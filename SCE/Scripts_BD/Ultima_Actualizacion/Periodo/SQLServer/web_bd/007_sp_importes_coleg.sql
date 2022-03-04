USE [web_bd]
GO

/****** Object:  StoredProcedure [dbo].[sp_importes_coleg]    Script Date: 27/9/2017 10:34:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[sp_importes_coleg]
@cuenta integer,
@anio integer,
@periodo integer,
@fcol1 integer,
@fcol2 integer,
@fcol3 integer,
@fcol4 integer
as
-- Este procedimiento regresa Los datos del alumno y los importes de las  colegiaturas.
-- Juan Campos Sánchez. 10 de Septiembre de 2002.


-- 12 Mayo 2006 Modificación: JMG. Se modifico para el nuevo esquema de transferencia. Lee ahora de 
-- la nueva vista v_mov_alumnos y no de mov_alumnos.


declare @nombre varchar(100)
declare @cve_carrera integer
declare @carrera varchar(100)
declare @nivel char(1)
declare @cve_concepto1a integer
declare @concepto1a varchar(50)
declare @saldo1a double precision
declare @cve_concepto2a integer
declare @concepto2a varchar(50)
declare @saldo2a double precision
declare @cve_concepto3a integer
declare @concepto3a varchar(50)
declare @saldo3a double precision
declare @cve_concepto4a integer
declare @concepto4a varchar(50)
declare @saldo4a double precision
declare @recalculo double precision
declare @contrecal integer

select @nombre = controlescolar_bd.dbo.alumnos.nombre_completo,
		 @cve_carrera = controlescolar_bd.dbo.carreras.cve_carrera,
		 @carrera = controlescolar_bd.dbo.carreras.carrera,
		 @nivel = controlescolar_bd.dbo.academicos.nivel
from 	controlescolar_bd.dbo.alumnos,
		controlescolar_bd.dbo.carreras,
		controlescolar_bd.dbo.academicos
where controlescolar_bd.dbo.alumnos.cuenta = @cuenta and
		controlescolar_bd.dbo.alumnos.cuenta = controlescolar_bd.dbo.academicos.cuenta and
		controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.carreras.cve_carrera


select   @cve_concepto1a = tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
			@concepto1a = tesoreria_bd.dbo.conceptos.concepto,
			@saldo1a = ROUND(SUM(case(tesoreria_bd.dbo.v_mov_alumnos.cve_subconcepto)
								when 1 then importe
								when 2 then importe
								else -importe
								end),2)
from 	
tesoreria_bd.dbo.v_mov_alumnos,
tesoreria_bd.dbo.conceptos
where 	
(tesoreria_bd.dbo.v_mov_alumnos.anio = @anio) and
(tesoreria_bd.dbo.v_mov_alumnos.periodo = @periodo) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = 8) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = tesoreria_bd.dbo.conceptos.cve_concepto) and
(10000*datepart(yy,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
(100 *datepart(mm,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
datepart(dd,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento) = @fcol1 and
tesoreria_bd.dbo.v_mov_alumnos.cuenta = @cuenta
group by 
tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
tesoreria_bd.dbo.conceptos.concepto

select   @cve_concepto2a = tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
			@concepto2a = tesoreria_bd.dbo.conceptos.concepto,
			@saldo2a = ROUND(SUM(case(tesoreria_bd.dbo.v_mov_alumnos.cve_subconcepto)
								when 1 then importe
								when 2 then importe
								else -importe
								end),2)
from 	
tesoreria_bd.dbo.v_mov_alumnos,
tesoreria_bd.dbo.conceptos
where 	
(tesoreria_bd.dbo.v_mov_alumnos.anio = @anio) and
(tesoreria_bd.dbo.v_mov_alumnos.periodo = @periodo) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = 9) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = tesoreria_bd.dbo.conceptos.cve_concepto) and
(10000*datepart(yy,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
(100 *datepart(mm,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
datepart(dd,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento) = @fcol2 and
tesoreria_bd.dbo.v_mov_alumnos.cuenta = @cuenta
group by 
tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
tesoreria_bd.dbo.conceptos.concepto


select   @cve_concepto3a = tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
			@concepto3a = tesoreria_bd.dbo.conceptos.concepto,
			@saldo3a = ROUND(SUM(case(tesoreria_bd.dbo.v_mov_alumnos.cve_subconcepto)
								when 1 then importe
								when 2 then importe
								else -importe
								end),2)
from 	
tesoreria_bd.dbo.v_mov_alumnos,
tesoreria_bd.dbo.conceptos
where 	
(tesoreria_bd.dbo.v_mov_alumnos.anio = @anio) and
(tesoreria_bd.dbo.v_mov_alumnos.periodo = @periodo) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = 10) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = tesoreria_bd.dbo.conceptos.cve_concepto) and
(10000*datepart(yy,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
(100 *datepart(mm,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
datepart(dd,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento) = @fcol3 and
tesoreria_bd.dbo.v_mov_alumnos.cuenta = @cuenta
group by 
tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
tesoreria_bd.dbo.conceptos.concepto

select   @cve_concepto4a = tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
			@concepto4a = tesoreria_bd.dbo.conceptos.concepto,
			@saldo4a = ROUND(SUM(case(tesoreria_bd.dbo.v_mov_alumnos.cve_subconcepto)
								when 1 then importe
								when 2 then importe
								else -importe
								end),2)
from 	
tesoreria_bd.dbo.v_mov_alumnos,
tesoreria_bd.dbo.conceptos
where 	
(tesoreria_bd.dbo.v_mov_alumnos.anio = @anio) and
(tesoreria_bd.dbo.v_mov_alumnos.periodo = @periodo) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = 11) and
(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = tesoreria_bd.dbo.conceptos.cve_concepto) and
(10000*datepart(yy,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
(100 *datepart(mm,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
datepart(dd,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento) = @fcol4 and
tesoreria_bd.dbo.v_mov_alumnos.cuenta = @cuenta
group by 
tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,
tesoreria_bd.dbo.conceptos.concepto


select @contrecal = 0

select @contrecal = count(*)
	from tesoreria_bd.dbo.v_mov_alumnos
	where tesoreria_bd.dbo.v_mov_alumnos.cuenta = @cuenta and
			tesoreria_bd.dbo.v_mov_alumnos.anio = @anio and
			tesoreria_bd.dbo.v_mov_alumnos.periodo = @periodo and
			tesoreria_bd.dbo.v_mov_alumnos.cve_caja = 120 and
			tesoreria_bd.dbo.v_mov_alumnos.cve_concepto in (8,9,10,11)

if @contrecal > 0 
begin
	select @saldo4a = 0 -- Por que ya viene el saldo sumado en el Recálculo

	select @recalculo = ROUND(SUM(case(tesoreria_bd.dbo.v_mov_alumnos.cve_subconcepto)
									when 1 then importe
									when 2 then importe
									else -importe
									end),2)
	from 	
	tesoreria_bd.dbo.v_mov_alumnos
	where 	
	(tesoreria_bd.dbo.v_mov_alumnos.anio = @anio) and
	(tesoreria_bd.dbo.v_mov_alumnos.periodo = @periodo) and
	(tesoreria_bd.dbo.v_mov_alumnos.cve_concepto in (8,9,10,11)) and
	(10000*datepart(yy,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
	(100 *datepart(mm,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento))+
	datepart(dd,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento) = @fcol4 and
	tesoreria_bd.dbo.v_mov_alumnos.cuenta = @cuenta
end
else
	select @recalculo = 0

-- Se el siguiente query para la leyenda en la boleta de: 'Tienes un adeudo de Inscripción de Periodo x de Año x'
-- Juan Campos. 21-Enero-2002.
 
declare @men_dif_inscrip varchar(100)
declare @periodo_str varchar(20)

if (select v_www_saldos_mov_alumnos.saldo  
    from v_www_saldos_mov_alumnos 
		where	(  v_www_saldos_mov_alumnos.cuenta = @cuenta ) and 
				((10000 * datepart(yy, v_www_saldos_mov_alumnos.fecha_vencimiento))+
				(100  *	datepart(mm, v_www_saldos_mov_alumnos.fecha_vencimiento))+
							datepart(dd, v_www_saldos_mov_alumnos.fecha_vencimiento) <= 
				(10000 * datepart(yy,getdate()))+
				(100  *	datepart(mm,getdate()))+
							datepart(dd,getdate())) and
				( v_www_saldos_mov_alumnos.saldo > 0) and
				( v_www_saldos_mov_alumnos.anio = @anio) and
				( v_www_saldos_mov_alumnos.periodo = @periodo) and
				( v_www_saldos_mov_alumnos.cve_concepto in(3,4,5,6,7,30))) > 0 
begin
	DECLARE  @descripcion VARCHAR(15)
	
	-- MALH 27/09/2017 SE AGREGA CONSULTA
	SELECT @descripcion = ISNULL(descripcion, '')
	from controlescolar_bd.dbo.periodo
	WHERE periodo = @periodo

	SELECT @periodo_str = @descripcion + ' de ' + convert(varchar(4), @anio)

	-- MALH 27/09/2017 SE COMENTA
	/*
	if @periodo = 0
		select @periodo_str = 'Primavera de ' + convert(varchar(4), @anio)
	else 
	if @periodo = 1
		select @periodo_str = 'Verano de ' + convert(varchar(4), @anio)
	else
	if @periodo = 2
		select @periodo_str = 'Otoño de ' + convert(varchar(4), @anio)
 	else
		select @periodo_str = ''
	*/
			
	select @men_dif_inscrip = 'Tienes un adeudo de Inscripción de ' + @periodo_str + '.'

end
else
	select @men_dif_inscrip = null
		
select 'nombre' = @nombre,
		 'cve_carrera' = @cve_carrera,
		 'carrera' = @carrera,	
		 'nivel' = @nivel,
		 'cve_concepto1a' = @cve_concepto1a,
		 'concepto1a' = @concepto1a,
		 'saldo1a' = @saldo1a,
		 'cve_concepto2a' = @cve_concepto2a,
		 'concepto2a' = @concepto2a,
		 'saldo2a' = @saldo2a,
		 'cve_concepto3a' = @cve_concepto3a,
		 'concepto3a' = @concepto3a,
		 'saldo3a' = @saldo3a,
		 'cve_concepto4a' = @cve_concepto4a,
		 'concepto4a' = @concepto4a,
		 'saldo4a' = @saldo4a,
		 'recalculo' = @recalculo,
		 'men_dif_inscrip' = @men_dif_inscrip
GO

GRANT EXECUTE ON [dbo].[sp_importes_coleg] TO public
GO
