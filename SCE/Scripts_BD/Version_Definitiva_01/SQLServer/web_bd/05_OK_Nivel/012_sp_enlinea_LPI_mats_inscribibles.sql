USE [web_bd]
GO

ALTER PROCEDURE sp_enlinea_LPI_mats_inscribibles
 @CUENTA int,
 @CLAVE_MAT int = 0,
 @MATERIA varchar(50) = '',
 @HORAINI int = 0,
 @a_hash varchar(50),
 @a_ip varchar(50),
 @CONMENSAJES int = 0
 
as

declare 
@ls_mensaje_error varchar(255),
@ll_num_error integer,
@num_error integer,
@mensaje_error varchar(255),
@ll_MATS_rowcount integer,
@li_codigo_proc integer,
@ls_mensaje_proc varchar(255),
@a_cuenta integer

SELECT @a_cuenta = @CUENTA


exec [sp_enlinea_LPI_valida_exec] 
@a_stored_procedure = 'sp_enlinea_LPI_mats_inscribibles',
@a_cuenta = @a_cuenta,
@a_hash = @a_hash ,
@a_ip = @a_ip ,
@CONMENSAJES = @CONMENSAJES,
@a_CODIGO = @li_codigo_proc  OUTPUT,
@a_MENSAJE  = @ls_mensaje_proc OUTPUT

IF @li_codigo_proc = -1 
BEGIN
	SET @ll_num_error = -1
	SET @ls_mensaje_error= @ls_mensaje_proc
	IF @CONMENSAJES <> 0 print @ls_mensaje_error
	Goto EtiquetaError	
END

--SI TODO FUE CORRECTO
SELECT @ll_num_error = 0,
@ls_mensaje_error = 'OK'
SELECT @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error

DECLARE @PLAN int, @CARRERA int, @NIVEL char(1)
/*Fecha creación 2013-11-07
  Autor: Antonio Pica /  Omar Ugalde
  Argumentos: El número de cuenta del alumno.
  			  filtro para clave de materia.
  			  filtro para nombre de materia.
  			  filtro para hora inicial de materia.
  			  
  Descripción:	Regresar las materias obligatorias del plan que el alumno puede inscribir
  			mas dos registros más para las materias de integración y las opcionales, estos
  			dos registros sólo servirán para cómo "link" para consultar todos los grupos de
  			del las materias respectivas.
 */

SET @CLAVE_MAT = ISNULL(@CLAVE_MAT,0)
SET @HORAINI   = ISNULL(@HORAINI,0)
SET @MATERIA = ISNULL(@MATERIA,'')
SET @MATERIA = REPLACE ( @MATERIA, '%','')
IF	LEN(@MATERIA) > 0	SET @MATERIA = '%'+@MATERIA+'%'
IF  LEN(@MATERIA) = 0	SET @MATERIA = '%'


SELECT @PLAN = cve_plan, @CARRERA = cve_carrera, @NIVEL = nivel
FROM	controlescolar_bd.dbo.academicos
WHERE	cuenta = @CUENTA

SELECT	case when exists(select 1
						 from 	controlescolar_bd.dbo.grupos as s1_grp
								inner join controlescolar_bd.dbo.horario as s1_hr on
								s1_grp.anio	= s1_hr.anio
							and	s1_grp.periodo	= s1_hr.periodo
							and	((s1_grp.cve_mat = s1_hr.cve_mat and s1_grp.gpo = s1_hr.gpo) 
									or 
			 					(s1_grp.cve_asimilada = s1_hr.cve_mat and s1_grp.gpo_asimilado = s1_hr.gpo))
						 where 	mpi.cve_mat	= s1_grp.cve_mat
 							and	(s1_hr.hora_inicio = @HORAINI OR @HORAINI = 0)
 						 group by s1_hr.gpo, s1_hr.hora_inicio
 						 having sum(s1_grp.cupo - s1_grp.inscritos) > 0
 						) then 1 else 0 end as cupo,
		mpi.cve_mat,mat.materia as materia,mat.horas_reales,mat.creditos,mpi.semestre_ideal,0 as es_opt, 0 as es_reflex
FROM controlescolar_bd.dbo.mat_pase_ingreso mpi
		
		inner join controlescolar_bd.dbo.materias mat on
		mat.cve_mat = mpi.cve_mat
		
		inner join	controlescolar_bd.dbo.plan_estudios ple on
		mpi.cve_carrera =	ple.cve_carrera
	and mpi.cve_plan	=	ple.cve_plan
		
		inner join  controlescolar_bd.dbo.area_mat amt on
		mpi.cve_mat		=	amt.cve_mat
	and	amt.cve_area not in (	ple.cve_area_integ_fundamental,
								ple.cve_area_integ_tema1,
								ple.cve_area_integ_tema2,
								ple.cve_area_integ_tema3,
								ple.cve_area_integ_tema4)
	and ( amt.cve_area in (		ple.cve_area_basica,
								ple.cve_area_mayor_oblig,
								ple.cve_area_servicio_social)
		or
		 amt.cve_area in	(select cve_area 
								 from controlescolar_bd.dbo.subsistema
								 where cve_plan = mpi.cve_plan and cve_carrera = mpi.cve_carrera and clase_area = 'OBL')
		)		
WHERE	mpi.cve_carrera	= @CARRERA
and		mpi.cve_plan	= @PLAN
and		mpi.cuenta		= @CUENTA
and		mpi.semestre_ideal <> 0
and		mat.materia like @MATERIA
and		(mpi.cve_mat = @CLAVE_MAT OR @CLAVE_MAT = 0)
and		(exists(select	1 
				from 	controlescolar_bd.dbo.grupos as s2_grp
							inner join controlescolar_bd.dbo.horario as s2_hr on
							s2_grp.anio	= s2_hr.anio
						and	s2_grp.periodo	= s2_hr.periodo
						and	((s2_grp.cve_mat = s2_hr.cve_mat and s2_grp.gpo = s2_hr.gpo) 
								or 
							 (s2_grp.cve_asimilada = s2_hr.cve_mat and s2_grp.gpo_asimilado = s2_hr.gpo))
				 where 	mpi.cve_mat	= s2_grp.cve_mat
					and	s2_hr.hora_inicio = @HORAINI
				)
			OR @HORAINI = 0)

UNION
SELECT -1,		-- cupo (mayor a cero - tiene cupo, igual a cero no hay cupo, -1 es reflexión o optativa
		0,		-- clave_materia
		'MATERIAS OPTATIVAS',		-- nombre_materia
		0,		-- horas
		0,		-- creditos
		0,		-- semestre ideal
		1 as es_opt,
		0 as es_reflex
WHERE	'MATERIAS OPTATIVAS' like @MATERIA AND @CLAVE_MAT = 0
UNION
SELECT -1,
		0,
		'REFLEXIÓN UNIVERSITARIA',
		0,
		0,
		0,
		0 as es_opt, 
		1 as es_reflex
WHERE @NIVEL <> 'P' AND 'REFLEXIÓN UNIVERSITARIA' like @MATERIA AND @CLAVE_MAT = 0
ORDER BY semestre_ideal, cupo desc, es_opt, materia

EtiquetaError:
 select @num_error = @ll_num_error, @mensaje_error = @ls_mensaje_error
SELECT CODIGO =@num_error, MENSAJE=@mensaje_error, 
		cuenta        = NULL,
		cve_mat       = NULL,
		materia       = NULL,
		gpo           = NULL,
		creditos      = NULL,
		horas         = NULL,
		cve_condicion = NULL
 -- Rollback Transaction
 return -1

GO

