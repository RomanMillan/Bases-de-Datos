-- Apartado 1

INSERT INTO persona
VALUES ('27272727A','Román','Millán','Sevilla','Las Almenas',20,'954656644',NULL,1);

INSERT INTO alumno VALUES ('A141414','27272727A');

INSERT INTO alumno_asignatura VALUES ('A141414','160002',1);

-- Apartado 2
SELECT * FROM profesor;

ALTER TABLE profesor DROP CONSTRAINT SYS_C0011405;

ALTER TABLE profesor ADD CONSTRAINT FK_profesor FOREIGN KEY(dni) 
REFERENCES persona (dni) ON DELETE CASCADE;

ALTER TABLE asignatura DROP CONSTRAINT SYS_C0011407;

ALTER TABLE asignatura ADD CONSTRAINT FK_asignatura FOREIGN KEY(idprofesor) 
REFERENCES profesor (idprofesor) ON DELETE CASCADE;

ALTER TABLE alumno_asignatura DROP CONSTRAINT SYS_C0011411;

ALTER TABLE alumno_asignatura ADD CONSTRAINT FK_alumno_asignatura FOREIGN KEY(idasignatura) 
REFERENCES asignatura (idasignatura) ON DELETE CASCADE;

DELETE FROM profesor WHERE idprofesor LIKE 'P117';

INSERT INTO persona 
VALUES('77222122K','Marta','López Martos','Sevilla','Calle Tarfia',9,'615891432',TO_DATE('22/07/1981','DD/MM/YYYY'),0);

-- Apartado 3
CREATE TABLE alumnos_muyrepetidores(
idasignatura		VARCHAR2(7),
idalumno			VARCHAR2(7),
nombre				VARCHAR2(50),
apellido			VARCHAR2(50),
telefono			VARCHAR2(9),
CONSTRAINT PK_alumnos_muyrepe PRIMARY KEY(idasignatura)
);

INSERT INTO alumnos_muyrepetidores (idasignatura,idalumno) 
SELECT idasignatura,idalumno FROM alumno_asignatura WHERE  numeromatricula >= 3;

-- Apartado 4

ALTER TABLE alumnos_muyrepetidores ADD observaciones VARCHAR2(100);

UPDATE alumnos_muyrepetidores SET observaciones = 'Se encuentra en seguimiento' 
WHERE idalumno IN (SELECT idalumno FROM persona p, alumno a WHERE p.ciudad LIKE 'Sevilla' AND p.dni = a.dni);



-- Apartado 5

DELETE FROM alumnos_muyrepetidores  
WHERE idalumno IN ( 
SELECT idalumno FROM persona p, alumno a WHERE TO_CHAR(p.fecha_nacimiento,'MM/YYYY') = '11/1971' AND p.dni = a.dni);


-- Apartado 6
CREATE TABLE resumen_titulaciones(
nombre_titulacion		VARCHAR2(40),
numeroasignaturas		NUMBER(2),
CONSTRAINT PK_resumen_titulaciones PRIMARY KEY(nombre_titulacion)
);

-- Apartado 7

-- 7.1
/*
 *Los datos no podrá verlos el otro programador a no ser que la persona que insertó los datos hiciera un commit despues 
 *de haber insertado esos datos. Ya que esos datos no son consistentes.
 * */

-- 7.2
/*
 *Si quedarán los datos guardados ya que al crear una nueva tabla posteriormente se produce un commit de manera automática
 *salvando todo lo que tenga anteriormente escrito o ejecutado. 
 * */

-- 7.3
/*
 * Si se puede regresar a la situación posterior. Usando rollback; regresaríamos al último commit realizado.
 * */


-- 7.4
/*
 * Para que una vez insertado los datos queden de forma persistentes en nuestra base de datos tendremos que realizar un 
 * commit; ya que estas insercciones por sí solas no serán guardadas de forma persistentes
 * */

-- 7.5
/*
 * Si se podría 
 * Lo primero es realizar un rollback; para volver al último commit y recuperar los datos que hemos borrado por error
 * después generamos la instrucción para solo borrar los datos que nos interesan.
 * Y por último una vez conforme con el resultado hacemos un commit; para hacer consistentes nuestros cambios.
 * 
 * */

-- 7.6
/*
 * Los savepoint son puntos de guardados donde podemos regresar a otros commits no necesariamente el último 
 * commit realizado.
 * cuando insertamos varios insert con sus respectivos commit pero queremos regresar al principo utilizamos el savepoint
 * */


