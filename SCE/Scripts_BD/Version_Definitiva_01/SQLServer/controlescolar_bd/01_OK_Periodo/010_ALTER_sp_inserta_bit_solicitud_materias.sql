
USE web_bd
GO  

ALTER procedure sp_inserta_bit_solicitud_materias @cuenta int = null
AS

   declare

      @numrows  int,
      @numnull  int,
      @errno    int,
      @errmsg   varchar(255),
	  @max int,
	  @ErrorVariable INT,
	  @ErrorText varchar(8000),
	  @periodo integer,
	  @anio integer

      select  @numrows = @@rowcount
      select  @errno = 20000
      select  @errmsg = 'pasa'


	/*Se recupera el tipo de periodo para recuperar información de periodos por procesos*/
	DECLARE @VAR_cve_carrera INTEGER 
	DECLARE @VAR_cve_plan INTEGER 
	DECLARE @VAR_tipo_periodo VARCHAR(3) 
	
	/* Se recuperan la cerrera y el plan.*/
	SELECT @VAR_cve_carrera = v_www_academicos.cve_carrera, 
		   @VAR_cve_plan = v_www_academicos.cve_plan
	FROM v_www_academicos
	WHERE cuenta = @CUENTA
	
	/* Se recupera el tipo de periodo.*/
	SELECT @VAR_tipo_periodo = dbo.v_www_plan_estudios.tipo_periodo
	FROM dbo.v_www_plan_estudios
	WHERE dbo.v_www_plan_estudios.cve_carrera = @VAR_cve_carrera
	AND dbo.v_www_plan_estudios.cve_plan = @VAR_cve_plan


	SELECT @periodo = periodo,
			@anio = anio FROM web_bd.dbo.v_www_periodo_mat_inscritas
	WHERE tipo_periodo = @VAR_tipo_periodo 		
			
			
	SELECT @ErrorVariable = @@ERROR
-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 

	IF @ErrorVariable <> 0 
	BEGIN
		SELECT @ErrorText =text 
		FROM sys.messages
		WHERE message_id = @ErrorVariable
		SELECT @ErrorVariable, @ErrorText
		RETURN @ErrorVariable
	END

	SELECT @max = ISNULL(MAX(fsm.folio),0) FROM web_bd.dbo.folio_solicitud_materias fsm
							 WHERE fsm.periodo = @periodo AND fsm.anio = @anio 
	SELECT @ErrorVariable = @@ERROR
-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 

	IF @ErrorVariable <> 0 
	BEGIN
		SELECT @ErrorText =text 
		FROM sys.messages
		WHERE message_id = @ErrorVariable
		SELECT @ErrorVariable, @ErrorText
		RETURN @ErrorVariable
	END

--print '<<<<< @max >>>>>'+convert(varchar(20),@max)

	if @max = NULL
	BEGIN
		SELECT @max = 1

--print '<<<<< @max = 1>>>>>'+convert(varchar(20),@max)

		INSERT INTO folio_solicitud_materias (folio, cuenta, periodo, anio)
		SELECT @max, @cuenta, @periodo, @anio
        
		SELECT @ErrorVariable = @@ERROR
-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 

		IF @ErrorVariable <> 0 
		BEGIN
			SELECT @ErrorText =text 
			FROM sys.messages
			WHERE message_id = @ErrorVariable
			SELECT @ErrorVariable, @ErrorText
			RETURN @ErrorVariable

		END
	END
	else
	BEGIN
		SELECT @max = @max +1

--print '<<<<< @max = @max +1>>>>>'+convert(varchar(20),@max)

		INSERT INTO folio_solicitud_materias (folio, cuenta, periodo, anio)
		SELECT @max, @cuenta, @periodo, @anio
        

		SELECT @ErrorVariable = @@ERROR
-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 
		IF @ErrorVariable <> 0 
		BEGIN
			SELECT  @ErrorText = text
			FROM sys.messages
			WHERE message_id = @ErrorVariable
			SELECT @ErrorVariable, @ErrorText
			RETURN @ErrorVariable
		END
	END

--Inserta los nuevos valores en la bitacora*/                 
--print '<<<<< @max >>>>>'+convert(varchar(20),@max)

		insert into bit_solicitud_materias (folio, cuenta, periodo, anio, cve_mat, gpo)
		select @max, @cuenta, @periodo, @anio, mi.cve_mat, mi.gpo 
		from controlescolar_bd.dbo.mat_inscritas mi
		WHERE mi.cuenta = @cuenta
		AND mi.periodo = @periodo
		AND mi.anio = @anio

 		SELECT @ErrorVariable = @@ERROR
-- The results of this select obtains information from sys.messages is available to Transact-SQL statements. 
		IF @ErrorVariable <> 0 
		BEGIN
			SELECT  @ErrorText = text
			FROM sys.messages
			WHERE message_id = @ErrorVariable
			SELECT @ErrorVariable, @ErrorText
			RETURN @ErrorVariable
		END

SELECT 0,'OK'       

return

GO

