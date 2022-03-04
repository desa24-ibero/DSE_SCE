USE controlescolar_bd
GO

DELETE FROM security_user_app
WHERE periodo_default = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM security_user_app'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM security_user_app'
END          
GO