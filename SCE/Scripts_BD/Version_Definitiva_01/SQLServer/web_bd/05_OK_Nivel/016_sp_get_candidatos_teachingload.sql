USE [web_bd]
GO

ALTER PROC [dbo].[sp_get_candidatos_teachingload]  
 @cve_coord int,   
 @cve_depto int
AS  
  
DECLARE @anio smallint, @periodo tinyint  
  
BEGIN  
  
--SE OBTIENEN LOS PROFESORES APLICANDO LOS FILTROS CORRESPONDIENTES  
  
--Primero, que sean profesores de asignatura, con grado de Maestria , Doctorado o Licenciatura (este último solo aplica para Coordinaciones de tipo TSU)  
SELECT	e.nomina as cve_profesor,  
		max(h.nivel_estudios) as grado  
INTO	#tmp_profs_asig  
FROM	SQLINTDES.sip2000.dbo.empleados e,  
		SQLINTDES.sip2000.dbo.hst_estudios h  
WHERE	e.nomina = h.num_empleado  
AND		e.tipo_nomina = 3  
AND		h.nivel_estudios IN (5,6,7)  
GROUP BY e.nomina  
  
--Pueden haber 2 periodos cargados en la tabla de grupos, utiliar el mas antiguo  
/*SELECT TOP 1 @anio = g.anio, @periodo = g.periodo  
FROM v_sce_grupos g  
WHERE g.periodo <> 1  
GROUP BY g.anio, g.periodo  
ORDER BY g.anio, g.periodo */ 
SELECT @anio = anio, @periodo = periodo FROM tl_periodos where activo = 1 

--Profesores que imparten clase actualmente  
SELECT g.anio, g.periodo,  
  g.cve_profesor,   
  sum(m.horas_reales) as horas,  
  ( SELECT MAX(sepe.anio*10+sepe.periodo)  
     --MAX(Cast(sepe.anio As Char(4)) + Cast(sepe.periodo As Char(1)))  
   FROM se3_sepe2_promsepegrupos sepe  
   WHERE sepe.cve_profesor = g.cve_profesor  
   AND  sepe.status = 'A'  
   AND  sepe.periodo <> 1  
   AND  sepe.nivel <> 'P' ) ult_periodo    
INTO #tmp_profs  
FROM (SELECT
		sg.anio,
		sg.periodo,
		sg.cve_profesor,
		sg.cve_mat,
		sg.cve_asimilada,
		sg.tipo
	FROM v_sce_grupos sg
	UNION
	SELECT
		hg.anio,
		hg.periodo,
		hg.cve_profesor,
		hg.cve_mat,
		hg.cve_asimilada,
		hg.tipo
	FROM v_sce_hist_grupos hg) g,  
  v_www_materias_1 m,  
  #tmp_profs_asig pa  
WHERE g.cve_mat = m.cve_mat  
AND  g.cve_profesor = pa.cve_profesor  
AND  m.nivel <> 'P'  
AND  g.cve_asimilada IS NULL  
AND  g.periodo <> 1  
AND  g.anio = @anio  
AND  g.periodo = @periodo  
AND  g.tipo = 0  
GROUP BY g.anio, g.periodo, g.cve_profesor  
ORDER BY g.anio, g.periodo  


--Se obtiene el periodo anterior inmediato al actual (sin considerar veranos)  
--Hasta este punto los veranos ya están filtrados  
SELECT @anio =  
CASE @periodo   
 WHEN (SELECT MIN(periodo) FROM ec_cat_periodo) THEN (SELECT @anio-1)  
 WHEN (SELECT MAX(periodo) FROM ec_cat_periodo) THEN (SELECT @anio)  
END   
SELECT @periodo =  
CASE @periodo   
 WHEN (SELECT MIN(periodo) FROM ec_cat_periodo) THEN (SELECT MAX(periodo) FROM ec_cat_periodo WHERE periodo NOT IN(1,@periodo))  
 WHEN (SELECT MAX(periodo) FROM ec_cat_periodo) THEN (SELECT MAX(periodo) FROM ec_cat_periodo WHERE periodo NOT IN(1,@periodo))  
END   
  
--NO TSU  
--Que hayan impartido clase en el periodo inmediato anterior (sin considerar veranos) y que hayan impartido entre 8 y 12 horas de clase   
SELECT p.cve_profesor, p.ult_periodo, sum(m.horas_reales) as horas  
INTO #tmp_prof_sel    
FROM #tmp_profs p,  
  v_www_hist_grupos g,  
  v_www_materias_1 m  
WHERE p.cve_profesor = g.cve_profesor  
AND  p.ult_periodo = ( g.anio*10 + g.periodo)  
AND  p.ult_periodo = (@anio*10 + @periodo)  
AND  g.cve_mat = m.cve_mat  
AND  m.nivel <> 'P'  
AND  g.cve_asimilada IS NULL  
AND  g.tipo = 0  
AND m.cve_coordinacion NOT IN (select cve_coordinacion from v_www_coordinaciones WHERE coordinacion LIKE 'TSU%')  
GROUP BY p.cve_profesor, p.ult_periodo  
HAVING sum(m.horas_reales) BETWEEN 8 AND 12  
  
--TSU  
--Que hayan impartido clase en el periodo inmediato anterior (sin considerar veranos) y que hayan impartido entre 3 y 12 horas de clase   
INSERT INTO #tmp_prof_sel  
SELECT p.cve_profesor, p.ult_periodo, sum(m.horas_reales) as horas  
FROM #tmp_profs p,  
  v_www_hist_grupos g,  
  v_www_materias_1 m  
WHERE p.cve_profesor = g.cve_profesor  
AND  p.ult_periodo = ( g.anio*10 + g.periodo)  
AND  g.cve_mat = m.cve_mat  
AND  m.nivel <> 'P'  
AND  g.cve_asimilada IS NULL  
AND  g.tipo = 0  
AND m.cve_coordinacion IN (select cve_coordinacion from v_www_coordinaciones WHERE coordinacion LIKE 'TSU%')  
GROUP BY p.cve_profesor, p.ult_periodo  
HAVING sum(m.horas_reales) BETWEEN 3 AND 12  
  
  
--NO TSU  
Select  div.cve_division, div.division,  
   dep.cve_depto, dep.departamento,     
   cord.cve_coordinacion, cord.coordinacion,   
   cve_profesor, nombre_completo As nombre,  
            Case When Sum(Case When promedio = 0 Then 0 Else inscritos1 End) = 0 Then (((Sum(sepe * cuestionarios) / Sum(cuestionarios)) - 1) / 4) Else (Cast((0.25 * Sum(sepe * cuestionarios) / Sum(cuestionarios) - 0.08375 - 0.021875 * Sum(promedio * inscritos1) / Sum(Case When promedio = 0 Then 0 Else inscritos1 End))As Decimal(12, 4))) End As idd,  
            MAX(anio*10+periodo) max_periodo  
Into  #temp_idds              
From  (  
                SELECT g.*   
                FROM se3_sepe2_promsepegrupos g,  
      #tmp_prof_sel p  
                WHERE p.cve_profesor = g.cve_profesor  
    AND  p.ult_periodo = ( g.anio*10 + g.periodo)  
    AND  p.ult_periodo = (@anio*10 + @periodo)  
                AND  g.periodo <> 1  
                AND  g.status = 'A'  
            )As res,  
   v_www_coordinaciones cord,  
   v_www_departamentos dep,  
   v_www_divisiones div  
Where  res.cve_coordinacion = cord.cve_coordinacion  
   And cord.cve_depto = dep.cve_depto  
   And dep.cve_division = div.cve_division  
   And tipo <> 2      
            And (res.cve_coordinacion <> 4600 or (gpo <> 'S' and gpo <> 'M'))   
            And res.cve_coordinacion = Case When @cve_coord = 0 Then res.cve_coordinacion Else @cve_coord End   
   And cord.cve_depto = Case When @cve_depto = 0 Then cord.cve_depto Else @cve_depto End   
   AND cord.cve_coordinacion NOT IN (select cve_coordinacion from v_www_coordinaciones WHERE coordinacion LIKE 'TSU%')  
Group By div.cve_division, div.division,  
   dep.cve_depto, dep.departamento,     
   cord.cve_coordinacion, cord.coordinacion,   
   cve_profesor, nombre_completo, nivel  
     
--TSU   
INSERT INTO #temp_idds    
Select  div.cve_division, div.division,  
dep.cve_depto, dep.departamento,     
cord.cve_coordinacion, cord.coordinacion,   
cve_profesor, nombre_completo As nombre,  
Case When Sum(Case When promedio = 0 Then 0 Else inscritos1 End) = 0 Then (((Sum(sepe * cuestionarios) / Sum(cuestionarios)) - 1) / 4) Else (Cast((0.25 * Sum(sepe * cuestionarios) / Sum(cuestionarios) - 0.08375 - 0.021875 * Sum(promedio * inscritos1) / Sum(Case When promedio = 0 Then 0 Else inscritos1 End))As Decimal(12, 4))) End As idd,  
MAX(anio*10+periodo) max_periodo  
From  (  
    SELECT g.*   
    FROM se3_sepe2_promsepegrupos g,  
   #tmp_prof_sel p  
    WHERE p.cve_profesor = g.cve_profesor  
 AND  p.ult_periodo = ( g.anio*10 + g.periodo)  
    AND  g.periodo <> 1  
    AND  g.status = 'A'  
)As res,  
v_www_coordinaciones cord,  
v_www_departamentos dep,  
v_www_divisiones div  
Where  res.cve_coordinacion = cord.cve_coordinacion  
 And cord.cve_depto = dep.cve_depto  
 And dep.cve_division = div.cve_division  
 And tipo <> 2      
 And (res.cve_coordinacion <> 4600 or (gpo <> 'S' and gpo <> 'M'))   
 And res.cve_coordinacion = Case When @cve_coord = 0 Then res.cve_coordinacion Else @cve_coord End   
 And cord.cve_depto = Case When @cve_depto = 0 Then cord.cve_depto Else @cve_depto End   
 AND cord.cve_coordinacion IN (select cve_coordinacion from v_www_coordinaciones WHERE coordinacion LIKE 'TSU%')  
Group By div.cve_division, div.division,  
dep.cve_depto, dep.departamento,     
cord.cve_coordinacion, cord.coordinacion,   
cve_profesor, nombre_completo, nivel  
  
  
Update #temp_idds  
Set  idd = idd * isNull(( Select f.factor  
        From ec_idd_coordinacion f  
        Where f.anio*10+periodo = #temp_idds.max_periodo  
        And  f.cve_coordinacion = #temp_idds.cve_coordinacion ),1)  
   
          
SELECT hrs_act.anio, hrs_act.periodo,  
  cve_division, division, cve_depto, departamento, cve_coordinacion, coordinacion,  
  prof.cve_profesor, prof.nombre, (prof.idd *100) as idd,   
  ( CASE est.grado WHEN 7 THEN 'DOCTORADO' WHEN 6 THEN 'MAESTRIA'  ELSE 'LICENCIATURA'  END ) as grado, est.grado as id_grado,  
  hrs_act.horas as horas_act, hrs_ant.horas as horas_ant, prof.max_periodo  
INTO #tblFinal  
FROM #temp_idds prof,  
  #tmp_profs_asig est,  
  #tmp_profs hrs_act,  
  #tmp_prof_sel hrs_ant  
WHERE prof.cve_profesor = est.cve_profesor  
AND  prof.cve_profesor = hrs_act.cve_profesor  
AND  prof.cve_profesor = hrs_ant.cve_profesor  
AND  idd >= .7  
--Se filtran las coordinaciones de posgrado (se omiten)  
AND cve_coordinacion in (SELECT cve_coordinacion  
      FROM   v_ec_depto_coord_mat  
      WHERE  nivel <> 'P'  
      GROUP BY cve_coordinacion, coordinacion, cve_depto)  
  
--Se descartan los profesores de Licenciatura, que no pertenezcan a una Coordinación de TSU  
DELETE FROM #tblFinal  
WHERE id_grado = 5 AND coordinacion NOT LIKE 'TSU%'  
  
--Se descartan los profesores que no pertenezcan a una Coordinación de TSU y que tienen menos de 8 Horas  
DELETE FROM #tblFinal  
WHERE coordinacion NOT LIKE 'TSU%' AND horas_ant < 8  
        
--FIN PROFESORES APLICANDO FILTROS  
  
--==============================================================        
        
--SE OBTIENEN LOS PROFESORES MARCADOS COMO EXCEPCION  
  
--Pueden haber 2 periodos cargados en la tabla de grupos, utiliar el mas antiguo  
/*SELECT TOP 1 @anio = g.anio, @periodo = g.periodo  
FROM v_sce_grupos g  
WHERE g.periodo <> 1  
GROUP BY g.anio, g.periodo  
ORDER BY g.anio, g.periodo  */
SELECT @anio = anio, @periodo = periodo FROM tl_periodos where activo = 1 

--Se agregan los profesores excepción  
SELECT e.cve_prof as cve_profesor,  
  max(h.nivel_estudios) as grado  
INTO #tmp_profs_exp  
FROM tl_teaching_load e,  
  SQLINTDES.sip2000.dbo.hst_estudios h  
WHERE e.cve_prof = h.num_empleado  
AND  e.excep = 1  
AND e.anio = @anio  
AND e.periodo = @periodo  
GROUP BY e.cve_prof  
  
  
--Se obtienen columnas de las excepciones  
SELECT g.anio, g.periodo,  
  g.cve_profesor,   
  sum(m.horas_reales) as horas,  
  ( SELECT MAX(sepe.anio*10+sepe.periodo)  
   FROM se3_sepe2_promsepegrupos sepe  
   WHERE sepe.cve_profesor = g.cve_profesor  
   AND  sepe.status = 'A'  
   AND  sepe.periodo <> 1  
   AND  sepe.nivel <> 'P' ) ult_periodo    
INTO #tmp_profs_excp  
FROM (SELECT
		sg.anio,
		sg.periodo,
		sg.cve_profesor,
		sg.cve_mat,
		sg.cve_asimilada,
		sg.tipo
	FROM v_sce_grupos sg
	UNION
	SELECT
		hg.anio,
		hg.periodo,
		hg.cve_profesor,
		hg.cve_mat,
		hg.cve_asimilada,
		hg.tipo
	FROM v_sce_hist_grupos hg) g,  
  v_www_materias_1 m,  
  #tmp_profs_exp pa  
WHERE g.cve_mat = m.cve_mat  
AND  g.cve_profesor = pa.cve_profesor  
--AND  m.nivel = 'L'  
AND  g.cve_asimilada IS NULL  
AND  g.periodo <> 1  
AND  g.anio = @anio  
AND  g.periodo = @periodo  
--AND  g.tipo = 0  
GROUP BY g.anio, g.periodo, g.cve_profesor  
ORDER BY g.anio, g.periodo  
  
  
--Se obtiene IDD y otros de excepciones  
Select  div.cve_division, div.division,  
   dep.cve_depto, dep.departamento,     
   cord.cve_coordinacion, cord.coordinacion,   
   cve_profesor, nombre_completo As nombre,  
            Case When Sum(Case When promedio = 0 Then 0 Else inscritos1 End) = 0 Then (((Sum(sepe * cuestionarios) / Sum(cuestionarios)) - 1) / 4) Else (Cast((0.25 * Sum(sepe * cuestionarios) / Sum(cuestionarios) - 0.08375 - 0.021875 * Sum(promedio * inscritos1) / Sum(Case When promedio = 0 Then 0 Else inscritos1 End))As Decimal(12, 4))) End As idd,  
            MAX(anio*10+periodo) max_periodo  
Into  #temp_idds_excp              
From  (  
                SELECT g.*   
                FROM se3_sepe2_promsepegrupos g,  
      #tmp_profs_excp p  
                WHERE p.cve_profesor = g.cve_profesor  
    AND  p.ult_periodo = ( g.anio*10 + g.periodo)  
    --AND  p.ult_periodo = (@anio*10 + @periodo)  
                AND  g.periodo <> 1  
                AND  g.status = 'A'  
            )As res,  
   v_www_coordinaciones cord,  
   v_www_departamentos dep,  
   v_www_divisiones div  
Where  res.cve_coordinacion = cord.cve_coordinacion  
   And cord.cve_depto = dep.cve_depto  
   And dep.cve_division = div.cve_division  
   And tipo <> 2      
            And (res.cve_coordinacion <> 4600 or (gpo <> 'S' and gpo <> 'M'))   
            And res.cve_coordinacion = Case When @cve_coord = 0 Then res.cve_coordinacion Else @cve_coord End   
   And cord.cve_depto = Case When @cve_depto = 0 Then cord.cve_depto Else @cve_depto End   
   --AND cord.cve_coordinacion NOT IN (select cve_coordinacion from v_www_coordinaciones WHERE coordinacion LIKE 'TSU%')  
Group By div.cve_division, div.division,  
   dep.cve_depto, dep.departamento,     
   cord.cve_coordinacion, cord.coordinacion,   
   cve_profesor, nombre_completo, nivel  
        
  
--Se actualiza el IDD de excepciones         
Update #temp_idds_excp  
Set  idd = idd * isNull(( Select f.factor  
        From ec_idd_coordinacion f  
        Where f.anio*10+periodo = #temp_idds_excp.max_periodo  
        And  f.cve_coordinacion = #temp_idds_excp.cve_coordinacion ),1)  
             
        
--Se obtienen columnas extras de las excepciones   
SELECT hrs_act.anio, hrs_act.periodo,  
  cve_division, division, cve_depto, departamento, cve_coordinacion, coordinacion,  
  prof.cve_profesor, prof.nombre, (prof.idd *100) as idd,   
  ( CASE est.grado WHEN 7 THEN 'DOCTORADO' WHEN 6 THEN 'MAESTRIA'  ELSE 'LICENCIATURA'  END ) as grado, est.grado as id_grado,  
  hrs_act.horas as horas_act, hrs_ant.horas as horas_ant, prof.max_periodo  
INTO #tblFinal_excep  
FROM #temp_idds_excp prof,  
  #tmp_profs_exp est,  
  #tmp_profs_excp hrs_act,  
  #tmp_prof_sel hrs_ant  
WHERE prof.cve_profesor = est.cve_profesor  
AND  prof.cve_profesor = hrs_act.cve_profesor  
AND  prof.cve_profesor = hrs_ant.cve_profesor  
--AND  idd >= .7  
--Se filtran las coordinaciones de posgrado (se omiten)  
--AND cve_coordinacion in (SELECT cve_coordinacion  
--      FROM   v_ec_depto_coord_mat  
--      WHERE  nivel = 'L'  
--      GROUP BY cve_coordinacion, coordinacion, cve_depto)  
  
--FIN PROFESORES EXCEPCIONES  
  
--=============================================================================  
        
--SE UNEN LAS EXCEPCIONES AL QUERY PRINCIPAL      
        
--Se cruza el query de candidatos obtenidos, con la tabla de candidatos registrados  
SELECT   
 C.anio,  
 C.periodo,  
 C.cve_division,  
 C.division,  
 C.cve_depto,  
 C.departamento,  
 C.cve_coordinacion,  
 C.coordinacion,  
 C.cve_profesor,  
 C.nombre,  
 C.grado,  
 C.idd,  
 C.horas_act,  
 C.horas_ant,   
 C.max_periodo,  
 SUBSTRING(CAST(C.max_periodo AS CHAR(5)),1,4) anio_final,  
 SUBSTRING(CAST(C.max_periodo AS CHAR(5)),5,1) periodo_final,  
 P.inicial,  
 CASE   
 WHEN LEN(TL.cve_prof) = 0 THEN 0  
 WHEN LEN(TL.cve_prof) > 0 THEN 1  
 END as registrado,  
 TL.horas,  
 TL.excep  
FROM #tblFinal AS C LEFT OUTER JOIN  
tl_teaching_load AS TL ON TL.anio = C.anio  
AND TL.periodo = C.periodo   
AND TL.cve_coord = C.cve_coordinacion  
AND TL.cve_prof = C.cve_profesor INNER JOIN  
ec_cat_periodo AS P ON P.periodo = SUBSTRING(CAST(C.max_periodo AS CHAR(5)),5,1)  
--ORDER BY C.coordinacion, C.nombre  
  
UNION   
  
SELECT   
 C.anio,  
 C.periodo,  
 C.cve_division,  
 C.division,  
 C.cve_depto,  
 C.departamento,  
 C.cve_coordinacion,  
 C.coordinacion,  
 C.cve_profesor,  
 C.nombre,  
 C.grado,  
 C.idd,  
 C.horas_act,  
 C.horas_ant,   
 C.max_periodo,  
 SUBSTRING(CAST(C.max_periodo AS CHAR(5)),1,4) anio_final,  
 SUBSTRING(CAST(C.max_periodo AS CHAR(5)),5,1) periodo_final,  
 P.inicial,  
 1 as registrado,  
 TL.horas,  
 1  
FROM #tblFinal_excep AS C LEFT OUTER JOIN  
tl_teaching_load AS TL ON TL.anio = C.anio  
AND TL.periodo = C.periodo   
AND TL.cve_coord = C.cve_coordinacion  
AND TL.cve_prof = C.cve_profesor INNER JOIN  
ec_cat_periodo AS P ON P.periodo = SUBSTRING(CAST(C.max_periodo AS CHAR(5)),5,1)  
ORDER BY C.coordinacion, C.nombre  
  
  
drop table #tmp_profs_asig  
drop table #tmp_profs  
drop table #tmp_prof_sel  
drop table #temp_idds  
drop table #tblFinal  
  
DROP TABLE #tmp_profs_exp  
DROP TABLE #tmp_profs_excp  
DROP TABLE #temp_idds_excp  
DROP TABLE #tblFinal_excep  
  
END  
  

GO

