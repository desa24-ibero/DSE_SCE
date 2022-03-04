$PBExportHeader$w_estad_bajas_acad_carr.srw
forward
global type w_estad_bajas_acad_carr from w_master_main_rep
end type
type uo_carrera from uo_carreras within w_estad_bajas_acad_carr
end type
type gb_carreras from groupbox within w_estad_bajas_acad_carr
end type
type st_3 from statictext within w_estad_bajas_acad_carr
end type
type dw_estadisticas from datawindow within w_estad_bajas_acad_carr
end type
type cb_1 from commandbutton within w_estad_bajas_acad_carr
end type
type em_anio from editmask within w_estad_bajas_acad_carr
end type
type dw_1x from datawindow within w_estad_bajas_acad_carr
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_bajas_acad_carr
end type
type uo_nivel from uo_nivel_rbutton within w_estad_bajas_acad_carr
end type
type gb_8 from groupbox within w_estad_bajas_acad_carr
end type
type gb_11 from groupbox within w_estad_bajas_acad_carr
end type
type gb_20 from groupbox within w_estad_bajas_acad_carr
end type
type gb_1 from groupbox within w_estad_bajas_acad_carr
end type
end forward

global type w_estad_bajas_acad_carr from w_master_main_rep
integer width = 3785
integer height = 2568
string title = "Estadística de Bajas Académicas por Carrera"
string menuname = "m_estad_alum_mat"
boolean resizable = true
long backcolor = 79741120
uo_carrera uo_carrera
gb_carreras gb_carreras
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
dw_1x dw_1x
uo_periodo uo_periodo
uo_nivel uo_nivel
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
end type
global w_estad_bajas_acad_carr w_estad_bajas_acad_carr

type variables
int periodo_x
end variables

on w_estad_bajas_acad_carr.create
int iCurrent
call super::create
if this.MenuName = "m_estad_alum_mat" then this.MenuID = create m_estad_alum_mat
this.uo_carrera=create uo_carrera
this.gb_carreras=create gb_carreras
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.dw_1x=create dw_1x
this.uo_periodo=create uo_periodo
this.uo_nivel=create uo_nivel
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_carrera
this.Control[iCurrent+2]=this.gb_carreras
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_estadisticas
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.em_anio
this.Control[iCurrent+7]=this.dw_1x
this.Control[iCurrent+8]=this.uo_periodo
this.Control[iCurrent+9]=this.uo_nivel
this.Control[iCurrent+10]=this.gb_8
this.Control[iCurrent+11]=this.gb_11
this.Control[iCurrent+12]=this.gb_20
this.Control[iCurrent+13]=this.gb_1
end on

on w_estad_bajas_acad_carr.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_carrera)
destroy(this.gb_carreras)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.dw_1x)
destroy(this.uo_periodo)
destroy(this.uo_nivel)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1

//uo_nivel.of_carga_control(gtr_sce) 

THIS.uo_periodo.of_inicializa_servicio("V", "L", "L", "N", gtr_sce) 

uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce, "S", "N") 

end event

type st_sistema from w_master_main_rep`st_sistema within w_estad_bajas_acad_carr
end type

type p_ibero from w_master_main_rep`p_ibero within w_estad_bajas_acad_carr
end type

type uo_carrera from uo_carreras within w_estad_bajas_acad_carr
event destroy ( )
integer x = 1321
integer y = 556
integer taborder = 30
boolean border = false
long backcolor = 12639424
end type

on uo_carrera.destroy
call uo_carreras::destroy
end on

type gb_carreras from groupbox within w_estad_bajas_acad_carr
integer x = 1289
integer y = 484
integer width = 1312
integer height = 248
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

type st_3 from statictext within w_estad_bajas_acad_carr
integer x = 3081
integer y = 380
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

type dw_estadisticas from datawindow within w_estad_bajas_acad_carr
integer y = 860
integer width = 3589
integer height = 1320
integer taborder = 90
string dataobject = "d_bajas_academicas_carr"
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

type cb_1 from commandbutton within w_estad_bajas_acad_carr
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3241
integer y = 524
integer width = 265
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cargar"
end type

event clicked;// Se recuperan los registros de la base de datos
long ll_renglon_uo
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel
string ls_anio,  ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor
long ll_row_carrera, ll_cve_carrera, ll_row_coordinacion, ll_cve_coordinacion
datetime ldttm_fecha_servidor
string ls_nivel, ls_nombre_nivel
//, ls_array_nivel[]

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



//uo_nivel.of_carga_arreglo_nivel( )
//uo_nivel.of_obtiene_array( ls_array_nivel[])
//ls_nivel = uo_nivel.of_obtiene_seleccion( ) 
ls_nivel = uo_nivel.cve_nivel 


//If UpperBound(ls_array_nivel[]) <= 0 Then
IF TRIM(ls_nivel) = "" THEN 
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
ls_periodo_elegido  = ls_periodo_elegido  + " " + ls_anio

//dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
//dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor


INTEGER le_resultado
DATASTORE lds_temporal

lds_temporal = CREATE DATASTORE 
lds_temporal.DATAOBJECT = dw_estadisticas.DATAOBJECT 

FOR le_index = 1 TO UPPERBOUND(le_periodo[])

	//Necesario por la creacion de la tabla temporal
	dw_estadisticas.RESET()
	gtr_sce.Autocommit= true
	 dw_estadisticas.SETTRANSOBJECT(gtr_sce)
	le_resultado = dw_estadisticas.Retrieve(le_periodo[le_index] , li_anio, ll_cve_carrera, ls_nivel, ls_tipo_periodo[le_index])
	gtr_sce.Autocommit= false
	IF le_resultado <= 0 AND le_index = UPPERBOUND(le_periodo[]) Then
//		gtr_sce.Autocommit= false
		MessageBox("Mensaje del Sistema", "No existe información para la consulta realizada...", Information!)
		RETURN -1
	Else 
//		gtr_sce.Autocommit= false
	End If
	
	IF le_resultado < 0 THEN 
		dw_estadisticas.RESET()
		MESSAGEBOX("Error", "No se pudo generar el reporte.") 
		RETURN -1
	ELSEIF le_resultado = 0 THEN 
		CONTINUE
	ELSE
		dw_estadisticas.ROWSCOPY(1, dw_estadisticas.ROWCOUNT(), PRIMARY!, lds_temporal, lds_temporal.ROWCOUNT() + 1, PRIMARY!) 
	END IF	
	
	
NEXT


// Se copia la información al dw principal.
dw_estadisticas.RESET()
lds_temporal.ROWSCOPY(1, lds_temporal.ROWCOUNT(), PRIMARY!, dw_estadisticas, dw_estadisticas.ROWCOUNT() + 1, PRIMARY!)


dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor





end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_bajas_acad_carr
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 55
integer y = 428
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

//CHOOSE CASE periodo
//	CASE 0
//		periodo_x = 0
//		rb_primavera.checked = TRUE
//	CASE 1
//		periodo_x = 1
//      rb_verano.checked = TRUE
//	CASE 2
//		periodo_x = 2
//      rb_otonio.checked = TRUE
//
//END CHOOSE
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

type dw_1x from datawindow within w_estad_bajas_acad_carr
boolean visible = false
integer x = 2606
integer y = 1060
integer width = 1038
integer height = 564
integer taborder = 80
boolean enabled = false
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type uo_periodo from uo_periodo_variable_tipos within w_estad_bajas_acad_carr
integer x = 338
integer y = 436
integer width = 901
integer height = 348
integer taborder = 60
boolean bringtotop = true
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type uo_nivel from uo_nivel_rbutton within w_estad_bajas_acad_carr
event destroy ( )
integer x = 2665
integer y = 480
integer width = 517
integer taborder = 30
boolean bringtotop = true
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

type gb_8 from groupbox within w_estad_bajas_acad_carr
integer x = 3205
integer y = 476
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

type gb_11 from groupbox within w_estad_bajas_acad_carr
integer x = 37
integer y = 368
integer width = 261
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

type gb_20 from groupbox within w_estad_bajas_acad_carr
integer x = 306
integer y = 368
integer width = 960
integer height = 440
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

type gb_1 from groupbox within w_estad_bajas_acad_carr
integer y = 304
integer width = 3589
integer height = 552
integer taborder = 10
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

