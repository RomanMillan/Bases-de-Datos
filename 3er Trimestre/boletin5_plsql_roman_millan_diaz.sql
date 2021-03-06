-- Boletin 5: Ejercicios PL/SQL
/*
1. Crear un procedimiento que en la tabla emp incremente el salario el 10% a 
los empleados que tengan una comisión superior al 5% del salario. 
*/

CREATE OR REPLACE
PROCEDURE b5_ej1
AS
BEGIN
    UPDATE emp
    SET emp.SAL = emp.SAL*1.10
    WHERE emp.SAL*0.05 < emp.COMM; 
    DBMS_OUTPUT.PUT_LINE('Numero de filas actualizadas: '||SQL%ROWCOUNT); --para contar el numero de filas modificadas
    EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado');
END;

BEGIN
    b5_ej1();
END;

/*
2. Realiza un procedimiento MostrarMejoresVendedores que muestre los 
nombres de los dos vendedores/as con más comisiones.
*/

CREATE OR REPLACE 
PROCEDURE MostrarMejoresVendedores
AS
    CURSOR c_vendedores IS
    select ename
    from (select NVL(e.comm,0) comision, e.ENAME
          from emp e
          order by NVL(e.COMM,0) desc)
    where rownum<=2;
BEGIN
    FOR i IN c_vendedores LOOP
       DBMS_OUTPUT.PUT_LINE('Mejores vendedores: ' || i.ename);
    END LOOP;
END;

BEGIN
    MostrarMejoresVendedores();
END;


/*
3. Realiza un procedimiento MostrarsodaelpmE que reciba el nombre de un 
departamento al revés y muestre los nombres de los empleados de ese departamento.
*/

CREATE OR REPLACE
PROCEDURE MostrarsodaelpmE (depar varchar2)
AS
    palabraDe varchar2(10);
    
    CURSOR c_emp IS
    select e.ENAME nombre
    from DEPT p, EMP e
    WHERE e.DEPTNO = p.DEPTNO
    AND UPPER(p.DNAME) LIKE UPPER(palabraDe);
BEGIN
    FOR i IN REVERSE 1..length(depar) LOOP
        palabraDe := palabraDe || substr(depar,i,1);
    END LOOP;
    
    FOR e IN c_emp LOOP
        DBMS_OUTPUT.PUT_LINE('Nombre de empleado: '||e.nombre);
    END LOOP;
END;

BEGIN
    MostrarsodaelpmE('selas');
END;


/*
4. Realiza un procedimiento RecortarSueldos que recorte el sueldo un 20% a los 
empleados cuyo nombre empiece por la letra que recibe como parámetro. 
Trata las excepciones que consideres necesarias.
*/

CREATE OR REPLACE
PROCEDURE RecortarSueldos(letra varchar2)
AS
    error EXCEPTION;
BEGIN
    UPDATE emp e
    SET e.SAL = e.sal - (e.sal*0.20)
    --WHERE UPPER(substr(e.ENAME,1,1)) LIKE UPPER(letra);
   	WHERE UPPER(e.ENAME) LIKE UPPER(letra||'%');
    
    IF SQL%NOTFOUND THEN
        RAISE error;
    END IF;
    commit;
    
    EXCEPTION
    WHEN error THEN
        DBMS_OUTPUT.PUT_LINE('Datos no encontrados');
        rollback;
END;

BEGIN
    RecortarSueldos('n');
END;

/*
5. Realiza un procedimiento BorrarBecarios que borre a los dos empleados 
más nuevos de cada departamento.
*/

CREATE OR REPLACE
PROCEDURE BorrarBecarios
AS
	CURSOR c_depart IS
	SELECT DISTINCT e.DEPTNO dep
	FROM EMP e;
	
	CURSOR c_emple IS
	SELECT e.ENAME nom , e.HIREDATE 
	FROM emp e
	WHERE e.DEPTNO = num_dep
	AND rownum <= 2
	ORDER BY e.hiredate;
	
	num_dep NUMBER(5);
BEGIN
	FOR i IN c_depart LOOP
		num_dep := i.dep;
		FOR k IN c_emple LOOP
			DBMS_OUTPUT.PUT_LINE(k.nom);
		END LOOP;
	end LOOP;
	
    
END;

BEGIN
	BorrarBecarios();
END;



-- Pruebas
SELECT DISTINCT e.DEPTNO 
FROM EMP e;

SELECT e.ENAME , e.HIREDATE 
FROM emp e
WHERE e.DEPTNO = 20
AND rownum <= 2
ORDER BY e.hiredate;

delete from emp e
WHERE e.HIREDATE = (select MIN(e2.HIREDATE)
                FROM emp e2);
                
               
               