USE [controlescolar_bd]
GO

IF OBJECT_ID ('dbo.regla_periodo') IS NOT NULL
	DROP RULE dbo.regla_periodo
GO

CREATE RULE [dbo].[regla_periodo] 
AS
@tipo_periodo in (7,8,9)

GO


