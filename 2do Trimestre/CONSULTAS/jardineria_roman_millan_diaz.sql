--Consultas multitabla (composición interna)
  --  1 Obtén un listado con el nombre de cada cliente y el nombre y apellido de
  -- su representante de ventas.
        SELECT c.NOMBRE_CLIENTE, e.NOMBRE, e.APELLIDO1
        FROM CLIENTE c, EMPLEADO e
        WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO;
        
    --2 Muestra el nombre de los clientes que hayan realizado pagos junto con el 
    --nombre de sus representantes de ventas.
        SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE
        FROM CLIENTE c, PAGO p, EMPLEADO e
        WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE
        AND c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO;
        
    --3 Muestra el nombre de los clientes que no hayan realizado pagos junto con el 
    --nombre de sus representantes de ventas.
        SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE
        FROM CLIENTE c, EMPLEADO e, PAGO p
        WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO 
        AND c.CODIGO_CLIENTE = p.CODIGO_CLIENTE(+)
        AND p.CODIGO_CLIENTE IS NULL;
        
    --4 Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus 
    --representantes junto con la ciudad de la oficina a la que pertenece 
    --el representante.
        SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE, o.CIUDAD
        FROM CLIENTE c, PAGO p, EMPLEADO e, OFICINA o
        WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE
        AND c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
        AND e.CODIGO_OFICINA = o.CODIGO_OFICINA;
       
        
    --5 Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre 
    --de sus representantes junto con la ciudad de la oficina a la que pertenece 
    --el representante.
        SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE, o.CIUDAD
        FROM CLIENTE c, PAGO p, EMPLEADO e, OFICINA o
        WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE (+)
        AND c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
        AND e.CODIGO_OFICINA = o.CODIGO_OFICINA
        AND p.CODIGO_CLIENTE IS NULL;
        
    --6 Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
        SELECT DISTINCT o.LINEA_DIRECCION1 direccion_oficinas
        FROM OFICINA o, EMPLEADO e, CLIENTE c
        WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA
        AND e.CODIGO_EMPLEADO = c.CODIGO_EMPLEADO_REP_VENTAS
        AND UPPER(c.CIUDAD) LIKE 'FUENLABRADA';
    
    --7 Devuelve el nombre de los clientes y el nombre de sus representantes junto 
    --con la ciudad de la oficina a la que pertenece el representante.
        SELECT DISTINCT c.NOMBRE_CLIENTE, e.NOMBRE, o.CIUDAD
        FROM CLIENTE c, EMPLEADO e, OFICINA o
        WHERE c.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
        AND e.CODIGO_OFICINA = o.CODIGO_OFICINA;
    
    --8 Devuelve un listado con el nombre de los empleados junto con el nombre 
    --de sus jefes.
        SELECT e.NOMBRE nom_empleado, j.NOMBRE nom_jefe
        FROM EMPLEADO e, EMPLEADO j
        WHERE e.CODIGO_JEFE = j.CODIGO_EMPLEADO;
    
    --9 Devuelve el nombre de los clientes a los que no se les ha entregado 
    --a tiempo un pedido.
        SELECT DISTINCT cl.NOMBRE_CLIENTE
        FROM CLIENTE cl, PEDIDO p
        WHERE cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE
        AND p.FECHA_ESPERADA < p.FECHA_ENTREGA;
    
    --10 Devuelve un listado de las diferentes gamas de producto que ha 
    --comprado cada cliente.
        SELECT DISTINCT pr.GAMA
        FROM CLIENTE c, PEDIDO p, DETALLE_PEDIDO d, PRODUCTO pr
        WHERE c.CODIGO_CLIENTE = p.CODIGO_CLIENTE
        AND p.CODIGO_PEDIDO = d.CODIGO_PEDIDO
        AND d.CODIGO_PRODUCTO = pr.CODIGO_PRODUCTO;
    
    
    
--Consultas multitabla (composición externa)
    --1 Devuelve un listado que muestre solamente los clientes que no han 
    --realizado ningún pago.
        SELECT cl.*
        FROM CLIENTE cl, PAGO p
        WHERE cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE(+)
        AND p.CODIGO_CLIENTE IS NULL;
        
    --2 Devuelve un listado que muestre solamente los clientes que no han 
    --realizado ningún pedido.
        SELECT cl.*
        FROM CLIENTE cl, PEDIDO pe
        WHERE cl.CODIGO_CLIENTE = pe.CODIGO_CLIENTE(+)
        AND pe.CODIGO_CLIENTE IS NULL;
        
    --3 Devuelve un listado que muestre los clientes que no han realizado ningún 
    --pago y los que no han realizado ningún pedido.
        SELECT cl.*
        FROM CLIENTE cl, pago pa, PEDIDO pe
        WHERE cl.CODIGO_CLIENTE = pe.CODIGO_CLIENTE(+)
        AND cl.CODIGO_CLIENTE = pa.CODIGO_CLIENTE(+)
        AND pa.CODIGO_CLIENTE IS NULL
        AND pe.CODIGO_CLIENTE IS NULL;

       
    --4 Devuelve un listado que muestre solamente los empleados que no tienen 
    --una oficina asociada.
        SELECT e.*
        FROM EMPLEADO e
        WHERE e.CODIGO_OFICINA IS NULL;
    
    --5 Devuelve un listado que muestre solamente los empleados que no tienen 
    --un cliente asociado.
        SELECT e.*
        FROM CLIENTE cl, EMPLEADO e
        WHERE cl.CODIGO_EMPLEADO_REP_VENTAS(+) = e.CODIGO_EMPLEADO
        AND cl.CODIGO_EMPLEADO_REP_VENTAS IS NULL;
        
    --6 Devuelve un listado que muestre los empleados que no tienen una oficina 
    --asociada y los que no tienen un cliente asociado.
        SELECT e.*
        FROM CLIENTE cl, EMPLEADO e 
        WHERE cl.CODIGO_EMPLEADO_REP_VENTAS(+) = e.CODIGO_EMPLEADO
        AND cl.CODIGO_EMPLEADO_REP_VENTAS IS NULL
        AND e.CODIGO_OFICINA IS NULL;
    
    --7 Devuelve un listado de los productos que nunca han aparecido en un pedido
        SELECT pr.*
        FROM PRODUCTO pr, DETALLE_PEDIDO d
        WHERE d.CODIGO_PRODUCTO(+) = pr.CODIGO_PRODUCTO
        AND d.CODIGO_PRODUCTO IS NULL;

    --8 Devuelve las oficinas donde no trabajan ninguno de los empleados que 
    --hayan sido los representantes de ventas de algún cliente que haya realizado 
    --la compra de algún producto de la gama Frutales.
        SELECT o.*
        FROM OFICINA o, EMPLEADO e, CLIENTE cl, PEDIDO p, DETALLE_PEDIDO d,
            PRODUCTO pr
        WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA (+)
        AND e.CODIGO_EMPLEADO = cl.CODIGO_EMPLEADO_REP_VENTAS
        AND cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE
        AND p.CODIGO_PEDIDO = d.CODIGO_PEDIDO
        AND d.CODIGO_PRODUCTO = pr.CODIGO_PRODUCTO
        AND e.CODIGO_OFICINA IS NULL
        AND UPPER(pr.GAMA) LIKE 'FRUTALES';
    
       
    --9 Devuelve un listado con los clientes que han realizado algún pedido, 
    --pero no han realizado ningún pago.
        SELECT DISTINCT cl.*
        FROM CLIENTE cl, PEDIDO p, PAGO pa
        WHERE cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE
        AND cl.CODIGO_CLIENTE = pa.CODIGO_CLIENTE (+)
        AND pa.CODIGO_CLIENTE IS NULL;
        
    
    --10 Devuelve un listado con los datos de los empleados que no tienen 
    --clientes asociados y el nombre de su jefe asociado.
        SELECT e.*, j.NOMBRE nombre_jefe
        FROM EMPLEADO e, EMPLEADO j, CLIENTE cl
        WHERE cl.CODIGO_EMPLEADO_REP_VENTAS (+) = e.CODIGO_EMPLEADO
        AND e.CODIGO_JEFE = j.CODIGO_EMPLEADO
        AND cl.CODIGO_EMPLEADO_REP_VENTAS IS NULL;


--Consultas resumen
    --1 ¿Cuántos empleados hay en la compañía?
        SELECT COUNT(e.CODIGO_EMPLEADO) num_empleados
        FROM EMPLEADO e;
    
    --2 ¿Cuántos clientes tiene cada país?
        SELECT cl.PAIS, COUNT(cl.CODIGO_CLIENTE) cand_clientes
        FROM CLIENTE cl
        GROUP BY cl.PAIS;
        
    --3 ¿Cuál fue el pago medio en 2009?
        SELECT TRUNC(AVG(p.TOTAL),2) pago_medio
        FROM PAGO p
        WHERE EXTRACT(YEAR FROM p.FECHA_PAGO) = 2009;
    
    --4 ¿Cuántos pedidos hay en cada estado? Ordena el resultado de forma 
    --descendente por el número de pedidos.
        SELECT COUNT(p.CODIGO_PEDIDO) cant_pedidos, p.ESTADO
        FROM PEDIDO p
        GROUP BY p.ESTADO
        ORDER BY COUNT(p.CODIGO_PEDIDO) DESC;
    
    --5 Calcula el precio de venta del producto más caro y más barato en una 
    --misma consulta.
        SELECT MAX(pr.PRECIO_VENTA) precio_max, MIN(pr.PRECIO_VENTA) precio_min
        FROM PRODUCTO pr;
    
    --6 Calcula el número de clientes que tiene la empresa.
        SELECT COUNT(c.CODIGO_CLIENTE) cant_clientes
        FROM CLIENTE c;
    
    --7 ¿Cuántos clientes tiene la ciudad de Madrid?
        SELECT COUNT(cl.CIUDAD) cant_clientes
        FROM CLIENTE cl
        WHERE UPPER(cl.CIUDAD) LIKE 'MADRID';
        
    --8 ¿Calcula cuántos clientes tiene cada una de las ciudades que empiezan por M?
        SELECT COUNT(cl.CIUDAD) canat_clientes
        FROM CLIENTE cl
        WHERE UPPER(cl.CIUDAD) LIKE 'M%'
       	GROUP BY cl.CIUDAD ;
    
    --9 Devuelve el código de empleado y el número de clientes al que atiende 
    --cada representante de ventas.
        SELECT e.CODIGO_EMPLEADO, COUNT(cl.CODIGO_CLIENTE) num_clientes
        FROM EMPLEADO e, CLIENTE cl
        WHERE cl.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
        GROUP BY e.CODIGO_EMPLEADO;
    
    --10 Calcula el número de clientes que no tiene asignado representante de ventas.
        SELECT COUNT(cl.CODIGO_CLIENTE) num_clientes
        FROM CLIENTE cl, EMPLEADO e
        WHERE cl.CODIGO_EMPLEADO_REP_VENTAS (+) = e.CODIGO_EMPLEADO
        AND cl.CODIGO_CLIENTE IS NULL;
    
    --11 Calcula la fecha del primer y último pago realizado por cada uno de 
    --los clientes.
        SELECT MIN(p.FECHA_PAGO) primera_fecha, MAX(p.FECHA_PAGO) ultima_fecha
        FROM PAGO p
        GROUP BY p.CODIGO_CLIENTE;
    
    --12 Calcula el número de productos diferentes que hay en cada uno de los pedidos.
        SELECT COUNT(DISTINCT pr.CODIGO_PRODUCTO) cant_productos
        FROM PEDIDO p, DETALLE_PEDIDO d, PRODUCTO pr
        WHERE p.CODIGO_PEDIDO = d.CODIGO_PEDIDO
        AND d.CODIGO_PRODUCTO = pr.CODIGO_PRODUCTO
        GROUP BY p.CODIGO_PEDIDO;
    
    --13 Calcula la suma de la cantidad total de todos los productos que aparecen
    -- en cada uno de los pedidos.
        SELECT SUM(d.CANTIDAD) suma_cantidad
        FROM DETALLE_PEDIDO d
        GROUP BY d.CODIGO_PEDIDO;
    
    --14 Devuelve un listado de los 20 códigos de productos más vendidos y el 
    --número total de unidades que se han vendido de cada uno. El listado deberá 
    --estar ordenado por el número total de unidades vendidas.
        -- NO SE SELECCIONAR EL TOP 20
        SELECT * 
        FROM (SELECT dp.codigo_producto, sum(dp.cantidad)
        		FROM detalle_pedido dp
        		GROUP BY dp.codigo_producto
        		ORDER BY sum(dp.cantidad)DESC)
        WHERE rownum<=20;
        
        
    --15 La facturación que ha tenido la empresa en toda la historia, indicando
    --la base imponible, el IVA y el total facturado. 
    --La base imponible se calcula sumando el coste del producto por el número 
    --de unidades vendidas de la tabla detalle_pedido. 
    -- El IVA es el 21 % de la base imponible, y el total la suma de los 
    --dos campos anteriores.
        SELECT SUM(d.PRECIO_UNIDAD * d.CANTIDAD) base_imponible, 
            SUM((d.PRECIO_UNIDAD * d.CANTIDAD) *0.21) iva, 
            SUM((d.PRECIO_UNIDAD * d.CANTIDAD) *1.21) total
        FROM DETALLE_PEDIDO d;
    
    --16 La misma información que en la pregunta anterior, pero agrupada por 
    --código de producto.
        SELECT SUM(d.PRECIO_UNIDAD * d.CANTIDAD) base_imponible, 
            SUM((d.PRECIO_UNIDAD * d.CANTIDAD) *0.21) iva, 
            SUM((d.PRECIO_UNIDAD * d.CANTIDAD) *1.21) total
        FROM DETALLE_PEDIDO d
        GROUP BY d.CODIGO_PRODUCTO;
    
    --17 La misma información que en la pregunta anterior, pero agrupada por 
    --código de producto filtrada por los códigos que empiecen por OR.
        SELECT SUM(d.PRECIO_UNIDAD * d.CANTIDAD) base_imponible, 
            SUM((d.PRECIO_UNIDAD * d.CANTIDAD) *0.21) iva, 
            SUM((d.PRECIO_UNIDAD * d.CANTIDAD) *1.21) total
        FROM DETALLE_PEDIDO d
        WHERE UPPER(d.CODIGO_PRODUCTO) LIKE 'OR%'
        GROUP BY d.CODIGO_PRODUCTO;
    
    --18 Lista las ventas totales de los productos que hayan facturado más de 
    --3000 euros. Se mostrará el nombre, unidades vendidas, total facturado y 
    --total facturado con impuestos (21% IVA).
        SELECT pr.NOMBRE, d.CANTIDAD, 
            SUM(d.PRECIO_UNIDAD * d.CANTIDAD) total_facturado,
            SUM(d.PRECIO_UNIDAD * d.CANTIDAD)*1.21 total_iva
        FROM PRODUCTO pr, DETALLE_PEDIDO d
        WHERE d.CODIGO_PRODUCTO = pr.CODIGO_PRODUCTO
        GROUP BY pr.NOMBRE, d.CANTIDAD
        HAVING SUM(d.PRECIO_UNIDAD * d.CANTIDAD) > 3000;
    
    
--Subconsultas
    --1 Devuelve el nombre del cliente con mayor límite de crédito.
       SELECT c.NOMBRE_CLIENTE 
       FROM  CLIENTE c 
       WHERE LIMITE_CREDITO = 
       						(SELECT MAX(LIMITE_CREDITO) 
       						FROM CLIENTE c2);
       
    --2 Devuelve el nombre, apellido1 y cargo de los empleados que no 
    --representen a ningún cliente.
       SELECT e.NOMBRE , e.APELLIDO1 , e.PUESTO 
       FROM EMPLEADO e , CLIENTE cl
       WHERE e.CODIGO_EMPLEADO  = cl.CODIGO_EMPLEADO_REP_VENTAS (+)
       AND cl.CODIGO_EMPLEADO_REP_VENTAS IS NULL;
      
        -- prueba.
       SELECT e.NOMBRE , e.APELLIDO1 , e.PUESTO 
       FROM EMPLEADO e 
       WHERE e.CODIGO_EMPLEADO NOT IN 
       							(SELECT c.CODIGO_EMPLEADO_REP_VENTAS  
       							FROM CLIENTE c
       							WHERE c.CODIGO_EMPLEADO_REP_VENTAS IS NULL);
       					
    --3 Devuelve el nombre del producto que tenga el precio de venta más caro.
      SELECT pro.NOMBRE
      FROM PRODUCTO pro
      WHERE pro.PRECIO_VENTA = 
                           (SELECT MAX(pro2.PRECIO_VENTA)
                            FROM PRODUCTO pro2);
      
    --4 Devuelve el nombre del producto del que se han vendido más unidades. 
    --(Ten en cuenta que tendrás que calcular cuál es el número total de unidades 
    --que se han vendido de cada producto a partir de los datos de la tabla 
    --detalle_pedido. Una vez que sepas cuál es el código del producto, puedes 
    --obtener su nombre fácilmente.)
        SELECT pro.NOMBRE
        FROM PRODUCTO pro, DETALLE_PEDIDO d
        WHERE pro.CODIGO_PRODUCTO = d.CODIGO_PRODUCTO
        GROUP BY pro.CODIGO_PRODUCTO , pro.NOMBRE 
        HAVING (sum(d.CANTIDAD) = 
        			(SELECT max(sum(d.CANTIDAD)
        			FROM DETALLE_PEDIDO dp  
        			GROUP BY dp.CODIGO_PRODUCTO );
        
  

    --5 Los clientes cuyo límite de crédito sea mayor que los pagos que haya realizado.
        SELECT cl.*
        FROM CLIENTE cl
        WHERE cl.LIMITE_CREDITO > 
                            (SELECT SUM(p.TOTAL)
                            FROM pago p
                            WHERE cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE);
    
    --6 El producto que más unidades tiene en stock y el que menos unidades tiene.
        SELECT p.*
        FROM PRODUCTO p
        WHERE p.CANTIDAD_EN_STOCK = 
                                (SELECT MAX(p.CANTIDAD_EN_STOCK) FROM PRODUCTO)
                               	OR p.CANTIDAD_EN_STOCK = (SELECT (MIN(CANTIDAD_EN_STOCK)FROM PRODUCTO p);
    
    --7 Devuelve el nombre, los apellidos y el email de los empleados a cargo 
    --de Alberto Soria.
        SELECT e.NOMBRE, e.APELLIDO1, e.APELLIDO2, e.EMAIL
        FROM EMPLEADO e
        WHERE e.CODIGO_JEFE = 
                        (SELECT j.CODIGO_EMPLEADO
                        FROM EMPLEADO j
                        WHERE UPPER(j.NOMBRE) LIKE 'ALBERTO'
                        AND UPPER(j.APELLIDO1) LIKE 'SORIA');
    


--Consultas variadas
    --1 Devuelve el listado de clientes indicando el nombre del cliente y 
    --cuántos pedidos ha realizado. Tenga en cuenta que pueden existir clientes 
    --que no han realizado ningún pedido.
        SELECT cl.NOMBRE_CLIENTE, NVL(COUNT(p.CODIGO_PEDIDO),0) cant_pedidos
        FROM CLIENTE cl, PEDIDO p
        WHERE cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE (+)
        GROUP BY cl.CODIGO_CLIENTE, cl.NOMBRE_CLIENTE;
    
    --2 Devuelve un listado con los nombres de los clientes y el total pagado 
    --por cada uno de ellos. Tenga en cuenta que pueden existir clientes que no 
    --han realizado ningún pago.
        SELECT cl.NOMBRE_CLIENTE, NVL(SUM(p.TOTAL),0) total_pagado
        FROM CLIENTE cl, PAGO p
        WHERE cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE(+)
        GROUP BY cl.CODIGO_CLIENTE, cl.NOMBRE_CLIENTE;
    
    --3 Devuelve el nombre de los clientes que hayan hecho pedidos en 2008 
    --ordenados alfabéticamente de menor a mayor.
        SELECT DISTINCT cl.NOMBRE_CLIENTE
        FROM CLIENTE cl, PEDIDO p
        WHERE cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE
        AND EXTRACT(YEAR FROM p.FECHA_PEDIDO) = 2008
        ORDER BY cl.NOMBRE_CLIENTE ASC;
    
    --4 Devuelve el nombre del cliente, el nombre y primer apellido de su 
    --representante de ventas y el número de teléfono de la oficina del 
    --representante de ventas, de aquellos clientes que no hayan realizado 
    --ningún pago.
        SELECT cl.NOMBRE_CLIENTE, e.APELLIDO1, o.TELEFONO
        FROM CLIENTE cl, EMPLEADO e, OFICINA o, PAGO p
        WHERE cl.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
        AND e.CODIGO_OFICINA = o.CODIGO_OFICINA
        AND cl.CODIGO_CLIENTE = p.CODIGO_CLIENTE(+)
        AND p.CODIGO_CLIENTE IS NULL;

    --5 Devuelve el listado de clientes donde aparezca el nombre del cliente, 
    --el nombre y primer apellido de su representante de ventas y la ciudad donde 
    --está su oficina.
        SELECT distinct cl.NOMBRE_CLIENTE, e.APELLIDO1, o.CIUDAD 
        FROM CLIENTE cl, EMPLEADO e, OFICINA o
        WHERE cl.CODIGO_EMPLEADO_REP_VENTAS = e.CODIGO_EMPLEADO
        AND e.CODIGO_OFICINA = o.CODIGO_OFICINA;
    
    --6 Devuelve el nombre, apellidos, puesto y teléfono de la oficina de 
    --aquellos empleados que no sean representante de ventas de ningún cliente.
        SELECT e.NOMBRE, e.APELLIDO1, e.APELLIDO2, o.TELEFONO
        FROM EMPLEADO e, CLIENTE cl, OFICINA o
        WHERE e.CODIGO_EMPLEADO = cl.CODIGO_EMPLEADO_REP_VENTAS (+)
        AND o.CODIGO_OFICINA = e.CODIGO_OFICINA
        AND cl.CODIGO_EMPLEADO_REP_VENTAS IS NULL;

    --7 Devuelve un listado indicando todas las ciudades donde hay oficinas 
    --y el número de empleados que tiene.
        SELECT o.CIUDAD, COUNT(e.CODIGO_EMPLEADO) num_empleados
        FROM OFICINA o, EMPLEADO e
        WHERE e.CODIGO_OFICINA = o.CODIGO_OFICINA
        GROUP BY o.CIUDAD;
        
       