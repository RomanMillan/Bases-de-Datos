/*1.
Realizar un procedure que muestre los números múltiplos de 5 de 0 a 100.
*/

CREATE OR REPLACE 
PROCEDURE multiplos5
IS
BEGIN
    FOR i IN 0..100 LOOP
        DBMS_OUTPUT.PUT_LINE(5*i);
    END LOOP;
END;

BEGIN
    multiplos5;
END;

/*2.
Procedure que muestre por pantalla todos los números comprendidos entre 1 y 100 
que son múltiplos de 7 o de 13.
*/
CREATE OR REPLACE 
PROCEDURE multiplosDe7o13
IS
BEGIN
    FOR i IN 1..100 LOOP
        IF(MOD(i,7)= 0 OR MOD(i,13)=0) THEN
            DBMS_OUTPUT.PUT_LINE(i);
        END IF;
    END LOOP;
END;

BEGIN
    multiplosDe7o13;
END;

/*3.
Realizar un procedure que muestre los número múltiplos del primer parámetro que 
van desde el segundo parámetro hasta el tercero
*/
-- NO ENTIENDO LO QUE SE PIDE

/*4.
Procedure que muestre por pantalla todos los números comprendidos entre 1 y 100 
que son múltiplos de 7 y de 13.
*/
CREATE OR REPLACE 
PROCEDURE multiplosDe7y13
IS
BEGIN
    FOR i IN 1..100 LOOP
        IF(MOD(i,7)= 0 AND MOD(i,13)=0) THEN
            DBMS_OUTPUT.PUT_LINE(i);
        END IF;
    END LOOP;
END;

BEGIN
    multiplosDe7y13;
END;

/*5.
Procedure que reciba un número entero por parámetro y visualice su tabla de 
multiplicar
*/
CREATE OR REPLACE 
PROCEDURE tablaDeMultiplicar (numero NUMBER)
IS
BEGIN
    FOR i IN 1..10 LOOP
        DBMS_OUTPUT.PUT_LINE(numero || ' * ' || i || ' = ' || numero * i);
    END LOOP;
END;

BEGIN
    tablaDeMultiplicar(6);
END;

/*6.
Realizar un procedure que muestre los número comprendidos desde el primer 
parámetro hasta el segundo.
*/
-- NO ENTIENDO LO QUE SE PIDE

/*7.
Realizar un procedure que cuente de 20 en 20, desde el primer parámetro hasta 
el segundo.
*/
-- NO ENTIENDO LO QUE SE PIDE

/*8.
Realizar un procedure que muestre por pantalla el cuadrado y el cubo de los 
cinco número consecutivos a partir del que se le pasa por parámetro.
*/
CREATE OR REPLACE 
PROCEDURE tablaCuadradoCubo (numero NUMBER)
IS
BEGIN
    FOR i IN numero +1..numero +5 LOOP
        DBMS_OUTPUT.PUT_LINE('Numero: ' || i);
        DBMS_OUTPUT.PUT_LINE('cuadrado:'|| power(i,2));
        DBMS_OUTPUT.PUT_LINE('cubo: ' || power(i,3));
    END LOOP;
END;

BEGIN
    tablaCuadradoCubo(5);
END;

/*9.
Realizar un procedure que reciba dos números como parámetro, y muestre el 
resultado de elevar el primero parámetro al segundo.
*/
CREATE OR REPLACE 
PROCEDURE elevacion (numero1 NUMBER, numero2 NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE(power(numero2,numero1));
END;

BEGIN
    elevacion(5,3);
END;

/*10
Realizar un procedure que reciba dos números como parámetro y muestre el 
resultado de elevar el primero número a 1, a 2... hasta el segundo número.
*/
CREATE OR REPLACE 
PROCEDURE elevacionAvanzada (numero1 NUMBER, numero2 NUMBER)
IS
BEGIN
    FOR i IN 1.. numero2 LOOP
        DBMS_OUTPUT.PUT_LINE(power(numero1,i));
    END LOOP;
END;

BEGIN
    elevacionAvanzada(5,3);
END;

/*11
Procedure que tome un número N que se le pasa por parámetro y muestre la suma 
de los N primeros números
*/
CREATE OR REPLACE 
PROCEDURE sumaN (numero NUMBER)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE((numero*(numero+1)/2));
END;

BEGIN
    sumaN(6);
END;

/*12
Procedure que tome como parámetros dos números enteros A y B, y calcule el 
producto de A y B mediante sumas, mostrando el resultado
*/

CREATE OR REPLACE 
PROCEDURE calcularProducto (numero1 NUMBER, numero2 NUMBER)
AS
resultado NUMBER(5):=0;
BEGIN
    resultado := resultado + (numero1 + numero1);
    FOR i IN 1.. (numero2-2) LOOP
       resultado := resultado + numero1; 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(resultado);
END;

BEGIN
    calcularProducto(6,3);
END;

/*13
Procedure que tome como parámetros dos números B y E enteros positivos, y 
calcule la potencia (B elevado a E) a través de productos
*/

CREATE OR REPLACE 
PROCEDURE calcularPotencia (numero1 NUMBER, numero2 NUMBER)
AS
resultado NUMBER(5):=0;
BEGIN
    resultado := resultado + (numero1 * numero1);
    FOR i IN 1.. (numero2-2) LOOP
       resultado := resultado * numero1; 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(resultado);
END;

BEGIN
    calcularPotencia(6,3);
END;

/*14
Realizar un procedure que reciba un número entero positivo y muestre el número 
de cifras que tiene dicho número. 
*/

CREATE OR REPLACE 
PROCEDURE calcularNumCifras (numero NUMBER)
AS
cont NUMBER(1) :=0;
i NUMBER(5) := 0;
BEGIN
    i := numero; 
    WHILE i != 0 LOOP
     i := i /10;
     cont := cont + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(cont);
END;

BEGIN
    calcularNumCifras(666);
END;

/*15
Realizar un procedure que solicite dos números enteros y  calcule el máximo 
común divisor de los dos números. (producto de los divisores de ambos números)
*/
-- ESTA MAL
CREATE OR REPLACE 
PROCEDURE cuacularMCD (numero1 NUMBER, numero2 NUMBER)
AS
temporal NUMBER(5);
BEGIN
    WHILE numero2 != 0 LOOP
        temporal := numero2;
        numero2 := MOD(numero1,numero2);
        numero1 := nuemro2;
    END LOOP;
END;

BEGIN
    cuacularMCD(12,18);
END;

/*
 16. Realizar un procedure que reciba como parámetro un número entero 
  positivo N y calcule el factorial.
    Factorial (0)= 1
    Factorial (1)= 1
    Factorial (N) = N * Factorial(N – 1)
*/
CREATE OR REPLACE 
PROCEDURE cuacularFactorial (numero NUMBER)
AS
resultado NUMBER(10) := 1;
BEGIN
    FOR i IN 1.. (numero-1) LOOP
        resultado := resultado * (i+1); 
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(resultado);
END;

BEGIN
    cuacularFactorial(7);
END;

/*
17. Realizar un procedure que reciba como parámetros número N entero 
positivo y calcule la suma de los inversos de N es decir
    1/1 + 1/2 + 1/3 + 1/4 + ...... 1/N
*/



/*
18. Realizar un programa lea dos números enteros mayores que 0 y calcule 
el máximo común divisor (m.c.d.) mediante el algoritmo de Euclides e 
imprima el resultado
    120 : 54 = 2 y resto 12
    54 : 12 = 4 y resto 6
    12: 6 = 2 y resto 0 -> El m.c.d. de 120 y 54 es 6
*/

