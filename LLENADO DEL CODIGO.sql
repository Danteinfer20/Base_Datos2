-- 1. Insertar Modalidades
INSERT INTO modalidades (nombre_modalidad) VALUES ('Presencial'), ('Virtual'), ('A Distancia');

-- 2. Insertar Programas (Relacionados con el ID de modalidad)
-- Supongamos: 1 es Presencial, 2 es Virtual
INSERT INTO programas (codigo_programa, nombre_programa, id_modalidad) 
VALUES ('228106', 'Análisis y Desarrollo de Software', 1),
       ('228107', 'Animación Digital', 2);

-- 3. Insertar Instructores
INSERT INTO instructores (documento_instructor, primer_nombre, primer_apellido, correo_electronico)
VALUES ('1061001', 'Carlos', 'Pérez', 'cperez@sena.edu.co'),
       ('1061002', 'Marta', 'Sánchez', 'msanchez@sena.edu.co');

-- 4. Insertar Competencias (Relacionadas con un programa)
INSERT INTO competencias (codigo_competencia, descripcion_competencia, codigo_programa)
VALUES ('COMP-001', 'Diseñar la estructura de datos', '228106'),
       ('COMP-002', 'Desarrollar la interfaz gráfica', '228106');

-- 5. Insertar Aprendices (Relacionados con un programa)
INSERT INTO aprendices (documento_aprendiz, primer_nombre, primer_apellido, fecha_nacimiento, codigo_programa)
VALUES ('555001', 'Juan', 'Gómez', '2005-05-15', '228106'),
       ('555002', 'Lucía', 'Ramos', '2004-10-20', '228107');

-- 6. Asignar Instructores a Competencias (Tabla asociativa)
INSERT INTO asignacion_instructores (documento_instructor, codigo_competencia)
VALUES ('1061001', 'COMP-001'),
       ('1061001', 'COMP-002');