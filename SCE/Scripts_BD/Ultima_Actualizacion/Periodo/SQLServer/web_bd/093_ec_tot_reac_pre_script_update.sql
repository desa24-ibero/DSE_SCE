USE web_bd
GO

UPDATE ec_tot_reac_pre SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ec_tot_reac_pre'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ec_tot_reac_pre'
END          
GO

UPDATE ec_tot_reac_pre SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ec_tot_reac_pre'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ec_tot_reac_pre'
END          
GO

UPDATE ec_tot_reac_pre SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ec_tot_reac_pre'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ec_tot_reac_pre'
END
GO