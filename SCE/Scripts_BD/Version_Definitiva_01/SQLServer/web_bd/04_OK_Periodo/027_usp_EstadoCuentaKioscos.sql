USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[usp_EstadoCuentaKioscos]    Script Date: 29/9/2017 12:05:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Procedure [dbo].[usp_EstadoCuentaKioscos] @Cuenta integer  as
  
DECLARE @date_format int

SELECT @date_format = 103

create table #saldo_EstadoCuenta
(
cuenta int not null ,   
cve_concepto smallint not null,  
cve_subconcepto smallint not null,  
cve_descripcion smallint not null,   
periodo  smallint not null ,
NomPeriodo varchar(9) not null,
anio smallint not null ,
fecha_vencimiento datetime not null,
fecha_pago datetime  null,
fecha_generacion datetime  null,   
concepto varchar(40) null, 
descripcion varchar(80) null,
nombre varchar(80)  null,  
carrera varchar(80)  null,
anioperiodocalinsc int  null,
importe float not null       
)
     
INSERT INTO #saldo_EstadoCuenta
SELECT	a.cuenta, 
		a.cve_concepto,
		a.cve_subconcepto,
		a.cve_descripcion,
		a.periodo,   
		-- MALH 29/09/2017 SE AGREGA
		UPPER(ISNULL(b.descripcion,'')) AS NomPeriodo,
		-- MALH 29/09/2017 SE COMENTA
		/*
		case a.periodo when 0 THEN 'PRIMAVERA' WHEN 1 THEN 'VERANO' WHEN 2 THEN 'OTOÑO' END as NomPeriodo,  
		*/
		a.anio,
		a.fecha_vencimiento,
		fecha_pago = case when a.cve_subconcepto = 4  then a.fecha_generacion else a.fecha_pago end,  
		fecha_generacion  = case when a.cve_subconcepto = 4  then a.fecha_generacion else a.fecha_pago end,
		a.concepto,
		a.descripcion,
		a.nombre, 
		a.carrera,
		a.anioperiodocalinsc,  
		sum(isnull(a.importe,0)) as importe  
FROM dbo.v_www_rep_estado_cuenta a
LEFT JOIN controlescolar_bd.dbo.periodo b ON b.periodo = a.periodo
WHERE a.Cuenta = @Cuenta
GROUP BY a.cuenta, a.anio, a.periodo, a.fecha_vencimiento, a.cve_concepto, a.cve_subconcepto, a.cve_descripcion,  
		 a.fecha_pago, a.fecha_generacion,a.concepto, a.descripcion,a.nombre,a.carrera,a.anioperiodocalinsc, b.descripcion
UNION ALL
SELECT	cuenta = @Cuenta,
		cve_concepto = 999,
		cve_subconcepto = 999,
		cve_descripcion = 999,
		a.periodo,   
		-- MALH 29/09/2017 SE AGREGA CONSULTA
		UPPER(ISNULL(b.descripcion,'')) AS NomPeriodo,
		-- MALH 29/09/2017 SE COMENTA
		/*
		case a.periodo when 0 THEN 'PRIMAVERA' WHEN 1 THEN 'VERANO' WHEN 2 THEN 'OTOÑO' END as NomPeriodo,  
		*/
		a.anio,
		fecha_vencimiento = dateadd(yy,10,GETDATE()),
		fecha_pago = dateadd(yy,10,GETDATE()),  
		fecha_generacion = dateadd(yy,10,GETDATE()),
		concepto = 'SALDO ',
		-- MALH 29/09/2017 SE AGREGA CONSULTA
		descripcion = 'PERIODO ', -- NOTA: NO SE PUSO AQUI LA DESCRIPCION DE UNA VEZ, DADO QUE CAUSA CONFLICTO POR TIPO DE DATOS
		-- MALH 29/09/2017 SE COMENTA
		/*
		--descripcion = 'PERIODO '+ case a.periodo when 0 THEN 'PRIMAVERA' WHEN 1 THEN 'VERANO' WHEN 2 THEN 'OTOÑO' END,
		*/
		nombre = '',
		carrera = '',
		anioperiodocalinsc = NULL, 
		sum(isnull(a.importe,0)) as importe  
FROM dbo.v_www_rep_estado_cuenta a
LEFT JOIN controlescolar_bd.dbo.periodo b ON b.periodo = a.periodo
WHERE a.cuenta = @Cuenta 
GROUP BY a.Cuenta,a.anio, a.periodo, b.descripcion
ORDER BY a.anio, a.periodo	
   
 select  a.cuenta,   
		 a.cve_concepto,  
		 a.cve_subconcepto,  
		 a.cve_descripcion,   
		 a.periodo,
		 a.NomPeriodo,
		 a.anio,
		 convert(nvarchar(10),a.fecha_vencimiento,@date_format) as fecha_vencimiento,
		 convert(nvarchar(10),a.fecha_pago,@date_format) as fecha_pago,
		 convert(nvarchar(10),a.fecha_generacion,@date_format) as fecha_generacion,
		 a.concepto, 
		 CASE a.descripcion WHEN 'PERIODO ' THEN 'PERIODO ' + UPPER(ISNULL(b.descripcion,'')) ELSE a.descripcion END AS descripcion,
		 a.nombre,  
		 a.carrera,
		 a.anioperiodocalinsc,
		 round(a.importe,2) as importe   
FROM #saldo_EstadoCuenta a
LEFT JOIN controlescolar_bd.dbo.periodo b ON b.periodo = a.periodo
ORDER BY a.anio, a.periodo, convert(datetime,a.fecha_vencimiento,@date_format), a.cve_concepto, a.cve_subconcepto, a.cve_descripcion,
convert(datetime,a.fecha_pago,@date_format),
convert(datetime,a.fecha_generacion,@date_format)
GO

