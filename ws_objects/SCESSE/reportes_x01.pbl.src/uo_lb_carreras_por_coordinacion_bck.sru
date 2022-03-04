﻿$PBExportHeader$uo_lb_carreras_por_coordinacion_bck.sru
forward
global type uo_lb_carreras_por_coordinacion_bck from userobject
end type
type uo_nivel from uo_nivel_rbutton within uo_lb_carreras_por_coordinacion_bck
end type
type rb_carreras_seleccionadas from radiobutton within uo_lb_carreras_por_coordinacion_bck
end type
type rb_todo_posgrado from radiobutton within uo_lb_carreras_por_coordinacion_bck
end type
type rb_todo_licenciatura from radiobutton within uo_lb_carreras_por_coordinacion_bck
end type
type rb_todas_carreras from radiobutton within uo_lb_carreras_por_coordinacion_bck
end type
type cb_eliminar_todas from commandbutton within uo_lb_carreras_por_coordinacion_bck
end type
type cb_agregar_todas from commandbutton within uo_lb_carreras_por_coordinacion_bck
end type
type cb_eliminar_seleccionada from commandbutton within uo_lb_carreras_por_coordinacion_bck
end type
type cb_agregar_seleccionada from commandbutton within uo_lb_carreras_por_coordinacion_bck
end type
type lb_carreras_seleccionadas from listbox within uo_lb_carreras_por_coordinacion_bck
end type
type lb_carreras_posibles from listbox within uo_lb_carreras_por_coordinacion_bck
end type
type gb_seleccion from groupbox within uo_lb_carreras_por_coordinacion_bck
end type
end forward

global type uo_lb_carreras_por_coordinacion_bck from userobject
integer width = 3401
integer height = 516
long backcolor = 12632256
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
uo_nivel uo_nivel
rb_carreras_seleccionadas rb_carreras_seleccionadas
rb_todo_posgrado rb_todo_posgrado
rb_todo_licenciatura rb_todo_licenciatura
rb_todas_carreras rb_todas_carreras
cb_eliminar_todas cb_eliminar_todas
cb_agregar_todas cb_agregar_todas
cb_eliminar_seleccionada cb_eliminar_seleccionada
cb_agregar_seleccionada cb_agregar_seleccionada
lb_carreras_seleccionadas lb_carreras_seleccionadas
lb_carreras_posibles lb_carreras_posibles
gb_seleccion gb_seleccion
end type
global uo_lb_carreras_por_coordinacion_bck uo_lb_carreras_por_coordinacion_bck

type variables
private int ii_total_disponibles, ii_total_seleccionadas
private int ii_cve_carreras_disponibles[], ii_cve_carreras_seleccionadas[]
private string is_carreras_disponibles[], is_carreras_seleccionadas[]
private int ii_seleccion //0 Todas, 1 Licenciatura, 2 Posgrado, 3 Seleccionadas

end variables

forward prototypes
private function integer transfiereposibleseleccionada (string as_carrera)
private function integer transfiereseleccionadaposible (string as_carrera)
private subroutine interruptor_seleccion (boolean ab_estatus)
public subroutine interruptor_listas_carreras (boolean ab_estatus)
public function integer inicializa (integer ai_cve_coordinacion)
public function integer obtencarreras (ref integer ai_cve_carreras[], ref integer ai_total_carreras)
end prototypes

private function integer transfiereposibleseleccionada (string as_carrera);//private int ii_cve_carreras_disponibles[], ii_cve_carreras_seleccionadas[]
//private string is_carreras_disponibles[], is_carreras_seleccionadas[]

int li_i
boolean lb_encontrado
lb_encontrado = false
li_i = 0
for li_i = 1 to ii_total_disponibles
	if is_carreras_disponibles[li_i] = as_carrera and not(lb_encontrado) then
		lb_encontrado = true
		ii_cve_carreras_seleccionadas[ii_total_seleccionadas + 1] = ii_cve_carreras_disponibles[li_i]
		is_carreras_seleccionadas[ii_total_seleccionadas + 1] = is_carreras_disponibles[li_i]
		ii_cve_carreras_disponibles[li_i] = 0
		is_carreras_disponibles[li_i] = ""
	end if
	if lb_encontrado and li_i < ii_total_disponibles then
		ii_cve_carreras_disponibles[li_i] = ii_cve_carreras_disponibles[li_i + 1]
		is_carreras_disponibles[li_i] = is_carreras_disponibles[li_i + 1]
	end if
next 
if lb_encontrado then
	ii_total_disponibles --
	ii_total_seleccionadas ++
	return 1
else
	return 0
end if


end function

private function integer transfiereseleccionadaposible (string as_carrera);int li_i
boolean lb_encontrado
lb_encontrado = false
li_i = 0
for li_i = 1 to ii_total_seleccionadas
	if is_carreras_seleccionadas[li_i] = as_carrera and not(lb_encontrado) then
		lb_encontrado = true
		ii_cve_carreras_disponibles[ii_total_disponibles + 1] = ii_cve_carreras_seleccionadas[li_i]
		is_carreras_disponibles[ii_total_disponibles + 1] = is_carreras_seleccionadas[li_i]
		ii_cve_carreras_seleccionadas[li_i] = 0
		is_carreras_seleccionadas[li_i] = ""
	end if
	if lb_encontrado and li_i < ii_total_seleccionadas then
		ii_cve_carreras_seleccionadas[li_i] = ii_cve_carreras_seleccionadas[li_i + 1]
		is_carreras_seleccionadas[li_i] = is_carreras_seleccionadas[li_i + 1]
	end if
next 
if lb_encontrado then
	ii_total_seleccionadas --
	ii_total_disponibles ++
	return 1
else
	return 0
end if


end function

private subroutine interruptor_seleccion (boolean ab_estatus);gb_seleccion.visible = ab_estatus
rb_todas_carreras.visible = ab_estatus
rb_todo_licenciatura.visible = ab_estatus
rb_todo_posgrado.visible = ab_estatus
rb_carreras_seleccionadas.visible = ab_estatus
end subroutine

public subroutine interruptor_listas_carreras (boolean ab_estatus);lb_carreras_posibles.visible = ab_estatus
lb_carreras_seleccionadas.visible = ab_estatus
//cb_agregar_seleccionada.visible = ab_estatus
//cb_eliminar_seleccionada.visible = ab_estatus
//cb_agregar_todas.visible = ab_estatus
//cb_eliminar_todas.visible = ab_estatus

//uo_nivel .visible = ab_estatus



end subroutine

public function integer inicializa (integer ai_cve_coordinacion);int li_total, li_i
datastore lds_carreras
lds_carreras = Create DataStore
lds_carreras.DataObject = "d_carreras_coordinaciones"
lds_carreras.SetTransObject(gtr_sce)
li_total = lds_carreras.retrieve(ai_cve_coordinacion)
if li_total > 0 then
	ii_total_disponibles = li_total
	for li_i = 1 to li_total
		ii_cve_carreras_disponibles[li_i] = lds_carreras.GetItemNumber(li_i, "cve_carrera")
		is_carreras_disponibles[li_i] = lds_carreras.GetItemString(li_i, "carrera")
		lb_carreras_posibles.AddItem(is_carreras_disponibles[li_i])
	next
end if
Destroy lds_carreras

if ai_cve_coordinacion <> 9999 then
	interruptor_seleccion(false)
else
	interruptor_seleccion(true)
end if


uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce, "S", "S")


return li_total

end function

public function integer obtencarreras (ref integer ai_cve_carreras[], ref integer ai_total_carreras);ai_cve_carreras = ii_cve_carreras_seleccionadas
ai_total_carreras = ii_total_seleccionadas
return ii_seleccion
end function

on uo_lb_carreras_por_coordinacion_bck.create
this.uo_nivel=create uo_nivel
this.rb_carreras_seleccionadas=create rb_carreras_seleccionadas
this.rb_todo_posgrado=create rb_todo_posgrado
this.rb_todo_licenciatura=create rb_todo_licenciatura
this.rb_todas_carreras=create rb_todas_carreras
this.cb_eliminar_todas=create cb_eliminar_todas
this.cb_agregar_todas=create cb_agregar_todas
this.cb_eliminar_seleccionada=create cb_eliminar_seleccionada
this.cb_agregar_seleccionada=create cb_agregar_seleccionada
this.lb_carreras_seleccionadas=create lb_carreras_seleccionadas
this.lb_carreras_posibles=create lb_carreras_posibles
this.gb_seleccion=create gb_seleccion
this.Control[]={this.uo_nivel,&
this.rb_carreras_seleccionadas,&
this.rb_todo_posgrado,&
this.rb_todo_licenciatura,&
this.rb_todas_carreras,&
this.cb_eliminar_todas,&
this.cb_agregar_todas,&
this.cb_eliminar_seleccionada,&
this.cb_agregar_seleccionada,&
this.lb_carreras_seleccionadas,&
this.lb_carreras_posibles,&
this.gb_seleccion}
end on

on uo_lb_carreras_por_coordinacion_bck.destroy
destroy(this.uo_nivel)
destroy(this.rb_carreras_seleccionadas)
destroy(this.rb_todo_posgrado)
destroy(this.rb_todo_licenciatura)
destroy(this.rb_todas_carreras)
destroy(this.cb_eliminar_todas)
destroy(this.cb_agregar_todas)
destroy(this.cb_eliminar_seleccionada)
destroy(this.cb_agregar_seleccionada)
destroy(this.lb_carreras_seleccionadas)
destroy(this.lb_carreras_posibles)
destroy(this.gb_seleccion)
end on

event constructor;ii_total_disponibles = 0
ii_total_seleccionadas = 0
ii_seleccion = 3







end event

type uo_nivel from uo_nivel_rbutton within uo_lb_carreras_por_coordinacion_bck
integer x = 2821
integer y = 28
integer width = 549
integer height = 372
integer taborder = 30
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

event ue_cambia_seleccion;call super::ue_cambia_seleccion;
STRING ls_nivel 

ls_nivel = THIS.cve_nivel


CHOOSE CASE ls_nivel  
	// TSU	
	CASE "T" 
		ii_seleccion = 4
		interruptor_listas_carreras(false) 				
	// Licenciatura 	
	CASE "L"
		ii_seleccion = 1
		interruptor_listas_carreras(false) 		
	// Posgrado 	
	CASE "P" 
		ii_seleccion = 2
		interruptor_listas_carreras(false)	 
	// Todos
	CASE "A"
		ii_seleccion = 0 
		interruptor_listas_carreras(false) 	
	// Seleccionado 
	CASE "S"
		ii_seleccion = 3
		interruptor_listas_carreras(true) 		
END CHOOSE



// ls_nivel = ls_nivel



// Licenciatura
//ii_seleccion = 1
//interruptor_listas_carreras(false) 

// Postgrado
//ii_seleccion = 2
//interruptor_listas_carreras(false)

// Todas 
//cve_nivel = "A" 
//ii_seleccion = 0
//interruptor_listas_carreras(false) 

// Seleccionadas
//cve_nivel = "S"
//ii_seleccion = 3
//interruptor_listas_carreras(true) 









end event

type rb_carreras_seleccionadas from radiobutton within uo_lb_carreras_por_coordinacion_bck
integer x = 2021
integer y = 432
integer width = 498
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Seleccionadas"
boolean checked = true
end type

event clicked;ii_seleccion = 3
interruptor_listas_carreras(true)
end event

type rb_todo_posgrado from radiobutton within uo_lb_carreras_por_coordinacion_bck
integer x = 914
integer y = 424
integer width = 480
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Posgrado"
end type

event clicked;ii_seleccion = 2
interruptor_listas_carreras(false)
end event

type rb_todo_licenciatura from radiobutton within uo_lb_carreras_por_coordinacion_bck
integer x = 274
integer y = 420
integer width = 535
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Licenciatura/TSU"
end type

event clicked;ii_seleccion = 1
interruptor_listas_carreras(false)
end event

type rb_todas_carreras from radiobutton within uo_lb_carreras_por_coordinacion_bck
integer x = 1472
integer y = 436
integer width = 485
integer height = 60
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Todas"
end type

event clicked;ii_seleccion = 0
interruptor_listas_carreras(false)
end event

type cb_eliminar_todas from commandbutton within uo_lb_carreras_por_coordinacion_bck
integer x = 1243
integer y = 308
integer width = 311
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<Todas<"
end type

event clicked;int li_i, li_total
li_total = lb_carreras_seleccionadas.TotalItems()
if li_total > 0 then
	for li_i = 1 to li_total 
		lb_carreras_seleccionadas.SelectItem(1)
		cb_eliminar_seleccionada.event clicked()
	next
end if
end event

type cb_agregar_todas from commandbutton within uo_lb_carreras_por_coordinacion_bck
integer x = 1243
integer y = 212
integer width = 311
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">Todas>"
end type

event clicked;int li_i, li_total
li_total = lb_carreras_posibles.TotalItems()
if li_total > 0 then
	for li_i = 1 to li_total 
		lb_carreras_posibles.SelectItem(1)
		cb_agregar_seleccionada.event clicked()
	next
end if

end event

type cb_eliminar_seleccionada from commandbutton within uo_lb_carreras_por_coordinacion_bck
integer x = 1243
integer y = 116
integer width = 311
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "<<<<<<<"
end type

event clicked;string ls_carrera
int li_indice

ls_carrera = lb_carreras_seleccionadas.Selecteditem()
li_indice = lb_carreras_seleccionadas.SelectedIndex()
if li_indice > 0 then
	if (TransfiereSeleccionadaPosible(ls_carrera) = 1) then
		lb_carreras_seleccionadas.DeleteItem(li_indice)
		lb_carreras_posibles.AddItem(ls_carrera)
	end if
end if
end event

type cb_agregar_seleccionada from commandbutton within uo_lb_carreras_por_coordinacion_bck
integer x = 1243
integer y = 20
integer width = 311
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = ">>>>>>>"
end type

event clicked;string ls_carrera
int li_indice

ls_carrera = lb_carreras_posibles.Selecteditem()
li_indice = lb_carreras_posibles.SelectedIndex()
if li_indice > 0 then
	if (TransfierePosibleSeleccionada(ls_carrera) = 1) then
		lb_carreras_posibles.DeleteItem(li_indice)
		lb_carreras_seleccionadas.AddItem(ls_carrera)
	end if
end if
end event

type lb_carreras_seleccionadas from listbox within uo_lb_carreras_por_coordinacion_bck
integer x = 1577
integer y = 20
integer width = 1202
integer height = 380
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;cb_eliminar_seleccionada. event clicked()
end event

type lb_carreras_posibles from listbox within uo_lb_carreras_por_coordinacion_bck
integer x = 18
integer y = 20
integer width = 1202
integer height = 380
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
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;cb_agregar_seleccionada.event clicked()
end event

type gb_seleccion from groupbox within uo_lb_carreras_por_coordinacion_bck
integer x = 37
integer y = 408
integer width = 594
integer height = 108
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
string text = "Seleccion Carreras"
end type

