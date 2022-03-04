USE controlescolar_bd
GO

UPDATE hist_alumno_acta_evaluacion_pr SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_alumno_acta_evaluacion_pr'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_alumno_acta_evaluacion_pr'
END          
GO

UPDATE hist_alumno_acta_evaluacion_pr SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_alumno_acta_evaluacion_pr'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_alumno_acta_evaluacion_pr'
END          
GO

UPDATE hist_alumno_acta_evaluacion_pr SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_alumno_acta_evaluacion_pr'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_alumno_acta_evaluacion_pr'
END
GO