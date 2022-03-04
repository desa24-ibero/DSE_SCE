USE controlescolar_bd
GO

UPDATE academicos2 
SET a.nivel = c.nivel 
FROM academicos2 a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T')
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE academicos2'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE academicos2'
END          
GO
