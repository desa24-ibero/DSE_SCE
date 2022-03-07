USE controlescolar_bd
GO

UPDATE sg_mat_preinsc SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_mat_preinsc'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_mat_preinsc'
END          
GO

UPDATE sg_mat_preinsc SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_mat_preinsc'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_mat_preinsc'
END          
GO

UPDATE sg_mat_preinsc SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_mat_preinsc'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_mat_preinsc'
END
GO

DELETE FROM sg_mat_preinsc
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE sg_mat_preinsc'
END ELSE BEGIN
	PRINT 'ERROR: DELETE sg_mat_preinsc'
END
GO