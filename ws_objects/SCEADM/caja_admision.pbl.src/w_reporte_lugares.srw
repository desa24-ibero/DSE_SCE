$PBExportHeader$w_reporte_lugares.srw
forward
global type w_reporte_lugares from window
end type
type cb_3 from commandbutton within w_reporte_lugares
end type
type cb_2 from commandbutton within w_reporte_lugares
end type
type uo_1 from uo_ver_per_ani within w_reporte_lugares
end type
type dw_1 from uo_dw_reporte within w_reporte_lugares
end type
end forward

global type w_reporte_lugares from window
integer x = 832
integer y = 360
integer width = 3506
integer height = 1964
boolean titlebar = true
string title = "Reporte de Lugares de Pago"
string menuname = "m_menu"
long backcolor = 30976088
cb_3 cb_3
cb_2 cb_2
uo_1 uo_1
dw_1 dw_1
end type
global w_reporte_lugares w_reporte_lugares

on w_reporte_lugares.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_3=create cb_3
this.cb_2=create cb_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.cb_3,&
this.cb_2,&
this.uo_1,&
this.dw_1}
end on

on w_reporte_lugares.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

if conecta_bd(gtr_scob,gs_scob,"admision","admision")=0 then
	close(this)
end if

dw_1.settransobject(gtr_scob)
end event

event close;desconecta_bd(gtr_scob)
end event

type cb_3 from commandbutton within w_reporte_lugares
integer x = 1714
integer y = 104
integer width = 741
integer height = 68
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inscripción Primer Ingreso"
end type

event clicked;dw_1.event primero()

CHOOSE CASE gi_periodo
	CASE 0
		return dw_1.retrieve('P',gi_anio - integer(gi_anio/100)*100,19)
	CASE 1
		return dw_1.retrieve('V',gi_anio - integer(gi_anio/100)*100,19)
	CASE 2
		return dw_1.retrieve('O',gi_anio - integer(gi_anio/100)*100,19)
END CHOOSE
end event

type cb_2 from commandbutton within w_reporte_lugares
integer x = 1714
integer y = 16
integer width = 741
integer height = 68
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aportación Única"
end type

event clicked;dw_1.event primero()

CHOOSE CASE gi_periodo
	CASE 0
		return dw_1.retrieve('P',gi_anio - integer(gi_anio/100)*100,1)
	CASE 1
		return dw_1.retrieve('V',gi_anio - integer(gi_anio/100)*100,1)
	CASE 2
		return dw_1.retrieve('O',gi_anio - integer(gi_anio/100)*100,1)
END CHOOSE

end event

type uo_1 from uo_ver_per_ani within w_reporte_lugares
integer y = 20
integer width = 1243
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_reporte_lugares
integer y = 192
integer width = 3456
integer height = 1588
integer taborder = 0
string dataobject = "dw_pagos_lugares"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;call super::carga;/**/

return 0
end event

