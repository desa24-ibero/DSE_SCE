$PBExportHeader$w_materias_x_carreras.srw
forward
global type w_materias_x_carreras from w_master_main_rep
end type
type gb_3 from groupbox within w_materias_x_carreras
end type
type gb_2 from groupbox within w_materias_x_carreras
end type
type dw_materias_x_carreras from uo_dw_reporte within w_materias_x_carreras
end type
type em_carrera from editmask within w_materias_x_carreras
end type
type lb_carreras from listbox within w_materias_x_carreras
end type
type lb_planes from listbox within w_materias_x_carreras
end type
type em_plan from editmask within w_materias_x_carreras
end type
type ddlb_nivel from dropdownlistbox within w_materias_x_carreras
end type
type dw_nivel from datawindow within w_materias_x_carreras
end type
type gb_4 from groupbox within w_materias_x_carreras
end type
type gb_1 from groupbox within w_materias_x_carreras
end type
end forward

global type w_materias_x_carreras from w_master_main_rep
integer width = 4809
integer height = 2912
string title = "Materias por Carrera"
string menuname = "m_menu"
boolean resizable = true
gb_3 gb_3
gb_2 gb_2
dw_materias_x_carreras dw_materias_x_carreras
em_carrera em_carrera
lb_carreras lb_carreras
lb_planes lb_planes
em_plan em_plan
ddlb_nivel ddlb_nivel
dw_nivel dw_nivel
gb_4 gb_4
gb_1 gb_1
end type
global w_materias_x_carreras w_materias_x_carreras

event open;call super::open;dw_materias_x_carreras.settransobject(gtr_sce)
dw_nivel.settransobject(gtr_sce)
dw_nivel.retrieve( )
end event

on w_materias_x_carreras.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.gb_3=create gb_3
this.gb_2=create gb_2
this.dw_materias_x_carreras=create dw_materias_x_carreras
this.em_carrera=create em_carrera
this.lb_carreras=create lb_carreras
this.lb_planes=create lb_planes
this.em_plan=create em_plan
this.ddlb_nivel=create ddlb_nivel
this.dw_nivel=create dw_nivel
this.gb_4=create gb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.dw_materias_x_carreras
this.Control[iCurrent+4]=this.em_carrera
this.Control[iCurrent+5]=this.lb_carreras
this.Control[iCurrent+6]=this.lb_planes
this.Control[iCurrent+7]=this.em_plan
this.Control[iCurrent+8]=this.ddlb_nivel
this.Control[iCurrent+9]=this.dw_nivel
this.Control[iCurrent+10]=this.gb_4
this.Control[iCurrent+11]=this.gb_1
end on

on w_materias_x_carreras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.dw_materias_x_carreras)
destroy(this.em_carrera)
destroy(this.lb_carreras)
destroy(this.lb_planes)
destroy(this.em_plan)
destroy(this.ddlb_nivel)
destroy(this.dw_nivel)
destroy(this.gb_4)
destroy(this.gb_1)
end on

type st_sistema from w_master_main_rep`st_sistema within w_materias_x_carreras
end type

type p_ibero from w_master_main_rep`p_ibero within w_materias_x_carreras
end type

type gb_3 from groupbox within w_materias_x_carreras
integer x = 1989
integer y = 420
integer width = 613
integer height = 512
integer taborder = 10
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

type gb_2 from groupbox within w_materias_x_carreras
integer x = 69
integer y = 420
integer width = 933
integer height = 512
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Carrera"
borderstyle borderstyle = stylebox!
end type

type dw_materias_x_carreras from uo_dw_reporte within w_materias_x_carreras
integer x = 18
integer y = 964
integer width = 4613
integer height = 1648
integer taborder = 0
string dataobject = "d_materias_x_carreras"
boolean resizable = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;long ll_cont, ll_totcarr, ll_totplan
integer li_carreras[],li_planes[]
string ls_nivel
event primero()

FOR ll_cont=1 TO lb_carreras.TotalItems( )
	li_carreras[ll_cont] = integer(lb_carreras.Text(ll_cont))
NEXT

FOR ll_cont=1 TO lb_planes.TotalItems( )
	li_planes[ll_cont] = integer(lb_planes.Text(ll_cont))
NEXT


ll_totcarr = lb_carreras.TotalItems( )

If ll_totcarr = 0 Or IsNull(ll_totcarr) Then
	MessageBox("Mensaje del Sistema", "Debe proporcionar al menos una carrera", StopSign!)
	return -1
End If	

ll_totplan = lb_planes.TotalItems( )

If ll_totplan = 0 Or IsNull(ll_totplan) Then
	MessageBox("Mensaje del Sistema", "Debe proporcionar al menos un plan", StopSign!)
	return -1
End If	


//if ddlb_nivel.text="Licenciatura" then
//	Modify("DataWindow.Table.Select = 'SELECT mat_prerrequisito.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerrequisito.semestre_ideal FROM mat_prerrequisito,materias,nombre_plan,coordinaciones,carreras WHERE ( mat_prerrequisito.cve_mat = materias.cve_mat ) and ( mat_prerrequisito.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerrequisito.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :carreras ) OR mat_prerrequisito.cve_carrera in ( :carreras ) ) AND ( mat_prerrequisito.cve_plan in ( :planes ) ) )'")
//else
//	Modify("DataWindow.Table.Select = 'SELECT mat_prerreq_pos.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerreq_pos.semestre_ideal FROM mat_prerreq_pos,materias,nombre_plan,coordinaciones,carreras WHERE ( mat_prerreq_pos.cve_mat = materias.cve_mat ) and ( mat_prerreq_pos.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerreq_pos.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :carreras ) OR mat_prerreq_pos.cve_carrera in ( :carreras ) ) AND ( mat_prerreq_pos.cve_plan in ( :planes ) ) )'")
//end if

dw_nivel.accepttext( )
ls_nivel = dw_nivel.getitemstring(dw_nivel.getrow(), 1)

if ls_nivel = "P" then
	Modify("DataWindow.Table.Select = 'SELECT mat_prerreq_pos.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerreq_pos.semestre_ideal FROM mat_prerreq_pos,materias,nombre_plan,coordinaciones,carreras WHERE ( mat_prerreq_pos.cve_mat = materias.cve_mat ) and ( mat_prerreq_pos.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerreq_pos.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :carreras ) OR mat_prerreq_pos.cve_carrera in ( :carreras ) ) AND ( mat_prerreq_pos.cve_plan in ( :planes ) ) )'")
else
	Modify("DataWindow.Table.Select = 'SELECT mat_prerrequisito.cve_carrera,carreras.carrera,nombre_plan.nombre_plan,materias.cve_mat,materias.sigla,materias.materia,materias.cve_coordinacion,coordinaciones.coordinacion,mat_prerrequisito.semestre_ideal FROM mat_prerrequisito,materias,nombre_plan,coordinaciones,carreras WHERE (carreras.nivel = ~~'" + ls_nivel + "~~') AND ( mat_prerrequisito.cve_mat = materias.cve_mat ) and ( mat_prerrequisito.cve_plan = nombre_plan.cve_plan ) and ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and ( mat_prerrequisito.cve_carrera = carreras.cve_carrera ) and ( ( 9999 in ( :carreras ) OR mat_prerrequisito.cve_carrera in ( :carreras ) ) AND ( mat_prerrequisito.cve_plan in ( :planes ) ) )'") 
end if

return retrieve(li_carreras,li_planes)
end event

type em_carrera from editmask within w_materias_x_carreras
integer x = 613
integer y = 652
integer width = 247
integer height = 100
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string mask = "####"
string displaydata = "Ø"
end type

event modified;if text<>"" then
	lb_carreras.AddItem(text)
	text=""
end if
end event

type lb_carreras from listbox within w_materias_x_carreras
integer x = 155
integer y = 492
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

type lb_planes from listbox within w_materias_x_carreras
event doubleclicked pbm_lbndblclk
integer x = 1189
integer y = 492
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

type em_plan from editmask within w_materias_x_carreras
event modified pbm_enmodified
integer x = 1623
integer y = 652
integer width = 247
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "##"
string displaydata = "P"
end type

event modified;if text<>"" then
	lb_planes.AddItem(text)
	text=""
end if
end event

type ddlb_nivel from dropdownlistbox within w_materias_x_carreras
boolean visible = false
integer x = 2990
integer y = 724
integer width = 197
integer height = 148
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

type dw_nivel from datawindow within w_materias_x_carreras
integer x = 2039
integer y = 652
integer width = 507
integer height = 100
integer taborder = 30
boolean bringtotop = true
string title = "none"
string dataobject = "dddw_nivel_2013"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_4 from groupbox within w_materias_x_carreras
integer x = 1029
integer y = 420
integer width = 933
integer height = 512
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Plan"
borderstyle borderstyle = stylebox!
end type

type gb_1 from groupbox within w_materias_x_carreras
integer x = 27
integer y = 344
integer width = 4599
integer height = 624
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda"
borderstyle borderstyle = stylebox!
end type

type p_uia from w_ancestral`p_uia within w_materias_x_carreras
boolean visible = false
integer x = 3191
integer y = 336
integer width = 155
integer height = 116
end type

