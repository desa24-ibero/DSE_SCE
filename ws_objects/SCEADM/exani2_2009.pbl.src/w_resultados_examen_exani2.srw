$PBExportHeader$w_resultados_examen_exani2.srw
forward
global type w_resultados_examen_exani2 from w_main
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_resultados_examen_exani2
end type
type uo_1 from uo_ver_per_ani within w_resultados_examen_exani2
end type
type dw_1 from uo_dw_reporte within w_resultados_examen_exani2
end type
end forward

global type w_resultados_examen_exani2 from w_main
integer x = 832
integer y = 364
integer width = 3694
integer height = 1964
string title = "Resultados de Examen"
string menuname = "m_menu"
long backcolor = 67108864
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_resultados_examen_exani2 w_resultados_examen_exani2

type variables

end variables

on w_resultados_examen_exani2.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_tipo_periodo_ing
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_resultados_examen_exani2.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_resultados_examen_exani2
integer x = 2290
integer y = 24
integer height = 144
integer taborder = 10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_resultados_examen_exani2
integer x = 5
integer y = 8
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_resultados_examen_exani2
integer x = 9
integer y = 184
integer width = 3639
integer height = 1552
integer taborder = 0
string dataobject = "dw_resultados_examen_exani2"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_resultados_examen_exani2"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_resultados_examen_exani2_ing"
	this.SetTransObject(gtr_sadm)	
END IF
event primero()
return retrieve(gi_version,gi_periodo,gi_anio)
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

