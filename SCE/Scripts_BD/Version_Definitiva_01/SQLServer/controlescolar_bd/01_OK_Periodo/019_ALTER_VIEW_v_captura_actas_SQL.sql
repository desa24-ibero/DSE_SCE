

USE controlescolar_bd 
GO


ALTER VIEW v_captura_actas
AS
SELECT  cve_mat = acta_evaluacion_preeliminar.cve_mat,   
         materia = materias.materia,   
         gpo = acta_evaluacion_preeliminar.gpo,   
         periodo = acta_evaluacion_preeliminar.periodo,   
         nombre_periodo = periodo.descripcion,   
         anio = acta_evaluacion_preeliminar.anio,   
         no_acta = acta_evaluacion_preeliminar.no_acta,   
         cve_tipo_examen = acta_evaluacion_preeliminar.cve_tipo_examen,   
         tipo_examen = tipo_examen.tipo_examen,   
         nivel = acta_evaluacion_preeliminar.nivel,   
			nombre_nivel = UPPER( (SELECT desc_corta FROM nivel WHERE cve_nivel = acta_evaluacion_preeliminar.nivel) ), 
         cve_coordinacion = coordinaciones.cve_coordinacion,   
         coordinacion = coordinaciones.coordinacion,   
         cve_profesor =profesor.cve_profesor,   
         nombre_completo_profesor = profesor.nombre_completo,   
			orden_alumno = alumno_acta_evaluacion_preelim.orden_alumno,
         cuenta = alumnos.cuenta,   
         digito = v_sce_alumno_digito.digito,   
         nombre_completo_alumno = alumnos.nombre_completo, 
			day =  day(acta_evaluacion_preeliminar.fecha_generacion),
			month =  month(acta_evaluacion_preeliminar.fecha_generacion),
			year =  year(acta_evaluacion_preeliminar.fecha_generacion),
			cve_tipo_calificacion = materias.evaluacion,
			calificacion_confirmada = alumno_acta_evaluacion_preelim.calificacion_confirmada,
			calificacion = alumno_acta_evaluacion_preelim.calificacion,
			cve_estatus_acta =acta_evaluacion_preeliminar.cve_estatus_acta, 
			estatus_acta = estatus_acta.estatus_acta,
			fecha_hoy = getdate(),
			no_acta_string = CASE WHEN acta_evaluacion_preeliminar.no_acta <10 THEN '000'+cast(acta_evaluacion_preeliminar.no_acta as varchar)
								  WHEN acta_evaluacion_preeliminar.no_acta <100 THEN '00'+cast(acta_evaluacion_preeliminar.no_acta as varchar)
								  WHEN acta_evaluacion_preeliminar.no_acta <1000 THEN '0'+cast(acta_evaluacion_preeliminar.no_acta as varchar)
								  ELSE cast(acta_evaluacion_preeliminar.no_acta as varchar)
							 END,
			inscritos = acta_evaluacion_preeliminar.inscritos
    FROM acta_evaluacion_preeliminar,   
         alumno_acta_evaluacion_preelim,   
         coordinaciones,   
         materias,   
         periodo,   
         tipo_examen,   
         profesor,   
         alumnos,   
         v_sce_alumno_digito,
			estatus_acta 
   WHERE ( acta_evaluacion_preeliminar.cve_mat = alumno_acta_evaluacion_preelim.cve_mat ) and  
         ( acta_evaluacion_preeliminar.gpo = alumno_acta_evaluacion_preelim.gpo ) and  
         ( acta_evaluacion_preeliminar.periodo = alumno_acta_evaluacion_preelim.periodo ) and  
         ( acta_evaluacion_preeliminar.anio = alumno_acta_evaluacion_preelim.anio ) and  
         ( acta_evaluacion_preeliminar.no_acta = alumno_acta_evaluacion_preelim.no_acta ) and  
         ( acta_evaluacion_preeliminar.cve_tipo_examen = alumno_acta_evaluacion_preelim.cve_tipo_examen ) and  
         ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and  
         ( alumno_acta_evaluacion_preelim.cve_tipo_examen = tipo_examen.cve_tipo_examen ) and  
         ( acta_evaluacion_preeliminar.cve_mat = materias.cve_mat ) and  
         ( acta_evaluacion_preeliminar.periodo = periodo.periodo ) and  
         ( acta_evaluacion_preeliminar.cve_profesor = profesor.cve_profesor ) and  
         ( alumno_acta_evaluacion_preelim.cuenta = alumnos.cuenta ) and  
         ( alumnos.cuenta = v_sce_alumno_digito.cuenta )  and  
         ( acta_evaluacion_preeliminar.cve_estatus_acta = estatus_acta.cve_estatus_acta )    


GO

