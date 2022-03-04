$PBExportHeader$w_grupos_sin_salon.srw
forward
global type w_grupos_sin_salon from window
end type
type st_1 from statictext within w_grupos_sin_salon
end type
type cb_cerrar from commandbutton within w_grupos_sin_salon
end type
type dw_salones_sin_horario from datawindow within w_grupos_sin_salon
end type
end forward

global type w_grupos_sin_salon from window
integer width = 2857
integer height = 1408
boolean titlebar = true
string title = "Horarios Sin Salón Asignado"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_1 st_1
cb_cerrar cb_cerrar
dw_salones_sin_horario dw_salones_sin_horario
end type
global w_grupos_sin_salon w_grupos_sin_salon

type variables
public st_cve_mat_gpo ist_cve_mat_gpo
end variables

event open;if (dw_salones_sin_horario.retrieve(gi_anio,gi_periodo) = 0) then
	MessageBox("Atencion", "NO hay grupos sin salón par ael año y periodo seleccionados.", StopSign!)
	cb_cerrar.event clicked()
end if
end event

on w_grupos_sin_salon.create
this.st_1=create st_1
this.cb_cerrar=create cb_cerrar
this.dw_salones_sin_horario=create dw_salones_sin_horario
this.Control[]={this.st_1,&
this.cb_cerrar,&
this.dw_salones_sin_horario}
end on

on w_grupos_sin_salon.destroy
destroy(this.st_1)
destroy(this.cb_cerrar)
destroy(this.dw_salones_sin_horario)
end on

event close;//st_cve_mat_gpo lst_cve_mat_gpo
//lst_cve_mat_gpo.cve_mat = 0
//lst_cve_mat_gpo.gpo = ""
CloseWithReturn(this,ist_cve_mat_gpo)
end event

type st_1 from statictext within w_grupos_sin_salon
integer x = 46
integer y = 1184
integer width = 1856
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Para seleccionar un grupo haga doble click sobre uno de sus horarios"
boolean focusrectangle = false
end type

type cb_cerrar from commandbutton within w_grupos_sin_salon
integer x = 2386
integer y = 1172
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "cerrar"
end type

event clicked;//st_cve_mat_gpo lst_cve_mat_gpo
//lst_cve_mat_gpo.cve_mat = 0
//lst_cve_mat_gpo.gpo = ""
////CloseWithReturn(parent,lst_cve_mat_gpo)
parent.event Close()
end event

type dw_salones_sin_horario from datawindow within w_grupos_sin_salon
integer x = 41
integer y = 32
integer width = 2747
integer height = 1120
integer taborder = 10
string title = "none"
string dataobject = "d_asigna_automatica_salon"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(gtr_sce)
//Modify("horario_cve_salon.TabOrder = '0'")
//Object.horario_cve_salon.TabOrder = 0
end event

event doubleclicked;if row > 0 then
	ist_cve_mat_gpo.cve_mat = GetItemNumber(row,"horario_cve_mat")
	ist_cve_mat_gpo.gpo = GetItemString(row,"horario_gpo")
	parent.event close()
	//closewithreturn(parent,lst_cve_mat_gpo)
end if
end event

