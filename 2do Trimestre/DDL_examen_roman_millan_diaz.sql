--EJERCICIO 1

--Creación de usuario
alter session set "_oracle_script"=true;  
create user ddl_exam_roman_millan identified by ddl_exam_roman_millan;
GRANT CONNECT, RESOURCE, DBA TO ddl_exam_roman_millan;


--APARTADO A

--Creación de tablas
CREATE TABLE familia(
nombre              VARCHAR2(20),
caracteristicas     VARCHAR2(40),
CONSTRAINT PK_familia PRIMARY KEY(nombre)
);

CREATE TABLE genero(
nombre              VARCHAR2(20),
caracteristicas     VARCHAR2(40),
nombre_familia      VARCHAR2(20),
CONSTRAINT PK_genero PRIMARY KEY(nombre),
CONSTRAINT FK_genero FOREIGN KEY(nombre_familia) REFERENCES familia (nombre)
);

CREATE TABLE especie(
nombre              VARCHAR2(20),
caracteristicas     VARCHAR2(40),
nombre_genero       VARCHAR2(20),
CONSTRAINT PK_especie PRIMARY KEY(nombre),
CONSTRAINT FK_especie FOREIGN KEY(nombre_genero) REFERENCES genero (nombre)
);

CREATE TABLE zona(
nombre          VARCHAR2(20),
localidad       VARCHAR2(40),
extension       NUMBER(5,2),
protegida       VARCHAR2(2),
CONSTRAINT PK_zona PRIMARY KEY(nombre),
CONSTRAINT CK_zona__protegia CHECK(protegida IN ('SI','NO'))
);

CREATE TABLE persona(
dni             VARCHAR2(9),
nombre          VARCHAR2(20) UNIQUE,
direccion       VARCHAR2(40),
telefono        VARCHAR2(9),
usuario         VARCHAR2(20),
CONSTRAINT PK_persona PRIMARY KEY(dni)
);

CREATE TABLE coleccion(
precio              NUMBER(5,2),
fecha_inicio        DATE,
nº_de_ejemplares    NUMBER(4),
dni_persona         VARCHAR2(9),
CONSTRAINT PK_coleccion PRIMARY KEY(dni_persona),
CONSTRAINT FK_coleccion FOREIGN KEY(dni_persona) REFERENCES persona(dni),
CONSTRAINT CK_coleccion__precio CHECK(precio >0),
CONSTRAINT CK_coleccion__n_ejemp CHECK(nº_de_ejemplares BETWEEN 1 AND 150)
);

CREATE TABLE ejemplar_mariposa(
fecha_captura       DATE, --PK
hora_captura        DATE, --PK
nombre_comun        VARCHAR2(20),
precio_ejemplar     NUMBER(5,2),
nombre_zona         VARCHAR2(20),--PK FK
dni_persona         VARCHAR2(9),--FK
fecha_coleccion     DATE,
nombre_especie      VARCHAR2(20), --FK
CONSTRAINT PK_ejemplar_mariposa PRIMARY KEY(fecha_captura,hora_captura,nombre_zona),
CONSTRAINT FK_ejemplar_mariposa FOREIGN KEY(nombre_zona) REFERENCES zona(nombre),
CONSTRAINT FK_ejemplar_mariposa_2 FOREIGN KEY(dni_persona) REFERENCES persona(dni),
CONSTRAINT FK_ejemplar_mariposa_3 FOREIGN KEY(nombre_especie) REFERENCES especie(nombre)
);

-- APARTADO B

-- Modificaciones de las tablas
ALTER TABLE persona ADD apellidos VARCHAR2(50);
ALTER TABLE zona ADD CONSTRAINT CK_zona__extension CHECK(extension BETWEEN 100 AND 1500);
ALTER TABLE coleccion DISABLE CONSTRAINT CK_coleccion__precio;

-- APARTADO C

--Crear los indices
CREATE INDEX ID_nombre_apellido ON persona (nombre,apellidos);
/*
No se puede crear este index ya que es una PK
seria de este modo:
CREATE INDEX ID_fecha_cap ON ejemplar_mariposa (fecha);
*/

-- APARTADO D

-- Creacion de roles 
--(He creado a usuarios y asignado sus roles para hacerlo mas completo)

--usuario
CREATE USER usuario IDENTIFIED BY usuario;
CREATE ROLE rol_usuario;
GRANT select ON persona TO rol_usuario;
GRANT select ON ejemplar_mariposa TO rol_usuario;
GRANT select ON coleccion TO rol_usuario;
GRANT rol_usuario TO usuario;

--empleado
CREATE USER empleado IDENTIFIED BY empleado;
CREATE ROLE rol_empleado;
GRANT select,insert,update ON persona TO rol_empleado;
GRANT select,insert,update ON ejemplar_mariposa TO rol_empleado;
GRANT select,insert,update ON coleccion TO rol_empleado;
GRANT select,insert,update ON zona TO rol_empleado;
GRANT rol_empleado TO empleado;

--administrador
CREATE USER administrador IDENTIFIED BY administrador;
CREATE ROLE rol_administrador;
GRANT CONNECT, RESOURCE, DBA TO rol_administrador;
GRANT rol_administrador TO administrador;

--APARTADO E

--Eliminar roles
DROP ROLE rol_usuario;
DROP ROLE rol_empleado;
DROP ROLE rol_administrador;

--Eliminar indices
DROP INDEX ID_nombre_apellido;

--Eliminar tablas
DROP TABLE coleccion CASCADE CONSTRAINTS;
DROP TABLE ejemplar_mariposa CASCADE CONSTRAINTS;
DROP TABLE especie CASCADE CONSTRAINTS;
DROP TABLE familia CASCADE CONSTRAINTS;
DROP TABLE genero CASCADE CONSTRAINTS;
DROP TABLE persona CASCADE CONSTRAINTS;
DROP TABLE zona CASCADE CONSTRAINTS;

-- Eliminar los usuarios
DROP USER usuario;
DROP USER empleado;
DROP USER administrador;




