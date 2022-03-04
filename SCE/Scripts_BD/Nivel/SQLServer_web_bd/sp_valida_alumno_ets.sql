USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_valida_alumno_ets]    Script Date: 8/8/2017 16:58:23 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_valida_alumno_ets]
 @CUENTA int,
 @TIPO_EXAMEN int
AS 


DECLARE @VAR_cve_carrera INTEGER			
DECLARE @VAR_cve_plan INTEGER			
DECLARE @VAR_insc_sem_ant INTEGER			
DECLARE @VAR_cve_flag_promedio INTEGER
DECLARE @VAR_baja_3_reprob INTEGER	
DECLARE @VAR_baja_4_insc INTEGER			
DECLARE @VAR_baja_disciplina INTEGER			
DECLARE @VAR_baja_documentos INTEGER				
DECLARE @VAR_invasor_hora INTEGER				
DECLARE @VAR_exten_cred INTEGER			
DECLARE @VAR_cve_flag_serv_social INTEGER			
DECLARE @VAR_puede_integracion INTEGER			
DECLARE @VAR_tema_fundamental_1 INTEGER			
DECLARE @VAR_tema_fundamental_2 INTEGER				
DECLARE @VAR_tema_1 INTEGER			
DECLARE @VAR_tema_2 INTEGER			
DECLARE @VAR_tema_3 INTEGER			
DECLARE @VAR_tema_4 INTEGER			
DECLARE @VAR_cve_flag_biblioteca INTEGER			
DECLARE @VAR_adeuda_finanzas INTEGER			
DECLARE @VAR_creditos_integ INTEGER			
DECLARE @VAR_baja_laboratorio INTEGER			
DECLARE @VAR_pago_1a_colegiatura INTEGER			
DECLARE @VAR_porcentaje_apoyo INTEGER			
DECLARE @VAR_consulta_adeudos_en_linea INTEGER			
DECLARE @VAR_num_horas_anticipadas INTEGER			
DECLARE @VAR_fecha_historico_reinsc DATETIME
DECLARE @VAR_horario_inscripcion DATETIME
DECLARE @VAR_hora_actual DATETIME
DECLARE @VAR_revision_hora_entrada INTEGER	
DECLARE @VAR_horario_con_tolerancia DATETIME
DECLARE @VAR_horario_inscripcion_str VARCHAR(50)
DECLARE @VAR_cuenta VARCHAR(50)
DECLARE @VAR_anio VARCHAR(50)
DECLARE @VAR_periodo VARCHAR(50)
DECLARE @VAR_separador VARCHAR(2)
DECLARE @VAR_mensaje_completo VARCHAR(8000)
DECLARE @VAR_codigo_completo VARCHAR(8000)
DECLARE @VAR_inscripcion_activa INTEGER
DECLARE @VAR_minutos_tolerancia INTEGER
DECLARE @VAR_envia_mensaje_completo INTEGER
DECLARE @VAR_extrao_titulo_activo INTEGER
DECLARE @VAR_insc_sem_actual INTEGER
DECLARE @VAR_num_reprobadas INTEGER
DECLARE @VAR_creditos_titulo_suficiencia INTEGER
DECLARE @VAR_nivel VARCHAR(4)
DECLARE  @total_minimos int
DECLARE  @total_cursados int
DECLARE  @total_faltan  int
DECLARE  @puntaje_min real
DECLARE  @promedio real
DECLARE  @promedio_menos_puntaje real
DECLARE  @cve_subsistema int
DECLARE  @ss_faltan int
DECLARE  @opc_ter_faltan int
DECLARE  @cursando_ss int
DECLARE  @total_faltan_menos_opc_term int

DECLARE  @Creditos int
DECLARE  @Contador smallint
DECLARE  @sum_creditos int


SELECT @VAR_separador ='|'
SELECT @VAR_mensaje_completo =''
SELECT @VAR_codigo_completo =''
SELECT @VAR_envia_mensaje_completo =1
SELECT @VAR_consulta_adeudos_en_linea=1
SELECT @VAR_extrao_titulo_activo=0
SELECT @VAR_insc_sem_actual=0
SELECT @VAR_num_reprobadas=0

--Valores posibles de @TIPO_EXAMEN
--2	EXTRAORDINARIO
--6	TIT. SUFICIENCIA

IF @TIPO_EXAMEN <> 2 AND @TIPO_EXAMEN<>6
BEGIN
	SELECT @VAR_envia_mensaje_completo =1
	IF @VAR_envia_mensaje_completo =0
	BEGIN
 		SELECT -1,'EL TIPO DE EXAMEN NO ES VALIDO'
		RETURN -1
	END
	ELSE
	BEGIN
--Termina el proceso inmediatamente
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL TIPO DE EXAMEN NO ES VALIDO'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
		SELECT @VAR_codigo_completo, @VAR_mensaje_completo
		RETURN -1
	END
END 


--Obtiene los parametros de los servicios en linea
--Especifica si la inscripción está activa
--Especifica si la inscripción de examen extraordinario y a titulo de suficiencia está activa
--Especifica si se enviará el mensaje de error completo solo el primer error detectado
--Lee los minutos de tolerancia de la base de datos

SELECT  @VAR_inscripcion_activa = isnull(inscripcion_activa,0),   
        @VAR_minutos_tolerancia = isnull(minutos_tolerancia,30),   
        @VAR_envia_mensaje_completo = isnull(envia_mensaje_completo,1),  
		@VAR_consulta_adeudos_en_linea = isnull(consulta_adeudos_en_linea,1),
		@VAR_extrao_titulo_activo  = isnull(extrao_titulo_activo,0),
		@VAR_creditos_titulo_suficiencia = isnull(creditos_titulo_suficiencia,0)
FROM controlescolar_bd.dbo.parametros_servicios  
 
--Si no existen estos parametros no es posible continuar
IF @@ROWCOUNT = 0
BEGIN
	SELECT @VAR_envia_mensaje_completo =1
	IF @VAR_envia_mensaje_completo =0
	BEGIN
 		SELECT -1,'NO SE ENCUENTRA INFORMACIÓN DE LOS PARAMETROS DE SERVICIOS PARA EL ALUMNO'
		RETURN -1
	END
	ELSE
	BEGIN
--Termina el proceso inmediatamente
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE ENCUENTRA INFORMACIÓN DE LOS PARAMETROS DE SERVICIOS PARA EL ALUMNO'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
		SELECT @VAR_codigo_completo, @VAR_mensaje_completo
		RETURN -1
	END
END 



--No esta habilitada la inscripcion a Extraordinario y Titulo de Suficiencia
IF  @VAR_extrao_titulo_activo = 0
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
 		SELECT -2,'EN ESTE MOMENTO AUN NO ES POSIBLE INSCRIBIRSE A EXTRAORDINARIO Y TITULO DE SUFICIENCIA'
		RETURN -2
	END
	ELSE
	BEGIN
--Termina el proceso inmediatamente
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EN ESTE MOMENTO AUN NO ES POSIBLE INSCRIBIRSE A EXTRAORDINARIO Y TITULO DE SUFICIENCIA'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-2'+@VAR_separador
		SELECT @VAR_codigo_completo, @VAR_mensaje_completo
		RETURN -2
	END
END 

--Consulta la carrera y plan de estudios
SELECT @VAR_cve_carrera = academicos.cve_carrera,   
	   @VAR_cve_plan =  academicos.cve_plan,
	   @VAR_nivel = nivel  
FROM	controlescolar_bd.dbo.academicos academicos
WHERE	( academicos.cuenta = @CUENTA )
IF @@ROWCOUNT = 0
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
 		SELECT -3,'NO SE ENCUENTRA INFORMACIÓN ACADÉMICA DEL ALUMNO'
		RETURN -3
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE ENCUENTRA INFORMACIÓN ACADÉMICA DEL ALUMNO'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-3'+@VAR_separador
	END
END 


--Consulta la información de la Revisión de Estudios para ver si cumple con los créditos para solicitar el trámite

SELECT @total_minimos = total_minimos,
		@total_cursados = total_minimos,
		@total_faltan = total_faltan,
		@puntaje_min = puntaje_min,
		@promedio = promedio,
		@promedio_menos_puntaje = promedio_menos_puntaje,
		@cve_subsistema = cve_subsistema,
		@ss_faltan = ss_faltan,
		@opc_ter_faltan = opc_ter_faltan
FROM controlescolar_bd.dbo.v_revision_de_estudios
WHERE cuenta = @CUENTA
AND cve_carrera = @VAR_cve_carrera
AND cve_plan = @VAR_cve_plan

IF @@ROWCOUNT = 0
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
 		SELECT -7,'EL ALUMNO CON CUENTA: '+cast(ISNULL(@CUENTA,0) as varchar)
 						+' CARRERA: '+cast(ISNULL(@VAR_cve_carrera,0) as varchar)
 						+' PLAN : '+cast(ISNULL(@VAR_cve_plan,0) as varchar)
						+' NIVEL: '+ISNULL(@VAR_nivel,'NULO')+ ' NO CUENTA CON REVISION DE ESTUDIOS.'
		RETURN -7
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO CON CUENTA: '+cast(ISNULL(@CUENTA,0) as varchar)
 						+' CARRERA: '+cast(ISNULL(@VAR_cve_carrera,0) as varchar)
 						+' PLAN : '+cast(ISNULL(@VAR_cve_plan,0) as varchar)
						+' NIVEL: '+ISNULL(@VAR_nivel,'NULO')+ ' NO CUENTA CON REVISION DE ESTUDIOS.'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-7'+@VAR_separador
	END
END

SELECT 	@total_faltan_menos_opc_term = @total_faltan - @opc_ter_faltan

--Para examenes a Título de licenciatura
IF @VAR_nivel <> 'P' -- MALH 08/08/2017 -> IF @VAR_nivel = 'L'
BEGIN
--Si es un examen a título se valida que sean sus dos últimas materias
	IF @TIPO_EXAMEN = 6
	BEGIN
		SELECT @creditos = 0
		-- Se obtiene la suma de los dos creditos de las materias mas altos de la carrera del alumno
		DECLARE cur_creditos CURSOR FOR
		  SELECT m.creditos 
		    FROM controlescolar_bd.dbo.mat_prerrequisito mp, controlescolar_bd.dbo.materias m
           WHERE mp.cve_carrera = @VAR_cve_carrera
			 AND mp.cve_plan = @VAR_cve_plan
			 AND mp.cve_mat = m.cve_mat
			 AND mp.cve_mat NOT IN (8763)
           ORDER BY m.creditos DESC
			FOR READ ONLY
						
			OPEN cur_creditos
			
			FETCH cur_creditos INTO @creditos

			IF @@FETCH_STATUS <> 0
			BEGIN
				SELECT -8, 'ERROR AL OBTENER LA SUMA DE LOS DOS CREDITOS DE LAS MATERIAS MAS ALTOS DE LA CARRERA DEL ALUMNO'
				CLOSE cur_creditos
				DEALLOCATE cur_creditos
				RETURN -8
			END
					
			SELECT @sum_creditos = 0		
			SELECT @Contador = 0 	

			WHILE (@@FETCH_STATUS=0) AND (@Contador < 2)
			BEGIN
				SELECT @sum_creditos = @sum_creditos + @creditos
				FETCH cur_creditos INTO @creditos
				SELECT @Contador = @Contador + 1
			END
			
			CLOSE cur_creditos
			DEALLOCATE cur_creditos

		--Si le faltan más de 16 créditos
		--		IF @total_faltan > 16

		-- Si le faltan más de la suma de lo dos créditos más altos
		IF @total_faltan > @sum_creditos
		BEGIN
			SELECT @cursando_ss = 0
--Solo si es posible que le falte el Servicio Social
			IF @total_faltan <= 32
			BEGIN
				IF @ss_faltan> 0 
				BEGIN
					SELECT @cursando_ss = count(cuenta) 
					FROM controlescolar_bd.dbo.historico 
					WHERE cuenta = @CUENTA
					AND cve_carrera = @VAR_cve_carrera
					AND cve_plan = @VAR_cve_plan
					AND cve_mat in (8763)
					AND calificacion in ('IN')
				END
			END

			IF (@ss_faltan = 0) OR
			   (@ss_faltan > 0 AND @cursando_ss <=0)
			BEGIN
				IF @VAR_envia_mensaje_completo =0
				BEGIN
					SELECT -8, 'PARA INSCRIBIR MATERIAS A TÍTULO SE REQUIERE QUE SEAN CUANDO MUCHO LAS ÚLTIMAS DOS Y AL ALUMNO AÚN LE FALTAN [' +
							CAST(ISNULL(@total_faltan,0) as varchar)+ '] CREDITOS POR CURSAR.'
					RETURN -8
				END
				ELSE
				BEGIN
					SELECT @VAR_mensaje_completo =@VAR_mensaje_completo +'PARA INSCRIBIR MATERIAS A TÍTULO SE REQUIERE QUE SEAN CUANDO MUCHO LAS ÚLTIMAS DOS Y AL ALUMNO AÚN LE FALTAN [' +
						CAST(ISNULL(@total_faltan,0)as varchar)+ '] CREDITOS POR CURSAR.'+@VAR_separador
					SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-8'+@VAR_separador
				END
			END
		END
	END
END
--Para examenes a Título de Posgrado
ELSE IF @VAR_nivel = 'P'
BEGIN
--Si es un examen a título se valida que sean sus dos últimas materias
	IF @TIPO_EXAMEN = 6
	BEGIN
		SELECT @creditos = 0
		-- Se obtiene la suma de los dos creditos de las materias mas altos de la carrera del alumno
		DECLARE cur_creditos_p CURSOR FOR
		  SELECT m.creditos 
		    FROM controlescolar_bd.dbo.mat_prerreq_pos mp, controlescolar_bd.dbo.materias m
           WHERE mp.cve_carrera = @VAR_cve_carrera
			 AND mp.cve_plan = @VAR_cve_plan
			 AND mp.cve_mat = m.cve_mat
			 AND mp.cve_mat NOT IN (8763)
           ORDER BY m.creditos DESC
			FOR READ ONLY
						
			OPEN cur_creditos_p
			
			FETCH cur_creditos_p INTO @creditos

			IF @@FETCH_STATUS <> 0
			BEGIN
				SELECT -8, 'ERROR AL OBTENER LA SUMA DE LOS DOS CREDITOS DE LAS MATERIAS MAS ALTOS DE LA CARRERA DEL ALUMNO'
				CLOSE cur_creditos_p
				DEALLOCATE cur_creditos_p
				RETURN -8
			END
					
			SELECT @sum_creditos = 0		
			SELECT @Contador = 0 	

			WHILE (@@FETCH_STATUS=0) AND (@Contador < 2)
			BEGIN
				SELECT @sum_creditos = @sum_creditos + @creditos
				FETCH cur_creditos_p INTO @creditos
				SELECT @Contador = @Contador + 1
			END
			
			CLOSE cur_creditos_p
			DEALLOCATE cur_creditos_p

--Si los creditos faltantes menos la opción terminal son más de 8 creditos
--		IF @total_faltan_menos_opc_term > 8 

		-- Si los creditos faltantes menos la opción terminal son más que la suma de los dos creditos de las materias mas altos de la carrera del alumno
		IF @total_faltan_menos_opc_term > @sum_creditos
		BEGIN			
			IF @VAR_envia_mensaje_completo =0
			BEGIN
				SELECT -8, 'PARA INSCRIBIR MATERIAS A TÍTULO SE REQUIERE QUE SEAN CUANDO MUCHO LAS ÚLTIMAS DOS Y AL ALUMNO AÚN LE FALTAN [' +
						CAST(ISNULL(@total_faltan,0) as varchar)+ '] CREDITOS POR CURSAR.'
				RETURN -8
			END
			ELSE
			BEGIN
				SELECT @VAR_mensaje_completo =@VAR_mensaje_completo +'PARA INSCRIBIR MATERIAS A TÍTULO SE REQUIERE QUE SEAN CUANDO MUCHO LAS ÚLTIMAS DOS Y AL ALUMNO AÚN LE FALTAN [' +
					CAST(ISNULL(@total_faltan,0)as varchar)+ '] CREDITOS POR CURSAR.'+@VAR_separador
				SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-8'+@VAR_separador
			END			
		END
	END
END



--Consulta los bloqueos
SELECT	@VAR_insc_sem_ant = insc_sem_ant,			
	@VAR_cve_flag_promedio = cve_flag_promedio,	
	@VAR_baja_3_reprob = baja_3_reprob,		
	@VAR_baja_4_insc = baja_4_insc,
	@VAR_baja_disciplina = baja_disciplina,		
	@VAR_baja_documentos = baja_documentos,		
	@VAR_invasor_hora = invasor_hora,		
	@VAR_exten_cred = exten_cred,
	@VAR_cve_flag_serv_social = cve_flag_serv_social,
	@VAR_puede_integracion = puede_integracion,
	@VAR_tema_fundamental_1 = tema_fundamental_1,
	@VAR_tema_fundamental_2 = tema_fundamental_2,	
	@VAR_tema_1 = tema_1,					
	@VAR_tema_2 = tema_2,				
	@VAR_tema_3 = tema_3,
	@VAR_tema_4 = tema_4,												
	@VAR_cve_flag_biblioteca = cve_flag_biblioteca,
	@VAR_adeuda_finanzas = adeuda_finanzas,	   
	@VAR_creditos_integ = creditos_integ,      
	@VAR_baja_laboratorio = isnull(baja_laboratorio,0)
FROM controlescolar_bd.dbo.banderas 
WHERE cuenta = @CUENTA
--Verifica que exista información de sus bloqueos
IF @@ROWCOUNT = 0
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
	 	SELECT -4,'NO SE ENCUENTRA INFORMACIÓN DE LOS BLOQUEOS DEL ALUMNO'
		RETURN -4
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE ENCUENTRA INFORMACIÓN DE LOS BLOQUEOS DEL ALUMNO'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-4'+@VAR_separador
	END
END 

--ELIMINADO: Consulta los parámetros de activacion de los alumnos para ver si se realizará la 
--validación del horario de entrada

--ELIMINADO:Verifica si se actualizó el histórico del alumno para permitirle la inscripción
--Sin esta validación se corre el riesgo de inscribir alumnos en materias ya cursadas

--ELIMINADO:Si el parámetro indica que se revisará el horario de entrada

--Valida la baja de disciplina
IF @VAR_baja_disciplina = 1
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
 		SELECT -9,'EL ALUMNO ESTA DADO DE BAJA POR DISCIPLINA'
		RETURN -9
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA DADO DE BAJA POR DISCIPLINA'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-9'+@VAR_separador
	END
END 

--ELIMINADO:Valida invasor de horario

--Valida baja de documentos
IF @VAR_baja_documentos = 1
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
		SELECT -10,'EL ALUMNO DADO DE BAJA POR ADEUDO DE DOCUMENTOS'
		RETURN -10
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO DADO DE BAJA POR ADEUDO DE DOCUMENTOS'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-10'+@VAR_separador
	END
END 



--Valida la baja por 4 inscripciones
IF @VAR_baja_4_insc = 1
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
	 	SELECT -11,'EL ALUMNO ESTA DADO DE BAJA POR 4 INSCRIPCIONES'
		RETURN -11
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA DADO DE BAJA POR 4 INSCRIPCIONES'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-11'+@VAR_separador
	END
END 

--Valida la baja por 3 reprobadas
IF @VAR_baja_3_reprob = 1
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
	 	SELECT -12,'EL ALUMNO ESTA DADO DE BAJA POR 3 REPROBADAS'
		RETURN -12
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA DADO DE BAJA POR 3 REPROBADAS'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-12'+@VAR_separador
	END
END 

--Valida la baja por promedio
-- 0	NORMAL
-- 1	AMONESTADO
-- 2	BAJA
-- 3	EXENTO
IF @VAR_cve_flag_promedio = 2
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
	 	SELECT -13,'EL ALUMNO ESTA DADO DE BAJA POR PROMEDIO'
		RETURN -13
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA DADO DE BAJA POR PROMEDIO'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-13'+@VAR_separador
	END
END 

--El alumno está inscrito en el periodo vigente

--Verifica si El alumno está inscrito en el periodo vigente
SELECT distinct @VAR_cuenta = mi.cuenta
FROM controlescolar_bd.dbo.mat_inscritas mi, v_www_periodo_mat_inscritas pmi
WHERE mi.cuenta = @CUENTA
AND	mi.periodo = pmi.periodo 
AND	mi.anio = pmi.anio  

IF @@ROWCOUNT <= 0
BEGIN
	SELECT @VAR_insc_sem_actual = 0
--En un examen extraordinario es necesario estar inscrito
	IF @TIPO_EXAMEN = 2
	BEGIN 
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -14,'EL ALUMNO NO ESTA INSCRITO EN EL PERIODO ACTUAL, NO ES POSIBLE INSCRIBIR UN EXAMEN EXTRAORDINARIO'
			RETURN -14
		END
		ELSE
		BEGIN
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO NO ESTA INSCRITO EN EL PERIODO ACTUAL, NO ES POSIBLE INSCRIBIR UN EXAMEN EXTRAORDINARIO'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-14'+@VAR_separador
		END
	END
END
ELSE 
BEGIN
	SELECT @VAR_insc_sem_actual = 1
--En un examen a titulo no es posible estar inscrito
	IF @TIPO_EXAMEN = 6
	BEGIN 
		IF @VAR_envia_mensaje_completo =0
		BEGIN
			SELECT -6,'EL ALUMNO ESTA INSCRITO EN EL PERIODO ACTUAL, NO ES POSIBLE INSCRIBIR UN EXAMEN A TITULO'
			RETURN -6
		END
		ELSE
		BEGIN
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA INSCRITO EN EL PERIODO ACTUAL, NO ES POSIBLE INSCRIBIR UN EXAMEN A TITULO'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-6'+@VAR_separador
		END
	END
END

--Contabiliza las materias reprobadas
SELECT @VAR_num_reprobadas =COUNT(historico.cuenta)
FROM controlescolar_bd.dbo.historico historico,
	controlescolar_bd.dbo.academicos academicos
WHERE historico.cuenta = @CUENTA
AND historico.cuenta = academicos.cuenta
AND historico.cve_carrera = academicos.cve_carrera
AND historico.cve_plan = academicos.cve_plan
AND  historico.calificacion not in ('6','7','8','9','10','AC','MB','B','S','RE','E')

IF @VAR_num_reprobadas <= 0
BEGIN
--En un examen extraordinario es necesario haber reprobado alguna materia
	IF @TIPO_EXAMEN = 2
	BEGIN 
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -5,'EL ALUMNO NO TIENE MATERIAS REPROBADAS, NO ES POSIBLE INSCRIBIR UN EXAMEN EXTRAORDINARIO'
			RETURN -5
		END
		ELSE
		BEGIN
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO NO TIENE MATERIAS REPROBADAS, NO ES POSIBLE INSCRIBIR UN EXAMEN EXTRAORDINARIO'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-5'+@VAR_separador
		END
	END
END


--Valida la baja por biblioteca
-- 0	NORMAL
-- 1	AMONESTADO
-- 2	SUSPENSION
-- 3	DADO DE BAJA
IF @VAR_cve_flag_biblioteca =3 OR @VAR_cve_flag_biblioteca =2
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
	 	SELECT -15,'EL ALUMNO ESTA BLOQUEADO POR ADEUDOS DE BIBLIOTECA'
		RETURN -15
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA BLOQUEADO POR ADEUDOS DE BIBLIOTECA'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-15'+@VAR_separador
	END
END 

--Valida la baja por material de laboratorio
IF @VAR_baja_laboratorio =1
BEGIN
	IF @VAR_envia_mensaje_completo =0
	BEGIN
	 	SELECT -16,'EL ALUMNO ESTA DADO DE BAJA POR ADEUDOS DE MATERIAL DE LABORATORIO'
		RETURN -16
	END
	ELSE
	BEGIN
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA DADO DE BAJA POR ADEUDOS DE MATERIAL DE LABORATORIO'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-16'+@VAR_separador
	END
END 


--Obliga que la revisión de los adeudos sea en linea
SELECT 	@VAR_consulta_adeudos_en_linea = 1

--Si al revisar al alumno, se descubre que tiene adeudos, es necesario realizar validaciones en línea
IF @VAR_adeuda_finanzas =1 OR @VAR_consulta_adeudos_en_linea=1
BEGIN

--Valida la baja por finanzas por consulta directa en tesoreria
	SELECT @VAR_cuenta =v_saldos_mov_alumnos.cuenta 
		FROM tesoreria_bd..v_saldos_mov_alumnos v_saldos_mov_alumnos
		WHERE   v_saldos_mov_alumnos.cuenta =@CUENTA
		AND  v_saldos_mov_alumnos.saldo > 5 AND 
		(dateadd(day, 1, v_saldos_mov_alumnos .fecha_vencimiento) <= getdate() 
		OR v_saldos_mov_alumnos.cve_concepto = 33) AND
		(cve_concepto <100)

--Si existe al menos un registro es porque el alumno tiene adeudos
	IF @@ROWCOUNT > 0
	BEGIN
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -18,'EL ALUMNO TIENE ADEUDOS EN TESORERIA'
			RETURN -18
		END
		ELSE
		BEGIN
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO TIENE ADEUDOS EN TESORERIA'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-18'+@VAR_separador
		END
	END 

--ELIMINADO:Valida si el alumno realizó su pago de su primera colegiatura en el periodo vigente

END

--END IF @VAR_adeuda_finanzas =1 OR @VAR_consulta_adeudos_en_linea=1
IF LEN(@VAR_mensaje_completo)>0
BEGIN
	SELECT @VAR_codigo_completo, @VAR_mensaje_completo
	RETURN -1
END
SELECT 0,'OK'       

