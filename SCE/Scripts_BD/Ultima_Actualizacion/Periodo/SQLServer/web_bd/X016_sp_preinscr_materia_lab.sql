USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_preinscr_materia_lab]    Script Date: 8/8/2017 12:56:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_preinscr_materia_lab]
@CUENTA int,
@MATERIA int,     
@GRUPO varchar(2),     
@MATERIA2 int,     
@GRUPO2 varchar(2),     
@CARRERA int,
@PLAN int,
@NIVEL varchar(1)
AS 
DECLARE @TMATERIA integer
DECLARE @CUPO integer
DECLARE @TPREINSCR integer
DECLARE @TPLAN integer
DECLARE @revisa_gpo_bloqueado integer
DECLARE @termino integer 
DECLARE @tmpgpo varchar(2) 
DECLARE @tmpcarrera integer 
DECLARE @bgpo integer 
DECLARE @bcar integer 
DECLARE @tmpplan integer 
DECLARE @PERIODO integer
DECLARE @ANIO integer 
DECLARE @MERROR integer
DECLARE @THIJO integer
DECLARE @retval integer
DECLARE @MENSAJE varchar(254),	@msg varchar(254), @retorno int, @lerr int, @lrwc int
DECLARE @CONMENSAJES integer, @matinscrita integer
DECLARE @cve_parametro integer
DECLARE @permite_materias_repetidas integer
DECLARE @permite_materias_encimadas integer
DECLARE @valida_demanda_inscritos integer
DECLARE @valida_prerrequisitos integer
DECLARE @ll_curso_prerrequisitos integer
DECLARE @ll_resultado integer
DECLARE @inscritos integer
DECLARE @demanda_inscritos integer
DECLARE @proceso_preinsc integer

-- MALH 08/08/2017 -> DECLARE @tipo_periodo varchar(3)  

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
WHERE cuenta = @CUENTA

/* Se recupera el tipo de periodo.*/
SELECT @VAR_tipo_periodo = web_bd.dbo.v_www_plan_estudios.tipo_periodo
FROM web_bd.dbo.v_www_plan_estudios
WHERE web_bd.dbo.v_www_plan_estudios.cve_carrera = @VAR_cve_carrera
AND web_bd.dbo.v_www_plan_estudios.cve_plan = @VAR_cve_plan  
/*****************************************/

SELECT @cve_parametro =cve_parametro, 
       @permite_materias_repetidas = permite_materias_repetidas,
       @permite_materias_encimadas = permite_materias_encimadas,
       -- MALH 08/08/2017 -> @tipo_periodo = tipo_periodo,
	   @valida_demanda_inscritos = valida_demanda_inscritos,
	   @valida_prerrequisitos = valida_prerrequisitos
FROM [controlescolar_bd].[dbo].[parametros_reinscripcion]
WHERE tipo_periodo = @VAR_tipo_periodo -- MALH 08/08/2017 -> WHERE [cve_parametro] = 1

SELECT @proceso_preinsc = proceso_preinsc
FROM [controlescolar_bd].[dbo].[activacion_su]
WHERE [tipo_periodo] = @VAR_tipo_periodo -- MALH 08/08/2017 -> @tipo_periodo


/*Validar la materia.*/
EXEC @retval = web_bd.dbo.sp_preinscr_materia_valida @CUENTA, @MATERIA, @GRUPO, @CARRERA, @PLAN, @NIVEL, @MENSAJE  
IF @retval <> 0
BEGIN
	SET @msg = @MENSAJE
	IF @CONMENSAJES <> 0 print @msg
	SELECT @retval, @msg
	RETURN @retval
END


/*Validar el Laboratorio.*/
EXEC @retval = web_bd.dbo.sp_preinscr_materia_valida @CUENTA, @MATERIA2, @GRUPO2, @CARRERA, @PLAN, @NIVEL, @MENSAJE  
IF @retval <> 0
BEGIN
	SET @msg = @MENSAJE
	IF @CONMENSAJES <> 0 print @msg
	SELECT @retval, @msg
	RETURN @retval
END

--@CUENTA, @MATERIA2, @GRUPO2, @CARRERA, @PLAN, @NIVEL, @MENSAJE


begin transaction Actualiza   

/*Se inserta la teoria*/
SELECT @PERIODO=periodo, @ANIO=anio  
from dbo.v_www_periodo_preinscripcion  

INSERT INTO controlescolar_bd.dbo.mat_preinsc(cuenta, cve_mat, gpo, status, periodo, anio, orden, tipo, proceso_preinsc)
select @CUENTA, @MATERIA,@GRUPO,0,		@PERIODO, @ANIO, max(isnull(orden,0))+1, 1 , @proceso_preinsc
from controlescolar_bd.dbo.mat_preinsc 

SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)
if @MERROR<>0
	BEGIN
		rollback transaction Actualiza 
		select -1, 'Error al insertar la materia en la reinscripcion'
	    return -1
	end

INSERT INTO controlescolar_bd.dbo.movmat_preinsc(cuenta ,cve_mat ,gpo   ,status,periodo, anio ,movimiento)
select @CUENTA,@MATERIA,@GRUPO,0,     @PERIODO,@ANIO,'IN'        

SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)

/*Se inserta el Laboratorio*/ 
INSERT INTO controlescolar_bd.dbo.mat_preinsc(cuenta, cve_mat, gpo, status, periodo, anio, orden, tipo, proceso_preinsc)
select @CUENTA, @MATERIA2,@GRUPO2,0, @PERIODO, @ANIO, max(isnull(orden,0))+1, 1 , @proceso_preinsc
from controlescolar_bd.dbo.mat_preinsc 

SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)
if @MERROR<>0
	BEGIN
		rollback transaction Actualiza 
		select -1, 'Error al insertar la materia en la reinscripcion'
	    return -1
	end

INSERT INTO controlescolar_bd.dbo.movmat_preinsc(cuenta ,cve_mat ,gpo   ,status,periodo, anio ,movimiento)
select @CUENTA,@MATERIA2,@GRUPO2,0,     @PERIODO,@ANIO,'IN'        

SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)



/*Se verifica si */
select @THIJO=COUNT (*) FROM controlescolar_bd.dbo.preinsc 
WHERE cuenta=@CUENTA 
and anio=@ANIO 
and periodo=@PERIODO 

if @THIJO=0
BEGIN

    INSERT INTO controlescolar_bd.dbo.preinsc(cuenta, folio, status, periodo, anio )
    select @CUENTA,(case when  max(folio)> 99999 then max(folio)+1 else 100000 end),2,
    		@PERIODO, @ANIO
	from controlescolar_bd.dbo.preinsc 
	
    SELECT @MERROR=(case when @@ERROR<>0 then @@ERROR else 0 end)
    
END

if @MERROR<>0
	begin
		rollback transaction Actualiza 
	    select -1, 'Error al insertar la materia en la reinscripcion'
	    return -1
	end
else
	begin
		commit transaction Actualiza 
		select 0,'OK'             
	end