USE controlescolar_bd
GO

UPDATE mat_preinsc_primer_ciclo SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_preinsc_primer_ciclo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_preinsc_primer_ciclo'
END          
GO

UPDATE mat_preinsc_primer_ciclo SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_preinsc_primer_ciclo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_preinsc_primer_ciclo'
END          
GO

UPDATE mat_preinsc_primer_ciclo SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE mat_preinsc_primer_ciclo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE mat_preinsc_primer_ciclo'
END
GO

DELETE FROM mat_preinsc_primer_ciclo
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE mat_preinsc_primer_ciclo'
END ELSE BEGIN
	PRINT 'ERROR: DELETE mat_preinsc_primer_ciclo'
END
GO