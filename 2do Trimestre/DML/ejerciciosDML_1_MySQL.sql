#Creación de tablas
CREATE TABLE fabricante(
codigo      INT(10),
nombre      VARCHAR(100),
CONSTRAINT PK_fabricante PRIMARY KEY(codigo)
);

CREATE TABLE producto(
codigo              INT(10) auto_increment,
nombre              VARCHAR(100),
precio              DOUBLE,
codigo_fabricante   INT(10),
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

# Modificaciones adicionales
#1
INSERT INTO fabricante VALUES (10,'LG');

#2
INSERT INTO fabricante (nombre) VALUES ('Nokia');

#3
INSERT INTO producto (codigo,nombre,precio,codigo_fabricante) 
VALUES (12,'LG WING',1099,10);

#4
INSERT INTO fabricante (nombre) VALUES ('IBM');

-- 5
/*
    No podemos borrar al fabricante debido a que tiene datos compartidos;
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
UPDATE fabricante SET codigo = 20 WHERE codigo = 2 ON UPDATE CASCADE;


-- 8

/*
    Si puede ser modificado ya que no está siendo utilizado en otras tablas
*/
UPDATE fabricante SET codigo = 20 WHERE codigo = 8;

-- 9
UPDATE producto SET precio = precio + 5;

-- 10
DELETE FROM producto WHERE nombre LIKE 'Impresora %' 
AND precio < 200;