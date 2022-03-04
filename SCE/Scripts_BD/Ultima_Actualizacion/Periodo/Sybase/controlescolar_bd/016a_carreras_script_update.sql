USE controlescolar_bd
GO

UPDATE carreras SET cve_grado = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE carreras'
END          
GO

UPDATE carreras SET nivel = 'T' 
WHERE cve_grado = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE carreras'
END          
GO