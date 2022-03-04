USE web_bd
go


ALTER PROCEDURE [dbo].[sp_valida_alumno_insc]
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
DECLARE @VAR_mensaje_tesoreria VARCHAR(600)
DECLARE @VAR_codigo_tesoreria VARCHAR(600)
DECLARE @VAR_inscripcion_activa INTEGER
DECLARE @VAR_minutos_tolerancia INTEGER
DECLARE @VAR_envia_mensaje_completo INTEGER
DECLARE @VAR_cve_formaingreso  INTEGER
DECLARE @VAR_periodo_ing  INTEGER
DECLARE @VAR_anio_ing  INTEGER
DECLARE @VAR_periodo_mi  INTEGER
DECLARE @VAR_anio_mi  INTEGER
DECLARE @VAR_nivel  VARCHAR(2)
DECLARE @VAR_tipo_periodo VARCHAR(3)

SELECT @VAR_separador ='|'
SELECT @VAR_mensaje_completo =''
SELECT @VAR_codigo_completo =''
SELECT @VAR_envia_mensaje_completo =1
SELECT @VAR_consulta_adeudos_en_linea=1
SELECT @VAR_mensaje_tesoreria = ''
SELECT @VAR_codigo_tesoreria = ''
SELECT @VAR_cve_formaingreso = -1
SELECT @VAR_periodo_ing = -1
SELECT @VAR_anio_ing = -1
SELECT @VAR_periodo_mi = -1
SELECT @VAR_anio_mi = -1
SELECT @VAR_nivel =''


-- Se recuperan la cerrera y el plan.
SELECT @VAR_cve_carrera = v_www_academicos.cve_carrera, 
	   @VAR_cve_plan = v_www_academicos.cve_plan
FROM v_www_academicos
WHERE cuenta = @CUENTA

-- Se recupera el tipo de periodo.
SELECT @VAR_tipo_periodo = dbo.v_www_plan_estudios.tipo_periodo
FROM dbo.v_www_plan_estudios
WHERE dbo.v_www_plan_estudios.cve_carrera = @VAR_cve_carrera
AND dbo.v_www_plan_estudios.cve_plan = @VAR_cve_plan
 



--Obtiene los parametros de los servicios en linea
--Especifica si la inscripción está activa
--Especifica si se enviará el mensaje de error completo solo el primer error detectado
--Lee los minutos de tolerancia de la base de datos
-- Se agrega filtro de tipo de periodo que se selecciona

SELECT  @VAR_inscripcion_activa = isnull(inscripcion_activa,0),   
        @VAR_minutos_tolerancia = isnull(minutos_tolerancia,30),   
        @VAR_envia_mensaje_completo = isnull(envia_mensaje_completo,1),  
                               @VAR_consulta_adeudos_en_linea = isnull(consulta_adeudos_en_linea,1)  
FROM controlescolar_bd.dbo.parametros_servicios   
WHERE controlescolar_bd.dbo.parametros_servicios.tipo_periodo = @VAR_tipo_periodo 


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

IF  @VAR_inscripcion_activa = 0
BEGIN
                IF @VAR_envia_mensaje_completo =0
                BEGIN
                              SELECT -2,'EN ESTE MOMENTO AUN NO ES POSIBLE INSCRIBIRSE'
                               RETURN -2
                END
                ELSE
                BEGIN
--Termina el proceso inmediatamente
                               SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EN ESTE MOMENTO AUN NO ES POSIBLE INSCRIBIRSE'+@VAR_separador
                               SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-2'+@VAR_separador
                               SELECT @VAR_codigo_completo, @VAR_mensaje_completo
                               RETURN -2
                END
END 

--Consulta la carrera y plan de estudios
SELECT @VAR_cve_carrera = academicos.cve_carrera,   
                   @VAR_cve_plan =  academicos.cve_plan,  
                   @VAR_cve_formaingreso =  academicos.cve_formaingreso,  
                   @VAR_periodo_ing =  academicos.periodo_ing,  
                   @VAR_anio_ing =  academicos.anio_ing, 
                   @VAR_periodo_mi = pmi.periodo,
                   @VAR_anio_mi  = pmi.anio,
                   @VAR_nivel = academicos.nivel
FROM   controlescolar_bd.dbo.academicos academicos, dbo.v_www_periodo_mat_inscritas pmi 
WHERE ( academicos.cuenta = @CUENTA )
AND pmi.tipo_periodo = @VAR_tipo_periodo

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

IF  (@VAR_nivel = 'L') AND (@VAR_periodo_ing = @VAR_periodo_mi AND @VAR_anio_ing = @VAR_anio_mi) AND
	(@VAR_cve_formaingreso = 0)
BEGIN 
                IF @VAR_envia_mensaje_completo =0
                BEGIN
                              SELECT -3,'NO SE PERMITEN ALUMNOS DE LICENCIATURA DE PRIMER INGRESO POR EXAMEN DE ADMISION'
                               RETURN -3
                END
                ELSE
                BEGIN
                               SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE PERMITEN ALUMNOS DE LICENCIATURA DE PRIMER INGRESO POR EXAMEN DE ADMISION'+@VAR_separador
                               SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-3'+@VAR_separador
                END

END


--Consulta los bloqueos
SELECT  @VAR_insc_sem_ant = insc_sem_ant,                                               
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

--Consulta los parámetros de activacion de los alumnos para ver si se realizará la 
--validación del horario de entrada
SELECT @VAR_revision_hora_entrada = activacion.revision_hora_entrada
FROM controlescolar_bd.dbo.activacion   activacion
WHERE activacion.tipo_periodo = @VAR_tipo_periodo

--Verifica que exista el registro de activacion en la tabla
IF @@ROWCOUNT = 0
BEGIN
                IF @VAR_envia_mensaje_completo =0
                BEGIN
                               SELECT -5,'NO SE ENCUENTRAN LOS PARAMETROS DE ACTIVACION DEL ALUMNO'
                               RETURN -5
                END
                ELSE
                BEGIN
                               SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'NO SE ENCUENTRAN LOS PARAMETROS DE ACTIVACION DEL ALUMNO'+@VAR_separador
                               SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-5'+@VAR_separador
                END
END 

--Verifica si se actualizó el histórico del alumno para permitirle la inscripción
--Sin esta validación se corre el riesgo de inscribir alumnos en materias ya cursadas
SELECT @VAR_fecha_historico_reinsc = fecha
FROM controlescolar_bd.dbo.historico_reinsc_actual hra, dbo.v_www_periodo_mat_inscritas pmi 
WHERE cuenta = @CUENTA
AND hra.anio = pmi.anio 
AND hra.periodo = pmi.periodo 
IF @@ROWCOUNT = 0
BEGIN
--Se manda este mensaje para que la gente de sistemas lo entienda
                IF @VAR_envia_mensaje_completo =0
                BEGIN
                               SELECT -6,'EL ALUMNO NO TIENE ACTUALIZADO SU HORARIO DE ENTRADA (HISTORICO)'
                               RETURN -6
                END
                ELSE
                BEGIN
                               SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO NO TIENE ACTUALIZADO SU HORARIO DE ENTRADA (HISTORICO)'+@VAR_separador
                               SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-6'+@VAR_separador
                END
END 

--Si el parámetro indica que se revisará el horario de entrada
IF @VAR_revision_hora_entrada = 1
BEGIN
--Verifica si se actualizó el horario de entrada del alumno para permitirle la inscripción
                SELECT @VAR_horario_inscripcion = hi.hora_entrada, 
                               @VAR_hora_actual = getdate(),
        @VAR_horario_inscripcion_str = convert(varchar(20), hi.hora_entrada,103)+' A LAS ' +convert(varchar(20), hi.hora_entrada,108 ) +' hrs.',
        @VAR_horario_con_tolerancia = DATEADD(mi, -@VAR_minutos_tolerancia, hi.hora_entrada)
                FROM controlescolar_bd.dbo.horario_insc hi, dbo.v_www_periodo_mat_inscritas pmi 
                WHERE cuenta = @CUENTA
                AND hi.anio = pmi.anio 
                AND hi.periodo = pmi.periodo 

--Si no existe el horario de inscripción del alumno
                IF @@ROWCOUNT = 0  
                BEGIN
                               IF @VAR_envia_mensaje_completo =0
                               BEGIN
                                              SELECT -7, 'EL ALUMNO NO TIENE ACTUALIZADO SU HORARIO DE ENTRADA (HE)'
                                               RETURN -7
                               END
                               ELSE
                               BEGIN
                                               SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO NO TIENE ACTUALIZADO SU HORARIO DE ENTRADA (HE)'+@VAR_separador
                                               SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-7'+@VAR_separador
                               END
                END 
                ELSE
--Le añade una tolerancia de X minutos (grlte 30) a la hora de inscripción del alumno
                BEGIN
                               
--                            SELECT @VAR_horario_con_tolerancia = DATEADD(mi, -@VAR_minutos_tolerancia, @VAR_horario_inscripcion)
--Si aun con la tolerancia el alumno no puede inscribirsa
                               IF  @VAR_horario_con_tolerancia > @VAR_hora_actual 
                               BEGIN
                                               IF @VAR_envia_mensaje_completo =0
                                               BEGIN
                                                             SELECT -8,'EL ALUMNO NO PUEDE INSCRIBIRSE HASTA EL DÍA '+@VAR_horario_inscripcion_str
                                                               RETURN -8
                                               END
                                               ELSE
                                               BEGIN
                                                               SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO NO PUEDE INSCRIBIRSE HASTA EL DÍA '+@VAR_horario_inscripcion_str+@VAR_separador
                                                               SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-8'+@VAR_separador
                                               END
                               END
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

--Valida invasor de horario
--IF @VAR_invasor_hora = 1
--BEGIN
--            IF @VAR_envia_mensaje_completo =0
--            BEGIN
--                            SELECT -10,'EL ALUMNO BLOQUEADO POR INVADIR SU HORA DE ENTRADA'
--                            RETURN -10
--            END
--            ELSE
--            BEGIN
--            SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO BLOQUEADO POR INVADIR SU HORA DE ENTRADA'+@VAR_separador
--                            SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-10'+@VAR_separador
--            END
--END 

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
-- 0         NORMAL
-- 1         AMONESTADO
-- 2         BAJA
-- 3         EXENTO
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

--Valida que el alumno haya estado inscrito el semestre anterior
IF @VAR_insc_sem_ant =0
BEGIN
--Verifica si el alumno tramitó un reingreso, en cuyo caso es como si hubiese estado inscrito
                SELECT @VAR_cuenta = hr.cuenta
                FROM controlescolar_bd.dbo.hist_reingreso hr, v_www_periodo_mat_inscritas pmi
                WHERE hr.cuenta = @CUENTA
                AND      hr.periodo_ing = pmi.periodo 
                AND      hr.anio_ing = pmi.anio  
                IF @@ROWCOUNT <= 0
                BEGIN
                               IF @VAR_envia_mensaje_completo =0
                               BEGIN
                                              SELECT -14,'EL ALUMNO ESTA BLOQUEADO POR NO ESTAR INSCRITO EL SEMESTRE ANTERIOR'
                                               RETURN -14
                               END
                               ELSE
                               BEGIN
                                               SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + 'EL ALUMNO ESTA BLOQUEADO POR NO ESTAR INSCRITO EL SEMESTRE ANTERIOR'+@VAR_separador
                                    SELECT @VAR_codigo_completo =@VAR_codigo_completo + '-14'+@VAR_separador
                               END
                END
END 


--Valida la baja por biblioteca
-- 0         NORMAL
-- 1         AMONESTADO
-- 2         SUSPENSION
-- 3         DADO DE BAJA
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

IF @VAR_adeuda_finanzas =1 OR @VAR_consulta_adeudos_en_linea=1 --Bloque de Finanzas
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

                --Tiene el pago de la primera colegiatura?
                SELECT @VAR_cuenta= a.cuenta, 
                                               @VAR_anio= b.anio, 
                                               @VAR_periodo =b.periodo 
                FROM v_www_pagos_inscripcion a, v_www_periodo_mat_inscritas b 
                WHERE a.cuenta = @CUENTA
                AND      a.periodo = b.periodo 
                AND      a.anio = b.anio  
                GROUP BY a.cuenta ,b.anio,b.periodo 
                HAVING sum(isnull(a.saldo,0))<0 

                IF @@ROWCOUNT = 0 --No tiene el pago de la 1a Colegiatura
                BEGIN
                               SELECT @VAR_pago_1a_colegiatura = 0
                               SELECT @VAR_mensaje_tesoreria = 'NO SE ENCUENTRA EL PAGO DE LA PRIMERA COLEGIATURA DEL ALUMNO'+@VAR_separador
                               SELECT @VAR_codigo_tesoreria = '-19'+@VAR_separador
                END
                ELSE
                               SELECT @VAR_pago_1a_colegiatura = 1
                
                IF @VAR_pago_1a_colegiatura = 0 --Si no tiene 1a Colegiatura Buscar si tiene Beca
                BEGIN
                               --Obtiene el procentaje de apoyo de la beca para el alumno que no pago la primera colegiatura
                               SELECT @VAR_porcentaje_apoyo = a.porcentaje_total
                               FROM dbo.v_sfeb_apoyos_activos_new a, dbo.v_www_periodo_mat_inscritas b 
                               WHERE cuenta = @CUENTA
                               AND a.anio = b.anio 
                               AND a.periodo = b.periodo 
                --
                               IF @@ROWCOUNT = 0  --No tiene Beca
                               BEGIN
                                   --Solicitud 05-enero-2010: Si no existe el pago de la 1a colegiatura, y no tiene beca,
                                   --verificar si existe el pago de horas por anticipado antes de impedir el acceso a inscripción.
                                   SELECT @VAR_porcentaje_apoyo = 0
                                               SET @VAR_mensaje_tesoreria = @VAR_mensaje_tesoreria +'EL ALUMNO NO TIENE PORCENTAJE DE APOYO-BECA REGISTRADO'+@VAR_separador
                                               SET @VAR_codigo_tesoreria  = @VAR_codigo_tesoreria + '-40'+ @VAR_separador
                                               
                                   SELECT @VAR_num_horas_anticipadas = isnull(sum(CASE (cve_estatus_tarjata)
                                                               WHEN 1 THEN -horas WHEN 2 THEN -horas
                                                                               WHEN 3 THEN horas  WHEN 4 THEN horas
                                                                              ELSE 0 END),0)
                                                               FROM v_www_pa_tarjeta_horas
                                                               WHERE cuenta = @CUENTA
                                               IF @VAR_num_horas_anticipadas <=0 --No tiene hrs pagadas x anticipado
                                                               BEGIN
                                                                              SELECT @VAR_pago_1a_colegiatura = 0
                                                                              IF @VAR_envia_mensaje_completo =0
                                                                              BEGIN
                                                                                              SELECT @VAR_mensaje_tesoreria = @VAR_mensaje_tesoreria +'EL ALUMNO NO TIENE REGISTRADO PAGOS DE HORAS ANTICIPADAS'+@VAR_separador
                                                                                              SELECT @VAR_codigo_tesoreria = @VAR_codigo_tesoreria + '-22'+@VAR_separador
                                                                                             SELECT -21,@VAR_mensaje_tesoreria
                                                                                              RETURN -21
                                                                              END
                                                                              ELSE
                                                                              BEGIN
                                                                                              SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + @VAR_mensaje_tesoreria+'EL ALUMNO NO TIENE REGISTRADO PAGOS DE HORAS ANTICIPADAS'+@VAR_separador
                                           SELECT @VAR_codigo_completo = @VAR_codigo_completo + @VAR_codigo_tesoreria+ '-22'+@VAR_separador
                                                                              END
                                                               END       
                               END
                               ELSE --Ok si tiene beca
                               BEGIN
                                               --Si el alumno no cuenta con beca al 100%
                                               IF @VAR_porcentaje_apoyo < 100
                                               BEGIN
                                                               --Verifica si el alumno ha pagado horas por anticipado, lo que lo excluye del pago 
                                                               --de la primera colegiatura
                                                               SELECT @VAR_num_horas_anticipadas = isnull(sum(CASE (cve_estatus_tarjata)
                                                               WHEN 1 THEN -horas WHEN 2 THEN -horas
                                                                               WHEN 3 THEN horas  WHEN 4 THEN horas
                                                                              ELSE 0 END),0)
                                                              FROM v_www_pa_tarjeta_horas
                                                               WHERE cuenta = @CUENTA       
                                               --
                                                               IF @VAR_num_horas_anticipadas <=0 --No tiene hrs pagadas x anticipado
                                                               BEGIN
                                                                              SELECT @VAR_pago_1a_colegiatura = 0
                                                                              IF @VAR_envia_mensaje_completo =0
                                                                              BEGIN
                                                                                              SELECT @VAR_mensaje_tesoreria = @VAR_mensaje_tesoreria +'EL ALUMNO NO TIENE REGISTRADO PAGOS DE HORAS ANTICIPADAS'+@VAR_separador
                                                                                              SELECT @VAR_codigo_tesoreria = @VAR_codigo_tesoreria + '-22'+@VAR_separador
                                                                                             SELECT -21,@VAR_mensaje_tesoreria
                                                                                              RETURN -21
                                                                              END
                                                                              ELSE
                                                                              BEGIN
                                                                                              SELECT @VAR_mensaje_completo =@VAR_mensaje_completo + @VAR_mensaje_tesoreria+'EL ALUMNO NO TIENE REGISTRADO PAGOS DE HORAS ANTICIPADAS'+@VAR_separador
                                                                                              SELECT @VAR_codigo_completo = @VAR_codigo_completo + @VAR_codigo_tesoreria+ '-22'+@VAR_separador
                                                                              END
                                                               END-- (Bloque de NO hrs x anticipado)
                                                               
                                               END-- (Bloque de beca < 100)
                               END--(Bloque de Tiene Beca)
                END --(Bloque Sin pago de 1a Colegiatura)
END --(Bloque de Finanzas)

IF LEN(@VAR_mensaje_completo)>0
BEGIN
                SELECT @VAR_codigo_completo, @VAR_mensaje_completo
                RETURN -1
END
SELECT 0,'OK'       


GO

