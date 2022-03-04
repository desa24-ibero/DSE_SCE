USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_sepe3_det]    Script Date: 27/9/2017 13:26:58 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_sepe3_det]	
	@anio int,
	@periodo int,
	@cve_prof int,
	@cve_coord int
as

create table #tmp_dets(
cve_mat int,
materia text collate SQL_Latin1_General_CP1_CI_AS,
gpo varchar(5) collate SQL_Latin1_General_CP1_CI_AS,
inscritos int,
sepe float,
pct_asist float,
pct_rets float,
prom_alum float,
pct_reps float,
pct_ba float)

insert into #tmp_dets
Select	e.cve_mat,
		e.materia,
		g.gpo,
		isnull(g.inscritos + isnull(insc_desp_bajas, 0), 0) as inscritos,
		p.prom_prof,
		0,
		0,
		0,
		0,
		0
from	ec_hist_grupos g
		inner join v_ec_depto_coord_mat e on  (g.cve_mat = e.cve_mat)
		left join ec_prom_mat p on (g.anio = p.anio and
									g.periodo = p.periodo and
									g.cve_mat = p.cve_mat and
									g.gpo = p.gpo COLLATE Latin1_General_CI_AI)
where	
		g.anio = @anio and
		g.periodo = @periodo and
		g.cve_profesor = @cve_prof and
		e.cve_coordinacion = @cve_coord

-- Asistencias y retardos
create table #tmp_tot(
cve_mat int,
gpo	varchar(5) collate SQL_Latin1_General_CP1_CI_AS,
total float,
asist float,
rets float)

insert into #tmp_tot
select	l.cve_mat,
		l.gpo,
		count(cve_asistencia),
		0,
		0
from	controlescolar_bd.dbo.profesor_lista_asistencia l,
		v_ec_depto_coord_mat e
where	l.cve_mat = e.cve_mat and
		l.anio = @anio and
		l.periodo = @periodo and
		e.cve_coordinacion = @cve_coord and
		l.cve_profesor = @cve_prof
group by l.cve_mat, l.gpo

create table #tmp_tot_asis(
cve_mat int,
gpo	varchar(5) collate SQL_Latin1_General_CP1_CI_AS,
asist float)

insert into #tmp_tot_asis
select	l.cve_mat,
		l.gpo,
		count(cve_asistencia)
from	controlescolar_bd.dbo.profesor_lista_asistencia l,
		v_ec_depto_coord_mat e
where	l.cve_mat = e.cve_mat and
		l.cve_asistencia between 1 and 6 and
		l.anio = @anio and
		l.periodo = @periodo and
		e.cve_coordinacion = @cve_coord and
		l.cve_profesor = @cve_prof
group by l.cve_mat, l.gpo


update	#tmp_tot
set		asist = t.asist
from	#tmp_tot_asis t
where	t.cve_mat = #tmp_tot.cve_mat and
		t.gpo = #tmp_tot.gpo

delete from #tmp_tot_asis

insert into #tmp_tot_asis
select	l.cve_mat,
		l.gpo,
		count(cve_asistencia)
from	controlescolar_bd.dbo.profesor_lista_asistencia l,
		v_ec_depto_coord_mat e
where	l.cve_mat = e.cve_mat and
		l.cve_asistencia = 7 and
		l.anio = @anio and
		l.periodo = @periodo and
		e.cve_coordinacion = @cve_coord and
		l.cve_profesor = @cve_prof
group by l.cve_mat, l.gpo

update	#tmp_tot
set		rets = t.asist
from	#tmp_tot_asis t
where	t.cve_mat = #tmp_tot.cve_mat and
		t.gpo = #tmp_tot.gpo

update	#tmp_dets 
set		pct_asist = t.asist / t.total *100,
		pct_rets = t.rets / t.total *100
from	#tmp_tot t
where	t.cve_mat = #tmp_dets.cve_mat and
		t.gpo = #tmp_dets.gpo

drop table #tmp_tot
drop table #tmp_tot_asis

-- % reprobados y bajas
create table #tmp_tot_cal(
cve_mat int,
gpo	varchar(5) collate SQL_Latin1_General_CP1_CI_AS,
total float,
promedio float,
reps float,
bas float)

insert into #tmp_tot_cal
select	l.cve_mat,
		l.gpo,
		count(l.calificacion) as total,
		(select	sum(convert(float, h.calificacion)) / count(h.calificacion) from v_www_historico h where isnumeric(h.calificacion) = 1 and h.anio = l.anio and h.periodo = l.periodo and h.cve_mat = l.cve_mat and h.gpo = g.gpo COLLATE Latin1_General_CI_AI group by h.anio, h.periodo, h.cve_mat, h.gpo),
		0,
		0
from	v_www_historico l,
		v_ec_depto_coord_mat e,
		ec_hist_grupos g
where	l.anio = g.anio and
		l.periodo = g.periodo and
		l.cve_mat = g.cve_mat and
		l.gpo = g.gpo COLLATE Latin1_General_CI_AI and
		l.cve_mat = e.cve_mat and
		l.anio = @anio and
		l.periodo = @periodo and
		e.cve_coordinacion = @cve_coord and
		g.cve_profesor = @cve_prof
group by l.anio, l.periodo, l.cve_mat, g.gpo, l.gpo

create table #tmp_tot_reps(
cve_mat int,
gpo	varchar(5) collate SQL_Latin1_General_CP1_CI_AS,
reps float)

insert into #tmp_tot_reps
select	l.cve_mat,
		l.gpo,
		count(l.calificacion)
from	v_www_historico l,
		v_ec_depto_coord_mat e,
		ec_hist_grupos g
where	l.anio = g.anio and
		l.periodo = g.periodo and
		l.cve_mat = g.cve_mat and
		l.gpo = g.gpo COLLATE Latin1_General_CI_AI and
		l.cve_mat = e.cve_mat and
		((isnumeric(l.calificacion) = 0 and l.calificacion = 'NA') or
		(isnumeric(l.calificacion) = 1 and l.calificacion < 6)) and
		l.anio = @anio and
		l.periodo = @periodo and
		e.cve_coordinacion = @cve_coord and
		g.cve_profesor = @cve_prof
group by l.cve_mat, l.gpo

update	#tmp_tot_cal
set		reps = t.reps / #tmp_tot_cal.total * 100
from	#tmp_tot_reps t
where	t.cve_mat = #tmp_tot_cal.cve_mat and
		t.gpo = #tmp_tot_cal.gpo

update	#tmp_dets 
set		pct_reps = reps,
		prom_alum = t.promedio
from	#tmp_tot_cal t
where	t.cve_mat = #tmp_dets.cve_mat and
		t.gpo = #tmp_dets.gpo

create table #tmp_bas_tot(
cve_mat int,
gpo varchar(5) collate SQL_Latin1_General_CP1_CI_AS,
total float)

insert into #tmp_bas_tot
Select	g.cve_mat,
		g.gpo,
		count(h.cuenta)
from	controlescolar_bd.dbo.ui_bibaj h,
		v_ec_depto_coord_mat d,
		ec_hist_grupos g
where	h.anio = g.anio and
		h.periodo = g.periodo and
		h.cve_mat = g.cve_mat and
		h.gpo = g.gpo COLLATE Latin1_General_CI_AI and
		h.cve_mat = d.cve_mat and
		h.anio = @anio and
		h.periodo = @periodo and
		d.cve_coordinacion = @cve_coord and
		g.cve_profesor = @cve_prof
group by g.cve_mat, g.gpo

update	#tmp_tot_cal
set		bas = t.total / #tmp_tot_cal.total * 100
from	#tmp_bas_tot t
where	t.cve_mat = #tmp_tot_cal.cve_mat and
		t.gpo = #tmp_tot_cal.gpo

update	#tmp_dets 
set		pct_ba = bas
from	#tmp_tot_cal t
where	t.cve_mat = #tmp_dets.cve_mat and
		t.gpo = #tmp_dets.gpo

-- MALH 27/09/2017 SE AGREGA CONSULTA
DECLARE @descripcion VARCHAR(15)

SELECT @descripcion = descripcion
FROM controlescolar_bd.dbo.periodo 
WHERE periodo = @periodo

		-- MALH 27/09/2017 SE COMENTA
select	/*
		case @periodo
			when 0 then 'Primavera'
			when 1 then 'Verano'
			when 2 then 'Otoño'
		end as perletra, 
		*/
		@descripcion AS perletra, -- MALH 27/09/2017 SE AGREGA
		@anio as anio,
		@periodo as periodo,
		materia, 
		gpo, 
		inscritos,
		pct_asist,
		pct_rets,
		prom_alum,
		pct_reps,
		pct_ba,
		sepe
from	#tmp_dets

drop table #tmp_tot_cal
drop table #tmp_tot_reps
drop table #tmp_bas_tot
drop table #tmp_dets
GO

