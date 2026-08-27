-- ============================================================
-- BASE DE DATOS: pizzeria_don_piccolo
-- Sistema de Gestión de Pedidos y Domicilios
-- ============================================================
 
CREATE DATABASE pizzeria_don_piccolo;
USE pizzeria_don_piccolo;
 
-- ============================================================
-- 1. SUPERCLASE: PERSONA
-- Contiene los atributos comunes a cualquier persona del sistema.
-- CLIENTE y DOMICILIARIO se "especializan" a partir de esta tabla
-- mediante una relación 1:1 (id_persona como FK y UNIQUE).
-- ============================================================
CREATE TABLE persona (
    id_persona      INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    telefono        VARCHAR(20)  NOT NULL,
    direccion       VARCHAR(200),
    correo          VARCHAR(100) UNIQUE,
    fecha_registro  DATETIME DEFAULT CURRENT_TIMESTAMP
);
 
-- ============================================================
-- 2. SUBCLASE: CLIENTE (hereda de persona)
-- Relación 1:1 -> un cliente ES una persona.
-- ============================================================
CREATE TABLE cliente (
    id_cliente       INT AUTO_INCREMENT PRIMARY KEY,
    id_persona       INT NOT NULL UNIQUE,
    fecha_nacimiento DATE,
    CONSTRAINT fk_cliente_persona
        FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
        ON DELETE CASCADE
);
 
-- ============================================================
-- 3. SUBCLASE: DOMICILIARIO (hereda de persona)
-- Relación 1:1 -> un domiciliario ES una persona.
-- Reemplaza/equivale al "repartidor" solicitado en el enunciado.
-- ============================================================
CREATE TABLE domiciliario (
    id_domiciliario  INT AUTO_INCREMENT PRIMARY KEY,
    id_persona       INT NOT NULL UNIQUE,
    zona_asignada    VARCHAR(50) NOT NULL,
    estado           ENUM('disponible','no disponible') DEFAULT 'disponible',
    CONSTRAINT fk_domiciliario_persona
        FOREIGN KEY (id_persona) REFERENCES persona(id_persona)
        ON DELETE CASCADE
);
 
-- ============================================================
-- 4. PIZZA
-- ============================================================
CREATE TABLE pizza (
    id_pizza     INT AUTO_INCREMENT PRIMARY KEY,
    nombre       VARCHAR(100) NOT NULL,
    tamano       ENUM('pequena','mediana','grande','familiar') NOT NULL,
    precio_base  DECIMAL(10,2) NOT NULL,
    tipo         ENUM('vegetariana','especial','clasica') NOT NULL,
    activo       BOOLEAN DEFAULT TRUE
);
 
-- ============================================================
-- 5. INGREDIENTE
-- ============================================================
CREATE TABLE ingrediente (
    id_ingrediente  INT AUTO_INCREMENT PRIMARY KEY,
    nombre          VARCHAR(100) NOT NULL,
    unidad_medida   VARCHAR(20) NOT NULL,        -- g, ml, unidad, etc.
    stock_actual    DECIMAL(10,2) NOT NULL DEFAULT 0,
    stock_minimo    DECIMAL(10,2) NOT NULL DEFAULT 0,
    costo_unitario  DECIMAL(10,2) NOT NULL
);
 
-- ============================================================
-- 6. PIZZA_INGREDIENTE (tabla puente N:M)
-- Relaciona qué ingredientes y en qué cantidad lleva cada pizza.
-- ============================================================
CREATE TABLE pizza_ingrediente (
    id_pizza            INT NOT NULL,
    id_ingrediente      INT NOT NULL,
    cantidad_requerida  DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_pizza, id_ingrediente),
    CONSTRAINT fk_pi_pizza
        FOREIGN KEY (id_pizza) REFERENCES pizza(id_pizza)
        ON DELETE CASCADE,
    CONSTRAINT fk_pi_ingrediente
        FOREIGN KEY (id_ingrediente) REFERENCES ingrediente(id_ingrediente)
        ON DELETE CASCADE
);
 
-- ============================================================
-- 7. PEDIDO
-- Cabecera del pedido: cliente, fecha, pago, estado y totales.
-- ============================================================
CREATE TABLE pedido (
    id_pedido    INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente   INT NOT NULL,
    fecha_hora   DATETIME DEFAULT CURRENT_TIMESTAMP,
    metodo_pago  ENUM('efectivo','tarjeta','app') NOT NULL,
    estado       ENUM('pendiente','en preparacion','entregado','cancelado')
                 DEFAULT 'pendiente',
    subtotal     DECIMAL(10,2) DEFAULT 0,
    iva          DECIMAL(10,2) DEFAULT 0,
    costo_envio  DECIMAL(10,2) DEFAULT 0,
    total        DECIMAL(10,2) DEFAULT 0,   -- se calcula con función/trigger
    CONSTRAINT fk_pedido_cliente
        FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);
 
-- ============================================================
-- 8. DETALLE_PEDIDO (tabla puente N:M entre pedido y pizza)
-- Permite que un pedido tenga una o varias pizzas.
-- ============================================================
CREATE TABLE detalle_pedido (
    id_detalle       INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido        INT NOT NULL,
    id_pizza         INT NOT NULL,
    cantidad         INT NOT NULL DEFAULT 1,
    precio_unitario  DECIMAL(10,2) NOT NULL,
    subtotal         DECIMAL(10,2) GENERATED ALWAYS AS (cantidad * precio_unitario) STORED,
    CONSTRAINT fk_detalle_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON DELETE CASCADE,
    CONSTRAINT fk_detalle_pizza
        FOREIGN KEY (id_pizza) REFERENCES pizza(id_pizza)
);
 
-- ============================================================
-- 9. DOMICILIO
-- Un pedido puede o no tener domicilio (1:1 opcional con pedido).
-- Un domiciliario puede atender muchos domicilios (1:N).
-- ============================================================
CREATE TABLE domicilio (
    id_domicilio     INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido        INT NOT NULL UNIQUE,
    id_domiciliario  INT NOT NULL,
    hora_salida      DATETIME,
    hora_entrega     DATETIME,
    distancia_km     DECIMAL(6,2),
    costo_envio      DECIMAL(10,2),
    zona             VARCHAR(50),
    CONSTRAINT fk_domicilio_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON DELETE CASCADE,
    CONSTRAINT fk_domicilio_domiciliario
        FOREIGN KEY (id_domiciliario) REFERENCES domiciliario(id_domiciliario)
);
 
-- ============================================================
-- 10. PAGO
-- Relación 1:1 con pedido (un pedido tiene un registro de pago).
-- ============================================================
CREATE TABLE pago (
    id_pago       INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido     INT NOT NULL UNIQUE,
    monto         DECIMAL(10,2) NOT NULL,
    metodo_pago   ENUM('efectivo','tarjeta','app') NOT NULL,
    fecha_pago    DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_pago   ENUM('pendiente','pagado','rechazado') DEFAULT 'pendiente',
    CONSTRAINT fk_pago_pedido
        FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido)
        ON DELETE CASCADE
);
 
-- ============================================================
-- 11. HISTORIAL_PRECIOS (tabla de auditoría)
-- Se llena mediante un trigger cuando cambia el precio de una pizza.
-- ============================================================
CREATE TABLE historial_precios (
    id_historial INT AUTO_INCREMENT PRIMARY KEY,
    id_pizza INT NOT NULL,
    precio_anterior DECIMAL(10,2) NOT NULL,
    precio_nuevo DECIMAL(10,2) NOT NULL,
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario_modifico VARCHAR(100) DEFAULT (CURRENT_USER()),

    CONSTRAINT fk_historial_pizza
        FOREIGN KEY (id_pizza)
        REFERENCES pizza(id_pizza)
);