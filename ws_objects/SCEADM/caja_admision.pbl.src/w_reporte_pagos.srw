$PBExportHeader$w_reporte_pagos.srw
$PBExportComments$Aquí se puede elegir el tipo de pago del cual se quiere el reporte.
forward
global type w_reporte_pagos from window
end type
type em_pago_examen from editmask within w_reporte_pagos
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_reporte_pagos
end type
type cbx_2 from checkbox within w_reporte_pagos
end type
type cbx_1 from checkbox within w_reporte_pagos
end type
type cb_3 from commandbutton within w_reporte_pagos
end type
type cb_2 from commandbutton within w_reporte_pagos
end type
type uo_1 from uo_ver_per_ani within w_reporte_pagos
end type
type dw_1 from uo_dw_reporte within w_reporte_pagos
end type
end forward

global type w_reporte_pagos from window
integer x = 832
integer y = 364
integer width = 3817
integer height = 1964
boolean titlebar = true
string title = "Reporte de Pagos Hechos"
string menuname = "m_menu"
long backcolor = 30976088
em_pago_examen em_pago_examen
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_2 cbx_2
cbx_1 cbx_1
cb_3 cb_3
cb_2 cb_2
uo_1 uo_1
dw_1 dw_1
end type
global w_reporte_pagos w_reporte_pagos

on w_reporte_pagos.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.em_pago_examen=create em_pago_examen
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.cb_3=create cb_3
this.cb_2=create cb_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.em_pago_examen,&
this.uo_tipo_periodo_ing,&
this.cbx_2,&
this.cbx_1,&
this.cb_3,&
this.cb_2,&
this.uo_1,&
this.dw_1}
end on

on w_reporte_pagos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_pago_examen)
destroy(this.uo_tipo_periodo_ing)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type em_pago_examen from editmask within w_reporte_pagos
integer x = 3264
integer y = 12
integer width = 498
integer height = 84
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#"
boolean spin = true
string displaydata = "NO PAGADO~t0/PAGADO~t1/CANCELADO~t2/DEVUELTO~t3/"
double increment = 1
string minmax = "0~~3"
boolean usecodetable = true
end type

type uo_tipo_periodo_ing from uo_tipo_periodo within w_reporte_pagos
integer x = 2290
integer y = 68
integer height = 136
integer taborder = 20
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_2 from checkbox within w_reporte_pagos
integer x = 3264
integer y = 128
integer width = 265
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Carrera"
boolean lefttext = true
end type

type cbx_1 from checkbox within w_reporte_pagos
integer x = 2619
integer y = 128
integer width = 270
integer height = 76
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Pagado"
boolean lefttext = true
end type

type cb_3 from commandbutton within w_reporte_pagos
integer x = 2953
integer y = 128
integer width = 293
integer height = 72
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inscripción"
end type

event clicked;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_reporte_pagos"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_reporte_pagos_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
dw_1.getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

dw_1.event primero()
if cbx_1.checked then
	dw_1.retrieve(gi_version,gi_periodo,gi_anio,1,1)
	dw_1.object.st_1.text=tit1+' Inscripción Pagada'
else
	dw_1.retrieve(gi_version,gi_periodo,gi_anio,0,1)
	dw_1.object.st_1.text=tit1+' Inscripción No Pagada'
end if
end event

type cb_2 from commandbutton within w_reporte_pagos
integer x = 2953
integer y = 16
integer width = 293
integer height = 72
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Examen"
end type

event clicked;string ls_pago_examen
integer li_pago_examen

ls_pago_examen = em_pago_examen.text

CHOOSE CASE ls_pago_examen
	CASE "NO PAGADO"
		li_pago_examen = 0
	CASE "PAGADO"
		li_pago_examen = 1
	CASE "CANCELADO"
		li_pago_examen = 2
	CASE "DEVUELTO"
		li_pago_examen = 3
	CASE ELSE
		li_pago_examen = 0
END CHOOSE



IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_reporte_pagos"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_reporte_pagos_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF

DataWindowChild carr
dw_1.getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

dw_1.event primero()

dw_1.retrieve(gi_version,gi_periodo,gi_anio,li_pago_examen,0)
dw_1.object.st_1.text=tit1+ls_pago_examen

//if cbx_1.checked then
//	dw_1.retrieve(gi_version,gi_periodo,gi_anio,1,0)
//	dw_1.object.st_1.text=tit1+' Examen Pagado'
//else
//	dw_1.retrieve(gi_version,gi_periodo,gi_anio,0,0)
//	dw_1.object.st_1.text=tit1+' Examen No Pagado'
//end if
end event

type uo_1 from uo_ver_per_ani within w_reporte_pagos
integer x = 5
integer y = 52
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_reporte_pagos
integer y = 228
integer width = 3717
integer height = 1552
integer taborder = 0
string dataobject = "dw_reporte_pagos"
boolean hscrollbar = true
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;/**/

return 0
end event

