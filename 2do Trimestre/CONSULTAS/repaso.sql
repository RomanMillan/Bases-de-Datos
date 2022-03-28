alter session set "_oracle_script"=true;  
create user refuerzo identified by refuerzo;
GRANT CONNECT, RESOURCE, DBA TO refuerzo;

-- Creación de tablas

CREATE TABLE depart(
dept_no		VARCHAR2(4),
dnombre		VARCHAR2(30),
loc			VARCHAR2(30),
CONSTRAINT PK_depart PRIMARY KEY(dept_no)
);

CREATE TABLE emple(
emp_no		VARCHAR2(4),
apellido	VARCHAR2(30),
oficio		VARCHAR2(30),
dir			VARCHAR2(4),
fecha_alt	DATE,
salario		NUMBER(10,1),
comision	NUMBER(10,1),
dep_no		VARCHAR2(4),
CONSTRAINT PK_emple PRIMARY KEY(emp_no),
CONSTRAINT FK_emple FOREIGN KEY(dep_no) REFERENCES depart(dept_no)
);

-- Añadir datos tablas

INSERT INTO depart VALUES('10','contabilidad','sevilla');
INSERT INTO depart VALUES('20','investigacion','madrid');
INSERT INTO depart VALUES('30','ventas','barcelona');
INSERT INTO depart VALUES('40','producción','bilbao');

INSERT INTO emple VALUES('7369','sánchez','empleado','7902',TO_DATE('17/12/1980','DD/MM/YYYY'),104000,NULL,'20');
INSERT INTO emple VALUES('7499','arroyo','vendedor','7698',TO_DATE('20/02/1980','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7521','sala','vendedor','7698',TO_DATE('22/02/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7566','jiménez','director','7839',TO_DATE('02/04/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7654','martín','vendedor','7698',TO_DATE('29/09/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7698','negro','director','7839',TO_DATE('01/05/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7788','gil','analista','7566',TO_DATE('01/05/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7839','rey','presidente',NULL,TO_DATE('09/11/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7844','tovar','vendedor','7698',TO_DATE('17/11/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7876','alonso','empleado','7788',TO_DATE('23/09/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7900','jimeno','empleado','7698',TO_DATE('03/12/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7902','fernández','analista','7566',TO_DATE('03/12/1981','DD/MM/YYYY'),,,'');
INSERT INTO emple VALUES('7934','muñoz','empleado','7782',TO_DATE('23/01/1982','DD/MM/YYYY'),,,'');



