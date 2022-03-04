USE controlescolar_bd
GO

DELETE FROM no_academicos_hist
WHERE periodo_ing < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END
GO

DELETE FROM no_academicos_hist
WHERE periodo_egre < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END
GO


UPDATE no_academicos_hist 
SET nivel = (SELECT nivel FROM carreras WHERE carreras.cve_carrera = no_academicos_hist.cve_carrera)

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE no_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE no_academicos_hist'
END          
GO