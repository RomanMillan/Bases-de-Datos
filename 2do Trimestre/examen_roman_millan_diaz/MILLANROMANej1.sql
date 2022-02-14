-- creacion de usuario
alter session set "_oracle_script"=true;  
create user MILLANROMANej1 identified by MILLANROMANej1;
GRANT CONNECT, RESOURCE, DBA TO MILLANROMANej1;

--creacion de tabla

CREATE TABLE t_estrato(
estrato			NUMBER(5), --PK
descripcion		VARCHAR2(50),
totalusuarios	NUMBER(5) DEFAULT 0,
CONSTRAINT PK_t_estrato PRIMARY KEY(estrato),
CONSTRAINT CK_t_estrato__estrato CHECK(estrato >39)
);

CREATE TABLE t_cargos(
idcargo				VARCHAR2(2), --PK
descripcioncargo	VARCHAR2(50),
CONSTRAINT PK_t_cargos PRIMARY KEY (idcargo),
CONSTRAINT CK_t_cargos__idcargo CHECK(idcargo IN ('FC','RC','RF','CO'))
);

CREATE TABLE t_servicios(
servicio				VARCHAR2(3), --PK
nservicio				NUMBER(4), --PK
descripcionservivio		VARCHAR2(200) NOT NULL,
cupousuarios			NUMBER(6),
nusuarios				NUMBER(10) DEFAULT 0,
testrato				NUMBER(5),--clave ajena
importefijo				NUMBER(8,2),
valorconsumo			NUMBER(10,2),
CONSTRAINT PK_t_servicios PRIMARY KEY(servicio,nservicio),
CONSTRAINT FK_t_servicios FOREIGN KEY(testrato) REFERENCES t_estrato (estrato)
);

CREATE TABLE t_movimientos(
id_cliente			NUMBER(5), --PK
fechaimporte		DATE DEFAULT SYSDATE,
fechamovimiento		DATE,
cargo_aplicado		VARCHAR2(2), --clave ajena
servicio			VARCHAR2(3), --clave ajena compuesta
nservicio			NUMBER(4), --clave ajena compuesta
consumo				NUMBER(10,2) NOT NULL,
importefac			NUMBER(10,2) NOT NULL,
importerec			NUMBER(10,2) NOT NULL,
impmorterefa		NUMBER(10,2) NOT NULL,
importeconv			NUMBER(10,2) NOT NULL,
CONSTRAINT PK_t_movimientos PRIMARY KEY(id_cliente,cargo_aplicado,servicio,nservicio),
CONSTRAINT FK_t_movimientos_1 FOREIGN KEY (cargo_aplicado) REFERENCES t_cargos(idcargo),
CONSTRAINT FK_t_movimientos_2 FOREIGN KEY(servicio,nservicio) REFERENCES t_servicios(servicio,nservicio)
);

CREATE TABLE t_maestro(
suscripcion		NUMBER(5), --PK y FK: t_movimientos
cargo_aplicado	VARCHAR2(2),
servicio		VARCHAR2(3),
nservicio		NUMBER(4),
alta			DATE,
nombre			VARCHAR2(20) NOT NULL,
direccion		VARCHAR2(30),
barrio			VARCHAR2(16),
saldoactual		NUMBER(10,2),
estrato			NUMBER(5),--clave ajena: t_estratos
mail			VARCHAR2(80) UNIQUE,
fechaalta		DATE DEFAULT SYSDATE,
CONSTRAINT PK_t_maestro PRIMARY KEY(suscripcion,cargo_aplicado,servicio,nservicio),
CONSTRAINT FK_t_maestro_1 FOREIGN KEY(suscripcion,cargo_aplicado,servicio,nservicio) REFERENCES t_movimientos(id_cliente,cargo_aplicado,servicio,nservicio),
CONSTRAINT FK_t_maestro_2 FOREIGN KEY (servicio,nservicio) REFERENCES t_servicios(servicio,nservicio),
CONSTRAINT FK_t_maestro_3 FOREIGN KEY(estrato) REFERENCES t_estrato(estrato),
CONSTRAINT CK_t_maestro__suscripcion CHECK(suscripcion>0),
CONSTRAINT CK_t_maestro__fechaalta CHECK(TO_CHAR(fechaalta,'DD')>01 AND TO_CHAR(fechaalta,'MM')>01
AND TO_CHAR(fechaalta,'YYYY')>1990)
);

--Modificacion de tablas
ALTER TABLE t_maestro ADD dni VARCHAR2(9) UNIQUE;
ALTER TABLE t_maestro DROP COLUMN barrio;
ALTER TABLE t_estrato MODIFY descripcion VARCHAR2(60);

-- Borrar todas las tablas
/*
DROP TABLE t_estrato CASCADE CONSTRAINTS;
DROP TABLE t_cargos CASCADE CONSTRAINTS;
DROP TABLE t_servicios CASCADE CONSTRAINTS;
DROP TABLE t_movimientos CASCADE CONSTRAINTS;
DROP TABLE t_maestro CASCADE CONSTRAINTS;
*/



