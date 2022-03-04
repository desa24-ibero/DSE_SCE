USE controlescolar_bd 
GO 


ALTER PROCEDURE [dbo].[sp_ets_validacion_prerequisitos]
 @CUENTA int,
 @MATERIA int,     
 @CARRERA int = 0,
 @PLAN int = 0,
 @CONMENSAJES int = 0
AS
DECLARE @prereq_cve int, @enlace varchar(5), @prereq_orden int, @prereq_aprobo int
DECLARE @bandera_or int
/*
Modificado 2009-08-07		Omar Ugalde
	Se agregó statement "SET @enlace_ant = 'Y'" en la condición "IF @enlace='Y' AND @prereq_aprobo>0"
	cuando el prerequisito es tipo 'Y' y está aprobado esto hace que si el siguiente prerrequisito es 
	tipo NULL(último) y no está aprobado, no permita la inscripción.
Modificado 2009-08-17		Omar Ugalde
	Rediseño para hacer más sencillo el proceso.
	Si existe una secuencia de prereq 'O', debe aprobar al menos una al llegar a un prereq 'Y' o 'NULO'
*/
SET @bandera_or		= 0
IF EXISTS(select 1 
          from controlescolar_bd.dbo.prerrequisitos pr
          		 INNER JOIN controlescolar_bd.dbo.academicos ac ON
          		ac.cuenta		= @CUENTA
          	and pr.cve_mat		= @MATERIA
            and pr.cve_plan		= ac.cve_plan
          	and pr.cve_carrera	= ac.cve_carrera)
BEGIN
 DECLARE PREREQ CURSOR FOR
 SELECT p.cve_prerreq, p.enlace, p.orden,CASE ac.nivel WHEN 'P' THEN ISNULL(hp.cve_mat,0) ELSE ISNULL(h.cve_mat,0) END
 FROM	controlescolar_bd.dbo.academicos ac
  					 INNER JOIN controlescolar_bd.dbo.prerrequisitos as p ON
  					 ac.cuenta = @CUENTA
  				 and p.cve_mat = @MATERIA
  				 and p.cve_plan = ac.cve_plan
  				 and p.cve_carrera = ac.cve_carrera
                     
  				     LEFT OUTER JOIN controlescolar_bd.dbo.historico as h ON
                     p.cve_prerreq	= h.cve_mat
                 and h.cve_plan = ac.cve_plan
                 and h.cve_carrera = ac.cve_carrera
                 and h.calificacion in ('AC' ,'6','7','8','9','10', 'MB','B','S','E','RE')
                 and h.cuenta	= ac.cuenta
                 and ac.nivel <> 'P'
                 
                 	 LEFT OUTER JOIN controlescolar_bd.dbo.historico as hp ON
                     p.cve_prerreq	= hp.cve_mat
                 and hp.cve_plan = ac.cve_plan
                 and hp.cve_carrera = ac.cve_carrera
                 and hp.calificacion in ('AC' ,'6','7','8','9','10', 'MB','B','S','E','RE')
                 and hp.cuenta	= ac.cuenta
                 and ac.nivel = 'P'
 ORDER BY p.orden
 /*Linea modificada SELECT p.cve_prerreq, p.enlace, p.orden,CASE ac.nivel WHEN 'L' THEN ISNULL(h.cve_mat,0) ELSE ISNULL(hp.cve_mat,0) END*/
 /*Linea modificada and ac.nivel = 'L'*/
 
 OPEN PREREQ
 FETCH NEXT FROM PREREQ INTO @prereq_cve, @enlace, @prereq_orden, @prereq_aprobo
 IF @CONMENSAJES=1 print 'Intentando inscribir materia '+cast(@MATERIA as varchar)
 WHILE (@@FETCH_STATUS = 0)
 BEGIN
  IF @CONMENSAJES=1 print 'Prereq:'+cast(@prereq_cve as varchar)+' Enlace:'+ISNULL(@enlace,'NULL')+' Orden:'+cast(@prereq_orden as varchar)+' Aprobo:'+cast(@prereq_aprobo as varchar)
  --Si no tiene aprobado un prereq 'Y' o 'NULO' (excepto cuando se aprobó un prerequisito 'O' anterior)
  IF @prereq_aprobo = 0 AND (@enlace='Y' OR @enlace IS NULL) AND @bandera_or = 0
  BEGIN
   IF @CONMENSAJES=1 print 'No cumple: Prereq:'+cast(@prereq_cve as varchar)+' Enlace:'+ISNULL(@enlace,'NULL')+' Orden:'+cast(@prereq_orden as varchar)+' Aprobo:'+cast(@prereq_aprobo as varchar)
   CLOSE PREREQ
   DEALLOCATE PREREQ
   RETURN 1
  END
  
  --Si se aprobó el prerequisito 'O', prender bandera hasta encontrar un prereq 'Y' o 'NULO'
  IF @prereq_aprobo > 0 AND @enlace='O'
  SET @bandera_or = 1
     
  --Si se llega a un prerequisito 'Y' o 'NULO', resetear la bandera_or
  IF (@enlace = 'Y' OR @enlace IS NULL) AND @bandera_or = 1
  SET @bandera_or = 0

  --Siguiente registro
  FETCH NEXT FROM PREREQ INTO @prereq_cve, @enlace, @prereq_orden, @prereq_aprobo
 END
 
 CLOSE PREREQ
 DEALLOCATE PREREQ
 IF @CONMENSAJES=1 print 'Si cumple Prerequisitos Materia '+cast(@MATERIA as varchar)
 RETURN 0
END
ELSE
 RETURN 0
GO

