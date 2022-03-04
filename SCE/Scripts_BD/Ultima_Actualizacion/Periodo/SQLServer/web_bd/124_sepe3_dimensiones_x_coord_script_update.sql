USE web_bd
GO

UPDATE sepe3_dimensiones_x_coord SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sepe3_dimensiones_x_coord'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sepe3_dimensiones_x_coord'
END          
GO

UPDATE sepe3_dimensiones_x_coord SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sepe3_dimensiones_x_coord'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sepe3_dimensiones_x_coord'
END          
GO

UPDATE sepe3_dimensiones_x_coord SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sepe3_dimensiones_x_coord'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sepe3_dimensiones_x_coord'
END
GO
