USE controlescolar_bd
GO

DELETE FROM academicos
WHERE periodo_ing < 7 OR periodo_egre < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM academicos'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM academicos'
END          
GO

UPDATE academicos 
SET a.nivel = c.nivel 
FROM academicos a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T')
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE academicos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE academicos'
END          
GO