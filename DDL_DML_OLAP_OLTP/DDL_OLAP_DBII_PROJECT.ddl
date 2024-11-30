-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-11-30 11:04:40 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE USER c##_olap_admin_dbii_project IDENTIFIED BY ACCOUNT UNLOCK ;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE c##_olap_admin_dbii_project.dim_artista (
    id_artista NUMBER NOT NULL,
    nombre     VARCHAR2(100 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE c##_olap_admin_dbii_project.dim_artista
    ADD CONSTRAINT dim_artista_pk PRIMARY KEY ( id_artista )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE c##_olap_admin_dbii_project.dim_cancion (
    id_cancion NUMBER NOT NULL,
    título     VARCHAR2(100 BYTE) NOT NULL,
    género     VARCHAR2(50 BYTE) NOT NULL,
    duración   NUMBER NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE c##_olap_admin_dbii_project.dim_cancion
    ADD CONSTRAINT dim_cancion_pk PRIMARY KEY ( id_cancion )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE c##_olap_admin_dbii_project.dim_plan (
    id_plan NUMBER NOT NULL,
    nombre  VARCHAR2(50 BYTE) NOT NULL,
    precio  NUMBER(10, 2) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE c##_olap_admin_dbii_project.dim_plan
    ADD CONSTRAINT dim_plan_pk PRIMARY KEY ( id_plan )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE c##_olap_admin_dbii_project.dim_tiempo (
    id_tiempo  NUMBER NOT NULL,
    mes        VARCHAR2(30 BYTE) NOT NULL,
    día        NUMBER NOT NULL,
    año        NUMBER NOT NULL,
    nombre_dia VARCHAR2(25 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE c##_olap_admin_dbii_project.dim_tiempo
    ADD CONSTRAINT dim_tiempo_pk PRIMARY KEY ( id_tiempo )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE c##_olap_admin_dbii_project.dim_usuario (
    id_usuario     NUMBER NOT NULL,
    nombre         VARCHAR2(100 BYTE) NOT NULL,
    fecha_registro DATE NOT NULL,
    plan_nombre    VARCHAR2(50 BYTE) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE c##_olap_admin_dbii_project.dim_usuario
    ADD CONSTRAINT dim_usuario_pk PRIMARY KEY ( id_usuario )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE TABLE c##_olap_admin_dbii_project.hechos_reproducciones (
    id_reproduccion                NUMBER NOT NULL,
    id_usuario                     NUMBER NOT NULL,
    id_cancion                     NUMBER NOT NULL,
    id_artista                     NUMBER NOT NULL,
    id_tiempo                      NUMBER NOT NULL,
    id_plan                        NUMBER NOT NULL,
    duracion_reproduccion_segundos NUMBER NOT NULL,
    veces_reproducidas             NUMBER NOT NULL,
    ganancias_plan                 NUMBER(10, 2) NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE c##_olap_admin_dbii_project.hechos_reproducciones
    ADD CONSTRAINT hechos_reproducciones_pk PRIMARY KEY ( id_reproduccion )
        USING INDEX PCTFREE 10 INITRANS 2 TABLESPACE users
LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

ALTER TABLE c##_olap_admin_dbii_project.hechos_reproducciones
    ADD FOREIGN KEY ( id_usuario )
        REFERENCES c##_olap_admin_dbii_project.dim_usuario ( id_usuario )
    NOT DEFERRABLE;

ALTER TABLE c##_olap_admin_dbii_project.hechos_reproducciones
    ADD FOREIGN KEY ( id_cancion )
        REFERENCES c##_olap_admin_dbii_project.dim_cancion ( id_cancion )
    NOT DEFERRABLE;

ALTER TABLE c##_olap_admin_dbii_project.hechos_reproducciones
    ADD FOREIGN KEY ( id_artista )
        REFERENCES c##_olap_admin_dbii_project.dim_artista ( id_artista )
    NOT DEFERRABLE;

ALTER TABLE c##_olap_admin_dbii_project.hechos_reproducciones
    ADD FOREIGN KEY ( id_tiempo )
        REFERENCES c##_olap_admin_dbii_project.dim_tiempo ( id_tiempo )
    NOT DEFERRABLE;

ALTER TABLE c##_olap_admin_dbii_project.hechos_reproducciones
    ADD FOREIGN KEY ( id_plan )
        REFERENCES c##_olap_admin_dbii_project.dim_plan ( id_plan )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             6
-- CREATE INDEX                             0
-- ALTER TABLE                             11
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              1
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
