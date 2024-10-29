--CREACION DE TABLAS
CREATE TABLE Clientes (
cliente_id int GENERATED AS IDENTITY PRIMARY KEY,
nombre VARCHAR2(50) NOT NULL,
apellido VARCHAR2(50) NOT NULL,
fecha_registro DATE DEFAULT SYSDATE, --en esta sentencia si no se especifica la fecha en el insert se inserta la fecha actual al momento de registrar
email VARCHAR2(100) UNIQUE NOT NULL,
telefono VARCHAR2(15)
);

alter table Clientes
modify(cliente_id number);

CREATE TABLE Productos (
producto_id number GENERATED AS IDENTITY PRIMARY KEY,
nombre_producto VARCHAR2 (100) not null,
categoria VARCHAR2 (50) not null,
precio number not null,
stock number not null
);

CREATE TABLE VENTAS (
venta_id number GENERATED AS IDENTITY PRIMARY KEY,
cliente_id number,
producto_id number,
cantidad number not null,
fecha_venta DATE DEFAULT SYSDATE,
total_venta number not null,
FOREIGN KEY (cliente_id) references Clientes(cliente_id),
FOREIGN KEY (producto_id) references Productos(producto_id)
);

CREATE TABLE PERSONAL_DE_VENTAS (
personal_id number GENERATED AS IDENTITY PRIMARY KEY,
nombre VARCHAR2(50) NOT NULL,
apellido VARCHAR2(50) NOT NULL,
email VARCHAR2(100) NOT NULL UNIQUE,
telefono NUMBER not null
);

-- LLENADO DE REGISTROS PARA CAD TABLA

--CLIENTES con fecha actual
INSERT INTO Clientes (nombre, apellido, email, telefono) VALUES ('Carlos', 'Gomez', 'carlos.gomez@gmail.com', '123456789');
INSERT INTO Clientes (nombre, apellido, email, telefono) VALUES ('Ana', 'Lopez', 'ana.lopez@hotmail.com', '987654321');
INSERT INTO Clientes (nombre, apellido, email, telefono) VALUES ('Luis', 'Martinez', 'luis.martinez@yahoo.com', '456123789');
INSERT INTO Clientes (nombre, apellido, email, telefono) VALUES ('Maria', 'Perez', 'maria.perez@gmail.com', '321654987');
INSERT INTO Clientes (nombre, apellido, email, telefono) VALUES ('Sofia', 'Garcia', 'sofia.garcia@hotmail.com', '654987123');

INSERT INTO Clientes (nombre, apellido, fecha_registro, email, telefono) 
VALUES ('Luis', 'Mendoza', TO_DATE('2024-10-10', 'YYYY-MM-DD'), 'luis.mendoza@example.com', '987654325');

INSERT INTO Clientes (nombre, apellido, fecha_registro, email, telefono) 
VALUES ('Carmen', 'Salinas', TO_DATE('2024-10-15', 'YYYY-MM-DD'), 'carmen.salinas@example.com', '912345678');

--CLIENTES CON FECHAS PASADAS
INSERT INTO Clientes (nombre, apellido, fecha_registro, email, telefono)
VALUES ('Andrea', 'Salazar', TO_DATE('2023-05-10', 'YYYY-MM-DD'), 'andrea.salazar@example.com', '111223344');

INSERT INTO Clientes (nombre, apellido, fecha_registro, email, telefono)
VALUES ('Luis', 'Fernández', TO_DATE('2022-12-21', 'YYYY-MM-DD'), 'luis.fernandez@example.com', '222334455');

INSERT INTO Clientes (nombre, apellido, fecha_registro, email, telefono)
VALUES ('Carla', 'Mendoza', TO_DATE('2021-07-17', 'YYYY-MM-DD'), 'carla.mendoza@example.com', '333445566');

INSERT INTO Clientes (nombre, apellido, fecha_registro, email, telefono)
VALUES ('Jorge', 'Castro', TO_DATE('2020-03-05', 'YYYY-MM-DD'), 'jorge.castro@example.com', '444556677');

INSERT INTO Clientes (nombre, apellido, fecha_registro, email, telefono)
VALUES ('Valeria', 'Ortiz', TO_DATE('2019-10-28', 'YYYY-MM-DD'), 'valeria.ortiz@example.com', '555667788');


select *from Clientes;

--PRODUCTOS
INSERT INTO Productos (nombre_producto, categoria, precio, stock) VALUES ('Laptop HP', 'Electrónica', 800.00, 15);
INSERT INTO Productos (nombre_producto, categoria, precio, stock) VALUES ('Teléfono Samsung', 'Electrónica', 500.00, 30);
INSERT INTO Productos (nombre_producto, categoria, precio, stock) VALUES ('Impresora Canon', 'Oficina', 150.00, 10);
INSERT INTO Productos (nombre_producto, categoria, precio, stock) VALUES ('Escritorio', 'Muebles', 200.00, 5);
INSERT INTO Productos (nombre_producto, categoria, precio, stock) VALUES ('Silla Ergonómica', 'Muebles', 120.00, 20);
INSERT INTO Productos (nombre_producto, categoria, precio, stock) VALUES ('Joystick Suita', 'Electronica', 140.00, 30);

select *from Productos;

--VENTAS
INSERT INTO VENTAS (cliente_id, producto_id, cantidad, total_venta) VALUES (1, 1, 2, 1600.00);
INSERT INTO VENTAS (cliente_id, producto_id, cantidad, total_venta) VALUES (2, 3, 1, 150.00);
INSERT INTO VENTAS (cliente_id, producto_id, cantidad, total_venta) VALUES (3, 2, 3, 1500.00);
INSERT INTO VENTAS (cliente_id, producto_id, cantidad, total_venta) VALUES (4, 5, 4, 480.00);
INSERT INTO VENTAS (cliente_id, producto_id, cantidad, total_venta) VALUES (5, 4, 1, 200.00);

SELECT *FROM VENTAS;

--PERSONAL DE VENTAS
INSERT INTO PERSONAL_DE_VENTAS (nombre, apellido, email, telefono) VALUES ('Roberto', 'Fernandez', 'roberto.fernandez@gmail.com', 987654321);
INSERT INTO PERSONAL_DE_VENTAS (nombre, apellido, email, telefono) VALUES ('Laura', 'Mejia', 'laura.mejia@hotmail.com', 123456789);
INSERT INTO PERSONAL_DE_VENTAS (nombre, apellido, email, telefono) VALUES ('Jorge', 'Santos', 'jorge.santos@yahoo.com', 654987321);
INSERT INTO PERSONAL_DE_VENTAS (nombre, apellido, email, telefono) VALUES ('Lucia', 'Ortiz', 'lucia.ortiz@gmail.com', 321654987);
INSERT INTO PERSONAL_DE_VENTAS (nombre, apellido, email, telefono) VALUES ('Andres', 'Castro', 'andres.castro@hotmail.com', 456123789);

SELECT *FROM PERSONAL_DE_VENTAS;

--DESAFIOS
--DESAFIO 1
--Obtener la lista de clientes registrados en el último mes, mostrando su nombre completo y fecha de registro.
--Ordenar la lista por fecha de registro en orden descendente
SELECT 
    CONCAT(nombre,'') || apellido as "Identificacion de Cliente",
    fecha_registro as "Fecha de registro"
    FROM 
        clientes
    WHERE 
        EXTRACT(YEAR FROM fecha_registro) = EXTRACT(YEAR FROM SYSDATE)
        AND EXTRACT(MONTH FROM fecha_registro) = EXTRACT(MONTH FROM SYSDATE)
    ORDER BY(fecha_registro) DESC;

--DESAFIO 2
--: Calcular el incremento del 15% del precio de todos los productos cuyo nombre termine en A y que tengan más de 10 unidades en stock. 
--Considera el resultado del incremento con 1 decimal. Ordenar el listado por el incremento de forma ascendente
SELECT 
    nombre_producto,
    ROUND(precio+(precio*0.15),1) AS "Precio incrementado en 15%", -- Redondea el incremento al entero
    precio AS "Precio sin incrementar"
FROM 
    Productos
WHERE 
    nombre_producto LIKE '%a' -- Productos terminados en la letra 'a'
    AND stock > 10
ORDER BY
    2 ASC;
    
--Desafio 3
--Mostrar la lista del personal de ventas registrado en la base de datos, mostrando su nombre completo,
--correo electrónico y creando una contraseña por defecto que cumpla los siguientes requisitos:
--4 primeras letras del nombre 
--Cantidad de caracteres de su email , 3 últimas letras del apellido 
--Ordenar la lista por apellido de forma descendente y por nombre de forma ascendente.

SELECT 
    nombre || ' ' || apellido AS nombre_completo, 
    email,
    SUBSTR(nombre, 1, 4) || LENGTH(email) || SUBSTR(apellido, -3) AS contrasena_por_defecto
FROM 
    personal_de_ventas
ORDER BY 
    apellido DESC, 
    nombre ASC;
