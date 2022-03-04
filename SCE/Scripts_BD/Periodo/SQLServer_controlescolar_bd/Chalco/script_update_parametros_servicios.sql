USE controlescolar_bd
GO

UPDATE parametros_servicios SET tipo_periodo = 'Q'
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_reinscripcion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_reinscripcion'
END          
GO

UPDATE parametros_servicios SET periodo_preinscripcion = 9
WHERE periodo_preinscripcion = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_reinscripcion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_reinscripcion'
END          
GO

UPDATE parametros_servicios SET periodo_mat_inscritas = 9
WHERE periodo_mat_inscritas = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE parametros_reinscripcion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE parametros_reinscripcion'
END          
GO
