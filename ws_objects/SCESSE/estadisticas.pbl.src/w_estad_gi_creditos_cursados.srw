$PBExportHeader$w_estad_gi_creditos_cursados.srw
forward
global type w_estad_gi_creditos_cursados from w_master_main_rep
end type
type uo_nivel from uo_nivel_2013 within w_estad_gi_creditos_cursados
end type
type uo_carrera from uo_carreras within w_estad_gi_creditos_cursados
end type
type gb_carreras from groupbox within w_estad_gi_creditos_cursados
end type
type st_3 from statictext within w_estad_gi_creditos_cursados
end type
type dw_estadisticas from datawindow within w_estad_gi_creditos_cursados
end type
type cb_1 from commandbutton within w_estad_gi_creditos_cursados
end type
type em_anio from editmask within w_estad_gi_creditos_cursados
end type
type dw_1x from datawindow within w_estad_gi_creditos_cursados
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_gi_creditos_cursados
end type
type gb_8 from groupbox within w_estad_gi_creditos_cursados
end type
type gb_11 from groupbox within w_estad_gi_creditos_cursados
end type
type gb_20 from groupbox within w_estad_gi_creditos_cursados
end type
type gb_1 from groupbox within w_estad_gi_creditos_cursados
end type
end forward

global type w_estad_gi_creditos_cursados from w_master_main_rep
integer width = 3831
integer height = 2744
string title = "Estadística de Créditos por Carrera"
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
dw_1x dw_1x
uo_periodo uo_periodo
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
end type
global w_estad_gi_creditos_cursados w_estad_gi_creditos_cursados

type variables
INTEGER periodo_x[], ii_num_resize = 0
STRING is_descripcion_periodo 
end variables

on w_estad_gi_creditos_cursados.create
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
this.Control[iCurrent+8]=this.dw_1x
this.Control[iCurrent+9]=this.uo_periodo
this.Control[iCurrent+10]=this.gb_8
this.Control[iCurrent+11]=this.gb_11
this.Control[iCurrent+12]=this.gb_20
this.Control[iCurrent+13]=this.gb_1
end on

on w_estad_gi_creditos_cursados.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.uo_carrera)
destroy(this.gb_carreras)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.dw_1x)
destroy(this.uo_periodo)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
end on

event open;
// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)


this.x=1
this.y=1

uo_nivel.of_carga_control(gtr_sce)
end event

event resize;call super::resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_estadisticas.height
	ll_height_win = this.height

	ll_height_tab = dw_estadisticas.height
	ll_width_tab = dw_estadisticas.width

	dw_estadisticas.width = newwidth - 50
	dw_estadisticas.height = newheight - 850
	
	ll_height_tab_final = dw_estadisticas.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_estadisticas.width = newwidth - 200
	dw_estadisticas.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize + 1
end if
end event

type st_sistema from w_master_main_rep`st_sistema within w_estad_gi_creditos_cursados
end type

type p_ibero from w_master_main_rep`p_ibero within w_estad_gi_creditos_cursados
end type

type uo_nivel from uo_nivel_2013 within w_estad_gi_creditos_cursados
integer x = 1289
integer y = 356
integer taborder = 60
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type uo_carrera from uo_carreras within w_estad_gi_creditos_cursados
event destroy ( )
integer x = 1906
integer y = 524
integer taborder = 30
boolean border = false
long backcolor = 12639424
end type

on uo_carrera.destroy
call uo_carreras::destroy
end on

type gb_carreras from groupbox within w_estad_gi_creditos_cursados
integer x = 1897
integer y = 460
integer width = 1294
integer height = 224
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

type st_3 from statictext within w_estad_gi_creditos_cursados
integer x = 3067
integer y = 384
integer width = 503
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

type dw_estadisticas from datawindow within w_estad_gi_creditos_cursados
integer x = 9
integer y = 828
integer width = 3589
integer height = 1652
integer taborder = 90
string dataobject = "d_gi_creditos_cursados"
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
decimal ldc_num_creditos
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

for ll_row = 1 to ll_num_rows
   ll_num_alumnos = this.GetItemNumber(ll_row, "num_alumnos")
   ldc_num_creditos = this.GetItemNumber(ll_row, "num_creditos")
	if ll_num_alumnos <> 0 then
	   lr_promedio = ldc_num_creditos / ll_num_alumnos
		this.Setitem(ll_row, "prom_creditos", lr_promedio)	
	end if
next



end event

type cb_1 from commandbutton within w_estad_gi_creditos_cursados
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3264
integer y = 548
integer width = 265
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
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

ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

ls_periodo_elegido =ls_periodo +" "+ ls_anio

//dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor


Parent.uo_nivel.of_carga_arreglo_nivel( )
Parent.uo_nivel.of_obtiene_array( ls_array_nivel[])
ls_nivel = Parent.uo_nivel.of_obtiene_seleccion( )


If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar un nivel",StopSign!)
	return
End If
	
//Necesario por la creacion de la tabla temporal
gtr_sce.Autocommit= true
//If dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_carrera, ls_nivel) <= 0 Then



//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[] 
STRING ls_tipo_periodo[]
DATASTORE lds_paso

lds_paso = CREATE DATASTORE 
lds_paso.DATAOBJECT = dw_estadisticas.DATAOBJECT 

PARENT.uo_periodo.of_recupera_periodos() 

periodo_x[] = le_periodo[]
is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
	
	dw_estadisticas.RESET()
	IF dw_estadisticas.Retrieve(periodo_x[le_index], li_anio, ll_cve_carrera, ls_nivel, ls_tipo_periodo[le_index]) < 0 THEN RETURN 0
	dw_estadisticas.ROWSCOPY(1, dw_estadisticas.ROWCOUNT(), PRIMARY!, lds_paso, lds_paso.ROWCOUNT() + 1, PRIMARY!)
	
NEXT 	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	

dw_estadisticas.object.periodo_anio.text=is_descripcion_periodo +" "+ ls_anio

dw_estadisticas.RESET()
lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, dw_estadisticas, dw_estadisticas.ROWCOUNT() + 1 , PRIMARY!)
dw_estadisticas.SORT()
dw_estadisticas.GROUPCALC()


//If dw_estadisticas.Retrieve(li_periodo, li_anio, ll_cve_carrera, ls_nivel, 'S') <= 0 Then
If dw_estadisticas.ROWCOUNT() <= 0 Then
  Messagebox("Mensaje de Sistema","No existe información para la consulta realizada")	
  gtr_sce.Autocommit= false
  return
Else
	gtr_sce.Autocommit= false
End If 

end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_gi_creditos_cursados
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 78
integer y = 420
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

//// 0 = Primavera
//// 1 = Verano
//// 2 = Otoño
//
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

type dw_1x from datawindow within w_estad_gi_creditos_cursados
boolean visible = false
integer x = 3630
integer y = 968
integer width = 1038
integer height = 564
integer taborder = 80
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type uo_periodo from uo_periodo_variable_tipos within w_estad_gi_creditos_cursados
integer x = 370
integer y = 420
integer width = 887
integer height = 344
integer taborder = 30
boolean bringtotop = true
long backcolor = 12639424
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type gb_8 from groupbox within w_estad_gi_creditos_cursados
integer x = 3227
integer y = 500
integer width = 329
integer height = 176
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_gi_creditos_cursados
integer x = 46
integer y = 356
integer width = 270
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

type gb_20 from groupbox within w_estad_gi_creditos_cursados
integer x = 343
integer y = 356
integer width = 937
integer height = 432
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

type gb_1 from groupbox within w_estad_gi_creditos_cursados
integer x = 9
integer y = 292
integer width = 3593
integer height = 528
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

