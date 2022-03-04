USE [controlescolar_bd]
GO

INSERT INTO [controlescolar_bd].[dbo].[parametros_reinscripcion] (cve_parametro, permite_materias_repetidas, permite_materias_encimadas, tipo_periodo, valida_demanda_inscritos, valida_prerrequisitos)
VALUES(3,0,0,'C',1,1)
GO

IF @@ERROR = 0 BEGIN
	PRINT 'EXITO: INSERT INTO parametros_reinscripcion'
END ELSE BEGIN
	PRINT 'ERROR: INSERT INTO parametros_reinscripcion'
END          
