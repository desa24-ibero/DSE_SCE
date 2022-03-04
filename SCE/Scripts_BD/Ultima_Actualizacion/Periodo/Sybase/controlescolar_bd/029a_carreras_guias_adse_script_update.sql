USE controlescolar_bd
GO

UPDATE carreras_guias_adse 
SET nivel = (SELECT nivel FROM carreras WHERE nivel IN('T') 
				AND carreras.cve_carrera = carreras_guias_adse.cve_carrera ) 
WHERE cve_carrera IN(SELECT cve_carrera FROM carreras WHERE nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE carreras_guias_adse'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE carreras_guias_adse'
END          
GO