USE web_bd
GO

UPDATE ei_evaluacion SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ei_evaluacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ei_evaluacion'
END          
GO

UPDATE ei_evaluacion SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ei_evaluacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ei_evaluacion'
END          
GO

UPDATE ei_evaluacion SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ei_evaluacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ei_evaluacion'
END
GO