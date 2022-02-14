alter session set "_oracle_script"=true;  
create user coche identified by coche;
GRANT CONNECT, RESOURCE, DBA TO coche;

-- Ejercicio 2 empresea alquiler de coches

CREATE TABLE vehiculo(
matricula		VARCHAR2(7),
marca			VARCHAR2(10) NOT NULL,
modelo			VARCHAR2(10) NOT NULL,
fecha_compra	DATE,
precio_por_dia	NUMBER(5,2),
CONSTRAINT PK_vehiculos PRIMARY KEY (matricula),
CONSTRAINT CK_vehiculo_fecha CHECK (EXTRACT(YEAR FROM fecha_compra)>= 2001),
CONSTRAINT CK_vehiculo_precio CHECK (precio_por_dia > 0)
);

CREATE TABLE cliente(
dni					VARCHAR2(9),
nombre				VARCHAR2(30) NOT NULL,
nacionalidad		VARCHAR2(30),
fecha_nacimiento	DATE,
direccion			VARCHAR2(50),
CONSTRAINT PK_cliente PRIMARY KEY (dni)
);

CREATE TABLE alquiler(
matricula		VARCHAR2(7),
dni				VARCHAR2(10),
fecha_hora		DATE,
num_dias		NUMBER(2) NOT NULL,
kilometros		NUMBER(4) DEFAULT 0,
CONSTRAINT PK_alquiler PRIMARY KEY(matricula,dni,fecha_hora),
CONSTRAINT FK1_alquiler FOREIGN KEY (matricula) REFERENCES vehiculo (matricula),
CONSTRAINT FK2_alquiler FOREIGN KEY (dni) REFERENCES cliente(dni)
);

ALTER TABLE vehiculo ADD total_kilometros NUMBER(6);






