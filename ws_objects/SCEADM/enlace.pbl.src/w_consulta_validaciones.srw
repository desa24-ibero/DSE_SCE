$PBExportHeader$w_consulta_validaciones.srw
forward
global type w_consulta_validaciones from window
end type
type cb_imprimir from commandbutton within w_consulta_validaciones
end type
type dw_1 from datawindow within w_consulta_validaciones
end type
type cb_1 from commandbutton within w_consulta_validaciones
end type
end forward

global type w_consulta_validaciones from window
integer width = 3858
integer height = 1576
boolean titlebar = true
string title = "Busqueda de Aspirante por nombre ..."
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_imprimir cb_imprimir
dw_1 dw_1
cb_1 cb_1
end type
global w_consulta_validaciones w_consulta_validaciones

type variables
String		is_nombre
String		is_apepaterno
String		is_apematerno, is_window

str_aspirante	istr_aspirante
end variables

on w_consulta_validaciones.create
this.cb_imprimir=create cb_imprimir
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.cb_imprimir,&
this.dw_1,&
this.cb_1}
end on

on w_consulta_validaciones.destroy
destroy(this.cb_imprimir)
destroy(this.dw_1)
destroy(this.cb_1)
end on

event open;integer li_rows

is_window = Message.StringParm

choose case is_window
	case 'CAR'
		This.title = 'Aspirantes con carreras diferentes en admisión y control escolar'
		dw_1.dataobject = 'dw_carreras_asp_dif_adm_controlesc'
	case 'PAQ'		
		This.title = 'Paquetes con grupos inexistentes'
		dw_1.dataobject = 'dw_paq_mat_sin_grupos_exist'
end choose

dw_1.SetTransObject ( gtr_sadm )
li_rows = dw_1.Retrieve (  gi_anio, gi_periodo )
If li_rows =  0 Then
	Messagebox('Mensaje del Sistema', 'No existen registros')
End If

IF dw_1.RowCount ( ) > 0 THEN
    dw_1.SetFocus ( )
END IF
end event

type cb_imprimir from commandbutton within w_consulta_validaciones
integer x = 2053
integer y = 1328
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;
If dw_1.rowcount( ) > 0 Then
		PrintSetup();

		If is_window = 'CAR' Then
			dw_1.Object.DataWindow.Zoom = 80
		End If
		If 	dw_1.print() = -1 Then
			If is_window = 'CAR' Then
				dw_1.Object.DataWindow.Zoom = 100
			End If
			MessageBox('Error del Sistema', 'Error al imprimir el documento')
			return -1
		End If
		If is_window = 'CAR' Then
			dw_1.Object.DataWindow.Zoom = 100
		End If
Else
	MessageBox('Mensaje del Sistema', 'No existe información en el reporte para imprimir')
End If
end event

type dw_1 from datawindow within w_consulta_validaciones
integer x = 23
integer y = 12
integer width = 3794
integer height = 1276
integer taborder = 50
string title = "none"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

type cb_1 from commandbutton within w_consulta_validaciones
integer x = 1362
integer y = 1328
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cerrar"
end type

event clicked;Close(Parent)
end event

