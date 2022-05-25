/*
 * Ejercicio 1 (3 puntos)
Crea un procedimiento que muestre un listado en el que aparezcan todos los cines,
 el número de salas que tiene, los nombres de las salas y las películas proyectadas. 
 El formato será el siguiente:
 * 
 */

CREATE OR REPLACE 
PROCEDURE ej1
AS
BEGIN
	CURSOR c_cine IS
	SELECT  c.CINE , c.CIUDAD_CINE , c.DIRECCION_CINE, COUNT(s.SALA) num_s 
	FROM CINE c , SALA s 
	WHERE c.CINE = s.CINE  
	GROUP BY c.CINE , c.CIUDAD_CINE , c.DIRECCION_CINE ;
	
	CURSOR c_sala(nom_c varchar2, )is

END;

SELECT s.SALA , s.AFORO , COUNT(p.CIP) num_pro
FROM sala s, PROYECCION p 
WHERE s.CINE = p.CINE 
AND s.SALA = p.SALA 
AND s.CINE = 'El Arcangel'
AND s.SALA = 1
ORDER BY s.SALA, s.AFORO;

SELECT  c.CINE , c.CIUDAD_CINE , c.DIRECCION_CINE, COUNT(s.SALA) num_s 
FROM CINE c , SALA s 
WHERE c.CINE = s.CINE  
GROUP BY c.CINE , c.CIUDAD_CINE , c.DIRECCION_CINE ;


/*
 * Ejercicio 2 (2 puntos) :
Crea una tabla llamada auditoria_peliculas con un campo llamado descripción que sea una cadena de 300
caracteres donde se almacenará una entrada en la tabla auditoria_peliculas con la fecha 
del suceso, valor antiguo y valor nuevo de cada campo, así como el tipo de operación 
realizada (-inserción, -modificación, -borrado).
 * 
 */

CREATE TABLE auditoria_peliculas(
	descripcion VARCHAR2(300),
	CONSTRAINT pk_auditoria_p PRIMARY KEY (descripcion)
);

CREATE OR REPLACE 
TRIGGER ej2
AFTER INSERT OR UPDATE OR DELETE ON pelicula
FOR EACH ROW
BEGIN
	IF DELETING THEN
		INSERT INTO auditoria_peliculas VALUES('Fecha: '||sysdate||' Tipo Operacion: Borrado Valores: ' 
									|| ' Cip: '|| :OLD.cip ||' titulo_P: '|| :OLD.titulo_p 
									||' Año produccion: '||:OLD.ano_produccion 
									||' Titulo_s: '||:OLD.titulo_s ||' Nacionalidad: '||:OLD.nacionalidad
									||' Presupuesto: '||:OLD.presupuesto ||' Duracion: '||:OLD.duracion);
	ELSIF INSERTING THEN
				INSERT INTO auditoria_peliculas VALUES('Fecha: '||sysdate||' Tipo Operacion: Insertar Valores: ' 
									|| ' Cip: '|| :NEW.cip ||' titulo_P: '|| :NEW.titulo_p 
									||' Año produccion: '||:NEW.ano_produccion 
									||' Titulo_s: '||:NEW.titulo_s ||' Nacionalidad: '||:NEW.nacionalidad
									||' Presupuesto: '||:NEW.presupuesto ||' Duracion: '||:NEW.duracion);
	ELSIF UPDATING THEN
					INSERT INTO auditoria_peliculas VALUES('Fecha: '||sysdate||' Tipo Operacion: Actualizar Valores: ' 
									|| ' Cip: '|| :NEW.cip ||' titulo_P: '|| :NEW.titulo_p 
									||' Año produccion: '||:NEW.ano_produccion 
									||' Titulo_s: '||:NEW.titulo_s ||' Nacionalidad: '||:NEW.nacionalidad
									||' Presupuesto: '||:NEW.presupuesto ||' Duracion: '||:NEW.duracion);
	END IF;
END;


DELETE FROM pelicula p WHERE p.CIP = '11111103-S';
INSERT INTO pelicula VALUES('44448','Examen',2022,'Examen','ESPAÑA',15000,80);
UPDATE pelicula p SET p.ANO_PRODUCCION = 2015 WHERE p.CIP = '44448';

/*
 * Ejercicio 3 (3 puntos):
	Dada la siguiente vista:
 * */

CREATE VIEW VISTA_PROYECCIONES (proyeccion_cine, proyeccion_sala, proyeccion_cip,
proyeccion_fechaestreno, salacine,sala,sala_aforo)
AS
SELECT p.CINE,p.SALA, p.CIP,p.FECHA_ESTRENO,s.CINE, s.SALA, s.AFORO
FROM PROYECCION p, SALA s
WHERE p.CINE =s.CINE
AND p.SALA =s.SALA;

/*
 * Deseamos operar sobre los datos correspondientes a la vista anterior. 
 * Crea el trigger necesario para realizar inserciones, eliminaciones
 *  y modificaciones en la vista anterior.
 * */

CREATE OR REPLACE 
TRIGGER ej3
INSTEAD OF INSERT OR UPDATE OR DELETE ON VISTA_PROYECCIONES
FOR EACH ROW
BEGIN
	IF DELETING THEN
		DELETE FROM PROYECCION pr 
		WHERE pr.CINE = cine 
		AND pr.SALA = sala;
		
		DELETE FROM SALA s 
		WHERE s.CINE = cine 
		AND s.SALA = sala;
	ELSIF INSERTING THEN
		INSERT INTO PROYECCION VALUES(:NEW.cine,:NEW.sala,:NEW.cip,:NEW.fecha_estreno,NULL,NULL,NULL);
		INSERT INTO SALA VALUES(:NEW.cine,:NEW.sala,:NEW.aforo);
	END IF;
END;

DELETE FROM VISTA_PROYECCIONES('El Arcangel',1,'11111102-S',TO_DATE('1995/09/21','YYYY/MM/DD'),'El Arcangel',1,50);
INSERT INTO VISTA_PROYECCIONES('El Arcangel',8,'11111147-S',TO_DATE('1995/09/21','YYYY/MM/DD'),'El Arcangel',8,50);

/*
 * jercicio 4 ( 2 puntos):
Crear el trigger necesario para impedir que un cine tenga más de 5 salas. En el caso de no cumplir la casuística
deberá lanzar una excepción que interrumpa el proceso. El error será -200007: Un cine no puede tener más
de 5 salas
 * */


CREATE OR REPLACE 
TRIGGER ej4
AFTER INSERT ON sala
FOR EACH ROW
DECLARE
	num_s NUMBER(2);
BEGIN
	SELECT COUNT(s.SALA)
	INTO num_s
	FROM s.sala, c.cine
	WHERE c.cine = s.cine
	AND s.sala != :NEW.sala;
	
	IF(num_s = 5)THEN
		RAISE_APPLICATION_ERROR(-20007, 'Un cine no puede tener más de 5 salas');
	END IF;
END;

INSERT INTO sala VALUES('El Arcangel',6,80);



