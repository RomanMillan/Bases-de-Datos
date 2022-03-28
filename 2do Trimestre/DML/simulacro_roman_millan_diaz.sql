-- Crear usuario
alter session set "_oracle_script"=true;  
create user simulacro_roman_millan identified by simulacro_roman_millan;
GRANT CONNECT, RESOURCE, DBA TO simulacro_roman_millan;

-- Apartado 1
CREATE TABLE profesor(
idprofesor		VARCHAR2(50),
nif_p			VARCHAR2(50),
nombre			VARCHAR2(50),
especialidad	VARCHAR2(50),
telefono		VARCHAR2(50),
CONSTRAINT PK_profesor PRIMARY KEY(idprofesor)
);

CREATE TABLE asignatura(
codasignatura		VARCHAR2(50),
nombre				VARCHAR2(50),
idprofesor			VARCHAR2(50),
CONSTRAINT PK_asignatura PRIMARY KEY(codasignatura),
CONSTRAINT FK_asignatura FOREIGN KEY(idprofesor) REFERENCES profesor (idprofesor)
);

CREATE TABLE alumno(
nummatricula		VARCHAR2(50),
nombre				VARCHAR2(50),
fechanacimiento		DATE,
telefono			VARCHAR2(50),
CONSTRAINT PK_alumno PRIMARY KEY(nummatricula)
);

CREATE TABLE recibe(
nummatricula		VARCHAR2(50),
codasignatura		VARCHAR2(50),
cursoescolar		VARCHAR2(50),
CONSTRAINT PK_recibe PRIMARY KEY(cursoescolar,nummatricula,codasignatura),
CONSTRAINT FK_recibe FOREIGN KEY(codasignatura) REFERENCES asignatura(codasignatura),
CONSTRAINT FK_recibe_2 FOREIGN KEY(nummatricula) REFERENCES alumno(nummatricula)
);

-- Apartado 2
-- profesores
INSERT INTO profesor VALUES ('1','46548487A','Juan','Ingeniero en Matematicas','95647441');
INSERT INTO profesor VALUES ('2','46548487F','Ana','Ingeniero en Lenguaje','45647448');

-- asignaturas
INSERT INTO asignatura VALUES ('A-1','Matematicas','1');
INSERT INTO asignatura VALUES ('A-2','Lengua castellana','2');
INSERT INTO asignatura VALUES ('A-3','Ingles','2');
INSERT INTO asignatura VALUES ('A-4','Sociales','2');

-- alumnos
INSERT INTO alumno VALUES ('AL-1','Alejandro',TO_DATE('19/06/2000','DD/MM/YYYY'),'55546225');
INSERT INTO alumno VALUES ('AL-2','Miguel',TO_DATE('11/07/2000','DD/MM/YYYY'),'54546225');
INSERT INTO alumno VALUES ('AL-3','Ana',TO_DATE('09/01/2000','DD/MM/YYYY'),'88546225');
INSERT INTO alumno VALUES ('AL-4','Maria',TO_DATE('10/06/2000','DD/MM/YYYY'),'77546225');
INSERT INTO alumno VALUES ('AL-5','Luciano',TO_DATE('19/06/2000','DD/MM/YYYY'),'65546225');
INSERT INTO alumno VALUES ('AL-6','Alejandro',TO_DATE('29/08/2000','DD/MM/YYYY'),'41546225');
INSERT INTO alumno VALUES ('AL-7','Antonio',TO_DATE('10/02/2000','DD/MM/YYYY'),'95546225');
INSERT INTO alumno VALUES ('AL-8','Roberto',TO_DATE('06/05/2000','DD/MM/YYYY'),'95256225');
INSERT INTO alumno VALUES ('AL-9','Maria',TO_DATE('10/10/2000','DD/MM/YYYY'),'95548725');
INSERT INTO alumno VALUES ('AL-10','Rosa',TO_DATE('09/02/2000','DD/MM/YYYY'),'95543625');

-- recibe
INSERT INTO recibe VALUES ('AL-1','A-1','C-1');
INSERT INTO recibe VALUES ('AL-1','A-2','C-1');

INSERT INTO recibe VALUES ('AL-2','A-1','C-1');
INSERT INTO recibe VALUES ('AL-2','A-2','C-1');

INSERT INTO recibe VALUES ('AL-3','A-1','C-1');
INSERT INTO recibe VALUES ('AL-3','A-2','C-1');

INSERT INTO recibe VALUES ('AL-4','A-1','C-1');
INSERT INTO recibe VALUES ('AL-4','A-2','C-1');

INSERT INTO recibe VALUES ('AL-5','A-1','C-1');
INSERT INTO recibe VALUES ('AL-5','A-2','C-1');

INSERT INTO recibe VALUES ('AL-6','A-1','C-1');
INSERT INTO recibe VALUES ('AL-6','A-2','C-1');

INSERT INTO recibe VALUES ('AL-7','A-1','C-1');
INSERT INTO recibe VALUES ('AL-7','A-2','C-1');

INSERT INTO recibe VALUES ('AL-8','A-1','C-1');
INSERT INTO recibe VALUES ('AL-8','A-2','C-1');

INSERT INTO recibe VALUES ('AL-9','A-1','C-1');
INSERT INTO recibe VALUES ('AL-9','A-2','C-1');

INSERT INTO recibe VALUES ('AL-10','A-1','C-1');
INSERT INTO recibe VALUES ('AL-10','A-2','C-1');

-- Apartado 3

/*
 * INSERT INTO alumno VALUES ('AL-11','Alejandro',TO_DATE('19/06/2000','DD/MM/YYYY'),'55546225');
 * INSERT INTO alumno VALUES ('AL-11','Miguel',TO_DATE('11/07/2000','DD/MM/YYYY'),'54546225');
 * 
 *  * Solo nos deja insertar el primero, el segundo no ya que la matricula es la misma y este es una PK y solo 
 * puede haber una unica matricula para cada alumno.
 * Para poder insertar los dos alumnos tendríamos que cambiar las matriculas
 * 
 * INSERT INTO alumno VALUES ('AL-11','Alejandro',TO_DATE('19/06/2000','DD/MM/YYYY'),'55546225');
 * INSERT INTO alumno VALUES ('AL-12','Miguel',TO_DATE('11/07/2000','DD/MM/YYYY'),'54546225');
 * */

-- Apartado 4
INSERT INTO alumno VALUES ('AL-13','Alejandra',TO_DATE('06/05/2000','DD/MM/YYYY'),NULL);
INSERT INTO alumno VALUES ('AL-14','Maria',TO_DATE('10/10/2000','DD/MM/YYYY'),NULL);
INSERT INTO alumno VALUES ('AL-15','Rosa',TO_DATE('09/02/2000','DD/MM/YYYY'),NULL);


-- Apartado 5
UPDATE alumno SET telefono = '95543624' WHERE nummatricula = 'AL-13';
UPDATE alumno SET telefono = '95543625' WHERE nummatricula = 'AL-14';
UPDATE alumno SET telefono = '95543627' WHERE nummatricula = 'AL-15';

-- Apartado 6
UPDATE alumno SET fechanacimiento = TO_DATE('22/07/1981','DD/MM/YYYY') WHERE TO_CHAR(fechanacimiento,'YYYY') > '2000';

-- Apartado 7
UPDATE profesor SET especialidad = 'Informática' WHERE telefono IS NOT NULL AND nif_p NOT LIKE '9%';

-- Apartado 8
DELETE FROM recibe WHERE codasignatura = 'A-1';

-- Apartado 9
DELETE FROM asignatura WHERE codasignatura = 'A-1';

-- Apartado 10
/*
 * DELETE FROM asignatura; 
 * Da error debido a que algunas asignaturas tienen hijos
 * 
 * Se solucionaría borrando la constraint y creandola de nuevo con un ON DELETE CASCADE
 * 
 * */
ALTER TABLE recibe DROP CONSTRAINT FK_recibe;
ALTER TABLE recibe ADD CONSTRAINT FK_recibe FOREIGN KEY(codasignatura) REFERENCES asignatura(codasignatura) ON DELETE CASCADE;
DELETE FROM asignatura;

-- Apartado 11
DELETE FROM profesor;

-- Apartado 12
UPDATE alumno SET nombre = UPPER(nombre);

-- Apartado 13
CREATE TABLE alumno_backup AS (SELECT * FROM alumno);






