USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_origen_materia]    Script Date: 29/9/2017 10:12:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_origen_materia]
	@a_cuenta integer
as
create table #mat_inscritas_origen(
	cuenta                          integer                              not null  ,
	cve_mat                         integer                              not null  ,
	gpo                             varchar(2)  collate SQL_Latin1_General_CP1_CI_AS                      not null ,
	periodo                         integer                     not null   ,
	anio                            integer                        not null   ,
	calificacion                    varchar(2)                    null   ,
	cve_condicion                   integer                                 null  ,
	acreditacion                    integer                                 null  ,
	inscripcion                     varchar(1)                 not null  ,
	cve_origen_materia         integer                 null  ,
	fecha							datetime				null
  
)

declare @ll_periodo integer, @ll_anio integer
declare @ll_periodo_ant integer, @ll_anio_ant integer
declare @ldttm_fecha_ant datetime, @ldttm_fecha_base datetime

insert into #mat_inscritas_origen
select cuenta,
cve_mat,
gpo,
periodo,
anio,
calificacion,
cve_condicion,
acreditacion,
inscripcion,
0, 
null 
from  controlescolar_bd.dbo.mat_inscritas
where cuenta = @a_cuenta

select @ll_periodo = max(periodo)
from #mat_inscritas_origen

select @ll_anio = max(anio)
from #mat_inscritas_origen

if @ll_periodo= 0
begin
	select @ll_periodo_ant = 2
	select @ll_anio_ant = @ll_anio -1
end
if @ll_periodo= 1
begin
	select @ll_periodo_ant = 0
	select @ll_anio_ant = @ll_anio
end
if @ll_periodo= 2
begin
	select @ll_periodo_ant = 1
	select @ll_anio_ant = @ll_anio
end

select @ldttm_fecha_ant = fecha
from controlescolar_bd.dbo.calendario
where anio = @ll_anio_ant 
and periodo = @ll_periodo_ant
and cve_evento = 2

select @ldttm_fecha_base = dateadd(dd, -1, @ldttm_fecha_ant)

update #mat_inscritas_origen
	set 	fecha = @ldttm_fecha_base 
from #mat_inscritas_origen


--cve_origen_materia
--1 - Reinscripción Solicitada
--2 - Reinscripción Paralelo
--3 - Ajustes
--4 - Coordinación
--5 - Servicios Escolares



--1 - Reinscripción Solicitada
update #mat_inscritas_origen
	set cve_origen_materia = 1,
		fecha = bita.fecha
from #mat_inscritas_origen mio, controlescolar_bd.dbo.mat_preinsc mp, controlescolar_bd.dbo.movmat_inscritas bita
where mio.cuenta = @a_cuenta
and mio.cuenta = mp.cuenta
and mio.cve_mat = mp.cve_mat
and mio.gpo = mp.gpo
and mio.periodo = mp.periodo
and mio.anio = mp.anio
and mp.status = 255
and bita.cuenta = mio.cuenta
and bita.cve_mat = mio.cve_mat
and bita.gpo = mio.gpo
and bita.periodo= mio.periodo
and bita.anio = mio.anio


--2 - Reinscripción Paralelo
update #mat_inscritas_origen
	set cve_origen_materia = 2,
		fecha = bita.fecha 
from #mat_inscritas_origen mio, controlescolar_bd.dbo.v_mat_preinsc_paralelo mp, controlescolar_bd.dbo.movmat_inscritas bita
where mio.cuenta = @a_cuenta
and mio.cuenta = mp.cuenta
and mio.cve_mat = mp.cve_mat
and mio.gpo = mp.gpo 
and mio.periodo = mp.periodo
and mio.anio = mp.anio
and mp.status = 255
and mp.status2 in (84,85)
and bita.cuenta = mio.cuenta
and bita.cve_mat = mio.cve_mat
and bita.gpo = mio.gpo
and bita.periodo= mio.periodo
and bita.anio = mio.anio

--3 - Ajustes
update #mat_inscritas_origen
	set cve_origen_materia = 3,
		fecha = bita.fecha
from controlescolar_bd.dbo.movmat_inscritas bita, #mat_inscritas_origen mi
where bita.usuario ='wwww'
and mi.cuenta = @a_cuenta 
and bita.cuenta = mi.cuenta
and bita.cve_mat = mi.cve_mat
and bita.gpo = mi.gpo
and bita.periodo= mi.periodo
and bita.anio = mi.anio
and mi.fecha < bita.fecha

--4 - Coordinación
update #mat_inscritas_origen
	set cve_origen_materia = 4,
		fecha = bita.fecha
from controlescolar_bd.dbo.movmat_inscritas bita, #mat_inscritas_origen mi, controlescolar_bd.dbo.coordinaciones c
where bita.usuario <>'wwww'
and mi.cuenta = @a_cuenta 
and bita.cuenta = mi.cuenta
and bita.cve_mat = mi.cve_mat
and bita.gpo = mi.gpo
and bita.periodo= mi.periodo
and bita.anio = mi.anio
and bita.usuario = lower(c.user_id)
and bita.movimiento = 'IN'
and mi.fecha < bita.fecha

--5 - Servicios Escolares
update #mat_inscritas_origen
	set cve_origen_materia = 5,
		fecha = bita.fecha
from controlescolar_bd.dbo.movmat_inscritas bita, #mat_inscritas_origen mi, controlescolar_bd.dbo.coordinaciones c
where bita.usuario <>'wwww'
and mi.cuenta = @a_cuenta 
and bita.cuenta = mi.cuenta
and bita.cve_mat = mi.cve_mat
and bita.gpo = mi.gpo
and bita.periodo= mi.periodo
and bita.anio = mi.anio
and bita.usuario <> lower(c.user_id)
and bita.movimiento = 'IN'
and mi.fecha < bita.fecha



SELECT mi.cuenta, 
		mi.nombre, 
		mi.carrera, 
		mi.nombre_plan, 
		mi.cve_mat, 
		mi.materia, 
		mi.creditos, 
		mi.horas, 
		mi.gpo,
		mi.dia, 
		mi.hora_inicio, 
		mi.hora_fin,
		mi.salon,
		mi.cve_condicion, 
		mi.calificacion,
		pmi.periodo,
		pmi.anio,
		-- MALH 29/09/2017 SE AGREGA CONSULTA
		(SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = pmi.periodo) AS nombre_periodo,
		/*-- MALH 29/09/2017 SE COMENTA
		nombre_periodo = CASE pmi.periodo WHEN 0 THEN 'PRIMAVERA'
                        WHEN 1 THEN 'VERANO'
                        WHEN 2 THEN 'OTOÑO' END,
		*/
		fecha_ayer = dateadd(d,-1,getdate()),
		cve_origen_materia = mio.cve_origen_materia,
		fecha_movimiento = mio.fecha,	
		origen = om.origen								
        FROM dbo.v_www_materias_inscritas mi, dbo.v_www_periodo_mat_inscritas pmi,
			 #mat_inscritas_origen mio, controlescolar_bd.dbo.origen_mat_inscritas om
        WHERE mi.cuenta =  @a_cuenta
		AND mi.cuenta = mio.cuenta
		AND mi.cve_mat = mio.cve_mat
		AND mi.gpo = mio.gpo
		AND mio.cve_origen_materia = om.cve_origen

		drop table #mat_inscritas_origen
GO

GRANT EXECUTE ON [dbo].[sp_origen_materia] TO public
GO