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


