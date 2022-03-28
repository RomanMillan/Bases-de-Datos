-- Ejercicio 1 - Empresa Gestion
    --1. Código, fecha y doble del descuento de las facturas con iva cero.
    SELECT FACTURAS.CODFAC, FACTURAS.FECHA, NVL(FACTURAS.DTO,0) *2 doble_descuento
    FROM FACTURAS
    WHERE FACTURAS.IVA = 0;
    
    --2. Código de las facturas con iva nulo.
    SELECT FACTURAS.CODFAC
    FROM FACTURAS
    WHERE FACTURAS.IVA IS NULL;
    
    --3. Código y fecha de las facturas sin iva (iva cero o nulo).
    SELECT FACTURAS.CODFAC, FACTURAS.FECHA
    FROM FACTURAS
    WHERE FACTURAS.IVA = 0 
    OR FACTURAS.IVA IS NULL; 
    
    --4. Código de factura y de artículo de las líneas de factura en las que la cantidad solicitada 
    --es menor de 5 unidades y además se ha aplicado un descuento del 25% o mayor.
    SELECT LINEAS_FAC.CODFAC, LINEAS_FAC.LINEA
    FROM LINEAS_FAC
    WHERE LINEAS_FAC.CANT < 5 
    AND LINEAS_FAC.DTO >= 25;
    
    --5. Obtener la descripción de los artículos cuyo stock está por debajo del stock mínimo, 
    --dado también la cantidad en unidades necesaria para alcanzar dicho mínimo.
    SELECT ARTICULOS.DESCRIP, ARTICULOS.STOCK_MIN - NVL(ARTICULOS.STOCK,0) cant_a_alcanzar
    FROM ARTICULOS
    WHERE NVL(ARTICULOS.STOCK,0) < ARTICULOS.STOCK_MIN;
    
    --6. Ivas distintos aplicados a las facturas.
    SELECT DISTINCT NVL(FACTURAS.IVA,0)
    FROM FACTURAS;
    
    --7. Código, descripción y stock mínimo de los artículos de los que se desconoce la 
    --cantidad de stock. Cuando se desconoce la cantidad de stock de un artículo, el stock es nulo.
    SELECT ARTICULOS.CODART, ARTICULOS.DESCRIP, ARTICULOS.STOCK_MIN
    FROM ARTICULOS
    WHERE ARTICULOS.STOCK IS NULL;

    --8. Obtener la descripción de los artículos cuyo stock es más de tres veces su 
    --stock mínimo y cuyo precio supera los 6 euros.
    SELECT ARTICULOS.DESCRIP
    FROM ARTICULOS
    WHERE ((ARTICULOS.STOCK_MIN * 3) < ARTICULOS.STOCK)
    AND ARTICULOS.PRECIO > 6.0;

    
    --9. Código de los artículos (sin que salgan repetidos) comprados en aquellas 
    --facturas cuyo código está entre 8 y 10.
    SELECT DISTINCT LINEAS_FAC.CODART
    FROM LINEAS_FAC
    WHERE LINEAS_FAC.CODFAC BETWEEN 8 AND 10;
    
    --10. Mostrar el nombre y la dirección de todos los clientes.
    SELECT CLIENTES.NOMBRE, CLIENTES.DIRECCION
    FROM CLIENTES;
    
    --11. Mostrar los distintos códigos de pueblos en donde tenemos clientes
    SELECT DISTINCT CLIENTES.CODPUE
    FROM CLIENTES;
    
    --12. Obtener los códigos de los pueblos en donde hay clientes con código de 
    --cliente menor que el código 25. No deben salir códigos repetidos.
    SELECT DISTINCT CLIENTES.CODPUE
    FROM CLIENTES
    WHERE CLIENTES.CODCLI < 25;
    
    --13. Nombre de las provincias cuya segunda letra es una 'O' (bien mayúscula o minúscula).
    SELECT PROVINCIAS.NOMBRE
    FROM PROVINCIAS
    WHERE UPPER(PROVINCIAS.NOMBRE) LIKE '_O%';
    
    --14. Código y fecha de las facturas del año pasado para aquellos clientes 
    -- cuyo código se encuentra entre 50 y 100.
    SELECT FACTURAS.CODFAC, FACTURAS.FECHA
    FROM FACTURAS
    WHERE EXTRACT(YEAR FROM FACTURAS.FECHA) = EXTRACT(YEAR FROM SYSDATE) - 1
    AND FACTURAS.CODCLI BETWEEN 50 AND 100;
   
   -- Para restarle o sumar (años, meses, dias  yla cantidad) 
   -- 12 meses a la fecha actual
   SELECT sysdate, add_months(sysdate,-12)FROM dual;
   
    --15. Nombre y dirección de aquellos clientes cuyo código postal empieza por “12”. 
    SELECT CLIENTES.NOMBRE, CLIENTES.DIRECCION
    FROM CLIENTES
    WHERE CLIENTES.CODPOSTAL LIKE '12%';
    
    --16. Mostrar las distintas fechas, sin que salgan repetidas, de las factura 
    --existentes de clientes cuyos códigos son menores que 50.
    SELECT DISTINCT FACTURAS.FECHA
    FROM FACTURAS
    WHERE FACTURAS.CODCLI <50;
    
    --17. Código y fecha de las facturas que se han realizado durante el mes de junio del año 2004
    SELECT FACTURAS.CODFAC, FACTURAS.FECHA
    FROM FACTURAS
    WHERE EXTRACT(MONTH FROM FACTURAS.FECHA) = 6 
    AND EXTRACT(YEAR FROM FACTURAS.FECHA) = 2004; 
    
    --18. Código y fecha de las facturas que se han realizado durante el mes de 
    --junio del año 2004 para aquellos clientes cuyo código se encuentra entre 100 y 250.
    SELECT FACTURAS.CODFAC, FACTURAS.FECHA
    FROM FACTURAS
    WHERE EXTRACT(MONTH FROM FACTURAS.FECHA) = 6 
    AND EXTRACT(YEAR FROM FACTURAS.FECHA) = 2004
    AND FACTURAS.CODCLI BETWEEN 100 AND 250;

    --19. Código y fecha de las facturas para los clientes cuyos códigos están entre 
    --90 y 100 y no tienen iva. NOTA: una factura no tiene iva cuando éste es cero o nulo.
    SELECT FACTURAS.CODFAC, FACTURAS.FECHA
    FROM FACTURAS
    WHERE FACTURAS.CODCLI BETWEEN 90 AND 100
    AND FACTURAS.IVA IS NULL OR FACTURAS.IVA = 0;
    
    --20. Nombre de las provincias que terminan con la letra 's' (bien mayúscula o minúscula).
    SELECT PROVINCIAS.NOMBRE
    FROM PROVINCIAS
    WHERE UPPER(PROVINCIAS.NOMBRE) LIKE '%S';
    
    --21. Nombre de los clientes cuyo código postal empieza por “02”, “11” ó “21”.
    SELECT CLIENTES.NOMBRE
    FROM CLIENTES
    WHERE CLIENTES.CODPOSTAL LIKE '02%' 
    OR CLIENTES.CODPOSTAL LIKE '11%'
    OR CLIENTES.CODPOSTAL LIKE '21%';
    
    --22. Artículos (todas las columnas) cuyo stock sea mayor que el stock mínimo y 
    --no haya en stock más de 5 unidades del stock_min.
   	SELECT *
    FROM ARTICULOS
    WHERE ARTICULOS.STOCK > ARTICULOS.STOCK_MIN
    AND (ARTICULOS.STOCK - ARTICULOS.STOCK_MIN) BETWEEN 1 AND 5;
    
    --23. Nombre de las provincias que contienen el texto “MA” (bien mayúsculas o minúsculas).
    SELECT PROVINCIAS.NOMBRE
    FROM PROVINCIAS
    WHERE UPPER(PROVINCIAS.NOMBRE) LIKE '%MA%';
    
    --24. Se desea promocionar los artículos de los que se posee un stock grande. 
    --Si el artículo es de más de 6000 € y el stock supera los 60000 €, se hará un descuento del 10%. 
    -- Mostrar un listado de los artículos que van a entrar en la promoción, con su código de 
    --artículo, nombre del articulo, precio actual y su precio en la promoción.
    SELECT ARTICULOS.CODART, ARTICULOS.DESCRIP, ARTICULOS.PRECIO precio_actual,
    ARTICULOS.PRECIO-(ARTICULOS.PRECIO*0.10) precio_promocion
    FROM ARTICULOS
    WHERE ARTICULOS.PRECIO  > 6000
    AND ARTICULOS.PRECIO * ARTICULOS.STOCK > 60000;
