USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[usp_ReportedetAdeudosKioscos]    Script Date: 29/9/2017 12:18:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER Procedure [dbo].[usp_ReportedetAdeudosKioscos] @Cuenta as integer as    

declare @d_SaldoFavor decimal(12,2)

SELECT	Cuenta, 
		Anio, 
		Periodo,
		muestra_fecha_venc = convert(varchar(10),fecha_vencimiento,105), 
		concepto,
		saldo,
		vencido,
		fecha_vencimiento,
		-- MALH 29/09/2017 SE AGREGA CONSULTA
		Muestra_periodo = (SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo),
		/*-- MALH 29/09/2017 SE COMENTA
		Muestra_periodo= CASE periodo when 0 then 'PRIMAVERA'
									WHEN 1 then 'VERANO'
									WHEN 2 then 'OTOÑO'
						END,
		*/
		cve_concepto, 
		conc_asociado = 0,
		bloqueo,
		saldo_favor = 0,
		total = (SELECT	SUM(saldo)
				from dbo.v_www_rep_adeudos
				WHERE	cuenta = @Cuenta AND  
						saldo > 0 AND  
						( vencido = 'SI' 
						OR ( vencido = 'NO' 
						AND cve_concepto NOT IN (17,18,19,20,21,22,48,52)))  
 ) 
FROM dbo.v_www_rep_adeudos   
WHERE  cuenta = @Cuenta AND  
  saldo > 0 AND  
 ( vencido = 'SI' OR ( vencido = 'NO' AND cve_concepto NOT IN (17,18,19,20,21,22,48,52) ) )  
ORDER BY fecha_vencimiento,  
 anio,  
 periodo,  
 cve_concepto


grant execute on [usp_ReportedetAdeudosKioscos] to desasit, mobile_web
GO

GRANT EXECUTE ON [dbo].[usp_ReportedetAdeudosKioscos] TO public
GO
