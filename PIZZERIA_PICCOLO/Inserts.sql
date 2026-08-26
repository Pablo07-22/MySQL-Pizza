-- ============================================================
-- BASE DE DATOS: pizzeria_don_piccolo
-- Script 2 de 3: INSERCIÓN DE DATOS DE PRUEBA
-- Mínimo 20 registros por tabla, respetando FKs.
-- ============================================================
USE pizzeria_don_piccolo;

-- ============================================================
-- 1. PERSONA  (40 filas: 1-20 serán CLIENTES, 21-40 DOMICILIARIOS)
-- ============================================================
INSERT INTO persona (nombre, telefono, direccion, correo) VALUES
('Juan Pérez',          '3001234501', 'Cra 45 #10-20, El Poblado',   'juan.perez@gmail.com'),
('María Gómez',         '3001234502', 'Cll 33 #65-12, Laureles',     'maria.gomez@gmail.com'),
('Carlos Rodríguez',    '3001234503', 'Cra 80 #45-30, Belén',        'carlos.rodriguez@gmail.com'),
('Ana Martínez',        '3001234504', 'Cll 10 #43-55, Envigado',     'ana.martinez@gmail.com'),
('Luis Hernández',      '3001234505', 'Cra 70 #33-10, Robledo',      'luis.hernandez@gmail.com'),
('Laura López',         '3001234506', 'Cll 50 #20-15, Sabaneta',     'laura.lopez@gmail.com'),
('Andrés Díaz',         '3001234507', 'Cra 65 #48-22, Buenos Aires', 'andres.diaz@gmail.com'),
('Camila Torres',       '3001234508', 'Cll 44 #70-19, Manrique',     'camila.torres@gmail.com'),
('Felipe Ramírez',      '3001234509', 'Cra 52 #38-40, Aranjuez',     'felipe.ramirez@gmail.com'),
('Valentina Castro',    '3001234510', 'Cll 60 #25-11, Castilla',     'valentina.castro@gmail.com'),
('Santiago Morales',    '3001234511', 'Cra 76 #34-28, La América',   'santiago.morales@gmail.com'),
('Isabella Ortiz',      '3001234512', 'Cll 39 #72-05, Guayabal',     'isabella.ortiz@gmail.com'),
('Miguel Vargas',       '3001234513', 'Cra 43 #16-33, Centro',       'miguel.vargas@gmail.com'),
('Daniela Rojas',       '3001234514', 'Cll 30 #55-18, Villa Hermosa','daniela.rojas@gmail.com'),
('Sebastián Jiménez',   '3001234515', 'Cra 68 #40-22, Bello',        'sebastian.jimenez@gmail.com'),
('Mariana Restrepo',    '3001234516', 'Cll 47 #62-14, Calasanz',     'mariana.restrepo@gmail.com'),
('Nicolás Zapata',      '3001234517', 'Cra 55 #29-31, San Javier',   'nicolas.zapata@gmail.com'),
('Gabriela Muñoz',      '3001234518', 'Cll 42 #58-27, Floresta',     'gabriela.munoz@gmail.com'),
('David Cárdenas',      '3001234519', 'Cra 48 #12-09, Itagüí',       'david.cardenas@gmail.com'),
('Paula Arango',        '3001234520', 'Cll 15 #48-36, Las Palmas',   'paula.arango@gmail.com'),
-- Personas 21-40: futuros domiciliarios
('Jorge Salazar',       '3009876501', 'Cra 45 #22-10, El Poblado',   'jorge.salazar@gmail.com'),
('Diego Correa',        '3009876502', 'Cll 33 #40-12, Laureles',     'diego.correa@gmail.com'),
('Esteban Villa',       '3009876503', 'Cra 80 #12-30, Belén',        'esteban.villa@gmail.com'),
('Julián Betancur',     '3009876504', 'Cll 10 #20-55, Envigado',     'julian.betancur@gmail.com'),
('Óscar Mejía',         '3009876505', 'Cra 70 #10-10, Robledo',      'oscar.mejia@gmail.com'),
('Ricardo Ospina',      '3009876506', 'Cll 50 #33-15, Sabaneta',     'ricardo.ospina@gmail.com'),
('Manuel Giraldo',      '3009876507', 'Cra 65 #18-22, Buenos Aires', 'manuel.giraldo@gmail.com'),
('Fernando Quintero',   '3009876508', 'Cll 44 #29-19, Manrique',     'fernando.quintero@gmail.com'),
('Álvaro Escobar',      '3009876509', 'Cra 52 #14-40, Aranjuez',     'alvaro.escobar@gmail.com'),
('Iván Londoño',        '3009876510', 'Cll 60 #11-11, Castilla',     'ivan.londono@gmail.com'),
('Cristian Palacio',    '3009876511', 'Cra 76 #16-28, La América',   'cristian.palacio@gmail.com'),
('Wilson Marín',        '3009876512', 'Cll 39 #20-05, Guayabal',     'wilson.marin@gmail.com'),
('Édgar Duque',         '3009876513', 'Cra 43 #33-33, Centro',       'edgar.duque@gmail.com'),
('Gustavo Cano',        '3009876514', 'Cll 30 #18-18, Villa Hermosa','gustavo.cano@gmail.com'),
('Rodrigo Aguirre',     '3009876515', 'Cra 68 #22-22, Bello',        'rodrigo.aguirre@gmail.com'),
('Sergio Montoya',      '3009876516', 'Cll 47 #10-14, Calasanz',     'sergio.montoya@gmail.com'),
('Camilo Serna',        '3009876517', 'Cra 55 #29-09, San Javier',   'camilo.serna@gmail.com'),
('Héctor Uribe',        '3009876518', 'Cll 42 #15-27, Floresta',     'hector.uribe@gmail.com'),
('Leonardo Vélez',      '3009876519', 'Cra 48 #40-09, Itagüí',       'leonardo.velez@gmail.com'),
('Mauricio Naranjo',    '3009876520', 'Cll 15 #33-36, Las Palmas',   'mauricio.naranjo@gmail.com');

-- ============================================================
-- 2. CLIENTE  (20 filas, id_persona 1-20)
-- ============================================================
INSERT INTO cliente (id_persona, fecha_nacimiento) VALUES
(1,  '1990-05-14'), (2,  '1988-11-02'), (3,  '1995-03-22'), (4,  '1992-07-18'),
(5,  '1998-01-09'), (6,  '1985-09-30'), (7,  '1993-12-05'), (8,  '1991-04-27'),
(9,  '1997-06-11'), (10, '1989-08-19'), (11, '1994-02-25'), (12, '1996-10-03'),
(13, '1987-03-15'), (14, '1999-05-28'), (15, '1990-12-20'), (16, '1993-07-07'),
(17, '1986-11-16'), (18, '1995-09-09'), (19, '1992-01-30'), (20, '1998-04-13');

-- ============================================================
-- 3. DOMICILIARIO  (20 filas, id_persona 21-40)
-- ============================================================
INSERT INTO domiciliario (id_persona, zona_asignada, estado) VALUES
(21, 'El Poblado',   'disponible'),
(22, 'Laureles',     'disponible'),
(23, 'Belén',        'no disponible'),
(24, 'Envigado',     'disponible'),
(25, 'Robledo',      'disponible'),
(26, 'Sabaneta',     'no disponible'),
(27, 'Buenos Aires', 'disponible'),
(28, 'Manrique',     'disponible'),
(29, 'Aranjuez',     'disponible'),
(30, 'Castilla',     'no disponible'),
(31, 'La América',   'disponible'),
(32, 'Guayabal',     'disponible'),
(33, 'Centro',       'disponible'),
(34, 'Villa Hermosa','no disponible'),
(35, 'Bello',        'disponible'),
(36, 'Calasanz',     'disponible'),
(37, 'San Javier',   'disponible'),
(38, 'Floresta',     'no disponible'),
(39, 'Itagüí',       'disponible'),
(40, 'Las Palmas',   'disponible');

-- ============================================================
-- 4. PIZZA  (20 filas)
-- ============================================================
INSERT INTO pizza (nombre, tamano, precio_base, tipo, activo) VALUES
('Margarita',              'mediana',  22000, 'clasica',      TRUE),
('Napolitana',              'mediana',  25000, 'clasica',      TRUE),
('Hawaiana',                'mediana',  24000, 'clasica',      TRUE),
('Pepperoni',               'grande',   28000, 'clasica',      TRUE),
('Cuatro Quesos',           'grande',   32000, 'especial',     TRUE),
('Vegetariana Especial',    'mediana',  30000, 'vegetariana',  TRUE),
('BBQ Pollo',               'grande',   34000, 'especial',     TRUE),
('Carnívora',               'familiar', 38000, 'especial',     TRUE),
('Champiñones',             'mediana',  27000, 'vegetariana',  TRUE),
('Especial de la Casa',     'familiar', 42000, 'especial',     TRUE),
('Prosciutto',              'grande',   36000, 'especial',     TRUE),
('Diavola',                 'grande',   33000, 'especial',     TRUE),
('Capricciosa',             'grande',   35000, 'especial',     TRUE),
('Mexicana',                'grande',   31000, 'especial',     TRUE),
('Mediterránea',            'mediana',  29000, 'vegetariana',  TRUE),
('Vegetal Deluxe',          'mediana',  26000, 'vegetariana',  TRUE),
('Pollo Ranch',             'grande',   33000, 'especial',     TRUE),
('Piccolo Especial',        'familiar', 45000, 'especial',     TRUE),
('Tres Quesos y Rúcula',    'grande',   37000, 'especial',     TRUE),
('Costilla BBQ',            'familiar', 44000, 'especial',     TRUE);

-- ============================================================
-- 5. INGREDIENTE  (20 filas)
-- ============================================================
INSERT INTO ingrediente (nombre, unidad_medida, stock_actual, stock_minimo, costo_unitario) VALUES
('Queso mozzarella',   'g',      2500, 3000, 18),
('Salsa de tomate',    'ml',     12000, 2500, 8),
('Masa de pizza',      'unidad', 300,   50,   1200),
('Pepperoni',          'g',      8000,  2000, 25),
('Jamón',              'g',      1000,  1500, 20),
('Piña',               'g',      5000,  1000, 10),
('Champiñones',        'g',      6000,  1200, 15),
('Cebolla',            'g',      4000,  800,  6),
('Pimentón',           'g',      4000,  800,  7),
('Aceitunas',          'g',      3000,  600,  22),
('Tocineta',           'g',      6000,  1200, 28),
('Pollo desmechado',   'g',      9000,  2000, 24),
('Carne molida',       'g',      1700,  2000, 26),
('Chorizo',            'g',      5000,  1000, 23),
('Rúcula',             'g',      2500,  500,  30),
('Queso parmesano',    'g',      4000,  800,  35),
('Queso ricotta',      'g',      3500,  700,  27),
('Albahaca',           'g',      1500,  300,  40),
('Orégano',            'g',      2000,  400,  12),
('Maíz tierno',        'g',      3000,  600,  9);

-- ============================================================
-- 6. PIZZA_INGREDIENTE (25 filas, receta por pizza)
-- ============================================================
INSERT INTO pizza_ingrediente (id_pizza, id_ingrediente, cantidad_requerida) VALUES
(1,  1, 150), (1,  2, 100),
(2,  1, 150), (2,  2, 100), (2, 5, 80),
(3,  1, 150), (3,  6, 90),
(4,  1, 150), (4,  4, 100),
(5,  1, 250), (5, 16, 60), (5, 17, 60),
(6,  7, 100), (6,  8, 60), (6, 9, 60),
(7, 12, 120), (7,  1, 150),
(8, 13, 150), (8, 11, 100), (8, 4, 80),
(9,  7, 150), (9,  1, 150),
(10, 4, 80), (10, 11, 80), (10, 5, 80),
(11, 5, 130), (11, 18, 20);

-- ============================================================
-- 7. PEDIDO  (20 filas)
--    Cliente 1 tiene 6 pedidos en agosto/2026 -> cliente frecuente
-- ============================================================
INSERT INTO pedido (id_cliente, fecha_hora, metodo_pago, estado, subtotal, iva, costo_envio, total) VALUES
(1,  '2026-08-02 12:30:00', 'efectivo', 'entregado',      22000, 4180,  4000, 30180),
(1,  '2026-08-05 19:15:00', 'tarjeta',  'entregado',      50000, 9500,  5000, 64500),
(1,  '2026-08-10 13:00:00', 'app',      'entregado',      24000, 4560,  6000, 34560),
(1,  '2026-08-15 20:45:00', 'efectivo', 'entregado',      84000, 15960, 4500, 104460),
(1,  '2026-08-18 12:10:00', 'tarjeta',  'entregado',      64000, 12160, 5500, 81660),
(1,  '2026-08-22 21:00:00', 'app',      'entregado',      30000, 5700,  6500, 42200),
(2,  '2026-07-03 12:40:00', 'efectivo', 'entregado',      68000, 12920, 4000, 84920),
(2,  '2026-07-08 19:20:00', 'tarjeta',  'entregado',      38000, 7220,  5000, 50220),
(3,  '2026-07-12 13:10:00', 'app',      'entregado',      81000, 15390, 6000, 102390),
(4,  '2026-07-15 20:00:00', 'efectivo', 'entregado',      84000, 15960, 4500, 104460),
(5,  '2026-07-20 12:50:00', 'tarjeta',  'entregado',      36000, 6840,  5500, 48340),
(6,  '2026-07-25 19:30:00', 'app',      'entregado',      66000, 12540, 6500, 85040),
(7,  '2026-08-01 13:20:00', 'efectivo', 'entregado',      35000, 6650,  4000, 45650),
(8,  '2026-08-06 20:10:00', 'tarjeta',  'entregado',      62000, 11780, 5000, 78780),
(9,  '2026-08-09 12:00:00', 'app',      'entregado',      29000, 5510,  6000, 40510),
(10, '2026-08-13 19:45:00', 'efectivo', 'entregado',      48000, 9120,  4500, 61620),
(11, '2026-08-17 13:15:00', 'tarjeta',  'en preparacion', 90000, 17100, 5500, 112600),
(12, '2026-08-19 20:30:00', 'app',      'pendiente',      77000, 14630, 6500, 98130),
(13, '2026-08-21 12:25:00', 'efectivo', 'cancelado',      91000, 17290, 4000, 112290),
(14, '2026-08-23 19:50:00', 'tarjeta',  'entregado',      86000, 16340, 5000, 107340);

-- ============================================================
-- 8. DETALLE_PEDIDO  (25 filas; subtotal es columna generada)
-- ============================================================
INSERT INTO detalle_pedido (id_pedido, id_pizza, cantidad, precio_unitario) VALUES
(1,  1, 1, 22000),
(2,  2, 2, 25000),
(3,  3, 1, 24000),
(4,  4, 3, 28000),
(5,  5, 2, 32000),
(6,  6, 1, 30000),
(7,  7, 2, 34000),
(8,  8, 1, 38000),
(9,  9, 3, 27000),
(10, 10, 2, 42000),
(11, 11, 1, 36000),
(12, 12, 2, 33000),
(13, 13, 1, 35000),
(14, 14, 2, 31000),
(15, 15, 1, 29000),
(16, 16, 1, 26000),
(16, 1,  1, 22000),
(17, 17, 2, 33000),
(17, 3,  1, 24000),
(18, 18, 1, 45000),
(18, 5,  1, 32000),
(19, 19, 1, 37000),
(19, 9,  2, 27000),
(20, 20, 1, 44000),
(20, 10, 1, 42000);

-- ============================================================
-- 9. DOMICILIO  (20 filas, 1:1 con pedido)
-- ============================================================
INSERT INTO domicilio (id_pedido, id_domiciliario, hora_salida, hora_entrega, distancia_km, costo_envio, zona) VALUES
(1,  1,  '2026-08-02 12:35:00', '2026-08-02 13:00:00', 3.2, 4000, 'El Poblado'),
(2,  2,  '2026-08-05 19:20:00', '2026-08-05 19:55:00', 4.5, 5000, 'Laureles'),
(3,  3,  '2026-08-10 13:05:00', '2026-08-10 13:30:00', 5.1, 6000, 'Belén'),
(4,  4,  '2026-08-15 20:50:00', '2026-08-15 21:20:00', 3.8, 4500, 'Envigado'),
(5,  5,  '2026-08-18 12:15:00', '2026-08-18 12:50:00', 4.9, 5500, 'Robledo'),
(6,  6,  '2026-08-22 21:05:00', '2026-08-22 21:40:00', 5.6, 6500, 'Sabaneta'),
(7,  7,  '2026-07-03 12:45:00', '2026-07-03 13:10:00', 3.0, 4000, 'Buenos Aires'),
(8,  8,  '2026-07-08 19:25:00', '2026-07-08 19:55:00', 4.2, 5000, 'Manrique'),
(9,  9,  '2026-07-12 13:15:00', '2026-07-12 13:45:00', 5.3, 6000, 'Aranjuez'),
(10, 10, '2026-07-15 20:05:00', '2026-07-15 20:35:00', 3.7, 4500, 'Castilla'),
(11, 11, '2026-07-20 12:55:00', '2026-07-20 13:25:00', 4.8, 5500, 'La América'),
(12, 12, '2026-07-25 19:35:00', '2026-07-25 20:05:00', 5.5, 6500, 'Guayabal'),
(13, 13, '2026-08-01 13:25:00', '2026-08-01 13:50:00', 3.1, 4000, 'Centro'),
(14, 14, '2026-08-06 20:15:00', '2026-08-06 20:45:00', 4.4, 5000, 'Villa Hermosa'),
(15, 15, '2026-08-09 12:05:00', '2026-08-09 12:35:00', 5.2, 6000, 'Bello'),
(16, 16, '2026-08-13 19:50:00', '2026-08-13 20:20:00', 3.6, 4500, 'Calasanz'),
(17, 17, '2026-08-17 13:20:00', NULL,                  4.7, 5500, 'San Javier'),
(18, 18, NULL,                  NULL,                  5.4, 6500, 'Floresta'),
(19, 19, NULL,                  NULL,                  3.3, 4000, 'Itagüí'),
(20, 20, '2026-08-23 19:55:00', '2026-08-23 20:25:00', 4.6, 5000, 'Las Palmas');

-- ============================================================
-- 10. PAGO  (20 filas, 1:1 con pedido)
-- ============================================================
INSERT INTO pago (id_pedido, monto, metodo_pago, fecha_pago, estado_pago) VALUES
(1,  30180,  'efectivo', '2026-08-02 13:00:00', 'pagado'),
(2,  64500,  'tarjeta',  '2026-08-05 19:15:00', 'pagado'),
(3,  34560,  'app',      '2026-08-10 13:00:00', 'pagado'),
(4,  104460, 'efectivo', '2026-08-15 20:45:00', 'pagado'),
(5,  81660,  'tarjeta',  '2026-08-18 12:10:00', 'pagado'),
(6,  42200,  'app',      '2026-08-22 21:00:00', 'pagado'),
(7,  84920,  'efectivo', '2026-07-03 12:40:00', 'pagado'),
(8,  50220,  'tarjeta',  '2026-07-08 19:20:00', 'pagado'),
(9,  102390, 'app',      '2026-07-12 13:10:00', 'pagado'),
(10, 104460, 'efectivo', '2026-07-15 20:00:00', 'pagado'),
(11, 48340,  'tarjeta',  '2026-07-20 12:50:00', 'pagado'),
(12, 85040,  'app',      '2026-07-25 19:30:00', 'pagado'),
(13, 45650,  'efectivo', '2026-08-01 13:20:00', 'pagado'),
(14, 78780,  'tarjeta',  '2026-08-06 20:10:00', 'pagado'),
(15, 40510,  'app',      '2026-08-09 12:00:00', 'pagado'),
(16, 61620,  'efectivo', '2026-08-13 19:45:00', 'pagado'),
(17, 112600, 'tarjeta',  '2026-08-17 13:15:00', 'pendiente'),
(18, 98130,  'app',      '2026-08-19 20:30:00', 'pendiente'),
(19, 112290, 'efectivo', '2026-08-21 12:25:00', 'rechazado'),
(20, 107340, 'tarjeta',  '2026-08-23 19:50:00', 'pagado');

-- ============================================================
-- 11. HISTORIAL_PRECIOS  (20 filas)
-- ============================================================
INSERT INTO historial_precios (id_pizza, precio_anterior, precio_nuevo, fecha_cambio, usuario_modifico) VALUES
(1,  20000, 22000, '2026-06-01 09:00:00', 'admin'),
(2,  23000, 25000, '2026-06-02 09:10:00', 'admin'),
(3,  22000, 24000, '2026-06-03 09:20:00', 'admin'),
(4,  26000, 28000, '2026-06-04 09:30:00', 'admin'),
(5,  30000, 32000, '2026-06-05 09:40:00', 'admin'),
(6,  28000, 30000, '2026-06-06 09:50:00', 'admin'),
(7,  32000, 34000, '2026-06-07 10:00:00', 'admin'),
(8,  36000, 38000, '2026-06-08 10:10:00', 'admin'),
(9,  25000, 27000, '2026-06-09 10:20:00', 'admin'),
(10, 40000, 42000, '2026-06-10 10:30:00', 'admin'),
(11, 34000, 36000, '2026-06-11 10:40:00', 'admin'),
(12, 31000, 33000, '2026-06-12 10:50:00', 'admin'),
(13, 33000, 35000, '2026-06-13 11:00:00', 'admin'),
(14, 29000, 31000, '2026-06-14 11:10:00', 'admin'),
(15, 27000, 29000, '2026-06-15 11:20:00', 'admin'),
(16, 24000, 26000, '2026-06-16 11:30:00', 'admin'),
(17, 31000, 33000, '2026-06-17 11:40:00', 'admin'),
(18, 43000, 45000, '2026-06-18 11:50:00', 'admin'),
(19, 35000, 37000, '2026-06-19 12:00:00', 'admin'),
(20, 42000, 44000, '2026-06-20 12:10:00', 'admin');