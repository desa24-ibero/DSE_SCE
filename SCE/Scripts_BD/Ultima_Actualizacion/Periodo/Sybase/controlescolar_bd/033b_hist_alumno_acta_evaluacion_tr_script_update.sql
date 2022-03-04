USE controlescolar_bd
GO

DELETE FROM hist_alumno_acta_evaluacion_tr
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_alumno_acta_evaluacion_tr'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_alumno_acta_evaluacion_tr'
END          
GO

UPDATE hist_alumno_acta_evaluacion_tr 
SET a.nivel = m.nivel 
FROM hist_alumno_acta_evaluacion_tr a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_alumno_acta_evaluacion_tr'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_alumno_acta_evaluacion_tr'
END          
GO