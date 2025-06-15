CONNECT system/bdadmin;

CREATE USER libreria IDENTIFIED BY 1516;
GRANT CONNECT, RESOURCE TO libreria;

CONNECT libreria/1516;

CREATE TABLE LIBRO(
    codigo          VARCHAR2(20)        CONSTRAINT lib_cod_pk PRIMARY KEY,
    titulo          VARCHAR2(20),
    precio          NUMBER(5,2),
    nejemplares     NUMBER(5),
    anopublicacion  NUMBER(5)
);

CREATE TABLE TEMA(
    codigo          VARCHAR2(20)        CONSTRAINT tem_cod_pk PRIMARY KEY,
    nombre          VARCHAR2(20)
);

CREATE TABLE TRATAR(
    codigolibro     VARCHAR2(20)        CONSTRAINT tra_codigol_lib_fk REFERENCES LIBRO,
    codigotema      VARCHAR2(20)        CONSTRAINT tra_codigot_tem_fk REFERENCES TEMA,
    CONSTRAINT tra_codigol_codigot_pk PRIMARY KEY(codigolibro, codigotema)
);