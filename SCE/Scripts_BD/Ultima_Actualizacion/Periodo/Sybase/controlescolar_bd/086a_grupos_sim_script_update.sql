USE controlescolar_bd
GO

UPDATE grupos_sim SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupos_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupos_sim'
END          
GO

UPDATE grupos_sim SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupos_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupos_sim'
END          
GO

UPDATE grupos_sim SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupos_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupos_sim'
END
GO

DELETE FROM grupos_sim
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE grupos_sim'
END ELSE BEGIN
	PRINT 'ERROR: DELETE grupos_sim'
END
GO