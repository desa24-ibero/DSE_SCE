$PBExportHeader$w_materias_x_coordinacion.srw
forward
global type w_materias_x_coordinacion from w_master_main_rep
end type
type gb_2 from groupbox within w_materias_x_coordinacion
end type
type dw_materias_x_coordinacion from uo_dw_reporte within w_materias_x_coordinacion
end type
type em_coordinacion from editmask within w_materias_x_coordinacion
end type
type lb_coordinaciones from listbox within w_materias_x_coordinacion
end type
type dw_nivel from datawindow within w_materias_x_coordinacion
end type
type ddlb_nivel from dropdownlistbox within w_materias_x_coordinacion
end type
type gb_3 from groupbox within w_materias_x_coordinacion
end type
type gb_1 from groupbox within w_materias_x_coordinacion
end type
end forward

global type w_materias_x_coordinacion from w_master_main_rep
integer width = 4759
integer height = 2736
string title = "Materias por Coordinación"
string menuname = "m_menu"
boolean resizable = true
gb_2 gb_2
dw_materias_x_coordinacion dw_materias_x_coordinacion
em_coordinacion em_coordinacion
lb_coordinaciones lb_coordinaciones
dw_nivel dw_nivel
ddlb_nivel ddlb_nivel
gb_3 gb_3
gb_1 gb_1
end type
global w_materias_x_coordinacion w_materias_x_coordinacion

event open;call super::open;dw_materias_x_coordinacion.settransobject(gtr_sce)

dw_nivel.settransobject(gtr_sce)

dw_nivel.retrieve( )
end event

on w_materias_x_coordinacion.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.gb_2=create gb_2
this.dw_materias_x_coordinacion=create dw_materias_x_coordinacion
this.em_coordinacion=create em_coordinacion
this.lb_coordinaciones=create lb_coordinaciones
this.dw_nivel=create dw_nivel
this.ddlb_nivel=create ddlb_nivel
this.gb_3=create gb_3
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.dw_materias_x_coordinacion
this.Control[iCurrent+3]=this.em_coordinacion
this.Control[iCurrent+4]=this.lb_coordinaciones
this.Control[iCurrent+5]=this.dw_nivel
this.Control[iCurrent+6]=this.ddlb_nivel
this.Control[iCurrent+7]=this.gb_3
this.Control[iCurrent+8]=this.gb_1
end on

on w_materias_x_coordinacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_2)
destroy(this.dw_materias_x_coordinacion)
destroy(this.em_coordinacion)
destroy(this.lb_coordinaciones)
destroy(this.dw_nivel)
destroy(this.ddlb_nivel)
destroy(this.gb_3)
destroy(this.gb_1)
end on

type st_sistema from w_master_main_rep`st_sistema within w_materias_x_coordinacion
end type

type p_ibero from w_master_main_rep`p_ibero within w_materias_x_coordinacion
end type

type gb_2 from groupbox within w_materias_x_coordinacion
integer x = 1225
integer y = 428
integer width = 878
integer height = 496
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Nivel"
borderstyle borderstyle = stylebox!
end type

type dw_materias_x_coordinacion from uo_dw_reporte within w_materias_x_coordinacion
integer x = 18
integer y = 960
integer width = 4526
integer height = 1476
integer taborder = 40
string dataobject = "d_materias_x_coordinacion"
boolean hscrollbar = true
boolean resizable = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;long ll_cont, ll_totcoord
integer li_coordinaciones[]
string ls_nivel
event primero()

ll_totcoord = lb_coordinaciones.TotalItems( )

If ll_totcoord = 0 Or IsNull(ll_totcoord) Then
	MessageBox("Mensaje del Sistema", "Debe proporcionar al menos una coordinación", StopSign!)
	return -1
End If	

FOR ll_cont=1 TO lb_coordinaciones.TotalItems( )
	li_coordinaciones[ll_cont] = integer(lb_coordinaciones.Text(ll_cont))
NEXT

//if ddlb_nivel.text="Licenciatura" then
//	Modify("DataWindow.Table.Select = 'SELECT mat_prerrequisito.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion FROM mat_prerrequisito,materias,nombre_plan,coordinaciones,carreras WHERE ( mat_prerrequisito.cve_mat = materias.cve_mat ) and ( mat_prerrequisito.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerrequisito.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :coordinaciones ) OR materias.cve_coordinacion in ( :coordinaciones ) ) )'")
//else
//	Modify("DataWindow.Table.Select = 'SELECT mat_prerreq_pos.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion FROM mat_prerreq_pos,materias,nombre_plan,coordinaciones,carreras WHERE ( mat_prerreq_pos.cve_mat = materias.cve_mat ) and ( mat_prerreq_pos.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerreq_pos.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :coordinaciones ) OR  materias.cve_coordinacion in ( :coordinaciones ) ) )'")
//end if

dw_nivel.accepttext( )
ls_nivel = dw_nivel.getitemstring(dw_nivel.getrow(), 1)

if ls_nivel = "P" then
	Modify("DataWindow.Table.Select = 'SELECT mat_prerreq_pos.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion FROM mat_prerreq_pos,materias,nombre_plan,coordinaciones,carreras WHERE ( mat_prerreq_pos.cve_mat = materias.cve_mat ) and ( mat_prerreq_pos.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerreq_pos.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :coordinaciones ) OR  materias.cve_coordinacion in ( :coordinaciones ) ) )'")
else
	Modify("DataWindow.Table.Select = 'SELECT mat_prerrequisito.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion FROM mat_prerrequisito,materias,nombre_plan,coordinaciones,carreras WHERE (carreras.nivel = ~~'" + ls_nivel + "~~') AND ( mat_prerrequisito.cve_mat = materias.cve_mat ) and ( mat_prerrequisito.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerrequisito.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :coordinaciones ) OR materias.cve_coordinacion in ( :coordinaciones ) ) )'")	
end if

return retrieve(li_coordinaciones)
end event

type em_coordinacion from editmask within w_materias_x_coordinacion
integer x = 183
integer y = 608
integer width = 247
integer height = 104
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string mask = "####"
end type

event modified;if text<>"" then
	lb_coordinaciones.AddItem(text)
	text=""
end if
end event

type lb_coordinaciones from listbox within w_materias_x_coordinacion
integer x = 736
integer y = 484
integer width = 329
integer height = 412
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
end type

event doubleclicked;DeleteItem(index)
end event

type dw_nivel from datawindow within w_materias_x_coordinacion
integer x = 1390
integer y = 608
integer width = 507
integer height = 100
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dddw_nivel_2013"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type ddlb_nivel from dropdownlistbox within w_materias_x_coordinacion
boolean visible = false
integer x = 2944
integer y = 496
integer width = 581
integer height = 232
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Licenciatura"
boolean vscrollbar = true
string item[] = {"Licenciatura","Posgrado"}
end type

type gb_3 from groupbox within w_materias_x_coordinacion
integer x = 55
integer y = 428
integer width = 1134
integer height = 496
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Coordinación"
borderstyle borderstyle = stylebox!
end type

type gb_1 from groupbox within w_materias_x_coordinacion
integer x = 18
integer y = 332
integer width = 4526
integer height = 624
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda"
borderstyle borderstyle = stylebox!
end type

type p_uia from w_ancestral`p_uia within w_materias_x_coordinacion
boolean visible = false
integer x = 2862
integer y = 412
integer width = 187
integer height = 124
end type

