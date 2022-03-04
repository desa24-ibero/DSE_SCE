USE controlescolar_bd
GO

UPDATE criterio_folio_solicitudes SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE criterio_folio_solicitudes'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE criterio_folio_solicitudes'
END          
GO

UPDATE criterio_folio_solicitudes SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE criterio_folio_solicitudes'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE criterio_folio_solicitudes'
END          
GO

UPDATE criterio_folio_solicitudes SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE criterio_folio_solicitudes'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE criterio_folio_solicitudes'
END
GO