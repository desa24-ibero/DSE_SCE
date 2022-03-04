USE controlescolar_bd
GO

DELETE FROM bit_academicos_hist
WHERE periodo_ing < 7 OR periodo_egre < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_academicos_hist'
END          
GO

UPDATE bit_academicos_hist 
SET a.nivel = c.nivel 
FROM bit_academicos_hist a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T')
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_academicos_hist'
END          
GO