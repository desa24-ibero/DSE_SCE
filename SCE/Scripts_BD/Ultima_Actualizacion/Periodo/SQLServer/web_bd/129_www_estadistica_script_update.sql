USE web_bd
GO

UPDATE www_estadistica SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE www_estadistica'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE www_estadistica'
END          
GO

UPDATE www_estadistica SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE www_estadistica'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE www_estadistica'
END          
GO

UPDATE www_estadistica SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE www_estadistica'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE www_estadistica'
END
GO
