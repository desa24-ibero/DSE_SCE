USE controlescolar_bd
GO

UPDATE sagi_materias_combinacion SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sagi_materias_combinacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sagi_materias_combinacion'
END          
GO

UPDATE sagi_materias_combinacion SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sagi_materias_combinacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sagi_materias_combinacion'
END          
GO

UPDATE sagi_materias_combinacion SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sagi_materias_combinacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sagi_materias_combinacion'
END
GO