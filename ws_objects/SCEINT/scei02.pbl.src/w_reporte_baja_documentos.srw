$PBExportHeader$w_reporte_baja_documentos.srw
forward
global type w_reporte_baja_documentos from w_ancestral
end type
type dw_1 from uo_dw_reporte within w_reporte_baja_documentos
end type
type st_2 from statictext within w_reporte_baja_documentos
end type
type sle_adeudos from singlelineedit within w_reporte_baja_documentos
end type
type rb_inscritos from radiobutton within w_reporte_baja_documentos
end type
type rb_todos from radiobutton within w_reporte_baja_documentos
end type
type rb_licenciatura from radiobutton within w_reporte_baja_documentos
end type
type rb_especialidad from radiobutton within w_reporte_baja_documentos
end type
type rb_maestria from radiobutton within w_reporte_baja_documentos
end type
type rb_doctorado from radiobutton within w_reporte_baja_documentos
end type
type rb_tsu from radiobutton within w_reporte_baja_documentos
end type
type dw_grado from datawindow within w_reporte_baja_documentos
end type
type gb_1 from groupbox within w_reporte_baja_documentos
end type
type gb_2 from groupbox within w_reporte_baja_documentos
end type
end forward

global type w_reporte_baja_documentos from w_ancestral
integer width = 3593
integer height = 2052
string title = "Reporte de Bajas por Adeudo de Documentos"
string menuname = "m_menu"
dw_1 dw_1
st_2 st_2
sle_adeudos sle_adeudos
rb_inscritos rb_inscritos
rb_todos rb_todos
rb_licenciatura rb_licenciatura
rb_especialidad rb_especialidad
rb_maestria rb_maestria
rb_doctorado rb_doctorado
rb_tsu rb_tsu
dw_grado dw_grado
gb_1 gb_1
gb_2 gb_2
end type
global w_reporte_baja_documentos w_reporte_baja_documentos

type variables
string is_nivel = "L"
string is_grado = ""
string is_grado2 = ""

end variables

on w_reporte_baja_documentos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.st_2=create st_2
this.sle_adeudos=create sle_adeudos
this.rb_inscritos=create rb_inscritos
this.rb_todos=create rb_todos
this.rb_licenciatura=create rb_licenciatura
this.rb_especialidad=create rb_especialidad
this.rb_maestria=create rb_maestria
this.rb_doctorado=create rb_doctorado
this.rb_tsu=create rb_tsu
this.dw_grado=create dw_grado
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.sle_adeudos
this.Control[iCurrent+4]=this.rb_inscritos
this.Control[iCurrent+5]=this.rb_todos
this.Control[iCurrent+6]=this.rb_licenciatura
this.Control[iCurrent+7]=this.rb_especialidad
this.Control[iCurrent+8]=this.rb_maestria
this.Control[iCurrent+9]=this.rb_doctorado
this.Control[iCurrent+10]=this.rb_tsu
this.Control[iCurrent+11]=this.dw_grado
this.Control[iCurrent+12]=this.gb_1
this.Control[iCurrent+13]=this.gb_2
end on

on w_reporte_baja_documentos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.sle_adeudos)
destroy(this.rb_inscritos)
destroy(this.rb_todos)
destroy(this.rb_licenciatura)
destroy(this.rb_especialidad)
destroy(this.rb_maestria)
destroy(this.rb_doctorado)
destroy(this.rb_tsu)
destroy(this.dw_grado)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_1.SetTransObject(gtr_sce)

dw_grado.INSERTROW(0)
end event

type p_uia from w_ancestral`p_uia within w_reporte_baja_documentos
end type

type dw_1 from uo_dw_reporte within w_reporte_baja_documentos
integer x = 78
integer y = 536
integer width = 3383
integer height = 1288
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_baja_documentos_insc"
boolean hscrollbar = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event type integer carga();long ll_rows
ll_rows = this.Retrieve(is_nivel,is_grado,is_grado2)
return ll_rows
end event

type st_2 from statictext within w_reporte_baja_documentos
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

type sle_adeudos from singlelineedit within w_reporte_baja_documentos
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

type rb_inscritos from radiobutton within w_reporte_baja_documentos
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

event clicked;dw_1.dataobject = "d_baja_documentos_insc"
dw_1.SetTransObject(gtr_sce)
end event

type rb_todos from radiobutton within w_reporte_baja_documentos
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

event clicked;dw_1.dataobject = "d_baja_documentos"
dw_1.SetTransObject(gtr_sce)
end event

type rb_licenciatura from radiobutton within w_reporte_baja_documentos
integer x = 640
integer y = 104
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Licenciatura"
boolean checked = true
boolean lefttext = true
end type

event clicked;is_nivel = "L"
//is_grado = ""
is_grado = "L"

end event

type rb_especialidad from radiobutton within w_reporte_baja_documentos
integer x = 640
integer y = 176
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Especialidad"
boolean lefttext = true
end type

event clicked;is_nivel = "P"
//is_grado  = "ESP.%"
is_grado = "E"
is_grado2 = "ESPEC%"
end event

type rb_maestria from radiobutton within w_reporte_baja_documentos
integer x = 640
integer y = 252
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Maestría"
boolean lefttext = true
end type

event clicked;is_nivel = "P"
//is_grado  = "MAESTR%"
is_grado = "M"
is_grado2 = "MTRIA%"
end event

type rb_doctorado from radiobutton within w_reporte_baja_documentos
integer x = 640
integer y = 328
integer width = 430
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Doctorado"
boolean lefttext = true
end type

event clicked;is_nivel = "P"
//is_grado  = "DOC.%"
is_grado = "D"
is_grado2 = "DOC%"
end event

type rb_tsu from radiobutton within w_reporte_baja_documentos
integer x = 640
integer y = 396
integer width = 430
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "TSU"
boolean lefttext = true
end type

event clicked;is_grado = ""
end event

type dw_grado from datawindow within w_reporte_baja_documentos
integer x = 1230
integer y = 136
integer width = 846
integer height = 104
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dw_lista_grado_seleccion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_reporte_baja_documentos
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

type gb_2 from groupbox within w_reporte_baja_documentos
integer x = 603
integer y = 32
integer width = 521
integer height = 464
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Grado"
end type

