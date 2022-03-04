$PBExportHeader$w_alum_ingreso_x_per.srw
$PBExportComments$Contiene el reporte de los alumnos que ingresaron en x periodo. Juan Campos. Abril-1998.
forward
global type w_alum_ingreso_x_per from window
end type
type uo_nivel from uo_nivel_rbutton within w_alum_ingreso_x_per
end type
type gb_8 from groupbox within w_alum_ingreso_x_per
end type
type uo_periodo from uo_periodo_variable_chk within w_alum_ingreso_x_per
end type
type cb_3 from commandbutton within w_alum_ingreso_x_per
end type
type cbx_todosperiodos from checkbox within w_alum_ingreso_x_per
end type
type cbx_otono from checkbox within w_alum_ingreso_x_per
end type
type cbx_verano from checkbox within w_alum_ingreso_x_per
end type
type cbx_primavera from checkbox within w_alum_ingreso_x_per
end type
type em_anio_fin from editmask within w_alum_ingreso_x_per
end type
type em_anio_ini from editmask within w_alum_ingreso_x_per
end type
type st_2 from statictext within w_alum_ingreso_x_per
end type
type st_1 from statictext within w_alum_ingreso_x_per
end type
type dw_1 from datawindow within w_alum_ingreso_x_per
end type
type cbx_todascarr from checkbox within w_alum_ingreso_x_per
end type
type cb_limpiarcarr from commandbutton within w_alum_ingreso_x_per
end type
type cb_eliminarcarr from commandbutton within w_alum_ingreso_x_per
end type
type em_carr from editmask within w_alum_ingreso_x_per
end type
type lb_listacarr from listbox within w_alum_ingreso_x_per
end type
type cb_agregarcarr from commandbutton within w_alum_ingreso_x_per
end type
type cb_2 from commandbutton within w_alum_ingreso_x_per
end type
type cb_1 from commandbutton within w_alum_ingreso_x_per
end type
type gb_6 from groupbox within w_alum_ingreso_x_per
end type
type gb_5 from groupbox within w_alum_ingreso_x_per
end type
type gb_4 from groupbox within w_alum_ingreso_x_per
end type
type gb_3 from groupbox within w_alum_ingreso_x_per
end type
type gb_2 from groupbox within w_alum_ingreso_x_per
end type
type gb_1 from groupbox within w_alum_ingreso_x_per
end type
type gb_7 from groupbox within w_alum_ingreso_x_per
end type
type cb_ordena from commandbutton within w_alum_ingreso_x_per
end type
type cbx_alfabetico from checkbox within w_alum_ingreso_x_per
end type
type cbx_cuenta from checkbox within w_alum_ingreso_x_per
end type
end forward

global type w_alum_ingreso_x_per from window
integer x = 832
integer y = 348
integer width = 3621
integer height = 2320
boolean titlebar = true
string title = "ALUMNOS QUE INGRESARON EN  X PERIODO"
boolean controlmenu = true
long backcolor = 27291696
uo_nivel uo_nivel
gb_8 gb_8
uo_periodo uo_periodo
cb_3 cb_3
cbx_todosperiodos cbx_todosperiodos
cbx_otono cbx_otono
cbx_verano cbx_verano
cbx_primavera cbx_primavera
em_anio_fin em_anio_fin
em_anio_ini em_anio_ini
st_2 st_2
st_1 st_1
dw_1 dw_1
cbx_todascarr cbx_todascarr
cb_limpiarcarr cb_limpiarcarr
cb_eliminarcarr cb_eliminarcarr
em_carr em_carr
lb_listacarr lb_listacarr
cb_agregarcarr cb_agregarcarr
cb_2 cb_2
cb_1 cb_1
gb_6 gb_6
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
gb_7 gb_7
cb_ordena cb_ordena
cbx_alfabetico cbx_alfabetico
cbx_cuenta cbx_cuenta
end type
global w_alum_ingreso_x_per w_alum_ingreso_x_per

type variables
String Nivel
Datawindowchild dwc_periodo
end variables

on w_alum_ingreso_x_per.create
this.uo_nivel=create uo_nivel
this.gb_8=create gb_8
this.uo_periodo=create uo_periodo
this.cb_3=create cb_3
this.cbx_todosperiodos=create cbx_todosperiodos
this.cbx_otono=create cbx_otono
this.cbx_verano=create cbx_verano
this.cbx_primavera=create cbx_primavera
this.em_anio_fin=create em_anio_fin
this.em_anio_ini=create em_anio_ini
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.cbx_todascarr=create cbx_todascarr
this.cb_limpiarcarr=create cb_limpiarcarr
this.cb_eliminarcarr=create cb_eliminarcarr
this.em_carr=create em_carr
this.lb_listacarr=create lb_listacarr
this.cb_agregarcarr=create cb_agregarcarr
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_6=create gb_6
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_7=create gb_7
this.cb_ordena=create cb_ordena
this.cbx_alfabetico=create cbx_alfabetico
this.cbx_cuenta=create cbx_cuenta
this.Control[]={this.uo_nivel,&
this.gb_8,&
this.uo_periodo,&
this.cb_3,&
this.cbx_todosperiodos,&
this.cbx_otono,&
this.cbx_verano,&
this.cbx_primavera,&
this.em_anio_fin,&
this.em_anio_ini,&
this.st_2,&
this.st_1,&
this.dw_1,&
this.cbx_todascarr,&
this.cb_limpiarcarr,&
this.cb_eliminarcarr,&
this.em_carr,&
this.lb_listacarr,&
this.cb_agregarcarr,&
this.cb_2,&
this.cb_1,&
this.gb_6,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.gb_1,&
this.gb_7,&
this.cb_ordena,&
this.cbx_alfabetico,&
this.cbx_cuenta}
end on

on w_alum_ingreso_x_per.destroy
destroy(this.uo_nivel)
destroy(this.gb_8)
destroy(this.uo_periodo)
destroy(this.cb_3)
destroy(this.cbx_todosperiodos)
destroy(this.cbx_otono)
destroy(this.cbx_verano)
destroy(this.cbx_primavera)
destroy(this.em_anio_fin)
destroy(this.em_anio_ini)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cbx_todascarr)
destroy(this.cb_limpiarcarr)
destroy(this.cb_eliminarcarr)
destroy(this.em_carr)
destroy(this.lb_listacarr)
destroy(this.cb_agregarcarr)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_7)
destroy(this.cb_ordena)
destroy(this.cbx_alfabetico)
destroy(this.cbx_cuenta)
end on

event open;// REPORTE DE ALUMNOS QUE INGRESARON EN X PERIODO
// JUAN CAMPOS SÁNCHEZ. 		ABRIL-1998.

This.x = 1
This.y = 1

Nivel = 'L'

//THIS.uo_periodo.of_inicializa_servicio("V", "L", "L", "N", gtr_sce)

INTEGER le_periodo 
INTEGER le_anio
this.uo_periodo.f_genera_periodo( gs_tipo_periodo, "V", "L", "L", "N", gtr_sce)
periodo_actual(le_periodo, le_anio, gtr_sce) 



This.em_anio_ini.text=string(year(today()))
This.em_anio_fin.text=string(year(today()))

// Se inicializa objeto con nivel.
this.uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce, "S", "N") 


end event

type uo_nivel from uo_nivel_rbutton within w_alum_ingreso_x_per
integer x = 64
integer y = 164
integer width = 421
integer height = 356
integer taborder = 90
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

event ue_cambia_seleccion;call super::ue_cambia_seleccion;
Nivel = cve_nivel 

IF cbx_todascarr.CHECKED THEN 
	cbx_todascarr.TRIGGEREVENT(CLICKED!) 
END IF 



end event

type gb_8 from groupbox within w_alum_ingreso_x_per
integer x = 1774
integer y = 96
integer width = 814
integer height = 460
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Orden"
end type

type uo_periodo from uo_periodo_variable_chk within w_alum_ingreso_x_per
integer x = 1175
integer y = 172
integer width = 512
integer taborder = 80
end type

on uo_periodo.destroy
call uo_periodo_variable_chk::destroy
end on

type cb_3 from commandbutton within w_alum_ingreso_x_per
integer x = 2683
integer y = 532
integer width = 800
integer height = 120
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar como archivo de Exel"
end type

event clicked;// Juan Campos Sánchez.    Abril-1998.
Long in_value

IF dw_1.RowCount() > 0 Then
	// Prompt the user with a File Save Dialog.
	dw_1.SaveAs("",EXCEL!,True)

	//dw_1.SaveAs("C:\ALU_INGRESO.XLS",EXCEL!,True)
	//Messagebox("El archivo se guardo en C:\","Con el nombre de: ALU_INGRESO.XLS")
	Messagebox("Información","El archivo se ha guardo con éxito!", Information!)
Else
	//Messagebox("No hay datos para guardar","")
	Messagebox("Alerta","No existen datos para guardar", Exclamation!)
End IF
end event

type cbx_todosperiodos from checkbox within w_alum_ingreso_x_per
boolean visible = false
integer x = 1701
integer y = 460
integer width = 238
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Todos"
boolean checked = true
boolean lefttext = true
borderstyle borderstyle = styleraised!
end type

event clicked;cbx_primavera.checked = True
cbx_verano.checked = True
cbx_otono.checked = True
cbx_todosperiodos.checked = True
end event

type cbx_otono from checkbox within w_alum_ingreso_x_per
boolean visible = false
integer x = 1243
integer y = 352
integer width = 288
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Otoño"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;cbx_todosperiodos.checked = False
end event

type cbx_verano from checkbox within w_alum_ingreso_x_per
boolean visible = false
integer x = 1243
integer y = 256
integer width = 288
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Verano"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;cbx_todosperiodos.checked = False
end event

type cbx_primavera from checkbox within w_alum_ingreso_x_per
boolean visible = false
integer x = 1243
integer y = 160
integer width = 343
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Primavera"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;cbx_todosperiodos.checked = False
end event

type em_anio_fin from editmask within w_alum_ingreso_x_per
integer x = 805
integer y = 244
integer width = 256
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "1999"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "1950~~2100"
end type

event modified;String Fecha

// Si se detecta un ENTER se verifica que haya escrito algo y se verifica el año 
// en el evento clicked de cb_2

if keydown(keyenter!) then	
	Fecha=this.text
	if (Fecha <> '') then
   	  //cb_2.triggerevent("clicked")
	end if	
end if

end event

event getfocus;This.selecttext(1,len(em_anio_fin.text))
end event

type em_anio_ini from editmask within w_alum_ingreso_x_per
integer x = 805
integer y = 148
integer width = 256
integer height = 96
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "1990"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "1950~~2100"
end type

event modified;String Fecha

// Si se detecta un ENTER se verifica que haya escrito algo y se verifica el año 
// en el evento clicked de cb_2

if keydown(keyenter!) then	
	Fecha=this.text
	if (Fecha <> '') then
   	  //cb_2.triggerevent("clicked")
	end if	
end if

end event

event getfocus;This.selecttext(1,len(em_anio_ini.text))
end event

type st_2 from statictext within w_alum_ingreso_x_per
integer x = 622
integer y = 260
integer width = 146
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Fin:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_alum_ingreso_x_per
integer x = 585
integer y = 164
integer width = 169
integer height = 64
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Inicio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_alum_ingreso_x_per
integer y = 1104
integer width = 3570
integer height = 1108
integer taborder = 120
string dataobject = "dw_alum_ingreso_x_periodo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;This.SettransObject(gtr_sce)
end event

type cbx_todascarr from checkbox within w_alum_ingreso_x_per
event limpia ( )
integer x = 73
integer y = 904
integer width = 288
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Todas"
borderstyle borderstyle = styleraised!
end type

event limpia;// Se limpian los datos de las listas
Integer	Total
long		Number[]

setpointer(Hourglass!)

Total=lb_listacarr.totalitems()
DO UNTIL Total=0
	lb_listacarr.DeleteItem(1)
	Total=lb_listacarr.totalitems()
LOOP
end event

event clicked;// Juan Campos Abril-1998.

// Se verifica que tipo de carrera se desea insertar
Integer total, cont
setpointer(Hourglass!)

DataStore dw_carreras  
dw_carreras = CREATE DataStore
dw_carreras.DataObject = "dw_carrera"
dw_carreras.Settransobject(gtr_sce)

If (this.checked = TRUE) then
	// Se limpian los datos
	this. EVENT limpia()
	dw_carreras.Retrieve()
	
	// Todos los niveles 
	if nivel = 'A' then
		// Se insertan todas las carreras en las listas		
		if dw_carreras.rowcount()>0 then
			total=dw_carreras.rowcount()
			FOR cont=1 TO total
				lb_listacarr.additem (string(dw_carreras.getItemNumber(cont,"cve_carrera"))+' - '+dw_carreras.getItemString(cont,"carrera"))
			NEXT			
		end if
   else
		// Se insertan todas las carreras de licenciatura en las listas		
		if dw_carreras.rowcount()>0 then
			total=dw_carreras.rowcount()
			FOR cont=1 TO total
				if dw_carreras.GetItemString(cont,"nivel") = nivel Then 
					lb_listacarr.additem (string(dw_carreras.getItemNumber(cont,"cve_carrera"))+' - '+dw_carreras.getItemString(cont,"carrera"))
				End IF			
			NEXT			
		end if 
	end if

//	if nivel = 'L' then
//		// Se insertan todas las carreras de licenciatura en las listas		
//		if dw_carreras.rowcount()>0 then
//			total=dw_carreras.rowcount()
//			FOR cont=1 TO total
//				if dw_carreras.GetItemString(cont,"nivel") = 'L' Then
//					lb_listacarr.additem (string(dw_carreras.getItemNumber(cont,"cve_carrera"))+' - '+dw_carreras.getItemString(cont,"carrera"))
//				End IF			
//			NEXT			
//		end if 
//	end if

//	if nivel = 'T' then
//		// Se insertan todas las carreras de licenciatura en las listas		
//		if dw_carreras.rowcount()>0 then
//			total=dw_carreras.rowcount()
//			FOR cont=1 TO total
//				if dw_carreras.GetItemString(cont,"nivel") = 'T' Then 
//					lb_listacarr.additem (string(dw_carreras.getItemNumber(cont,"cve_carrera"))+' - '+dw_carreras.getItemString(cont,"carrera"))
//				End IF			
//			NEXT			
//		end if 
//	end if

//	if nivel = 'P' then
//		// Se insertan todas las carreras de licenciatura en las listas		
//		if dw_carreras.rowcount()>0 then
//			total=dw_carreras.rowcount()
//			FOR cont=1 TO total
//				if dw_carreras.GetItemString(cont,"nivel") = 'P' Then
//					lb_listacarr.additem (string(dw_carreras.getItemNumber(cont,"cve_carrera"))+' - '+dw_carreras.getItemString(cont,"carrera"))
//				End IF			
//			NEXT			
//		end if 
//	end if
 
else
	// Se Limpian las listas, para evitar duplicidad
	this. EVENT limpia()
end if	

end event

type cb_limpiarcarr from commandbutton within w_alum_ingreso_x_per
integer x = 2158
integer y = 680
integer width = 288
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpiar"
end type

event clicked;// Juan Campos Abril-1998.
 
Setpointer(Hourglass!)
lb_listacarr.Reset()
cbx_todascarr.checked = False 
end event

type cb_eliminarcarr from commandbutton within w_alum_ingreso_x_per
integer x = 2158
integer y = 808
integer width = 288
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;// Juan Campos Abril-1998. 
 
Integer li_Index
setpointer(Hourglass!)
// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_listacarr.SelectedIndex( )
// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_listacarr.DeleteItem(li_Index)
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_listacarr.SelectedIndex( )
LOOP

cbx_todascarr.checked = False 
end event

type em_carr from editmask within w_alum_ingreso_x_per
integer x = 73
integer y = 616
integer width = 288
integer height = 96
integer taborder = 10
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = ""
end type

event modified;// Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
// en el evento clicked de cd_agregarcarr
// Juan Campos Abril-1998. 

if keydown(keyenter!) then	
	if (this.text <> '') then
   	  cb_agregarcarr.triggerevent("clicked")
	end if	
end if
 
end event

type lb_listacarr from listbox within w_alum_ingreso_x_per
integer x = 402
integer y = 616
integer width = 1682
integer height = 352
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean hscrollbar = true
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

type cb_agregarcarr from commandbutton within w_alum_ingreso_x_per
event type integer verifica ( )
event type integer verifica1 ( string carrera )
integer x = 73
integer y = 776
integer width = 288
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar"
end type

event type integer verifica();// Juan Campos Abril-1998.

String	Nombre,Nivel_X, Carrera
Integer	Carr

Carr = Integer(em_carr.text)

SELECT carreras.carrera, carreras.nivel
INTO :Nombre, :Nivel_X
FROM carreras
WHERE carreras.cve_carrera = :Carr using gtr_sce;

If gtr_sce.sqlcode = 100 then
	messagebox("Aviso","La Carrera con clave "+em_carr.text+" no existe.")
	return 0
ElseIf gtr_sce.sqlcode = - 1 Then
	messagebox("Aviso","La Carrera con clave "+em_carr.text+" no existe."+gtr_sce.sqlerrtext)
ElseIf gtr_sce.sqlcode = 0 Then
	If( Nivel = 'A' or Nivel_X = Nivel) then
		Carrera=string(Carr,"####0000")
		If this. EVENT verIfica1(Carrera) = 1 then
 			lb_listacarr.additem(Carrera+" - "+Nombre)
			em_carr.text=''
			return 1 /* Todo esta bien */
	    Else
   		/* Ya esta en la lista */
			return 0
		End If	
	Else
		messagebox("Aviso","La Carrera NO pertenece al NIVEL seleccionado")
		Return 0
	End If	
End If	
  
		
 
end event

event verifica1;// Juan Campos Abril-1998.

Integer	Total,contador,Bandera=0
String	Textito
 
Total=lb_listacarr.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_listacarr.text(contador)
		if len(Textito) > 0 Then Textito=Mid(Textito,1,3)
	   if Carrera=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT
end if

if Bandera = 1 then
	messagebox("Aviso","La Carrera que desea introducir "+&
	                   "~r~ YA SE ENCUENTRA EN LA LISTA    ")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if


end event

event clicked;
if (em_carr.text <> '') then
		if this. EVENT verifica() = 1 then
		else
			em_carr.selectText(1, Len(em_carr.text))
			em_carr.setfocus()
		end if	  
end if
end event

type cb_2 from commandbutton within w_alum_ingreso_x_per
integer x = 2679
integer y = 796
integer width = 800
integer height = 120
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Reporte"
end type

event clicked;// Juan Campos Sánchez.    Abril-1998.

if dw_1.RowCount() > 0 Then
	dw_1.print()
Else
	Messagebox("Aviso","No hay datos para imprimir")
End if

	

 
end event

type cb_1 from commandbutton within w_alum_ingreso_x_per
integer x = 2674
integer y = 264
integer width = 800
integer height = 120
integer taborder = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Reporte"
end type

event clicked;// Juan Campos Sánchez.	Abril-1998.

String	A_Nivel[],Textito
Integer	A_Carreras[],A_Periodos[],Total,contador,i,Resta,Indice
Long		A_Anios[],AnioIni,AnioFin
 
 INTEGER le_periodos[]

le_periodos = PARENT.uo_periodo.f_recupera_seleccion() 

//If cbx_niveltodos.Checked Then
//	A_Nivel[1]= 'L'
//	A_Nivel[2]= 'P'
//ElseIf cbx_lic.Checked Then
//	A_Nivel[1]= 'L'
//ElseIf cbx_post.Checked Then
//	A_Nivel[1]= 'P'
//Else
//	Messagebox("Selecciona un nivel académico","")
//	Return
//End if

STRING ls_nivel
INTEGER le_registros, le_pos 
ls_nivel = PARENT.uo_nivel.cve_nivel 
IF ls_nivel = "A" THEN 
	le_registros = PARENT.uo_nivel.iuo_nivel_servicios.ids_niveles.ROWCOUNT() 
	FOR le_pos = 1 TO le_registros 
		A_Nivel[le_pos] = PARENT.uo_nivel.iuo_nivel_servicios.ids_niveles.GETITEMSTRING(le_pos, "cve_nivel") 
	NEXT		
ELSE
	A_Nivel[1] = ls_nivel 
END IF 

 
Total=lb_listacarr.totalitems()
if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_listacarr.text(contador)
		if len(Textito) > 0 Then Textito=Mid(Textito,1,4)
		A_Carreras[Contador] = Integer(Textito)
 	NEXT
Else
	A_Carreras[1] = 0
end if

AnioIni = Long(em_anio_ini.text)
AnioFin = Long(em_anio_fin.text)
If AnioFin >= AnioIni Then
	AnioFin ++
	Resta = AnioFin - AnioIni
	AnioIni --
	For i=1 to Resta
      A_Anios[i] = (AnioIni + i)
	Next	
Else
	Messagebox("Aviso","El año de inicio no puede ser mayor al año final.~nFavor de Verificar")
	Return
End if

// Redefine el arreglo de periodos
A_Periodos = le_periodos[]

/*
Indice=1
IF cbx_primavera.checked Then	 
	A_Periodos[Indice] = 0
End If	

IF cbx_verano.checked Then
	Indice = upperBound(A_Periodos) + 1
	A_Periodos[Indice] = 1
End If	

IF cbx_otono.checked Then
	Indice = upperBound(A_Periodos) + 1
	A_Periodos[Indice] = 2
End If	
 	

*/

If upperBound(A_Periodos) = 0 Then
	Messagebox("Aviso","No hay periodo seleccionado. ~nFavor de verificar")	
	RETURN 
End if	
	 
If dw_1.Retrieve(A_Nivel,A_Carreras,A_Anios,A_Periodos) > 0 Then
	cb_ordena.event clicked() 
Else
	Messagebox("Aviso","No hay datos con estos criterios de busqueda")	
End IF

//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_1, dwc_periodo, "academicos_periodo_ing")

end event

type gb_6 from groupbox within w_alum_ingreso_x_per
integer x = 1134
integer y = 96
integer width = 599
integer height = 452
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Periodos"
end type

type gb_5 from groupbox within w_alum_ingreso_x_per
integer x = 549
integer y = 96
integer width = 549
integer height = 452
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Año"
end type

type gb_4 from groupbox within w_alum_ingreso_x_per
integer x = 37
integer y = 552
integer width = 2560
integer height = 480
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Carreras"
end type

type gb_3 from groupbox within w_alum_ingreso_x_per
integer x = 2642
integer y = 92
integer width = 882
integer height = 912
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Selseccionar"
end type

type gb_2 from groupbox within w_alum_ingreso_x_per
integer x = 37
integer y = 96
integer width = 475
integer height = 452
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Nivel"
end type

type gb_1 from groupbox within w_alum_ingreso_x_per
integer y = 36
integer width = 3566
integer height = 1068
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "CRITERIOS DE BUSQUEDA"
end type

type gb_7 from groupbox within w_alum_ingreso_x_per
integer x = 1778
integer y = 96
integer width = 818
integer height = 452
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Orden"
end type

type cb_ordena from commandbutton within w_alum_ingreso_x_per
integer x = 2254
integer y = 224
integer width = 288
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordena"
end type

event clicked;// Juan Campos Sánchez.		Mayo-1998.


 
If cbx_alfabetico.checked Then
	dw_1.SetSort("academicos_cve_carrera A, alumnos_nombre_completo A , academicos_anio_ing A, academicos_periodo_ing A")
	dw_1.Sort()	 
	dw_1.GroupCalc ( )
	dw_1.filter() 
ElseIf cbx_cuenta.checked Then
	dw_1.SetSort("academicos_cve_carrera A, academicos_cuenta A , academicos_anio_ing A, academicos_periodo_ing A")
	dw_1.Sort()	 
	dw_1.GroupCalc ( )
	dw_1.filter()
 Else
	Messagebox("No hay un order seleccionado","Seleccione uno")		
End if
 
 


  

end event

type cbx_alfabetico from checkbox within w_alum_ingreso_x_per
integer x = 1815
integer y = 160
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Alfabético"
boolean checked = true
borderstyle borderstyle = styleraised!
end type

event clicked;This.Checked = True
cbx_cuenta.checked = False
end event

type cbx_cuenta from checkbox within w_alum_ingreso_x_per
integer x = 1815
integer y = 256
integer width = 343
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
string text = "Cuenta"
borderstyle borderstyle = styleraised!
end type

event clicked;This.Checked = True
cbx_alfabetico.checked = False
end event

