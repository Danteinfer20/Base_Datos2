select * from programas

where  id_modalidad = 1 and tipo_programa = 'Tecnólogo';


select * from aprendices
where apellido  like '%az';

select * from centros 
where ubicacion = 'Popayán - Norte' or nombre_centro like '%gropecuario%';

select * from fichas
where fecha_inicio = '2026-01-15' or  codigo_programa = 'ADSO-01';
