

USE controlescolar_bd
go
 
ALTER PROCEDURE [dbo].[sp_srl_validacion_materia_grupo]
 @CUENTA int,
 @MATERIA int,     
 @GRUPO varchar(2),     
 @MENSAJE varchar(254) = '' OUTPUT,
 @INSCRIBE int =1,
 @CONMENSAJES int = 0
AS
DECLARE @CARRERA int, @PLAN int, @NIVEL varchar(1)
DECLARE @existe_grupo varchar(2), @pertenece_plan int, @cursada int, @cupo int, @inscritos int,@matinscrita int
DECLARE @retval integer
DECLARE @grupo_carr int
DECLARE	@msg varchar(254), @retorno int, @lerr int, @lrwc int
DECLARE @ANIO int, @PERIODO int, @tipo_inscrip char(1)
/*
Modificicación 2009-08-18 Omar Ugalde
	Se unificó el sp que valida los prerequisitos para Licenciatura y Prosgrado, por lo tanto se eliminaron las
	secciones IF @NIVEL = 'L', IF @NIVEL = 'P' que llamaban a distintos sp's.
	
	Se agregó parámetro @MENSAJE output al sp de servicio social para mostrar al usuario la razón x la cual no
	se puede cursar el Servicio Social.
*/
/*LEER LOS PARÁMETROS DE CARRERA,PLAN,NIVEL DE ACADÉMICOS*/
SELECT @CARRERA= cve_carrera, @PLAN = cve_plan, @NIVEL = nivel
FROM controlescolar_bd.dbo.academicos
WHERE cuenta = @CUENTA

SET @lrwc = @@ROWCOUNT

IF @lrwc = 0 OR @lrwc IS NULL
BEGIN
 SET @msg = 'El alumno con cuenta: '+cast(ISNULL(@CUENTA,0) as varchar)
 						+' carrera: '+cast(ISNULL(@CARRERA,0) as varchar)
 						+' plan: '+cast(ISNULL(@PLAN,0) as varchar)
 						+' nivel: '+ISNULL(@NIVEL,'NULO')+ ' no existe.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 1,@msg
 RETURN 1
END
/**/
SELECT	@existe_grupo	= ISNULL(grupos.gpo,''),
		@pertenece_plan = CASE @NIVEL WHEN 'L' THEN ISNULL(mat_prerrequisito.cve_mat,0) ELSE ISNULL(mat_prerreq_pos.cve_mat,0) END,
		@cursada		= CASE @NIVEL WHEN 'L' THEN ISNULL(historico_re.cve_mat,0) ELSE ISNULL(historico_pos_re.cve_mat,0) END,
		@cupo			= ISNULL(grupos.cupo,0),
		@inscritos		= ISNULL(grupos.inscritos,0),
		@grupo_carr		= CASE WHEN EXISTS	(select	1
					 						 from	controlescolar_bd.dbo.reinscripcion_materias rm
					 						 where	rm.cve_mat = materias.cve_mat
											 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA OR rm.cve_gpo = @GRUPO)
 											)
						  THEN				(select	count(*)
 					 			 			 from	controlescolar_bd.dbo.reinscripcion_materias rm
 					 			  			 where	rm.cve_mat = materias.cve_mat
					 						 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA and rm.cve_gpo = @GRUPO)
											)
						  ELSE 1 END,
		@matinscrita	= ISNULL(mat_inscritas.cve_mat,0)
FROM controlescolar_bd.dbo.materias materias
			
			LEFT OUTER JOIN controlescolar_bd.dbo.mat_prerrequisito mat_prerrequisito ON
				materias.cve_mat				= mat_prerrequisito.cve_mat
			AND	mat_prerrequisito.cve_carrera	= @CARRERA
			AND	mat_prerrequisito.cve_plan		= @PLAN
			AND @NIVEL = 'L'
				
			LEFT OUTER JOIN controlescolar_bd.dbo.mat_prerreq_pos mat_prerreq_pos ON
				materias.cve_mat				= mat_prerreq_pos.cve_mat
			AND	mat_prerreq_pos.cve_carrera	= @CARRERA
			AND	mat_prerreq_pos.cve_plan		= @PLAN
			AND @NIVEL = 'P'
				
			LEFT OUTER JOIN controlescolar_bd.dbo.historico_re historico_re ON
				historico_re.cve_mat		= materias.cve_mat
			AND	historico_re.cve_plan		= @PLAN
			AND	historico_re.cve_carrera	= @CARRERA
			AND ltrim(rtrim(historico_re.calificacion)) IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
			AND @NIVEL = 'L'
			AND historico_re.cuenta			= @CUENTA
				
			LEFT OUTER JOIN controlescolar_bd.dbo.historico_pos_re historico_pos_re ON
				historico_pos_re.cve_mat		= materias.cve_mat
			AND historico_pos_re.cve_plan		= @PLAN
			AND historico_pos_re.cve_carrera	= @CARRERA
			AND ltrim(rtrim(historico_pos_re.calificacion)) IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
			AND @NIVEL = 'P'
			AND historico_pos_re.cuenta			= @CUENTA
				
			LEFT OUTER JOIN controlescolar_bd.dbo.grupos grupos WITH (NOLOCK) ON
				materias.cve_mat	= grupos.cve_mat
			AND	grupos.gpo			= @GRUPO
				
			LEFT OUTER JOIN controlescolar_bd.dbo.mat_inscritas mat_inscritas ON
				materias.cve_mat		= mat_inscritas.cve_mat
			AND mat_inscritas.cuenta	= @CUENTA
WHERE materias.cve_mat = @MATERIA

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
SET @msg = 'Consulta de materia Filas: '+cast(@lrwc as varchar)+' Error: '+cast(@lerr as varchar)
IF @CONMENSAJES <> 0 print @msg
IF @lerr <> 0
BEGIN
 SET @MENSAJE = @msg
 SELECT @lerr,'Error en consulta para recuperar inforamción. Código:'+convert(varchar,@lerr)
 RETURN @lerr
END

IF @lrwc = 0 --2, LA MATERIA NO EXISTE
BEGIN
 SET @msg = 'La materia no existe.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 10, @msg
 RETURN 10
END

IF @pertenece_plan = 0 --3, LA MATERIA NO PERTENECE AL PLAN
BEGIN
 SET @msg = 'La materia no pertenece al plan de estudios.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 20, @msg
 RETURN 20
END

IF @cursada > 0  --4, LA MATERIA YA FUÉ CURSADA
BEGIN
 SET @msg = 'La materia ya fue cursada y aprobada.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 30, @msg
 RETURN 30
END

IF @matinscrita > 0 --5, LA MATERIA YA ESTÁ INSCRITA
BEGIN
 SET @msg = 'La materia ya está inscrita.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 40, @msg
 RETURN 40
END 

					-- 60, EL ALUMNO EXCEDE LOS CRÉDITOS PERMITIDOS
EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_creditos_max @CUENTA,@MATERIA,@CARRERA,@PLAN,@CONMENSAJES
IF @retval <> 0
BEGIN
 SET @msg = 'El alumno excede los créditos permitidos.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 60, @msg
 RETURN 60
END


IF @existe_grupo = '' --6, EL GRUPO NO EXISTE
BEGIN
 SET @msg = 'El grupo no existe.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 100, @msg
 RETURN 100
END

IF @grupo_carr = 0 --7, GRUPO BLOQUEADO PARA CIERTAS CARRERAS O LA CARRERA-PLAN TIENE GRUPOS ESPECIALES
					--  QUE NO SON ESTE.
BEGIN
 SET @msg = 'El grupo especificado es especial para alumnos de otra carrera/plan.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 110, @msg
 RETURN 110
END

IF @inscritos >= @cupo --8, GRUPO LLENO
BEGIN
 SET @msg = 'El grupo solicitado no tiene vacantes.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 120, @msg
 RETURN 120
END

/*Validar los prerequisitos de la materia.*/
EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_prerequisitos @CUENTA, @MATERIA, @CARRERA, @PLAN,@CONMENSAJES
IF @retval <> 0
BEGIN
SET @msg = 'El alumno no cuenta con los prerequisitos necesarios para la materia.' + convert(VARCHAR(20),@MATERIA)
IF @CONMENSAJES <> 0 print @msg
SET @MENSAJE = @msg
SELECT 90, @msg
RETURN 90
END

EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_materias_encimadas @CUENTA,@MATERIA,@GRUPO,@CONMENSAJES
IF @retval <> 0
BEGIN
  SET @msg = 'El horario de la materia se traslapa con otra.'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
 SELECT 130, @msg
 RETURN 130
END

EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_integracion @CUENTA,@MATERIA,@PLAN,@msg output ,@CONMENSAJES
IF @retval <> 0
BEGIN
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 140, @msg
 RETURN 140
END

EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_trabajo_social @CUENTA,@MATERIA,@CARRERA,@PLAN,@msg output,@CONMENSAJES
IF @retval <> 0
BEGIN
 SET @msg = 'La materia de trabajo social no se puede inscribir:'+ @msg
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 150, @msg
 RETURN 150
END


/*Se recupera el tipo de periodo asocuado al plan de estudios de la cuenta*/
DECLARE @VAR_cve_carrera INTEGER
DECLARE @VAR_cve_plan INTEGER
DECLARE @VAR_tipo_periodo VARCHAR(3)

/* Se recuperan la cerrera y el plan.*/
SELECT @VAR_cve_carrera = web_bd.dbo.v_www_academicos.cve_carrera, 
	   @VAR_cve_plan = web_bd.dbo.v_www_academicos.cve_plan
FROM web_bd.dbo.v_www_academicos
WHERE cuenta = @CUENTA

/* Se recupera el tipo de periodo.*/
SELECT @VAR_tipo_periodo = web_bd.dbo.v_www_plan_estudios.tipo_periodo
FROM web_bd.dbo.v_www_plan_estudios
WHERE web_bd.dbo.v_www_plan_estudios.cve_carrera = @VAR_cve_carrera
AND web_bd.dbo.v_www_plan_estudios.cve_plan = @VAR_cve_plan 



/*Realizar inscripción: insertar en mat_inscritas*/
SELECT @ANIO = anio ,@PERIODO = periodo, @tipo_inscrip = CASE tipo_inscripcion WHEN 1 THEN 'A' WHEN 0 THEN 'I' ELSE '?' END
FROM	controlescolar_bd.dbo.activacion
WHERE tipo_periodo = @VAR_tipo_periodo 

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
IF @lerr <> 0
BEGIN
 SET @msg = 'Error en consulta de parámetros de inscripción. Código:'+convert(varchar,@lerr)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT @lerr,@msg
 RETURN @lerr
END

IF @lrwc = 0 --Los parámetros de inscripción no existen
BEGIN
 SET @msg = 'Los parámetros de inscripción no existen.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 20,@msg
 RETURN 20
END

IF @INSCRIBE <> 1
BEGIN
 SET @msg = 'Grupo Ok.(el grupo no se inscribió)'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 0, @msg
 RETURN 0
END
/*Empieza transacción, bloquear el registro del grupo desde la lectura, para evitar modificaciones*/
BEGIN TRANSACTION
	SELECT @lrwc = COUNT(*)
	FROM controlescolar_bd.dbo.grupos as gpo WITH(XLOCK,ROWLOCK)
	WHERE gpo.cve_mat = @MATERIA AND gpo.gpo = @GRUPO and  gpo.periodo = @PERIODO and gpo.anio = @ANIO
		 --AND gpo.inscritos = @inscritos 
		   AND gpo.cupo - gpo.inscritos > 0 --permitir (aunque cambie la variable 
		   									--@inscritos que leyó el número de inscritos al iniciar
		   									--el proceso),inscripción mientras haya cupo
	SELECT @lerr = @@ERROR
	IF @lerr <> 0	--ERROR AL TRATAR DE BLOQUEAR REGISTRO.
	BEGIN
	 ROLLBACK TRANSACTION
	 SET @msg = 'Ha ocurrido un error al inscribir la materia '+convert(varchar,@MATERIA)+' grupo '+@GRUPO+
					' Intente nuevamente.'+' Código:'+convert(varchar,@lerr)
	 IF @CONMENSAJES <> 0 print @msg
	 SET @MENSAJE = @msg
	 SELECT @lerr,@msg
	 RETURN @lerr
	END
	
	IF @lrwc <> 1  --NO SE OBTUVO NINGÚN REGISTRO, PROBABLEMENTE EL # DE INSCRITOS CAMBIO
	BEGIN			--MIENTRAS SE HACÍAN LAS VALIDACIONES, PEDIR QUE SE INTENTE NUEVAMENTE.
	 ROLLBACK TRANSACTION
	 SET @msg = 'El cupo de alumnos ha cambiado mientras se procesaba la solicitud. Le pedimos lo intente nuevamente.' + convert(VARCHAR(20), @lrwc)
	 IF @CONMENSAJES <> 0 print @msg
	 SET @MENSAJE = @msg
	 SELECT 300,@msg
	 RETURN 300
	END
	
	INSERT INTO controlescolar_bd.dbo.mat_inscritas(cuenta, cve_mat, gpo,   periodo, anio, inscripcion,  cve_condicion)
	VALUES(@CUENTA,@MATERIA,@GRUPO,@PERIODO,@ANIO,@tipo_inscrip,0)
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SET @msg = 'Error al dar de alta la materia, grupo. Código:'+convert(varchar,@lerr)
	    IF @CONMENSAJES <> 0 print @msg
	    SET @MENSAJE = @msg
 		SELECT @lerr,@msg
 		RETURN @lerr
	END
COMMIT TRANSACTION
SET @msg = 'Materia Clave: '+convert(varchar,@MATERIA)+' Grupo: '+@GRUPO+' inscrita correctamente.'
IF @CONMENSAJES <> 0 print @msg
SET @MENSAJE = @msg
SELECT 0, @msg
RETURN 0

GO

 