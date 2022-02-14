alter session set "_oracle_script"=true;  
create user hipodromo identified by hipodromo;
GRANT CONNECT, RESOURCE, DBA TO hipodromo;

-- 1
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
cod_carrera			VARCHAR2(4),
fecha_y_hora		DATE,
importe_premio		NUMBER(6),
apuesta_limite		NUMBER(5,2),
CONSTRAINT PK_carrera PRIMARY KEY(cod_carrera),
CONSTRAINT CK_carrera__fecha_y_hora CHECK (TO_CHAR(fecha_y_hora,'HH24')>= '9' 
AND TO_CHAR(fecha_y_hora,'HH24/MM')<= '14/30'),
CONSTRAINT CK_carrera__apuesta_limite CHECK(apuesta_limite < 20000)
);

CREATE TABLE participacion(
cod_caballo			VARCHAR2(4),
cod_carrera			VARCHAR2(4),
dorsal				NUMBER(2) NOT NULL,
jockey				VARCHAR2(10) NOT NULL,
posicion_final		NUMBER(2),
CONSTRAINT PK_participacion PRIMARY KEY(cod_caballo),
CONSTRAINT FK_participacion FOREIGN KEY(cod_carrera) REFERENCES carrera(cod_carrera),
CONSTRAINT CK_participacion__posicion_final CHECK(posicion_final > 0)
);

CREATE TABLE apuesta(
dni_cliente			VARCHAR2(10),
cod_caballo			VARCHAR2(4),
cod_carrera			VARCHAR2(4),
importe				NUMBER(6) NOT NULL,DEFAULT = 300,
tanto_por_uno		NUMBER(4,2),
CONSTRAINT PK_apuesta PRIMARY KEY(dni_cliente,cod_caballo,cod_carrera)
);






