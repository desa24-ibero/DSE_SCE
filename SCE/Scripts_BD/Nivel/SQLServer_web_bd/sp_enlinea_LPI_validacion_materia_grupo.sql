ALTER PROCEDURE [dbo].[sp_enlinea_LPI_validacion_materia_grupo]
 @CUENTA int,
 @MATERIA int,   
 @GRUPO varchar(2),     
 @INSCRIBE int =1,
 @a_hash varchar(50),
 @a_ip varchar(50),
 @CONMENSAJES int = 0
  
AS
declare
@ls_mensaje_error varchar(255),
@MENSAJE varchar(255),
@ll_num_error integer,
@num_error integer,
@mensaje_error varchar(255),
@ll_MATS_rowcount integer,
@li_codigo_proc integer,
@ls_mensaje_proc varchar(255),
@a_cuenta integer,
@return int

DECLARE @filas int, @lerror int, @chk int

SET @a_cuenta 	= ISNULL(@CUENTA,0)
SET @return = -1

DECLARE @CARRERA int, @PLAN int, @NIVEL varchar(1)
DECLARE @existe_grupo varchar(2), @pertenece_plan int, @cursada int, @cupo int, @inscritos int,@matinscrita int
DECLARE @pert_plan_pos int, @cursadapos integer, @retval integer
DECLARE @grupo_carr int
DECLARE	@msg varchar(254), @retorno int, @lerr int, @lrwc int
DECLARE @ANIO int, @PERIODO int, @tipo_inscrip char(1)


exec [sp_enlinea_LPI_valida_exec] 
@a_stored_procedure = 'sp_enlinea_LPI_validacion_materia_grupo',
@a_cuenta = @a_cuenta,
@a_hash = @a_hash ,
@a_ip = @a_ip ,
@CONMENSAJES = @CONMENSAJES,
@a_CODIGO = @li_codigo_proc  OUTPUT,
@a_MENSAJE  = @ls_mensaje_proc OUTPUT

IF @li_codigo_proc = -1 
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error= @ls_mensaje_proc
	IF @CONMENSAJES <> 0 print @ls_mensaje_error
	Goto EtiquetaError	
END

--SI TODO FUE CORRECTO
SELECT @ll_num_error = 0,
@ls_mensaje_error = 'OK'
SELECT @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error




/*LEER LOS PAR�METROS DE CARRERA,PLAN,NIVEL DE ACAD�MICOS*/
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
 
-- SELECT 1,@msg
-- RETURN 1
	SELECT @ll_num_error = 0
	SELECT @ls_mensaje_error = @MENSAJE
	SELECT @return =@ll_num_error
	Goto EtiquetaError				   
  
END
/**/
SELECT	@existe_grupo	= ISNULL(grupos.gpo,''),
		@pertenece_plan = ISNULL(mat_prerrequisito.cve_mat,0),
		@pert_plan_pos	= ISNULL(mat_prerreq_pos.cve_mat,0),
		@cursada		= ISNULL(historico_re.cve_mat,0),
		@cursadapos		= ISNULL(historico_pos_re.cve_mat,0),
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
			AND @NIVEL <> 'P'
				
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
			AND @NIVEL <>'P' 
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
 
-- SELECT @lerr,'Error en consulta para recuperar informaci�n. C�digo:'+convert(varchar,@lerr)
-- RETURN @lerr
 
 SELECT @ll_num_error = @lerr
 SELECT @ls_mensaje_error = @MENSAJE
 SELECT @return =@ll_num_error
 Goto EtiquetaError				   
 

END

IF @lrwc = 0 --2, LA MATERIA NO EXISTE
BEGIN
 SET @msg = 'La materia no existe'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 10, @msg
-- RETURN 10
 SELECT @ll_num_error = 10
 SELECT @ls_mensaje_error = @MENSAJE
 SELECT @return =@ll_num_error
 Goto EtiquetaError				   
  
END

/*IF (@NIVEL = 'L' OR @NIVEL = 'T')*/
IF (@NIVEL <> 'P')
BEGIN
 IF @pertenece_plan = 0 --3, LA MATERIA NO PERTENECE AL PLAN
 BEGIN
  SET @msg = 'La materia no pertenece al plan de estudios'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
--  SELECT 20, @msg
--  RETURN 20
  SELECT @ll_num_error = 20
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
  
 END
END

IF @NIVEL = 'P'
BEGIN
 IF @pert_plan_pos = 0 --3, LA MATERIA NO PERTENECE AL PLAN
 BEGIN
  SET @msg = 'La materia no pertenece al plan de estudios'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
--  SELECT 20, @msg
--  RETURN 20
  SELECT @ll_num_error = 20
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
 END
END

/*IF @cursada > 0 AND (@NIVEL = 'L'  OR @NIVEL = 'T')--4, LA MATERIA YA FU� CURSADA*/
IF @cursada > 0 AND @NIVEL <> 'P' --4, LA MATERIA YA FU� CURSADA 
BEGIN
 SET @msg = 'La materia ya fue cursada y aprobada'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 30, @msg
-- RETURN 30
  SELECT @ll_num_error = 30
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
END

IF @cursadapos > 0 AND @NIVEL = 'P' --4, LA MATERIA YA FU� CURSADA
BEGIN
 SET @msg =  'La materia ya fue cursada y aprobada'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 30,@msg
-- RETURN 30 
 SELECT @ll_num_error = 30
 SELECT @ls_mensaje_error = @MENSAJE
 SELECT @return =@ll_num_error
 Goto EtiquetaError				      
END

IF @matinscrita > 0 --5, LA MATERIA YA EST� INSCRITA
BEGIN
 SET @msg = 'La materia ya est� inscrita'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 40, @msg
-- RETURN 40
  SELECT @ll_num_error = 40
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
END 

					-- 60, EL ALUMNO EXCEDE LOS CR�DITOS PERMITIDOS
EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_creditos_max @CUENTA,@MATERIA,@CARRERA,@PLAN,@CONMENSAJES
IF @retval <> 0
BEGIN
 SET @msg = 'El alumno excede los cr�ditos permitidos.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 60, @msg
-- RETURN 60
  SELECT @ll_num_error = 60
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
END


IF @existe_grupo = '' --6, EL GRUPO NO EXISTE
BEGIN
 SET @msg = 'El grupo no existe.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 100, @msg
-- RETURN 100
  SELECT @ll_num_error = 100
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
END

IF @grupo_carr = 0 --7, GRUPO BLOQUEADO PARA CIERTAS CARRERAS O LA CARRERA-PLAN TIENE GRUPOS ESPECIALES
					--  QUE NO SON ESTE.
BEGIN
 SET @msg = 'El grupo especificado es especial para alumnos de otra carrera/plan'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 110, @msg
-- RETURN 110
  SELECT @ll_num_error = 110
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
END

IF @inscritos >= @cupo --8, GRUPO LLENO
BEGIN
 SET @msg = 'El grupo solicitado no tiene vacantes'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 120, @msg
-- RETURN 120
  SELECT @ll_num_error = 120
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
END

/*IF (@NIVEL = 'L' or @NIVEL = 'T')*/
IF (@NIVEL <> 'P') 
BEGIN
 EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_prerequisitos @CUENTA, @MATERIA, @CARRERA, @PLAN,@CONMENSAJES
 IF @retval <> 0
 BEGIN
  SET @msg = 'El alumno no cuenta con los prerequisitos necesarios.'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
--  SELECT 90, @msg
--  RETURN 90
  SELECT @ll_num_error = 90
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
 END
END

IF @NIVEL = 'P'
BEGIN
 EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_prerequisitos_pos @CUENTA, @MATERIA, @CARRERA, @PLAN,@CONMENSAJES
 IF @retval <> 0
 BEGIN
  SET @msg = 'El alumno no cuenta con los prerequisitos necesarios.'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
--  SELECT 90, @msg
--  RETURN 90
  SELECT @ll_num_error = 90
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
 END
END 

EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_materias_encimadas @CUENTA,@MATERIA,@GRUPO,@CONMENSAJES
IF @retval <> 0
BEGIN
  SET @msg = 'El horario de la materia se traslapa con otra.'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
-- SELECT 130, @msg
-- RETURN 130
 
 SELECT @ll_num_error = 130
 SELECT @ls_mensaje_error = @MENSAJE
 SELECT @return =@ll_num_error
 Goto EtiquetaError				     
 
 
END

EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_integracion @CUENTA,@MATERIA,@PLAN,@msg output ,@CONMENSAJES
IF @retval <> 0
BEGIN
 --SET @msg = 'La materia de integraci�n no se puede inscribir.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 140, @msg
-- RETURN 140

  SELECT @ll_num_error = 140
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
  
END

EXEC @retval = controlescolar_bd.dbo.sp_srl_validacion_trabajo_social @CUENTA,@MATERIA,@CARRERA,@PLAN,@CONMENSAJES
IF @retval <> 0
BEGIN
 SET @msg = 'La materia de trabajo social no se puede inscribir.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 150, @msg
-- RETURN 150
  SELECT @ll_num_error = 150
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     

END


/*****************************************/
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
/*****************************************/


/*Realizar inscripci�n: insertar en mat_inscritas*/
SELECT @ANIO = anio ,@PERIODO = periodo, @tipo_inscrip = CASE tipo_inscripcion WHEN 1 THEN 'A' WHEN 0 THEN 'I' ELSE '?' END
FROM	controlescolar_bd.dbo.activacion
WHERE tipo_periodo = @VAR_tipo_periodo 

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
IF @lerr <> 0
BEGIN
 SET @msg = 'Error en consulta de par�metros de inscripci�n. C�digo:'+convert(varchar,@lerr)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT @lerr,@msg
-- RETURN @lerr
  SELECT @ll_num_error = @lerr
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     


END

IF @lrwc = 0 --Los par�metros de inscripci�n no existen
BEGIN
 SET @msg = 'Los par�metros de inscripci�n no existen.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 20,@msg
-- RETURN 20 
  SELECT @ll_num_error = 20
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     
 
END

IF @INSCRIBE <> 1
BEGIN
 SET @msg = 'Grupo Ok.(el grupo no se inscribi�)'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
-- SELECT 0, @msg
-- RETURN 0
  SELECT @ll_num_error = 0
  SELECT @ls_mensaje_error = @MENSAJE
  SELECT @return =@ll_num_error
  Goto EtiquetaError				     

END
/*Empieza transacci�n, bloquear el registro del grupo desde la lectura, para evitar modificaciones*/
BEGIN TRANSACTION
	SELECT @lrwc = COUNT(*)
	FROM controlescolar_bd.dbo.grupos as gpo WITH(XLOCK,ROWLOCK)
	WHERE gpo.cve_mat = @MATERIA AND gpo.gpo = @GRUPO and  gpo.periodo = @PERIODO and gpo.anio = @ANIO
		 --AND gpo.inscritos = @inscritos 
		   AND gpo.cupo - gpo.inscritos > 0 --permitir (aunque cambie la variable 
		   									--@inscritos que ley� el n�mero de inscritos al iniciar
		   									--el proceso),inscripci�n mientras haya cupo
	SELECT @lerr = @@ERROR
	IF @lerr <> 0	--ERROR AL TRATAR DE BLOQUEAR REGISTRO.
	BEGIN
	 ROLLBACK TRANSACTION
	 SET @msg = 'Ha ocurrido un error al inscribir la materia '+convert(varchar,@MATERIA)+' grupo '+@GRUPO+
					' Intente nuevamente.'+' C�digo:'+convert(varchar,@lerr)
	 IF @CONMENSAJES <> 0 print @msg
	 SET @MENSAJE = @msg
--	 SELECT @lerr,@msg
--	 RETURN @lerr
	 SELECT @ll_num_error = @lerr
	 SELECT @ls_mensaje_error = @MENSAJE
	 SELECT @return =@ll_num_error
	 Goto EtiquetaError				     
	 
	 
	END
	
	IF @lrwc <> 1  --NO SE OBTUVO NING�N REGISTRO, PROBABLEMENTE EL # DE INSCRITOS CAMBIO
	BEGIN			--MIENTRAS SE HAC�AN LAS VALIDACIONES, PEDIR QUE SE INTENTE NUEVAMENTE.
	 ROLLBACK TRANSACTION
	 SET @msg = 'El cupo de alumnos ha cambiado mientras se procesaba la solicitud. Le pedimos lo intente nuevamente.'
	 IF @CONMENSAJES <> 0 print @msg
	 SET @MENSAJE = @msg
--	 SELECT 300,@msg
--	 RETURN 300
	 SELECT @ll_num_error = 300
	 SELECT @ls_mensaje_error = @MENSAJE
	 SELECT @return =@ll_num_error
	 Goto EtiquetaError		   
	 
	END
	
	INSERT INTO controlescolar_bd.dbo.mat_inscritas(cuenta, cve_mat, gpo,   periodo, anio, inscripcion,  cve_condicion)
	VALUES(@CUENTA,@MATERIA,@GRUPO,@PERIODO,@ANIO,@tipo_inscrip,0)
	
	SELECT @lerr = @@ERROR
	IF @lerr <> 0	--ERROR AL TRATAR DE BLOQUEAR REGISTRO.
	BEGIN
		ROLLBACK TRANSACTION
		SET @msg = 'Error al dar de alta la materia, grupo. C�digo:'+convert(varchar,@lerr)
	    IF @CONMENSAJES <> 0 print @msg
	    SET @MENSAJE = @msg
-- 		SELECT @lerr,@msg
-- 		RETURN @lerr
		SELECT @ll_num_error = @lerr
		SELECT @ls_mensaje_error = @MENSAJE
		SELECT @return =@ll_num_error
		Goto EtiquetaError				     
 		
	END
COMMIT TRANSACTION
SET @msg = 'Materia Clave: '+convert(varchar,@MATERIA)+' Grupo: '+@GRUPO+' inscrita correctamente.'
IF @CONMENSAJES <> 0 print @msg
SET @MENSAJE = @msg
--SELECT 0, @msg
--RETURN 0

--SI TODO FUE CORRECTO
SELECT @ll_num_error = 0,
@ls_mensaje_error = @MENSAJE

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
return @return


GO

