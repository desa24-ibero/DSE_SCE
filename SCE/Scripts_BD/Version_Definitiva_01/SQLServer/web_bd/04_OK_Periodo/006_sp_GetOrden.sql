USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_GetOrden]    Script Date: 29/9/2017 08:58:54 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[sp_GetOrden] 
	@orden_num varchar(20)
AS
BEGIN


SELECT	concepto,
		v.cve_concepto,
		cve_subconcepto,
		cve_descripcion,
		-- MALH 29/09/2017 SE AGREGA CONSULTA
		(SELECT descripcion FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo) AS period,
		-- MALH 29/09/2017 SE COMENTA
		/* 
		period =
		CASE periodo
			WHEN 0 THEN 'Primavera'
			WHEN 1 THEN 'Verano'
			WHEN 2 THEN 'Otoño'
		END,
		*/
		anio,
		fecha_vencimiento,
		fecha,
		importe,
		fecha_generacion,
		fecha_vencimiento,
		periodo
FROM	tesoreria_bd.dbo.vpos_mov_alumnos v, 
		tesoreria_bd.dbo.conceptos c 
WHERE	
		vpos_cc_ordernum = @orden_num AND 
		v.cve_concepto = c.cve_concepto 
	
END

