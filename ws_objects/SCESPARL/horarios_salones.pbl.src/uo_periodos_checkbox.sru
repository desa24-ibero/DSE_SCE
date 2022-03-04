$PBExportHeader$uo_periodos_checkbox.sru
$PBExportComments$Objeto para seleccionar periodos Semestrales y Trimestrales. César Ponce - Tijuana. Marzo/2017
forward
global type uo_periodos_checkbox from userobject
end type
type st_200 from statictext within uo_periodos_checkbox
end type
type st_100 from statictext within uo_periodos_checkbox
end type
type uo_2 from uo_per_ani within uo_periodos_checkbox
end type
type uo_1 from uo_per_ani within uo_periodos_checkbox
end type
type cbx_semestral from checkbox within uo_periodos_checkbox
end type
type cbx_trimestral from checkbox within uo_periodos_checkbox
end type
end forward

global type uo_periodos_checkbox from userobject
integer width = 1957
integer height = 368
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_200 st_200
st_100 st_100
uo_2 uo_2
uo_1 uo_1
cbx_semestral cbx_semestral
cbx_trimestral cbx_trimestral
end type
global uo_periodos_checkbox uo_periodos_checkbox

type variables
uo_periodo_servicios iuo_periodo_servicios 
uo_periodo_servicios iuo_periodo_servicios2

int anio_semestral,periodo_semestral
int anio_trimestral,periodo_trimestral
end variables

forward prototypes
public subroutine inicializa_periodos (transaction conexion)
public subroutine obtener_periodos (ref integer anio_sem_param, ref integer periodo_sem_param, ref integer anio_trim_param, ref integer periodo_trim_param, ref boolean semestral_seleccionado, ref boolean trimestral_seleccionado)
end prototypes

public subroutine inicializa_periodos (transaction conexion);// Inicializa los Objetos de periodos. Cesar Ponce - Tijuana - Marzo 2017

STRING lsModifica 

// inicia semestrales

iuo_periodo_servicios = CREATE uo_periodo_servicios 

iuo_periodo_servicios.f_carga_periodos("S", "L", conexion) // L de descripcion larga "S" de semestral

lsModifica = iuo_periodo_servicios. f_genera_cadena_opciones("L") // L de descripcion larga
iuo_periodo_servicios.f_carga_periodo_activo( periodo_semestral,anio_semestral,"S",conexion) // "S" de semestral


uo_1.em_per.DisplayData = lsModifica


uo_1.em_ani.text = string(anio_semestral) 
uo_1.em_per.text = string(periodo_semestral)  

uo_1.em_per.TRIGGEREVENT(MODIFIED!)

// inicia trimestrales

iuo_periodo_servicios2 = CREATE uo_periodo_servicios 

iuo_periodo_servicios2.f_carga_periodos("T", "L", conexion) // L de descripcion larga "S" de trimestral

lsModifica = iuo_periodo_servicios2. f_genera_cadena_opciones("L") // L de descripcion larga
iuo_periodo_servicios2.f_carga_periodo_activo( periodo_trimestral,anio_trimestral,"T",conexion) // "S" de trimestral


uo_2.em_per.DisplayData = lsModifica


uo_2.em_ani.text = string(anio_trimestral) 
uo_2.em_per.text = string(periodo_trimestral)  

uo_2.em_per.TRIGGEREVENT(MODIFIED!)


end subroutine

public subroutine obtener_periodos (ref integer anio_sem_param, ref integer periodo_sem_param, ref integer anio_trim_param, ref integer periodo_trim_param, ref boolean semestral_seleccionado, ref boolean trimestral_seleccionado);string tempo


uo_1.em_per.getdata(tempo)
periodo_sem_param=integer(tempo)

anio_sem_param=integer(uo_1.em_ani.text)

//messagebox("",string(anio_sem_param))

uo_2.em_per.getdata(tempo)
periodo_trim_param=integer(tempo)

anio_trim_param=integer(uo_2.em_ani.text)

semestral_seleccionado=cbx_semestral.checked
trimestral_seleccionado=cbx_trimestral.checked


end subroutine

on uo_periodos_checkbox.create
this.st_200=create st_200
this.st_100=create st_100
this.uo_2=create uo_2
this.uo_1=create uo_1
this.cbx_semestral=create cbx_semestral
this.cbx_trimestral=create cbx_trimestral
this.Control[]={this.st_200,&
this.st_100,&
this.uo_2,&
this.uo_1,&
this.cbx_semestral,&
this.cbx_trimestral}
end on

on uo_periodos_checkbox.destroy
destroy(this.st_200)
destroy(this.st_100)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.cbx_semestral)
destroy(this.cbx_trimestral)
end on

type st_200 from statictext within uo_periodos_checkbox
boolean visible = false
integer x = 1851
integer y = 44
integer width = 78
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "."
alignment alignment = right!
boolean focusrectangle = false
end type

event doubleclicked;st_100.visible=true
st_200.visible=false
messagebox("",string(reverse(".6102/ozraM ,anaujiT orebI~n~zdH ecnoP raseC")))

end event

type st_100 from statictext within uo_periodos_checkbox
integer x = 1851
integer y = 220
integer width = 78
integer height = 56
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "."
alignment alignment = right!
boolean focusrectangle = false
end type

event doubleclicked;st_200.visible=true
st_100.visible=false
end event

type uo_2 from uo_per_ani within uo_periodos_checkbox
event destroy ( )
integer x = 603
integer y = 176
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
end type

on uo_2.destroy
call uo_per_ani::destroy
end on

event constructor;call super::constructor;/*iuo_periodo_servicios2 = CREATE uo_periodo_servicios 

iuo_periodo_servicios2.f_carga_periodos("T", "L", gtr_sce) // L de descripcion larga "S" de trimestral
STRING lsModifica 
lsModifica = iuo_periodo_servicios2. f_genera_cadena_opciones("L") // L de descripcion larga
iuo_periodo_servicios2.f_carga_periodo_activo( periodo_trimestral,anio_trimestral,"T",gtr_sce) // "S" de trimestral


this.em_per.DisplayData = lsModifica


this.em_ani.text = string(anio_trimestral) 
this.em_per.text = string(periodo_trimestral)  

em_per.TRIGGEREVENT(MODIFIED!)
*/
end event

type uo_1 from uo_per_ani within uo_periodos_checkbox
event destroy ( )
integer x = 603
integer y = 12
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

event constructor;call super::constructor;/*iuo_periodo_servicios = CREATE uo_periodo_servicios 

iuo_periodo_servicios.f_carga_periodos("S", "L", gtr_sce) // L de descripcion larga "S" de semestral
STRING lsModifica 
lsModifica = iuo_periodo_servicios. f_genera_cadena_opciones("L") // L de descripcion larga
iuo_periodo_servicios.f_carga_periodo_activo( periodo_semestral,anio_semestral,"S",gtr_sce) // "S" de semestral


this.em_per.DisplayData = lsModifica


this.em_ani.text = string(anio_semestral) 
this.em_per.text = string(periodo_semestral)  

em_per.TRIGGEREVENT(MODIFIED!)
*/
end event

type cbx_semestral from checkbox within uo_periodos_checkbox
integer y = 52
integer width = 571
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo Semestral"
boolean checked = true
boolean lefttext = true
end type

type cbx_trimestral from checkbox within uo_periodos_checkbox
integer x = 5
integer y = 208
integer width = 571
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo Trimestral"
boolean checked = true
boolean lefttext = true
end type

