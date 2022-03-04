USE controlescolar_bd
GO

DELETE FROM acta_evaluacion_transf
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE acta_evaluacion_transf'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE acta_evaluacion_transf'
END          
GO

UPDATE acta_evaluacion_transf 
SET a.nivel = m.nivel 
FROM acta_evaluacion_transf a, materias m 
WHERE a.cve_mat = m.cve_mat 
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE acta_evaluacion_transf'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE acta_evaluacion_transf'
END          
GO