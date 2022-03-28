
-- 1 Mostrar los nombres y los créditos de cada una de las asignaturas.
SELECT nombre, creditos FROM ASIGNATURA;

-- 2 Obtener los posibles distintos créditos de las asignaturas que hay en la base de datos.
SELECT DISTINCT creditos FROM ASIGNATURA;

--3 Mostrar todos los datos de todas de las personas
SELECT * FROM PERSONA;

-- 4 Mostrar el nombre y créditos de las asignaturas del primer cuatrimestre.
SELECT nombre,creditos FROM ASIGNATURA WHERE cuatrimestre =1;

-- 5 Mostrar el nombre y el apellido de las personas nacidas antes del 1 de enero de 1975.
SELECT nombre, apellido FROM persona WHERE TO_CHAR(fecha_nacimiento,'YYYY')<'1975';

-- 6 Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos.
SELECT nombre, costebasico FROM asignatura WHERE creditos > 4.5;

-- 7 Mostrar el nombre de las asignaturas cuyo coste básico está entre 25 y 35 euros.
SELECT nombre FROM asignatura WHERE costebasico BETWEEN 25 AND 35;

-- 8 Mostrar el identificador de los alumnos matriculados en la asignatura '150212' o en la '130113' o en ambas.
SELECT DISTINCT idalumno FROM alumno_asignatura WHERE idasignatura = '150212' OR idasignatura = '130113';

-- 9 Obtener el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos.
SELECT nombre FROM asignatura WHERE cuatrimestre = 2 AND NOT creditos =6;

   -- 10. Mostrar el nombre y el apellido de las personas cuyo apellido comience por 'G'.
SELECT nombre, apellido FROM persona WHERE apellido LIKE 'G%';

    -- 11. Obtener el nombre de las asignaturas que no tienen dato para el IdTitulacion. 
SELECT nombre FROM asignatura WHERE idtitulacion IS NULL;

   --  12. Obtener el nombre de las asignaturas que tienen dato para el IdTitulacion.
SELECT nombre FROM asignatura WHERE idtitulacion IS NOT NULL;

   --  13. Mostrar el nombre de las asignaturas cuyo coste por cada crédito sea mayor de 8 euros. 
SELECT nombre FROM asignatura WHERE creditos>8;

  --   14. Mostrar el nombre y el número de horas de las asignaturas de la base de datos. (1cred.=10 horas).
SELECT nombre, NVL(creditos,0)*10 AS cant_horas FROM asignatura;

   --  15. Mostrar todos los datos de las asignaturas del 2º cuatrimestre ordenados por el identificador de asignatura.
SELECT * FROM asignatura WHERE  cuatrimestre = 2 ORDER BY idasignatura;

  --   16. Mostrar el nombre de todas las mujeres que viven en “Madrid”.
SELECT nombre FROM persona WHERE UPPER(ciudad) = 'MADRID' AND varon = 0;

  --   17. Mostrar el nombre y los teléfonos de aquellas personas cuyo teléfono empieza por 91
SELECT nombre,telefono FROM persona WHERE telefono LIKE '91%';

   --  18. Mostrar el nombre de las asignaturas que contengan la sílaba “pro”
SELECT nombre FROM asignatura WHERE UPPER(nombre) LIKE '%PRO%';

   --  19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor que tiene código P101
SELECT nombre FROM asignatura WHERE asignatura.CURSO = 1 AND asignatura.IDPROFESOR = 'P101';

   --  20. Mostrar el código de alumno que se ha matriculado tres o más veces de una asignatura, 
   -- mostrando también el código de la asignatura correspondiente.
SELECT ALUMNO_ASIGNATURA.IDALUMNO, ALUMNO_ASIGNATURA.IDASIGNATURA FROM ALUMNO_ASIGNATURA 
WHERE ALUMNO_ASIGNATURA.NUMEROMATRICULA >= 3;

  /*  21. El coste de cada asignatura va subiendo a medida que se repite la asignatura. 
   Para saber cuál sería el precio de las distintas asignaturas en las repeticiones 
   (y así animar a nuestros alumnos a que estudien) 
   
   se quiere mostrar un listado en donde esté el nombre de la asignatura, el precio básico, 
   - el precio de la primera repetición (un 10 por ciento más que el coste básico),  
   - el precio de la segunda repetición un 30 por ciento más que el coste básico) 
   - y el precio de la tercer repetición (un 60 por ciento más que el coste básico).
*/
SELECT nombre,ASIGNATURA.COSTEBASICO, 
(ASIGNATURA.COSTEBASICO + (ASIGNATURA.COSTEBASICO*0.10))AS coste_1_rep,
(ASIGNATURA.COSTEBASICO + (ASIGNATURA.COSTEBASICO*0.30)) AS coste_2_rep,
(ASIGNATURA.COSTEBASICO + (ASIGNATURA.COSTEBASICO*0.60)) AS coste_3_rep
FROM ASIGNATURA;

   --  22. Mostrar todos los datos de las personas que tenemos en la base de datos que han nacido antes de la década de los 70.
SELECT * FROM PERSONA WHERE TO_CHAR(PERSONA.FECHA_NACIMIENTO,'YY')<70;

   --  23. Mostrar el identificador de las personas que trabajan como profesor, sin que salgan valores repetidos.
SELECT DISTINCT PROFESOR.DNI FROM PROFESOR;

   --  24. Mostrar el identificador de los alumnos que se encuentran matriculados en la asignatura con código 130122.
SELECT ALUMNO_ASIGNATURA.IDALUMNO FROM ALUMNO_ASIGNATURA WHERE ALUMNO_ASIGNATURA.IDASIGNATURA = '130122';

  --   25. Mostrar los códigos de las asignaturas en las que se encuentra matriculado algún alumno, sin que salgan códigos repetidos.
SELECT ASIGNATURA.IDASIGNATURA FROM ASIGNATURA WHERE ASIGNATURA.CURSO IS NOT NULL;

  --   26. Mostrar el nombre de las asignaturas que tienen más de 4 créditos, 
  -- y además, o se imparten en el primer cuatrimestre o son del primer curso.
SELECT nombre FROM ASIGNATURA WHERE ASIGNATURA.CREDITOS > 4 
AND (ASIGNATURA.CUATRIMESTRE = 1 OR ASIGNATURA.CURSO = 1); 

   --  27. Mostrar los distintos códigos de las titulaciones en las que hay alguna asignatura en nuestra base de datos.
SELECT DISTINCT NVL(ASIGNATURA.IDTITULACION,0) FROM ASIGNATURA;

   --  28. Mostrar el dni de las personas cuyo apellido contiene la letra g en mayúsculas o minúsculas.
SELECT PERSONA.DNI FROM PERSONA WHERE UPPER(PERSONA.APELLIDO) LIKE '%G%';

  --   29. Mostrar las personas varones que tenemos en la base de datos que han nacido con posterioridad a 1970
  -- y que vivan en una ciudad que empieza por M.
SELECT * FROM PERSONA WHERE PERSONA.VARON = 1 
AND TO_CHAR(PERSONA.FECHA_NACIMIENTO,'YYYY')>'1970' 
AND PERSONA.CIUDAD LIKE 'M%';

