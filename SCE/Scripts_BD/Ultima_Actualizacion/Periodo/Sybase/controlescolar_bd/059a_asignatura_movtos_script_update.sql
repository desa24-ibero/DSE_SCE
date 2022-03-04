USE controlescolar_bd
GO

UPDATE asignatura_movtos SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE asignatura_movtos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE asignatura_movtos'
END          
GO

UPDATE asignatura_movtos SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE asignatura_movtos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE asignatura_movtos'
END          
GO

UPDATE asignatura_movtos SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE asignatura_movtos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE asignatura_movtos'
END
GO

DELETE FROM asignatura_movtos
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE asignatura_movtos'
END ELSE BEGIN
	PRINT 'ERROR: DELETE asignatura_movtos'
END
GO