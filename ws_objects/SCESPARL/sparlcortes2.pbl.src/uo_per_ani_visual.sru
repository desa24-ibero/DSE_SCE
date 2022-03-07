﻿$PBExportHeader$uo_per_ani_visual.sru
$PBExportComments$Objeto con el que se puede seleccionar: Periodo y Año en cuestión. Modifica variables globales.
forward
global type uo_per_ani_visual from userobject
end type
type em_per from editmask within uo_per_ani_visual
end type
type em_ani from editmask within uo_per_ani_visual
end type
type r_3 from rectangle within uo_per_ani_visual
end type
type cbx_nuevo from checkbox within uo_per_ani_visual
end type
type rr_4 from roundrectangle within uo_per_ani_visual
end type
type rr_5 from roundrectangle within uo_per_ani_visual
end type
end forward

global type uo_per_ani_visual from userobject
integer width = 1248
integer height = 168
boolean enabled = false
long tabtextcolor = 41943040
long tabbackcolor = 80793808
long picturemaskcolor = 553648127
em_per em_per
em_ani em_ani
r_3 r_3
cbx_nuevo cbx_nuevo
rr_4 rr_4
rr_5 rr_5
end type
global uo_per_ani_visual uo_per_ani_visual

type variables


end variables

forward prototypes
public function integer of_obten_anio ()
public function integer of_obten_periodo ()
end prototypes

public function integer of_obten_anio ();//of_obten_anio
//Devuelve el anio seleccionado

string ls_anio
long ll_anio
ls_anio = em_ani.text

if isnumber(ls_anio) then
	ll_anio = long(ls_anio)
else
	ll_anio = -1
end if

return ll_anio

end function

public function integer of_obten_periodo ();//of_obten_periodo
//Devuelve el periodo seleccionado


integer li_periodo

CHOOSE CASE em_per.text
	CASE "Primavera"
		li_periodo = 0		
	CASE "Verano"
		li_periodo = 1		
	CASE "Otoño"
		li_periodo = 2
	CASE ELSE
		li_periodo = -1
END CHOOSE

RETURN li_periodo
end function

on uo_per_ani_visual.create
this.em_per=create em_per
this.em_ani=create em_ani
this.r_3=create r_3
this.cbx_nuevo=create cbx_nuevo
this.rr_4=create rr_4
this.rr_5=create rr_5
this.Control[]={this.em_per,&
this.em_ani,&
this.r_3,&
this.cbx_nuevo,&
this.rr_4,&
this.rr_5}
end on

on uo_per_ani_visual.destroy
destroy(this.em_per)
destroy(this.em_ani)
destroy(this.r_3)
destroy(this.cbx_nuevo)
destroy(this.rr_4)
destroy(this.rr_5)
end on

type em_per from editmask within uo_per_ani_visual
event modified pbm_enmodified
integer x = 462
integer y = 24
integer width = 731
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxx"
boolean autoskip = true
boolean spin = true
string displaydata = "Primavera~t0/Verano~t1/Otoño~t2/"
double increment = 1
boolean usecodetable = true
end type

event modified;CHOOSE CASE text
	CASE "Primavera"
		gi_periodo=0
	CASE "Verano"
		gi_periodo=1
	CASE "Otoño"
		gi_periodo=2
END CHOOSE
end event

event constructor;CHOOSE CASE gi_periodo
	CASE 0
		text="Primavera"
	CASE 1
		text="Verano"
	CASE 2
		text="Otoño"
END CHOOSE
end event

type em_ani from editmask within uo_per_ani_visual
integer x = 32
integer y = 28
integer width = 347
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean autoskip = true
boolean spin = true
string displaydata = ""
double increment = 1
end type

event modified;if long(text) < 100 Then
	gi_anio = long(text) + 1900
	text = String(gi_anio)
else
	gi_anio = long(text)
End if
end event

event constructor;text=string(gi_anio)
end event

type r_3 from rectangle within uo_per_ani_visual
boolean visible = false
integer linethickness = 5
long fillcolor = 30588249
integer x = 2807
integer y = 32
integer width = 407
integer height = 72
end type

type cbx_nuevo from checkbox within uo_per_ani_visual
boolean visible = false
integer x = 2811
integer y = 36
integer width = 393
integer height = 64
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Modificar"
borderstyle borderstyle = stylelowered!
end type

type rr_4 from roundrectangle within uo_per_ani_visual
long linecolor = 33554432
integer linethickness = 5
long fillcolor = 79741120
integer x = 430
integer y = 8
integer width = 795
integer height = 144
integer cornerheight = 41
integer cornerwidth = 42
end type

type rr_5 from roundrectangle within uo_per_ani_visual
long linecolor = 33554432
integer linethickness = 5
long fillcolor = 79741120
integer x = 14
integer y = 8
integer width = 398
integer height = 144
integer cornerheight = 41
integer cornerwidth = 42
end type
