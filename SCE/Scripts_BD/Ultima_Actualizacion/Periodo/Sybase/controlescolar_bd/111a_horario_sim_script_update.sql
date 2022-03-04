USE controlescolar_bd
GO

UPDATE horario_sim SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE horario_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE horario_sim'
END          
GO

UPDATE horario_sim SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE horario_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE horario_sim'
END          
GO

UPDATE horario_sim SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE horario_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE horario_sim'
END
GO

DELETE FROM horario_sim
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE horario_sim'
END ELSE BEGIN
	PRINT 'ERROR: DELETE horario_sim'
END
GO