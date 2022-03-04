$PBExportHeader$uo_lb_carreras_plan_por_coordinacion.sru
forward
global type uo_lb_carreras_plan_por_coordinacion from userobject
end type
type rb_todos from radiobutton within uo_lb_carreras_plan_por_coordinacion
end type
type rb_posgrado from radiobutton within uo_lb_carreras_plan_por_coordinacion
end type
type rb_licenciatura from radiobutton within uo_lb_carreras_plan_por_coordinacion
end type
type lb_carreras_plan_posibles from listbox within uo_lb_carreras_plan_por_coordinacion
end type
type gb_nivel from groupbox within uo_lb_carreras_plan_por_coordinacion
end type
end forward

global type uo_lb_carreras_plan_por_coordinacion from userobject
integer width = 3547
integer height = 496
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event selectionchanged ( integer index )
rb_todos rb_todos
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
lb_carreras_plan_posibles lb_carreras_plan_posibles
gb_nivel gb_nivel
end type
global uo_lb_carreras_plan_por_coordinacion uo_lb_carreras_plan_por_coordinacion

type variables
int ii_cve_carrera[]
int ii_cve_plan[]
end variables

forward prototypes
public function integer inicializa (integer ai_cve_coordinacion)
public function integer carreraplanseleccionada (ref integer ai_cve_carrera, ref integer ai_cve_plan)
public function integer llenalistbox (integer ai_cve_coordinacion, string as_nivel)
end prototypes

public function integer inicializa (integer ai_cve_coordinacion);boolean lb_visible
string ls_nivel
if ai_cve_coordinacion <> 9999 then
	lb_visible = false
	ls_nivel = "T"
else
	lb_visible = true
	if rb_licenciatura.checked = true then
		ls_nivel = "L"
	elseif rb_posgrado.checked = true then
		ls_nivel = "P"
	else
		ls_nivel = "T"
	end if
end if
gb_nivel.visible = lb_visible
rb_licenciatura.visible = lb_visible
rb_posgrado.visible = lb_visible
rb_todos.visible = lb_visible
gb_nivel.enabled = lb_visible
rb_licenciatura.enabled = lb_visible 
rb_posgrado.enabled = lb_visible
rb_todos.enabled = lb_visible
return llenalistbox(ai_cve_coordinacion,ls_nivel)
end function

public function integer carreraplanseleccionada (ref integer ai_cve_carrera, ref integer ai_cve_plan);int li_indice
li_indice = lb_carreras_plan_posibles.SelectedIndex()
if li_indice > 0 then
	ai_cve_carrera = ii_cve_carrera[li_indice]
	ai_cve_plan = ii_cve_plan[li_indice]
	return 1
else
	ai_cve_carrera = 0
	ai_cve_plan = 0
	return -1
end if

end function

public function integer llenalistbox (integer ai_cve_coordinacion, string as_nivel);int li_total, li_i
datastore lds_carreras
lds_carreras = Create DataStore
lds_carreras.DataObject = "d_carreras_plan_coordinaciones"
lds_carreras.SetTransObject(gtr_sce)
li_total = lds_carreras.retrieve(ai_cve_coordinacion,as_nivel)
if li_total > 0 then
	lb_carreras_plan_posibles.reset()
	for li_i = 1 to li_total
		ii_cve_carrera[li_i] = lds_carreras.GetItemNumber(li_i, "carreras_cve_carrera")
		ii_cve_plan[li_i] = lds_carreras.GetItemNumber(li_i, "nombre_plan_cve_plan")
		lb_carreras_plan_posibles.AddItem(lds_carreras.GetItemString(li_i, "carreras_carrera")+"-"+&
					lds_carreras.GetItemString(li_i, "nombre_plan_nombre_plan"))
	next
end if
Destroy lds_carreras
return li_total

end function

on uo_lb_carreras_plan_por_coordinacion.create
this.rb_todos=create rb_todos
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.lb_carreras_plan_posibles=create lb_carreras_plan_posibles
this.gb_nivel=create gb_nivel
this.Control[]={this.rb_todos,&
this.rb_posgrado,&
this.rb_licenciatura,&
this.lb_carreras_plan_posibles,&
this.gb_nivel}
end on

on uo_lb_carreras_plan_por_coordinacion.destroy
destroy(this.rb_todos)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.lb_carreras_plan_posibles)
destroy(this.gb_nivel)
end on

type rb_todos from radiobutton within uo_lb_carreras_plan_por_coordinacion
integer x = 2994
integer y = 328
integer width = 343
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todos"
borderstyle borderstyle = stylelowered!
end type

event clicked;llenalistbox(9999,"T")
end event

type rb_posgrado from radiobutton within uo_lb_carreras_plan_por_coordinacion
integer x = 2994
integer y = 244
integer width = 361
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Posgrado"
borderstyle borderstyle = stylelowered!
end type

event clicked;llenalistbox(9999,"P")
end event

type rb_licenciatura from radiobutton within uo_lb_carreras_plan_por_coordinacion
integer x = 2994
integer y = 152
integer width = 379
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Licenciatura"
boolean checked = true
borderstyle borderstyle = stylelowered!
end type

event clicked;llenalistbox(9999,"L")
end event

type lb_carreras_plan_posibles from listbox within uo_lb_carreras_plan_por_coordinacion
integer x = 14
integer y = 12
integer width = 2853
integer height = 472
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
boolean sorted = false
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;parent.Event SelectionChanged(index)
end event

type gb_nivel from groupbox within uo_lb_carreras_plan_por_coordinacion
integer x = 2953
integer y = 88
integer width = 485
integer height = 332
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Filtrar nivel"
borderstyle borderstyle = stylelowered!
end type

