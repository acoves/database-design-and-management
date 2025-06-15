CONNECT system/bdadmin;

CREATE USER ord1617 IDENTIFIED BY examen;
GRANT CONNECT, RESOURCE TO ord1617;

CONNECT ord1617/examen;

CREATE TABLE CLASE(
    codigo      VARCHAR2(20)        CONSTRAINT cla_cod_pk PRIMARY KEY,
    nombre      VARCHAR2(20)
);

CREATE TABLE MONITOR(
    dni         VARCHAR2(20)        CONSTRAINT mon_dni_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    apellidos   VARCHAR2(20),
    telefono    VARCHAR2(20)
);

CREATE TABLE SALA(
    codigo      VARCHAR2(20)        CONSTRAINT sal_cod_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    ubicacion   VARCHAR2(20)
);

CREATE TABLE IMPARTIR(
    codmonitor  VARCHAR2(20),
    codclase    VARCHAR2(20)        CONSTRAINT imp_codc_nn NOT NULL,
    codsala     VARCHAR2(20)        CONSTRAINT imp_cods_nn NOT NULL,
    diassemana  VARCHAR2(20),
    CONSTRAINT imp_codm_codc_pk PRIMARY KEY(codmonitor, codclase),
    CONSTRAINT imp_codm_mon_fk FOREIGN KEY(codmonitor) REFERENCES MONITOR,
    CONSTRAINT imp_codc_cla_fk FOREIGN KEY(codclase) REFERENCES CLASE,
    CONSTRAINT imp_cods_sal_fk FOREIGN KEY(codsala) REFERENCES SALA,
    CONSTRAINT imp_codc_cods_uq UNIQUE(codclase, codsala)
);

