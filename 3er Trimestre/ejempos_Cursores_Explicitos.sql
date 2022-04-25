

--1
CREATE OR REPLACE 
PROCEDURE listarEmpleados
AS
	CURSOR c_Empleados IS
	SELECT * 
	FROM EMPLEADOS 
	WHERE UPPER(empleados.NOMEM) LIKE '%A%';
BEGIN
	FOR i IN c_Empleados LOOP
    	DBMS_OUTPUT.PUT_LINE('nombre: ' || i.nomem);
   		DBMS_OUTPUT.PUT_LINE('sueldo: ' || i.salar);
  	END LOOP;
END;

BEGIN
    listarEmpleados();
END;


--2
CREATE OR REPLACE 
PROCEDURE listarEmpleados2
AS
	CURSOR c_Empleados IS
	SELECT * 
	FROM EMPLEADOS 
	WHERE UPPER(empleados.NOMEM) LIKE '%A%';
	i c_Empleados%ROWTYPE;
BEGIN
	OPEN c_Empleados;
	LOOP
		FETCH c_Empleados INTO i;
		EXIT WHEN c_Empleados%NOTFOUND;
		DBMS_OUTPUT.PUT_LINE('nombre: ' || i.nomem);
   		DBMS_OUTPUT.PUT_LINE('sueldo: ' || i.salar);
	END LOOP;
	CLOSE c_Empleados;
	
END;

BEGIN
    listarEmpleados2();
END;






