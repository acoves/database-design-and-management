-- Connect as administrator to create the user
CONNECT system/bdadmin;

-- Create the working user and assign basic roles
CREATE USER USUARIO1 IDENTIFIED BY USU1;
GRANT CONNECT, RESOURCE TO USUARIO1;

CONNECT USUARIO1/USU1;

-- ==================================
-- TABLE CREATION FOR PADEL DATABASE
-- ==================================
-- This section includes the definition of all required tables 
-- for the paddle club management system. Each table reflects
-- entities or relationships from the E-R diagram provided in 
-- the practice description, and includes:
--   • Appropriate data types
--   • Primary keys
--   • Foreign key constraints
--   • Additional integrity constraints where applicable
-- Tables are created in dependency-safe order (from independent to dependent entities).
-- =====================================================================================

CREATE TABLE ALUMNO(
    dni             VARCHAR2(10)    CONSTRAINT alu_dni_pk PRIMARY KEY,
    nombre          VARCHAR2(25),
    apellido1       VARCHAR2(25),
    telefono        VARCHAR2(30),
    fechanac        DATE,
    sexo            VARCHAR2(10)
);

CREATE TABLE MONITOR(
    dni             VARCHAR2(10)    CONSTRAINT mon_dni_pk PRIMARY KEY,
    nombre          VARCHAR2(25),
    apellido1       VARCHAR2(25),
    telefono        VARCHAR2(30)
);

CREATE TABLE NIVEL(
    numero          NUMBER(2)       CONSTRAINT niv_num_pk PRIMARY KEY,
    nombre          VARCHAR2(15),
    descripcion     VARCHAR2(50)
);

CREATE TABLE PISTA(
    codigo          VARCHAR2(10)    CONSTRAINT pis_cod_pk PRIMARY KEY,
    estado          VARCHAR2(20),
    observaciones   VARCHAR2(45)
);

CREATE TABLE TIENDA(
    cif             VARCHAR2(10)    CONSTRAINT tie_cif_pk PRIMARY KEY,
    nombre          VARCHAR2(50),
    telefono        VARCHAR2(30)
);

CREATE TABLE ASIGNAR(
    dnimonitor      VARCHAR2(10)    CONSTRAINT asi_dni_mon_fk REFERENCES MONITOR,
    ciftienda       VARCHAR2(10)    CONSTRAINT asi_cif_tie_fk REFERENCES TIENDA,
    descuento       NUMBER(4,2),
    CONSTRAINT asi_dni_cif_pk PRIMARY KEY(dnimonitor, ciftienda)
);

CREATE TABLE COMPRAR(
    dnialumno       VARCHAR2(10)    CONSTRAINT com_dnia_alu_fk REFERENCES ALUMNO,
    dnimonitor      VARCHAR2(10)    CONSTRAINT com_dnim_mon_fk REFERENCES MONITOR,
    ciftienda       VARCHAR2(10)    CONSTRAINT com_cif_tie_fk REFERENCES TIENDA,
    fecha           DATE,
    importeinicial  NUMBER(8,2),
    importefinal    NUMBER(8,2),
    CONSTRAINT com_dnia_dnim_cif_fec_pk PRIMARY KEY(dnialumno, dnimonitor, ciftienda, fecha)
);

CREATE TABLE CURSO(
    numnivel        NUMBER(2)   CONSTRAINT cur_numn_niv_fk REFERENCES NIVEL,
    numero          NUMBER(3),
    fechaini        DATE,
    horario         VARCHAR2(100),
    numhoras        NUMBER(3),
    precio          NUMBER(8,2),
    pista           VARCHAR2(10),
    dnimonitor      VARCHAR2(10) CONSTRAINT cur_dni_mon_fk REFERENCES MONITOR,
    CONSTRAINT cur_numn_nume_pk PRIMARY KEY(numnivel, numero)
);

CREATE TABLE MATRICULAR(
    dnialumno       VARCHAR2(10)    CONSTRAINT mat_dni_alu_fk REFERENCES ALUMNO,
    nivel           NUMBER(2),
    curso           NUMBER(3),
    diasasiste      NUMBER(3),
    CONSTRAINT mat_dni_niv_cur_pk PRIMARY KEY(dnialumno, nivel, curso),
    CONSTRAINT mat_niv_cur_cur_fk FOREIGN KEY(nivel, curso) REFERENCES CURSO
);


-- ===================================
-- QUERIES FOR PRACTICE VERIFICATION
-- ===================================

-- 2a. List the names of the created tables
-- This query returns the names of all user-defined tables in the current schema
SELECT table_name FROM user_tables;

-- 2b. List the defined constraints on the database
-- This query returns the name, type, and associated table of each constraint in the current schema
SELECT constraint_name, constraint_type, table_name FROM user_constraints;

-- 2c. Count how many primary keys exist
-- This query counts all constraints of type 'P' (Primary Key) in the current schema
SELECT COUNT(*) FROM user_constraints WHERE constraint_type ='P';

-- 2d. Count how many foreign keys exist
-- This query counts all constraints of type 'R' (Referential Integrity / Foreign Key) in the current schema
SELECT COUNT(*) FROM user_constraints WHERE constraint_type ='R';




-- ==========================================================================
-- Practice 2 – Modifying Table Structures and Constraints in Oracle SQL
-- DESCRIPTION:
-- This script contains ALTER TABLE statements to modify the
-- structure of the paddle club database by adding, modifying,
-- or removing constraints and columns in existing tables.
-- All changes follow the requirements specified in Practice 2.
-- ==========================================================================

-- Ensure that the 'codigo' column has a length of 10 characters
ALTER TABLE PISTA MODIFY(codigo VARCHAR2(10));

-- Add 'email' column to store student's email address (max 30 chars)
ALTER TABLE ALUMNO ADD(email VARCHAR2(30));
DESC ALUMNO;

-- Ensure 'sexo' column stores only 1 character
ALTER TABLE ALUMNO MODIFY(sexo VARCHAR2(1));

-- Add CHECK constraint to restrict 'sexo' to 'H' (male) or 'M' (female)
ALTER TABLE ALUMNO MODIFY(sexo CONSTRAINT alu_sex_ch CHECK(sexo IN('H','M')));
DESC ALUMNO;

-- Make 'telefono' column mandatory
ALTER TABLE MONITOR MODIFY(telefono CONSTRAINT mon_tel_nn NOT NULL);

-- Add a new column 'codigo' as an alternate unique identifier for each monitor
ALTER TABLE MONITOR ADD(codigo VARCHAR2(15) CONSTRAINT mon_cod_nn NOT NULL CONSTRAINT mon_cod_uq UNIQUE);

-- Add foreign key from 'pista' in CURSO to PISTA table
ALTER TABLE CURSO ADD(CONSTRAINT cur_pis_pis_fk FOREIGN KEY(pista) REFERENCES PISTA);

-- Make 'dnimonitor' a mandatory field (no course without a monitor)
ALTER TABLE CURSO MODIFY(dnimonitor CONSTRAINT cur_dni_nn NOT NULL);

-- Ensure 'descuento' has a default value of 0 and is never negative
ALTER TABLE ASIGNAR MODIFY(descuento DEFAULT 0 CONSTRAINT asi_des_ch CHECK(descuento >= 0));

-- Add CHECK constraint to ensure 'importeinicial' is less than 'importefinal'
ALTER TABLE COMPRAR ADD(CONSTRAINT com_imp_ch CHECK(importeinicial<= importefinal));

-- Remove incorrect foreign keys
ALTER TABLE COMPRAR DROP CONSTRAINT com_dnim_mon_fk;
ALTER TABLE COMPRAR DROP CONSTRAINT com_cif_tie_fk;

-- Add correct composite foreign key referencing ASIGNAR
ALTER TABLE COMPRAR ADD(CONSTRAINT com_dnim_cif_asi_fk FOREIGN KEY(dnimonitor, ciftienda) REFERENCES ASIGNAR);


-- ==============================
-- 12. CONSTRAINTS SUMMARY CHECK
-- ==============================

-- Query to verify number of constraints by type
SELECT
    CASE constraint_type
        WHEN 'P' THEN 'Clave_principal'
        WHEN 'R' THEN 'Clave_ajena'
        WHEN 'C' THEN 'Check+NotNull'
        WHEN 'U' THEN 'Unico'
    END AS tipo_restriccion,
COUNT(*) AS total
FROM user_constraints
GROUP BY constraint_type;