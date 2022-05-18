
--1
/*Crear un trigger sobre la tabla EMPLEADOS para que no se permita que un empleado
sea jefe de más de cinco empleados.
 * */
CREATE OR REPLACE
TRIGGER ej1
BEFORE INSERT ON empleados
FOR EACH ROW
DECLARE
emple NUMBER(5);
BEGIN
	SELECT COUNT(emp.DNI)
	INTO emple
	FROM empleados emp, EMPLEADOS jefe
	WHERE emp.JEFE = JEFE.dni;

	IF emple <5THEN
		INSERT INTO EMPLEADOS (dni) 
		VALUES (:NEW.dni);
	ELSE
		raise_error(-20001; 'No puede haber un jefe con mas de 5 empleados');
	END IF;
END;

--2
/*
 * Crear un trigger para impedir que se aumente el salario de un empleado
 *  en más de un 20%.
 * */
CREATE OR REPLACE
TRIGGER ej2
BEFORE UPDATE ON empleados
FOR EACH ROW
DECLARE
	salarioAu NUMBER(10,2);
BEGIN
	SELECT e.SALARIO*1.2 sal
	INTO salarioAu
	FROM EMPLEADOS e 
	WHERE e.DNI = :NEW.dni;

	IF(salarioAu < :OLD.salario)THEN
		UPDATE EMPLEADOS 
		SET salario = :NEW.salario
		WHERE dni = :NEW.dni;
	END IF;
END;



--3
/*
 * Crear una tabla empleados_baja con la siguiente estructura
 * */
CREATE TABLE empleados_baja
( dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2 (50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE );

/*
 * Crear un trigger que inserte una fila en la tabla empleados_baja cuando 
 * se borre una fila en la tabla empleados. Los datos que se insertan son
 *  los del empleado que se da de baja en la tabla empleados, salvo en 
 * las columnas usuario y fecha se grabarán las variables del sistema 
 * USER y SYSDATE que almacenan el usuario y fecha actual
 * */




-- HACER HASTA EL 5 y en clase hacer hasta el 9






