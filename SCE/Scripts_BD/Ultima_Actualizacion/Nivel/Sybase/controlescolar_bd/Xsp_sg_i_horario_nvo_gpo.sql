IF OBJECT_ID ('dbo.sp_sg_i_horario_nvo_gpo') IS NOT NULL
	DROP PROCEDURE dbo.sp_sg_i_horario_nvo_gpo
GO

create procedure sp_sg_i_horario_nvo_gpo @horas_reales int, @li_cve_mat int, @ls_gpo_nuevo varchar(03), @ai_periodo int, @ai_anio int
as
begin

 declare @horas_par  int,
		 @hora_simple int,
		 @hora_aux	 int

 declare @iCurRow    int,
         @iNumRows   int

 declare @iCurRowComb    int,
         @iNumMaxComb   int
         
 declare @iError    int

 declare @iNumComb  int,
		 @iCveDia 	int,
		 @iHrsClase int
		 
declare	 @iNumComb1 int,
		 @iCveDia1 int,
		 @iHrIni1 int,
		 @iIniHrPar1 int,
		 @iTotalRep1  int
		 
declare	 @iCveDia2 int,
		 @iHrIni2 int,
		 @iIniHrPar2 int,
		 @iTotalRep2  int
		 
declare  @horas_par_count  int,
		 @hora_simple_count int,
		 @iHoraIniMax int,
		 @iSolMaxima int,
		 @iAsignado int,
		 @iHorarioExiste int
		 
declare	 @iCurDiaPrio int,
		 @iTotHorariDia int,
		 @errmsg varchar(255),
		@iHoraFinalPos int

declare  @iHrIniAux int,
			@iTotGposHrDia int,
			@iHorarioNoValido int

 declare 	@iCurGpo	int,
         	@iNumGpo	int,
			@iDiaGpo	int,
			@iHoraGpo	int,
			@iHoraFinGpo int

declare	 @iNumCombMatR1 int,
		 @iHrIniMatR1 int,
		 @iContGruposMax1 integer,
		 @iContGruposMax2 integer

declare @iContCiclo integer,
		@iDiaConflicto1 integer,
		@iDiaConflicto2 integer,
		@iContConflic integer


declare @num_error integer,
		  @mensaje_error varchar(255)

SELECT @num_error = 20000


--/*Obtenemos cuantas horas reales de dos horas*/
select @horas_par = abs(@horas_reales / 2)

--/*Verificamos si existe una hora simple adicional (Mod)*/
select @hora_simple = @horas_reales % 2 

/*Se valida que el catalogo de proridad de horarios se encuentre completamente definido*/
select @iCurDiaPrio = 1,
	   @iTotHorariDia = 0
	   
while @iCurDiaPrio <= 5
begin
	
	select @iTotHorariDia = count(*)
	  from sg_horarios_priori
	 where cve_dia = @iCurDiaPrio
	
	if @iTotHorariDia <> 15
	begin
		select @errmsg = 'No esta bien definido el catalogo de prioridad de horarios'
		RAISERROR 20000, @errmsg
		rollback		
		return -1
		--break
	end

	select @iTotHorariDia = 0	
	select @iCurDiaPrio = @iCurDiaPrio + 1
end

DELETE FROM #tab_combdias
DELETE FROM #tab_horari
DELETE FROM #tab_result
DELETE FROM #hrs_full

select @iAsignado = 0

INSERT INTO #tab_combdias
SELECT num_combinacion, cve_dia, horas_clase
  FROM sg_param_dias_horarios
 WHERE  horas_reales  = @horas_reales
 ORDER by num_combinacion
 
 select @iCurRow  = min(id_sol),
        @iNumRows = max(id_sol)
  FROM #tab_combdias
  
--Procesa Solicitudes 

   while @iCurRow <= @iNumRows And @iCurRow <> -1
     begin
       /* Consultar los valores*/
       Select @iNumComb = num_combinacion,
			  @iCveDia = cve_dia,
			  @iHrsClase = horas_clase
       From   #tab_combdias
       where  id_sol = @iCurRow
       
	  Insert into #tab_horari
	  Select @iNumComb, cve_dia, hora_inicio, prioridad, 1
	    From sg_horarios_priori
	  Where cve_dia = @iCveDia
		 And hora_inicio in (Select h.hora_inicio
							   From sg_param_horas_inicio h
							  Where h.horas_clase =  @iHrsClase)
		And (hora_inicio + @iHrsClase) <= 22
		And hora_inicio between 7 and 21
		
	If @iHrsClase = 2 Or @iHrsClase = 3
	Begin
	   Insert into #tab_horari
	   Select @iNumComb, cve_dia, hora_inicio, prioridad, 0
	    From sg_horarios_priori
	  Where cve_dia = @iCveDia
		 And hora_inicio in (Select (h.hora_inicio + 1)
							   From sg_param_horas_inicio h
							  Where h.horas_clase = @iHrsClase
								And h.hora_inicio <> 13)
		And (hora_inicio + @iHrsClase) <= 22
		And hora_inicio between 7 and 20
		 
	End
  
--       /* Proceso con los valores*/
--       if @iError <> 0
--         break

       /* Siguiente registro*/
       Select @iCurRow = IsNull(min(id_sol),-1) FROM #tab_combdias WHERE id_sol > @iCurRow
     end  --Fin del Ciclo de Procesamiento

--   /* Tratamiento del error*/
end

/*En esta seccion cargamos las horas/dias que ya estan saturadas y no se deben de asignar mas grupos*/
insert into #hrs_full
Select IsNull(count(*),0)as total, h.cve_dia, h.hora_inicio
  From  sg_horario h
 Where  h.clase_aula = 0
   Group by h.hora_inicio, h.cve_dia
   Having IsNull(count(*),0) >= 200

Select @iCurRowComb  = min(num_combinacion),
       @iNumMaxComb = max(num_combinacion)
  From #tab_combdias
 
While @iCurRowComb <= @iNumMaxComb
Begin
	IF exists (select * from 
			(SELECT  cve_dia ,  hora_inicio ,  hora_final, IsNull(count(*),0) as registro
			FROM sg_horario
			WHERE cve_mat = @li_cve_mat
			AND periodo = @ai_periodo 
			AND anio = @ai_anio
			GROUP BY cve_dia ,  hora_inicio , hora_final
			HAVING IsNull(COUNT(*),0) <
			(
			select max(reg)
			FROM 
			(select IsNull(count(*),0) reg
			from sg_horario 
			WHERE cve_mat = @li_cve_mat
			AND periodo = @ai_periodo 
			AND anio = @ai_anio
			group by  cve_dia ,  hora_inicio , hora_final ) as maS)) AS dispon)
	BEGIN

		insert into #tab_result
		select num_combinacion,
			   t.cve_dia,
			   t.hora_inicio, 
			   prioridad,
			   inicio_hr_par,
			   IsNull(count(*),0) as total_rep
		  from #tab_horari t LEFT JOIN 
	
				(SELECT  cve_dia ,  hora_inicio , hora_final, IsNull(count(*),0) as registro
				FROM sg_horario
				WHERE cve_mat = @li_cve_mat
				AND periodo = @ai_periodo 
				AND anio = @ai_anio
				GROUP BY cve_dia ,  hora_inicio  , hora_final
				HAVING COUNT(*) <
				(
				select max(reg)
				FROM 
				(select IsNull(count(*),0) reg
				from sg_horario 
				WHERE cve_mat = @li_cve_mat
				AND periodo = @ai_periodo 
				AND anio = @ai_anio
				group by  cve_dia ,  hora_inicio , hora_final ) as maS)) AS dispon 	ON t.cve_dia = dispon.cve_dia AND t.hora_inicio = dispon.hora_inicio
		  
		  
		  where num_combinacion = @iCurRowComb
	
		  AND dispon.hora_final is not null
	
		  group by t.hora_inicio
		  having num_combinacion = @iCurRowComb
		  order by num_combinacion, prioridad, count(*) desc
	END
		  
	ELSE
	BEGIN
	
		insert into #tab_result
		select num_combinacion,
			   t.cve_dia,
			   t.hora_inicio, 
			   prioridad,
			   inicio_hr_par,
			   IsNull(count(*),0) as total_rep
		  from #tab_horari t 
		  where num_combinacion = @iCurRowComb
--		  and not exists (select 1 from #hrs_full h where h.cve_dia = t.cve_dia and h.hora_inicio = t.hora_inicio)
		  group by t.hora_inicio
		  having num_combinacion = @iCurRowComb
		  and not exists (select 1 from #hrs_full h where h.cve_dia = t.cve_dia and h.hora_inicio = t.hora_inicio)		  
		  order by num_combinacion, prioridad, count(*) desc
	END
	  
	select @iCurRowComb	= @iCurRowComb + 1
End

--select *
--from #tab_result


select @horas_par_count = 0

Select @iSolMaxima = 0

/*Elección de horarios disponibles*/
	select @iContConflic = 1

		
		DECLARE CUR_HORARIOS CURSOR FOR
		SELECT id_sol,
			   num_combinacion,
			   cve_dia,
			   hora_inicio, 
			   inicio_hr_par,
			   total_rep
		 FROM #tab_result
		ORDER BY id_sol
		
		OPEN CUR_HORARIOS
		
		FETCH CUR_HORARIOS INTO @iCurRow, @iNumComb1, @iCveDia1, @iHrIni1, @iIniHrPar1, @iTotalRep1


		if (@@sqlstatus = 2)
		begin
		
			 select @num_error = 20000,
					  @mensaje_error = "No existen movimientos a Procesar cursor: CUR_HORARIOS "
			 CLOSE CUR_HORARIOS
			 GOTO EtqFin
		end

		if (@@sqlstatus = 1) 
		begin
			select @num_error = 20000, 
		 			@mensaje_error = "Error de lectura en el cursor: CUR_HORARIOS"
			CLOSE CUR_HORARIOS
			GOTO EtqErrorPrincipal
		end


		
		WHILE (@@sqlstatus = 0)
		BEGIN

	select @iHorarioNoValido = 0

	/*Validacion de numero máximo de grupos disponibles */
	  If @iIniHrPar1 = 1
	  Begin
--		 Select @iTotGposHrDia = 0

		 Select @iCurGpo = 0,
				  @iNumGpo = 0,
				  @iDiaGpo = 0,
				  @iHoraGpo = 0,
				  @iHoraFinGpo = 0


		SELECT @iContCiclo = 1 
		
		DECLARE CUR_VALIDATOT CURSOR FOR
		
		SELECT lim_horas.cve_dia, hora, hora_final
		  FROM sagi_hora sh, (SELECT cve_dia,horas_clase, @iHrIni1 as hora_inicio, (@iHrIni1 + horas_clase) as hora_final
									    FROM sg_param_dias_horarios
						  			  WHERE num_combinacion = @iNumComb1
										  AND horas_reales  = @horas_reales) as lim_horas
		WHERE ( sh.hora  >= lim_horas.hora_inicio 
			AND sh.hora < lim_horas.hora_final )
		ORDER BY lim_horas.cve_dia, hora

		OPEN	CUR_VALIDATOT	
		
		FETCH CUR_VALIDATOT INTO @iCurGpo, @iHoraGpo, @iHoraFinGpo

		if (@@sqlstatus = 2)
		begin
			 CLOSE CUR_VALIDATOT
			 GOTO EtqContPrincipal
		end

		if (@@sqlstatus = 1) 
		begin
			select @num_error = 20000, 
		 			@mensaje_error = "Error de lectura en el cursor: CUR_VALIDATOT"
			CLOSE CUR_VALIDATOT
			CLOSE CUR_HORARIOS
			GOTO EtqErrorHijo
		end


		WHILE (@@sqlstatus = 0) AND @iContCiclo = 1
		BEGIN

--				PRINT 'ENTRA CUR_VALIDATOT'
--				PRINT "MATERIA @li_cve_mat int, %1!", @li_cve_mat
--				PRINT "GRUPO @ls_gpo_nuevo, %1!", @ls_gpo_nuevo
--				PRINT "DIA @iCurGpo, %1!", @iCurGpo
--				PRINT "HORA INI @iHoraGpo, %1!", @iHoraGpo
--				PRINT "HORA FIN @iHoraFinGpo, %1!", @iHoraFinGpo

		 	Select @iTotGposHrDia = 0
			
			
			Select @iTotGposHrDia = IsNull(count(*),0)
			From sg_horario h, sagi_hora sh
			Where ( sh.hora  >= h.hora_inicio and sh.hora <  h.hora_final )
			And h.periodo = @ai_periodo
			And h.anio= @ai_anio
			And h.clase_aula =0
			And h.cve_dia = @iCurGpo
			And sh.hora = @iHoraGpo

--			If @iTotGposHrDia >= 250
			If @iTotGposHrDia >= 270
			Begin
--				PRINT '  ------    ENTRO VALIDA   -------------------------------------------'
--				PRINT "@iTotGposHrDia, %1!", @iTotGposHrDia  
				/*Se pone la bandera como si fuera un horario no valido para inicio de clase*/
				Select @iIniHrPar1 = 0
				select @iHorarioNoValido = 1
				SELECT @iContCiclo = 0
--				PRINT "MATERIA @li_cve_mat int, %1!", @li_cve_mat
--				PRINT "GRUPO @ls_gpo_nuevo, %1!", @ls_gpo_nuevo
--				PRINT "HORAINICIO @iHoraGpo, %1!", @iHoraGpo
--				PRINT "HORAFIN @iHoraFinGpo, %1!", @iHoraFinGpo
--				PRINT "DIA @iCurGpo, %1!", @iCurGpo  
				CLOSE CUR_VALIDATOT
				DEALLOCATE CUR_VALIDATOT
				GOTO EtqContPrincipal
			End

			--Select @iCurGpo = @iCurGpo + 1
			FETCH CUR_VALIDATOT INTO @iCurGpo, @iHoraGpo, @iHoraFinGpo

			if (@@sqlstatus = 1) 
			begin
				CLOSE CUR_VALIDATOT
				GOTO EtqErrorHijo
			end

		END --While

		CLOSE CUR_VALIDATOT
		DEALLOCATE CUR_VALIDATOT
	  End

		/*Primero validamos que la hora final de clase no exceda el horario normal de clases*/
	  If @iIniHrPar1 = 1
	  Begin
		Select @iHoraFinalPos = 0

	      Select @iHoraFinalPos = @iHrIni1 + horas_clase
		   From sg_param_dias_horarios
	     Where num_combinacion = @iNumComb1
			And horas_reales  = @horas_reales

		If @iHoraFinalPos >= 23
		Begin
			/*Se pone la bandera como si fuera un horario no valido para inicio de clase porque la hora final esta fuera de horario*/
			Select @iIniHrPar1 = 0
			select @iHorarioNoValido = 1
		End
	  End

		--PRINT "ANTES INSERT1, %1!", @iIniHrPar1
		--PRINT "ANTES INSERT2, %1!", @iHorarioNoValido
       If @iIniHrPar1 = 1 and @iHorarioNoValido = 0
       Begin
	
			  /*Verificamos si ya existe un horario asignado para esa materia en los horarios de esa combinacion de días*/
			  Select @iHorarioExiste = IsNull(count(*),0)
				From sg_horario
			   Where hora_inicio  = @iHrIni1
				 And cve_mat = @li_cve_mat
				 And cve_dia in (Select cve_dia  
								   From sg_param_dias_horarios
								   Where num_combinacion = @iNumComb1
								   and horas_reales  = @horas_reales)
				 				 
			  If @iHorarioExiste > 0 
			  Begin
			  	
--			  	
			  	If @iSolMaxima = 0 
			  	Begin
			  		select @iSolMaxima = @iContConflic
			  		
			  		select @iNumCombMatR1 = @iNumComb1,
						   @iHrIniMatR1 = @iHrIni1

			  	End
			  End
			  Else
			  Begin

				IF @iIniHrPar1 = 1 And @iHorarioNoValido = 0 
				Begin
					
					Select @iContGruposMax1 = (@iHrIni1 + horas_clase) 
					  From sg_param_dias_horarios
					 Where num_combinacion = @iNumComb1
						  And horas_reales  = @horas_reales

					IF @iContGruposMax1 <= 22 
					BEGIN

						 /*Insertar horario*/
						Insert into sg_horario
						Select		cve_mat 	= @li_cve_mat,
									gpo 		= @ls_gpo_nuevo,
									periodo 	= @ai_periodo,
									anio 		= @ai_anio,
									cve_dia,
									cve_salon 	= null,
									hora_inicio = @iHrIni1,
									hora_final 	= (@iHrIni1 + horas_clase),
									clase_aula 	= 0
							   From sg_param_dias_horarios
							  Where num_combinacion = @iNumComb1
								And horas_reales  = @horas_reales

						IF @@error != 0 
						BEGIN
							select @num_error = 20000, @mensaje_error = "Error al insertar sg_horario en cursor: cursor_gpos_horario."
							close CUR_HORARIOS
							GOTO EtqErrorPrincipal
						END
	
						/*Obtenemos el horario propuesto en base a prioridades*/
						select @iAsignado = 1
						CLOSE CUR_HORARIOS
						GOTO EtqFin
					END
				End
			  End
       End

	   EtqContPrincipal:

       --Select @iCurRow = @iCurRow + 1
	   FETCH CUR_HORARIOS INTO @iCurRow, @iNumComb1, @iCveDia1, @iHrIni1, @iIniHrPar1, @iTotalRep1
		if (@@sqlstatus = 1) 
		begin
			CLOSE CUR_HORARIOS
			GOTO EtqErrorPrincipal
		end

	   select @iContConflic = @iContConflic + 1

END /*While*/

		CLOSE CUR_HORARIOS
		
		DEALLOCATE CUR_HORARIOS

		/*En caso de que la unica opcion existente sea la mas utilizada se vuelve a asignar la misma combinacion dias+horarios*/
       	 If @iSolMaxima > 0 and @iAsignado = 0
       	 Begin
       	 	
--       	 	Select @iNumCombMatR1  = num_combinacion,
--				   @iHrIniMatR1    = hora_inicio
--			  From #tab_result
--			 Where id_sol = @iSolMaxima


			IF @iIniHrPar1 = 1 And @iHorarioNoValido = 0
			Begin
				/*Obtenemos el horario propuesto en base a prioridades*/
				 /*Insertar horario*/
				--PRINT "INSERT1@iTotGposHrDia, %1!", @iTotGposHrDia
				
					Select @iContGruposMax1 = (@iHrIniMatR1 + horas_clase) 
					  From sg_param_dias_horarios
					 Where num_combinacion = @iNumCombMatR1
						  And horas_reales  = @horas_reales

					IF @iContGruposMax1 <= 22 
					BEGIN

					Insert into sg_horario
					Select		cve_mat 	= @li_cve_mat,
								gpo 		= @ls_gpo_nuevo,
								periodo 	= @ai_periodo,
								anio 		= @ai_anio,
								cve_dia,
								cve_salon 	= null,
								hora_inicio = @iHrIniMatR1,
								hora_final 	= (@iHrIniMatR1 + horas_clase),	
								clase_aula 	= 0
						   From sg_param_dias_horarios
						  Where num_combinacion = @iNumCombMatR1
							And horas_reales  = @horas_reales							
								
	
					 select @iAsignado = 1
					GOTO EtqFin
				END
				 
			End



return 0

EtqFin:
RETURN 0

EtqErrorPrincipal:
	raiserror @num_error,  @mensaje_error
	DEALLOCATE CUR_HORARIOS
	Rollback Transaction
	return -1

EtqErrorHijo:
	raiserror @num_error,  @mensaje_error
	DEALLOCATE CUR_VALIDATOT
--	DEALLOCATE CUR_HORARIOS
	Rollback Transaction
	return -1

End
GO
GRANT EXECUTE ON dbo.sp_sg_i_horario_nvo_gpo  TO public
GO


