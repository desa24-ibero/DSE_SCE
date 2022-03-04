USE controlescolar_bd
GO

UPDATE solicitud_tramite_internet SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE solicitud_tramite_internet'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE solicitud_tramite_internet'
END          
GO

UPDATE solicitud_tramite_internet SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE solicitud_tramite_internet'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE solicitud_tramite_internet'
END          
GO

UPDATE solicitud_tramite_internet SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE solicitud_tramite_internet'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE solicitud_tramite_internet'
END
GO