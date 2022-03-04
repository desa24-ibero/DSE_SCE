USE controlescolar_bd
GO

DELETE FROM bit_acta_evaluacion_preelim
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_acta_evaluacion_preelim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_acta_evaluacion_preelim'
END          
GO

UPDATE bit_acta_evaluacion_preelim 
SET a.nivel = m.nivel 
FROM bit_acta_evaluacion_preelim a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P'
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_acta_evaluacion_preelim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_acta_evaluacion_preelim'
END          
GO