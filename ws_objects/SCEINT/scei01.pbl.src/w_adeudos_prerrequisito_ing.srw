$PBExportHeader$w_adeudos_prerrequisito_ing.srw
forward
global type w_adeudos_prerrequisito_ing from w_ancestral
end type
type dw_1 from uo_dw_reporte within w_adeudos_prerrequisito_ing
end type
type em_semestre from editmask within w_adeudos_prerrequisito_ing
end type
type st_1 from statictext within w_adeudos_prerrequisito_ing
end type
type st_2 from statictext within w_adeudos_prerrequisito_ing
end type
type sle_adeudos from singlelineedit within w_adeudos_prerrequisito_ing
end type
type rb_inscritos from radiobutton within w_adeudos_prerrequisito_ing
end type
type rb_todos from radiobutton within w_adeudos_prerrequisito_ing
end type
type gb_1 from groupbox within w_adeudos_prerrequisito_ing
end type
end forward

global type w_adeudos_prerrequisito_ing from w_ancestral
integer width = 4562
integer height = 3492
string title = "Reporte de Adeudos en Prerrequisito de Inglés"
string menuname = "m_menu"
dw_1 dw_1
em_semestre em_semestre
st_1 st_1
st_2 st_2
sle_adeudos sle_adeudos
rb_inscritos rb_inscritos
rb_todos rb_todos
gb_1 gb_1
end type
global w_adeudos_prerrequisito_ing w_adeudos_prerrequisito_ing

on w_adeudos_prerrequisito_ing.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.em_semestre=create em_semestre
this.st_1=create st_1
this.st_2=create st_2
this.sle_adeudos=create sle_adeudos
this.rb_inscritos=create rb_inscritos
this.rb_todos=create rb_todos
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.em_semestre
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.sle_adeudos
this.Control[iCurrent+6]=this.rb_inscritos
this.Control[iCurrent+7]=this.rb_todos
this.Control[iCurrent+8]=this.gb_1
end on

on w_adeudos_prerrequisito_ing.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.em_semestre)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.sle_adeudos)
destroy(this.rb_inscritos)
destroy(this.rb_todos)
destroy(this.gb_1)
end on

event open;call super::open;String ls_desc_periodo

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios 

dw_1.SetTransObject(gtr_sce)

ls_desc_periodo = luo_periodo_tipo_servicios.f_obten_desc_periodo_msg(gs_tipo_periodo)

IF luo_periodo_tipo_servicios.i_error = -1 THEN 
	MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
	RETURN luo_periodo_tipo_servicios.i_error
END IF	

st_1.text = ls_desc_periodo  + " Inferior:"

//if gs_tipo_periodo="T" then
//	st_1.text="Trimestre Inferior:"
//end if
end event

type p_uia from w_ancestral`p_uia within w_adeudos_prerrequisito_ing
end type

type dw_1 from uo_dw_reporte within w_adeudos_prerrequisito_ing
integer x = 78
integer y = 428
integer width = 4379
integer height = 2824
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_ad_insc_prerrequisito_ing"
boolean hscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event carga;long ll_semestre, ll_rows
string ls_semestre, ls_desc_periodo

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios 

ls_semestre = em_semestre.text

if not isnumber(ls_semestre) then
	
	ls_desc_periodo = luo_periodo_tipo_servicios.f_obten_desc_periodo_msg(gs_tipo_periodo)
	
	IF luo_periodo_tipo_servicios.i_error = -1 THEN 
		MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
		RETURN luo_periodo_tipo_servicios.i_error
	END IF	
	
	MessageBox(ls_desc_periodo + " Inválido", "Favor de escribir un número de " + LOWER(ls_desc_periodo), StopSign!)

//	if gs_tipo_periodo="S" then
//		MessageBox("Semestre Inválido", "Favor de escribir un número de semestre", StopSign!)
//	else
//		MessageBox("Trimestre Inválido", "Favor de escribir un número de trimestre", StopSign!)
//	end if
	return 0
else
	ll_semestre = long(ls_semestre)
	ll_rows= dw_1.Retrieve(ll_semestre)
	if ll_rows<>-1 then
		sle_adeudos.text = string(ll_rows)
		return ll_rows
	else
		MessageBox("Error al ejecutar la consulta", "Favor de intentar nuevamente", StopSign!)
		return -1
	end if
end if


end event

type em_semestre from editmask within w_adeudos_prerrequisito_ing
integer x = 1111
integer y = 140
integer width = 155
integer height = 96
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "3"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "##"
end type

type st_1 from statictext within w_adeudos_prerrequisito_ing
integer x = 521
integer y = 156
integer width = 530
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Semestre Inferior:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_adeudos_prerrequisito_ing
boolean visible = false
integer x = 1326
integer y = 160
integer width = 489
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Total Adeudos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_adeudos from singlelineedit within w_adeudos_prerrequisito_ing
boolean visible = false
integer x = 1874
integer y = 140
integer width = 247
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type rb_inscritos from radiobutton within w_adeudos_prerrequisito_ing
integer x = 2336
integer y = 128
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Inscritos"
boolean checked = true
boolean lefttext = true
end type

event clicked;dw_1.dataobject = "d_ad_insc_prerrequisito_ing"
dw_1.SetTransObject(gtr_sce)
end event

type rb_todos from radiobutton within w_adeudos_prerrequisito_ing
integer x = 2336
integer y = 220
integer width = 411
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Todos"
boolean lefttext = true
end type

event clicked;dw_1.dataobject = "d_adeudos_prerrequisito_ing"
dw_1.SetTransObject(gtr_sce)
end event

type gb_1 from groupbox within w_adeudos_prerrequisito_ing
integer x = 2272
integer y = 60
integer width = 544
integer height = 264
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Alumnos"
end type

