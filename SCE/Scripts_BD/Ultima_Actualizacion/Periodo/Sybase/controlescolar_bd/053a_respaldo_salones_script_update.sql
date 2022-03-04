USE controlescolar_bd
GO

UPDATE respaldo_salones SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE respaldo_salones'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE respaldo_salones'
END          
GO

UPDATE respaldo_salones SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE respaldo_salones'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE respaldo_salones'
END          
GO

UPDATE respaldo_salones SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE respaldo_salones'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE respaldo_salones'
END
GO

DELETE FROM respaldo_salones
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE respaldo_salones'
END ELSE BEGIN
	PRINT 'ERROR: DELETE respaldo_salones'
END
GO