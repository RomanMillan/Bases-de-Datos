--Ejercicio1 TIENDA

-- Crear usuario tienda
alter session set "_oracle_script"=true; 
create user tienda1 identified by tienda1;
GRANT CONNECT, RESOURCE, DBA TO tienda1;

--Creación de tablas
CREATE TABLE fabricante(
codigo      NUMBER(10),
nombre      VARCHAR2(100),
CONSTRAINT PK_fabricante PRIMARY KEY(codigo)
);

CREATE TABLE producto(
codigo              NUMBER(10),
nombre              VARCHAR2(100),
precio              NUMBER(7,2),
codigo_fabricante   NUMBER(10),
CONSTRAINT PK_producto PRIMARY KEY(codigo),
CONSTRAINT FK_producto FOREIGN KEY(codigo_fabricante) REFERENCES fabricante(codigo)
);

--Datos tabla fabricante
INSERT INTO fabricante VALUES (1,'Asus');
INSERT INTO fabricante VALUES (2,'Lenovo');
INSERT INTO fabricante VALUES (3,'Hewlett-Packard');
INSERT INTO fabricante VALUES (4,'Samsung');
INSERT INTO fabricante VALUES (5,'Seagate');
INSERT INTO fabricante VALUES (6,'Crucial');
INSERT INTO fabricante VALUES (7,'Gigabyte');
INSERT INTO fabricante VALUES (8,'Huawei');
INSERT INTO fabricante VALUES (9,'Xiaomi');

-- Datos tabla producto
INSERT INTO producto VALUES (1,'Disco duro SATA3 1TB',86.99,5);
INSERT INTO producto VALUES (2,'Memoria RAM DDR4 8GB',120,6);
INSERT INTO producto VALUES (3,'Disco SSD 1TB',150.99,4);
INSERT INTO producto VALUES (4,'GeForce GTX 1050Ti',185,7);
INSERT INTO producto VALUES (5,'GeForce GTX 1080 Xtreme',755,6);
INSERT INTO producto VALUES (6,'Monitor 24 LED Full HD',202,1);
INSERT INTO producto VALUES (7,'Monitor 27 LED Full HD',245.99,1);
INSERT INTO producto VALUES (8,'Portátil Yoga 520',559,2);
INSERT INTO producto VALUES (9,'Portátil Ideapd 320',444,2);
INSERT INTO producto VALUES (10,'Impresora HP Deskjet 3720',59.99,3);
INSERT INTO producto VALUES (11,'Impresora HP Laserjet Pro M26w',180,3);

-- Modificaciones adicionales
--1
INSERT INTO fabricante VALUES (10,'LG');

--2
/*No se puede añadir un nuevo dato dejando nulo el campo codigo que es PK*/

--3
INSERT INTO producto (codigo,nombre,precio,codigo_fabricante) 
VALUES (12,'LG WING',1099,10);

--4
/*No se puede añadir un nuevo dato dejando nulo el campo codigo que es PK*/

-- 5
/*
    No podemos borrar al fabricante debido a que tiene hijos de la FK;
    Tenemos que borrar la constraint y crearla de nuevo con ON DELETE CASCADE
*/
ALTER TABLE producto DROP CONSTRAINT FK_producto;
ALTER TABLE producto ADD CONSTRAINT FK_producto FOREIGN KEY(codigo_fabricante) 
REFERENCES fabricante(codigo) ON DELETE CASCADE;

DELETE FROM fabricante WHERE codigo = 1;

-- 6
/*
    Si es posible eliminarlo ya que tenemos modificado la constraint y 
    además no tenemos ningun dato guardado en otra tabla referenciado
*/
DELETE FROM fabricante WHERE codigo = 9;

-- 7
/*
    No deja modificar ya que está siendo usado para cubrir otros campos

*/

ALTER TABLE producto DISABLE CONSTRAINT FK_producto;
UPDATE fabricante SET codigo = 20 WHERE codigo = 2;

UPDATE producto SET codigo = 20 WHERE codigo = 2

-- 8

/*
    Si puede ser modificado ya que no está siendo utilizado en otras tablas
*/
UPDATE fabricante SET codigo = 20 WHERE codigo = 8;

-- 9
UPDATE producto SET precio = precio + 5;

-- 10
SELECT nombre FROM producto WHERE nombre LIKE 'Impresora %';
DELETE FROM producto WHERE UPPER nombre LIKE UPPER('Impresora %')
AND precio < 200;



--Ejercicio2 EMPLEADOS

-- Crear usuario empleado
alter session set "_oracle_script"=true;  
create user empleado identified by empleado;
GRANT CONNECT, RESOURCE, DBA TO empleado;

-- Creacion de las tablas
CREATE TABLE departamento(
codigo          NUMBER(10),
nombre          VARCHAR2(100),
presupuesto     NUMBER(9,2),
CONSTRAINT PK_departamento PRIMARY KEY(codigo)
);

CREATE TABLE empleado(
codigo                  NUMBER(10),
nif                     VARCHAR2(9),
nombre                  VARCHAR2(100),
apellido1               VARCHAR2(100),
apellido2               VARCHAR2(100),
codigo_departamento     NUMBER(10),
CONSTRAINT PK_empleado PRIMARY KEY(codigo),
CONSTRAINT FK_empleado FOREIGN KEY(codigo_departamento) REFERENCES departamento(codigo)
);

ALTER TABLE departamento ADD presupuesto2 NUMBER(6);

-- Datos de departamento
INSERT INTO departamento VALUES (1,'Desarrollo',120000,6000);
INSERT INTO departamento VALUES (2,'Sistemas',150000,21000);
INSERT INTO departamento VALUES (3,'Recursos Humanos',280000,25000);
INSERT INTO departamento VALUES (4,'Contabilidad',110000,3000);
INSERT INTO departamento VALUES (5,'I+D',375000,380000);
INSERT INTO departamento VALUES (6,'Proyectos',0,0);
INSERT INTO departamento VALUES (7,'Publicidad',0,1000);

-- Datos de empleado
INSERT INTO empleado VALUES (1,'32481596F','Aarón','Rivero','Gómez',1);
INSERT INTO empleado VALUES (2,'Y5575632D','Adela','Salas','Díaz',2);
INSERT INTO empleado VALUES (3,'R6970642B','Adolfo','Rubio','Díaz',3);
INSERT INTO empleado VALUES (4,'77705545E','Adrián','Suárez',NULL,4);
INSERT INTO empleado VALUES (5,'17087203C','Marcos','Loyola','Méndez',5);
INSERT INTO empleado VALUES (6,'38382980M','María','Santana','Moreno',1);
INSERT INTO empleado VALUES (7,'80576669X','Pilar','Ruiz',NULL,2);
INSERT INTO empleado VALUES (8,'71651431Z','Pepe','Ruiz','Santana',3);
INSERT INTO empleado VALUES (9,'56399183D','Juan','Gómez','López',2);
INSERT INTO empleado VALUES (10,'46384486H','Diego','Flores','Salas',5);
INSERT INTO empleado VALUES (11,'67389283A','Marta','Herrera','Gil',1);
INSERT INTO empleado VALUES (12,'41234836R','Irene','Salas','Flores',NULL);
INSERT INTO empleado VALUES (13,'82635162B','Juan Antonio','Sáez','Guerrero',NULL);

-- Modificaciones de datos
-- 1
INSERT INTO departamento (codigo,nombre,presupuesto) 
VALUES (8,'Tesoreria',150000);

-- 2
/*
No se puede debido a que es una PK y debe tener algun dato
*/
-- 3
INSERT INTO departamento (codigo,nombre,presupuesto,presupuesto2) 
VALUES (9,'Base de datos',150000,48000);

-- 4
INSERT INTO empleado (codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES (14,'12644162H','Marcos','Moreno','Rivero',9);

--5
INSERT INTO empleado (codigo,nif,nombre,apellido1,apellido2,codigo_departamento)
VALUES (15,'44644162D','Marina','Maleza','Martos',9);

-- 6
CREATE TABLE departamento_backup AS (SELECT * FROM departamento);

-- 7
DELETE FROM departamento WHERE codigo = 6;

-- 8
DELETE FROM departamento WHERE codigo = 1;

-- 9
UPDATE departamento SET codigo = 30 WHERE codigo = 3;

-- 10
UPDATE departamento SET codigo = 40 WHERE codigo = 7;

-- 11
UPDATE departamento SET presupuesto = presupuesto + 50000 
WHERE presupuesto < 20000;

-- 12
DELETE FROM empleado WHERE codigo_departamento IS NULL;



