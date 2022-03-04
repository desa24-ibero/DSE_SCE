USE controlescolar_bd
GO

UPDATE sagi_alumnos_carrera SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sagi_alumnos_carrera'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sagi_alumnos_carrera'
END          
GO

UPDATE sagi_alumnos_carrera SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sagi_alumnos_carrera'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sagi_alumnos_carrera'
END          
GO

UPDATE sagi_alumnos_carrera SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sagi_alumnos_carrera'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sagi_alumnos_carrera'
END
GO

DELETE FROM sagi_alumnos_carrera
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE sagi_alumnos_carrera'
END ELSE BEGIN
	PRINT 'ERROR: DELETE sagi_alumnos_carrera'
END
GO