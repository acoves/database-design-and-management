CONNECT system/bdadmin;

CREATE USER tutelar IDENTIFIED BY tut;
GRANT CONNECT, RESOURCE TO tutelar;

CONNECT tutelar/tut;

CREATE TABLE MENOR(
    dni         VARCHAR2(20)        CONSTRAINT men_dni_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    apellido1   VARCHAR2(20),
    fechanac    DATE
);

CREATE TABLE JUZGADO(
    codigo      VARCHAR2(20)        CONSTRAINT juz_cod_pk PRIMARY KEY,
    direccion   VARCHAR2(20)
);

CREATE TABLE ABOGADO(
    dni         VARCHAR2(20)        CONSTRAINT abo_dni_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    apellido1   VARCHAR2(20),
    telefono    VARCHAR2(20),
    ncolegiado  VARCHAR2(20)        CONSTRAINT abo_nco_nn NOT NULL,
    CONSTRAINT abo_nco_uq UNIQUE(ncolegiado)
);

CREATE TABLE EXPEDIENTE(
    numero          NUMBER(5),
    dnimenor        VARCHAR2(20)    CONSTRAINT exp_dnim_men_fk REFERENCES MENOR,
    delito          VARCHAR2(20),
    fecha           DATE,
    sentencia       VARCHAR2(20),
    codigojuzgado   VARCHAR2(20)    CONSTRAINT exp_cod_juz_fk REFERENCES JUZGADO,
    dniabogado      VARCHAR2(20)    CONSTRAINT exp_dnia_nn NOT NULL,
    CONSTRAINT exp_dnia_abo_fk FOREIGN KEY(dniabogado) REFERENCES ABOGADO,
    CONSTRAINT exp_num_dnim_pk PRIMARY KEY(numero, dnimenor)
);