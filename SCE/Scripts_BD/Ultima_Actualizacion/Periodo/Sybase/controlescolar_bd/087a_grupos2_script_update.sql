USE controlescolar_bd
GO

UPDATE grupos2 SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupos2'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupos2'
END          
GO

UPDATE grupos2 SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupos2'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupos2'
END          
GO

UPDATE grupos2 SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupos2'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupos2'
END
GO

DELETE FROM grupos2
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE grupos2'
END ELSE BEGIN
	PRINT 'ERROR: DELETE grupos2'
END
GO