CONNECT system/bdadmin;

CREATE USER puntuable2 IDENTIFIED BY examen;
GRANT CONNECT, RESOURCE TO puntuable2;

CONNECT puntuable2/examen;

CREATE TABLE B(
    b1      VARCHAR2(10),
    b2      DATE,
    b3      VARCHAR2(10),
    CONSTRAINT b_b1_b2_pk PRIMARY KEY(b1,b2)
);

CREATE TABLE C(
    c1      VARCHAR2(10)    CONSTRAINT c_c1_pk PRIMARY KEY,
    c2      VARCHAR2(1)     DEFAULT 'N' CONSTRAINT c_c2_nn NOT NULL,
    c3      VARCHAR2(10),
    c4      VARCHAR2(10)
);

CREATE TABLE D(
    d1      VARCHAR2(10)    CONSTRAINT d_d1_pk PRIMARY KEY,
    d2      VARCHAR2(10),
    d3      DATE,
    CONSTRAINT d_d2_d3_b_fk FOREIGN KEY(d2, d3) REFERENCES B
);

CREATE TABLE A(
    a1      VARCHAR2(10),
    a2      VARCHAR2(10)    CONSTRAINT a_a2_nn NOT NULL,
    a3      VARCHAR2(10)    CONSTRAINT a_a3_nn NOT NULL,
    CONSTRAINT a_a3_a1_pk PRIMARY KEY(a3, a1),
    CONSTRAINT a_a2_a3_uq UNIQUE(a2, a3),
    CONSTRAINT a_a1_d_fk FOREIGN KEY(a1) REFERENCES D ON DELETE CASCADE,
    CONSTRAINT a_a2_d_fk FOREIGN KEY(a2) REFERENCES D ON DELETE CASCADE,
    CONSTRAINT a_a3_c_fk FOREIGN KEY(a3) REFERENCES C
);