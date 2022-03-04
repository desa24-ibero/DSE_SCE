USE web_bd
GO

UPDATE se3_sepe2_alumnos_faltas SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE se3_sepe2_alumnos_faltas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE se3_sepe2_alumnos_faltas'
END          
GO

UPDATE se3_sepe2_alumnos_faltas SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE se3_sepe2_alumnos_faltas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE se3_sepe2_alumnos_faltas'
END          
GO

UPDATE se3_sepe2_alumnos_faltas SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE se3_sepe2_alumnos_faltas'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE se3_sepe2_alumnos_faltas'
END
GO
