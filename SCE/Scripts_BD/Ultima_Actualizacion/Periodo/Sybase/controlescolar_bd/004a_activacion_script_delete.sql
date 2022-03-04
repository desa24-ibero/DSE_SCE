USE controlescolar_bd
GO

DELETE FROM activacion
WHERE tipo_periodo = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM activacion'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM activacion'
END          
GO