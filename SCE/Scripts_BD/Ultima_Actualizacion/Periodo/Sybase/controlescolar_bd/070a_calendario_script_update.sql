USE controlescolar_bd
GO

UPDATE calendario SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE calendario'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE calendario'
END          
GO

UPDATE calendario SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE calendario'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE calendario'
END          
GO

UPDATE calendario SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE calendario'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE calendario'
END
GO

DELETE FROM calendario
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE calendario'
END ELSE BEGIN
	PRINT 'ERROR: DELETE calendario'
END
GO