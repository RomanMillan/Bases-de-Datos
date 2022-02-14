alter session set "_oracle_script"=true;  
create user hipodromo identified by hipodromo;
GRANT CONNECT, RESOURCE, DBA TO hipodromo;

-- Apartado 1
CREATE TABLE caballo(
cod_caballo			VARCHAR2(4), -- PK
nombre				VARCHAR2(20) NOT NULL,
peso				NUMBER(3),
fecha_nacimiento	DATE,
propietario			VARCHAR2(25),
nacionalidad		VARCHAR2(20),
CONSTRAINT PK_caballo PRIMARY KEY(cod_caballo),
CONSTRAINT CK_caballo__peso CHECK(peso BETWEEN 240 AND 300),
CONSTRAINT CK_caballo__fecha_nacimiento CHECK(TO_CHAR(fecha_nacimiento,'YYYY') > '2000'),
CONSTRAINT CK_caballo__nacionalidad CHECK(UPPER(nacionalidad) = nacionalidad)
);

CREATE TABLE carrera(
cod_carrera			VARCHAR2(4),-- PK
fecha_y_hora		DATE,
importe_premio		NUMBER(6),
apuesta_limite		NUMBER(5,2),
CONSTRAINT PK_carrera PRIMARY KEY(cod_carrera),
CONSTRAINT CK_carrera__fecha_y_hora CHECK (TO_CHAR(fecha_y_hora,'HH24')>= '09' 
AND TO_CHAR(fecha_y_hora,'HH24/MI')<= '14/30'),
CONSTRAINT CK_carrera__apuesta_limite CHECK(apuesta_limite < 20000)
);

CREATE TABLE participacion(
cod_caballo			VARCHAR2(4), -- PK FK (caballo)
cod_carrera			VARCHAR2(4), -- PK FK (carrera)
dorsal				NUMBER(2) NOT NULL,
jockey				VARCHAR2(10) NOT NULL,
posicion_final		NUMBER(2),
CONSTRAINT PK_participacion PRIMARY KEY(cod_caballo,cod_carrera),
CONSTRAINT FK_participacion FOREIGN KEY(cod_caballo) REFERENCES caballo(cod_caballo),
CONSTRAINT FK_participacion_2 FOREIGN KEY(cod_carrera) REFERENCES carrera(cod_carrera),
CONSTRAINT CK_participacion__posi_fi CHECK(posicion_final > 0)
);

CREATE TABLE cliente(
dni                 VARCHAR2(10), --FK
nombre              VARCHAR2(20),
nacionalidad        VARCHAR2(20),
CONSTRAINT PK_cliente PRIMARY KEY(dni),
CONSTRAINT CK_cliete__nacionalidad CHECK(UPPER(nacionalidad) = nacionalidad),
CONSTRAINT CK_cliente__dni CHECK(regexp_like(dni,'[0-9]{8}[A-Z]{1}'))
);

CREATE TABLE apuesta(
dni_cliente			VARCHAR2(10), -- PK FK (cliente)
cod_caballo			VARCHAR2(4), -- PK FK (caballo)
cod_carrera			VARCHAR2(4), -- PK FK (carrera)
importe				NUMBER(6)DEFAULT 300,
tanto_por_uno		NUMBER(4,2),
CONSTRAINT PK_apuesta PRIMARY KEY(dni_cliente,cod_caballo,cod_carrera),
CONSTRAINT FK_apuesta_1 FOREIGN KEY(dni_cliente) REFERENCES cliente(dni) ON DELETE CASCADE,
CONSTRAINT FK_apuesta_2 FOREIGN KEY(cod_caballo) REFERENCES caballo(cod_caballo) ON DELETE CASCADE,
CONSTRAINT FK_apuesta_3 FOREIGN KEY(cod_carrera) REFERENCES carrera(cod_carrera) ON DELETE CASCADE,
CONSTRAINT CK_apuesta__tanto_por_uno CHECK(tanto_por_uno > 1)
);


-- Apartado 2
INSERT INTO cliente (dni,nacionalidad) VALUES ('15487856A','ESCOCESA');

INSERT INTO caballo (cod_caballo,nombre,peso) VALUES ('CA-1','Spirit',300);

INSERT INTO carrera (cod_carrera,fecha_y_hora) 
VALUES ('CAR1',TO_DATE('15/08/2009/09/10','DD/MM/YYYY/HH24/MI'));

INSERT INTO apuesta VALUES ('15487856A','CA-1','CAR1',2000,30.1);

-- Apartado 3

INSERT INTO carrera VALUES ('C6',TO_DATE('18/08/2009/09/10','DD/MM/YYYY/HH24/MI'),14000,200);

INSERT INTO caballo (cod_caballo,nombre,peso) VALUES ('CA-2','Furia',245);
INSERT INTO caballo (cod_caballo,nombre,peso) VALUES ('C7','Rapido',284);

INSERT INTO participacion VALUES ('CA-2','CAR1',96,'Manuel',4);
INSERT INTO participacion VALUES ('C7','CAR1',37,'Angel',1);

-- Apartado 4
INSERT INTO carrera VALUES ('CAR2',TO_DATE('19/08/2009/09/10','DD/MM/YYYY/HH24/MI'),14000,200);
INSERT INTO carrera VALUES ('CAR3',TO_DATE('22/08/2009/09/10','DD/MM/YYYY/HH24/MI'),20000,280);

-- Apartado 5
ALTER TABLE caballo DROP COLUMN propietario;

-- Apartado 6 
-- HAY que tener cuidado el INITCAP solo permite que esté en mayuscula la primera si está todo ne mayuscula no
-- No lo dejará crear la constraint
ALTER TABLE participacion ADD CONSTRAINT CK_partici__jockey CHECK(jockey= INITCAP(jockey));

ALTER TABLE carrera ADD CONSTRAINT CK_carrera__f_y_h_2 
CHECK(((TO_CHAR(fecha_y_hora,'DD') >= 10 AND TO_CHAR(fecha_y_hora,'MM')= 3)
 OR (TO_CHAR(fecha_y_hora,'MM') > 3))
AND ((TO_CHAR(fecha_y_hora,'DD') <=  10) AND TO_CHAR(fecha_y_hora,'MM')= 11) 
OR (TO_CHAR(fecha_y_hora,'MM') < 11));

ALTER TABLE caballo ADD CONSTRAINT CK_caballo__nacionalidad_2
CHECK(nacionalidad IN ('Española','Británica','Árabe'));

-- Apartado 7
DELETE FROM carrera WHERE 
    (SELECT cab.* FROM caballo cab ,participacion par 
     WHERE cab.cod_caballo LIKE par.cod_caballo);


-- Apartado 8
CREATE TABLE cliente_backup AS (SELECT * FROM cliente);
DELETE  FROM cliente;
ALTER TABLE cliente ADD codigo VARCHAR2(6)UNIQUE NOT NULL;
INSERT INTO cliente SELECT dni,nombre,nacionalidad,'15' FROM cliente_backup;
DROP TABLE cliente_backup;

-- Apartado 9
UPDATE carrera SET cod_carrera = 'C66' WHERE cod_carrera = 'C6';

-- Apartado 10
ALTER TABLE apuesta ADD premio NUMBER(6);

-- Apartado 11
DROP TABLE caballo CASCADE CONSTRAINTS;
DROP TABLE carrera CASCADE CONSTRAINTS;
DROP TABLE participacion CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE apuesta CASCADE CONSTRAINTS;


