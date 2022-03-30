    --1. Mostrar el nombre y apellidos de todos los afiliados que tengan una 
    --licencia que empieza por A.
        SELECT a.NOMBRE, a.APELLIDOS
        FROM AFILIADOS a, PERMISOS p 
        WHERE a.FICHA = p.FICHA
        AND UPPER(p.LICENCIA) LIKE 'A%';
    
    --2. Mostrar los nombres de los peces que se han capturado en los eventos 
    --celebrados durante el año de 1998 indicando el nombre de la comunidad en 
    --la que se celebraron junto con el nombre y apellido del afiliado que lo 
    --capturó. La información debe aparecer ordenada por comunidad, luego por 
    --peces y por último por apellido del afiliado.
        SELECT DISTINCT cv.PEZ, cv.EVENTO, a.NOMBRE, a.APELLIDOS
        FROM CAPTURASEVENTOS cv, AFILIADOS a
        WHERE a.FICHA = cv.FICHA
        AND EXTRACT(YEAR FROM cv.FECHA_PESCA) = 1998
        ORDER BY cv.EVENTO, cv.PEZ, a.APELLIDOS;
    
    --3. Mostrar los eventos, el lugar y los cauces en los que se han celebrado 
    --eventos internacionales (el nombre del evento contiene la palabra internacional 
    --en mayúsculas o minúsculas). Hay que hacer esta sentencia con JOIN.
        SELECT DISTINCT cv.EVENTO, l.LUGAR, l.CAUCE
        FROM CAPTURASEVENTOS cv, LUGARES l, afiliados a, CAPTURASSOLOS cs
        WHERE cv.FICHA = a.ficha
        AND a.FICHA = cs.FICHA
        AND cs.LUGAR = l.LUGAR
        AND UPPER(cv.EVENTO) LIKE '%INTERNACIONAL%';
    
    --4. Para cada uno de los peces que ha sido pescado por un afiliado en solitario,
     --mostrar el nombre del pez, la talla, la fecha de pesca y la hora de la pesca,
      --mostrando los datos ordenador por peces y luego los más grandes.
        SELECT cs.PEZ, cs.TALLA, cs.FECHA_PESCA, cs.HORA_PESCA
        FROM CAPTURASSOLOS cs, AFILIADOS a
        WHERE a.FICHA = cs.FICHA
        ORDER BY cs.PEZ, cs.TALLA;
    
    --5. Mostrar todos los cauces en los que alguna vez algún afiliado ha pescado 
    --alguna vez un pez en solitario, siempre que el la relación talla/peso sea 
    --mayor que 3.
        SELECT DISTINCT l.CAUCE
        FROM AFILIADOS a, CAPTURASSOLOS cs, LUGARES l
        WHERE a.FICHA = cs.FICHA
        AND cs.LUGAR = l.LUGAR
        AND ((cs.TALLA / cs.PESO) > 3);
    
    --6. Mostrar el nombre y el apellido de los afiliados que han pescado algún 
    --pez en un evento y que en el campo de observaciones esté recogido que su 
    --hábitat es ríos.
        SELECT a.NOMBRE, a.APELLIDOS
        FROM AFILIADOS a, CAPTURASEVENTOS cv
        WHERE a.FICHA = cv.FICHA
        AND a.OBSERVACIONES IS NOT NULL;
    
    --7. Mostrar el nombre y el apellido del afiliado o afiliados que ha sido el 
    --primer avalador del afiliado con código 1000. 
        SELECT a.NOMBRE, a.APELLIDOS
        FROM AFILIADOS a, AFILIADOS a2
        WHERE a.APELLIDOS = a2.APELLIDOS
        AND a.FICHA = '1000';
    
    --8. Mostrar los eventos que se han celebrado en un lugar en el que el campo 
    --de observaciones no tiene valor.
        SELECT e.EVENTO
        FROM EVENTOS e
        WHERE e.OBSERVACIONES IS NULL;
    
    --9. Muestra el nombre y apellidos de todos las parejas de avales que existen 
    --en la base de datos. Es decir, debes mostrar el nombre y apellido del primer 
    --aval y el nombre y apellido del segundo aval.
        SELECT a.NOMBRE, a.APELLIDOS
        FROM AFILIADOS a, CAPTURASSOLOS cs
        WHERE a.FICHA = cs.FICHA;
    
    --10. Mostrar el nombre y apellido del afiliado o afiliados que han quedado 
    --en algunas de las cuatro primeras posiciones en algún evento o que participado 
    --en algún evento celebrado en el Coto De Dilar  o en el Coto De Fardes. 
    --(hay que hacer esta consulta sin utilizar JOIN)
        SELECT DISTINCT a.NOMBRE, a.APELLIDOS
        FROM AFILIADOS a, PARTICIPACIONES p
        WHERE a.FICHA = p.FICHA
        AND (p.POSICION <= 4
        OR UPPER(p.EVENTO) LIKE '%COTO DE DILAR%'
        OR UPPER(p.EVENTO) LIKE '%COTO DE FARDES%');
        
       -- Pagina para practicar SQL: https://josejuansanchez.org/bd/
    