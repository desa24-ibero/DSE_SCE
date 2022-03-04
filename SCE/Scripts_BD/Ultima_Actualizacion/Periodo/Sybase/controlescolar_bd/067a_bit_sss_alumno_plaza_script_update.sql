USE controlescolar_bd
GO

UPDATE bit_sss_alumno_plaza SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_sss_alumno_plaza'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_sss_alumno_plaza'
END          
GO

UPDATE bit_sss_alumno_plaza SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_sss_alumno_plaza'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_sss_alumno_plaza'
END          
GO

UPDATE bit_sss_alumno_plaza SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_sss_alumno_plaza'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_sss_alumno_plaza'
END
GO

DELETE FROM bit_sss_alumno_plaza
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE bit_sss_alumno_plaza'
END ELSE BEGIN
	PRINT 'ERROR: DELETE bit_sss_alumno_plaza'
END
GO