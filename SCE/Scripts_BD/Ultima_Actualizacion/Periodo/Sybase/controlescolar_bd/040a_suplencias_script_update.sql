USE controlescolar_bd
GO

UPDATE suplencias SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE suplencias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE suplencias'
END          
GO

UPDATE suplencias SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE suplencias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE suplencias'
END          
GO

UPDATE suplencias SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE suplencias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE suplencias'
END
GO

DELETE FROM suplencias
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE suplencias'
END ELSE BEGIN
	PRINT 'ERROR: DELETE suplencias'
END
GO