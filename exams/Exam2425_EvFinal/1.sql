CONNECT system/bdadmin;

CREATE USER ord2425 IDENTIFIED BY examen;
GRANT CONNECT, RESOURCE TO ord2425;

CONNECT ord2425/examen;

CREATE TABLE PRUEBA(
    codigo      VARCHAR2(20)        CONSTRAINT pru_cod_pk PRIMARY KEY,
    nombre      VARCHAR2(20)
);

CREATE TABLE CENTRO(
    codigo      VARCHAR2(20)        CONSTRAINT cen_cod_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    localidad   VARCHAR2(20)
);

CREATE TABLE DEPORTISTA(
    dni         VARCHAR2(20)        CONSTRAINT dep_dni_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    apellido1   VARCHAR2(20),
    localidad   VARCHAR2(20),
    telefono    VARCHAR2(20),
    iddep       VARCHAR2(20)        CONSTRAINT dep_idd_nn NOT NULL,
    CONSTRAINT dep_idd_uq UNIQUE(iddep)
);

CREATE TABLE CELEBRAR(
    codigo      VARCHAR2(20)        CONSTRAINT cel_cod_pru_fk REFERENCES PRUEBA,
    centro      VARCHAR2(20)        CONSTRAINT cel_cen_cen_fk REFERENCES CENTRO,
    dia         DATE,
    precio      NUMBER(5,2),
    CONSTRAINT cel_cod_cen_dia_pk PRIMARY KEY(codigo, centro, dia)
);

CREATE TABLE PARTICIPAR(
    dni         VARCHAR2(20)        CONSTRAINT par_dni_dep_fk REFERENCES DEPORTISTA,
    codigo      VARCHAR2(20),
    centro      VARCHAR2(20),
    fecha       DATE,
    posicion    NUMBER(5),
    CONSTRAINT par_dni_cod_cen_fec_pk PRIMARY KEY(dni, codigo, centro, fecha),
    CONSTRAINT par_cod_cen_fec_cel_fk FOREIGN KEY(codigo, centro, fecha) REFERENCES CELEBRAR
);

ALTER TABLE CELEBRAR MODIFY(precio  CONSTRAINT cel_pre_ch CHECK (precio >= 0 AND precio <= 120));