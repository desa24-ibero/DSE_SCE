USE [web_bd]
GO

/****** Object:  View [dbo].[v_www_periodo_mat_inscritas]    Script Date: 9/8/2017 12:42:46 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


ALTER view [dbo].[v_www_periodo_mat_inscritas](periodo,anio, tipo_periodo) as
SELECT  controlescolar_bd.dbo.periodos_por_procesos.periodo,
        controlescolar_bd.dbo.periodos_por_procesos.anio,
        controlescolar_bd.dbo.periodos_por_procesos.tipo_periodo
FROM    controlescolar_bd.dbo.periodos_por_procesos
WHERE controlescolar_bd.dbo.periodos_por_procesos.cve_proceso = 5
AND controlescolar_bd.dbo.periodos_por_procesos.tipo_periodo = tipo_periodo -- MALH 08/08/2017 -> SE AGREGA CONDICION

GO


