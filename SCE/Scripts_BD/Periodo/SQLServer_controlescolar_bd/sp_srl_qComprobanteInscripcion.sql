USE [controlescolar_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_srl_qComprobanteInscripcion]    Script Date: 26/9/2017 13:00:44 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_srl_qComprobanteInscripcion]
 @CUENTA int
AS
SELECT	--case mi.periodo when 0 then 'PRIMAVERA' when 1 then 'VERANO' when 2 then 'OTOÑO' end as periodo,
		per.descripcion AS periodo,
		mi.anio as anio,
		getdate() as fecha_impr,
		ac.cuenta as cuenta,
		vd.digito as digito,
		al.apaterno as apaterno,
		al.amaterno as amaterno,
		al.nombre as nombre,
		ca.cve_carrera as cve_carrera,
		ca.carrera as carrera,
		pl.cve_plan as cve_plan,
		pln.nombre_plan as nombre_plan,
		mi.cve_mat as cve_mat,
		mi.gpo as grupo,
		ma.materia as materia,
		ma.creditos as creditos,
		ma.horas_reales as horas_reales,
		ISNULL(hor.cve_salon,'') as cve_salon,
		CASE ISNULL(hor.cve_dia,0) WHEN 1 THEN 'Lunes' WHEN 2 THEN 'Martes' WHEN 3 THEN 'Miércoles'
						WHEN 4 THEN 'Jueves' WHEN 5 THEN 'Viernes' WHEN 6 THEN 'Sábado'
						WHEN 7 THEN 'Domingo' ELSE 'Sin Día' END as dia,
		act.mensaje,
		folio = (select isnull(max(fsm.folio),0) from web_bd.dbo.folio_solicitud_materias fsm where al.cuenta = fsm.cuenta and fsm.periodo = act.periodo and fsm.anio = act.anio)
FROM	controlescolar_bd.dbo.mat_inscritas mi
		inner join periodo AS per ON per.periodo = mi.periodo

		inner join controlescolar_bd.dbo.alumnos as al on
		al.cuenta = mi.cuenta
		
		inner join controlescolar_bd.dbo.academicos as ac on
		ac.cuenta = mi.cuenta
		
		inner join controlescolar_bd.dbo.v_sce_alumno_digito as vd on
		vd.cuenta =  mi.cuenta
		
		inner join controlescolar_bd.dbo.plan_estudios as pl on
		pl.cve_carrera	= ac.cve_carrera
	and pl.cve_plan		= ac.cve_plan
	
		inner join controlescolar_bd.dbo.nombre_plan as pln on
		pln.cve_plan	= pl.cve_plan
		
		inner join controlescolar_bd.dbo.carreras as ca on
		ca.cve_carrera = ac.cve_carrera 
		
		inner join controlescolar_bd.dbo.activacion as act on
		act.anio	= mi.anio
	and act.periodo	= mi.periodo
		
		inner join controlescolar_bd.dbo.materias as ma on
		ma.cve_mat = mi.cve_mat
		
		inner join controlescolar_bd.dbo.grupos grp WITH (NOLOCK) on
		mi.cve_mat	= grp.cve_mat
	and	mi.gpo		= grp.gpo
	and mi.periodo	= grp.periodo
	and	mi.anio		= grp.anio
			
		left join controlescolar_bd.dbo.horario hor on
		grp.anio	= hor.anio
	and	grp.periodo	= hor.periodo
	and	((grp.cve_mat = hor.cve_mat and grp.gpo = hor.gpo) 
          or 
          (grp.cve_asimilada = hor.cve_mat and grp.gpo_asimilado = hor.gpo)
         )
WHERE mi.cuenta = @CUENTA
ORDER BY mi.cve_mat, hor.cve_dia
GO

GRANT EXECUTE ON [dbo].[sp_srl_qComprobanteInscripcion] TO public
GO