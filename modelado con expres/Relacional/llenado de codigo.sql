-- 1. Tablas Maestras
CREATE TABLE centros (
    id_centro SERIAL PRIMARY KEY,
    codigo_centro VARCHAR(20) NOT NULL UNIQUE,
    nombre_centro VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100)
);

CREATE TABLE modalidades (
    id_modalidad SERIAL PRIMARY KEY,
    nombre_modalidad VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE instructores (
    documento_instructor VARCHAR(20) PRIMARY KEY,
    primer_nombre VARCHAR(50) NOT NULL,
    primer_apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL UNIQUE,
    especialidad VARCHAR(50)
);

-- 2. Tablas de Formación (Aquí incluimos COMPETENCIAS)
CREATE TABLE programas (
    codigo_programa VARCHAR(20) PRIMARY KEY,
    nombre_programa VARCHAR(100) NOT NULL,
    id_modalidad INT NOT NULL REFERENCES modalidades(id_modalidad),
    id_centro INT NOT NULL REFERENCES centros(id_centro),
    tipo_programa VARCHAR(30) CHECK (tipo_programa IN ('Técnico', 'Tecnólogo', 'Complementario'))
);

CREATE TABLE competencias (
    codigo_competencia VARCHAR(20) PRIMARY KEY,
    descripcion_competencia TEXT NOT NULL,
    codigo_programa VARCHAR(20) NOT NULL REFERENCES programas(codigo_programa) ON DELETE CASCADE,
    tipo_competencia VARCHAR(30) CHECK (tipo_competencia IN ('Técnica', 'Transversal', 'Bilingüismo'))
);

CREATE TABLE fichas (
    numero_ficha VARCHAR(20) PRIMARY KEY,
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    codigo_programa VARCHAR(20) NOT NULL REFERENCES programas(codigo_programa) ON DELETE CASCADE
);

-- 3. Gestión de Personas
CREATE TABLE aprendices (
    documento_aprendiz VARCHAR(20) PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    grado_escolar INT DEFAULT 0,
    fecha_bloqueo_hasta DATE DEFAULT NULL,
    motivo_bloqueo VARCHAR(100) DEFAULT NULL,
    CONSTRAINT chk_edad_minima CHECK (fecha_nacimiento <= CURRENT_DATE - INTERVAL '14 years')
);

-- 4. Relaciones y Matrículas
CREATE TABLE matriculas (
    id_matricula SERIAL PRIMARY KEY,
    documento_aprendiz VARCHAR(20) NOT NULL REFERENCES aprendices(documento_aprendiz) ON DELETE CASCADE,
    numero_ficha VARCHAR(20) NOT NULL REFERENCES fichas(numero_ficha) ON DELETE CASCADE,
    fecha_matricula DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(30) DEFAULT 'En formación',
    CONSTRAINT chk_estado_matricula CHECK (estado IN ('En formación', 'Retiro voluntario', 'Deserción', 'Aplazado', 'Certificado'))
);

CREATE TABLE asignacion_instructores (
    documento_instructor VARCHAR(20) REFERENCES instructores(documento_instructor) ON DELETE CASCADE,
    codigo_competencia VARCHAR(20) REFERENCES competencias(codigo_competencia) ON DELETE CASCADE,
    numero_ficha VARCHAR(20) REFERENCES fichas(numero_ficha) ON DELETE CASCADE,
    fecha_asignacion DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (documento_instructor, codigo_competencia, numero_ficha)
);