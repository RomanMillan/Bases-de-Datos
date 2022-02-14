
-- Apartado 1
CREATE TABLE caballo(
cod_caballo			VARCHAR(4), -- PK
nombre				VARCHAR(20) NOT NULL,
peso				INT(3),
fecha_nacimiento	DATE,
propietario			VARCHAR(25),
nacionalidad		VARCHAR(20),
CONSTRAINT PK_caballo PRIMARY KEY(cod_caballo),
CONSTRAINT CK_caballo__peso CHECK(peso BETWEEN 240 AND 300),
CONSTRAINT CK_caballo__fecha_nacimiento CHECK(DATE_FORMAT(fecha_nacimiento,'YYYY') > '2000'),
CONSTRAINT CK_caballo__nacionalidad CHECK(UPPER(nacionalidad) = nacionalidad)
);

CREATE TABLE carrera(
cod_carrera			VARCHAR(4),-- PK
fecha_y_hora		DATE,
importe_premio		INT(6),
apuesta_limite		DOUBLE(5,2),
CONSTRAINT PK_carrera PRIMARY KEY(cod_carrera),
CONSTRAINT CK_carrera__fecha_y_hora CHECK (DATE_FORMAT(fecha_y_hora,'HH24')>= '09' 
AND DATE_FORMAT(fecha_y_hora,'HH24/MI')<= '14/30'),
CONSTRAINT CK_carrera__apuesta_limite CHECK(apuesta_limite < 20000)
);

CREATE TABLE participacion(
cod_caballo			VARCHAR(4), -- PK FK (caballo)
cod_carrera			VARCHAR(4), -- PK FK (carrera)
dorsal				INT(2) NOT NULL,
jockey				VARCHAR(10) NOT NULL,
posicion_final		INT(2),
CONSTRAINT PK_participacion PRIMARY KEY(cod_caballo,cod_carrera),
CONSTRAINT FK_participacion FOREIGN KEY(cod_caballo) REFERENCES caballo(cod_caballo),
CONSTRAINT FK_participacion_2 FOREIGN KEY(cod_carrera) REFERENCES carrera(cod_carrera),
CONSTRAINT CK_participacion__posi_fi CHECK(posicion_final > 0)
);

CREATE TABLE cliente(
dni                 VARCHAR(10), -- FK
nombre              VARCHAR(20),
nacionalidad        VARCHAR(20),
CONSTRAINT PK_cliente PRIMARY KEY(dni),
CONSTRAINT CK_cliete__nacionalidad CHECK(UPPER(nacionalidad) = nacionalidad),
CONSTRAINT CK_cliente__dni CHECK(regexp_like(dni,'[0-9]{8}[A-Z]{1}'))
);

CREATE TABLE apuesta(
dni_cliente			VARCHAR(10), -- PK FK (cliente)
cod_caballo			VARCHAR(4), -- PK FK (caballo)
cod_carrera			VARCHAR(4), -- PK FK (carrera)
importe				INT(6) DEFAULT 300,
tanto_por_uno		DOUBLE(4,2),
CONSTRAINT PK_apuesta PRIMARY KEY(dni_cliente,cod_caballo,cod_carrera),
CONSTRAINT FK_apuesta_1 FOREIGN KEY(dni_cliente) REFERENCES cliente(dni) ON DELETE CASCADE,
CONSTRAINT FK_apuesta_2 FOREIGN KEY(cod_caballo) REFERENCES caballo(cod_caballo) ON DELETE CASCADE,
CONSTRAINT FK_apuesta_3 FOREIGN KEY(cod_carrera) REFERENCES carrera(cod_carrera) ON DELETE CASCADE,
CONSTRAINT CK_apuesta__tanto_por_uno CHECK(tanto_por_uno > 1)
);


-- Apartado 2
INSERT INTO cliente VALUES ('15487856A','James','ESCOCESA');

INSERT INTO caballo (cod_caballo,nombre,peso) VALUES ('CA-1','Spirit',300);

INSERT INTO carrera (cod_carrera,fecha_y_hora) 
VALUES ('CAR1',DATE_FORMAT('15/08/2009/09/10','DD/MM/YYYY/HH24/MI'));

INSERT INTO apuesta VALUES ('15487856A','CA-1','CAR1',2000,30);

-- Apartado 3

INSERT INTO carrera VALUES ('C6',DATE_FORMAT('18/08/2009/09/10','DD/MM/YYYY/HH24/MI'),14000,200);

INSERT INTO caballo (cod_caballo,nombre,peso) VALUES ('CA-2','Furia',245);
INSERT INTO caballo (cod_caballo,nombre,peso) VALUES ('C7','Rapido',284);

INSERT INTO participacion VALUES ('CA-2','CAR1',96,'Manuel',4);
INSERT INTO participacion VALUES ('C7','CAR1',37,'Angel',1);

-- Apartado 4
INSERT INTO carrera VALUES ('CAR2',DATE_FORMAT('19/08/2009/09/10','DD/MM/YYYY/HH24/MI'),14000,200);
INSERT INTO carrera VALUES ('CAR3',DATE_FORMAT('22/08/2009/09/10','DD/MM/YYYY/HH24/MI'),20000,280);

-- Apartado 5
ALTER TABLE caballo DROP COLUMN propietario;

-- Apartado 6
ALTER TABLE participacion ADD CONSTRAINT CK_partici__jockey CHECK(jockey= INITCAP(jockey));

ALTER TABLE carrera ADD CONSTRAINT CK_carrera__f_y_h_2 
CHECK(((DATE_FORMAT(fecha_y_hora,'DD') >= 10 AND DATE_FORMAT(fecha_y_hora,'MM')= 3)
 OR (DATE_FORMAT(fecha_y_hora,'MM') > 3))
AND ((DATE_FORMAT(fecha_y_hora,'DD') <=  10) AND DATE_FORMAT(fecha_y_hora,'MM')= 11) 
OR (DATE_FORMAT(fecha_y_hora,'MM') < 11));

ALTER TABLE caballo ADD CONSTRAINT CK_caballo__nacionalidad_2
CHECK(nacionalidad IN ('Espa�ola','Brit�nica','�rabe'));

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