USE web_bd
GO

UPDATE bus_detalle_consolidado SET periodo_genera = 7 -- CUATRIMESTRE 1
WHERE periodo_genera = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_detalle_consolidado'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_detalle_consolidado'
END          
GO

UPDATE bus_detalle_consolidado SET periodo_procesa = 7 -- CUATRIMESTRE 1
WHERE periodo_procesa = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_detalle_consolidado'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_detalle_consolidado'
END          
GO

UPDATE bus_detalle_consolidado SET periodo_genera = 8 -- CUATRIMESTRE 2
WHERE periodo_genera = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_detalle_consolidado'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_detalle_consolidado'
END          
GO

UPDATE bus_detalle_consolidado SET periodo_procesa = 8 -- CUATRIMESTRE 2
WHERE periodo_procesa = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_detalle_consolidado'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_detalle_consolidado'
END          
GO

UPDATE bus_detalle_consolidado SET periodo_genera = 9 -- CUATRIMESTRE 3
WHERE periodo_genera = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_detalle_consolidado'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_detalle_consolidado'
END
GO

UPDATE bus_detalle_consolidado SET periodo_procesa = 9 -- CUATRIMESTRE 3
WHERE periodo_procesa = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bus_detalle_consolidado'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bus_detalle_consolidado'
END
GO