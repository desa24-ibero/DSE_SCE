USE controlescolar_bd
GO

UPDATE hist_carreras SET periodo_ing = 7 -- CUATRIMESTRE 1
WHERE periodo_ing = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END          
GO


UPDATE hist_carreras SET periodo_egre_ant = 7 -- CUATRIMESTRE 1
WHERE periodo_egre_ant = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END          
GO

UPDATE hist_carreras SET periodo_ing = 8 -- CUATRIMESTRE 2
WHERE periodo_ing = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END          
GO

UPDATE hist_carreras SET periodo_egre_ant = 8 -- CUATRIMESTRE 2
WHERE periodo_egre_ant = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END          
GO

UPDATE hist_carreras SET periodo_ing = 9 -- CUATRIMESTRE 3
WHERE periodo_ing = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END
GO

UPDATE hist_carreras SET periodo_egre_ant = 9 -- CUATRIMESTRE 3
WHERE periodo_egre_ant = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END
GO
