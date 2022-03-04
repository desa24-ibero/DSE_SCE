USE controlescolar_bd
GO

UPDATE security_user_app SET periodo_default = 'Q'
WHERE periodo_default = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE security_user_app'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE security_user_app'
END          
GO