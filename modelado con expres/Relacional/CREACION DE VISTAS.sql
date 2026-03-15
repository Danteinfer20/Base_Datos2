-----------------------------------------------------
------------  Sancionados Activos   -----------------
-----------------------------------------------------

CREATE OR REPLACE VIEW vista_aprendices_sancionados AS
SELECT 
    documento_aprendiz,
    nombre || ' ' || apellido AS aprendiz,
    fecha_bloqueo_hasta,
    motivo_bloqueo,
    (fecha_bloqueo_hasta - CURRENT_DATE) AS dias_restantes
FROM aprendices
WHERE fecha_bloqueo_hasta > CURRENT_DATE;



--------------------------------------------------
------------ Ocupación por Ficha -----------------
--------------------------------------------------



CREATE OR REPLACE VIEW vista_control_fichas AS
SELECT 
    f.numero_ficha,
    p.nombre_programa,
    COUNT(DISTINCT m.documento_aprendiz) AS total_aprendices,
    COUNT(DISTINCT ai.documento_instructor) AS total_instructores
FROM fichas f
JOIN programas p ON f.codigo_programa = p.codigo_programa
LEFT JOIN matriculas m ON f.numero_ficha = m.numero_ficha
LEFT JOIN asignacion_instructores ai ON f.numero_ficha = ai.numero_ficha
GROUP BY f.numero_ficha, p.nombre_programa;


----------------------------------------------
----- Especialidad de Instructores -----------
-----------------------------------------------


CREATE OR REPLACE VIEW vista_instructores_competencias AS
SELECT 
    i.primer_nombre || ' ' || i.primer_apellido AS instructor,
    i.especialidad,
    c.descripcion_competencia,
    c.tipo_competencia,
    f.numero_ficha
FROM instructores i
JOIN asignacion_instructores ai ON i.documento_instructor = ai.documento_instructor
JOIN competencias c ON ai.codigo_competencia = c.codigo_competencia
JOIN fichas f ON ai.numero_ficha = f.numero_ficha;



---------------------------------------------------
--------- Cumplimiento Académico -----------------
--------------------------------------------------


CREATE OR REPLACE VIEW vista_validacion_niveles AS
SELECT 
    a.nombre,
    a.grado_escolar,
    p.nombre_programa,
    p.tipo_programa,
    CASE 
        WHEN p.tipo_programa = 'Tecnólogo' AND a.grado_escolar < 11 THEN 'Revisar: No es Bachiller'
        WHEN p.tipo_programa = 'Técnico' AND a.grado_escolar < 9 THEN 'Revisar: Grado insuficiente'
        ELSE 'Correcto'
    END AS validacion_sena
FROM aprendices a
JOIN matriculas m ON a.documento_aprendiz = m.documento_aprendiz
JOIN fichas f ON m.numero_ficha = f.numero_ficha
JOIN programas p ON f.codigo_programa = p.codigo_programa;



------------------------------------
---  EJEMPLO PRACTICO --------------
------------------------------------
CREATE OR REPLACE VIEW vista_tecnologos AS
SELECT 
    a.nombre || ' ' || a.apellido AS aprendiz,
    p.nombre_programa
FROM aprendices a
INNER JOIN matriculas m ON a.documento_aprendiz = m.documento_aprendiz
-- ... (aquí faltan los otros joins para llegar a programas)
WHERE p.tipo_programa = 'Tecnólogo';0








------------------------------
-- SOLUCION-------------
-----------------------

INNER JOIN fichas f ON m.numero_ficha = f.numero_ficha         
INNER JOIN programas p ON f.codigo_programa = p.codigo_programa