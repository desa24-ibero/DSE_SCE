ALTER PROCEDURE [dbo].[sp_enlinea_LPI_srl_qLlevaTeoriaLab]
 @CUENTA int,
 @CLAVE_MAT int,
 @GRUPO varchar(2),
 @FROMPROC int = 0,
 @CLAVE2 int = 0 output,
 @GRUPO2 varchar(2) = 0 output,
 @ES_LABO int = 0 output
AS
DECLARE @PLAN int, @CARRERA int, @NIVEL varchar, @ES_LAB integer
/*Fecha creación 2009-05-22
  Autor: Omar Ugalde
  Argumentos: El número de cuenta del alumno.
  			  La clave de la materia/laboratorio a revisar
  			  El grupo de la materia/laboratorio

  Descripción:	Revisa si la materia/lab debe ser inscrito con su contraparte
				@ES_LAB determina si se está pasando la teoría (0) o el laboratorio (1)
				
  Regresa una consulta con la clave de la contraparte y el grupo a inscribir (*|[A-Z][A-Z]?)
  cero filas si la materia no tiene contraparte o si ya se aprobó la contraparte.
  Fecha mofificación 2014-04-02
*/

--OBTIENE LA CARRERA, PLAN Y NIVEL DEL ALUMNO

SELECT	@PLAN = cve_plan, @CARRERA = cve_carrera, @NIVEL = nivel
FROM	controlescolar_bd.dbo.academicos
WHERE	cuenta = @CUENTA

--DETERMINA EN LA TABLA teoria_lab SI LA MATERIA RECIBIDA COMO PARÁMETRO ES LABORATORIO (@ES_LAB=1) O ES TEORIA (@ES_LAB=0)
SELECT	TOP 1 @ES_LAB = CASE WHEN @CLAVE_MAT = tl.cve_lab THEN 1 ELSE 0 END
FROM	controlescolar_bd.dbo.teoria_lab as tl
WHERE	(tl.cve_teoria = @CLAVE_MAT OR tl.cve_lab = @CLAVE_MAT)
AND		tl.cve_plan = @PLAN and tl.cve_carrera = @CARRERA

--EN CASO DE QUE NO HAYA SIDO INVOCADO DE UN STORED PROCEDURE OBTIENE DONDE DEBERÁ INSCRIBIRSE, SIEMPRE Y CUANDO NO LA TENGA PREVIAMENTE APROBADA EN historico_re O historico_pos_re:
--	SI LA MATERIA-GRUPO ES DE TEORIA (@ES_LAB=0), LA  LA CLAVE Y GRUPO DEL LABORATORIO CORRESPONDIENTE O CLAVE CERO(0) Y GRUPO NULO SI NO APLICA
--	SI LA MATERIA-GRUPO ES DE LABORATORIO (@ES_LAB=1), LA  LA CLAVE Y GRUPO DE LA TEORIA CORRESPONDIENTE O CLAVE CERO(0) Y GRUPO NULO SI NO APLICA
IF @FROMPROC <> 0
BEGIN
SELECT	@CLAVE2 = CASE @ES_LAB WHEN 1 THEN tl.cve_teoria WHEN 0 THEN tl.cve_lab ELSE 0 END,
		@GRUPO2 = CASE @ES_LAB WHEN 1 THEN tl.gpo_teoria WHEN 0 THEN tl.gpo_lab ELSE '' END,
		@ES_LABO = @ES_LAB
FROM	controlescolar_bd.dbo.teoria_lab as tl
		left join controlescolar_bd.dbo.historico_re he on
								he.cuenta = @CUENTA
							and ((he.cve_mat =  tl.cve_teoria ) OR
								 (he.cve_mat = tl.cve_lab ))
							and he.calificacion IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
							and @NIVEL <> 'P'
							
		left join controlescolar_bd.dbo.historico_pos_re hep on
								hep.cuenta = @CUENTA
							and ((hep.cve_mat =  tl.cve_teoria ) OR
								 (hep.cve_mat = tl.cve_lab ))
							and hep.calificacion IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
							and @NIVEL = 'P'
WHERE	(tl.cve_teoria = @CLAVE_MAT OR tl.cve_lab = @CLAVE_MAT)
AND		he.cve_mat IS NULL AND hep.cve_mat IS NULL
AND		tl.cve_plan = @PLAN
AND		tl.cve_carrera = @CARRERA
AND		(( (tl.gpo_teoria = @GRUPO 
		   OR ( '*' = ISNULL(tl.gpo_teoria,'*')
		       AND NOT EXISTS(select 1 
		       				  from controlescolar_bd.dbo.teoria_lab tll
							  where tll.cve_plan	= tl.cve_plan 
							  and tll.cve_carrera	= tl.cve_carrera
							  and tll.cve_teoria	= tl.cve_teoria
							  and tll.gpo_teoria	= @GRUPO)
			  )
		 )
		 AND 0 = @ES_LAB
		)
OR		( (tl.gpo_lab = @GRUPO 
		   OR ( '*' = ISNULL(tl.gpo_lab,'*')
		       AND NOT EXISTS(select 1 
		       				  from controlescolar_bd.dbo.teoria_lab tll
							  where tll.cve_plan	= tl.cve_plan 
							  and tll.cve_carrera	= tl.cve_carrera
							  and tll.cve_teoria	= tl.cve_teoria
							  and tll.gpo_lab		= @GRUPO)
			  )
		 )
		 AND 1 = @ES_LAB
		)
		)
 --SI ES INVOCADO DESDE UN STORED PROCEDURE, AL DEVOLVER UN NÚMERO DE RENGLONES ES SUFICIENTE PARA SABER SI HAY UNA LIGA DE TEORIA - LABORATORIO
 RETURN @@ROWCOUNT
END


SELECT	CASE @ES_LAB WHEN 1 THEN tl.cve_teoria WHEN 0 THEN tl.cve_lab ELSE 0 END as clave_ligado,
		CASE @ES_LAB WHEN 1 THEN tl.gpo_teoria WHEN 0 THEN tl.gpo_lab ELSE '' END as grupo_ligado,
		@ES_LAB as es_laboratorio
FROM	controlescolar_bd.dbo.teoria_lab as tl
		left join controlescolar_bd.dbo.historico_re he on
								he.cuenta = @CUENTA
							and ((he.cve_mat =  tl.cve_teoria ) OR
								 (he.cve_mat = tl.cve_lab ))
							and he.calificacion IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
							and @NIVEL <> 'P'
							
		left join controlescolar_bd.dbo.historico_pos_re hep on
								hep.cuenta = @CUENTA
							and ((hep.cve_mat =  tl.cve_teoria ) OR
								 (hep.cve_mat = tl.cve_lab ))
							and hep.calificacion IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
							and @NIVEL = 'P'
WHERE	(tl.cve_teoria = @CLAVE_MAT OR tl.cve_lab = @CLAVE_MAT)
AND		he.cve_mat IS NULL AND hep.cve_mat IS NULL
AND		tl.cve_plan = @PLAN
AND		tl.cve_carrera = @CARRERA
AND		(( (tl.gpo_teoria = @GRUPO 
		   OR ( '*' = ISNULL(tl.gpo_teoria,'*')
		       AND NOT EXISTS(select 1 
		       				  from controlescolar_bd.dbo.teoria_lab tll
							  where tll.cve_plan	= tl.cve_plan 
							  and tll.cve_carrera	= tl.cve_carrera
							  and tll.cve_teoria	= tl.cve_teoria
							  and tll.gpo_teoria	= @GRUPO)
			  )
		 )
		 AND 0 = @ES_LAB
		)
OR		( (tl.gpo_lab = @GRUPO 
		   OR ( '*' = ISNULL(tl.gpo_lab,'*')
		       AND NOT EXISTS(select 1 
		       				  from controlescolar_bd.dbo.teoria_lab tll
							  where tll.cve_plan	= tl.cve_plan 
							  and tll.cve_carrera	= tl.cve_carrera
							  and tll.cve_teoria	= tl.cve_teoria
							  and tll.gpo_lab		= @GRUPO)
			  )
		 )
		 AND 1 = @ES_LAB
		)
		)
 RETURN @@ROWCOUNT		

GO

