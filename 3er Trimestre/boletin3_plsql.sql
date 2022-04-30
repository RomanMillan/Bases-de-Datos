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
BEGIN
    FOR i IN c_empleados LOOP
        DBMS_OUTPUT.PUT_LINE(i.empno ||' '|| i.ename ||' '||  i.job|| ' '|| i.mgr 
        || ' '|| i.hiredate || ' '|| i.sal || ' '|| i.comm || ' '|| i.deptno);
    END LOOP;
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
    MostrarJefes('Sales');
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
    ej6();
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
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Numero de departamento no encontrado');
    WHEN exception_sin_datos THEN
        DBMS_OUTPUT.PUT_LINE('El departamento buscado no tiene empleados');
END;

BEGIN
   HallarNumEmp('sales'); 
END;