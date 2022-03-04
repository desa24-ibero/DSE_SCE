USE controlescolar_bd
GO

DELETE FROM hist_academicos
WHERE periodo_ing < 7 OR periodo_egre < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM hist_academicos'
END          
GO

UPDATE hist_academicos 
SET a.nivel = c.nivel 
FROM hist_academicos a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T')
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_academicos'
END          
GO