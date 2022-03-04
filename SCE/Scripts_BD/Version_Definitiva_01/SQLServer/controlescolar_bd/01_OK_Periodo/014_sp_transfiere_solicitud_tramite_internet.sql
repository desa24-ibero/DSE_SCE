use controlescolar_bd
GO
 
ALTER procedure sp_transfiere_solicitud_tramite_internet 
@tipo_periodo VARCHAR(3) 
as
declare
	@periodobase	int,
	@aniobase		int,
	@periodores		int,
	@aniores		int,
    @mensaje_error varchar(250),
	@num_error INT,
	@numregs		int,
	@desc_periodo	varchar(10),
    @ErrorSeverity INT,
    @ErrorState INT, 
	@periodomin	int,
	@periodomax	int
-- Asignacion de variables 

begin 
	begin tran
		--Periodo Baja total
		SELECT @periodobase = periodo, @aniobase = anio
		FROM periodos_por_procesos
		WHERE cve_proceso = 11
		AND tipo_periodo = @tipo_periodo

		--Periodo a respaldar
		/*if @periodobase = 0 
			begin
				select @aniores =  @aniobase - 1
				select @periodores = 2
			end 
		else
			begin
				select @aniores =  @aniobase
				select @periodores = @periodobase - 1 
			end*/

		-- Se recupera el periodo anterior 
		SELECT @periodomin = MIN(periodo), @periodomax = MAX(periodo)
		FROM periodo
		WHERE tipo = @tipo_periodo
		
		IF @periodobase = @periodomin 
			BEGIN
				SELECT @periodores = @periodomax  
				SELECT @aniores = @aniobase - 1 
			END
		ELSE
			BEGIN
				SELECT @periodores = MAX(periodo)
				FROM periodo
				WHERE tipo = @tipo_periodo
				AND periodo < @periodobase

				select @aniores =  @aniobase

			END

		select @numregs = count(*)
		from hist_solicitud_tramite_internet
		WHERE periodo = @periodores
		and anio = @aniores 
	
		if @numregs > 0
		begin
			/*if @periodores = 0 select @desc_periodo = 'Primavera ' + convert(char(4),@aniores)
			if @periodores = 1 select @desc_periodo = 'Verano ' + convert(char(4),@aniores)
			if @periodores = 2 select @desc_periodo = 'Otoño ' + convert(char(4),@aniores)*/
			
			SELECT @desc_periodo = (SELECT descripcion FROM periodo WHERE periodo = @periodores) + ' ' + convert(char(4),@aniores)
			
			select @mensaje_error = 'Ya existen registros en hist_solicitud_tramite_internet: ' + @desc_periodo 
			goto EtiquetaError
		end 	
	
		INSERT INTO hist_solicitud_tramite_internet
		select   cuenta,cve_carrera,cve_plan,cve_tramite,fecha,respuesta,periodo,anio,cve_estatus_solicitud_tramite,motivo,num_intentos  
		    FROM solicitud_tramite_internet   
		    WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		    
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = 'Error al insertar en hist_solicitud_tramite_internet'
			goto EtiquetaError
		end 

		delete from solicitud_tramite_internet
		WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = 'Error al borrar solicitud_tramite_internet'
			goto EtiquetaError
		end 
	
		Commit Transaction 
		
		return 0

end

EtiquetaError:
	select @ErrorSeverity = 16,	@ErrorState = 1
	RAISERROR (@mensaje_error, @ErrorSeverity, @ErrorState)
	Rollback Transaction 
	return -1


GO

