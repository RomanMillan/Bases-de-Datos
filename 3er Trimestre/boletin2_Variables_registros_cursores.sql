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
	FROM EMPLEADOS emp 
	WHERE emp.NUMHI > 2
	AND emp.SALAR < 2000; 
	
BEGIN

	FOR i IN c_salario LOOP
        
        DBMS_OUTPUT.PUT_LINE ('Codigo Empleado  : ' || i.numem);
		DBMS_OUTPUT.PUT_LINE ('Nombre Empleado  : ' || i.nomem);
		DBMS_OUTPUT.PUT_LINE ('Salario Anterior  : ' || i.salar);
		
		UPDATE EMPLEADOS e 
		SET e.salar = i.SALAR*1.10
		WHERE e.numem = i.numem;
	

		DBMS_OUTPUT.PUT_LINE ('Salario Final  : ' || i.salar);
		DBMS_OUTPUT.PUT_LINE ('__________________ ');
	END LOOP;
	COMMIT;
	
    EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Datos no encontrados');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado'); 
END;

BEGIN
    ej2();
END;


CREATE OR REPLACE 
PROCEDURE ej2
AS
	CURSOR c_Salario IS
	SELECT *
	FROM EMPLEADOS
	WHERE EMPLEADOS.NUMHI > 2
	AND EMPLEADOS.SALAR < 2000;
	 
	i c_Salario%ROWTYPE;
	
BEGIN
    OPEN c_Salario;
        LOOP
            FETCH c_Salario INTO i;
            EXIT WHEN c_Salario%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE ('Codigo Empleado  : ' || i.NUMEM);
            DBMS_OUTPUT.PUT_LINE ('Nombre Empleado  : ' || i.NOMEM);
            DBMS_OUTPUT.PUT_LINE ('Salario Anterior  : ' || i.salar);
            
            UPDATE EMPLEADOS e 
            SET e.salar = e.SALAR*1.10
            WHERE  e.numem = i.numem;
           	
           
            DBMS_OUTPUT.PUT_LINE ('Salario Final  : ' || i.SALAR*1.10);
            DBMS_OUTPUT.PUT_LINE ('__________________ ');

        END LOOP;
    CLOSE c_Salario;
   
    COMMIT; 
   EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Datos no encontrados');
        ROLLBACK;
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado');
    
END;

BEGIN
    ej2();
END;


SELECT e.SALAR*1.10  FROM EMPLEADOS e WHERE e.NUMHI > 2 AND e.SALAR <2800;
UPDATE EMPLEADOS e SET e.salar = e.SALAR*1.10 WHERE e.numem = 110;

/*
3. Escribe un procedimiento que reciba dos parámetros (número de
departamento, hijos). Deber. crearse un cursor explícito al que se le pasarán
estos parámetros y que mostrar. los datos de los empleados que pertenezcan
al departamento y con el número de hijos indicados. Al final se indicar. el
número de empleados obtenidos
*/
CREATE OR REPLACE 
PROCEDURE ej3(num_dept NUMBER, hijos NUMBER)
AS
	CURSOR c_empleados(num_dept NUMBER, hijos NUMBER) IS
	SELECT *
	FROM EMPLEADOS
	WHERE EMPLEADOS.NUMHI = hijos
	AND empleados.NUMDE = num_dept;
	 
	i c_empleados%ROWTYPE;
	num_emp_obtenidos NUMBER(5) := 0;
BEGIN
	OPEN c_empleados(num_dept, hijos);
        LOOP
            FETCH c_empleados INTO i;
            EXIT WHEN c_empleados%NOTFOUND;
           
           num_emp_obtenidos := num_emp_obtenidos + 1;
           END LOOP;
          DBMS_OUTPUT.PUT_LINE('EL numero de empleados : ' || num_emp_obtenidos);
    CLOSE c_empleados;
END;


BEGIN
    ej3(121,3);
END;



/*
4. Escribe un procedimiento con un parámetro para el nombre de empleado,
que nos muestre la edad de dicho empleado en años, meses y días.
*/
CREATE OR REPLACE 
PROCEDURE ej4(nombre VARCHAR2)
AS
	CURSOR c_empleados IS
	SELECT *
	FROM EMPLEADOS
	WHERE EMPLEADOS.NOMEM = nombre;
	i c_empleados%ROWTYPE;
    
	fecha_na empleados.FECNA%TYPE;
	fecha_act DATE;
    meses_t NUMBER;
    anios NUMBER;
    meses NUMBER;
    dias NUMBER;
BEGIN
    fecha_act := sysdate;
	OPEN c_empleados;
        LOOP
        	FETCH c_empleados INTO i;
            EXIT WHEN c_empleados%NOTFOUND;
            fecha_na := i.fecna;
            meses_t := MONTHS_BETWEEN(fecha_act, fecha_na);
            anios := TRUNC(meses_t/12);
            meses := TRUNC(mod(meses_t,12));
            dias := TRUNC(fecha_act-ADD_MONTHS(fecha_na,TRUNC(meses_t)));
            
            DBMS_OUTPUT.PUT_LINE('Años: ' || anios || ' meses: ' || meses || ' dias: ' || dias);
        END LOOP;
    CLOSE c_empleados;    
END;


BEGIN
    ej4('MARCOS');
END;








