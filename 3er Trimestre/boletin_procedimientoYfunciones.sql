--1 Crea un procedimiento llamado ESCRIBE para mostrar por pantalla el
--mensaje HOLA MUNDO
CREATE OR REPLACE 
PROCEDURE escribe
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Hola Mundo');
END;

BEGIN
	escribe;
END;

/*2 Crea un procedimiento llamado ESCRIBE_MENSAJE que tenga un
parámetro de tipo VARCHAR2 que recibe un texto y lo muestre por pantalla.
La forma del procedimiento ser. la siguiente:
ESCRIBE_MENSAJE (mensaje VARCHAR2)
*/

CREATE OR REPLACE
PROCEDURE escribe_mensaje (texto VARCHAR)
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE(texto);
END;

BEGIN
	escribe_mensaje ('sufiendo con plsql');
END;

/*3. Crea un procedimiento llamado SERIE que muestre por pantalla una serie de
números desde un mínimo hasta un máximo con un determinado paso. La
forma del procedimiento ser. la siguiente:
	SERIE (minimo NUMBER, maximo NUMBER, paso NUMBER)
 * */

CREATE OR REPLACE
PROCEDURE serie (minimo NUMBER,maximo NUMBER, paso NUMBER)
AS
minimoAsumar NUMBER(5);

BEGIN
	minimoAsumar := minimo;
	WHILE minimoAsumar < maximo LOOP
		DBMS_OUTPUT.PUT_LINE(minimoAsumar);
	minimoAsumar := minimoAsumar + paso;
	END LOOP;
END;

BEGIN
	serie (1,10, 2);
END;

/*
 * 4. Crea una función AZAR que reciba dos parámetros y genere un número al
azar entre un mínimo y máximo indicado. La forma de la función será la
siguiente:
		AZAR (minimo NUMBER, maximo NUMBER) RETURN NUMBER
 * */

CREATE OR REPLACE
FUNCTION azar (minimo NUMBER, maximo NUMBER)
RETURN NUMBER
IS
BEGIN
  RETURN MOD(ABS(DBMS_RANDOM.RANDOM),maximo)+minimo;
END;

SELECT azar(1,10) num_azar
FROM DUAL;

/*
 * 5. Crea una función NOTA que reciba un parámetro que será una nota numérica
entre 0 y 10 y devuelva una cadena de texto con la calificación (Suficiente,
Bien, Notable, ...). La forma de la función será la siguiente:
	NOTA (nota NUMBER) RETURN VARCHAR2
 * */
CREATE OR REPLACE FUNCTION nota (nota number)
RETURN VARCHAR2
AS
clasificacion VARCHAR2(20);
BEGIN
	CASE
		WHEN nota <= 4 THEN
		clasificacion := 'Insuficiente';
		WHEN nota = 5 THEN
		clasificacion := 'Suficiente';
		WHEN nota = 6 THEN
		clasificacion := 'Bien';
		WHEN nota >= 7 AND nota <= 8 THEN
		clasificacion := 'Notable';
		WHEN nota >= 9 AND nota <= 10 THEN
		clasificacion := 'Sobresaliente';
	END CASE;
	RETURN clasificacion;
END;

SELECT nota(9) FROM DUAL;


