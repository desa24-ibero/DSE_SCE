--CP que consulta de materias de reflexión

ALTER PROCEDURE sp_cea_area_reflex @licve_plan tinyint, @licve_carrera int
AS
BEGIN
DECLARE @lsnivel nvarchar(1)
/*
    *Autor: Salvador Gaytan Herrera
    *Fecha: 14/NOV/2005
    *Descripción: Consulta materias de reflexión universitaria
    *
    *Parametros:   
    *           @licve_plan = plan a consultar
    *           @licve_carrera = carrera a consultar
*/
--Obtiene el nivel de la carrera 
SELECT @lsnivel = nivel FROM v_www_carreras WHERE cve_carrera = @licve_carrera


/*IF (@lsnivel = 'L')*/
IF (@lsnivel <> 'P') 
BEGIN
--Plan ideal nivel licenciatura
             --   Area de reflexion universitaria Licenciatura 2
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerrequisito 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan 

            AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_fundamental
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal = 0)
        UNION     --   Area de reflexion universitaria Licenciatura 3
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerrequisito 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan 

            AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema1
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal = 0)

        UNION     --   Area de reflexion universitaria Licenciatura 4
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerrequisito 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan 

            AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema2
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal = 0)

        UNION     --   Area de reflexion universitaria Licenciatura 5
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerrequisito 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan 

            AND   v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema3
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal = 0)
        UNION     --   Area de reflexion universitaria Licenciatura 6
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa, 
                   v_www_materias_1.creditos
        FROM         v_www_mat_prerrequisito 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan 
            AND   v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema4
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal = 0)
        ORDER BY materia    
END
ELSE
BEGIN
--Plan ideal nivel posgrado
           --   Area de reflexion universitaria Posgrado 2
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerreq_pos 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan 

            AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_fundamental
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal = 0)
        UNION     --   Area de reflexion universitaria Posgrado 3
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerreq_pos 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan 

            AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema1
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal = 0)

        UNION     --   Area de reflexion universitaria Posgrado 4
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerreq_pos 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan 

   AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema2
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal = 0)

        UNION     --   Area de reflexion universitaria Posgrado 5
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerreq_pos 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan 

            AND   v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema3
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal = 0)
        UNION     --   Area de reflexion universitaria Posgrado 6
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
	                END	,
                   4 AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa, 
                   v_www_materias_1.creditos
        FROM         v_www_mat_prerreq_pos 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan 
            AND   v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema4
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal = 0)
        ORDER BY materia
END

END

GO

