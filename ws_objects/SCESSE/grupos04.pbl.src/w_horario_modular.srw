$PBExportHeader$w_horario_modular.srw
forward
global type w_horario_modular from window
end type
type cb_2 from commandbutton within w_horario_modular
end type
type cb_1 from commandbutton within w_horario_modular
end type
type pb_borra_horario from picturebutton within w_horario_modular
end type
type pb_inserta_horario from picturebutton within w_horario_modular
end type
type dw_horario from datawindow within w_horario_modular
end type
end forward

global type w_horario_modular from window
integer width = 4014
integer height = 1812
boolean titlebar = true
string title = "Horario Grupo Modular"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
pb_borra_horario pb_borra_horario
pb_inserta_horario pb_inserta_horario
dw_horario dw_horario
end type
global w_horario_modular w_horario_modular

type variables
INTEGER ie_anio
end variables

on w_horario_modular.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_borra_horario=create pb_borra_horario
this.pb_inserta_horario=create pb_inserta_horario
this.dw_horario=create dw_horario
this.Control[]={this.cb_2,&
this.cb_1,&
this.pb_borra_horario,&
this.pb_inserta_horario,&
this.dw_horario}
end on

on w_horario_modular.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_borra_horario)
destroy(this.pb_inserta_horario)
destroy(this.dw_horario)
end on

event open;uo_grupo_paso luo_grupo_paso

luo_grupo_paso = MESSAGE.POWEROBJECTPARM


luo_grupo_paso.ids_grupo_sesion.ROWSCOPY(1, luo_grupo_paso.ids_grupo_sesion.ROWCOUNT(), PRIMARY!, dw_horario, 1, PRIMARY!) 


ie_anio = luo_grupo_paso.ie_anio
end event

type cb_2 from commandbutton within w_horario_modular
integer x = 3511
integer y = 368
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 



end event

type cb_1 from commandbutton within w_horario_modular
integer x = 3511
integer y = 240
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

type pb_borra_horario from picturebutton within w_horario_modular
integer x = 3630
integer y = 100
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row 

le_row = dw_horario.GETROW()

IF le_row > 0 THEN dw_horario.DELETEROW(le_row) 

dw_horario.TRIGGEREVENT("ue_valida_horario") 




end event

type pb_inserta_horario from picturebutton within w_horario_modular
integer x = 3511
integer y = 100
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row, valor
//le_row = dw_horario.INSERTROW(0)
//SETNULL(valor) 
//
le_row = PARENT.dw_horario.INSERTROW(0) 

DATE ldt_fecha 

ldt_fecha = DATE("01/01/" + STRING(ie_anio)) 

dw_horario.SETITEM(le_row, "fecha_inicio", ldt_fecha)
dw_horario.SETITEM(le_row, "fecha_fin", ldt_fecha)

RETURN le_row 


end event

type dw_horario from datawindow within w_horario_modular
integer x = 73
integer y = 84
integer width = 3319
integer height = 1524
integer taborder = 10
string title = "none"
string dataobject = "dw_horario_modular"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

