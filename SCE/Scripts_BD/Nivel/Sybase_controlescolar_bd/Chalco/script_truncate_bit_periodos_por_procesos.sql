USE controlescolar_bd
GO

TRUNCATE TABLE bit_periodos_por_procesos
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: TRUNCATE TABLE bit_periodos_por_procesos'
END ELSE BEGIN
	PRINT 'ERROR: TRUNCATE TABLE bit_periodos_por_procesos'
END
GO