USE controlescolar_bd
go



ALTER VIEW [dbo].[v_sfeb_sqp_ultimo_periodo_cur]
AS
	select cuenta =a.cuenta, anio = (select max(b.anio) from sfeb_sqp_historico b where b.cuenta =  a.cuenta  ), 
			periodo = (select max(b.periodo) from sfeb_sqp_historico b where b.cuenta =  a.cuenta and  b.anio = (select max(b.anio) from sfeb_sqp_historico b where b.cuenta =  a.cuenta  ) )
	from sfeb_sqp_historico a inner join materias on a.cve_mat = materias.cve_mat
		inner join carreras on a.cve_carrera = carreras.cve_carrera  and carreras.nivel <> 'P'
	where materias.creditos > 0
	group by a.cuenta


GO 





