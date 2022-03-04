USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_consulta_registro_fallos]    Script Date: 9/8/2017 15:52:06 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_consulta_registro_fallos] @cuenta int = null, @digito varchar(2) = null, @folio int = null, @red varchar(25) = null
AS

   declare

      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
	  @max int,
	  @ErrorVariable INT,
	  @RowCountVariable INT,
	  @ErrorText varchar(8000),
	  @periodo integer,
	  @anio integer
	DECLARE @VAR_inscripcion_activa INTEGER
	DECLARE @VAR_minutos_tolerancia INTEGER
	DECLARE @VAR_envia_mensaje_completo INTEGER
	DECLARE @VAR_consulta_adeudos_en_linea INTEGER
	DECLARE @VAR_cuenta INTEGER 
	DECLARE @VAR_digito varchar(2)
	DECLARE @VAR_nombre_completo varchar(255) 
	DECLARE @VAR_cve_carrera INTEGER
	DECLARE @VAR_carrera varchar(255) 
	DECLARE @VAR_cve_plan INTEGER
	DECLARE @VAR_nombre_plan varchar(255) 
	DECLARE @VAR_num_folios_registrados INTEGER
	DECLARE @VAR_separador VARCHAR(2)
	DECLARE @VAR_mensaje_completo VARCHAR(8000)
	DECLARE @VAR_codigo_completo VARCHAR(8000)
	DECLARE @VAR_num_alumnos INTEGER
	DECLARE @VAR_indice_fin_sub_red INTEGER
	DECLARE @VAR_sub_red varchar(25) 
	DECLARE @VAR_todas_redes varchar(25) 
	DECLARE @VAR_num_redes varchar(25) 
	DECLARE @VAR_password varchar(8) 

	/*****************************************/
	-- MALH 08/08/2017
	/*Se recupera el tipo de periodo asocuado al plan de estudios de la cuenta*/
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

      IF  @cuenta IS NULL
	  BEGIN
 			SELECT -1,'FAVOR DE ESCRIBIR UN NUMERO DE CUENTA DE UN ALUMNO'
			RETURN -1
	  END

      IF  @digito  IS NULL
	  BEGIN
 			SELECT -1,'FAVOR DE ESCRIBIR EL DÍGITO DE UN ALUMNO'
			RETURN -1
	  END
      IF  @folio IS NULL
	  BEGIN
 			SELECT -1,'FAVOR DE ESCRIBIR UN NUMERO FOLIO LIGADO A UN NUMERO DE CUENTA DE UN ALUMNO'
			RETURN -1
	  END
      IF  @red IS NULL
	  BEGIN
 			SELECT -1,'FAVOR DE ESCRIBIR UNA DIRECCION IP PARA VALIDAR EL ACCESO'
			RETURN -1
	  END

SELECT @VAR_separador ='|'
SELECT @VAR_mensaje_completo =''
SELECT @VAR_codigo_completo =''
SELECT @VAR_envia_mensaje_completo =1
SELECT @VAR_consulta_adeudos_en_linea=1
SELECT @ErrorVariable=0
SELECT @ErrorText=''

--print 'VALIDA PARAMETROS DEL SP'

	SELECT  @VAR_inscripcion_activa = isnull(inscripcion_activa,0),   
		    @VAR_minutos_tolerancia = isnull(minutos_tolerancia,30),   
			@VAR_envia_mensaje_completo = isnull(envia_mensaje_completo,1),  
			@VAR_consulta_adeudos_en_linea = isnull(consulta_adeudos_en_linea,1)  
	FROM controlescolar_bd.dbo.parametros_servicios
	WHERE tipo_periodo = @VAR_tipo_periodo -- MALH 08/08/2017 -> SE AGREGA CONDICION "WHERE"

	SELECT @ErrorVariable = @@ERROR
	SELECT @RowCountVariable = @@ROWCOUNT
-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 
	IF @ErrorVariable <> 0 
	BEGIN
		SELECT @ErrorText =text 
		FROM sys.messages
		WHERE message_id = @ErrorVariable
		SELECT @ErrorVariable, @ErrorText		
		RETURN @ErrorVariable
	END

--Si no existen estos parametros no es posible continuar
	IF @RowCountVariable = 0
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -1,'NO SE ENCUENTRA INFORMACIÓN DE LOS PARAMETROS DE SERVICIOS PARA EL ALUMNO'
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE ENCUENTRA INFORMACIÓN DE LOS PARAMETROS DE SERVICIOS PARA EL ALUMNO'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
		END
	END 

--print 'LEE PARAMETROS - MENSAJE COMPLETO:' +CONVERT(VARCHAR(20),@VAR_envia_mensaje_completo)

--Validación del alumno y dígito

--	SELECT  @VAR_cuenta =al.cuenta, 
--			@VAR_digito = d.digito, 
--			@VAR_nombre_completo = al.nombre_completo, 
--			@VAR_cve_carrera = ac.cve_carrera, 
--			@VAR_carrera = c.carrera, 
--			@VAR_cve_plan = np.cve_plan, 
--			@VAR_nombre_plan = np.nombre_plan

	SELECT @VAR_num_alumnos = COUNT(al.cuenta)
	FROM v_www_alumno_digito d, controlescolar_bd.dbo.alumnos al, controlescolar_bd.dbo.academicos ac, 
	controlescolar_bd.dbo.carreras c,  controlescolar_bd.dbo.nombre_plan np
	WHERE d.cuenta = al.cuenta
	AND   d.cuenta = ac.cuenta
	AND   ac.cve_carrera = c.cve_carrera
	AND   ac.cve_plan = np.cve_plan
	AND   d.cuenta = @cuenta
	AND	  d.digito = @digito

	SELECT @ErrorVariable = @@ERROR
	SELECT @RowCountVariable = @@ROWCOUNT


-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 
	IF @ErrorVariable <> 0 
	BEGIN
		SELECT @ErrorText =text 
		FROM sys.messages
		WHERE message_id = @ErrorVariable
		SELECT @ErrorVariable, @ErrorText
		RETURN @ErrorVariable*-1
	END

--Si no existe información es porque el alumno o el dígito son incorrectos
	IF @RowCountVariable = 0 or @VAR_num_alumnos<=0
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -1,'EL NUMERO DE CUENTA O EL DÍGITO NO CORRESPONDEN A UN ALUMNO VALIDO'
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL NUMERO DE CUENTA O EL DÍGITO NO CORRESPONDEN A UN ALUMNO VALIDO'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
		END
	END 

--print 'CUENTA:' +CONVERT(VARCHAR(20),@cuenta)
--print 'DIGITO:' +@digito
--print 'FOLIO:' +CONVERT(VARCHAR(20),@folio)
--print 'RowCountVariable:'+CONVERT(VARCHAR(20),@RowCountVariable)
--print 'ErrorVariable:'+CONVERT(VARCHAR(20),@ErrorVariable)

	SELECT @VAR_num_folios_registrados = count(frf.cuenta) 
	FROM web_bd.dbo.folio_registro_fallos frf, web_bd.dbo.v_www_alumno_digito d, web_bd.dbo.v_www_periodo_mat_inscritas pmi
	WHERE frf.cuenta = d.cuenta
	AND frf.periodo = pmi.periodo
	AND frf.anio = pmi.anio
	AND frf.cuenta = @cuenta
	AND frf.folio = @folio

	SELECT @ErrorVariable = @@ERROR
	SELECT @RowCountVariable = @@ROWCOUNT

-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 
	IF @ErrorVariable <> 0 
	BEGIN
		SELECT @ErrorText =text 
		FROM sys.messages
		WHERE message_id = @ErrorVariable
		SELECT @ErrorVariable, @ErrorText
		RETURN @ErrorVariable*-1
	END

PRINT 'FOLIOS REGISTRADOS:' +CONVERT(VARCHAR(20),@VAR_num_folios_registrados)

--Si no existe información es porque el alumno no ha registrado un fallo para ser atendido
	IF @RowCountVariable = 0 OR @VAR_num_folios_registrados  = 0
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -1,'EL NUMERO DE CUENTA DEL ALUMNO ['+CONVERT(VARCHAR(20),@cuenta)+'-'+@digito+'] NO HA REGISTRADO EL FOLIO['+CONVERT(VARCHAR(20),@folio)+'] PARA SER ATENDIDO'
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL NUMERO DE CUENTA DEL ALUMNO ['+CONVERT(VARCHAR(20),@cuenta)+'-'+@digito+'] NO HA REGISTRADO EL FOLIO ['+CONVERT(VARCHAR(20),@folio)+'] PARA SER ATENDIDO'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
		END
	END 
	
	SELECT @VAR_todas_redes = 'TODAS'
	SELECT @VAR_indice_fin_sub_red = charindex('.',@red, charindex('.',@red, charindex('.',@red)+1)+1)
	SELECT @VAR_sub_red = SUBSTRING ( @red , 1 , @VAR_indice_fin_sub_red -1 )+'%'

print '@VAR_todas_redes:' +@VAR_todas_redes
print '@VAR_indice_fin_sub_red:' +CONVERT(VARCHAR(20),@VAR_indice_fin_sub_red)
print '@VAR_sub_red:' +@VAR_sub_red


	select @VAR_num_redes = count(red)
	from redes_registro_fallos
	where red = @red
	--or    red like @VAR_sub_red
	--or    red like 'TODAS'

	SELECT @ErrorVariable = @@ERROR
	SELECT @RowCountVariable = @@ROWCOUNT

-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 
	IF @ErrorVariable <> 0 
	BEGIN
		SELECT @ErrorText =text 
		FROM sys.messages
		WHERE message_id = @ErrorVariable
		SELECT @ErrorVariable, @ErrorText
		RETURN @ErrorVariable*-1
	END

--Si no existe información es porque el alumno no ha registrado un fallo para ser atendido
	IF @RowCountVariable = 0 
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -1,'NO SE ENCUENTRA INFORMACION DE LA CONTRASEÑA DEL ALUMNO '
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE ENCUENTRA INFORMACION DE LA CONTRASEÑA DEL ALUMNO '
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
		END
	END 

	SELECT @VAR_password = password
	FROM controlescolar_bd.dbo.nips
	WHERE cuenta = @cuenta
	SELECT @ErrorVariable = @@ERROR
	SELECT @RowCountVariable = @@ROWCOUNT

-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 
	IF @ErrorVariable <> 0 
	BEGIN
		SELECT @ErrorText =text 
		FROM sys.messages
		WHERE message_id = @ErrorVariable
		SELECT @ErrorVariable, @ErrorText
		RETURN @ErrorVariable*-1
	END
--Si no existe información es porque el alumno no ha registrado un fallo para ser atendido
	IF @RowCountVariable = 0 OR @VAR_num_redes  = 0
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -1,'NO ESTA AUTORIZADO EL ACCESO DESDE EL NODO UTILIZADO, NO ES UNA SUBRED VALIDA '
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO ESTA AUTORIZADO EL ACCESO DESDE EL NODO UTILIZADO, NO ES UNA SUBRED VALIDA '
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
		END
	END 




IF LEN(@VAR_mensaje_completo)>0
BEGIN
	SELECT @VAR_codigo_completo, @VAR_mensaje_completo
	RETURN -1
END
SELECT 0,@VAR_password     
return
