-- Boletin 0.

-- 1 
/*
 * Se inicia el programa y entra en una condicion donde analiza
 * si 10 es mayor que 5.
 * Si es cierto imprime por consola cierto
 * sino falso.
 * cierra la condicion y el programa.
 */

BEGIN
	IF 10 > 5 THEN
		DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
		DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;

--2
/*
 * Inicia el programa y entra en una condicion mira si 10 > 5 y 5 > 1
 * si se cumple prime cierto sino falso
 * finaliza la condicion y el programa.
 * */

BEGIN
	IF 10 > 5 AND 5 > 1 THEN
		DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
		DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;

--3
/*
 * Lo mismo que los anteriores.
 * Imprime cierto
 * */
BEGIN
	IF 10 > 5 AND 5 > 50 THEN
		DBMS_OUTPUT.PUT_LINE ('Cierto');
	ELSE
		DBMS_OUTPUT.PUT_LINE ('Falso');
	END IF;
END;


--4
/*
 * Incicia el programa y despues el case que es de una sola condicion
 *  donde será falso
 * */
BEGIN
	CASE
		WHEN 10 > 5 AND 5 > 50 THEN
			DBMS_OUTPUT.PUT_LINE ('Cierto');
		ELSE
			DBMS_OUTPUT.PUT_LINE ('Falso');
	END CASE;
END;

-- 5
/*
 * Entra en el bucle for donde imprimirá del 1 al 10 
 * */

BEGIN
	FOR i IN 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE (i);
	END LOOP;
END;

--6
/*
 * Lo mismo que el ejercicio 5
 * */

BEGIN
	FOR i IN REVERSE 1..10 LOOP
		DBMS_OUTPUT.PUT_LINE (i);
	END LOOP;
END;

--7
/*
 * 
 * */



--8
DECLARE
	num NUMBER(3) := 0;
BEGIN
	LOOP
		DBMS_OUTPUT.PUT_LINE (num);
		IF num > 100 THEN 
			EXIT; 
		END IF;
		num := 2;
	END LOOP;
END;



