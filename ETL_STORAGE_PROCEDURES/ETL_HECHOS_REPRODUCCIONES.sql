CREATE OR REPLACE PACKAGE PK_HECHOS_REPRODUCCIONES AS 
    FUNCTION FN_OBTENER_REPRODUCCIONES(QUERY_ORIGIN_TBL_HECHOS VARCHAR2) RETURN SYS_REFCURSOR;
    PROCEDURE SP_INSERTAR_REPRODUCCIONES(QUERY_ORIGIN_TBL_HECHOS VARCHAR2 ,MSJ OUT VARCHAR2);
END;

CREATE OR REPLACE PACKAGE BODY PK_HECHOS_REPRODUCCIONES 
IS 
    FUNCTION FN_OBTENER_REPRODUCCIONES(QUERY_ORIGIN_TBL_HECHOS VARCHAR2) RETURN SYS_REFCURSOR 
    IS
        DATOS_REPRODUCCIONES SYS_REFCURSOR;
    BEGIN 
        OPEN DATOS_REPRODUCCIONES FOR QUERY_ORIGIN_TBL_HECHOS;
            
        RETURN DATOS_REPRODUCCIONES;
    END;
    
    PROCEDURE SP_INSERTAR_REPRODUCCIONES(QUERY_ORIGIN_TBL_HECHOS VARCHAR2 ,MSJ OUT VARCHAR2) 
    IS
        DATOS_OBTENIDOS SYS_REFCURSOR;
        V_ID_REPRODUCCION NUMBER;
        V_ID_USUARIO NUMBER;
        V_ID_CANCION NUMBER;
        V_ID_ARTISTA NUMBER;
        V_ID_TIEMPO NUMBER;
        V_ID_PLAN NUMBER;
        V_DURACION_RPD_SEG NUMBER;
        V_VECES_REPRODUCIDAS NUMBER;
        V_GANANCIAS_PLAN NUMBER(10,2);
    BEGIN
        DATOS_OBTENIDOS := FN_OBTENER_REPRODUCCIONES(QUERY_ORIGIN_TBL_HECHOS);
        
        LOOP 
            FETCH DATOS_OBTENIDOS INTO 
                V_ID_REPRODUCCION,
                V_ID_USUARIO,
                v_ID_CANCION,
                V_ID_ARTISTA,
                V_ID_TIEMPO,
                V_ID_PLAN,
                V_DURACION_RPD_SEG,
                V_VECES_REPRODUCIDAS,
                V_GANANCIAS_PLAN;
            EXIT WHEN DATOS_OBTENIDOS%NOTFOUND;
            
            INSERT INTO HECHOS_REPRODUCCIONES(
                ID_REPRODUCCION,
                ID_USUARIO,
                ID_CANCION,
                ID_ARTISTA,
                ID_TIEMPO,
                ID_PLAN,
                DURACION_REPRODUCCION_SEGUNDOS,
                VECES_REPRODUCIDAS,
                GANANCIAS_PLAN)
                SELECT V_ID_REPRODUCCION,
                    V_ID_USUARIO,
                    V_ID_CANCION,
                    V_ID_ARTISTA,
                    V_ID_TIEMPO,
                    V_ID_PLAN,
                    V_DURACION_RPD_SEG,
                    V_VECES_REPRODUCIDAS,
                    V_GANANCIAS_PLAN
                FROM DUAL
                WHERE NOT EXISTS (
                    SELECT 1 
                    FROM HECHOS_REPRODUCCIONES
                    WHERE HECHOS_REPRODUCCIONES.ID_REPRODUCCION = V_ID_REPRODUCCION
                );
            END LOOP;
            
            CLOSE DATOS_OBTENIDOS;
             MSJ := 'EJECUCIÓN DE ETL HECHOS COMPLETADO CORRECTAMENTE.';
            COMMIT;
        
            EXCEPTION 
                WHEN OTHERS THEN 
                MSJ := SQLERRM;
                ROLLBACK;
    END;
END;
    
DECLARE 
    MENSAJE VARCHAR2(500);
    
    QUERY_ORIGIN_TBL_HECHOS VARCHAR2(2500) := 'SELECT
                                                R.ID_REPRODUCCION,
                                                R.ID_USUARIO,
                                                R.ID_CANCION,
                                                C.ID_ARTISTA,
                                                1 AS ID_TIEMPO,
                                                U.ID_PLAN,
                                                R.DURACION_REPRODUCCION_SEGUNDOS,
                                                NVL(E.CANTIDAD_REPRODUCCIONES, 0) AS VECES_REPRODUCIDAS,
                                                NVL(P.PRECIO * E.CANTIDAD_REPRODUCCIONES, 0) AS GANANCIAS_PLAN
                                                FROM 
                                                    C##_OLTP_ADMIN_DBII_PROJECT.REPRODUCCIONES R
                                                JOIN
                                                    C##_OLTP_ADMIN_DBII_PROJECT.CANCIONES C ON R.ID_CANCION = C.ID_CANCION
                                                JOIN 
                                                    C##_OLTP_ADMIN_DBII_PROJECT.USUARIOS U ON R.ID_USUARIO = U.ID_USUARIO
                                                LEFT JOIN
                                                    C##_OLTP_ADMIN_DBII_PROJECT.ESTADISTICAS E ON R.ID_CANCION = E.ID_CANCION AND R.ID_USUARIO = E.ID_USUARIO
                                                JOIN 
                                                    C##_OLTP_ADMIN_DBII_PROJECT.PLANES P ON U.ID_PLAN = P.ID_PLAN';
            
BEGIN
    PK_HECHOS_REPRODUCCIONES.SP_INSERTAR_REPRODUCCIONES(QUERY_ORIGIN_TBL_HECHOS ,MENSAJE);
    DBMS_OUTPUT.PUT_LINE(MENSAJE);
END;

DELETE FROM HECHOS_REPRODUCCIONES;

SET SERVEROUTPUT ON;

SELECT * FROM HECHOS_REPRODUCCIONES;


                
        