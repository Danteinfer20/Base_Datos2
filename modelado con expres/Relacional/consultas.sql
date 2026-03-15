SELECT 
    i.primer_nombre, 
    c.descripcion_competencia
FROM instructores i
INNER JOIN asignacion_instructores ai ON i.documento_instructor = ai.documento_instructor
INNER JOIN competencias c ON ai.codigo_competencia = c.codigo_competencia;


select * from programas where nombre_programa LIKE '%Sofware%';
SELECT * FROM programas WHERE nombre_programa LIKE '%Software%';

select *from aprendices where  grado_escolar = 9;

select * from aprendices where  grado_escolar between (9) and (11);

select * from aprendices where nombre like '%n';