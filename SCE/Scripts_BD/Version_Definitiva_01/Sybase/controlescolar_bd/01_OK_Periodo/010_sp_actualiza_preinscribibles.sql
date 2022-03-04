USE controlescolar_bd
go

IF OBJECT_ID ('dbo.sp_actualiza_preinscribibles') IS NOT NULL
	DROP PROCEDURE dbo.sp_actualiza_preinscribibles
GO 

create procedure sp_actualiza_preinscribibles 
@tipo_periodo VARCHAR(3) 

as

declare
	@periodobase	int,
	@aniobase		int,
	@periodopre		int,
	@aniopre		int,
    @mensaje_error varchar(250),
	@num_error INT

-- Asignacion de variables 
begin 
--set chained off

	begin TRAN
	
		--Periodo mat_inscritas
		SELECT @periodobase = periodo, @aniobase = anio
		FROM periodos_por_procesos
		WHERE cve_proceso = 5
		AND tipo_periodo = @tipo_periodo 

		--Periodo preinscripcion
		SELECT @periodopre = periodo, @aniopre = anio
		FROM periodos_por_procesos
		WHERE cve_proceso = 3
		AND tipo_periodo = @tipo_periodo

		if @periodobase = @periodopre and @aniobase = @aniopre
		begin
			select @num_error = 20000, @mensaje_error = "Se encontró que el periodo de preinscripción es el mismo de las materias inscritas... favor de actualizar el periodo de preinscripción en periodos por proceso"
			goto EtiquetaError
		end 

		if @periodopre < @periodobase
		begin
			select @num_error = 20000, @mensaje_error = "Se encontró que el periodo de preinscripción es menor que las materias inscritas... favor de actualizar el periodo de preinscripción en periodos por proceso"
			goto EtiquetaError
		end 

		if @aniopre < @aniobase 
		begin
			select @num_error = 20000, @mensaje_error = "Se encontró que el periodo de preinscripción es menor que las materias inscritas... favor de actualizar el periodo de preinscripción en periodos por proceso"
			goto EtiquetaError
		end 

		Delete prueba
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = "Error al borrar prueba"
			goto EtiquetaError
		end 

		--Inscritos
		Insert into prueba
		select bins.cuenta,'' 
		from banderas_inscrito bins, 
			 academicos acdm, 
			 plan_estudios pes 
		WHERE bins.cuenta = acdm.cuenta 
		AND acdm.cve_carrera = pes.cve_carrera 
		AND acdm.cve_plan = pes.cve_plan 
		AND pes.tipo_periodo = @tipo_periodo

		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = "Error al insertar en Prueba los alumnos inscritos"
			goto EtiquetaError
		end 

		--Reingresos
		Insert into prueba
		select cuenta,'' 
		from hist_reingreso 
		where periodo_ing = @periodopre 
		and anio_ing = @aniopre 
		and cuenta not in (select cuenta from prueba)
		
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = "Error al insertar en Prueba los alumnos con reingreso"
			goto EtiquetaError
		end 

		if @periodopre = 2
			begin
				--Cortes solo cuando el periodo de reinscripcion es 2 (otoño)
				Insert into prueba
				select cuenta,'' 
				from cuentas_cortes 
				where periodo in (0,1) 
				and anio = @aniopre 
				and cuenta not in (select cuenta from prueba)
				if @@error != 0 
				begin
					select @num_error = 20000, @mensaje_error = "Error al insertar en Prueba los alumnos reingreso (otoño)"
					goto EtiquetaError
				end 
			end

		--Actualiza los que no tienen preinscripción
		update banderas
		set insc_sem_ant =0
		where insc_sem_ant =1
		and cuenta not in (select cuenta from prueba)

		--Actualiza los que si tienen preinscripción
		update banderas
		set insc_sem_ant =1
		where insc_sem_ant =0
		and cuenta in (select cuenta from prueba)

		update prueba
		set nivel = b.nivel
		from  academicos b, prueba bi
		where b.cuenta = bi.cuenta

		Commit Transaction 

		return 1

end


EtiquetaError:

	raiserror @num_error,  @mensaje_error

	Rollback Transaction 

	return -1
GO

GRANT EXECUTE ON sp_actualiza_preinscribibles TO g_se_administrador
go 

GRANT EXECUTE ON sp_actualiza_preinscribibles TO g_inf_admin
go 



