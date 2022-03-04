USE controlescolar_bd
GO

UPDATE grupo_sinodal_ets SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupo_sinodal_ets'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupo_sinodal_ets'
END          
GO

UPDATE grupo_sinodal_ets SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupo_sinodal_ets'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupo_sinodal_ets'
END          
GO

UPDATE grupo_sinodal_ets SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE grupo_sinodal_ets'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE grupo_sinodal_ets'
END
GO

DELETE FROM grupo_sinodal_ets
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE grupo_sinodal_ets'
END ELSE BEGIN
	PRINT 'ERROR: DELETE grupo_sinodal_ets'
END
GO