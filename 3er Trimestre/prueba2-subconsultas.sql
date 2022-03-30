    --1. Mostrar el nombre de los peces que únicamente se hayan capturado 
    --por libre.
    	SELECT distinct cs.pez
    	FROM afiliados a, capturassolos cs
    	WHERE a.ficha = cs.ficha;
    
    --2. A la siguiente consulta la llamaremos el pez madrugador, debes 
    --mostrar el pez que ha sido capturado más temprano por libre.
    	SELECT distinct cs.pez
    	FROM afiliados a, capturassolos cs
    	WHERE a.ficha = cs.ficha
    	AND cs.HORA_PESCA =
				    	(SELECT MIN(c2.HORA_PESCA)
				    	FROM CAPTURASSOLOS c2);
    
    
    --3. Obtén la mejor posición alcanzada en competición a lo largo de su 
    --vida por el afiliado 1002. Debe aparecer, además de la posición, el 
    --evento en que la alcanzó y el trofeo obtenido.
       
				    
    --4. Obtén el nombre y apellidos de todas las personas que en alguno de 
    --los eventos '1er Encuentro Lures and Pikes' hayan realizado capturas 
    --de un peso superior a la media que se registró en dicho evento.
       
    --5. Obtén todas las personas que han realizado una captura en solitario 
    --pero que nunca han avalado la captura de otro.
       
    --6. Confirma si alguien ha capturado más de 5 peces en el evento 
    --'Super Barbo', mostrando el número de ficha, el pez capturado y 
    --la cantidad de capturas. Si nadie ha infringido las normas, el 
    --resultado de la consulta es 'ninguna fila'.
       
    --7. Elimina las capturas de los aquellos usuarios que se hayan 
    --avalado a sí mismos.
       
    --8. Actualiza el peso de la trucha con mayor peso de capturasolos 
    --al peso de la trucha más pesada en el evento 'La Gran Trucha'.
       
    --9. Se ha detectado un error en la báscula de 0.5 kg en el evento 
    --“Super Carpa”, por lo que hay que actualizar el peso (sumando 0.5 kg)
    --a todas las capturas de dicho evento.  
       
    --10. Se desea modificar la tabla participaciones añadiendo un 
    --campo premio, a continuación deberás dejar en el campo trofeo 
    --solo copa y en el campo premio el importe del premio.
    
    
       