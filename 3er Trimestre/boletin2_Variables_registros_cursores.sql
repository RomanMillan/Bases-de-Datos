/*
 * 1. Escribe un procedimiento que muestre el número de empleados y el salario
mínimo, máximo y medio del departamento de FINANZAS. Debe hacerse
uso de cursores implícitos, es decir utilizar SELECT ... INTO.
 * 
 */



CREATE OR REPLACE 
PROCEDURE ej1
AS
c_empleado EMPLEADOS%ROWTYPE;
BEGIN
	SELECT COUNT(e.NUMEM) num , MIN(e.SALAR) maxs ,MAX(e.SALAR) mins, AVG(e.SALAR) media  
	FROM EMPLEADOS e , DEPARTAMENTOS d 
	WHERE d.NUMDE = e.NUMDE  
	AND UPPER(d.NOMDE) LIKE 'FINANZAS';
	DBMS_OUTPUT.PUT_LINE ('Num Empleados  : ' || c_empleado.num);
END;

BEGIN 
	ej1();
END;
