--Ejercicio 1
CREATE OR REPLACE
PROCEDURE ej1(fecha_ini DATE, fecha_final date)
IS
	CURSOR c_carreras IS
	SELECT c.NOMBRECARRERA carrera_c, c.FECHAHORA fecha_c, c.CODCARRERA cod_c 
	FROM CARRERAS c ;
	
	CURSOR c_apuesta(cod_carrera VARCHAR2) IS
	SELECT c2.DNI cliente_c, a.IMPORTE importe_c 
	FROM CARRERAS c, APUESTAS a , CLIENTES c2 
	WHERE c.CODCARRERA = a.CODCARRERA 
	AND a.DNICLIENTE = c2.DNI 
	AND a.CODCARRERA =cod_carrera ;
	
BEGIN
	FOR i IN c_carreras LOOP
		DBMS_OUTPUT.PUT_LINE('Carrera: '||i.carrera_c);
		DBMS_OUTPUT.PUT_LINE('Fecha: '||i.fecha_c);
		FOR k IN c_apuesta(i.cod_c) LOOP
			DBMS_OUTPUT.PUT_LINE('Cliente: '||k.cliente_c
			||' ImporteApostado: ' ||k.importe_c||' Ganancia: ');		
		END LOOP;
		DBMS_OUTPUT.PUT_LINE('Total ganancias de los apostantes en la carrera: ');
		DBMS_OUTPUT.PUT_LINE('Total ganancias Hipódromo en la carrera: ');
		DBMS_OUTPUT.PUT_LINE('--------------');
	END LOOP;
END;

BEGIN
	ej1(TO_DATE('15/10/2001','DD/MM/YYYY'),TO_DATE('15/10/2001','DD/MM/YYYY'));
END;

SELECT c.NOMBRECARRERA carrera_c, c.FECHAHORA fecha_c, c.CODCARRERA cod_c 
FROM CARRERAS c 
WHERE (EXTRACT(YEAR FROM c.FECHAHORA) >= 2008
AND EXTRACT(YEAR FROM c.FECHAHORA) <= 2009)

AND (AND EXTRACT(MONTH FROM c.FECHAHORA) >= 7
AND EXTRACT(MONTH FROM c.FECHAHORA) <= 10)

AND (AND EXTRACT(DAY FROM c.FECHAHORA) >= 10)
AND EXTRACT(DAY FROM c.FECHAHORA) <= 20));


--Ejercicio2

ALTER TABLE CABALLOS ADD c_ganadas NUMBER(10);
COMMIT;

CREATE OR REPLACE 
PROCEDURE ej2
IS
	CURSOR c_ganado IS
	SELECT c.CODCABALLO cod_c 
	FROM CABALLOS c, PARTICIPACIONES p 
	WHERE c.CODCABALLO = p.CODCABALLO
	AND p.POSICIONFINAL = 1;
BEGIN
	FOR i IN c_ganado LOOP
		UPDATE CABALLOS c
		SET c.c_ganadas = +1
		WHERE c.CODCABALLO = i.cod_c;
	END LOOP;
	COMMIT;
	EXCEPTION 
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado');
       ROLLBACK;
END;

BEGIN
	ej2();
END;


--Ejercicio 3
CREATE OR REPLACE
PROCEDURE ej3(numero NUMBER, letra1 varchar2, letra2 varchar2)
IS
	letra1_c varchar2(20);
	letra2_c varchar2(20);
	error EXCEPTION;
	i binary_integer := 0;
BEGIN
	IF (numero <= 0)THEN
		RAISE error;
	END IF;
	IF (letra1 = letra2)THEN
		RAISE error;
	END IF;
	WHILE i< numero loop
		letra1_c := letra1_c || letra1;
		letra2_c := letra2_c || letra2;
		i := i+1;
	END LOOP;
	i := 0;
	if(MOD(numero,2)= 1)THEN
		WHILE i< numero/2 LOOP
			DBMS_OUTPUT.PUT_LINE(letra1_c);
		i := i+1;	
		if(i<numero-1)THEN
				DBMS_OUTPUT.PUT_LINE(letra2_c);
			END IF;
		end LOOP;	
	ELSE
		WHILE i< numero/2 LOOP
			DBMS_OUTPUT.PUT_LINE(letra1_c);
			DBMS_OUTPUT.PUT_LINE(letra2_c);
			i := i+1;
		end LOOP;
	END IF;
	EXCEPTION
	WHEN error THEN
	 DBMS_OUTPUT.PUT_LINE('Datos insertados no correctos');
END;

BEGIN
	ej3(6, 'B','C');
END;



--4
CREATE OR REPLACE 
PROCEDURE ej4(nombre_c varchar2, nom_carrera varchar2, 
		nombre_cl varchar2, naci_cl varchar2, import_c number)
IS
BEGIN
	
END;


INSERT INTO apuestas(dnicliente, CODCABALLO, CODCARRERA)
VALUES ();

FROM CABALLOS c , CLIENTES cl , CARRERAS ca, APUESTAS a 
WHERE a.CODCABALLO = c.CODCABALLO 
AND a.DNICLIENTE = cl.DNI 
AND a.CODCARRERA = ca.CODCARRERA 
AND c.NOMBRE = nombre_c
AND ca.NOMBRECARRERA = nom_carrera
AND cl.NOMBRE = nombre_cl









