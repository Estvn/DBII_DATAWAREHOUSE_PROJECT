CREATE OR REPLACE PACKAGE PK_ETL_CANCIONES
IS 
   FUNCTION FN_OBTENER_CANCIONES(QUERY_ORIGIN_TBL_CANCIONES VARCHAR2) RETURN SYS_REFCURSOR;
   PROCEDURE SP_INSERTAR_CANCIONES(QUERY_ORIGIN_TBL_CANCIONES VARCHAR2, MSJ OUT VARCHAR2);
END;

CREATE OR REPLACE PACKAGE BODY PK_ETL_CANCIONES
IS 
    FUNCTION FN_OBTENER_CANCIONES(QUERY_ORIGIN_TBL_CANCIONES VARCHAR2) RETURN SYS_REFCURSOR
    IS
        DATOS_CANCIONES SYS_REFCURSOR;
    BEGIN
        
        OPEN DATOS_CANCIONES FOR QUERY_ORIGIN_TBL_CANCIONES;
        RETURN DATOS_CANCIONES;        
    END;
    
    PROCEDURE SP_INSERTAR_CANCIONES(QUERY_ORIGIN_TBL_CANCIONES VARCHAR2 ,MSJ OUT VARCHAR2)
    IS
        TYPE FILA IS RECORD(
            CANCION_ID DIM_CANCION.ID_CANCION%TYPE, -- NUMBER
            TITULO DIM_CANCION.T�TULO%TYPE, -- VARCHAR2(100 BYTE)
            GENERO DIM_CANCION.G�NERO%TYPE, -- VARCHAR2(50 BYTE)
            DURACION DIM_CANCION.DURACI�N%TYPE -- NUMBER
        );
        FILA_CANCION FILA;
    
        DATOS_OBTENIDOS SYS_REFCURSOR;
    BEGIN    
        DATOS_OBTENIDOS := FN_OBTENER_CANCIONES(QUERY_ORIGIN_TBL_CANCIONES);
        
        LOOP
            FETCH DATOS_OBTENIDOS INTO FILA_CANCION;
            EXIT WHEN DATOS_OBTENIDOS%NOTFOUND;
            
            INSERT INTO DIM_CANCION VALUES (
            FILA_CANCION.CANCION_ID, 
            FILA_CANCION.TITULO, 
            FILA_CANCION.GENERO,
            FILA_CANCION.DURACION);
            
            /*
            DBMS_OUTPUT.PUT_LINE('ID DE LA CANCION: '|| FILA_CANCION.CANCION_ID);
            DBMS_OUTPUT.PUT_LINE('GENERO DE LA CANCION: ' || FILA_CANCION.TITULO); 
            DBMS_OUTPUT.PUT_LINE('TITULO DE LA CANCION: ' || FILA_CANCION.GENERO);
            DBMS_OUTPUT.PUT_LINE('DURACION DE LA CANCION: ' || FILA_CANCION.DURACION);
            DBMS_OUTPUT.PUT_LINE(CHR(10));
            */
            
        END LOOP;     
        CLOSE DATOS_OBTENIDOS;
        COMMIT;
        MSJ := 'EJECUCI�N DE ETL CANCIONES COMPLETADO CORRECTAMENTE.';
        
        EXCEPTION
            WHEN OTHERS THEN
                MSJ := 'ERROR EN EL ETL CANCION: ' || SQLERRM;
                ROLLBACK;
    END;
END;

DECLARE
    MENSAJE VARCHAR2(500);
    
    QUERY_ORIGIN_TBL_CANCIONES VARCHAR2(1500) := 'SELECT 
        OTLP_CANCIONES.ID_CANCION, 
        NVL(UPPER(TRIM(TRAILING ''.'' FROM OTLP_CANCIONES.TITULO)), ''SIN DEFINIR''),
        NVL(UPPER(TRIM(TRAILING ''.'' FROM OTLP_CANCIONES.GENERO)), ''NO ENCONTRADO''),
        NVL(OTLP_CANCIONES.DURACION_SEGUNDOS, 0)
        FROM C##_OLTP_ADMIN_DBII_PROJECT.CANCIONES OTLP_CANCIONES
        WHERE NOT EXISTS
        (SELECT * FROM DIM_CANCION DC WHERE DC.ID_CANCION = OTLP_CANCIONES.ID_CANCION)';
        
BEGIN
    PK_ETL_CANCIONES.SP_INSERTAR_CANCIONES(QUERY_ORIGIN_TBL_CANCIONES, MENSAJE);
    DBMS_OUTPUT.PUT_LINE(MENSAJE);
END;

DELETE FROM DIM_CANCION;
SET SERVEROUTPUT ON;
SELECT COUNT(*) FROM DIM_CANCION;

SELECT * FROM DIM_CANCION;

SET SERVEROUTPUT ON;