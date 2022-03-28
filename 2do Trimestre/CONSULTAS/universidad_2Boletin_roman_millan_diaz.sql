-- Universidad. Segundo Boletín

--    1. Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para las asignaturas del mismo coste 
--		mostrar por orden alfabético de nombre de asignatura. 
		SELECT *  
		FROM  ASIGNATURA 
		ORDER BY ASIGNATURA.COSTEBASICO DESC, ASIGNATURA.NOMBRE;
		
--    2. Mostrar el nombre y los apellidos de los profesores. 
        SELECT PERSONA.NOMBRE,PERSONA.APELLIDO 
        FROM PERSONA, PROFESOR 
        WHERE PERSONA.DNI = PROFESOR.DNI;

--   3. Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla. 
        SELECT ASIGNATURA.NOMBRE
        FROM PERSONA, PROFESOR, ASIGNATURA
        WHERE PERSONA.DNI = PROFESOR.DNI 
        AND PROFESOR.IDPROFESOR = ASIGNATURA.IDPROFESOR
        AND UPPER(PERSONA.CIUDAD) LIKE 'SEVILLA';

--    4. Mostrar el nombre y los apellidos de los alumnos.
        SELECT PERSONA.NOMBRE, PERSONA.APELLIDO
        FROM PERSONA, ALUMNO
        WHERE PERSONA.DNI = ALUMNO.DNI;

--    5. Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 
        SELECT PERSONA.DNI, PERSONA.NOMBRE, PERSONA.APELLIDO
        FROM PERSONA, ALUMNO
        WHERE PERSONA.DNI = ALUMNO.DNI
        AND UPPER(PERSONA.CIUDAD) LIKE 'SEVILLA';
    
  --  6. Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 
        SELECT PERSONA.DNI,PERSONA.NOMBRE,PERSONA.APELLIDO
        FROM PERSONA, ALUMNO,ALUMNO_ASIGNATURA,ASIGNATURA
        WHERE PERSONA.DNI = ALUMNO.DNI 
        AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO 
        AND ALUMNO_ASIGNATURA.IDALUMNO = ALUMNO.IDALUMNO
        AND UPPER(ASIGNATURA.NOMBRE) LIKE 'SEGURIDAD VIAL';

    --7. Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. 
    -- Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.
        SELECT DISTINCT TITULACION.IDTITULACION
        FROM TITULACION, ALUMNO_ASIGNATURA,ALUMNO,ASIGNATURA
        WHERE ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO 
        AND ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        AND TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION
        AND ALUMNO.DNI LIKE '20202020A';
    
   -- 8. Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.
        SELECT ASIGNATURA.NOMBRE
        FROM PERSONA, ALUMNO,ALUMNO_ASIGNATURA,ASIGNATURA
        WHERE PERSONA.DNI = ALUMNO.DNI 
        AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO
        AND ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        AND UPPER(PERSONA.NOMBRE) LIKE 'ROSA' AND UPPER(PERSONA.APELLIDO) LIKE 'GARCIA';
   
   -- 9. Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 
        SELECT ALUMNO.DNI
        FROM PERSONA,ALUMNO,ALUMNO_ASIGNATURA,ASIGNATURA,PROFESOR
        WHERE PERSONA.DNI = PROFESOR.DNI 
        AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO
        AND ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        AND ASIGNATURA.IDPROFESOR = PROFESOR.IDPROFESOR
        AND UPPER(PERSONA.NOMBRE) LIKE 'JORGE' AND UPPER(PERSONA.APELLIDO) LIKE 'SAENZ';

   -- 10. Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 
        -- NO SALE
        SELECT ALUMNO.DNI, PERSONA.NOMBRE, PERSONA.APELLIDO
        FROM PERSONA,PROFESOR,ASIGNATURA,ALUMNO_ASIGNATURA, ALUMNO
        WHERE PERSONA.DNI = PROFESOR.DNI 
        AND PROFESOR.IDPROFESOR = ASIGNATURA.IDPROFESOR
        AND ASIGNATURA.IDASIGNATURA = ALUMNO_ASIGNATURA.IDASIGNATURA
        AND ALUMNO_ASIGNATURA.IDALUMNO = ALUMNO.IDALUMNO 
        -- AND ALUMNO.DNI = PERSONA.DNI
        AND UPPER(PERSONA.NOMBRE) LIKE 'JORGE' AND UPPER(PERSONA.APELLIDO) LIKE 'SAENZ';

   -- 11. Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 
        SELECT TITULACION.NOMBRE
        FROM TITULACION,ASIGNATURA
        WHERE TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION
        AND ASIGNATURA.CREDITOS = 4;
   
   -- 12. Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con 
   -- el nombre de la titulación a la que pertenecen. 
      SELECT ASIGNATURA.NOMBRE nombre_asig, ASIGNATURA.CREDITOS creditos_asig, TITULACION.NOMBRE nombre_titul
      FROM ASIGNATURA,TITULACION
      WHERE TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION
      AND ASIGNATURA.CUATRIMESTRE = 1;  

  --  13. Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con 
  --  el nombre de las personas matriculadas
        SELECT ASIGNATURA.NOMBRE nombre_asig, ASIGNATURA.COSTEBASICO coste_basico, PERSONA.NOMBRE nombre_per
        FROM PERSONA, ALUMNO, ALUMNO_ASIGNATURA,ASIGNATURA
        WHERE PERSONA.DNI = ALUMNO.DNI 
        AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO
        AND ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        AND ASIGNATURA.CREDITOS > 4.5;

  --  14. Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos
        SELECT PERSONA.NOMBRE
        FROM PERSONA, PROFESOR, ASIGNATURA
        WHERE PERSONA.DNI = PROFESOR.DNI 
        AND PROFESOR.IDPROFESOR = ASIGNATURA.IDPROFESOR
        AND ASIGNATURA.COSTEBASICO BETWEEN 25 AND 35;

  --  15. Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.
        SELECT PERSONA.NOMBRE
        FROM PERSONA, ALUMNO, ALUMNO_ASIGNATURA
        WHERE PERSONA.DNI = ALUMNO.DNI 
        AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO
        AND (ALUMNO_ASIGNATURA.IDASIGNATURA LIKE '150212' OR ALUMNO_ASIGNATURA.IDASIGNATURA LIKE '130113')
        OR (ALUMNO_ASIGNATURA.IDASIGNATURA LIKE '150212' AND ALUMNO_ASIGNATURA.IDASIGNATURA LIKE '130113');

   -- 16. Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el nombre 
   --  de la titulación a la que pertenece.
        SELECT ASIGNATURA.NOMBRE nombre_asig, TITULACION.NOMBRE nombre_titu
        FROM ASIGNATURA, TITULACION
        WHERE ASIGNATURA.IDTITULACION = TITULACION.IDTITULACION
        AND ASIGNATURA.CUATRIMESTRE = 2
        AND NOT ASIGNATURA.CREDITOS = 6; 

   -- 17. Mostrar el nombre y el número de horas de todas las asignaturas. 
   -- (1cred.=10 horas) junto con el dni de los alumnos que están matriculados.
       SELECT ASIGNATURA.NOMBRE, ASIGNATURA.CREDITOS*10, ALUMNO.DNI
       FROM  ALUMNO, ALUMNO_ASIGNATURA, ASIGNATURA
       WHERE ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO 
       AND ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA;
       

   -- 18. Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura
        SELECT PERSONA.NOMBRE
        FROM PERSONA, ALUMNO, ALUMNO_ASIGNATURA
        WHERE PERSONA.DNI = ALUMNO.DNI AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO
        AND UPPER(PERSONA.CIUDAD) LIKE 'SEVILLA'
        AND PERSONA.VARON = 0
        AND ALUMNO_ASIGNATURA.IDALUMNO IS NOT NULL;

   -- 19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.
        SELECT ASIGNATURA.NOMBRE
        FROM ASIGNATURA
        WHERE ASIGNATURA.CURSO = 1
        AND UPPER(ASIGNATURA.IDPROFESOR) LIKE 'P101';

  --  20. Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.
        SELECT PERSONA.NOMBRE
        FROM PERSONA, ALUMNO, ALUMNO_ASIGNATURA
        WHERE PERSONA.DNI = ALUMNO.DNI 
        AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO
        AND ALUMNO_ASIGNATURA.NUMEROMATRICULA >= 3;
        