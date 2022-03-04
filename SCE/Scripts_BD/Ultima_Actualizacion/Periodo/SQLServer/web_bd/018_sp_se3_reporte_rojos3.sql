USE [web_bd]
GO
/****** Object:  StoredProcedure [dbo].[sp_se3_reporte_rojos3]    Script Date: 27/9/2017 11:44:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROC [dbo].[sp_se3_reporte_rojos3]  
@cve_division int,  
 @cve_departamento int,  
 @cve_coordinacion int,  
 @mostrar_todos tinyint,
 @cve_prof int = 0,
 @tipo_periodo tinyint = 1,
 @soloAsignatura int,
 @periodoD int
AS  


DECLARE
 @pIni Char(5),  
 @pFin Char(5),
 @sepe float
    
declare @anio_act smallint, @per_act tinyint, @var_per_act int,   
  @per_prof char(10), @var_per_prof smallint, @cont smallint, @cve_profesor int,  
  @per1 varchar(10),@per2 varchar(10),@per3 varchar(10),@val_per1 smallint,@val_per2 smallint,@val_per3 smallint,  
  @val_p1 char(5),@val_p2 char(5),@val_p3 char(5), @idd float, @idd1 float, @idd2 float, @idd3 float  
  
-- tabla donde se guardaran los 3 ultimos idd de los profesores  
create table #tmp_profs_idd3(  
 cve_coordinacion int,   
 cve_profesor int,
 sepe1 float,  
 idd float,  
 per1 char(10),  
 per2 char(10),  
 per3 char(10),  
 val_per1 int,  
 val_per2 int,  
 val_per3 int,     
 idd_per1 float,  
 idd_per2 float,  
 idd_per3 float  
)  
  
--Se evalua el tipo periodo a consultar
DECLARE @tblPeriodos AS TABLE
(
	id_periodo tinyint
)

IF( @tipo_periodo = 1 ) --Semestral
BEGIN
	INSERT INTO @tblPeriodos 
	VALUES
	(0) --Primavera
	INSERT INTO @tblPeriodos
	VALUES
	(2)--Otoño   (1 - Verano no aplica en este reporte)
END
ELSE -- Trimestral, Cuatrimestral
BEGIN
	DECLARE @num_registros INT

	-- MALH 27/09/2017 SE AGREGA CONSULTA
	SELECT @num_registros = COUNT(1)
	FROM controlescolar_bd.dbo.periodo_tipo
	WHERE id_tipo  = 'T'

	IF @num_registros = 1 BEGIN
		INSERT INTO @tblPeriodos
		SELECT periodo
		FROM controlescolar_bd.dbo.periodo
		WHERE tipo = 'T'
	END 

	-- MALH 27/09/2017 SE AGREGA CONSULTA
	SELECT @num_registros = COUNT(1)
	FROM controlescolar_bd.dbo.periodo_tipo
	WHERE id_tipo  = 'Q'

	IF @num_registros = 1 BEGIN
		INSERT INTO @tblPeriodos
		SELECT periodo
		FROM controlescolar_bd.dbo.periodo
		WHERE tipo = 'Q'
	END 

	-- MALH 27/09/2017 SE COMENTA
	/*
	INSERT INTO @tblPeriodos
	VALUES
	(3) --Trimestral I
	INSERT INTO @tblPeriodos
	VALUES
	(4) --Trimestral 2
	INSERT INTO @tblPeriodos
	VALUES
	(5) --Trimestral 3
	INSERT INTO @tblPeriodos
	VALUES
	(6) --Trimestral 4
	*/
END
  
  
IF( @periodoD = 0 )
	BEGIN
		-- Obtener ultimo periodo de SEPE  
		select top 1 @anio_act = anio,   
		  @per_act = periodo,   
		  @var_per_act = anio * 10 + periodo   
		from ec_estatus  
		where estatus_proceso = 1  
		and periodo in (SELECT id_periodo FROM @tblPeriodos) 
		order by anio desc, periodo desc  
	END
ELSE
	BEGIN
		-- Nvo. Req. Se debe pasar el periodo desde la forma
		SET @anio_act	 = SUBSTRING(Cast(@periodoD as char), 1, 4) 
		SET @per_act	 = SUBSTRING(Cast(@periodoD as char), 5, 1)
		SET @var_per_act = SUBSTRING(Cast(@periodoD as char), 1, 5)
	END
  

-- Obtener los profesores que impartieron clase el ultimo semestre del SEPE  
select gp.cve_coordinacion, gp.cve_profesor  
into #tmp_profs_act  
from se3_sepe2_promsepegrupos gp
INNER JOIN v_ec_div_dep_cord vddc ON (vddc.cve_coordinacion =  gp.cve_coordinacion)  
Where   gp.cve_coordinacion = case @cve_coordinacion when 0 then gp.cve_coordinacion else @cve_coordinacion end  
AND vddc.cve_depto = case @cve_departamento when 0 then vddc.cve_depto else @cve_departamento end  
AND vddc.cve_division = case @cve_division when 0 then vddc.cve_division else @cve_division end  
And  gp.cve_profesor Not In (1, 5)  
And  gp.status = 'A'  
and  gp.anio = @anio_act  
and  gp.periodo = @per_act  
AND  gp.cve_profesor = CASE WHEN @cve_prof = 0 THEN gp.cve_profesor ELSE @cve_prof END
Group by gp.cve_coordinacion, gp.cve_profesor  


	--Modificacion para recuperar datos de un profesor en específico
	--Si no se encuentran datos del profesor solicitado, se omite el filtrado por el ultimo periodo
	IF NOT EXISTS( SELECT cve_profesor FROM #tmp_profs_act WHERE cve_profesor = @cve_prof )
	BEGIN
		--Indica que se requieren de un profesor en específico, por lo que se recupera la información del ultimo semestre del que se tanga registro
		IF ( @cve_prof != 0 )
			INSERT INTO #tmp_profs_act
			(cve_coordinacion, cve_profesor)
			SELECT gp.cve_coordinacion, gp.cve_profesor  
			from se3_sepe2_promsepegrupos gp
			INNER JOIN v_ec_div_dep_cord vddc ON (vddc.cve_coordinacion =  gp.cve_coordinacion)  
			Where   gp.cve_coordinacion = case @cve_coordinacion when 0 then gp.cve_coordinacion else @cve_coordinacion end  
			AND vddc.cve_depto = case @cve_departamento when 0 then vddc.cve_depto else @cve_departamento end  
			AND vddc.cve_division = case @cve_division when 0 then vddc.cve_division else @cve_division end  
			And  gp.cve_profesor Not In (1, 5)  
			AND  gp.cve_profesor = @cve_prof
			And  gp.status = 'A'  
			Group by gp.cve_coordinacion, gp.cve_profesor  
	END
	---Fin Modificacion


-- Obtener profesores que hayan impartido 3 o mas semestres anteriormente  
select g.cve_coordinacion, g.cve_profesor  
into #tmp_profs_3sem  
from se3_sepe2_promsepegrupos g,  
  #tmp_profs_act p  
Where   g.cve_coordinacion = p.cve_coordinacion  
And  g.cve_profesor = p.cve_profesor  
And  g.status = 'A'  
and  g.periodo IN (SELECT id_periodo FROM @tblPeriodos) 
And  g.cve_profesor Not In (1, 5)  
Group by g.cve_coordinacion, g.cve_profesor  
Having Count(Distinct g.anio*10+g.periodo) >= CASE WHEN @cve_prof = 0 THEN 3 ELSE 1 END  
order by g.cve_coordinacion, g.cve_profesor  


-- Ciclo para todos los profesores con mas de 3 semetres  
while exists ( select 1 from #tmp_profs_3sem )  
begin  
  
 set rowcount 1  
 select @cve_coordinacion = cve_coordinacion,  
   @cve_profesor = cve_profesor  
 from #tmp_profs_3sem  
   
 delete from #tmp_profs_3sem  
 set rowcount 0  
   
 -- Obtener cuales fueron los ultimos 3 semestres que impartio el profesor  
 select top 3 
  RTRIM(LTRIM(P.inicial)) + ' - ' + Cast(se.anio As Char(4)) nom_periodo,  
  se.anio * 10 + se.periodo as val_per   
 into #tmp_periodos_prof  
 from se3_sepe2_promsepegrupos as se INNER JOIN
 ec_cat_periodo AS P ON P.periodo = se.periodo   
 Where   se.cve_coordinacion = @cve_coordinacion  
 And  se.cve_profesor = @cve_profesor  
 And  se.status = 'A'  
 and  se.periodo IN (SELECT id_periodo FROM @tblPeriodos)    
 And  se.anio * 10 + se.periodo <= @var_per_act  
 group by se.anio, se.periodo, p.inicial   
 order by se.anio DESC, se.periodo DESC  
 
 ---------
 --Modificacion obtener sepe1
 --Se obtiene el sepe1, de los ultimos 3 semestres impartidos por el profesor (o los ultimos impartidos).
 ---------
 select @pIni = MIN(val_per) from #tmp_periodos_prof
 select @pFin = MAX(val_per) from #tmp_periodos_prof
  
 Select  
  @sepe = Cast(Sum(gp.sepe * gp.cuestionarios) / Sum(gp.cuestionarios)As Decimal(12,2))
 From  se3_sepe2_promsepegrupos gp
 INNER JOIN v_ec_div_dep_cord vddc ON (vddc.cve_coordinacion =  gp.cve_coordinacion)  
Where   gp.cve_coordinacion = case @cve_coordinacion when 0 then gp.cve_coordinacion else @cve_coordinacion end  
AND vddc.cve_depto = case @cve_departamento when 0 then vddc.cve_depto else @cve_departamento end  
AND vddc.cve_division = case @cve_division when 0 then vddc.cve_division else @cve_division end     
 AND  gp.cve_coordinacion = @cve_coordinacion
	And gp.tipo <> 2      
	And gp.cve_profesor Not In (1, 5)  
	And gp.cve_profesor = @cve_profesor 
	And (gp.cve_coordinacion <> 4600 or (gpo <> 'S' and gpo <> 'M'))   
	AND Cast(gp.anio As Char(4)) + Cast(gp.periodo As Char(1)) Between @pIni And @pFin  
	AND gp.periodo IN (SELECT id_periodo FROM @tblPeriodos) 
	AND gp.status = 'A' 
 Group By gp.cve_profesor
 ---------
 --Fin obtener sepe1
 ---------

 
 --contador para saber que en periodo vamos  
 set @cont = 1  
 while exists ( select 1 from #tmp_periodos_prof )  
 begin  
  set rowcount 1  
    
   select @per_prof = nom_periodo,  
    @var_per_prof = val_per  
  from #tmp_periodos_prof  
    
  delete from #tmp_periodos_prof  
  set rowcount 0  
   
  if @cont = 1  
  begin  
   set @val_per1 = @var_per_prof  
   set @per1 = @per_prof  
  end  
  if @cont = 2  
  begin  
   set @val_per2 = @var_per_prof  
   set @per2 = @per_prof  
  end  
  if @cont = 3  
  begin  
   set @val_per3 = @var_per_prof  
   set @per3 = @per_prof  
  end  
      
  set @cont = @cont+1  
 end  
   
 --insertar los datos del profesor en la tabla de profesores idd3 3  
 insert into #tmp_profs_idd3(cve_coordinacion,cve_profesor, sepe1, per1,per2,per3,val_per1,val_per2,val_per3)   
 values(@cve_coordinacion,@cve_profesor, @sepe,@per1,@per2,@per3,@val_per1,@val_per2,@val_per3)  
   
 drop table #tmp_periodos_prof  
       
end      
  
create table #tmp_rojos3(  
 cve_coordinacion int,   
 cve_profesor int,  
 sepe1 float,
 idd float,  
 per1 char(10),  
 per2 char(10),  
 per3 char(10),  
 idd_per1 float,  
 idd_per2 float,  
 idd_per3 float  
)  
  
-- Ciclo para todos los profesores con mas de 3 semetres  
while exists ( select 1 from #tmp_profs_idd3 )  
begin  
  
 set rowcount 1  
 select @cve_coordinacion = cve_coordinacion,  
   @cve_profesor = cve_profesor,  
   @sepe = sepe1,
   @per1 = per1,  
   @per2 = per2,  
   @per3 = per3,     
   @val_p1 = cast(val_per1 as CHAR(5)),  
   @val_p2 = cast(val_per2 as CHAR(5)),  
   @val_p3 = cast(val_per3 as CHAR(5))     
 from #tmp_profs_idd3  
   
 delete from #tmp_profs_idd3  
 set rowcount 0  
  
 select @idd  = dbo.obtener_idd3_prof(@cve_coordinacion,@cve_profesor,@val_p1,@val_p2,@val_p3)   
   
 -- solo se registraran los profesores que en sus ultimos 3 semestres impartidos hayan tenido idd3 en rojo  
 -- o a todos los profesores de la coordinacion, dependiendo del argumento  
 if @idd < .64 OR @mostrar_todos = 1  
 begin  
  select @idd1 = dbo.obtener_idd3_prof(@cve_coordinacion,@cve_profesor,@val_p1,@val_p1,@val_p1)   
  select @idd2 = dbo.obtener_idd3_prof(@cve_coordinacion,@cve_profesor,@val_p2,@val_p2,@val_p2)   
  select @idd3 = dbo.obtener_idd3_prof(@cve_coordinacion,@cve_profesor,@val_p3,@val_p3,@val_p3)    
    
  insert into #tmp_rojos3 values (@cve_coordinacion,@cve_profesor,@sepe,@idd,@per1,@per2,@per3,@idd1,@idd2,@idd3)  

  --- Para que no aparezcan los periodos en 0, si es que el profesor no impartió clase
  DELETE FROM  #tmp_rojos3 WHERE (idd_per2 IS NULL OR idd_per3 IS NULL)
 end   
   
end  
  
drop table #tmp_profs_act  
drop table #tmp_profs_3sem  
drop table #tmp_profs_idd3  
  
IF @soloAsignatura = 1
	select 
		em.tipo_nomina,
		r.cve_coordinacion,
		r.cve_profesor,
		r.sepe1,  
		r.idd * 100 idd,  
		RTRIM(per1) per1,
		RTRIM(per2) per2,
		RTRIM(per3) per3,  
		idd_per1*100 idd_per1,  
		idd_per2*100 idd_per2,  
		idd_per3*100 idd_per3,  
		RTRIM(LTRIM(isnull(p.apaterno,'')+' '+isnull(p.amaterno,'')+' '+ISNULL(p.nombre,''))) nombre   
	from #tmp_rojos3 r,  
		 v_www_profesor p  
		 LEFT JOIN SQLINTDES.sip2000.dbo.empleados em ON (em.nomina = p.cve_profesor)
	where r.cve_profesor = p.cve_profesor 
	AND    em.nomina = r.cve_profesor
	AND r.cve_profesor = CASE WHEN @cve_prof = 0 THEN r.cve_profesor ELSE @cve_prof END
	AND		em.tipo_nomina IN (3)
ELSE IF @soloAsignatura = 0
	select 
		em.tipo_nomina,
		r.cve_coordinacion,
		r.cve_profesor,
		r.sepe1,  
		r.idd * 100 idd,  
		RTRIM(per1) per1,
		RTRIM(per2) per2,
		RTRIM(per3) per3,  
		idd_per1*100 idd_per1,  
		idd_per2*100 idd_per2,  
		idd_per3*100 idd_per3,  
		RTRIM(LTRIM(isnull(p.apaterno,'')+' '+isnull(p.amaterno,'')+' '+ISNULL(p.nombre,''))) nombre   
	from #tmp_rojos3 r,  
		 v_www_profesor p  
		 LEFT JOIN SQLINTDES.sip2000.dbo.empleados em ON (em.nomina = p.cve_profesor)
	where r.cve_profesor = p.cve_profesor
	AND    em.nomina = r.cve_profesor    
	AND r.cve_profesor = CASE WHEN @cve_prof = 0 THEN r.cve_profesor ELSE @cve_prof END
	AND		em.tipo_nomina IN (1,2,3)
ELSE
	select 
		r.cve_coordinacion,
		r.cve_profesor,
		r.sepe1,  
		r.idd * 100 idd,  
		RTRIM(per1) per1,
		RTRIM(per2) per2,
		RTRIM(per3) per3,  
		idd_per1*100 idd_per1,  
		idd_per2*100 idd_per2,  
		idd_per3*100 idd_per3,  
		RTRIM(LTRIM(isnull(p.apaterno,'')+' '+isnull(p.amaterno,'')+' '+ISNULL(p.nombre,''))) nombre   
	from #tmp_rojos3 r,  
	  v_www_profesor p  
	where r.cve_profesor = p.cve_profesor    
	AND r.cve_profesor = CASE WHEN @cve_prof = 0 THEN r.cve_profesor ELSE @cve_prof END
  
drop table #tmp_rojos3  
GO

GRANT EXECUTE ON [dbo].[sp_se3_reporte_rojos3] TO public
GO

