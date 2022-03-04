USE controlescolar_bd
GO

DELETE FROM bit_alumno_acta_evaluacion_pre
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre'
END          
GO

/**/
UPDATE bit_alumno_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P' 
AND anio = 2010
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre 2010'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre 2010'
END          
GO

UPDATE bit_alumno_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P' 
AND anio = 2011
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre 2011'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre 2011'
END          
GO


UPDATE bit_alumno_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P' 
AND anio = 2012
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre 2012'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre 2012'
END          
GO


UPDATE bit_alumno_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P' 
AND anio = 2013
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre 2013'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre 2013'
END          
GO


UPDATE bit_alumno_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P' 
AND anio = 2014
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre 2014'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre 2014'
END          
GO


UPDATE bit_alumno_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P' 
AND anio = 2015
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre 2015'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre 2015'
END          
GO


UPDATE bit_alumno_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P' 
AND anio = 2016
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 


IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE bit_alumno_acta_evaluacion_pre 2016'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE bit_alumno_acta_evaluacion_pre 2016'
END          
GO
