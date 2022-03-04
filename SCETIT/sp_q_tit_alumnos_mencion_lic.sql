-----------------------------------------------------------------------------
-- DDL for Stored Procedure 'controlescolar_bd.dbo.sp_q_tit_alumnos_mencion_lic;1'
-----------------------------------------------------------------------------
 
print '<<<<< CREATING Stored Procedure - "controlescolar_bd.dbo.sp_q_tit_alumnos_mencion_lic;1" >>>>>'
go 
 
IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid=u.uid AND o.name = 'sp_q_tit_alumnos_mencion_lic' AND u.name = 'dbo' AND o.type = 'P')
BEGIN
                setuser 'dbo'
                drop procedure sp_q_tit_alumnos_mencion_lic
 
END
go 
 
IF (@@error != 0)
BEGIN
                PRINT "Error CREATING Stored Procedure 'controlescolar_bd.dbo.sp_q_tit_alumnos_mencion_lic;1'"
                SELECT syb_quit()
END
go
 
use controlescolar_bd
go
 
setuser 'dbo'
go 
 
CREATE PROCEDURE sp_q_tit_alumnos_mencion_lic @as_fecha_exam1 varchar(08),
                                                                                                                                                                              @as_fecha_exam2 varchar(08)
AS
BEGIN
-- Se depuran las tablas de trabajo
IF (SELECT COUNT(*) FROM tit_holograma_mencion) > 0
TRUNCATE TABLE tit_holograma_mencion
 
IF (SELECT COUNT(*) FROM tit_prom_mencion) > 0
TRUNCATE TABLE tit_prom_mencion
 
IF (SELECT COUNT(*) FROM tit_prom_reprob_mencion) > 0
TRUNCATE TABLE tit_prom_reprob_mencion
 
IF (SELECT COUNT(*) FROM tit_prom_bajas_mencion) > 0
TRUNCATE TABLE tit_prom_bajas_mencion
 
-- Alumnos en proceso de titulacion segun el periodo dado
INSERT INTO tit_holograma_mencion (num_holograma, cuenta, numero, fecha_emision, cve_carrera, cve_plan, 
                                                                                                                                ciclos_cursados, cancelado, orden_cobro, cve_doc_control_sep, del, al)
 
                SELECT s.num_holograma, s.cuenta, d.digito as digito, s.fecha_emision, s.cve_carrera, s.cve_plan,  
                                   s.ciclos_cursados, s.cancelado, 0 as orden_cobro, s. cve_doc_control_sep, t.fecha_examen as del, t.fecha_examen as al
                   FROM titulacion t, control_sep s, v_sce_alumno_digito d
                  WHERE t.cuenta = s.cuenta
                               AND t.cve_carrera = s.cve_carrera
                               AND t.cve_plan = s.cve_plan
                               AND t.cuenta = d.cuenta
                               AND t.aprobado = 1
                               AND s.cve_doc_control_sep = 4
                               AND convert(varchar(08), t.fecha_examen,112) >= @as_fecha_exam1
                               AND convert(varchar(08), t.fecha_examen,112) <= @as_fecha_exam2
                  ORDER BY s.num_holograma
                  
 
-- Alumnos que tienen promedio para mención
INSERT INTO tit_prom_mencion (cuenta, cve_carrera, promedio, cve_plan, mencion, pasan)
                SELECT tit_holograma_mencion.cuenta, tit_holograma_mencion.cve_carrera, round(dbo.academicos.promedio,6) as promedio, tit_holograma_mencion.cve_plan, dbo.carreras.promedio_mencion , 1 AS pasan
                   FROM ((tit_holograma_mencion LEFT JOIN dbo.academicos ON (tit_holograma_mencion.cuenta = dbo.academicos.cuenta) AND (tit_holograma_mencion.cve_carrera = dbo.academicos.cve_carrera)) 
                                                                                                                                             INNER JOIN dbo.carreras ON (tit_holograma_mencion.cve_carrera = dbo.carreras.cve_carrera) )
                  WHERE ((tit_holograma_mencion.cve_plan In (4,6)) AND (round(CONVERT(Numeric(8,2), dbo.academicos.promedio),1) >= round(dbo.carreras.promedio_mencion,1)) )
 
 
-- Alumnos que tienen promedio para mención pero tienen reprobadas
INSERT INTO tit_prom_reprob_mencion (cuenta, cve_carrera, cve_plan,cuenta_calificacion)
SELECT tit_prom_mencion.cuenta, tit_prom_mencion.cve_carrera, dbo.historico.cve_plan , Count(dbo.historico.calificacion) AS CuentaDecalificacion
FROM tit_prom_mencion INNER JOIN dbo.historico ON (tit_prom_mencion.cve_plan = dbo.historico.cve_plan) AND (tit_prom_mencion.cve_carrera = dbo.historico.cve_carrera) AND (tit_prom_mencion.cuenta = dbo.historico.cuenta)
WHERE (((dbo.historico.calificacion) In ("5","NA")))
GROUP BY tit_prom_mencion.cuenta, tit_prom_mencion.cve_carrera, dbo.historico.cve_plan
 
-- Alumnos que tienen prom de mencion pero tienen mas de 3 bajas inginndus
INSERT INTO tit_prom_bajas_mencion(cuenta, cve_carrera, cve_plan, cuenta_calificacion)
SELECT tit_prom_mencion.cuenta, tit_prom_mencion.cve_carrera, dbo.historico.cve_plan, Count(dbo.historico.calificacion) AS CuentaDecalificacion
FROM tit_prom_mencion INNER JOIN dbo.historico ON (tit_prom_mencion.cuenta = dbo.historico.cuenta) AND (tit_prom_mencion.cve_carrera = dbo.historico.cve_carrera) AND (tit_prom_mencion.cve_plan = dbo.historico.cve_plan)
WHERE (((dbo.historico.calificacion)="BA"))
GROUP BY tit_prom_mencion.cuenta, tit_prom_mencion.cve_carrera, dbo.historico.cve_plan
HAVING (((tit_prom_mencion.cve_carrera) In (2501,2803)) AND ((Count(dbo.historico.calificacion))>3))
 
SELECT tit_prom_mencion.cuenta, tit_holograma_mencion.numero as digito, tit_prom_mencion.cve_carrera, tit_prom_mencion.cve_plan, dbo.carreras.carrera, dbo.alumnos.nombre_completo, promedio
  FROM tit_prom_mencion INNER JOIN dbo.alumnos ON tit_prom_mencion.cuenta = dbo.alumnos.cuenta
                                                                                              INNER JOIN dbo.carreras ON tit_prom_mencion.cve_carrera = dbo.carreras.cve_carrera
                                                                                              INNER JOIN tit_holograma_mencion ON tit_prom_mencion.cuenta = tit_holograma_mencion.cuenta AND tit_prom_mencion.cuenta = tit_holograma_mencion.cuenta AND tit_prom_mencion.cuenta = tit_holograma_mencion.cuenta
WHERE tit_prom_mencion.cuenta NOT IN (SELECT tit_prom_reprob_mencion.cuenta 
                                                                                                                                                             FROM tit_prom_reprob_mencion
                                                                                                                                                WHERE tit_prom_reprob_mencion.cve_carrera = tit_prom_mencion.cve_carrera
                                                                                                                                                  AND tit_prom_reprob_mencion.cve_plan = tit_prom_mencion.cve_plan)
   AND tit_prom_mencion.cuenta NOT IN (SELECT tit_prom_bajas_mencion.cuenta 
                                                                                                                                                             FROM tit_prom_bajas_mencion
                                                                                                                                                WHERE tit_prom_bajas_mencion.cve_carrera = tit_prom_mencion.cve_carrera
                                                                                                                                                  AND tit_prom_bajas_mencion.cve_plan = tit_prom_mencion.cve_plan)
 
END                                                                                                            
go 
 
Grant Execute on dbo.sp_q_tit_alumnos_mencion_lic to g_se_jef_tit_cert 
go
Grant Execute on dbo.sp_q_tit_alumnos_mencion_lic to g_se_tit_cert_ventanilla 
go
Grant Execute on dbo.sp_q_tit_alumnos_mencion_lic to g_inf_admin 
go
Grant Execute on dbo.sp_q_tit_alumnos_mencion_lic to g_se_tit_cert_atencion 
go
 
sp_procxmode 'sp_q_tit_alumnos_mencion_lic', unchained
go 
 
setuser
go 
 

