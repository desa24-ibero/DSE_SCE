USE controlescolar_bd
GO

DELETE FROM periodos_por_procesos
WHERE tipo_periodo = 'T'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE FROM periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: DELETE FROM periodos_por_procesos+'
END          
GO