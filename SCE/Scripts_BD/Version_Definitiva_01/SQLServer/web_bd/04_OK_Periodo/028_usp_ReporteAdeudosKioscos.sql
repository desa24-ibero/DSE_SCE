USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[usp_ReporteAdeudosKioscos]    Script Date: 29/9/2017 12:12:56 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Procedure [dbo].[usp_ReporteAdeudosKioscos] @Cuenta as integer as    

declare @d_SaldoFavor decimal(12,2)

set @d_SaldoFavor = 0

select @d_SaldoFavor =isnull(SUM(saldo),0)
from dbo.v_www_saldos_a_favor 
where cuenta = @Cuenta
and cve_concepto <> 39
and saldo < 0 


SELECT	Cuenta, 
		Anio, 
		Periodo,
		-- MALH 29/09/2017 SE AGREGA CONSULTA
		Muestra_periodo = (SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo),
		/*-- MALH 29/09/2017 SE COMENTA
		Muestra_periodo= CASE periodo when 0 then 'PRIMAVERA'
									WHEN 1 then 'VERANO'
									WHEN 2 then 'OTOÑO'
						END,
		*/
		fecha_vencimiento,
		muestra_fecha_venc = convert(varchar(10),fecha_vencimiento,105), 
		cve_concepto, 
		concepto,
		saldo,
		vencido, 
		0 as conc_asociado,
		bloqueo, 
		@d_SaldoFavor as saldo_favor
FROM dbo.v_www_rep_adeudos   
/*WHERE Cuenta = @Cuenta  
ORDER BY anio, periodo,fecha_vencimiento,concepto  
*/
WHERE  cuenta = @Cuenta AND  
  saldo > 0 AND  
 ( vencido = 'SI' OR ( vencido = 'NO' AND cve_concepto NOT IN (17,18,19,20,21,22,48,52) ) )  
ORDER BY fecha_vencimiento,  
 anio,  
 periodo,  
 cve_concepto
GO
