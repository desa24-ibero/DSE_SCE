USE controlescolar_bd
GO

UPDATE procesos_actas SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE procesos_actas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE procesos_actas'
END          
GO

UPDATE procesos_actas SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE procesos_actas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE procesos_actas'
END          
GO

UPDATE procesos_actas SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE procesos_actas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE procesos_actas'
END
GO

DELETE FROM procesos_actas
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE procesos_actas'
END ELSE BEGIN
	PRINT 'ERROR: DELETE procesos_actas'
END
GO