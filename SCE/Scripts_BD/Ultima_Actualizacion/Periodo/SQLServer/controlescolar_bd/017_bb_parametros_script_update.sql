USE controlescolar_bd
GO

UPDATE bb_parametros SET periodo_ant_2 = 7 -- CUATRIMESTRE 1
WHERE periodo_ant_2 = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO

UPDATE bb_parametros SET periodo_ant = 7 -- CUATRIMESTRE 1
WHERE periodo_ant = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO

UPDATE bb_parametros SET periodo_sig = 7 -- CUATRIMESTRE 1
WHERE periodo_sig = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO

UPDATE bb_parametros SET periodo_act = 7 -- CUATRIMESTRE 1
WHERE periodo_act = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO



UPDATE bb_parametros SET periodo_ant_2 = 8 -- CUATRIMESTRE 2
WHERE periodo_ant_2 = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO

UPDATE bb_parametros SET periodo_ant = 8 -- CUATRIMESTRE 2
WHERE periodo_ant = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO

UPDATE bb_parametros SET periodo_sig = 8 -- CUATRIMESTRE 2
WHERE periodo_sig = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO

UPDATE bb_parametros SET periodo_act = 8 -- CUATRIMESTRE 2
WHERE periodo_act = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END          
GO



UPDATE bb_parametros SET periodo_ant_2 = 9 -- CUATRIMESTRE 3
WHERE periodo_ant_2 = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END
GO

UPDATE bb_parametros SET periodo_ant = 9 -- CUATRIMESTRE 3
WHERE periodo_ant = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END
GO

UPDATE bb_parametros SET periodo_sig = 9 -- CUATRIMESTRE 3
WHERE periodo_sig = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END
GO

UPDATE bb_parametros SET periodo_act = 9 -- CUATRIMESTRE 3
WHERE periodo_act = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bb_parametros'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bb_parametros'
END
GO