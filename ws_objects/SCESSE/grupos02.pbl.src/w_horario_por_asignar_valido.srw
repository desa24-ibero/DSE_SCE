$PBExportHeader$w_horario_por_asignar_valido.srw
forward
global type w_horario_por_asignar_valido from window
end type
type cb_1 from commandbutton within w_horario_por_asignar_valido
end type
type st_3 from statictext within w_horario_por_asignar_valido
end type
type st_2 from statictext within w_horario_por_asignar_valido
end type
type st_1 from statictext within w_horario_por_asignar_valido
end type
type em_hora_final from editmask within w_horario_por_asignar_valido
end type
type em_hora_inicio from editmask within w_horario_por_asignar_valido
end type
type em_dia from editmask within w_horario_por_asignar_valido
end type
end forward

global type w_horario_por_asignar_valido from window
integer width = 1765
integer height = 992
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
st_3 st_3
st_2 st_2
st_1 st_1
em_hora_final em_hora_final
em_hora_inicio em_hora_inicio
em_dia em_dia
end type
global w_horario_por_asignar_valido w_horario_por_asignar_valido

on w_horario_por_asignar_valido.create
this.cb_1=create cb_1
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.em_hora_final=create em_hora_final
this.em_hora_inicio=create em_hora_inicio
this.em_dia=create em_dia
this.Control[]={this.cb_1,&
this.st_3,&
this.st_2,&
this.st_1,&
this.em_hora_final,&
this.em_hora_inicio,&
this.em_dia}
end on

on w_horario_por_asignar_valido.destroy
destroy(this.cb_1)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_hora_final)
destroy(this.em_hora_inicio)
destroy(this.em_dia)
end on

type cb_1 from commandbutton within w_horario_por_asignar_valido
integer x = 741
integer y = 748
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Valida"
end type

event clicked;boolean lb_horario_por_asignar_valido
string ls_cve_dia, ls_hora_inicio , ls_hora_final
integer li_cve_dia, li_hora_inicio , li_hora_final

li_cve_dia = integer(em_dia.text)
li_hora_inicio  =integer(em_hora_inicio.text)
li_hora_final= integer(em_hora_final.text)


lb_horario_por_asignar_valido =f_horario_por_asignar_valido (li_cve_dia, li_hora_inicio , li_hora_final)

if lb_horario_por_asignar_valido then
	Messagebox("OK", "HORARIO VALIDO", iNFORMATION!)
else
	Messagebox("ERROR", "HORARIO INVALIDO", StopSign!)
end if

end event

type st_3 from statictext within w_horario_por_asignar_valido
integer x = 251
integer y = 536
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
string text = "Hora Final"
boolean focusrectangle = false
end type

type st_2 from statictext within w_horario_por_asignar_valido
integer x = 251
integer y = 312
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
string text = "Hora Inicio"
boolean focusrectangle = false
end type

type st_1 from statictext within w_horario_por_asignar_valido
integer x = 251
integer y = 76
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
string text = "Día"
boolean focusrectangle = false
end type

type em_hora_final from editmask within w_horario_por_asignar_valido
integer x = 690
integer y = 512
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type em_hora_inicio from editmask within w_horario_por_asignar_valido
integer x = 690
integer y = 288
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type em_dia from editmask within w_horario_por_asignar_valido
integer x = 690
integer y = 52
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

