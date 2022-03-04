$PBExportHeader$w_carreras_x_materia.srw
forward
global type w_carreras_x_materia from w_master_main_rep
end type
type dw_carreras_x_materias from uo_dw_reporte within w_carreras_x_materia
end type
type em_materia from editmask within w_carreras_x_materia
end type
type lb_materias from listbox within w_carreras_x_materia
end type
type ddlb_nivel from dropdownlistbox within w_carreras_x_materia
end type
type dw_nivel from datawindow within w_carreras_x_materia
end type
type gb_2 from groupbox within w_carreras_x_materia
end type
type gb_1 from groupbox within w_carreras_x_materia
end type
end forward

global type w_carreras_x_materia from w_master_main_rep
integer width = 3767
integer height = 2832
string title = "Carreras por Materias"
string menuname = "m_menu"
boolean resizable = true
dw_carreras_x_materias dw_carreras_x_materias
em_materia em_materia
lb_materias lb_materias
ddlb_nivel ddlb_nivel
dw_nivel dw_nivel
gb_2 gb_2
gb_1 gb_1
end type
global w_carreras_x_materia w_carreras_x_materia

event open;call super::open;dw_carreras_x_materias.settransobject(gtr_sce)

dw_nivel.settransobject(gtr_sce)
dw_nivel.retrieve( )
end event

on w_carreras_x_materia.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_carreras_x_materias=create dw_carreras_x_materias
this.em_materia=create em_materia
this.lb_materias=create lb_materias
this.ddlb_nivel=create ddlb_nivel
this.dw_nivel=create dw_nivel
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_carreras_x_materias
this.Control[iCurrent+2]=this.em_materia
this.Control[iCurrent+3]=this.lb_materias
this.Control[iCurrent+4]=this.ddlb_nivel
this.Control[iCurrent+5]=this.dw_nivel
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
end on

on w_carreras_x_materia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_carreras_x_materias)
destroy(this.em_materia)
destroy(this.lb_materias)
destroy(this.ddlb_nivel)
destroy(this.dw_nivel)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type st_sistema from w_master_main_rep`st_sistema within w_carreras_x_materia
end type

type p_ibero from w_master_main_rep`p_ibero within w_carreras_x_materia
end type

type dw_carreras_x_materias from uo_dw_reporte within w_carreras_x_materia
integer x = 18
integer y = 896
integer width = 3543
integer height = 1648
integer taborder = 30
string dataobject = "d_carreras_x_materias"
boolean resizable = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;long ll_cont, ll_totmat
long ll_materias[]
string ls_nivel
event primero()


ll_totmat = lb_materias.TotalItems( )

If ll_totmat = 0 Or IsNull(ll_totmat) Then
	MessageBox("Mensaje del Sistema", "Debe proporcionar al menos una materia", StopSign!)
	return -1
End If	


FOR ll_cont=1 TO lb_materias.TotalItems( )
	ll_materias[ll_cont] = long(lb_materias.Text(ll_cont))
NEXT

//if ddlb_nivel.text="Licenciatura" then
//	Modify("DataWindow.Table.Select = 'SELECT materias.cve_mat,materias.materia,materias.sigla,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerrequisito.cve_carrera,carreras.carrera,nombre_plan.nombre_plan, materias.sigla_anterior, mat_prerrequisito.cve_plan FROM mat_prerrequisito,materias,carreras,coordinaciones,nombre_plan WHERE ( mat_prerrequisito.cve_mat = materias.cve_mat ) and ( carreras.cve_carrera = mat_prerrequisito.cve_carrera ) and ( materias.cve_coordinacion = coordinaciones.cve_coordinacion ) and ( mat_prerrequisito.cve_plan = nombre_plan.cve_plan ) and ( ( materias.cve_mat in ( :materia ) ) )'")
//else
//	Modify("DataWindow.Table.Select = 'SELECT materias.cve_mat,materias.materia,materias.sigla,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerreq_pos.cve_carrera,carreras.carrera,nombre_plan.nombre_plan, materias.sigla_anterior, mat_prerreq_pos.cve_plan FROM mat_prerreq_pos,materias,carreras,coordinaciones,nombre_plan WHERE ( mat_prerreq_pos.cve_mat = materias.cve_mat ) and ( carreras.cve_carrera = mat_prerreq_pos.cve_carrera ) and ( materias.cve_coordinacion = coordinaciones.cve_coordinacion ) and ( mat_prerreq_pos.cve_plan = nombre_plan.cve_plan ) and ( ( materias.cve_mat in ( :materia ) ) )'")
//end if

dw_nivel.accepttext( )
ls_nivel = dw_nivel.getitemstring(dw_nivel.getrow(), 1)

If ls_nivel = "P" Then
	Modify("DataWindow.Table.Select = 'SELECT materias.cve_mat,materias.materia,materias.sigla,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerreq_pos.cve_carrera,carreras.carrera,nombre_plan.nombre_plan, materias.sigla_anterior, mat_prerreq_pos.cve_plan FROM mat_prerreq_pos,materias,carreras,coordinaciones,nombre_plan WHERE ( mat_prerreq_pos.cve_mat = materias.cve_mat ) and ( carreras.cve_carrera = mat_prerreq_pos.cve_carrera ) and ( materias.cve_coordinacion = coordinaciones.cve_coordinacion ) and ( mat_prerreq_pos.cve_plan = nombre_plan.cve_plan ) and ( ( materias.cve_mat in ( :materia ) ) )'")
Else
	Modify("DataWindow.Table.Select = 'SELECT materias.cve_mat,materias.materia,materias.sigla,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerrequisito.cve_carrera,carreras.carrera,nombre_plan.nombre_plan, materias.sigla_anterior, mat_prerrequisito.cve_plan FROM mat_prerrequisito,materias,carreras,coordinaciones,nombre_plan WHERE (carreras.nivel = ~~'" + ls_nivel + "~~') AND ( mat_prerrequisito.cve_mat = materias.cve_mat ) and ( carreras.cve_carrera = mat_prerrequisito.cve_carrera ) and ( materias.cve_coordinacion = coordinaciones.cve_coordinacion ) and ( mat_prerrequisito.cve_plan = nombre_plan.cve_plan ) and ( ( materias.cve_mat in ( :materia ) ) )'")
End If

return retrieve(ll_materias)
end event

type em_materia from editmask within w_carreras_x_materia
integer x = 215
integer y = 576
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
string mask = "#####"
string displaydata = "Ø"
end type

event modified;if text<>"" then
	lb_materias.AddItem(text)
	text=""
end if
end event

type lb_materias from listbox within w_carreras_x_materia
integer x = 695
integer y = 436
integer width = 279
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

type ddlb_nivel from dropdownlistbox within w_carreras_x_materia
boolean visible = false
integer x = 2871
integer y = 396
integer width = 379
integer height = 196
boolean bringtotop = true
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

type dw_nivel from datawindow within w_carreras_x_materia
integer x = 2121
integer y = 576
integer width = 507
integer height = 100
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dddw_nivel_2013"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_carreras_x_materia
integer x = 59
integer y = 384
integer width = 1650
integer height = 484
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Materia"
borderstyle borderstyle = stylebox!
end type

type gb_1 from groupbox within w_carreras_x_materia
integer x = 18
integer y = 312
integer width = 3534
integer height = 584
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

type p_uia from w_ancestral`p_uia within w_carreras_x_materia
boolean visible = false
integer x = 2930
integer y = 344
integer width = 169
integer height = 116
end type

