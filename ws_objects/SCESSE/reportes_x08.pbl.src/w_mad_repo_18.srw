$PBExportHeader$w_mad_repo_18.srw
$PBExportComments$Ventana para el Reporte de Ocupación de Salones
forward
global type w_mad_repo_18 from window
end type
type gb_20 from groupbox within w_mad_repo_18
end type
type st_3 from statictext within w_mad_repo_18
end type
type dw_1z from datawindow within w_mad_repo_18
end type
type cb_1 from commandbutton within w_mad_repo_18
end type
type cb_5x from commandbutton within w_mad_repo_18
end type
type rb_3x from radiobutton within w_mad_repo_18
end type
type rb_2x from radiobutton within w_mad_repo_18
end type
type rb_1x from radiobutton within w_mad_repo_18
end type
type em_1 from editmask within w_mad_repo_18
end type
type rb_13 from radiobutton within w_mad_repo_18
end type
type rb_12 from radiobutton within w_mad_repo_18
end type
type rb_11 from radiobutton within w_mad_repo_18
end type
type cbx_3 from checkbox within w_mad_repo_18
end type
type cbx_4 from checkbox within w_mad_repo_18
end type
type cbx_5 from checkbox within w_mad_repo_18
end type
type cbx_2 from checkbox within w_mad_repo_18
end type
type cbx_1 from checkbox within w_mad_repo_18
end type
type dw_1x from datawindow within w_mad_repo_18
end type
type gb_8 from groupbox within w_mad_repo_18
end type
type gb_9 from groupbox within w_mad_repo_18
end type
type gb_11 from groupbox within w_mad_repo_18
end type
type gb_6 from groupbox within w_mad_repo_18
end type
type gb_2 from groupbox within w_mad_repo_18
end type
type gb_1 from groupbox within w_mad_repo_18
end type
type uo_periodos from uo_per_ani within w_mad_repo_18
end type
end forward

global type w_mad_repo_18 from window
integer x = 832
integer y = 360
integer width = 3799
integer height = 2644
boolean titlebar = true
string title = "Reporte de Ocupación de Salones"
string menuname = "m_repo_mad7"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
gb_20 gb_20
st_3 st_3
dw_1z dw_1z
cb_1 cb_1
cb_5x cb_5x
rb_3x rb_3x
rb_2x rb_2x
rb_1x rb_1x
em_1 em_1
rb_13 rb_13
rb_12 rb_12
rb_11 rb_11
cbx_3 cbx_3
cbx_4 cbx_4
cbx_5 cbx_5
cbx_2 cbx_2
cbx_1 cbx_1
dw_1x dw_1x
gb_8 gb_8
gb_9 gb_9
gb_11 gb_11
gb_6 gb_6
gb_2 gb_2
gb_1 gb_1
uo_periodos uo_periodos
end type
global w_mad_repo_18 w_mad_repo_18

type variables
int periodo_x

uo_periodo_servicios iuo_periodo_servicios
end variables

on w_mad_repo_18.create
if this.MenuName = "m_repo_mad7" then this.MenuID = create m_repo_mad7
this.gb_20=create gb_20
this.st_3=create st_3
this.dw_1z=create dw_1z
this.cb_1=create cb_1
this.cb_5x=create cb_5x
this.rb_3x=create rb_3x
this.rb_2x=create rb_2x
this.rb_1x=create rb_1x
this.em_1=create em_1
this.rb_13=create rb_13
this.rb_12=create rb_12
this.rb_11=create rb_11
this.cbx_3=create cbx_3
this.cbx_4=create cbx_4
this.cbx_5=create cbx_5
this.cbx_2=create cbx_2
this.cbx_1=create cbx_1
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_9=create gb_9
this.gb_11=create gb_11
this.gb_6=create gb_6
this.gb_2=create gb_2
this.gb_1=create gb_1
this.uo_periodos=create uo_periodos
this.Control[]={this.gb_20,&
this.st_3,&
this.dw_1z,&
this.cb_1,&
this.cb_5x,&
this.rb_3x,&
this.rb_2x,&
this.rb_1x,&
this.em_1,&
this.rb_13,&
this.rb_12,&
this.rb_11,&
this.cbx_3,&
this.cbx_4,&
this.cbx_5,&
this.cbx_2,&
this.cbx_1,&
this.dw_1x,&
this.gb_8,&
this.gb_9,&
this.gb_11,&
this.gb_6,&
this.gb_2,&
this.gb_1,&
this.uo_periodos}
end on

on w_mad_repo_18.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_20)
destroy(this.st_3)
destroy(this.dw_1z)
destroy(this.cb_1)
destroy(this.cb_5x)
destroy(this.rb_3x)
destroy(this.rb_2x)
destroy(this.rb_1x)
destroy(this.em_1)
destroy(this.rb_13)
destroy(this.rb_12)
destroy(this.rb_11)
destroy(this.cbx_3)
destroy(this.cbx_4)
destroy(this.cbx_5)
destroy(this.cbx_2)
destroy(this.cbx_1)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_9)
destroy(this.gb_11)
destroy(this.gb_6)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.uo_periodos)
end on

event open;this.x=1
this.y=1

	//Modif. Roberto Novoa R.  May/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

end event

type gb_20 from groupbox within w_mad_repo_18
integer x = 795
integer y = 68
integer width = 1312
integer height = 268
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_mad_repo_18
integer x = 3273
integer y = 72
integer width = 443
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_1z from datawindow within w_mad_repo_18
integer y = 432
integer width = 3739
integer height = 1984
integer taborder = 90
string dataobject = "dw_repo_mad_18_gz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(dw_1z.object.cuantos[1])
	st_3.text='Total : '+Cont
else
	st_3.text='Total : '+Cont
end if

end event

type cb_1 from commandbutton within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3378
integer y = 220
integer width = 265
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;/* Se le pasa el arreglo al datawindow*/
int Total, Plan_GO
int contador

int Salones[]
long Anio_X
string Nivel_X[]

setpointer(Hourglass!)

if (cbx_1.checked = true or cbx_2.checked = true or cbx_3.checked = true or cbx_4.checked = true) then
   Plan_GO = 1
else
	Plan_GO = 0
end if

if ( Plan_GO = 1)  then

	dw_1x.Reset() 
	dw_1z.Reset()

   // Se Obtienen los tipos de Salon
	contador=0
	contador  = upperbound (Salones[])
   if (cbx_1.checked = true) THEN
		  Salones[contador+1]=0
	END IF	
	contador  = upperbound (Salones[])
   if (cbx_2.checked = true) THEN
		  Salones[contador+1]=1
	END IF
	contador  = upperbound (Salones[])
   if (cbx_3.checked = true) THEN
		  Salones[contador+1]=2
	END IF
	contador  = upperbound (Salones[])
   if (cbx_4.checked = true) THEN
		  Salones[contador+1]=3
	END IF
	
	periodo_x=uo_periodos.iuo_periodo_servicios.f_recupera_id(uo_periodos.em_per.text, "L")
	Anio_X=long(uo_periodos.em_ani.text)
	
	dw_1x.retrieve(periodo_x,Anio_X,Salones)	
	dw_1z.retrieve(periodo_x,Anio_X,Salones)
	
// Se Ordenan deacuerdo a los criterios establecidos
   cb_5x.triggerevent("clicked") 

end if

end event

event constructor;TabOrder = 4
end event

type cb_5x from commandbutton within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2935
integer y = 224
integer width = 270
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordenar"
end type

event clicked;/* Se verifica que opcion de Ordenamiento que se requiere por medio de los checks*/
setpointer(Hourglass!)
if (rb_1x.checked=TRUE) then
	// Ordenamiento por Salón 
   dw_1x.setsort("salon_cve_salon A, horario_cve_dia A, horario_hora_inicio A ")
	dw_1x.sort()
	// Se recalcula el grupo
	dw_1x.GroupCalc ( )

   dw_1z.setsort("salon_cve_salon A, horario_cve_dia A, horario_hora_inicio A ")
	dw_1z.sort()
	// Se recalcula el grupo
	dw_1z.GroupCalc ( )

   
  
end if

if (rb_2x.checked=TRUE) then
	// Ordenamiento por Tipo de Salon
   dw_1x.setsort("horario_clase_aula A, salon_cve_salon A, horario_cve_dia A, horario_hora_inicio A A")
	dw_1x.sort()
	// Se recalcula el grupo
	dw_1x.GroupCalc ( )

   dw_1z.setsort("horario_clase_aula A, salon_cve_salon A, horario_cve_dia A, horario_hora_inicio A ")
	dw_1z.sort()
	// Se recalcula el grupo
	dw_1z.GroupCalc ( )

	
end if

if (rb_3x.checked=TRUE) then
	// Ordenamiento por Capacidad del Salón
   dw_1x.setsort("salon_cupo A, salon_cve_salon A, horario_cve_dia A, horario_hora_inicio A ")
	dw_1x.sort()
	// Se recalcula el grupo
	dw_1x.GroupCalc ( )

   dw_1z.setsort("salon_cupo A, salon_cve_salon A, horario_cve_dia A, horario_hora_inicio A ")
	dw_1z.sort()
	// Se recalcula el grupo
	dw_1z.GroupCalc ( )

	
end if

if dw_1z.rowcount() > 0 then
	dw_1z.scrolltorow(1)
	dw_1x.scrolltorow(1)
end if
end event

event constructor;TabOrder = 0
end event

type rb_3x from radiobutton within w_mad_repo_18
integer x = 2144
integer y = 300
integer width = 645
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Por Capacidad"
boolean lefttext = true
end type

type rb_2x from radiobutton within w_mad_repo_18
event constructor pbm_constructor
event clicked pbm_bnclicked
integer x = 2144
integer y = 196
integer width = 645
integer height = 88
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Por Tipo de Salón"
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type rb_1x from radiobutton within w_mad_repo_18
event constructor pbm_constructor
integer x = 2144
integer y = 120
integer width = 645
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Por Cve. de Salón"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type em_1 from editmask within w_mad_repo_18
event constructor pbm_constructor
event modified pbm_enmodified
boolean visible = false
integer x = 841
integer y = 112
integer width = 219
integer height = 80
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
string displaydata = "`"
end type

event constructor;TabOrder = 0

int periodo,anio


periodo_actual(periodo,anio,gtr_sce)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño

CHOOSE CASE periodo
	CASE 0
		periodo_x = 0
		rb_11.checked = TRUE
	CASE 1
		periodo_x = 1
      rb_12.checked = TRUE
	CASE 2
		periodo_x = 2
      rb_13.checked = TRUE

END CHOOSE
this.text = string(anio)
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type rb_13 from radiobutton within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 1563
integer y = 248
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

event constructor;TabOrder = 0
end event

type rb_12 from radiobutton within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 1207
integer y = 248
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

event constructor;TabOrder = 0
end event

type rb_11 from radiobutton within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 823
integer y = 248
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

event constructor;TabOrder = 0
end event

type cbx_3 from checkbox within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 462
integer y = 108
integer width = 270
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Lab."
boolean checked = true
boolean lefttext = true
end type

event clicked;If (this.checked = TRUE) and (cbx_2.checked = TRUE) and (cbx_1.checked = TRUE)and (cbx_4.checked = TRUE) then
  	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type cbx_4 from checkbox within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 462
integer y = 200
integer width = 270
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Otros"
boolean checked = true
boolean lefttext = true
end type

event clicked;If (this.checked = TRUE) and (cbx_2.checked = TRUE) and (cbx_3.checked = TRUE)and (cbx_1.checked = TRUE) then
  	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type cbx_5 from checkbox within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 251
integer y = 292
integer width = 288
integer height = 72
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "TODOS"
boolean checked = true
end type

event clicked;
If (this.checked = TRUE) then
	cbx_1.enabled = FALSE
	cbx_2.enabled = FALSE
	cbx_3.enabled = FALSE
	cbx_4.enabled = FALSE
	
	cbx_1.checked = TRUE
	cbx_2.checked = TRUE
	cbx_3.checked = TRUE
	cbx_4.checked = TRUE
	
else
	cbx_1.enabled = TRUE
	cbx_2.enabled = TRUE
	cbx_3.enabled = TRUE
	cbx_4.enabled = TRUE
  	cbx_1.checked = FALSE
	cbx_2.checked = FALSE
	cbx_3.checked = FALSE
	cbx_4.checked = FALSE

end if

end event

event constructor;TabOrder = 0
end event

type cbx_2 from checkbox within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 69
integer y = 200
integer width = 247
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Taller"
boolean checked = true
end type

event clicked;If (this.checked = TRUE) and (cbx_1.checked = TRUE) and (cbx_3.checked = TRUE)and (cbx_4.checked = TRUE) then
	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type cbx_1 from checkbox within w_mad_repo_18
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 69
integer y = 108
integer width = 247
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Salón"
boolean checked = true
end type

event clicked;If (this.checked = TRUE) and (cbx_2.checked = TRUE) and (cbx_3.checked = TRUE)and (cbx_4.checked = TRUE) then
	cbx_5.checked = TRUE
	cbx_5. EVENT clicked()
end if
end event

event constructor;TabOrder = 0
enabled=FALSE
end event

type dw_1x from datawindow within w_mad_repo_18
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 80
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_repo_mad7.dw = this
end event

type gb_8 from groupbox within w_mad_repo_18
integer x = 3355
integer y = 168
integer width = 320
integer height = 184
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_9 from groupbox within w_mad_repo_18
integer x = 2903
integer y = 172
integer width = 334
integer height = 172
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_mad_repo_18
boolean visible = false
integer x = 795
integer y = 52
integer width = 315
integer height = 160
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within w_mad_repo_18
integer x = 41
integer y = 56
integer width = 709
integer height = 332
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Salones"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_mad_repo_18
integer x = 2126
integer y = 56
integer width = 695
integer height = 332
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Ordenamiento"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_mad_repo_18
integer width = 3735
integer height = 428
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

type uo_periodos from uo_per_ani within w_mad_repo_18
integer x = 841
integer y = 140
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
end type

on uo_periodos.destroy
call uo_per_ani::destroy
end on

