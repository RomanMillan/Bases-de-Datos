/*Ejercicio 1 , Editorial*/

/*Creación de tablas:*/

CREATE TABLE editorial (
cod_editorial		VARCHAR2(30),
denominacion		VARCHAR2(30),
CONSTRAINT pk_editorial PRIMARY KEY(cod_editorial)
);

CREATE  TABLE tema(
cod_tema		NUMBER(8),
denominacion	VARCHAR2(30),
cod_tema_padre	NUMBER(8),
CONSTRAINT PK_tema PRIMARY KEY (cod_tema),
CONSTRAINT CK_tema__cod_tema CHECK (cod_tema_padre >= cod_tema)
);

CREATE TABLE autor(
cod_autor			VARCHAR2(30),
nombre				VARCHAR2(30),
f_nacimiento		DATE,
libro_principal		VARCHAR2(30),
CONSTRAINT PK_autor PRIMARY KEY (cod_autor)
);

CREATE TABLE libro(
cod_libro			VARCHAR2(30),
titiulo				VARCHAR2(30),
f_creacion			DATE,
cod_tema			NUMBER(8),
autor_principal		VARCHAR2(30),
CONSTRAINT PK_libro PRIMARY KEY (cod_libro),
CONSTRAINT FK_libro FOREIGN KEY (cod_tema) REFERENCES tema (cod_tema),
CONSTRAINT FK2_libro FOREIGN KEY (autor_principal) REFERENCES autor (cod_autor)
);

CREATE TABLE libro_autor(
cod_libro		VARCHAR2(30),
cod_autor		VARCHAR2(30),
orden			NUMBER(8),
CONSTRAINT PK_libro_autor PRIMARY KEY (cod_libro,cod_autor),
CONSTRAINT FK1_libro_autor FOREIGN KEY (cod_libro) REFERENCES libro (cod_libro),
CONSTRAINT FK2_libro_autor FOREIGN KEY (cod_autor) REFERENCES autor (cod_autor),
CONSTRAINT CK_libro_autor__orden CHECK (orden >= 1 AND orden <= 5) 
);

CREATE TABLE publicacion(
cod_editorial		VARCHAR2(30),
cod_libro			VARCHAR2(30),
precio				NUMBER(5,2) NOT NULL,
f_publicacion		DATE DEFAULT SYSDATE,
CONSTRAINT PK_publicacion PRIMARY KEY (cod_editorial,cod_libro),
CONSTRAINT FK_publicacion FOREIGN KEY (cod_editorial) REFERENCES editorial (cod_editorial) ON DELETE CASCADE,
CONSTRAINT FK2_publicacion FOREIGN KEY (cod_libro) REFERENCES libro (cod_libro)ON DELETE CASCADE,
CONSTRAINT CK_publicacion__precio CHECK (precio > 0)
);

/*Crear las FK faltantes*/
ALTER TABLE tema ADD CONSTRAINT FK_tema FOREIGN KEY (cod_tema_padre) REFERENCES tema (cod_tema);
ALTER TABLE autor ADD CONSTRAINT FK_autor FOREIGN KEY (libro_principal) REFERENCES libro (cod_libro);

/*Borrar todas las tablas y con dependencia de FK*/
DROP TABLE editorial CASCADE CONSTRAINTS;
DROP TABLE tema CASCADE CONSTRAINTS;
DROP TABLE autor CASCADE CONSTRAINTS;
DROP TABLE libro CASCADE CONSTRAINTS;
DROP TABLE libro_autor CASCADE CONSTRAINTS;
DROP TABLE publicacion CASCADE CONSTRAINTS;

