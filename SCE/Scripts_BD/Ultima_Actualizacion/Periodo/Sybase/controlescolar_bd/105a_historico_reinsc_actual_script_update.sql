USE controlescolar_bd
GO

UPDATE historico_reinsc_actual SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE historico_reinsc_actual'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE historico_reinsc_actual'
END          
GO

UPDATE historico_reinsc_actual SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE historico_reinsc_actual'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE historico_reinsc_actual'
END          
GO

UPDATE historico_reinsc_actual SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE historico_reinsc_actual'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE historico_reinsc_actual'
END
GO

DELETE FROM historico_reinsc_actual
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE historico_reinsc_actual'
END ELSE BEGIN
	PRINT 'ERROR: DELETE historico_reinsc_actual'
END
GO