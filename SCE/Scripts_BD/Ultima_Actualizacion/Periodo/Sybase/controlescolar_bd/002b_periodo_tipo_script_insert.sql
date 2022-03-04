USE controlescolar_bd
GO

INSERT INTO periodo_tipo
VALUES('Q','Cuatrimestral')
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO periodo_tipo'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO periodo_tipo'
END          
GO