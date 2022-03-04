$PBExportHeader$w_proceso_apertura_reinsc.srw
forward
global type w_proceso_apertura_reinsc from pfc_w_master
end type
type cbx_sepe from checkbox within w_proceso_apertura_reinsc
end type
type cb_sepe from commandbutton within w_proceso_apertura_reinsc
end type
type dw_sepe from datawindow within w_proceso_apertura_reinsc
end type
type st_periodo_anio from statictext within w_proceso_apertura_reinsc
end type
type rb_deshabilita from radiobutton within w_proceso_apertura_reinsc
end type
type rb_habilita from radiobutton within w_proceso_apertura_reinsc
end type
type rb_cerrada from radiobutton within w_proceso_apertura_reinsc
end type
type rb_abierta from radiobutton within w_proceso_apertura_reinsc
end type
type rb_consulta from radiobutton within w_proceso_apertura_reinsc
end type
type cb_habilita from commandbutton within w_proceso_apertura_reinsc
end type
type cb_trans from commandbutton within w_proceso_apertura_reinsc
end type
type cb_actualiza from commandbutton within w_proceso_apertura_reinsc
end type
type dw_preinscribibles from datawindow within w_proceso_apertura_reinsc
end type
type cbx_trans_preinsc from checkbox within w_proceso_apertura_reinsc
end type
type cbx_act_preinsc from checkbox within w_proceso_apertura_reinsc
end type
type gb_2 from groupbox within w_proceso_apertura_reinsc
end type
type gb_4 from groupbox within w_proceso_apertura_reinsc
end type
type gb_1 from groupbox within w_proceso_apertura_reinsc
end type
type st_trans_preinsc from statictext within w_proceso_apertura_reinsc
end type
type st_trans_mat_preinsc from statictext within w_proceso_apertura_reinsc
end type
end forward

global type w_proceso_apertura_reinsc from pfc_w_master
integer width = 3090
integer height = 1960
string title = "Apertura / Cierre de Reinscripción"
cbx_sepe cbx_sepe
cb_sepe cb_sepe
dw_sepe dw_sepe
st_periodo_anio st_periodo_anio
rb_deshabilita rb_deshabilita
rb_habilita rb_habilita
rb_cerrada rb_cerrada
rb_abierta rb_abierta
rb_consulta rb_consulta
cb_habilita cb_habilita
cb_trans cb_trans
cb_actualiza cb_actualiza
dw_preinscribibles dw_preinscribibles
cbx_trans_preinsc cbx_trans_preinsc
cbx_act_preinsc cbx_act_preinsc
gb_2 gb_2
gb_4 gb_4
gb_1 gb_1
st_trans_preinsc st_trans_preinsc
st_trans_mat_preinsc st_trans_mat_preinsc
end type
global w_proceso_apertura_reinsc w_proceso_apertura_reinsc

type variables
n_tr itr_web
int ii_activa,ii_visible,ii_periodo,ii_anio
st_confirma_usuario ist_confirma_usuario
string is_pagina


uo_periodo_servicios iuo_periodo_servicios 
end variables

on w_proceso_apertura_reinsc.create
int iCurrent
call super::create
this.cbx_sepe=create cbx_sepe
this.cb_sepe=create cb_sepe
this.dw_sepe=create dw_sepe
this.st_periodo_anio=create st_periodo_anio
this.rb_deshabilita=create rb_deshabilita
this.rb_habilita=create rb_habilita
this.rb_cerrada=create rb_cerrada
this.rb_abierta=create rb_abierta
this.rb_consulta=create rb_consulta
this.cb_habilita=create cb_habilita
this.cb_trans=create cb_trans
this.cb_actualiza=create cb_actualiza
this.dw_preinscribibles=create dw_preinscribibles
this.cbx_trans_preinsc=create cbx_trans_preinsc
this.cbx_act_preinsc=create cbx_act_preinsc
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_1=create gb_1
this.st_trans_preinsc=create st_trans_preinsc
this.st_trans_mat_preinsc=create st_trans_mat_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_sepe
this.Control[iCurrent+2]=this.cb_sepe
this.Control[iCurrent+3]=this.dw_sepe
this.Control[iCurrent+4]=this.st_periodo_anio
this.Control[iCurrent+5]=this.rb_deshabilita
this.Control[iCurrent+6]=this.rb_habilita
this.Control[iCurrent+7]=this.rb_cerrada
this.Control[iCurrent+8]=this.rb_abierta
this.Control[iCurrent+9]=this.rb_consulta
this.Control[iCurrent+10]=this.cb_habilita
this.Control[iCurrent+11]=this.cb_trans
this.Control[iCurrent+12]=this.cb_actualiza
this.Control[iCurrent+13]=this.dw_preinscribibles
this.Control[iCurrent+14]=this.cbx_trans_preinsc
this.Control[iCurrent+15]=this.cbx_act_preinsc
this.Control[iCurrent+16]=this.gb_2
this.Control[iCurrent+17]=this.gb_4
this.Control[iCurrent+18]=this.gb_1
this.Control[iCurrent+19]=this.st_trans_preinsc
this.Control[iCurrent+20]=this.st_trans_mat_preinsc
end on

on w_proceso_apertura_reinsc.destroy
call super::destroy
destroy(this.cbx_sepe)
destroy(this.cb_sepe)
destroy(this.dw_sepe)
destroy(this.st_periodo_anio)
destroy(this.rb_deshabilita)
destroy(this.rb_habilita)
destroy(this.rb_cerrada)
destroy(this.rb_abierta)
destroy(this.rb_consulta)
destroy(this.cb_habilita)
destroy(this.cb_trans)
destroy(this.cb_actualiza)
destroy(this.dw_preinscribibles)
destroy(this.cbx_trans_preinsc)
destroy(this.cbx_act_preinsc)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_1)
destroy(this.st_trans_preinsc)
destroy(this.st_trans_mat_preinsc)
end on

event open;call super::open;int li_visible,li_periodo,li_anio,li_revision
string ls_periodo

x=1
y=1

Setpointer(hourglass!)

if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	return
End if

dw_preinscribibles.SetTransObject(gtr_sce)
dw_sepe.Reset()
dw_sepe.Insertrow(0)

  SELECT  periodo_preinscripcion_sepe.periodo_sepe ,
           periodo_preinscripcion_sepe.anio_sepe ,
           periodo_preinscripcion_sepe.revision_activa 
	into :li_periodo, :li_anio,:li_revision
     FROM web_bd.dbo.periodo_preinscripcion_sepe 
	  WHERE periodo_preinscripcion_sepe.tipo_periodo = :gs_tipo_periodo 
	  using itr_web;

dw_sepe.Setitem(1,'anio_sepe',li_anio)
dw_sepe.Setitem(1,'periodo_sepe',li_periodo)
dw_sepe.Setitem(1,'revision_activa',li_revision)

is_pagina = 'preinscripcion_consulta.cfm'
ii_activa = 0
ii_visible = 1

f_obten_periodo(li_periodo, li_anio, 3)

ii_periodo = li_periodo
ii_anio = li_anio


iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 
ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( ii_periodo, "L")

/*choose case ii_periodo
	case 0
		ls_periodo = 'PRIMAVERA'
	case 1
		ls_periodo = 'VERANO'
	case 2
		ls_periodo = 'OTOÑO'
end choose*/

st_periodo_anio.text = ls_periodo+" - "+string(ii_anio)


iuo_periodo_servicios.f_modifica_lista_columna( dw_sepe, "periodo_sepe", "L") 



end event

event closequery;//
end event

type cbx_sepe from checkbox within w_proceso_apertura_reinsc
integer x = 256
integer y = 1076
integer width = 768
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Valida SEPE"
end type

event clicked;if messagebox('Aviso','¿Desea validar el proceso de SEPE?', Question!,Yesno!) = 1 then
	cb_sepe.enabled = true
	dw_sepe.visible = true
else
	dw_sepe.visible = false
	cb_sepe.enabled = false
	messagebox('Aviso','No se pudo ejecutar el proceso de SEPE')
end if
end event

type cb_sepe from commandbutton within w_proceso_apertura_reinsc
integer x = 2414
integer y = 1048
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Valida SEPE"
end type

event clicked;int li_anio,li_periodo,li_revision,li_anio_mat,li_periodo_mat
string ls_periodo

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	cb_sepe.enabled = false
	RETURN 
END IF

dw_sepe.Accepttext()
li_anio = dw_sepe.Getitemnumber(1,'anio_sepe')
li_periodo = dw_sepe.Getitemnumber(1,'periodo_sepe')
li_revision = dw_sepe.Getitemnumber(1,'revision_activa')

f_obten_periodo(li_periodo_mat, li_anio_mat, 5)

/*choose case li_periodo_mat
	case 0
		ls_periodo = 'PRIMAVERA'
	case 1
		ls_periodo = 'VERANO'
	case 2
		ls_periodo = 'OTOÑO'
end choose*/

ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( li_periodo_mat, "L")


if  li_periodo > li_periodo_mat and li_anio = li_anio_mat then
	messagebox('Error','El periodo SEPE no puede ser mayor a: ' +  ls_periodo+" - "+string(li_anio_mat))
	return 1
elseif  li_periodo = li_periodo_mat and li_anio > li_anio_mat then
	messagebox('Error','El periodo SEPE no puede ser mayor a: ' +  ls_periodo+" - "+string(li_anio_mat))
	return 1
elseif  li_periodo > li_periodo_mat and li_anio > li_anio_mat then
	messagebox('Error','El periodo SEPE no puede ser mayor a: ' +  ls_periodo+" - "+string(li_anio_mat))
	return 1	
end if

/*choose case li_periodo
	case 0
		ls_periodo = 'PRIMAVERA'
	case 1
		ls_periodo = 'VERANO'
	case 2
		ls_periodo = 'OTOÑO'
end choose*/

ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( li_periodo, "L") 

if messagebox('Aviso','¿Esta seguro de actualizar el periodo SEPE a: ' +   ls_periodo+" - "+string(li_anio),Question! ,Yesno!) = 1 then
	
	UPDATE parametros_servicios
	SET periodo_preinscripcion = :ii_periodo,
		  anio_preinscripcion  = :ii_anio 
	where cve_parametro = 1
	AND tipo_periodo = :gs_tipo_periodo
	using itr_web;
	
	if itr_web.sqlcode <> 0 then
		messagebox('Error',itr_web.sqlerrtext)
		return
	end if
		
	UPDATE web_bd.dbo.periodo_preinscripcion_sepe 
	SET periodo_preinsc = :ii_periodo,
			anio_preinsc  = :ii_anio ,
			periodo_sepe = :li_periodo,
			anio_sepe =  :li_anio ,
			revision_activa = :li_revision
	WHERE tipo_periodo = :gs_tipo_periodo 
	using itr_web;
	if itr_web.sqlcode <> 0 then
		messagebox('Error',itr_web.sqlerrtext)
		return
	else
		commit using itr_web;
		messagebox('Aviso','Proceso de Validación de SEPE ejecutado')
	end if    
else
	Rollback using itr_web;
end if





end event

type dw_sepe from datawindow within w_proceso_apertura_reinsc
boolean visible = false
integer x = 1170
integer y = 992
integer width = 1097
integer height = 224
integer taborder = 40
string title = "none"
string dataobject = "d_parametros_sepe"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_periodo_anio from statictext within w_proceso_apertura_reinsc
integer x = 1902
integer y = 160
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

type rb_deshabilita from radiobutton within w_proceso_apertura_reinsc
integer x = 1207
integer y = 1524
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

type rb_habilita from radiobutton within w_proceso_apertura_reinsc
integer x = 1207
integer y = 1424
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

type rb_cerrada from radiobutton within w_proceso_apertura_reinsc
integer x = 329
integer y = 1576
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

event clicked;is_pagina = 'preinscripcion_academica.cfm'
ii_activa = 0
end event

type rb_abierta from radiobutton within w_proceso_apertura_reinsc
integer x = 329
integer y = 1476
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

event clicked;is_pagina = 'preinscripcion_academica.cfm'
ii_activa = 1
end event

type rb_consulta from radiobutton within w_proceso_apertura_reinsc
integer x = 329
integer y = 1376
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
string text = "Consulta "
boolean checked = true
end type

event clicked;is_pagina = 'preinscripcion_consulta.cfm'
ii_activa = 0
end event

type cb_habilita from commandbutton within w_proceso_apertura_reinsc
integer x = 2414
integer y = 1432
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

event clicked;if messagebox('Aviso','¿Desea Habilitar/Deshabilitar la Reinscripción?', Question!,Yesno!) = 2 then 
	messagebox('Aviso','No se pudo Habilitar/Deshabilitar la Reinscripción')
	return
end if

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	RETURN 
END IF

//HABILITA LA PREINSCRIPCIÓN
UPDATE web_bd.dbo.www_menu
SET visible = :ii_visible,
	pagina = :is_pagina
WHERE cve_menu = 18 
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
//HABILITA LA PREINSCRIPCIÓN
UPDATE parametros_servicios
SET preinscripcion_activa = :ii_activa
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
	return
end if
	
commit using itr_web;

messagebox('Aviso','Proceso de Habilitar/Deshabilitar la Reinscripción ejecutado')
end event

type cb_trans from commandbutton within w_proceso_apertura_reinsc
integer x = 2414
integer y = 732
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
long ll_trans_preinsc,ll_trans_mat_preinsc

Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	cbx_trans_preinsc.enabled = false
	cbx_trans_preinsc.checked = false
	cb_trans.enabled = false
	RETURN 
END IF

st_trans_preinsc.text = ''
st_trans_mat_preinsc.text = ''
Setpointer(hourglass!)
//	SP se ejecuta en Sybase
DECLARE  sp_procedure PROCEDURE FOR sp_transfiere_preinscripcion 
@tipo_periodo = :gs_tipo_periodo 
using gtr_sce ; 
	
EXECUTE sp_procedure; //Ejecutamos con el nombre del Alias
if len(gtr_sce.sqlerrtext) > 0 then
	messagebox('Error',gtr_sce.sqlerrtext)
	cbx_trans_preinsc.enabled = false
	return
else
	commit using gtr_sce;
end if
CLOSE sp_procedure;
	
//	SP se ejecuta en SQL
DECLARE  sp_procedure2 PROCEDURE FOR sp_transfiere_preinscripcion 
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

UPDATE parametros_servicios
SET periodo_preinscripcion = :ii_periodo,
anio_preinscripcion  = :ii_anio 
where cve_parametro = 1
AND tipo_periodo = :gs_tipo_periodo
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
else
	commit using itr_web;
end if

UPDATE web_bd.dbo.periodo_preinscripcion_sepe 
SET periodo_preinsc = :ii_periodo,
anio_preinsc  = :ii_anio 
WHERE tipo_periodo = :gs_tipo_periodo
using itr_web;
if itr_web.sqlcode <> 0 then
	messagebox('Error',itr_web.sqlerrtext)
else
	commit using itr_web;
end if

f_obten_periodo(li_periodo, li_anio, 5)

select count(*) 
	into :ll_trans_preinsc
from hist_preinsc
where periodo = :li_periodo
and anio = :li_anio using gtr_sce;

select count(*) 
	into :ll_trans_mat_preinsc
from hist_mat_preinsc
where periodo = :li_periodo
and anio = :li_anio using gtr_sce;

if ll_trans_preinsc > 0 then	st_trans_preinsc.text = 'Alumnos transferidos: ' + string(ll_trans_preinsc,'#,##0')
if ll_trans_mat_preinsc > 0 then st_trans_mat_preinsc.text =  'Materias transferidas: ' + string(ll_trans_mat_preinsc,'#,##0')
	
messagebox('Aviso','Proceso de Transferencia de Reinscripción ejecutado')

cbx_trans_preinsc.enabled = false
cb_trans.enabled = false




end event

type cb_actualiza from commandbutton within w_proceso_apertura_reinsc
integer x = 2414
integer y = 456
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Actualiza"
end type

event clicked;Open(w_confirma_usuario)
ist_confirma_usuario = Message.PowerObjectParm
IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	cbx_act_preinsc.checked = false
	RETURN 
END IF
Setpointer(hourglass!)
//	SP se ejecuta en Sybase
DECLARE  sp_procedure3 PROCEDURE FOR sp_actualiza_preinscribibles 
@tipo_periodo = :gs_tipo_periodo 
using gtr_sce ; 
	
EXECUTE sp_procedure3; //Ejecutamos con el nombre del Alias
if len(gtr_sce.sqlerrtext) > 0 then
	messagebox('Error',gtr_sce.sqlerrtext)
	cbx_trans_preinsc.enabled = false
	return
else
	commit using gtr_sce;
end if
CLOSE sp_procedure3;

//	SP se ejecuta en SQL
DECLARE  sp_procedure4 PROCEDURE FOR sp_actualiza_preinscribibles 
@tipo_periodo = :gs_tipo_periodo 
using itr_web ; 
	
EXECUTE sp_procedure4; //Ejecutamos con el nombre del Alias
if len(itr_web.sqlerrtext) > 0 then
	messagebox('Error',itr_web.sqlerrtext)
	cbx_trans_preinsc.enabled = false
else
	commit using itr_web;
end if
CLOSE sp_procedure4;


dw_preinscribibles.Retrieve(gs_tipo_periodo)
if dw_preinscribibles.Rowcount() > 0 then
	dw_preinscribibles.visible = true
	cbx_trans_preinsc.enabled = true
	messagebox('Aviso','Proceso de Reinscribibles ejecutado')
else
	messagebox('Error','No se pudo ejecutar el proceso de Actualización de Preinscribibles')
end if

this.enabled = false

end event

type dw_preinscribibles from datawindow within w_proceso_apertura_reinsc
boolean visible = false
integer x = 1170
integer y = 352
integer width = 622
integer height = 320
integer taborder = 20
string title = "none"
string dataobject = "d_sp_actualiza_preinscribibles"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_trans_preinsc from checkbox within w_proceso_apertura_reinsc
integer x = 256
integer y = 756
integer width = 768
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
string text = "Transfiere Reinscripción"
end type

event clicked;if messagebox('Aviso','¿Desea generar el proceso de Transferencia de Reinscripción?', Question!,Yesno!) = 1 then
	cb_trans.enabled = true
else
	messagebox('Aviso','No se pudo ejecutar el proceso de Transferencia de Reinscripción')
	this.checked = false
	cb_trans.enabled = false
end if
end event

type cbx_act_preinsc from checkbox within w_proceso_apertura_reinsc
integer x = 256
integer y = 480
integer width = 768
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Actualiza Reinscribibles"
end type

event clicked;if messagebox('Aviso','¿Desea generar el proceso de Reinscribibles?', Question!,Yesno!) = 1 then
	cb_actualiza.enabled = true
else
	this.checked = false
	cb_actualiza.enabled = false
	messagebox('Aviso','No se pudo ejecutar el proceso de Actualización de Preinscribibles')
end if
end event

type gb_2 from groupbox within w_proceso_apertura_reinsc
integer x = 256
integer y = 1280
integer width = 549
integer height = 416
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

type gb_4 from groupbox within w_proceso_apertura_reinsc
integer x = 1170
integer y = 1328
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

type gb_1 from groupbox within w_proceso_apertura_reinsc
integer x = 110
integer y = 64
integer width = 2816
integer height = 1696
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proceso Apertura / Cierre Reinscripción"
end type

type st_trans_preinsc from statictext within w_proceso_apertura_reinsc
integer x = 1170
integer y = 756
integer width = 896
integer height = 64
boolean bringtotop = true
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

type st_trans_mat_preinsc from statictext within w_proceso_apertura_reinsc
integer x = 1170
integer y = 852
integer width = 896
integer height = 64
boolean bringtotop = true
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

