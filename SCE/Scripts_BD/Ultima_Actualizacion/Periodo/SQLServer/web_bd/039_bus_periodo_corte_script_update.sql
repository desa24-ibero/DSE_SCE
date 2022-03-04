USE web_bd
GO

UPDATE bus_periodo_corte SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_periodo_corte'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_periodo_corte'
END          
GO

UPDATE bus_periodo_corte SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_periodo_corte'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_periodo_corte'
END          
GO

UPDATE bus_periodo_corte SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_periodo_corte'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_periodo_corte'
END
GO