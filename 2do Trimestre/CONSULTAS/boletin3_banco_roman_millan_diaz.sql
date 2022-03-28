--1. Mostrar el saldo medio de todas las cuentas de la entidad bancaria con dos decimales y
--la suma de los saldos de todas las cuentas bancarias.
SELECT TRUNC(AVG(CUENTA.SALDO),2) saldo_medio, SUM(CUENTA.SALDO) suma_cuentas
FROM CUENTA;

--2. Mostrar el saldo mínimo, máximo y medio de todas las cuentas bancarias.
SELECT MAX(CUENTA.SALDO) saldo_max, MIN(CUENTA.SALDO) saldo_min, 
    TRUNC(AVG(NVL(CUENTA.SALDO,0)),2) saldo_medio
FROM CUENTA;

--3. Mostrar la suma de los saldos y el saldo medio de las cuentas bancarias por cada
--código de sucursal.
SELECT SUM(CUENTA.SALDO) suma_saldos, TRUNC(AVG(NVL(CUENTA.SALDO,0)),2) saldo_medio
FROM CUENTA
GROUP BY CUENTA.COD_SUCURSAL;

--4. Para cada cliente del banco se desea conocer su código, la cantidad total que tiene
--depositada en la entidad y el número de cuentas abiertas.
SELECT CUENTA.COD_CLIENTE, SUM(CUENTA.SALDO) cant_total, COUNT(CUENTA.COD_CUENTA) num_cuentas_ab
FROM CUENTA
GROUP BY CUENTA.COD_CLIENTE;

--5. Retocar la consulta anterior para que aparezca el nombre y apellidos de cada cliente en
--vez de su código de cliente.
SELECT CLIENTE.NOMBRE, CLIENTE.APELLIDOS, SUM(CUENTA.SALDO) cant_total, 
    COUNT(CUENTA.COD_CUENTA) num_cuentas_ab
FROM CUENTA, CLIENTE
WHERE CUENTA.COD_CLIENTE = CLIENTE.COD_CLIENTE
GROUP BY CUENTA.COD_CLIENTE, CLIENTE.NOMBRE, CLIENTE.APELLIDOS;

--6. Para cada sucursal del banco se desea conocer su dirección, el número de cuentas que
--tiene abiertas y la suma total que hay en ellas.
SELECT SUCURSAL.DIRECCION, COUNT(CUENTA.COD_CUENTA) num_cuentas, SUM(CUENTA.SALDO) suma_total
FROM SUCURSAL, CUENTA
WHERE CUENTA.COD_SUCURSAL = SUCURSAL.COD_SUCURSAL
GROUP BY SUCURSAL.COD_SUCURSAL, SUCURSAL.DIRECCION;

--7. Mostrar el saldo medio y el interés medio de las cuentas a las que se le aplique un
--interés mayor del 10%, de las sucursales 1 y 2.
SELECT AVG(NVL(CUENTA.SALDO,0)) saldo_medio, AVG(NVL(CUENTA.INTERES,0)) interes_medio
FROM CUENTA
WHERE CUENTA.INTERES > 0.10
AND (CUENTA.COD_SUCURSAL = 1 OR CUENTA.COD_SUCURSAL = 2);

--8. Mostrar los tipos de movimientos de las cuentas bancarias, sus descripciones y el
--volumen total de dinero que se manejado en cada tipo de movimiento.
SELECT TIPO_MOVIMIENTO.COD_TIPO_MOVIMIENTO, TIPO_MOVIMIENTO.DESCRIPCION, 
    SUM(MOVIMIENTO.IMPORTE) volumen_total
FROM TIPO_MOVIMIENTO, MOVIMIENTO
WHERE MOVIMIENTO.COD_TIPO_MOVIMIENTO = TIPO_MOVIMIENTO.COD_TIPO_MOVIMIENTO
GROUP BY TIPO_MOVIMIENTO.COD_TIPO_MOVIMIENTO, TIPO_MOVIMIENTO.DESCRIPCION;

--9. Mostrar cuál es la cantidad media que los clientes de nuestro banco tienen en el
--epígrafe “Retirada por cajero automático”.
SELECT TRUNC(AVG(MOVIMIENTO.importe),2) cant_media
FROM MOVIMIENTO, TIPO_MOVIMIENTO
WHERE TIPO_MOVIMIENTO.COD_TIPO_MOVIMIENTO = MOVIMIENTO.COD_TIPO_MOVIMIENTO
AND UPPER(TIPO_MOVIMIENTO.DESCRIPCION) LIKE 'RETIRADA POR CAJERO AUTOM_TICO';

--10. Calcular la cantidad total de dinero que emite la entidad bancaria clasificada según los
--tipos de movimientos de salida.
SELECT SUM(m.IMPORTE) cant_total
FROM TIPO_MOVIMIENTO tm , MOVIMIENTO m
WHERE m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO
AND tm.SALIDA LIKE 'Si'
GROUP BY tm.SALIDA;

--11. Calcular la cantidad total de dinero que ingresa cada cuenta bancaria clasificada según
--los tipos de movimientos de entrada mostrando además la descripción del tipo de
--movimiento.
SELECT SUM(m.IMPORTE) cant_total, tm.DESCRIPCION
FROM TIPO_MOVIMIENTO tm, MOVIMIENTO m
WHERE tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO
AND tm.SALIDA LIKE 'No'
GROUP BY m.COD_CUENTA, tm.DESCRIPCION;

--12. Calcular la cantidad total de dinero que sale de la sucursal de Paseo Castellana
SELECT SUM(m.IMPORTE) cant_total
FROM SUCURSAL s, CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm
WHERE s.COD_SUCURSAL = c.COD_SUCURSAL
AND c.COD_CUENTA = m.COD_CUENTA
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO
AND UPPER(s.DIRECCION) LIKE '%PASEO CASTELLANA%'
AND tm.SALIDA LIKE 'Si';


--13. Mostrar la suma total por tipo de movimiento de las cuentas bancarias de los clientes
--del banco. Se deben mostrar los siguientes campos: apellidos, nombre, cod_cuenta,
--descripción del tipo movimiento y el total acumulado de los movimientos de un
--mismo tipo.
SELECT SUM(m.IMPORTE) Suma_total, cl.NOMBRE, cl.APELLIDOS, c.COD_CUENTA, tm.DESCRIPCION
FROM CLIENTE cl, CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm
WHERE cl.COD_CLIENTE = c.COD_CLIENTE
AND c.COD_CUENTA = m.COD_CUENTA
AND tm.COD_TIPO_MOVIMIENTO = m.COD_TIPO_MOVIMIENTO
GROUP BY tm.COD_TIPO_MOVIMIENTO, cl.NOMBRE, cl.APELLIDOS, c.COD_CUENTA, tm.DESCRIPCION;

--14. Contar el número de cuentas bancarias que no tienen asociados movimientos.
-- MIRAR (No se como descartar las que no estan asociadas)
SELECT COUNT(distinct c.COD_CUENTA) num_cuentas
FROM CUENTA c, MOVIMIENTO m
WHERE c.COD_CUENTA = m.COD_CUENTA(+)
AND m.COD_CUENTA IS NULL;


SELECT COUNT(distinct c.COD_CUENTA) num_cuentas
FROM CUENTA c, MOVIMIENTO m
WHERE c.COD_CUENTA NOT IN (SELECT COD_CUENTA FROM movimiento m );


--15. Por cada cliente, contar el número de cuentas bancarias que posee sin movimientos. Se
--deben mostrar los siguientes campos: cod_cliente, num_cuentas_sin_movimiento.
--NO SE HACERLO
SELECT c.COD_CLIENTE, COUNT(c.COD_CUENTA) num_cuentas
FROM CUENTA c, MOVIMIENTO m
WHERE c.COD_CUENTA = m.COD_CUENTA(+)
AND m.COD_CUENTA IS NULL
GROUP BY c.COD_CLIENTE;

SELECT c.COD_CLIENTE, COUNT(c.COD_CUENTA) num_cuentas
FROM CUENTA c
WHERE c.COD_CUENTA NOT IN (SELECT COD_CUENTA FROM MOVIMIENTO)
GROUP BY c.COD_CLIENTE;


--16. Mostrar el código de cliente, la suma total del dinero de todas sus cuentas y el número
--de cuentas abiertas, sólo para aquellos clientes cuyo capital supere los 35.000 euros.
SELECT c.COD_CLIENTE, SUM(c.SALDO) suma_total, COUNT(c.COD_CUENTA) num_cuentas
FROM CUENTA c
GROUP BY c.COD_CLIENTE
HAVING SUM(c.SALDO) > 35000;

--17. Mostrar los apellidos, el nombre y el número de cuentas abiertas sólo de aquellos
--clientes que tengan más de 2 cuentas.
SELECT cl.NOMBRE, cl.APELLIDOS, COUNT(c.COD_CUENTA) num_cuentas
FROM CLIENTE cl, CUENTA c
WHERE c.COD_CLIENTE = cl.COD_CLIENTE
GROUP BY c.COD_CLIENTE, cl.NOMBRE, cl.APELLIDOS
HAVING COUNT(c.COD_CUENTA)> 2;

--18. Mostrar el código de sucursal, dirección, capital del año anterior y la suma de los
--saldos de sus cuentas, sólo de aquellas sucursales cuya suma de los saldos de las
--cuentas supera el capital del año anterior ordenadas por sucursal.
SELECT s.*, SUM(c.SALDO) suma_saldo
FROM SUCURSAL s, CUENTA c
WHERE c.COD_SUCURSAL = s.COD_SUCURSAL
GROUP BY s.COD_SUCURSAL, s.DIRECCION, s.CAPITAL_ANIO_ANTERIOR
HAVING SUM(c.SALDO) > s.CAPITAL_ANIO_ANTERIOR
ORDER BY s.COD_SUCURSAL;

--19. Mostrar el código de cuenta, su saldo, la descripción del tipo de movimiento y la suma
--total de dinero por movimiento, sólo para aquellas cuentas cuya suma total de dinero
--por movimiento supere el 20% del saldo.

SELECT m.COD_CUENTA, c.SALDO, tm.DESCRIPCION, SUM(m.IMPORTE) suma_movimiento
FROM CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm
WHERE c.COD_CUENTA = m.COD_CUENTA
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO
GROUP BY m.COD_CUENTA, c.SALDO, tm.DESCRIPCION
HAVING SUM(m.IMPORTE)> (c.SALDO*0.20);


--20. Mostrar los mismos campos del ejercicio anterior pero ahora sólo de aquellas cuentas
--cuya suma de importes por movimiento supere el 10% del saldo y no sean de la
--sucursal 4.
SELECT c.COD_CUENTA, c.SALDO, tm.DESCRIPCION, SUM(m.IMPORTE) suma_movimiento
FROM CUENTA c, MOVIMIENTO m, TIPO_MOVIMIENTO tm, SUCURSAL s
WHERE c.COD_CUENTA = m.COD_CUENTA
AND m.COD_TIPO_MOVIMIENTO = tm.COD_TIPO_MOVIMIENTO
AND s.COD_SUCURSAL = c.COD_SUCURSAL
AND s.COD_SUCURSAL != 4
GROUP BY c.COD_CUENTA, c.SALDO, tm.DESCRIPCION
HAVING SUM(m.IMPORTE)> (c.SALDO*0.10);

--21. Mostrar los datos de aquellos clientes para los que el saldo de sus cuentas suponga al
--menos el 20% del capital del año anterior de su sucursal. 
SELECT cl.*
FROM CLIENTE cl, cuenta c, SUCURSAL s
WHERE cl.COD_CLIENTE = c.COD_CLIENTE
AND c.COD_SUCURSAL = s.COD_SUCURSAL
GROUP BY cl.COD_CLIENTE, cl.NOMBRE, cl.APELLIDOS, cl.DIRECCION, c.SALDO, s.CAPITAL_ANIO_ANTERIOR
HAVING SUM(c.SALDO) >= (s.CAPITAL_ANIO_ANTERIOR*0.20);
