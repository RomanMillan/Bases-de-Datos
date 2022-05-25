

create or replace 
procedure recaudacion_total (nom_c varchar2, sala_c number)
AS
    nom_cine varchar2(20);
    num_s number(5);
    r_total number(15);
    afo_s number(5);
    cine_ciu varchar(20);
BEGIN
    select p.CINE, p.SALA, SUM(p.RECAUDACION) reca_total, s.AFORO,c.CIUDAD_CINE
    INTO nom_cine, num_s, r_total, afo_s, cine_ciu
    from PROYECCION p , SALA s, CINE c
    where p.CINE = s.CINE
    and p.SALA = s.SALA
    and c.CINE = s.CINE
    and p.CINE = nom_c
    and p.SALA = sala_c
    GROUP BY p.CINE, p.SALA, s.aforo, c.CIUDAD_CINE;
    
    DBMS_OUTPUT.PUT_LINE('Cine: '|| nom_cine || ' // Num sala: '|| num_s || 
                            ' // Reca total: '|| r_total || ' // aforo sala: ' || afo_s
                            ||' // Nom ciudad: ' || cine_ciu);
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Datos no encontrados');
END;

BEGIN
    recaudacion_total ('Los Arcos', 1);
END;

BEGIN
    peliculas('11111110-S');
END;


create or replace 
procedure actualizar_ti_p (cod_p varchar2, nuevo_nom varchar2)
AS
BEGIN
    update PELICULA p
    set p.TITULO_S = nuevo_nom
    where p.CIP = cod_p;
    if(SQL%ROWCOUNT =0)then
        RAISE_APPLICATION_ERROR(-20001, 'pelicula no encontrada');
    END IF;
END;

BEGIN
    actualizar_ti_p('11111124-S','moco');
END;


CREATE OR REPLACE
PACKAGE codig_p AS
    ti_s varchar(40);
	cod_p varchar2(20);
END;

CREATE OR REPLACE
TRIGGER conseguir_codigo
BEFORE UPDATE OF titulo_s ON pelicula
FOR EACH ROW
BEGIN
    codig_p.ti_s := :NEW.titulo_s;
    codig_p.cod_p := :NEW.CID;   -- si es una PK no puedo 
END;


create or replace
trigger act_ti_p
before update on pelicula
for each row
declare
    duracion_p number(10);
begin
    select p.DURACION
    into duracion_p
    from PELICULA p
    --where p.CIP = codig_p.cod_p;
    where p.CIP = codig_p.cod_p;
    
    if(duracion_p > 100)then 
        RAISE_APPLICATION_ERROR(-20003, 'No puede actualizar nombre con duracion mayor a 100 min');
    end if;
end;

    