--Boletin Cursores BD Jardineria
/*
 * 1.- Desarrollar un procedimiento que visualice el nombre, apellidos y puesto
de todos los empleados, ordenados por primer apellido.
 */

CREATE OR REPLACE
PROCEDURE ej1
AS
	CURSOR c_empleado IS
	SELECT emp.NOMBRE nom, emp.APELLIDO1 ap1, emp.APELLIDO2  ap2, emp.PUESTO puesto
	FROM EMPLEADO emp;
BEGIN
	FOR i IN c_empleado LOOP
		DBMS_OUTPUT.PUT_LINE('nombre: '||i.nom || ' apellidos: ' || i.ap1 ||' '
		||i.ap2 ||' puesto: ' ||i.puesto);
	END LOOP;
	
END;

BEGIN
	ej1();	
END;

/*
 * 2.- Desarrollar un procedimiento que muestre el código de cada oficina
 *  y el número de empleados que tiene.
 * */

CREATE OR REPLACE
PROCEDURE ej2
AS
	CURSOR c_numEmp IS
	SELECT o.CODIGO_OFICINA cod, COUNT(e.CODIGO_EMPLEADO) num_empl
	FROM OFICINA o, EMPLEADO e  
	WHERE o.CODIGO_OFICINA = e.CODIGO_OFICINA
	GROUP BY o.CODIGO_OFICINA;
BEGIN
	FOR i IN c_numEmp LOOP
		DBMS_OUTPUT.PUT_LINE('Codigo: '|| i.cod || ' numero empleado: '||i.num_empl);	
	END LOOP;
END;

BEGIN
	ej2();
END;

/*
 * 3.- Desarrollar un procedimiento que reciba como parámetro una cadena de
 * texto y muestre el código de cliente y nombre de cliente de todos los
 * clientes cuyo nombre contenga la cadena especificada. Al finalizar debe
 * mostrar el número de clientes mostrados.
 * */

CREATE OR REPLACE
PROCEDURE ej3(nombre_c VARCHAR2)
AS
	CURSOR c_cliente IS 
	SELECT c.CODIGO_CLIENTE codigo, c.NOMBRE_CLIENTE nombre
	FROM CLIENTE c 
	WHERE UPPER(c.NOMBRE_CLIENTE) LIKE UPPER(nombre_c);	
	error EXCEPTION;
BEGIN
	
	FOR i IN c_cliente LOOP
		DBMS_OUTPUT.PUT_LINE('Codigo: ' ||i.codigo||' nombre: ' ||i.nombre);	
	end LOOP;
	
	IF SQL%NOTFOUND THEN
		RAISE error;
	END IF;

	EXCEPTION
	WHEN error THEN
	DBMS_OUTPUT.PUT_LINE('Datos no encontrado');
END;

BEGIN
	ej3('Lasas S.A.');	
END;

/*
 * 4.- Escribir un programa que muestre el código de producto, nombre 
 * y gama de los 5 productos más vendidos.
 * */

CREATE OR REPLACE
PROCEDURE ej4
AS
    CURSOR c_mas_vendido IS
    select CODIGO_PRODUCTO codigo, NOMBRE nom, GAMA
    from (select dp.CODIGO_PRODUCTO, p.NOMBRE, p.GAMA, COUNT(dp.CODIGO_PRODUCTO) cant_vendida
          from DETALLE_PEDIDO dp, PRODUCTO p
          WHERE dp.CODIGO_PRODUCTO = p.CODIGO_PRODUCTO
          GROUP BY dp.CODIGO_PRODUCTO, p.NOMBRE, p.GAMA
           ORDER BY COUNT(dp.CODIGO_PRODUCTO)desc)
    where rownum<=5;
BEGIN
    FOR i IN c_mas_vendido LOOP
        DBMS_OUTPUT.PUT_LINE('Codigo: '||i.codigo||' Nombre: '||i.nom||' Gama: '||i.gama);
    END LOOP;
END;


BEGIN 
    ej4();
END;

-- select de comprobacion
select CODIGO_PRODUCTO, NOMBRE, GAMA 
from (select dp.CODIGO_PRODUCTO, p.NOMBRE, p.GAMA, COUNT(dp.CODIGO_PRODUCTO) cant_vendida
      from DETALLE_PEDIDO dp, PRODUCTO p
      WHERE dp.CODIGO_PRODUCTO = p.CODIGO_PRODUCTO
      GROUP BY dp.CODIGO_PRODUCTO, p.NOMBRE, p.GAMA
      ORDER BY COUNT(dp.CODIGO_PRODUCTO)desc)
where rownum<=5;

/*
 5.- Desarrollar un procedimiento que aumente el límite de crédito en un
50% a aquellos clientes que cuyo valor sea inferior al límite de crédito
medio actual.
*/

CREATE OR REPLACE
PROCEDURE ej5
AS
BEGIN
    UPDATE cliente cl
    SET cl.LIMITE_CREDITO = cl.limite_credito*1.50
    WHERE cl.LIMITE_CREDITO < (select AVG(NVL(c.LIMITE_CREDITO,0))
                               from cliente c);
    EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error inesperado');
END;

BEGIN
    ej5();
END;

--Prueba
UPDATE cliente cl
SET cl.LIMITE_CREDITO = cl.limite_credito*1.50
WHERE cl.LIMITE_CREDITO < (select AVG(NVL(c.LIMITE_CREDITO,0))
                           from cliente c);

/*
6.- Diseñar una función que dado un código de producto retorne el número
de unidades vendidas del producto. 
En caso de introducir un producto inexistente retornará -1.
*/

CREATE OR REPLACE
FUNCTION ej6(codigo DETALLE_PEDIDO.CODIGO_PRODUCTO%TYPE)
RETURN NUMBER
IS
    cant_v NUMBER(5);
BEGIN
    select COUNT(dp.CODIGO_PRODUCTO) cant_vendida
    INTO cant_v
    from DETALLE_PEDIDO dp
    WHERE dp.CODIGO_PRODUCTO = codigo;
    
    IF(cant_v =0)THEN
        cant_v := -1;
    END IF;
    return cant_v;
END;

select ej6('AR-005')cant_vendida from DUAL;

--Prueba
select COUNT(dp.CODIGO_PRODUCTO) cant_vendida
from DETALLE_PEDIDO dp
WHERE dp.CODIGO_PRODUCTO = 'AR-005';


/*
7.- Diseñar una función que dado un código de cliente y un año retorne la
cantidad total pagada por el cliente durante el periodo indicado. 
En caso de introducir un cliente inexistente retornará -1.
*/
CREATE OR REPLACE
FUNCTION ej7(codigo VARCHAR2, anio NUMBER)
RETURN NUMBER
IS
    total_p NUMBER;
BEGIN
    select SUM(p.TOTAL)
    INTO total_p
    from PAGO p
    WHERE p.CODIGO_CLIENTE = codigo
    AND EXTRACT(YEAR FROM p.FECHA_PAGO) = anio;
    
    IF(total_p IS NULL)THEN
        total_p := -1;
    END IF;
    return total_p;
END;

select ej7('1',2008)pago_total from dual;

--Prueba.
select SUM(p.TOTAL)
from PAGO p
WHERE p.CODIGO_CLIENTE = '1'
AND EXTRACT(YEAR FROM p.FECHA_PAGO) = 2008;

/*
8.- Diseñar una función que dado un código de cliente elimine todos sus
pedidos realizados. 
La función retornará el número de pedidos borrados.
*/
CREATE OR REPLACE
FUNCTION ej8(codigo NUMBER)
RETURN NUMBER
IS
    ped_borrados NUMBER;
BEGIN
    select COUNT(p.CODIGO_CLIENTE) num_b
    INTO ped_borrados
    from PEDIDO p 
    where p.CODIGO_CLIENTE = codigo;

   	DELETE FROM DETALLE_PEDIDO dp  
    WHERE dp.CODIGO_PEDIDO  = codigo;
   
    DELETE FROM PEDIDO p
    WHERE p.CODIGO_PEDIDO = codigo;
    return ped_borrados;
END;

DECLARE
	variable NUMBER;
BEGIN
	variable:= ej8(1);
	DBMS_OUTPUT.PUT_LINE(variable);
END;


--Pruebas
select COUNT(p.CODIGO_CLIENTE) 
from PEDIDO p 
where p.CODIGO_CLIENTE = 1;

ALTER TABLE pedido drop constraint SYS_C008645;

DELETE FROM PEDIDO p
WHERE p.CODIGO_CLIENTE = 1;

/*
9.- Desarrollar un procedimiento que actualice el precio de venta de todos
los productos de una determinada gama. 

El procedimiento recibirá como parámetro la gama, y actualizará el precio de 
venta como el precio de proveedor + 70%. 

Al finalizar el procedimiento indicará el número de productos actualizados y su gama.
*/

CREATE OR REPLACE
PROCEDURE ej9(gama_b VARCHAR2)
AS
    cant_act NUMBER;
BEGIN
    select COUNT(pr.GAMA)
    INTO cant_act
    from PRODUCTO pr
    WHERE UPPER(pr.GAMA) LIKE UPPER(gama_b);

    UPDATE producto pr
    SET pr.PRECIO_VENTA = pr.precio_venta *1.70
    WHERE UPPER(pr.GAMA) LIKE UPPER(gama_b);

    UPDATE producto pr
    SET pr.PRECIO_PROVEEDOR = pr.PRECIO_PROVEEDOR *1.70
    WHERE UPPER(pr.GAMA) LIKE UPPER(gama_b);
    DBMS_OUTPUT.PUT_LINE('Gama: '||gama_b||' Cantidad act: '||cant_act);
END;

BEGIN
    ej9('aromáticas');
END;


--Pruebas
select COUNT(pr.GAMA)
from PRODUCTO pr
WHERE UPPER(pr.GAMA) LIKE UPPER('aromáticas');

UPDATE producto pr
SET pr.PRECIO_VENTA = pr.precio_venta *1.70
WHERE UPPER(pr.GAMA) LIKE UPPER('frutales');

UPDATE producto pr
SET pr.PRECIO_PROVEEDOR = pr.PRECIO_PROVEEDOR *1.70
WHERE UPPER(pr.GAMA) LIKE UPPER('frutales');

/*
10.- Diseñar una aplicación que simule un listado de empleados según el
siguiente formato:
*/


