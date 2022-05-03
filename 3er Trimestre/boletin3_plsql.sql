-- Boletin 3
/*1.
Realiza un procedimiento que reciba un número de departamento y muestre por pantalla su
nombre y localidad
*/

CREATE OR REPLACE 
PROCEDURE ej1 (num NUMBER)
AS
    nombre DEPT.DNAME%TYPE;
    localidad DEPT.LOC%TYPE;
BEGIN
    SELECT DEPT.DNAME, DEPT.LOC 
    INTO nombre, localidad
    FROM DEPT 
    WHERE DEPT.DEPTNO =num;
    DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre || ' Localidad: ' || localidad);
END;

BEGIN
    ej1(20);
END;

/*2.
Realiza una función devolver_sal que reciba un nombre de departamento y devuelva la suma
de sus salarios.
*/
CREATE OR REPLACE
FUNCTION devolver_sal(nombre DEPT.DNAME%TYPE)
RETURN NUMBER
AS
    suma_salario EMP.SAL%TYPE;
BEGIN
    SELECT SUM(EMP.SAL)
    INTO suma_salario
    FROM DEPT, EMP 
    WHERE DEPT.DEPTNO = EMP.DEPTNO
    AND UPPER(DEPT.DNAME) LIKE UPPER(nombre);
    RETURN suma_salario;
   	
   	EXCEPTION 
   	WHEN NO_DATA_FOUND THEN
   		DBMS_OUTPUT.PUT_LINE('DATOS NO ENCONTRADOS');
END;

SELECT devolver_sal('Research') FROM DUAL;

/*3.
Realiza un procedimiento MostrarAbreviaturas que muestre las tres primeras letras del
nombre de cada empleado.
*/
CREATE OR REPLACE 
PROCEDURE MostrarAbreviaturas
AS
    CURSOR c_nombre IS
    SELECT SUBSTR(EMP.ENAME,0,3) primero
    FROM EMP;
BEGIN
    FOR i IN c_nombre LOOP
        DBMS_OUTPUT.PUT_LINE(i.primero);
    END LOOP;
END;

BEGIN
    MostrarAbreviaturas();
END;

--SELECT INDEPENDIENTE (PRUEBA)
SELECT SUBSTR(EMP.ENAME,0,3)FROM EMP;

/*4.
Realiza un procedimiento que reciba un número de departamento y muestre una lista de sus
empleados.
*/
CREATE OR REPLACE 
PROCEDURE ej4(depart NUMBER)
AS
    CURSOR c_empleados IS
    SELECT * 
    FROM EMP 
    WHERE EMP.DEPTNO = depart;
   	num NUMBER;
BEGIN
    SELECT deptno  INTO num FROM dept WHERE deptno = depart;
	
   FOR i IN c_empleados LOOP
        DBMS_OUTPUT.PUT_LINE(i.empno ||' '|| i.ename ||' '||  i.job|| ' '|| i.mgr 
        || ' '|| i.hiredate || ' '|| i.sal || ' '|| i.comm || ' '|| i.deptno);
    END LOOP;
	EXCEPTION
	WHEN NO_DATA_FOUND THEN
	DBMS_OUTPUT.PUT_LINE('datos no encontrados');
   
   END;

BEGIN
    ej4(20);
END; 

/*5.
Realiza un procedimiento MostrarJefes que reciba el nombre de un departamento y muestre
los nombres de los empleados de ese departamento que son jefes de otros empleados.
Trata las excepciones que consideres necesarias.
*/

CREATE OR REPLACE 
PROCEDURE MostrarJefes(depart VARCHAR2)
AS
    CURSOR c_jefe IS
    SELECT  empleado.ENAME jefe
    FROM DEPT, EMP empleado, EMP jefe 
    WHERE DEPT.DEPTNO = empleado.DEPTNO
    AND empleado.MGR = jefe.EMPNO
    AND UPPER(DEPT.DNAME) LIKE UPPER(depart);
BEGIN
    FOR i IN c_jefe LOOP
        DBMS_OUTPUT.PUT_LINE(i.jefe);
    END LOOP;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
         DBMS_OUTPUT.PUT_LINE('Datos no encontrado');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado.');
END;

BEGIN
    MostrarJefes('Accounting ');
END;


/*6
Hacer un procedimiento que muestre el nombre y el salario del empleado cuyo código es
7082 
*/

CREATE OR REPLACE 
PROCEDURE ej6
AS
    nombre EMP.ENAME%TYPE;
    salario EMP.SAL%TYPE;
BEGIN
    SELECT EMP.ENAME, EMP.SAL
    INTO nombre, salario
    FROM EMP 
    WHERE EMP.EMPNO = 7082;
     DBMS_OUTPUT.PUT_LINE('nombre: ' || nombre || ' salario: ' || salario);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('Trabajador no encontrado');
END;

BEGIN
    ej6(7082);
END;

/*
7. Realiza un procedimiento llamado HallarNumEmp que recibiendo un nombre de
departamento, muestre en pantalla el número de empleados de dicho departamento

Si el departamento no tiene empleados deberá mostrar un mensaje informando de ello. 
Si el departamento no existe se tratará la excepción correspondiente
*/
CREATE OR REPLACE 
PROCEDURE HallarNumEmp(nom_dept VARCHAR2)
AS
    num_emp NUMBER;
    exception_sin_datos EXCEPTION;
BEGIN
    SELECT COUNT(EMP.EMPNO) 
    INTO num_emp
    FROM EMP,DEPT 
    WHERE DEPT.DEPTNO = EMP.DEPTNO 
    AND UPPER(DEPT.DNAME) LIKE UPPER(nom_dept);
    
    IF(num_emp =0) THEN
        RAISE exception_sin_datos;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Numero de empleados: ' || num_emp);
    END IF;
    
    EXCEPTION
    WHEN exception_sin_datos THEN
        DBMS_OUTPUT.PUT_LINE('El departamento buscado no tiene empleados');
END;

BEGIN
   HallarNumEmp('operation'); 
END;

/*
 *8. Hacer un procedimiento que reciba como parámetro un código de empleado y 
 *devuelva su nombre 
 * */
CREATE OR REPLACE 
PROCEDURE ej8(cod NUMBER)
AS
	nombre emp.ename%TYPE;
BEGIN
	SELECT ename
	INTO nombre
	FROM emp
	WHERE empno = cod;
	
	DBMS_OUTPUT.PUT_LINE('Nombre: ' || nombre);
END;

BEGIN
	ej8(7900);
END;

/*
 * 9. Codificar un procedimiento que reciba una cadena y la visualice al revés.
 * */

CREATE OR REPLACE 
PROCEDURE ej9(cadena VARCHAR2)
AS
	cadena_re VARCHAR2(100);
BEGIN
	FOR i IN REVERSE 1..LENGTH(cadena) LOOP
		cadena_re := cadena_re || SUBSTR(cadena,i,1);
	end LOOP;
	DBMS_OUTPUT.PUT_LINE(cadena_re);
END;

BEGIN
	ej9('hola a todos');
END;

/*
 * 10. Escribir un procedimiento que reciba una fecha y escriba el año, en número, 
 * correspondiente a esa fecha
 * */
CREATE OR REPLACE 
PROCEDURE ej10(fecha DATE)
AS
	anio VARCHAR2(20);
BEGIN
	anio := EXTRACT(YEAR FROM fecha);
	DBMS_OUTPUT.PUT_LINE(anio);
END;

BEGIN
	ej10(sysdate);
END;

/*
 * 11. Realiza una función llamada CalcularCosteSalarial que reciba un nombre de
 *  departamento y devuelva la suma de los salarios y comisiones de los empleados 
 * de dicho departamento
 * */
CREATE OR REPLACE 
PROCEDURE CalcularCosteSalarial(nom_dept VARCHAR2)
AS
    total NUMBER(10);
    no_datos EXCEPTION;
BEGIN
	SELECT (SUM(emp.SAL) + SUM(emp.COMM)) suma_total
	INTO total
    FROM emp, DEPT
    WHERE emp.DEPTNO = DEPT.DEPTNO
    AND UPPER(DEPT.DNAME) LIKE UPPER(nom_dept);
    IF(total IS NULL)THEN
        RAISE no_datos;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Salario + comisiones: ' || total);
    END IF;
    EXCEPTION
    WHEN no_datos THEN
        DBMS_OUTPUT.PUT_LINE('Datos no encontrados');
END;

BEGIN
    CalcularCosteSalarial('sales');
END;

/*
12. Codificar un procedimiento que permita borrar un empleado cuyo número 
se pasará en la llamada. 
Si no existiera dar el correspondiente mensaje de error.
*/

CREATE OR REPLACE 
PROCEDURE borrarEmpleado(num_empl NUMBER)
AS
    prueba NUMBER(10);
BEGIN
    -- para que la exception salte si el num_emple no es encontrado.
    SELECT EMP.EMPNO INTO prueba FROM emp WHERE emp.EMPNO = num_empl;
     
    DELETE FROM emp 
    WHERE emp.EMPNO = num_empl;
    
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Datos no encontrados');
END;

BEGIN
    borrarEmpleado(2550);
END;

/*
13. Realiza un procedimiento MostrarCostesSalariales que muestre los 
nombres de todos los departamentos y el coste salarial de cada uno de ellos
*/

CREATE OR REPLACE 
PROCEDURE MostrarCostesSalariales
AS
    CURSOR c_coste IS
    SELECT DEPT.DNAME, SUM(NVL(EMP.SAL,0)) coste_salarial
    FROM EMP, DEPT
    WHERE DEPT.DEPTNO = EMP.DEPTNO(+)
    GROUP BY DEPT.DNAME;
BEGIN
    FOR i IN c_coste LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre Depart: ' || i.dname 
        || ' Coste salarial: ' || i.coste_salarial);
    END LOOP;
END;

BEGIN
    MostrarCostesSalariales();
END;

-- select independiente
SELECT DEPT.DNAME, SUM(NVL(EMP.SAL,0)) coste_salarial
FROM EMP, DEPT
WHERE DEPT.DEPTNO = EMP.DEPTNO(+)
GROUP BY DEPT.DNAME;

/*
14. Escribir un procedimiento que modifique la localidad de un departamento.
 El procedimiento recibirá como parámetros el número del departamento 
 y la localidad nueva.
*/

CREATE OR REPLACE 
PROCEDURE ej14(num_dept NUMBER, nue_nom VARCHAR2)
AS
BEGIN
    UPDATE dept 
    SET dept.LOC = UPPER(nue_nom) 
    WHERE dept.DEPTNO = num_dept;
END;

BEGIN
    ej14(40, 'Sevilla');
END;

/*
15. Realiza un procedimiento MostrarMasAntiguos que muestre el nombre del 
empleado más antiguo de cada departamento junto con el nombre del departamento. 
Trata las excepciones que consideres necesarias.
*/
CREATE OR REPLACE 
PROCEDURE MostrarMasAntiguos
AS
BEGIN

END;

SELECT DEPT.DNAME, emp.ENAME
FROM emp, DEPT
WHERE DEPT.DEPTNO = emp.DEPTNO
GROUP BY emp.DEPTNO, ;
