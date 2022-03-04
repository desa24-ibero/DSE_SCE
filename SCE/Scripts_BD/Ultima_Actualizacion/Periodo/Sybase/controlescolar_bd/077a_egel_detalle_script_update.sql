USE controlescolar_bd
GO

UPDATE egel_detalle SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE egel_detalle'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE egel_detalle'
END          
GO

UPDATE egel_detalle SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE egel_detalle'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE egel_detalle'
END          
GO

UPDATE egel_detalle SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE egel_detalle'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE egel_detalle'
END
GO

DELETE FROM egel_detalle
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE egel_detalle'
END ELSE BEGIN
	PRINT 'ERROR: DELETE egel_detalle'
END
GO