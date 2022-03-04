USE controlescolar_bd
GO

UPDATE sfeb_sqp_historico SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sfeb_sqp_historico'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sfeb_sqp_historico'
END          
GO

UPDATE sfeb_sqp_historico SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sfeb_sqp_historico'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sfeb_sqp_historico'
END          
GO

UPDATE sfeb_sqp_historico SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sfeb_sqp_historico'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sfeb_sqp_historico'
END
GO

DELETE FROM sfeb_sqp_historico
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE sfeb_sqp_historico'
END ELSE BEGIN
	PRINT 'ERROR: DELETE sfeb_sqp_historico'
END
GO