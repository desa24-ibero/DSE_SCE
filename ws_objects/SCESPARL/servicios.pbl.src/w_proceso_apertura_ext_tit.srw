$PBExportHeader$w_proceso_apertura_ext_tit.srw
forward
global type w_proceso_apertura_ext_tit from pfc_w_master
end type
type st_periodo_anio from statictext within w_proceso_apertura_ext_tit
end type
type st_rev_est from statictext within w_proceso_apertura_ext_tit
end type
type st_examenes from statictext within w_proceso_apertura_ext_tit
end type
type rb_deshabilita from radiobutton within w_proceso_apertura_ext_tit
end type
type rb_habilita from radiobutton within w_proceso_apertura_ext_tit
end type
type rb_cerrada from radiobutton within w_proceso_apertura_ext_tit
end type
type st_trans_preinsc from statictext within w_proceso_apertura_ext_tit
end type
type rb_abierta from radiobutton within w_proceso_apertura_ext_tit
end type
type cb_habilita from commandbutton within w_proceso_apertura_ext_tit
end type
type cb_trans from commandbutton within w_proceso_apertura_ext_tit
end type
type cbx_trans_preinsc from checkbox within w_proceso_apertura_ext_tit
end type
type gb_2 from groupbox within w_proceso_apertura_ext_tit
end type
type gb_4 from groupbox within w_proceso_apertura_ext_tit
end type
type gb_1 from groupbox within w_proceso_apertura_ext_tit
end type
end forward

global type w_proceso_apertura_ext_tit from pfc_w_master
integer width = 3013
integer height = 1352
string title = "Apertura / Cierre de Examen Extraordinario y Titulo de Suficiencia"
st_periodo_anio st_periodo_anio
st_rev_est st_rev_est
st_examenes st_examenes
rb_deshabilita rb_deshabilita
rb_habilita rb_habilita
rb_cerrada rb_cerrada
st_trans_preinsc st_trans_preinsc
rb_abierta rb_abierta
cb_habilita cb_habilita
cb_trans cb_trans
cbx_trans_preinsc cbx_trans_preinsc
gb_2 gb_2
gb_4 gb_4
gb_1 gb_1
end type
global w_proceso_apertura_ext_tit w_proceso_apertura_ext_tit

type variables
n_tr itr_web
int ii_activa,ii_visible,ii_anio,ii_periodo
st_confirma_usuario ist_confirma_usuario
string is_pagina


uo_periodo_servicios iuo_periodo_servicios

end variables

on w_proceso_apertura_ext_tit.create
int iCurrent
call super::create
this.st_periodo_anio=create st_periodo_anio
this.st_rev_est=create st_rev_est
this.st_examenes=create st_examenes
this.rb_deshabilita=create rb_deshabilita
this.rb_habilita=create rb_habilita
this.rb_cerrada=create rb_cerrada
this.st_trans_preinsc=create st_trans_preinsc
this.rb_abierta=create rb_abierta
this.cb_habilita=create cb_habilita
this.cb_trans=create cb_trans
this.cbx_trans_preinsc=create cbx_trans_preinsc
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_periodo_anio
this.Control[iCurrent+2]=this.st_rev_est
this.Control[iCurrent+3]=this.st_examenes
this.Control[iCurrent+4]=this.rb_deshabilita
this.Control[iCurrent+5]=this.rb_habilita
this.Control[iCurrent+6]=this.rb_cerrada
this.Control[iCurrent+7]=this.st_trans_preinsc
this.Control[iCurrent+8]=this.rb_abierta
this.Control[iCurrent+9]=this.cb_habilita
this.Control[iCurrent+10]=this.cb_trans
this.Control[iCurrent+11]=this.cbx_trans_preinsc
this.Control[iCurrent+12]=this.gb_2
this.Control[iCurrent+13]=this.gb_4
this.Control[iCurrent+14]=this.gb_1
end on

on w_proceso_apertura_ext_tit.destroy
call super::destroy
destroy(this.st_periodo_anio)
destroy(this.st_rev_est)
destroy(this.st_examenes)
destroy(this.rb_deshabilita)
destroy(this.rb_habilita)
destroy(this.rb_cerrada)
destroy(this.st_trans_preinsc)
destroy(this.rb_abierta)
destroy(this.cb_habilita)
destroy(this.cb_trans)
destroy(this.cbx_trans_preinsc)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_1)
end on

event open;call super::open;int li_visible

x=1
y=1

Setpointer(hourglass!)

if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	return
End if

ii_activa = 0
ii_visible = 1

SELECT periodo,  anio
	into :ii_periodo,:ii_anio
FROM periodos_por_procesos
WHERE cve_proceso = 12  
AND tipo_periodo = :gs_tipo_periodo 
using gtr_sce;

iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 

STRING ls_periodo 

ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( ii_periodo, "L")  

st_periodo_anio.TEXT = ls_periodo + " - " + STRING(ii_anio) 








end event

type st_periodo_anio from statictext within w_proceso_apertura_ext_tit
integer x = 1737
integer y = 204
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

type st_rev_est from statictext within w_proceso_apertura_ext_tit
integer x = 1280
integer y = 416
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

type st_examenes from statictext within w_proceso_apertura_ext_tit
integer x = 1280
integer y = 596
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

type rb_deshabilita from radiobutton within w_proceso_apertura_ext_tit
integer x = 1207
integer y = 880
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

type rb_habilita from radiobutton within w_proceso_apertura_ext_tit
integer x = 1207
integer y = 780
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

type rb_cerrada from radiobutton within w_proceso_apertura_ext_tit
integer x = 329
integer y = 880
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

type st_trans_preinsc from statictext within w_proceso_apertura_ext_tit
integer x = 1280
integer y = 512
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

type rb_abierta from radiobutton within w_proceso_apertura_ext_tit
integer x = 329
integer y = 780
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

type cb_habilita from commandbutton within w_proceso_apertura_ext_tit
integer x = 2304
integer y = 788
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Habilita"
end type

event clicked;if messagebox('Aviso','¿Desea Habilitar/Deshabilitar la opción de EXAMENES EXTRAORDINARIOS Y TIT?', Question!,Yesno!) = 2 then 
	messagebox('Aviso','No se pudo Habilitar/Deshabilitar la opción de EXAMENES EXTRAORDINARIOS Y TIT')
	return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	RETURN 
END IF

//HABILITA EXAMENES EXTRAORDINARIOS Y TIT
UPDATE web_bd.dbo.www_menu
SET visible = :ii_visible
WHERE cve_menu = 21
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
//HABILITA EXAMENES EXTRAORDINARIOS Y TIT
UPDATE parametros_servicios
SET extrao_titulo_activo = :ii_activa
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
commit using itr_web;

messagebox('Aviso','Proceso de Habilitar/Deshabilitar la opción de EXAMENES EXTRAORDINARIOS Y TIT Total ejecutado')
end event

type cb_trans from commandbutton within w_proceso_apertura_ext_tit
integer x = 2304
integer y = 416
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Transfiere"
end type

event clicked;int li_periodo,li_anio,li_rtn
string ls_periodo,ls_classname
long ll_trans_bajas,ll_trans_exam,ll_registros
n_transfiere_sybase_sql_2 ln_transfiere_sybase_sql

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	cbx_trans_preinsc.checked = false
	cb_trans.enabled = false
	RETURN 
END IF

st_trans_preinsc.text = ''
st_examenes.text = ''

Setpointer(hourglass!)

//delete from revision_de_estudios
//using itr_web;


DELETE FROM revision_de_estudios 
WHERE EXISTS (SELECT * FROM  plan_estudios 
					WHERE revision_de_estudios.cve_carrera = plan_estudios.cve_carrera 
					AND revision_de_estudios.cve_plan = plan_estudios.cve_plan 
					AND plan_estudios.tipo_periodo = :gs_tipo_periodo )
using itr_web;


if itr_web.sqlcode <> 0 then
	messagebox('Error','No se pudo borrar Revision de estudios de WEB')
	rollback using itr_web;
	return
else
	commit using itr_web;
end if

ls_classname =	w_proceso_apertura_ext_tit.ClassName()
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql_2

li_rtn = ln_transfiere_sybase_sql.of_actualizacion_objeto_replica(ls_classname, gtr_sce, itr_web)

if li_rtn <> 1 then
	messagebox('Error','No se pudo transferir Revisión de estudios a WEB')
	rollback using itr_web;
	rollback using gtr_sce;
else
	if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
		return
	End if
end if

//	SP se ejecuta en SQL
DECLARE  sp_procedure1 PROCEDURE FOR sp_transfiere_examen_extrao_titulo_sol
@tipo_periodo = :gs_tipo_periodo 
using itr_web ; 
	
EXECUTE sp_procedure1; //Ejecutamos con el nombre del Alias
if len(itr_web.sqlerrtext) > 0 then
	messagebox('Error',itr_web.sqlerrtext)
	cbx_trans_preinsc.enabled = false
	return
else
	commit using itr_web;
end if
CLOSE sp_procedure1;

//if ii_periodo = 0 then
//	li_anio = ii_anio - 1
//	li_periodo = 2
//else
//	li_periodo = ii_periodo - 1 
//	li_anio = ii_anio
//end if

li_periodo = ii_periodo
li_anio = ii_anio 

//Se recupera el periodo anterior
iuo_periodo_servicios.f_recupera_periodo_anterior(li_periodo, li_anio, gtr_sce) 

select count(*) 
	into :ll_trans_bajas
from hist_examen_extrao_titulo_sol
where periodo = :li_periodo
and anio = :li_anio using itr_web;

select count(*) 
	into :ll_trans_exam
from hist_examen_extrao_titulo
where periodo = :li_periodo
and anio = :li_anio using itr_web;

st_trans_preinsc.visible = true
if ll_trans_bajas > 0 then	st_trans_preinsc.text = 'Solicitudes transferidas: ' + string(ll_trans_bajas,'#,##0')
st_examenes.visible = true
if ll_trans_exam > 0 then	st_examenes.text = 'Examenes transferidos: ' + string(ll_trans_exam,'#,##0')

cb_trans.enabled = false

messagebox('Aviso','Proceso de Transferencia de Revisión de estudios ejecutado')
commit using gtr_sce;
end event

type cbx_trans_preinsc from checkbox within w_proceso_apertura_ext_tit
integer x = 256
integer y = 416
integer width = 965
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Transfiere Revision de Estudios"
end type

event clicked;int li_periodo, li_anio
string ls_desc_periodo
long ll_registros

//if ii_periodo = 0 then
//	li_anio = ii_anio - 1
//	li_periodo = 2
//else
//	li_periodo = ii_periodo - 1 
//	li_anio = ii_anio
//end if

li_periodo = ii_periodo
li_anio = ii_anio
	
iuo_periodo_servicios.f_recupera_periodo_anterior( li_periodo, li_anio, gtr_sce)

/*if li_periodo = 0 then ls_desc_periodo = 'Primavera ' + string(li_anio)
if li_periodo = 1 then ls_desc_periodo = 'Verano ' + string(li_anio)
if li_periodo = 2 then ls_desc_periodo = 'Otoño ' + string(li_anio)*/

ls_desc_periodo = iuo_periodo_servicios.f_recupera_descripcion( li_periodo, "L") + " " + string(li_anio) 

if messagebox('Aviso','¿Desea generar el proceso de Transferencia de Revisión de Estudios del periodo '+ ls_desc_periodo +'?', Question!,Yesno!) = 1 then 
	cb_trans.enabled = true
else
	messagebox('Aviso','No se pudo ejecutar el proceso de Transferencia de Revisión de Estudios')
	this.checked = false
	cb_trans.enabled = false
end if

st_rev_est.text = ''

Select count(*)
into :ll_registros
from revision_de_estudios, plan_estudios 
WHERE revision_de_estudios.cve_carrera = plan_estudios.cve_carrera 
AND revision_de_estudios.cve_plan = plan_estudios.cve_plan 
AND plan_estudios.tipo_periodo = :gs_tipo_periodo 
using gtr_sce;

if ll_registros > 0 then	st_rev_est.text = 'Registros a tranferir: ' + string(ll_registros,'#,##0') 





end event

type gb_2 from groupbox within w_proceso_apertura_ext_tit
integer x = 256
integer y = 684
integer width = 549
integer height = 320
integer taborder = 50
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

type gb_4 from groupbox within w_proceso_apertura_ext_tit
integer x = 1170
integer y = 684
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

type gb_1 from groupbox within w_proceso_apertura_ext_tit
integer x = 110
integer y = 64
integer width = 2743
integer height = 1044
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proceso Apertura / Cierre Examen Extraordinario y Titulo de Suficiencia"
end type

