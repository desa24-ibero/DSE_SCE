USE [web_bd]
GO

/****** Object:  View [dbo].[vw_RepEstadoCuenta]    Script Date: 29/9/2017 15:51:35 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[vw_RepEstadoCuenta] as

SELECT cuenta, cve_concepto,cve_subconcepto,cve_descripcion,periodo, 
-- MALH 29/09/2017 SE AGREGA CONSULTA
(SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo) AS NomPeriodo,
/*-- MALH 29/09/2017 SE COMENTA
case periodo when 0 THEN 'PRIMAVERA' WHEN 1 THEN 'VERANO' WHEN 2 THEN 'OTOÑO' END as NomPeriodo,
*/
anio,fecha_vencimiento, max(fecha_pago) as fecha_pago,
min(fecha_generacion) as fecha_generacion,concepto,descripcion,nombre, carrera,anioperiodocalinsc,
sum(isnull(importe,0)) as importe
FROM dbo.v_www_rep_estado_cuenta

GROUP BY cuenta, periodo, anio, cve_concepto, cve_subconcepto, cve_descripcion,
fecha_vencimiento, concepto, descripcion,
nombre, carrera,	anioperiodocalinsc

GO


