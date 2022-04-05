--creamos la tabla
CREATE TABLE HOTEL (
	ID NUMBER(2) PRIMARY KEY, 
	NHABS NUMBER(3)
);

--insertamos los datos
INSERT INTO HOTEL VALUES (1, 10);
INSERT INTO HOTEL VALUES (2, 60);
INSERT INTO HOTEL VALUES (3, 200);
INSERT INTO HOTEL VALUES (99, NULL);

--creamos el procedimiento
CREATE OR REPLACE
PROCEDURE TAMHOTEL (cod Hotel.ID%TYPE)
AS
  NumHabitaciones  Hotel.Nhabs%TYPE;
  Comentario       VARCHAR2(40);
BEGIN
  -- Número de habitaciones del Hotel cuyo ID es cod
  SELECT Nhabs 
  INTO NumHabitaciones
  FROM Hotel 
  WHERE ID=cod;

  IF NumHabitaciones IS NULL THEN
    Comentario := 'de tamaño indeterminado';
  ELSIF NumHabitaciones < 50 THEN
    Comentario := 'Pequeño';
  ELSIF NumHabitaciones < 100 THEN
    Comentario := 'Mediano';
  ELSE
    Comentario := 'Grande';
  END IF;

  DBMS_OUTPUT.PUT_LINE ('El hotel con ID '|| cod ||' es '|| Comentario);
END;

--ejecutamos el procedimiento
BEGIN
   TAMHOTEL(1);
   TAMHOTEL(2);
   TAMHOTEL(3);
   TAMHOTEL(99);
END;

--funciones
CREATE OR REPLACE
FUNCTION SUMA (NUM1 NUMBER, NUM2 NUMBER)
RETURN NUMBER
IS
BEGIN
  RETURN NUM1+NUM2;
END SUMA;

--despues la llamamos
SELECT SUMA(5.7, 9.3)
FROM DUAL;


