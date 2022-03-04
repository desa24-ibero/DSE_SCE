USE web_bd
GO

UPDATE spre_solicitud SET cveperiodo = 7 -- CUATRIMESTRE 1
WHERE cveperiodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE spre_solicitud'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE spre_solicitud'
END          
GO

UPDATE spre_solicitud SET cveperiodo = 8 -- CUATRIMESTRE 2
WHERE cveperiodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE spre_solicitud'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE spre_solicitud'
END          
GO

UPDATE spre_solicitud SET cveperiodo = 9 -- CUATRIMESTRE 3
WHERE cveperiodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE spre_solicitud'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE spre_solicitud'
END
GO
