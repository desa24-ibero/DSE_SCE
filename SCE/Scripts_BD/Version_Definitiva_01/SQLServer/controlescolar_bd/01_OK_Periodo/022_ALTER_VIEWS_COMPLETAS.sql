USE web_bd
GO


ALTER view dbo.v_www_academicos AS SELECT * FROM controlescolar_bd.dbo.academicos
GO

/********************************/

ALTER view [dbo].[v_www_activacion]  as SELECT * FROM controlescolar_bd.dbo.activacion


GO

/********************************/
ALTER view dbo.v_www_activacion_su  as SELECT * FROM controlescolar_bd.dbo.activacion_su

GO


/********************************/
ALTER view dbo.v_www_plan_estudios as select * from controlescolar_bd.dbo.plan_estudios

GO

/*


IF OBJECT_ID ('dbo.v_www_coordinaciones') IS NOT NULL
	DROP VIEW dbo.v_www_coordinaciones
GO

CREATE VIEW dbo.v_www_coordinaciones
AS
SELECT     cve_coordinacion, coordinacion, cve_coordinador, cve_depto, sigla
FROM         controlescolar_bd.dbo.coordinaciones

GO




IF OBJECT_ID ('dbo.v_www_materias') IS NOT NULL
	DROP VIEW dbo.v_www_materias
GO

CREATE VIEW dbo.v_www_materias
AS
SELECT     cve_mat, materia, cve_coordinacion, sigla, activa
FROM         controlescolar_bd.dbo.materias

GO

*/





