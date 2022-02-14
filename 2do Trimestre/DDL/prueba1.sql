/*Ejercicio prueba iniciación*/

CREATE TABLE grupo(
cod_grupo		VARCHAR2(30),
descripcion		VARCHAR2(30),
CONSTRAINT PK_grupo PRIMARY KEY (cod_grupo)
);

CREATE TABLE alumno(
nif			VARCHAR2(30),
nombre		VARCHAR2(30),
cod_grupo	VARCHAR2(30),
CONSTRAINT PK_nif PRIMARY KEY (nif),
CONSTRAINT FK_cod_grupo FOREIGN KEY (cod_grupo) REFERENCES grupo(cod_grupo)
);

