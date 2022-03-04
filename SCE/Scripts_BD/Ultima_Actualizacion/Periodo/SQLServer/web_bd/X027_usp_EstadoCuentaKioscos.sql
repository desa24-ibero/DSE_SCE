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
	SELECT cuenta, 
	cve_concepto,
	cve_subconcepto,
	cve_descripcion,
	periodo,   
	-- MALH 29/09/2017 SE AGREGA CONSULTA
	(SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo) AS NomPeriodo,
	/*-- MALH 29/09/2017 SE COMENTA
	case periodo when 0 THEN 'PRIMAVERA' WHEN 1 THEN 'VERANO' WHEN 2 THEN 'OTOÑO' END as NomPeriodo,  
	*/
	anio,
	fecha_vencimiento,
	fecha_pago = case when cve_subconcepto = 4  then fecha_generacion else fecha_pago end,  
	fecha_generacion  = case when cve_subconcepto = 4  then fecha_generacion else fecha_pago end,
	concepto,
	descripcion,
	nombre, 
	carrera,
	anioperiodocalinsc,  
	sum(isnull(importe,0)) as importe  
	FROM dbo.v_www_rep_estado_cuenta  
	 WHERE Cuenta = @Cuenta
	GROUP BY cuenta, anio, periodo, fecha_vencimiento, cve_concepto, cve_subconcepto, cve_descripcion,  
	 fecha_pago, fecha_generacion,concepto,	descripcion,nombre,carrera,	anioperiodocalinsc

UNION ALL

 select cuenta = @Cuenta,
 cve_concepto = 999,
 cve_subconcepto = 999,
cve_descripcion = 999,
periodo,   
-- MALH 29/09/2017 SE AGREGA CONSULTA
(SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo) AS NomPeriodo,
-- MALH 29/09/2017 SE COMENTA
/*
case periodo when 0 THEN 'PRIMAVERA' WHEN 1 THEN 'VERANO' WHEN 2 THEN 'OTOÑO' END as NomPeriodo,  
*/
anio,
fecha_vencimiento = dateadd(yy,10,GETDATE()),
fecha_pago = dateadd(yy,10,GETDATE()),  
fecha_generacion = dateadd(yy,10,GETDATE()),
concepto = 'SALDO ',
-- MALH 29/09/2017 SE AGREGA CONSULTA
descripcion = 'PERIODO '+ (SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo),
-- MALH 29/09/2017 SE COMENTA
/*
descripcion = 'PERIODO '+ case periodo when 0 THEN 'PRIMAVERA' WHEN 1 THEN 'VERANO' WHEN 2 THEN 'OTOÑO' END,
*/
nombre = '',
carrera = '',
anioperiodocalinsc = NULL, 
sum(isnull(importe,0)) as importe  
 from dbo.v_www_rep_estado_cuenta    
 where 
	dbo.v_www_rep_estado_cuenta.cuenta = @Cuenta 
	  GROUP BY Cuenta,anio, periodo
  order by anio, periodo	
   
 select cuenta,   
 cve_concepto,  
 cve_subconcepto,  
 cve_descripcion,   
 periodo,
 NomPeriodo,
 anio,
 convert(nvarchar(10),fecha_vencimiento,@date_format) as fecha_vencimiento,
 convert(nvarchar(10),fecha_pago,@date_format) as fecha_pago,
 convert(nvarchar(10),fecha_generacion,@date_format) as fecha_generacion,
 concepto, 
 descripcion,
 nombre,  
 carrera,
 anioperiodocalinsc,
 round(importe,2)as importe   
 FROM #saldo_EstadoCuenta
  ORDER BY anio, periodo, convert(datetime,fecha_vencimiento,@date_format), cve_concepto, cve_subconcepto, cve_descripcion,
 convert(datetime,fecha_pago,@date_format),
 convert(datetime,fecha_generacion,@date_format)
GO

GRANT EXECUTE ON [dbo].[usp_EstadoCuentaKioscos] TO public
GO

