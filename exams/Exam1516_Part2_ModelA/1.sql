CONNECT system/bdadmin;

CREATE USER examen IDENTIFIED BY parte2;
GRANT CONNECT, RESOURCE TO examen;

CONNECT examen/parte2;

CREATE TABLE ALUMNO(
    numexpediente       NUMBER(5)       CONSTRAINT alu_num_pk PRIMARY KEY,
    nombre              VARCHAR2(20),
    apellido1           VARCHAR2(20),
    apellido2           VARCHAR2(20)
);

CREATE TABLE ASIGNATURA(
    codigo              VARCHAR2(20)    CONSTRAINT asi_cod_pk PRIMARY KEY,
    nombre              VARCHAR2(20),
    creditos            NUMBER(5),
    tipo                VARCHAR2(20)
);

CREATE TABLE MATRICULAR(
    codigoalumno        NUMBER(5),
    codigoasignatura    VARCHAR2(20),
    convocatoria        VARCHAR2(20),
    nota                NUMBER(5,2),
    CONSTRAINT mat_codigoal_codigoas_con_pk PRIMARY KEY(codigoalumno, codigoasignatura, convocatoria),
    CONSTRAINT mat_codigoal_alu_fk FOREIGN KEY(codigoalumno) REFERENCES ALUMNO,
    CONSTRAINT mat_codigoas_asi_fk FOREIGN KEY(codigoasignatura) REFERENCES ASIGNATURA
);

ALTER TABLE ASIGNATURA MODIFY(tipo CONSTRAINT asi_tip_ch CHECK(tipo IN('OBLIGATORIA','OPTATIVA','LIBRE')));