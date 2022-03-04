

USE controlescolar_bd
go

CREATE TABLE nivel_constancia(
cve_nivel char(1) not null, 
cve_carrera integer not null, 
descripcion_constancia varchar(20) null, 
descripcion_constancia2 varchar(20) null, 
descripcion_constancia3 varchar(20) null, 
descripcion_constancia4 varchar(20) null, 
PRIMARY KEY(cve_nivel, cve_carrera)
)
go 

GRANT select, insert, update, delete on nivel_constancia to g_se_administrador 
go 

GRANT select, insert, update, delete on nivel_constancia to g_inf_admin 
go 



INSERT INTO nivel_constancia(cve_nivel, cve_carrera, descripcion_constancia, descripcion_constancia2, descripcion_constancia3, descripcion_constancia4)
SELECT nivel, cve_carrera, 
CASE nivel WHEN 'L' THEN 'Licenciatura' ELSE 'Posgrado' end, 
CASE nivel WHEN 'L' THEN 'en' ELSE 'en' end, 
CASE nivel WHEN 'L' THEN 'a la' ELSE 'al' END , 
CASE nivel WHEN 'L' THEN 'de la' ELSE 'del' END 
FROM carreras
WHERE cve_carrera in(SELECT cve_carrera from academicos where cuenta in(SELECT cuenta from mat_inscritas))
go




GRANT SELECT ON dbo.nivel_constancia TO g_coordinaciones
GO
GRANT SELECT ON dbo.nivel_constancia TO inscripcion
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_jef_tit_cert
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_tit_cert_ventanilla
GO
GRANT SELECT ON dbo.nivel_constancia TO g_sfeb_becas
GO
GRANT SELECT ON dbo.nivel_constancia TO g_auditoria_interna
GO
GRANT SELECT, INSERT, DELETE, UPDATE ON dbo.nivel_constancia TO g_se_administrador
GO
GRANT SELECT, INSERT, DELETE, UPDATE ON dbo.nivel_constancia TO g_inf_admin
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_ce_ventanilla
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_ce_atencion
GO
GRANT SELECT, INSERT, DELETE, UPDATE ON dbo.nivel_constancia TO g_se_jef_admision
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_admision_ventanilla
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_admision_atencion
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_jef_archivo
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_archivo_ventanilla
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_archivo_atencion
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_tit_cert_atencion
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_consultas
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_adse
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_biblioteca
GO
GRANT SELECT ON dbo.nivel_constancia TO g_se_cobranzas
GO
GRANT SELECT ON dbo.nivel_constancia TO g_DataReader
GO



