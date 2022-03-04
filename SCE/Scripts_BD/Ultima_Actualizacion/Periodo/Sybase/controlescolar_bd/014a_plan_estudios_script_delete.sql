USE controlescolar_bd
GO

DELETE FROM plan_estudios
WHERE tipo_periodo = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM plan_estudios'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM plan_estudios'
END          
GO