$PBExportHeader$w_selecciona_materia_sep.srw
$PBExportComments$Se selecciona la materia SEP a inscribir
forward
global type w_selecciona_materia_sep from window
end type
type cb_salir from commandbutton within w_selecciona_materia_sep
end type
type cb_seleccionar from commandbutton within w_selecciona_materia_sep
end type
type rb_coordinacion from radiobutton within w_selecciona_materia_sep
end type
type rb_carrera from radiobutton within w_selecciona_materia_sep
end type
type dw_carrera_coord from datawindow within w_selecciona_materia_sep
end type
type dw_materias from datawindow within w_selecciona_materia_sep
end type
type gb_1 from groupbox within w_selecciona_materia_sep
end type
end forward

global type w_selecciona_materia_sep from window
integer width = 4055
integer height = 1884
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_salir cb_salir
cb_seleccionar cb_seleccionar
rb_coordinacion rb_coordinacion
rb_carrera rb_carrera
dw_carrera_coord dw_carrera_coord
dw_materias dw_materias
gb_1 gb_1
end type
global w_selecciona_materia_sep w_selecciona_materia_sep

type variables

LONG il_coord
TRANSACTION itr_trans
STRING is_orden

end variables
forward prototypes
public function integer wf_tipo_busqueda ()
end prototypes

public function integer wf_tipo_busqueda ();// Se revisa el tipo de búsqueda 
IF rb_carrera.CHECKED THEN 
	dw_carrera_coord.DATAOBJECT = "dw_carreras_mat_sep" 
ELSE
	dw_carrera_coord.DATAOBJECT = "" 
END IF  


dw_carrera_coord.SETTRANSOBJECT(itr_trans) 
dw_carrera_coord.RETRIEVE()

RETURN 0




end function

on w_selecciona_materia_sep.create
this.cb_salir=create cb_salir
this.cb_seleccionar=create cb_seleccionar
this.rb_coordinacion=create rb_coordinacion
this.rb_carrera=create rb_carrera
this.dw_carrera_coord=create dw_carrera_coord
this.dw_materias=create dw_materias
this.gb_1=create gb_1
this.Control[]={this.cb_salir,&
this.cb_seleccionar,&
this.rb_coordinacion,&
this.rb_carrera,&
this.dw_carrera_coord,&
this.dw_materias,&
this.gb_1}
end on

on w_selecciona_materia_sep.destroy
destroy(this.cb_salir)
destroy(this.cb_seleccionar)
destroy(this.rb_coordinacion)
destroy(this.rb_carrera)
destroy(this.dw_carrera_coord)
destroy(this.dw_materias)
destroy(this.gb_1)
end on

event open;
il_coord = Message.LongParm 


// Se revisa si se trata de una coordinación en particular 
IF il_coord > 0 THEN 
	rb_carrera.visible = FALSE
	rb_carrera.CHECKED = FALSE 
	rb_coordinacion.CHECKED = TRUE 
	rb_coordinacion.ENABLED = FALSE
END IF 






end event

type cb_salir from commandbutton within w_selecciona_materia_sep
integer x = 3557
integer y = 656
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

type cb_seleccionar from commandbutton within w_selecciona_materia_sep
integer x = 3557
integer y = 516
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleccionar"
end type

type rb_coordinacion from radiobutton within w_selecciona_materia_sep
integer x = 101
integer y = 208
integer width = 425
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coordinación"
end type

type rb_carrera from radiobutton within w_selecciona_materia_sep
integer x = 101
integer y = 120
integer width = 302
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carrera"
boolean checked = true
end type

type dw_carrera_coord from datawindow within w_selecciona_materia_sep
integer x = 658
integer y = 68
integer width = 2784
integer height = 396
integer taborder = 10
string title = "none"
string dataobject = "dw_carreras_mat_sep"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event doubleclicked;
STRING ls_sort

IF dwo.name = "cve_carrera_t" THEN  
	ls_sort = "cve_carrera"
ELSEIF dwo.name = "carrera_t" THEN  
	ls_sort = "carrera"
	
END IF 

IF is_orden <> "A"  THEN 
	ls_sort = ls_sort + " " + " ASC"
	is_orden = "A" 
ELSE	
	ls_sort = ls_sort + " " + " DESC"
	is_orden = "D"  
END IF  

dw_carrera_coord.SETSORT(ls_sort)  
dw_carrera_coord.SORT() 


end event

type dw_materias from datawindow within w_selecciona_materia_sep
integer x = 69
integer y = 516
integer width = 3369
integer height = 1208
integer taborder = 10
string title = "none"
string dataobject = "dw_materias_ofertadas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_selecciona_materia_sep
integer x = 55
integer y = 44
integer width = 567
integer height = 288
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar por: "
end type

