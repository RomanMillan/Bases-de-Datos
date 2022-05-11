--Boletin 4- paquetes y Excepciones

/*
 *1. Desarrolla el paquete ARITMETICA cuyo código fuente viene en este tema.
Crea un archivo para la especi(cación y otro para el cuerpo. Realiza varias pruebas
para comprobar que las llamadas a funciones y procedimiento funcionan
correctamente.
 */

CREATE OR REPLACE 
PACKAGE aritmetica IS 
  version NUMBER := 1.0;
	PROCEDURE mostrar_info;
	FUNCTION suma 		(a NUMBER, b number)RETURN NUMBER;
	FUNCTION resta 		(a NUMBER, b number)RETURN NUMBER;
	FUNCTION multiplica (a NUMBER, b number)RETURN NUMBER;
	FUNCTION divide 	(a NUMBER, b number)RETURN NUMBER;
END;

CREATE OR REPLACE
PACKAGE BODY aritmetica IS
 -- procedure mostrar info
  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;
  --function suma
  FUNCTION suma(a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a+b);
  END suma;
--function resta
  FUNCTION resta(a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a-b);
  END resta;
--function multiplica
  FUNCTION multiplica (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a*b);
  END multiplica;
--function divide
  FUNCTION divide (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a/b);
  END divide;
END;


/*
 * 2 Al paquete anterior añade una función llamada RESTO que reciba dos
parámetros, el dividendo y el divisor, y devuelva el resto de la división.
 * */

CREATE OR REPLACE 
PACKAGE aritmetica IS 
version NUMBER := 1.0;
	PROCEDURE mostrar_info;
	FUNCTION suma 		(a NUMBER, b number)RETURN NUMBER;
	FUNCTION resta 		(a NUMBER, b number)RETURN NUMBER;
	FUNCTION multiplica (a NUMBER, b number)RETURN NUMBER;
	FUNCTION divide 	(a NUMBER, b number)RETURN NUMBER;
	FUNCTION resto 		(a NUMBER, b number)RETURN NUMBER;
END;

CREATE OR REPLACE
PACKAGE BODY aritmetica IS
 -- procedure mostrar info
  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;
  --function suma
  FUNCTION suma(a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a+b);
  END suma;
--function resta
  FUNCTION resta(a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a-b);
  END resta;
--function multiplica
  FUNCTION multiplica (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a*b);
  END multiplica;
--function divide
  FUNCTION divide (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a/b);
  END divide;
  --fuction resto
  FUNCTION resto (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN MOD(a,b);
  END resto;
END;


/*
5.6.3. Al paquete anterior añade un procedimiento sin parámetros llamado AYUDA
que muestre un mensaje por pantalla de los procedimientos y funciones disponibles
en el paquete, su utilidad y forma de uso.
*/

CREATE OR REPLACE 
PACKAGE aritmetica IS 
version NUMBER := 1.0;
	PROCEDURE mostrar_info;
	FUNCTION suma 		(a NUMBER, b number)RETURN NUMBER;
	FUNCTION resta 		(a NUMBER, b number)RETURN NUMBER;
	FUNCTION multiplica (a NUMBER, b number)RETURN NUMBER;
	FUNCTION divide 	(a NUMBER, b number)RETURN NUMBER;
	FUNCTION resto 		(a NUMBER, b number)RETURN NUMBER;
	PROCEDURE ayuda;
END;

CREATE OR REPLACE
PACKAGE BODY aritmetica IS
 -- procedure mostrar info
  PROCEDURE mostrar_info IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE
      ('Paquete de operaciones aritméticas. Versión ' || version);
  END mostrar_info;
  --function suma
  FUNCTION suma(a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a+b);
  END suma;
--function resta
  FUNCTION resta(a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a-b);
  END resta;
--function multiplica
  FUNCTION multiplica (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a*b);
  END multiplica;
--function divide
  FUNCTION divide (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN (a/b);
  END divide;
  --fuction resto
  FUNCTION resto (a NUMBER, b NUMBER) 
  RETURN NUMBER 
  IS
  BEGIN
    RETURN MOD(a,b);
  END resto; 
  --Procedure ayuda
  PROCEDURE ayuda IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Información del paquete ARITMETICA:');
    DBMS_OUTPUT.PUT_LINE('Mostrar Info: Procedimiento que muestra descripcion del paquete y version.');
    DBMS_OUTPUT.PUT_LINE('Suma: Funcion que suma. Introducir los dos num a sumar.');
    DBMS_OUTPUT.PUT_LINE('Resta: Funcion que resta. Introducir los dos num a restar.');
    DBMS_OUTPUT.PUT_LINE('Multiplica: Funcion que multiplica. Introducir los dos num a multiplicar.');
    DBMS_OUTPUT.PUT_LINE('Divide: Funcion que divide. Introducir los dos num a dividir.');
    DBMS_OUTPUT.PUT_LINE('Resto: Funcion que muestra el resto. Introducir los dos num a dividir y muestre su resto.');
    DBMS_OUTPUT.PUT_LINE('Ayuda: Procedimiento que muestra información detallada del paquete ARITMETICA');
  END ayuda;
END;


BEGIN
    ARITMETICA.AYUDA;
END;

/*
4 Desarrolla el paquete GESTION. En un principio tendremos los
procedimientos para gestionar los departamentos. Dado el archivo de
especi(cación mostrado más abajo crea el archivo para el cuerpo. 
Realiza varias pruebas para comprobar que las llamadas a funciones y 
procedimientos funcionan correctamente.
*/

CREATE TABLE departamento(
    numero_dep      NUMBER(5),
    nombre_dep      VARCHAR2(40),
    presupuesto_dep     NUMBER(10,2),
    CONSTRAINT PK_departamento PRIMARY KEY(numero_dep)
);

CREATE SEQUENCE incrementar
   MINVALUE 1
   START WITH 1
   INCREMENT BY 1;

CREATE OR REPLACE
PACKAGE GESTION AS
 PROCEDURE CREAR_DEP (nombre VARCHAR2, presupuesto NUMBER);
 FUNCTION NUM_DEP (nombre VARCHAR2) RETURN NUMBER;
 PROCEDURE MOSTRAR_DEP (numero NUMBER);
 PROCEDURE BORRAR_DEP (numero NUMBER);
 PROCEDURE MODIFICAR_DEP (numero NUMBER, presupuesto NUMBER);
END GESTION;

CREATE OR REPLACE
PACKAGE BODY gestion IS
  PROCEDURE CREAR_DEP (nombre varchar2, presupuesto number)
  IS
  BEGIN
        INSERT INTO departamento(numero_dep, nombre_dep, presupuesto_dep) 
        VALUES (incrementar.nextval, nombre, presupuesto);
  END;

FUNCTION NUM_DEP(nombre VARCHAR2) 
  RETURN NUMBER 
  IS
    num NUMBER(10);
  BEGIN
    SELECT d.NUMERO_DEP
    INTO num
    FROM departamento d
    WHERE UPPER(d.NOMBRE_DEP) LIKE UPPER(nombre);
    RETURN num;
  END NUM_DEP;
  
  PROCEDURE MOSTRAR_DEP (numero NUMBER)
  IS
    nombre VARCHAR2(50);
    presupuesto NUMBER(10,2);
  BEGIN
      SELECT p.NOMBRE_DEP, p.PRESUPUESTO_DEP
      INTO nombre, presupuesto
      FROM DEPARTAMENTO p
      WHERE p.NUMERO_DEP = numero;
      DBMS_OUTPUT.PUT_LINE('Nombre: '||nombre ||' presupuesto: '||presupuesto);
  END;

  
  PROCEDURE BORRAR_DEP (numero NUMBER)
  IS
  BEGIN
        DELETE FROM DEPARTAMENTO d 
        WHERE d.NUMERO_DEP = numero;
  END;
  PROCEDURE MODIFICAR_DEP (numero NUMBER, presupuesto NUMBER)
  IS
  BEGIN
        UPDATE DEPARTAMENTO p
        SET p.PRESUPUESTO_DEP = presupuesto
        WHERE p.NUMERO_DEP = numero;
  END;
END;

begin
    GESTION.crear_dep('recursos',1000);
END;

BEGIN
    gestion.modificar_dep(2,5000);
END;