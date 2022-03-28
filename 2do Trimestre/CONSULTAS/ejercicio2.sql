-- Ejercicio 2 enunciado.


--    1. Para cada titulación ordenar por coste mostrando primero las asignaturas más caras y para las asignaturas del mismo coste 
--		mostrar por orden alfabético de nombre de asignatura. 
		SELECT COSTEBASICO, NOMBRE  FROM  ASIGNATURA a ORDER BY COSTEBASICO DESC, NOMBRE ;

--    2. Mostrar el nombre y los apellidos de los profesores. 

--   3. Mostrar el nombre de las asignaturas impartidas por profesores de Sevilla. 

--    4. Mostrar el nombre y los apellidos de los alumnos.

--    5. Mostrar el DNI, nombre y apellidos de los alumnos que viven en Sevilla. 

  --  6. Mostrar el DNI, nombre y apellidos de los alumnos matriculados en la asignatura "Seguridad Vial". 

--    7. Mostrar el Id de las titulaciones en las que está matriculado el alumno con DNI 20202020A. Un alumno está matriculado en una titulación si está matriculado en una asignatura de la titulación.

  --  8. Obtener el nombre de las asignaturas en las que está matriculada Rosa Garcia.

   -- 9. Obtener el DNI de los alumnos a los que le imparte clase el profesor Jorge Saenz. 

 --   10. Obtener el DNI, nombre y apellido de los alumnos a los que imparte clase el profesor Jorge Sáenz. 

   -- 11. Mostrar el nombre de las titulaciones que tengan al menos una asignatura de 4 créditos. 

   -- 12. Mostrar el nombre y los créditos de las asignaturas del primer cuatrimestre junto con el nombre de la titulación a la que pertenecen. 

--    13. Mostrar el nombre y el coste básico de las asignaturas de más de 4,5 créditos junto con el nombre de las personas matriculadas

  --  14. Mostrar el nombre de los profesores que imparten asignaturas con coste entre 25 y 35 euros, ambos incluidos

  --  15. Mostrar el nombre de los alumnos matriculados en la asignatura '150212' ó en la '130113' ó en ambas.

   -- 16. Mostrar el nombre de las asignaturas del 2º cuatrimestre que no sean de 6 créditos, junto con el nombre de la titulación a la que pertenece.

   -- 17. Mostrar el nombre y el número de horas de todas las asignaturas. (1cred.=10 horas) junto con el dni de los alumnos que están matriculados.

   -- 18. Mostrar el nombre de todas las mujeres que viven en “Sevilla” y que estén matriculados de alguna asignatura

   -- 19. Mostrar el nombre de la asignatura de primero y que lo imparta el profesor con identificador p101.

  --  20. Mostrar el nombre de los alumnos que se ha matriculado tres o más veces en alguna asignatura.