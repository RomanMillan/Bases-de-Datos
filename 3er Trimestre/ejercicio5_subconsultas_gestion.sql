   --Gestion - Practica 5 - subconsultas
    --1. Número de clientes que tienen alguna factura con IVA 16%.
       SELECT count(c.CODCLI) num_clientes
       FROM clientes c
       WHERE c.CODCLI IN 
                   (SELECT f.CODCLI
                   FROM FACTURAS f
                   WHERE f.IVA = 16);
    
    --2. Número de clientes que no tienen ninguna factura con un 16% de IVA.
        SELECT count(c.CODCLI) num_clientes
           FROM clientes c
           WHERE c.CODCLI IN 
                       (SELECT f.CODCLI
                       FROM FACTURAS f
                       WHERE f.IVA != 16);
    
    --3. Número de clientes que en todas sus facturas tienen un 16% de IVA 
    --(los clientes deben tener al menos una factura).
        SELECT COUNT(c.CODCLI) num_clientes
           FROM clientes c
           WHERE c.CODCLI IN
                       (SELECT f.CODCLI
                       FROM FACTURAS f
                       WHERE f.IVA = 16)
            AND c.CODCLI NOT IN 
                       (SELECT f.CODCLI
                       FROM FACTURAS f
                       WHERE f.IVA != 16);
    
    --4. Fecha de la factura con mayor importe (sin tener en cuenta descuentos
    --ni impuestos).
         SELECT f.FECHA 
         FROM FACTURAS f, LINEAS_FAC lf 
         where f.CODFAC = lf.CODFAC
         AND lf.PRECIO =
                     (SELECT MAX(PRECIO) 
                     FROM LINEAS_FAC);
     
    --5. Número de pueblos en los que no tenemos clientes.
        SELECT COUNT(p.CODPUE) num_pueblos
        FROM PUEBLOS p
        WHERE p.CODPUE NOT IN
                (SELECT distinct c.CODPUE
                FROM CLIENTES c);
    
    --6. Número de artículos cuyo stock supera las 20 unidades, con precio 
    --superior a 15 euros y de los que no hay ninguna factura en el último 
    --trimestre del año pasado.
        SELECT COUNT(a.CODART) num_articulos
        FROM ARTICULOS a, LINEAS_FAC lf, FACTURAS f
        WHERE a.CODART = lf.CODART
        AND f.CODFAC = lf.CODFAC
        AND a.STOCK > 20
        AND a.PRECIO > 15
        AND f.CODFAC NOT IN
                    (SELECT f2.CODFAC
                    FROM FACTURAS f2
                    WHERE EXTRACT(YEAR FROM f2.FECHA) = EXTRACT(YEAR FROM SYSDATE -1));
        
    
    --7. Obtener el número de clientes que en todas las facturas del año 
    --pasado han pagado IVA (no se ha pagado IVA si es cero o nulo).
        SELECT COUNT(c.CODCLI) num_clientes
        FROM CLIENTES c
        WHERE c.CODCLI IN
                    (SELECT distinct f.CODCLI
                    FROM FACTURAS f
                    WHERE f.IVA != 0
                    AND f.IVA IS NOT NULL
                    AND EXTRACT(YEAR FROM f.FECHA) = EXTRACT(YEAR FROM SYSDATE -1));
    
    --8. Clientes (código y nombre) que fueron preferentes durante el mes de 
    --noviembre del año pasado y que en diciembre de ese mismo año no tienen 
    --ninguna factura. Son clientes preferentes de un mes aquellos que han 
    --solicitado más de 60,50 euros en facturas durante ese mes, sin tener 
    --en cuenta descuentos ni impuestos.
        SELECT c.CODCLI, c.NOMBRE
        FROM CLIENTES c
        WHERE c.CODCLI IN 
                    (SELECT distinct f.CODCLI
                    FROM FACTURAS f, LINEAS_FAC fl
                    WHERE f.CODFAC = fl.CODFAC
                    AND fl.PRECIO >= 50
                    AND EXTRACT(MONTH FROM f.FECHA)=11
                    AND EXTRACT(YEAR FROM f.FECHA) = EXTRACT(YEAR FROM SYSDATE -1));
    
    --9. Código, descripción y precio de los diez artículos más caros.
        SELECT CODART, DESCRIP, PRECIO
        FROM (SELECT a.CODART, a.DESCRIP, a.PRECIO, SUM(a.PRECIO)
             FROM ARTICULOS a
             GROUP BY a.CODART, a.DESCRIP, a.PRECIO
             ORDER BY SUM(a.PRECIO)desc)
        WHERE rownum<=20; 
                    
    
    --10. Nombre de la provincia con mayor número de clientes.
        SELECT pr.NOMBRE
        FROM CLIENTES c, PUEBLOS p, PROVINCIAS pr
        WHERE c.CODPUE = p.CODPUE
        AND p.CODPRO = pr.CODPRO 
        group by pr.NOMBRE, pr.CODPRO
        having COUNT(c.CODCLI) = (SELECT MAX(COUNT(c2.CODCLI))
                                FROM CLIENTES c2, PUEBLOS p2, PROVINCIAS pr2
                                WHERE c2.CODPUE = p2.CODPUE
                                AND p2.CODPRO = pr2.CODPRO 
                                GROUP BY pr2.CODPRO);

    --11. Código y descripción de los artículos cuyo precio es mayor de 90,15
    --euros y se han vendido menos de 10 unidades (o ninguna) durante el año
    --pasado.
        SELECT a.CODART, a.DESCRIP
        FROM ARTICULOS a, LINEAS_FAC lf
        WHERE a.PRECIO > 90.15
        AND a.CODART = lf.CODART
        AND lf.CODART IN
                        (SELECT lf2.CODART
                        FROM LINEAS_FAC lf2, FACTURAS f
                        WHERE lf2.CODFAC = f.CODFAC
                        AND EXTRACT(YEAR FROM f.FECHA) = EXTRACT(YEAR FROM SYSDATE -1)
                        GROUP BY lf2.CODART
                        HAVING COUNT(lf2.CODART)<10);
      
    --12. Código y descripción de los artículos cuyo precio es más de tres 
    --mil veces mayor que el precio mínimo de cualquier artículo.
        SELECT a.CODART, a.DESCRIP
        FROM ARTICULOS a
        WHERE a.PRECIO >
                    (SELECT MIN(a2.PRECIO)*3000
                    FROM ARTICULOS a2);
         
    --13. Nombre del cliente con mayor facturación.
        SELECT c.NOMBRE
        FROM CLIENTES c, FACTURAS f, LINEAS_FAC fl
        WHERE c.CODCLI = f.CODCLI
        AND f.CODFAC = fl.CODFAC
        AND fl.PRECIO =
                    (SELECT MAX(lf2.precio)
                    FROM LINEAS_FAC lf2);
    
    --14. Código y descripción de aquellos artículos con un precio superior 
    --a la media y que hayan sido comprados por más de 5 clientes.
        SELECT a.CODART, a.DESCRIP
        FROM ARTICULOS a, LINEAS_FAC lf, FACTURAS f
        WHERE a.CODART = lf.CODART
        AND lf.CODFAC = f.CODFAC
        AND a.PRECIO > 
                    (SELECT AVG(a2.PRECIO)
                    FROM ARTICULOS a2)
        AND f.CODCLI IN
                    (SELECT f2.CODCLI
                    FROM FACTURAS f2, LINEAS_FAC lf2
                    WHERE f2.CODFAC = lf2.CODFAC
                    GROUP BY lf2.CODFAC, f2.CODCLI
                    HAVING COUNT(f2.CODCLI)>5);
        
        