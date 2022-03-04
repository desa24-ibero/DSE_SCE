USE controlescolar_bd
GO

UPDATE hist_reingreso SET periodo_ing = 7 -- CUATRIMESTRE 1
WHERE periodo_ing = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_reingreso'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_reingreso'
END          
GO

UPDATE hist_reingreso SET periodo_ing = 8 -- CUATRIMESTRE 2
WHERE periodo_ing = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_reingreso'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_reingreso'
END          
GO

UPDATE hist_reingreso SET periodo_ing = 9 -- CUATRIMESTRE 3
WHERE periodo_ing = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_reingreso'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_reingreso'
END
GO

DELETE FROM hist_reingreso
WHERE periodo_ing < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE hist_reingreso'
END ELSE BEGIN
	PRINT 'ERROR: DELETE hist_reingreso'
END
GO