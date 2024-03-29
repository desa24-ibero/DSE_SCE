USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_valida_alumno_intercambio]    Script Date: 9/8/2017 09:08:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_valida_alumno_intercambio]
 @CUENTA int
 
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
DECLARE @VAR_num_intercambios INTEGER
DECLARE @VAR_num_reprobadas INTEGER
DECLARE @VAR_num_aprobadas INTEGER
DECLARE @VAR_creditos_cursados INTEGER		
DECLARE @VAR_creditos_minimos_lic INTEGER		
DECLARE @VAR_nivel VARCHAR(1)
DECLARE @VAR_promedio REAL
DECLARE @VAR_puntaje_min REAL

SELECT @VAR_separador ='|'
SELECT @VAR_mensaje_completo =''
SELECT @VAR_codigo_completo =''
SELECT @VAR_envia_mensaje_completo =1
SELECT @VAR_consulta_adeudos_en_linea=1

--Obtiene los parametros de los servicios en linea
--Especifica si la inscripción está activa
--Especifica si se enviará el mensaje de error completo solo el primer error detectado
--Lee los minutos de tolerancia de la base de datos

SELECT @VAR_num_intercambios= isnull(COUNT(cve_periodo_intercambio),0)
FROM dca_periodo_intercambio pi, v_www_periodo p
where isnull(pi.fecha_inicial,getdate()) >= getdate()
and  getdate()<= isnull(pi.fecha_final,getdate())
and pi.periodo = p.periodo
 
--Si no existen estos parametros es porque no existen periodos activos
IF @@ROWCOUNT = 0 OR @VAR_num_intercambios= 0
BEGIN
	SELECT @VAR_envia_mensaje_completo =1
	IF @VAR_envia_mensaje_completo =0
	BEGIN
 		SELECT -1,'NO SE ENCUENTRA INFORMACIÓN DE LOS PERIODOS DE INTERCAMBIO O NO HAY ACTIVOS'
		RETURN -1
	END
	ELSE
	BEGIN
--Termina el proceso inmediatamente
		SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE ENCUENTRA INFORMACIÓN DE LOS PERIODOS DE INTERCAMBIO O NO HAY ACTIVOS'+@VAR_separador
		SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
		SELECT @VAR_codigo_completo, @VAR_mensaje_completo
		RETURN -1
	END
END 

--Consulta el número de materias reprobadas o NO Acreditadas en el histórico con la carrera y plan de estudio vigente
SELECT @VAR_num_reprobadas = ISNULL(COUNT(h.cuenta),0)
FROM v_www_historico h, v_www_academicos ac
where h.cuenta = @CUENTA
AND h.cuenta = ac.cuenta 
AND h.cve_carrera = ac.cve_carrera
AND h.cve_plan= ac.cve_plan
AND h.calificacion IN ( 'NA', '5')

--Si no existen registros es porque el alumno no tiene reprobadas
IF @VAR_num_reprobadas>0
BEGIN
--Si el alumno tiene 3 o más reprobadas, NO podrá irse de intercambio
	IF @VAR_num_intercambios >=3
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -1,'ALUMNO CON MÁS DE 3 REPROBADAS.'
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'ALUMNO CON MÁS DE 3 REPROBADAS.'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
		END
	END
END 


--Consulta el número de materias reprobadas o NO Acreditadas en el histórico con la carrera y plan de estudio vigente
SELECT @VAR_num_aprobadas = COUNT(h.cuenta)
FROM v_www_historico h, v_www_academicos ac
where h.cuenta = @CUENTA
AND h.cuenta = ac.cuenta 
AND h.cve_carrera = ac.cve_carrera
AND h.cve_plan= ac.cve_plan
AND h.calificacion IN ('6','7','8','9','10','AC','MB','B','S','RE','E')

--Si no existen registros es porque el alumno no tiene Aprobadas
IF @@ROWCOUNT = 0 
BEGIN
--Si el alumno tiene menos de 2 aeprobadas, NO podrá irse de intercambio
	IF @VAR_num_aprobadas <=0
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
 			SELECT -1,'ALUMNO SIN MATERIAS APROBADAS.'
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'ALUMNO SIN MATERIAS APROBADAS.'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
		END
	END
END 

--Consulta la carrera y plan de estudios
SELECT @VAR_cve_carrera = academicos.cve_carrera,   
	   @VAR_cve_plan =  academicos.cve_plan,
	   @VAR_creditos_cursados = academicos.creditos_cursados,
	   @VAR_nivel= academicos.nivel,
	   @VAR_promedio= academicos.promedio,
	   @VAR_puntaje_min = pe.puntaje_min
FROM	controlescolar_bd.dbo.academicos academicos, v_www_plan_estudios pe
WHERE	( academicos.cuenta = @CUENTA )
AND  academicos.cve_carrera = pe.cve_carrera
AND  academicos.cve_plan = pe.cve_plan

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

--Si es de licenciatura
IF @VAR_nivel <> 'P' -- MALH 08/08/2017 -> IF @VAR_nivel = 'L' 
BEGIN
	select @VAR_creditos_minimos_lic = 120
--Si el alumno de licenciatura tiene menos de 120 créditos, no se permite el intercambio
	IF @VAR_creditos_cursados < @VAR_creditos_minimos_lic
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
			SELECT -1,'ALUMNO DE LICENCIATURA CON MENOS DE 120 CREDITOS ['+convert(varchar(5),@VAR_creditos_cursados)+'].'
			RETURN -1
		END
		ELSE
		BEGIN
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'ALUMNO DE LICENCIATURA CON MENOS DE 120 CREDITOS ['+convert(varchar(5),@VAR_creditos_cursados)+'].'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-3'+@VAR_separador
		END
	END
--Si el promedio del alumno es menor al puntaje mínimo de calidad
	IF @VAR_promedio < @VAR_puntaje_min 
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
			SELECT -1,'ALUMNO DE LICENCIATURA CON PROMEDIO MENOR A ['+CONVERT(VARCHAR(5),@VAR_puntaje_min)+'] QUE ES EL PUNTAJE DE CALIDAD'
			RETURN -1
		END
		ELSE
		BEGIN
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'ALUMNO DE LICENCIATURA CON PROMEDIO MENOR A ['+CONVERT(VARCHAR(5),@VAR_puntaje_min)+'] QUE ES EL PUNTAJE DE CALIDAD'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-3'+@VAR_separador
		END
	END
END
ELSE
--Si es de posgrado
IF @VAR_nivel = 'P' 
BEGIN
--Si el alumno de posgrado tiene menos de 2 aprobadas, no se permite el intercambio
	IF @VAR_num_aprobadas <=2
	BEGIN
		SELECT @VAR_envia_mensaje_completo =1
		IF @VAR_envia_mensaje_completo =0
		BEGIN
			SELECT -1,'ALUMNO DE POSGRADO CON MENOS DE 2 APROBADAS.'
			RETURN -1
		END
		ELSE
		BEGIN
--Termina el proceso inmediatamente
			SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'ALUMNO DE POSGRADO CON MENOS DE 2 APROBADAS.'+@VAR_separador
			SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-1'+@VAR_separador
			SELECT @VAR_codigo_completo, @VAR_mensaje_completo
			RETURN -1
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

IF LEN(@VAR_mensaje_completo)>0
BEGIN
	SELECT @VAR_codigo_completo, @VAR_mensaje_completo
	RETURN -1
END
SELECT 0,'OK'       
