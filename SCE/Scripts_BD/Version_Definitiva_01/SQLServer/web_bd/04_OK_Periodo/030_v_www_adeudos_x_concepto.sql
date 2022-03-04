USE [web_bd]
GO

/****** Object:  View [dbo].[v_www_adeudos_x_concepto]    Script Date: 29/9/2017 12:39:02 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER view [dbo].[v_www_adeudos_x_concepto]
(cuenta,anio,periodo,periodo_str,cve_concepto,concepto,fecha_vencimiento,importe,fecha_hoy,vencido,sumado,bloqueo) 
as
-- Adeudos que puede pagar un alumno
-- Juan Campos Sánchez. 31 de Octubre de 2002.
select	tesoreria_bd.dbo.v_mov_alumnos.cuenta,   
			tesoreria_bd.dbo.v_mov_alumnos.anio,
			tesoreria_bd.dbo.v_mov_alumnos.periodo,
			-- MALH 29/09/2017 SE AGREGA CONSULTA
			(SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = tesoreria_bd.dbo.v_mov_alumnos.periodo),
			/*-- MALH 29/09/2017 SE COMENTA
			case tesoreria_bd.dbo.v_mov_alumnos.periodo
				when 0 then 'PRIMAVERA'
				when 1 then 'VERANO'
				else 'OTOÑO'
			end,
			*/
			tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,    
			tesoreria_bd.dbo.conceptos.concepto,    
			tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento,
			round(sum(case tesoreria_bd.dbo.v_mov_alumnos.cve_subconcepto 
							 when 1 then tesoreria_bd.dbo.v_mov_alumnos.importe 
							 when 2 then tesoreria_bd.dbo.v_mov_alumnos.importe 
							 else - tesoreria_bd.dbo.v_mov_alumnos.importe
						 end),2),
			GetDate(),
			case	when ((10000 * datepart(yy,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento)) +
							  (100 *   datepart(mm,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento)) +
										  datepart(dd,tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento) <    
							  (10000 * datepart(yy,GetDate())) +
							  (100 *   datepart(mm,GetDate())) +
										  datepart(dd,GetDate()))     
					then 1
					else 0 
			end,0,
			tesoreria_bd.dbo.conceptos.bloqueo
from	tesoreria_bd.dbo.v_mov_alumnos, tesoreria_bd.dbo.conceptos
where ( tesoreria_bd.dbo.v_mov_alumnos.cve_concepto < 100 )AND
		( tesoreria_bd.dbo.v_mov_alumnos.cve_concepto = tesoreria_bd.dbo.conceptos.cve_concepto ) AND
		( tesoreria_bd.dbo.v_mov_alumnos.cve_concepto not in (37) ) AND
		( tesoreria_bd.dbo.conceptos.pago_servicio = 0 )
group by tesoreria_bd.dbo.v_mov_alumnos.cuenta,   
			tesoreria_bd.dbo.v_mov_alumnos.anio,
			tesoreria_bd.dbo.conceptos.bloqueo,   
			tesoreria_bd.dbo.v_mov_alumnos.periodo,  
			tesoreria_bd.dbo.v_mov_alumnos.cve_concepto,    
			tesoreria_bd.dbo.conceptos.cve_con_asociado,
			tesoreria_bd.dbo.conceptos.concepto,    
			tesoreria_bd.dbo.v_mov_alumnos.fecha_vencimiento
GO