IF OBJECT_ID ('dbo.sp_crear_grupos') IS NOT NULL
	DROP PROCEDURE dbo.sp_crear_grupos
GO

CREATE PROCEDURE dbo.sp_crear_grupos @ai_minimo_aumentar_cupo Int, @ai_margen_abrir_nvo_gpo Int, @ai_cupo_nvo_gpo Int, @ai_anio Int, @ai_periodo Int
AS

DECLARE @li_cve_mat             Int,
        @li_cant_solicitantes   Int,
        @li_cupo_ofrecido       Int,
        @lc_nivel               Char,
        @ai_cupo_incrementado   Int,
        @li_cupo_adicional_req  Int,
        @li_gpo_creado          int,
        @lc_gpo_incrementar     VarChar(10),
        @li_num_gpos_creados    int,
        @li_nuevo_cupo_req      int,
        @ai_ascii               int,
        @li_hay_horarios_1      int,
        @li_hay_horarios_2      Int,
        @li_dia_a_crear         Int,
        @li_primer_hora_inicio  Int,
        @li_continuar           Int,
        @li_cambiar_dia         Int,
		@li_creditos			Int,
		@ls_clase_aula			Varchar(10),
		@li_procesar			Int,
		@li_periodo_ant			Int,
		@li_anio_ant			Int,
		@li_hay_en_hist			Int,
		@li_hay_en_teoria		Int,
		@li_hay_en_lab			Int,
		@ls_mensaje        		Varchar(100),
		@li_es_asimilante		Int,
		@li_cve_asimilada		Int,
		@ls_gpo_asimilado		Varchar(3),
		@ls_gpo_incrementar		Varchar(3),
		@ls_gpo_nuevo			Varchar(3),
		@ls_gpo					Varchar(3),
		@as_gpo					Varchar(2),
		@li_ret_sp				integer,
		@ls_print				varchar(50),
		@li_num_gpos_salon		integer,
		@li_cve_mat_cupo		integer,
		@ls_gpo_cupo			Varchar(3),
		@li_cupo_cupo			Integer,
		@ls_cve_salon_cupo		Varchar(10),
		@ls_clase_aula_cupo		Varchar(10),
		@li_tipo_cupo			integer,
		@lc_mas_cupos			Varchar(2),
		@li_mas_cupos			Integer,
		@li_ciclo				Integer,
		@li_cant_inc_cupo		Integer,
		@li_incrementos_de		integer,
		@li_contador			Integer,
		@li_num_gpos			Integer,
		@ls_gpo_clonar			Varchar(5),
		@li_horas_reales		Integer,
		@li_gpos_disponibles	Integer,
		@iHorariosCreados	Integer
		

delete from sg_nuevos_grupos

-- Obtener el periodo anterior ...
IF @ai_periodo = 0
Begin
	Select @li_periodo_ant = 2
	Select @li_anio_ant = @ai_anio - 1
End
ELSE
Begin
	Select @li_periodo_ant = @ai_periodo - 1
	Select @li_anio_ant = @ai_anio
End

--Select @ls_mensaje = 'Periodo Ant : ' + Cast(@li_periodo_ant as Varchar)
--Print @ls_mensaje


-- Obtener las cantidades de materias que no alcanzan en los cupos ofrecidos ...
DECLARE cur_solicitantes_vs_ofertantes CURSOR FOR
Select		cve_mat,
			( select creditos from materias where materias.cve_mat = sg_mat_preinsc.cve_mat ) creditos,
			Count(cuenta) solicitan_materias,
			IsNull ( (Select sum(sg_grupos.cupo) from sg_grupos where sg_grupos.cve_mat = sg_mat_preinsc.cve_mat and sg_grupos.tipo <> 2 ) , -1 ) cupo_ofrecido,
			(Select nivel from materias where materias.cve_mat = sg_mat_preinsc.cve_mat) nivel
From		sg_mat_preinsc
--where   cve_mat = 20624
--where   cve_mat = 21555
Group By 	cve_mat
Having		Count(cuenta) > IsNull ( (Select sum(sg_grupos.cupo) from sg_grupos where sg_grupos.cve_mat = sg_mat_preinsc.cve_mat and sg_grupos.tipo <> 2 ) , -1 )
Order By	cve_mat

OPEN cur_solicitantes_vs_ofertantes

FETCH NEXT FROM cur_solicitantes_vs_ofertantes INTO @li_cve_mat, @li_creditos, @li_cant_solicitantes, @li_cupo_ofrecido, @lc_nivel

WHILE (@@FETCH_STATUS = 0) BEGIN

	Select @li_procesar = 1
	
	IF @li_creditos = 0
	BEGIN
		
		-- Se asume que no se procesa ...
		Select @li_procesar = 0
		
		-- Primero verificar si existen en el historico con calificacion aprobatoria ...
		Select	@li_hay_en_hist = Count(*) 
		From	historico,
				sg_calificaciones
		Where	cve_mat = @li_cve_mat and
				anio = @li_anio_ant and
				periodo = @li_periodo_ant and
				historico.calificacion = sg_calificaciones.calificacion
		
		-- Si hay en el histórico, se procesan ...
		IF @li_hay_en_hist > 0
		Begin
			Select @li_procesar = 1
		End
		
		-- Si NO hay en el histórico, buscar en la tabla teoria_lab ...
		IF @li_hay_en_hist = 0
		Begin
			
			-- Primero se verifica si existe en teoria, se asume que ya estan cursadas ...
			Select	@li_hay_en_teoria = Count (*)
			From	teoria_lab
			Where	cve_teoria = @li_cve_mat
			
			-- Luego se verifica si existe en laboratorio, se asume que ya estan cursadas ...
			Select	@li_hay_en_lab = Count (*)
			From	teoria_lab
			Where	cve_lab = @li_cve_mat
		
			-- Si hay cursados en teoria o en lab, se asume que la materia debe ser considerada ..
			IF @li_hay_en_teoria > 0
			Begin
				Select @li_procesar = 1
			End
			
			IF @li_hay_en_teoria > 0
			Begin
				Select @li_procesar = 1
			End
				
		End
		
	END		-- De IF @li_creditos > 0
	
	IF @li_procesar = 1
	Begin
		-- Inicializar @ls_clase_aula ...
		select @ls_clase_aula = ''
		
		-- El valor -1 indica que no existen grupos y que hay que crearlos ...
		if @li_cupo_ofrecido = -1
		begin
			select @li_cupo_adicional_req = 0
		end
		else
		begin
			select @li_cupo_adicional_req = @li_cupo_ofrecido
		end

		-- Obtener la cantidad de solicitantes que no tienen grupo ...
		select @li_cupo_adicional_req = @li_cant_solicitantes - @li_cupo_adicional_req

		-- los grupos QUE NO EXISTEN se crean solo para nivel Licenciatura ...
		select @li_gpo_creado = 0
		/*if @lc_nivel= 'L' and @li_cupo_ofrecido = -1*/
		if @lc_nivel <> 'P' and @li_cupo_ofrecido = -1
		begin
			select @li_gpo_creado = 1
		end
		
		-- Si el CUPO ADICIONAL REQUERIDO (@li_cupo_adicional_req) es mayor o igual que el MÍNIMO PARA AUMENTAR CUPO (@ai_minimo_aumentar_cupo)
		-- y menor que el MARGEN PARA ABRIR NUEVO GRUPO ( @ai_margen_abrir_nvo_gpo ) entonces solo se aumentara el cupo de un grupo ...
		select @li_cant_inc_cupo = 0
		Select @ai_cupo_incrementado = 0
		Select @lc_gpo_incrementar = null
		--if ( @li_cupo_adicional_req < @ai_margen_abrir_nvo_gpo ) and @li_cupo_ofrecido > -1 -- Se descartan los -1 por que son grupos que no exísten
		if ( @li_cupo_adicional_req >= @ai_minimo_aumentar_cupo and @li_cupo_adicional_req < @ai_margen_abrir_nvo_gpo ) and @li_cupo_ofrecido > -1 -- Se descartan los -1 por que son grupos que no exísten
		begin
		
			-- Obtener el número de salones con clase de aula 'SALON' con la misma materia ...
			Select		@li_num_gpos_salon = IsNull ( Sum ( Count ( distinct sg_grupos.cve_mat ) ) , 0 )
			From		sg_grupos,
						sg_horario,
						salon
			Where		sg_grupos.cve_mat		= @li_cve_mat AND
						sg_grupos.cve_mat		= sg_horario.cve_mat AND
						sg_grupos.gpo			= sg_horario.gpo AND
						sg_grupos.anio			= sg_horario.anio AND
						sg_grupos.periodo		= sg_horario.periodo AND
						sg_horario.cve_salon	= salon.cve_salon AND
						salon.clase_aula 		= 'SALON'
			Group By	sg_grupos.cve_mat, sg_grupos.gpo
			
			Select @lc_mas_cupos = 'SI'
			Select @li_mas_cupos = 0
			Select @li_ciclo = 0
		
--			While @li_mas_cupos <= @li_cupo_adicional_req
--			Begin
--Select @li_mas_cupos = @li_cupo_adicional_req			
				Select @li_ciclo = @li_ciclo + 1
				
				DECLARE cur_grupos_x_materia CURSOR FOR
				Select		distinct sg_grupos.cve_mat, sg_grupos.gpo, sg_grupos.cupo, sg_horario.cve_salon, IsNull ( salon.clase_aula , 'NA') as clase_aula, sg_grupos.tipo
				From		sg_grupos,
							sg_horario,
							salon
				Where		sg_grupos.cve_mat		= @li_cve_mat AND
							sg_grupos.cve_mat		*= sg_horario.cve_mat AND
							sg_grupos.gpo			*= sg_horario.gpo AND
							sg_grupos.anio			*= sg_horario.anio AND
							sg_grupos.periodo		*= sg_horario.periodo AND
							sg_horario.cve_salon	*= salon.cve_salon
				Order By	sg_grupos.cupo, sg_grupos.gpo
				
				
				OPEN cur_grupos_x_materia

				FETCH NEXT FROM cur_grupos_x_materia INTO @li_cve_mat_cupo,	@ls_gpo_cupo, @li_cupo_cupo, @ls_cve_salon_cupo, @ls_clase_aula_cupo, @li_tipo_cupo

				Select @li_contador = 0
				if @li_num_gpos_salon > 0
				begin
					Select @li_incrementos_de = Ceiling ( Convert ( float , Convert ( decimal , @li_cupo_adicional_req ) / Convert ( decimal , @li_num_gpos_salon ) ) )

				end
				else
				begin
					Select @li_incrementos_de = 0
				end

				WHILE (@@FETCH_STATUS = 0) BEGIN
					if @li_contador = @li_cupo_adicional_req 
					begin
						Select @li_incrementos_de = 0
					end
					
					if @ls_clase_aula_cupo = 'SALON'
					Begin
						Select @li_contador = @li_contador + @li_incrementos_de
					End
					
					if @li_contador > @li_cupo_adicional_req 
					begin
						Select @li_incrementos_de = @li_cupo_adicional_req - ( @li_contador - @li_incrementos_de )
					end

					-- Se incrementa el cupo solo a los horarios que tienen asignada una clase de aula 'SALON' y tipo salon NORMAL ó ASIMILADO...
					-- 11 Enero 2013, no se consideran los tipo 1 (ASESORIA) para incrementar cupo ...
					if ( @ls_clase_aula_cupo = 'SALON' ) and ( @li_tipo_cupo = 0 or @li_tipo_cupo = 2 )
					Begin
						-- Si solo existe un grupo, se incrementa el total del cupo a ese grupo ...
						if @li_num_gpos_salon = 1 --and @lc_mas_cupos = 'SI'
						begin
						
							Select @lc_mas_cupos = 'NO'
							Select @li_mas_cupos = @li_cupo_adicional_req
							
							Update	sg_grupos
							Set		cupo = cupo + @li_cupo_adicional_req
							Where	cve_mat = @li_cve_mat and
									gpo = @ls_gpo_cupo
									
							-- Si el grupo es asimilante, actualizar el cupo de todos los grupos asimilados ...
							Select @li_es_asimilante = count (*) from sg_grupos where cve_asimilada = @li_cve_mat and gpo_asimilado = @ls_gpo_cupo
							if @li_es_asimilante > 0
							Begin
								-- Incrementar el cupo a todos los posibles hijos ( el asimilante ya fue actualizado )...
								Update	sg_grupos
								Set		cupo = cupo + @li_cupo_adicional_req
								Where	cve_asimilada = @li_cve_mat and
										gpo_asimilado = @ls_gpo_cupo
							End
							
							-- Si el grupo es asimilado, actualizar todos los posibles hijos ...
							select @li_cve_asimilada = cve_asimilada, @ls_gpo_asimilado = gpo_asimilado from grupos where cve_mat = @li_cve_mat and gpo = @ls_gpo_cupo
							if @li_cve_asimilada <> null and @ls_gpo_asimilado <> null
							Begin
								-- incrementar el cupo del asimilante ...
								Update	sg_grupos
								Set		cupo = cupo + @li_cupo_adicional_req
								Where	cve_mat = @li_cve_asimilada and
										gpo = @ls_gpo_asimilado
										
								-- incrementar el cupo de los posibles demas grupos asimilados ...
								Update	sg_grupos
								Set		cupo = cupo + @li_cupo_adicional_req
								Where	cve_asimilada = @li_cve_asimilada and
										gpo_asimilado = @ls_gpo_asimilado and
										cve_mat <> @li_cve_mat and
										gpo <> @ls_gpo_cupo
							End
						End
						
						-- Si existe mas de un grupo, se incrementa en 1 el cada grupo ( se prorratea el cupo requerido entre los grupos disponibles)...
						if @li_num_gpos_salon > 1 --and @lc_mas_cupos = 'SI'
						begin
							--Select @li_mas_cupos = @li_mas_cupos + 1
							Select @li_mas_cupos = @li_mas_cupos + @li_incrementos_de
							
							IF @li_mas_cupos = @li_cupo_adicional_req
							Begin
								Select @lc_mas_cupos = 'NO'
								Select @li_mas_cupos = @li_cupo_adicional_req
							End
							
							
							Update	sg_grupos
							Set		cupo = cupo + @li_incrementos_de
							Where	cve_mat = @li_cve_mat and
									gpo = @ls_gpo_cupo
									
							-- Si el grupo es asimilante, actualizar el cupo de todos los grupos asimilados ...
							Select @li_es_asimilante = count (*) from sg_grupos where cve_asimilada = @li_cve_mat and gpo_asimilado = @ls_gpo_cupo
							if @li_es_asimilante > 0
							Begin
								-- Incrementar el cupo a todos los posibles hijos ( el asimilante ya fue actualizado )...
								Update	sg_grupos
								Set		cupo = cupo + @li_incrementos_de
								Where	cve_asimilada = @li_cve_mat and
										gpo_asimilado = @ls_gpo_cupo
							End
							
							-- Si el grupo es asimilado, actualizar todos los posibles hijos ...
							select @li_cve_asimilada = cve_asimilada, @ls_gpo_asimilado = gpo_asimilado from grupos where cve_mat = @li_cve_mat and gpo = @ls_gpo_cupo
							if @li_cve_asimilada <> null and @ls_gpo_asimilado <> null
							Begin
								-- incrementar el cupo del asimilante ...
								Update	sg_grupos
								Set		cupo = cupo + @li_incrementos_de
								Where	cve_mat = @li_cve_asimilada and
										gpo = @ls_gpo_asimilado
										
								-- incrementar el cupo de los posibles demas grupos asimilados ...
								Update	sg_grupos
								Set		cupo = cupo + @li_incrementos_de
								Where	cve_asimilada = @li_cve_asimilada and
										gpo_asimilado = @ls_gpo_asimilado and
										cve_mat <> @li_cve_mat and
										gpo <> @ls_gpo_cupo
							End
						End

						Select @ai_cupo_incrementado = 1
					End

					-- 11 Enero 2013, no se consideran los tipo 1 (ASESORIA) para incrementar cupo, pero se registra que no se incremento el cupo de un tipo ASESORIA ...
					if ( @ls_clase_aula_cupo <> 'SALON' ) or ( @li_tipo_cupo <> 0 and @li_tipo_cupo <> 2 )
					begin
						-- El valor de @ai_cupo_incrementado = 0 es para indicar que un grupo de una clase que no es 'SALON'
						-- y que tampoco es tipo NORMAL ni ASIMILADO requeria cupo adicional ...
						Select @ai_cupo_incrementado = 0
						
						-- Si solo existe un grupo, se incrementa el total del cupo a ese grupo ...
						if @li_num_gpos_salon = 1 --and @lc_mas_cupos = 'SI'
						begin
							Select @lc_mas_cupos = 'NO'
							Select @li_mas_cupos = @li_cupo_adicional_req
						end
						
					end
										
					IF @li_ciclo = 1
					Begin
					
						IF @li_num_gpos_salon > 1
						Begin
							if @ls_clase_aula_cupo = 'SALON' and ( @li_tipo_cupo = 0 or @li_tipo_cupo = 2 )
							begin
								--Select @li_cant_inc_cupo = @li_cant_inc_cupo + @li_incrementos_de
								Select @li_cant_inc_cupo = @li_incrementos_de
							end

						End
						
						IF @li_num_gpos_salon = 1
						Begin
							if @ls_clase_aula_cupo = 'SALON' and ( @li_tipo_cupo = 0 or @li_tipo_cupo = 2 )
							begin
								Select @li_cant_inc_cupo = @li_cupo_adicional_req
							end

						End
						
						if @ls_clase_aula_cupo <> 'SALON' or ( @li_tipo_cupo <> 0 and @li_tipo_cupo <> 2 )
						begin
							Select @li_cant_inc_cupo = 0
						end

						Insert into sg_nuevos_grupos values ( @li_cve_mat_cupo, @ls_gpo_cupo, @ai_anio, @ai_periodo, @li_cant_solicitantes, @li_cupo_cupo, @lc_nivel, @ai_cupo_incrementado, @li_cupo_adicional_req, 0, 0, @ls_clase_aula_cupo, @li_tipo_cupo, @li_cant_inc_cupo )
					End
					
					IF @li_ciclo > 1
					Begin
						
						Update	sg_nuevos_grupos
						Set		cant_de_incremento_cupo = cant_de_incremento_cupo + 1
						Where	cve_mat = @li_cve_mat_cupo and
								gpo = @ls_gpo_cupo and
								anio = @ai_anio and
								periodo = @ai_periodo
					End
					
					FETCH NEXT FROM cur_grupos_x_materia INTO @li_cve_mat_cupo,	@ls_gpo_cupo, @li_cupo_cupo, @ls_cve_salon_cupo, @ls_clase_aula_cupo, @li_tipo_cupo
				END	-- Del WHILE (@@FETCH_STATUS = 0)
				
				CLOSE cur_grupos_x_materia
				DEALLOCATE cur_grupos_x_materia
				
--			END -- del While @li_mas_cupos < @li_cupo_adicional_req
			

		end	-- Termina el if para incrementar el cupo ...

		-- Si el CUPO ADICIONAL REQUERIDO (@li_cupo_adicional_req) es mayor o igual que el MARGEN PARA AUMENTAR CUPO (@ai_margen_abrir_nvo_gpo)
		-- entonces se crea un nuevo grupo ...
		Select @li_num_gpos_creados = 0
		Select @li_nuevo_cupo_req = @li_cupo_adicional_req
		Select @ai_ascii = 64 -- Se inicializa en 64 para que comience con 65 ( 'A' ) en el primer incremento ...
		Select @li_primer_hora_inicio = 5 -- Se inicializa en 5 para que comience con 7 en el primer incremento ...
		Select @li_continuar = 1
		Select @li_cambiar_dia = 0
		--if ( @li_cupo_adicional_req >= @ai_margen_abrir_nvo_gpo ) and ( @li_cupo_ofrecido > -1 or @lc_nivel= 'L' )-- Se descartan los -1 por que son grupos que no exísten
		/*if ( @li_cupo_adicional_req >= @ai_margen_abrir_nvo_gpo ) and ( @lc_nivel= 'L' )*/
		if ( @li_cupo_adicional_req >= @ai_margen_abrir_nvo_gpo ) and ( @lc_nivel <> 'P' )
		begin
		
			-- Verificar si se puede repartir el CUPO ADICIONAL REQUERIDO entre los posibles grupos existentes (Antes de decidir crear grupo(s)) ...
			-- Obtener el número de salones con clase de aula 'SALON' con la misma materia ...
			Select		@li_num_gpos_salon = IsNull ( Sum ( Count ( distinct sg_grupos.cve_mat ) ) , 0 )
			From		sg_grupos,
						sg_horario,
						salon
			Where		sg_grupos.cve_mat		= @li_cve_mat AND
						sg_grupos.cve_mat		= sg_horario.cve_mat AND
						sg_grupos.gpo			= sg_horario.gpo AND
						sg_grupos.anio			= sg_horario.anio AND
						sg_grupos.periodo		= sg_horario.periodo AND
						sg_horario.cve_salon	= salon.cve_salon AND
						salon.clase_aula 		= 'SALON'
			Group By	sg_grupos.cve_mat, sg_grupos.gpo
			
			-- Si existe mas de un grupo con clase de aula salón, se verifica si es posible repartir el cupo adicional requerido ...
			If @li_num_gpos_salon > 1
			Begin
--				Select @ls_mensaje = 'Mas de un grpo por salón : ' + Cast(@li_num_gpos_salon as Varchar)
--				Print @ls_mensaje
				
--				Select @ls_mensaje = 'li_cve_mat : ' + Cast(@li_cve_mat as Varchar) + ' -- ai_anio : ' + Cast(@ai_anio as Varchar) + ' -- ai_periodo : ' + Cast(@ai_periodo as Varchar) + ' -- li_cant_solicitantes : ' + Cast(@li_cant_solicitantes as Varchar) + ' -- lc_nivel : ' + Cast(@lc_nivel as Varchar)
--				Print @ls_mensaje
				
--				Select @ls_mensaje = ' -- li_cupo_adicional_req : ' + Cast(@li_cupo_adicional_req as Varchar)
--				Print @ls_mensaje
				
				-- Verificar si es posible repartir el cupo adicional requerido entre los grupos existentes, con el siguiente ejemplo como criterio:
				-- CUPO ADICIONAL REQUERIDO:		18
				-- GRUPOS DISPONIBLES				4
				-- MARGEN PARA ABRIR NUEVOS GRUPOS	5
				-- Supongamos que existen los siguientes grupos:
				-- A
				-- B
				-- C
				-- D
				-- El cupo adicional requerido se repartiria de la siguiente forma:
				-- GPO		CUPO ADICIONAL
				-- A		5
				-- B		5
				-- C		5
				-- D		3
				-- Debido a que el cupo mayor que se incrementaria ( 5 ) es igual o menor al cupo adicional requerido (5)
				-- se toma la decicion de incrementar cupos.
				
				Select @li_gpos_disponibles = Ceiling ( Convert ( float , Convert ( decimal , @li_cupo_adicional_req ) / Convert ( decimal , @li_num_gpos_salon ) ) )
				
				if @li_gpos_disponibles <= @ai_margen_abrir_nvo_gpo
				begin
					exec sp_sg_incrementar_cupo @li_cve_mat, @ai_anio, @ai_periodo, @li_cant_solicitantes, @lc_nivel, @li_cupo_adicional_req
				end
			End
			
			-- Si no fué posible incrementar cupos ...
			If @li_num_gpos_salon < 2 or ( @li_gpos_disponibles > @ai_margen_abrir_nvo_gpo )
			Begin
				-- Crear el o los grupos requeridos ...
--				Select @ls_mensaje = 'Menos de dos grpo por salón : ' + Cast(@li_num_gpos_salon as Varchar)
--				Print @ls_mensaje
				
				while @li_nuevo_cupo_req > 0
				begin

					Select @li_num_gpos_creados = @li_num_gpos_creados + 1
					
					-- Decrementar el cupo adicional requerido ...
					select @li_nuevo_cupo_req = @li_nuevo_cupo_req - @ai_cupo_nvo_gpo

					if @li_nuevo_cupo_req < 0
					begin
						Select @li_nuevo_cupo_req = 0
					end

					-- Insertar el grupo ...
					if @li_cupo_ofrecido > -1   -- Clonar un grupo ..
					begin

						-- 2012-10-03
						-- Genera el nuevo grupo, es decir la letra o combinacion de letras que le corresponderá		
						select @li_ret_sp = 0
						select @as_gpo = ''
						select @ls_gpo = ''
						
						exec @li_ret_sp = sp_siguiente_gpo @ai_cve_mat = @li_cve_mat,	 @as_gpo= @ls_gpo  out
						
						--Asigna el valor regresado por el sp
						Select @ls_gpo_nuevo = @ls_gpo
						
						-- Verificar si el grupo no existe, asignar el primer grupo 'A' ...
						select @li_num_gpos = Count(gpo) from sg_grupos where cve_mat = @li_cve_mat
						if @li_num_gpos = 0
						begin
							Select @ls_gpo_nuevo = 'A'
						end
	--1) INICIO


	--2012-10-04	Esto solo debe realizarse si se trata de un grupo NO ASIMILADO					
	--				AND		tipo <> 2
						-- Insertar el grupo ...

	--2012-10-04
	--CONTAR SI EXISTE UN GRUPO NORMAL AL CUAL CLONAR

	--SI NO EXISTE BUSCAR UN ASIMILANTE NORMAL Y CLONAR SUS DATOS 
	--TANTO PARA EL GRUPO,COMO PARA EL HORARIO

						
						Select		top 1 @ls_gpo_clonar = gpo
						From		sg_grupos
						Where    	cve_mat = @li_cve_mat AND
									tipo <> 2
						Order By	gpo desc

						-- 12 Enero 2013, el tipo de grupo debe ser 0 (NORMAL) ...
						Insert into sg_grupos
						Select		top 1 
									cve_mat_gpo = Convert ( Varchar ( 10 ) , cve_mat ) + @ls_gpo_nuevo, cve_mat, gpo= @ls_gpo_nuevo, periodo, anio, cond_gpo, cupo = @ai_cupo_nvo_gpo, tipo = 0, inscritos = 0, insc_desp_bajas, null,
									null, cve_profesor = 1, prom_gpo, porc_asis, ema4, primer_sem, comentarios, creado_auto = 1
						From		sg_grupos
						Where    	cve_mat = @li_cve_mat AND
									gpo = @ls_gpo_clonar
						AND			tipo <> 2
						Order By	gpo desc
						
						if @@error <> 0
						Begin
							Print 'Algo fallo aqui'
						End
						-------------------------------------------------------
						-- Insertar (Clonar) el horario para el grupo ...
						-------------------------------------------------------
						--Insert into sg_horario
						--Select		cve_mat = @li_cve_mat , gpo = @ls_gpo_nuevo, periodo = @ai_periodo , anio = @ai_anio, cve_dia, cve_salon = null, hora_inicio, hora_final, clase_aula = 0
						--From		sg_horario
						--Where    	cve_mat = @li_cve_mat AND
						--			gpo = @ls_gpo_clonar

						------------------------------------------------------- ABR 2013
						-- Debido a que se saturaban los horarios en los nuevos grupos la clonacion de los horarios ya no se realiza, ahora se le asigna los horarios en base a los nuevos criterios de creación de grupos
						-- Insertar el horario para el grupo, los dias definidos en la combinacion de dias horarios (sg_param_dias_horarios) segun la prioridad definida...
						-------------------------------------------------------
						-- Obtener las horas reales (horas por semana ) de la materia ...
						Select @li_horas_reales =  horas_reales from materias where cve_mat = @li_cve_mat

						EXEC sp_sg_i_horario_nvo_gpo @li_horas_reales, @li_cve_mat, @ls_gpo_nuevo, @ai_periodo, @ai_anio

						Select @iHorariosCreados = 0

						-- En caso de que no haya podido crear los horarios del grupo se convierte a "Tipo 3. Otros"
						Select @iHorariosCreados = IsNull(count(*),0)
							From sg_horario 
						  Where cve_mat = @li_cve_mat
							And gpo = @ls_gpo_nuevo
							And periodo = @ai_periodo
							And anio = @ai_anio

						If @iHorariosCreados = 0 
						Begin
							Update sg_grupos 
								 Set tipo = 3
							 Where cve_mat = @li_cve_mat
								And gpo = @ls_gpo_nuevo
								And periodo = @ai_periodo
								And anio = @ai_anio
						End

					end	--	if @li_cupo_ofrecido > -1   -- Clonar un grupo ..

					if @li_cupo_ofrecido = -1   -- Crear un nuevo grupo ..
					begin
						-- Obtener el último grupo ...
						-- Genera el nuevo grupo, es decir la letra o combinacion de letras que le corresponderá	
										
						exec @li_ret_sp = sp_siguiente_gpo @ai_cve_mat = @li_cve_mat,	 @as_gpo= @ls_gpo  out
						
						-- Asigna el valor regresado por el sp
						Select @ls_gpo_nuevo = @ls_gpo
						
						-- Verificar si el grupo no existe, asignar el primer grupo 'A' ...
						select @li_num_gpos = Count(gpo) from sg_grupos where cve_mat = @li_cve_mat
						if @li_num_gpos = 0
						begin
							Select @ls_gpo_nuevo = 'A'
						end
						
						-- Almacenar el nuevo grupo creado ...
						Select @lc_gpo_incrementar = @ls_gpo_nuevo
						
						-- Insertar el grupo ...
						Insert into sg_grupos
						Select		cve_mat_gpo = Convert ( Varchar ( 10 ) , @li_cve_mat ) + @ls_gpo_nuevo,
									cve_mat = @li_cve_mat,
									gpo= @ls_gpo_nuevo,
									periodo = @ai_periodo,
									anio = @ai_anio,
									cond_gpo = 1,
									cupo = @ai_cupo_nvo_gpo,
									tipo = 0,
									inscritos = 0,
									insc_desp_bajas = 0,
									cve_asimilada = null,
									gpo_asimilado = null,
									cve_profesor = 1,
									prom_gpo = 0,
									porc_asis = 0,
									ema4 = 0,
									primer_sem = 0,
									comentarios = null,
									creado_auto = 1

						if @@error <> 0
						Begin
							Print 'Algo fallo aqui 2'
						End
						
						-- Insertar el horario para el grupo, los dias viernes (por que es dia y horario sin mucha demanda) ...
						-- Obtener las horas reales (horas por semana ) de la materia ...
						Select @li_horas_reales =  horas_reales from materias where cve_mat = @li_cve_mat

					--	Insert into sg_horario
					--	Select		cve_mat = @li_cve_mat,
					--				gpo = @ls_gpo_nuevo,
					--				periodo = @ai_periodo,
					--				anio = @ai_anio,
					--				cve_dia,
					--				cve_salon = null,
					--				hora_inicio,
					--				hora_final,
					--				clase_aula = 0
					--	From		sg_parametros_nvos_horarios
					--	Where		horas_reales = @li_horas_reales

						-- Insertar el horario para el grupo, los dias definidos en la combinacion de dias horarios (sg_param_dias_horarios) segun la prioridad definida...
						EXEC sp_sg_i_horario_nvo_gpo @li_horas_reales, @li_cve_mat, @ls_gpo_nuevo, @ai_periodo, @ai_anio

						Select @iHorariosCreados = 0

						-- En caso de que no haya podido crear los horarios del grupo se convierte a "Tipo 3. Otros"
						Select @iHorariosCreados = IsNull(count(*),0)
							From sg_horario 
						  Where cve_mat = @li_cve_mat
							And gpo = @ls_gpo_nuevo
							And periodo = @ai_periodo
							And anio = @ai_anio

						If @iHorariosCreados = 0 
						Begin
							Update sg_grupos 
								 Set tipo = 3
							 Where cve_mat = @li_cve_mat
								And gpo = @ls_gpo_nuevo
								And periodo = @ai_periodo
								And anio = @ai_anio
						End

						
	--					Insert into sg_horario
	--					Select		cve_mat = @li_cve_mat , gpo = @ls_gpo_nuevo, periodo = @ai_periodo , anio = @ai_anio, cve_dia = 5, cve_salon = null, hora_inicio = 13, hora_final = 15, clase_aula = 0

					end
				end	--	while @li_nuevo_cupo_req > 0

				Select @li_gpo_creado = 1
				
				Insert into sg_nuevos_grupos values ( @li_cve_mat, @lc_gpo_incrementar, @ai_anio, @ai_periodo, @li_cant_solicitantes, @li_cupo_ofrecido, @lc_nivel, @ai_cupo_incrementado, @li_cupo_adicional_req, @li_gpo_creado, @li_num_gpos_creados, @ls_clase_aula, 0 , 0 )
			End
			
			
		end


	End -- De IF @li_procesar = 1

    FETCH NEXT FROM cur_solicitantes_vs_ofertantes INTO @li_cve_mat, @li_creditos, @li_cant_solicitantes, @li_cupo_ofrecido, @lc_nivel
END	-- Del WHILE (@@FETCH_STATUS = 0)

CLOSE cur_solicitantes_vs_ofertantes
DEALLOCATE cur_solicitantes_vs_ofertantes

/*Aseguramos que no existan grupos-horarios fuera del rango de horarios permitidos de clases*/
DELETE sg_grupos
from sg_grupos, sg_horario
where  sg_grupos.cve_mat =  sg_horario.cve_mat 
and  sg_grupos.gpo =  sg_horario.gpo 
and  sg_grupos.periodo =  sg_horario.periodo 
and  sg_grupos.anio =  sg_horario.anio
and sg_horario.periodo = @ai_periodo
and sg_horario.anio = @ai_anio
and  (sg_horario.hora_inicio < 7 Or sg_horario.hora_final > 22)


DELETE sg_horario
FROM sg_horario
where  sg_horario.periodo = @ai_periodo
and sg_horario.anio = @ai_anio
and  (sg_horario.hora_inicio < 7 Or sg_horario.hora_final > 22)


Commit
/* Adaptive Server has expanded all '*' elements in the following statement */ select sg_nuevos_grupos.cve_mat, sg_nuevos_grupos.gpo, sg_nuevos_grupos.anio, sg_nuevos_grupos.periodo, sg_nuevos_grupos.cant_solicitantes, sg_nuevos_grupos.cupo_ofrecido, sg_nuevos_grupos.nivel, sg_nuevos_grupos.cupo_incrementado, sg_nuevos_grupos.cupo_adicional_req, sg_nuevos_grupos.gpo_creado, sg_nuevos_grupos.num_gpos_creados, sg_nuevos_grupos.clase_aula, sg_nuevos_grupos.tipo_grupo, sg_nuevos_grupos.cant_de_incremento_cupo from sg_nuevos_grupos
GO

