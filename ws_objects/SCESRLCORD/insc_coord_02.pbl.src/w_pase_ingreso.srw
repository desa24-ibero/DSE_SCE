$PBExportHeader$w_pase_ingreso.srw
forward
global type w_pase_ingreso from window
end type
type st_1 from statictext within w_pase_ingreso
end type
type cb_2 from commandbutton within w_pase_ingreso
end type
type cb_1 from commandbutton within w_pase_ingreso
end type
type dw_pase_ingreso from datawindow within w_pase_ingreso
end type
end forward

global type w_pase_ingreso from window
integer width = 3643
integer height = 1824
boolean titlebar = true
string title = "Impresión del Pase de Ingreso"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 16777215
string icon = "ApplicationIcon!"
boolean clientedge = true
st_1 st_1
cb_2 cb_2
cb_1 cb_1
dw_pase_ingreso dw_pase_ingreso
end type
global w_pase_ingreso w_pase_ingreso

on w_pase_ingreso.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_pase_ingreso=create dw_pase_ingreso
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_1,&
this.dw_pase_ingreso}
end on

on w_pase_ingreso.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_pase_ingreso)
end on

event open;long ll_cuenta, ll_rows

if isvalid(w_reinscripcion) then
	ll_cuenta = w_reinscripcion_2014.il_cuenta
else
	ll_cuenta = w_preinscripción_2014.il_cuenta
end if

dw_pase_ingreso.SetTransObject(sqlca)

if (ll_cuenta> 0 and not isnull(ll_cuenta)) then 
	ll_rows = dw_pase_ingreso.Retrieve(ll_cuenta)
end if




end event

type st_1 from statictext within w_pase_ingreso
boolean visible = false
integer x = 1778
integer y = 2452
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "I"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_pase_ingreso
integer x = 2117
integer y = 1556
integer width = 745
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Volver a Inscripción/Cerrar"
end type

event clicked;Close(parent)
end event

type cb_1 from commandbutton within w_pase_ingreso
integer x = 1120
integer y = 1556
integer width = 713
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Pase de Ingreso"
end type

event clicked;integer li_confirmacion, li_impresion
if dw_pase_ingreso.RowCount()>0 then

	li_confirmacion = MessageBox("Confirme Impresión","Desea Imprimir el pase de ingreso", Question!, YesNo!)
	if li_confirmacion = 1 then
		li_impresion = dw_pase_ingreso.Print()
		if li_impresion = -1 then
			MessageBox("Error de Impresión", "No es posible imprimir el pase de ingreso", StopSign!)
		end if
	end if
else
	MessageBox("Información Inexistente", "NO existe Información de alumno para imprimir el pase de ingreso", StopSign!)	
end if
end event

type dw_pase_ingreso from datawindow within w_pase_ingreso
integer x = 46
integer y = 52
integer width = 3506
integer height = 1460
integer taborder = 10
string title = "none"
string dataobject = "d_pase_ingreso"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

