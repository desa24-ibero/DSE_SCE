USE controlescolar_bd
GO

UPDATE hist_indulto SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_indulto'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_indulto'
END          
GO

UPDATE hist_indulto SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_indulto'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_indulto'
END          
GO

UPDATE hist_indulto SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_indulto'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_indulto'
END
GO

DELETE FROM hist_indulto
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE hist_indulto'
END ELSE BEGIN
	PRINT 'ERROR: DELETE hist_indulto'
END
GO