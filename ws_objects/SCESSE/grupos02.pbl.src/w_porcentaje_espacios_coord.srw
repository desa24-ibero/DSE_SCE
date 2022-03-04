$PBExportHeader$w_porcentaje_espacios_coord.srw
forward
global type w_porcentaje_espacios_coord from window
end type
type cb_2 from commandbutton within w_porcentaje_espacios_coord
end type
type cb_1 from commandbutton within w_porcentaje_espacios_coord
end type
type dw_porcentaje_espacios_coord from datawindow within w_porcentaje_espacios_coord
end type
end forward

global type w_porcentaje_espacios_coord from window
integer width = 3867
integer height = 2284
boolean titlebar = true
string title = "Porcentaje de Uso de Espacios por Coordinación"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_porcentaje_espacios_coord dw_porcentaje_espacios_coord
end type
global w_porcentaje_espacios_coord w_porcentaje_espacios_coord

type variables
str_periodo_coord  ist_parametros 
long il_periodo, il_anio, il_cve_coordinacion
n_tr itr_original

end variables

on w_porcentaje_espacios_coord.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_porcentaje_espacios_coord=create dw_porcentaje_espacios_coord
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_porcentaje_espacios_coord}
end on

on w_porcentaje_espacios_coord.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_porcentaje_espacios_coord)
end on

event open;
//Lee los valores recibidos por la ventana anterior
ist_parametros = Message.PowerObjectParm	
	
il_cve_coordinacion=	ist_parametros.cve_coordinacion 
il_anio = 	ist_parametros.anio 
il_periodo=	ist_parametros.periodo 

//

//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if



dw_porcentaje_espacios_coord.SetTransObject(itr_original)
itr_original.Autocommit = true
dw_porcentaje_espacios_coord.Retrieve(il_periodo, il_anio, il_cve_coordinacion)
itr_original.Autocommit = false

end event

event close;
if isvalid(itr_original) then
	DISCONNECT USING itr_original;	
end if


end event

type cb_2 from commandbutton within w_porcentaje_espacios_coord
integer x = 2245
integer y = 2032
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;close(parent)
end event

type cb_1 from commandbutton within w_porcentaje_espacios_coord
integer x = 1317
integer y = 2040
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;dw_porcentaje_espacios_coord.Print()
end event

type dw_porcentaje_espacios_coord from datawindow within w_porcentaje_espacios_coord
integer x = 69
integer y = 64
integer width = 3675
integer height = 1932
integer taborder = 10
string title = "none"
string dataobject = "d_porcentaje_espacios_coord"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

