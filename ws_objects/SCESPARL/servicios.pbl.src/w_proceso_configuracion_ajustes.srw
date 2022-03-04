$PBExportHeader$w_proceso_configuracion_ajustes.srw
forward
global type w_proceso_configuracion_ajustes from pfc_w_master
end type
type tab_1 from tab within w_proceso_configuracion_ajustes
end type
type tabpage_1 from userobject within tab_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_bitacora from datawindow within tabpage_1
end type
type cb_tranfiere_banderas from commandbutton within tabpage_1
end type
type cbx_trans_banderas from checkbox within tabpage_1
end type
type cb_tranfiere_estruc from commandbutton within tabpage_1
end type
type cbx_trans_estruct from checkbox within tabpage_1
end type
type cb_alumnos_hora from commandbutton within tabpage_1
end type
type cbx_1 from checkbox within tabpage_1
end type
type cb_alumnos_pre from commandbutton within tabpage_1
end type
type cbx_alumnos_preinsc from checkbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
st_1 st_1
dw_bitacora dw_bitacora
cb_tranfiere_banderas cb_tranfiere_banderas
cbx_trans_banderas cbx_trans_banderas
cb_tranfiere_estruc cb_tranfiere_estruc
cbx_trans_estruct cbx_trans_estruct
cb_alumnos_hora cb_alumnos_hora
cbx_1 cbx_1
cb_alumnos_pre cb_alumnos_pre
cbx_alumnos_preinsc cbx_alumnos_preinsc
end type
type tabpage_2 from userobject within tab_1
end type
type st_periodo_anio from statictext within tabpage_2
end type
type dw_ajustes from datawindow within tabpage_2
end type
type ddlb_fechas from dropdownlistbox within tabpage_2
end type
type rb_dia from radiobutton within tabpage_2
end type
type rb_todo from radiobutton within tabpage_2
end type
type gb_1 from groupbox within tabpage_2
end type
type tabpage_2 from userobject within tab_1
st_periodo_anio st_periodo_anio
dw_ajustes dw_ajustes
ddlb_fechas ddlb_fechas
rb_dia rb_dia
rb_todo rb_todo
gb_1 gb_1
end type
type tabpage_3 from userobject within tab_1
end type
type rb_1 from radiobutton within tabpage_3
end type
type rb_aju_insc from radiobutton within tabpage_3
end type
type rb_deshabilita from radiobutton within tabpage_3
end type
type rb_habilita from radiobutton within tabpage_3
end type
type rb_cerrada from radiobutton within tabpage_3
end type
type rb_abierta from radiobutton within tabpage_3
end type
type cb_habilita from commandbutton within tabpage_3
end type
type gb_4 from groupbox within tabpage_3
end type
type gb_2 from groupbox within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type tabpage_3 from userobject within tab_1
rb_1 rb_1
rb_aju_insc rb_aju_insc
rb_deshabilita rb_deshabilita
rb_habilita rb_habilita
rb_cerrada rb_cerrada
rb_abierta rb_abierta
cb_habilita cb_habilita
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
end type
type tab_1 from tab within w_proceso_configuracion_ajustes
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
type st_trans_preinsc from statictext within w_proceso_configuracion_ajustes
end type
end forward

global type w_proceso_configuracion_ajustes from pfc_w_master
integer width = 3931
integer height = 2864
string title = "Configuración de Ajustes"
tab_1 tab_1
st_trans_preinsc st_trans_preinsc
end type
global w_proceso_configuracion_ajustes w_proceso_configuracion_ajustes

type variables
n_tr itr_web
int ii_anio,ii_periodo,ii_ren,ii_activa,ii_visible,ii_sw
st_confirma_usuario ist_confirma_usuario
long il_reg
time ti_inicio, ti_fin
date id_fecha_ini,id_fecha_fin

end variables

forward prototypes
public function integer wf_borra_tablas (transaction atr_trans)
public function integer wf_inserta_preinscritos (transaction atr_trans)
public function integer wf_inserta_alum_hora (transaction atr_trans)
public function integer wf_genera_cifras (date ad_fec_ini, date ad_fec_fin)
public function integer wf_valida_param_ajustes ()
end prototypes

public function integer wf_borra_tablas (transaction atr_trans);Delete from historico_re 
WHERE periodo in(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo )
using atr_trans;
if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
end if

Delete from historico_pos_re 
WHERE periodo in(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo )
using atr_trans;
if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
end if

Delete from historico_reinsc_actual 
WHERE periodo in(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo )
using atr_trans;
if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
end if

return 0



// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 

//Delete from historico_re using atr_trans;
//if atr_trans.sqlcode < 0 then
//	messagebox('Error',atr_trans.sqlerrtext)
//	return -1
//end if
//
//Delete from historico_pos_re using atr_trans;
//if atr_trans.sqlcode < 0 then
//	messagebox('Error',atr_trans.sqlerrtext)
//	return -1
//end if
//
//Delete from historico_reinsc_actual using atr_trans;
//if atr_trans.sqlcode < 0 then
//	messagebox('Error',atr_trans.sqlerrtext)
//	return -1
//end if
//
//return 0
end function

public function integer wf_inserta_preinscritos (transaction atr_trans);//INSERTA EN LA TABLA TEMPORAL DE historico_re LAS MATERIAS DE LOS ALUMNOS PREINSCRITOS DE LICENCIATURA
tab_1.tabpage_1.st_1.text = 'Inserción de alumnos PREINSCRITOS LICENCIATURA ' + atr_trans.dbms

insert into historico_re
select distinct 
h.cuenta,
h.cve_mat,
isnull(h.gpo,'A'),
h.periodo,
h.anio,
h.cve_carrera,
h.cve_plan,
h.calificacion,
h.observacion
from historico h, academicos a, preinsc p
where h.cuenta = a.cuenta
and	h.cuenta = p.cuenta
and h.periodo IN(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo) 
and   a.nivel <> 'P' 
using atr_trans;

/*Condición Original  and   a.nivel = 'L'   */

if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos Preinscritos LICENCIATURA')
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

tab_1.tabpage_1.st_1.text = 'Inserción de alumnos PREINSCRITOS POSGRADO ' + atr_trans.dbms
//INSERTA EN LA TABLA TEMPORAL DE historico_pos_re LAS MATERIAS DE LOS ALUMNOS PREINSCRITOS DE POSGRADO
insert into historico_pos_re
select distinct 
h.cuenta,
h.cve_mat,
h.gpo,
h.periodo,
h.anio,
h.cve_carrera,
h.cve_plan,
h.calificacion,
h.observacion
from historico h, academicos a, preinsc p
where h.cuenta = a.cuenta
and	h.cuenta = p.cuenta
and h.periodo IN(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo) 
and   a.nivel = "P" 
using atr_trans;

if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos Preinscritos POSGRADO')
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

tab_1.tabpage_1.st_1.text = 'Inserción de alumnos PREINSCRITOS (HISTÓRICO) LICENCIATURA ' + atr_trans.dbms
//ACTUALIZA LA TABLA historico_reinsc_actual LA CUAL SEÑALA SI UN ALUMNO DE  LICENCIATURA YA ACTUALIZO SU HISTORICO PARA EVITAR
//PROBLEMAS DE SERIACION DURANTE LA INSCRIPCION
insert into 
historico_reinsc_actual  
select distinct 
p.cuenta,
p.periodo,
p.anio,
getdate()
from academicos a, preinsc p
where a.cuenta = p.cuenta
and p.periodo in(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo)
and   a.nivel <> "P"
and a.cuenta not in (select cuenta from historico_reinsc_actual) 
using atr_trans;

/*Línea Original and   a.nivel = "L"   */

if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos Preinscritos (HISTÓRICO) LICENCIATURA')
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

tab_1.tabpage_1.st_1.text = 'Inserción de alumnos PREINSCRITOS (HISTÓRICO) POSGRADO ' + atr_trans.dbms
//ACTUALIZA LA TABLA historico_reinsc_actual LA CUAL SEÑALA SI UN ALUMNO DE POSGRADO YA ACTUALIZO SU HISTORICO PARA EVITAR
//PROBLEMAS DE SERIACION DURANTE LA INSCRIPCION
insert into 
historico_reinsc_actual
select distinct 
p.cuenta,
p.periodo,
p.anio,
getdate()
from academicos a, preinsc p
where a.cuenta = p.cuenta
and p.periodo in(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo)
and   a.nivel = "P"
and a.cuenta not in (select cuenta from historico_reinsc_actual) using atr_trans;
if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos Preinscritos (HISTÓRICO) POSGRADO')
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

return 0
end function

public function integer wf_inserta_alum_hora (transaction atr_trans);tab_1.tabpage_1.st_1.text = 'Inserción de alumnos con HORARIO DE INSC. LICENCIATURA ' + atr_trans.dbms

insert into historico_re
select distinct 
h.cuenta,
h.cve_mat,
h.gpo,
h.periodo,
h.anio,
h.cve_carrera,
h.cve_plan,
h.calificacion,
h.observacion
from historico h, academicos a, horario_insc p
where h.cuenta = a.cuenta
and	h.cuenta = p.cuenta
and h.periodo IN(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo)
and   a.nivel <> "P" 
using atr_trans;

/* Línea Original and   a.nivel = "L"   */

if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos con HORARIO DE INSC. LICENCIATURA ' + atr_trans.dbms) 
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

tab_1.tabpage_1.st_1.text = 'Inserción de alumnos con HORARIO DE INSC. POSGRADO ' + atr_trans.dbms
insert into historico_pos_re
select distinct 
h.cuenta,
h.cve_mat,
h.gpo,
h.periodo,
h.anio,
h.cve_carrera,
h.cve_plan,
h.calificacion,
h.observacion
from historico h, academicos a, horario_insc p
where h.cuenta = a.cuenta
and	h.cuenta = p.cuenta
and h.periodo IN(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo) 
and   a.nivel = "P" 
using atr_trans;
if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos con HORARIO DE INSC. POSGRADO ' + atr_trans.dbms)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

tab_1.tabpage_1.st_1.text = 'Inserción de alumnos con HORARIO DE INSC.  (HISTÓRICO) LICENCIATURA ' + atr_trans.dbms
insert into historico_reinsc_actual
select distinct 
p.cuenta,
p.periodo,
p.anio,
getdate()
from academicos a, horario_insc p
where a.cuenta = p.cuenta
and p.periodo in(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo) 
and   a.nivel <> "P" 
using atr_trans;

/* Linea original and   a.nivel = "L" */

if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos con HORARIO DE INSC. (HISTÓRICO) LICENCIATURA ' + atr_trans.dbms)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

tab_1.tabpage_1.st_1.text = 'Inserción de alumnos con HORARIO DE INSC.  (HISTÓRICO) POSGRADO ' + atr_trans.dbms
insert into historico_reinsc_actual
select distinct 
p.cuenta,
p.periodo,
p.anio,
getdate()
from academicos a, horario_insc p
where a.cuenta = p.cuenta
and p.periodo in(SELECT periodo FROM periodo WHERE tipo = :gs_tipo_periodo) 
and   a.nivel = "P" 
using atr_trans;

if atr_trans.sqlcode < 0 then
	messagebox('Error',atr_trans.sqlerrtext)
	return -1
else
	il_reg = atr_trans.sqlnrows
	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Inserción de alumnos con HORARIO DE INSC. (HISTÓRICO) POSGRADO ' + atr_trans.dbms)
	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
end if

return 0
end function

public function integer wf_genera_cifras (date ad_fec_ini, date ad_fec_fin);long ll_val1,ll_val2,ll_val3,ll_val4,ll_val5,ll_val6,ll_val7,ll_val8,ll_val9,ll_val10,ll_val11,ll_val12,ll_val13,ll_val14,ll_val15,ll_val16,ll_val17,ll_val18
string ls_fec_ini,ls_fec_fin

Setpointer(Hourglass!)

ls_fec_ini = string(ad_fec_ini,'yyyymmdd')
ls_fec_fin = string(ad_fec_fin,'yyyymmdd')

//Bloque 1

select count(cuenta) into :ll_val1 from alumnos 
WHERE EXISTS(SELECT * FROM academicos, plan_estudios  
						WHERE academicos.cuenta = alumnos.cuenta 
						AND academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo)
using gtr_sce;

select count(cuenta) into :ll_val2 from alumnos 
WHERE EXISTS(SELECT * FROM academicos, plan_estudios  
						WHERE academicos.cuenta = alumnos.cuenta 
						AND academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo)
using itr_web;

select count(cuenta) into :ll_val3 from academicos , plan_estudios
						WHERE academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo
using gtr_sce;

select count(cuenta) into :ll_val4 from academicos , plan_estudios
						WHERE academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo
using itr_web;

select count(cuenta) into :ll_val5 from banderas 
WHERE EXISTS(SELECT * FROM academicos, plan_estudios  
						WHERE academicos.cuenta = banderas.cuenta 
						AND academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo)
using gtr_sce;

select count(cuenta) into :ll_val6 from banderas 
WHERE EXISTS(SELECT * FROM academicos, plan_estudios  
						WHERE academicos.cuenta = banderas.cuenta 
						AND academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo)
using itr_web;

select count(cuenta) into :ll_val7 from nips  
WHERE EXISTS(SELECT * FROM academicos, plan_estudios  
						WHERE academicos.cuenta = nips.cuenta 
						AND academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo)
using gtr_sce;

select count(cuenta) into :ll_val8 from nips  
WHERE EXISTS(SELECT * FROM academicos, plan_estudios  
						WHERE academicos.cuenta = nips.cuenta 
						AND academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo)
using itr_web;

//Bloque 2
//MOVIMIENTOS TOTALES POR INTERNET DE ALUMNOS
select count(cuenta) into :ll_val9 from controlescolar_bd.dbo.movmat_inscritas 
where  convert(varchar(10),fecha,112) between :ls_fec_ini and :ls_fec_fin 
AND EXISTS (SELECT * FROM controlescolar_bd.dbo.academicos, controlescolar_bd.dbo.plan_estudios  
						WHERE controlescolar_bd.dbo.academicos.cuenta = controlescolar_bd.dbo.movmat_inscritas.cuenta 
						AND controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.plan_estudios.cve_carrera 
						AND controlescolar_bd.dbo.academicos.cve_plan = controlescolar_bd.dbo.plan_estudios.cve_plan 
						AND controlescolar_bd.dbo.plan_estudios.tipo_periodo = :gs_tipo_periodo) 
and usuario = 'wwww' using itr_web;

//--ALUMNOS CON MOVIMIENTOS POR INTERNET
select count(distinct cuenta) into :ll_val10 from controlescolar_bd.dbo.movmat_inscritas
where  convert(varchar(10),fecha,112) between :ls_fec_ini and :ls_fec_fin 
AND EXISTS (SELECT * FROM controlescolar_bd.dbo.academicos, controlescolar_bd.dbo.plan_estudios  
						WHERE controlescolar_bd.dbo.academicos.cuenta = controlescolar_bd.dbo.movmat_inscritas.cuenta 
						AND controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.plan_estudios.cve_carrera 
						AND controlescolar_bd.dbo.academicos.cve_plan = controlescolar_bd.dbo.plan_estudios.cve_plan 
						AND controlescolar_bd.dbo.plan_estudios.tipo_periodo = :gs_tipo_periodo) 
and usuario = 'wwww' using itr_web;

//--MOVIMIENTOS TOTALES DE ALUMNOS POR CLIENTE SERVIDOR
select  count(cuenta)  into :ll_val11 from controlescolar_bd.dbo.movmat_inscritas
where  convert(varchar(10),fecha,112) between :ls_fec_ini and :ls_fec_fin 
AND EXISTS (SELECT * FROM controlescolar_bd.dbo.academicos, controlescolar_bd.dbo.plan_estudios  
						WHERE controlescolar_bd.dbo.academicos.cuenta = controlescolar_bd.dbo.movmat_inscritas.cuenta 
						AND controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.plan_estudios.cve_carrera 
						AND controlescolar_bd.dbo.academicos.cve_plan = controlescolar_bd.dbo.plan_estudios.cve_plan 
						AND controlescolar_bd.dbo.plan_estudios.tipo_periodo = :gs_tipo_periodo) 
and usuario <> 'wwww' using itr_web;

//--ALUMNOS CON MOVIMIENTOS POR CLIENTE SERVIDOR
select count(distinct cuenta) into :ll_val12 from controlescolar_bd.dbo.movmat_inscritas
where  convert(varchar(10),fecha,112) between :ls_fec_ini and :ls_fec_fin 
AND EXISTS (SELECT * FROM controlescolar_bd.dbo.academicos, controlescolar_bd.dbo.plan_estudios  
						WHERE controlescolar_bd.dbo.academicos.cuenta = controlescolar_bd.dbo.movmat_inscritas.cuenta 
						AND controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.plan_estudios.cve_carrera 
						AND controlescolar_bd.dbo.academicos.cve_plan = controlescolar_bd.dbo.plan_estudios.cve_plan 
						AND controlescolar_bd.dbo.plan_estudios.tipo_periodo = :gs_tipo_periodo) 
and usuario <> 'wwww' using itr_web;

//--ALUMNOS QUE HAN INGRESADO A SERVICIOS EN LINEA
select count(distinct cuenta)  into :ll_val13 from web_bd.dbo.bit_acceso_uia
where  convert(varchar(10),fecha,112) between :ls_fec_ini and :ls_fec_fin 
AND EXISTS (SELECT * FROM controlescolar_bd.dbo.academicos, controlescolar_bd.dbo.plan_estudios  
						WHERE controlescolar_bd.dbo.academicos.cuenta = web_bd.dbo.bit_acceso_uia.cuenta 
						AND controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.plan_estudios.cve_carrera 
						AND controlescolar_bd.dbo.academicos.cve_plan = controlescolar_bd.dbo.plan_estudios.cve_plan 
						AND controlescolar_bd.dbo.plan_estudios.tipo_periodo = :gs_tipo_periodo) 
using itr_web;

//--ACCESOS TOTALES QUE HAN INGRESADO A SERVICIOS EN LINEA
select count( cuenta) into :ll_val14 from web_bd.dbo.bit_acceso_uia
where  convert(varchar(10),fecha,112) between :ls_fec_ini and :ls_fec_fin 
AND EXISTS (SELECT * FROM controlescolar_bd.dbo.academicos, controlescolar_bd.dbo.plan_estudios  
						WHERE controlescolar_bd.dbo.academicos.cuenta = web_bd.dbo.bit_acceso_uia.cuenta 
						AND controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.plan_estudios.cve_carrera 
						AND controlescolar_bd.dbo.academicos.cve_plan = controlescolar_bd.dbo.plan_estudios.cve_plan 
						AND controlescolar_bd.dbo.plan_estudios.tipo_periodo = :gs_tipo_periodo) 
using itr_web;

//--BLOQUE 3
//--MATERIAS INSCRITAS TOTALES
SELECT  count(cuenta) into :ll_val15 from mat_inscritas
WHERE EXISTS(SELECT * FROM academicos, plan_estudios  
						WHERE academicos.cuenta = mat_inscritas.cuenta 
						AND academicos.cve_carrera = plan_estudios.cve_carrera 
						AND academicos.cve_plan = plan_estudios.cve_plan 
						AND plan_estudios.tipo_periodo = :gs_tipo_periodo)
using gtr_sce;

//--GRUPOS INSCRITOS TOTALES
SELECT sum(inscritos) into :ll_val16 from grupos
where tipo<>2 
AND periodo in(SELECT periodo from periodo where tipo = :gs_tipo_periodo) 
using gtr_sce;

//--MATERIAS INSCRITAS TOTALES
SELECT  count(cuenta) into :ll_val17 from mat_inscritas 
WHERE EXISTS (SELECT * FROM controlescolar_bd.dbo.academicos, controlescolar_bd.dbo.plan_estudios  
						WHERE controlescolar_bd.dbo.academicos.cuenta = mat_inscritas.cuenta 
						AND controlescolar_bd.dbo.academicos.cve_carrera = controlescolar_bd.dbo.plan_estudios.cve_carrera 
						AND controlescolar_bd.dbo.academicos.cve_plan = controlescolar_bd.dbo.plan_estudios.cve_plan 
						AND controlescolar_bd.dbo.plan_estudios.tipo_periodo = :gs_tipo_periodo) 
using itr_web;

//--GRUPOS INSCRITOS TOTALES
SELECT sum(inscritos) into :ll_val18 from grupos
where tipo<>2 
AND periodo in(SELECT periodo from periodo where tipo = :gs_tipo_periodo) 
using itr_web;

DELETE FROM bit_proceso_ajustes  using gtr_sce;


INSERT INTO bit_proceso_ajustes(syb_alumnos_num, sql_alumnos_num, syb_academicos_num, sql_academicos_num, syb_banderas_num, sql_banderas_num, syb_nips_num, sql_nips_num, syb_cuenta_mat_inscritas, syb_grupos_inscritos, sql_movtos_insc_www, sql_alumnos_insc_www, sql_movtos_insc_cs, sql_alumnos_insc_cs, sql_alumnos_accesos_totales, sql_accesos_totales, sql_cuenta_mat_inscritas, sql_grupos_inscritos ) 
Values(:ll_val1,:ll_val2,:ll_val3,:ll_val4,:ll_val5,:ll_val6,:ll_val7,:ll_val8,:ll_val15,:ll_val16,:ll_val9,:ll_val10,:ll_val11,:ll_val12,:ll_val13,:ll_val14,:ll_val17,:ll_val18)
using gtr_sce;

tab_1.tabpage_2.dw_ajustes.Settransobject(gtr_sce)
tab_1.tabpage_2.dw_ajustes.Retrieve()

return 0

end function

public function integer wf_valida_param_ajustes ();int li_syb,li_sql


//Suma de los parametros activos de control escolar en Sybase
select sum(activo)
	into :li_syb
from parametros_conexion
where cve_conexion in (10,12,15) using gtr_sce;

//Suma de los parametros activos de control escolar en SQL
select sum(activo)
	into :li_sql
from parametros_conexion
where cve_conexion in (11,13,14) using gtr_sce;

if li_syb = 3 and li_sql = 0 then
	messagebox('Aviso','Es necesario mover los parámetros de conexión para ajustes')
	return -1
else
	return 0
end if
end function

on w_proceso_configuracion_ajustes.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_trans_preinsc=create st_trans_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_trans_preinsc
end on

on w_proceso_configuracion_ajustes.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.st_trans_preinsc)
end on

event open;call super::open;int li_visible

x=1
y=1

Setpointer(hourglass!)

if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	return
End if

SELECT periodo,  anio
	into :ii_periodo,:ii_anio
FROM periodos_por_procesos
WHERE cve_proceso = 11  using gtr_sce;
end event

type tab_1 from tab within w_proceso_configuracion_ajustes
integer x = 73
integer y = 32
integer width = 3767
integer height = 2592
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event clicked;datetime ldt_fecha_ini,ldt_fecha_fin
integer li_periodo,li_anio
string ls_periodo

if index = 2 then
	SELECT periodos_por_procesos.fecha_inicial,   
         periodos_por_procesos.fecha_final,
		periodos_por_procesos.periodo,
		periodos_por_procesos.anio  
		 INTO :ldt_fecha_ini,   
				:ldt_fecha_fin,
				:li_periodo,
				:li_anio
    FROM periodos_por_procesos  
   WHERE periodos_por_procesos.cve_proceso = 15 using gtr_sce  ;
	
	if gtr_sce.sqlcode = 100 then
		messagebox('Aviso','No existe periodo de ajustes dado de alta')
		tab_1.tabpage_2.rb_todo.enabled = false
		tab_1.tabpage_2.rb_dia.enabled = false
	else
		id_fecha_ini = date(ldt_fecha_ini)
		id_fecha_fin = date(ldt_fecha_fin)
		tab_1.tabpage_2.rb_todo.enabled = true
		tab_1.tabpage_2.rb_dia.enabled = true
		
		choose case li_periodo
			case 0
				ls_periodo = 'PRIMAVERA'
			case 1
				ls_periodo = 'VERANO'
			case 2
				ls_periodo = 'OTOÑO'
		end choose
		
		tab_1.tabpage_2.st_periodo_anio.text = ls_periodo+" - "+string(li_anio)
		
	end if
elseif  index = 3 then
	ii_activa = 0
	ii_visible = 1
	ii_sw = 0
end if
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3730
integer height = 2464
long backcolor = 79741120
string text = "Configuración de ajustes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_1 st_1
dw_bitacora dw_bitacora
cb_tranfiere_banderas cb_tranfiere_banderas
cbx_trans_banderas cbx_trans_banderas
cb_tranfiere_estruc cb_tranfiere_estruc
cbx_trans_estruct cbx_trans_estruct
cb_alumnos_hora cb_alumnos_hora
cbx_1 cbx_1
cb_alumnos_pre cb_alumnos_pre
cbx_alumnos_preinsc cbx_alumnos_preinsc
end type

on tabpage_1.create
this.st_1=create st_1
this.dw_bitacora=create dw_bitacora
this.cb_tranfiere_banderas=create cb_tranfiere_banderas
this.cbx_trans_banderas=create cbx_trans_banderas
this.cb_tranfiere_estruc=create cb_tranfiere_estruc
this.cbx_trans_estruct=create cbx_trans_estruct
this.cb_alumnos_hora=create cb_alumnos_hora
this.cbx_1=create cbx_1
this.cb_alumnos_pre=create cb_alumnos_pre
this.cbx_alumnos_preinsc=create cbx_alumnos_preinsc
this.Control[]={this.st_1,&
this.dw_bitacora,&
this.cb_tranfiere_banderas,&
this.cbx_trans_banderas,&
this.cb_tranfiere_estruc,&
this.cbx_trans_estruct,&
this.cb_alumnos_hora,&
this.cbx_1,&
this.cb_alumnos_pre,&
this.cbx_alumnos_preinsc}
end on

on tabpage_1.destroy
destroy(this.st_1)
destroy(this.dw_bitacora)
destroy(this.cb_tranfiere_banderas)
destroy(this.cbx_trans_banderas)
destroy(this.cb_tranfiere_estruc)
destroy(this.cbx_trans_estruct)
destroy(this.cb_alumnos_hora)
destroy(this.cbx_1)
destroy(this.cb_alumnos_pre)
destroy(this.cbx_alumnos_preinsc)
end on

type st_1 from statictext within tabpage_1
integer x = 165
integer y = 2096
integer width = 3401
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16711680
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_bitacora from datawindow within tabpage_1
boolean visible = false
integer x = 1774
integer y = 80
integer width = 1902
integer height = 1952
integer taborder = 30
string title = "none"
string dataobject = "d_bitacora_ajustes"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_tranfiere_banderas from commandbutton within tabpage_1
integer x = 1225
integer y = 748
integer width = 503
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Transferir"
end type

event clicked;string ls_sql

if messagebox('Aviso','¿Desea generar la transferencia de banderas?', Question!,Yesno!) = 2 then
	messagebox('Aviso','No se pudo ejecutar la la transferencia de banderas')
	this.enabled = false
	Return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	this.enabled = false
	RETURN 
END IF

tab_1.tabpage_1.dw_bitacora.visible = true
if dw_bitacora.Rowcount() > 0 then 
	if messagebox('Aviso','¿Desea limpiar la bitacora?',Question!,yesno!) = 1 then 
		tab_1.tabpage_1.dw_bitacora.Reset()
	end if
end if


Setpointer(Hourglass!)
ti_inicio = now()
tab_1.tabpage_1.st_1.text = 'Borrando datos de: Banderas' +' '+ itr_web.dbms
ls_sql = 'Delete from banderas'
EXECUTE IMMEDIATE :ls_sql USING itr_web ;
if itr_web.sqlcode < 0 then
	messagebox('Error',itr_web.sqlerrtext)
else
	tab_1.tabpage_1.st_1.text = 'Transfiriendo datos de: Banderas'
	if f_replica('d_transfiere_banderas',gtr_sce,itr_web,il_reg) <> 0 then
		ROLLBACK USING itr_web ;
	else
		COMMIT USING itr_web ;
		ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
		tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
		tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Registros transferidos: banderas' )
		tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
	end if
end if

ti_fin = now()

tab_1.tabpage_1.st_1.text = 'Tiempo de proceso: Inicio: ' + string(ti_inicio) + ' Fin: ' +string(ti_fin)
messagebox('Aviso','Proceso terminado')
end event

type cbx_trans_banderas from checkbox within tabpage_1
integer x = 128
integer y = 764
integer width = 1010
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Transfiere banderas"
end type

event clicked;tab_1.tabpage_1.cb_tranfiere_banderas.enabled = true
end event

type cb_tranfiere_estruc from commandbutton within tabpage_1
integer x = 1225
integer y = 520
integer width = 503
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Transferir"
end type

event clicked;string ls_lista_dw[12],ls_sql,ls_tablas[12]
int li_i,li_res
pipeline lp_trans


if messagebox('Aviso','¿Desea generar la transferencia de la estructura académica?', Question!,Yesno!) = 2 then
	messagebox('Aviso','No se pudo ejecutar la la transferencia de la estructura académica')
	this.enabled = false
	Return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	this.enabled = false
	RETURN 
END IF

tab_1.tabpage_1.dw_bitacora.visible = true
if dw_bitacora.Rowcount() > 0 then 
	if messagebox('Aviso','¿Desea limpiar la bitacora?',Question!,yesno!) = 1 then 
		tab_1.tabpage_1.dw_bitacora.Reset()
	end if
end if

ls_lista_dw[1] = 'd_transfiere_mat_prerrequisito'
ls_lista_dw[2] = 'd_transfiere_mat_prerreq_pos'
ls_lista_dw[3] = 'd_transfiere_prerrequisitos'
ls_lista_dw[4] = 'd_transfiere_teoria_lab'
ls_lista_dw[5] = 'd_transfiere_salon'
ls_lista_dw[6] = 'd_transfiere_reinscripcion_materias'
ls_lista_dw[7] = 'd_transfiere_plan_estudios'
ls_lista_dw[8] = 'd_transfiere_areas'
ls_lista_dw[9] = 'd_transfiere_area_mat'
ls_lista_dw[10] = 'd_transfiere_materias'
//ls_lista_dw[11] = 'd_transfiere_carreras'
ls_lista_dw[11] = 'd_transfiere_nombre_plan'
ls_lista_dw[12] = 'd_transfiere_subsistema'

ls_tablas[1] = 'mat_prerrequisito'
ls_tablas[2] = 'mat_prerreq_pos'
ls_tablas[3] = 'prerrequisitos'
ls_tablas[4] = 'teoria_lab'
ls_tablas[5] = 'salon'
ls_tablas[6] = 'reinscripcion_materias'
ls_tablas[7] = 'plan_estudios'
ls_tablas[8] = 'areas'
ls_tablas[9] = 'area_mat'
ls_tablas[10] = 'materias'
//ls_tablas[11] = 'carreras'
ls_tablas[11] = 'nombre_plan'
ls_tablas[12] = 'subsistema'

ti_inicio = now()
for li_i = 1 to 12
	Setpointer(Hourglass!)
	tab_1.tabpage_1.st_1.text = 'Borrando datos de: '  + ls_tablas[li_i] +' '+ itr_web.dbms
	ls_sql = 'Delete from ' + ls_tablas[li_i]
	EXECUTE IMMEDIATE :ls_sql USING itr_web ;
	if itr_web.sqlcode < 0 then
		messagebox('Error',itr_web.sqlerrtext)
		exit
	else
		tab_1.tabpage_1.st_1.text = 'Transfiriendo datos de: '  + ls_tablas[li_i] 
		if f_replica(ls_lista_dw[li_i],gtr_sce,itr_web,il_reg) <> 0 then
			ROLLBACK USING itr_web ;
			exit
		else
			COMMIT USING itr_web ;
			ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
			tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
			tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Registros transferidos: ' + ls_tablas[li_i] )
			tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
		end if
	end if
	Setpointer(Arrow!)
next

Setpointer(Hourglass!)
tab_1.tabpage_1.st_1.text = 'Borrando datos de: Carreras' +' '+ itr_web.dbms

Delete from carreras_transfer using gtr_sce;
INSERT INTO carreras_transfer  
SELECT cve_carrera, carrera, nivel, cve_coordinacion, num_simpl_admva_sep, carrera_sin_prefijo, cve_grado,   nombre_minusculas, activa_1er_ing, cve_plan_ofertado, promedio_mencion, cve_dgp 
    FROM carreras using gtr_sce;
if gtr_sce.sqlcode < 0 then
	messagebox('Error',gtr_sce.sqlerrtext)
else
	Delete from carreras_transfer using itr_web;
	Delete from carreras using itr_web;
	if itr_web.sqlcode < 0 then
		messagebox('Error',itr_web.sqlerrtext)
		ROLLBACK USING itr_web ;
	else
		tab_1.tabpage_1.st_1.text = 'Transfiriendo datos de: Carreras'
		if f_replica('d_transfiere_carreras_transfer',gtr_sce,itr_web,il_reg) <> 0 then
			ROLLBACK USING itr_web ;
		else
			
			INSERT INTO carreras  
			SELECT cve_carrera, carrera, nivel, cve_coordinacion, num_simpl_admva_sep, carrera_sin_prefijo, cve_grado,   nombre_minusculas, activa_1er_ing, cve_plan_ofertado, promedio_mencion, cve_dgp 
				 FROM carreras_transfer using itr_web;
			il_reg = itr_web.sqlnrows
			if itr_web.sqlcode < 0 then
				messagebox('Error',itr_web.sqlerrtext)
				ROLLBACK USING itr_web ;
			else
				COMMIT USING itr_web ;
				ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
				tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
				tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Registros transferidos: carreras' )
				tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
			end if
		end if
	end if
end if

//lp_trans = CREATE pipeline
//lp_trans.DataObject = "pl_trans_carreras"
//tab_1.tabpage_1.st_1.text = 'Transfiriendo datos de: carreras'
//li_res = lp_trans.Start(gtr_sce, itr_web, tab_1.tabpage_1.dw_bitacora)
//if li_Res = 1 then
//	select count(*)
//		into :il_reg
//	from carreras 
//	using itr_web;
//	ii_ren = tab_1.tabpage_1.dw_bitacora.Insertrow(0)
//	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'renglon',ii_ren)
//	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'proceso','Registros transferidos: carreras'  )
//	tab_1.tabpage_1.dw_bitacora.Setitem(ii_ren,'registros',il_reg)
//end if

ti_fin = now()

tab_1.tabpage_1.st_1.text = 'Tiempo de proceso: Inicio: ' + string(ti_inicio) + ' Fin: ' +string(ti_fin)
messagebox('Aviso','Proceso terminado')
end event

type cbx_trans_estruct from checkbox within tabpage_1
integer x = 128
integer y = 536
integer width = 1010
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Transfiere estructura académica"
end type

event clicked;tab_1.tabpage_1.cb_tranfiere_estruc.enabled = true
end event

type cb_alumnos_hora from commandbutton within tabpage_1
integer x = 1225
integer y = 292
integer width = 503
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Actualizar histórico"
end type

event clicked;int li_res

if messagebox('Aviso','¿Desea actualizar el histórico con los alumnos con horario de inscripción?', Question!,Yesno!) = 2 then
	messagebox('Aviso','No se pudo actualizar el histórico con los alumnos con horario de inscripción')
	this.enabled = false
	Return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	this.enabled = false
	RETURN 
END IF

tab_1.tabpage_1.dw_bitacora.visible = true
if dw_bitacora.Rowcount() > 0 then 
	if messagebox('Aviso','¿Desea limpiar la bitacora?',Question!,yesno!) = 1 then 
		tab_1.tabpage_1.dw_bitacora.Reset()
	end if
end if


Setpointer(Hourglass!)
ti_inicio = now()
tab_1.tabpage_1.st_1.text = 'Borrando tablas históricas Sybase'
li_res = wf_borra_tablas(gtr_sce)
if li_res = 0 then
	li_res = wf_inserta_alum_hora(gtr_sce)
	if li_res = 0 then
		COMMIT using gtr_sce; 
	else
		ROLLBACK using gtr_sce; 
	end if
else
	ROLLBACK using gtr_sce; 
	return
end if
Setpointer(Arrow!)

Setpointer(Hourglass!)
tab_1.tabpage_1.st_1.text = 'Borrando tablas históricas SQL'
li_res = wf_borra_tablas(itr_web)
if li_res = 0 then
	li_res = wf_inserta_alum_hora(itr_web)
	if li_res = 0 then
		COMMIT using itr_web; 
	else
		ROLLBACK using itr_web; 
	end if
else
	ROLLBACK using itr_web; 
	return
end if

ti_fin = now()

tab_1.tabpage_1.st_1.text = 'Tiempo de proceso: Inicio: ' + string(ti_inicio) + ' Fin: ' +string(ti_fin)
messagebox('Aviso','Proceso terminado')
end event

type cbx_1 from checkbox within tabpage_1
integer x = 128
integer y = 308
integer width = 1010
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alumnos con horario de inscripción"
end type

event clicked;tab_1.tabpage_1.cb_alumnos_hora.enabled = true
end event

type cb_alumnos_pre from commandbutton within tabpage_1
integer x = 1225
integer y = 96
integer width = 503
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Actualizar histórico"
end type

event clicked;int li_res

if messagebox('Aviso','¿Desea actualizar el histórico con los alumnos preinscritos?', Question!,Yesno!) = 2 then
	messagebox('Aviso','No se pudo actualizar el histórico con los alumnos preinscritos')
	this.enabled = false
	Return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	this.enabled = false
	RETURN 
END IF

tab_1.tabpage_1.dw_bitacora.visible = true
if dw_bitacora.Rowcount() > 0 then 
	if messagebox('Aviso','¿Desea limpiar la bitacora?',Question!,yesno!) = 1 then 
		tab_1.tabpage_1.dw_bitacora.Reset()
	end if
end if


Setpointer(Hourglass!)
ti_inicio = now()
tab_1.tabpage_1.st_1.text = 'Borrando tablas históricas Sybase'
li_res = wf_borra_tablas(gtr_sce)
if li_res = 0 then
	li_res = wf_inserta_preinscritos(gtr_sce)
	if li_res = 0 then
		COMMIT using gtr_sce; 
	else
		ROLLBACK using gtr_sce; 
	end if
else
	ROLLBACK using gtr_sce; 
end if
ti_fin = now()

tab_1.tabpage_1.st_1.text = 'Tiempo de proceso: Inicio: ' + string(ti_inicio) + ' Fin: ' +string(ti_fin)
messagebox('Aviso','Proceso terminado')
end event

type cbx_alumnos_preinsc from checkbox within tabpage_1
integer x = 128
integer y = 112
integer width = 640
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Alumnos preinscritos"
end type

event clicked;tab_1.tabpage_1.cb_alumnos_pre.enabled = true
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3730
integer height = 2464
long backcolor = 79741120
string text = "Monitoreo de ajustes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
st_periodo_anio st_periodo_anio
dw_ajustes dw_ajustes
ddlb_fechas ddlb_fechas
rb_dia rb_dia
rb_todo rb_todo
gb_1 gb_1
end type

on tabpage_2.create
this.st_periodo_anio=create st_periodo_anio
this.dw_ajustes=create dw_ajustes
this.ddlb_fechas=create ddlb_fechas
this.rb_dia=create rb_dia
this.rb_todo=create rb_todo
this.gb_1=create gb_1
this.Control[]={this.st_periodo_anio,&
this.dw_ajustes,&
this.ddlb_fechas,&
this.rb_dia,&
this.rb_todo,&
this.gb_1}
end on

on tabpage_2.destroy
destroy(this.st_periodo_anio)
destroy(this.dw_ajustes)
destroy(this.ddlb_fechas)
destroy(this.rb_dia)
destroy(this.rb_todo)
destroy(this.gb_1)
end on

type st_periodo_anio from statictext within tabpage_2
integer x = 18
integer y = 48
integer width = 983
integer height = 116
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "PERIODO - AÑO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_ajustes from datawindow within tabpage_2
integer x = 1298
integer y = 48
integer width = 2231
integer height = 2304
integer taborder = 20
string title = "none"
string dataobject = "d_bit_proceso_ajustes"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_fechas from dropdownlistbox within tabpage_2
boolean visible = false
integer x = 494
integer y = 432
integer width = 549
integer height = 416
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;date ld_fecha

ld_fecha = date(ddlb_fechas.Text(index))

wf_genera_cifras(ld_fecha,ld_fecha)


end event

type rb_dia from radiobutton within tabpage_2
integer x = 91
integer y = 452
integer width = 270
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Por día"
end type

event clicked;int li_i,li_tot
string ls_fecha

li_tot = daysafter(id_fecha_ini,id_fecha_fin)

if isnull(li_tot) then
	messagebox('Aviso','No existe un perido de ajustes capturado')
	return
end if

ddlb_fechas.Reset ( )

for li_i = 0 to li_tot
	if li_i = 0 then
		ls_fecha = string(id_fecha_ini,'dd/mm/yyyy')
	else
		if li_i = li_tot then
			ls_fecha = string(id_fecha_fin,'dd/mm/yyyy')
		else
			ls_fecha = string(RelativeDate(id_fecha_ini, li_i),'dd/mm/yyyy')
		end if
	end if
	ddlb_fechas.AddItem ( ls_fecha )
next

ddlb_fechas.visible = true
end event

type rb_todo from radiobutton within tabpage_2
integer x = 91
integer y = 368
integer width = 256
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Todo"
end type

event clicked;ddlb_fechas.visible = false

wf_genera_cifras(id_fecha_ini,id_fecha_fin)
end event

type gb_1 from groupbox within tabpage_2
integer x = 18
integer y = 272
integer width = 1134
integer height = 384
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo"
end type

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3730
integer height = 2464
long backcolor = 79741120
string text = "Apertura/Cierre Ajustes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
rb_1 rb_1
rb_aju_insc rb_aju_insc
rb_deshabilita rb_deshabilita
rb_habilita rb_habilita
rb_cerrada rb_cerrada
rb_abierta rb_abierta
cb_habilita cb_habilita
gb_4 gb_4
gb_2 gb_2
gb_3 gb_3
end type

on tabpage_3.create
this.rb_1=create rb_1
this.rb_aju_insc=create rb_aju_insc
this.rb_deshabilita=create rb_deshabilita
this.rb_habilita=create rb_habilita
this.rb_cerrada=create rb_cerrada
this.rb_abierta=create rb_abierta
this.cb_habilita=create cb_habilita
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.rb_1,&
this.rb_aju_insc,&
this.rb_deshabilita,&
this.rb_habilita,&
this.rb_cerrada,&
this.rb_abierta,&
this.cb_habilita,&
this.gb_4,&
this.gb_2,&
this.gb_3}
end on

on tabpage_3.destroy
destroy(this.rb_1)
destroy(this.rb_aju_insc)
destroy(this.rb_deshabilita)
destroy(this.rb_habilita)
destroy(this.rb_cerrada)
destroy(this.rb_abierta)
destroy(this.cb_habilita)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type rb_1 from radiobutton within tabpage_3
integer x = 384
integer y = 244
integer width = 1193
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ajustes de Inscripción de Lic. 1er. Ingreso"
end type

event clicked;tab_1.tabpage_3.cb_habilita.enabled = false
if wf_valida_param_ajustes() = 0 then
	tab_1.tabpage_3.cb_habilita.enabled = true
	ii_sw = 2
else
	tab_1.tabpage_3.cb_habilita.enabled = true
	ii_sw = 0 
end if
end event

type rb_aju_insc from radiobutton within tabpage_3
integer x = 384
integer y = 144
integer width = 667
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ajustes de Inscripción"
end type

event clicked;tab_1.tabpage_3.cb_habilita.enabled = false
if wf_valida_param_ajustes() = 0 then
	tab_1.tabpage_3.cb_habilita.enabled = true
	ii_sw = 1
else
	tab_1.tabpage_3.cb_habilita.enabled = false
	ii_sw = 0
end if
end event

type rb_deshabilita from radiobutton within tabpage_3
integer x = 1019
integer y = 752
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Deshabilita"
end type

event clicked;ii_visible = 0
cb_habilita.text = 'Deshabilita'
end event

type rb_habilita from radiobutton within tabpage_3
integer x = 1019
integer y = 656
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Habilita"
boolean checked = true
end type

event clicked;ii_visible = 1
cb_habilita.text = 'Habilita'
end event

type rb_cerrada from radiobutton within tabpage_3
integer x = 325
integer y = 752
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cerrada"
end type

event clicked;ii_activa = 0
end event

type rb_abierta from radiobutton within tabpage_3
integer x = 325
integer y = 656
integer width = 402
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Abierta"
end type

event clicked;ii_activa = 1
end event

type cb_habilita from commandbutton within tabpage_3
integer x = 1701
integer y = 688
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Habilita"
end type

event clicked;int li_cve_menu

if messagebox('Aviso','¿Desea Habilitar/Deshabilitar la Baja Total?', Question!,Yesno!) = 2 then 
	messagebox('Aviso','No se pudo Habilitar/Deshabilitar la Baja Total')
	return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	RETURN 
END IF

if ii_sw = 1 then 
	li_cve_menu = 29
elseif  ii_sw = 2 then 
	li_cve_menu = 31
end if

//HABILITA LA BAJA TOTAL
UPDATE web_bd.dbo.www_menu
SET visible = :ii_visible
WHERE cve_menu = :li_cve_menu
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
//HABILITA LA BAJA TOTAL
UPDATE parametros_servicios
SET inscripcion_activa = :ii_activa 
WHERE tipo_periodo = :gs_tipo_periodo
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
commit using itr_web;

messagebox('Aviso','Proceso de Habilitar/Deshabilitar la Baja Total ejecutado')
end event

type gb_4 from groupbox within tabpage_3
integer x = 969
integer y = 560
integer width = 475
integer height = 320
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Menú"
end type

type gb_2 from groupbox within tabpage_3
integer x = 274
integer y = 560
integer width = 549
integer height = 320
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proceso"
end type

type gb_3 from groupbox within tabpage_3
integer x = 128
integer y = 48
integer width = 2560
integer height = 1024
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ajustes"
end type

type st_trans_preinsc from statictext within w_proceso_configuracion_ajustes
integer x = 1280
integer y = 244
integer width = 969
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

