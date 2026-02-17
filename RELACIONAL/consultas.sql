-- primera consulta
select * from aprendices
where nombre like 'J%';
--- segunda consulta
SELECT * FROM fichas 
WHERE codigo_programa = 'ADSO-01' 
AND fecha_inicio >= '2026-01-01';
--- tercera consulta
SELECT * FROM programas 
WHERE nombre_programa LIKE '%Software%' 
OR nombre_programa LIKE '%Sistemas%';
--- cuarta consulta
SELECT * FROM aprendices 
WHERE (apellido = 'García' AND fecha_nacimiento > '2000-01-01')
OR nombre = 'Paola';