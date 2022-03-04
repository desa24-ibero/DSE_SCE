USE controlescolar_bd 
GO




ALTER PROCEDURE [dbo].[sp_validacion_materia_ets]
 @CUENTA int,
 @MATERIA int,     
 @TIPO_EXAMEN int,
 @MENSAJE varchar(254) = '' OUTPUT,
 @INSCRIBE int =1,
 @CONMENSAJES int = 0

AS

DECLARE @CARRERA int, @PLAN int, @NIVEL varchar(1)
DECLARE @existe_grupo varchar(2), @pertenece_plan int, @cursada int, @cupo int, @inscritos int,@matinscrita int
DECLARE @pert_plan_pos int, @cursadapos integer, @retval integer
DECLARE @grupo_carr int
DECLARE	@msg varchar(254), @retorno int, @lerr int, @lrwc int
DECLARE @ANIO int, @PERIODO int, @tipo_inscrip char(1)
DECLARE @GRUPO varchar(2)
DECLARE @area_mat int, @c_mat int, @c_totales int, @lerror int , @lrow int
DECLARE @es_ss int
DECLARE @es_opcion_terminal int
DECLARE @es_cursativa int
DECLARE  @num_veces_cursada int
DECLARE  @total_minimos int
DECLARE  @total_cursados int
DECLARE  @total_faltan  int
DECLARE  @puntaje_min real
DECLARE  @promedio real
DECLARE  @promedio_menos_puntaje real
DECLARE  @cve_subsistema int
DECLARE  @num_mat_inscritas int
DECLARE  @num_reprobadas int
DECLARE  @num_misma_mat_ets_inscrita int
DECLARE  @num_ets_inscritas int
DECLARE  @num_ets_solicitadas int
DECLARE  @cve_mat_ets int
DECLARE  @materia_ets varchar(75)
DECLARE  @tipo_examen_ets int
DECLARE  @tipo_examen_descripcion varchar(30)
DECLARE  @cve_concepto int
DECLARE  @autorizado int
DECLARE  @horas_reales int

SELECT @GRUPO= 'A'
     
--Valores posibles de @TIPO_EXAMEN
--2	EXTRAORDINARIO
--6	TIT. SUFICIENCIA

--Conceptos de Tesorería
--118	EXAMEN EXTRAORDINARIO LICENCIATURA
--119	EXAMEN A TÍTULO DE SUFICIENCIA LICENCIA
--120	EXAMEN EXTRAORDINARIO O A TÍTULO POSGRAD

--Valida el tipo de examen
IF @TIPO_EXAMEN <> 2 AND @TIPO_EXAMEN<>6
BEGIN
	SET @msg = 'EL TIPO DE EXAMEN NO ES VALIDO.'
	IF @CONMENSAJES <> 0 print @msg
	SET @MENSAJE = @msg
	SELECT 1,@msg
	RETURN 1
END 

--Si es Extraordinario
IF @TIPO_EXAMEN  =2 
BEGIN
	SELECT @tipo_examen_descripcion = ' Extraordinario '
END

--Si es a Título de Suficiencia
IF @TIPO_EXAMEN  = 6
BEGIN
	SELECT @tipo_examen_descripcion = ' Título de Suficiencia '
END



--LEER LOS PARÁMETROS DE CARRERA,PLAN,NIVEL DE ACADÉMICOS
SELECT @CARRERA= cve_carrera, @PLAN = cve_plan, @NIVEL = nivel
FROM controlescolar_bd.dbo.academicos
WHERE cuenta = @CUENTA

SET @lrwc = @@ROWCOUNT

--No se encontraron registros de información académica
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

--Cuenta las materias inscritas del alumno
SELECT @num_mat_inscritas =count(cve_mat)
FROM controlescolar_bd.dbo.mat_inscritas
WHERE cuenta = @CUENTA

SET @lrwc = @@ROWCOUNT

--No se encontraron registros de materias inscritas
IF @lrwc = 0 OR @lrwc IS NULL
BEGIN

 SET @msg = 'No ha sido posible consultar las materias inscritas.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 1,@msg
 RETURN 1
END

--Si es Extraordinario
--Asigna el concepto en base al Nivel de Estudios
IF @TIPO_EXAMEN  =2 
BEGIN
	IF @NIVEL <> 'P'
	BEGIN
		SELECT @cve_concepto = 118
	END
	ELSE
	BEGIN
		SELECT @cve_concepto = 120
	END
END

--Si es A Título
--Asigna el concepto en base al Nivel de Estudios
IF @TIPO_EXAMEN  = 6
BEGIN
	IF @NIVEL <> 'P'
	BEGIN
		SELECT @cve_concepto = 119
	END
	ELSE
	BEGIN
		SELECT @cve_concepto = 120
	END
END

--Si es Extraordinario y NO tiene Materias Inscritas va contra el reglamento
IF @TIPO_EXAMEN = 2 AND @num_mat_inscritas=0
BEGIN
	SET @msg = 'Es necesario estar inscrito para solicitar un Examen Extraordinario.'
	IF @CONMENSAJES <> 0 print @msg
	SET @MENSAJE = @msg
	SELECT 1,@msg
	RETURN 1
END 

--Si es A Título de Suficiencia y TIENE Materias Inscritas va contra el reglamento
IF @TIPO_EXAMEN = 6 AND @num_mat_inscritas>=1
BEGIN
	SET @msg = 'Es necesario NO estar inscrito para solicitar un Examen a Título de Suficiencia.'
	IF @CONMENSAJES <> 0 print @msg
	SET @MENSAJE = @msg
	SELECT 1,@msg
	RETURN 1
END 

--Se toma la información de la revisión de estudios reciente
SELECT @total_minimos = total_minimos,
		@total_cursados = total_minimos,
		@total_faltan = total_faltan,
		@puntaje_min = puntaje_min,
		@promedio = promedio,
		@promedio_menos_puntaje = promedio_menos_puntaje,
		@cve_subsistema = cve_subsistema
FROM controlescolar_bd.dbo.v_revision_de_estudios
WHERE cuenta = @CUENTA
AND cve_carrera = @CARRERA
AND cve_plan = @PLAN

SET @lrwc = @@ROWCOUNT

--No se encontraron registros de la revisión de estudios 
IF @lrwc = 0 OR @lrwc IS NULL
BEGIN
 SET @msg = 'El alumno con cuenta: '+cast(ISNULL(@CUENTA,0) as varchar)
 						+' carrera: '+cast(ISNULL(@CARRERA,0) as varchar)
 						+' plan: '+cast(ISNULL(@PLAN,0) as varchar)
 						+' nivel: '+ISNULL(@NIVEL,'NULO')+ ' no cuenta con revision de estudios.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 1,@msg
 RETURN 1
END


--Obtiene información de la materia que se solicita Inscribir
SELECT	
		@pertenece_plan = ISNULL(mat_prerrequisito.cve_mat,0),
		@pert_plan_pos	= ISNULL(mat_prerreq_pos.cve_mat,0),
		@cursada		= ISNULL(historico.cve_mat,0),
		@matinscrita	= ISNULL(mat_inscritas.cve_mat,0),
		@horas_reales   = ISNULL(materias.horas_reales,0)
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
				
			LEFT OUTER JOIN controlescolar_bd.dbo.historico historico ON
				historico.cve_mat		= materias.cve_mat
			AND	historico.cve_plan		= @PLAN
			AND	historico.cve_carrera	= @CARRERA
			AND ltrim(rtrim(historico.calificacion)) IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
			AND @NIVEL IN (SELECT cve_nivel FROM nivel)
			AND historico.cuenta			= @CUENTA
	
			LEFT OUTER JOIN controlescolar_bd.dbo.mat_inscritas mat_inscritas ON
				materias.cve_mat		= mat_inscritas.cve_mat
			AND mat_inscritas.cuenta	= @CUENTA
WHERE materias.cve_mat = @MATERIA

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
SET @msg = 'Consulta de materia Filas: '+cast(@lrwc as varchar)+' Error: '+cast(@lerr as varchar)
IF @CONMENSAJES <> 0 print @msg

--Si no fue posible consultar la información de la materia
IF @lerr <> 0
BEGIN
 SET @MENSAJE = @msg
 SELECT @lerr,'Error en consulta para recuperar información. Código:'+convert(varchar,@lerr)
 RETURN @lerr
END

IF @lrwc = 0 --2, LA MATERIA NO EXISTE
BEGIN
 SET @msg = 'La materia no existe'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 10, @msg
 RETURN 10
END

IF @NIVEL <> 'P'
BEGIN
 IF @pertenece_plan = 0 --3, LA MATERIA NO PERTENECE AL PLAN
 BEGIN
  SET @msg = 'La materia no pertenece al plan de estudios'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
  SELECT 20, @msg
  RETURN 20
 END
END

IF @NIVEL = 'P'
BEGIN
 IF @pert_plan_pos = 0 --3, LA MATERIA NO PERTENECE AL PLAN
 BEGIN
  SET @msg = 'La materia no pertenece al plan de estudios'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
  SELECT 20, @msg
  RETURN 20
 END
END

IF @cursada > 0  --4, LA MATERIA YA FUÉ CURSADA
BEGIN
 SET @msg = 'La materia ya fue cursada y aprobada'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 30, @msg
 RETURN 30
END

--Cuenta las veces que se ha reprobado la materia, excluyendo las Bajas Académicas
select @num_reprobadas = count(h.cve_mat) 
from historico h, materias m
where h.cuenta = @CUENTA
and h.cve_carrera = @CARRERA
and h.cve_plan = @PLAN
and h.cve_mat = m.cve_mat
and h.calificacion not in ('6','7','8','9','10','AC','MB','B','S','RE','E','BA')
and h.cve_mat = @MATERIA

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
SET @msg = 'Consulta de materia Filas: '+cast(@lrwc as varchar)+' Error: '+cast(@lerr as varchar)
IF @CONMENSAJES <> 0 print @msg

--Si no fue posible consultar el historico
IF @lerr <> 0
BEGIN
	SET @MENSAJE = @msg
	SELECT @lerr,'Error en consulta para recuperar información. Código:'+convert(varchar,@lerr)
	RETURN @lerr
END

-- Si es extraordinario debe haberla reprobado
IF @TIPO_EXAMEN= 2 AND @num_reprobadas=0
BEGIN
	SET @msg = 'Si la materia no ha sido reprobada, no puede inscribirse a Extraordinario'
	IF @CONMENSAJES <> 0 print @msg
	SET @MENSAJE = @msg
	SELECT 30, @msg
	RETURN 30
END 
-- Si es a titulo debe inscribirla sin haberla reprobado
IF @TIPO_EXAMEN= 6 AND @num_reprobadas>=1
BEGIN
	SET @msg = 'Si la materia ha sido reprobada, no puede inscribirse a Título de suficiencia'
	IF @CONMENSAJES <> 0 print @msg
	SET @MENSAJE = @msg
	SELECT 30, @msg
	RETURN 30
END


IF @matinscrita > 0 --5, LA MATERIA YA ESTÁ INSCRITA
BEGIN
 SET @msg = 'La materia ya está inscrita como normal, en proceso de cursarse.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 40, @msg
 RETURN 40
END 


IF @NIVEL <> 'P'
BEGIN
--Efectúa la validación para que cumpla con los prerrequisitos
 EXEC @retval = controlescolar_bd.dbo.sp_ets_validacion_prerequisitos @CUENTA, @MATERIA, @CARRERA, @PLAN,@CONMENSAJES
 IF @retval <> 0
 BEGIN
  SET @msg = 'El alumno no cuenta con los prerequisitos necesarios.'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
  SELECT 90, @msg
  RETURN 90
 END

--Obtiene si la materia es cursativa
	SELECT TOP 1 @es_cursativa = isnull(mp.cursativa,1)
	FROM controlescolar_bd.dbo.mat_prerrequisito as mp
	WHERE mp.cve_mat	= @MATERIA
	AND mp.cve_plan	= @PLAN
	AND mp.cve_carrera	= @CARRERA

	SELECT @lerror = @@ERROR, @lrow = @@ROWCOUNT

--Si no es posible consultar si es cursativa
	IF @lerror <> 0
	BEGIN
	IF @CONMENSAJES <> 0 print 'Ha ocurrido un error en la consulta mat_prerrequisito. Código: '+cast(@lerror as varchar)
		RETURN @lerror
	END

--Es una materia cursativa
	IF @es_cursativa = 1
	BEGIN
		SET @msg = 'No está permitido inscribir materias cursativas.'
		IF @CONMENSAJES <> 0 print @msg
		SET @MENSAJE = @msg
--Las materias cursativas entrarán como solicitudes, no como materias inscritas
		--SELECT 777, @msg
		--RETURN 777
	END
END


IF @NIVEL = 'P'
BEGIN
--Efectúa la validación para que cumpla con los prerrequisitos
 EXEC @retval = controlescolar_bd.dbo.sp_ets_validacion_prerequisitos_pos @CUENTA, @MATERIA, @CARRERA, @PLAN,@CONMENSAJES
 IF @retval <> 0
 BEGIN
  SET @msg = 'El alumno no cuenta con los prerequisitos necesarios.'
  IF @CONMENSAJES <> 0 print @msg
  SET @MENSAJE = @msg
  SELECT 90, @msg
  RETURN 90
 END

--Obtiene si la materia es cursativa
	SELECT TOP 1 @es_cursativa = isnull(mp.cursativa,1)
	FROM controlescolar_bd.dbo.mat_prerreq_pos as mp
	WHERE mp.cve_mat	= @MATERIA
	AND mp.cve_plan	= @PLAN
	AND mp.cve_carrera	= @CARRERA

--Si no es posible consultar si es cursativa
	SELECT @lerror = @@ERROR, @lrow = @@ROWCOUNT
	IF @lerror <> 0
	BEGIN
	IF @CONMENSAJES <> 0 print 'Ha ocurrido un error en la consulta mat_prerrequisito. Código: '+cast(@lerror as varchar)
		RETURN @lerror
	END

--Es una materia cursativa
	IF @es_cursativa = 1 
	BEGIN
		SET @msg = 'No está permitido inscribir materias cursativas.'
		IF @CONMENSAJES <> 0 print @msg
		SET @MENSAJE = @msg
--Las materias cursativas entrarán como solicitudes, no como materias inscritas
--		SELECT 777, @msg
--		RETURN 777
	END
END 

--Cuenta las veces que esta materia ha sido cursada a Extraordinario o Titulo
SELECT @num_veces_cursada =count(*)
FROM	dbo.historico
WHERE dbo.historico.cuenta = @CUENTA
AND   dbo.historico.cve_mat = @MATERIA
AND	dbo.historico.cve_carrera = @CARRERA
AND	dbo.historico.cve_plan = @PLAN
AND	dbo.historico.observacion in (2,6)


SELECT @lerror = @@ERROR, @lrow = @@ROWCOUNT
--No es posible consultar las veces que se ha cursado a Extraordinario o Titulo
IF @lerror <> 0
BEGIN
IF @CONMENSAJES <> 0 print 'Ha ocurrido un error en la consulta historico. Código: '+cast(@lerror as varchar)
	RETURN @lerror
END

--Es una materia cursativa y ya se ha inscrito más de 2 veces a extraordinario o a título
IF @num_veces_cursada >= 2 AND @es_cursativa = 1
BEGIN
	SET @msg = 'No está permitido inscribir materias cursativas cuando ya ha sido dispensada 2 veces anteriores.'
	IF @CONMENSAJES <> 0 print @msg
	SET @MENSAJE = @msg
	SELECT 150, @msg
	RETURN 150
END


--¿¿Es materia de Integración??
SELECT	TOP 1 @area_mat	=	area_mat.cve_area,
			  @c_mat	=	materias.creditos			  
FROM	area_mat, materias
WHERE	materias.cve_mat = area_mat.cve_mat
AND		area_mat.cve_mat = @MATERIA
AND		area_mat.cve_area  IN (2200, 2201, 2202, 2203, 2204, 2205)

SELECT @lerror = @@ERROR, @lrow = @@ROWCOUNT
--No es posible consultar si es de Integración
IF @lerror <> 0
BEGIN
 IF @CONMENSAJES <> 0 print 'Ha ocurrido un error en la consulta del área de materia de Integración. Código: '+cast(@lerror as varchar)
 RETURN @lerror
END

--Es una materia de integración
IF @lrow >= 1
BEGIN
 SET @msg = 'La materia '+cast(@MATERIA as varchar)+' es de Integración y sólo se puede cursar de manera ordinaria. No hay dispensas de cursatividad.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 140, @msg
 RETURN 140
END


--¿¿Es materia de Reflexión Universitaria??
SELECT	TOP 1 @area_mat	=	area_mat.cve_area,
			  @c_mat	=	materias.creditos			  
FROM	area_mat, materias
WHERE	materias.cve_mat = area_mat.cve_mat
AND		area_mat.cve_mat = @MATERIA
AND		area_mat.cve_area  IN (8061, 8062, 8063, 8064)

SELECT @lerror = @@ERROR, @lrow = @@ROWCOUNT
--No es posible consultar si es de Integración
IF @lerror <> 0
BEGIN
 IF @CONMENSAJES <> 0 print 'Ha ocurrido un error en la consulta del área de materia de Reflexión Universitaria. Código: '+cast(@lerror as varchar)
 RETURN @lerror
END

--Es una materia de integración
IF @lrow >= 1
BEGIN
 SET @msg = 'La materia '+cast(@MATERIA as varchar)+' es de Reflexión Universitaria y sólo se puede cursar de manera ordinaria. No hay dispensas de cursatividad.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 140, @msg
 RETURN 140
END



--¿¿Es materia de Servicio Social??
SELECT	@es_ss = count(*)
FROM	controlescolar_bd.dbo.area_mat area_mat
WHERE	area_mat.cve_area in (	select	plan_estudios.cve_area_servicio_social
								from	controlescolar_bd.dbo.plan_estudios plan_estudios
								where	plan_estudios.cve_carrera = @CARRERA
								and		plan_estudios.cve_plan = @PLAN)
AND area_mat.cve_mat = @MATERIA

SELECT	@lerror = @@ERROR, @lrow = @@ROWCOUNT
--No es posible consultar si es de Servicio Social
IF @lerror <> 0
BEGIN
 IF @CONMENSAJES <> 0 print 'Error en consulta del área de la materia y plan de estudios del Servicio Social. Código:'+convert(varchar,@lerror)
 RETURN @lerror
END

--Es una materia de servicio social
IF @es_ss >= 1
BEGIN
 SET @msg = 'La materia '+cast(@MATERIA as varchar)+' es el Servicio Social y sólo se puede cursar de manera ordinaria. No hay dispensas de cursatividad.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 150, @msg
 RETURN 150
END

--¿¿Es materia de Opcion Terminal??

IF @NIVEL <> 'P'
BEGIN
	SELECT	@es_opcion_terminal = count(*)
	FROM	controlescolar_bd.dbo.aux_opcion_terminal area_mat
	WHERE	area_mat.cve_area in (	select	plan_estudios.cve_area_opcion_terminal
								from	controlescolar_bd.dbo.plan_estudios plan_estudios
								where	plan_estudios.cve_carrera = @CARRERA
								and		plan_estudios.cve_plan = @PLAN)
	AND area_mat.cve_proyecto_opc_term = @MATERIA
END
ELSE IF @NIVEL = 'P'
BEGIN
	SELECT	@es_opcion_terminal = count(*)
	FROM	controlescolar_bd.dbo.area_mat area_mat
	WHERE	area_mat.cve_area in (	select	plan_estudios.cve_area_opcion_terminal
								from	controlescolar_bd.dbo.plan_estudios plan_estudios
								where	plan_estudios.cve_carrera = @CARRERA
								and		plan_estudios.cve_plan = @PLAN)
	AND area_mat.cve_mat = @MATERIA
END


	SELECT	@lerror = @@ERROR, @lrow = @@ROWCOUNT
--No es posible consultar si es Opcion Terminal
	IF @lerror <> 0
	BEGIN
		IF @CONMENSAJES <> 0 print 'Error en consulta del área de la materia y plan de estudios de la Opción Terminal. Código:'+convert(varchar,@lerror)
		RETURN @lerror
	END

--Es una materia de Opcion Terminal
	IF @es_opcion_terminal >= 1
	BEGIN
		SET @msg = 'La materia '+cast(@MATERIA as varchar)+' es el Proyecto de Opción Terminales y sólo se puede cursar de manera ordinaria. No hay dispensas de cursatividad.'
		IF @CONMENSAJES <> 0 print @msg
		SET @MENSAJE = @msg
		SELECT 150, @msg
		RETURN 150
	END



--Obtiene la información de los parámetros de la inscripción, para saber cómo inscribir las solicitudes
SELECT @ANIO = anio ,@PERIODO = periodo, @tipo_inscrip = CASE tipo_inscripcion WHEN 1 THEN 'A' WHEN 0 THEN 'I' ELSE '?' END
FROM	controlescolar_bd.dbo.activacion

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
--No es posible consultar los parámetros de activación
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


--Verifica si la misma materia ya está inscrita a Extraordinario o a Titulo de Suficiencia
SELECT TOP 1 @cve_mat_ets = eetw.cve_mat, 
             @materia_ets = materias.materia,  
             @tipo_examen_ets = eetw.tipo_examen
FROM controlescolar_bd.dbo.examen_extrao_titulo eetw,   
         controlescolar_bd.dbo.materias   materias
WHERE ( eetw.cve_mat =materias.cve_mat ) and  
         ( ( eetw.cuenta = @CUENTA ) and
			( eetw.periodo = @PERIODO ) and
			( eetw.anio = @ANIO )and
            ( eetw.cve_mat = @MATERIA ) )        

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
--No es posible consultar si ya está inscrita a Extraordinario o a Titulo de Suficiencia
IF @lerr <> 0
BEGIN
 SET @msg = 'Error en consulta de preexistencia de examen_extrao_titulo 1. Código:'+convert(varchar,@lerr)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT @lerr,@msg
 RETURN @lerr
END

IF @lrwc >= 1 --La materia elegida ya está inscrita a Extraordinario o a Titulo de Suficiencia
BEGIN
 SET @msg = 'La materia '+cast(@MATERIA as varchar)+' '+@materia_ets +' ya está inscrita a'+@tipo_examen_descripcion
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 20,@msg
 RETURN 20
END

---Verifica si la misma materia ya está como solicitada
SELECT TOP 1 @cve_mat_ets = eetw.cve_mat, 
             @materia_ets = materias.materia,  
             @tipo_examen_ets = eetw.tipo_examen
FROM controlescolar_bd.dbo.examen_extrao_titulo_sol eetw,   
         controlescolar_bd.dbo.materias   materias
WHERE ( eetw.cve_mat =materias.cve_mat ) and  
         ( ( eetw.cuenta = @CUENTA ) and
			( eetw.periodo = @PERIODO ) and
			( eetw.anio = @ANIO )and
            ( eetw.cve_mat = @MATERIA ) )        

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
--No es posible consultar si ya está como solicitada a Extraordinario o a Titulo de Suficiencia

IF @lerr <> 0
BEGIN
 SET @msg = 'Error en consulta de preexistencia de examen_extrao_titulo_sol 2. Código:'+convert(varchar,@lerr)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT @lerr,@msg
 RETURN @lerr
END

IF @lrwc >= 1 --La materia elegida ya está solicitada para autorización
BEGIN
 SET @msg = 'La materia '+cast(@MATERIA as varchar)+' '+@materia_ets +' ya está solicitada para autorización a'+@tipo_examen_descripcion
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 20,@msg
 RETURN 20
END

--Cuenta el número de materias solicitadas a Extraordinario o a Titulo de Suficiencia
SELECT  @num_ets_solicitadas = count(cuenta)
   FROM dbo.examen_extrao_titulo_sol,   
         dbo.materias  
   WHERE ( dbo.examen_extrao_titulo_sol.cve_mat = dbo.materias.cve_mat ) and  
         ( ( dbo.examen_extrao_titulo_sol.cuenta = @CUENTA ) and
			( dbo.examen_extrao_titulo_sol.periodo = @PERIODO ) and
			( dbo.examen_extrao_titulo_sol.anio = @ANIO ) )    

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
--No es posible consultar si ya está como inscrita a Extraordinario o a Titulo de Suficiencia
IF @lerr <> 0
BEGIN
 SET @msg = 'Error en cuenta de examen_extrao_titulo solicitud 2. Código:'+convert(varchar,@lerr)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT @lerr,@msg
 RETURN @lerr
END

--Deja inscribir
--IF @num_ets_inscritas <1
--BEGIN
--END

--Solo si tiene el puntaje de calidad
--IF @num_ets_solicitadas =1

--Si es Extraordinario y Solo si tiene el puntaje de calidad
IF @TIPO_EXAMEN = 2 AND @num_ets_solicitadas = 1
BEGIN
--Si No Tiene el puntaje de calidad no se le permite inscribir dos materias
	IF @promedio_menos_puntaje <1 
	BEGIN
		 SET @msg = 'Solo se permite solicitar un máximo de dos materias cuando se tiene arriba de '+cast(@puntaje_min +1 as varchar)+' de promedio.'
		IF @CONMENSAJES <> 0 print @msg
		SET @MENSAJE = @msg
		SELECT 20,@msg
		RETURN 20
	END
END

--Ya no es posible por haber inscrito 2 o más
IF @num_ets_solicitadas >=2
BEGIN
 SET @msg = 'Solo se permite solicitar un máximo de dos materias por periodo.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 20,@msg
 RETURN 20
END

--
--Cuenta el número de materias ya inscritas a Extraordinario o a Titulo de Suficiencia
SELECT  @num_ets_inscritas = count(cuenta)
   FROM dbo.examen_extrao_titulo,   
         dbo.materias  
   WHERE ( dbo.examen_extrao_titulo.cve_mat = dbo.materias.cve_mat ) and  
         ( ( dbo.examen_extrao_titulo.cuenta = @CUENTA ) and
			( dbo.examen_extrao_titulo.periodo = @PERIODO ) and
			( dbo.examen_extrao_titulo.anio = @ANIO ) )    

SELECT @lerr = @@ERROR, @lrwc = @@ROWCOUNT
--No es posible consultar si ya está como inscrita a Extraordinario o a Titulo de Suficiencia
IF @lerr <> 0
BEGIN
 SET @msg = 'Error en cuenta de examen_extrao_titulo inscritas 2. Código:'+convert(varchar,@lerr)
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT @lerr,@msg
 RETURN @lerr
END

--Deja inscribir
--IF @num_ets_inscritas <1
--BEGIN
--END

--Solo si tiene el puntaje de calidad
--IF @num_ets_inscritas =1

--Si es Extraordinario y Solo si tiene el puntaje de calidad
IF @TIPO_EXAMEN = 2 And @num_ets_inscritas =1
BEGIN
--Si No Tiene el puntaje de calidad no se le permite inscribir dos materias
	IF @promedio_menos_puntaje <1 
	BEGIN
		 SET @msg = 'Solo se permite inscribir un máximo de dos materias cuando se tiene arriba de '+cast(@puntaje_min +1 as varchar)+' de promedio.'
		IF @CONMENSAJES <> 0 print @msg
		SET @MENSAJE = @msg
		SELECT 20,@msg
		RETURN 20
	END
END

--Ya no es posible por haber inscrito 2 o más
IF @num_ets_inscritas >=2
BEGIN
 SET @msg = 'Solo se permite inscribir un máximo de dos materias por periodo.'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 20,@msg
 RETURN 20
END


--***
-- Ejecución de procedimiento o query de tesoreria que consulta asocia_pagos_servicios y asocia_pagos_servicios_web 
-- para validar si se han pagado las horas correspondientes a lo solicitado
-- Incluir la llamada aqui, donde aún no se ha insertado la materia 


IF @INSCRIBE <> 1
BEGIN
 SET @msg = 'Grupo Ok.(el grupo no se inscribió)'
 IF @CONMENSAJES <> 0 print @msg
 SET @MENSAJE = @msg
 SELECT 0, @msg
 RETURN 0
END

--Si la materia NO es cursativa, de entrada estará autorizada academicamente
IF @es_cursativa = 0 
BEGIN
	SELECT @autorizado = 1
END
--Si la materia ES cursativa, de entrada deberá ser autorizada por el coordinador
IF @es_cursativa = 1
BEGIN
	SELECT @autorizado = 0
END

/*Empieza transacción, bloquear el registro del grupo desde la lectura, para evitar modificaciones*/
BEGIN TRANSACTION
	IF @es_cursativa = 0 or @es_cursativa = 1
--	BEGIN
--		INSERT INTO controlescolar_bd.dbo.examen_extrao_titulo 
--          (	cuenta  , cve_mat , gpo   , periodo , anio , tipo_examen , cve_condicion )
--		VALUES( @CUENTA , @MATERIA, @GRUPO, @PERIODO, @ANIO, @TIPO_EXAMEN, 0)
--	END
--	ELSE
--Debido a que ahora el trámite dependerá del pago y de la aprobación del coordinador
--Invariablemente se insertará como solicitud
	BEGIN
			INSERT INTO controlescolar_bd.dbo.examen_extrao_titulo_sol  
		      (	cuenta  , cve_mat , gpo   , periodo , anio , tipo_examen , cve_condicion, autorizado, cve_concepto, num_horas)
			VALUES( @CUENTA , @MATERIA, @GRUPO, @PERIODO, @ANIO, @TIPO_EXAMEN, 0, @autorizado, @cve_concepto, @horas_reales)
	END
	--INSERT INTO controlescolar_bd.dbo.mat_inscritas(cuenta, cve_mat, gpo,   periodo, anio, inscripcion,  cve_condicion)
	--VALUES(@CUENTA,@MATERIA,@GRUPO,@PERIODO,@ANIO,@tipo_inscrip,0)
	IF @@ERROR <> 0
--	IF 2 <> 0
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

--***
-- Ejecución de procedimiento de tesoreria que mueve informacion de asocia_pagos_servicios y asocia_pagos_servicios_web de: 
-- Pendiente a En Tramite-Proceso
-- Incluir la llamada aqui, donde ya se insertó la materia y añadir un mensaje que informe sobre la aplicación del servicio

SELECT 0, @msg
RETURN 0


GO

