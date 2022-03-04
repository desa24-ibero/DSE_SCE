USE controlescolar_bd
GO

INSERT INTO nivel VALUES('T','Tecnico', 'Tecnico')
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO nivel'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO nivel'
END          
GO