USE controlescolar_bd
GO

UPDATE alumno_examen_gral_con SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE alumno_examen_gral_con'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE alumno_examen_gral_con'
END          
GO

UPDATE alumno_examen_gral_con SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE alumno_examen_gral_con'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE alumno_examen_gral_con'
END          
GO

UPDATE alumno_examen_gral_con SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE alumno_examen_gral_con'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE alumno_examen_gral_con'
END
GO

DELETE FROM alumno_examen_gral_con
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE alumno_examen_gral_con'
END ELSE BEGIN
	PRINT 'ERROR: DELETE alumno_examen_gral_con'
END
GO