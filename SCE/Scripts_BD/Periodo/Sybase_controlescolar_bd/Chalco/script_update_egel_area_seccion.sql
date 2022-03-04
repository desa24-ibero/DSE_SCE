USE controlescolar_bd
GO

UPDATE egel_area_seccion SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE egel_area_seccion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE egel_area_seccion'
END          
GO

UPDATE egel_area_seccion SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE egel_area_seccion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE egel_area_seccion'
END          
GO

UPDATE egel_area_seccion SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE egel_area_seccion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE egel_area_seccion'
END
GO