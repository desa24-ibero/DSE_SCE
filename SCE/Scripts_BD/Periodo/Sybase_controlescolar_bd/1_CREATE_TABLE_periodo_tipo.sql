use controlescolar_bd
go

CREATE TABLE periodo_tipo(
id_tipo varchar(3) NOT NULL, 
descripcion varchar(20) NOT NULL, 
PRIMARY KEY (id_tipo ))
go


GRANT select, insert, update, delete on periodo_tipo to g_se_administrador 
go

GRANT select, insert, update, delete on periodo_tipo to g_inf_admin 
go


INSERT INTO periodo_tipo(id_tipo, descripcion)
VALUES('S', 'Semestral')
go





GRANT SELECT ON dbo.periodo_tipo TO g_coordinaciones
GO
GRANT SELECT ON dbo.periodo_tipo TO inscripcion
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_jef_tit_cert
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_tit_cert_ventanilla
GO
GRANT SELECT ON dbo.periodo_tipo TO g_sit_admin
GO
GRANT SELECT ON dbo.periodo_tipo TO g_sfeb_becas
GO
GRANT SELECT ON dbo.periodo_tipo TO g_res_esp_inst
GO
GRANT INSERT ON dbo.periodo_tipo TO g_res_esp_inst
GO
GRANT DELETE ON dbo.periodo_tipo TO g_res_esp_inst
GO
GRANT UPDATE ON dbo.periodo_tipo TO g_res_esp_inst
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_administrador
GO
GRANT INSERT ON dbo.periodo_tipo TO g_se_administrador
GO
GRANT DELETE ON dbo.periodo_tipo TO g_se_administrador
GO
GRANT UPDATE ON dbo.periodo_tipo TO g_se_administrador
GO
GRANT SELECT ON dbo.periodo_tipo TO g_inf_admin
GO
GRANT INSERT ON dbo.periodo_tipo TO g_inf_admin
GO
GRANT DELETE ON dbo.periodo_tipo TO g_inf_admin
GO
GRANT UPDATE ON dbo.periodo_tipo TO g_inf_admin
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_ce_ventanilla
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_ce_atencion
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_jef_admision
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_admision_ventanilla
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_admision_atencion
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_jef_archivo
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_archivo_ventanilla
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_archivo_atencion
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_tit_cert_atencion
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_consultas
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_adse
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_biblioteca
GO
GRANT SELECT ON dbo.periodo_tipo TO g_se_cobranzas
GO
GRANT SELECT ON dbo.periodo_tipo TO g_adm_asistenecia
GO
GRANT SELECT ON dbo.periodo_tipo TO g_sit_supercobtes
GO
GRANT SELECT ON dbo.periodo_tipo TO g_sfeb_superbecas
GO
GRANT SELECT ON dbo.periodo_tipo TO g_DataReader
GO
GRANT SELECT ON dbo.periodo_tipo TO g_directores_cesc
GO
GRANT SELECT ON dbo.periodo_tipo TO g_coordinaciones_trim
GO













