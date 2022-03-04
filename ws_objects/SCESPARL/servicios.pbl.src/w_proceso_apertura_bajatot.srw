$PBExportHeader$w_proceso_apertura_bajatot.srw
forward
global type w_proceso_apertura_bajatot from pfc_w_master
end type
type st_periodo_anio from statictext within w_proceso_apertura_bajatot
end type
type rb_deshabilita from radiobutton within w_proceso_apertura_bajatot
end type
type rb_habilita from radiobutton within w_proceso_apertura_bajatot
end type
type rb_cerrada from radiobutton within w_proceso_apertura_bajatot
end type
type st_trans_preinsc from statictext within w_proceso_apertura_bajatot
end type
type rb_abierta from radiobutton within w_proceso_apertura_bajatot
end type
type cb_habilita from commandbutton within w_proceso_apertura_bajatot
end type
type cb_trans from commandbutton within w_proceso_apertura_bajatot
end type
type cbx_trans_preinsc from checkbox within w_proceso_apertura_bajatot
end type
type gb_2 from groupbox within w_proceso_apertura_bajatot
end type
type gb_4 from groupbox within w_proceso_apertura_bajatot
end type
type gb_1 from groupbox within w_proceso_apertura_bajatot
end type
end forward

global type w_proceso_apertura_bajatot from pfc_w_master
integer width = 3013
integer height = 1352
string title = "Apertura / Cierre de Baja total"
st_periodo_anio st_periodo_anio
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
global w_proceso_apertura_bajatot w_proceso_apertura_bajatot

type variables
n_tr itr_web
int ii_activa,ii_visible,ii_anio,ii_periodo
st_confirma_usuario ist_confirma_usuario
string is_pagina 

uo_periodo_servicios iuo_periodo_servicios  


end variables

on w_proceso_apertura_bajatot.create
int iCurrent
call super::create
this.st_periodo_anio=create st_periodo_anio
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
this.Control[iCurrent+2]=this.rb_deshabilita
this.Control[iCurrent+3]=this.rb_habilita
this.Control[iCurrent+4]=this.rb_cerrada
this.Control[iCurrent+5]=this.st_trans_preinsc
this.Control[iCurrent+6]=this.rb_abierta
this.Control[iCurrent+7]=this.cb_habilita
this.Control[iCurrent+8]=this.cb_trans
this.Control[iCurrent+9]=this.cbx_trans_preinsc
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_4
this.Control[iCurrent+12]=this.gb_1
end on

on w_proceso_apertura_bajatot.destroy
call super::destroy
destroy(this.st_periodo_anio)
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
WHERE cve_proceso = 11  
AND tipo_periodo = :gs_tipo_periodo 
using gtr_sce;


iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 

STRING ls_periodo 

ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( ii_periodo, "L")  

st_periodo_anio.TEXT = ls_periodo + " - " + STRING(ii_anio) 



end event

type st_periodo_anio from statictext within w_proceso_apertura_bajatot
integer x = 1710
integer y = 168
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

type rb_deshabilita from radiobutton within w_proceso_apertura_bajatot
integer x = 1207
integer y = 788
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

type rb_habilita from radiobutton within w_proceso_apertura_bajatot
integer x = 1207
integer y = 688
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

type rb_cerrada from radiobutton within w_proceso_apertura_bajatot
integer x = 329
integer y = 788
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

type st_trans_preinsc from statictext within w_proceso_apertura_bajatot
integer x = 1280
integer y = 388
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

type rb_abierta from radiobutton within w_proceso_apertura_bajatot
integer x = 329
integer y = 688
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

type cb_habilita from commandbutton within w_proceso_apertura_bajatot
integer x = 2304
integer y = 680
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

event clicked;if messagebox('Aviso','¿Desea Habilitar/Deshabilitar la Baja Total?', Question!,Yesno!) = 2 then 
	messagebox('Aviso','No se pudo Habilitar/Deshabilitar la Baja Total')
	return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	RETURN 
END IF

//HABILITA LA BAJA TOTAL
UPDATE web_bd.dbo.www_menu
SET visible = :ii_visible
WHERE cve_menu = 27 
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
//HABILITA LA BAJA TOTAL
UPDATE parametros_servicios
SET baja_total_activa = :ii_activa
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
commit using itr_web;

messagebox('Aviso','Proceso de Habilitar/Deshabilitar la Baja Total ejecutado')
end event

type cb_trans from commandbutton within w_proceso_apertura_bajatot
integer x = 2304
integer y = 364
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

event clicked;int li_periodo,li_anio
string ls_periodo
long ll_trans_bajas

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	cbx_trans_preinsc.checked = false
	cb_trans.enabled = false
	RETURN 
END IF

st_trans_preinsc.text = ''
Setpointer(hourglass!)
//	SP se ejecuta en SQL
DECLARE  sp_procedure2 PROCEDURE FOR sp_transfiere_solicitud_tramite_internet 
@tipo_periodo = :gs_tipo_periodo 
using itr_web ; 
	
EXECUTE sp_procedure2; //Ejecutamos con el nombre del Alias
if len(itr_web.sqlerrtext) > 0 then
	messagebox('Error',itr_web.sqlerrtext)
	cbx_trans_preinsc.enabled = false
else
	commit using itr_web;
end if
CLOSE sp_procedure2;


//if ii_periodo = 0 then
//	li_anio = ii_anio - 1
//	li_periodo = 2
//else
//	li_periodo = ii_periodo - 1 
//	li_anio = ii_anio
//end if 

li_periodo = ii_periodo
li_anio = ii_anio

// Se recupera el periodo anterior 
iuo_periodo_servicios.f_recupera_periodo_anterior( li_periodo, li_anio, gtr_sce) 
	

select count(*) 
	into :ll_trans_bajas
from hist_solicitud_tramite_internet
where periodo = :li_periodo
and anio = :li_anio 
using itr_web;

st_trans_preinsc.visible = true
if ll_trans_bajas > 0 then	st_trans_preinsc.text = 'Solicitudes transferidas: ' + string(ll_trans_bajas,'#,##0')
	
messagebox('Aviso','Proceso de Transferencia de Solicitudes por Internet ejecutado')

cbx_trans_preinsc.enabled = false
cb_trans.enabled = false
end event

type cbx_trans_preinsc from checkbox within w_proceso_apertura_bajatot
integer x = 256
integer y = 388
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
string text = "Transfiere Solicitudes por Internet"
end type

event clicked;int li_periodo, li_anio
string ls_desc_periodo




//if ii_periodo = 0 then
//	li_anio = ii_anio - 1
//	li_periodo = 2
//else
//	li_periodo = ii_periodo - 1 
//	li_anio = ii_anio
//end if

li_periodo = ii_periodo
li_anio = ii_anio

// Se recupera el periodo anterior 
iuo_periodo_servicios.f_recupera_periodo_anterior( li_periodo, li_anio, gtr_sce) 



/*if li_periodo = 0 then ls_desc_periodo = 'Primavera ' + string(li_anio)
if li_periodo = 1 then ls_desc_periodo = 'Verano ' + string(li_anio)
if li_periodo = 2 then ls_desc_periodo = 'Otoño ' + string(li_anio)*/

ls_desc_periodo = iuo_periodo_servicios.f_recupera_descripcion( li_periodo, "L") + " - " + string(li_anio) 

if messagebox('Aviso','¿Desea generar el proceso de Transferencia de Solicitudes por Internet del periodo '+ ls_desc_periodo +'?', Question!,Yesno!) = 1 then
	cb_trans.enabled = true
else
	messagebox('Aviso','No se pudo ejecutar el proceso de Transferencia de Solicitudes por Internet')
	this.checked = false
	cb_trans.enabled = false
end if
end event

type gb_2 from groupbox within w_proceso_apertura_bajatot
integer x = 256
integer y = 592
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

type gb_4 from groupbox within w_proceso_apertura_bajatot
integer x = 1170
integer y = 592
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

type gb_1 from groupbox within w_proceso_apertura_bajatot
integer x = 110
integer y = 64
integer width = 2743
integer height = 956
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proceso Apertura / Cierre Baja Total"
end type

