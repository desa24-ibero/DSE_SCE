USE controlescolar_bd
GO

UPDATE examen_extrao_titulo SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE examen_extrao_titulo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE examen_extrao_titulo'
END          
GO

UPDATE examen_extrao_titulo SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE examen_extrao_titulo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE examen_extrao_titulo'
END          
GO

UPDATE examen_extrao_titulo SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE examen_extrao_titulo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE examen_extrao_titulo'
END
GO

DELETE FROM examen_extrao_titulo
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE examen_extrao_titulo'
END ELSE BEGIN
	PRINT 'ERROR: DELETE examen_extrao_titulo'
END
GO