USE controlescolar_bd
GO

UPDATE periodos_por_procesos SET tipo_periodo = 'Q'
WHERE tipo_periodo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodos_por_procesos'
END          
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
