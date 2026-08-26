
-- ############################################################
-- FUNCIONES
-- ############################################################
-- ------------------------------------------------------------
-- 1) fn_calcular_total_pedido
--    Suma el valor de las pizzas del pedido (detalle_pedido),
--    le agrega el costo de envío (si tiene domicilio) y el IVA.
-- ------------------------------------------------------------

DELIMITER //
CREATE FUNCTION fn_calcular_total_pedido(id_pedido INT)
RETURNS DOUBLE
DETERMINISTIC
READS SQL DATA
BEGIN

    DECLARE subtotal DOUBLE;
    DECLARE envio DOUBLE;
    DECLARE iva DOUBLE;
    DECLARE total DOUBLE;

    SELECT SUM(subtotal) INTO subtotal FROM detalle_pedido WHERE detalle_pedido.id_pedido = id_pedido;

    IF subtotal IS NULL THEN
        SET subtotal = 0;
    END IF;

    SELECT costo_envio INTO envio FROM domicilio WHERE domicilio.id_pedido = id_pedido LIMIT 1;

    IF envio IS NULL THEN
        SET envio = 0;
    END IF;

    SET iva = subtotal * 0.19;
    SET total = subtotal + iva + envio;
    RETURN total;
END //
DELIMITER ;

-- ------------------------------------------------------------
-- 2) fn_ganancia_neta_diaria
--    Ventas del día (pedidos entregados) menos el costo de los
--    ingredientes consumidos ese mismo día.
-- ------------------------------------------------------------

DELIMITER //
CREATE FUNCTION fn_ganancia_neta_diaria(fecha DATE)
RETURNS DOUBLE
DETERMINISTIC
READS SQL DATA
BEGIN

    DECLARE ventas DOUBLE;
    DECLARE costos DOUBLE;

    SELECT SUM(total) INTO ventas FROM pedido WHERE DATE(fecha_hora) = fecha AND estado = 'entregado';

    IF ventas IS NULL THEN
        SET ventas = 0;
    END IF;

    SELECT SUM(dp.cantidad * pi.cantidad_requerida * i.costo_unitario) INTO costos FROM detalle_pedido dp JOIN pedido p ON dp.id_pedido = p.id_pedido
    JOIN pizza_ingrediente pi ON dp.id_pizza = pi.id_pizza JOIN ingrediente i ON pi.id_ingrediente = i.id_ingrediente WHERE DATE(p.fecha_hora) = fecha AND p.estado = 'entregado';

    IF costos IS NULL THEN
        SET costos = 0;
    END IF;
    RETURN ventas - costos;
END //
DELIMITER ;


-- ############################################################
-- PROCEDIMIENTOS ALMACENADOS
-- ############################################################

-- ------------------------------------------------------------
-- 1) sp_registrar_entrega
--    Registra la hora de entrega de un domicilio y, con eso,
--    cambia automáticamente el estado del pedido a 'entregado'.
--    (La liberación del domiciliario la hace el trigger
--     trg_liberar_domiciliario al detectar el UPDATE en domicilio)
-- ------------------------------------------------------------

DELIMITER //
CREATE PROCEDURE sp_registrar_entrega(IN id_domicilio INT, IN hora_entrega DATETIME)
BEGIN

    DECLARE id_pedido INT;

    SELECT domicilio.id_pedido INTO id_pedido FROM domicilio WHERE domicilio.id_domicilio = id_domicilio;

    IF id_pedido IS NULL THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El domicilio no existe';
    ELSE
        UPDATE domicilio SET domicilio.hora_entrega = hora_entrega WHERE domicilio.id_domicilio = id_domicilio;
        UPDATE pedido SET estado = 'entregado' WHERE pedido.id_pedido = id_pedido;
    END IF;
END //
DELIMITER ;

-- ------------------------------------------------------------
-- 2) sp_actualizar_total_pedido
--    Utilidad que recalcula subtotal, IVA, envío y total de un
--    pedido usando fn_calcular_total_pedido, y deja la fila
--    consistente (útil tras insertar/editar detalle_pedido).
-- ------------------------------------------------------------

DELIMITER //
CREATE PROCEDURE sp_actualizar_total_pedido(IN id_pedido INT)
BEGIN

    DECLARE subtotal DOUBLE;
    DECLARE envio DOUBLE;

    SELECT SUM(detalle_pedido.subtotal)INTO subtotal FROM detalle_pedido WHERE detalle_pedido.id_pedido = id_pedido;

    IF subtotal IS NULL THEN
        SET subtotal = 0;
    END IF;

    SELECT costo_envio INTO envio FROM domicilio WHERE domicilio.id_pedido = id_pedido LIMIT 1;

    IF envio IS NULL THEN
        SET envio = 0;
    END IF;
    UPDATE pedido SET pedido.subtotal = subtotal, pedido.iva = subtotal * 0.19, pedido.costo_envio = envio, pedido.total = fn_calcular_total_pedido(id_pedido) 
    WHERE pedido.id_pedido = id_pedido;
END //
DELIMITER ;


-- ############################################################
-- TRIGGERS
-- ############################################################

-- ------------------------------------------------------------
-- 1) trg_stock_ingredientes
--    Al insertar una línea en detalle_pedido, descuenta del
--    stock de cada ingrediente la cantidad que exige la receta
--    de la pizza, multiplicada por la cantidad pedida.
-- ------------------------------------------------------------

DELIMITER //
CREATE TRIGGER trg_stock_ingredientes
AFTER INSERT ON detalle_pedido
FOR EACH ROW
BEGIN

    UPDATE ingrediente i JOIN pizza_ingrediente pi ON i.id_ingrediente = pi.id_ingrediente
    SET i.stock_actual = i.stock_actual - (pi.cantidad_requerida * NEW.cantidad) WHERE pi.id_pizza = NEW.id_pizza;
END //
DELIMITER ;

