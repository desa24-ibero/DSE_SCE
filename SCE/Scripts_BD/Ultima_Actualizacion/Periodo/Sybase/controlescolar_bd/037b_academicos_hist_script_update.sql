USE controlescolar_bd
GO

DELETE FROM academicos_hist
WHERE periodo_ing < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE academicos_hist'
END          
GO

DELETE FROM academicos_hist
WHERE periodo_egre < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE academicos_hist'
END          
GO

UPDATE academicos_hist 
SET a.nivel = c.nivel 
FROM academicos_hist a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T')
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE academicos_hist'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE academicos_hist'
END          
GO