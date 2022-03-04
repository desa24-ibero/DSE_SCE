USE controlescolar_bd
GO

DELETE FROM coordinaciones
WHERE tipo_periodo = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM coordinaciones'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM coordinaciones'
END          
GO