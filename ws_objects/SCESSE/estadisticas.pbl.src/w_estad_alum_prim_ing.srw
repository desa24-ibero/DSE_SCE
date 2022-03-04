$PBExportHeader$w_estad_alum_prim_ing.srw
forward
global type w_estad_alum_prim_ing from w_master_main_rep
end type
type uo_nivel from uo_nivel_2013 within w_estad_alum_prim_ing
end type
type st_explicacion from statictext within w_estad_alum_prim_ing
end type
type gb_forma_ingreso from groupbox within w_estad_alum_prim_ing
end type
type st_3 from statictext within w_estad_alum_prim_ing
end type
type dw_estadisticas from datawindow within w_estad_alum_prim_ing
end type
type cb_1 from commandbutton within w_estad_alum_prim_ing
end type
type em_anio from editmask within w_estad_alum_prim_ing
end type
type gb_8 from groupbox within w_estad_alum_prim_ing
end type
type gb_11 from groupbox within w_estad_alum_prim_ing
end type
type gb_20 from groupbox within w_estad_alum_prim_ing
end type
type gb_1 from groupbox within w_estad_alum_prim_ing
end type
type uo_cve_forma_ingreso from uo_ingreso within w_estad_alum_prim_ing
end type
type dw_1x from datawindow within w_estad_alum_prim_ing
end type
type uo_periodo from uo_periodo_variable_tipos within w_estad_alum_prim_ing
end type
type st_1 from statictext within w_estad_alum_prim_ing
end type
end forward

global type w_estad_alum_prim_ing from w_master_main_rep
integer width = 4009
integer height = 2508
string title = "Estadística de Alumnos de Primer Ingreso"
string menuname = "m_estad_alum_prim_ing"
boolean resizable = true
long backcolor = 79741120
uo_nivel uo_nivel
st_explicacion st_explicacion
gb_forma_ingreso gb_forma_ingreso
st_3 st_3
dw_estadisticas dw_estadisticas
cb_1 cb_1
em_anio em_anio
gb_8 gb_8
gb_11 gb_11
gb_20 gb_20
gb_1 gb_1
uo_cve_forma_ingreso uo_cve_forma_ingreso
dw_1x dw_1x
uo_periodo uo_periodo
st_1 st_1
end type
global w_estad_alum_prim_ing w_estad_alum_prim_ing

type variables
int periodo_x
end variables

on w_estad_alum_prim_ing.create
int iCurrent
call super::create
if this.MenuName = "m_estad_alum_prim_ing" then this.MenuID = create m_estad_alum_prim_ing
this.uo_nivel=create uo_nivel
this.st_explicacion=create st_explicacion
this.gb_forma_ingreso=create gb_forma_ingreso
this.st_3=create st_3
this.dw_estadisticas=create dw_estadisticas
this.cb_1=create cb_1
this.em_anio=create em_anio
this.gb_8=create gb_8
this.gb_11=create gb_11
this.gb_20=create gb_20
this.gb_1=create gb_1
this.uo_cve_forma_ingreso=create uo_cve_forma_ingreso
this.dw_1x=create dw_1x
this.uo_periodo=create uo_periodo
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nivel
this.Control[iCurrent+2]=this.st_explicacion
this.Control[iCurrent+3]=this.gb_forma_ingreso
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.dw_estadisticas
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.em_anio
this.Control[iCurrent+8]=this.gb_8
this.Control[iCurrent+9]=this.gb_11
this.Control[iCurrent+10]=this.gb_20
this.Control[iCurrent+11]=this.gb_1
this.Control[iCurrent+12]=this.uo_cve_forma_ingreso
this.Control[iCurrent+13]=this.dw_1x
this.Control[iCurrent+14]=this.uo_periodo
this.Control[iCurrent+15]=this.st_1
end on

on w_estad_alum_prim_ing.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.st_explicacion)
destroy(this.gb_forma_ingreso)
destroy(this.st_3)
destroy(this.dw_estadisticas)
destroy(this.cb_1)
destroy(this.em_anio)
destroy(this.gb_8)
destroy(this.gb_11)
destroy(this.gb_20)
destroy(this.gb_1)
destroy(this.uo_cve_forma_ingreso)
destroy(this.dw_1x)
destroy(this.uo_periodo)
destroy(this.st_1)
end on

event open;this.x=1
this.y=1


uo_nivel.of_carga_control( gtr_sce ) 

// Se inicializa el objeto de servicios de periodo.
THIS.uo_periodo.of_inicializa_servicio("V", "L", "L", "S", gtr_sce)


 
end event

type st_sistema from w_master_main_rep`st_sistema within w_estad_alum_prim_ing
end type

type p_ibero from w_master_main_rep`p_ibero within w_estad_alum_prim_ing
end type

type uo_nivel from uo_nivel_2013 within w_estad_alum_prim_ing
integer x = 2697
integer y = 368
integer taborder = 110
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type st_explicacion from statictext within w_estad_alum_prim_ing
integer x = 1417
integer y = 588
integer width = 1221
integer height = 136
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Se consideran alumnos de primer ingreso en base al periodo y año de ingreso registrado."
boolean focusrectangle = false
end type

type gb_forma_ingreso from groupbox within w_estad_alum_prim_ing
integer x = 1394
integer y = 348
integer width = 1271
integer height = 224
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Forma Ingreso"
borderstyle borderstyle = styleraised!
end type

type st_3 from statictext within w_estad_alum_prim_ing
integer x = 3333
integer y = 388
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

type dw_estadisticas from datawindow within w_estad_alum_prim_ing
integer y = 896
integer width = 3808
integer height = 1340
integer taborder = 80
string dataobject = "dw_estad_alum_prim_ing"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
m_estad_alum_prim_ing.dw= this
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

type cb_1 from commandbutton within w_estad_alum_prim_ing
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 3438
integer y = 532
integer width = 265
integer height = 108
integer taborder = 90
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
integer li_cve_forma_ingreso, li_anio, li_periodo, li_indice_nivel, li_periodo2
string ls_anio, ls_nivel[], ls_periodo, ls_periodo_elegido, ls_forma_ingreso, ls_fecha_servidor, ls_periodo2
datetime ldttm_fecha_servidor
string ls_array_nivel[]
integer le_periodo[]

ll_renglon_uo = uo_cve_forma_ingreso.dw_ingreso.GetRow()
li_cve_forma_ingreso = uo_cve_forma_ingreso.dw_ingreso.object.cve_formaingreso[ll_renglon_uo]
ls_forma_ingreso = uo_cve_forma_ingreso.dw_ingreso.object.forma_ingreso[ll_renglon_uo]

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
//**--****--****--****--****--****--****--****--****--****--****--****--**
INTEGER le_index

PARENT.uo_periodo.of_recupera_periodos()

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(ls_periodo_elegido) <> "" THEN ls_periodo_elegido = ls_periodo_elegido + ", "
	ls_periodo_elegido = ls_periodo_elegido + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	le_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
NEXT 
//**--****--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--****--**


////li_indice_nivel = upperbound(ls_nivel)
////if cbx_licenciatura.checked then
////	li_indice_nivel = li_indice_nivel+1
////	ls_nivel[li_indice_nivel]=  "L" 
////end if
////li_indice_nivel = upperbound(ls_nivel)
////if cbx_posgrado.checked then
////	li_indice_nivel = li_indice_nivel+1
////	ls_nivel[li_indice_nivel]=  "P" 
////end if
////
////li_indice_nivel = upperbound(ls_nivel)
////if li_indice_nivel= 0 then
////	MessageBox("Error", "Es necesario seleccionar el Nivel", StopSign!)
////	return
////end if

uo_nivel.of_carga_arreglo_nivel( )
uo_nivel.of_obtiene_array( ls_array_nivel[])

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar un nivel",StopSign!)
	return
End If

ls_anio = em_anio.text

if not isnumber(ls_anio) then
	MessageBox("Error", "Es necesario escribir un Año", StopSign!)
	return
end if

li_anio= integer(ls_anio)

setpointer(Hourglass!)
ldttm_fecha_servidor = fecha_servidor(gtr_sce)
ls_fecha_servidor= string(ldttm_fecha_servidor, "dd/mm/yyyy hh:mm")

//ls_periodo_elegido = ls_periodo +" "+ ls_anio
ls_periodo_elegido = ls_periodo_elegido +" "+ ls_anio

dw_estadisticas.object.periodo_anio.text= ls_periodo_elegido
dw_estadisticas.object.st_fecha_hoy.text= ls_fecha_servidor

dw_estadisticas.object.st_forma_ingreso.text= ls_forma_ingreso
//dw_estadisticas.Retrieve(li_periodo, li_anio, ls_nivel, li_cve_forma_ingreso)


//If dw_estadisticas.Retrieve(li_periodo, li_anio, ls_array_nivel[], li_cve_forma_ingreso) <= 0 Then
If dw_estadisticas.Retrieve(le_periodo[], li_anio, ls_array_nivel[], li_cve_forma_ingreso) <= 0 Then
	MessageBox("Mensaje del Sistema", "No existe información para la consulta realizada...", Information!)
End If






end event

event constructor;TabOrder = 4
end event

type em_anio from editmask within w_estad_alum_prim_ing
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 82
integer y = 428
integer width = 219
integer height = 80
integer taborder = 30
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

type gb_8 from groupbox within w_estad_alum_prim_ing
integer x = 3401
integer y = 484
integer width = 329
integer height = 176
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within w_estad_alum_prim_ing
integer x = 37
integer y = 368
integer width = 315
integer height = 160
integer taborder = 40
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

type gb_20 from groupbox within w_estad_alum_prim_ing
integer x = 370
integer y = 360
integer width = 1006
integer height = 484
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

type gb_1 from groupbox within w_estad_alum_prim_ing
integer y = 300
integer width = 3808
integer height = 568
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

type uo_cve_forma_ingreso from uo_ingreso within w_estad_alum_prim_ing
event destroy ( )
integer x = 1422
integer y = 412
integer width = 1211
integer height = 152
integer taborder = 20
boolean bringtotop = true
boolean border = false
long backcolor = 79741120
end type

on uo_cve_forma_ingreso.destroy
call uo_ingreso::destroy
end on

type dw_1x from datawindow within w_estad_alum_prim_ing
boolean visible = false
integer x = 3392
integer y = 520
integer width = 238
integer height = 208
integer taborder = 70
boolean enabled = false
string dataobject = "dw_repo_mad_18_gx"
boolean livescroll = true
end type

type uo_periodo from uo_periodo_variable_tipos within w_estad_alum_prim_ing
integer x = 398
integer y = 420
integer width = 951
integer height = 352
integer taborder = 40
boolean bringtotop = true
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type st_1 from statictext within w_estad_alum_prim_ing
integer x = 411
integer y = 780
integer width = 457
integer height = 56
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "* Periodo Activo"
boolean focusrectangle = false
end type

