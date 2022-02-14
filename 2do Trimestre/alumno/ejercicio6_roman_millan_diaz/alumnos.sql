-- Ejercicio: Academia de idiomas (ALUMNOS)

--Creación de usuario
alter session set "_oracle_script"=true;  
create user alumno identified by alumno;
GRANT CONNECT, RESOURCE, DBA TO alumno;

-- Creacion de tablas
CREATE TABLE curso(
codigo          VARCHAR2(30),
nombre          VARCHAR2(30),
num_max_alum    NUMBER(2),
fecha_inicio    DATE,
fecha_final     DATE,
num_horas       NUMBER(4) NOT NULL,
CONSTRAINT PK_curso PRIMARY KEY (codigo),
CONSTRAINT U_curso__nombre UNIQUE (nombre),
CONSTRAINT CK_curso__fecha_inico CHECK(TO_CHAR(fecha_inicio,'DD''MM')= '15''09'),
CONSTRAINT CK_curso__fecha_final CHECK(TO_CHAR(fecha_final,'MM')= '06' AND TO_CHAR(fecha_final,'DD') = '22')
);

CREATE TABLE alumno(
dni                 VARCHAR2(9),
nombre              VARCHAR2(30),
apellidos           VARCHAR2(30),
direccion           VARCHAR2(30),
sexo                VARCHAR2(1),
fecha_nacimiento    DATE,
cod_curso           VARCHAR2(30),
CONSTRAINT PK_alumno PRIMARY KEY(dni),
CONSTRAINT FK_alumno FOREIGN KEY (cod_curso) REFERENCES curso(codigo),
CONSTRAINT CK_alumno__sexo CHECK(sexo IN ('H','M')),
CONSTRAINT CK_alumno__sexo_2 CHECK(sexo = UPPER(sexo))
);

CREATE TABLE profesor(
dni             VARCHAR2(9),
nombre          VARCHAR2(30),
direccion       VARCHAR2(30),
titulacion      VARCHAR2(30),
sueldo          NUMBER(4) NOT NULL,
cod_curso       VARCHAR2(30),
CONSTRAINT PK_profesor PRIMARY KEY (dni),
CONSTRAINT FK_profesor FOREIGN KEY (cod_curso) REFERENCES curso(codigo),
CONSTRAINT U_profesor__nombre UNIQUE (nombre)
);
