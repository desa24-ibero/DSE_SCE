USE controlescolar_bd
GO

UPDATE hist_academicos SET periodo_ing = 7 -- CUATRIMESTRE 1
WHERE periodo_ing = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_academicos'
END          
GO

UPDATE hist_academicos SET periodo_egre = 7 -- CUATRIMESTRE 1
WHERE periodo_egre = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_academicos'
END          
GO

UPDATE hist_academicos SET periodo_ing = 8 -- CUATRIMESTRE 2
WHERE periodo_ing = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_academicos'
END          
GO

UPDATE hist_academicos SET periodo_egre = 8 -- CUATRIMESTRE 2
WHERE periodo_egre = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_academicos'
END          
GO

UPDATE hist_academicos SET periodo_ing = 9 -- CUATRIMESTRE 3
WHERE periodo_ing = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_academicos'
END
GO

UPDATE hist_academicos SET periodo_egre = 9 -- CUATRIMESTRE 3
WHERE periodo_egre = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_academicos'
END
GO