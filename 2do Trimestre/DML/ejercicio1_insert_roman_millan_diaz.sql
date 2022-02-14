
--Ejercicio ACADEMIA

-- Crear usuario tienda
ALTER SESSION SET "_oracle_script" = TRUE;
CREATE USER academia
    IDENTIFIED BY academia;
GRANT CONNECT, RESOURCE, DBA TO academia;

-- Apartado 1
-- Crear tablas

CREATE TABLE profesor
(
    nombre       VARCHAR2 (50),
    apellido1    VARCHAR2 (50),
    apellido2    VARCHAR2 (50),
    dni          VARCHAR2 (9), -- PK
    direccion    VARCHAR2 (50),
    titulo       VARCHAR2 (50),
    gana         NUMBER (8, 2),
    CONSTRAINT PK_profesor PRIMARY KEY (dni)
);

CREATE TABLE curso
(
    nombre_curso      VARCHAR2 (50),
    cod_curso         VARCHAR2 (50), -- PK
    dni_profesor      VARCHAR2 (9), -- FK (profesor)
    maximo_alumnos    NUMBER (2),
    fecha_inicio      DATE,
    fecha_fin         DATE,
    num_horas         NUMBER (4),
    CONSTRAINT PK_curso PRIMARY KEY (cod_curso),
    CONSTRAINT FK_curso FOREIGN KEY (dni_profesor) REFERENCES profesor (dni)
);

CREATE TABLE alumno
(
    nombre              VARCHAR2 (50),
    apellido1           VARCHAR2 (50),
    apellido2           VARCHAR2 (50),
    dni                 VARCHAR2 (9),  -- PK
    direccion           VARCHAR2 (50),
    sexo                VARCHAR2 (1),
    fecha_nacimiento    DATE,
    curso               VARCHAR2 (50), --FK (curso)
    CONSTRAINT PK_alumno PRIMARY KEY (dni),
    CONSTRAINT FK_alumno FOREIGN KEY (curso) REFERENCES curso (cod_curso),
    CONSTRAINT CK_alumno__sexo CHECK (sexo IN ('H', 'M'))
);


-- Apartado 2
-- Insertar datos del profesor

INSERT INTO profesor
     VALUES ('Juan',
             'Arch',
             'López',
             '32432455',
             'Puerta Negra, 4',
             'Ing. Informática',
             7500);

INSERT INTO profesor
     VALUES ('María',
             'Oliva',
             'Rubio',
             '4321543',
             'Juan Alfonso 32',
             'Lda. Fil. Inglesa',
             5400);

-- Insertar datos Curso

INSERT INTO curso
     VALUES ('Inglés Básico',
             '1',
             '43215643',
             15,
             TO_DATE ('01/11/00', 'DD/MM/YY'),
             TO_DATE ('22-DEC-00', 'DD-MON-YY'),
             120);

/*
No podemos insertar otro tipo de formato que no se haya estrablecido prviamente
Es decir antes hemos metido:  TO_DATE('22-DEC-00','DD-MON-YY')
Despues no podemos hacer esto: TO_DATE('01-SEPT-00','DD-MONT-YY')
ya que estamos intentando meter dos tipos diferentes de formato para el mismo campo
*/

INSERT INTO curso
     VALUES ('Administración Linux',
             '2',
             '32432455',
             NULL,
             TO_DATE ('01-SEP-00', 'DD-MON-YY'),
             NULL,
             80);

--Insertar datos alumnos

INSERT INTO alumno
     VALUES ('Lucas',
             'Manilva',
             'López',
             '123523',
             'Alhamar, 3',
             'H',
             TO_DATE ('01/11/79', 'DD/MM/YY'),
             1);

INSERT INTO alumno
     VALUES ('Antonia',
             'López',
             'Alcantara',
             '2567567',
             'Maniquí, 21',
             'M',
             NULL,
             2);

INSERT INTO alumno
     VALUES ('Manuel',
             'Alcantara',
             'Pedrós',
             '3123689',
             'Julian, 2',
             'M',
             NULL,
             1);

INSERT INTO alumno
     VALUES ('José',
             'Pérez',
             'Caballar',
             '4896765',
             'Jarcha,5',
             'H',
             TO_DATE ('03/02/77', 'DD/MM/YY'),
             2);

-- Apartado 3

/*Entre otros errores tiene el DNI igual que otro alumno*/

INSERT INTO alumno
     VALUES ('Sergio',
             'Navas',
             'Retal',
             '123523K',
             NULL,
             'M',
             NULL,
             1);

-- Apartado 4

/*Tiene el DNI igual qeu otro profesor*/

INSERT INTO profesor
     VALUES ('Juan',
             'Arch',
             'López',
             '32432455K',
             'Puerta Negra, 4',
             'Ing. Informática',
             NULL);

-- Apartado 5

INSERT INTO alumno
     VALUES ('María',
             'Jaén',
             'Sevilla',
             '789678',
             'Martos, 5',
             'M',
             NULL,
             NULL);

-- Apartado 6

UPDATE alumno
   SET fecha_nacimiento = TO_DATE ('23/12/1976', 'DD/MM/YYYY')
 WHERE dni LIKE '2567567';

-- Apartado 7

/*No hay ningún curso con codigo: 5*/

SELECT *
  FROM alumno
 WHERE dni LIKE '2567567';

UPDATE alumno
   SET curso = '1'
 WHERE dni LIKE '2567567';

-- Apartado 8

/*No hay nadie llamado: Laura Jiménez*/

SELECT *
  FROM profesor
 WHERE UPPER (nombre) LIKE 'LAURA' AND UPPER (apellido1) LIKE 'JIMÉNEZ';

DELETE FROM profesor
      WHERE UPPER (nombre) LIKE 'LAURA' AND UPPER (apellido1) LIKE 'JIMÉNEZ';

-- Apartado 9

SELECT *
  FROM curso
 WHERE cod_curso LIKE '1';

ALTER TABLE alumno
    DROP CONSTRAINT FK_alumno;

ALTER TABLE alumno
    ADD CONSTRAINT FK_alumno FOREIGN KEY (curso)
            REFERENCES curso (cod_curso) ON DELETE CASCADE;

DELETE FROM curso
      WHERE cod_curso LIKE '1';

-- Apartado 10

ALTER TABLE curso
    ADD numero_alumno NUMBER (2);

-- Apartado 11

SELECT *
  FROM alumno
 WHERE fecha_nacimiento IS NULL;

UPDATE alumno
   SET fecha_nacimiento = TO_DATE ('01/01/2012', 'DD,MM,YYYY')
 WHERE fecha_nacimiento IS NULL;

-- Apartado 12

ALTER TABLE alumno
    DROP COLUMN sexo;

-- Apartado 13
 

UPDATE profesor SET gana = NVL(gana,0) = NVL(gana,0) +(NVL(gana*0.2))
 WHERE titulo LIKE '%Informática%';


 -- Apartado 14

 /*
 NO se puede actualizar ya que tiene hijos y no puede ser modificado
  ALTER TABLE curso DROP CONSTRAINT FK_curso;
 ALTER TABLE curso ADD CONSTRAINT FK_curso FOREIGN KEY (dni_profesor) 
 REFERENCES profesor (dni);
 */

UPDATE profesor
   SET dni = '1234567'
 WHERE dni = '32432455';

 -- Apartado 15


 -- Apartado 16
UPDATE alumno
   SET sexto 'F'
 WHERE dni = '32432455';


