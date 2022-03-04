use web_bd 
go 


ALTER procedure [dbo].[sp_acceso_alumno_uia] 
@a_cuenta integer,
@a_digito varchar(1), 
@a_password varchar(32),
@ip_cliente varchar(25),
@cve_aplicacion_uia integer 
as
declare 
@ls_mensaje_error varchar(255),
@ls_mensaje_bloqueo varchar(255),
@ll_num_error integer,
@ll_resultado integer,
@ll_cuenta integer,
@ls_digito varchar(1),
@ls_nip varchar(4),
@ls_password varchar(32),
@ll_cve_carrera integer,
@ll_cve_plan integer,
@ls_nivel varchar(1),
@ll_dia integer,
@ls_hora varchar(10),
@ll_flag_documento integer,
@ll_flag_biblioteca integer, 
@ll_baja_laboratorio integer,
@ll_baja_disciplina integer, 
@ll_rowcount_consulta integer, 
@ll_rowcount_bloqueo_dia integer, 
@ll_rowcount_bloqueo_mins integer, 
@ll_cve_tipo_acceso integer, 

@ll_accesos_fallidos_dia integer, 
@ll_num_intentos_bloqueo_dia integer, 
@ll_accesos_fallidos_minutos integer, 
@ll_num_intentos_bloqueo_rango integer,

@ll_num_bloqueos integer,
@ll_bloqueo_activo integer,
@ll_cambio_obligatorio  integer,
@ll_muestra_aviso  integer,
@ldt_fecha_inicio_obligatorio datetime,
@ls_tipo_acceso varchar(255),
@ldt_fecha_bloqueo datetime,
	
@ll_num_intentos_sugerencia_dia	integer ,
@ll_num_intentos_sugerencia_rango integer,

@ldt_fecha_base_dia datetime,
@ldt_fecha_base_min datetime,

@ll_tamanio_password integer,
@ll_tamanio_a_password integer,

@ErrorSeverity INT,
@ErrorState INT,

@tipo_periodo varchar(3)

SELECT 
@ll_cuenta = au.cuenta,
@ls_digito = au.digito,
@ls_nip = au.nip,
@ls_password = au.password,
@ll_cve_carrera = nc.cve_carrera,
@ll_cve_plan = nc.cve_plan, 
@ls_nivel = nc.nivel, 
@ll_dia = nc.dia, 
@ls_hora = nc.hora, 
@ll_flag_documento = nc.flag_documento, 
@ll_flag_biblioteca = nc.flag_biblioteca, 
@ll_baja_laboratorio = nc.baja_laboratorio, 
@ll_baja_disciplina = nc.baja_disciplina,
@ll_bloqueo_activo = au.bloqueo_activo,
@ldt_fecha_bloqueo = au.fecha_bloqueo,
@ll_cambio_obligatorio = au.cambio_obligatorio,
@ll_muestra_aviso = au.muestra_aviso,
@ldt_fecha_inicio_obligatorio = au.fecha_inicio_obligatorio
FROM dbo.v_www_nip_carrera nc, dbo.v_www_alumno_acceso_uia au
WHERE nc.cuenta = au.cuenta 
AND   nc.cuenta = @a_cuenta



SELECT @ll_rowcount_consulta = @@rowcount
BEGIN TRANSACTION 
--EL NUMERO DE CUENTA CORRESPONDE A UN ALUMNO VALIDO
IF @ll_rowcount_consulta> 0 
BEGIN
	IF @ll_bloqueo_activo = 1
	BEGIN
		IF @cve_aplicacion_uia IN (1)
		BEGIN			
			--EL ALUMNO ESTA BLOQUEADO
			SELECT @ll_cve_tipo_acceso = 21	
			goto AccesoPorBloqueo
		END
	END

	--LA CUENTA Y EL DIGITO SON CORRECTOS
	IF (@ll_cuenta = @a_cuenta) AND (@ls_digito = @a_digito)
	BEGIN
		IF (@a_password = @ls_nip) OR (@a_password = @ls_password)
		BEGIN

			SELECT @ll_tamanio_password = len (@ls_password)
			SELECT @ll_tamanio_a_password = len (@a_password)

			--EL ALUMNO NO HA MODIFICADO SU NIP POR PASSWORD
			IF @ls_password IS NULL
			BEGIN
				--EL PASSWORD ES CORRECTO
				SELECT @ll_cve_tipo_acceso = 1	
				--SE ESCRIBIO EL NIP
				IF (@a_password = @ls_nip)
				BEGIN
					IF (getdate() >= @ldt_fecha_inicio_obligatorio)
					BEGIN
						--SE REQUIERE MODIFICAR EL PASSWORD A 8 CARACTERES
						SELECT @ll_cve_tipo_acceso = 3
					END
					ELSE
					BEGIN
						IF (@ll_muestra_aviso= 1)
						BEGIN	
							--SE RECOMIENDA MODIFICAR EL PASSWORD A 8 CARACTERES
							SELECT @ll_cve_tipo_acceso = 2
						END
					END
				END
			END 
			--EL ALUMNO YA MODIFICO SU NIP POR PASSWORD
			ELSE
			BEGIN
				--EL PASSWORD ES CORRECTO
				IF (@a_password = @ls_password)
				BEGIN
					SELECT @ll_cve_tipo_acceso = 1		
				END
				ELSE
				BEGIN
					SELECT @ll_cve_tipo_acceso = 11		
				END
			END 
		END	
		ELSE
		BEGIN
			--EL PASSWORD ES INCORRECTO
			SELECT @ll_cve_tipo_acceso = 11
		END	
		
	END
	ELSE
	BEGIN
		--EL DIGITO NO CORRESPONDE
		SELECT @ll_cve_tipo_acceso = 12
	END	

	-- SI EL PASSWORD ES INCORRECTO O EL DIGITO NO CORRESPONDE
	IF @ll_cve_tipo_acceso = 11 OR @ll_cve_tipo_acceso = 12
	BEGIN
		--SI HAY UN DESBLOQUEO
		IF @ldt_fecha_bloqueo is not null
		BEGIN
			IF @ll_bloqueo_activo = 0
			BEGIN
				--EL DESBLOQUEO ES POSTERIOR A AYER (HOY MENOS 24 HORAS)
				IF @ldt_fecha_bloqueo > DATEADD (dd , -1, getdate()) 	
				BEGIN
					SELECT @ldt_fecha_base_dia = @ldt_fecha_bloqueo		
				END
				--EL DESBLOQUEO ES ANTERIOR
				ELSE
				BEGIN
					SELECT @ldt_fecha_base_dia = DATEADD (dd , -1, getdate()) 		
				END
			END
			ELSE
			BEGIN
				SELECT @ldt_fecha_base_dia = DATEADD (dd , -1, getdate()) 		
			END
		END 
		ELSE
		-- HAY UN BLOQUEO 
		BEGIN
			SELECT @ldt_fecha_base_dia = DATEADD (dd , -1, getdate()) 	
		END 

		--SOLO SE CONTARAN LOS ACCESOS FALLIDOS DESDE SERVICIOS EN LINEA (cve_aplicacion_uia in (1))
		SELECT @ll_accesos_fallidos_dia =count(bau.cuenta), 
			@ll_num_intentos_bloqueo_dia = par.num_intentos_bloqueo_dia,
			@ll_num_intentos_sugerencia_dia = par.num_intentos_sugerencia_dia	
		FROM controlescolar_bd.dbo.parametros_cambio_password  par, bit_acceso_uia bau
		WHERE par.cve_parametro = 1
		AND bau.cve_tipo_acceso >1
		AND bau.fecha >= @ldt_fecha_base_dia 
		AND bau.cuenta = @a_cuenta
		AND bau.cve_aplicacion_uia in (1)
		GROUP BY par.num_intentos_bloqueo_dia,
			par.num_intentos_sugerencia_dia

		SELECT @ll_rowcount_bloqueo_dia = @@rowcount

		--EL ALUMNO ESTA A PUNTO DE ALCANZAR EL NUMERO DE ERRORES POR DIA
		IF @ll_accesos_fallidos_dia = @ll_num_intentos_sugerencia_dia
		BEGIN
			--EL ALUMNO ESTA A PUNTO DE ALCANZAR EL NUMERO DE ERRORES POR DIA
			SELECT @ll_cve_tipo_acceso = 14

		END
		ELSE
		BEGIN
			IF @ll_rowcount_bloqueo_dia > 0 AND @ll_accesos_fallidos_dia > @ll_num_intentos_bloqueo_dia
			BEGIN
				--EL ALUMNO HA EXCEDIDO EL NUMERO DE ERRORES POR DIA
				SELECT @ll_cve_tipo_acceso = 22	
			END
 		END


		--SI HAY UN DESBLOQUEO
		IF @ldt_fecha_bloqueo is not null
		BEGIN
			IF @ll_bloqueo_activo = 0
			BEGIN
				SELECT @ldt_fecha_base_min = DATEADD (mi , -1 *par.num_minutos_bloqueo_rango, getdate()) 
				FROM controlescolar_bd.dbo.parametros_cambio_password  par
				WHERE par.cve_parametro = 1

				--EL DESBLOQUEO ES POSTERIOR A x MINUTOS (HOY MENOS X MINUTOS)
				IF @ldt_fecha_bloqueo > @ldt_fecha_base_min
				BEGIN
					SELECT @ldt_fecha_base_min = @ldt_fecha_bloqueo		
				END
				--EL DESBLOQUEO ES ANTERIOR
				ELSE
				BEGIN
					SELECT @ldt_fecha_base_min = DATEADD (mi , -1 *par.num_minutos_bloqueo_rango, getdate()) 
					FROM controlescolar_bd.dbo.parametros_cambio_password  par
					WHERE par.cve_parametro = 1
				END
			END
			ELSE
			BEGIN
				SELECT @ldt_fecha_base_min = DATEADD (mi , -1 *par.num_minutos_bloqueo_rango, getdate()) 
				FROM controlescolar_bd.dbo.parametros_cambio_password  par
				WHERE par.cve_parametro = 1
			END
		END 
		ELSE
		-- HAY UN BLOQUEO 
		BEGIN
			SELECT @ldt_fecha_base_min = DATEADD (mi , -1 *par.num_minutos_bloqueo_rango, getdate()) 
			FROM controlescolar_bd.dbo.parametros_cambio_password  par
			WHERE par.cve_parametro = 1
		END 

		--SOLO SE CONTARAN LOS ACCESOS FALLIDOS DESDE SERVICIOS EN LINEA (cve_aplicacion_uia in (1))
		SELECT @ll_accesos_fallidos_minutos = count(bau.cuenta), 
			@ll_num_intentos_bloqueo_rango = par.num_intentos_bloqueo_rango,
			@ll_num_intentos_sugerencia_rango = par.num_intentos_sugerencia_rango	
		FROM controlescolar_bd.dbo.parametros_cambio_password  par, bit_acceso_uia bau
		WHERE par.cve_parametro = 1
		AND bau.cve_tipo_acceso >1
		AND bau.fecha >= @ldt_fecha_base_min
		AND bau.cuenta = @a_cuenta
		AND bau.cve_aplicacion_uia in (1)
		GROUP BY par.num_intentos_bloqueo_rango,
			par.num_intentos_sugerencia_rango	

		SELECT @ll_rowcount_bloqueo_mins = @@rowcount
 
		--EL ALUMNO ESTA A PUNTO DE ALCANZAR EL NUMERO DE ERRORES POR RANGO DE MINUTOS
		IF @ll_accesos_fallidos_minutos = @ll_num_intentos_sugerencia_rango
		BEGIN
			--EL ALUMNO ESTA A PUNTO DE ALCANZAR EL NUMERO DE ERRORES POR RANGO DE MINUTOS
			SELECT @ll_cve_tipo_acceso = 15

		END
		ELSE
		BEGIN
			--EL ALUMNO HA EXCEDIDO EL NUMERO DE ERRORES POR RANGO POR MINUTO
			IF @ll_rowcount_bloqueo_mins> 0 AND @ll_accesos_fallidos_minutos > @ll_num_intentos_bloqueo_rango
			BEGIN
				--EL ALUMNO HA EXCEDIDO EL NUMERO DE ERRORES POR RANGO POR MINUTO
				SELECT @ll_cve_tipo_acceso = 23
			END
		END
	END

	
END
ELSE
BEGIN
	--EL NUMERO DE CUENTA NO ES DE UN ALUMNO VALIDO
	SELECT @ll_cve_tipo_acceso = 13
END

--EL ALUMNO ESTA A PUNTO DE ALCANZAR EL NUMERO DE ERRORES POR DIA (O)
--EL ALUMNO HA EXCEDIDO EL NUMERO DE ERRORES POR RANGO POR MINUTO
IF @ll_cve_tipo_acceso = 22 OR @ll_cve_tipo_acceso = 23
BEGIN
	SELECT @ll_bloqueo_activo = 1

	SELECT @ll_num_bloqueos = count(bu.cuenta)
	FROM bloqueo_uia bu
	WHERE bu.cuenta = @a_cuenta
	AND	bu.cve_tipo_usuario = 'A'

	--EL ALUMNO YA HA TENIDO ALGUN BLOQUEO
	IF @ll_num_bloqueos>0 
	BEGIN
		SELECT @ls_mensaje_bloqueo = 'Error de actualizacion en: bloqueo_uia.',
				@ErrorSeverity = 16,
				@ErrorState = 1


		UPDATE bloqueo_uia
		SET 	cve_profesor = 0,
			folio = 0,
			bloqueo_activo = @ll_bloqueo_activo,
			cve_tipo_acceso	= @ll_cve_tipo_acceso,
			fecha = getdate(),
			usuario = user_name()
		FROM bloqueo_uia
		WHERE cve_tipo_usuario = 'A'
		AND	cuenta = @a_cuenta
	END
	ELSE
	--ES EL PRIMER BLOQUEO DEL ALUMNO
	BEGIN
		SELECT @ls_mensaje_bloqueo = 'Error de insercion en: bloqueo_uia.',
				@ErrorSeverity = 16,
				@ErrorState = 1


		INSERT INTO bloqueo_uia
		(cve_tipo_usuario,
		cuenta,
		cve_profesor,
		folio,
		bloqueo_activo,
		cve_tipo_acceso,		
		fecha,
		usuario
		) VALUES (
		'A',
		@a_cuenta,
		0,
		0,
		@ll_bloqueo_activo,
		@ll_cve_tipo_acceso,
		getdate(),
		user_name()
		)

	END 
	
	IF (@@ERROR <> 0) 
	BEGIN
		select @ll_num_error = 20000
		select @ls_mensaje_error = @ls_mensaje_bloqueo
		goto EtiquetaError
	END
END


AccesoPorBloqueo:


INSERT INTO 
bit_acceso_uia (
	cve_tipo_usuario,
	cuenta,
	cve_profesor,
	folio,
	digito,
	password,
	ip_cliente,
	cve_tipo_acceso,
	cve_aplicacion_uia)
VALUES ('A',
	@a_cuenta,
	0,
	0,
	@a_digito,
	@a_password,
	@ip_cliente,
	@ll_cve_tipo_acceso,
	@cve_aplicacion_uia)

IF (@@ERROR <> 0) 
BEGIN
	select @ll_num_error = 20000
	select @ls_mensaje_error = 'Error de inserción en: bit_acceso_uia.',
				@ErrorSeverity = 16,
				@ErrorState = 1

	goto EtiquetaError
END

SELECT @ls_tipo_acceso = tipo_acceso
FROM dbo.tipo_acceso
WHERE cve_tipo_acceso = @ll_cve_tipo_acceso


SELECT @tipo_periodo = dbo.v_www_plan_estudios.tipo_periodo
FROM dbo.v_www_plan_estudios
WHERE dbo.v_www_plan_estudios.cve_carrera = @ll_cve_carrera
AND dbo.v_www_plan_estudios.cve_plan = @ll_cve_plan


select cuenta =@ll_cuenta, 
digito = @ls_digito, 
nip = @ls_nip, 
password = @ls_password, 
cve_carrera = @ll_cve_carrera, 
cve_plan = @ll_cve_plan, 
nivel = @ls_nivel, 
dia = @ll_dia, 
hora = @ls_hora, 
flag_documento = @ll_flag_documento, 
flag_biblioteca = @ll_flag_biblioteca, 
baja_laboratorio = @ll_baja_laboratorio,
baja_disciplina = @ll_baja_disciplina,
cve_tipo_acceso = @ll_cve_tipo_acceso,
bloqueo_activo = @ll_bloqueo_activo,
cambio_obligatorio = @ll_cambio_obligatorio,
muestra_aviso = @ll_muestra_aviso,
fecha_inicio_obligatorio = @ldt_fecha_inicio_obligatorio,
tipo_acceso = @ls_tipo_acceso,
fecha_bloqueo = @ldt_fecha_bloqueo, 
tipo_periodo = @tipo_periodo

--ls_mensaje_bloqueo = @ls_mensaje_bloqueo,
--ll_num_bloqueos = @ll_num_bloqueos

EtiquetaCorrecto:
COMMIT TRANSACTION
 return 0
 
EtiquetaError:
 --raiserror ('%d, %s.',16, 1,@ll_num_error, @ls_mensaje_error)
  RAISERROR (@ls_mensaje_error, @ErrorSeverity, @ErrorState)
 Rollback Transaction
 return -1




GO

