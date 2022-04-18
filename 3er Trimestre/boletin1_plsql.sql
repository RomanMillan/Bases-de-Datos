/*
 *1.
 * Sabiendo que una persona ha trabajado 38 horas en una semana 
 * dada y gana a razón de 60 euros la hora. La tasa de impuestos 
 * del estado es del 15,5% de su paga bruta. Se desea saber cuál es 
 * la paga bruta, el descuento por impuesto y la paga neta del trabajador.
 */

CREATE OR REPLACE 
PROCEDURE sueldo(horasT NUMBER, gana NUMBER, impuesto NUMBER)
IS 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Ganacia en bruto: ' || horasT*gana);
	DBMS_OUTPUT.PUT_LINE('Descuento: ' ||((horasT*gana)*impuesto)/100);
	DBMS_OUTPUT.PUT_LINE('Paga Neta: ' ||((horasT*gana)-((horasT*gana)*impuesto)/100));
END;

BEGIN
	sueldo (38,60,15.5);
END;



/*2.
 * Realizar un procedure que calcule el salario neto de un trabajador 
 * recibiendo como parámetro las horas trabajadas, el precio de la hora y el 
 * tanto por ciento de impuestos que se aplicará sobre el salario bruto.
 */


CREATE OR REPLACE 
PROCEDURE sueldo(horasT NUMBER, gana NUMBER, impuesto NUMBER)
IS 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Ganacia en bruto: ' || horasT*gana);
	DBMS_OUTPUT.PUT_LINE('Descuento: ' ||((horasT*gana)*impuesto)/100);
	DBMS_OUTPUT.PUT_LINE('Paga Neta: ' ||((horasT*gana)-((horasT*gana)*impuesto)/100));
END;

BEGIN
	sueldo (38,60,15.5);
END;


/*3.
 * Realizar un procedure para hallar la media ponderada de tres puntuaciones 
 * de exámenes que se pasarán como parámetros. Los pesos asociados a cada 
 * uno de los exámenes serán fijos y son 50%, 20% y 30% para cada puntuación
 * */

CREATE OR REPLACE 
PROCEDURE mediaPonderada(nota1 NUMBER, nota2 NUMBER, nota3 NUMBER)
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Media Ponderada: ' || ((nota1*0.5) + (nota2*0.2) + (nota3*0.3)));
END;

BEGIN
	mediaPonderada(6,8,5);
END;


/*4.
 * Escribe un procedure para calcular el cuadrado y el cubo de un número 
 * introducido por parámetros y mostrar el resultado.
 * */

CREATE OR REPLACE 
PROCEDURE calcularCuadradoYcubo(numero NUMBER)
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Cuadrado: ' || power(numero,2));
	DBMS_OUTPUT.PUT_LINE('Cuadrado: ' || power(numero,3));
END;

BEGIN
	calcularCuadradoYcubo(7);
END;


/*5.
 * Escribe un procedure para calcular la longitud de la circunferencia 
 * y el área del círculo cuyo radio se pasa por parámetro. 
 * (longitud=2*pi*r y área pi*r*r)
 * */


CREATE OR REPLACE 
PROCEDURE calcularLongYarea(r NUMBER)
IS
BEGIN
	DBMS_OUTPUT.PUT_LINE('Longitud: ' || (r * 3.1416));
	DBMS_OUTPUT.PUT_LINE('Area: ' || (3.1416 * power(r,2)));
END;

BEGIN
	calcularLongYarea(7);
END;


/*6.
 * Realizar un procedure que reciba tres números  y diga si la suma de
 *  de los dos primeros número es igual al tercero. Si se cumple esta 
 * condición escribir “Iguales”, y en caso contrario escribir “Distintos”
 * */

CREATE OR REPLACE 
PROCEDURE igualOdistinto(n1 NUMBER, n2 NUMBER, n3 number)
AS
	suma NUMBER(10,2);
BEGIN
	suma := n1 + n2;
	IF (suma = n3) THEN
		DBMS_OUTPUT.PUT_LINE('Iguales');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Distintos');
	END IF;
END;

BEGIN
	igualOdistinto(7,2,9);
END;


/*7.
 * Realizar un procedure que reciba un número y muestre “Positivo”
 *  si el número es mayor o igual que cero, y “negativo” en caso contrario.
 * */

CREATE OR REPLACE 
PROCEDURE positivoOnegativo(numero NUMBER)
IS
BEGIN
	IF (numero >= 0) THEN
		DBMS_OUTPUT.PUT_LINE('Positivo');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Negativo');
	END IF;
END;

BEGIN
	positivoOnegativo(5);
END;


/*8.
 * Realizar un procedure que reciba un número y diga si el número es “Par” 
 * si el número es par, e impar en caso contrario.
 * */







