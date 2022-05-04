--Boletin Cursores BD Jardineria
/*
 * 1.- Desarrollar un procedimiento que visualice el nombre, apellidos y puesto
de todos los empleados, ordenados por primer apellido.
 */

CREATE OR REPLACE
PROCEDURE ej1
AS
	CURSOR c_empleado IS
	SELECT emp.NOMBRE nom, emp.APELLIDO1 ap1, emp.APELLIDO2  ap2, emp.PUESTO puesto
	FROM EMPLEADO emp;
BEGIN
	FOR i IN c_empleado LOOP
		DBMS_OUTPUT.PUT_LINE('nombre: '||i.nom || ' apellidos: ' || i.ap1 ||' '
		||i.ap2 ||' puesto: ' ||i.puesto);
	END LOOP;
	
END;

BEGIN
	ej1();	
END;

/*
 * 2.- Desarrollar un procedimiento que muestre el código de cada oficina
 *  y el número de empleados que tiene.
 * */

CREATE OR REPLACE
PROCEDURE ej2
AS
	CURSOR c_numEmp IS
	SELECT o.CODIGO_OFICINA cod, COUNT(e.CODIGO_EMPLEADO) num_empl
	FROM OFICINA o, EMPLEADO e  
	WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA
	GROUP BY o.CODIGO_OFICINA;
BEGIN
	FOR i IN c_numEmp LOOP
		DBMS_OUTPUT.PUT_LINE('Codigo: '|| i.cod || ' numero empleado: '||i.num_empl);	
	END LOOP;
END;

BEGIN
	ej2();
END;

/*
 * 3.- Desarrollar un procedimiento que reciba como parámetro una cadena de
 * texto y muestre el código de cliente y nombre de cliente de todos los
 * clientes cuyo nombre contenga la cadena especificada. Al finalizar debe
 * mostrar el número de clientes mostrados.
 * */

CREATE OR REPLACE
PROCEDURE ej3(nombre_c VARCHAR2)
AS
	CURSOR c_cliente IS 
	SELECT c.CODIGO_CLIENTE codigo, c.NOMBRE_CLIENTE nombre
	FROM CLIENTE c 
	WHERE UPPER(c.NOMBRE_CLIENTE) LIKE UPPER(nombre_c);	
	error EXCEPTION;
BEGIN
	
	FOR i IN c_cliente LOOP
		DBMS_OUTPUT.PUT_LINE('Codigo: ' ||i.codigo||' nombre: ' ||i.nombre);	
	end LOOP;
	
	IF SQL%NOTFOUND THEN
		RAISE error;
	END IF;

	EXCEPTION
	WHEN error THEN
	DBMS_OUTPUT.PUT_LINE('Datos no encontrado');
END;

BEGIN
	ej3('Lasas S.A.');	
END;

/*
 * 4.- Escribir un programa que muestre el código de producto, nombre 
 * y gama de los 5 productos más vendidos.
 * */
























