USE controlescolar_bd
GO

UPDATE parametros_reinscripcion SET tipo_periodo = 'Q'
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_reinscripcion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_reinscripcion'
END          
GO
