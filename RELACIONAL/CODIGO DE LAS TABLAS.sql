

-- 1. TABLAS MAESTRAS (Nivel 1)


CREATE TABLE centros (
    id_centro SERIAL,
    codigo_centro VARCHAR(20) NOT NULL,
    nombre_centro VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(100),
    CONSTRAINT pk_centro PRIMARY KEY (id_centro),
    CONSTRAINT uk_codigo_centro UNIQUE (codigo_centro)
);

CREATE TABLE modalidades (
    id_modalidad SERIAL,
    nombre_modalidad VARCHAR(50) NOT NULL,
    CONSTRAINT pk_modalidad PRIMARY KEY (id_modalidad),
    CONSTRAINT uk_nombre_modalidad UNIQUE (nombre_modalidad)
);

CREATE TABLE instructores (
    documento_instructor VARCHAR(20),
    primer_nombre VARCHAR(50) NOT NULL,
    primer_apellido VARCHAR(50) NOT NULL,
    correo_electronico VARCHAR(100) NOT NULL,
    CONSTRAINT pk_instructor PRIMARY KEY (documento_instructor),
    CONSTRAINT uk_correo_instructor UNIQUE (correo_electronico)
);

-- ==========================================
-- 3. TABLAS DEPENDIENTES (Nivel 2)
-- ==========================================

CREATE TABLE programas (
    codigo_programa VARCHAR(20),
    nombre_programa VARCHAR(100) NOT NULL,
    id_modalidad INT NOT NULL,
    id_centro INT NOT NULL, 
    tipo_programa VARCHAR(30) CHECK (tipo_programa IN ('Técnico', 'Tecnólogo', 'Complementario')),
    CONSTRAINT pk_programa PRIMARY KEY (codigo_programa),
    CONSTRAINT fk_prog_modalidad FOREIGN KEY (id_modalidad) REFERENCES modalidades(id_modalidad),
    CONSTRAINT fk_prog_centro FOREIGN KEY (id_centro) REFERENCES centros(id_centro)
);

CREATE TABLE fichas (
    numero_ficha VARCHAR(20),
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    codigo_programa VARCHAR(20) NOT NULL,
    CONSTRAINT pk_ficha PRIMARY KEY (numero_ficha),
    CONSTRAINT fk_ficha_programa FOREIGN KEY (codigo_programa) REFERENCES programas(codigo_programa) ON DELETE CASCADE
);

CREATE TABLE competencias (
    codigo_competencia VARCHAR(20),
    descripcion_competencia TEXT NOT NULL,
    codigo_programa VARCHAR(20) NOT NULL,
    CONSTRAINT pk_competencia PRIMARY KEY (codigo_competencia),
    CONSTRAINT fk_comp_programa FOREIGN KEY (codigo_programa) REFERENCES programas(codigo_programa) ON DELETE CASCADE
);

-- ==========================================
-- 4. GESTIÓN DE PERSONAS Y MATRÍCULAS (Nivel 3)
-- ==========================================

CREATE TABLE aprendices (
    documento_aprendiz VARCHAR(20),
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    fecha_nacimiento DATE NOT NULL,
    CONSTRAINT pk_aprendiz PRIMARY KEY (documento_aprendiz)
);

CREATE TABLE matriculas (
    id_matricula SERIAL,
    documento_aprendiz VARCHAR(20),
    numero_ficha VARCHAR(20),
    fecha_matricula DATE DEFAULT CURRENT_DATE,
    estado VARCHAR(20) DEFAULT 'En formación',
    CONSTRAINT pk_matricula PRIMARY KEY (id_matricula),
    CONSTRAINT fk_mat_aprendiz FOREIGN KEY (documento_aprendiz) REFERENCES aprendices(documento_aprendiz) ON DELETE CASCADE,
    CONSTRAINT fk_mat_ficha FOREIGN KEY (numero_ficha) REFERENCES fichas(numero_ficha) ON DELETE CASCADE
);

CREATE TABLE asignacion_instructores (
    documento_instructor VARCHAR(20),
    codigo_competencia VARCHAR(20),
    fecha_asignacion DATE DEFAULT CURRENT_DATE,
    CONSTRAINT pk_asignacion PRIMARY KEY (documento_instructor, codigo_competencia),
    CONSTRAINT fk_asig_inst FOREIGN KEY (documento_instructor) REFERENCES instructores(documento_instructor) ON DELETE CASCADE,
    CONSTRAINT fk_asig_comp FOREIGN KEY (codigo_competencia) REFERENCES competencias(codigo_competencia) ON DELETE CASCADE
);