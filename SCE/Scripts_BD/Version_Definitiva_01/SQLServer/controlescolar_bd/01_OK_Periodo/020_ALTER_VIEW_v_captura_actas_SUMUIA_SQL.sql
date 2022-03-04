USE sumuia_bd
go

ALTER VIEW v_captura_actas
AS
SELECT      cve_mat = dca_acta_evaluacion_plantilla.cve_mat,   
			materia = v_sce_materias.materia,   
			gpo = dca_acta_evaluacion_plantilla.gpo,   
			periodo = dca_acta_evaluacion_plantilla.periodo,   
			nombre_periodo = v_sce_periodo.descripcion,   
			anio = dca_acta_evaluacion_plantilla.anio,   
			no_acta = dca_acta_evaluacion_plantilla.no_acta,   
			cve_tipo_examen = dca_acta_evaluacion_plantilla.cve_tipo_examen,   
			tipo_examen = dca_tipo_examen.tipo_examen,   
			nivel = dca_acta_evaluacion_plantilla.nivel,   
			nombre_nivel =	UPPER( (SELECT desc_corta FROM controlescolar_bd.dbo.nivel WHERE cve_nivel = dca_acta_evaluacion_plantilla.nivel COLLATE Latin1_General_CI_AI ) ),
			cve_coordinacion = v_sce_coordinaciones.cve_coordinacion,   
			coordinacion = v_sce_coordinaciones.coordinacion,   
			cve_profesor = v_sce_profesor.cve_profesor,   
			nombre_completo_profesor = v_sce_profesor.nombre_completo,
			orden_alumno = dca_alumno_acta_eval_plantilla.orden_alumno,
			cuenta = dca_alumnos_ext.no_folio_inter,   
			digito = '',   /* Para alumnos foraneos no se utiliza el dígito verificador*/
			nombre_completo_alumno = dca_alumnos_ext.s_lastname + ' '  + dca_alumnos_ext.s_name, 
			day =  day(dca_acta_evaluacion_plantilla.fecha_generacion),
			month =  month(dca_acta_evaluacion_plantilla.fecha_generacion),
			year =  year(dca_acta_evaluacion_plantilla.fecha_generacion),
			cve_tipo_calificacion = dca_acta_evaluacion_plantilla.cve_tipo_calificacion,
			calificacion_confirmada = dca_alumno_acta_eval_plantilla.calificacion_confirmada,
			calificacion = dca_alumno_acta_eval_plantilla.calificacion,
			cve_estatus_acta =dca_acta_evaluacion_plantilla.cve_estatus_acta, 
			estatus_acta = dca_estatus_acta.estatus_acta,
			fecha_hoy = getdate(),
			no_acta_string = CASE	WHEN dca_acta_evaluacion_plantilla.no_acta <10 THEN '000'+cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
											WHEN dca_acta_evaluacion_plantilla.no_acta <100 THEN '00'+cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
											WHEN dca_acta_evaluacion_plantilla.no_acta <1000 THEN '0'+cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
											ELSE cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
									END,
			inscritos = dca_acta_evaluacion_plantilla.inscritos
FROM		dca_acta_evaluacion_plantilla,   
			dca_alumno_acta_eval_plantilla,   
			v_sce_coordinaciones,   
			v_sce_materias,   
			v_sce_periodo,   
			dca_tipo_examen,   
			v_sce_profesor,   
			dca_alumnos_ext,   
			dca_estatus_acta 
WHERE		( dca_acta_evaluacion_plantilla.cve_mat < 100000 ) and /* Materias de alumnos internos */
			( dca_acta_evaluacion_plantilla.cve_mat = dca_alumno_acta_eval_plantilla.cve_mat ) and  
			( dca_acta_evaluacion_plantilla.gpo = dca_alumno_acta_eval_plantilla.gpo ) and  
			( dca_acta_evaluacion_plantilla.periodo = dca_alumno_acta_eval_plantilla.periodo ) and  
			( dca_acta_evaluacion_plantilla.anio = dca_alumno_acta_eval_plantilla.anio ) and  
			( dca_acta_evaluacion_plantilla.no_acta = dca_alumno_acta_eval_plantilla.no_acta ) and  
			( dca_acta_evaluacion_plantilla.cve_tipo_examen = dca_alumno_acta_eval_plantilla.cve_tipo_examen ) and  
			( v_sce_coordinaciones.cve_coordinacion = v_sce_materias.cve_coordinacion ) and  
			( dca_alumno_acta_eval_plantilla.cve_tipo_examen = dca_tipo_examen.cve_tipo_examen ) and  
			( dca_acta_evaluacion_plantilla.cve_mat = v_sce_materias.cve_mat ) and  
			( dca_acta_evaluacion_plantilla.periodo = v_sce_periodo.periodo ) and  
			( dca_acta_evaluacion_plantilla.cve_profesor = v_sce_profesor.cve_profesor ) and  
			( dca_alumno_acta_eval_plantilla.cuenta = dca_alumnos_ext.no_folio_inter ) and  
			( dca_acta_evaluacion_plantilla.cve_estatus_acta = dca_estatus_acta.cve_estatus_acta )

UNION ALL

SELECT		cve_mat = dca_acta_evaluacion_plantilla.cve_mat,   
			materia = Convert ( Varchar ( 42 ) , dca_materias.materia ) COLLATE SQL_Latin1_General_CP1_CI_AS,
			gpo = dca_acta_evaluacion_plantilla.gpo,   
			periodo = dca_acta_evaluacion_plantilla.periodo,   
			nombre_periodo = v_sce_periodo.descripcion,   
			anio = dca_acta_evaluacion_plantilla.anio,   
			no_acta = dca_acta_evaluacion_plantilla.no_acta,   
			cve_tipo_examen = dca_acta_evaluacion_plantilla.cve_tipo_examen,   
			tipo_examen = dca_tipo_examen.tipo_examen,   
			nivel = dca_acta_evaluacion_plantilla.nivel,   
			nombre_nivel =	CASE dca_acta_evaluacion_plantilla.nivel	WHEN 'L' THEN 'LICENCIATURA'
																		WHEN 'P' THEN 'POSGRADO'
																		ELSE ''
							END,   
			cve_coordinacion = v_sce_coordinaciones.cve_coordinacion,   
			coordinacion = v_sce_coordinaciones.coordinacion,   
			cve_profesor = v_sce_profesor.cve_profesor,   
			nombre_completo_profesor = v_sce_profesor.nombre_completo,
			orden_alumno = dca_alumno_acta_eval_plantilla.orden_alumno,
			cuenta = dca_alumnos_ext.no_folio_inter,   
			digito = '',   /* Para alumnos foraneos no se utiliza el dígito verificador*/
			nombre_completo_alumno = dca_alumnos_ext.s_lastname + ' '  + dca_alumnos_ext.s_name, 
			day =  day(dca_acta_evaluacion_plantilla.fecha_generacion),
			month =  month(dca_acta_evaluacion_plantilla.fecha_generacion),
			year =  year(dca_acta_evaluacion_plantilla.fecha_generacion),
			cve_tipo_calificacion = dca_acta_evaluacion_plantilla.cve_tipo_calificacion,
			calificacion_confirmada = dca_alumno_acta_eval_plantilla.calificacion_confirmada,
			calificacion = dca_alumno_acta_eval_plantilla.calificacion,
			cve_estatus_acta = dca_acta_evaluacion_plantilla.cve_estatus_acta, 
			estatus_acta = dca_estatus_acta.estatus_acta,
			fecha_hoy = getdate(),
			no_acta_string = CASE	WHEN dca_acta_evaluacion_plantilla.no_acta <10 THEN '000'+cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
									WHEN dca_acta_evaluacion_plantilla.no_acta <100 THEN '00'+cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
									WHEN dca_acta_evaluacion_plantilla.no_acta <1000 THEN '0'+cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
									ELSE cast(dca_acta_evaluacion_plantilla.no_acta as varchar)
							END,
			inscritos = dca_acta_evaluacion_plantilla.inscritos
FROM		dca_acta_evaluacion_plantilla,   
			dca_alumno_acta_eval_plantilla,   
			v_sce_coordinaciones,   
			dca_materias,   
			v_sce_periodo,   
			dca_tipo_examen,   
			v_sce_profesor, 
			dca_alumnos_ext,
			dca_estatus_acta 
WHERE		( dca_acta_evaluacion_plantilla.cve_mat >= 100000 ) and /* Materias de alumnos internos */
			( dca_acta_evaluacion_plantilla.cve_mat = dca_alumno_acta_eval_plantilla.cve_mat ) and  
			( dca_acta_evaluacion_plantilla.gpo = dca_alumno_acta_eval_plantilla.gpo ) and  
			( dca_acta_evaluacion_plantilla.periodo = dca_alumno_acta_eval_plantilla.periodo ) and  
			( dca_acta_evaluacion_plantilla.anio = dca_alumno_acta_eval_plantilla.anio ) and  
			( dca_acta_evaluacion_plantilla.no_acta = dca_alumno_acta_eval_plantilla.no_acta ) and  
			( dca_acta_evaluacion_plantilla.cve_tipo_examen = dca_alumno_acta_eval_plantilla.cve_tipo_examen ) and  
			( v_sce_coordinaciones.cve_coordinacion = dca_materias.cve_coordinacion ) and  
			( dca_alumno_acta_eval_plantilla.cve_tipo_examen = dca_tipo_examen.cve_tipo_examen ) and  
			( dca_acta_evaluacion_plantilla.cve_mat = dca_materias.cve_mat ) and  
			( dca_acta_evaluacion_plantilla.periodo = v_sce_periodo.periodo ) and  
			( dca_acta_evaluacion_plantilla.cve_profesor = v_sce_profesor.cve_profesor ) and
			( dca_alumno_acta_eval_plantilla.cuenta = dca_alumnos_ext.no_folio_inter ) and  
			( dca_acta_evaluacion_plantilla.cve_estatus_acta = dca_estatus_acta.cve_estatus_acta )

GO

