USE controlescolar_bd
GO

DELETE FROM acta_evaluacion_preeliminar
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE acta_evaluacion_preeliminar'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE acta_evaluacion_preeliminar'
END          
GO

UPDATE acta_evaluacion_preeliminar 
SET a.nivel = m.nivel 
FROM acta_evaluacion_preeliminar a, materias m 
WHERE a.cve_mat = m.cve_mat 
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE acta_evaluacion_preeliminar'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE acta_evaluacion_preeliminar'
END          
GO
