USE controlescolar_bd
GO

IF OBJECT_ID ('dbo.v_titulados_licenciatura') IS NOT NULL
	DROP VIEW dbo.v_titulados_licenciatura
GO

CREATE VIEW v_titulados_licenciatura
as
  SELECT cuenta = titulacion.cuenta  
    FROM academicos,   
         titulacion,   
         carreras  
   WHERE ( academicos.cuenta = titulacion.cuenta ) and  
         ( academicos.cve_carrera = titulacion.cve_carrera ) and  
         ( academicos.cve_plan = titulacion.cve_plan ) and  
         ( titulacion.cve_carrera = carreras.cve_carrera ) and  
         ( ( titulacion.aprobado = 1 ) AND  
         ( carreras.nivel <> 'P' ) )
         
         /*( carreras.nivel = 'L' ) )*/
GO




GRANT SELECT ON dbo.v_titulados_licenciatura TO g_coordinaciones
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO inscripcion
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_jef_tit_cert
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_tit_cert_ventanilla
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_sfeb_becas
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_administrador
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_inf_admin
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_ce_ventanilla
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_ce_atencion
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_jef_admision
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_admision_ventanilla
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_admision_atencion
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_jef_archivo
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_archivo_ventanilla
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_archivo_atencion
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_tit_cert_atencion
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_consultas
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_adse
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_biblioteca
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_se_cobranzas
GO
GRANT SELECT ON dbo.v_titulados_licenciatura TO g_DataReader
GO


