USE controlescolar_bd
GO

DELETE FROM activacion_su
WHERE tipo_periodo = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM activacion_su'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM activacion_su'
END          
GO