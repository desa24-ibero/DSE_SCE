$PBExportHeader$w_mad_repo_16_17.srw
$PBExportComments$Ventana para el Reporte de los Alumnos que pueden cursar el Servicio Social. Y de la posible Demanda del servicio Social
forward
global type w_mad_repo_16_17 from window
end type
type tab_1 from tab within w_mad_repo_16_17
end type
type tabpage_pueden_cursar from userobject within tab_1
end type
type st_7 from statictext within tabpage_pueden_cursar
end type
type st_6 from statictext within tabpage_pueden_cursar
end type
type st_5 from statictext within tabpage_pueden_cursar
end type
type dw_2y from datawindow within tabpage_pueden_cursar
end type
type dw_2x from datawindow within tabpage_pueden_cursar
end type
type dw_2z from datawindow within tabpage_pueden_cursar
end type
type cb_1 from commandbutton within tabpage_pueden_cursar
end type
type cb_5x from commandbutton within tabpage_pueden_cursar
end type
type cbx_2x from checkbox within tabpage_pueden_cursar
end type
type rb_2x from radiobutton within tabpage_pueden_cursar
end type
type rb_1x from radiobutton within tabpage_pueden_cursar
end type
type st_1 from statictext within tabpage_pueden_cursar
end type
type gb_6 from groupbox within tabpage_pueden_cursar
end type
type gb_3 from groupbox within tabpage_pueden_cursar
end type
type gb_5 from groupbox within tabpage_pueden_cursar
end type
type gb_4 from groupbox within tabpage_pueden_cursar
end type
type gb_2 from groupbox within tabpage_pueden_cursar
end type
type gb_1 from groupbox within tabpage_pueden_cursar
end type
type tabpage_pueden_cursar from userobject within tab_1
st_7 st_7
st_6 st_6
st_5 st_5
dw_2y dw_2y
dw_2x dw_2x
dw_2z dw_2z
cb_1 cb_1
cb_5x cb_5x
cbx_2x cbx_2x
rb_2x rb_2x
rb_1x rb_1x
st_1 st_1
gb_6 gb_6
gb_3 gb_3
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
end type
type tabpage_posible_demanda from userobject within tab_1
end type
type st_4 from statictext within tabpage_posible_demanda
end type
type st_3 from statictext within tabpage_posible_demanda
end type
type st_2 from statictext within tabpage_posible_demanda
end type
type cb_2 from commandbutton within tabpage_posible_demanda
end type
type dw_1y from datawindow within tabpage_posible_demanda
end type
type dw_1x from datawindow within tabpage_posible_demanda
end type
type dw_1z from datawindow within tabpage_posible_demanda
end type
type st_1x from statictext within tabpage_posible_demanda
end type
type cb_3 from commandbutton within tabpage_posible_demanda
end type
type rb_20 from radiobutton within tabpage_posible_demanda
end type
type rb_10 from radiobutton within tabpage_posible_demanda
end type
type gb_15 from groupbox within tabpage_posible_demanda
end type
type gb_14 from groupbox within tabpage_posible_demanda
end type
type gb_13 from groupbox within tabpage_posible_demanda
end type
type gb_12 from groupbox within tabpage_posible_demanda
end type
type gb_11 from groupbox within tabpage_posible_demanda
end type
type tabpage_posible_demanda from userobject within tab_1
st_4 st_4
st_3 st_3
st_2 st_2
cb_2 cb_2
dw_1y dw_1y
dw_1x dw_1x
dw_1z dw_1z
st_1x st_1x
cb_3 cb_3
rb_20 rb_20
rb_10 rb_10
gb_15 gb_15
gb_14 gb_14
gb_13 gb_13
gb_12 gb_12
gb_11 gb_11
end type
type tabpage_posible_demanda_b from userobject within tab_1
end type
type dw_3y from datawindow within tabpage_posible_demanda_b
end type
type st_3x from statictext within tabpage_posible_demanda_b
end type
type st_10 from statictext within tabpage_posible_demanda_b
end type
type st_8 from statictext within tabpage_posible_demanda_b
end type
type gb_32 from groupbox within tabpage_posible_demanda_b
end type
type gb_31 from groupbox within tabpage_posible_demanda_b
end type
type gb_33 from groupbox within tabpage_posible_demanda_b
end type
type dw_3x from datawindow within tabpage_posible_demanda_b
end type
type cb_4 from commandbutton within tabpage_posible_demanda_b
end type
type tabpage_posible_demanda_b from userobject within tab_1
dw_3y dw_3y
st_3x st_3x
st_10 st_10
st_8 st_8
gb_32 gb_32
gb_31 gb_31
gb_33 gb_33
dw_3x dw_3x
cb_4 cb_4
end type
type tab_1 from tab within w_mad_repo_16_17
tabpage_pueden_cursar tabpage_pueden_cursar
tabpage_posible_demanda tabpage_posible_demanda
tabpage_posible_demanda_b tabpage_posible_demanda_b
end type
end forward

global type w_mad_repo_16_17 from window
integer x = 832
integer y = 364
integer width = 3639
integer height = 2140
boolean titlebar = true
string title = "Reportes del Servicio Social"
string menuname = "m_repo_mad3"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
tab_1 tab_1
end type
global w_mad_repo_16_17 w_mad_repo_16_17

type variables
int agrupa
end variables

on w_mad_repo_16_17.create
if this.MenuName = "m_repo_mad3" then this.MenuID = create m_repo_mad3
this.tab_1=create tab_1
this.Control[]={this.tab_1}
end on

on w_mad_repo_16_17.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
tab_1.tabpage_pueden_cursar.dw_2x.settransobject(gtr_sce)
tab_1.tabpage_pueden_cursar.dw_2z.settransobject(gtr_sce)
tab_1.tabpage_pueden_cursar.dw_2y.settransobject(gtr_sce)

tab_1.tabpage_posible_demanda.dw_1y.settransobject(gtr_sce)
tab_1.tabpage_posible_demanda.dw_1z.settransobject(gtr_sce)
tab_1.tabpage_posible_demanda.dw_1x.settransobject(gtr_sce)

//tab_1.tabpage_posible_demanda_b.dw_3y.settransobject(gtr_sce)
//tab_1.tabpage_posible_demanda_b.dw_3z.settransobject(gtr_sce)
tab_1.tabpage_posible_demanda_b.dw_3x.settransobject(gtr_sce)


/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1
agrupa =1

///*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_repo_mad3.m_registro.m_nuevo.disable( )
m_repo_mad3.m_registro.m_actualiza.disable( )
m_repo_mad3.m_registro.m_borraregistro.disable( )

end event

type tab_1 from tab within w_mad_repo_16_17
integer y = 12
integer width = 3607
integer height = 1852
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean fixedwidth = true
boolean raggedright = true
boolean focusonbuttondown = true
boolean powertips = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_pueden_cursar tabpage_pueden_cursar
tabpage_posible_demanda tabpage_posible_demanda
tabpage_posible_demanda_b tabpage_posible_demanda_b
end type

on tab_1.create
this.tabpage_pueden_cursar=create tabpage_pueden_cursar
this.tabpage_posible_demanda=create tabpage_posible_demanda
this.tabpage_posible_demanda_b=create tabpage_posible_demanda_b
this.Control[]={this.tabpage_pueden_cursar,&
this.tabpage_posible_demanda,&
this.tabpage_posible_demanda_b}
end on

on tab_1.destroy
destroy(this.tabpage_pueden_cursar)
destroy(this.tabpage_posible_demanda)
destroy(this.tabpage_posible_demanda_b)
end on

event selectionchanged;/* Se asignan los datawindows dependiendo del TAB al menu, para poder imprimirlos */
if newindex = 1 then
	 m_repo_mad3.dw = tab_1.tabpage_pueden_cursar.dw_2x
    m_repo_mad3.dw2 = tab_1.tabpage_pueden_cursar.dw_2y
	 tab_1.tabpage_pueden_cursar.gb_1.taborder =0
	 tab_1.tabpage_pueden_cursar.gb_2.taborder =0
	 tab_1.tabpage_pueden_cursar.gb_3.taborder =0
	 tab_1.tabpage_pueden_cursar.gb_4.taborder =0
	 tab_1.tabpage_pueden_cursar.gb_5.taborder =0
	 tab_1.tabpage_pueden_cursar.gb_6.taborder =0
//	 tab_1.tabpage_pueden_cursar.gb_7.taborder =0
//	 tab_1.tabpage_pueden_cursar.gb_8.taborder =0
//	 tab_1.tabpage_pueden_cursar.gb_9.taborder =0
//	 tab_1.tabpage_pueden_cursar.gb_10.taborder =0
//	 
end if
if newindex = 2 then
	 m_repo_mad3.dw = tab_1.tabpage_posible_demanda.dw_1x
    m_repo_mad3.dw2 = tab_1.tabpage_posible_demanda.dw_1y
	 tab_1.tabpage_posible_demanda.gb_11.taborder=0
 	 tab_1.tabpage_posible_demanda.gb_12.taborder=0
  	 tab_1.tabpage_posible_demanda.gb_13.taborder=0
	 tab_1.tabpage_posible_demanda.gb_14.taborder=0
	 tab_1.tabpage_posible_demanda.gb_15.taborder=0
//	 tab_1.tabpage_posible_demanda.gb_16.taborder=0
//	 tab_1.tabpage_posible_demanda.gb_17.taborder=0
//	 tab_1.tabpage_posible_demanda.gb_18.taborder=0
 	
end if

if newindex = 3 then
	 m_repo_mad3.dw = tab_1.tabpage_posible_demanda_b.dw_3x
    m_repo_mad3.dw2 = tab_1.tabpage_posible_demanda_b.dw_3y
	 tab_1.tabpage_posible_demanda_b.gb_31.taborder=0
 	 tab_1.tabpage_posible_demanda_b.gb_32.taborder=0
  	 tab_1.tabpage_posible_demanda_b.gb_33.taborder=0
//	 tab_1.tabpage_posible_demanda_b.gb_24.taborder=0
//	 tab_1.tabpage_posible_demanda_b.gb_25.taborder=0
//	 tab_1.tabpage_posible_demanda_b.gb_26.taborder=0
//	 tab_1.tabpage_posible_demanda_b.gb_27.taborder=0
//	 tab_1.tabpage_posible_demanda_b.gb_28.taborder=0
 	
end if

end event

type tabpage_pueden_cursar from userobject within tab_1
integer x = 128
integer y = 16
integer width = 3461
integer height = 1820
long backcolor = 16777215
string text = "Pueden Cursar "
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom033!"
long picturemaskcolor = 79741120
st_7 st_7
st_6 st_6
st_5 st_5
dw_2y dw_2y
dw_2x dw_2x
dw_2z dw_2z
cb_1 cb_1
cb_5x cb_5x
cbx_2x cbx_2x
rb_2x rb_2x
rb_1x rb_1x
st_1 st_1
gb_6 gb_6
gb_3 gb_3
gb_5 gb_5
gb_4 gb_4
gb_2 gb_2
gb_1 gb_1
end type

on tabpage_pueden_cursar.create
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.dw_2y=create dw_2y
this.dw_2x=create dw_2x
this.dw_2z=create dw_2z
this.cb_1=create cb_1
this.cb_5x=create cb_5x
this.cbx_2x=create cbx_2x
this.rb_2x=create rb_2x
this.rb_1x=create rb_1x
this.st_1=create st_1
this.gb_6=create gb_6
this.gb_3=create gb_3
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.st_7,&
this.st_6,&
this.st_5,&
this.dw_2y,&
this.dw_2x,&
this.dw_2z,&
this.cb_1,&
this.cb_5x,&
this.cbx_2x,&
this.rb_2x,&
this.rb_1x,&
this.st_1,&
this.gb_6,&
this.gb_3,&
this.gb_5,&
this.gb_4,&
this.gb_2,&
this.gb_1}
end on

on tabpage_pueden_cursar.destroy
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.dw_2y)
destroy(this.dw_2x)
destroy(this.dw_2z)
destroy(this.cb_1)
destroy(this.cb_5x)
destroy(this.cbx_2x)
destroy(this.rb_2x)
destroy(this.rb_1x)
destroy(this.st_1)
destroy(this.gb_6)
destroy(this.gb_3)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type st_7 from statictext within tabpage_pueden_cursar
integer x = 41
integer y = 244
integer width = 837
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "y pueden cursar el Serv. Social"
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type st_6 from statictext within tabpage_pueden_cursar
integer x = 41
integer y = 180
integer width = 805
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "cumplen con los créditos min."
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type st_5 from statictext within tabpage_pueden_cursar
integer x = 41
integer y = 116
integer width = 805
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Reporte de los Alumnos que "
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type dw_2y from datawindow within tabpage_pueden_cursar
integer x = 1591
integer y = 1936
integer width = 983
integer height = 400
integer taborder = 8
string dataobject = "dw_repo_mad_16_gy"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

type dw_2x from datawindow within tabpage_pueden_cursar
integer x = 73
integer y = 1892
integer width = 731
integer height = 372
integer taborder = 7
string dataobject = "dw_repo_mad_16_gx"
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

event retrieveend;// Se coloca el Periodo en la impresión

int periodo,anio
string periodo_2

//periodo_actual(periodo,anio,gtr_sce)
//
//CHOOSE CASE periodo
//	CASE 0
//		periodo = 1
//	CASE 1
//		periodo = 2
//	CASE 2
//		periodo = 0
//		anio = anio +1
//
//END CHOOSE

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodo_activo( periodo, anio,gs_tipo_periodo,gtr_sce)

luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN luo_periodo_servicios.ierror
END IF	

this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
dw_2y.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)

/*
CHOOSE CASE periodo
	CASE 0
		periodo_2="Primavera"
	CASE 1
		periodo_2="Verano"
	CASE 2
		periodo_2="Otoño"

END CHOOSE
*/

this.object.st_periodo.text="Alumnos que ya cursaron el mínimo de Créditos para Inscribir el Servicio Social en : "+periodo_2+" - "+string(anio)
dw_2y.object.st_periodo.text="Alumnos que ya cursaron el mínimo de Créditos para Inscribir el Servicio Social en : "+periodo_2+" - "+string(anio)


end event

type dw_2z from datawindow within tabpage_pueden_cursar
integer y = 348
integer width = 3433
integer height = 1468
integer taborder = 6
string dataobject = "dw_repo_mad_16_gz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

string Cont
setpointer(Hourglass!)
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(rowcount)
	st_1.text='Total : '+Cont
else
	st_1.text='Total : '+Cont
end if


end event

event constructor;taborder = 0
end event

type cb_1 from commandbutton within tabpage_pueden_cursar
integer x = 2880
integer y = 204
integer width = 247
integer height = 92
integer taborder = 5
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;// Se limpian los datawindows
		dw_2x.Reset() 
		dw_2z.Reset()
		dw_2y.Reset()

dw_2x.retrieve(agrupa)
dw_2z.retrieve(agrupa)
dw_2y.retrieve(agrupa)
// Se Ordenan deacuerdo a los criterios establecidos
cb_5x.triggerevent("clicked") 
end event

event constructor;TabOrder = 2


end event

type cb_5x from commandbutton within tabpage_pueden_cursar
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2217
integer y = 148
integer width = 270
integer height = 96
integer taborder = 4
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
	// Ordenamiento por Alumno
   dw_2x.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
	dw_2x.sort()
	// Se recalcula el grupo
	dw_2x.GroupCalc ( )

   dw_2z.setsort("alumnos_nombre_completo A, academicos_cve_carrera A")
	dw_2z.sort()
	// Se recalcula el grupo
	dw_2z.GroupCalc ( )


   if (cbx_2x.checked=TRUE) then
      dw_2x.setsort("academicos_cve_carrera A, alumnos_nombre_completo A")
		dw_2x.sort()
		// Se recalcula el grupo
		dw_2x.GroupCalc ( )

      dw_2z.setsort("academicos_cve_carrera A, alumnos_nombre_completo A")
		dw_2z.sort()
		// Se recalcula el grupo
		dw_2z.GroupCalc ( )

	end if		
end if

if (rb_2x.checked=TRUE) then
	// Ordenamiento por Cuenta
   dw_2x.setsort("academicos_cuenta A")
	dw_2x.sort()
	// Se recalcula el grupo
	dw_2x.GroupCalc ( )

   dw_2z.setsort("academicos_cuenta A")
	dw_2z.sort()
	// Se recalcula el grupo
	dw_2z.GroupCalc ( )

	if (cbx_2x.checked=TRUE) then
      dw_2x.setsort("academicos_cve_carrera A, academicos_cuenta A")
		dw_2x.sort()
		// Se recalcula el grupo
		dw_2x.GroupCalc ( )

	   dw_2z.setsort("academicos_cve_carrera A, academicos_cuenta A")
		dw_2z.sort()
		// Se recalcula el grupo
		dw_2z.GroupCalc ( )

	end if	
	
end if

end event

event constructor;TabOrder = 3

end event

type cbx_2x from checkbox within tabpage_pueden_cursar
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1481
integer y = 164
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Agrup. por Carrera "
boolean checked = true
end type

event clicked;
// Se cambia la opción de Agrupación 

if (this.checked = TRUE) then
    agrupa = 1    // CON Agrupación
else
	 agrupa = 2    // SIN Agrupación
end if
end event

event constructor;TabOrder = 1
end event

type rb_2x from radiobutton within tabpage_pueden_cursar
event constructor pbm_constructor
event clicked pbm_bnclicked
integer x = 997
integer y = 220
integer width = 343
integer height = 68
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cuenta"
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type rb_1x from radiobutton within tabpage_pueden_cursar
event constructor pbm_constructor
integer x = 997
integer y = 160
integer width = 343
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Alfabético"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type st_1 from statictext within tabpage_pueden_cursar
event constructor pbm_constructor
integer x = 2629
integer y = 60
integer width = 731
integer height = 76
integer textsize = -9
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

event constructor;TabOrder = 0
end event

type gb_6 from groupbox within tabpage_pueden_cursar
integer x = 18
integer y = 44
integer width = 869
integer height = 288
integer taborder = 4
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Descripción:"
end type

type gb_3 from groupbox within tabpage_pueden_cursar
integer x = 2834
integer y = 156
integer width = 334
integer height = 156
integer taborder = 5
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tabpage_pueden_cursar
integer x = 2181
integer y = 96
integer width = 334
integer height = 172
integer taborder = 4
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_pueden_cursar
integer x = 1463
integer y = 124
integer width = 617
integer height = 128
integer taborder = 3
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_pueden_cursar
integer x = 933
integer y = 96
integer width = 466
integer height = 204
integer taborder = 2
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Ordenamiento"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_pueden_cursar
integer width = 3438
integer height = 348
integer taborder = 4
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type tabpage_posible_demanda from userobject within tab_1
integer x = 128
integer y = 16
integer width = 3461
integer height = 1820
string text = "Posible Demanda"
long tabtextcolor = 33554432
long tabbackcolor = 12639424
string picturename = "NestedReturn!"
long picturemaskcolor = 79741120
st_4 st_4
st_3 st_3
st_2 st_2
cb_2 cb_2
dw_1y dw_1y
dw_1x dw_1x
dw_1z dw_1z
st_1x st_1x
cb_3 cb_3
rb_20 rb_20
rb_10 rb_10
gb_15 gb_15
gb_14 gb_14
gb_13 gb_13
gb_12 gb_12
gb_11 gb_11
end type

on tabpage_posible_demanda.create
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.cb_2=create cb_2
this.dw_1y=create dw_1y
this.dw_1x=create dw_1x
this.dw_1z=create dw_1z
this.st_1x=create st_1x
this.cb_3=create cb_3
this.rb_20=create rb_20
this.rb_10=create rb_10
this.gb_15=create gb_15
this.gb_14=create gb_14
this.gb_13=create gb_13
this.gb_12=create gb_12
this.gb_11=create gb_11
this.Control[]={this.st_4,&
this.st_3,&
this.st_2,&
this.cb_2,&
this.dw_1y,&
this.dw_1x,&
this.dw_1z,&
this.st_1x,&
this.cb_3,&
this.rb_20,&
this.rb_10,&
this.gb_15,&
this.gb_14,&
this.gb_13,&
this.gb_12,&
this.gb_11}
end on

on tabpage_posible_demanda.destroy
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.dw_1y)
destroy(this.dw_1x)
destroy(this.dw_1z)
destroy(this.st_1x)
destroy(this.cb_3)
destroy(this.rb_20)
destroy(this.rb_10)
destroy(this.gb_15)
destroy(this.gb_14)
destroy(this.gb_13)
destroy(this.gb_12)
destroy(this.gb_11)
end on

type st_4 from statictext within tabpage_posible_demanda
integer x = 55
integer y = 240
integer width = 1065
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "cursar el Servicio Social."
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type st_3 from statictext within tabpage_posible_demanda
integer x = 55
integer y = 176
integer width = 1065
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "todas sus materias inscritas podrían"
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type st_2 from statictext within tabpage_posible_demanda
integer x = 55
integer y = 112
integer width = 1065
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Reporte de los alumnos que acreditando"
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type cb_2 from commandbutton within tabpage_posible_demanda
integer x = 2843
integer y = 188
integer width = 274
integer height = 108
integer taborder = 5
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;
setpointer(Hourglass!)

// Se limpian los Datawindows
dw_1x.Reset() 
dw_1z.Reset() 
dw_1y.Reset() 

	// Se traen los datos al datawindow, Agrupa_2 = 1 ---- CON Agrupación de Carrera
	//                                   Agrupa_2 = 2 ---- SIN Agrupación de Carrera
	dw_1x.retrieve()
	dw_1z.retrieve()
	dw_1y.retrieve()
	
	// Se Ordenan los Datos de acuerdo a los criterios establecidos
   cb_3.triggerevent("clicked") 


end event

event constructor;TabOrder = 1
end event

type dw_1y from datawindow within tabpage_posible_demanda
integer x = 891
integer y = 1980
integer width = 1531
integer height = 416
integer taborder = 9
string dataobject = "dw_repo_mad_17_gy"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;long Cuantos 
Cuantos = dw_1y.object.cuantos_hay[1]

/*Cuando dw_1 termine de leer los datos de la tabla...*/

st_1x.text='Total : '+string(Cuantos)	

end event

event constructor;TabOrder = 0
end event

type dw_1x from datawindow within tabpage_posible_demanda
integer x = 87
integer y = 1964
integer width = 494
integer height = 364
integer taborder = 8
string dataobject = "dw_repo_mad_17_gx"
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

event retrieveend;// Se coloca el Periodo en la impresión

int periodo,anio
string periodo_2

//periodo_actual(periodo,anio,gtr_sce)
//
//CHOOSE CASE periodo
//	CASE 0
//		periodo = 1
//	CASE 1
//		periodo = 2
//	CASE 2
//		periodo = 0
//		anio = anio +1
//END CHOOSE

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodo_activo(periodo, anio, gs_tipo_periodo, gtr_sce)

luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN luo_periodo_servicios.ierror
END IF	

this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
dw_1y.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)

/*
CHOOSE CASE periodo
	CASE 0
		periodo_2="Primavera"
	CASE 1
		periodo_2="Verano"
	CASE 2
		periodo_2="Otoño"

END CHOOSE
*/

this.object.st_periodo.text="Alumnos Potenciales que podrían cursar el Servicio Social en : "+periodo_2+" - "+string(anio)
dw_1y.object.st_periodo.text="Alumnos Potenciales que podrían cursar el Servicio Social en : "+periodo_2+" - "+string(anio)
end event

type dw_1z from datawindow within tabpage_posible_demanda
integer y = 352
integer width = 3433
integer height = 1468
integer taborder = 8
string dataobject = "dw_repo_mad_17_gz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;///*Cuando dw_1 termine de leer los datos de la tabla...*/
//
//
//string Cont
//Cont = '0'
///*Verifica si se bajo más de un dato*/
//if rowcount >= 1 then
//	// Se actualiza el numero de datos traidos
//	Cont =string(rowcount)
//	st_1x.text='Total : '+Cont	
//else
//	st_1x.text='Total : '+Cont
//
//end if
//
end event

event constructor;taborder = 0
end event

type st_1x from statictext within tabpage_posible_demanda
event constructor pbm_constructor
integer x = 2587
integer y = 68
integer width = 736
integer height = 76
integer textsize = -9
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

event constructor;TabOrder = 0
end event

type cb_3 from commandbutton within tabpage_posible_demanda
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1883
integer y = 156
integer width = 274
integer height = 108
integer taborder = 7
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordenar"
end type

event clicked;setpointer(Hourglass!)
/* Se verifica que opcion de Ordenamiento que se requiere por medio de los checks*/

if (rb_10.checked=TRUE) then
	// Ordenamiento por Alumno
   dw_1x.setsort("academicos_cve_carrera A,alumnos_nombre_completo A ")
	dw_1x.sort()
	// Se recalcula el grupo
	dw_1x.GroupCalc ( )

   dw_1z.setsort("academicos_cve_carrera A,alumnos_nombre_completo A")
	dw_1z.sort()
	// Se recalcula el grupo
	dw_1z.GroupCalc ( )

end if

if (rb_20.checked=TRUE) then
	// Ordenamiento por Cuenta
   dw_1x.setsort("academicos_cve_carrera A,academicos_cuenta A")
	dw_1x.sort()
	// Se recalcula el grupo
	dw_1x.GroupCalc ( )

   dw_1z.setsort("academicos_cve_carrera A,academicos_cuenta A")
	dw_1z.sort()
	// Se recalcula el grupo
	dw_1z.GroupCalc ( )
	
end if

end event

event constructor;TabOrder = 2
end event

type rb_20 from radiobutton within tabpage_posible_demanda
event constructor pbm_constructor
event clicked pbm_bnclicked
integer x = 1317
integer y = 208
integer width = 343
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Cuenta"
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type rb_10 from radiobutton within tabpage_posible_demanda
event constructor pbm_constructor
integer x = 1317
integer y = 144
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Alfabético"
boolean checked = true
boolean lefttext = true
end type

event constructor;TabOrder = 0
end event

type gb_15 from groupbox within tabpage_posible_demanda
integer x = 23
integer y = 48
integer width = 1125
integer height = 272
integer taborder = 5
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Descripción :"
end type

type gb_14 from groupbox within tabpage_posible_demanda
integer x = 2816
integer y = 140
integer width = 325
integer height = 180
integer taborder = 5
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_13 from groupbox within tabpage_posible_demanda
integer x = 1856
integer y = 100
integer width = 325
integer height = 180
integer taborder = 7
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_12 from groupbox within tabpage_posible_demanda
integer x = 1243
integer y = 76
integer width = 503
integer height = 228
integer taborder = 6
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = " Ordenamiento"
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within tabpage_posible_demanda
integer width = 3438
integer height = 352
integer taborder = 6
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type tabpage_posible_demanda_b from userobject within tab_1
integer x = 128
integer y = 16
integer width = 3461
integer height = 1820
string text = "Posible Demanda ~"B~""
long tabtextcolor = 33554432
long tabbackcolor = 15793151
long picturemaskcolor = 536870912
dw_3y dw_3y
st_3x st_3x
st_10 st_10
st_8 st_8
gb_32 gb_32
gb_31 gb_31
gb_33 gb_33
dw_3x dw_3x
cb_4 cb_4
end type

on tabpage_posible_demanda_b.create
this.dw_3y=create dw_3y
this.st_3x=create st_3x
this.st_10=create st_10
this.st_8=create st_8
this.gb_32=create gb_32
this.gb_31=create gb_31
this.gb_33=create gb_33
this.dw_3x=create dw_3x
this.cb_4=create cb_4
this.Control[]={this.dw_3y,&
this.st_3x,&
this.st_10,&
this.st_8,&
this.gb_32,&
this.gb_31,&
this.gb_33,&
this.dw_3x,&
this.cb_4}
end on

on tabpage_posible_demanda_b.destroy
destroy(this.dw_3y)
destroy(this.st_3x)
destroy(this.st_10)
destroy(this.st_8)
destroy(this.gb_32)
destroy(this.gb_31)
destroy(this.gb_33)
destroy(this.dw_3x)
destroy(this.cb_4)
end on

type dw_3y from datawindow within tabpage_posible_demanda_b
integer x = 114
integer y = 1924
integer width = 494
integer height = 364
integer taborder = 10
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

type st_3x from statictext within tabpage_posible_demanda_b
integer x = 2592
integer y = 64
integer width = 690
integer height = 76
integer textsize = -9
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

event constructor;TabOrder = 0
end event

type st_10 from statictext within tabpage_posible_demanda_b
integer x = 27
integer y = 172
integer width = 1605
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "y que podrian ser posibles candidatos a inscribirla de nuevo."
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type st_8 from statictext within tabpage_posible_demanda_b
integer x = 32
integer y = 108
integer width = 1513
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 12632256
boolean enabled = false
string text = "Reporte de los Alumnos, que adeudan el Servicio Social "
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;TabOrder = 0
end event

type gb_32 from groupbox within tabpage_posible_demanda_b
integer x = 1952
integer y = 44
integer width = 306
integer height = 164
integer taborder = 6
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_31 from groupbox within tabpage_posible_demanda_b
integer x = 18
integer y = 44
integer width = 1637
integer height = 212
integer taborder = 5
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Descripción :"
end type

type gb_33 from groupbox within tabpage_posible_demanda_b
integer x = 5
integer width = 3442
integer height = 276
integer taborder = 6
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type dw_3x from datawindow within tabpage_posible_demanda_b
integer x = 5
integer y = 284
integer width = 3438
integer height = 1524
integer taborder = 9
string dataobject = "dw_repo_mad_17_gx_ext"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event retrieveend;// Se coloca el Periodo en la impresión

int periodo,anio
string periodo_2

//periodo_actual(periodo,anio,gtr_sce)
//
//CHOOSE CASE periodo
//	CASE 0
//		periodo = 1
//	CASE 1
//		periodo = 2
//	CASE 2
//		periodo = 0
//		anio = anio +1
//
//END CHOOSE

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodo_activo( periodo, anio, gs_tipo_periodo, gtr_sce)

luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
periodo_2 = luo_periodo_servicios.f_recupera_descripcion(periodo , "L")

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN luo_periodo_servicios.ierror
END IF	

this.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)
//dw_3y.object.st_periodo.text="Periodo Actual: "+periodo_2+" - "+string(anio)

/*
CHOOSE CASE periodo
	CASE 0
		periodo_2="Primavera"
	CASE 1
		periodo_2="Verano"
	CASE 2
		periodo_2="Otoño"

END CHOOSE
*/

this.object.st_periodo.text="Alumnos Potenciales que adeudan el Serv. Social, pero que podrían cursarlo en : "+periodo_2+" - "+string(anio)
//dw_1y.object.st_periodo.text="Alumnos Potenciales que adeudan el Serv. Social en : "+periodo_2+" - "+string(anio)

end event

event constructor;TabOrder = 0
end event

type cb_4 from commandbutton within tabpage_posible_demanda_b
event filtra ( )
event ordena ( )
integer x = 1984
integer y = 92
integer width = 247
integer height = 96
integer taborder = 6
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event filtra;long Hist_Mat,Hist_Cal,Materia
long Total,OffSet,Cont,Cuenta

Total = dw_3x.rowcount()
if total > 0 then
	Cont = 1
	DO UNTIL Cont >= Total
	Cuenta  = dw_3x.GetItemNumber(Cont,"academicos_cuenta")//dw_3x.object.academicos_cuenta[Cont]
	Materia = dw_3x.GetItemNumber(Cont,"historico_cve_mat")//dw_3x.object.historico_cve_mat[Cont]

	  SELECT historico.cve_mat,   
	         historico.calificacion  
	    INTO :Hist_Mat,
				:Hist_Cal
	    FROM historico  
	   WHERE ( historico.cuenta = :Cuenta) AND  
		      ( historico.cve_mat = :Materia ) AND  
	         ( historico.calificacion = "AC" )    using gtr_sce;

		if gtr_sce.SQLCode = 100 then
			/* Not found*/
			Cont ++
		else
			/* Maybe I found something */
			dw_3x.DeleteRow(Cont) 
			Total = dw_3x.rowcount()
			OffSet = Cont
			if Cont = 1 then
				Cont = 1
			else
 		  		Cont = OffSet
			end if
		end if
	st_3x.text='Total : '+string(Total)	
	LOOP
end if


end event

event ordena;dw_3x.setsort("academicos_cve_plan A,academicos_cve_carrera A, alumnos_nombre_completo A")
dw_3x.sort()
		// Se recalcula el grupo
dw_3x.GroupCalc ( )
end event

event clicked;long mat,Cont
int Materias[]

setpointer(Hourglass!)
dw_3x.Reset()
st_3x.text='Total : 0'

DECLARE MIO CURSOR FOR 
SELECT DISTINCT materias.cve_mat  
   FROM area_mat,   
         materias,   
         plan_estudios  
   WHERE ( plan_estudios.cve_area_servicio_social = area_mat.cve_area ) and  
			( area_mat.cve_mat = materias.cve_mat) using gtr_sce;                                     
OPEN MIO;

FETCH MIO INTO :mat;

do while gtr_sce.sqlcode <>100
	Cont ++
	Materias[Cont] = mat
	FETCH MIO INTO :mat;
loop
CLOSE MIO;

dw_3x.retrieve(Materias)
this. EVENT filtra()
this. EVENT ordena()
end event

event constructor;TabOrder = 1
end event

