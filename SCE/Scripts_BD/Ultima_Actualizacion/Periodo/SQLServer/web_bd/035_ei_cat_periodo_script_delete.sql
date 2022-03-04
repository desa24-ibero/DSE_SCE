USE web_bd
GO

TRUNCATE TABLE ei_cat_periodo
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: TRUNCATE TABLE ei_cat_periodo'
END ELSE BEGIN
	PRINT 'ERROR: TRUNCATE TABLE ei_cat_periodo'
END          
GO
