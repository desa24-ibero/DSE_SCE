USE [web_bd]
GO

-- SP que muestra las materias de integración

ALTER PROCEDURE "dbo"."sp_cea_area_integra" @licve_plan tinyint, @licve_carrera int,@litema tinyint
AS
BEGIN
DECLARE @lsnivel nvarchar(1)
/*
    *Autor: Salvador Gaytan Herrera
    *Fecha: 17/NOV/2005
    *Descripción: Regresa materias de tegración
    *
    *Parametros:   
    *           @licve_plan = plan a consultar
    *           @licve_carrera = carrera a consultar
    *           @litema = Tema a consultar
*/
--Obtiene el nivel de la carrera 
SELECT @lsnivel = nivel FROM v_www_carreras WHERE cve_carrera = @licve_carrera
/*IF (@lsnivel = 'L')*/
IF (@lsnivel <> 'P') 
BEGIN
--Plan ideal nivel licenciatura
        IF (@litema = 1)     --   Materias de integración tema 1
            BEGIN
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
                ORDER BY materia    
             END

        IF (@litema = 2)     --   Materias de integración tema 2
            BEGIN
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
                ORDER BY materia    
             END
        IF (@litema = 3)     --   Materias de integración tema 3
            BEGIN
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

                    AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema3
                WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
                    AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
                    AND (v_www_mat_prerrequisito.semestre_ideal = 0)
                ORDER BY materia    
             END

        IF (@litema = 4)     --   Materias de integración tema 4
            BEGIN
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

                    AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema4
                WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
                    AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
                    AND (v_www_mat_prerrequisito.semestre_ideal = 0)
                ORDER BY materia    
             END


END
ELSE
BEGIN
--Plan ideal nivel posgrado
        IF (@litema = 1)     --   Materias de integración tema 1
            BEGIN
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
                ORDER BY materia
            END
        IF (@litema = 2)     --   Materias de integración tema 2
            BEGIN
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
                ORDER BY materia
            END
        IF (@litema = 3)     --   Materias de integración tema 3
            BEGIN
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

                    AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema3
                WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
                    AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
                    AND (v_www_mat_prerreq_pos.semestre_ideal = 0)
                ORDER BY materia
            END

        IF (@litema = 4)     --   Materias de integración tema 4
            BEGIN
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

                    AND  v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_integ_tema4
                WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
                    AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
                    AND (v_www_mat_prerreq_pos.semestre_ideal = 0)
                ORDER BY materia
            END

END

END

GO

