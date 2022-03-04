USE controlescolar_bd 
go


ALTER PROCEDURE [dbo].[sp_srl_qMateriasGrupos_LPI]
 @CUENTA int,
 @CLAVE_MAT int,
 @REFLEX int = 0,
 @OPTATIVA int = 0,
 @MATERIA varchar(50) = '',
 @HORA int = 0,
 @GRUPO varchar(2) = '',
 @AREA_INTEG int = 0
AS
/*Fecha creación 2012-11-29
  Autor: Antonio Pica
  Argumentos: El número de cuenta del alumno.
  			  La clave de la materia (en caso de una materia obligatoria)
  			  	-- Se solicitó que fuese cualquier materia, por lo tanto se quita mat_prerrequisito del join
  			  Bandera para materias de reflexión
  			  Bandera para materias optarivas
  			  Filtro para nombre de materia
  			  Filtro por horario
  			  
  Descripción:	Regresar los grupos de la(s) materia(s)
  			
  			
  			Nótese el uso de WITH(NOLOCK) en la tabla de grupos, ya que esta podrá tener una
  			concurrencia alta, debido a la modificación de la columna inscritos.

 */
DECLARE @PLAN int, @CARRERA int, @NIVEL varchar, @COORD int
SET @CUENTA		= ISNULL(@CUENTA,0)
SET @CLAVE_MAT	= ISNULL(@CLAVE_MAT,0)
SET @REFLEX		= ISNULL(@REFLEX,0)
SET @OPTATIVA	= ISNULL(@OPTATIVA,0)

SET @MATERIA = REPLACE ( @MATERIA, '%','')
IF	LEN(@MATERIA) > 0	SET @MATERIA = '%'+@MATERIA+'%'
IF  LEN(@MATERIA) = 0	SET @MATERIA = '%'

SELECT @PLAN = ac.cve_plan, @CARRERA = ac.cve_carrera, @NIVEL = ac.nivel, @COORD = ca.cve_coordinacion
FROM	controlescolar_bd.dbo.academicos as ac 
			inner join controlescolar_bd.dbo.carreras as ca on
			ac.cve_carrera = ca.cve_carrera
WHERE	cuenta = @CUENTA
/*GRUPOS DE UNA MATERIA ESPECÍFICA (@CLAVE_MAT > 0) (OBLIGATORIA)*/
SELECT	DISTINCT
		mat.cve_mat as clave_materia,
		mat.materia as materia,
		
		CASE WHEN EXISTS	(select	1
	 						 from	controlescolar_bd.dbo.reinscripcion_materias rm
	 						 where	rm.cve_mat = mat.cve_mat
							 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA OR rm.cve_gpo = grp.gpo)
								)
		THEN				(select	count(*)
	 			 			 from	controlescolar_bd.dbo.reinscripcion_materias rm
	 			  			 where	rm.cve_mat = mat.cve_mat
	 						 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA and rm.cve_gpo = grp.gpo)
							)
		ELSE 1 END as no_bloqueado,
		
		cast(convert(float,grp.inscritos)/
		(CASE WHEN grp.cupo = 0 THEN 1 ELSE grp.cupo END) * 100 as decimal(10,2)) as capacidad,
		grp.gpo as grupo,
		
		ISNULL(hr.cve_dia,0) as cve_dia,
		
		CASE ISNULL(hr.cve_dia,0) WHEN 1 THEN 'Lunes' WHEN 2 THEN 'Martes' WHEN 3 THEN 'Miércoles'
						WHEN 4 THEN 'Jueves' WHEN 5 THEN 'Viernes' WHEN 6 THEN 'Sábado'
						WHEN 7 THEN 'Domingo' ELSE 'Sin Día' END as dia,
		
		case len(cast(ISNULL(hora_inicio,0) as varchar)) 
		 when 1 then '0'+cast(ISNULL(hora_inicio,0) as varchar) 
		 else cast(ISNULL(hora_inicio,0) as varchar) end
		+' - '+ 
		case len(cast(ISNULL(hora_final,0) as varchar))
		 when 1 then '0' +cast(ISNULL(hora_final,0) as varchar) 
		 else cast(ISNULL(hora_final,0) as varchar) end  as horario,
		
		ISNULL(prof.nombre+' ','')+ISNULL(prof.apaterno,'') as profesor,
		grp.cupo as cupo,
		grp.inscritos as inscritos,
		isnull(grp.primer_sem,0) as primer_sem
FROM	controlescolar_bd.dbo.materias mat 
		
		inner join controlescolar_bd.dbo.grupos as grp WITH (NOLOCK) on
		mat.cve_mat = grp.cve_mat
		
		--grupos sin horario (asesorías, en línea,...)
		left join controlescolar_bd.dbo.horario as hr on
		grp.anio	= hr.anio
	and	grp.periodo	= hr.periodo
	and	((grp.cve_mat = hr.cve_mat and grp.gpo = hr.gpo) 
			or 
			(grp.cve_asimilada = hr.cve_mat and grp.gpo_asimilado = hr.gpo))
			
		left outer join controlescolar_bd.dbo.profesor as prof on
		grp.cve_profesor = prof.cve_profesor

WHERE 	@OPTATIVA + @REFLEX = 0
and		mat.cve_mat		=@CLAVE_MAT
and		(@HORA = 0 OR hr.hora_inicio = @HORA )
and		(grp.gpo = ISNULL(@GRUPO,'') OR ISNULL(@GRUPO,'') = '')
and		isnull(grp.primer_sem,0) >0
UNION
/*MATERIAS OPTATIVAS*/
SELECT	DISTINCT 
		mat.cve_mat as clave_materia,
		mat.materia as materia,
		
		CASE WHEN EXISTS	(select	1
	 						 from	controlescolar_bd.dbo.reinscripcion_materias rm
	 						 where	rm.cve_mat = mat.cve_mat
							 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA OR rm.cve_gpo = grp.gpo)
								)
		THEN				(select	count(*)
	 			 			 from	controlescolar_bd.dbo.reinscripcion_materias rm
	 			  			 where	rm.cve_mat = mat.cve_mat
	 						 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA and rm.cve_gpo = grp.gpo)
							)
		ELSE 1 END as no_bloqueado,
		
		cast(convert(float,grp.inscritos)/
		(CASE WHEN grp.cupo = 0 THEN 1 ELSE grp.cupo END) * 100 as decimal(10,2)) as capacidad,
		grp.gpo as grupo,
		
		ISNULL(hr.cve_dia,0) as cve_dia,
		
		CASE ISNULL(hr.cve_dia,0) WHEN 1 THEN 'Lunes' WHEN 2 THEN 'Martes' WHEN 3 THEN 'Miércoles'
						WHEN 4 THEN 'Jueves' WHEN 5 THEN 'Viernes' WHEN 6 THEN 'Sábado'
						WHEN 7 THEN 'Domingo' ELSE 'Sin Día' END as dia,
		
		case len(cast(ISNULL(hora_inicio,0) as varchar)) 
		 when 1 then '0'+cast(ISNULL(hora_inicio,0) as varchar) 
		 else cast(ISNULL(hora_inicio,0) as varchar) end
		+' - '+ 
		case len(cast(ISNULL(hora_final,0) as varchar))
		 when 1 then '0' +cast(ISNULL(hora_final,0) as varchar) 
		 else cast(ISNULL(hora_final,0) as varchar) end  as horario,
		
		ISNULL(prof.nombre+' ','')+ISNULL(prof.apaterno,'') as profesor,
		grp.cupo as cupo,
		grp.inscritos as inscritos,
		isnull(grp.primer_sem,0) as primer_sem
FROM	(select ml.cve_mat, ml.cve_plan, ml.cve_carrera from controlescolar_bd.dbo.mat_prerrequisito ml
														where @NIVEL <> 'P'
		 UNION
		 select mp.cve_mat, mp.cve_plan, mp.cve_carrera from controlescolar_bd.dbo.mat_prerreq_pos mp
		 												where @NIVEL = 'P'
		)as mpr(cve_mat,cve_plan,cve_carrera)

		inner join  controlescolar_bd.dbo.materias mat on
		mpr.cve_mat = mat.cve_mat
		
		inner join controlescolar_bd.dbo.area_mat amt on
		mpr.cve_mat = amt.cve_mat
								
		inner join controlescolar_bd.dbo.grupos as grp WITH (NOLOCK) on
		mpr.cve_mat = grp.cve_mat
		
		left join controlescolar_bd.dbo.subsistema sst on
		mpr.cve_carrera	=	sst.cve_carrera
	and	mpr.cve_plan	=	sst.cve_plan
	and sst.clase_area	=	'OPT'
	and	amt.cve_area	=	sst.cve_area
	
		left join controlescolar_bd.dbo.plan_estudios pln on
		pln.cve_carrera	= mpr.cve_carrera
	and	pln.cve_plan	= mpr.cve_plan
	and	amt.cve_area	= pln.cve_area_mayor_opt
	
		left join controlescolar_bd.dbo.horario as hr on
		
								grp.anio	= hr.anio
							and	grp.periodo	= hr.periodo
							and	((grp.cve_mat = hr.cve_mat and grp.gpo = hr.gpo) 
									or 
			 					(grp.cve_asimilada = hr.cve_mat and grp.gpo_asimilado = hr.gpo))

		left join controlescolar_bd.dbo.historico_re hre on
		hre.cve_mat = mpr.cve_mat
	and hre.cuenta = @CUENTA
	and hre.calificacion IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
	and @NIVEL <> 'P'
	
		left join controlescolar_bd.dbo.historico_pos_re hrp on
		hrp.cve_mat = mpr.cve_mat
	and hrp.cuenta = @CUENTA
	and hrp.calificacion IN ('AC','6','7','8','9','10', 'MB','B','S','E','RE')
	and @NIVEL = 'P'
	
		left outer join controlescolar_bd.dbo.profesor as prof on
		grp.cve_profesor = prof.cve_profesor

WHERE	@CLAVE_MAT 		=	0
and		@OPTATIVA		=	1
and		mpr.cve_carrera	=	@CARRERA
and		mpr.cve_plan	=	@PLAN
and		hre.cve_mat IS NULL AND hrp.cve_mat IS NULL
and		mat.materia LIKE @MATERIA
and		isnull(grp.primer_sem,0) >0
and		(@HORA = 0 OR hr.hora_inicio = @HORA)
and		((@NIVEL <> 'P' AND sst.cve_carrera IS NOT NULL) OR 
		(@NIVEL = 'P' AND pln.cve_area_mayor_opt IS NOT NULL AND mat.cve_coordinacion = @COORD))
UNION
/*MATERIAS DE REFLEXION*/
SELECT	DISTINCT
		mpr.cve_mat as clave_materia,
		mat.materia as materia,
		
		CASE WHEN EXISTS	(select	1
	 						 from	controlescolar_bd.dbo.reinscripcion_materias rm
	 						 where	rm.cve_mat = mat.cve_mat
							 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA OR rm.cve_gpo = grp.gpo)
								)
		THEN				(select	count(*)
	 			 			 from	controlescolar_bd.dbo.reinscripcion_materias rm
	 			  			 where	rm.cve_mat = mat.cve_mat
	 						 and	(rm.cve_plan = @PLAN and rm.cve_carrera = @CARRERA and rm.cve_gpo = grp.gpo)
							)
		ELSE 1 END as no_bloqueado,
		
		cast(convert(float,grp.inscritos)/
		(CASE WHEN grp.cupo = 0 THEN 1 ELSE grp.cupo END) * 100 as decimal(10,2)) as capacidad,
		grp.gpo as grupo,
		
		hr.cve_dia as cve_dia,
		
		CASE ISNULL(hr.cve_dia,0) WHEN 1 THEN 'Lunes' WHEN 2 THEN 'Martes' WHEN 3 THEN 'Miércoles'
						WHEN 4 THEN 'Jueves' WHEN 5 THEN 'Viernes' WHEN 6 THEN 'Sábado'
						WHEN 7 THEN 'Domingo' ELSE 'Sin Día' END as dia,
		
		case len(cast(ISNULL(hora_inicio,0) as varchar)) 
		 when 1 then '0'+cast(ISNULL(hora_inicio,0) as varchar) 
		 else cast(ISNULL(hora_inicio,0) as varchar) end
		+' - '+ 
		case len(cast(ISNULL(hora_final,0) as varchar))
		 when 1 then '0' +cast(ISNULL(hora_final,0) as varchar) 
		 else cast(ISNULL(hora_final,0) as varchar) end  as horario,
		
		ISNULL(prof.nombre+' ','')+ISNULL(prof.apaterno,'') as profesor,
		grp.cupo as cupo,
		grp.inscritos as inscritos,
		isnull(grp.primer_sem,0) as primer_sem
FROM	controlescolar_bd.dbo.mat_prerrequisito mpr

		inner join  controlescolar_bd.dbo.materias mat on
		mpr.cve_mat = mat.cve_mat
	and @NIVEL <> 'P'
		
		inner join	controlescolar_bd.dbo.plan_estudios ple on
		mpr.cve_carrera =	ple.cve_carrera
	and mpr.cve_plan	=	ple.cve_plan
		inner join  controlescolar_bd.dbo.area_mat amt on
		mpr.cve_mat		=	amt.cve_mat
	/*and	amt.cve_area in (	ple.cve_area_integ_fundamental,
							ple.cve_area_integ_tema1,
							ple.cve_area_integ_tema2,
							ple.cve_area_integ_tema3,
							ple.cve_area_integ_tema4)*/
	and amt.cve_area = @AREA_INTEG					
		
		inner join controlescolar_bd.dbo.grupos as grp WITH (NOLOCK) on
		mpr.cve_mat = grp.cve_mat
		
		inner join controlescolar_bd.dbo.horario as hr on
		grp.anio	= hr.anio
	and	grp.periodo	= hr.periodo
	and	((grp.cve_mat = hr.cve_mat and grp.gpo = hr.gpo) 
			or 
			(grp.cve_asimilada = hr.cve_mat and grp.gpo_asimilado = hr.gpo))
			
		left outer join controlescolar_bd.dbo.profesor as prof on
		grp.cve_profesor = prof.cve_profesor
WHERE	@REFLEX = 1
and 	@CLAVE_MAT = 0
and		mpr.cve_carrera	= @CARRERA
and		mpr.cve_plan	= @PLAN
and		mat.materia LIKE @MATERIA
and		isnull(grp.primer_sem,0) >0
and		(hr.hora_inicio = @HORA OR @HORA = 0)
ORDER BY materia,grupo,cve_dia

GO

