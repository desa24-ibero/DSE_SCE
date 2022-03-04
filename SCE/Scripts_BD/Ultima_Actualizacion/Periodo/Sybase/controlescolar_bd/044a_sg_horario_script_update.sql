USE controlescolar_bd
GO

UPDATE sg_horario SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_horario'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_horario'
END          
GO

UPDATE sg_horario SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_horario'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_horario'
END          
GO

UPDATE sg_horario SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_horario'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_horario'
END
GO

DELETE FROM sg_horario
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE sg_horario'
END ELSE BEGIN
	PRINT 'ERROR: DELETE sg_horario'
END
GO