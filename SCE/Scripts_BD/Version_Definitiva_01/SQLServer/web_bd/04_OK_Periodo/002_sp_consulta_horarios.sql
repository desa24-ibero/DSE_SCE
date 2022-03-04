USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_horarios]    Script Date: 10/8/2017 08:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_consulta_horarios]
@cve_coordinacion int
 
AS 

DECLARE @VAR_anio INTEGER
DECLARE @VAR_periodo INTEGER
DECLARE @VAR_cve_coordinacion INTEGER

/*****************************************/
-- MALH 08/08/2017
/*Se recupera el tipo de periodo asocuado al plan de estudios de la cuenta*/
DECLARE @VAR_cve_carrera INTEGER
DECLARE @VAR_cve_plan INTEGER
DECLARE @VAR_tipo_periodo VARCHAR(3)

/* Se recuperan la cerrera y el plan.*/
SELECT @VAR_cve_carrera = web_bd.dbo.v_www_academicos.cve_carrera, 
	   @VAR_cve_plan = web_bd.dbo.v_www_academicos.cve_plan
FROM web_bd.dbo.v_www_academicos
WHERE cuenta = @cve_coordinacion

/* Se recupera el tipo de periodo.*/
SELECT @VAR_tipo_periodo = web_bd.dbo.v_www_plan_estudios.tipo_periodo
FROM web_bd.dbo.v_www_plan_estudios
WHERE web_bd.dbo.v_www_plan_estudios.cve_carrera = @VAR_cve_carrera
AND web_bd.dbo.v_www_plan_estudios.cve_plan = @VAR_cve_plan  
/*****************************************/

--Obtiene los parametros de los periodos por procesos
--Para el periodo de la carga de grupos

SELECT @VAR_anio = isnull(anio,0),  
	   @VAR_periodo = isnull(periodo,0)  
FROM controlescolar_bd.dbo.periodos_por_procesos
WHERE cve_proceso = 4
AND tipo_periodo = @VAR_tipo_periodo -- MALH 08/08/2017 -> SE AGREGA CONDICION "AND"

--Si no existen estos parametros no es posible continuar
IF @@ROWCOUNT = 0
BEGIN
	SELECT -1,'NO SE ENCUENTRA INFORMACIÓN DE LOS PARAMETROS DE CARGA PARA EL GRUPO'
	RETURN -1
END 


  SELECT cve_mat_gpo= grupos.cve_mat_gpo,
		 cve_mat = grupos.cve_mat,   
         gpo = grupos.gpo,   
         sigla = materias.sigla,   
         materia = materias.materia,   
         nombre_completo = profesor.nombre_completo,   
		 comentarios = upper(grupos.comentarios),
         cve_dia = horario.cve_dia,   
		 dia = CASE  horario.cve_dia WHEN 0 THEN 'Domingo'
  												 WHEN 1 THEN 'Lunes'
  												 WHEN 2 THEN 'Martes'
  												 WHEN 3 THEN 'Miércoles'
  												 WHEN 4 THEN 'Jueves'
  												 WHEN 5 THEN 'Viernes'
  												 WHEN 6 THEN 'Sábado'
												ELSE ''END,
         hora_inicio = horario.hora_inicio,   
         hora_final = horario.hora_final,   
         cve_salon = horario.cve_salon
    FROM 
    
    
		 controlescolar_bd.dbo.grupos grupos left outer join 
         controlescolar_bd.dbo.horario horario on (grupos.cve_mat = horario.cve_mat and   grupos.gpo = horario.gpo  
												OR   grupos.cve_asimilada = horario.cve_mat and  grupos.gpo_asimilado = horario.gpo)
		inner join controlescolar_bd.dbo.materias materias	 on (grupos.cve_mat = materias.cve_mat and grupos.cond_gpo = 1 )
		inner join controlescolar_bd.dbo.profesor profesor	 on (grupos.cve_profesor = profesor.cve_profesor)							
		inner join  controlescolar_bd.dbo.coordinaciones coordinaciones on (materias.cve_coordinacion = @cve_coordinacion and  materias.cve_coordinacion = coordinaciones.cve_coordinacion)
 
		
	WHERE grupos.anio = @VAR_anio  
		AND   grupos.periodo = @VAR_periodo  
		AND   horario.anio = @VAR_anio 
		AND horario.periodo = @VAR_periodo
		AND grupos.gpo NOT IN ('ZZ')
	UNION
SELECT cve_mat_gpo= grupos.cve_mat_gpo,
		 cve_mat = grupos.cve_mat,   
         gpo = grupos.gpo,   
         sigla = materias.sigla,   
         materia = materias.materia,   
         nombre_completo = profesor.nombre_completo,   
		 comentarios = upper(grupos.comentarios),
         cve_dia = NULL,   
		 dia = NULL,
         hora_inicio = NULL,   
         hora_final = NULL,   
         cve_salon = NULL
    FROM 
    
    
		 controlescolar_bd.dbo.grupos grupos 
         		inner join controlescolar_bd.dbo.materias materias	 on (grupos.cve_mat = materias.cve_mat and grupos.cond_gpo = 1 )
		inner join controlescolar_bd.dbo.profesor profesor	 on (grupos.cve_profesor = profesor.cve_profesor)							
		inner join  controlescolar_bd.dbo.coordinaciones coordinaciones on (materias.cve_coordinacion = @cve_coordinacion and  materias.cve_coordinacion = coordinaciones.cve_coordinacion)
 
		
	WHERE grupos.anio = @VAR_anio  
		AND   grupos.periodo = @VAR_periodo
		AND	  grupos.tipo not in (0)
		AND grupos.gpo NOT IN ('ZZ')

ORDER BY grupos.cve_mat, grupos.gpo, horario.cve_dia

--IF @@ROWCOUNT = 0
--BEGIN
--	SELECT -3,'NO SE ENCUENTRA INFORMACIÓN DEL DEPARTAMENTO EN CUESTIÓN'
--	RETURN -3
--END 


