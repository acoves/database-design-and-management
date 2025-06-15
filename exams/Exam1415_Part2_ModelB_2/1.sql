CONNECT system/bdadmin;

CREATE USER clubpadel IDENTIFIED BY club;
GRANT CONNECT, RESOURCE TO clubpadel;

CONNECT clubpadel/club;

CREATE TABLE TORNEO(
    codigo      VARCHAR2(20)        CONSTRAINT tor_cod_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    fechainicio DATE,
    descripcion VARCHAR2(20)
);

CREATE TABLE SOCIO(
    dni         VARCHAR2(20)        CONSTRAINT soc_dni_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    apellido1   VARCHAR2(20),
    apellido2   VARCHAR2(20),
    telefono    VARCHAR2(20),
    email       VARCHAR2(20),
    fechanac    DATE,
    sexo        VARCHAR2(20)
);

CREATE TABLE PATROCINADOR(
    cif         VARCHAR2(20)        CONSTRAINT pat_cif_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    telefono    VARCHAR2(20),
    email       VARCHAR2(20)
);

CREATE TABLE FINANCIAR(
    cifpatrocinador     VARCHAR2(20)    CONSTRAINT fin_cif_pat_fk REFERENCES PATROCINADOR,
    codtorneo           VARCHAR2(20)    CONSTRAINT fin_cod_tor_fk REFERENCES TORNEO,
    importe             NUMBER(5,2),
    CONSTRAINT fin_cif_cod_pk PRIMARY KEY(cifpatrocinador, codtorneo)
);

CREATE TABLE PARTICIPAR(
    codtorneo           VARCHAR2(20)    CONSTRAINT par_cod_nn NOT NULL,
    socio1              VARCHAR2(20),
    socio2              VARCHAR2(20)    CONSTRAINT par_socio2_nn NOT NULL,
    posicion            VARCHAR2(20),
    CONSTRAINT par_cod_socio1_pk PRIMARY KEY(codtorneo, socio1),
    CONSTRAINT par_cod_tor_fk FOREIGN KEY(codtorneo) REFERENCES TORNEO,
    CONSTRAINT par_socio1_soc_fk FOREIGN KEY(socio1) REFERENCES SOCIO,
    CONSTRAINT par_socio2_soc_fk FOREIGN KEY(socio2) REFERENCES SOCIO,
    CONSTRAINT par_cod_socio2_uq UNIQUE(codtorneo, socio2)
);