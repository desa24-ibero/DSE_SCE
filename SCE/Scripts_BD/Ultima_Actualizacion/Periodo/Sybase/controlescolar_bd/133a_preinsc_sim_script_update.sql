USE controlescolar_bd
GO

UPDATE preinsc_sim SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE preinsc_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE preinsc_sim'
END          
GO

UPDATE preinsc_sim SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE preinsc_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE preinsc_sim'
END          
GO

UPDATE preinsc_sim SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE preinsc_sim'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE preinsc_sim'
END
GO

DELETE FROM preinsc_sim
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE preinsc_sim'
END ELSE BEGIN
	PRINT 'ERROR: DELETE preinsc_sim'
END
GO