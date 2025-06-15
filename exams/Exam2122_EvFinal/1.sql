CONNECT system/bdadmin;

CREATE USER ord2122 IDENTIFIED BY examen;
GRANT CONNECT, RESOURCE TO ord2122;

CONNECT ord2122/examen;

CREATE TABLE EMPLEADO(
    dni         VARCHAR2(20)        CONSTRAINT emp_dni_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    apellido1   VARCHAR2(20),
    email       VARCHAR2(20),
    fechaalta   DATE
);

CREATE TABLE EXTERIOR(
    codigo      VARCHAR2(20)        CONSTRAINT ext_cod_pk PRIMARY KEY,
    descripcion VARCHAR2(20)
);

CREATE TABLE PROYECTO(
    codigo      VARCHAR2(20)        CONSTRAINT pro_cod_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    inicio      VARCHAR2(20),
    fin         VARCHAR2(20)
);

CREATE TABLE DIETAS(
    dni         VARCHAR2(20)        CONSTRAINT die_dni_nn NOT NULL,
    codproyecto VARCHAR2(20)        CONSTRAINT die_codp_pro_fk REFERENCES PROYECTO,
    codexterior VARCHAR2(20)        CONSTRAINT die_code_ext_fk REFERENCES EXTERIOR,
    numdias     NUMBER(5)           DEFAULT 1,
    preciodia   NUMBER(6,2),
    CONSTRAINT die_codp_code_pk PRIMARY KEY(codproyecto, codexterior),
    CONSTRAINT die_dni_emp_fk FOREIGN KEY(dni) REFERENCES EMPLEADO ON DELETE CASCADE
);

ALTER TABLE DIETAS MODIFY(preciodia CONSTRAINT die_pre_nn NOT NULL CONSTRAINT die_pre_ch CHECK(preciodia >0 AND preciodia<1000));