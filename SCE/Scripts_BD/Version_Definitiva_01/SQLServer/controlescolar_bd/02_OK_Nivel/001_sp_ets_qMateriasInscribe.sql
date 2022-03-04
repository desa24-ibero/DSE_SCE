USE controlescolar_bd 
go


ALTER PROCEDURE sp_ets_qMateriasInscribe
 @CUENTA int,
 @CLAVE_MAT int = 0,
 @SIGLA varchar(50) = ''
AS

DECLARE @PLAN int, @CARRERA int, @NIVEL char(1)
/*Fecha creación 2010-08-12
  Autor: Antonio Pica
  Argumentos: El número de cuenta del alumno.
  			  filtro para clave de materia.
  			  filtro para sigla de materia.
  			    			  
  Descripción:	Regresar las materias que el alumno puede inscribir,
*/

SET @CLAVE_MAT = ISNULL(@CLAVE_MAT,0)
SET @SIGLA = ISNULL(@SIGLA,'')
SET @SIGLA = REPLACE ( @SIGLA, '%','')
IF	LEN(@SIGLA) > 0	SET @SIGLA = '%'+@SIGLA+'%'
IF  LEN(@SIGLA) = 0	SET @SIGLA = '%'

IF @CLAVE_MAT=0 AND @SIGLA = '%' SET @SIGLA = '*'

SELECT @PLAN = cve_plan, @CARRERA = cve_carrera, @NIVEL = nivel
FROM	controlescolar_bd.dbo.academicos
WHERE	cuenta = @CUENTA

/*IF @NIVEL = 'L'*/
IF @NIVEL <> 'P'
BEGIN
	SELECT	1 as cupo,
		mat.cve_mat,
		mat.sigla,
		mat.materia as materia,
		mat.horas_reales,
		mat.creditos,
		1000 as semestre_ideal,
		0 as es_opt, 
		0 as es_reflex,
		cursativa = isnull((SELECT cursativa from controlescolar_bd.dbo.mat_prerrequisito  mp
							WHERE mat.cve_mat = mp.cve_mat 
							AND   mp.cve_carrera = @CARRERA
							AND   mp.cve_plan = @PLAN ),100),

		c.cve_coordinacion,
		c.coordinacion
	FROM  controlescolar_bd.dbo.materias mat , 
	controlescolar_bd.dbo.coordinaciones c
	WHERE	mat.sigla like @SIGLA
	and		(mat.cve_mat = @CLAVE_MAT OR @CLAVE_MAT = 0)
	AND		mat.cve_coordinacion = c.cve_coordinacion
	ORDER BY cupo desc, es_opt, materia
END
ELSE
BEGIN
	IF @NIVEL = 'P'
	BEGIN
		SELECT	1 as cupo,
			mat.cve_mat,
			mat.sigla,
			mat.materia as materia,
			mat.horas_reales,
			mat.creditos,
			1000 as semestre_ideal,
			0 as es_opt, 
			0 as es_reflex,
			cursativa = isnull((SELECT cursativa from controlescolar_bd.dbo.mat_prerreq_pos  mp
							WHERE mat.cve_mat = mp.cve_mat 
							AND   mp.cve_carrera = @CARRERA
							AND   mp.cve_plan = @PLAN ),100),
						
			c.cve_coordinacion,
			c.coordinacion
		FROM  controlescolar_bd.dbo.materias mat ,
		controlescolar_bd.dbo.coordinaciones c
		WHERE	mat.sigla like @SIGLA
		and		(mat.cve_mat = @CLAVE_MAT OR @CLAVE_MAT = 0)
		AND		mat.cve_coordinacion = c.cve_coordinacion		
		ORDER BY cupo desc, es_opt, materia
	END
END

GO

