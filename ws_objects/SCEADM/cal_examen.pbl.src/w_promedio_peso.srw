$PBExportHeader$w_promedio_peso.srw
$PBExportComments$Ventana para modificar pesos de áreas y secciones
forward
global type w_promedio_peso from window
end type
type dw_1 from uo_dw_captura within w_promedio_peso
end type
type cb_2 from commandbutton within w_promedio_peso
end type
type uo_1 from uo_carrera within w_promedio_peso
end type
end forward

global type w_promedio_peso from window
integer x = 832
integer y = 360
integer width = 2994
integer height = 996
boolean titlebar = true
string title = "Peso de Promedio por Carrera"
string menuname = "m_menu"
long backcolor = 30976088
dw_1 dw_1
cb_2 cb_2
uo_1 uo_1
end type
global w_promedio_peso w_promedio_peso

on w_promedio_peso.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.cb_2=create cb_2
this.uo_1=create uo_1
this.Control[]={this.dw_1,&
this.cb_2,&
this.uo_1}
end on

on w_promedio_peso.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)

end event

event close;dw_1.event actualiza()
end event

type dw_1 from uo_dw_captura within w_promedio_peso
integer x = 37
integer y = 256
integer width = 2514
integer height = 520
integer taborder = 0
string dataobject = "dw_promedio_peso"
end type

event borra;int i=0
end event

event carga;//event actualiza()


return retrieve(uo_1.dw_carrera.object.cve_carrera[uo_1.dw_carrera.getrow()])
object.st_1.text=uo_1.dw_carrera.object.carrera[uo_1.dw_carrera.getrow()]+' '
end event

event nuevo;int i=0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type cb_2 from commandbutton within w_promedio_peso
integer x = 2670
integer y = 436
integer width = 261
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Reporte"
end type

event clicked;opensheet(w_promedio_peso_rep,w_principal,4,Original!)
end event

type uo_1 from uo_carrera within w_promedio_peso
integer x = 46
integer y = 36
integer width = 1344
integer height = 204
boolean enabled = true
end type

on uo_1.destroy
call uo_carrera::destroy
end on

