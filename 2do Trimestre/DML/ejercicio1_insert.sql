--Ejercicio ACADEMIA

-- Crear usuario tienda
alter session set "_oracle_script"=true; 
create user academia identified by academia;
GRANT CONNECT, RESOURCE, DBA TO academia;

-- Creacion de tablas
CREATE TABLE profesor(
nombre				VARCHAR2(50),
apellido1			VARCHAR2(50),
apellido2			VARCHAR2(50),
dni					VARCHAR2(9), -- PK
direccion			VARCHAR2(50),
titulo				VARCHAR2(50),
gana				NUMBER(8,2),
CONSTRAINT PK_profesor PRIMARY KEY(dni)
);

CREATE TABLE curso(
nombre_curso		VARCHAR2(50),
cod_curso			VARCHAR2(50), -- PK
dni_profesor		VARCHAR2(9), -- FK (profesor)
maximo_alumnos		NUMBER(2),
fecha_inicio		DATE,
fecha_fin			DATE,
num_horas			NUMBER(4),
CONSTRAINT PK_curso PRIMARY KEY(cod_curso),
CONSTRAINT FK_curso FOREIGN KEY(dni_profesor) REFERENCES profesor(dni)
);

CREATE TABLE alumno(
nombre				VARCHAR2(50),
apellido1			VARCHAR2(50),
apellido2			VARCHAR2(50),
dni					VARCHAR2(9), -- PK
direccion			VARCHAR2(50),
sexo				VARCHAR2(1),
fecha_nacimiento	DATE,
curso				VARCHAR2(50), --FK (curso)
CONSTRAINT PK_alumno PRIMARY KEY(dni),
CONSTRAINT FK_alumno FOREIGN KEY(curso) REFERENCES curso(cod_curso),
CONSTRAINT CK_alumno__sexo CHECK(sexo IN ('H','M'))
);

-- Insertar datos Profesor
INSERT INTO profesor VALUES ('Juan','Arch','López','32432455','Puerta Negra, 4','Ing. Informática',7500);
INSERT INTO profesor VALUES ('María','Oliva','Rubio','43215643','Juan Alfonso 32','Lda. Fil. Inglesa',5400);

-- Insertar datos Curso
INSERT INTO curso 
VALUES ('Inglés Básico','1','43215643',15,TO_DATE('01/11/00','DD/MM/YY'),TO_DATE('22-DEC-00','DD-MON-YY'),120);

INSERT INTO curso 
VALUES ('Administración Linux','2','32432455',NULL,TO_DATE('01-SEPT-00','DD-MONT-YY'),NULL,80);

--Insertar datos alumnos
INSERT INTO alumnos
VALUES ('','','','','');

