USE controlescolar_bd
GO

UPDATE aspirantes_revalidacion SET periodo_ing = 7 -- CUATRIMESTRE 1
WHERE periodo_ing = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE aspirantes_revalidacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE aspirantes_revalidacion'
END          
GO

UPDATE aspirantes_revalidacion SET periodo_ing = 8 -- CUATRIMESTRE 2
WHERE periodo_ing = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE aspirantes_revalidacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE aspirantes_revalidacion'
END          
GO

UPDATE aspirantes_revalidacion SET periodo_ing = 9 -- CUATRIMESTRE 3
WHERE periodo_ing = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE aspirantes_revalidacion'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE aspirantes_revalidacion'
END
GO