CREATE TABLE empleados
(dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2(50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE,
CONSTRAINT FK_JEFE FOREIGN KEY (jefe) REFERENCES empleados (dni) );

--1
/*Crear un trigger sobre la tabla EMPLEADOS para que no se permita que un empleado
sea jefe de más de cinco empleados.
 * */
CREATE OR REPLACE
TRIGGER ej1
BEFORE INSERT ON empleados
FOR EACH ROW
DECLARE
emple NUMBER(5);
BEGIN
	SELECT COUNT(emp.DNI)
	INTO emple
	FROM empleados emp, EMPLEADOS jefe
	WHERE emp.JEFE = JEFE.dni;

	IF emple <5THEN
		INSERT INTO EMPLEADOS (dni) 
		VALUES (:NEW.dni);
	ELSE
		RAISE_APPLICATION_ERROR(-20001, 'No puede haber un jefe con mas de 5 empleados');
	END IF;
END;

--2
/*
 * Crear un trigger para impedir que se aumente el salario de un empleado
 *  en más de un 20%.
 * */
CREATE OR REPLACE
TRIGGER ej2
BEFORE UPDATE OF salario ON empleados
FOR EACH ROW
DECLARE
	salarioAu NUMBER(10,2);
BEGIN
	SELECT e.SALARIO*1.2 sal
	INTO salarioAu
	FROM EMPLEADOS e 
	WHERE e.DNI = :NEW.dni;

	IF(salarioAu < :OLD.salario)THEN
		UPDATE EMPLEADOS 
		SET salario = :NEW.salario
		WHERE dni = :NEW.dni;
	END IF;
END;



--3
/*
 * Crear una tabla empleados_baja con la siguiente estructura
 * */
CREATE TABLE empleados_baja
( dni VARCHAR2(9) PRIMARY KEY,
nomemp VARCHAR2 (50),
jefe VARCHAR2(9),
departamento NUMBER,
salario NUMBER(9,2) DEFAULT 1000,
usuario VARCHAR2(50),
fecha DATE );

/*
 * - Crear un trigger que inserte una fila en la tabla empleados_baja cuando 
 *   se borre una fila en la tabla empleados. 
    -Los datos que se insertan son los del empleado que se da de baja en la 
    tabla empleados, salvo en las columnas usuario y fecha se grabarán las 
    variables del sistema USER y SYSDATE que almacenan el usuario y fecha actual
 * */

    INSERT INTO empleados
    VALUES ('11K','Juan',NULL,5,5000,'Migo',TO_DATE('15/10/2010','DD/MM/YYYY'));
    
    INSERT INTO empleados
    VALUES ('14E','Sonia',NULL,5,8000,'SM',TO_DATE('20/09/2010','DD/MM/YYYY'));
 

CREATE OR REPLACE
TRIGGER ej3
AFTER DELETE ON empleados
FOR EACH ROW
DECLARE

BEGIN
		INSERT INTO EMPLEADOS_BAJA
    	VALUES (:OLD.dni,:OLD.nomemp,:OLD.jefe,:OLD.departamento,:OLD.salario,USER,sysdate);
END;



DELETE empleados
WHERE dni = '1441K';


    INSERT INTO empleados
    VALUES ('11K','Juan','14E',5,5000,'SM',TO_DATE('15/10/2010','DD/MM/YYYY'));
    
    INSERT INTO empleados
    VALUES ('14E','Sonia',NULL,5,8000,'SM',TO_DATE('20/09/2010','DD/MM/YYYY'));

/*
Ejercicio 4
Crear un trigger para impedir que, al insertar un empleado, el empleado y su jefe puedan
pertenecer a departamentos distintos. 
Es decir, el jefe y el empleado deben pertenecer al mismo departamento.
*/
/*
CREATE OR REPLACE
TRIGGER ej4
BEFORE INSERT ON empleados
FOR EACH ROW
DECLARE
    dep_jefe NUMBER(5);
BEGIN
    select emp.DEPARTAMENTO
    INTO dep_jefe
    from EMPLEADOS emp
    WHERE emp.DNI = :NEW.jefe;
    
    IF(dep_jefe = :NEW.departamento)THEN
        INSERT INTO empleados
        VALUES(:NEW.dni,:NEW.nomemp,:NEW.jefe,:NEW.departamento,:NEW.salario,
                :NEW.usuario,:NEW.fecha);
    ELSE
        RAISE_APPLICATION_ERROR(-20006, 'Los jefes tienen que ser del mismo dep que el emp');
    END IF;
END;
*/

CREATE OR REPLACE
TRIGGER ej4
BEFORE INSERT ON empleados
FOR EACH ROW
DECLARE
    dep_jefe NUMBER(5);
BEGIN
	--obtenermos el depar del jefe
    select emp.DEPARTAMENTO
    INTO dep_jefe
    from EMPLEADOS emp
    WHERE emp.DNI = :NEW.jefe;
    
    IF(dep_jefe != :NEW.departamento)THEN
	 RAISE_APPLICATION_ERROR(-20006, 'Los jefes tienen que ser del mismo dep que el emp');
    END IF;
END;




    delete empleados e 
    where e.DNI = '11K';
    
    INSERT INTO empleados
    VALUES ('77I','Konic','14E',8,47000,'SOE',TO_DATE('20/09/2010','DD/MM/YYYY'));

    INSERT INTO empleados
    VALUES ('77I','Konic','14E',5,47000,'SOE',TO_DATE('20/09/2010','DD/MM/YYYY'));


/*
Ejercicio 5
Crear un trigger para impedir que, al insertar un empleado, la suma de los salarios de los
empleados pertenecientes al departamento del empleado insertado supere los 10.000
euros.
*/
CREATE OR REPLACE
TRIGGER ej5
BEFORE INSERT ON empleados
FOR EACH ROW
DECLARE
    total_s NUMBER(10);
BEGIN
    select sum(e.SALARIO)
    into total_s
    from EMPLEADOS e;
    
    IF(total_s >10000)THEN
        RAISE_APPLICATION_ERROR(-20009, 'El salario total no puede superar los 10000');
    END IF;
END;

    INSERT INTO empleados
    VALUES ('77I','Konic','14E',8,800,'SOE',TO_DATE('20/09/2010','DD/MM/YYYY'));


   
 --Ejercicio 6
--Crea la tabla:
CREATE TABLE controlCambios(
usuario varchar2(30),
fecha date,
tipooperacion varchar2(30),
datoanterior varchar2(30),
datonuevo varchar2(30)
);
/*
Creamos un trigger que se active cuando modificamos algún campo de "empleados" y
almacene en "controlCambios" el nombre del usuario que realiza la actualización, la
fecha, el tipo de operación que se realiza, el dato que se cambia y el nuevo valor.
 * */
   
CREATE OR REPLACE
TRIGGER ej6
AFTER UPDATE ON empleados
FOR EACH ROW
DECLARE
BEGIN
	IF(:OLD.dni != :NEW.dni)THEN
		INSERT INTO CONTROLCAMBIOS  
		VALUES (USER,sysdate,'update',:OLD.dni,:NEW.dni);
	ELSIF (:OLD.nomemp != :NEW.nomemp) THEN
		INSERT INTO CONTROLCAMBIOS  
		VALUES (USER,sysdate,'update',:OLD.nomemp,:NEW.nomemp);
	ELSIF (:OLD.jefe != :NEW.jefe) THEN
		INSERT INTO CONTROLCAMBIOS  
		VALUES (USER,sysdate,'update',:OLD.jefe,:NEW.jefe);
	ELSIF (:OLD.departamento != :NEW.departamento) THEN
		INSERT INTO CONTROLCAMBIOS  
		VALUES (USER,sysdate,'update',:OLD.departamento,:NEW.departamento);
	ELSE 
		INSERT INTO CONTROLCAMBIOS  
		VALUES (USER,sysdate,'update',:OLD.salario,:NEW.salario);
	END IF;	
END;

UPDATE empleados e
SET e.NOMEMP = 'Paco'
WHERE e.DNI = '11K';



INSERT INTO CONTROLCAMBIOS  
VALUES (USER,sysdate,'update',);


/*
 * Ejercicio 7
Creamos otro trigger que se active cuando ingresamos un nuevo registro en "empleados",
debe almacenar en "controlCambios" el nombre del usuario que realiza el ingreso, la
fecha, el tipo de operación que se realiza , "null" en "datoanterior" (porque se dispara con
una inserción) y en "datonuevo" el valor del nuevo dato.
 * */

CREATE OR REPLACE
TRIGGER ej7
AFTER INSERT ON empleados
FOR EACH ROW
DECLARE
BEGIN
	INSERT INTO CONTROLCAMBIOS  
	VALUES (USER,sysdate,'update',NULL,:NEW.dni);
END;

INSERT INTO empleados
VALUES ('11V','Sonia','14E',5,5000,'SM',TO_DATE('15/10/2010','DD/MM/YYYY'));


CREATE TABLE pedidos
( CODIGOPEDIDO NUMBER,
FECHAPEDIDO DATE,
FECHAESPERADA DATE,
FECHAENTREGA DATE DEFAULT NULL,
ESTADO VARCHAR2(15),
COMENTARIOS CLOB,
CODIGOCLIENTE NUMBER
)

/*Ej8
 * Crea un trigger que al actualizar la columna fechaentrega de pedidos la compare con la
fechaesperada.
• Si fechaentrega es menor que fechaesperada añadirá a los comentarios 'Pedido
entregado antes de lo esperado'.
• Si fechaentrega es mayor que fechaesperada añadir a los comentarios 'Pedido
entregado con retraso'.
 * 
 * */

CREATE OR REPLACE PACKAGE codigopackage IS
	codigo_n          pedidos.CODIGOPEDIDO%TYPE;
	fechaesperada_n    pedidos.fechaesperada%TYPE;
	fechaentrega_n  pedidos.fechaentrega%TYPE;
END;

CREATE OR REPLACE
TRIGGER ej8
AFTER UPDATE OF fechaentrega ON pedidos
DECLARE
BEGIN
	codigopackage.codigo_n := :NEW.codigopedido;
	codigopackage.fechaesperada_n := :OLD.fechaesperada;
	codigopackage.fechaentrega_n := :NEW.fechaentrega; 
	
	IF(codigopackage.fechaentrega_n < codigopackage.fechaesperada_n) THEN
		UPDATE PEDIDOS  p
		SET p.COMENTARIOS = 'Pedido entregado antes de lo esperado'
		WHERE p.CODIGOPEDIDO = codigopackage.codigo_n;
	ELSE
		UPDATE PEDIDOS  p
		SET p.COMENTARIOS = 'Pedido entregado con retraso'
		WHERE p.CODIGOPEDIDO = codigopackage.codigo_n;
	END IF;
END;

Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values(1,to_date('17/01/06','DD/MM/YY'),to_date('19/01/06','DD/MM/YY'),to_date('19/01/06','DD/MM/YY'),'Entregado',5);

Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values(2,to_date('23/10/07','DD/MM/YY'),to_date('28/10/07','DD/MM/YY'),to_date('26/10/07','DD/MM/YY'),'Entregado',5);

Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values(3,to_date('20/06/08','DD/MM/YY'),to_date('25/06/08','DD/MM/YY'),null,'Rechazado',5);

Insert into PEDIDOS
(CODIGOPEDIDO,FECHAPEDIDO,FECHAESPERADA,FECHAENTREGA,ESTADO,CODIGOCLIENTE)
values(4,to_date('20/01/09','DD/MM/YY'),to_date('26/01/09','DD/MM/YY'),null,'Pendiente',5);

UPDATE pedidos p
SET p.FECHAENTREGA = to_date('18/01/06','DD/MM/YY')
WHERE p.CODIGOPEDIDO = 1;



/*Ejercicio 9
Modifica el trigger anterior pero solo se ejecute si fechaentrega es mayor que
fechaesperada
 * 
 * */


