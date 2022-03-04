


UPDATE carreras SET nivel = 'T' WHERE cve_grado = 'T'
go

UPDATE carreras SET nivel = 'U' WHERE cve_grado = 'U' 
go


UPDATE academicos 
SET a.nivel = c.nivel 
FROM academicos a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T','U')
GO 


UPDATE academicos2 
SET a.nivel = c.nivel 
FROM academicos2 a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T','U')
GO 

UPDATE academicos_cambio_carrera 
SET a.nivel = c.nivel 
FROM academicos_cambio_carrera a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T','U')
GO 



UPDATE academicos_hist 
SET a.nivel = c.nivel 
FROM academicos_hist a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T','U')
GO 


UPDATE materias 
SET nivel = ISNULL((
SELECT DISTINCT c.nivel
FROM carreras c, mat_prerrequisito p
WHERE p.cve_carrera = c.cve_carrera 
AND p.cve_mat = materias.cve_mat  
AND c.nivel IN('T', 'U')) , nivel) 
WHERE materias.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 


/*Agregar UPDATE DE MATERIAS DE POSGRADO*/  

UPDATE acta_evaluacion_preeliminar 
SET a.nivel = m.nivel 
FROM acta_evaluacion_preeliminar a, materias m 
WHERE a.cve_mat = m.cve_mat 
GO 



UPDATE acta_evaluacion_transf 
SET a.nivel = m.nivel 
FROM acta_evaluacion_transf a, materias m 
WHERE a.cve_mat = m.cve_mat 
GO 


UPDATE alumno_acta_evaluacion_preelim 
SET a.nivel = m.nivel 
FROM alumno_acta_evaluacion_preelim a, materias m 
WHERE a.cve_mat = m.cve_mat 
AND m.nivel IN('U', 'T')
GO 

UPDATE alumno_acta_evaluacion_transf 
SET a.nivel = m.nivel 
FROM alumno_acta_evaluacion_transf a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND m.nivel IN('U', 'T')
GO 



UPDATE bit_academicos_hist 
SET a.nivel = c.nivel 
FROM bit_academicos_hist a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T','U')
GO 


UPDATE bit_acta_evaluacion_preelim 
SET a.nivel = m.nivel 
FROM bit_acta_evaluacion_preelim a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.nivel <> 'P'
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
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
						AND carreras.nivel IN('T', 'U') )
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
						AND carreras.nivel IN('T', 'U') )
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
						AND carreras.nivel IN('T', 'U') )
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
						AND carreras.nivel IN('T', 'U') )
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
						AND carreras.nivel IN('T', 'U') )
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
						AND carreras.nivel IN('T', 'U') )
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
						AND carreras.nivel IN('T', 'U') )
GO 

/**/

UPDATE carreras_guias_adse 
SET nivel = (SELECT nivel FROM carreras WHERE nivel IN('T','U') 
				AND carreras.cve_carrera = carreras_guias_adse.cve_carrera ) 
WHERE cve_carrera IN(SELECT cve_carrera FROM carreras WHERE nivel IN('T','U') )
GO 



UPDATE hist_academicos 
SET a.nivel = c.nivel 
FROM hist_academicos a, carreras c 
WHERE a.cve_carrera = c.cve_carrera 
AND c.nivel IN('T','U')
GO 



UPDATE hist_acta_evaluacion_pre 
SET a.nivel = m.nivel 
FROM hist_acta_evaluacion_pre a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 



UPDATE hist_acta_evaluacion_transf 
SET a.nivel = m.nivel 
FROM hist_acta_evaluacion_transf a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 



UPDATE hist_alumno_acta_evaluacion_pr 
SET a.nivel = m.nivel 
FROM hist_alumno_acta_evaluacion_pr a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 



UPDATE hist_alumno_acta_evaluacion_tr 
SET a.nivel = m.nivel 
FROM hist_alumno_acta_evaluacion_tr a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 




UPDATE hist_carreras 
SET nivel_ant = (SELECT nivel FROM carreras WHERE nivel IN('T','U') 
				AND carreras.cve_carrera = hist_carreras.cve_carrera_ant ) 
WHERE cve_carrera_ant IN(SELECT cve_carrera FROM carreras WHERE nivel IN('T','U') )
GO 


UPDATE hist_carreras 
SET nivel_act = (SELECT nivel FROM carreras WHERE nivel IN('T','U') 
				AND carreras.cve_carrera = hist_carreras.cve_carrera_act ) 
WHERE cve_carrera_act IN(SELECT cve_carrera FROM carreras WHERE nivel IN('T','U') )
GO 



UPDATE no_academicos_hist 
SET nivel = (SELECT nivel FROM carreras WHERE carreras.cve_carrera = no_academicos_hist.cve_carrera)



UPDATE sg_nuevos_grupos 
SET a.nivel = m.nivel 
FROM sg_nuevos_grupos a, materias m  
WHERE a.cve_mat = m.cve_mat 
AND a.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 








