USE controlescolar_bd
GO

UPDATE mat_preinsc_rechazadas SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_preinsc_rechazadas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_preinsc_rechazadas'
END          
GO

UPDATE mat_preinsc_rechazadas SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_preinsc_rechazadas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_preinsc_rechazadas'
END          
GO

UPDATE mat_preinsc_rechazadas SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_preinsc_rechazadas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_preinsc_rechazadas'
END
GO