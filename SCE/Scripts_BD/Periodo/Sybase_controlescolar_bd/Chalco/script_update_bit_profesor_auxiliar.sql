USE controlescolar_bd
GO

UPDATE bit_profesor_auxiliar SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_profesor_auxiliar'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_profesor_auxiliar'
END          
GO

UPDATE bit_profesor_auxiliar SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_profesor_auxiliar'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_profesor_auxiliar'
END          
GO

UPDATE bit_profesor_auxiliar SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_profesor_auxiliar'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_profesor_auxiliar'
END
GO