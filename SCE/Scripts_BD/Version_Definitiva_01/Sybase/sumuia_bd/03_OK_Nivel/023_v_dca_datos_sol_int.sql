USE sumuia_bd 
GO 


IF OBJECT_ID ('dbo.v_dca_datos_sol_int') IS NOT NULL
	DROP VIEW dbo.v_dca_datos_sol_int
GO

CREATE view v_dca_datos_sol_int
as 
select  i.cuenta,
 v.digito,
 a.nombre,
 a.apaterno,
 a.amaterno,
 i.periodo,
 i.anio,
 i.cve_periodo_intercambio,
tc.desc_conv,
  i.calle,
 i.colonia,
 i.cod_postal,
 i.telefono,
 i.telefono_movil,
 i.e_mail,
 i.sexo,
 i.fecha_nacimiento,
 i.lugar_nac, 
i.cve_nacion,
 p.nombre_pt,
 p.apaterno_pt,
 p.amaterno_pt,
 p.telefono_pt,
 p.nombre_contacto,
 p.apaterno_contacto,
 p.amaterno_contacto, 
p.telefono_contacto,
 p.telefono_movil_contacto ,
 p.parentesco_contacto  ,
 ac.nivel,
 ac.cve_carrera,
 ca.carrera,
es.estado, 
na.nacionalidad,
 es_licenciatura = CASE WHEN ac.nivel <> 'P' THEN 'X' ELSE '' END,
 es_posgrado = CASE ac.nivel WHEN 'P' THEN 'X' ELSE '' END,
 anio_primavera = CASE pi.periodo WHEN 0 THEN convert(varchar(4),pi.anio) ELSE '' END,
 anio_verano = CASE pi.periodo WHEN 1 THEN convert(varchar(4),pi.anio) ELSE '' END,
 anio_otonio = CASE pi.periodo WHEN 2 THEN convert(varchar(4),pi.anio) ELSE '' END
from dca_solicitud_intercambio i,
 dca_padre_tutor p,
 v_sce_alumnos a,
   v_alumno_digitoverificador v , 
dca_periodo_intercambio  pi,
 dca_tipos_convenios tc    ,
 v_sce_academicos ac  ,
 v_sce_carreras ca, 
v_sce_estados es,
 v_sce_nacionalidad na
where  i.cuenta = p.cuenta  and i.cuenta = a.cuenta AND i.cuenta = v.cuenta
and pi.cve_periodo_intercambio = i.cve_periodo_intercambio
AND pi.periodo = i.periodo
AND pi.anio = i.anio
AND tc.cve_conv =  pi.cve_conv 
AND ac.cuenta = i.cuenta
AND ac.cve_carrera = ca.cve_carrera
AND es.cve_estado = i.lugar_nac
AND na.cve_nacion = i.cve_nacion
GO



GRANT SELECT ON dbo.v_dca_datos_sol_int TO prhintraces
GO
GRANT SELECT ON dbo.v_dca_datos_sol_int TO adminintercambio
GO
GRANT SELECT ON dbo.v_dca_datos_sol_int TO foraneosadm
GO
GRANT SELECT ON dbo.v_dca_datos_sol_int TO g_admisionadm
GO
GRANT SELECT ON dbo.v_dca_datos_sol_int TO internosadm
GO
GRANT SELECT ON dbo.v_dca_datos_sol_int TO g_inf_admin
GO
GRANT SELECT ON dbo.v_dca_datos_sol_int TO g_me_foraneos_aloja
GO
GRANT SELECT ON dbo.v_dca_datos_sol_int TO g_DataReader
GO

