USE controlescolar_bd
GO

DELETE FROM sg_nuevos_grupos
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_nuevos_grupos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_nuevos_grupos'
END
GO

UPDATE sg_nuevos_grupos 
SET a.nivel = m.nivel 
FROM sg_nuevos_grupos a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T'))
GO 

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE sg_nuevos_grupos'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE sg_nuevos_grupos'
END
GO