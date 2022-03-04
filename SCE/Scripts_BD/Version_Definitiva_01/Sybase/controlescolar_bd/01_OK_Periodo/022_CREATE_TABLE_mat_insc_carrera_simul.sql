USE controlescolar_bd
go

CREATE TABLE mat_insc_carrera_simul(
cuenta INTEGER NOT NULL, 
cve_mat INTEGER NOT NULL, 
gpo VARCHAR(2) NOT NULL,  
periodo tipo_periodo NOT NULL,  
anio tipo_anio NOT NULL,  
cve_carrera	INTEGER NOT NULL,  
cve_plan INTEGER NOT NULL, 
cve_condicion INTEGER NOT NULL, 
PRIMARY KEY (cuenta, cve_mat, gpo, periodo, anio, cve_carrera, cve_plan)) 
GO 



GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_coordinaciones
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO inscripcion
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_jef_tit_cert
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_tit_cert_ventanilla
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_sfeb_becas
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_auditoria_interna
GO
GRANT SELECT, INSERT, DELETE, UPDATE ON dbo.mat_insc_carrera_simul TO g_se_administrador
GO
GRANT SELECT, INSERT, DELETE, UPDATE ON dbo.mat_insc_carrera_simul TO g_inf_admin
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_ce_ventanilla
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_ce_atencion
GO
GRANT SELECT, INSERT, DELETE, UPDATE ON dbo.mat_insc_carrera_simul TO g_se_jef_admision
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_admision_ventanilla
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_admision_atencion
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_jef_archivo
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_archivo_ventanilla
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_archivo_atencion
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_tit_cert_atencion
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_consultas
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_adse
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_biblioteca
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_se_cobranzas
GO
GRANT SELECT ON dbo.mat_insc_carrera_simul TO g_DataReader
GO
