USE controlescolar_bd
GO

UPDATE materias 
SET nivel = ISNULL((
SELECT DISTINCT c.nivel
FROM carreras c, mat_prerrequisito p
WHERE p.cve_carrera = c.cve_carrera 
AND p.cve_mat = materias.cve_mat  
AND c.nivel IN('T')) , nivel) 
WHERE materias.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE materias'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE materias'
END          
GO