-- 1. MODALIDADES
INSERT INTO modalidades (nombre_modalidad) VALUES 
('Presencial'), ('Virtual'), ('A Distancia'), ('Híbrida'), ('Especial');

-- 2. CENTROS
INSERT INTO centros (codigo_centro, nombre_centro, ubicacion) VALUES 
('9201', 'Centro de Comercio y Servicios', 'Popayán - Calle 4'),
('9202', 'Centro Agropecuario', 'Popayán - Alto Cauca'),
('9203', 'Centro de la Construcción', 'Popayán - Norte'),
('9204', 'Centro de Teleinformática', 'Popayán - Centro'),
('9501', 'Centro de Formación Regional', 'Santander de Quilichao');

-- 3. INSTRUCTORES
INSERT INTO instructores (documento_instructor, primer_nombre, primer_apellido, correo_electronico) VALUES 
('10610001', 'Carlos', 'Pérez', 'cperez@sena.edu.co'),
('10610002', 'Marta', 'Rodríguez', 'mrodriguez@sena.edu.co'),
('10610003', 'Luis', 'Gómez', 'lgomez@sena.edu.co'),
('10610004', 'Elena', 'Paz', 'epaz@sena.edu.co'),
('10610005', 'Andrés', 'Muñoz', 'amunoz@sena.edu.co');

-- 4. PROGRAMAS (Vinculados a Modalidad 1 y Centro 1 por defecto)
INSERT INTO programas (codigo_programa, nombre_programa, id_modalidad, id_centro, tipo_programa) VALUES 
('ADSO-01', 'Análisis y Desarrollo de Software', 1, 1, 'Tecnólogo'),
('CONT-02', 'Contabilidad y Finanzas', 1, 1, 'Tecnólogo'),
('SIST-03', 'Sistemas', 1, 4, 'Técnico'),
('INGL-04', 'Inglés Nivel 1', 2, 1, 'Complementario'),
('REDC-05', 'Redes de Computadores', 1, 4, 'Técnico');

-- 5. COMPETENCIAS
INSERT INTO competencias (codigo_competencia, descripcion_competencia, codigo_programa) VALUES 
('COMP-01', 'Diseñar bases de datos relacionales', 'ADSO-01'),
('COMP-02', 'Contabilizar operaciones financieras', 'CONT-02'),
('COMP-03', 'Mantenimiento de equipos de cómputo', 'SIST-03'),
('COMP-04', 'Comunicación básica en inglés', 'INGL-04'),
('COMP-05', 'Configuración de dispositivos de red', 'REDC-05');

-- 6. FICHAS (Vinculadas a sus respectivos programas)
INSERT INTO fichas (numero_ficha, fecha_inicio, fecha_fin, codigo_programa) VALUES 
('2879541', '2026-01-15', '2027-12-15', 'ADSO-01'),
('2879542', '2026-02-01', '2027-12-01', 'CONT-02'),
('2501003', '2026-03-01', '2026-09-01', 'SIST-03'),
('1000004', '2026-04-10', '2026-05-10', 'INGL-04'),
('2602005', '2026-02-15', '2026-11-15', 'REDC-05');

-- 7. APRENDICES
INSERT INTO aprendices (documento_aprendiz, nombre, apellido, fecha_nacimiento) VALUES 
('10620002', 'Julián', 'García', '2005-05-20'),
('10620003', 'Paola', 'Sánchez', '2004-11-12'),
('10620004', 'Kevin', 'López', '2006-01-30'),
('10620005', 'Valentina', 'Díaz', '2005-08-15'),
('10620006', 'Felipe', 'Torres', '2004-03-25');

-- 8. MATRICULAS (Relacionan Aprendiz con Ficha)
INSERT INTO matriculas (documento_aprendiz, numero_ficha) VALUES 
('10620002', '2879541'), -- Julián en ADSO
('10620003', '2879542'), -- Paola en Contabilidad
('10620004', '2501003'), -- Kevin en Sistemas
('10620005', '1000004'), -- Valentina en Inglés
('10620006', '2602005'); -- Felipe en Redes

-- 9. ASIGNACION_INSTRUCTORES (Relacionan Instructor con Competencia)
INSERT INTO asignacion_instructores (documento_instructor, codigo_competencia) VALUES 
('10610001', 'COMP-01'), -- Carlos en SQL
('10610002', 'COMP-02'), -- Marta en Contabilidad
('10610003', 'COMP-03'), -- Luis en Mantenimiento
('10610004', 'COMP-04'), -- Elena en Inglés
('10610005', 'COMP-05'); -- Andrés en Redes