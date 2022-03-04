USE controlescolar_bd
GO

DELETE FROM alumno_acta_evaluacion_preelim
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE alumno_acta_evaluacion_preelim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE alumno_acta_evaluacion_preelim'
END          
GO

UPDATE alumno_acta_evaluacion_preelim 
SET a.nivel = m.nivel 
FROM alumno_acta_evaluacion_preelim a, materias m 
WHERE a.cve_mat = m.cve_mat 
AND m.nivel IN('T')
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE alumno_acta_evaluacion_preelim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE alumno_acta_evaluacion_preelim'
END          
GO