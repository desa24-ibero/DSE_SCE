USE web_bd
GO

UPDATE folio_solicitud_materias SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE folio_solicitud_materias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE folio_solicitud_materias'
END          
GO

UPDATE folio_solicitud_materias SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE folio_solicitud_materias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE folio_solicitud_materias'
END          
GO

UPDATE folio_solicitud_materias SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE folio_solicitud_materias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE folio_solicitud_materias'
END
GO
