use controlescolar_bd
go 

ALTER PROCEDURE [dbo].[sp_srl_inscripcion_teoria_lab]
 @CUENTA int,
 @CVEMAT1 int,     
 @GPO1 varchar(5),     
 @CVEMAT2 int,
 @GPO2 varchar(5),
 @MENSAJE varchar(254) = '' OUTPUT,
 @INSCRIBE int =1,
 @CONMENSAJES int = 0
AS
/*Modificado 2009-08-17 Omar Ugalde
	Se agregó validación para que la teoría y laboratorio que están tratando de inscribirse no
	traslapen sus horarios.
*/
DECLARE @CARRERA int, @PLAN int, @NIVEL varchar(1), @ANIO int, @PERIODO int,@tipo_inscrip char(1)
DECLARE	@msg varchar(254), @retorno int, @lerr int, @lrwc int,@msgtmp varchar (254)
DECLARE @ES_LAB int, @CVETEO int, @CVELAB int, @GPOTEO varchar(5), @GPOLAB varchar(5)
DECLARE @CVETMP int, @GPOTMP varchar(5), @ENCIMA int
SET @CVEMAT1 = ISNULL(@CVEMAT1,0)
SET @CVEMAT2 = ISNULL(@CVEMAT2,0)
SET @GPO1 	 = ISNULL(@GPO1,'')
SET @GPO2 	 = ISNULL(@GPO2,'')
 
EXEC @retorno = controlescolar_bd.dbo.sp_srl_qLlevaTeoriaLab	@CUENTA		= @CUENTA,
																@CLAVE_MAT	= @CVEMAT1,
																@GRUPO		= @GPO1,
																@FROMPROC	= 1,
														 		@CLAVE2		= @CVETMP OUTPUT ,
														 		@GRUPO2		= @GPOTMP OUTPUT,
														 		@ES_LABO	= @ES_LAB OUTPUT
IF @retorno = 0
BEGIN
 SET @msg = 'La materia '+cast(@CVEMAT1 as varchar)+' no está ligada '+
 							'con la materia '+cast(@CVEMAT2 as varchar)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 10,@msg
 RETURN 10
END

IF @ES_LAB = 0
 SELECT @CVETEO = @CVEMAT1, @GPOTEO = @GPO1, @CVELAB = @CVEMAT2, @GPOLAB = @GPO2
ELSE
 SELECT @CVELAB = @CVEMAT1, @GPOLAB = @GPO1, @CVETEO = @CVEMAT2, @GPOTEO = @GPO2

/*Validar que las materias estén ligadas*/
IF (@ES_LAB = 1 AND @CVETEO <> @CVETMP) OR (@ES_LAB = 0 AND @CVELAB <> @CVETMP)
BEGIN
 SET @msg = 'La materia '+cast(@CVEMAT1 as varchar)+' no está ligada '+
 							'con la materia '+cast(@CVEMAT2 as varchar)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 11,@msg
 RETURN 11
END

/*Validar que el horario de la teoria vs laboratorio no se traslapen*/
select @ENCIMA = count(*)
from controlescolar_bd.dbo.grupos grupos WITH (NOLOCK)
		inner join controlescolar_bd.dbo.horario horario on
	grupos.anio	= horario.anio
and	grupos.periodo	= horario.periodo
and	((grupos.cve_mat = horario.cve_mat and 
	  grupos.gpo = horario.gpo) 
          or 
	 (grupos.cve_asimilada = horario.cve_mat and 
	  grupos.gpo_asimilado = horario.gpo)
	)
			inner join
	(select hor.hora_inicio, hor.hora_final, hor.cve_dia
	 from controlescolar_bd.dbo.horario hor inner join controlescolar_bd.dbo.grupos gru WITH (NOLOCK) on
	 hor.anio = gru.anio and hor.periodo = gru.periodo and (
	 (hor.cve_mat = gru.cve_mat and hor.gpo = gru.gpo) or
	 (hor.cve_mat = gru.cve_asimilada and hor.gpo = gru.gpo_asimilado))
	 where gru.cve_mat = @CVEMAT2 and gru.gpo = @GPO2
	)				as nvo_gpo (hi,hf,cd) on
	horario.cve_dia = nvo_gpo.cd
and	((nvo_gpo.hf > horario.hora_inicio and nvo_gpo.hf < horario.hora_final) or
	 (nvo_gpo.hi > horario.hora_inicio and nvo_gpo.hi < horario.hora_final) or
	 (nvo_gpo.hi = horario.hora_inicio and nvo_gpo.hf = horario.hora_final) or
	 (nvo_gpo.hi = horario.hora_inicio and nvo_gpo.hf > horario.hora_final) or
	 (nvo_gpo.hf = horario.hora_final  and nvo_gpo.hi < horario.hora_inicio) or
	 (nvo_gpo.hi < horario.hora_final  and nvo_gpo.hf > horario.hora_final)
	)
where grupos.cve_mat = @CVEMAT1 and grupos.gpo = @GPO1
IF @ENCIMA <> 0
BEGIN
  SET @msg = 'El horario de la teoría y laboratorio se traslapan.'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
 SELECT 130, @msg
 RETURN 130
END

/*Validar los grupos*/
IF (@ES_LAB = 0 AND @GPOTMP <> @GPOLAB AND @GPOTMP <> '*')
OR (@ES_LAB = 1 AND @GPOTMP <> @GPOTEO AND @GPOTMP <> '*')
BEGIN
 IF @ES_LAB = 0
  SET @msg = 'La materia '+cast(@CVETEO as varchar)+' grupo '+@GPOTEO+' debe inscribirse '+
			 'con el laboratorio '+cast(@CVELAB as varchar)+ ' grupo '+@GPOTMP
 ELSE
  SET @msg = 'El laboratorio '+cast(@CVELAB as varchar)+' grupo '+@GPOLAB+' debe inscribirse '+
  				'con la materia '+cast(@CVETEO as varchar)+' grupo '+@GPOTMP
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 13,@msg
 RETURN 13
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


/*La validación de la existencia de los parámetros se lleva a cabo en sp_srl_validacin_materia_grupo*/
SELECT	@ANIO = anio ,@PERIODO = periodo, 
		@tipo_inscrip = CASE tipo_inscripcion WHEN 1 THEN 'A' WHEN 0 THEN 'I' ELSE '?' END
FROM	controlescolar_bd.dbo.activacion 
WHERE controlescolar_bd.dbo.activacion.tipo_periodo = @VAR_tipo_periodo



EXEC @retorno = controlescolar_bd.dbo.sp_srl_validacion_materia_grupo
 @CUENTA =@CUENTA,
 @MATERIA = @CVETEO,     
 @GRUPO = @GPOTEO,     
 @INSCRIBE = 0,
 @CONMENSAJES = 0,
 @MENSAJE = @msgtmp OUTPUT
IF @retorno <> 0																   
BEGIN
 SET @msg = @msgtmp
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT @retorno,@msg
 RETURN @retorno
END

EXEC @retorno = controlescolar_bd.dbo.sp_srl_validacion_materia_grupo
 @CUENTA =@CUENTA,
 @MATERIA = @CVELAB,     
 @GRUPO = @GPOLAB,     
 @INSCRIBE = 0,
 @CONMENSAJES = 0,
 @MENSAJE  = @msgtmp OUTPUT
IF @retorno <> 0
BEGIN
 SET @msg = @msgtmp
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT @retorno,@msg
 RETURN @retorno
END

IF @INSCRIBE <> 1
BEGIN
 SET @msg = 'Teoría-Laboratorio OK.(Los grupos no se inscribieron.)'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 0, @msg
 RETURN 0
END

BEGIN TRANSACTION
	/*Bloquear registros*/
	SELECT @lrwc = COUNT(*)
	FROM controlescolar_bd.dbo.grupos as gpo WITH(XLOCK,ROWLOCK)
	WHERE ((gpo.cve_mat = @CVETEO AND gpo.gpo = @GPOTEO and  gpo.periodo = @PERIODO and gpo.anio = @ANIO)
	OR	  (gpo.cve_mat = @CVELAB AND gpo.gpo = @GPOLAB and  gpo.periodo = @PERIODO and gpo.anio = @ANIO))
	AND	   gpo.cupo - gpo.inscritos > 0
	
	SELECT @lerr = @@ERROR
	IF @lerr <> 0	--ERROR AL TRATAR DE BLOQUEAR REGISTRO.
	BEGIN
	 ROLLBACK TRANSACTION
	 SET @msg = 'Ha ocurrido un error al inscribir la materia '+convert(varchar,@CVETEO)+' grupo '+@GPOTEO+
	 			' con el laboratorio '+convert(varchar,@CVELAB)+' grupo '+@GPOLAB+
					'. Intente nuevamente.'+' Código:'+convert(varchar,@lerr)
	 IF @CONMENSAJES <> 0 print @msg
	 SET @MENSAJE = @msg
	 SELECT @lerr,@msg
	 RETURN @lerr
	END
	
	IF @lrwc <> 2  --NO SE OBTUVO BLOQUO SOBRE AMBOS REGISTROS, PROBABLEMENTE EL GRUPO SE LLENO
	BEGIN			--MIENTRAS SE HACÍAN LAS VALIDACIONES, PEDIR QUE SE INTENTE NUEVAMENTE.
	 ROLLBACK TRANSACTION
	 SET @msg = 'El cupo de alumnos ha cambiado mientras se procesaba la solicitud. Le pedimos lo intente nuevamente.' + convert(VARCHAR(20), @lrwc)
	 IF @CONMENSAJES <> 0 print @msg
	 SET @MENSAJE = @msg
	 SELECT 300,@msg
	 RETURN 300
	END
	/*Insertar la materia*/
	INSERT INTO controlescolar_bd.dbo.mat_inscritas(cuenta, cve_mat, gpo,   periodo, anio, inscripcion,  cve_condicion)
	VALUES(@CUENTA,@CVETEO,@GPOTEO,@PERIODO,@ANIO,@tipo_inscrip,0)
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SET @msg = 'Ha ocurrido un error al inscribir la materia '+convert(varchar,@CVETEO)+' grupo '+@GPOTEO+
				   ' Código:'+convert(varchar,@lerr)
	    IF @CONMENSAJES <> 0 print @msg
	    SET @MENSAJE = @msg
 		SELECT @lerr,@msg
 		RETURN @lerr
	END
	/*Insertar el laboratorio*/
	INSERT INTO controlescolar_bd.dbo.mat_inscritas(cuenta, cve_mat, gpo,   periodo, anio, inscripcion,  cve_condicion)
	VALUES(@CUENTA,@CVELAB,@GPOLAB,@PERIODO,@ANIO,@tipo_inscrip,0)
	IF @@ERROR <> 0
	BEGIN
		ROLLBACK TRANSACTION
		SET @msg = 'Ha ocurrido un error al inscribir el laboratorio '+convert(varchar,@CVELAB)+' grupo '+@GPOLAB+
				   ' Código:'+convert(varchar,@lerr)
	    IF @CONMENSAJES <> 0 print @msg
	    SET @MENSAJE = @msg
 		SELECT @lerr,@msg
 		RETURN @lerr
	END
COMMIT TRANSACTION
SET @msg = 'La materia Clave: '+convert(varchar,@CVETEO)+' Grupo: '+@GPOTEO+' se inscribió con el laboratorio '+
			'Clave: '+convert(varchar,@CVELAB)+' Grupo: '+@GPOLAB+'.'
IF @CONMENSAJES <> 0 print @msg
SET @MENSAJE = @msg
SELECT 0, @msg
RETURN 0
GO

