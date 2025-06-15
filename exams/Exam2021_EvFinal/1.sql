CONNECT system/bdadmin;

CREATE USER ORD2021 IDENTIFIED BY EXAMEN;
GRANT CONNECT, RESOURCE TO ORD2021;

CONNECT ORD2021/EXAMEN;

CREATE TABLE EMPLEADO(
    dni         VARCHAR2(20)    CONSTRAINT emp_dni_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    apellido1   VARCHAR2(20),
    email       VARCHAR2(20),
    fechaalta   DATE
);

CREATE TABLE EXTERIOR(
    codigo      VARCHAR2(20)    CONSTRAINT ext_cod_pk PRIMARY KEY,
    descripcion VARCHAR2(20)
);

CREATE TABLE PROYECTO(
    codigo      VARCHAR2(20)    CONSTRAINT pro_cod_pk PRIMARY KEY,
    nombre      VARCHAR2(20),
    fechainicio DATE,
    fechafin    DATE
);

CREATE TABLE DIETAS(
    dniempleado VARCHAR2(20),
    codproyecto VARCHAR2(20),
    codexterior VARCHAR2(20),
    numdias     NUMBER(5),
    preciodia   VARCHAR2(20),
    CONSTRAINT die_dni_codp_code_pk PRIMARY KEY(dniempleado, codproyecto, codexterior),
    CONSTRAINT die_dni_emp_fk FOREIGN KEY(dniempleado) REFERENCES EMPLEADO,
    CONSTRAINT die_codp_pro_fk FOREIGN KEY(codproyecto) REFERENCES PROYECTO,
    CONSTRAINT die_code_ext_fk FOREIGN KEY(codexterior) REFERENCES EXTERIOR
);

ALTER TABLE DIETAS MODIFY(preciodia NUMBER(5,2) CONSTRAINT die_pre_nn NOT NULL CONSTRAINT die_pre_ch CHECK(preciodia< 1000 AND preciodia>0));
ALTER TABLE EMPLEADO MODIFY(fechaalta DEFAULT SYSDATE);