$PBExportHeader$w_mad_repo_28.srw
$PBExportComments$Ventana para el Reporte de Area - Materia
forward
global type w_mad_repo_28 from window
end type
type st_3 from statictext within w_mad_repo_28
end type
type cb_1 from commandbutton within w_mad_repo_28
end type
type dw_1 from datawindow within w_mad_repo_28
end type
type cbx_1 from checkbox within w_mad_repo_28
end type
type cb_40x from commandbutton within w_mad_repo_28
end type
type cb_20x from commandbutton within w_mad_repo_28
end type
type lb_3 from listbox within w_mad_repo_28
end type
type cb_10x from commandbutton within w_mad_repo_28
end type
type em_2x from editmask within w_mad_repo_28
end type
type gb_2 from groupbox within w_mad_repo_28
end type
type gb_10 from groupbox within w_mad_repo_28
end type
type gb_7 from groupbox within w_mad_repo_28
end type
type gb_3 from groupbox within w_mad_repo_28
end type
type gb_1 from groupbox within w_mad_repo_28
end type
end forward

global type w_mad_repo_28 from window
integer x = 832
integer y = 360
integer width = 3634
integer height = 2008
boolean titlebar = true
string title = "Reporte de Area-Materias"
string menuname = "m_repo_mad7"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
st_3 st_3
cb_1 cb_1
dw_1 dw_1
cbx_1 cbx_1
cb_40x cb_40x
cb_20x cb_20x
lb_3 lb_3
cb_10x cb_10x
em_2x em_2x
gb_2 gb_2
gb_10 gb_10
gb_7 gb_7
gb_3 gb_3
gb_1 gb_1
end type
global w_mad_repo_28 w_mad_repo_28

on w_mad_repo_28.create
if this.MenuName = "m_repo_mad7" then this.MenuID = create m_repo_mad7
this.st_3=create st_3
this.cb_1=create cb_1
this.dw_1=create dw_1
this.cbx_1=create cbx_1
this.cb_40x=create cb_40x
this.cb_20x=create cb_20x
this.lb_3=create lb_3
this.cb_10x=create cb_10x
this.em_2x=create em_2x
this.gb_2=create gb_2
this.gb_10=create gb_10
this.gb_7=create gb_7
this.gb_3=create gb_3
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.cb_1,&
this.dw_1,&
this.cbx_1,&
this.cb_40x,&
this.cb_20x,&
this.lb_3,&
this.cb_10x,&
this.em_2x,&
this.gb_2,&
this.gb_10,&
this.gb_7,&
this.gb_3,&
this.gb_1}
end on

on w_mad_repo_28.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.cbx_1)
destroy(this.cb_40x)
destroy(this.cb_20x)
destroy(this.lb_3)
destroy(this.cb_10x)
destroy(this.em_2x)
destroy(this.gb_2)
destroy(this.gb_10)
destroy(this.gb_7)
destroy(this.gb_3)
destroy(this.gb_1)
end on

event open;this.x=1
this.y=1
end event

type st_3 from statictext within w_mad_repo_28
integer x = 2958
integer y = 96
integer width = 434
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
string text = "Total  : 0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_mad_repo_28
integer x = 2208
integer y = 196
integer width = 279
integer height = 112
integer taborder = 30
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;/* Se le pasa el arreglo al datawindow*/

int Total
int contador
string Textito
long Areas[]
string Nuevo_Select,Nuevo_Select_2
string rc
int Todo


setpointer(Hourglass!)

if (cbx_1.checked = TRUE) then
	Todo = 1
else
	Todo = 0
end if

Total=lb_3.totalitems()
// Se verifica si existen Carreras
if ( Total > 0 and Todo = 0 )  then
   // Se limpian los datawindows
	dw_1.Reset() 
	contador=1
	FOR contador=1 TO Total
		Textito=lb_3.text(contador)
		Areas[contador]=integer(Textito)
  	NEXT
         
   Nuevo_Select_2=" DataWindow.Table.Select='SELECT area_mat.cve_area,"+&
        " materias.cve_mat,"+&
        " materias.materia,"+&
        " materias.creditos,"+& 
        " teoria_lab.cve_lab,"+& 
        " materias.sigla,"+&
        " materias.horas_teoria,"+&
        " materias.horas_practica, "+&
	   " materias.horas_individuales ,"+&
       " materias.horas_aula "+&
    	  " FROM area_mat,"+&
        " materias,"+&
        " teoria_lab "+&
        " WHERE ( materias.cve_mat *= teoria_lab.cve_teoria) and "+&
        " ( area_mat.cve_mat = materias.cve_mat ) and "+&
        " ( area_mat.cve_area in ( :cve_area ) ) "+ " ' "
 
	// Se Modifica el SQL para X
	rc=dw_1.Modify(Nuevo_Select_2)
	if rc="" then
		// Se realiza el retrieve  con el nuevo SQL para X
		dw_1.retrieve(Areas)
	else
		messagebox("Error en el SQL 2 ",rc)
	end if

end if


if ( Todo = 1 )  then
   // Se Fusiona el nuevo statement de SQL
   Nuevo_Select=" DataWindow.Table.Select='SELECT area_mat.cve_area,"+&
        " materias.cve_mat,"+&
        " materias.materia,"+&
        " materias.creditos,"+& 
        " teoria_lab.cve_lab,"+& 
        " materias.sigla,"+&
        " materias.horas_teoria,"+&
        " materias.horas_practica, "+&
	   " materias.horas_individuales ,"+&
       " materias.horas_aula "+&
    	  " FROM area_mat,"+&
        " materias,"+&
        " teoria_lab "+&
        " WHERE ( materias.cve_mat *= teoria_lab.cve_teoria) and "+&
        " ( area_mat.cve_mat = materias.cve_mat ) "+ " ' "
        Areas[1]=0
			// Se Modifica el SQL para X
			rc=dw_1.Modify(Nuevo_Select)
			if rc="" then
				// Se realiza el retrieve  con el nuevo SQL para X
				dw_1.retrieve(Areas)
			else
				messagebox("Error en el SQL 1 ",rc)
			end if
		  
end if

end event

type dw_1 from datawindow within w_mad_repo_28
integer x = 5
integer y = 476
integer width = 3589
integer height = 1352
string dataobject = "dw_repo_mad_28_gx"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;this.settransobject(gtr_sce)
m_repo_mad7.dw = this
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(dw_1.object.cuantos[1])
	st_3.text='Total : '+Cont
else
	st_3.text='Total : '+Cont
end if

end event

type cbx_1 from checkbox within w_mad_repo_28
integer x = 370
integer y = 340
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Todos"
end type

event clicked;setpointer(Hourglass!)

If (this.checked = TRUE) then
  em_2x.enabled = FALSE
  cb_10x.enabled = FALSE
  lb_3.enabled = FALSE
  cb_20x.enabled = FALSE
  
else
  em_2x.enabled = TRUE
  cb_10x.enabled = TRUE
  lb_3.enabled = TRUE
  cb_20x.enabled = TRUE
  
	
end if
end event

type cb_40x from commandbutton within w_mad_repo_28
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1321
integer y = 292
integer width = 279
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
int Total


setpointer(Hourglass!)
Total=lb_3.totalitems()
DO UNTIL Total=0
		lb_3.DeleteItem(1)
		
		Total=lb_3.totalitems()
LOOP


dw_1.reset()

st_3.text="Total : "+string(lb_3.totalitems())
end event

event constructor;TabOrder = 0
end event

type cb_20x from commandbutton within w_mad_repo_28
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1321
integer y = 124
integer width = 279
integer height = 108
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
string Texto
int Carrera_x
int Plan_x

setpointer(Hourglass!)

// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_3.SelectedIndex( )


// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_3.DeleteItem(li_Index)
	
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_3.SelectedIndex( )
	
	

LOOP



st_3.text="Total : "+string(lb_3.totalitems())


end event

event constructor;TabOrder = 0
end event

type lb_3 from listbox within w_mad_repo_28
event constructor pbm_constructor
event doubleclicked pbm_lbndblclk
event selectionchanged pbm_lbnselchange
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 791
integer y = 104
integer width = 457
integer height = 332
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

event doubleclicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
string Texto
int Carrera_x
int Plan_x

li_Index = lb_3.SelectedIndex( )


lb_3.DeleteItem(li_Index)



st_3.text="Total : "+string(lb_3.totalitems())
end event

event invierte_seleccion;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items - Inverting each item
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, (Not this.State(ll_item)=1) )
	Next
//	//Number of selected items
//	Return this.TotalSelected()
End If

//Not a valid operation
//Return 0
end event

event selecciona_todo;integer 	li_totalitems
long		ll_item

//Only a valid operation when MuliSelect is set to True.
If this.MultiSelect Then
	li_totalitems = this.TotalItems()
	//Loop through all items
	For ll_item = 1 to li_totalitems
		this.SetState(ll_item, True)
	Next
	//Number of selected items
//	Return li_totalitems
End If

//Not a valid operation
//Return 0
end event

type cb_10x from commandbutton within w_mad_repo_28
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( )
event type integer verifica_2 ( string depto )
integer x = 489
integer y = 144
integer width = 261
integer height = 84
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar"
end type

event clicked;/* Se verifica que exista el alumno y que no este en la lista y que su digito verificador este
correcto */
string Texto
	Texto=em_2x.text
	if (Texto <> '') then
		if this. EVENT verifica() = 1 then
			st_3.text="Total : "+string(lb_3.totalitems())
		else
			em_2x.SelectText(1, Len(em_2x.Text))
			em_2x.setfocus()
		end if	  
end if
end event

event constructor;TabOrder = 2
end event

event verifica;/* Se verifica que el Depto exista y que no se repita
en la lista*/

string Texto,Cve_Area_T
int Cve_Area_X,Cve_Area_Y


Texto=em_2x.text
Cve_Area_Y=integer(texto)

  SELECT area_mat.cve_area  
    INTO :Cve_Area_X
    FROM area_mat  
   WHERE area_mat.cve_area =: Cve_Area_Y using gtr_sce;

 	 if gtr_sce.sqlcode = 100 then
		   /* Carrera no existe */
	      messagebox("Atención","El Area con Clave: "+string(Cve_Area_Y)+" no existe.")
			return 0
	 else	
		  Cve_Area_T=string(Cve_Area_X,"####0000")
		  if (this. EVENT verifica_2(Cve_Area_T)=1) then
				lb_3.additem (string(Cve_Area_T))
				em_2x.text=''
				return 1 /* Todo esta bien */
			else
				/* Ya esta en la lista */
				return 0
			end if
			
	end if
end event

event verifica_2;/* Se verifica que no se encuentre en la lista */
int Total
int contador
string Textito
int Bandera

Bandera=0
Total=lb_3.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_3.text(contador)
	   if depto=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	messagebox("Atención","EL AREA que desea introducir "+&
	                   "~r~ YA SE ENCUENTRA EN LA LISTA ")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

type em_2x from editmask within w_mad_repo_28
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 197
integer y = 144
integer width = 247
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###xxxxxx"
string displaydata = ""
end type

event constructor;TabOrder = 1
end event

event modified;string Texto

/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_10x*/
if keydown(keyenter!) then	
	Texto=this.text
	if (Texto <> '') then
   	  cb_10x.triggerevent("clicked")
	end if	
end if

end event

type gb_2 from groupbox within w_mad_repo_28
integer x = 2171
integer y = 144
integer width = 347
integer height = 184
integer taborder = 31
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_10 from groupbox within w_mad_repo_28
integer x = 2926
integer y = 44
integer width = 494
integer height = 156
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within w_mad_repo_28
integer x = 329
integer y = 288
integer width = 325
integer height = 144
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
end type

type gb_3 from groupbox within w_mad_repo_28
integer x = 137
integer y = 56
integer width = 1554
integer height = 404
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Areas"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_mad_repo_28
integer width = 3593
integer height = 472
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Criterios de Busqueda"
borderstyle borderstyle = styleraised!
end type

