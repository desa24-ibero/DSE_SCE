USE controlescolar_bd
GO

UPDATE no_academicos_hist SET periodo_ing = 7 -- CUATRIMESTRE 1
WHERE periodo_ing = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END          
GO

UPDATE no_academicos_hist SET periodo_egre = 7 -- CUATRIMESTRE 1
WHERE periodo_egre = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END          
GO

UPDATE no_academicos_hist SET periodo_ing = 8 -- CUATRIMESTRE 2
WHERE periodo_ing = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END          
GO

UPDATE no_academicos_hist SET periodo_egre = 8 -- CUATRIMESTRE 2
WHERE periodo_egre = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END          
GO

UPDATE no_academicos_hist SET periodo_ing = 9 -- CUATRIMESTRE 3
WHERE periodo_ing = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END
GO

UPDATE no_academicos_hist SET periodo_egre = 9 -- CUATRIMESTRE 3
WHERE periodo_egre = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END
GO