-- ==========================================
-- 1. TABLAS MAESTRAS (Sin llaves foráneas)
-- ==========================================

CREATE TABLE modalidades (
    id_modalidad SERIAL,
    nombre_modalidad VARCHAR(50) NOT NULL,
    CONSTRAINT pk_modalidad PRIMARY KEY (id_modalidad),
    CONSTRAINT uk_nombre_modalidad UNIQUE (nombre_modalidad)
);

CREATE TABLE instructores (
    documento_instructor VARCHAR(20),
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    correo_electronico VARCHAR(100) NOT NULL,
    CONSTRAINT pk_instructor PRIMARY KEY (documento_instructor),
    CONSTRAINT uk_correo_instructor UNIQUE (correo_electronico)
);

-- ==========================================
-- 2. TABLAS DEPENDIENTES (Con llaves foráneas)
-- ==========================================

CREATE TABLE programas (
    codigo_programa VARCHAR(20),
    nombre_programa VARCHAR(100) NOT NULL,
    id_modalidad INT NOT NULL,
    CONSTRAINT pk_programa PRIMARY KEY (codigo_programa),
    CONSTRAINT fk_programa_modalidad FOREIGN KEY (id_modalidad) 
        REFERENCES modalidades(id_modalidad)
);

CREATE TABLE competencias (
    codigo_competencia VARCHAR(20),
    descripcion_competencia TEXT NOT NULL,
    codigo_programa VARCHAR(20) NOT NULL,
    CONSTRAINT pk_competencia PRIMARY KEY (codigo_competencia),
    CONSTRAINT fk_competencia_programa FOREIGN KEY (codigo_programa) 
        REFERENCES programas(codigo_programa)
);

CREATE TABLE aprendices (
    documento_aprendiz VARCHAR(20),
    primer_nombre VARCHAR(50) NOT NULL,
    segundo_nombre VARCHAR(50),
    primer_apellido VARCHAR(50) NOT NULL,
    segundo_apellido VARCHAR(50),
    fecha_nacimiento DATE NOT NULL,
    codigo_programa VARCHAR(20) NOT NULL,
    CONSTRAINT pk_aprendiz PRIMARY KEY (documento_aprendiz),
    CONSTRAINT fk_aprendiz_programa FOREIGN KEY (codigo_programa) 
        REFERENCES programas(codigo_programa)
);

-- ==========================================
-- 3. TABLA ASOCIATIVA (Muchos a Muchos)
-- ==========================================

CREATE TABLE asignacion_instructores (
    documento_instructor VARCHAR(20),
    codigo_competencia VARCHAR(20),
    fecha_asignacion DATE DEFAULT CURRENT_DATE,
    CONSTRAINT pk_asignacion PRIMARY KEY (documento_instructor, codigo_competencia),
    CONSTRAINT fk_asignacion_inst FOREIGN KEY (documento_instructor) 
        REFERENCES instructores(documento_instructor),
    CONSTRAINT fk_asignacion_comp FOREIGN KEY (codigo_competencia) 
        REFERENCES competencias(codigo_competencia)
);