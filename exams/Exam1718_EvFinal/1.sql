CONNECT system/bdadmin;

CREATE USER ord1718 IDENTIFIED BY ene1718;
GRANT CONNECT, RESOURCE TO ord1718;

CONNECT ord1718/ene1718;

CREATE TABLE MENOR(
    dni             VARCHAR2(20)        CONSTRAINT men_dni_pk PRIMARY KEY,
    nombre          VARCHAR2(20),
    apellido1       VARCHAR2(20),
    fechanac        DATE
);

CREATE TABLE ABOGADO(
    dni             VARCHAR2(20)        CONSTRAINT abo_dni_pk PRIMARY KEY,
    nombre          VARCHAR2(20),
    apellido1       VARCHAR2(20),
    ncolegiado      VARCHAR2(20)        CONSTRAINT abo_nco_nn NOT NULL,
    CONSTRAINT abo_nco_uq UNIQUE(ncolegiado)
);

CREATE TABLE EXPEDIENTE(
    numero          VARCHAR2(20),
    dnimenor        VARCHAR2(20),
    delito          VARCHAR2(20),
    fechaapertura   DATE,
    sentencia       VARCHAR2(20),
    dniabogado      VARCHAR2(20)        CONSTRAINT exp_dnia_nn NOT NULL,
    CONSTRAINT exp_num_dnim_pk PRIMARY KEY(numero, dnimenor),
    CONSTRAINT exp_dnia_abo_fk FOREIGN KEY(dniabogado) REFERENCES ABOGADO,
    CONSTRAINT exp_dnim_men_fk FOREIGN KEY(dnimenor) REFERENCES MENOR
);

ALTER TABLE EXPEDIENTE MODIFY(fechaapertura DEFAULT SYSDATE);
ALTER TABLE EXPEDIENTE MODIFY(sentencia CONSTRAINT exp_sen_ch CHECK(sentencia IN ('C','I') OR sentencia IS NULL));