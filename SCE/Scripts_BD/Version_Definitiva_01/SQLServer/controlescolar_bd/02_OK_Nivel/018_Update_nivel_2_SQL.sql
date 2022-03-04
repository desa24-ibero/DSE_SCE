
USE controlescolar_bd 
GO 


UPDATE carreras SET nivel = 'T' WHERE cve_grado = 'T'
go

UPDATE carreras SET nivel = 'U' WHERE cve_grado = 'U' 
go


UPDATE academicos 
SET nivel = c.nivel 
FROM academicos, carreras c 
WHERE academicos.cve_carrera = c.cve_carrera 
AND c.nivel IN('T','U')
GO 

UPDATE academicos_hist 
SET academicos_hist.nivel = c.nivel 
FROM academicos_hist, carreras c 
WHERE academicos_hist.cve_carrera = c.cve_carrera 
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


UPDATE acta_evaluacion_preeliminar 
SET acta_evaluacion_preeliminar.nivel = m.nivel 
FROM acta_evaluacion_preeliminar, materias m 
WHERE acta_evaluacion_preeliminar.cve_mat = m.cve_mat 
AND m.nivel in('T','U')
GO 

UPDATE acta_evaluacion_transf 
SET acta_evaluacion_transf.nivel = m.nivel 
FROM acta_evaluacion_transf , materias m 
WHERE acta_evaluacion_transf.cve_mat = m.cve_mat 
AND m.nivel in('T','U')
GO 

UPDATE alumno_acta_evaluacion_preelim 
SET alumno_acta_evaluacion_preelim.nivel = m.nivel 
FROM alumno_acta_evaluacion_preelim , materias m 
WHERE alumno_acta_evaluacion_preelim.cve_mat = m.cve_mat 
AND m.nivel in('T','U')
GO 


UPDATE alumno_acta_evaluacion_transf 
SET alumno_acta_evaluacion_transf.nivel = m.nivel 
FROM alumno_acta_evaluacion_transf , materias m  
WHERE alumno_acta_evaluacion_transf.cve_mat = m.cve_mat 
AND m.nivel in('T','U')
GO 


UPDATE bit_acta_evaluacion_preelim 
SET bit_acta_evaluacion_preelim.nivel = m.nivel 
FROM bit_acta_evaluacion_preelim, materias m  
WHERE bit_acta_evaluacion_preelim.cve_mat = m.cve_mat 
AND bit_acta_evaluacion_preelim.nivel <> 'P'
AND bit_acta_evaluacion_preelim.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 


UPDATE bit_alumno_acta_evaluacion_pre 
SET bit_alumno_acta_evaluacion_pre.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre, materias m  
WHERE bit_alumno_acta_evaluacion_pre.cve_mat = m.cve_mat 
AND bit_alumno_acta_evaluacion_pre.nivel <> 'P' 
AND bit_alumno_acta_evaluacion_pre.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
AND bit_alumno_acta_evaluacion_pre.anio IN(2010, 2011)
GO 

UPDATE bit_alumno_acta_evaluacion_pre 
SET bit_alumno_acta_evaluacion_pre.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre, materias m  
WHERE bit_alumno_acta_evaluacion_pre.cve_mat = m.cve_mat 
AND bit_alumno_acta_evaluacion_pre.nivel <> 'P' 
AND bit_alumno_acta_evaluacion_pre.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
AND bit_alumno_acta_evaluacion_pre.anio IN(2012, 2013)
GO 


UPDATE bit_alumno_acta_evaluacion_pre 
SET bit_alumno_acta_evaluacion_pre.nivel = m.nivel 
FROM bit_alumno_acta_evaluacion_pre, materias m  
WHERE bit_alumno_acta_evaluacion_pre.cve_mat = m.cve_mat 
AND bit_alumno_acta_evaluacion_pre.nivel <> 'P' 
AND bit_alumno_acta_evaluacion_pre.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
AND bit_alumno_acta_evaluacion_pre.anio IN(2014, 2015, 2016)
GO 



UPDATE hist_acta_evaluacion_pre 
SET hist_acta_evaluacion_pre.nivel = m.nivel 
FROM hist_acta_evaluacion_pre, materias m  
WHERE hist_acta_evaluacion_pre.cve_mat = m.cve_mat 
AND hist_acta_evaluacion_pre.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 



UPDATE hist_acta_evaluacion_transf 
SET hist_acta_evaluacion_transf.nivel = m.nivel 
FROM hist_acta_evaluacion_transf, materias m  
WHERE hist_acta_evaluacion_transf.cve_mat = m.cve_mat 
AND hist_acta_evaluacion_transf.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 




UPDATE hist_alumno_acta_evaluacion_pr 
SET hist_alumno_acta_evaluacion_pr.nivel = m.nivel 
FROM hist_alumno_acta_evaluacion_pr , materias m  
WHERE hist_alumno_acta_evaluacion_pr.cve_mat = m.cve_mat 
AND hist_alumno_acta_evaluacion_pr.cve_mat IN(SELECT cve_mat 
						FROM mat_prerrequisito, carreras 
						WHERE mat_prerrequisito.cve_carrera = carreras.cve_carrera
						AND carreras.nivel IN('T', 'U') )
GO 



UPDATE hist_alumno_acta_evaluacion_tr 
SET hist_alumno_acta_evaluacion_tr.nivel = m.nivel 
FROM hist_alumno_acta_evaluacion_tr, materias m  
WHERE hist_alumno_acta_evaluacion_tr.cve_mat = m.cve_mat 
AND hist_alumno_acta_evaluacion_tr.cve_mat IN(SELECT cve_mat 
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



--SELECT * FROM academicos
--SELECT * FROM academicos_hist
--SELECT * FROM acta_evaluacion_preeliminar
--SELECT * FROM acta_evaluacion_transf
--***SELECT * FROM activacion
--***SELECT * FROM activacion_su
--SELECT * FROM alumno_acta_evaluacion_preelim
--SELECT * FROM alumno_acta_evaluacion_transf
--SELECT * FROM bit_acta_evaluacion_preelim
--SELECT COUNT(*) FROM bit_alumno_acta_evaluacion_pre
--SELECT * FROM carreras
--**SELECT * FROM carreras_transfer
--SELECT * FROM hist_acta_evaluacion_pre
--SELECT * FROM hist_acta_evaluacion_transf
--SELECT * FROM hist_alumno_acta_evaluacion_pr
--SELECT * FROM hist_alumno_acta_evaluacion_tr
--SELECT * FROM hist_carreras
--SELECT * FROM hist_carreras
--SELECT * FROM materias
--**SELECT * FROM materias_optativas
--SELECT * FROM nivel
--SELECT * FROM nivel
--***SELECT * FROM profesor
--***SELECT * FROM prueba 
--******-*SELECT * FROM websce.prueba_preinsc     EXEC SP_HELP prueba_preinsc
--**SELECT * FROM salon
--SELECT * FROM v_captura_actas
--SELECT * FROM v_captura_actas
--SELECT * FROM v_carreras
--SELECT * FROM v_materias
--SELECT * FROM v_revision_de_estudios
--SELECT * FROM v_sce_carreras_cursadas
--SELECT * FROM v_sce_coordinacion_nivel
--SELECT * FROM v_www_profesor 



--SELECT  sysobjects.name, *
--	FROM       sysobjects , syscolumns 
--	WHERE     (UPPER(syscolumns.name) like upper('%NIVEL%')) 
--	AND sysobjects.id = syscolumns.id 
--	ORDER BY sysobjects.name, syscolumns.colid



