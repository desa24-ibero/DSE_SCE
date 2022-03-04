$PBExportHeader$w_reasigna_orden_cobro.srw
forward
global type w_reasigna_orden_cobro from window
end type
type st_3 from statictext within w_reasigna_orden_cobro
end type
type st_2 from statictext within w_reasigna_orden_cobro
end type
type sle_orden_cobro_destino from singlelineedit within w_reasigna_orden_cobro
end type
type cb_cancelar from commandbutton within w_reasigna_orden_cobro
end type
type cb_aceptar from commandbutton within w_reasigna_orden_cobro
end type
type sle_orden_cobro from singlelineedit within w_reasigna_orden_cobro
end type
type st_1 from statictext within w_reasigna_orden_cobro
end type
end forward

global type w_reasigna_orden_cobro from window
integer x = 846
integer y = 372
integer width = 1701
integer height = 776
boolean titlebar = true
string title = "Reasignación de Ordenes de Cobro"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
st_3 st_3
st_2 st_2
sle_orden_cobro_destino sle_orden_cobro_destino
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
sle_orden_cobro sle_orden_cobro
st_1 st_1
end type
global w_reasigna_orden_cobro w_reasigna_orden_cobro

forward prototypes
public function boolean wf_ordenes_validas (string as_orden_origen, string as_orden_destino)
end prototypes

public function boolean wf_ordenes_validas (string as_orden_origen, string as_orden_destino);//wf_ordenes_validas
// Revisa si las ordenes origen y destino son validas
//as_orden_origen
//as_orden_destino


int li_i
boolean lb_sirve_origen = true, lb_sirve_destino = true
int li_char
string ls_null
SetNull(ls_null)

if as_orden_origen = "" or  as_orden_origen= ls_null then 
	MessageBox("Atención", "Escriba algo en la orden de cobro Origen", StopSign!)
	return false
end if
	
if as_orden_destino = "" or  as_orden_destino=  ls_null then 
	MessageBox("Atención", "Escriba algo en la orden de cobro Destino", StopSign!)
	return false
end if
	
li_i = 1
do while li_i <= len(as_orden_origen) and lb_sirve_origen = true
	li_char = asc(mid(as_orden_origen,li_i,1))
	if li_char <> 45 AND (li_char < 48 OR li_char > 57 ) AND (li_char < 65 OR li_char > 90 ) then lb_sirve_origen = false
	li_i ++
loop

if not lb_sirve_origen then 
	MessageBox("Atención", "Sólo se admiten números, letras y guiones en la orden de cobro Origen", StopSign!)
	return false
end if

li_i = 1
do while li_i <= len(as_orden_destino) and lb_sirve_destino = true
	li_char = asc(mid(as_orden_destino,li_i,1))
	if li_char <> 45 AND (li_char < 48 OR li_char > 57 ) AND (li_char < 65 OR li_char > 90 ) then lb_sirve_destino = false
	li_i ++
loop

if not lb_sirve_destino then 
	MessageBox("Atención", "Sólo se admiten números, letras y guiones en la orden de cobro Destino", StopSign!)
	return false
end if
	
if not f_existe_orden_cobro(as_orden_origen) then
	MessageBox("Atención", "No existen registros correspondientes a la orden de cobro Origen", StopSign!)
	return false
end if

if f_existe_orden_cobro(as_orden_destino) then
	MessageBox("Atención", "La orden de cobro Destino ya se encuentra asignada", StopSign!)
	return false
end if


return true
end function

on w_reasigna_orden_cobro.create
this.st_3=create st_3
this.st_2=create st_2
this.sle_orden_cobro_destino=create sle_orden_cobro_destino
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.sle_orden_cobro=create sle_orden_cobro
this.st_1=create st_1
this.Control[]={this.st_3,&
this.st_2,&
this.sle_orden_cobro_destino,&
this.cb_cancelar,&
this.cb_aceptar,&
this.sle_orden_cobro,&
this.st_1}
end on

on w_reasigna_orden_cobro.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_orden_cobro_destino)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.sle_orden_cobro)
destroy(this.st_1)
end on

event open;x= 1
y= 1
end event

type st_3 from statictext within w_reasigna_orden_cobro
integer x = 690
integer y = 280
integer width = 242
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = oem!
fontpitch fontpitch = fixed!
fontfamily fontfamily = modern!
string facename = "Terminal"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "====>"
boolean focusrectangle = false
end type

type st_2 from statictext within w_reasigna_orden_cobro
integer x = 905
integer y = 108
integer width = 521
integer height = 124
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Orden de cobro Destino/Definitiva"
alignment alignment = center!
boolean focusrectangle = false
end type

type sle_orden_cobro_destino from singlelineedit within w_reasigna_orden_cobro
integer x = 942
integer y = 264
integer width = 457
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type cb_cancelar from commandbutton within w_reasigna_orden_cobro
integer x = 905
integer y = 508
integer width = 334
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;close( parent)
end event

type cb_aceptar from commandbutton within w_reasigna_orden_cobro
integer x = 407
integer y = 508
integer width = 334
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;string ls_orden_origen, ls_orden_destino
integer li_resultado_asignacion, li_confirma

ls_orden_origen = sle_orden_cobro.text 
ls_orden_destino = sle_orden_cobro_destino.text

// Revisa si las ordenes origen y destino son validas
if wf_ordenes_validas(ls_orden_origen, ls_orden_destino) then
	
	li_confirma = MessageBox("Confirmacion", "Desea sustituir la orden de cobro ["+ls_orden_origen &
	                        +"] con la orden ["+ ls_orden_destino+"]", Question!, YesNo!)
	if li_confirma = 1 then
		li_resultado_asignacion = f_reasigna_orden_cobro(ls_orden_origen, ls_orden_destino)
		if li_resultado_asignacion= -1 then
			MessageBox("Atención", "Favor de Intentar nuevamente", StopSign!)
			return 	
		elseif li_resultado_asignacion= 0 then
			MessageBox("Actualizacion Exitosa", "Se ha reasignado exitosamente la orden de cobro", Information!)
			return 	
		elseif li_resultado_asignacion= 100 then
			MessageBox("Actualizacion sin Registros", "No existen registros a reasignar", Information!)
			return 	
		end if
	end if
else
	MessageBox("Atención", "Favor de corregir la informacion", StopSign!)
	return 
end if
end event

type sle_orden_cobro from singlelineedit within w_reasigna_orden_cobro
integer x = 210
integer y = 264
integer width = 457
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
textcase textcase = upper!
integer limit = 12
borderstyle borderstyle = stylelowered!
end type

type st_1 from statictext within w_reasigna_orden_cobro
integer x = 192
integer y = 108
integer width = 489
integer height = 124
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Orden de cobro Origen/Temporal"
alignment alignment = center!
boolean focusrectangle = false
end type

