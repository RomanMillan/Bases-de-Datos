
--Ejercicio , Tiendas.

-- Creación de usuario
alter session set "_oracle_script"=true;  
create user tienda identified by tienda;
GRANT CONNECT, RESOURCE, DBA TO tienda;

-- Crear las tablas
CREATE TABLE fabricante(
cod_fabricante		NUMBER(3),
nombre				VARCHAR2(15),
pais				VARCHAR2(15),
CONSTRAINT PK_fabricante PRIMARY KEY (cod_fabricante),
CONSTRAINT CK_fabricante__nombre CHECK(nombre = UPPER(nombre)),
CONSTRAINT CK_fabricante__pais CHECK(pais = UPPER(pais))
);

CREATE TABLE articulo(
articulo			VARCHAR2(20),
cod_fabricante		NUMBER(3),
peso				NUMBER(3),
categoria			VARCHAR2(10),
precio_venta		NUMBER(4,2),
precio_costo		NUMBER(4,2),
existencias			NUMBER(5),
CONSTRAINT PK_articulo PRIMARY KEY(articulo,cod_fabricante,peso,categoria),
CONSTRAINT FK_articulo FOREIGN KEY (cod_fabricante) REFERENCES fabricante (cod_fabricante),
CONSTRAINT CK_articulo__precio_venta CHECK(precio_venta >0),
CONSTRAINT CK_articulo__precio_costo CHECK(precio_costo >0),
CONSTRAINT CK_articulo__peso CHECK(peso >0)
);

CREATE TABLE tienda(
nif				VARCHAR2(10),
nombre			VARCHAR2(20),
direccion		VARCHAR2(20),
poblacion		VARCHAR2(20),
provincia		VARCHAR2(20),
codpostal		NUMBER(5),
CONSTRAINT PK_tienda PRIMARY KEY (nif)
);

CREATE TABLE pedido(
nif                 VARCHAR2(10),
articulo            VARCHAR2(20),
cod_fabricante      NUMBER(3),
peso                NUMBER(3),
categoria           VARCHAR2(10),
fecha_pedido        DATE,
unidades_pedidas    NUMBER(4),
CONSTRAINT PK_pedido PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_pedido),
CONSTRAINT FK_pedido_1 FOREIGN KEY (nif) REFERENCES tienda(nif),
CONSTRAINT FK_pedido_2 FOREIGN KEY (articulo,peso,categoria,cod_fabricante) 
REFERENCES articulo(articulo,peso,categoria,cod_fabricante) ON DELETE CASCADE,
CONSTRAINT CK_pedido__unidades_pedidas CHECK (unidades_pedidas >0)
);

CREATE TABLE venta(
nif                 VARCHAR2(10),
articulo            VARCHAR2(20),
cod_fabricante      NUMBER(3),
peso                NUMBER(3),
categoria           VARCHAR2(10),
fecha_venta         DATE DEFAULT sysdate,
unidades_vendidas   NUMBER(4),
CONSTRAINT PK_venta PRIMARY KEY(nif,articulo,cod_fabricante,peso,categoria,fecha_venta),
CONSTRAINT FK_venta_1 FOREIGN KEY (articulo,cod_fabricante,peso,categoria) 
REFERENCES articulo(articulo,cod_fabricante,peso,categoria)ON DELETE CASCADE,
CONSTRAINT FK_venta_2 FOREIGN KEY (nif) REFERENCES tienda(nif),
CONSTRAINT CK_venta__unidades_vendidas CHECK(unidades_vendidas > 0)
);

--Modificar las tablas
--1
ALTER TABLE pedido MODIFY unidades_pedidas NUMBER(6);
ALTER TABLE venta MODIFY unidades_vendidas NUMBER(6);

--2
ALTER TABLE pedido ADD pvp NUMBER(5,2);
ALTER TABLE venta ADD pvp NUMBER(5,2);

--3
ALTER TABLE fabricante DROP COLUMN pais;

--4
ALTER TABLE venta ADD CONSTRAINT CK_venta__unid_vendidas_2 CHECK(unidades_vendidas >= 100);

--5
ALTER TABLE venta DROP CONSTRAINT CK_venta__unid_vendidas_2;

-- 6
DROP TABLE fabricante CASCADE CONSTRAINTS;
DROP TABLE articulo CASCADE CONSTRAINTS;
DROP TABLE tienda CASCADE CONSTRAINTS;
DROP TABLE pedido CASCADE CONSTRAINTS;
DROP TABLE venta CASCADE CONSTRAINTS;