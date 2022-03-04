$PBExportHeader$w_cat_carreras_disponibles.srw
forward
global type w_cat_carreras_disponibles from window
end type
type cb_actualizar from commandbutton within w_cat_carreras_disponibles
end type
type cb_eliminar from commandbutton within w_cat_carreras_disponibles
end type
type cb_nuevo from commandbutton within w_cat_carreras_disponibles
end type
type dw_carreras_disponibles from datawindow within w_cat_carreras_disponibles
end type
end forward

global type w_cat_carreras_disponibles from window
integer width = 2587
integer height = 1692
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_actualizar cb_actualizar
cb_eliminar cb_eliminar
cb_nuevo cb_nuevo
dw_carreras_disponibles dw_carreras_disponibles
end type
global w_cat_carreras_disponibles w_cat_carreras_disponibles

on w_cat_carreras_disponibles.create
this.cb_actualizar=create cb_actualizar
this.cb_eliminar=create cb_eliminar
this.cb_nuevo=create cb_nuevo
this.dw_carreras_disponibles=create dw_carreras_disponibles
this.Control[]={this.cb_actualizar,&
this.cb_eliminar,&
this.cb_nuevo,&
this.dw_carreras_disponibles}
end on

on w_cat_carreras_disponibles.destroy
destroy(this.cb_actualizar)
destroy(this.cb_eliminar)
destroy(this.cb_nuevo)
destroy(this.dw_carreras_disponibles)
end on

event close;if dw_carreras_disponibles.modifiedcount()>0 or dw_carreras_disponibles.deletedcount()>0 then
	if messagebox("Mensaje del sistema", "Se han realizado cambios, desea guardarlos?",question!,yesno!)=1 then
		cb_actualizar.triggerevent(clicked!)
	end if
end if
end event

event open;dw_carreras_disponibles.settransobject(gtr_sce)
dw_carreras_disponibles.retrieve()
end event

type cb_actualizar from commandbutton within w_cat_carreras_disponibles
integer x = 1600
integer y = 1336
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Actualizar"
end type

event clicked;if dw_carreras_disponibles.update()=1 then
	commit using gtr_sce;
	messagebox("Mensaje del Sistema","La información se ha guardado exitosamente",information!)
else
	rollback using gtr_sce;
	messagebox("Mensaje del Sistema","Ha ocurrido un error al guardar la información",stopsign!)
end if
end event

type cb_eliminar from commandbutton within w_cat_carreras_disponibles
integer x = 1019
integer y = 1336
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Eliminar"
end type

event clicked;dw_carreras_disponibles.deleterow(0)
end event

type cb_nuevo from commandbutton within w_cat_carreras_disponibles
integer x = 453
integer y = 1336
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Nuevo"
end type

event clicked;dw_carreras_disponibles.insertrow(0)
end event

type dw_carreras_disponibles from datawindow within w_cat_carreras_disponibles
integer x = 46
integer y = 40
integer width = 2414
integer height = 1200
integer taborder = 10
string title = "none"
string dataobject = "d_cat_carreras_disponibles"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;if currentrow>0 then
	selectrow(0,false)
	selectrow(currentrow,true)
end if
end event

