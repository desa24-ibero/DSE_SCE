USE controlescolar_bd
GO

UPDATE activacion_su SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE activacion_su'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE activacion_su'
END          
GO

UPDATE activacion_su SET bajas_periodo_distinto = 7 -- CUATRIMESTRE 1
WHERE bajas_periodo_distinto = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE activacion_su'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE activacion_su'
END          
GO

UPDATE activacion_su SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE activacion_su'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE activacion_su'
END          
GO

UPDATE activacion_su SET bajas_periodo_distinto = 8 -- CUATRIMESTRE 2
WHERE bajas_periodo_distinto = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE activacion_su'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE activacion_su'
END          
GO

UPDATE activacion_su SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE activacion_su'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE activacion_su'
END
GO

UPDATE activacion_su SET bajas_periodo_distinto = 9 -- CUATRIMESTRE 3
WHERE bajas_periodo_distinto = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE activacion_su'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE activacion_su'
END
GO