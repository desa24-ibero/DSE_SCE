USE [web_bd]
GO

ALTER PROCEDURE sp_cea_Plan_ideal @licve_plan tinyint, @licve_carrera int 
AS
BEGIN
DECLARE @lsnivel nvarchar(1)
/*
    *Autor: Salvador Gaytan Herrera
    *Fecha: 10/NOV/2005
    *Descripción: Regresa el plan ideal
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
        --Area Basica Licenciatura
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia, 
              sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   1 AS cve_plan_area,
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
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_basica
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
      UNION     --   Area Mayor Licenciatura Obligatoria
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   2 AS cve_plan_area,
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
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_mayor_oblig
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
        UNION     --   Area Mayor Licenciatura (optativa)
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   2 AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
              1 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerrequisito 
            INNER JOIN v_www_materias_1 
            ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat 
            INNER JOIN v_www_area_mat 
            ON v_www_materias_1.cve_mat = v_www_area_mat.cve_mat 
            INNER JOIN v_www_plan_estudios 
            ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera 
            AND v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan 
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_mayor_opt
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
        UNION     --   Materias de opción terminal 1/2
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   8  AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM       v_www_mat_prerrequisito INNER JOIN
                   v_www_materias_1 ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat INNER JOIN
                   v_www_plan_estudios ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera AND 
                   v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan INNER JOIN
                   v_www_aux_opcion_terminal ON v_www_plan_estudios.cve_area_opcion_terminal = v_www_aux_opcion_terminal.cve_area AND 
                   v_www_materias_1.cve_mat = v_www_aux_opcion_terminal.cve_proyecto_opc_term
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
        UNION     --   Materias de opción terminal 2/2
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                    8  AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerrequisito INNER JOIN
                      v_www_materias_1 ON v_www_mat_prerrequisito.cve_mat = v_www_materias_1.cve_mat INNER JOIN
                      v_www_plan_estudios ON v_www_mat_prerrequisito.cve_carrera = v_www_plan_estudios.cve_carrera AND 
                      v_www_mat_prerrequisito.cve_plan = v_www_plan_estudios.cve_plan INNER JOIN
                      v_www_aux_opcion_terminal ON v_www_plan_estudios.cve_area_opcion_terminal = v_www_aux_opcion_terminal.cve_area AND 
                      v_www_materias_1.cve_mat = v_www_aux_opcion_terminal.cve_seminario_tit
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
 
        UNION     --   Area de Servicio Social
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   5 AS cve_plan_area,
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
 
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_servicio_social
        WHERE     (v_www_mat_prerrequisito.cve_plan = @licve_plan) 
            AND (v_www_mat_prerrequisito.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
        UNION     --   Area de reflexion universitaria Licenciatura 2
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
        UNION     --   Area de reflexion universitaria Licenciatura 3
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
 
        UNION     --   Area de reflexion universitaria Licenciatura 4
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
 
        UNION     --   Area de reflexion universitaria Licenciatura 5
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
        UNION     --   Area de reflexion universitaria Licenciatura 6
        SELECT     v_www_mat_prerrequisito.cve_carrera,
                   v_www_mat_prerrequisito.cve_plan,
                   v_www_mat_prerrequisito.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
        UNION     --   Area menor obligatoria
        SELECT     v_www_subsistema.cve_carrera,
                   v_www_subsistema.cve_plan,
                   v_www_area_mat.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   3 AS cve_plan_area,
                   v_www_mat_prerrequisito.semestre_ideal,
                   0 AS optativa,
                 v_www_materias_1.creditos
        FROM         v_www_subsistema 
                INNER JOIN v_www_area_mat 
                ON v_www_subsistema.cve_area = v_www_area_mat.cve_area 
                INNER JOIN v_www_mat_prerrequisito 
                ON v_www_area_mat.cve_mat = v_www_mat_prerrequisito.cve_mat 
                AND v_www_subsistema.cve_carrera = v_www_mat_prerrequisito.cve_carrera 
                AND v_www_subsistema.cve_plan = v_www_mat_prerrequisito.cve_plan 
                INNER JOIN v_www_materias_1 
                ON v_www_area_mat.cve_mat = v_www_materias_1.cve_mat
        WHERE     (v_www_subsistema.cve_carrera = @licve_carrera)
             AND (v_www_subsistema.cve_plan = @licve_plan) 
             AND (v_www_mat_prerrequisito.semestre_ideal <> 0)
            AND (v_www_subsistema.clase_area = 'OBL')
        UNION     --   Materias que no existen
        SELECT     controlescolar_bd.dbo.plantilla_plan_materia.cve_carrera,
                   controlescolar_bd.dbo.plantilla_plan_materia.cve_plan, 
                   controlescolar_bd.dbo.materias_optativas.cve_mat,
                   controlescolar_bd.dbo.materias_optativas.materia, 
                   controlescolar_bd.dbo.materias_optativas.sigla,
                   controlescolar_bd.dbo.plantilla_plan_materia.cve_plan_area,
                   controlescolar_bd.dbo.plantilla_plan_materia.semestre_ideal,
                   1 AS optativa, 
                   controlescolar_bd.dbo.materias_optativas.creditos
        FROM         controlescolar_bd.dbo.materias_optativas 
                INNER JOIN controlescolar_bd.dbo.plantilla_plan_materia 
                ON  controlescolar_bd.dbo.materias_optativas.cve_mat = controlescolar_bd.dbo.plantilla_plan_materia.cve_mat
        WHERE     (controlescolar_bd.dbo.plantilla_plan_materia.cve_carrera = @licve_carrera) 
                AND (controlescolar_bd.dbo.plantilla_plan_materia.cve_plan = @licve_plan)
                AND (controlescolar_bd.dbo.plantilla_plan_materia.semestre_ideal <> 0)
        ORDER BY semestre_ideal,materia    
END
ELSE
BEGIN
--Plan ideal nivel posgrado
        --Area Basica Posgrado
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia, 
              sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   1 AS cve_plan_area,
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
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_basica
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
      UNION     --   Area Mayor Posgrado
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   2 AS cve_plan_area,
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
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_mayor_oblig
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Area Mayor Posgrado (optativa)
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   2 AS cve_plan_area,
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
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_mayor_opt
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Materias de opción terminal 1/2
 
 
       SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                    8 AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerreq_pos INNER JOIN
                      v_www_materias_1 ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat INNER JOIN
                      v_www_plan_estudios ON v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera AND 
                      v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan INNER JOIN
                      v_www_aux_opcion_terminal ON v_www_plan_estudios.cve_area_opcion_terminal = v_www_aux_opcion_terminal.cve_area AND 
                      v_www_materias_1.cve_mat = v_www_aux_opcion_terminal.cve_proyecto_opc_term
 
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Materias de opción terminal 2/2
       SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                    8  AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa, v_www_materias_1.creditos
        FROM         v_www_mat_prerreq_pos INNER JOIN
                      v_www_materias_1 ON v_www_mat_prerreq_pos.cve_mat = v_www_materias_1.cve_mat INNER JOIN
                      v_www_plan_estudios ON v_www_mat_prerreq_pos.cve_carrera = v_www_plan_estudios.cve_carrera AND 
                      v_www_mat_prerreq_pos.cve_plan = v_www_plan_estudios.cve_plan INNER JOIN
                      v_www_aux_opcion_terminal ON v_www_plan_estudios.cve_area_opcion_terminal = v_www_aux_opcion_terminal.cve_area AND 
                      v_www_materias_1.cve_mat = v_www_aux_opcion_terminal.cve_proyecto_opc_term
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Area de Servicio Social
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   5 AS cve_plan_area,
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
 
            AND v_www_area_mat.cve_area = v_www_plan_estudios.cve_area_servicio_social
        WHERE     (v_www_mat_prerreq_pos.cve_plan = @licve_plan) 
            AND (v_www_mat_prerreq_pos.cve_carrera = @licve_carrera) 
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Area de reflexion universitaria Posgrado 2
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Area de reflexion universitaria Posgrado 3
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
 
        UNION     --   Area de reflexion universitaria Posgrado 4
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
 
        UNION     --   Area de reflexion universitaria Posgrado 5
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Area de reflexion universitaria Posgrado 6
        SELECT     v_www_mat_prerreq_pos.cve_carrera,
                   v_www_mat_prerreq_pos.cve_plan,
                   v_www_mat_prerreq_pos.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
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
            AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
        UNION     --   Area menor obligatoria
        SELECT     v_www_subsistema.cve_carrera,
                   v_www_subsistema.cve_plan,
                   v_www_area_mat.cve_mat,
                   v_www_materias_1.materia,
                   sigla =
                    CASE @licve_plan
                    WHEN  6 THEN v_www_materias_1.sigla
                    ELSE ISNULL(v_www_materias_1.sigla_anterior,v_www_materias_1.sigla)
                 END ,
                   3 AS cve_plan_area,
                   v_www_mat_prerreq_pos.semestre_ideal,
                   0 AS optativa,
                 v_www_materias_1.creditos
        FROM         v_www_subsistema 
                INNER JOIN v_www_area_mat 
                ON v_www_subsistema.cve_area = v_www_area_mat.cve_area 
                INNER JOIN v_www_mat_prerreq_pos 
                ON v_www_area_mat.cve_mat = v_www_mat_prerreq_pos.cve_mat 
                AND v_www_subsistema.cve_carrera = v_www_mat_prerreq_pos.cve_carrera 
                AND v_www_subsistema.cve_plan = v_www_mat_prerreq_pos.cve_plan 
                INNER JOIN v_www_materias_1 
                ON v_www_area_mat.cve_mat = v_www_materias_1.cve_mat
        WHERE     (v_www_subsistema.cve_carrera = @licve_carrera)
             AND (v_www_subsistema.cve_plan = @licve_plan) 
             AND (v_www_mat_prerreq_pos.semestre_ideal <> 0)
            AND (v_www_subsistema.clase_area = 'OBL')
        UNION     --   Materias que no existen
        SELECT     controlescolar_bd.dbo.plantilla_plan_materia.cve_carrera,
                   controlescolar_bd.dbo.plantilla_plan_materia.cve_plan, 
                   controlescolar_bd.dbo.materias_optativas.cve_mat,
                   controlescolar_bd.dbo.materias_optativas.materia, 
                   controlescolar_bd.dbo.materias_optativas.sigla,
                   controlescolar_bd.dbo.plantilla_plan_materia.cve_plan_area,
                   controlescolar_bd.dbo.plantilla_plan_materia.semestre_ideal,
                   1 AS optativa, 
                   controlescolar_bd.dbo.materias_optativas.creditos
        FROM         controlescolar_bd.dbo.materias_optativas 
                INNER JOIN controlescolar_bd.dbo.plantilla_plan_materia 
                ON  controlescolar_bd.dbo.materias_optativas.cve_mat = controlescolar_bd.dbo.plantilla_plan_materia.cve_mat
        WHERE     (controlescolar_bd.dbo.plantilla_plan_materia.cve_carrera = @licve_carrera) 
                AND (controlescolar_bd.dbo.plantilla_plan_materia.cve_plan = @licve_plan)
                AND (controlescolar_bd.dbo.plantilla_plan_materia.semestre_ideal <> 0)
        ORDER BY semestre_ideal,materia
END
 
END

GO

