$PBExportHeader$w_promedio_peso_2.srw
$PBExportComments$Ventana para modificar pesos de áreas y secciones
forward
global type w_promedio_peso_2 from window
end type
type dw_1 from uo_dw_captura within w_promedio_peso_2
end type
end forward

global type w_promedio_peso_2 from window
integer x = 832
integer y = 360
integer width = 2985
integer height = 2372
boolean titlebar = true
string title = "Peso de Promedio por Carrera"
string menuname = "m_menu"
boolean resizable = true
long backcolor = 30976088
dw_1 dw_1
end type
global w_promedio_peso_2 w_promedio_peso_2

on w_promedio_peso_2.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on w_promedio_peso_2.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_1.retrieve()
end event

event close;dw_1.event actualiza()
end event

type dw_1 from uo_dw_captura within w_promedio_peso_2
integer x = 55
integer y = 52
integer width = 2619
integer height = 2060
integer taborder = 0
string dataobject = "dw_promedio_peso_2"
borderstyle borderstyle = styleraised!
end type

event borra;int i=0
end event

event carga;//event actualiza()
return dw_1.retrieve()

end event

event nuevo;int i=0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

