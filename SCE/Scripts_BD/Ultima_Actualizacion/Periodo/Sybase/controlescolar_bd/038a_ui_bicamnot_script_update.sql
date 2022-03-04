USE controlescolar_bd
GO

UPDATE ui_bicamnot SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ui_bicamnot'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ui_bicamnot'
END          
GO

UPDATE ui_bicamnot SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ui_bicamnot'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ui_bicamnot'
END          
GO

UPDATE ui_bicamnot SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE ui_bicamnot'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE ui_bicamnot'
END
GO

DELETE FROM ui_bicamnot
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE ui_bicamnot'
END ELSE BEGIN
	PRINT 'ERROR: DELETE ui_bicamnot'
END
GO