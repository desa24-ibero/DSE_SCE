USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_prueba]    Script Date: 8/8/2017 13:25:37 ******/
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO
ALTER procedure [dbo].[sp_prueba]
@cuenta integer,
@anio integer, 
@periodo integer,
@anio_ing integer, 
@periodo_ing integer,
@cve_forma_ingreso integer,
@cve_tipo_cobro integer,
@nivel char(1),
@cve_carrera integer,
@inscripcion_esp integer,
@unidades integer,
@unidades_apoyo integer,
@cve_apoyo integer
as
-- Regresa los importes a pagar de: Inscripción
-- Se toma en cuenta los apoyos por beca o financiamiento, los pagos y las devoluciones. 
-- Nota No se valida ningun concepto de recargo, Apetición del usuario
-- ya que las boletas no estaran en servicio cuando las fechas esten vencidas.
-- Juan Campos Sánchez. 20 de septiembre de 2002.

declare @costo double precision
declare @costo_insc double precision
declare @costo_mat double precision
declare @costo_matex double precision
declare @limite_inferior integer
declare @limite_superior integer
declare @pagos_devoluciones_insc double precision
declare @pagos_devoluciones_apor double precision
declare @paga_aportacion integer
declare @regresa_aportacion integer
declare @concepto_inscripcion integer
declare @concepto_aportacion integer
declare @cve_version_examen integer
declare @anio_examen integer
declare @periodo_examen integer
declare @anio_mov_alu integer
declare @periodo_mov_alu integer
declare @anio_ven integer
declare @periodo_ven integer
declare @des_concepto_insc varchar(100)
declare @des_concepto_apor varchar(100)
declare @costo_aportacion double precision
declare @fecha_vencimiento datetime
declare @error varchar(100)

-- Obtiene los conceptos a pagar de Inscripción y Aportación
select @concepto_inscripcion = -1
select @concepto_aportacion = -1

if @cve_forma_ingreso = 2 -- Reingreso
begin
	if @nivel <> "P" -- MALH 08/08/2017 -> if @nivel = "L"
	begin
		select @concepto_inscripcion = 4 -- Inscripcion Reingreso Lic
		select @concepto_aportacion = 0 -- Reingreso No paga Aportación Única 
	end
	else
	begin
		select @concepto_inscripcion = 6 -- Inscripcion Reingreso Posgrado
		select @concepto_aportacion = 0 -- Posgrado No paga Aportación Única 
	end
end

if @cve_forma_ingreso = 1 -- Ingreso
begin
	if @periodo <> 1 -- Primavera y Otoño
	begin
		if @nivel <> "P" -- MALH 08/08/2017 -> if @nivel = "L"
		begin
			select @concepto_inscripcion = 3 -- Inscripción primer ingreso lic
			select @concepto_aportacion = 1 -- Aportación Única 
		end
		else
		begin
			select @concepto_inscripcion = 5 -- Inscripción Primer Ingreso Pos
			select @concepto_aportacion = 0 -- Posgrado No paga Aportación Única 
		end
	end
	else -- Verano. Nota. En verano los primeros ingresos se vuelven reingresos
	begin
		if @nivel <> "P" -- MALH 08/08/2017 -> if @nivel = "L"
		begin
			select @concepto_inscripcion = 4 -- Inscripción Reingreso lic
			select @concepto_aportacion = 0 -- En verano no se paga Aportación . ¿Revisar?.
			select @cve_forma_ingreso = 2 -- Se Convierte a Reingreso
 		end
		else
		begin
			select @concepto_inscripcion = 6 -- Inscripción Reingreso Pos
			select @concepto_aportacion = 0 -- Posgrado No paga Aportación Única 
			select @cve_forma_ingreso = 2 -- Se Convierte a Reingreso
		end
	end
end

if @cve_forma_ingreso = 3 -- Revalidación
begin
	select @concepto_inscripcion = 7 -- Inscripción Revalidación
	select @concepto_aportacion = 2 --  Aportación Única Revalidación
end

--Consulta si el alumno paga Aportación única.
select @paga_aportacion = 0
select @regresa_aportacion = 0
select @paga_aportacion = count(*) from tesoreria_bd.dbo.no_paga_aportacion where clave = @cve_carrera
if @paga_aportacion > 0 
begin
	--No paga aportación por la clave de carrera
	select @paga_aportacion = 0
	select @regresa_aportacion = 0
	select @concepto_aportacion = 0
end
else
begin

	select "cve_apoyo" = @cve_apoyo
	select @paga_aportacion = count(*) from tesoreria_bd.dbo.no_paga_aportacion where clave = @cve_apoyo
	if @paga_aportacion > 0 
	begin
		select @paga_aportacion = 1
		select @regresa_aportacion = 1 -- Paga Aportación por su cve de apoyo, pero se le regresa al 100%			
		--Modificación: --No paga aportación por la clave del apoyo
		--Juan campos Diciembre de 2004. A petición  de Carlos Escobedo.
		--select @paga_aportacion = 0
		--select @regresa_aportacion = 0
		--select @concepto_aportacion = 0
	end
end

if @concepto_inscripcion = -1 
begin
	select @error ="Error al consultar Concepto de Inscripción"
	goto error
end 
	if @concepto_aportacion = -1 
begin
	select @error ="Error al consultar Concepto de Aportación"
	goto error
end 

--Sólo para Inscripción Primer Ingreso lic, se obtienen versión exámen 1
--e identifica si el alumno es apartado de lugar.
--Juan Campos. 2002.

if @concepto_inscripcion = 3 
begin		
	select @cve_version_examen = admision_bd.dbo.general.clv_ver,
			 @anio_examen = admision_bd.dbo.general.anio,
			 @periodo_examen = admision_bd.dbo.general.clv_per
	from  admision_bd.dbo.general, admision_bd.dbo.aspiran  
	where ( admision_bd.dbo.general.folio	 = admision_bd.dbo.aspiran.folio ) and  
  			( admision_bd.dbo.general.clv_ver = admision_bd.dbo.aspiran.clv_ver ) and
  			( admision_bd.dbo.general.clv_per = admision_bd.dbo.aspiran.clv_per ) and
			( admision_bd.dbo.general.anio 	 = admision_bd.dbo.aspiran.anio  ) and
        	( admision_bd.dbo.general.cuenta  = @cuenta ) AND  
        	( admision_bd.dbo.general.clv_ver <> 0 ) AND  
        	( admision_bd.dbo.aspiran.ing_anio = @anio_ing ) AND  
        	( admision_bd.dbo.aspiran.ing_per = @periodo_ing ) 

	if @@ERROR <> 0
	begin	 
		select @error = "Error al obtener Versión del Examen"
		goto error
	end		
 
	if @cve_version_examen = null or @anio_examen = null or @periodo_examen = null
	begin
		select @cve_version_examen = MAX(admision_bd.dbo.general.clv_ver )
   	from	admision_bd.dbo.general  
   	where  (admision_bd.dbo.general.anio = @anio) and
				 (admision_bd.dbo.general.clv_per = @periodo) 

			select @anio_examen = @anio -- Año del proceso
			select @periodo_examen = @periodo -- Periodo del Proceso 
	end
 
	if @anio_examen <> @anio_ing or @periodo_examen <> @periodo_ing
	begin
		select @concepto_inscripcion = 30 -- Inscripción Apartado de lugar
		if @concepto_aportacion <> 0				
			select @concepto_aportacion = 31 -- Aportación Apartado de lugar
 
	end
 
end
	
-- Si es un partado de lugar el periodo y año deben de ser los de ingreso:
-- y el periodo y año de vencimiento deben ser los del examen de admisión.

if @concepto_inscripcion = 30
begin
	select @anio_mov_alu = @anio_ing
	select @periodo_mov_alu = @periodo_ing
	select @anio_ven = @anio_examen
	select @periodo_ven = @periodo_examen
end
else
begin
	select @anio_mov_alu = @anio
	select @periodo_mov_alu = @periodo
	select @anio_ven = @anio 
	select @periodo_ven = @periodo
end

if @inscripcion_esp = 0 
begin
	--Inscripción Normal		
	select @costo_insc = 0
	declare costos_normales cursor for
		select limite_inferior,limite_superior,costo
		from  tesoreria_bd.dbo.costos_inscripcion
		where anio = @anio_ven and
				periodo = @periodo_ven and
				cve_forma_ingreso = @cve_forma_ingreso and
				nivel = @nivel and
				cve_tipo_cobro = @cve_tipo_cobro

	open costos_normales

	fetch next from costos_normales into @limite_inferior,@limite_superior,@costo

	if (@@FETCH_STATUS <> 0)
	begin
		select @cve_tipo_cobro = 0
		select @costo = 0 
		select @limite_inferior = 0
		select @limite_superior = 0
		close costos_normales
		deallocate costos_normales
		return
	end

	if @cve_tipo_cobro = 4 -- limite de horas
	begin
		while (@@FETCH_STATUS = 0)
		begin
			if @unidades >= @limite_inferior and @unidades <= @limite_superior 
				select @costo_insc = @costo	
			fetch next from costos_normales into @limite_inferior,@limite_superior,@costo
		end
	end
 
	if @cve_tipo_cobro = 2 and @nivel ="P" -- Horas
		select @costo_insc = (@costo * @unidades)

	close costos_normales
	deallocate costos_normales

end -- fin del if @inscripcion_esp = 0 

if @inscripcion_esp = 1
begin
	--Inscripción Especial		
	select @costo_insc = 0
	declare costos_especiales cursor for
		select cve_tipo_cobro,limite_inferior,limite_superior,costo
		from  tesoreria_bd.dbo.costos_inscripcion_especiales
		where anio = @anio_ven and
				periodo = @periodo_ven and
				cve_forma_ingreso = @cve_forma_ingreso and
				cve_carrera = @cve_carrera

	open costos_especiales

	fetch next from costos_especiales into @cve_tipo_cobro,@limite_inferior,@limite_superior,@costo

	if (@@FETCH_STATUS <> 0)
	begin
		select @cve_tipo_cobro = 0
		select @costo = 0 
		select @limite_inferior = 0
		select @limite_superior = 0
		close costos_especiales
		deallocate costos_especiales
		return
	end

	select @costo_insc = 0

	if @cve_tipo_cobro = 4 -- limite de horas
	begin
		while (@@FETCH_STATUS = 0)
		begin
			if @unidades >= @limite_inferior and @unidades <= @limite_superior 
				select @costo_insc = @costo	
			fetch next from costos_especiales into @cve_tipo_cobro,@limite_inferior,@limite_superior,@costo
		end
	end

	if @cve_tipo_cobro = 5 or @cve_tipo_cobro = 6  -- Materia y Materia Extra
	begin
		while (@@FETCH_STATUS = 0)
		begin
			if @cve_tipo_cobro = 5
				select @costo_mat = @costo 
			if @cve_tipo_cobro = 6
				select @costo_matex = @costo 
			 fetch next from costos_especiales into @cve_tipo_cobro,@limite_inferior,@limite_superior,@costo
		end
		
		if @unidades = 1 
			select @costo_insc = @costo_mat  

		if @unidades > 1 
			select @costo_insc = @costo_mat + ((@unidades - 1) * @costo_matex )
	end

	if @cve_tipo_cobro = 7 -- Proyecto
		select @costo_insc = (@costo * @unidades)

	close costos_especiales
	deallocate costos_especiales

end -- Fin del if @inscripcion_esp = 1

-----------------------------------------------------------------------------------------------------
-- Se duplico el código para la consulta de la  inscripcion normal y especial, y se modifico para
-- que consulte y valide con @unidades_apoyo, que son las horas financiadas del alumno que tenga beca
-- Juan Campos. 24-abril-2003.
-----------------------------------------------------------------------------------------------------
declare @costo_insc_beca double precision
select @costo_insc_beca = 0

if @unidades_apoyo > 0 
begin
	if @inscripcion_esp = 0 
	begin
		--Inscripción Normal		
		select @costo_insc_beca = 0
		declare costos_normales_beca cursor for
			select limite_inferior,limite_superior,costo
			from  tesoreria_bd.dbo.costos_inscripcion
			where anio = @anio_ven and
					periodo = @periodo_ven and
					cve_forma_ingreso = @cve_forma_ingreso and
					nivel = @nivel and
					cve_tipo_cobro = @cve_tipo_cobro

		open costos_normales_beca

		fetch next from costos_normales_beca into @limite_inferior,@limite_superior,@costo

		if (@@FETCH_STATUS <> 0)
		begin
			select @cve_tipo_cobro = 0
			select @costo = 0 
			select @limite_inferior = 0
			select @limite_superior = 0
			close costos_normales_beca
			deallocate costos_normales_beca
			return
		end

		if @cve_tipo_cobro = 4 -- limite de horas
		begin
			while (@@FETCH_STATUS = 0)
			begin
				if @unidades_apoyo >= @limite_inferior and @unidades_apoyo <= @limite_superior 
					select @costo_insc_beca = @costo	
				fetch next from costos_normales_beca into @limite_inferior,@limite_superior,@costo
			end
		end
 
		if @cve_tipo_cobro = 2 and @nivel ="P" -- Horas
			select @costo_insc_beca = (@costo * @unidades_apoyo)

		close costos_normales_beca
		deallocate costos_normales_beca

	end -- fin del if @inscripcion_esp = 0 

 	
	if @inscripcion_esp = 1
	begin
		--Inscripción Especial		
		select @costo_insc_beca = 0
		declare costos_especiales_beca cursor for
			select cve_tipo_cobro,limite_inferior,limite_superior,costo
			from  tesoreria_bd.dbo.costos_inscripcion_especiales
			where anio = @anio_ven and
					periodo = @periodo_ven and
					cve_forma_ingreso = @cve_forma_ingreso and
					cve_carrera = @cve_carrera

		open costos_especiales_beca

		fetch next from costos_especiales_beca into @cve_tipo_cobro,@limite_inferior,@limite_superior,@costo

		if (@@FETCH_STATUS <> 0)
		begin
			select @cve_tipo_cobro = 0
			select @costo = 0 
			select @limite_inferior = 0
			select @limite_superior = 0
			close costos_especiales_beca
			deallocate costos_especiales_beca
			return
		end

		select @costo_insc_beca = 0

		if @cve_tipo_cobro = 4 -- limite de horas
		begin
			while (@@FETCH_STATUS = 0)
			begin
				if @unidades_apoyo >= @limite_inferior and @unidades_apoyo <= @limite_superior 
					select @costo_insc_beca = @costo	
				fetch next from costos_especiales_beca into @cve_tipo_cobro,@limite_inferior,@limite_superior,@costo
			end
		end

		if @cve_tipo_cobro = 5 or @cve_tipo_cobro = 6  -- Materia y Materia Extra
		begin
			while (@@FETCH_STATUS = 0)
			begin
				if @cve_tipo_cobro = 5
					select @costo_mat = @costo 
				if @cve_tipo_cobro = 6
					select @costo_matex = @costo 
				 fetch next from costos_especiales_beca into @cve_tipo_cobro,@limite_inferior,@limite_superior,@costo
			end
		
			if @unidades_apoyo = 1 
				select @costo_insc_beca = @costo_mat  

			if @unidades_apoyo > 1 
				select @costo_insc_beca = @costo_mat + ((@unidades_apoyo - 1) * @costo_matex )
		end

		if @cve_tipo_cobro = 7 -- Proyecto
			select @costo_insc_beca = (@costo * @unidades_apoyo)

		close costos_especiales_beca
		deallocate costos_especiales_beca

	end -- Fin del if @inscripcion_esp = 1

end -- fin @unidades_apoyo 
-----------------------------------------------------------------------------------------------------

if @costo_insc > 0 
begin
	if @nivel <> "P" -- MALH 08/08/2017 -> if @nivel = "L"
	begin
		-- Se recupera el costo de la Aportación Única
		declare @con_aux integer
		select @error = null
	
		if @concepto_aportacion <> 0
		begin
			if @concepto_aportacion = 31
				select @con_aux = 1 -- Aportación única
			else	
				select @con_aux = @concepto_aportacion

			select @costo_aportacion =  tesoreria_bd.dbo.costos_conceptos.costo 
      	from tesoreria_bd.dbo.costos_conceptos      
	      where (tesoreria_bd.dbo.costos_conceptos.cve_concepto = @con_aux ) and
   	       	(tesoreria_bd.dbo.costos_conceptos.anio = @anio_ven ) And
      	    	(tesoreria_bd.dbo.costos_conceptos.periodo = @periodo_ven)   

			if @costo_aportacion = null
			begin
				select @error = "Error al consultar costos de aportación única"			
				goto error
			end
		end
		else
			select @costo_aportacion = 0
	end
	else
		select @costo_aportacion = 0

	--Obtiene la descripción de los conceptos
 	select @des_concepto_insc = tesoreria_bd.dbo.conceptos.concepto
	from tesoreria_bd.dbo.conceptos
	where tesoreria_bd.dbo.conceptos.cve_concepto = @concepto_inscripcion
	if @des_concepto_insc = null 
	begin
		select @error = "Error al consultar la descripción del concepto de Inscripción"
		goto error
	end
	
	if @concepto_aportacion > 0 
	begin
		select @des_concepto_apor = tesoreria_bd.dbo.conceptos.concepto
		from tesoreria_bd.dbo.conceptos
		where tesoreria_bd.dbo.conceptos.cve_concepto = @concepto_aportacion
		if @des_concepto_apor = null 
		begin
			select @error = "Error al consultar la descripción del concepto de Aportación"
			goto error
		end
	end
	
	--Obtiene la fecha de vencimiento deacuerdo al concepto
	declare @fecha_entera integer
	if @concepto_inscripcion = 3 or @concepto_inscripcion = 30
	begin
		select @fecha_vencimiento = tesoreria_bd.dbo.fechas_tasas_vencimiento.fecha_vencimiento
		from tesoreria_bd.dbo.fechas_tasas_vencimiento
		where anio = @anio_examen and
				periodo = @periodo_examen and
				cve_concepto = @concepto_inscripcion and
				vencimiento = 1 and
				version = @cve_version_examen
	end
	else
	begin
		select @fecha_vencimiento = tesoreria_bd.dbo.fechas_tasas_vencimiento.fecha_vencimiento
		from tesoreria_bd.dbo.fechas_tasas_vencimiento
		where anio = @anio and
				periodo = @periodo and
				cve_concepto = @concepto_inscripcion and
				vencimiento = 1 and
				version = 0
	end

	if @fecha_vencimiento = null
	begin
		select @error = "Error al consultar fecha de vencimiento"
		goto error
	end
	else
	begin
		-- Convierte la fecha a un entero para la consulta de los pagos y devoluciones
		select @fecha_entera = (Year(@fecha_vencimiento) * 10000) + (Month(@fecha_vencimiento) * 100) + Day(@fecha_vencimiento)

		-- Obtiene los pagos menos las devoluciones de Inscripción.

		-- Modificación. 15-Julio-2003. Juan Campos.
		-- Conceptualmente se restan las cancelaciones a el importe a pagar
		-- 406(Cancelación por convenio), 409(Apoyo Emergente), 457(Apoyo Externo)
		-- Realmente se estan sumando los pagos mas cancelaciones.
		
		select @pagos_devoluciones_insc = 0

		select @pagos_devoluciones_insc =
					ROUND(SUM(case(tesoreria_bd.dbo.mov_alumnos.cve_subconcepto)
									when 3 then  tesoreria_bd.dbo.mov_alumnos.importe
									when 2 then  - tesoreria_bd.dbo.mov_alumnos.importe
									else 0
									end),2) +
					ROUND(SUM(case(tesoreria_bd.dbo.mov_alumnos.cve_descripcion)
									when 409 then importe
									when 406 then importe				 
									else 0
									end),2) 
	    from tesoreria_bd.dbo.mov_alumnos  
   	where ( tesoreria_bd.dbo.mov_alumnos.cuenta = @cuenta ) and
      	   ( tesoreria_bd.dbo.mov_alumnos.cve_concepto = @concepto_inscripcion ) and  
         	( tesoreria_bd.dbo.mov_alumnos.anio = @anio_mov_alu ) and
	         ( tesoreria_bd.dbo.mov_alumnos.periodo = @periodo_mov_alu ) and  
   	      ( (10000*datepart(yy,tesoreria_bd.dbo.mov_alumnos.fecha_vencimiento))+
				(100 *datepart(mm,tesoreria_bd.dbo.mov_alumnos.fecha_vencimiento)) +
				datepart(dd,tesoreria_bd.dbo.mov_alumnos.fecha_vencimiento) = @fecha_entera)    

			if @pagos_devoluciones_insc = null
				select @pagos_devoluciones_insc = 0

		-- Obtiene los pagos menos las devoluciones de Aportación Única.

		select @pagos_devoluciones_apor = 0

		if @concepto_aportacion > 0 
		begin
			select @pagos_devoluciones_apor =
						ROUND(SUM(	case(tesoreria_bd.dbo.mov_alumnos.cve_subconcepto)
										when 3 then  tesoreria_bd.dbo.mov_alumnos.importe
										when 2 then  - tesoreria_bd.dbo.mov_alumnos.importe
										else 0
										end),2) +
						ROUND(SUM(case(tesoreria_bd.dbo.mov_alumnos.cve_descripcion)
										when 409 then importe
										when 406 then importe				 
										else 0
										end),2) 

		    from tesoreria_bd.dbo.mov_alumnos  
   		where ( tesoreria_bd.dbo.mov_alumnos.cuenta = @cuenta ) and
      		   ( tesoreria_bd.dbo.mov_alumnos.cve_concepto = @concepto_aportacion ) and  
         		( tesoreria_bd.dbo.mov_alumnos.anio = @anio_mov_alu ) and
	         	( tesoreria_bd.dbo.mov_alumnos.periodo = @periodo_mov_alu ) and  
	   	      ( (10000*datepart(yy,tesoreria_bd.dbo.mov_alumnos.fecha_vencimiento))+
					(100 *datepart(mm,tesoreria_bd.dbo.mov_alumnos.fecha_vencimiento)) +
					datepart(dd,tesoreria_bd.dbo.mov_alumnos.fecha_vencimiento) = @fecha_entera)    

				if @pagos_devoluciones_apor = null
					select @pagos_devoluciones_apor = 0

		end
			
	end -- fin del if @fecha_vencimiento
end 	-- Fin del if @costo_insc del bloque then
else  
begin
	select @error ="Error al consultar Costo de Inscripción"
	goto error
end -- Fin: del if @costo_insc del bloque else

select	"costo_inscripcion" = @costo_insc,
			"costo_inscripcion_beca" = @costo_insc_beca,
 			"costo_aportacion" = @costo_aportacion,
			"pagos-devoluciones_insc" = @pagos_devoluciones_insc,
			"pagos_devoluciones_apor" = @pagos_devoluciones_apor,
			"anio_impresion" =  @anio_mov_alu,
			"periodo_impresion" = @periodo_mov_alu,
			"cve_concepto_inscripcion" = @concepto_inscripcion,
			"concepto_inscripcion" = @des_concepto_insc,
			"cve_concepto_aportacion" = @concepto_aportacion,
			"concepto_aportacion" = @des_concepto_apor,
			"fecha_vencimiento" = @fecha_vencimiento,
			"error" = null	
Return
 
error:
	select
		"costo_inscripcion" = 0,
		"costo_inscripcion_beca" = 0,
		"costo_aportacion" = 0,
		"pagos-devoluciones_insc" = 0,
		"pagos_devoluciones_apor" = 0,
		"anio_impresion" =  0,
		"periodo_impresion" = 0,
		"cve_concepto_inscripcion" = 0,
		"concepto_inscripcion" = 0,
		"cve_concepto_aportacion" = 0,
		"concepto_aportacion" = 0,
		"fecha_vencimiento" = null,
		"error" = @error	
