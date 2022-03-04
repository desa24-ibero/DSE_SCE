USE controlescolar_bd
GO

UPDATE parametros_servicios SET periodo_preinscripcion = 7 -- CUATRIMESTRE 1
WHERE periodo_preinscripcion = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_servicios'
END          
GO

UPDATE parametros_servicios SET periodo_mat_inscritas = 7 -- CUATRIMESTRE 1
WHERE periodo_mat_inscritas = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_servicios'
END          
GO

UPDATE parametros_servicios SET periodo_preinscripcion = 8 -- CUATRIMESTRE 2
WHERE periodo_preinscripcion = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_servicios'
END          
GO

UPDATE parametros_servicios SET periodo_mat_inscritas = 8 -- CUATRIMESTRE 2
WHERE periodo_mat_inscritas = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_servicios'
END          
GO

UPDATE parametros_servicios SET periodo_preinscripcion = 9 -- CUATRIMESTRE 3
WHERE periodo_preinscripcion = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_servicios'
END
GO

UPDATE parametros_servicios SET periodo_mat_inscritas = 9 -- CUATRIMESTRE 3
WHERE periodo_mat_inscritas = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_servicios'
END
GO


DELETE FROM parametros_servicios
WHERE periodo_preinscripcion < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: DELETE parametros_servicios'
END
GO

DELETE FROM parametros_servicios
WHERE periodo_mat_inscritas < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE parametros_servicios'
END ELSE BEGIN
	PRINT 'ERROR: DELETE parametros_servicios'
END
GO