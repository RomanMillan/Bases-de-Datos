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
	igualOdistinto(7,3,9);
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

CREATE OR REPLACE 
PROCEDURE parOimpar(numero NUMBER)
IS
BEGIN
	IF (MOD(numero,2)=0) THEN
		DBMS_OUTPUT.PUT_LINE('Par');
	ELSE
		DBMS_OUTPUT.PUT_LINE('Impar');
	END IF;
END;

BEGIN
	parOimpar(4);
END;


/*9.
Realizar un procedure que reciba un número y diga si el número es 
“Par positivo”, “Par negativo”, “Impar positivo”, “Impar negativo” o “cero”,
 según sea el número.
*/
CREATE OR REPLACE 
PROCEDURE parOimparPosNega(numero NUMBER)
IS
BEGIN
    IF(numero = 0) THEN
        DBMS_OUTPUT.PUT_LINE('Cero');
	ELSIF (MOD(numero,2)=0) THEN
        IF(numero> 0) THEN
            DBMS_OUTPUT.PUT_LINE('Par Positivo');
		ELSE
            DBMS_OUTPUT.PUT_LINE('Par Negativo');
		END IF;
	ELSE 
        IF (numero > 0) THEN
            DBMS_OUTPUT.PUT_LINE('Impar Positivo');
		ELSE
            DBMS_OUTPUT.PUT_LINE('Impar Negativo');
		END IF;
	END IF;
END;

BEGIN
	parOimparPosNega(-4);
END;

/*10.
Realizar un procedure que reciba dos números como parámetro, y muestre la suma 
de los dos números.
*/

CREATE OR REPLACE 
PROCEDURE suma(num1 NUMBER, num2 NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('La suma es: ' || (num1 + num2));
END;

BEGIN
    suma(5,6);
END;

/*11.
Realizar un procedure que reciba dos números como parámetros y muestre
 la resta de los dos números.
*/

CREATE OR REPLACE 
PROCEDURE resta(num1 NUMBER, num2 NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('La resta es: ' || (num1 - num2));
END;

BEGIN
    resta(5,6);
END;

/*12.
Realizar un procedure que reciba dos número como parámetros y muestre la 
suma de los dos números si los dos números son mayor que cero, y la resta 
de los dos números si alguno de los números es menor que cero.
*/

CREATE OR REPLACE 
PROCEDURE restaOsuma(num1 NUMBER, num2 NUMBER)
IS
BEGIN
    IF(num1 > 0 AND num2 > 0) THEN
        DBMS_OUTPUT.PUT_LINE('La suma es: ' || (num1 + num2));
    ELSE
        DBMS_OUTPUT.PUT_LINE('La resta es: ' || (num1 - num2));
    END IF;
END;

BEGIN
    restaOsuma(5,-2);
END;

-- Otra forma y funciona bien
CREATE OR REPLACE 
PROCEDURE otraForma(num1 NUMBER, num2 NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('El resultado: ' || (num1 + num2));
END;

BEGIN
    otraForma(5,-2);
END;

/*13.
Realizar un procedure que reciba dos número como parámetros y muestre la suma 
de los dos números si los dos números son mayor que cero o si los dos números 
son menor que cero. Si un número es positivo y el otro negativo, muestre la 
resta del número positivo menos el número negativo.
*/

CREATE OR REPLACE 
PROCEDURE restaOsumaRara(num1 NUMBER, num2 NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('El resultado: ' || (num1 + num2));
END;

BEGIN
    restaOsumaRara(5,-2);
END;

/*
    14. Realizar un procedure que calcule el salario neto semanal de un trabajador. 
    El procedure recibirá como parámetro el numero de horas trabajadas y el precio
     por hora, y hay que tener en cuenta los siguientes aspectos:
    • Las primeras 35 horas se pagan a tarifa normal
    • Las horas que pasen de 35 se pagan a 1,5 veces la tarifa normal.
    • Las tasa de impuesto son:
    • Las primeros 600 euros son libres de impuestos.
    • Los siguientes 300 euros tienen un 25% de impuestos.
    • Los restantes euros un 45 % de impuestos. 
*/

CREATE OR REPLACE 
PROCEDURE calcularSalario(horas NUMBER, precio NUMBER)
AS
salario NUMBER(10,2);
salarioAquitar NUMBER(10,2);
coste NUMBER(10,2);
BEGIN
    IF(horas <= 35)THEN
        salario := horas*precio;   
    ELSE
        salario := (horas * precio)*1.5;
    END IF;
    IF(salario > 600 AND salario <= 900)THEN
        salarioAquitar := salario - 600;
        coste := salarioAquitar * 0.25;
        salario := salario - coste;
    ELSIF(salario > 900)THEN   
        salarioAquitar:= salario - 900;
        coste := (salarioAquitar * 0.45) + 75;
        salario := salario - coste;  
    END IF;
    DBMS_OUTPUT.PUT_LINE('Salario Neto: ' || salario);
END;

BEGIN
    calcularSalario(80,8);
END;