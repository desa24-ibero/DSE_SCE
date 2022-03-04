IF OBJECT_ID ('dbo.sp_sg_materias_x_car') IS NOT NULL
	DROP PROCEDURE dbo.sp_sg_materias_x_car
GO

CREATE PROCEDURE dbo.sp_sg_materias_x_car  @ai_anio Int, @ai_periodo Int, @a_carrera INTEGER, @a_plan INTEGER, @con_RyO BIT
AS

DECLARE @lc_nivel 			CHAR(1),
		@ll_carrera			INT,
		@ll_plan			INT,
		@ll_sems_cu			INT,
		@ll_sems_id			INT,
		@ll_cuenta			INT,
		@ls_curricula		Varchar(15),
		@li_cuenta			INT,
		@li_cve_mat 		INT,
		@li_semestre_ideal 	TINYINT,
		@ls_materia 		VARCHAR(42),
		@lc_tipo			CHAR(1),
		@li_con_prerreq		SMALLINT,
		@li_orden			smallint,
		@li_periodo			Int,
		@li_prereq_val		Int

		
Begin Transaction
	Delete From sg_t_curr_ideal
	Delete From sg_t_curr_pend
Commit Transaction
		
/*
--- TABLAS TEMPORALES		
CREATE TABLE #t_curr_ideal
	(
	curricula 		VARCHAR (15),
	cve_mat 		INT,
	semestre_ideal 	TINYINT NULL,
	materia 		VARCHAR (42),
	tipo			CHAR(1),
	con_prerreq		SMALLINT	
	)
*/
CREATE TABLE #t_curr_actual
	(
	curricula 		VARCHAR (6),
	cve_mat 		INT,
	semestre_ideal 	TINYINT NULL,
	materia 		VARCHAR (42),
	status 			VARCHAR (8),
	periodo 		TINYINT,
	anio 			SMALLINT,
	tipo 			VARCHAR (1) NULL
	)
/*
CREATE TABLE #t_curr_pend
	(
	curricula 		VARCHAR (15),
	cve_mat 		INT,
	semestre_ideal 	TINYINT NULL,
	materia 		VARCHAR (42),
	tipo			CHAR(1),
	con_prerreq		SMALLINT
	)
*/
CREATE TABLE #t_curr_prop
	(
	curricula 		VARCHAR(15),
	cuenta			INT,
	cve_mat 		INT,
	semestre_ideal 	TINYINT NULL,
	materia 		VARCHAR(42),
	tipo			CHAR(1),
	con_prerreq		SMALLINT,
	orden			smallint
	)
	
	
--- TABLAS TEMPORALES		

-- TODAS LAS MATERIOS DE REFLEXION UNIVERSITARIA
SELECT DISTINCT cve_mat,'R' AS tipo
INTO #t_reflexion
FROM area_mat WHERE cve_area  IN (select cve_area from sg_areas_para_mat_reflexion)

-- OSS. Cuando aplique optativas, verificar si se debe descartar como optativas las materias 
-- Remedial español 90203 y remedial matematicas 90204 ...
-- TODAS LAS MATERIAS OPTATIVAS
SELECT DISTINCT cve_mat,'O' AS tipo
INTO	#t_optativas
FROM	mat_prerrequisito
WHERE	cve_carrera = @a_carrera AND
		cve_plan = @a_plan AND
		( optativa = 1 OR clase_area = 'OPT') AND
		cve_mat not in (select cve_mat from sg_mat_no_considerar) -- Materias que no se consideran ...


SELECT @lc_nivel = ca.nivel
FROM plan_estudios pe,
	 carreras ca
WHERE pe.cve_carrera 	= ca.cve_carrera
	AND pe.cve_carrera	= @a_carrera
	AND pe.cve_plan	 	= @a_plan


-- CURRICULA IDEAL LICENCIATURA
/*IF @lc_nivel = 'L' */
IF @lc_nivel <> 'P' 
	-- 17 Ene 2013, Se modifica el query para que tome todas las materias obligatorias de una tabla para el plan SUJ y para todos los planes posibles que se puedan crear ...
	INSERT INTO sg_t_curr_ideal
	SELECT	'IDEAL' AS curricula, pr.cve_mat,pr.semestre_ideal,m.materia,'N' AS tipo, count(pre.cve_prerreq) AS con_prerreq
	FROM	mat_prerrequisito pr,
			materias m,
			prerrequisitos pre
	WHERE	pr.cve_carrera = @a_carrera AND
			pr.cve_plan = @a_plan AND
			( pr.clase_area IN (NULL) OR clase_area in (Select clase_area from sg_clase_area_x_plan where considerar = 1 AND descripcion = 'MATERIA OBLIGATORIA' ) ) AND
			pr.optativa <> 1 AND -- En el plan SUJ estan marcadas como optativoa = 1 las optativas y remediales ...
			pr.semestre_ideal > 0 AND
			pr.cve_mat = m.cve_mat AND
			pr.cve_mat *= pre.cve_mat AND
			pr.cve_carrera *= pre.cve_carrera AND
			pr.cve_plan *= pre.cve_plan and
			pr.cve_mat not in (select cve_mat from sg_mat_no_considerar) -- Materias que no se consideran ...
	GROUP BY pr.cve_mat,pr.semestre_ideal,m.materia

	--UNION
	
	IF @con_RyO = 1
		-- reflexion universitaria y optativas REFLEXION UNIVERSITARIA Y OPTATIVAS	
		INSERT INTO sg_t_curr_ideal
		SELECT 'IDEAL' AS curricula,a.cve_mat,a.semestre_ideal, --'** REFLEXIÓN / OPTATIVAS' 
				CASE WHEN a.sigla LIKE 'RU%' 
					THEN '** REFLEXION UNIVERSITARIA'
					ELSE '** MATERIA OPTATIVA'
				END,
				CASE WHEN a.sigla LIKE 'RU%' THEN 'R'
					 ELSE 'O'
				END,0
						
		FROM plantilla_plan_materia a
		WHERE a.cve_carrera = @a_carrera
			AND a.cve_plan = @a_plan
		ORDER BY semestre_ideal	
	
-- CURRICULA IDEAL POSGRADO
ELSE
 
	INSERT INTO sg_t_curr_ideal
	SELECT	'IDEAL' AS curricula,a.cve_mat, a.semestre_ideal,m.materia,'N',count(pr.cve_prerreq)			
	FROM	mat_prerreq_pos a,
			materias m,
			prerrequisitos pr
	WHERE	a.cve_carrera = @a_carrera AND
			a.cve_plan = @a_plan AND
			a.cve_mat = m.cve_mat AND
			a.semestre_ideal > 0 AND
			a.cve_mat *= pr.cve_mat AND
			a.cve_carrera *= pr.cve_carrera AND
			a.cve_plan *= pr.cve_plan and
			pr.cve_mat not in (select cve_mat from sg_mat_no_considerar) -- Materias que no se consideran ...
	GROUP BY a.cve_mat, a.semestre_ideal,m.materia
	ORDER BY a.semestre_ideal	


--SELECT * FROM #t_curr_ideal ORDER BY semestre_ideal, cve_mat

-- Obtener el periodo actual ...
Select @li_periodo = periodo from periodos_por_procesos where cve_proceso = 5

IF @li_periodo = 1
Begin
	
	-- Si el Periodo corresponde a Verano, se consideran los alumnos de la vista v_sg_alumnos_verano ...
	DECLARE cur_alumnos_car CURSOR FOR
	SELECT a.cuenta 
	FROM academicos a,
		 v_sg_alumnos_verano b
	WHERE a.cuenta = b.cuenta
		AND a.cve_carrera = @a_carrera
		AND a.cve_plan = @a_plan
	

End
Else
Begin
	
	DECLARE cur_alumnos_car CURSOR FOR
	SELECT a.cuenta 
	FROM academicos a,
		 banderas_inscrito b
	WHERE a.cuenta = b.cuenta
		AND a.cve_carrera = @a_carrera
		AND a.cve_plan = @a_plan

END

OPEN cur_alumnos_car
FETCH NEXT FROM cur_alumnos_car INTO @ll_cuenta

WHILE (@@FETCH_STATUS = 0) BEGIN
	--SELECT @ll_cuenta AS alumno, @ll_cuenta AS alumno2
	
	SELECT @lc_nivel	= nivel,
		   @ll_carrera	= cve_carrera,
		   @ll_plan		= cve_plan,
		   @ll_sems_cu	= sem_cursados
	FROM academicos 
	WHERE cuenta = @ll_cuenta
	
	/*-- DATOS
	SELECT al.cuenta, al.nombre, al.apaterno, al.amaterno,ca.cve_carrera, ca.carrera, ca.nivel, ac.sem_cursados,@ll_sems_id AS semestres_ideal
	FROM alumnos al,
		 academicos ac,
		 carreras ca
	WHERE al.cuenta = ac.cuenta
		AND ac.cve_carrera = ca.cve_carrera
		AND al.cuenta = @ll_cuenta*/
	


	-- CURRICULA ACTUAL LICENCIATURA
	-- OSS. Para obtener las materias ya cursadas en semestries anteriores, se consulta la tabla historico,
	-- para obtener las materias que el alumno actualmente está cursando se consulta la tabla mat_inscritas.
	
	-- OSS. Se consideran de historico sólo las materias que el alumno tiene con calificación aprobatoria ...
	/*IF @lc_nivel = 'L' */
	IF @lc_nivel <> 'P' 
		INSERT INTO #t_curr_actual
		SELECT	'ACTUAL' AS curricula, h.cve_mat,mp.semestre_ideal,m.materia,'CURSADA' AS status , h.periodo, h.anio,
				CASE WHEN mp.semestre_ideal = 0 THEN 'R'
					WHEN mp.semestre_ideal > 0 AND mp.optativa <> 1 THEN 'N'
				ELSE 'O'
				END 
		FROM	historico h,
				academicos ac,
				mat_prerrequisito mp,
				materias m,
				sg_calificaciones c -- calificaciones aprobatorias
		WHERE	h.cuenta = @ll_cuenta AND
				h.cve_carrera = @a_carrera AND
				ac.cuenta = h.cuenta AND
				ac.cve_carrera = mp.cve_carrera AND
				ac.cve_plan = mp.cve_plan AND
				h.cve_mat = mp.cve_mat AND
				h.cve_mat = m.cve_mat AND
				c.calificacion = h.calificacion AND
				h.cve_mat not in (select cve_mat from sg_mat_no_considerar) -- Materias que no se consideran ...
		
		UNION
		
		-- OSS. Se asume que el alumno tendrá una calificación aprobatoria para las materias que esta cursando ...
		SELECT	'ACTUAL',mi.cve_mat, mp.semestre_ideal,m.materia,'CURSANDO' AS status, mi.periodo, mi.anio,
				CASE WHEN mp.semestre_ideal = 0 THEN 'R'
					WHEN mp.semestre_ideal > 0 AND mp.optativa <> 1 THEN 'N'
				ELSE 'O'
				END 
		FROM	mat_inscritas mi,
				academicos ac,
				mat_prerrequisito mp,
				materias m
		WHERE	mi.cuenta = @ll_cuenta AND
				ac.cve_carrera = @a_carrera AND
				ac.cuenta = mi.cuenta AND
				ac.cve_carrera = mp.cve_carrera AND
				ac.cve_plan = mp.cve_plan AND
				mi.cve_mat = mp.cve_mat AND
				mi.cve_mat = m.cve_mat AND
				mi.cve_condicion <> 1 AND -- condicion.gpo.cond_gpo = 1 (ACTIVO)
				mi.cve_mat not in (select cve_mat from sg_mat_no_considerar) -- Materias que no se consideran ...
		ORDER BY semestre_ideal,anio, periodo
		
	-- CURRICULA ACTUAL POSGRADO	
	ELSE
		INSERT INTO #t_curr_actual
		SELECT	'ACTUAL' AS curricula, h.cve_mat,mp.semestre_ideal,m.materia,'CURSADA' AS status , h.periodo, h.anio,
				NULL AS TIPO
		FROM	historico h,
				academicos ac,
				mat_prerreq_pos mp,
				materias m,
				sg_calificaciones c -- calificaciones aprobatorias
		WHERE	h.cuenta = @ll_cuenta AND
				h.cve_carrera = @a_carrera AND
				ac.cuenta = h.cuenta AND
				ac.cve_carrera = mp.cve_carrera AND
				ac.cve_plan = mp.cve_plan AND
				h.cve_mat = mp.cve_mat AND
				h.cve_mat = m.cve_mat AND
				c.calificacion = h.calificacion
		
		UNION	
		
		SELECT	'ACTUAL',mi.cve_mat, mp.semestre_ideal,m.materia,'CURSANDO' AS status, mi.periodo, mi.anio,
				NULL AS TIPO
		FROM	mat_inscritas mi,
				academicos ac,
				mat_prerreq_pos mp,
				materias m
		WHERE	mi.cuenta = @ll_cuenta AND
				ac.cve_carrera = @a_carrera AND
				ac.cuenta = mi.cuenta AND
				ac.cve_carrera = mp.cve_carrera AND
				ac.cve_plan = mp.cve_plan AND
				mi.cve_mat = mp.cve_mat AND
				mi.cve_mat = m.cve_mat AND
				mi.cve_condicion <> 1
		ORDER BY	semestre_ideal,anio, periodo	
	
	--SELECT * FROM #t_curr_actual
	

	-- CURRICULA PENDIENTE
	Select @li_prereq_val = 0
	
	-- Verificar si la materia tiene prerequisito , devuelve 0 si el prerrequisito es válido o si la materia no tiene prerequisito ...
	--exec @li_prereq_val = sp_sg_validacion_prereq @ll_cuenta, 20068, @a_carrera, @ll_plan, 0
----------------------------------------------------------------------------------------

DECLARE @ls_curricula2		VarChar(20),
		@li_cve_mat2		INT,
		@ll_semestre_ideal	INT,
		@ls_materia2		Varchar (100),
		@lc_tipo2			Char(1),
		@li_con_prerreq2	SmallInt
		
	DECLARE cur_curr_ideal CURSOR FOR
	SELECT	'PENDIENTE' AS curricula,a.cve_mat, a.semestre_ideal, a.materia, a.tipo, a.con_prerreq
	FROM	sg_t_curr_ideal a
	WHERE	NOT EXISTS (	SELECT	* 
							FROM	historico h,
									sg_calificaciones c -- calificaciones aprobatorias
							WHERE	h.cuenta = @ll_cuenta
							AND		h.cve_mat = a.cve_mat
							AND		h.calificacion = c.calificacion 
						) AND
			a.cve_mat NOT IN (SELECT cve_mat FROM mat_inscritas h WHERE h.cuenta = @ll_cuenta ) AND
			a.tipo = 'N'


	OPEN cur_curr_ideal
	FETCH NEXT FROM cur_curr_ideal INTO @ls_curricula2, @li_cve_mat2, @ll_semestre_ideal, @ls_materia2, @lc_tipo2, @li_con_prerreq2

	WHILE (@@FETCH_STATUS = 0) BEGIN
	
		Declare @no_cumple int
		--exec @no_cumple = sp_sg_validacion_prereq @ll_cuenta, @li_cve_mat2, @a_carrera, @a_plan
		exec sp_sg_validacion_prereq @ll_cuenta, @li_cve_mat2, @a_carrera, @a_plan, @no_cumple output
		--select @no_cumple = dbo.f_sg_validacion_prereq (@ll_cuenta, a.cve_mat, @a_carrera, @a_plan)
		
		if @no_cumple = 0
		begin
		
			INSERT INTO sg_t_curr_pend values ( @ls_curricula2, @li_cve_mat2, @ll_semestre_ideal, @ls_materia2, @lc_tipo2, @li_con_prerreq2 )
			
		end
		
		FETCH NEXT FROM cur_curr_ideal INTO @ls_curricula2, @li_cve_mat2, @ll_semestre_ideal, @ls_materia2, @lc_tipo2, @li_con_prerreq2
	END 

	CLOSE cur_curr_ideal
	DEALLOCATE cur_curr_ideal
	
----------------------------------------------------------------------------------------
/*
	INSERT INTO #t_curr_pend
	SELECT	'PENDIENTE' AS curricula,a.cve_mat, a.semestre_ideal, a.materia, a.tipo, a.con_prerreq
	FROM	#t_curr_ideal a
	WHERE	NOT EXISTS (	SELECT	* 
							FROM	historico h,
									sg_calificaciones c -- calificaciones aprobatorias
							WHERE	h.cuenta = @ll_cuenta
							AND		h.cve_mat = a.cve_mat
							AND		h.calificacion = c.calificacion 
						) AND
			a.cve_mat NOT IN (SELECT cve_mat FROM mat_inscritas h WHERE h.cuenta = @ll_cuenta ) AND
			a.tipo = 'N' --AND
			--0 = dbo.f_sg_validacion_prereq (@ll_cuenta, a.cve_mat, @a_carrera, @a_plan)
*/			
/*	
	-- El sig. union solo aplicará cuando se consideren materias de reflexion Universitaria y Optativas ...
	UNION
	
	SELECT	'PENDIENTE' AS curricula,a.cve_mat, a.semestre_ideal, a.materia, a.tipo, a.con_prerreq
	FROM	#t_curr_ideal a
	WHERE	a.tipo <> 'N'
*/
-- Comentar estas lineas	
/*
	if @ll_cuenta = 166187
--	if @ll_cuenta = 5627
	begin
		SELECT * FROM #t_curr_pend
		
		SELECT		TOP 12 'PROPUESTA' AS curricula,@ll_cuenta ,p.cve_mat,p.semestre_ideal,p.materia,p.tipo,p.con_prerreq,'Caro'
		FROM		#t_curr_pend p
		WHERE		p.tipo = 'N'
		ORDER BY	p.semestre_ideal asc,p.con_prerreq desc,p.cve_mat
		
		print 'hola'
		Return
	End
*/
	
	----------------------------------------------------------------------------------------------------------
	-- proponer hasta 13 cursos!!  3 Reflexión, 3 Optativas y 7 NORMALES 
	-- Se ordenan por semestre ideal y por prerrequisito, debido a que se comenzará por proponer
	-- las materias con mayor retraso dando prioridad a las materias seriadas (con prerrequisitos)
	----------------------------------------------------------------------------------------------------------
	/*IF @lc_nivel = 'L' */
	IF @lc_nivel <> 'P' 
	Begin
	Begin Transaction
		DECLARE cur_materias_propuestas CURSOR FOR
			SELECT		TOP 7 'PROPUESTA' AS curricula,@ll_cuenta ,p.cve_mat,p.semestre_ideal,p.materia,p.tipo,p.con_prerreq
			FROM		sg_t_curr_pend p
			WHERE		p.tipo = 'N'
			ORDER BY	p.semestre_ideal asc,p.con_prerreq desc,p.cve_mat

		OPEN cur_materias_propuestas
		
		Select @li_orden = 0
		FETCH NEXT FROM cur_materias_propuestas INTO @ls_curricula, @li_cuenta, @li_cve_mat, @li_semestre_ideal, @ls_materia,@lc_tipo, @li_con_prerreq

		WHILE (@@FETCH_STATUS = 0) BEGIN
			Select @li_orden = @li_orden + 1
			
			INSERT		INTO #t_curr_prop
			SELECT		@ls_curricula, @li_cuenta, @li_cve_mat, @li_semestre_ideal, @ls_materia,@lc_tipo, @li_con_prerreq, @li_orden
			
			FETCH NEXT FROM cur_materias_propuestas INTO @ls_curricula, @li_cuenta, @li_cve_mat, @li_semestre_ideal, @ls_materia,@lc_tipo, @li_con_prerreq
		END 

		CLOSE cur_materias_propuestas
		DEALLOCATE cur_materias_propuestas
	Commit Transaction
	
/*	
		INSERT		INTO #t_curr_prop
		SELECT		TOP 8 'PROPUESTA' AS curricula,@ll_cuenta ,p.cve_mat,p.semestre_ideal,p.materia,p.tipo,p.con_prerreq,1
		FROM		#t_curr_pend p
		WHERE		p.tipo = 'N'
		ORDER BY	p.semestre_ideal,p.con_prerreq,p.cve_mat
*/		
	
	End
	ELSE
	Begin
	Begin Transaction
		DECLARE cur_materias_propuestas CURSOR FOR
			SELECT		TOP 4 'PROPUESTA' AS curricula,@ll_cuenta ,p.cve_mat,p.semestre_ideal,p.materia,p.tipo,p.con_prerreq
			FROM		sg_t_curr_pend p
			WHERE		p.tipo = 'N'
			ORDER BY	p.semestre_ideal asc,p.con_prerreq desc,p.cve_mat

		OPEN cur_materias_propuestas
		
		Select @li_orden = 0
		FETCH NEXT FROM cur_materias_propuestas INTO @ls_curricula, @li_cuenta, @li_cve_mat, @li_semestre_ideal, @ls_materia,@lc_tipo, @li_con_prerreq

		WHILE (@@FETCH_STATUS = 0) BEGIN
			Select @li_orden = @li_orden + 1
			
			INSERT		INTO #t_curr_prop
			SELECT		@ls_curricula, @li_cuenta, @li_cve_mat, @li_semestre_ideal, @ls_materia,@lc_tipo, @li_con_prerreq, @li_orden
			
			FETCH NEXT FROM cur_materias_propuestas INTO @ls_curricula, @li_cuenta, @li_cve_mat, @li_semestre_ideal, @ls_materia,@lc_tipo, @li_con_prerreq
		END 

		CLOSE cur_materias_propuestas
		DEALLOCATE cur_materias_propuestas
		
	Commit Transaction
/*	
		select @li_orden = 1
		INSERT		INTO #t_curr_prop
		SELECT		TOP 4 'PROPUESTA' AS curricula,@ll_cuenta ,p.cve_mat,p.semestre_ideal,p.materia,p.tipo,p.con_prerreq,1
		FROM		#t_curr_pend p
		WHERE		p.tipo = 'N'
		ORDER BY	p.semestre_ideal,p.con_prerreq,p.cve_mat
*/
	END

/*	--OSS. Esto es lo original de jesus Moran ...	
	-- Lo comente por que las materias con prerrequisitos se obtienen de forma natural ordenando por
	-- el semestre ideal (hasta este punto no importa el tipo de enlace que tenga ...)
	INSERT INTO #t_curr_prop
	SELECT TOP 4 'PROPUESTA' AS curricula,@ll_cuenta ,p.cve_mat,p.semestre_ideal,p.materia,p.tipo,p.con_prerreq
	FROM #t_curr_pend p
	WHERE p.tipo = 'N'
		AND ( 
			p.con_prerreq = 0
			OR
			-- verifica prerrequisitos!! ojo no contempla el enlace 'O' :(
			p.con_prerreq = ( SELECT COUNT(*) 
							  FROM historico h,
							  	   sg_calificaciones b,
							  	   prerrequisitos pr
							  WHERE pr.cve_mat = p.cve_mat
							  	AND pr.cve_prerreq = h.cve_mat
							  	AND h.cuenta = @ll_cuenta
							  	AND pr.cve_carrera = @ll_carrera
							  	AND pr.cve_plan = @ll_plan
							  	AND h.calificacion = b.calificacion)
							  
			)
	ORDER BY p.semestre_ideal,p.con_prerreq,p.cve_mat
*/
	IF @con_RyO = 1 BEGIN

		-- reflexión universitaria su aun no termina de cursar todas
		IF (SELECT count(*) FROM sg_t_curr_ideal WHERE tipo = 'R') > (SELECT count(*) FROM #t_curr_actual WHERE tipo = 'R')
			INSERT INTO #t_curr_prop
			SELECT TOP 3 'PROPUESTA' AS curricula,@ll_cuenta ,r.cve_mat,0 AS semestre_ideal,m.materia, r.tipo,0,1
			FROM #t_reflexion r,
				 materias m
			WHERE NOT EXISTS (SELECT * FROM #t_curr_actual a WHERE a.cve_mat = r.cve_mat)
				AND r.cve_mat = m.cve_mat
		
		-- optativas si aun no cursa todas
		IF (SELECT count(*) FROM sg_t_curr_ideal WHERE tipo = 'O') > (SELECT count(*) FROM #t_curr_actual WHERE tipo = 'O')
			INSERT INTO #t_curr_prop
			SELECT TOP 3 'PROPUESTA' AS curricula,@ll_cuenta ,r.cve_mat,mp.semestre_ideal,m.materia, r.tipo,0,1
			FROM #t_optativas r,
				 materias m,
				 mat_prerrequisito mp
			WHERE NOT EXISTS (SELECT * FROM #t_curr_actual a WHERE a.cve_mat = r.cve_mat)
				AND r.cve_mat = m.cve_mat
				AND r.cve_mat = mp.cve_mat
				AND mp.cve_carrera = @ll_carrera
				AND mp.cve_plan = @ll_plan
	END			
	
	
	DELETE #t_curr_actual
	DELETE sg_t_curr_pend
	FETCH NEXT FROM cur_alumnos_car INTO @ll_cuenta
END 

CLOSE cur_alumnos_car
DEALLOCATE cur_alumnos_car

--SELECT * FROM #t_curr_prop

--SELECT @a_carrera AS carrera , @a_plan AS 'plan', (SELECT count(*) FROM #t_curr_prop) AS total

INSERT sg_mat_preinsc
	(cuenta, cve_mat, gpo, status, periodo, anio, orden)
SELECT cuenta, cve_mat,NULL,NULL,@ai_periodo,@ai_anio,orden
FROM #t_curr_prop 

commit 
--Print	'Listo, sin errores'
/*SELECT a.cve_mat,a.materia,a.semestre_ideal,count(a.cuenta) AS num_alumnos
FROM #t_curr_prop a
GROUP BY a.cve_mat,a.materia,a.semestre_ideal
HAVING count(a.cuenta) > 5 -- excluye las materias que tengas 5 o menos alumnos
ORDER BY a.semestre_ideal,a.cve_mat
*/

DROP TABLE #t_curr_actual
DROP TABLE #t_curr_prop
DROP TABLE #t_reflexion
DROP TABLE #t_optativas

RETURN
GO




GRANT EXECUTE ON dbo.sp_sg_materias_x_car TO g_se_administrador
GO
GRANT EXECUTE ON dbo.sp_sg_materias_x_car TO g_inf_admin
GO








