USE controlescolar_bd
GO

IF OBJECT_ID ('dbo.v_sce_carrerasdisponibles') IS NOT NULL
	DROP VIEW dbo.v_sce_carrerasdisponibles
GO

CREATE VIEW v_sce_carrerasdisponibles 
(cve_carrera,carrera) AS 
select carreras.cve_carrera, carreras.carrera
from  controlescolar_bd.dbo.carreras carreras
where carreras.activa_1er_ing = 1
and carreras.nivel <>'P'

/*and carreras.nivel ='L'*/

GO



GRANT SELECT ON dbo.v_sce_carrerasdisponibles TO wwwadmision
GO
GRANT SELECT ON dbo.v_sce_carrerasdisponibles TO g_auditoria_interna
GO
GRANT SELECT ON dbo.v_sce_carrerasdisponibles TO g_inf_admin
GO
GRANT SELECT ON dbo.v_sce_carrerasdisponibles TO g_daia_cons
GO
GRANT SELECT ON dbo.v_sce_carrerasdisponibles TO g_DataReader
GO

