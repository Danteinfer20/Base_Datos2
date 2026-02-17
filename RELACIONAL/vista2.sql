-- Table: public.asignacion_instructores

-- DROP TABLE IF EXISTS public.asignacion_instructores;

CREATE TABLE IF NOT EXISTS public.asignacion_instructores
(
    documento_instructor character varying(20) COLLATE pg_catalog."default" NOT NULL,
    codigo_competencia character varying(20) COLLATE pg_catalog."default" NOT NULL,
    fecha_asignacion date DEFAULT CURRENT_DATE,
    CONSTRAINT pk_asignacion PRIMARY KEY (documento_instructor, codigo_competencia),
    CONSTRAINT fk_asig_comp FOREIGN KEY (codigo_competencia)
        REFERENCES public.competencias (codigo_competencia) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE,
    CONSTRAINT fk_asig_inst FOREIGN KEY (documento_instructor)
        REFERENCES public.instructores (documento_instructor) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE CASCADE
)

TABLESPACE pg_default;

ALTER TABLE IF EXISTS public.asignacion_instructores
    OWNER to postgres;