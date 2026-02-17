SELECT 
    f.numero_ficha AS "Ficha",
    p.nombre_programa AS "Programa",
    a.nombre || ' ' || a.apellido AS "Aprendiz",
    c.nombre_centro AS "Centro de Formación"
FROM matriculas m
JOIN aprendices a ON m.documento_aprendiz = a.documento_aprendiz
JOIN fichas f ON m.numero_ficha = f.numero_ficha
JOIN programas p ON f.codigo_programa = p.codigo_programa
JOIN centros c ON p.id_centro = c.id_centro;