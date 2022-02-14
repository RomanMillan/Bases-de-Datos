-- Caladero

-- Creación de usuario
alter session set "_oracle_script"=true;  
create user caladero identified by caladero;
GRANT CONNECT, RESOURCE, DBA TO caladero;

-- Creación de tablas
CREATE TABLE barco(
matricula           VARCHAR2(30),
nombre              VARCHAR2(30),
clase               VARCHAR2(30),
armador             VARCHAR2(30),
capacidad           VARCHAR2(30),
nacionalidad        VARCHAR2(30),
CONSTRAINT PK_barco PRIMARY KEY (matricula)
);

CREATE TABLE especie(
codigo                  VARCHAR2(30),
nombre                  VARCHAR2(30),
tipo                    VARCHAR2(30),
cupoporbarco            VARCHAR2(30),
caladero_principal      VARCHAR2(30),
CONSTRAINT PK_especie PRIMARY KEY (codigo)
);

CREATE TABLE lote(
codigo                      VARCHAR2(30),
matricula                   VARCHAR2(30),
numkilos                    NUMBER(4),
precioporkilosalida         NUMBER(5,2),
precioporkiloadjudicado     NUMBER(5,2),
fechaventa                  DATE NOT NULL,
codigo_especie              VARCHAR2(30),
CONSTRAINT PK_lote PRIMARY KEY (codigo),
CONSTRAINT FK_lote_1 FOREIGN KEY (matricula) REFERENCES barco(matricula) ON DELETE CASCADE,
CONSTRAINT FK_lote_2 FOREIGN KEY (codigo_especie) REFERENCES especie(codigo) ON DELETE CASCADE,
CONSTRAINT CK_lote__prejudicado CHECK(precioporkiloadjudicado > precioporkilosalida),
CONSTRAINT CK_lote__numkilos CHECK (numkilos > 0),
CONSTRAINT CK_lote__presalida CHECK(precioporkilosalida > 0),
CONSTRAINT CK_lote__prejudicado_2 CHECK(precioporkiloadjudicado > 0)
);

CREATE TABLE caladero(
codigo                  VARCHAR2(30),
nombre                  VARCHAR2(30),
ubicacion               VARCHAR2(30),
especie_principal       VARCHAR2(30),
CONSTRAINT PK_caladero PRIMARY KEY (codigo),
CONSTRAINT FK_caladero FOREIGN KEY (especie_principal) REFERENCES especie(codigo) ON DELETE SET NULL,
CONSTRAINT CK_caladero__nombre CHECK(UPPER(nombre) = nombre),
CONSTRAINT CK_caladero__ubicacion CHECK(UPPER(ubicacion) = ubicacion)
);

CREATE TABLE fecha_captura_permitida(
cod_especie         VARCHAR2(30),
cod_caladero        VARCHAR2(30),
fecha_inicial       DATE,
fecha_final         DATE,
CONSTRAINT PK_fecha_cap_per PRIMARY KEY (cod_especie,cod_caladero),
CONSTRAINT FK_fecha_cap_per_1 FOREIGN KEY (cod_especie) REFERENCES especie(codigo),
CONSTRAINT FK_fecha_cap_per_2 FOREIGN KEY (cod_caladero) REFERENCES caladero(codigo),

CONSTRAINT CK_fecha_cap_per__f_ini CHECK(((TO_CHAR(fecha_inicial,'MM') = '02' AND TO_CHAR(fecha_inicial,'DD') < '02') OR (TO_CHAR(fecha_inicial,'MM') < '02')) 
OR ((TO_CHAR(fecha_inicial,'MM') = '03' AND TO_CHAR(fecha_inicial,'DD') >'28') OR (TO_CHAR(fecha_inicial,'MM')>'03'))),

CONSTRAINT CK_fecha_cap_per__f_fin CHECK (((TO_CHAR(fecha_final,'MM') = '02' AND TO_CHAR(fecha_final,'DD') < '02') OR (TO_CHAR(fecha_final,'MM') < '02')) 
OR ((TO_CHAR(fecha_final,'MM') = '03' AND TO_CHAR(fecha_final,'DD') >'28') OR (TO_CHAR(fecha_final,'MM')>'03')))
);

-- Modificación de tablas
ALTER TABLE caladero ADD nombre_cientifico VARCHAR2(30);
ALTER TABLE especie ADD CONSTRAINT FK_especie FOREIGN KEY (caladero_principal) REFERENCES caladero(codigo);

-- Inserción de datos 
INSERT INTO barco
VALUES ('L-4568','Miranda','pesquero','Juan Sanchez Páez',300,'España');

INSERT INTO barco
VALUES ('A-8885','Polvor','pesquero','Miranda López Guerrero',430,'España');


INSERT INTO especie (codigo,nombre,tipo,cupoporbarco)
VALUES ('444LV','caballa','perciforme','15000');

INSERT INTO especie (codigo,nombre,tipo,cupoporbarco)
VALUES ('957SA','sardina','clupeido','17000');


INSERT INTO lote
VALUES ('1-AA45','L-4568','210',1.45,2.3,TO_DATE('12/03/2021','DD/MM/YYYY'),'957SA');

INSERT INTO lote
VALUES ('2-AD24','A-8885','153',1.54,2.8,TO_DATE('12/03/2021','DD/MM/YYYY'),'444LV');


INSERT INTO caladero (codigo,nombre,ubicacion,especie_principal,nombre_cientifico)
VALUES ('CL-AND1','SURATLANTICA','SUROESTE DE ESPAÑA','444LV','Scomber Scombrus');

INSERT INTO caladero(codigo,nombre,ubicacion,especie_principal,nombre_cientifico)
VALUES ('CL-AND2','SURMEDITERRANEA','SURESTE DE ESPAÑA','957SA','Sardina Pilchardus');


INSERT INTO fecha_captura_permitida
VALUES ('444LV','CL-AND1',TO_DATE('15/01/2021','DD/MM/YYYY'),TO_DATE('20/01/2021','DD/MM/YYYY'));

INSERT INTO fecha_captura_permitida
VALUES ('957SA','CL-AND1',TO_DATE('29/03/2021','DD/MM/YYYY'),TO_DATE('5/4/2021','DD/MM/YYYY'));

-- Borrar campo: armador de la tabla: barco
ALTER TABLE barco DROP (armador);

-- Borrar tablas
DROP TABLE barco CASCADE CONSTRAINTS;
DROP TABLE especie CASCADE CONSTRAINTS;
DROP TABLE lote CASCADE CONSTRAINTS;
DROP TABLE caladero CASCADE CONSTRAINTS;
DROP TABLE fecha_captura_permitida CASCADE CONSTRAINTS;

