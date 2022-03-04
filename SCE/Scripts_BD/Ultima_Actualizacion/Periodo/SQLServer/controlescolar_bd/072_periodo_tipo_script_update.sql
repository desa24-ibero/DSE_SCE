USE controlescolar_bd
GO

UPDATE periodo_tipo SET id_tipo = 'Q', descripcion = 'Cuatrimestre'
WHERE id_tipo = 'S'
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE periodo_tipo'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE periodo_tipo'
END          
GO