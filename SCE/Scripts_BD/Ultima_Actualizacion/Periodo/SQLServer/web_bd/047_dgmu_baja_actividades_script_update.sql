USE web_bd
GO

UPDATE dgmu_baja_actividades SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE dgmu_baja_actividades'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE dgmu_baja_actividades'
END          
GO

UPDATE dgmu_baja_actividades SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE dgmu_baja_actividades'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE dgmu_baja_actividades'
END          
GO

UPDATE dgmu_baja_actividades SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE dgmu_baja_actividades'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE dgmu_baja_actividades'
END
GO