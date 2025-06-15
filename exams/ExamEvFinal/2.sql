SELECT
    CASE constraint_type
        WHEN 'P' THEN 'Clave_Primaria'
        WHEN 'R' THEN 'Clave_Ajena'
        WHEN 'C' THEN 'Check+NotNull'
        WHEN 'U' THEN 'Unica'
    END AS tipo_restriccion,
COUNT(*) AS total
FROM user_constraints
GROUP BY constraint_type;