USE controlescolar_bd
GO

DELETE FROM periodo_parametros
WHERE periodo >= 3
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM periodo_parametros'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM periodo_parametros'
END          
GO