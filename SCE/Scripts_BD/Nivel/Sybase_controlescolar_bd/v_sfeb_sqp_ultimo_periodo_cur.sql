IF OBJECT_ID ('dbo.v_sfeb_sqp_ultimo_periodo_cur') IS NOT NULL
	DROP VIEW dbo.v_sfeb_sqp_ultimo_periodo_cur
GO

CREATE VIEW v_sfeb_sqp_ultimo_periodo_cur
AS
	select distinct cuenta =a.cuenta,  anio = a.anio  , 
			periodo = (select max(b.periodo) from sfeb_sqp_historico b where b.cuenta =  a.cuenta and  b.anio = a.anio )
	from sfeb_sqp_historico a inner join materias on a.cve_mat = materias.cve_mat
		inner join carreras on a.cve_carrera = carreras.cve_carrera  and carreras.nivel <> 'P' 
	where materias.creditos >0
	group by a.cuenta
	having anio = max(a.anio)
	
/*inner join carreras on a.cve_carrera = carreras.cve_carrera  and carreras.nivel = 'L'*/	
	
GO


GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_informes
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_tesoreria
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_cobranza
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_admin
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_becas
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_monelesit
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_rectoria
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sfeb_becas
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sfeb_rectoria
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_inf_admin
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_biblio
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_sit_consulta
GO
GRANT SELECT ON dbo.v_sfeb_sqp_ultimo_periodo_cur TO g_DataReader
GO

