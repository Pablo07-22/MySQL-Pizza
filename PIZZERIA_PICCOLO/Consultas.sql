-- ------------------------------------------------------------
-- 1) Clientes con pedidos entre dos fechas (BETWEEN)
--    Ejemplo: pedidos realizados en la primera quincena de agosto/2026
-- ------------------------------------------------------------

SELECT per.nombre AS cliente, pe.id_pedido, pe.fecha_hora, pe.total FROM pedido pe JOIN cliente c   ON pe.id_cliente = c.id_cliente
JOIN persona per ON c.id_persona  = per.id_persona WHERE pe.fecha_hora BETWEEN '2026-08-01 00:00:00' AND '2026-08-15 23:59:59' ORDER BY pe.fecha_hora;

-- ------------------------------------------------------------
-- 2) Pizzas más vendidas (GROUP BY y COUNT)
--    Suma las unidades vendidas de cada pizza en detalle_pedido
-- ------------------------------------------------------------

SELECT pz.nombre AS pizza, COUNT(dp.id_detalle) AS veces_pedida, SUM(dp.cantidad) AS unidades_vendidas FROM detalle_pedido dp JOIN pizza pz ON dp.id_pizza = pz.id_pizza
GROUP BY pz.id_pizza, pz.nombre ORDER BY unidades_vendidas DESC;

-- ------------------------------------------------------------
-- 3) Pedidos por repartidor (JOIN)
--    Cuántos domicilios ha atendido cada domiciliario
-- ------------------------------------------------------------

SELECT per.nombre AS domiciliario, dm.zona_asignada, COUNT(dom.id_domicilio) AS pedidos_atendidos FROM domiciliario dm
JOIN persona per ON dm.id_persona = per.id_persona JOIN domicilio dom ON dm.id_domiciliario = dom.id_domiciliario GROUP BY dm.id_domiciliario, per.nombre, dm.zona_asignada
ORDER BY pedidos_atendidos DESC;

-- ------------------------------------------------------------
-- 4) Promedio de entrega por zona (AVG y JOIN)
--    Tiempo promedio en minutos entre hora_salida y hora_entrega
-- ------------------------------------------------------------

SELECT dom.zona, ROUND(AVG(TIMESTAMPDIFF(MINUTE, dom.hora_salida, dom.hora_entrega)), 1) AS promedio_minutos, COUNT(dom.id_domicilio) AS entregas_completadas
FROM domicilio dom JOIN pedido pe ON dom.id_pedido = pe.id_pedido WHERE dom.hora_entrega IS NOT NULL GROUP BY dom.zona ORDER BY promedio_minutos;

-- ------------------------------------------------------------
-- 5) Clientes que gastaron más de un monto (HAVING)
--    Ejemplo: clientes con más de $150.000 acumulados en pedidos
-- ------------------------------------------------------------

SELECT per.nombre AS cliente, SUM(pe.total) AS total_gastado FROM pedido pe JOIN cliente c   ON pe.id_cliente = c.id_cliente
JOIN persona per ON c.id_persona  = per.id_persona GROUP BY c.id_cliente, per.nombre HAVING SUM(pe.total) > 150000 ORDER BY total_gastado DESC;

-- ------------------------------------------------------------
-- 6) Búsqueda por coincidencia parcial de nombre de pizza (LIKE)
--    Ejemplo: pizzas cuyo nombre contiene "Especial"
-- ------------------------------------------------------------

SELECT id_pizza, nombre, tamano, precio_base, tipo FROM pizza WHERE nombre LIKE '%Especial%';

-- ------------------------------------------------------------
-- 7) Subconsulta para obtener los clientes frecuentes
--    (más de 5 pedidos en un mismo mes)
-- ------------------------------------------------------------

SELECT per.nombre AS cliente_frecuente, frecuentes.mes, frecuentes.pedidos_en_el_mes FROM (SELECT pe.id_cliente, DATE_FORMAT(pe.fecha_hora, '%Y-%m') AS mes, COUNT(*) AS pedidos_en_el_mes
FROM pedido pe GROUP BY pe.id_cliente, DATE_FORMAT(pe.fecha_hora, '%Y-%m') HAVING COUNT(*) > 5) AS frecuentes JOIN cliente c  ON frecuentes.id_cliente = c.id_cliente
JOIN persona per ON c.id_persona = per.id_persona;

-- ------------------------------------------------------------
-- 8) LEFT JOIN
--    Todos los clientes, hayan hecho o no algún pedido
--    (útil para detectar clientes registrados que nunca han comprado)
-- ------------------------------------------------------------

SELECT per.nombre AS cliente, COUNT(pe.id_pedido) AS cantidad_pedidos, IFNULL(SUM(pe.total), 0)   AS total_gastado FROM persona per JOIN cliente c ON per.id_persona = c.id_persona
LEFT JOIN pedido pe ON c.id_cliente = pe.id_cliente GROUP BY per.id_persona, per.nombre ORDER BY cantidad_pedidos ASC;
