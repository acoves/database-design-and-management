CONNECT system/bdadmin;

CREATE USER PARTE2 IDENTIFIED BY EXAMEN;
GRANT CONNECT, RESOURCE TO PARTE2;

CONNECT PARTE2/EXAMEN;

CREATE TABLE A(
    a1          VARCHAR2(10)        CONSTRAINT a_a1_pk PRIMARY KEY,
    a2          VARCHAR2(10),
    a3          DATE,
    a4          VARCHAR2(10)        CONSTRAINT a_a4_nn NOT NULL,
    CONSTRAINT a_a4_uq UNIQUE(a4)
);

CREATE TABLE D(
    d1          VARCHAR2(10),
    d2          VARCHAR2(10),
    d3          VARCHAR2(10)    DEFAULT 'S',
    d4          VARCHAR2(10),
    CONSTRAINT d_d1_d2_pk PRIMARY KEY(d1,d2)
);

CREATE TABLE B(
    b1          VARCHAR2(10)    CONSTRAINT b_b1_pk PRIMARY KEY,
    b2          VARCHAR2(10)    CONSTRAINT b_b2_a_fk REFERENCES A,
    b3          VARCHAR2(10)
);

CREATE TABLE C(
    c1          VARCHAR2(10)    CONSTRAINT c_c1_b_fk REFERENCES B,
    c2          VARCHAR2(10),
    c3          VARCHAR2(10),
    c4          NUMBER(2),
    CONSTRAINT c_c1_c2_c3_pk PRIMARY KEY(c1,c2,c3),
    CONSTRAINT c_c2_c3_d_fk FOREIGN KEY(c2, c3) REFERENCES D
);

ALTER TABLE C MODIFY(c4     CONSTRAINT c_c4_nn NOT NULL CONSTRAINT c_c4_ch CHECK(c4>=20 AND c4<=50));

SELECT table_name FROM user_tables;

DESC A;
DESC B;
DESC C;
DESC D;

SELECT constraint_name, constraint_type, table_name FROM user_constraints ORDER BY constraint_name;