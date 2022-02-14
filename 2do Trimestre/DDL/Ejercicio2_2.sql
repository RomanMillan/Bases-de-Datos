/*Ejercicio 2 - 2*/

-- Crear el usuario
alter session set "_oracle_script"=true;  
create user partido identified by partido;
GRANT CONNECT, RESOURCE, DBA TO partido;


--creacion de las tablas
CREATE TABLE equipo(
codEquipo		VARCHAR2(4),
nombre			VARCHAR2(30) NOT NULL,
localidad		VARCHAR2(15),
CONSTRAINT PK_equipo PRIMARY KEY (codEquipo)
);

CREATE TABLE jugador (
codJugador			VARCHAR2(4),
nombre				VARCHAR2(30) NOT NULL,
fechaNacimiento		DATE,
demarcacion			VARCHAR2(10),
codEquipo			VARCHAR2(4),
CONSTRAINT PK_jugador PRIMARY KEY (codJugador),
CONSTRAINT FK_jugador FOREIGN KEY (codEquipo) REFERENCES equipo(codEquipo)
);

CREATE TABLE partido(
codPartido				VARCHAR2(4),
codEquipoLocal			VARCHAR2(4),
codEquipoVisitante		VARCHAR2(4),
fecha					DATE,
competicion				VARCHAR2(4),
jornada					VARCHAR(20),
CONSTRAINT PK_partido PRIMARY KEY(codPartido),
CONSTRAINT FK_partido_1 FOREIGN KEY (codEquipoLocal) REFERENCES equipo(codEquipo),
CONSTRAINT FK_partido_2 FOREIGN KEY (codEquipoVisitante) REFERENCES equipo(codEquipo),
CONSTRAINT CK_partido__competicion CHECK (UPPER(competicion) IN ('COPA','LIGA')),
CONSTRAINT CK_partido__fecha CHECK (EXTRACT(MONTH FROM fecha) != 7 AND EXTRACT(MONTH FROM fecha) !=8) --(EXTRACT(MONTH FROM fecha) NOT IN (7,8)) 
);

CREATE TABLE incidencia (
numIncidencia		VARCHAR2(6),
codPartido			VARCHAR2(4),
codJugador			VARCHAR2(4),
minuto				NUMBER(2),
tipo				VARCHAR2(20),
CONSTRAINT PK_incidencia PRIMARY KEY (numIncidencia),
CONSTRAINT FK_incidencia FOREIGN KEY (codPartido) REFERENCES partido(codPartido),
CONSTRAINT FK_incidencia_2 FOREIGN KEY (codJugador) REFERENCES jugador(codJugador),
CONSTRAINT CK_incidencia__minuto CHECK (minuto BETWEEN 1 AND 99)
);

-- Modificaciones de las tablas
ALTER TABLE incidencia MODIFY tipo NOT NULL;
ALTER TABLE equipo ADD golesMarcados NUMBER(3);
ALTER TABLE jugador ADD CONSTRAINT ck_jugador__nombre CHECK (INITCAP(nombre) = nombre); 
ALTER TABLE jugador ADD CONSTRAINT ck_jugador__demarcacion CHECK ((demarcacion) IN ('Portero','Defensa','Medio','Delantero'));
ALTER TABLE equipo ADD CONSTRAINT ck_equipo__nombre CHECK (regexp_like(nombre,'^[0-9]{1}'));



