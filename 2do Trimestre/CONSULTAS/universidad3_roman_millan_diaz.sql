    -- EJERCICIO UNIVERSIDAD 3

    --1. Cuantos costes básicos hay.
        SELECT COUNT(NVL(ASIGNATURA.COSTEBASICO,0))
        FROM ASIGNATURA;

    --2. Para cada titulación mostrar el número de asignaturas que hay junto con el nombre de la titulación.
        SELECT COUNT(ASIGNATURA.IDASIGNATURA) num_asignatura, TITULACION.NOMBRE nombre_titulacion
        FROM ASIGNATURA, TITULACION
        WHERE ASIGNATURA.IDTITULACION = TITULACION.IDTITULACION
        GROUP BY TITULACION.NOMBRE;
    
    --3. Para cada titulación mostrar el nombre de la titulación junto con el precio total de todas sus asignaturas.
        SELECT TITULACION.NOMBRE nombre_titu, SUM(ASIGNATURA.COSTEBASICO) precio_total
        FROM TITULACION, ASIGNATURA
        WHERE ASIGNATURA.IDTITULACION = TITULACION.IDTITULACION
        GROUP BY TITULACION.NOMBRE;
    
    --4. Cual sería el coste global de cursar la titulación de Matemáticas si el coste de cada asignatura fuera 
    --incrementado en un 7%. 
        SELECT SUM(ASIGNATURA.COSTEBASICO) * 1.07 coste_global
        FROM ASIGNATURA, TITULACION
        WHERE TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION
        AND UPPER(TITULACION.NOMBRE) LIKE 'MATEMATICAS';
    
    --5. Cuantos alumnos hay matriculados en cada asignatura, junto al id de la asignatura. 
        SELECT COUNT(ALUMNO_ASIGNATURA.IDALUMNO) num_alumnos, ALUMNO_ASIGNATURA.IDASIGNATURA
        FROM ALUMNO_ASIGNATURA
        GROUP BY ALUMNO_ASIGNATURA.IDASIGNATURA;
    
    --6. Igual que el anterior pero mostrando el nombre de la asignatura.
        SELECT COUNT(ALUMNO_ASIGNATURA.IDALUMNO) num_alumnos, ALUMNO_ASIGNATURA.IDASIGNATURA, ASIGNATURA.NOMBRE nombre_asig
        FROM ALUMNO_ASIGNATURA, ASIGNATURA
        WHERE ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        GROUP BY ALUMNO_ASIGNATURA.IDASIGNATURA, ASIGNATURA.NOMBRE;
    
    --7. Mostrar para cada alumno, el nombre del alumno junto con lo que tendría que pagar por el total de 
    --todas las asignaturas en las que está matriculada. Recuerda que el precio de la matrícula tiene un 
    -- incremento de un 10% por cada año en el que esté matriculado. 
    
    -- NO ESTA TERMINADO
        SELECT PERSONA.NOMBRE, SUM(ASIGNATURA.COSTEBASICO + ALUMNO_ASIGNATURA.NUMEROMATRICULA)* 0.10 coste_total
        FROM PERSONA, ALUMNO, ALUMNO_ASIGNATURA, ASIGNATURA
        WHERE PERSONA.DNI = ALUMNO.DNI AND ALUMNO.IDALUMNO = ALUMNO_ASIGNATURA.IDALUMNO
        AND ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        GROUP BY PERSONA.NOMBRE;
    
    --8. Coste medio de las asignaturas de cada titulación, para aquellas titulaciones en el que el coste 
    -- total de la 1ª matrícula sea mayor que 60 euros. 
        SELECT AVG(ASIGNATURA.COSTEBASICO) coste_medio
        FROM TITULACION, ASIGNATURA, ALUMNO_ASIGNATURA
        WHERE TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION
        AND ASIGNATURA.IDASIGNATURA = ALUMNO_ASIGNATURA.IDASIGNATURA
        GROUP BY TITULACION.NOMBRE
        HAVING SUM(ASIGNATURA.COSTEBASICO) > 60;

    
    --9. Nombre de las titulaciones  que tengan más de tres alumnos.
        SELECT TITULACION.NOMBRE
        FROM TITULACION, ASIGNATURA, ALUMNO_ASIGNATURA
        WHERE TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION 
        AND ASIGNATURA.IDASIGNATURA = ALUMNO_ASIGNATURA.IDASIGNATURA
        GROUP BY TITULACION.NOMBRE
        HAVING COUNT(ALUMNO_ASIGNATURA.IDASIGNATURA) > 3;
    
    --10. Nombre de cada ciudad junto con el número de personas que viven en ella.
        SELECT PERSONA.CIUDAD nombre_ciudad, COUNT(PERSONA.DNI) num_persona
        FROM PERSONA
        GROUP BY PERSONA.CIUDAD;

    --11. Nombre de cada profesor junto con el número de asignaturas que imparte.
        SELECT PERSONA.NOMBRE nombre_profesor, COUNT(ASIGNATURA.IDPROFESOR) num_asig
        FROM PERSONA, PROFESOR, ASIGNATURA
        WHERE PERSONA.DNI = PROFESOR.DNI 
        AND PROFESOR.IDPROFESOR = ASIGNATURA.IDPROFESOR
        GROUP BY PERSONA.NOMBRE;
    
    --12. Nombre de cada profesor junto con el número de alumnos que tiene, para aquellos profesores que 
    -- tengan dos o más de 2 alumnos.
       SELECT PERSONA.NOMBRE nombre_profesor, COUNT(ALUMNO_ASIGNATURA.IDALUMNO) num_alumnos 
       FROM  PERSONA, PROFESOR, ASIGNATURA, ALUMNO_ASIGNATURA
       WHERE PERSONA.DNI = PROFESOR.DNI 
       AND PROFESOR.IDPROFESOR = ASIGNATURA.IDPROFESOR
       AND ASIGNATURA.IDASIGNATURA = ALUMNO_ASIGNATURA.IDASIGNATURA
       GROUP BY PROFESOR.DNI,PERSONA.NOMBRE
       HAVING COUNT(ALUMNO_ASIGNATURA.IDALUMNO)>=2;

    --13. Obtener el máximo de las sumas de los costesbásicos de cada cuatrimestre
        SELECT MAX(SUM(ASIGNATURA.COSTEBASICO)) coste_maximo
        FROM ASIGNATURA
        GROUP BY ASIGNATURA.CUATRIMESTRE;

    --14. Suma del coste de las asignaturas
        SELECT SUM(ASIGNATURA.COSTEBASICO) suma_coste
        FROM ASIGNATURA;
    
    --15. ¿Cuántas asignaturas hay?
        SELECT COUNT(ASIGNATURA.IDASIGNATURA) asignaturas
        FROM ASIGNATURA;
    
    --16. Coste de la asignatura más cara y de la más barata
        SELECT MAX(ASIGNATURA.COSTEBASICO) asig_mas_cara, MIN(ASIGNATURA.COSTEBASICO) asig_mas_barata
        FROM ASIGNATURA;
    
    --17. ¿Cuántas posibilidades de créditos de asignatura hay?
        SELECT COUNT(DISTINCT ASIGNATURA.CREDITOS) creditos
        FROM ASIGNATURA;
    
    --18. ¿Cuántos cursos hay?
        SELECT COUNT(DISTINCT ASIGNATURA.CURSO) cursos
        FROM ASIGNATURA;
        
    --19. ¿Cuántas ciudades hau?
        SELECT COUNT(DISTINCT PERSONA.CIUDAD) ciudades
        FROM PERSONA;
    
    --20. Nombre y número de horas de todas las asignaturas.
        -- NUMERO DE HORAS??
        SELECT ASIGNATURA.NOMBRE, (ASIGNATURA.CREDITOS * 10) numero_horas
        FROM ASIGNATURA;
    
    --21. Mostrar las asignaturas que no pertenecen a ninguna titulación.
        SELECT ASIGNATURA.NOMBRE
        FROM ASIGNATURA
        WHERE ASIGNATURA.IDTITULACION IS NULL;
    
    --22. Listado del nombre completo de las personas, sus teléfonos y sus direcciones, llamando a la columna 
    --del nombre "NombreCompleto" y a la de direcciones "Direccion".
        SELECT PERSONA.NOMBRE || ' '|| PERSONA.APELLIDO nombre_completo, 
        PERSONA.TELEFONO, PERSONA.DIRECCIONCALLE ||' '|| PERSONA.DIRECCIONNUM direccion
        FROM PERSONA;
   
    --23. Cual es el día siguiente al día en que nacieron las personas de la B.D.
        SELECT EXTRACT(DAY FROM PERSONA.FECHA_NACIMIENTO)+1 dia_sig
        FROM PERSONA;
    
    --24. Años de las personas de la Base de Datos, esta consulta tiene que valor para cualquier momento
        SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM PERSONA.FECHA_NACIMIENTO)edad
        FROM PERSONA;
    
    --25. Listado de personas mayores de 25 años ordenadas por apellidos y nombre, esta consulta tiene que valor 
    -- para cualquier momento
        SELECT EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM PERSONA.FECHA_NACIMIENTO)edad
        FROM PERSONA
        WHERE EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM PERSONA.FECHA_NACIMIENTO) > 25;
    
    --26. Nombres completos de los profesores que además son alumnos
        SELECT PERSONA.NOMBRE ||' '|| PERSONA.APELLIDO nombre_completo
        FROM PERSONA,PROFESOR,ALUMNO
        WHERE ALUMNO.DNI = PROFESOR.DNI;
    
    --27. Suma de los créditos de las asignaturas de la titulación de Matemáticas
        SELECT SUM(ASIGNATURA.CREDITOS)
        FROM ASIGNATURA, TITULACION
        WHERE TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION
        AND UPPER(TITULACION.NOMBRE) LIKE 'MATEMATICAS';
    
    --28. Número de asignaturas de la titulación de Matemáticas
        SELECT COUNT(ASIGNATURA.IDASIGNATURA) num_asig_mate
        FROM ASIGNATURA, TITULACION
        WHERE TITULACION.IDTITULACION = ASIGNATURA.IDTITULACION
        AND UPPER(TITULACION.NOMBRE) LIKE 'MATEMATICAS';
    
    --29. ¿Cuánto paga cada alumno por su matrícula?
        SELECT NVL(SUM(ASIGNATURA.COSTEBASICO),0) coste_alumno
        FROM ALUMNO_ASIGNATURA, ASIGNATURA
        WHERE ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        GROUP BY ALUMNO_ASIGNATURA.IDALUMNO;
    
    --30. ¿Cuántos alumnos hay matriculados en cada asignatura?
        SELECT COUNT(ALUMNO_ASIGNATURA.IDALUMNO) num_alumnos_asig
        FROM ALUMNO_ASIGNATURA, ASIGNATURA
        WHERE ALUMNO_ASIGNATURA.IDASIGNATURA = ASIGNATURA.IDASIGNATURA
        GROUP BY ASIGNATURA.IDASIGNATURA;
        