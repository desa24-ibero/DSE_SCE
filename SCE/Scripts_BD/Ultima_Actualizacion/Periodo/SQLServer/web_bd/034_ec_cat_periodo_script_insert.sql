USE web_bd
GO

INSERT INTO ec_cat_periodo VALUES(7, 'CUATRIMESTRE 1', 'Q1')
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO ec_cat_periodo'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO ec_cat_periodo'
END          
GO

INSERT INTO ec_cat_periodo VALUES(8, 'CUATRIMESTRE 2', 'Q2')
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO ec_cat_periodo'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO ec_cat_periodo'
END          
GO

INSERT INTO ec_cat_periodo VALUES(9, 'CUATRIMESTRE 3', 'Q3')
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO ec_cat_periodo'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO ec_cat_periodo'
END          
GO
