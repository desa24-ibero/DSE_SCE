USE controlescolar_bd 
go



ALTER PROCEDURE [dbo].[sp_valida_prerequisitos_reinsc]
 @CUENTA int,
 @MATERIA int,     
 @CARRERA int = 0,
 @PLAN int = 0,
 @CONMENSAJES int = 0
AS
DECLARE @prereq_cve int, @enlace varchar(5), @prereq_orden int, @prereq_aprobo int
DECLARE @bandera_or int
DECLARE @mi_prerreq_cursando int
/*
Modificado 2016-10-27		Antonio Pica
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
 SELECT p.cve_prerreq, p.enlace, p.orden,CASE ac.nivel WHEN 'P' THEN ISNULL(h.cve_mat,0) ELSE ISNULL(h.cve_mat,0) END
 FROM	controlescolar_bd.dbo.academicos ac
  					 INNER JOIN controlescolar_bd.dbo.prerrequisitos as p ON
  					 ac.cuenta = @CUENTA
  				 and p.cve_mat = @MATERIA
  				 and p.cve_plan = ac.cve_plan
  				 and p.cve_carrera = ac.cve_carrera
                     
                 	 LEFT OUTER JOIN controlescolar_bd.dbo.mat_inscritas as hp ON
                     p.cve_prerreq	= hp.cve_mat
                 and hp.cve_condicion = 0
                 and hp.cuenta	= ac.cuenta

  				     LEFT OUTER JOIN controlescolar_bd.dbo.historico as h ON
                     p.cve_prerreq	= h.cve_mat
                 and h.cve_plan = ac.cve_plan
                 and h.cve_carrera = ac.cve_carrera
                 and h.calificacion in ('AC' ,'6','7','8','9','10', 'MB','B','S','E','RE')
                 and h.cuenta	= ac.cuenta
                                  

 ORDER BY p.orden
 OPEN PREREQ
 FETCH NEXT FROM PREREQ INTO @prereq_cve, @enlace, @prereq_orden, @prereq_aprobo
 IF @CONMENSAJES=1 print 'Intentando inscribir materia '+cast(@MATERIA as varchar)
 WHILE (@@FETCH_STATUS = 0)
 BEGIN
  IF @CONMENSAJES=1 print 'Prereq:'+cast(@prereq_cve as varchar)+' Enlace:'+ISNULL(@enlace,'NULL')+' Orden:'+cast(@prereq_orden as varchar)+' Aprobo:'+cast(@prereq_aprobo as varchar)
--Consulta si está actualmente está cursando el prerrequisito correspondiente
   SELECT @mi_prerreq_cursando = isnull(cve_mat,0) 
   FROM controlescolar_bd.dbo.mat_inscritas as mi
   WHERE mi.cve_mat = @prereq_cve
   AND  mi.cve_condicion = 0
   AND  mi.cuenta = @CUENTA
--Si no tiene inscrita la materia actual (el resultset está vacío)
   IF (@@ROWCOUNT = 0 ) SET @mi_prerreq_cursando= 0
--Si está cursando el prerrequisito es como si "hubiera" aprobado este prerrequisito
   IF (@mi_prerreq_cursando > 0)
   BEGIN
		IF @CONMENSAJES=1 print 'Cursando:'+cast(@mi_prerreq_cursando as varchar)
		SET  @prereq_aprobo = 1
   END  


  --Si no tiene aprobado un prereq 'Y' o 'NULO' (excepto cuando se aprobó un prerequisito 'O' anterior)
  IF (@prereq_aprobo = 0 )AND (@enlace='Y' OR @enlace IS NULL) AND @bandera_or = 0
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

