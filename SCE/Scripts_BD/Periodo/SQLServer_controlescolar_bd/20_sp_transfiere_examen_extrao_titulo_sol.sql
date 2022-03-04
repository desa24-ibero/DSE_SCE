
use controlescolar_bd
go


 

ALTER procedure sp_transfiere_examen_extrao_titulo_sol 
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
	@periodomin INT, 
	@periodomax INT 
-- Asignacion de variables 

begin 
	begin tran
		--Periodo Examen extraoprdinario y titulo de suficiencia
		SELECT @periodobase = periodo, @aniobase = anio
		FROM periodos_por_procesos
		WHERE cve_proceso = 12
		AND tipo_periodo = @tipo_periodo 
		
		/*--Periodo a respaldar
		if @periodobase = 0 
			begin
				select @aniores =  @aniobase - 1
				select @periodores = 2
			end 
		else if @periodobase = 3
			begin
				select @aniores =  @aniobase - 1
				select @periodores = 6
			end 		 
		else
			begin
				select @aniores =  @aniobase
				select @periodores = @periodobase - 1 
			end*/

		--Periodo a respaldar
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
		from hist_examen_extrao_titulo_sol
		WHERE periodo = @periodores
		and anio = @aniores 
	
		if @numregs > 0
		begin
			/*if @periodores = 0 select @desc_periodo = 'Primavera ' + convert(char(4),@aniores)
			if @periodores = 1 select @desc_periodo = 'Verano ' + convert(char(4),@aniores)
			if @periodores = 2 select @desc_periodo = 'Otoño ' + convert(char(4),@aniores)*/
			
			SELECT @desc_periodo = (SELECT descripcion FROM periodo WHERE periodo = @periodores) + ' ' + convert(char(4),@aniores) 
			
			select @mensaje_error = 'Ya existen registros en hist_examen_extrao_titulo_sol: ' + @desc_periodo 
			goto EtiquetaError
		end 	
	
		INSERT INTO hist_examen_extrao_titulo_sol
		select   cuenta,cve_mat,gpo,periodo,anio,calificacion,tipo_examen,cve_condicion,autorizado,fecha_autorizado,pagado,num_horas,cve_concepto,fecha_pago,order_num,asociado  
		    FROM examen_extrao_titulo_sol   
		    WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		    
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = 'Error al insertar en hist_examen_extrao_titulo_sol'
			goto EtiquetaError
		end 

		delete from examen_extrao_titulo_sol
		WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo)  
		
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = 'Error al borrar examen_extrao_titulo_sol'
			goto EtiquetaError
		end 
	
		INSERT INTO hist_examen_extrao_titulo
		select   cuenta,cve_mat,gpo,periodo,anio,calificacion,tipo_examen,cve_condicion
		    FROM examen_extrao_titulo   
		    WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		    
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = 'Error al insertar en hist_examen_extrao_titulo'
			goto EtiquetaError
		end 

		delete from examen_extrao_titulo
		WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo) 
		
		if @@error != 0 
		begin
			select @num_error = 20000, @mensaje_error = 'Error al borrar examen_extrao_titulo'
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

