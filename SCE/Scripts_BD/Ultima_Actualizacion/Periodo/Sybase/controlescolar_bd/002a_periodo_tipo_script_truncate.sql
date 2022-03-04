USE controlescolar_bd
GO

TRUNCATE TABLE periodo_tipo 
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: TRUNCATE TABLE periodo_tipo'
END ELSE BEGIN
	PRINT 'ERROR: TRUNCATE TABLE periodo_tipo'
END          
GO