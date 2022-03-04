USE controlescolar_bd
GO

UPDATE archivo_mat_insc_bit_fec SET periodo = 7 -- CUATRIMESTRE 1
WHERE periodo = 0
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE archivo_mat_insc_bit_fec'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE archivo_mat_insc_bit_fec'
END          
GO

UPDATE archivo_mat_insc_bit_fec SET periodo = 8 -- CUATRIMESTRE 2
WHERE periodo = 1
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE archivo_mat_insc_bit_fec'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE archivo_mat_insc_bit_fec'
END          
GO

UPDATE archivo_mat_insc_bit_fec SET periodo = 9 -- CUATRIMESTRE 3
WHERE periodo = 2
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: UPDATE archivo_mat_insc_bit_fec'
END ELSE BEGIN
	PRINT 'ERROR: UPDATE archivo_mat_insc_bit_fec'
END
GO

DELETE FROM archivo_mat_insc_bit_fec
WHERE periodo < 7

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: DELETE archivo_mat_insc_bit_fec'
END ELSE BEGIN
	PRINT 'ERROR: DELETE archivo_mat_insc_bit_fec'
END
GO