/*
 * 1. Escribe un procedimiento que muestre el número de empleados y el salario
mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
uso de cursores implícitos, es decir utilizar SELECT ... INTO.
 * 
 */

CREATE OR REPLACE 
PROCEDURE ej1
AS
    v_num NUMBER(5);
    v_maxi NUMBER(5);
    v_mini NUMBER(5);
    v_media NUMBER(5);
BEGIN
	SELECT COUNT(e.NUMEM) num , MIN(e.SALAR) mini ,MAX(e.SALAR) maxi, AVG(e.SALAR) media  
	INTO v_num, v_mini, v_maxi, v_media
	FROM EMPLEADOS e , DEPARTAMENTOS d 
	WHERE d.NUMDE = e.NUMDE  
	AND UPPER(d.NOMDE) LIKE 'FINANZAS';
	
	DBMS_OUTPUT.PUT_LINE ('Num Empleados  : ' || v_num);
	DBMS_OUTPUT.PUT_LINE ('Salario maximo : ' || v_maxi);
	DBMS_OUTPUT.PUT_LINE ('Salario minimo : ' || v_mini);
	DBMS_OUTPUT.PUT_LINE ('Media salario  : ' || v_media);

	EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE ('No se ha encontrado datos');
END;

BEGIN 
	ej1();
END;


/*
2. Escribe un procedimiento que suba un 10% el salario a los EMPLEADOS
con más de 2 hijos y que ganen menos de 2000 €. Para cada empleado se
mostrar por pantalla el código de empleado, nombre, salario anterior y final.
Utiliza un cursor explícito. La transacción no puede quedarse a medias. Si
por cualquier razón no es posible actualizar todos estos salarios, debe
deshacerse el trabajo a la situación inicial
*/
CREATE OR REPLACE 
PROCEDURE ej2
AS
	CURSOR c_salario IS
	SELECT *
	FROM EMPLEADOS e 
	WHERE e.NUMHI > 2
	AND e.SALAR < 2000; 
	salarAnt NUMBER(5);
	
BEGIN

	FOR i IN c_salario LOOP
		salarAnt := i.salar;	
	
		UPDATE EMPLEADOS e 
		SET e.salar = e.SALAR*1.10
		WHERE e.numen = i.numen;
	
		DBMS_OUTPUT.PUT_LINE ('Codigo Empleado  : ' || i.numen);
		DBMS_OUTPUT.PUT_LINE ('Nombre Empleado  : ' || i.nomen);
		DBMS_OUTPUT.PUT_LINE ('Nombre Empleado  : ' || salarAnt);
	END LOOP;
END;

SELECT e.SALAR*1.10,  FROM EMPLEADOS e WHERE e.NUMHI > 2;
UPDATE EMPLEADOS e SET e.salar = e.SALAR*1.10 WHERE e.numen = 110;

/*
3. Escribe un procedimiento que reciba dos parámetros (número de
departamento, hijos). Deber. crearse un cursor explícito al que se le pasarán
estos parámetros y que mostrar. los datos de los empleados que pertenezcan
al departamento y con el número de hijos indicados. Al final se indicar. el
número de empleados obtenidos
*/

/*
4. Escribe un procedimiento con un parámetro para el nombre de empleado,
que nos muestre la edad de dicho empleado en años, meses y días.
*/