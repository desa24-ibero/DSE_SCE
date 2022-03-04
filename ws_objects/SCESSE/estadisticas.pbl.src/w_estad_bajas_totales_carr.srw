$PBExportHeader$w_estad_bajas_totales_carr.srw
forward
global type w_estad_bajas_totales_carr from w_master_main_rep
end type
type uo_nivel from uo_nivel_2013 within w_estad_bajas_totales_carr
end type
type uo_carrera from uo_carreras within w_estad_bajas_totales_carr
end type
type gb_carreras from groupbox within w_estad_bajas_totales_carr
end type
type st_3 from statictext within w_estad_bajas_totales_carr
end type
type dw_estadisticas from datawindow within w_estad_bajas_totales_carr
end type
type cb_1 from commandbutton within w_estad_bajas_totales_carr
end type
type em_anio from editmask within w_estad_bajas_totales_carr
end type
type rb_otonio from radiobutton within w_estad_bajas_totales_carr
end type
type rb_verano from radiobutton within w_estad_bajas_totales_carr
end type
type rb_primavera from radiobutton within w_estad_bajas_totales_carr
end type
type dw_1x from datawindow within w_estad_bajas_totales_carr
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_bajas_totales_carr
end type
type gb_8 from groupbox within w_estad_bajas_totales_carr
end type
type gb_11 from groupbox within w_estad_bajas_totales_carr
end type
type gb_20 from groupbox within w_estad_bajas_totales_carr
end type
type gb_1 from groupbox within w_estad_bajas_totales_carr
end type
end forward

global type w_estad_bajas_totales_carr from w_master_main_rep
integer width = 3803
integer height = 2520
string title = "Estadística de Bajas Totales por Carrera"
string menuname = "m_estad_alum_mat"
boolean resizable = true
long backcolor = 79741120
uo_nivel uo_nivel
uo_carrera uo_carrera
gb_carreras gb_carreras
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
rb_otonio rb_otonio
rb_verano rb_verano
rb_primavera rb_primavera
dw_1x dw_1x
uo_periodo uo_periodo
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
end type
global w_estad_bajas_totales_carr w_estad_bajas_totales_carr

type variables
int periodo_x
end variables

on w_estad_bajas_totales_carr.create
int iCurrent
call super::create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_nivel=create uo_nivel
this.uo_carrera=create uo_carrera
this.gb_carreras=create gb_carreras
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.rb_otonio=create rb_otonio
this.rb_verano=create rb_verano
this.rb_primavera=create rb_primavera
this.dw_1x=create dw_1x
this.uo_periodo=create uo_periodo
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nivel
this.Control[iCurrent+2]=this.uo_carrera
this.Control[iCurrent+3]=this.gb_carreras
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_estadisticas
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.em_anio
this.Control[iCurrent+8]=this.rb_otonio
this.Control[iCurrent+9]=this.rb_verano
this.Control[iCurrent+10]=this.rb_primavera
this.Control[iCurrent+11]=this.dw_1x
this.Control[iCurrent+12]=this.uo_periodo
this.Control[iCurrent+13]=this.gb_8
this.Control[iCurrent+14]=this.gb_11
this.Control[iCurrent+15]=this.gb_20
this.Control[iCurrent+16]=this.gb_1
end on

on w_estad_bajas_totales_carr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.uo_carrera)
destroy(this.gb_carreras)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.rb_otonio)
destroy(this.rb_verano)
destroy(this.rb_primavera)
destroy(this.dw_1x)
destroy(this.uo_periodo)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1


uo_nivel.of_carga_control(gtr_sce)


THIS.uo_periodo.of_inicializa_servicio("V", "L", "L", "S", gtr_sce)
end event

type st_sistema from w_master_main_rep`st_sistema within w_estad_bajas_totales_carr
end type

type p_ibero from w_master_main_rep`p_ibero within w_estad_bajas_totales_carr
end type

type uo_nivel from uo_nivel_2013 within w_estad_bajas_totales_carr
integer x = 2642
integer y = 400
integer taborder = 50
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type uo_carrera from uo_carreras within w_estad_bajas_totales_carr
event destroy ( )
integer x = 1344
integer y = 464
integer taborder = 30
boolean border = false
long backcolor = 12639424
end type

on uo_carrera.destroy
call uo_carreras::destroy
end on

type gb_carreras from groupbox within w_estad_bajas_totales_carr
integer x = 1312
integer y = 400
integer width = 1317
integer height = 240
integer taborder = 20
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Carreras"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_estad_bajas_totales_carr
boolean visible = false
integer x = 3090
integer y = 396
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

type dw_estadisticas from datawindow within w_estad_bajas_totales_carr
integer x = 9
integer y = 928
integer width = 3589
integer height = 1296
integer taborder = 90
string dataobject = "d_bajas_totales_carr"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_estad_alum_mat.dw= this
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/
long ll_num_rows, ll_row, ll_num_alumnos
real lr_promedio

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

ll_num_rows = rowcount

end event

type cb_1 from commandbutton within w_estad_bajas_totales_carr
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3264
integer y = 540
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

event clicked;// Se recuperan los registros de la base de datos
long ll_renglon_uo
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel
string ls_anio,  ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion
datetime ldttm_fecha_servidor
string ls_nivel, ls_nombre_nivel, ls_array_nivel[]

ll_row_carrera = parent.uo_carrera.dw_carreras.GetRow()
ll_cve_carrera = parent.uo_carrera.dw_carreras.object.cve_carrera[ll_row_carrera]
//ll_row_coordinacion = parent.uo_coordinacion.dw_coordinaciones.GetRow()
//ll_cve_coordinacion = parent.uo_coordinacion.dw_coordinaciones.object.cve_coordinacion[ll_row_coordinacion]

//if rb_licenciatura.checked then
//	ls_nivel= "L"
//	ls_nombre_nivel = "LICENCIATURA"
//elseif rb_posgrado.checked then
//	ls_nivel= "P"
//	ls_nombre_nivel = "POSGRADO"
//elseif rb_ambos.checked then
//	ls_nivel= "A"	
//	ls_nombre_nivel = "AMBOS"
//else
//	MessageBox("Error", "Es necesario seleccionar un Nivel", StopSign!)
//	return
//end if

uo_nivel.of_carga_arreglo_nivel( )
uo_nivel.of_obtiene_array( ls_array_nivel[])
//ls_nivel = uo_nivel.of_obtiene_seleccion( )

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar un nivel",StopSign!)
	return
End If

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

//**--****--****--****--****--****--****--****--****--****--****--****--**
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]

PARENT.uo_periodo.of_recupera_periodos()

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
	ls_periodo_elegido = ls_periodo_elegido + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 
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
ls_periodo_elegido = ls_periodo_elegido +" "+ ls_anio

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

//Necesario por la creacion de la tabla temporal
gtr_sce.Autocommit= true
dw_estadisticas.Retrieve(ll_cve_carrera, ls_array_nivel[], le_periodo[])
gtr_sce.Autocommit= false
end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_bajas_totales_carr
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 64
integer y = 444
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
boolean displayonly = true
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

type rb_otonio from radiobutton within w_estad_bajas_totales_carr
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 1170
integer y = 604
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
boolean enabled = false
string text = "Otoño"
end type

event clicked;periodo_x = 2
end event

type rb_verano from radiobutton within w_estad_bajas_totales_carr
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 731
integer y = 464
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 12639424
boolean enabled = false
string text = "Verano"
end type

event clicked;periodo_x = 1
end event

type rb_primavera from radiobutton within w_estad_bajas_totales_carr
event clicked pbm_bnclicked
event constructor pbm_constructor
boolean visible = false
integer x = 352
integer y = 464
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
boolean enabled = false
string text = "Primavera"
end type

event clicked;periodo_x = 0
end event

type dw_1x from datawindow within w_estad_bajas_totales_carr
boolean visible = false
integer x = 2725
integer y = 980
integer width = 919
integer height = 564
integer taborder = 80
boolean enabled = false
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type uo_periodo from uo_periodo_variable_tipos within w_estad_bajas_totales_carr
integer x = 347
integer y = 464
integer width = 923
integer taborder = 120
boolean bringtotop = true
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type gb_8 from groupbox within w_estad_bajas_totales_carr
integer x = 3227
integer y = 492
integer width = 329
integer height = 176
integer taborder = 110
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_bajas_totales_carr
integer x = 46
integer y = 384
integer width = 256
integer height = 160
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Año"
borderstyle borderstyle = styleraised!
end type

type gb_20 from groupbox within w_estad_bajas_totales_carr
integer x = 320
integer y = 400
integer width = 978
integer height = 472
integer taborder = 60
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Periodo"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_estad_bajas_totales_carr
integer x = 9
integer y = 320
integer width = 3589
integer height = 604
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

