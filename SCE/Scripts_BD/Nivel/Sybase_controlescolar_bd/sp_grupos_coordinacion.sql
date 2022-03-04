IF OBJECT_ID ('dbo.sp_grupos_coordinacion') IS NOT NULL
	DROP PROCEDURE dbo.sp_grupos_coordinacion
GO

create procedure sp_grupos_coordinacion @periodo		smallint = null,

												@anio					smallint = null,

												@cve_coordinacion integer = null,

												@cve_categoria 	smallint = null,

												@tipo_grupo 		smallint = null,

												@nivel		 		varchar(2) = null

as

declare

	 @fecha_hoy datetime, 

    @mensaje_error varchar(50),

	 @num_error integer,

	@periodo_actual integer,

	@anio_actual integer,

	@cur_cve_profesor integer,

	@cur_nombre_completo varchar(75),

	@horas_licenciatura smallint,

	@horas_posgrado smallint,

	@horas_totales smallint,

	@grupos_licenciatura smallint,

	@grupos_posgrado smallint,

	@grupos_totales smallint





Begin Transaction



if @periodo in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar el periodo"

	Goto EtiquetaError

end 



if @anio in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar el anio"

	Goto EtiquetaError

end



if @cve_coordinacion in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar la clave de la coordinacion"

	Goto EtiquetaError

end



if @cve_categoria in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar la categoria de los profesores"

	Goto EtiquetaError

end



if @tipo_grupo in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar el tipo de grupo"

	Goto EtiquetaError

end



if @nivel in (null)

begin

	select @num_error = 20000, @mensaje_error = "Es necesario dar el nivel"

	Goto EtiquetaError

end




-- ******************************************************************
DECLARE @tipo_periodo VARCHAR(3)  

SELECT @tipo_periodo = tipo 
FROM periodo 
WHERE periodo = @periodo 

SELECT @periodo_actual = periodo, @anio_actual = anio 
FROM periodos_por_procesos 
WHERE cve_proceso = 0
AND tipo_periodo = @tipo_periodo 


--select @periodo_actual = max(isnull(periodo,0)) from mat_inscritas
--select @anio_actual = max(isnull(anio,0)) from mat_inscritas
-- ******************************************************************


if (@anio > @anio_actual) 

begin

	select @num_error = 20000, @mensaje_error = "El anio escrito no es permitido, por ser futuro"

	Goto EtiquetaError

end 



if (@anio = @anio_actual) and (@periodo > @periodo_actual) 

begin

	select @num_error = 20000, @mensaje_error = "El periodo escrito no es permitido, por ser futuro"

	Goto EtiquetaError

end 





create table #grupos_profesor(

cve_profesor integer,

nombre_completo varchar(75),

horas_licenciatura smallint null,

horas_posgrado smallint null,

horas_totales smallint null,

grupos_licenciatura smallint null,

grupos_posgrado smallint null,

grupos_totales smallint null



)



create unique index idx_grupos_profesor

on #grupos_profesor(cve_profesor)



if @periodo=@periodo_actual and @anio=@anio_actual

BEGIN

	INSERT INTO #grupos_profesor

	SELECT p.cve_profesor,

			 p.nombre_completo,

			horas_licenciatura = 0,

			horas_posgrado = 0,

				horas_totales = 0,

			grupos_licenciatura = 0,

			grupos_posgrado = 0,

			grupos_totales = 0

	FROM	profesor p,

			grupos g,

			materias m,

			coordinaciones c

	WHERE ( g.periodo = @periodo ) AND

			( g.anio = @anio ) AND

			( g.cve_profesor = p.cve_profesor ) AND

	  		( g.cve_mat = m.cve_mat ) AND

			( m.cve_coordinacion = @cve_coordinacion OR

				@cve_coordinacion = 9999) AND

			(m.nivel = @nivel OR

			@nivel = "A") AND

			(g.tipo <> 2) AND

			(g.gpo not in ("Z1","Z2","Z3","Z4","Z5","Z6","Z7","Z8","Z9","ZZ")) AND

			(g.cve_profesor > 9) AND

			(g.inscritos > 0 ) AND

			(g.cond_gpo = 1) AND

			( g.tipo in (@tipo_grupo) OR

           @tipo_grupo = 99 ) AND

			( p.cve_categoria in (@cve_categoria) OR

           @cve_categoria = 99  )

	GROUP BY p.cve_profesor,

			 p.nombre_completo

END

ELSE

BEGIN

	INSERT INTO #grupos_profesor

	SELECT p.cve_profesor,

			 p.nombre_completo,

			horas_licenciatura = 0,

			horas_posgrado = 0,

				horas_totales = 0,

			grupos_licenciatura = 0,

			grupos_posgrado = 0,

			grupos_totales = 0

	FROM	profesor p,

			hist_grupos g,

			materias m,

			coordinaciones c

	WHERE ( g.periodo = @periodo ) AND

			( g.anio = @anio ) AND

			( g.cve_profesor = p.cve_profesor ) AND

	  		( g.cve_mat = m.cve_mat ) AND

			( m.cve_coordinacion = @cve_coordinacion OR

				@cve_coordinacion = 9999) AND

			(m.nivel = @nivel OR

			@nivel = "A") AND

			(g.tipo <> 2) AND

			(g.gpo not in ("Z1","Z2","Z3","Z4","Z5","Z6","Z7","Z8","Z9","ZZ")) AND

			(g.cve_profesor > 9) AND

			(g.inscritos > 0 ) AND

			(g.cond_gpo = 1) AND

			( g.tipo in (@tipo_grupo) OR

           @tipo_grupo = 99 ) AND

			( p.cve_categoria in (@cve_categoria) OR

           @cve_categoria = 99  )

	GROUP BY p.cve_profesor,

			 p.nombre_completo



END

if @@rowcount = 0 

BEGIN

    goto Fin

END



DECLARE cursor_gpos_coord cursor 

FOR 

SELECT cve_profesor,

		nombre_completo

FROM #grupos_profesor

FOR UPDATE



-- Abre el cursor 

open cursor_gpos_coord



-- Lee el primer registro 

fetch cursor_gpos_coord

into 

@cur_cve_profesor,

@cur_nombre_completo



-- El result set se encuentra vacío 



if (@@sqlstatus = 2)

begin

    select @num_error = 20000, @mensaje_error = "No existen movimientos a Procesar."

    close cursor_gpos_coord

    goto Fin

end



-- Si ocurrio un error, llamar al manejador designado 



if (@@sqlstatus = 1) 

begin

   select @num_error = 20000, @num_error = 20000, @mensaje_error = "Error de lectura en el cursor: cursor_gpos_coord."

	close cursor_gpos_coord

	goto EtiquetaError

end



-- Si el result set contiene elementos , entonces procesar

-- cada registro de información 



while (@@sqlstatus = 0)

begin



	if @periodo=@periodo_actual and @anio=@anio_actual

	BEGIN	



		SELECT @horas_licenciatura = isnull(SUM(m.horas_reales),0),

				@grupos_licenciatura = isnull(COUNT(g.cve_mat),0)

		FROM materias m, grupos g

		WHERE m.cve_mat = g.cve_mat

		AND	g.cve_profesor = @cur_cve_profesor

		AND	(m.nivel <> "P")

		AND	g.tipo<>2

		AND   ( g.periodo = @periodo )

		AND	( g.anio = @anio ) 

		/*AND	(m.nivel = "L")*/

		SELECT @horas_posgrado = isnull(SUM(m.horas_reales),0),

				@grupos_posgrado = isnull(COUNT(g.cve_mat),0)

		FROM materias m, grupos g

		WHERE m.cve_mat = g.cve_mat

		AND	g.cve_profesor = @cur_cve_profesor

		AND	(m.nivel = "P")

		AND	g.tipo<>2

		AND   ( g.periodo = @periodo )

		AND	( g.anio = @anio ) 



		SELECT @horas_totales = @horas_licenciatura + @horas_posgrado

		SELECT @grupos_totales = @grupos_licenciatura + @grupos_posgrado



	END

	ELSE

	BEGIN	



		SELECT @horas_licenciatura = isnull(SUM(m.horas_reales),0),

				@grupos_licenciatura = isnull(COUNT(g.cve_mat),0)

		FROM materias m, hist_grupos g

		WHERE m.cve_mat = g.cve_mat

		AND	g.cve_profesor = @cur_cve_profesor

		AND	(m.nivel <> "P")

		AND	g.tipo<>2

		AND   ( g.periodo = @periodo )

		AND	( g.anio = @anio ) 

	
		/*AND	(m.nivel = "L")*/
	

		SELECT @horas_posgrado = isnull(SUM(m.horas_reales),0),

				@grupos_posgrado = isnull(COUNT(g.cve_mat),0)

		FROM materias m, hist_grupos g

		WHERE m.cve_mat = g.cve_mat

		AND	g.cve_profesor = @cur_cve_profesor

		AND	(m.nivel = "P")

		AND	g.tipo<>2

		AND   ( g.periodo = @periodo )

		AND	( g.anio = @anio ) 



		SELECT @horas_totales = @horas_licenciatura + @horas_posgrado

		SELECT @grupos_totales = @grupos_licenciatura + @grupos_posgrado



	END





	update #grupos_profesor

	set horas_licenciatura = @horas_licenciatura,

		 horas_posgrado = @horas_posgrado,

		 horas_totales = @horas_totales,

       grupos_licenciatura = @grupos_licenciatura,

		 grupos_posgrado = @grupos_posgrado,

		 grupos_totales = @grupos_totales

	where current of cursor_gpos_coord 





	if @@error != 0 

	begin

	   select @mensaje_error = "Error al actualizar #grupos_profesor en cursor: cursor_gpos_coord."

		close cursor_gpos_coord

		goto Fin

	end 



	fetch cursor_gpos_coord

	into 

	@cur_cve_profesor,

	@cur_nombre_completo



end





-- Si ocurrio un error, llamar al manejador designado 



if (@@sqlstatus = 1) 

begin

   select @num_error = 20000, @mensaje_error = "Error de lectura en el cursor: cursor_gpos_coord."

	close cursor_gpos_coord

	goto Fin

end



-- Cierra el cursor

close cursor_gpos_coord



-- Elimina el espacio reservado para el cursor

deallocate cursor cursor_gpos_coord





SELECT cve_profesor,

nombre_completo,

horas_licenciatura,

horas_posgrado,

horas_totales,

grupos_licenciatura,

grupos_posgrado,

grupos_totales

FROM #grupos_profesor





Fin:

--	raiserror @num_error,  @mensaje_error



EtiquetaCorrecto:

	Commit Transaction

	return 0



EtiquetaError:

	raiserror @num_error,  @mensaje_error

	Rollback Transaction

	return -1


                                                                                                                      
GO




GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO prhintraces
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_coordinaciones
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO inscripcion
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_jef_tit_cert
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_tit_cert_ventanilla
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_sfeb_becas
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_administrador
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_inf_admin
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_ce_ventanilla
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_ce_atencion
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_jef_admision
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_admision_ventanilla
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_admision_atencion
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_jef_archivo
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_archivo_ventanilla
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_archivo_atencion
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_tit_cert_atencion
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_consultas
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_biblioteca
GO
GRANT EXECUTE ON dbo.sp_grupos_coordinacion TO g_se_cobranzas
GO



