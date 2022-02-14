-- creacion de usuario
alter session set "_oracle_script"=true;  
create user MILLANROMANej2 identified by MILLANROMANej2;
GRANT CONNECT, RESOURCE, DBA TO MILLANROMANej2;

-- creacion de tablas

CREATE TABLE persona(
id					NUMBER(10),
nif					VARCHAR2(9),
nombre				VARCHAR2(25),
apellido1			VARCHAR2(50),
apellido2			VARCHAR2(50),
ciudad				VARCHAR2(25),
direccion			VARCHAR2(50),
telefono			VARCHAR2(9),
fecha_nacimiento	DATE,
sexo				VARCHAR2(1),
tipo				VARCHAR2(100),
CONSTRAINT PK_persona PRIMARY KEY(id),
CONSTRAINT CK_persona__sexo CHECK(sexo IN ('H','M'))
);

CREATE TABLE departamento(
id		NUMBER(10),
nombre	VARCHAR(50),
CONSTRAINT PK_departamento PRIMARY KEY(id)
);

CREATE TABLE profesor(
id_profesor			NUMBER(10),
id_departamento		NUMBER(10),
CONSTRAINT PK_profesor PRIMARY KEY(id_profesor),
CONSTRAINT FK_profesor_1 FOREIGN KEY(id_profesor) REFERENCES persona(id),
CONSTRAINT FK_profesor_2 FOREIGN KEY(id_departamento) REFERENCES departamento (id)
);

CREATE TABLE grado(
id			NUMBER(10),
nombre		VARCHAR(100),
CONSTRAINT PK_grado PRIMARY KEY(id)
);

CREATE TABLE asignatura(
id				NUMBER(10),
nombre			VARCHAR2(100),
creditos		NUMBER(5,2),
tipo			VARCHAR2(100),
curso			NUMBER(3),
cuatrimestre	NUMBER(3),
id_profesor		NUMBER(10),
id_grado		NUMBER(10),
CONSTRAINT PK_asignatura PRIMARY KEY(id),
CONSTRAINT FK_asignatura_1 FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor),
CONSTRAINT FK_asignatura_2 FOREIGN KEY(id_grado) REFERENCES grado(id)
);

CREATE TABLE curso_escolar(
id				NUMBER(10),
anyo_inicio		DATE,
anyo_fin		DATE,
CONSTRAINT PK_curso_escolar PRIMARY KEY(id)
);

CREATE TABLE alumno_se_matricula_asignatura(
id_alumno			NUMBER(10),
id_asignatura		NUMBER(10),
id_curso_escolar 	NUMBER(10),
CONSTRAINT PK_alumno_se_matr_asg PRIMARY KEY(id_alumno,id_asignatura,id_curso_escolar),
CONSTRAINT FK_alumno_se_matr_asg_1 FOREIGN KEY(id_alumno) REFERENCES persona(id),
CONSTRAINT FK_alumno_se_matr_asg_2 FOREIGN KEY(id_asignatura) REFERENCES asignatura(id),
CONSTRAINT FK_alumno_se_matr_asg_3 FOREIGN KEY(id_curso_escolar) REFERENCES curso_escolar(id)
);

-- Modificaciones de tablas

ALTER TABLE persona ADD CONSTRAINT CK_persona__nombre CHECK(nombre = UPPER(nombre));
ALTER TABLE persona ADD edad NUMBER(3);
ALTER TABLE persona ADD CONSTRAINT CK_persona__edad CHECK(edad BETWEEN 7 AND 25);
ALTER TABLE curso_escolar ADD CONSTRAINT CK_curso_escolar__anyoI CHECK(anyo_inicio < anyo_fin);
ALTER TABLE asignatura ADD CONSTRAINT CK_asignatura__cuatrimestre CHECK(cuatrimestre BETWEEN 1 AND 4);
ALTER TABLE asignatura ADD CONSTRAINT CK_asignatura__tipo CHECK(tipo LIKE 'T%');
ALTER TABLE persona ADD CONSTRAINT CK_persona__fecha_nac CHECK(TO_CHAR(fecha_nacimiento,'YYYY')>1981);
ALTER TABLE asignatura DROP COLUMN creditos;

--Eliminar todas las tablas
/*
DROP TABLE persona CASCADE CONSTRAINTS;
DROP TABLE departamento CASCADE CONSTRAINTS;
DROP TABLE profesor CASCADE CONSTRAINTS;
DROP TABLE grado CASCADE CONSTRAINTS;
DROP TABLE asignatura CASCADE CONSTRAINTS;
DROP TABLE curso_escolar CASCADE CONSTRAINTS;
DROP TABLE alumno_se_matricula_asignatura CASCADE CONSTRAINTS;
*/


