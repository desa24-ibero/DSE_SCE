$PBExportHeader$w_mad_repo_26.srw
$PBExportComments$Ventana para el Reporte Materias
forward
global type w_mad_repo_26 from w_master_main_rep
end type
type dw_depto_7 from datawindow within w_mad_repo_26
end type
type tab_1 from tab within w_mad_repo_26
end type
type tabpage_general from userobject within tab_1
end type
type uo_nivel from uo_nivel_2013 within tabpage_general
end type
type dw_depto_6 from datawindow within tabpage_general
end type
type cbx_1 from checkbox within tabpage_general
end type
type lb_3 from listbox within tabpage_general
end type
type em_2x from editmask within tabpage_general
end type
type cb_10x from commandbutton within tabpage_general
end type
type rb_5 from radiobutton within tabpage_general
end type
type st_1 from statictext within tabpage_general
end type
type cb_1 from commandbutton within tabpage_general
end type
type cbx_6 from checkbox within tabpage_general
end type
type dw_2z from datawindow within tabpage_general
end type
type rb_7 from radiobutton within tabpage_general
end type
type rb_1 from radiobutton within tabpage_general
end type
type rb_2 from radiobutton within tabpage_general
end type
type rb_3 from radiobutton within tabpage_general
end type
type rb_4 from radiobutton within tabpage_general
end type
type rb_6 from radiobutton within tabpage_general
end type
type gb_2 from groupbox within tabpage_general
end type
type gb_4 from groupbox within tabpage_general
end type
type gb_7 from groupbox within tabpage_general
end type
type gb_8 from groupbox within tabpage_general
end type
type cb_20x from commandbutton within tabpage_general
end type
type cb_40x from commandbutton within tabpage_general
end type
type gb_3 from groupbox within tabpage_general
end type
type gb_1 from groupbox within tabpage_general
end type
type lb_4 from listbox within tabpage_general
end type
type dw_2x from datawindow within tabpage_general
end type
type tabpage_general from userobject within tab_1
uo_nivel uo_nivel
dw_depto_6 dw_depto_6
cbx_1 cbx_1
lb_3 lb_3
em_2x em_2x
cb_10x cb_10x
rb_5 rb_5
st_1 st_1
cb_1 cb_1
cbx_6 cbx_6
dw_2z dw_2z
rb_7 rb_7
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_6 rb_6
gb_2 gb_2
gb_4 gb_4
gb_7 gb_7
gb_8 gb_8
cb_20x cb_20x
cb_40x cb_40x
gb_3 gb_3
gb_1 gb_1
lb_4 lb_4
dw_2x dw_2x
end type
type tab_1 from tab within w_mad_repo_26
tabpage_general tabpage_general
end type
type dw_depto_0 from datawindow within w_mad_repo_26
end type
type dw_depto_5 from datawindow within w_mad_repo_26
end type
type dw_depto_4 from datawindow within w_mad_repo_26
end type
type dw_depto_3 from datawindow within w_mad_repo_26
end type
type dw_depto_2 from datawindow within w_mad_repo_26
end type
type dw_depto_1 from datawindow within w_mad_repo_26
end type
end forward

global type w_mad_repo_26 from w_master_main_rep
integer x = 9
integer y = 4
integer width = 3781
integer height = 2744
string title = "Reporte de Materias"
string menuname = "m_repo_mad7"
boolean resizable = true
dw_depto_7 dw_depto_7
tab_1 tab_1
dw_depto_0 dw_depto_0
dw_depto_5 dw_depto_5
dw_depto_4 dw_depto_4
dw_depto_3 dw_depto_3
dw_depto_2 dw_depto_2
dw_depto_1 dw_depto_1
end type
global w_mad_repo_26 w_mad_repo_26

type variables
string nivel
string division_x
int periodo_x

end variables

forward prototypes
public subroutine separa_cve_grupo (string texto, ref long cve_mat, ref string grupo)
end prototypes

public subroutine separa_cve_grupo (string texto, ref long cve_mat, ref string grupo);string Texto_Temporal
int Longitud,Posicion

Posicion=Pos(texto, "-")
Texto_Temporal=Left(texto,(Posicion - 1))
cve_mat = long(Texto_Temporal)

Longitud=Len(Texto)
Longitud=Longitud - Posicion

Texto_Temporal=Right(Texto, Longitud)
grupo = upper(Texto_Temporal)

end subroutine

on w_mad_repo_26.create
int iCurrent
call super::create
if this.MenuName = "m_repo_mad7" then this.MenuID = create m_repo_mad7
this.dw_depto_7=create dw_depto_7
this.tab_1=create tab_1
this.dw_depto_0=create dw_depto_0
this.dw_depto_5=create dw_depto_5
this.dw_depto_4=create dw_depto_4
this.dw_depto_3=create dw_depto_3
this.dw_depto_2=create dw_depto_2
this.dw_depto_1=create dw_depto_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_depto_7
this.Control[iCurrent+2]=this.tab_1
this.Control[iCurrent+3]=this.dw_depto_0
this.Control[iCurrent+4]=this.dw_depto_5
this.Control[iCurrent+5]=this.dw_depto_4
this.Control[iCurrent+6]=this.dw_depto_3
this.Control[iCurrent+7]=this.dw_depto_2
this.Control[iCurrent+8]=this.dw_depto_1
end on

on w_mad_repo_26.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_depto_7)
destroy(this.tab_1)
destroy(this.dw_depto_0)
destroy(this.dw_depto_5)
destroy(this.dw_depto_4)
destroy(this.dw_depto_3)
destroy(this.dw_depto_2)
destroy(this.dw_depto_1)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/

tab_1.tabpage_general.dw_2z.settransobject(gtr_sce)
tab_1.tabpage_general.dw_2x.settransobject(gtr_sce)



/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1
nivel = 'T'
division_x = 'T'

tab_1.tabpage_general.uo_nivel.of_carga_control(gtr_sce)
end event

type st_sistema from w_master_main_rep`st_sistema within w_mad_repo_26
end type

type p_ibero from w_master_main_rep`p_ibero within w_mad_repo_26
end type

type dw_depto_7 from datawindow within w_mad_repo_26
boolean visible = false
integer x = 160
integer y = 1472
integer width = 690
integer height = 364
integer taborder = 71
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(3000)
end event

type tab_1 from tab within w_mad_repo_26
event selectionchanged pbm_tcnselchanged
event create ( )
event destroy ( )
integer x = 9
integer y = 332
integer width = 3602
integer height = 2100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean fixedwidth = true
boolean raggedright = true
boolean boldselectedtext = true
tabposition tabposition = tabsonleft!
alignment alignment = center!
integer selectedtab = 1
tabpage_general tabpage_general
end type

event selectionchanged;/* Se asignan los datawindows dependiendo del TAB al menu, para poder imprimirlos */
if newindex = 1 then
	
   m_repo_mad7.dw = tab_1.tabpage_general.dw_2x
   
	 tab_1.tabpage_general.gb_1.taborder =0


	 tab_1.tabpage_general.gb_3.taborder =0
	 tab_1.tabpage_general.gb_4.taborder =0
//	 tab_1.tabpage_general.gb_5.taborder =0


	 tab_1.tabpage_general.gb_7.taborder =0
	 tab_1.tabpage_general.gb_8.taborder =0

end if

end event

on tab_1.create
this.tabpage_general=create tabpage_general
this.Control[]={this.tabpage_general}
end on

on tab_1.destroy
destroy(this.tabpage_general)
end on

type tabpage_general from userobject within tab_1
event create ( )
event destroy ( )
integer x = 128
integer y = 16
integer width = 3456
integer height = 2068
long backcolor = 16777215
string text = "General"
long tabtextcolor = 33554432
long tabbackcolor = 15780518
string picturename = "Custom045!"
long picturemaskcolor = 553648127
uo_nivel uo_nivel
dw_depto_6 dw_depto_6
cbx_1 cbx_1
lb_3 lb_3
em_2x em_2x
cb_10x cb_10x
rb_5 rb_5
st_1 st_1
cb_1 cb_1
cbx_6 cbx_6
dw_2z dw_2z
rb_7 rb_7
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_6 rb_6
gb_2 gb_2
gb_4 gb_4
gb_7 gb_7
gb_8 gb_8
cb_20x cb_20x
cb_40x cb_40x
gb_3 gb_3
gb_1 gb_1
lb_4 lb_4
dw_2x dw_2x
end type

on tabpage_general.create
this.uo_nivel=create uo_nivel
this.dw_depto_6=create dw_depto_6
this.cbx_1=create cbx_1
this.lb_3=create lb_3
this.em_2x=create em_2x
this.cb_10x=create cb_10x
this.rb_5=create rb_5
this.st_1=create st_1
this.cb_1=create cb_1
this.cbx_6=create cbx_6
this.dw_2z=create dw_2z
this.rb_7=create rb_7
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_6=create rb_6
this.gb_2=create gb_2
this.gb_4=create gb_4
this.gb_7=create gb_7
this.gb_8=create gb_8
this.cb_20x=create cb_20x
this.cb_40x=create cb_40x
this.gb_3=create gb_3
this.gb_1=create gb_1
this.lb_4=create lb_4
this.dw_2x=create dw_2x
this.Control[]={this.uo_nivel,&
this.dw_depto_6,&
this.cbx_1,&
this.lb_3,&
this.em_2x,&
this.cb_10x,&
this.rb_5,&
this.st_1,&
this.cb_1,&
this.cbx_6,&
this.dw_2z,&
this.rb_7,&
this.rb_1,&
this.rb_2,&
this.rb_3,&
this.rb_4,&
this.rb_6,&
this.gb_2,&
this.gb_4,&
this.gb_7,&
this.gb_8,&
this.cb_20x,&
this.cb_40x,&
this.gb_3,&
this.gb_1,&
this.lb_4,&
this.dw_2x}
end on

on tabpage_general.destroy
destroy(this.uo_nivel)
destroy(this.dw_depto_6)
destroy(this.cbx_1)
destroy(this.lb_3)
destroy(this.em_2x)
destroy(this.cb_10x)
destroy(this.rb_5)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cbx_6)
destroy(this.dw_2z)
destroy(this.rb_7)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_6)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.gb_7)
destroy(this.gb_8)
destroy(this.cb_20x)
destroy(this.cb_40x)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.lb_4)
destroy(this.dw_2x)
end on

type uo_nivel from uo_nivel_2013 within tabpage_general
event destroy ( )
integer x = 1755
integer y = 52
integer taborder = 30
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type dw_depto_6 from datawindow within tabpage_general
boolean visible = false
integer x = 41
integer y = 1152
integer width = 690
integer height = 364
integer taborder = 71
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(2000)
end event

type cbx_1 from checkbox within tabpage_general
integer x = 2450
integer y = 196
integer width = 654
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Agrupación por Depto"
boolean checked = true
end type

event constructor;taborder = 0
end event

type lb_3 from listbox within tabpage_general
event constructor pbm_constructor
event doubleclicked pbm_lbndblclk
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 654
integer y = 448
integer width = 1728
integer height = 352
integer taborder = 82
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean hscrollbar = true
boolean vscrollbar = true
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

event doubleclicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index

li_Index = lb_3.SelectedIndex( )
lb_3.DeleteItem(li_Index)
lb_4.DeleteItem(li_Index)

// Se deselecciona la opcion de "Todas las Carreras"
if (cbx_6.checked = TRUE) then
  	 cbx_6.checked = FALSE
end if
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

type em_2x from editmask within tabpage_general
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 64
integer y = 488
integer width = 247
integer height = 84
integer taborder = 61
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

event modified;string Departamento

/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_10x*/
if keydown(keyenter!) then	
	Departamento=this.text
	if (Departamento <> '') then
   	  cb_10x.triggerevent("clicked")
	end if	
end if

end event

type cb_10x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( )
event type integer verifica_2 ( string depto )
integer x = 361
integer y = 488
integer width = 261
integer height = 84
integer taborder = 61
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
string Depto
	Depto=em_2x.text
	if (Depto <> '') then
		if this. EVENT verifica() = 1 then
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

string Depto,Nombre
int Depto_A,Depto_B,Division_X2
Depto=em_2x.text
Depto_A=integer(Depto)

  SELECT coordinaciones.cve_coordinacion, coordinaciones.coordinacion, departamentos.cve_division  
    INTO :Depto_B, :Nombre, :Division_X2 
    FROM departamentos, coordinaciones
	 WHERE coordinaciones.cve_depto = departamentos.cve_depto AND
	 	coordinaciones.cve_coordinacion = :Depto_A using gtr_sce;

 	 if gtr_sce.sqlcode = 100 then
		   /* Depto no existe */
	      messagebox("Atención","La Coordinación con clave "+Depto+" no existe.")
			return 0
	 else		
   	Depto=string(Depto_A,"####0000")
	// Se verifica la Division Seleccionada
      if( division_x = 'T' or Division_X2  = integer(division_x)) then
			if this. EVENT verifica_2(Depto) = 1 then
			   lb_4.additem (Depto)
				lb_3.additem (Depto+" - "+Nombre)
			   em_2x.text=''
		      return 1 /* Todo esta bien */
	      else
   			/* Ya esta en la lista */
	   		return 0
		   end if	
		else
			// Division del Depto Erroneo
			messagebox("Atención","La Coordinación NO pertenece a la DIVISION seleccionada")
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
Total=lb_4.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		Textito=lb_4.text(contador)
	   if depto=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	messagebox("Atención","La Coordinación que desea introducir "+&
	                   "~r~ YA SE ENCUENTRA LA LISTA    ")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

type rb_5 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 549
integer y = 176
integer width = 443
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Planteles"
end type

event clicked;division_x='5'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(5,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type st_1 from statictext within tabpage_general
event constructor pbm_constructor
integer x = 2450
integer y = 52
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

type cb_1 from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2921
integer y = 368
integer width = 306
integer height = 92
integer taborder = 61
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
string Textito
int Agrupa

int Departamentos[]

string ls_array_nivel[]

setpointer(Hourglass!)

Total=lb_4.totalitems()
// Se verifica si existen Carreras
if ( Total > 0 )  then
   // Se limpian los datawindows
	dw_2x.Reset() 
	dw_2z.Reset()
	contador=1
	FOR contador=1 TO Total
		Textito=lb_4.text(contador)
		Departamentos[contador]=integer(Textito)
  	NEXT
  
//	if nivel='T' then
//        Nivel_X[1]='L'
//		  Nivel_X[2]='P'
//	else
//		  Nivel_X[1]=nivel
//	end if
//	


tab_1.tabpage_general.uo_nivel.of_carga_arreglo_nivel( )
tab_1.tabpage_general.uo_nivel.of_obtiene_array( ls_array_nivel[])

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox(" Error ","Debe seleccionar un nivel",StopSign!)
	return
End If

   if (cbx_1.checked = TRUE ) then
		Agrupa = 1
	else
		Agrupa = 2
	end if
	
	dw_2x.retrieve(Agrupa,Departamentos,ls_array_nivel[])
	dw_2z.retrieve(Agrupa,Departamentos,ls_array_nivel[])
end if

end event

event constructor;TabOrder = 5
end event

type cbx_6 from checkbox within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event limpia ( )
integer x = 242
integer y = 680
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Todos"
end type

event clicked;// Se verifica que tipo de carrera se desea insertar
int total, cont
setpointer(Hourglass!)

If (this.checked = TRUE) then
	// Se limpian los datos
	this. EVENT limpia()
	if division_x = 'T' then
// Se insertan todos los Departamentos en las listas		
		if dw_depto_0.rowcount() > 0 then
			total=dw_depto_0.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_0.object.coordinacion[cont]))
			NEXT			
		end if
			
		if dw_depto_1.rowcount() > 0 then
			total=dw_depto_1.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_1.object.coordinacion[cont]))
			NEXT			
		end if
		
		if dw_depto_2.rowcount() > 0 then
			total=dw_depto_2.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_2.object.coordinacion[cont]))
			NEXT			
		end if
		
		if dw_depto_3.rowcount() > 0 then
			total=dw_depto_3.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_3.object.coordinacion[cont]))
			NEXT			
		end if
		if dw_depto_4.rowcount() > 0 then
			total=dw_depto_4.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_4.object.coordinacion[cont]))
			NEXT			
		end if
		if dw_depto_5.rowcount() > 0 then
			total=dw_depto_5.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_5.object.coordinacion[cont]))
			NEXT			
		end if
		if dw_depto_6.rowcount() > 0 then
			total=dw_depto_6.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_6.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_6.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_6.object.coordinacion[cont]))
			NEXT			
		end if
		if dw_depto_7.rowcount() > 0 then
			total=dw_depto_7.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_7.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_7.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_7.object.coordinacion[cont]))
			NEXT			
		end if
		
	end if
	
	if division_x = '0' then
		// Se insertan todos los departamentos (Sin Division)		
		if dw_depto_0.rowcount() > 0 then
			total=dw_depto_0.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_0.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_0.object.coordinacion[cont]))
			NEXT			
		end if
		
	end if		
	if division_x = '1' then
			// Se insertan todos los departamentos (Arte)
			
		if dw_depto_1.rowcount() > 0 then
			total=dw_depto_1.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_1.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_1.object.coordinacion[cont]))
			NEXT			
		end if
		
	end if

	if division_x = '2' then
		// Se insertan todos los departamentos (C. Econom. Admon.)		
		if dw_depto_2.rowcount() > 0 then
			total=dw_depto_2.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_2.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_2.object.coordinacion[cont]))
			NEXT			
		end if
		

	end if

	if division_x = '3' then
			// Se insertan todos los departamentos (Ciencias e Ing.)
		if dw_depto_3.rowcount() > 0 then
			total=dw_depto_3.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_3.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_3.object.coordinacion[cont]))
			NEXT			
		end if
		
	end if
	if division_x = '4' then
		// Se insertan todos los departamentos (Ciencias del Hombre)		
		if dw_depto_4.rowcount() > 0 then
			total=dw_depto_4.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_4.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_4.object.coordinacion[cont]))
			NEXT			
		end if
	end if

	if division_x = '5' then
			// Se insertan todos los departamentos (Humanidades)
		if dw_depto_5.rowcount() > 0 then
			total=dw_depto_5.rowcount()
			FOR cont=1 TO total
				lb_4.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000"))
				lb_3.additem (string(dw_depto_5.object.cve_coordinacion[cont],"###000")+" - "+string(dw_depto_5.object.coordinacion[cont]))
			NEXT			
		end if
		
	end if

else
	// Se Limpian las listas, para evitar duplicidad
	this. EVENT limpia()
end if	


end event

event constructor;TabOrder = 0
end event

event limpia;// Se limpian los datos de las listas
int Total
long Number[]
setpointer(Hourglass!)
Total=lb_3.totalitems()
DO UNTIL Total=0
		lb_3.DeleteItem(1)
		lb_4.DeleteItem(1)
		Total=lb_3.totalitems()
LOOP
end event

type dw_2z from datawindow within tabpage_general
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
integer y = 848
integer width = 3447
integer height = 1224
integer taborder = 61
string dataobject = "dw_repo_mad_26_gz"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event constructor;TabOrder = 0
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


string Cont
Cont = '0'
/*Verifica si se bajo más de un dato*/
if rowcount >= 1 then
	// Se actualiza el numero de datos traidos
	Cont =string(this.rowcount())
	st_1.text='Total : '+Cont
else
	st_1.text='Total : '+Cont
end if

//this.Object.DataWindow.Zoom = 76
end event

type rb_7 from radiobutton within tabpage_general
event clicked pbm_bnclicked
integer x = 585
integer y = 240
integer width = 283
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "TODAS"
boolean checked = true
end type

event clicked;division_x = 'T'

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()

end if

end event

event constructor;TabOrder = 0
end event

type rb_1 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 32
integer y = 112
integer width = 471
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Estudios Disc."
end type

event clicked;division_x='1'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(1,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type rb_2 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 549
integer y = 112
integer width = 494
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Historia"
end type

event clicked;division_x='2'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(2,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type rb_3 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 1120
integer y = 112
integer width = 494
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Vicerrectoria"
end type

event clicked;division_x='3'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(3,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type rb_4 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 32
integer y = 176
integer width = 475
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Centros"
end type

event clicked;division_x='4'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(4,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type rb_6 from radiobutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( integer source_dw,  string depto_x )
integer x = 1120
integer y = 176
integer width = 494
integer height = 56
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Estudios Prof"
end type

event clicked;division_x='0'
setpointer(Hourglass!)
int li_Index
int Total
int Contador
string Depto_A,Depto_B

if (cbx_6.checked = TRUE) then
    cbx_6. EVENT clicked()
else

 
	Total=lb_4.totalitems()

  
	DO UNTIL Total=0
  	     Depto_A=lb_4.text(Total)
		 
		  if (this. EVENT verifica(0,Depto_A) = 1 ) then
		     // Si existe, esta Bien
		  else
			  // No existe, hay que borrarlo
			   lb_3.DeleteItem(Total)
				lb_4.DeleteItem(Total)
				Total=lb_4.totalitems()
				Total++
	     end if
		   Total --
	LOOP
end if
end event

event constructor;TabOrder = 0
end event

event verifica;int Cont
int Bandera,Stop

if (source_dw = 0) then
	if dw_depto_0.rowcount() > 0 then
	     Stop=dw_depto_0.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_0.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 1) then
	if dw_depto_1.rowcount() > 0 then
	     Stop=dw_depto_1.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_1.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1 // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 2) then
	if dw_depto_2.rowcount() > 0 then
	     Stop=dw_depto_2.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_2.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 3) then
	if dw_depto_3.rowcount() > 0 then
	     Stop=dw_depto_3.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_3.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 4) then
	if dw_depto_4.rowcount() > 0 then
	     Stop=dw_depto_4.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_4.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

if (source_dw = 5) then
	if dw_depto_5.rowcount() > 0 then
	     Stop=dw_depto_5.rowcount()
			  FOR Cont=1 TO Stop
				  if integer(depto_x)=dw_depto_5.object.cve_depto[Cont] then
					  Bandera=1
      	     end if
		     NEXT
			 if Bandera=1 then
				  return 1  // Si existe
			 else
				  return 0  // No existe
          end if
   end if
	
end if

// Si existe un error
messagebox("Error","Alguna de las tablas esta vacia, favor de consultar al administrador",StopSign!)
return 0

end event

type gb_2 from groupbox within tabpage_general
integer x = 2400
integer y = 156
integer width = 759
integer height = 132
integer taborder = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_general
integer x = 18
integer y = 52
integer width = 1669
integer height = 252
integer taborder = 81
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "División"
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within tabpage_general
integer x = 197
integer y = 632
integer width = 325
integer height = 144
integer taborder = 63
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
end type

type gb_8 from groupbox within tabpage_general
integer x = 2889
integer y = 320
integer width = 366
integer height = 156
integer taborder = 62
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

type cb_20x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2414
integer y = 480
integer width = 261
integer height = 100
integer taborder = 61
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
integer li_Index
setpointer(Hourglass!)
// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_3.SelectedIndex( )
// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_3.DeleteItem(li_Index)
	lb_4.DeleteItem(li_Index)
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_3.SelectedIndex( )
LOOP

// Se deselecciona la opcion de "Todas las Carreras"
if (cbx_6.checked = TRUE) then
  	 cbx_6.checked = FALSE
end if


end event

event constructor;TabOrder = 0
end event

type cb_40x from commandbutton within tabpage_general
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 2414
integer y = 632
integer width = 261
integer height = 100
integer taborder = 62
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
		lb_4.DeleteItem(1)
		Total=lb_3.totalitems()
LOOP

// Se deselecciona la opcion de "Todas las Carreras"
if (cbx_6.checked = TRUE) then
  	 cbx_6.checked = FALSE
end if


dw_2z.Reset()
dw_2x.Reset()
st_1.text='Total Gen. : 0'

end event

event constructor;TabOrder = 0
end event

type gb_3 from groupbox within tabpage_general
integer x = 18
integer y = 392
integer width = 2693
integer height = 428
integer taborder = 84
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Coordinaciones"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_general
integer width = 3447
integer height = 848
integer taborder = 1
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

type lb_4 from listbox within tabpage_general
event constructor pbm_constructor
integer x = 2725
integer y = 652
integer width = 91
integer height = 76
integer taborder = 62
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

type dw_2x from datawindow within tabpage_general
integer x = 82
integer y = 2000
integer width = 494
integer height = 364
integer taborder = 62
string dataobject = "dw_repo_mad_26_gx"
boolean livescroll = true
end type

type dw_depto_0 from datawindow within w_mad_repo_26
event constructor pbm_constructor
boolean visible = false
integer x = 4498
integer y = 1176
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(1000)
end event

type dw_depto_5 from datawindow within w_mad_repo_26
event constructor pbm_constructor
boolean visible = false
integer x = 3726
integer y = 1160
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(9000)
end event

type dw_depto_4 from datawindow within w_mad_repo_26
event constructor pbm_constructor
boolean visible = false
integer x = 4562
integer y = 764
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(7000)
end event

type dw_depto_3 from datawindow within w_mad_repo_26
event constructor pbm_constructor
boolean visible = false
integer x = 3712
integer y = 760
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(6000)
end event

type dw_depto_2 from datawindow within w_mad_repo_26
event constructor pbm_constructor
boolean visible = false
integer x = 4549
integer y = 384
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(5000)
end event

type dw_depto_1 from datawindow within w_mad_repo_26
boolean visible = false
integer x = 3730
integer y = 352
integer width = 690
integer height = 364
string dataobject = "dw_fmc_coordinacion"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
retrieve(4000)
end event

