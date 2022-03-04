USE controlescolar_bd
GO

DELETE FROM academicos_cambio_carrera
WHERE periodo_ing < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE academicos_cambio_carrera'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE academicos_cambio_carrera'
END          
GO

UPDATE academicos_cambio_carrera 
SET a.nivel = c.nivel 
FROM academicos_cambio_carrera a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T')
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE academicos_cambio_carrera'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE academicos_cambio_carrera'
END          
GO