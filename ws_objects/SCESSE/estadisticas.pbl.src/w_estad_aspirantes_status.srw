$PBExportHeader$w_estad_aspirantes_status.srw
forward
global type w_estad_aspirantes_status from window
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_aspirantes_status
end type
type cbx_todos_status from checkbox within w_estad_aspirantes_status
end type
type uo_status_aspirante from uo_status_aspiran within w_estad_aspirantes_status
end type
type uo_carrera from uo_carreras within w_estad_aspirantes_status
end type
type gb_status from groupbox within w_estad_aspirantes_status
end type
type gb_carreras from groupbox within w_estad_aspirantes_status
end type
type st_3 from statictext within w_estad_aspirantes_status
end type
type dw_estadisticas from datawindow within w_estad_aspirantes_status
end type
type cb_1 from commandbutton within w_estad_aspirantes_status
end type
type em_anio from editmask within w_estad_aspirantes_status
end type
type rb_otonio from radiobutton within w_estad_aspirantes_status
end type
type rb_verano from radiobutton within w_estad_aspirantes_status
end type
type rb_primavera from radiobutton within w_estad_aspirantes_status
end type
type dw_1x from datawindow within w_estad_aspirantes_status
end type
type gb_8 from groupbox within w_estad_aspirantes_status
end type
type gb_11 from groupbox within w_estad_aspirantes_status
end type
type gb_20 from groupbox within w_estad_aspirantes_status
end type
type gb_1 from groupbox within w_estad_aspirantes_status
end type
end forward

global type w_estad_aspirantes_status from window
integer width = 3662
integer height = 1960
boolean titlebar = true
string title = "Estadística de Estatus de Aspirantes"
string menuname = "m_estad_aspirantes_status"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_periodo uo_periodo
cbx_todos_status cbx_todos_status
uo_status_aspirante uo_status_aspirante
uo_carrera uo_carrera
gb_status gb_status
gb_carreras gb_carreras
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
rb_otonio rb_otonio
rb_verano rb_verano
rb_primavera rb_primavera
dw_1x dw_1x
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
end type
global w_estad_aspirantes_status w_estad_aspirantes_status

type variables
int periodo_x
end variables

on w_estad_aspirantes_status.create
if this.MenuName = "m_estad_aspirantes_status" then this.MenuID = create m_estad_aspirantes_status
this.uo_periodo=create uo_periodo
this.cbx_todos_status=create cbx_todos_status
this.uo_status_aspirante=create uo_status_aspirante
this.uo_carrera=create uo_carrera
this.gb_status=create gb_status
this.gb_carreras=create gb_carreras
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.rb_otonio=create rb_otonio
this.rb_verano=create rb_verano
this.rb_primavera=create rb_primavera
this.dw_1x=create dw_1x
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
this.Control[]={this.uo_periodo,&
this.cbx_todos_status,&
this.uo_status_aspirante,&
this.uo_carrera,&
this.gb_status,&
this.gb_carreras,&
this.st_3,&
this.dw_estadisticas,&
this.cb_1,&
this.em_anio,&
this.rb_otonio,&
this.rb_verano,&
this.rb_primavera,&
this.dw_1x,&
this.gb_8,&
this.gb_11,&
this.gb_20,&
this.gb_1}
end on

on w_estad_aspirantes_status.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo)
destroy(this.cbx_todos_status)
destroy(this.uo_status_aspirante)
destroy(this.uo_carrera)
destroy(this.gb_status)
destroy(this.gb_carreras)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.rb_otonio)
destroy(this.rb_verano)
destroy(this.rb_primavera)
destroy(this.dw_1x)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1


// Se inicializa el objeto de servicios de periodo.
//THIS.uo_semestre.f_genera_periodo("S", "H", "L", "L", "S", gtr_sce)
//THIS.uo_trimestre.f_genera_periodo("T", "H", "L", "L", "S", gtr_sce)
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "S", gtr_sce)

//**--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--**
//// Se selecciona el periodo actual por omisión.
//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios
//luo_periodo_servicios.f_carga_periodos_activos(gtr_sce)
//
//INTEGER le_pos, le_ttl_rgs
//INTEGER le_id_periodo, le_anio
//STRING ls_tipo_periodo 
//
//le_ttl_rgs =  luo_periodo_servicios.ids_periodos_activos.ROWCOUNT() 
//
//FOR le_pos = 1 TO le_ttl_rgs
//	
//	le_id_periodo = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "id_periodo") 
//	le_anio = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "anio") 
//	ls_tipo_periodo = luo_periodo_servicios.ids_periodos_activos.GETITEMSTRING(le_pos, "tipo_periodo") 
//	
//	IF ls_tipo_periodo = "S" THEN 
//		THIS.uo_semestre.f_selecciona_periodo(le_id_periodo, "L")
//	ELSE
//		THIS.uo_trimestre.f_selecciona_periodo(le_id_periodo, "L")
//	END IF
//	
//NEXT 

//**--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--**




end event

type uo_periodo from uo_periodo_variable_tipos within w_estad_aspirantes_status
event destroy ( )
integer x = 443
integer y = 100
integer width = 1134
integer height = 400
integer taborder = 110
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type cbx_todos_status from checkbox within w_estad_aspirantes_status
integer x = 2560
integer y = 160
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "TODOS"
boolean lefttext = true
end type

type uo_status_aspirante from uo_status_aspiran within w_estad_aspirantes_status
event destroy ( )
integer x = 1765
integer y = 128
integer width = 745
integer taborder = 60
boolean border = false
long backcolor = 79741120
end type

on uo_status_aspirante.destroy
call uo_status_aspiran::destroy
end on

type uo_carrera from uo_carreras within w_estad_aspirantes_status
event destroy ( )
integer x = 1760
integer y = 372
integer taborder = 30
boolean border = false
long backcolor = 79741120
end type

on uo_carrera.destroy
call uo_carreras::destroy
end on

type gb_status from groupbox within w_estad_aspirantes_status
integer x = 1723
integer y = 72
integer width = 1294
integer height = 224
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Status"
borderstyle borderstyle = styleraised!
end type

type gb_carreras from groupbox within w_estad_aspirantes_status
integer x = 1728
integer y = 312
integer width = 1294
integer height = 224
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carreras"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_estad_aspirantes_status
integer x = 3081
integer y = 76
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

type dw_estadisticas from datawindow within w_estad_aspirantes_status
integer y = 540
integer width = 3589
integer height = 1212
integer taborder = 80
string dataobject = "d_aspirantes_status"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_estad_aspirantes_status.dw= this
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	Cont = string(rowcount)
	// Se actualiza el numero de datos traidos
//	Cont =string(dw_1z.object.cuantos[1])
	st_3.text='Total : '+Cont
else
	st_3.text='Total : '+Cont
end if

end event

type cb_1 from commandbutton within w_estad_aspirantes_status
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3186
integer y = 220
integer width = 265
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;// Se recuperan los registros de la base de datos
long ll_renglon_uo
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel, li_periodo2
string ls_anio, ls_nivel[], ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor, ls_periodo2
long ll_row_carrera, ll_cve_carrera, ll_row_status, ll_cve_status
datetime ldttm_fecha_servidor

ll_row_carrera = parent.uo_carrera.dw_carreras.GetRow()
ll_cve_carrera = parent.uo_carrera.dw_carreras.object.cve_carrera[ll_row_carrera]

if cbx_todos_status.checked then
	ll_cve_status = 99
else
	ll_row_status = parent.uo_status_aspirante.dw_status.GetRow()
	ll_cve_status = parent.uo_status_aspirante.dw_status.object.status[ll_row_status]	
end if

//if rb_primavera.checked then
//	li_periodo= 0
//	ls_periodo = "Primavera"
//elseif rb_verano.checked then
//	li_periodo= 1
//	ls_periodo = "Verano"
//elseif rb_otonio.checked then
//	li_periodo= 2	
//	ls_periodo = "Otoño"
//else
//	MessageBox("Error", "Es necesario seleccionar un Periodo", StopSign!)
//	return
//end if

//**--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--**
//PARENT.uo_semestre.f_recupera_periodo(li_periodo, ls_periodo)
//IF PARENT.uo_semestre.ierror < 0 THEN 
//	MessageBox("Error", PARENT.uo_semestre.imensaje, StopSign!)
//	RETURN 
//ELSE
//	ls_periodo_elegido = ls_periodo
//END IF
//
//PARENT.uo_trimestre.f_recupera_periodo(li_periodo2, ls_periodo2)
//IF PARENT.uo_trimestre.ierror < 0 THEN 
//	MessageBox("Error", PARENT.uo_trimestre.imensaje, StopSign!)
//	RETURN 
//ELSE
//	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
//	ls_periodo_elegido = ls_periodo_elegido + ls_periodo2
//END IF
//**--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--**

//**--****--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--****--**
INTEGER le_index
INTEGER le_periodo[]

PARENT.uo_periodo.of_recupera_periodos()

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
	ls_periodo_elegido = ls_periodo_elegido + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
NEXT 
//**--****--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--****--**



ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

//ls_periodo_elegido =ls_periodo +" "+ ls_anio
ls_periodo_elegido =ls_periodo_elegido +" "+ ls_anio

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

//**--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--**
//STRING ls_query
//STRING ls_periodos
//STRING ls_coma
//
//IF li_periodo >= 0 THEN 
//	ls_periodos = STRING(li_periodo)
//	ls_coma = ", " 
//END IF
//
//IF NOT ISNULL(li_periodo2) THEN 
//	ls_periodos = ls_periodos + ls_coma + STRING(li_periodo2) 
//END IF
//
//
//// Se modifica la cadena de selección.
//
//ls_query = " SELECT admision_bd.dbo.aspiran.clv_carr, " + & 
//				" dbo.carreras.carrera, " + & 
//				" admision_bd.dbo.aspiran.status, " + & 
//				" admision_bd.dbo.status.nombre, " + & 
//				" numero = count(*) " + & 
//				" FROM dbo.carreras, " + & 
//				" admision_bd.dbo.aspiran, " + &  
//				" admision_bd.dbo.status " + & 
//				" WHERE admision_bd.dbo.aspiran.clv_per in( " + ls_periodos + ") " + & 
//				" AND	admision_bd.dbo.aspiran.anio = " + STRING(li_anio) + & 
//				" AND	admision_bd.dbo.aspiran.clv_carr = dbo.carreras.cve_carrera " + &  
//				" AND	admision_bd.dbo.aspiran.status = admision_bd.dbo.status.status " + &  
//				" AND	(admision_bd.dbo.aspiran.clv_carr = " + STRING(ll_cve_carrera) + & 
//				" OR		" + STRING(ll_cve_carrera) + " = 9999) " + & 
//				" AND	(admision_bd.dbo.aspiran.status = " + STRING(ll_cve_status) + & 
//				" OR		" + STRING(ll_cve_status) + " = 99) " + &
//				" GROUP BY " + &
//				" admision_bd.dbo.aspiran.clv_carr, " + &
//				" dbo.carreras.carrera, " + &
//				" admision_bd.dbo.aspiran.status, " + &
//				" admision_bd.dbo.status.nombre "   
//
//dw_estadisticas.MODIFY("Datawindow.Table.Select = '" + ls_query + "'")

//**--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--**

dw_estadisticas.Retrieve(le_periodo[], li_anio, ll_cve_carrera, ll_cve_status)






end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_aspirantes_status
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 82
integer y = 124
integer width = 219
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
string displaydata = "`"
end type

event constructor;TabOrder = 0

int periodo,anio


periodo_actual_mat_insc(periodo,anio,gtr_sce)

// 0 = Primavera
// 1 = Verano
// 2 = Otoño

CHOOSE CASE periodo
	CASE 0
		periodo_x = 0
		rb_primavera.checked = TRUE
	CASE 1
		periodo_x = 1
      rb_verano.checked = TRUE
	CASE 2
		periodo_x = 2
      rb_otonio.checked = TRUE

END CHOOSE
this.text = string(anio)

//Deshabilitar los objetos que señalan el periodo
//this.enabled = FALSE
//rb_primavera.enabled = FALSE
//rb_verano.enabled = FALSE
//rb_otonio.enabled = FALSE
		

		
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type rb_otonio from radiobutton within w_estad_aspirantes_status
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 805
integer y = 396
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

type rb_verano from radiobutton within w_estad_aspirantes_status
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 448
integer y = 396
integer width = 270
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

type rb_primavera from radiobutton within w_estad_aspirantes_status
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 64
integer y = 396
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

type dw_1x from datawindow within w_estad_aspirantes_status
boolean visible = false
integer x = 3767
integer y = 624
integer width = 1038
integer height = 564
integer taborder = 70
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type gb_8 from groupbox within w_estad_aspirantes_status
integer x = 3150
integer y = 172
integer width = 329
integer height = 176
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_aspirantes_status
integer x = 37
integer y = 64
integer width = 315
integer height = 160
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_estad_aspirantes_status
boolean visible = false
integer x = 32
integer y = 332
integer width = 1056
integer height = 160
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_estad_aspirantes_status
integer width = 3589
integer height = 540
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

