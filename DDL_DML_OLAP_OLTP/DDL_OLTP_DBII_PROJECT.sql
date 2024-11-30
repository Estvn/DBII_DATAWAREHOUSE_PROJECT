-- Generado por Oracle SQL Developer Data Modeler 23.1.0.087.0806
--   en:        2024-11-30 10:54:09 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



CREATE ROLE c##_olap_admin_dbii_project NOT IDENTIFIED;

CREATE USER c##_oltp_admin_dbii_project IDENTIFIED BY ACCOUNT UNLOCK ;

-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE c##_oltp_admin_dbii_project.artistas (
    id_artista       NUMBER NOT NULL,
    nombre           VARCHAR2(100 BYTE) NOT NULL,
    nacionalidad     VARCHAR2(100 BYTE),
    fecha_nacimiento DATE
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.artistas_pk ON
    c##_oltp_admin_dbii_project.artistas (
        id_artista
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.artistas TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.artistas
    ADD CONSTRAINT artistas_pk PRIMARY KEY ( id_artista )
        USING INDEX c##_oltp_admin_dbii_project.artistas_pk;

CREATE TABLE c##_oltp_admin_dbii_project.artistas_grupos (
    id_artista NUMBER NOT NULL,
    id_grupo   NUMBER NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.artistas_grupos_pk ON
    c##_oltp_admin_dbii_project.artistas_grupos (
        id_artista
    ASC,
        id_grupo
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.artistas_grupos TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.artistas_grupos
    ADD CONSTRAINT artistas_grupos_pk PRIMARY KEY ( id_artista,
                                                    id_grupo )
        USING INDEX c##_oltp_admin_dbii_project.artistas_grupos_pk;

CREATE TABLE c##_oltp_admin_dbii_project.canciones (
    id_cancion              NUMBER NOT NULL,
    id_artista              NUMBER,
    id_grupo                NUMBER,
    id_genero               NUMBER(*, 0) NOT NULL,
    titulo                  VARCHAR2(100 BYTE) NOT NULL,
    duracion_segundos       NUMBER,
    genero                  VARCHAR2(50 BYTE),
    letra                   CLOB,
    cantidad_reproducciones NUMBER
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    )
    LOB ( letra ) STORE AS (
        TABLESPACE users
        STORAGE ( PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS UNLIMITED FREELISTS 1 BUFFER_POOL DEFAULT )
        CHUNK 8192
        RETENTION
        ENABLE STORAGE IN ROW
        NOCACHE LOGGING
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.canciones_pk ON
    c##_oltp_admin_dbii_project.canciones (
        id_cancion
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.canciones TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.canciones
    ADD CONSTRAINT canciones_pk PRIMARY KEY ( id_cancion )
        USING INDEX c##_oltp_admin_dbii_project.canciones_pk;

CREATE TABLE c##_oltp_admin_dbii_project.estadisticas (
    id_usuario                    NUMBER NOT NULL,
    id_cancion                    NUMBER NOT NULL,
    cantidad_reproducciones       NUMBER,
    fecha_ultima_reproduccion     DATE,
    cantidad_minutos_reproduccion NUMBER
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.estadisticas_pk ON
    c##_oltp_admin_dbii_project.estadisticas (
        id_usuario
    ASC,
        id_cancion
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.estadisticas TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.estadisticas
    ADD CONSTRAINT estadisticas_pk PRIMARY KEY ( id_usuario,
                                                 id_cancion )
        USING INDEX c##_oltp_admin_dbii_project.estadisticas_pk;

CREATE TABLE c##_oltp_admin_dbii_project.favoritos (
    id_usuario NUMBER NOT NULL,
    id_cancion NUMBER NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.favoritos_pk ON
    c##_oltp_admin_dbii_project.favoritos (
        id_usuario
    ASC,
        id_cancion
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.favoritos TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.favoritos
    ADD CONSTRAINT favoritos_pk PRIMARY KEY ( id_usuario,
                                              id_cancion )
        USING INDEX c##_oltp_admin_dbii_project.favoritos_pk;

CREATE TABLE c##_oltp_admin_dbii_project.generos_musicales (
    id_genero     NUMBER(*, 0) NOT NULL,
    nombre_genero VARCHAR2(400 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.generos_musicales_pk ON
    c##_oltp_admin_dbii_project.generos_musicales (
        id_genero
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.generos_musicales TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.generos_musicales
    ADD CONSTRAINT generos_musicales_pk PRIMARY KEY ( id_genero )
        USING INDEX c##_oltp_admin_dbii_project.generos_musicales_pk;

CREATE TABLE c##_oltp_admin_dbii_project.grupos (
    id_grupo   NUMBER NOT NULL,
    nombre     VARCHAR2(100 BYTE) NOT NULL,
    formacion  DATE,
    disolucion DATE
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.grupos_pk ON
    c##_oltp_admin_dbii_project.grupos (
        id_grupo
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.grupos TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.grupos
    ADD CONSTRAINT grupos_pk PRIMARY KEY ( id_grupo )
        USING INDEX c##_oltp_admin_dbii_project.grupos_pk;

CREATE TABLE c##_oltp_admin_dbii_project.listas_reproduccion (
    id_lista       NUMBER NOT NULL,
    nombre         VARCHAR2(100 BYTE) NOT NULL,
    id_usuario     NUMBER,
    fecha_creacion DATE
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.listas_reproduccion_pk ON
    c##_oltp_admin_dbii_project.listas_reproduccion (
        id_lista
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.listas_reproduccion TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.listas_reproduccion
    ADD CONSTRAINT listas_reproduccion_pk PRIMARY KEY ( id_lista )
        USING INDEX c##_oltp_admin_dbii_project.listas_reproduccion_pk;

CREATE TABLE c##_oltp_admin_dbii_project.listas_x_canciones (
    id_lista            NUMBER NOT NULL,
    id_cancion          NUMBER NOT NULL,
    fecha_hora_agregada DATE NOT NULL
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

GRANT SELECT ON c##_oltp_admin_dbii_project.listas_x_canciones TO c##_olap_admin_dbii_project;

CREATE TABLE c##_oltp_admin_dbii_project.pagos (
    id_pago    NUMBER NOT NULL,
    id_usuario NUMBER,
    id_plan    NUMBER,
    fecha_pago DATE
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.pagos_pk ON
    c##_oltp_admin_dbii_project.pagos (
        id_pago
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.pagos TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.pagos
    ADD CONSTRAINT pagos_pk PRIMARY KEY ( id_pago )
        USING INDEX c##_oltp_admin_dbii_project.pagos_pk;

CREATE TABLE c##_oltp_admin_dbii_project.planes (
    id_plan     NUMBER NOT NULL,
    nombre      VARCHAR2(100 BYTE) NOT NULL,
    precio      NUMBER(8, 2) NOT NULL,
    descripcion VARCHAR2(255 BYTE)
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.planes_pk ON
    c##_oltp_admin_dbii_project.planes (
        id_plan
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.planes TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.planes
    ADD CONSTRAINT planes_pk PRIMARY KEY ( id_plan )
        USING INDEX c##_oltp_admin_dbii_project.planes_pk;

CREATE TABLE c##_oltp_admin_dbii_project.reproducciones (
    id_reproduccion                NUMBER(*, 0) NOT NULL,
    id_usuario                     NUMBER,
    id_cancion                     NUMBER,
    fecha_reproduccion             DATE,
    duracion_reproduccion_segundos NUMBER
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.estadisticas_reproduccion_pk ON
    c##_oltp_admin_dbii_project.reproducciones (
        id_reproduccion
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.reproducciones TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.reproducciones
    ADD CONSTRAINT estadisticas_reproduccion_pk PRIMARY KEY ( id_reproduccion )
        USING INDEX c##_oltp_admin_dbii_project.estadisticas_reproduccion_pk;

CREATE TABLE c##_oltp_admin_dbii_project.top_artistas_mensuales (
    id_artista              NUMBER,
    id_grupo                NUMBER,
    anio                    NUMBER,
    mes                     VARCHAR2(200 BYTE),
    cantidad_reproducciones VARCHAR2(500 BYTE),
    posicion                NUMBER
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

GRANT SELECT ON c##_oltp_admin_dbii_project.top_artistas_mensuales TO c##_olap_admin_dbii_project;

CREATE TABLE c##_oltp_admin_dbii_project.usuarios (
    id_usuario     NUMBER NOT NULL,
    id_plan        NUMBER,
    nombre_usuario VARCHAR2(50 BYTE) NOT NULL,
    correo         VARCHAR2(100 BYTE),
    fecha_registro DATE
)
PCTFREE 10 PCTUSED 40 TABLESPACE users LOGGING
    STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT
    );

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.usuarios_correo_un ON
    c##_oltp_admin_dbii_project.usuarios (
        correo
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

CREATE UNIQUE INDEX c##_oltp_admin_dbii_project.usuarios_pk ON
    c##_oltp_admin_dbii_project.usuarios (
        id_usuario
    ASC )
        TABLESPACE users PCTFREE 10
            STORAGE ( INITIAL 65536 NEXT 1048576 PCTINCREASE 0 MINEXTENTS 1 MAXEXTENTS 2147483645 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL
            DEFAULT )
        LOGGING;

GRANT SELECT ON c##_oltp_admin_dbii_project.usuarios TO c##_olap_admin_dbii_project;

ALTER TABLE c##_oltp_admin_dbii_project.usuarios
    ADD CONSTRAINT usuarios_pk PRIMARY KEY ( id_usuario )
        USING INDEX c##_oltp_admin_dbii_project.usuarios_pk;

ALTER TABLE c##_oltp_admin_dbii_project.usuarios
    ADD CONSTRAINT usuarios_correo_un UNIQUE ( correo )
        USING INDEX c##_oltp_admin_dbii_project.usuarios_correo_un;

ALTER TABLE c##_oltp_admin_dbii_project.top_artistas_mensuales
    ADD CONSTRAINT artistas_fk FOREIGN KEY ( id_artista )
        REFERENCES c##_oltp_admin_dbii_project.artistas ( id_artista )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.listas_x_canciones
    ADD CONSTRAINT canciones_fk FOREIGN KEY ( id_cancion )
        REFERENCES c##_oltp_admin_dbii_project.canciones ( id_cancion )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.canciones
    ADD CONSTRAINT canciones_generos_musicales_fk FOREIGN KEY ( id_genero )
        REFERENCES c##_oltp_admin_dbii_project.generos_musicales ( id_genero )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.canciones
    ADD CONSTRAINT canciones_grupos_fk FOREIGN KEY ( id_grupo )
        REFERENCES c##_oltp_admin_dbii_project.grupos ( id_grupo )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.estadisticas
    ADD CONSTRAINT estadisticas_canciones_fk FOREIGN KEY ( id_cancion )
        REFERENCES c##_oltp_admin_dbii_project.canciones ( id_cancion )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.estadisticas
    ADD CONSTRAINT estadisticas_usuarios_fk FOREIGN KEY ( id_usuario )
        REFERENCES c##_oltp_admin_dbii_project.usuarios ( id_usuario )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.top_artistas_mensuales
    ADD CONSTRAINT grupos_fk FOREIGN KEY ( id_grupo )
        REFERENCES c##_oltp_admin_dbii_project.grupos ( id_grupo )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.listas_x_canciones
    ADD CONSTRAINT listas_reproduccion_fk FOREIGN KEY ( id_lista )
        REFERENCES c##_oltp_admin_dbii_project.listas_reproduccion ( id_lista )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.canciones
    ADD FOREIGN KEY ( id_artista )
        REFERENCES c##_oltp_admin_dbii_project.artistas ( id_artista )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.artistas_grupos
    ADD FOREIGN KEY ( id_artista )
        REFERENCES c##_oltp_admin_dbii_project.artistas ( id_artista )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.artistas_grupos
    ADD FOREIGN KEY ( id_grupo )
        REFERENCES c##_oltp_admin_dbii_project.grupos ( id_grupo )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.pagos
    ADD FOREIGN KEY ( id_usuario )
        REFERENCES c##_oltp_admin_dbii_project.usuarios ( id_usuario )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.pagos
    ADD FOREIGN KEY ( id_plan )
        REFERENCES c##_oltp_admin_dbii_project.planes ( id_plan )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.listas_reproduccion
    ADD FOREIGN KEY ( id_usuario )
        REFERENCES c##_oltp_admin_dbii_project.usuarios ( id_usuario )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.favoritos
    ADD FOREIGN KEY ( id_usuario )
        REFERENCES c##_oltp_admin_dbii_project.usuarios ( id_usuario )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.favoritos
    ADD FOREIGN KEY ( id_cancion )
        REFERENCES c##_oltp_admin_dbii_project.canciones ( id_cancion )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.reproducciones
    ADD FOREIGN KEY ( id_usuario )
        REFERENCES c##_oltp_admin_dbii_project.usuarios ( id_usuario )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.reproducciones
    ADD FOREIGN KEY ( id_cancion )
        REFERENCES c##_oltp_admin_dbii_project.canciones ( id_cancion )
    NOT DEFERRABLE;

ALTER TABLE c##_oltp_admin_dbii_project.usuarios
    ADD CONSTRAINT usuarios_planes_fk FOREIGN KEY ( id_plan )
        REFERENCES c##_oltp_admin_dbii_project.planes ( id_plan )
    NOT DEFERRABLE;



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            14
-- CREATE INDEX                            13
-- ALTER TABLE                             32
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
-- CREATE ROLE                              1
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
