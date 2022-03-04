USE controlescolar_bd
GO

UPDATE mat_inscritas_ets SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_inscritas_ets'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_inscritas_ets'
END          
GO

UPDATE mat_inscritas_ets SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_inscritas_ets'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_inscritas_ets'
END          
GO

UPDATE mat_inscritas_ets SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_inscritas_ets'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_inscritas_ets'
END
GO

DELETE FROM mat_inscritas_ets
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE mat_inscritas_ets'
END ELSE BEGIN
	PRINT 'ERROR: DELETE mat_inscritas_ets'
END
GO