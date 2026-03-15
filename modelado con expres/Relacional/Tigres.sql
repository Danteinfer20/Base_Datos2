-- Primero creamos la función (La lógica)
CREATE OR REPLACE FUNCTION fn_gestionar_sanciones_sena()
RETURNS TRIGGER AS $$
BEGIN
    -- Si el estado cambia a Retiro Voluntario: 6 meses de sanción
    IF NEW.estado = 'Retiro voluntario' THEN
        UPDATE aprendices 
        SET fecha_bloqueo_hasta = CURRENT_DATE + INTERVAL '6 months',
            motivo_bloqueo = 'Sanción por Retiro Voluntario'
        WHERE documento_aprendiz = NEW.documento_aprendiz;
        
    -- Si el estado cambia a Deserción: 2 años de sanción
    ELSIF NEW.estado = 'Deserción' THEN
        UPDATE aprendices 
        SET fecha_bloqueo_hasta = CURRENT_DATE + INTERVAL '2 years',
            motivo_bloqueo = 'Sanción por Deserción'
        WHERE documento_aprendiz = NEW.documento_aprendiz;
        
    -- Si el estado es cualquier otro, quitamos bloqueos (opcional)
    ELSE
        UPDATE aprendices 
        SET fecha_bloqueo_hasta = NULL, motivo_bloqueo = NULL
        WHERE documento_aprendiz = NEW.documento_aprendiz;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Ahora creamos el Trigger (El que vigila la tabla)
CREATE TRIGGER trg_sanciones_automaticas
AFTER UPDATE OF estado ON matriculas
FOR EACH ROW
EXECUTE FUNCTION fn_gestionar_sanciones_sena();



---------------------------------------------------------------------
----- Trigger de Validación de Requisitos  --------------------------                                   ------------------------
---------------------------------------------------------------------

CREATE OR REPLACE FUNCTION fn_validar_requisitos_ingreso()
RETURNS TRIGGER AS $$
DECLARE
    v_grado_aprendiz INT;
    v_fecha_sancion DATE;
    v_tipo_prog VARCHAR;
BEGIN
    -- 1. Obtener datos del aprendiz
    SELECT grado_escolar, fecha_bloqueo_hasta 
    INTO v_grado_aprendiz, v_fecha_sancion
    FROM aprendices WHERE documento_aprendiz = NEW.documento_aprendiz;

    -- 2. Obtener el tipo de programa de la ficha
    SELECT p.tipo_programa INTO v_tipo_prog
    FROM fichas f
    JOIN programas p ON f.codigo_programa = p.codigo_programa
    WHERE f.numero_ficha = NEW.numero_ficha;

    -- VALIDACIÓN A: ¿Está sancionado?
    IF v_fecha_sancion IS NOT NULL AND v_fecha_sancion > CURRENT_DATE THEN
        RAISE EXCEPTION 'BLOQUEO SOFIA+: El aprendiz tiene una sanción activa hasta %', v_fecha_sancion;
    END IF;

    -- VALIDACIÓN B: ¿Cumple el grado escolar?
    IF v_tipo_prog = 'Tecnólogo' AND v_grado_aprendiz < 11 THEN
        RAISE EXCEPTION 'REQUISITO NO CUMPLIDO: Para Tecnólogo debe ser bachiller (Grado 11)';
    END IF;

    IF v_tipo_prog = 'Técnico' AND v_grado_aprendiz < 9 THEN
        RAISE EXCEPTION 'REQUISITO NO CUMPLIDO: Para Técnico requiere mínimo Grado 9';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trg_validar_antes_de_matricular
BEFORE INSERT ON matriculas
FOR EACH ROW
EXECUTE FUNCTION fn_validar_requisitos_ingreso();

