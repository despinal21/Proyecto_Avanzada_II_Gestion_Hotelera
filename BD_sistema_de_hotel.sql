CREATE DATABASE IF NOT EXISTS BaseDatosHotel;
USE BaseDatosHotel;

CREATE TABLE huespedes (
    id_huesped VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    direccion TEXT
);

CREATE TABLE habitaciones (
    id_habitacion INT PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    capacidad INT NOT NULL,
    estado VARCHAR(20) NOT NULL
);

CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_huesped VARCHAR(20) NOT NULL,
    id_habitacion INT NOT NULL,
    fecha_entrada DATE NOT NULL,
    fecha_salida DATE NOT NULL,
    estado VARCHAR(20) NOT NULL,
    FOREIGN KEY (id_huesped) REFERENCES huespedes(id_huesped),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion)
);

CREATE TABLE pagos (
    id_pago INT AUTO_INCREMENT PRIMARY KEY,
    id_reserva INT NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    monto DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva)
);

CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cargo VARCHAR(50) NOT NULL,
    fecha_contratacion DATE NOT NULL
);

CREATE TABLE servicios (
    id_servicio INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT,
    precio DECIMAL(10,2) NOT NULL
);

CREATE TABLE reservas_servicios (
    id_reserva INT NOT NULL,
    id_servicio INT NOT NULL,
    PRIMARY KEY (id_reserva, id_servicio),
    FOREIGN KEY (id_reserva) REFERENCES reservas(id_reserva),
    FOREIGN KEY (id_servicio) REFERENCES servicios(id_servicio)
);

CREATE TABLE roles_empleados (
    id_rol INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT
);

/*Justificacion de los INDEX*/
/*Se podria hacer un index por cada tabla pero como nos comento Ing. en clase por temas de rendimiento es mejor no colocarlos todos.*/

/*optimiza la busqueda de reservas de un huesped*/
CREATE INDEX idx_reservas_huesped ON reservas(id_huesped);

/*agiliza la consulta de historial de una habitacion*/
CREATE INDEX idx_reservas_habitacion ON reservas(id_habitacion);

/*optimiza la busqueda de pagos asociados a reservas*/
CREATE INDEX idx_pagos_reserva ON pagos(id_reserva);

/*mejora la busqueda de empleados por su cargo*/
CREATE INDEX idx_empleados_cargo ON empleados(cargo);


INSERT INTO huespedes (id_huesped, nombre, apellido, correo_electronico, telefono, direccion) VALUES
('0801199603432', 'Carlos', 'Ramírez', 'carlosr@gmail.com', '5551234567', 'Av. Central 123'),
('0801199405321', 'Laura', 'Pérez', 'laurap@hotmail.com', '5557654321', 'Calle Falsa 456'),
('0802199001234', 'Pedro', 'López', 'pedrol@yahoo.com', '5552223333', 'Av. Reforma 789'),
('0803199805678', 'María', 'González', 'mariag@gmail.com', '5559998888', 'Calle Luna 10'),
('0804199504567', 'Ana', 'Martínez', 'anam@gmail.com', '5551112233', 'Boulevard del Sol 202'),
('0805199206789', 'Luis', 'Fernández', 'luisf@outlook.com', '5554445566', 'Calle Norte 45'),
('0806199702345', 'Jorge', 'Sánchez', 'jorges@hotmail.com', '5553332211', 'Col. Sur 55'),
('0807199809876', 'Lucía', 'Hernández', 'luciah@gmail.com', '5558887777', 'Av. Las Palmas 99'),
('0808199501234', 'Raúl', 'Jiménez', 'raulj@yahoo.com', '5556667788', 'Calle 3ra 345'),
('0809199304321', 'Paola', 'Díaz', 'paolad@gmail.com', '5551110099', 'Zona Rosa 12');

INSERT INTO habitaciones (id_habitacion, tipo, precio, capacidad, estado) VALUES
(101, 'Individual', 500.00, 1, 'Disponible'),
(102, 'Doble', 800.00, 2, 'Disponible'),
(103, 'Suite', 1500.00, 4, 'Ocupada'),
(201, 'Individual', 450.00, 1, 'Mantenimiento'),
(202, 'Doble', 750.00, 2, 'Disponible'),
(203, 'Suite', 1800.00, 3, 'Disponible'),
(301, 'Individual', 520.00, 1, 'Disponible'),
(302, 'Doble', 810.00, 2, 'Disponible'),
(303, 'Suite', 1750.00, 4, 'Disponible'),
(401, 'Individual', 490.00, 1, 'Disponible');

INSERT INTO reservas (id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado) VALUES
('0801199603432', 101, '2025-06-10', '2025-06-12', 'Confirmada'),
('0801199405321', 102, '2025-06-08', '2025-06-15', 'Activa'),
('0802199001234', 103, '2025-06-05', '2025-06-07', 'Cancelada'),
('0803199805678', 201, '2025-06-12', '2025-06-14', 'Confirmada'),
('0804199504567', 202, '2025-06-09', '2025-06-11', 'Activa'),
('0805199206789', 203, '2025-06-20', '2025-06-22', 'Confirmada'),
('0806199702345', 301, '2025-06-15', '2025-06-17', 'Activa'),
('0807199809876', 302, '2025-06-25', '2025-06-30', 'Confirmada'),
('0808199501234', 303, '2025-06-10', '2025-06-12', 'Activa'),
('0809199304321', 401, '2025-06-18', '2025-06-22', 'Cancelada');

INSERT INTO pagos (id_reserva, metodo_pago, monto) VALUES
(1, 'Tarjeta', 1000.00),
(2, 'Efectivo', 1600.00),
(3, 'Transferencia', 1500.00),
(4, 'Tarjeta', 900.00),
(5, 'Efectivo', 800.00),
(6, 'Tarjeta', 2000.00),
(7, 'Transferencia', 950.00),
(8, 'Tarjeta', 1800.00),
(9, 'Efectivo', 2100.00),
(10, 'Transferencia', 1200.00);

INSERT INTO empleados (nombre, apellido, cargo, fecha_contratacion) VALUES
('Sofía', 'Luna', 'Recepcionista', '2022-01-10'),
('Ricardo', 'Mejía', 'Gerente', '2020-06-15'),
('Clara', 'Morales', 'Camarera', '2023-03-22'),
('José', 'Torres', 'Conserje', '2021-12-01'),
('Diana', 'Ríos', 'Recepcionista', '2022-09-17'),
('Mario', 'Quintero', 'Administrador', '2020-04-04'),
('Elena', 'Suárez', 'Chef', '2019-08-25'),
('Tomás', 'Delgado', 'Seguridad', '2023-01-01'),
('Patricia', 'Vega', 'Camarera', '2024-02-14'),
('Gustavo', 'Navarro', 'Conserje', '2021-07-30');

INSERT INTO servicios (nombre, descripcion, precio) VALUES
('Spa', 'Masajes y tratamientos relajantes', 500.00),
('Lavandería', 'Lavado y planchado de ropa', 100.00),
('Desayuno Buffet', 'Desayuno libre incluido', 150.00),
('Gimnasio', 'Acceso al gimnasio 24h', 200.00),
('Wi-Fi Premium', 'Internet de alta velocidad', 50.00),
('Transporte', 'Traslados aeropuerto-hotel', 300.00),
('Mini Bar', 'Bebidas y snacks en la habitación', 120.00),
('Room Service', 'Servicio a la habitación 24h', 250.00),
('Estacionamiento', 'Estacionamiento privado', 80.00),
('Tour Turístico', 'Recorridos guiados por la ciudad', 600.00);

INSERT INTO reservas_servicios (id_reserva, id_servicio) VALUES
(1, 2),
(2, 4),
(3, 1),
(4, 5),
(5, 3),
(6, 6),
(7, 7),
(8, 8),
(9, 9),
(10, 10);

INSERT INTO roles_empleados (nombre, descripcion) VALUES
('Recepcionista', 'Atención al cliente y gestión de reservas'),
('Gerente', 'Supervisión general del hotel'),
('Camarera', 'Limpieza y mantenimiento de habitaciones'),
('Conserje', 'Asistencia y apoyo a los huéspedes'),
('Administrador', 'Gestión financiera y operativa'),
('Chef', 'Preparación de alimentos y menús'),
('Seguridad', 'Vigilancia y protección del hotel'),
('Asistente de eventos', 'Organización de eventos y reuniones'),
('Técnico de mantenimiento', 'Reparaciones y soporte técnico'),
('Community Manager', 'Gestión de redes sociales y marketing digital');

/*1. reservas con informacion del huesped y habitacion*/
SELECT r.id_reserva, h.nombre, h.apellido, hab.tipo, r.fecha_entrada, r.fecha_salida, r.estado
FROM reservas r
JOIN huespedes h ON r.id_huesped = h.id_huesped
JOIN habitaciones hab ON r.id_habitacion = hab.id_habitacion;

/*2. total de reservas por huesped con 1 o mas reserva*/
SELECT h.id_huesped, h.nombre, h.apellido, COUNT(r.id_reserva) AS total_reservas
FROM huespedes h
JOIN reservas r ON h.id_huesped = r.id_huesped
GROUP BY h.id_huesped, h.nombre, h.apellido
HAVING COUNT(r.id_reserva) >= 1;

/*3. reservas con monto superior al promedio general*/
SELECT r.id_reserva, h.nombre, p.monto
FROM reservas r
JOIN pagos p ON r.id_reserva = p.id_reserva
JOIN huespedes h ON r.id_huesped = h.id_huesped
WHERE p.monto > (
    SELECT AVG(monto) FROM pagos
);

/*4. reporte de ingresos por habitacion (CTE)*/
WITH ingresos_por_habitacion AS (SELECT r.id_habitacion, SUM(p.monto) AS ingresos FROM reservas r
    JOIN pagos p ON r.id_reserva = p.id_reserva
    GROUP BY r.id_habitacion)
SELECT h.id_habitacion, h.tipo, i.ingresos FROM habitaciones h
LEFT JOIN ingresos_por_habitacion i ON h.id_habitacion = i.id_habitacion;

/*5.fecha formateada y diferencia de dias*/
SELECT r.id_reserva, h.nombre, 
       DATE_FORMAT(r.fecha_entrada, '01-06-2025') AS entrada_formateada,
       DATEDIFF(r.fecha_salida, r.fecha_entrada) AS noches
FROM reservas r
JOIN huespedes h ON r.id_huesped = h.id_huesped;

/*6. busqueda por nombre o correo (LIKE)*/
SELECT * 
FROM huespedes 
WHERE nombre LIKE '%Carlos%' OR correo_electronico LIKE '%gmail%';

/*7. busqueda por rango de fechas (BETWEEN)*/
SELECT * 
FROM reservas 
WHERE fecha_entrada BETWEEN '2025-06-01' AND '2025-06-30';

/*8. EXPLAIN para análisis de rendimiento*/
EXPLAIN SELECT * 
FROM reservas 
WHERE id_huesped = '0801199603432';

/*9.consulta de servicios por reserva (Multiples JOIN)*/
SELECT r.id_reserva, h.nombre, s.nombre AS servicio, s.precio
FROM reservas r
JOIN huespedes h ON r.id_huesped = h.id_huesped
JOIN reservas_servicios rs ON r.id_reserva = rs.id_reserva
JOIN servicios s ON rs.id_servicio = s.id_servicio;

/*10.cantidad total gastada por cada huesped (JOIN, GROUP BY, SUM) */
SELECT h.id_huesped, h.nombre, h.apellido, SUM(p.monto) AS total_gastado
FROM huespedes h
JOIN reservas r ON h.id_huesped = r.id_huesped
JOIN pagos p ON r.id_reserva = p.id_reserva
GROUP BY h.id_huesped, h.nombre, h.apellido;

/*11. transaccion para registrar nueva reserva y pago*/
START TRANSACTION;
INSERT INTO reservas (id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado)
VALUES ('0801199603432', 202, '2025-07-01', '2025-07-05', 'Confirmada');
SET @id_reserva_nueva = LAST_INSERT_ID();
INSERT INTO pagos (id_reserva, metodo_pago, monto)
VALUES (@id_reserva_nueva, 'Tarjeta', 1200.00);
COMMIT;

/*12. procedimiento almacenado para registrar reserva mas pago*/
DELIMITER $$
CREATE PROCEDURE registrar_reserva_pago(
    IN p_id_huesped VARCHAR(20),
    IN p_id_habitacion INT,
    IN p_fecha_entrada DATE,
    IN p_fecha_salida DATE,
    IN p_estado VARCHAR(20),
    IN p_metodo_pago VARCHAR(50),
    IN p_monto DECIMAL(10,2))
BEGIN
    START TRANSACTION;
    INSERT INTO reservas (id_huesped, id_habitacion, fecha_entrada, fecha_salida, estado)
    VALUES (p_id_huesped, p_id_habitacion, p_fecha_entrada, p_fecha_salida, p_estado);
    SET @nuevo_id_reserva = LAST_INSERT_ID();
    INSERT INTO pagos (id_reserva, metodo_pago, monto)
    VALUES (@nuevo_id_reserva, p_metodo_pago, p_monto);
    COMMIT;
END $$
DELIMITER ;

