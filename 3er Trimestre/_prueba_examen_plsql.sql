--1
CREATE OR REPLACE
PACKAGE romangestioncarreras IS
    FUNCTION  listadocaballos RETURN NUMBER;
    PROCEDURE agregarcaballos (nombre_c VARCHAR2, peso_c NUMBER, fecha_naci_c DATE, 
        nacio_c VARCHAR2, dni_p VARCHAR2, nombre_p VARCHAR2);
END;

--2
CREATE OR REPLACE
PACKAGE BODY romangestioncarreras IS
    FUNCTION listadocaballos
    RETURN NUMBER
    IS
        cursor c_caballos is
        select c.NOMBRE nom, c.PESO pe, p.NOMBRE prop, c.CODCABALLO cod
        from CABALLOS c, PERSONAS p
        WHERE c.PROPIETARIO = p.CODIGO
        ORDER BY c.NACIONALIDAD DESC, p.NOMBRE DESC;
        
        CURSOR c_carreras(codigo_c VARCHAR2) is
        SELECT c.NOMBRECARRERA carrera, per.NOMBRE jokey, c.FECHAHORA fecha, p.POSICIONFINAL pos, c.IMPORTEPREMIO premio
        FROM CABALLOS ca, PARTICIPACIONES p, CARRERAS c, PERSONAS per
        WHERE ca.CODCABALLO = p.CODCABALLO 
        AND c.CODCARRERA = p.CODCARRERA
        AND p.JOCKEY = per.CODIGO
        AND p.CODCABALLO = codigo_c
        ORDER BY c.NOMBRECARRERA DESC, c.FECHAHORA DESC;
        
        ganadas NUMBER(5):= 0;
        total_ganado NUMBER(10):= 0;
        total_caballos NUMBER(10):= 0;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('INFROME DE LOS CABALLOS EXISTENTES EN LA BASE DE DATOS');
        FOR i IN c_caballos LOOP
            DBMS_OUTPUT.PUT_LINE('Caballo: ' ||i.nom);
            DBMS_OUTPUT.PUT_LINE('Peso: ' ||i.pe);
            DBMS_OUTPUT.PUT_LINE('Nombre del Propietario: ' ||i.prop);
            FOR e IN c_carreras(i.cod) LOOP
                DBMS_OUTPUT.PUT_LINE('Nombre de la Carrera: '||e.carrera ||
                ' Nombre del jokey: '|| e.jokey || ' Fecha' ||e.fecha ||
                ' posicion final: ' ||e.pos || ' Premio: ' ||e.premio);
                IF(e.pos =1)THEN
                    ganadas := ganadas + 1;
                END IF;
                total_ganado := total_ganado + e.premio;
            END LOOP;
            DBMS_OUTPUT.PUT_LINE('Numero de carreras ganadas: ' || ganadas);
            DBMS_OUTPUT.PUT_LINE('Total del importe de todos sus premios: ' || total_ganado);
            DBMS_OUTPUT.PUT_LINE('----------------------------------');
            ganadas := 0;
            total_ganado := 0;
            total_caballos:= total_caballos + 1;
        END LOOP;
        return total_caballos;
    END listadocaballos;
    --EJERCICIO 3
    PROCEDURE agregarcaballos (nombre_c VARCHAR2, peso_c NUMBER, fecha_naci_c DATE, 
        nacio_c VARCHAR2, dni_p VARCHAR2, nombre_p VARCHAR2)
    IS
        pro_exit NUMBER(2):=0;
        max_pro NUMBER(2);
        max_caba VARCHAR2(20);
        nuevo_na VARCHAR2(30);
        existe EXCEPTION;
    BEGIN
        -- miramos si existe el propietario.
        SELECT COUNT(caba.PROPIETARIO)
        INTO pro_exit
        FROM CABALLOS caba
        WHERE caba.PROPIETARIO = (select p.CODIGO
                from PERSONAS p
                WHERE p.DNI = dni_p);
        
        -- si no existe sacamos el codigo mas alto de propietario y caballo
        IF(pro_exit =0)THEN
            
            SELECT MAX(ca.PROPIETARIO)+1
            INTO max_pro
            from CABALLOS ca;
        
            select TO_CHAR(max(cabal.CODCABALLO)+1)
            INTO max_caba
            from CABALLOS cabal;


            --insertamos al dueño
            INSERT INTO PERSONAS (codigo, dni, nombre) 
            VALUES (max_pro,dni_p,nombre_p);
            
            --miramos si la nacionalidad es nula. Si es así ponemos español
            IF(nacio_c = ''OR nacio_c IS NULL)THEN
                nuevo_na := 'ESPAÑOL';
            else
                nuevo_na := nacio_c;
            END IF;
            
            --insertamos al caballo.
            INSERT INTO CABALLOS (codcaballo,nombre, peso, fechanacimiento, propietario,nacionalidad) 
            VALUES (max_caba,nombre_c,peso_c,fecha_naci_c,max_pro,nuevo_na);
            
            commit;
        ELSE
            RAISE existe;
        END IF;
        EXCEPTION 
        WHEN existe THEN
            DBMS_OUTPUT.PUT_LINE('El caballo que está intentando insertar ya existe');
        WHEN OTHERS THEN
            rollback;
    END agregarcaballos;
END romangestioncarreras;


select ROMANGESTIONCARRERAS.LISTADOCABALLOS FROM dual;

BEGIN
    ROMANGESTIONCARRERAS.AGREGARCABALLOS('Bravo',270,TO_DATE('15/10/2007','DD/MM/YYYY'),'','66666666E','Cayetano');
END;











-- FUNCTION DEL EJ2
CREATE OR REPLACE
FUNCTION listadocaballoss
RETURN NUMBER
IS
    cursor c_caballos is
    select c.NOMBRE nom, c.PESO pe, p.NOMBRE prop, c.CODCABALLO cod
    from CABALLOS c, PERSONAS p
    WHERE c.PROPIETARIO = p.CODIGO
    ORDER BY c.NACIONALIDAD DESC, p.NOMBRE DESC;
    
    CURSOR c_carreras(codigo_c VARCHAR2) is
    SELECT c.NOMBRECARRERA carrera, per.NOMBRE jokey, c.FECHAHORA fecha, p.POSICIONFINAL pos, c.IMPORTEPREMIO premio
    FROM CABALLOS ca, PARTICIPACIONES p, CARRERAS c, PERSONAS per
    WHERE ca.CODCABALLO = p.CODCABALLO 
    AND c.CODCARRERA = p.CODCARRERA
    AND p.JOCKEY = per.CODIGO
    AND p.CODCABALLO = codigo_c
    ORDER BY c.NOMBRECARRERA DESC, c.FECHAHORA DESC;
    
    ganadas NUMBER(5):= 0;
    total_ganado NUMBER(10):= 0;
    total_caballos NUMBER(10):= 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('INFROME DE LOS CABALLOS EXISTENTES EN LA BASE DE DATOS');
    FOR i IN c_caballos LOOP
        DBMS_OUTPUT.PUT_LINE('Caballo: ' ||i.nom);
        DBMS_OUTPUT.PUT_LINE('Peso: ' ||i.pe);
        DBMS_OUTPUT.PUT_LINE('Nombre del Propietario: ' ||i.prop);
        FOR e IN c_carreras(i.cod) LOOP
            DBMS_OUTPUT.PUT_LINE('Nombre de la Carrera: '||e.carrera ||
            ' Nombre del jokey: '|| e.jokey || ' Fecha' ||e.fecha ||
            ' posicion final: ' ||e.pos || ' Premio: ' ||e.premio);
            IF(e.pos =1)THEN
                ganadas := ganadas + 1;
            END IF;
            total_ganado := total_ganado + e.premio;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('Numero de carreras ganadas: ' || ganadas);
        DBMS_OUTPUT.PUT_LINE('Total del importe de todos sus premios: ' || total_ganado);
        DBMS_OUTPUT.PUT_LINE('----------------------------------');
        ganadas := 0;
        total_ganado := 0;
        total_caballos:= total_caballos + 1;
    END LOOP;
    return total_caballos;
END;

select listadocaballoss from dual;

-- PROCEDURE EJ3
CREATE OR REPLACE
PROCEDURE prueba (nombre_c VARCHAR2, peso_c NUMBER, fecha_naci_c DATE, 
        nacio_c VARCHAR2, dni_p VARCHAR2, nombre_p VARCHAR2)
IS
    pro_exit NUMBER(2):=0;
    max_pro NUMBER(2);
    max_caba VARCHAR2(20);
    nuevo_na VARCHAR2(30);
    existe EXCEPTION;
BEGIN
    -- miramos si existe el propietario.
    SELECT COUNT(caba.PROPIETARIO)
    INTO pro_exit
    FROM CABALLOS caba
    WHERE caba.PROPIETARIO = (select p.CODIGO
            from PERSONAS p
            WHERE p.DNI = dni_p);
    
    -- si no existe sacamos el codigo mas alto de propietario y caballo
    IF(pro_exit =0)THEN
        
        SELECT MAX(ca.PROPIETARIO)+1
        INTO max_pro
        from CABALLOS ca;
    
        select TO_CHAR(max(cabal.CODCABALLO)+1)
        INTO max_caba
        from CABALLOS cabal;


        --insertamos al dueño
        INSERT INTO PERSONAS (codigo, dni, nombre) 
        VALUES (max_pro,dni_p,nombre_p);
        
        --miramos si la nacionalidad es nula. Si es así ponemos español
        IF(nacio_c = ''OR nacio_c IS NULL)THEN
            nuevo_na := 'ESPAÑOL';
        else
            nuevo_na := nacio_c;
        END IF;
        
        --insertamos al caballo.
        INSERT INTO CABALLOS (codcaballo,nombre, peso, fechanacimiento, propietario,nacionalidad) 
        VALUES (max_caba,nombre_c,peso_c,fecha_naci_c,max_pro,nuevo_na);
        
        commit;
    ELSE
        RAISE existe;
    END IF;
    EXCEPTION 
    WHEN existe THEN
        DBMS_OUTPUT.PUT_LINE('El caballo que está intentando insertar ya existe');
    WHEN OTHERS THEN
        rollback;
END;

BEGIN
    prueba('Bravo',270,TO_DATE('15/10/2007','DD/MM/YYYY'),'','66666666V','Cayetano');
END;

delete from CABALLOS where CABALLOS.PROPIETARIO = 22;
delete from PERSONAS where PERSONAS.DNI = '66666666V';
