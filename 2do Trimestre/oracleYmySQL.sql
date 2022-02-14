
-- creacion de usuario
alter session set "_oracle_script"=true;  
create user oracleYmysql identified by oracleYmysql;
GRANT CONNECT, RESOURCE, DBA TO oracleYmysql;

-- Ejercicio1
CREATE TABLE departamento(
codigo			NUMBER(10),
nombre			VARCHAR2(100),
presupuesto		NUMBER(5,2),
CONSTRAINT PK_departamento PRIMARY KEY (codigo)
);

CREATE TABLE empleado(
codigo					NUMBER(10),
nif						VARCHAR2(9),
nombre					VARCHAR2(100),
apellido1				VARCHAR2(100),
apellido2				VARCHAR2(100),
codigo_departamento		NUMBER(10),
CONSTRAINT PK_empleado PRIMARY KEY(codigo),
CONSTRAINT FK_empleado FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);

-- Ejercicio2
CREATE TABLE comercial(
id			NUMBER(10),
nombre		VARCHAR2(100),
apellido1	VARCHAR2(100),
apellido2	VARCHAR2(100),
ciudad		VARCHAR2(100),
comision	NUMBER(5,2),
CONSTRAINT PK_comercial PRIMARY KEY(id)
);

CREATE TABLE cliente(
id			NUMBER(10),
nombre		VARCHAR2(100),
apellido1	VARCHAR2(100),
apellido2	VARCHAR2(100),
ciudad		VARCHAR2(100),
categoria	NUMBER(10),
CONSTRAINT PK_cliente PRIMARY KEY(id)
);

CREATE TABLE pedido(
id				NUMBER(10),
cantidad		NUMBER(5,2),
fecha			DATE,
id_cliente		NUMBER(10),
id_comercial	NUMBER(10),
CONSTRAINT PK_pedido PRIMARY KEY (id),
CONSTRAINT FK_pedido FOREIGN KEY (id_cliente) REFERENCES cliente(id),
CONSTRAINT FK_pedido_2 FOREIGN KEY (id_comercial) REFERENCES comercial(id)
);

--Ejercicio3
CREATE TABLE persona(
id					NUMBER(10),
nif					VARCHAR2(9),
nombre				VARCHAR2(25),
apellido1			VARCHAR2(50),
apellido2			VARCHAR2(50),
cidudad				VARCHAR2(25),
direccion			VARCHAR2(50),
telefono			VARCHAR2(9),
fecha_nacimiento	DATE,
sexo				VARCHAR2(1),
tipo				NUMBER(3),
CONSTRAINT PK_persona PRIMARY KEY(id)
);

CREATE TABLE departamento(
id			NUMBER(10),
nombre		VARCHAR2(50),
CONSTRAINT PK_departamento PRIMARY KEY(id)
);

CREATE TABLE profesor(
id_profesor			NUMBER(10),
id_departamento		NUMBER(10),
CONSTRAINT PK_profesor PRIMARY KEY (id_profesor),
CONSTRAINT FK_profesor FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

CREATE TABLE grado(
id			NUMBER(10),
nombre		VARCHAR2(100),
CONSTRAINT PK_grado PRIMARY KEY(id)
);

CREATE TABLE asignatura(
id				NUMBER(10),
nombre			VARCHAR2(100),
creditos		NUMBER(5,2),
tipo			VARCHAR2(30),
curso			NUMBER(3),
cuatrimestre	NUMBER(3),
id_profesor		NUMBER(10),
id_grado		NUMBER(10),
CONSTRAINT PK_asignatura PRIMARY KEY(id),
CONSTRAINT FK_asignatura FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor),
CONSTRAINT FK_asignatura_2 FOREIGN KEY(id_grado) REFERENCES grado(id),
CONSTRAINT CK_asignatura__tipo CHECK(curso IN ('A','C'))
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
id_curso_escolar	NUMBER(10),
CONSTRAINT PK_alumno_mat_asg PRIMARY KEY(id_alumno,id_asignatura,id_curso_escolar),
CONSTRAINT FK_alumno_mat_asg_1 FOREIGN KEY (id_alumno) REFERENCES persona(id),
CONSTRAINT FK_alumno_mat_asg_2 FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
CONSTRAINT FK_alumno_mat_asg_3 FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);

-- Ejercicio 4














