USE controlescolar_bd
GO

UPDATE materias SET tipo_periodo = 'Q'
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE materias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE materias'
END          
GO