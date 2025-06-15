CONNECT system/bdadmin;

CREATE USER ord1819 IDENTIFIED BY ene1819;
GRANT CONNECT, RESOURCE TO ord1819;

CONNECT ord1819/ene1819;

CREATE TABLE ALUMNO(
    numexpediente       NUMBER(5)       CONSTRAINT alu_num_pk PRIMARY KEY,
    nombre              VARCHAR2(20),
    apellido1           VARCHAR2(20),
    apellido2           VARCHAR2(20),
    fechanacimiento     DATE
);

CREATE TABLE ASIGNATURA(
    codigo              VARCHAR2(20)    CONSTRAINT asi_cod_pk PRIMARY KEY,
    nombre              VARCHAR2(20),
    creditos            NUMBER(5,1),
    tipo                VARCHAR2(20)
);

CREATE TABLE MATRICULAR(
    codigoalumno        NUMBER(5),
    codigoasignatura    VARCHAR2(20),
    convocatoria        VARCHAR2(20),
    nota                NUMBER(5),
    CONSTRAINT mat_codigoal_codigoas_con_pk PRIMARY KEY(codigoalumno, codigoasignatura, convocatoria),
    CONSTRAINT mat_codigoal_alu_fk FOREIGN KEY(codigoalumno) REFERENCES ALUMNO,
    CONSTRAINT mat_codigoas_asi_fk FOREIGN KEY(codigoasignatura) REFERENCES ASIGNATURA
);

ALTER TABLE ASIGNATURA MODIFY(creditos CONSTRAINT asi_cre_ch CHECK(creditos < 100 AND creditos > 0));

ALTER TABLE ASIGNATURA MODIFY(tipo CONSTRAINT asi_tip_ch CHECK(tipo IN('OBLIGATORIA', 'OPTATIVA', 'LIBRE')));