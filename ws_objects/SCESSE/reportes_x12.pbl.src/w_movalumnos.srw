$PBExportHeader$w_movalumnos.srw
forward
global type w_movalumnos from w_ancestral
end type
type dw_1 from uo_dw_reporte within w_movalumnos
end type
type em_usuario from editmask within w_movalumnos
end type
type em_fecha_min from editmask within w_movalumnos
end type
type em_fecha_max from editmask within w_movalumnos
end type
type rb_alumnos from radiobutton within w_movalumnos
end type
type rb_mat_inscritas from radiobutton within w_movalumnos
end type
type gb_1 from groupbox within w_movalumnos
end type
type uo_nombre from uo_nombre_alumno within w_movalumnos
end type
type st_1 from statictext within w_movalumnos
end type
type st_2 from statictext within w_movalumnos
end type
type st_3 from statictext within w_movalumnos
end type
type cbx_todos_usuarios from checkbox within w_movalumnos
end type
end forward

global type w_movalumnos from w_ancestral
integer width = 3634
integer height = 2692
string title = "Bitácora de Movimientos de Alumnos"
string menuname = "m_menu"
long backcolor = 10789024
dw_1 dw_1
em_usuario em_usuario
em_fecha_min em_fecha_min
em_fecha_max em_fecha_max
rb_alumnos rb_alumnos
rb_mat_inscritas rb_mat_inscritas
gb_1 gb_1
uo_nombre uo_nombre
st_1 st_1
st_2 st_2
st_3 st_3
cbx_todos_usuarios cbx_todos_usuarios
end type
global w_movalumnos w_movalumnos

type variables
long il_cuenta = 0
string is_usuario = "todos"
Datawindowchild  dwc_periodo
end variables

event open;call super::open;dw_1.settransobject(gtr_sce)

integer li_cve_coordinador, li_cve_area_coordinacion, li_rtncode, li_res, li_res_uo
datetime ldttm_fecha_hoy
date ldt_fecha_inicial, ldt_fecha_final
string ls_fecha_inicial, ls_fecha_final


//x=1
//y=1
ldttm_fecha_hoy= fecha_servidor(gtr_sce)
ldt_fecha_final = date(ldttm_fecha_hoy)
ldt_fecha_inicial = relativedate(ldt_fecha_final, -1)

ls_fecha_inicial= string(ldt_fecha_inicial)
ls_fecha_final= string(ldt_fecha_final)

em_fecha_min.text =ls_fecha_inicial
em_fecha_max.text =ls_fecha_final




end event

on w_movalumnos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.em_usuario=create em_usuario
this.em_fecha_min=create em_fecha_min
this.em_fecha_max=create em_fecha_max
this.rb_alumnos=create rb_alumnos
this.rb_mat_inscritas=create rb_mat_inscritas
this.gb_1=create gb_1
this.uo_nombre=create uo_nombre
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.cbx_todos_usuarios=create cbx_todos_usuarios
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.em_usuario
this.Control[iCurrent+3]=this.em_fecha_min
this.Control[iCurrent+4]=this.em_fecha_max
this.Control[iCurrent+5]=this.rb_alumnos
this.Control[iCurrent+6]=this.rb_mat_inscritas
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.uo_nombre
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.st_2
this.Control[iCurrent+11]=this.st_3
this.Control[iCurrent+12]=this.cbx_todos_usuarios
end on

on w_movalumnos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.em_usuario)
destroy(this.em_fecha_min)
destroy(this.em_fecha_max)
destroy(this.rb_alumnos)
destroy(this.rb_mat_inscritas)
destroy(this.gb_1)
destroy(this.uo_nombre)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.cbx_todos_usuarios)
end on

event doubleclicked;call super::doubleclicked;int flag
flag = 0

long ll_row, ll_cuenta

ll_row = uo_nombre.dw_nombre_alumno.GetRow()
il_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")

if f_alumno_restringido (ll_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()
		return		
	end if
end if


end event

type p_uia from w_ancestral`p_uia within w_movalumnos
boolean visible = false
boolean enabled = false
end type

type dw_1 from uo_dw_reporte within w_movalumnos
integer x = 37
integer y = 768
integer width = 3534
integer height = 1672
integer taborder = 0
boolean titlebar = true
string title = "Movimientos de Alumno"
string dataobject = "dw_movalumnos"
boolean controlmenu = true
boolean minbox = true
boolean hscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = false
boolean righttoleft = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;long min,max
string usuario
datetime fecha_min, fecha_max
date ldt_fecha_final, ldt_fecha_inicial

ldt_fecha_inicial = date(em_fecha_min.text)
ldt_fecha_final = date(em_fecha_max.text)

ldt_fecha_final = relativedate(ldt_fecha_final, +1)


fecha_min=datetime(ldt_fecha_inicial)
fecha_max=datetime(ldt_fecha_final)


//event primero()
return retrieve(il_cuenta,is_usuario,fecha_min, fecha_max)


end event

type em_usuario from editmask within w_movalumnos
integer x = 2089
integer y = 472
integer width = 453
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "todos"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxx"
string displaydata = "~r"
end type

event modified;is_usuario = em_usuario.text
end event

type em_fecha_min from editmask within w_movalumnos
integer x = 1298
integer y = 472
integer width = 453
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "1/1/90"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

type em_fecha_max from editmask within w_movalumnos
integer x = 1298
integer y = 604
integer width = 453
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
string text = "31/12/99"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = "<"
end type

type rb_alumnos from radiobutton within w_movalumnos
integer x = 87
integer y = 528
integer width = 425
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Ver Alumnos"
boolean checked = true
end type

event clicked;if checked = true then
	dw_1.DataObject = "dw_movalumnos"
	dw_1.SetTransObject(gtr_sce)
//	dw_1.event carga()
end if
end event

type rb_mat_inscritas from radiobutton within w_movalumnos
integer x = 87
integer y = 604
integer width = 663
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Ver Materias Inscritas"
end type

event clicked;if checked = true then
	dw_1.DataObject = "d_movmat_inscritas"
	dw_1.SetTransObject(gtr_sce)
//	dw_1.event carga()
end if


//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_1, dwc_periodo, "periodo")

end event

type gb_1 from groupbox within w_movalumnos
integer x = 37
integer y = 444
integer width = 832
integer height = 312
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Bitácora"
end type

type uo_nombre from uo_nombre_alumno within w_movalumnos
integer y = 12
integer width = 3241
integer height = 424
integer taborder = 10
boolean bringtotop = true
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type st_1 from statictext within w_movalumnos
integer x = 1778
integer y = 488
integer width = 270
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Usuario"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_2 from statictext within w_movalumnos
integer x = 910
integer y = 488
integer width = 361
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Fecha Inicial"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_movalumnos
integer x = 910
integer y = 624
integer width = 361
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Fecha Final"
alignment alignment = right!
boolean focusrectangle = false
end type

type cbx_todos_usuarios from checkbox within w_movalumnos
integer x = 2578
integer y = 480
integer width = 590
integer height = 80
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Todos los Usuarios"
end type

event clicked;if this.checked then
	em_usuario.enabled = false
	is_usuario = "todos"
else
	em_usuario.enabled = true
	is_usuario = em_usuario.text
end if

end event

