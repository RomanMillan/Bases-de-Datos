-- Ejercicio1
CREATE TABLE departamento(
codigo			INT(10),
nombre			VARCHAR(100),
presupuesto		DOUBLE,
CONSTRAINT PK_departamento PRIMARY KEY (codigo);
);

CREATE TABLE empleado(
codigo					INT(10),
nif						VARCHAR(9),
nombre					VARCHAR(100),
apellido1				VARCHAR(100),
apellido2				VARCHAR(100),
codigo_departamento		INT(10),
CONSTRAINT PK_empleado PRIMARY KEY(codigo),
CONSTRAINT FK_empleado FOREIGN KEY (codigo_departamento) REFERENCES departamento(codigo)
);

-- Ejercicio2
CREATE TABLE comercial(
id			INT(10),
nombre		VARCHAR(100),
apellido1	VARCHAR(100),
apellido2	VARCHAR(100),
ciudad		VARCHAR(100),
comision	FLOAT,
CONSTRAINT PK_comercial PRIMARY KEY(id)
);

CREATE TABLE cliente(
id			INT(10),
nombre		VARCHAR(100),
apellido1	VARCHAR(100),
apellido2	VARCHAR(100),
ciudad		VARCHAR(100),
categoria	INT(10),
CONSTRAINT PK_cliente PRIMARY KEY(id)
);

CREATE TABLE pedido(
id				INT(10),
cantidad		DOUBLE,
fecha			DATE,
id_cliente		INT(10),
id_comercial	INT(10),
CONSTRAINT PK_pedido PRIMARY KEY (id),
CONSTRAINT FK_pedido FOREIGN KEY (id_cliente) REFERENCES cliente(id),
CONSTRAINT FK_pedido FOREIGN KEY (id_comercial) REFERENCES comercial(id),
);

--Ejercicio3
CREATE TABLE persona(
id					INT(10),
nif					VARCHAR(9),
nombre				VARCHAR(25),
apellido1			VARCHAR(50),
apellido2			VARCHAR(50),
cidudad				VARCHAR(25),
direccion			VARCHAR(50),
telefono			VARCHAR(9),
fecha_nacimiento	DATE,
sexo				ENUM(1),
tipo				INT(3),
CONSTRAINT PK_persona PRIMARY KEY(id)
);

CREATE TABLE departamento(
id			INT(10),
nombre		VARCHAR(50),
CONSTRAINT PK_departamento PRIMARY KEY(id)
);

CREATE TABLE profesor(
id_profesor			INT(10),
id_departamento		INT(10)
CONSTRAINT PK_profesor PRIMARY KEY (id_profesor),
CONSTRAINT FK_profesor FOREIGN KEY (id_departamento) REFERENCES departamento(id)
);

CREATE TABLE grado(
id			INT(10),
nombre		VARCHAR(100),
CONSTRAINT PK_grado PRIMARY KEY(id)
);

CREATE TABLE asignatura(
id				INT(10),
nombre			VARCHAR2(100),
creditos		FLOAT,
tipo			ENUM(3),
curso			TINYINT(3),
cuatrimestre	TINYINT(3),
id_profesor		INT(10),
id_grado		INT(10),
CONSTRAINT PK_asignatura PRIMARY KEY(id),
CONSTRAINT FK_asignatura FOREIGN KEY(id_profesor) REFERENCES profesor(id_profesor),
CONSTRAINT FK_asignatura_2 FOREIGN KEY(id_grado) REFERENCES grado(id)
);

CREATE TABLE curso_escolar(
id				INT(10),
anyo_inicio		YEAR,
anyo_fin		YEAR,
CONSTRAINT PK_curso_escolar PRIMARY KEY(id)
);

CREATE TABLE alumno_se_matricula_asignatura(
id_alumno			INT(10),
id_asignatura		INT(10),
id_curso_escolar	INT(10),
CONSTRAINT PK_alumno_mat_asg PRIMARY KEY(id_alumno,id_asignatura,id_curso_escolar),
CONSTRAINT FK_alumno_mat_asg_1 FOREIGN KEY (id_alumno) REFERENCES persona(id),
CONSTRAINT FK_alumno_mat_asg_2 FOREIGN KEY (id_asignatura) REFERENCES asignatura(id),
CONSTRAINT FK_alumno_mat_asg_3 FOREIGN KEY (id_curso_escolar) REFERENCES curso_escolar(id)
);



