USE controlescolar_bd
GO

UPDATE hist_acta_evaluacion_transf SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_acta_evaluacion_transf'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_acta_evaluacion_transf'
END          
GO

UPDATE hist_acta_evaluacion_transf SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_acta_evaluacion_transf'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_acta_evaluacion_transf'
END          
GO

UPDATE hist_acta_evaluacion_transf SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_acta_evaluacion_transf'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_acta_evaluacion_transf'
END
GO