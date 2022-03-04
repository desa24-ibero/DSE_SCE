USE controlescolar_bd
GO

UPDATE movimiento_prof_aux SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE movimiento_prof_aux'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE movimiento_prof_aux'
END          
GO

UPDATE movimiento_prof_aux SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE movimiento_prof_aux'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE movimiento_prof_aux'
END          
GO

UPDATE movimiento_prof_aux SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE movimiento_prof_aux'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE movimiento_prof_aux'
END
GO