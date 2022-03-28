--Escribe en un fichero de texto las sentencias que responden a las siguientes preguntas identificando el 
--número de respuesta. Debes realizar al menos un JOIN y una unión de tablas con WHERE.

   -- 1. Nombre, apellido y teléfono de todos los afiliados que sean hombres y que hayan nacido 
   -- antes del 1 de enero de 1070
		SELECT a.NOMBRE , a.APELLIDOS, a.TELF  
		FROM AFILIADOS a 
		WHERE a.SEXO ='H'
		AND EXTRACT(YEAR FROM a.NACIMIENTO) < 1970;

   -- 2. Peso, talla  y nombre de todos los peces que se han pescado por con talla inferior o igual a 45. 
   -- Los datos deben salir ordenados por el nombre del pez, y para el mismo pez por el peso (primero los más grandes)
    --y para el mismo peso por la talla (primero los más grandes).

    --3. Obtener los nombres y apellidos de los afiliados que o bien tienen la licencia de pesca que comienzan 
    --con una A (mayúscula o minúscula), o bien el teléfono empieza en 9 y la dirección comienza en Avda.

    --4. Lugares del cauce “Rio Genil” que en el campo de observaciones no tengan valor.

   -- 5. Mostrar el nombre y apellidos de cada afiliado, junto con la ficha de los afiliados que lo
    --han avalado alguna vez como primer avalador.

    --6. Obtén los cauces y en qué lugar de ellos han encontrado tencas (tipo de pez) cuando nuestros afiliados 
   -- han ido a pescar solos, indicando la comunidad a la que pertenece dicho lugar. (no deben salir valores repetidos)

    --7. Mostrar el nombre y apellido de los afiliados que han conseguido alguna copa. Los datos deben salir 
    --ordenador por la fecha del evento, mostrando primero los eventos más antiguos.

   -- 8. Obtén la ficha, nombre, apellidos, posición y trofeo de todos los participantes del evento 'Super Barbo'
    --mostrándolos según su clasificación.


   -- 9. Mostrar el nombre y apellidos de cada afiliado, junto con el nombre y apellidos de los afiliados que lo
   -- han avalado alguna vez como segundo avalador.

    --10. Indica todos los eventos en los que participó el afiliado 3796 en 1995 que no consiguió trofeo, 
    --ordenados descendentemente por fecha.
    
    
    
    
    