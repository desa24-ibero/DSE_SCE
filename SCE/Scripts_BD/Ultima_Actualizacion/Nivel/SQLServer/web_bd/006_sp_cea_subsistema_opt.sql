--SP que Consulta los subsistemas

ALTER PROCEDURE sp_cea_subsistema_opt @licve_plan tinyint, @licve_carrera int, @liarea_sub int
AS
BEGIN
DECLARE @lsnivel nvarchar(1)
/*
    *Autor: Salvador Gaytan Herrera
    *Fecha: 14/NOV/2005
    *Descripción: Regresa las materias de subsistema
    *
    *Parametros:   
    *           @licve_plan = plan a consultar
    *           @licve_carrera = carrera a consultar
    *           @liarea_sub = clave del subsistema a consultar
*/
--Obtiene el nivel de la carrera 
SELECT @lsnivel = nivel FROM v_www_carreras WHERE cve_carrera = @licve_carrera
/*IF (@lsnivel = 'L')*/
IF (@lsnivel <> 'P') 
BEGIN
		SELECT   	v_www_mat_prerrequisito.cve_mat,
				 	v_www_mat_prerrequisito.cve_carrera,
					v_www_mat_prerrequisito.cve_plan,
					v_www_area_mat.cve_area,
					v_www_materias_1.materia,
                	sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END,
					v_www_materias_1.creditos
		FROM        v_www_mat_prerrequisito 
		INNER JOIN  v_www_area_mat 
                ON  v_www_mat_prerrequisito.cve_mat = v_www_area_mat.cve_mat 
        INNER JOIN  v_www_materias_1 
                ON  v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
                AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
                AND (v_www_area_mat.cve_area = @liarea_sub)
END
ELSE
BEGIN
        SELECT     v_www_area_mat.cve_area, 
                   v_www_materias_1.materia,
                	sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_materias_1.creditos
        FROM       v_www_mat_prerreq_pos 
        INNER JOIN v_www_materias_1 
                ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat 
        INNER JOIN v_www_area_mat 
                ON v_www_mat_prerreq_pos.cve_mat = v_www_area_mat.cve_mat
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
                AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
                AND (v_www_area_mat.cve_area = @liarea_sub)



END
END

GO

