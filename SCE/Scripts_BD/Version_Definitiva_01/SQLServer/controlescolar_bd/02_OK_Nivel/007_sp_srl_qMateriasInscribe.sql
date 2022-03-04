USE controlescolar_bd 
go


ALTER PROCEDURE sp_srl_qMateriasInscribe
 @CUENTA int,
 @CLAVE_MAT int = 0,
 @MATERIA varchar(50) = '',
 @HORAINI int = 0
AS
DECLARE @PLAN int, @CARRERA int, @NIVEL varchar
DECLARE @puede int
DECLARE @tf1 int, @tf2 int, @t1 int, @t2 int, @t3 int, @t4 int
DECLARE @a_tf int, @a_t1 int, @a_t2 int, @a_t3 int, @a_t4 int
/*Fecha creación 2009-05-14
  Autor: Omar Ugalde
  Argumentos: El número de cuenta del alumno.
  			  filtro para clave de materia.
  			  filtro para nombre de materia.
  			  filtro para hora inicial de materia.
  			  
  Descripción:	Regresar las materias obligatorias (o la materia específica si el argumento
  				@clave_mat es distindo de cero) del plan que el alumno puede inscribir
  			mas dos registros más para las materias de integración y las opcionales, estos
  			dos registros sólo servirán cómo "link" para consultar todos los grupos de
  			del las materias respectivas.
  			
			Nótese el uso de WITH(NOLOCK) en la tabla de grupos, ya que esta podrá tener una
  			concurrencia alta, debido a la modificación de la columna inscritos.
 */

SET @CLAVE_MAT = ISNULL(@CLAVE_MAT,0)
SET @HORAINI   = ISNULL(@HORAINI,0)
SET @MATERIA = ISNULL(@MATERIA,'')
SET @MATERIA = REPLACE ( @MATERIA, '%','')
IF	LEN(@MATERIA) > 0	SET @MATERIA = '%'+@MATERIA+'%'
IF  LEN(@MATERIA) = 0	SET @MATERIA = '%'


SELECT	@PLAN = ac.cve_plan, @CARRERA = ac.cve_carrera, @NIVEL = ac.nivel,
		@a_tf = ISNULL(pl.cve_area_integ_fundamental,0),
		@a_t1 = ISNULL(pl.cve_area_integ_tema1,0),
		@a_t2 = ISNULL(pl.cve_area_integ_tema2,0),
		@a_t3 = ISNULL(pl.cve_area_integ_tema3,0),
		@a_t4 = ISNULL(pl.cve_area_integ_tema4,0)
FROM	controlescolar_bd.dbo.academicos as ac
		inner join controlescolar_bd.dbo.plan_estudios pl on
		ac.cve_plan		= pl.cve_plan
	and ac.cve_carrera	= pl.cve_carrera
WHERE	cuenta = @CUENTA

SELECT	@puede	= ISNULL(puede_integracion,0),
		@tf1	= ISNULL(tema_fundamental_1,0),
		@tf2	= ISNULL(tema_fundamental_2,0),
		@t1		= ISNULL(tema_1,0),
		@t2		= ISNULL(tema_2,0),
		@t3		= ISNULL(tema_3,0),
		@t4		= ISNULL(tema_4,0)
FROM	controlescolar_bd.dbo.banderas
WHERE	cuenta	= @CUENTA

SELECT MAX(cupo) as cupo,cve_mat,materia,horas_reales,creditos,semestre_ideal,es_opt,es_reflex,0 as area_integ
FROM(
 SELECT	case when ISNULL(SUM(s1_grp.cupo - s1_grp.inscritos),0) <= 0 then 0 else 1 end as cupo,
		mat.cve_mat as cve_mat,
		mat.materia as materia,
		mat.horas_reales as horas_reales,
		mat.creditos as creditos,
		mpi.semestre_ideal as semestre_ideal,
		0 as es_opt,
		0 as es_reflex
 FROM web_bd.dbo.mat_pase_ingreso mpi
		
		inner join controlescolar_bd.dbo.materias mat on
		mat.cve_mat = mpi.cve_mat
		
		inner join	controlescolar_bd.dbo.plan_estudios ple on
		mpi.cve_carrera =	ple.cve_carrera
	and mpi.cve_plan	=	ple.cve_plan
		
		inner join  controlescolar_bd.dbo.area_mat amt on
		mpi.cve_mat		=	amt.cve_mat
	and	amt.cve_area not in (	ISNULL(ple.cve_area_integ_fundamental,0),
								ISNULL(ple.cve_area_integ_tema1,0),
								ISNULL(ple.cve_area_integ_tema2,0),
								ISNULL(ple.cve_area_integ_tema3,0),
								ISNULL(ple.cve_area_integ_tema4,0)
							 )
	and ( amt.cve_area in (		ISNULL(ple.cve_area_basica,0),
								ISNULL(ple.cve_area_mayor_oblig,0),
								ISNULL(ple.cve_area_opcion_terminal,0), --Posgrado
								ISNULL(ple.cve_area_servicio_social,0)
						   )
		or
		 amt.cve_area in	(select cve_area 
								 from controlescolar_bd.dbo.subsistema
								 where cve_plan = mpi.cve_plan and cve_carrera = mpi.cve_carrera and clase_area = 'OBL')
		)
		
		inner join controlescolar_bd.dbo.grupos as s1_grp WITH(NOLOCK) on
		mat.cve_mat	= s1_grp.cve_mat
		
		left join controlescolar_bd.dbo.horario as s1_hr on
		s1_grp.anio	= s1_hr.anio
	and	s1_grp.periodo	= s1_hr.periodo
	and	((s1_grp.cve_mat = s1_hr.cve_mat and s1_grp.gpo = s1_hr.gpo) 
			or 
		(s1_grp.cve_asimilada = s1_hr.cve_mat and s1_grp.gpo_asimilado = s1_hr.gpo))
 WHERE		mpi.cve_carrera	= @CARRERA
 and		mpi.cve_plan	= @PLAN
 and		mpi.cuenta		= @CUENTA
 and		mpi.semestre_ideal <> 0
 and		mat.materia like @MATERIA
 and		@CLAVE_MAT = 0
 and		(s1_hr.hora_inicio = @HORAINI OR @HORAINI = 0)
 GROUP BY mat.cve_mat,mat.materia,mat.horas_reales,mat.creditos,semestre_ideal,s1_grp.gpo
 ) as materias_obligatorias(cupo,cve_mat,materia,horas_reales,creditos,semestre_ideal,es_opt,es_reflex)
 GROUP BY cve_mat,materia,horas_reales,creditos,semestre_ideal,es_opt,es_reflex
 UNION
/*Si se especifica cómo parámetro la clave de la materia, mostrarla aunque no sea del plan*/
SELECT ISNULL(MAX(cupo),0),cve_mat,materia,horas_reales,creditos,semestre_ideal,es_opt,es_reflex,0 as area_integ
FROM(
 SELECT	case when ISNULL(SUM(s1_grp.cupo - s1_grp.inscritos),0) <= 0 then 0 else 1 end as cupo,
		mat.cve_mat as cve_mat,
		mat.materia as materia,
		mat.horas_reales as horas_reales,
		mat.creditos as creditos,
		CASE @NIVEL WHEN 'P' THEN
						ISNULL((select mp.semestre_ideal
		 				from controlescolar_bd.dbo.mat_prerreq_pos mp
		 				where @NIVEL = 'P' and mp.cve_plan = @PLAN and mp.cve_carrera = @CARRERA and mp.cve_mat = mat.cve_mat
		 				),0)		
					ELSE  
						ISNULL((select ml.semestre_ideal 
		 				from controlescolar_bd.dbo.mat_prerrequisito ml
		 				where @NIVEL <> 'P' and ml.cve_plan = @PLAN and ml.cve_carrera = @CARRERA and ml.cve_mat = mat.cve_mat
		 				),0)					
				 END as  semestre_ideal,
		0 as es_opt,
		0 as es_reflex
 FROM 	controlescolar_bd.dbo.materias mat 
		
		left join controlescolar_bd.dbo.grupos as s1_grp WITH(NOLOCK)on
		mat.cve_mat	= s1_grp.cve_mat
		
		left join controlescolar_bd.dbo.horario as s1_hr on
		s1_grp.anio	= s1_hr.anio
	and	s1_grp.periodo	= s1_hr.periodo
	and	((s1_grp.cve_mat = s1_hr.cve_mat and s1_grp.gpo = s1_hr.gpo) 
			or 
		(s1_grp.cve_asimilada = s1_hr.cve_mat and s1_grp.gpo_asimilado = s1_hr.gpo))
		
 WHERE	mat.cve_mat = @CLAVE_MAT
 and		(s1_hr.hora_inicio = @HORAINI OR @HORAINI = 0)
 GROUP BY mat.cve_mat,mat.materia,mat.horas_reales,mat.creditos,s1_grp.gpo
) as materia_por_clave (cupo,cve_mat,materia,horas_reales,creditos,semestre_ideal,es_opt,es_reflex)
GROUP BY cve_mat,materia,horas_reales,creditos,semestre_ideal,es_opt,es_reflex
UNION
SELECT  1,		-- cupo (mayor a cero - tiene cupo, igual a cero no hay cupo
		0,		-- clave_materia
		'MATERIAS OPTATIVAS',		-- nombre_materia
		0,		-- horas
		0,		-- creditos
		1000,		-- semestre ideal
		1 as es_opt,
		0 as es_reflex,
		0 as area_integ
WHERE	@CLAVE_MAT = 0
UNION
SELECT  1,
		0,
		'INTEGRACIÓN TEMA FUNDAMENTAL',
		0,
		0,
		2000,
		0 as es_opt, 
		1 as es_reflex,
		@a_tf as area_integ
WHERE @NIVEL <> 'P' AND @CLAVE_MAT = 0 AND @puede = 1 AND @PLAN <>6 AND (@tf1 + @tf2) < 2
UNION
SELECT  1,
		0,
		CASE @PLAN WHEN 6 THEN 'REFLEXIÓN UNIVERSITARIA TEMA 1' ELSE 'INTEGRACIÓN TEMA 1' END,
		0,
		0,
		2001,
		0 as es_opt, 
		1 as es_reflex,
		@a_t1 as area_integ
WHERE @NIVEL <> 'P' AND @CLAVE_MAT = 0 AND @puede = 1 AND @t1 = 0
UNION
SELECT  1,
		0,
		CASE @PLAN WHEN 6 THEN 'REFLEXIÓN UNIVERSITARIA TEMA 2' ELSE 'INTEGRACIÓN TEMA 2' END,
		0,
		0,
		2002,
		0 as es_opt, 
		1 as es_reflex,
		@a_t2 as area_integ
WHERE @NIVEL <> 'P' AND @CLAVE_MAT = 0 AND @puede = 1 AND @t2 = 0
UNION
SELECT  1,
		0,
		CASE @PLAN WHEN 6 THEN 'REFLEXIÓN UNIVERSITARIA TEMA 3' ELSE 'INTEGRACIÓN TEMA 3' END,
		0,
		0,
		2003,
		0 as es_opt, 
		1 as es_reflex,
		@a_t3 as area_integ
WHERE @NIVEL <> 'P' AND @CLAVE_MAT = 0 AND @puede = 1 AND @t3 = 0
UNION
SELECT  1,
		0,
		CASE @PLAN WHEN 6 THEN 'REFLEXIÓN UNIVERSITARIA TEMA 4' ELSE 'INTEGRACIÓN TEMA 4' END,
		0,
		0,
		2004,
		0 as es_opt, 
		1 as es_reflex,
		@a_t4 as area_integ
WHERE @NIVEL <> 'P' AND @CLAVE_MAT = 0 AND @puede = 1 AND @t4 = 0
ORDER BY semestre_ideal,materia
GO

