USE controlescolar_bd
GO

UPDATE bit_historico_intercambio SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_historico_intercambio'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_historico_intercambio'
END          
GO

UPDATE bit_historico_intercambio SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_historico_intercambio'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_historico_intercambio'
END          
GO

UPDATE bit_historico_intercambio SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_historico_intercambio'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_historico_intercambio'
END
GO

DELETE FROM bit_historico_intercambio
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE bit_historico_intercambio'
END ELSE BEGIN
	PRINT 'ERROR: DELETE bit_historico_intercambio'
END
GO