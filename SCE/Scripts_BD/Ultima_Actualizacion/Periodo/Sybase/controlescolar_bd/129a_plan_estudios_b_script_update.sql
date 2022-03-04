USE controlescolar_bd
GO

UPDATE plan_estudios SET periodo_vigencia = 7 -- CUATRIMESTRE 1
WHERE periodo_vigencia = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_estudios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_estudios'
END          
GO

UPDATE plan_estudios SET periodo_vigencia = 8 -- CUATRIMESTRE 2
WHERE periodo_vigencia = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_estudios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_estudios'
END          
GO

UPDATE plan_estudios SET periodo_vigencia = 9 -- CUATRIMESTRE 3
WHERE periodo_vigencia = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE plan_estudios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE plan_estudios'
END
GO

DELETE FROM plan_estudios
WHERE periodo_vigencia < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE plan_estudios'
END ELSE BEGIN
	PRINT 'ERROR: DELETE plan_estudios'
END
GO