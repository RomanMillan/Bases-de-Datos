-- Ejercicio 7 Boletin 7.1


-- Tablas necesarias

CREATE TABLE empleados
(dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2(50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE,
CONSTRAINT FK_JEFE FOREIGN KEY (jefe) REFERENCES empleados (dni) );

CREATE TABLE controlCambios(
usuario varchar2(30),
fecha date,
tipooperacion varchar2(30),
datoanterior varchar2(30),
datonuevo varchar2(30)
);

/*
 * Ejercicio 7
Creamos otro trigger que se active cuando ingresamos un nuevo registro en "empleados",
debe almacenar en "controlCambios" el nombre del usuario que realiza el ingreso, la
fecha, el tipo de operación que se realiza , "null" en "datoanterior" (porque se dispara con
una inserción) y en "datonuevo" el valor del nuevo dato.
 * */

CREATE OR REPLACE
TRIGGER ej7
AFTER INSERT ON empleados
FOR EACH ROW
DECLARE
BEGIN
	INSERT INTO CONTROLCAMBIOS  
	VALUES (USER,sysdate,'Insert',NULL,:NEW.dni);
END;

--Insert de prueba
INSERT INTO empleados
VALUES ('11V','Sonia','14E',5,5000,'SM',TO_DATE('15/10/2010','DD/MM/YYYY'));
