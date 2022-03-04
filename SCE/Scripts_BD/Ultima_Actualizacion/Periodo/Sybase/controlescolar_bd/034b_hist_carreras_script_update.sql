USE controlescolar_bd
GO

DELETE FROM hist_carreras
WHERE periodo_ing < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END          
GO

DELETE FROM hist_carreras
WHERE periodo_egre_ant < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END          
GO

DELETE FROM hist_carreras
WHERE periodo_ing_act < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras'
END          
GO

UPDATE hist_carreras 
SET nivel_ant = (SELECT nivel FROM carreras WHERE nivel IN('T') 
				AND carreras.cve_carrera = hist_carreras.cve_carrera_ant ) 
WHERE cve_carrera_ant IN(SELECT cve_carrera FROM carreras WHERE nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras 1'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras 1'
END          
GO


UPDATE hist_carreras 
SET nivel_act = (SELECT nivel FROM carreras WHERE nivel IN('T') 
				AND carreras.cve_carrera = hist_carreras.cve_carrera_act ) 
WHERE cve_carrera_act IN(SELECT cve_carrera FROM carreras WHERE nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE hist_carreras 2'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE hist_carreras 2'
END          
GO