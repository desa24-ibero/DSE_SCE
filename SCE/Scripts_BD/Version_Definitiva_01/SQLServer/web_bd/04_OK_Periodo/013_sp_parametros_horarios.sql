USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_parametros_horarios]    Script Date: 29/9/2017 10:40:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER PROCEDURE [dbo].[sp_parametros_horarios]
 @cve_coordinacion int
 
AS 

DECLARE @VAR_anio INTEGER
DECLARE @VAR_periodo INTEGER
DECLARE @VAR_cve_coordinacion INTEGER
DECLARE @VAR_coordinacion VARCHAR(70)
DECLARE @VAR_periodo_texto VARCHAR(10)

--Obtiene los parametros de los periodos por procesos
--Para el periodo de la carga de grupos

SELECT @VAR_anio = isnull(anio,0),  
	   @VAR_periodo = isnull(periodo,0),
	   -- MALH 29/09/2017 SE AGREGA CONSULTA
	   @VAR_periodo_texto = (SELECT UPPER(descripcion) FROM controlescolar_bd.dbo.periodo WHERE periodo = periodo)
	   /*-- MALH 29/09/2017 SE COMENTA
	   @VAR_periodo_texto = CASE  periodo WHEN 0 THEN 'Primavera'
  												 WHEN 1 THEN 'Verano'
  												 WHEN 2 THEN 'Otoño'
												ELSE ''END
	   */
FROM controlescolar_bd.dbo.periodos_por_procesos
WHERE cve_proceso = 4


--Si no existen estos parametros no es posible continuar
IF @@ROWCOUNT = 0
BEGIN
	SELECT -1,'NO SE ENCUENTRA INFORMACIÓN DE LOS PARAMETROS DE CARGA PARA EL GRUPO'
	RETURN -1
END 

SELECT @VAR_cve_coordinacion = cve_coordinacion,
		 @VAR_coordinacion = coordinacion
FROM controlescolar_bd.dbo.coordinaciones
WHERE cve_coordinacion = @cve_coordinacion

--Si no existe la coordinacion no hay información que mostrar
IF @@ROWCOUNT = 0
BEGIN
	SELECT cve_coordinacion=-1, 
			coordinacion='NO SE ENCUENTRA INFORMACIÓN DE LOS GRUPOS DE LA COORDINACION '+CONVERT(VARCHAR(10),@cve_coordinacion), 
			periodo= @VAR_periodo_texto,
			anio=@VAR_anio
	RETURN -1
END

  SELECT cve_coordinacion = @VAR_cve_coordinacion,
		 coordinacion = @VAR_coordinacion,
		 periodo =@VAR_periodo_texto,
		 anio = @VAR_anio
GO

