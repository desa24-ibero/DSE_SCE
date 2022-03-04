USE controlescolar_bd
GO

UPDATE periodo_parametros SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_parametros'
END          
GO

UPDATE periodo_parametros SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_parametros'
END          
GO

UPDATE periodo_parametros SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_parametros'
END
GO