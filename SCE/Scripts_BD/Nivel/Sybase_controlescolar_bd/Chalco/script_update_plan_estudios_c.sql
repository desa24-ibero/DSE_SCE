USE controlescolar_bd
GO

UPDATE plan_estudios SET tipo_periodo = 'Q' -- CUATRIMESTRES
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_estudios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_estudios'
END          
GO