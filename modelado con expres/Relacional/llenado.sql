-- 1. CENTROS (3 sedes principales del Cauca + 1 adicional)
INSERT INTO centros (codigo_centro, nombre_centro, ubicacion) VALUES 
('CTPI', 'C. de Teleinformática y Producción Industrial', 'Popayán - Norte'),
('CCS', 'C. de Comercio y Servicios', 'Popayán - Centro'),
('CTAS', 'C. Tecnológico de la Amazonía y el Sur', 'Santander de Quilichao'),
('S-AGRO', 'Centro Agropecuario', 'Popayán - El Vivero');

-- 2. MODALIDADES
INSERT INTO modalidades (nombre_modalidad) VALUES 
('Presencial'), ('Virtual'), ('Distancia'), ('Dual');

-- 3. INSTRUCTORES
INSERT INTO instructores (documento_instructor, primer_nombre, primer_apellido, correo_electronico, especialidad) VALUES 
('2020', 'Juan', 'Pablo', 'jpablo@sena.edu.co', 'Ingeniería de Sistemas'),
('3030', 'Maria', 'Angulo', 'mangulo@sena.edu.co', 'Licenciada en Idiomas'),
('4040', 'Ricardo', 'Daza', 'rdaza@sena.edu.co', 'Contabilidad y Finanzas'),
('5050', 'Elena', 'Torres', 'etorres@sena.edu.co', 'Mecánica Automotriz');

-- 4. PROGRAMAS (Diferentes tipos para probar los Triggers)
INSERT INTO programas (codigo_programa, nombre_programa, id_modalidad, id_centro, tipo_programa) VALUES 
('ADSO-01', 'Análisis y Desarrollo de Software', 1, 1, 'Tecnólogo'),
('MANT-02', 'Mantenimiento de Motores Diesel', 1, 1, 'Técnico'),
('CONT-03', 'Contabilidad y Finanzas', 1, 2, 'Tecnólogo'),
('EXCEL-05', 'Excel Avanzado', 1, 2, 'Complementario');

-- 5. COMPETENCIAS (Vinculadas a los programas)
INSERT INTO competencias (codigo_competencia, descripcion_competencia, codigo_programa, tipo_competencia) VALUES 
('SOFT-01', 'Diseño de bases de datos relacionales', 'ADSO-01', 'Técnica'),
('ENG-01', 'Comprensión de textos en inglés', 'ADSO-01', 'Bilingüismo'),
('CONT-01', 'Procesar la información contable', 'CONT-03', 'Técnica'),
('MEC-01', 'Reparar motores diesel', 'MANT-02', 'Técnica');

-- 6. FICHAS
INSERT INTO fichas (numero_ficha, fecha_inicio, fecha_fin, codigo_programa) VALUES 
('25001', '2026-01-20', '2028-01-20', 'ADSO-01'),
('26002', '2026-02-15', '2027-02-15', 'MANT-02'),
('25003', '2026-03-01', '2028-03-01', 'CONT-03'),
('20005', '2026-05-01', '2026-06-01', 'EXCEL-05');

-- 7. APRENDICES (Casos para testear Triggers)
INSERT INTO aprendices (documento_aprendiz, nombre, apellido, fecha_nacimiento, grado_escolar) VALUES 
('1001', 'Juan', 'Bachiller', '2000-01-01', 11), -- Apto para todo
('1002', 'Maura', 'Noveno', '2008-05-15', 9),     -- No apto para Tecnólogo
('1003', 'Luis', 'Basica', '2010-10-20', 5),      -- No apto para Técnico
('1005', 'Ana', 'Activa', '1998-12-12', 11);     -- Apta

-- 8. ASIGNACIÓN DE INSTRUCTORES
INSERT INTO asignacion_instructores (documento_instructor, codigo_competencia, numero_ficha) VALUES 
('2020', 'SOFT-01', '25001'),
('3030', 'ENG-01', '25001'),
('4040', 'CONT-01', '25003'),
('5050', 'MEC-01', '26002');

-- 9. MATRÍCULAS (Aquí es donde se dispara la lógica)
INSERT INTO matriculas (documento_aprendiz, numero_ficha, estado) VALUES 
('1001', '25001', 'En formación'),
('1005', '25003', 'En formación');