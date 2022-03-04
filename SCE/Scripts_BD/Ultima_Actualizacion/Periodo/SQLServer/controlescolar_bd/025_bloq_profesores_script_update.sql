USE controlescolar_bd
GO

UPDATE bloq_profesores SET periodo_inicio = 7 -- CUATRIMESTRE 1
WHERE periodo_inicio = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bloq_profesores'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bloq_profesores'
END          
GO

UPDATE bloq_profesores SET periodo_fin = 7 -- CUATRIMESTRE 1
WHERE periodo_fin = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bloq_profesores'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bloq_profesores'
END          
GO

UPDATE bloq_profesores SET periodo_inicio = 8 -- CUATRIMESTRE 2
WHERE periodo_inicio = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bloq_profesores'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bloq_profesores'
END          
GO

UPDATE bloq_profesores SET periodo_fin = 8 -- CUATRIMESTRE 2
WHERE periodo_fin = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bloq_profesores'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bloq_profesores'
END          
GO

UPDATE bloq_profesores SET periodo_inicio = 9 -- CUATRIMESTRE 3
WHERE periodo_inicio = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bloq_profesores'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bloq_profesores'
END
GO

UPDATE bloq_profesores SET periodo_fin = 9 -- CUATRIMESTRE 3
WHERE periodo_fin = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bloq_profesores'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bloq_profesores'
END
GO