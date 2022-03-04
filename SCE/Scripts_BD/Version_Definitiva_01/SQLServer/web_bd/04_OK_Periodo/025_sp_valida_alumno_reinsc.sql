USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_valida_alumno_reinsc]    Script Date: 9/8/2017 16:47:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER procedure [dbo].[sp_valida_alumno_reinsc] 
@a_cuenta integer
as
declare 
@num_error integer,
@mensaje_error varchar(255),
@ls_mensaje_error varchar(500),
@ll_num_error integer,
@ll_resultado integer,
@ll_cuenta integer,
@ll_cve_mat integer,
@ll_anio integer,
@ll_periodo integer,
@ls_periodo_descripcion varchar(15),
@ls_estatus_materia varchar(50),
@ls_anio_periodo varchar(25),
@ll_curso_prerrequisitos integer,
@ll_cve_mat_grupos integer,
@ll_cve_carrera integer,
@ll_cve_plan integer,
@ll_rowcount_plan_ideal integer,
@ll_rowcount_teorias_aprobadas integer,
@ll_periodo_teoria integer,
@ll_anio_teoria integer,
@ll_calificacion_teoria integer,
@ls_nivel varchar(1),

@ll_preinscripcion_activa integer,
@ll_periodo_preinscripcion integer,
@ls_nombre_periodo_preinscripcion varchar(255),
@ll_anio_preinscripcion integer,
@ldttm_fecha_res_preinscripcion datetime,
@ll_activa_posgrado_p_ingreso integer,
@ll_ppi_cuenta integer,
@ll_ppi_periodo integer,
@ll_ppi_anio integer,
@ll_ppi_rowcount integer,
@ll_periodo_reinsc integer,
@ls_nombre_periodo_reinsc varchar(255),		   
@ll_anio_reinsc	integer,	       
@ll_reinsc_activa integer,
@ll_califico_sepe int,
@ll_PERIODO_SEPE int,
@ls_NOMBRE_PERIODO_SEPE varchar(255),
@ll_ANIO_SEPE int,
@ll_REVISION_SEPE_ACTIVA int,
@ll_SEPE_rowcount integer,
@ll_inscrito_cuenta integer,
@ll_INSCRITO_rowcount integer,
@ll_reingreso_cuenta integer,
@ll_REINGRESO_rowcount integer,
@ll_PER_REINSC_rowcount integer,
@ll_ACADEMICOS_rowcount integer,
@ll_PARAMETROS_rowcount integer,
@ll_ADEUDOS_rowcount integer,
@ll_ADEUDOS_cuenta integer


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
WHERE cuenta = @a_cuenta

/* Se recupera el tipo de periodo.*/
SELECT @VAR_tipo_periodo = web_bd.dbo.v_www_plan_estudios.tipo_periodo
FROM web_bd.dbo.v_www_plan_estudios
WHERE web_bd.dbo.v_www_plan_estudios.cve_carrera = @VAR_cve_carrera
AND web_bd.dbo.v_www_plan_estudios.cve_plan = @VAR_cve_plan  
/*****************************************/

--utilities.f_parametros_servicios
--CONSULTA LOS PARÁMETROS PARA DETERMINAR SI LA REINSCRIPCIÓN ESTÁ ACTIVA
SELECT 
@ll_preinscripcion_activa =	preinscripcion_activa,
@ll_periodo_preinscripcion = periodo_preinscripcion,
-- MALH 29/09/2017 SE AGREGA CONSULTA
@ls_nombre_periodo_preinscripcion =	(SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo_preinscripcion),
/*-- MALH 29/09/2017 SE COMENTA
@ls_nombre_periodo_preinscripcion =	CASE periodo_preinscripcion WHEN 0 THEN 'PRIMAVERA' 
					       						WHEN 1 THEN 'VERANO'
			       								WHEN 2 THEN 'OTOÑO' END,
*/
@ll_anio_preinscripcion = anio_preinscripcion,
@ldttm_fecha_res_preinscripcion = fecha_res_preinscripcion,
@ll_activa_posgrado_p_ingreso = activa_posgrado_p_ingreso
FROM v_www_parametros_servicios ps
WHERE ps.cve_parametro = 1

SET @ll_PARAMETROS_rowcount =@@ROWCOUNT

--SI NO SE OBTUVIERON REGISTROS ES PORQUE LOS PARÁMETROS ESTÁN MAL CONFIGURADOS
IF @ll_PARAMETROS_rowcount = 0
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error= 'No existen Parámetros de Servicios.'
	Goto EtiquetaError
END

--OBTIENE LA CARRERA, PLAN Y NIVEL DEL ALUMNO EN CUESTION
	SELECT @ll_cuenta = ac.cuenta,
			@ll_cve_carrera = ac.cve_carrera,
			@ll_cve_plan = ac.cve_plan,
			@ls_nivel = ac.nivel
	FROM v_www_academicos ac 
	WHERE ac.cuenta = @a_cuenta

SET @ll_ACADEMICOS_rowcount =@@ROWCOUNT

--SI NO SE OBTUVIERON REGISTROS ES PORQUE NO EXISTE INFORMACIÓN ACADÉMICA DEL ALUMNO
IF @ll_ACADEMICOS_rowcount = 0
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error= 'No existen información Académica del alumno.'
	Goto EtiquetaError
END


--utilities.f_posgrado_primer_ingreso
--CONSULTA SI EL ALUMNO ES DE POSGRADO DE PRIMER INGRESO
SELECT @ll_ppi_cuenta =  ac.cuenta,
		@ll_ppi_periodo = pp.periodo,
		@ll_ppi_anio = pp.anio
FROM v_www_academicos ac, 
	controlescolar_bd.dbo.periodos_por_procesos pp
WHERE ac.nivel = 'P'
AND ac.anio_ing = pp.anio
AND ac.periodo_ing = pp.periodo
AND pp.cve_proceso = 2
AND ac.cuenta = @a_cuenta
AND pp.tipo_periodo = @VAR_tipo_periodo -- MALH 08/08/2017 -> SE AGREGA CONDICION "AND"


SET @ll_ppi_rowcount =@@ROWCOUNT
--SI DEVUELVE 0 NO ES DE PRIMER INGRESO, DE LO CONTRARIO SI LO ES

IF (@ll_preinscripcion_activa= 0 AND @ll_ppi_rowcount = 0)
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error = 'No es periodo de Reinscripción.(1)'
	Goto EtiquetaError
END

IF (@ls_nivel = 'P') AND (@ll_ppi_rowcount >= 1) AND (@ll_activa_posgrado_p_ingreso = 0)
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error = 'No es periodo de Reinscripción.(2)'
	Goto EtiquetaError
END

--OBTIENE EL PERIODO DE REINSCRIPCIÓN VIGENTE
--utilities.f_periodo_preinscripcion
SELECT @ll_periodo_reinsc = pp.periodo, 
	   -- MALH 29/09/2017 SE AGREGA CONSULTA
	   @ls_nombre_periodo_reinsc = (SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = pp.periodo),
	   /*-- MALH 29/09/2017 SE COMENTA
       @ls_nombre_periodo_reinsc = CASE periodo WHEN 0 THEN 'PRIMAVERA' 
		       WHEN 1 THEN 'VERANO'
		       WHEN 2 THEN 'OTOÑO' END, 
	   */
       @ll_anio_reinsc = pp.anio,
       @ll_reinsc_activa = ps.preinscripcion_activa
FROM v_www_periodo_preinscripcion pp, 
	v_www_parametros_servicios ps
WHERE ps.cve_parametro = 1

SET @ll_PER_REINSC_rowcount =@@ROWCOUNT

--SI NO SE OBTUVIERON REGISTROS ES PORQUE LOS PARÁMETROS ESTÁN MAL CONFIGURADOS
IF @ll_PER_REINSC_rowcount = 0
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error= 'No existen parámetros de indicando el periodo de Reinscripción Vigente.'
	Goto EtiquetaError
END

--OBTIENE EL PERIODO DEL SEPE Y SI LA REVISIÓN ESTÁ ACTIVA
SELECT @ll_PERIODO_SEPE= pps.periodo_sepe,
	   -- MALH 29/09/2017 SE AGREGA CONSULTA
	   @ls_NOMBRE_PERIODO_SEPE = (SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = pps.periodo_sepe),
	   /*-- MALH 29/09/2017 SE COMENTA
	   @ls_NOMBRE_PERIODO_SEPE = CASE pps.periodo_sepe WHEN 0 THEN 'PRIMAVERA' 
				   WHEN 1 THEN 'VERANO'
				   WHEN 2 THEN 'OTOÑO' END, 
	   */
@ll_ANIO_SEPE= pps.anio_sepe,
@ll_REVISION_SEPE_ACTIVA = pps.revision_activa
FROM dbo.periodo_preinscripcion_sepe pps
WHERE pps.periodo_preinsc = @ll_periodo_reinsc
AND pps.anio_preinsc = @ll_anio_reinsc

SET @ll_SEPE_rowcount =@@ROWCOUNT

--SI NO SE OBTUVIERON REGISTROS ES PORQUE LOS PARÁMETROS ESTÁN MAL CONFIGURADOS
IF @ll_SEPE_rowcount = 0
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error= 'No existen parámetros de SEPE  para el periodo de Reinscripción '+@ls_nombre_periodo_reinsc +' '+ CONVERT(VARCHAR(4),@ll_anio_reinsc)+'.'
	Goto EtiquetaError
END

--SOLO SI LA REVISION DEL SEPE ESTA ACTIVA SE REALIZA LA REVISIÓN
IF @ll_REVISION_SEPE_ACTIVA= 1 
BEGIN
--SI EL NIVEL ES DE POSGRADO, POR DEFAULT ES COMO SI HUBIERA LLENADO EL SEPE
--OK
--[sp_califico_sepe_reinsc2]
--utilities.f_alumno_evaluo_sepe1
	IF @ls_nivel = 'P'
	BEGIN
		SET @ll_califico_sepe=1
	END
	ELSE
	BEGIN
		SET @ll_califico_sepe= 0
		EXEC sp_califico_sepe_reinsc2 @CUENTA =@a_cuenta, @CALIFICO_SEPE_OUT = @ll_califico_sepe OUTPUT
	END
END

--SI EL ALUMNO NO LLENO EL SEPE
IF @ll_califico_sepe = 0
BEGIN
--Tu Reinscripción está bloqueada por no haber contestado la totalidad del SEPE1 durante Oto&ntilde;o 2011. Contéstalo en [Servicios Escolares] -> [Evaluación de Profesores] y vuelve a intentar.
	SET @ll_num_error = -1
	SET @ls_mensaje_error= 'Tu Reinscripción está bloqueada por no haber contestado la totalidad del SEPE1 durante '+@ls_NOMBRE_PERIODO_SEPE +' '+ CONVERT(VARCHAR(4),@ll_ANIO_SEPE)+'. Contéstalo en [Servicios Escolares] -> [Evaluación de Profesores] y vuelve a intentar.'
	Goto EtiquetaError
END

--OBTIENE SI EL ALUMNO ESTUVO INSCRITO EL SEMETRE ANTERIOR 

--utilities.f_revisa_inscrito
SELECT @ll_inscrito_cuenta = cuenta 
FROM dbo.v_www_inscritos_actuales
WHERE dbo.v_www_inscritos_actuales.cuenta = @a_cuenta

SET @ll_INSCRITO_rowcount =@@ROWCOUNT

--SI NO SE OBTUVIERON REGISTROS HABRA QUE VALIDAR SI TIENE UN REINGRESO
IF @ll_INSCRITO_rowcount = 0
BEGIN

-- OBTIENE SI EL ALUMNO TIENE UN REINGRESO			
	SELECT @ll_reingreso_cuenta = cuenta 
				FROM dbo.v_www_reingresos
				WHERE dbo.v_www_reingresos.cuenta = @a_cuenta
				
	SET @ll_REINGRESO_rowcount =@@ROWCOUNT
	
	IF @ll_REINGRESO_rowcount = 0
	BEGIN
		SET @ll_num_error = -1
		SET @ls_mensaje_error= 'No es posible Reinscribirte. Tienes que tramitar un reingreso.'
		Goto EtiquetaError	
	END
END

--	REVISA SI EL ALUMNO TIENE ADEUDOS
SELECT @ll_ADEUDOS_cuenta = v_www_saldos_mov_alumnos.cuenta
FROM v_www_saldos_mov_alumnos
WHERE   v_www_saldos_mov_alumnos.cuenta =@a_cuenta
AND  v_www_saldos_mov_alumnos.saldo > 5 AND 
(dateadd(day, 1, v_www_saldos_mov_alumnos .fecha_vencimiento) <= getdate() 
OR v_www_saldos_mov_alumnos.cve_concepto = 33) AND
(cve_concepto <100)
			
SET @ll_ADEUDOS_rowcount =@@ROWCOUNT

--SI NO SE OBTUVIERON REGISTROS ES PORQUE LOS PARÁMETROS ESTÁN MAL CONFIGURADOS
IF @ll_ADEUDOS_rowcount > 0
BEGIN
	SET @ll_num_error = 0
	SET @ls_mensaje_error= 'Recuerda realizar tu pago antes de la fecha límite.'
	Goto EtiquetaCorrecto
END
			
--SI TODO FUE CORRECTO
SELECT @ll_num_error = 0,
@ls_mensaje_error = 'OK'

Fin:
 
EtiquetaCorrecto:
select @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error
-- Commit Transaction
SELECT CODIGO =@num_error, MENSAJE=@mensaje_error
return 0
 
EtiquetaError:
 select @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error
SELECT CODIGO =@num_error, MENSAJE=@mensaje_error
 -- Rollback Transaction
 return -1
GO