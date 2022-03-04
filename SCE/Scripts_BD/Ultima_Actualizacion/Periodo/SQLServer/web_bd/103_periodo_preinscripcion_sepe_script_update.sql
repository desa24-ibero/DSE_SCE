USE web_bd
GO

UPDATE periodo_preinscripcion_sepe SET periodo_preinsc = 7 -- CUATRIMESTRE 1
WHERE periodo_preinsc = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_preinscripcion_sepe'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_preinscripcion_sepe'
END          
GO

UPDATE periodo_preinscripcion_sepe SET periodo_sepe = 7 -- CUATRIMESTRE 1
WHERE periodo_sepe = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_preinscripcion_sepe'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_preinscripcion_sepe'
END          
GO

UPDATE periodo_preinscripcion_sepe SET periodo_preinsc = 8 -- CUATRIMESTRE 2
WHERE periodo_preinsc = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_preinscripcion_sepe'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_preinscripcion_sepe'
END          
GO

UPDATE periodo_preinscripcion_sepe SET periodo_sepe = 8 -- CUATRIMESTRE 2
WHERE periodo_sepe = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_preinscripcion_sepe'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_preinscripcion_sepe'
END          
GO

UPDATE periodo_preinscripcion_sepe SET periodo_preinsc = 9 -- CUATRIMESTRE 3
WHERE periodo_preinsc = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_preinscripcion_sepe'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_preinscripcion_sepe'
END
GO

UPDATE periodo_preinscripcion_sepe SET periodo_sepe = 9 -- CUATRIMESTRE 3
WHERE periodo_sepe = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_preinscripcion_sepe'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_preinscripcion_sepe'
END
GO