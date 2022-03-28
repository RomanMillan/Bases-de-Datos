--1. Obtener las diferentes nacionalidades de películas que existen en la base de datos.

SELECT DISTINCT NACIONALIDAD  
FROM PELICULA p;

--2. Mostrar el código de la película, la fecha de estreno y la recaudación de las
--películas ordenadas por su recaudación de mayor a menor estrenadas antes del 22
--de septiembre de 1997.

SELECT DISTINCT p.CIP , pro.FECHA_ESTRENO , pro.RECAUDACION 
FROM PELICULA p , PROYECCION pro
WHERE p.CIP  = pro.CIP
AND TO_CHAR(pro.FECHA_ESTRENO,'YYYY/MM/DD')< '1997/09/22'
ORDER BY pro.RECAUDACION DESC;

-- 3. Mostrar el código de las películas, la recaudación y el número de espectadores
--cuyo número de espectadores sea mayor que 3000 o cuya recaudación sea mayor o
--igual que 2.000.000, ordenadas de mayor a menor número de espectadores.
SELECT DISTINCT p.CIP , p.RECAUDACION , p.ESPECTADORES 
FROM PROYECCION p 
WHERE p.ESPECTADORES > 3000
OR p.RECAUDACION >= 2000000
ORDER BY p.ESPECTADORES DESC;

--4. Obtener el nombre de los cines que contengan la cadena "ar" en mayúsculas o
--minúsculas en su dirección
SELECT c.CINE  
FROM CINE c  
WHERE UPPER(c.DIRECCION_CINE) LIKE '%AR%';

-- 5. Mostrar los cines y su aforo total cuyo aforo total sea mayor que 600 ordenados
--por su aforo total de forma descendente
SELECT s.CINE , SUM(s.AFORO) aforo_total
FROM SALA s 
GROUP BY s.CINE
HAVING SUM(s.AFORO)> 600
ORDER BY SUM(s.AFORO) desc;

--6. Obtener el título de las películas estrenadas en la primera quincena de cualquier
--mes.
SELECT DISTINCT p.TITULO_P 
FROM PROYECCION pro, PELICULA p 
WHERE pro.CIP = p.CIP 
AND EXTRACT (DAY FROM pro.FECHA_ESTRENO)<= '15';

-- 7. Muestra la nacionalidad de las películas junto con la media del presupuesto por
--cada nacionalidad teniendo en cuenta los valores nulos y teniendo en cuenta sólo
--aquellas películas cuyo presupuesto es mayor que 500;

SELECT p.NACIONALIDAD, AVG(NVL(p.PRESUPUESTO ,0)) media_presupuesto
FROM PELICULA p 
GROUP BY p.NACIONALIDAD
HAVING AVG(NVL(p.PRESUPUESTO ,0))> 500; 

--8. Obtener el nombre y el sexo de todos los personajes cuyo nombre termine en 'n',
--'s' o 'e' y no tengan sexo asignado
SELECT p.NOMBRE_PERSONA, p.SEXO_PERSONA 
FROM PERSONAJE p 
WHERE (UPPER(p.NOMBRE_PERSONA) LIKE '%N'
OR UPPER(p.NOMBRE_PERSONA) LIKE '%S'
OR UPPER(p.NOMBRE_PERSONA) LIKE '%E')
AND p.SEXO_PERSONA IS NULL;

--9. Mostrar el nombre de las películas que el número total de días que se han
--estrenado sea mayor de 50.

SELECT p.TITULO_P
FROM PELICULA p, PROYECCION pro
WHERE p.CIP = pro.CIP 
GROUP BY p.TITULO_P 
HAVING SUM(pro.DIAS_ESTRENO)>50;

--10. Mostrar el nombre del cine, junto con su dirección y la ciudad en la que está,
--junto con la sala y el aforo de la sala, y el nombre de las películas que se han
--proyectado en esa sala. Los datos deben salir ordenados por el nombre del cine, la
--sala del cine y por último el nombre de la película (puedes usar el nombre en
--versión original o en español como quieras).

SELECT c.CINE, c.DIRECCION_CINE , c.CIUDAD_CINE , s.SALA , s.AFORO , p.TITULO_P 
FROM CINE c , SALA s , PROYECCION pro, PELICULA p
ORDER BY c.CINE ASC, s.SALA ASC, p.TITULO_P ASC; 

--11. Realizar una consulta que muestre por cada uno de los posibles trabajos(tareas)
--que se pueden realizar en nuestra base de datos, el número de personas que han
--realizado dicho trabajo.
--Ten en cuenta que si una persona ha realizado dos veces el mismo trabajo sólo
--deberá salir una vez.
SELECT t.TAREA, COUNT(DISTINCT t.CIP) num_personas
FROM TRABAJO t 
GROUP BY t.TAREA;

--12. Mostrar todos los datos de las películas estrenadas entre el 20 de septiembre de
--1995 y el 15 de diciembre de 1995. Si la película se ha estrenado dos o más veces
--en esas fechas sólo debe salir una vez.
SELECT DISTINCT p.* 
FROM PELICULA p , PROYECCION pro
WHERE TO_CHAR(pro.FECHA_ESTRENO,'YYYY/MM/DD') >= '1995/09/20' 
AND TO_CHAR(pro.FECHA_ESTRENO,'YYYY/MM/DD') <= '1995/12/15';

--13. Mostrar el nombre de los cines y la ciudad en la que se han proyectado 22 o
--más películas distintas en todas sus salas.
SELECT c.CINE , c.CIUDAD_CINE
FROM CINE c , SALA s , PROYECCION pro
WHERE c.CINE = s.CINE 
AND s.CINE = pro.CINE 
GROUP BY pro.CIP, c.CINE ,c.CIUDAD_CINE 
HAVING  COUNT(pro.CIP) >=22;

-- 14. Obtener el nombre de la película y el presupuesto de todas las películas
--americanas estrenadas en un cine de Córdoba, sabiendo que Córdoba está escrito
--sin tilde en la base de datos y puede estar en mayúsculas o minúsculas.
SELECT DISTINCT p.TITULO_P , p.PRESUPUESTO 
FROM PELICULA p , PROYECCION pro, SALA s , CINE c 
WHERE p.CIP = pro.CIP  
AND pro.CINE = s.CINE 
AND s.CINE = c.CINE 
AND UPPER(p.NACIONALIDAD) LIKE 'EE.UU'
AND UPPER(c.CIUDAD_CINE) LIKE 'CORDOBA';

--15. Obtener el título y la recaudación total obtenida por películas que contengan en
--su TITULO_P la cadena 'vi' en minúsculas o el número 7.
SELECT p.TITULO_P , SUM(pro.RECAUDACION) recaudacion_total
FROM PELICULA p, PROYECCION pro
WHERE p.CIP = pro.CIP 
AND p.TITULO_P LIKE '%vi%' OR p.TITULO_P LIKE '%7%'
GROUP BY p.TITULO_P;

-- 16. Obtener el presupuesto máximo y el presupuesto mínimo para las películas.
--Deberás utilizar los alias necesarios.
SELECT MAX(p.PRESUPUESTO) presupuesto_max , MIN(p.PRESUPUESTO) presupuesto_min
FROM PELICULA p ;

-- 17. Explica en qué consiste el OUTER JOIN e indica un ejemplo justificándolo e
-- incluyendo la sentencia correspondiente.
/*
 * El outer join es un de los tipos de join que hay. 
 * El outer join consiste en que cuando estamos "uniendo" tablas atrabas de un join
 * queremos que meustre tambien los datos de la union que está en nulo
 * osea que si estamos uniendo la tabla pelicula p y proyeccion pro
 * y en proyeccion tenemos datos nulos y los queremos mostrar, tenemos que usar el outer join
 * 
 * y sería de la siguente forma: p.cip = pro.cip (+)
 * con (+) que lo ponemos en la tabla donde tenemos los datos nulos ya podemos forzar a 
 * mostrarlos.
 * */

-- 18. Se desea obtener un listado de todas las proyecciones, adicionalmente deberá
--aparecer en el listado otra columna que se llame fecha_estimada y cuyos valores a
--mostrar sean la fecha de estreno con un incremento de 2 meses.
SELECT p.*, p.FECHA_ESTRENO + (EXTRACT(MONTH FROM p.FECHA_ESTRENO)+2)  fecha_estimada
FROM PROYECCION p; 

-- 19. Mostrar todos los datos de películas junto con los datos de sus proyecciones. En
--este listado deben aparecer tanto las películas que tienes proyecciones como las
--que no tienen proyección.
SELECT p.*, pro.*
FROM PELICULA p , PROYECCION pro
WHERE p.CIP = pro.CIP(+);




