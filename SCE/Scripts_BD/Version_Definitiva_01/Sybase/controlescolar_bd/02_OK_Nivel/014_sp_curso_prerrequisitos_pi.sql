USE controlescolar_bd
GO

IF OBJECT_ID ('dbo.sp_curso_prerrequisitos_pi') IS NOT NULL
	DROP PROCEDURE dbo.sp_curso_prerrequisitos_pi
GO

CREATE procedure dbo.sp_curso_prerrequisitos_pi  

@al_cuenta integer, 

@al_cve_mat integer, 

@al_cve_carrera integer, 

@al_cve_plan integer, 

@si_no integer output

as

-- Adaptación para SQL Server

-- Juan Campos. Mayo-2002.

declare 

@ls_mensaje_error varchar(255),

@ll_num_error integer,

@ll_resultado integer,

@ll_cuenta integer,

@curl_cve_mat integer,

@curl_cve_carrera integer,

@curl_cve_plan integer,

@curl_cve_prerreq integer,

@curs_enlace varchar(1),

@curl_orden integer,

@ll_cve_mat_hist integer,

@ll_cve_mat_mi integer,

@ll_rowcount_prerrequisitos integer,

@ll_rowcount_historico integer,

@ll_rowcount_mat_inscritas integer,

@ll_continua_ciclo integer,

@ll_prerrequisito_actual integer,

@ll_creditos_mi integer,

@ll_creditos_ss integer,

@ll_creditos_integ integer,

@ll_creditos_corte integer,

@ll_creditos_totales_alumno integer,

@ll_cve_area_integ_f1 integer,

@ll_cve_area_integ_f2 integer,

@ll_cve_area_integ_t1 integer,

@ll_cve_area_integ_t2 integer,

@ll_cve_area_integ_t3 integer,

@ll_cve_area_integ_t4 integer,

@ll_cve_area_opcion_terminal integer,

@ll_mat_area_integ_f1 integer,

@ll_mat_area_integ_f2 integer,

@ll_mat_area_integ_t1 integer,

@ll_mat_area_integ_t2 integer,

@ll_mat_area_integ_t3 integer,

@ll_mat_area_integ_t4 integer,

@ll_cve_proyecto_opc_term integer,

@ll_cve_seminario_tit integer,

@ll_rowcount_area_integ_f1 integer,

@ll_rowcount_area_integ_f2 integer,

@ll_rowcount_area_integ_t1 integer,

@ll_rowcount_area_integ_t2 integer,

@ll_rowcount_area_integ_t3 integer,

@ll_rowcount_area_integ_t4 integer,

@ll_rowcount_area_opc_term integer



--NUEVA SINTAXIS PARA CORREGIR EL USO DE RAISERROR        

    DECLARE @ErrorSeverity INT

    DECLARE @ErrorState INT





begin transaction



--OBTIENE LOS CREDITOS AL CORTE



SELECT @ll_creditos_corte = isnull(creditos_cursados,0)	

FROM dbo.academicos 

WHERE cve_carrera = @al_cve_carrera

AND	cve_plan = @al_cve_plan

AND	cuenta = @al_cuenta



--SUMA LOS CREDITOS DE LAS MATERIAS INSCRITAS

SELECT @ll_creditos_mi = isnull(SUM(m.

creditos),0)

FROM dbo.materias m, dbo.mat_inscritas mi

WHERE m.cve_mat = mi.cve_mat

AND  cuenta = @al_cuenta



--OBTIENE LOS CREDITOS PARA SERVICIO SOCIAL Y LAS AREAS DE INTEGRACION

SELECT @ll_creditos_ss = isnull(cred_serv_social,0), 

		 @ll_cve_area_integ_f1 = isnull(cve_area_integ_fundamental,0),

		 @ll_cve_area_integ_f2 = isnull(cve_area_integ_fundamental,0),

		 @ll_cve_area_integ_t1 = isnull(cve_area_integ_tema1,0),

		 @ll_cve_area_integ_t2 = isnull(cve_area_integ_tema2,0),

		 @ll_cve_area_integ_t3 = isnull(cve_area_integ_tema3,0),

		 @ll_cve_area_integ_t4 = isnull(cve_area_integ_tema4,0),

		 @ll_cve_area_opcion_terminal = isnull(cve_area_opcion_terminal,0)

FROM dbo.plan_estudios 

WHERE cve_carrera = @al_cve_carrera

AND	cve_plan = @al_cve_plan





SELECT @ll_mat_area_integ_f1 = isnull(cve_mat,0)

FROM   dbo.area_mat

WHERE  cve_area = @ll_cve_area_integ_f1

AND 	 cve_mat = @al_cve_mat



SELECT @ll_rowcount_area_integ_f1 = @@rowcount



SELECT @ll_mat_area_integ_f2 = isnull(cve_mat,0)

FROM   dbo.area_mat

WHERE  cve_area = @ll_cve_area_integ_f2

AND 	 cve_mat = @al_cve_mat



SELECT @ll_rowcount_area_integ_f2 = @@rowcount



SELECT @ll_mat_area_integ_t1 = isnull(cve_mat,0)

FROM   dbo.area_mat

WHERE  cve_area = @ll_cve_area_integ_t1

AND 	 cve_mat = @al_cve_mat



SELECT @ll_rowcount_area_integ_t1 = @@rowcount



SELECT @ll_mat_area_integ_t2 = isnull(cve_mat,0)

FROM   dbo.area_mat

WHERE  cve_area = @ll_cve_area_integ_t2

AND 	 cve_mat = @al_cve_mat



SELECT @ll_rowcount_area_integ_t2 = @@rowcount



SELECT @ll_mat_area_integ_t3 = isnull(cve_mat,0)

FROM   dbo.area_mat

WHERE  cve_area = @ll_cve_area_integ_t3

AND 	 cve_mat = @al_cve_mat



SELECT @ll_rowcount_area_integ_t3 = @@rowcount



SELECT @ll_mat_area_integ_t4 = isnull(cve_mat,0)

FROM   dbo.area_mat

WHERE  cve_area = @ll_cve_area_integ_t4

AND 	 cve_mat = @al_cve_mat



SELECT @ll_rowcount_area_integ_t4 = @@rowcount



SELECT @ll_cve_proyecto_opc_term = cve_proyecto_opc_term,

		 @ll_cve_seminario_tit = cve_seminario_tit

FROM dbo.aux_opcion_terminal

WHERE cve_area = @ll_cve_area_opcion_terminal



SELECT @ll_rowcount_area_opc_term = @@rowcount



--LA MATERIA REVISADA ES DE INTEGRACION

IF @ll_rowcount_area_integ_f1 >0 OR @ll_rowcount_area_integ_f2>0 OR @ll_rowcount_area_integ_t1>0 OR

	@ll_rowcount_area_integ_t2 >0 OR @ll_rowcount_area_integ_t3>0 OR @ll_rowcount_area_integ_t4>0 

BEGIN



	SELECT @ll_creditos_integ = 72



	SELECT @ll_creditos_totales_alumno =  @ll_creditos_corte



	IF	@ll_creditos_totales_alumno >= @ll_creditos_integ

	BEGIN

	 	select @si_no= 1

		goto Fin

	END

	ELSE

	BEGIN

	 	Select @si_no= 0

		goto Fin

	END





END



--SI SE ESTA REVISANDO EL PROYECTO DE OPCION TERMINAL O EL SEMINARIO DE TITULACION

IF @al_cve_mat= @ll_cve_proyecto_opc_term OR @al_cve_mat = @ll_cve_seminario_tit

BEGIN

	select @si_no= 2

	goto Fin

END



--SI SE ESTA REVISANDO EL SERVICIO SOCIAL 

IF @al_cve_mat= 8763  

BEGIN



	SELECT @ll_creditos_totales_alumno =  @ll_creditos_corte



	IF	@ll_creditos_totales_alumno >= @ll_creditos_ss

	BEGIN

	 	select @si_no= 1

		goto Fin

	END

	ELSE

	BEGIN

	 	Select @si_no= 0

		goto Fin

	END

END





declare cursor_prerrequisitos cursor 

for

 SELECT dbo.prerrequisitos.cve_mat,   

         dbo.prerrequisitos.cve_carrera,   

         dbo.prerrequisitos.cve_plan,   

         dbo.prerrequisitos.cve_prerreq,   

         dbo.prerrequisitos.enlace,   

         dbo.prerrequisitos.orden

    FROM dbo.prerrequisitos

   WHERE ( dbo.prerrequisitos.cve_mat = @al_cve_mat ) AND  

         ( dbo.prerrequisitos.cve_carrera = @al_cve_carrera ) AND  

         ( dbo.prerrequisitos.cve_plan = @al_cve_plan ) 

	ORDER BY dbo.prerrequisitos.orden



-- Abre el cursor 

open cursor_prerrequisitos



SELECT @ll_rowcount_prerrequisitos = count(*)

FROM dbo.prerrequisitos

WHERE ( dbo.prerrequisitos.cve_mat = @al_cve_mat ) AND  

      ( dbo.prerrequisitos.cve_carrera = @al_cve_carrera ) AND  

      ( dbo.prerrequisitos.cve_plan = @al_cve_plan ) 



-- Lee el primer registro 

fetch  cursor_prerrequisitos

into 

@curl_cve_mat,

@curl_cve_carrera,

@curl_cve_plan,

@curl_cve_prerreq,

@curs_enlace,

@curl_orden



-- El result set se encuentra vacío 



if (@@FETCH_STATUS <> 0)

begin

    select @ll_num_error = 20000, @ls_mensaje_error = "No existen materias a Procesar.",

				@ErrorSeverity = 16,

				@ErrorState = 1

    close cursor_prerrequisitos

	 deallocate cursor_prerrequisitos

	 select @si_no= 1

    goto Fin

end



-- Si ocurrio un error, llamar al manejador designado 



-- AVISO PARA EL PROGRAMADOR.

-- Verificar a que numero de error corresponde cuando

-- fetch es un error. Juan Campos.

--if (@@FETCH_STATUS = -1) 

--begin

--   select @ll_num_error = 20000, @ls_mensaje_error = "Error de lectura en el cursor: cursor_prerrequisitos."

--	close cursor_prerrequisitos

--	goto EtiquetaError

--end



-- Si el result set contiene elementos , entonces procesar

--cada registro de información 

select @ll_continua_ciclo = 1



IF @ll_rowcount_prerrequisitos > 0

BEGIN

	SELECT @ll_prerrequisito_actual = 1

END



while (@@FETCH_STATUS = 0) and

(@ll_prerrequisito_actual <= @ll_rowcount_prerrequisitos)

begin



--INICIALIZA LAS VARIABLES UTILIZADAS EN LA ASIGNACION





		SELECT @ll_cve_mat_hist = dbo.historico.cve_mat

		FROM dbo.historico	

		WHERE	( dbo.historico.cuenta =  @al_cuenta) AND 

				( dbo.historico.cve_mat =  @curl_cve_prerreq) AND 

				( dbo.historico.cve_carrera	=	@al_cve_carrera ) AND

				( dbo.historico.cve_plan	=	@al_cve_plan ) AND

				( dbo.historico.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE")) 





		SELECT @ll_rowcount_historico = @@rowcount



		SELECT @ll_cve_mat_mi = dbo.mat_inscritas.cve_mat

		FROM dbo.mat_inscritas	

		WHERE	( dbo.mat_inscritas.cuenta =  @al_cuenta) AND 

				( dbo.mat_inscritas.cve_mat =  @curl_cve_prerreq) AND

				( isnull(dbo.mat_inscritas.calificacion,"") NOT IN  ("BA")) 



		SELECT @ll_rowcount_mat_inscritas = @@rowcount



--	IF @curl_cve_mat = 1269

--	BEGIN 

--		SELECT hist= @ll_rowcount_historico, mi = @ll_rowcount_mat_inscritas ,  prerreq= @curl_cve_prerreq, num_prerreq= @ll_rowcount_prerrequisitos

--	END



--YA CURSO LA MATERIA 

	IF (@ll_rowcount_historico> 0 )

	BEGIN

--LA MATERIA ES OPTATIVA Y NO ESTA LIGADA CON OTRAS. ES NECESARIO SALIR DEL CICLO

		IF (@curs_enlace = "O" OR  @curs_enlace IS NULL OR @curs_enlace = "" OR @ll_prerrequisito_actual = @ll_rowcount_prerrequisitos )

		BEGIN



--		IF @curl_cve_mat = 1269

--		BEGIN 

--			SELECT tipo_o_ultimo = "SI"

--		END



			SELECT @ll_prerrequisito_actual = @ll_rowcount_prerrequisitos + 1

			close cursor_prerrequisitos

			deallocate cursor_prerrequisitos

	 		select @si_no= 1

		   goto Fin

		END

		ELSE

		BEGIN

--			IF @curl_cve_mat = 1269

--			BEGIN 

--				SELECT tipo_y_primero = "SI"

--			END



			SELECT @ll_prerrequisito_actual = @ll_prerrequisito_actual + 1

		END

	END

	ELSE

--NO HA CURSADO LA MATERIA NI LA ESTA CURSANDO EN EL MOMENTO

	BEGIN

--		IF @curl_cve_mat = 1269

--		BEGIN 

--			SELECT sin_hist_ni_mi = "SI"

--		END



		close cursor_prerrequisitos

		deallocate cursor_prerrequisitos

	 	select @si_no= 0

		goto Fin

	END





	fetch  cursor_prerrequisitos

	into 

   @curl_cve_mat,

   @curl_cve_carrera,

   @curl_cve_plan,

   @curl_cve_prerreq,

   @curs_enlace,

   @curl_orden





end



-- Si ocurrio un error, llamar al manejador designado 

 



if (@@FETCH_STATUS = -1)

begin

   select @ls_mensaje_error = "Error de lectura en el cursor: cursor_prerrequisitos.",

				@ErrorSeverity = 16,

				@ErrorState = 1

	close cursor_prerrequisitos

	deallocate cursor_prerrequisitos

	goto Fin

end



-- Cierra el cursor

close cursor_prerrequisitos



-- Elimina el espacio reservado para el cursor

deallocate cursor_prerrequisitos



Fin:

--	raiserror @ll_num_error,  @ls_mensaje_error



EtiquetaCorrecto:

	Commit Transaction

	return 0



EtiquetaError:

	RAISERROR 20000,@ls_mensaje_error

	Rollback Transaction

	return -1
GO

