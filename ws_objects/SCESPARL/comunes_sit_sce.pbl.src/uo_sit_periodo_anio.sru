$PBExportHeader$uo_sit_periodo_anio.sru
$PBExportComments$Objeto Visual Periodo y Año. JCS.
forward
global type uo_sit_periodo_anio from userobject
end type
type em_anio from editmask within uo_sit_periodo_anio
end type
type em_periodo from editmask within uo_sit_periodo_anio
end type
type rr_1 from roundrectangle within uo_sit_periodo_anio
end type
end forward

global type uo_sit_periodo_anio from userobject
integer width = 1134
integer height = 176
long backcolor = 29534863
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_anio em_anio
em_periodo em_periodo
rr_1 rr_1
end type
global uo_sit_periodo_anio uo_sit_periodo_anio

type variables
w_sit_ancestral w_padre
end variables

on uo_sit_periodo_anio.create
this.em_anio=create em_anio
this.em_periodo=create em_periodo
this.rr_1=create rr_1
this.Control[]={this.em_anio,&
this.em_periodo,&
this.rr_1}
end on

on uo_sit_periodo_anio.destroy
destroy(this.em_anio)
destroy(this.em_periodo)
destroy(this.rr_1)
end on

event constructor;/* 
	Obtiene el periodo actual en base a la fecha del servidor
	Ver código de la fumción f_periodo_actual
	Ver variables de instancia en esta ventan y en la  ventana w_sit_ancestral (ii_periodo,ii_anio)
	Juan Campos Sánchez
	Junio-2001.
*/

w_padre = getparent()

f_sit_periodo_actual(w_padre.ii_anio,w_padre.ii_periodo)

end event

type em_anio from editmask within uo_sit_periodo_anio
integer x = 741
integer y = 36
integer width = 352
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "####"
boolean spin = true
double increment = 1
string minmax = "1950~~2100"
end type

event constructor;
text=string(w_padre.ii_anio)
 

end event

event losefocus;//event modified()
end event

event modified;if w_padre.ii_anio = integer(text) then
	return
else
	w_padre.ii_anio= integer(text)
end if

w_padre.event ue_periodo()


end event

type em_periodo from editmask within uo_sit_periodo_anio
integer x = 46
integer y = 36
integer width = 677
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 15793151
alignment alignment = center!
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
boolean autoskip = true
boolean spin = true
string displaydata = "PRIMAVERA~t0/VERANO~t1/OTOÑO~t2/"
double increment = 1
string minmax = "0~~2"
boolean usecodetable = true
end type

event losefocus;//event modified()
end event

event constructor; 
CHOOSE CASE w_padre.ii_periodo
	CASE 0
		text="PRIMAVERA"
		w_padre.ii_periodo = 0
	CASE 1
		text="VERANO"
		w_padre.ii_periodo = 1
	CASE 2
		text="OTOÑO"
		w_padre.ii_periodo = 2		
END CHOOSE

end event

event modified;
CHOOSE CASE text
CASE "PRIMAVERA"
	w_padre.ii_periodo=0
CASE "VERANO"
		w_padre.ii_periodo=1
CASE "OTOÑO"
		w_padre.ii_periodo=2
END CHOOSE

w_padre.event ue_periodo()
	

end event

type rr_1 from roundrectangle within uo_sit_periodo_anio
integer linethickness = 1
long fillcolor = 12632256
integer x = 18
integer y = 12
integer width = 1097
integer height = 152
integer cornerheight = 40
integer cornerwidth = 46
end type

