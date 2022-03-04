--Crea el SP para la consulta del detalle de la materia

ALTER PROCEDURE sp_cea_gener_mat @licve_plan tinyint, @licve_carrera int, @licve_mat INT 
AS
BEGIN
DECLARE @lsnivel nvarchar(1)
/*
    *Autor: Salvador Gaytan Herrera
    *Fecha: 14/NOV/2005
    *Descripción: Regresa los detalles de la materia
    *
    *Parametros:   
    *           @licve_plan = plan a consultar
    *           @licve_carrera = carrera a consultar
    *           @licve_mat = clave de la materia
*/
--Obtiene el nivel de la carrera 
SELECT @lsnivel = nivel FROM v_www_carreras WHERE cve_carrera = @licve_carrera
/*IF (@lsnivel = 'L')*/
IF (@lsnivel <> 'P')
BEGIN
		SELECT 	
			m.cve_mat,
			m.evaluacion,
			m.horas_reales,
			cursativa =
			CASE ISNULL(ppm.cursativa,0)
				WHEN 0 THEN 'NO'
				WHEN 1 THEN 'SI'
			END,
			ISNULL(CONVERT(varchar, ppm.semestre_ideal),'--' ) semestre_ideal
		FROM v_www_materias_1 m,
             v_www_mat_prerrequisito ppm
		WHERE	m.cve_mat = ppm.cve_mat
		AND	ppm.cve_carrera = @licve_carrera
		AND	ppm.cve_plan = @licve_plan
		AND	ppm.cve_mat = @licve_mat
END
ELSE
BEGIN
		SELECT 	
			m.cve_mat,
			m.evaluacion,
			m.horas_reales,
			cursativa =
			CASE ISNULL(ppm.cursativa,0)
				WHEN 0 THEN 'NO'
				WHEN 1 THEN 'SI'
			END,
			ISNULL(CONVERT(varchar, ppm.semestre_ideal),'--' ) semestre_ideal
		FROM v_www_materias_1 m,
             v_www_mat_prerreq_pos ppm
		WHERE	m.cve_mat = ppm.cve_mat
		AND	ppm.cve_carrera = @licve_carrera
		AND	ppm.cve_plan = @licve_plan
		AND	ppm.cve_mat = @licve_mat
END
END

GO

