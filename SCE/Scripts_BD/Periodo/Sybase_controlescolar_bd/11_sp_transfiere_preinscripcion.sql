
IF OBJECT_ID ('dbo.sp_transfiere_preinscripcion') IS NOT NULL
	DROP PROCEDURE dbo.sp_transfiere_preinscripcion
GO  	

create procedure sp_transfiere_preinscripcion 
@tipo_periodo VARCHAR(3) 

as

declare

	@periodobase	int,
	@aniobase		int,
	@periodopre		int,
	@aniopre		int,
    @mensaje_error varchar(250),
	@num_error INT,
	@numregs		int,
	@desc_periodo	varchar(10)

-- Asignacion de variables 

begin 

--set chained off

	begin tran

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

		select @numregs = count(*)
		from hist_preinsc 
		WHERE periodo = @periodobase
		and anio = @aniobase 
		

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

		if @numregs > 0
		BEGIN
		
			/*Se obtiene la decodificación del periodo*/
			SELECT @desc_periodo = descripcion + convert(char(4),@aniobase) 
			FROM periodo 
			WHERE periodo = @periodobase
		
			/*if @periodobase = 0 select @desc_periodo = 'Primavera ' + convert(char(4),@aniobase)
			if @periodobase = 1 select @desc_periodo = 'Verano ' + convert(char(4),@aniobase)
			if @periodobase = 2 select @desc_periodo = 'Otoño ' + convert(char(4),@aniobase)*/

			select @num_error = 20000, @mensaje_error = "Ya existen registros en hist_preinsc del periodo: " + @desc_periodo
			goto EtiquetaError

		end 	

	

		/* Adaptive Server has expanded all '*' elements in the following statement */ 
		
		INSERT INTO hist_preinsc
		select preinsc.cuenta, 
			preinsc.folio, 
			preinsc.status, 
			preinsc.periodo, 
			preinsc.anio, 
			preinsc.noimpresiones 
		from preinsc 
		WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		
		if @@error != 0 

		begin
			select @num_error = 20000, @mensaje_error = "Error al insertar en hist_preinsc"
			goto EtiquetaError
		end 



		INSERT INTO hist_mat_preinsc
		select cuenta,
			cve_mat,
			gpo,
			status,
			periodo,
			anio
		from mat_preinsc 
		WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo)
		
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = "Error al insertar en hist_mat_preinsc"
			goto EtiquetaError
		end 
		
		delete from preinsc
		WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = "Error al borrar preinsc"
			goto EtiquetaError
		end 

		Delete mat_preinsc 
		WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = "Error al borrar mat_preinsc"
			goto EtiquetaError
		end 

		Commit Transaction 

		return 0

end



EtiquetaError:

	raiserror @num_error,  @mensaje_error

	Rollback Transaction 

	return -1
GO


GRANT EXECUTE ON sp_transfiere_preinscripcion TO g_se_administrador
go 

GRANT EXECUTE ON sp_transfiere_preinscripcion TO g_inf_admin
go 




