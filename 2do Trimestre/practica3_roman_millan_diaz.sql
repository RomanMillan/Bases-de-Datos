  -- Practica 3 - Gestion de Empresa
    
	--1. Descuento medio aplicado en las facturas.
        SELECT ROUND(AVG(FACTURAS.DTO),2) media_descuento
        FROM FACTURAS;
	
    --2. Descuento medio aplicado en las facturas sin considerar los valores nulos.
        SELECT ROUND(AVG(FACTURAS.DTO),2) media_descuento
        FROM FACTURAS
        WHERE FACTURAS.DTO IS NOT NULL;
    
    --3. Descuento medio aplicado en las facturas considerando los valores nulos 
    --como cero.
        SELECT ROUND(AVG(NVL(FACTURAS.DTO,0)),2) media_descuento
        FROM FACTURAS;
    
    --4. Número de facturas.
        SELECT COUNT(FACTURAS.CODFAC) cant_fact
        FROM FACTURAS;
    
    --5. Número de pueblos de la Comunidad de Valencia.
        SELECT COUNT(PUEBLOS.CODPUE) cant_pueblos
        FROM PUEBLOS, PROVINCIAS
        WHERE PROVINCIAS.CODPRO = PUEBLOS.CODPRO
        AND UPPER(PROVINCIAS.NOMBRE)LIKE 'VALENCIA' ;
    
    --6. Importe total de los artículos que tenemos en el almacén. Este importe 
    --se calcula sumando el producto de las unidades en stock por el precio de 
    --cada unidad
        SELECT SUM(ARTICULOS.PRECIO * ARTICULOS.STOCK) importe_total
        FROM ARTICULOS;
    
    --7. Número de pueblos en los que residen clientes cuyo código postal 
    --empieza por ‘12’.
        SELECT DISTINCT COUNT(CLIENTES.CODPUE) num_pueblos
        FROM CLIENTES
        WHERE CLIENTES.CODPOSTAL LIKE '12%';
    
    --8. Valores máximo y mínimo del stock de los artículos cuyo precio oscila 
    --entre 9 y 12 € y diferencia entre ambos valores
        SELECT MAX(ARTICULOS.PRECIO) precio_max, MIN(ARTICULOS.PRECIO) precio_min,
        (MAX(ARTICULOS.PRECIO) - MIN(ARTICULOS.PRECIO)) diferencia_precio
        FROM ARTICULOS
        WHERE ARTICULOS.PRECIO BETWEEN 9 AND 12;
    
    --9. Precio medio de los artículos cuyo stock supera las 10 unidades.
        SELECT ROUND(AVG(ARTICULOS.PRECIO),2) precio_medio
        FROM ARTICULOS
        WHERE ARTICULOS.STOCK > 10;
    
    --10. Fecha de la primera y la última factura del cliente con código 210.
        SELECT MAX(FACTURAS.FECHA) ultima_fact, MIN(FACTURAS.FECHA) primera_fact
        FROM FACTURAS
        WHERE FACTURAS.CODCLI = 210 ;
    
    --11. Número de artículos cuyo stock es nulo.
        SELECT COUNT(ARTICULOS.CODART) cant_art_nul
        FROM ARTICULOS
        WHERE ARTICULOS.STOCK IS NULL;
    
    --12. Número de líneas cuyo descuento es nulo (con un decimal)
        SELECT COUNT(LINEAS_FAC.CODART) desc_nulo
        FROM LINEAS_FAC
        WHERE LINEAS_FAC.DTO IS NULL;
        
    --13. Obtener cuántas facturas tiene cada cliente.
        SELECT COUNT(FACTURAS.CODFAC) cant_fac
        FROM FACTURAS
        GROUP BY FACTURAS.CODCLI;
    
    --14. Obtener cuántas facturas tiene cada cliente, pero sólo si tiene dos o 
    --más  facturas.
        SELECT COUNT(FACTURAS.CODFAC) cant_fac
        FROM FACTURAS
        GROUP BY FACTURAS.CODCLI
        HAVING COUNT(FACTURAS.CODFAC) >=2;
    
    --15. Importe de la facturación (suma del producto de la cantidad por el
     --precio de las líneas de factura) de los  artículos
     --DUDA
        SELECT ARTICULOS.PRECIO * LINEAS_FAC.CANT importe_fact
        FROM ARTICULOS, LINEAS_FAC
        WHERE ARTICULOS.CODART = LINEAS_FAC.CODART;
        
    --16. Importe de la facturación (suma del producto de la cantidad por el 
    --precio de las líneas de factura) de aquellos artículos cuyo código contiene
     --la letra “A” (bien mayúscula o minúscula).
        SELECT ARTICULOS.PRECIO * LINEAS_FAC.CANT importe_fact
        FROM ARTICULOS, LINEAS_FAC
        WHERE ARTICULOS.CODART = LINEAS_FAC.CODART
        AND UPPER(ARTICULOS.CODART) LIKE '%A%';
    
    --17. Número de facturas para cada fecha, junto con la fecha
        SELECT COUNT(FACTURAS.CODFAC) num_facturas, FACTURAS.FECHA
        FROM FACTURAS
        GROUP BY FACTURAS.FECHA;
    
    --18. Obtener el número de clientes del pueblo junto con el nombre del pueblo 
    --mostrando primero los pueblos que más clientes tengan.
        SELECT COUNT(CLIENTES.CODCLI) num_clientes, PUEBLOS.NOMBRE
        FROM CLIENTES, PUEBLOS
        WHERE CLIENTES.CODPUE = PUEBLOS.CODPUE
        GROUP BY PUEBLOS.NOMBRE
        ORDER BY COUNT(CLIENTES.CODCLI)DESC;
    
    --19. Obtener el número de clientes del pueblo junto con el nombre del pueblo
    -- mostrando primero los pueblos que más clientes tengan, siempre y cuando 
     --tengan más de dos clientes.
        SELECT COUNT(CLIENTES.CODCLI) num_clientes, PUEBLOS.NOMBRE
        FROM CLIENTES, PUEBLOS
        WHERE CLIENTES.CODPUE = PUEBLOS.CODPUE
        GROUP BY PUEBLOS.NOMBRE
        HAVING COUNT(CLIENTES.CODCLI) > 2
        ORDER BY COUNT(CLIENTES.CODCLI)DESC;
     
    --20. Cantidades totales vendidas para cada artículo cuyo código empieza 
    --por “P", mostrando también la descripción de dicho artículo.
        SELECT COUNT(LINEAS_FAC.CANT) cant_totales_ven, ARTICULOS.DESCRIP
        FROM ARTICULOS, LINEAS_FAC
        WHERE ARTICULOS.CODART = LINEAS_FAC.CODART
        AND UPPER(ARTICULOS.CODART) LIKE 'P%'
        GROUP BY ARTICULOS.CODART, ARTICULOS.DESCRIP
        ORDER BY COUNT(LINEAS_FAC.CANT)DESC;
        
    -- 20EXTRA. Precio máximo y precio mínimo de venta (en líneas de facturas) 
    --para cada artículo cuyo código empieza por “c”.
        SELECT MAX(LINEAS_FAC.PRECIO)precio_max, MIN(LINEAS_FAC.PRECIO) precio_min
        FROM LINEAS_FAC
        WHERE UPPER(LINEAS_FAC.CODART) LIKE 'C%';
    
    --21. Igual que el anterior pero mostrando también la diferencia entre el 
    --precio máximo y mínimo.
        SELECT MAX(LINEAS_FAC.PRECIO)precio_max, 
        MIN(LINEAS_FAC.PRECIO) precio_min,
        MAX(LINEAS_FAC.PRECIO) - MIN(LINEAS_FAC.PRECIO)diferencia
        FROM LINEAS_FAC
        WHERE UPPER(LINEAS_FAC.CODART) LIKE 'C%';
    
    --22. Nombre de aquellos artículos de los que se ha facturado más de 
    -- 10000 euros.
        SELECT ARTICULOS.DESCRIP
        FROM ARTICULOS, LINEAS_FAC
        WHERE ARTICULOS.CODART = LINEAS_FAC.CODART
        AND LINEAS_FAC.PRECIO > 10000;
    
    --23. Número de facturas de cada uno de los clientes cuyo código está 
    --entre 150 y 300 (se debe mostrar este código), con cada IVA distinto 
    --que se les ha aplicado.
        SELECT COUNT(FACTURAS.CODFAC) num_fact
        FROM FACTURAS
        WHERE FACTURAS.CODCLI BETWEEN 150 AND 300
        GROUP BY FACTURAS.IVA;
    
    --24. Media del importe de las facturas, sin tener en cuenta impuestos 
    --ni descuentos.
        SELECT ROUND(AVG(LINEAS_FAC.PRECIO),2) media_importe
        FROM LINEAS_FAC;