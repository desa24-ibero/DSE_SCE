USE controlescolar_bd
GO

UPDATE bit_periodos_por_procesos SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_periodos_por_procesos'
END          
GO

UPDATE bit_periodos_por_procesos SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_periodos_por_procesos'
END          
GO

UPDATE bit_periodos_por_procesos SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_periodos_por_procesos'
END
GO

DELETE FROM bit_periodos_por_procesos
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE bit_periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: DELETE bit_periodos_por_procesos'
END
GO