    --Practicas variadas Peces
    
--Escribe en un fichero de texto las sentencias que responden a las siguientes 
--preguntas identificando el número de respuesta. Debes realizar al menos un JOIN
-- y una unión de tablas con WHERE.

   -- 1. Nombre, apellido y teléfono de todos los afiliados que sean hombres y que 
   --hayan nacido antes del 1 de enero de 1070
		SELECT a.NOMBRE , a.APELLIDOS, a.TELF  
		FROM AFILIADOS a 
		WHERE a.SEXO ='H'
		AND EXTRACT(YEAR FROM a.NACIMIENTO) < 1970;

   -- 2. Peso, talla  y nombre de todos los peces que se han pescado por con talla 
   --inferior o igual a 45. Los datos deben salir ordenados por el nombre del pez,
    --y para el mismo pez por el peso (primero los más grandes)y para el mismo peso 
    --por la talla (primero los más grandes).
    
       -- BIEN HECHO
       SELECT  PESO, TALLA, PEZ
       FROM CAPTURASSOLOS 
		WHERE TALLA <= 45
		UNION
		SELECT  PESO, TALLA, PEZ
       FROM CAPTURASSOLOS 
		WHERE TALLA <= 45
	    ORDER BY PEZ DESC, PESO DESC, TALLA DESC  ;     
       
	    
	    
    --3. Obtener los nombres y apellidos de los afiliados que o bien tienen la 
    --licencia de pesca que comienzan con una A (mayúscula o minúscula), o 
    --bien el teléfono empieza en 9 y la dirección comienza en Avda.
        SELECT DISTINCT a.NOMBRE, a.APELLIDOS
        FROM AFILIADOS a, PERMISOS p
        WHERE a.FICHA = p.FICHA
        AND (UPPER(p.LICENCIA) LIKE 'A%'
        OR (a.TELF LIKE '9%'
        AND a.DIRECCION LIKE 'Avda%'));
        
    --4. Lugares del cauce “Rio Genil” que en el campo de observaciones no tengan valor.
        SELECT l.LUGAR
        FROM LUGARES l, CAUCES c
        WHERE c.CAUCE = l.CAUCE
        AND UPPER(l.CAUCE) LIKE '%RIO GENIL%'
        AND c.OBSERVACIONES IS NULL;
        
   -- 5. Mostrar el nombre y apellidos de cada afiliado, junto con la ficha de 
   --los afiliados que lo han avalado alguna vez como primer avalador.
        --NO COMPRENDO EL ENUNCIADO
        SELECT a.NOMBRE, a.APELLIDOS, a2.nombre, a2.APELLIDOS, a3.NOMBRE, a3.APELLIDOS
        FROM AFILIADOS a, CAPTURASSOLOS c, afiliados a2, afiliados a3
        WHERE a.FICHA = c.FICHA
        AND a2.FICHA = c.AVAL1
        AND a3.FICHA = c.AVAL2;
		

    --6. Obtén los cauces y en qué lugar de ellos han encontrado tencas (tipo de pez) 
    --cuando nuestros afiliados han ido a pescar solos, indicando la comunidad a 
    --la que pertenece dicho lugar. (no deben salir valores repetidos)
        SELECT l.LUGAR, c.CAUCE, l.COMUNIDAD
        FROM LUGARES l, CAUCES c, CAPTURASSOLOS cs
        WHERE c.CAUCE = l.CAUCE
        AND l.LUGAR = cs.LUGAR
        AND UPPER(cs.PEZ) LIKE 'TENCA';

    --7. Mostrar el nombre y apellido de los afiliados que han conseguido alguna copa.
    --Los datos deben salir ordenador por la fecha del evento, mostrando primero 
    --los eventos más antiguos.
        SELECT DISTINCT a.NOMBRE, a.APELLIDOS
        FROM AFILIADOS a, PARTICIPACIONES p
        WHERE a.FICHA = p.FICHA
        AND UPPER(p.TROFEO) LIKE '%COPA%';      
        
   -- 8. Obtén la ficha, nombre, apellidos, posición y trofeo de todos los participantes 
   --del evento 'Super Barbo' mostrándolos según su clasificación.
        SELECT a.FICHA, a.NOMBRE, a.APELLIDOS, p.POSICION, p.TROFEO
        FROM AFILIADOS a, PARTICIPACIONES p
        WHERE a.FICHA = p.FICHA
        AND UPPER(p.EVENTO) LIKE 'SUPER BARBO';
        
   -- 9. Mostrar el nombre y apellidos de cada afiliado, junto con el nombre y 
   --apellidos de los afiliados que lo han avalado alguna vez como segundo avalador.
        -- NO SE HACERLO
       SELECT DISTINCT a.NOMBRE, a.APELLIDOS, a2.nombre, a2.APELLIDOS
        FROM AFILIADOS a, CAPTURASSOLOS c, afiliados a2
        WHERE a.FICHA = c.FICHA
        AND a2.FICHA = c.AVAL2;
        
    --10. Indica todos los eventos en los que participó el afiliado 3796 en 1995 
    --que no consiguió trofeo, ordenados descendentemente por fecha.
        SELECT DISTINCT p.EVENTO
        FROM AFILIADOS a, PARTICIPACIONES p, CAPTURASEVENTOS ce
        WHERE a.FICHA = p.FICHA
        AND ce.FICHA = a.FICHA
        AND a.FICHA = '3796'
        AND EXTRACT(YEAR FROM ce.FECHA_PESCA) = 1995
        AND p.TROFEO IS NULL;
        
    
    
    
    