USE web_bd
GO

UPDATE convocatorias_vigentes SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE convocatorias_vigentes'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE convocatorias_vigentes'
END          
GO

UPDATE convocatorias_vigentes SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE convocatorias_vigentes'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE convocatorias_vigentes'
END          
GO

UPDATE convocatorias_vigentes SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE convocatorias_vigentes'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE convocatorias_vigentes'
END
GO