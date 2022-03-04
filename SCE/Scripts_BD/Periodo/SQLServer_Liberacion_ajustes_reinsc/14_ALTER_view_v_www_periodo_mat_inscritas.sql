
USE web_bd
GO

ALTER view dbo.v_www_periodo_mat_inscritas(periodo,anio, tipo_periodo) as
SELECT  controlescolar_bd.dbo.periodos_por_procesos.periodo,
        controlescolar_bd.dbo.periodos_por_procesos.anio,
        controlescolar_bd.dbo.periodos_por_procesos.tipo_periodo
FROM    controlescolar_bd.dbo.periodos_por_procesos
WHERE controlescolar_bd.dbo.periodos_por_procesos.cve_proceso = 5

GO



