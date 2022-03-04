use controlescolar_bd
go
 

ALTER PROCEDURE [dbo].[sp_transfiere_preinscripcion] 
@tipo_periodo VARCHAR(3) 

AS
  DECLARE @ErrorSeverity INT
  DECLARE @ErrorState INT
  DECLARE @ls_mensaje_error VARCHAR(250)



BEGIN
	BEGIN TRANSACTION 
	delete from preinsc
	WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo)
	
	IF (@@ERROR <> 0) 
	BEGIN
		Select @ls_mensaje_error = 'Error en el borrado de preinsc.',
		@ErrorSeverity = 16,
		@ErrorState = 1

		goto EtiquetaError
	END

	delete from mat_preinsc 
	WHERE periodo IN(SELECT periodo FROM periodo WHERE tipo = @tipo_periodo)
	
	IF (@@ERROR <> 0) 
	BEGIN
		select @ls_mensaje_error = 'Error en el borrado de mat_preinsc.',
		@ErrorSeverity = 16,
		@ErrorState = 1
		goto EtiquetaError
	END

	COMMIT TRANSACTION

	Return 0



END

EtiquetaError:
 RAISERROR (@ls_mensaje_error, @ErrorSeverity, @ErrorState)
 Rollback Transaction
 return -1

GO

