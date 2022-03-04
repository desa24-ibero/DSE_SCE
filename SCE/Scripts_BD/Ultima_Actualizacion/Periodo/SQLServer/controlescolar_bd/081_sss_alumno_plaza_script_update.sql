USE controlescolar_bd
GO

UPDATE sss_alumno_plaza SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sss_alumno_plaza'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sss_alumno_plaza'
END          
GO

UPDATE sss_alumno_plaza SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sss_alumno_plaza'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sss_alumno_plaza'
END          
GO

UPDATE sss_alumno_plaza SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sss_alumno_plaza'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sss_alumno_plaza'
END
GO