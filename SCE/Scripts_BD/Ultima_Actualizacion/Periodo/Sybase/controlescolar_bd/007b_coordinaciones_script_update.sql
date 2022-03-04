USE controlescolar_bd
GO

UPDATE coordinaciones SET tipo_periodo = 'Q'
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE coordinaciones'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE coordinaciones'
END          
GO