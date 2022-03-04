USE controlescolar_bd
GO

UPDATE periodos_por_procesos SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodos_por_procesos'
END          
GO

UPDATE periodos_por_procesos SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodos_por_procesos'
END          
GO

UPDATE periodos_por_procesos SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodos_por_procesos'
END
GO

DELETE FROM periodos_por_procesos
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: DELETE periodos_por_procesos'
END
GO