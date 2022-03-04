IF OBJECT_ID ('dbo.regla_periodo') IS NOT NULL
	DROP RULE dbo.regla_periodo
GO

create rule regla_periodo as @tipo_periodo in (7,8,9)
         

GO

