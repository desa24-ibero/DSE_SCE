USE controlescolar_bd
GO

INSERT INTO controlescolar_bd.dbo.periodos_por_procesos
SELECT	cve_proceso,
		proceso,
		periodo,
		anio,
		fecha_inicial,
		fecha_final,
		'C' -- tipo_periodo
FROM controlescolar_bd.dbo.periodos_por_procesos
WHERE periodo IN (1,2,3)
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO periodos_por_procesos'
END          
