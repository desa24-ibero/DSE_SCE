$PBExportHeader$w_imp_kardex.srw
$PBExportComments$Ventana de impresión de kardex,  Se imprime todas las materias anteriores inscritas,creditos ,calificacion periodo,año etc Juan Campos Nov-1996
forward
global type w_imp_kardex from window
end type
type st_2 from statictext within w_imp_kardex
end type
type st_1 from statictext within w_imp_kardex
end type
type cb_carrera from commandbutton within w_imp_kardex
end type
type em_carrera from editmask within w_imp_kardex
end type
type cb_2 from commandbutton within w_imp_kardex
end type
type cb_cargar from commandbutton within w_imp_kardex
end type
type cb_1x from commandbutton within w_imp_kardex
end type
type cb_4x from commandbutton within w_imp_kardex
end type
type cb_2x from commandbutton within w_imp_kardex
end type
type em_1x from editmask within w_imp_kardex
end type
type lb_1 from listbox within w_imp_kardex
end type
type cb_impresion from commandbutton within w_imp_kardex
end type
type hsb_1 from hscrollbar within w_imp_kardex
end type
type dw_preview_kardex from datawindow within w_imp_kardex
end type
type lds_revision_est from datawindow within w_imp_kardex
end type
type lds_prueba from datawindow within w_imp_kardex
end type
type gb_1 from groupbox within w_imp_kardex
end type
end forward

global type w_imp_kardex from window
integer x = 5
integer y = 4
integer width = 3497
integer height = 1932
boolean titlebar = true
string title = "IMPRESIÓN DE KÁRDEX"
string menuname = "m_imprime_kardex"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
st_2 st_2
st_1 st_1
cb_carrera cb_carrera
em_carrera em_carrera
cb_2 cb_2
cb_cargar cb_cargar
cb_1x cb_1x
cb_4x cb_4x
cb_2x cb_2x
em_1x em_1x
lb_1 lb_1
cb_impresion cb_impresion
hsb_1 hsb_1
dw_preview_kardex dw_preview_kardex
lds_revision_est lds_revision_est
lds_prueba lds_prueba
gb_1 gb_1
end type
global w_imp_kardex w_imp_kardex

type variables
window EstaVentana
DataWindowChild ldc_revision
boolean ib_usuario_especial=false

end variables

forward prototypes
public function boolean promedio_y_creditos_nuevos (long cuenta, ref string prom, ref string cred)
end prototypes

public function boolean promedio_y_creditos_nuevos (long cuenta, ref string prom, ref string cred);// Calcula el promedio y los creditos de un alumno
// Esta Función No actualiza ninguna Tabla. 
// Juan Campos Sánchez. 21-Enero-1998.

Integer	Carrera, Plan,Creditos
Real promedio


Select cve_carrera, cve_plan Into :Carrera, :Plan From academicos 
Where cuenta = :cuenta Using gtr_sce;

If gtr_sce.sqlcode = 0 Then 
  DECLARE Emp_proc procedure for calcula_promedio
    @cuenta   = :cuenta,
    @cve_carr = :carrera, 
    @plan     = :plan,
    @promedio = :promedio out, 
    @creditos = :creditos out using gtr_sce;
	EXECUTE Emp_proc;
	IF gtr_sce.sqlcode <> 0 Then
		Goto Error
   End if
	FETCH Emp_proc INTO :promedio,:creditos;
	IF gtr_sce.sqlcode <> 0 Then
		Goto Error
   End if	
	CLOSE Emp_proc;
	IF gtr_sce.sqlcode <> 0 Then
		Goto Error
   End if	
	Prom = String(Round(Promedio, 2))
	Cred = String(Creditos)
	Return True 
Else 
	MessageBox("Error","Al obtener la carrera y el plan de este alumno"+gtr_sce.sqlerrtext)
   Return False	
End IF

Error:
	Rollback Using gtr_sce;
	Messagebox("Error al obtener promedio y creditos",gtr_sce.sqlerrtext)
	Return False
  		 
end function

on w_imp_kardex.create
if this.MenuName = "m_imprime_kardex" then this.MenuID = create m_imprime_kardex
this.st_2=create st_2
this.st_1=create st_1
this.cb_carrera=create cb_carrera
this.em_carrera=create em_carrera
this.cb_2=create cb_2
this.cb_cargar=create cb_cargar
this.cb_1x=create cb_1x
this.cb_4x=create cb_4x
this.cb_2x=create cb_2x
this.em_1x=create em_1x
this.lb_1=create lb_1
this.cb_impresion=create cb_impresion
this.hsb_1=create hsb_1
this.dw_preview_kardex=create dw_preview_kardex
this.lds_revision_est=create lds_revision_est
this.lds_prueba=create lds_prueba
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.st_1,&
this.cb_carrera,&
this.em_carrera,&
this.cb_2,&
this.cb_cargar,&
this.cb_1x,&
this.cb_4x,&
this.cb_2x,&
this.em_1x,&
this.lb_1,&
this.cb_impresion,&
this.hsb_1,&
this.dw_preview_kardex,&
this.lds_revision_est,&
this.lds_prueba,&
this.gb_1}
end on

on w_imp_kardex.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_carrera)
destroy(this.em_carrera)
destroy(this.cb_2)
destroy(this.cb_cargar)
destroy(this.cb_1x)
destroy(this.cb_4x)
destroy(this.cb_2x)
destroy(this.em_1x)
destroy(this.lb_1)
destroy(this.cb_impresion)
destroy(this.hsb_1)
destroy(this.dw_preview_kardex)
destroy(this.lds_revision_est)
destroy(this.lds_prueba)
destroy(this.gb_1)
end on

event open;// Impresión de Kardex Individual y por Carrera
// Original:   Nov-1996.
// Modificado: Fen-1998.
// Juan Campos Sánchez. 

This.x = 1
This.y = 1
EstaVentana = This 

ib_usuario_especial = f_usuario_especial(gs_usuario)

//g_nv_security.fnv_secure_window (this)
 
end event

type st_2 from statictext within w_imp_kardex
integer x = 155
integer y = 288
integer width = 325
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Por carrera:"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within w_imp_kardex
integer x = 155
integer y = 100
integer width = 320
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Por cuenta:"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_carrera from commandbutton within w_imp_kardex
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( )
event type integer verifica_2 ( string cuenta )
integer x = 992
integer y = 276
integer width = 279
integer height = 108
integer taborder = 80
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
string Carrera
	Carrera=em_carrera.text
	if (Carrera <> '') then
		if this. EVENT verifica() = 1 then
		else
			em_carrera.SelectText(1, Len(em_carrera.Text))
			em_carrera.setfocus()
		end if	  
end if
end event

event verifica;/* Se verifica que el alumno exista y que el digito verificador corresponda y que no se 
   encuentre en la lista*/

string Carrera
long Carrera_A
string Carrera_B
string s_cuenta
long l_cuenta
DataStore lds_carrera_inscritos
int i, ret = 1

Carrera=em_carrera.text
Carrera_A=long(Carrera)

SELECT carreras.carrera  
    INTO :Carrera_B  
	 FROM carreras  
	 WHERE carreras.cve_carrera = :carrera_A using gtr_sce;
if gtr_sce.sqlcode = 100 then
	messagebox("Atención","La carrera con clave "+Carrera+" no existe.")
	/* Alumno no existe */
	return 0
else
	lds_carrera_inscritos = Create DataStore
	//Si el usuario no es especial, no podra ver los alumnos de acceso restringido
	if f_usuario_especial(gs_usuario) then
		lds_carrera_inscritos.DataObject = "dw_carrera_inscritos"
	else
		lds_carrera_inscritos.DataObject = "dw_carrera_inscritos_restring"
	end if
	lds_carrera_inscritos.SetTransObject(gtr_sce)
	if lds_carrera_inscritos.Retrieve(carrera_a) > 0 then
		for i = 1 to lds_carrera_inscritos.Rowcount()
			l_cuenta = lds_carrera_inscritos.GetItemNumber(i,"academicos_cuenta")
			s_cuenta = string(l_cuenta)
			if this. EVENT verifica_2(s_cuenta) = 1 then
				s_cuenta += +" - "+string(obten_digito(l_cuenta))
				lb_1.additem (s_cuenta)
   			//lb_2.additem (Cuenta)
			else
   			/* Ya esta en la lista */
	   		ret = 0
			end if
		next
	else
		messagebox("Atención","No se encontraron alumnos con la carrera "+Carrera)
	end if
destroy lds_carrera_inscritos
em_carrera.text=''
return ret
end if

end event

event verifica_2;/* Se verifica que no se encuentre en la lista */
int Total
int contador
string Textito
int Bandera

Bandera=0
//Total=lb_2.totalitems()
Total=lb_1.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		//Textito=lb_2.text(contador)
		Textito = mid(lb_1.text(contador),1,len(lb_1.text(contador)) - 4)
	  if Cuenta=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

type em_carrera from editmask within w_imp_kardex
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 494
integer y = 284
integer width = 475
integer height = 84
integer taborder = 40
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
string displaydata = "Ä"
end type

event modified;string Carrera
/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_1x*/
if keydown(keyenter!) then	
	Carrera=this.text
	if (Carrera <> '') then
   	  cb_carrera.triggerevent("clicked")
	end if	
end if

end event

type cb_2 from commandbutton within w_imp_kardex
integer x = 2405
integer y = 60
integer width = 471
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir todos"
end type

event clicked;int total, contador
long ll_cuenta

Total=lb_1.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		lb_1.SelectItem (contador)
		cb_cargar.event clicked()
		cb_impresion. event clicked()
	NEXT

end if
end event

type cb_cargar from commandbutton within w_imp_kardex
integer x = 2405
integer y = 316
integer width = 471
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;int   res, car, pla, sub,i, li_baja_disciplina
long  cuenta
string nivel
long ll_cuenta
long ll_cve_mat
string ls_gpo
integer li_periodo
long li_anio
integer li_materia_en_intercambio_temp
long ll_row
string ls_filtro_intercambio

DatawindowChild ldc_kardex, ldc_kardexencabezado, ldc_kardexpies
if lb_1.SelectedIndex() > 0 then
	cuenta = long(mid(lb_1.SelectedItem(),1,len(lb_1.SelectedItem()) - 3))
	dw_preview_kardex.Getchild("dw_preview_kardex",ldc_kardex)
	dw_preview_kardex.Getchild("dr_kardexencabezado",ldc_kardexencabezado)
	dw_preview_kardex.Getchild("dr_kardexpies",ldc_kardexpies)
	ldc_kardex.SetTransObject(gtr_sce)
	ldc_kardexencabezado.SetTransObject(gtr_sce)
	ldc_kardexpies.SetTransObject(gtr_sce)
	if cuenta > 0 then
		SELECT a.cve_carrera, a.cve_plan, a.cve_subsistema, a.nivel, b.baja_disciplina
		INTO :car, :pla, :sub ,:Nivel, :li_baja_disciplina
			FROM academicos a, banderas b
			WHERE a.cuenta = b.cuenta AND a.cuenta = :cuenta using gtr_sce;
		if gtr_sce.sqlcode < 0 Then
     		Messagebox("Error de comunicación con la base de datos",Sqlca.sqlerrtext)
		elseif li_baja_disciplina = 0 then
			res = ldc_kardex.Retrieve(cuenta,car,pla)			
			if res >= 0 then
				FOR ll_row = 1 TO res
					ls_gpo = ldc_kardex.GetItemString(ll_row,"historico_gpo")

					if ls_gpo = "ZZ" then

						ll_cuenta = cuenta
						ll_cve_mat = ldc_kardex.GetItemNumber(ll_row,"historico_cve_mat")
						li_periodo = ldc_kardex.GetItemNumber(ll_row,"historico_periodo")
						li_anio = ldc_kardex.GetItemNumber(ll_row,"historico_anio")
	
						li_materia_en_intercambio_temp = f_materia_en_intercambio_temp(ll_cuenta, ll_cve_mat, ls_gpo, li_periodo, li_anio)
	
						if li_materia_en_intercambio_temp = 1 then
								ldc_kardex.SetItem(ll_row,"hti", li_materia_en_intercambio_temp)
						end if

					end if
				NEXT
				ls_filtro_intercambio = "hti = 0"
				ldc_kardex.SetFilter(ls_filtro_intercambio)
				ldc_kardex.Filter( )

				ldc_kardexencabezado.Retrieve(cuenta)
				ldc_kardexpies.Retrieve(cuenta)
				dw_preview_kardex.Getchild("dw_rev_est_fmc_child",ldc_revision)
				lds_revision_est.Reset()
				ldc_revision.Reset()
				lds_prueba.Reset()
				hist_alumno_areas(cuenta,car,pla,sub,lds_prueba,lds_revision_est,nivel)
				for i = 1 to lds_revision_est.Rowcount()
					ldc_revision.insertrow(0)
					ldc_revision.SetItem(i,"minimos",lds_revision_est.GetItemNumber(i,"minimos"))
					ldc_revision.SetItem(i,"cursados",lds_revision_est.GetItemNumber(i,"cursados"))
				next
			end if
		else
			Messagebox("Alumno Bloqueado por disciplina","No se puede imprimir el kardex de un alumno bloqueado por disciplina")
		end if
	else
		Messagebox("Atención","Seleccione un alumno de la lista")
	end if
else
	Messagebox("Atención","Seleccione un alumno de la lista")
end if


end event

type cb_1x from commandbutton within w_imp_kardex
event clicked pbm_bnclicked
event constructor pbm_constructor
event type integer verifica ( )
event type integer verifica_2 ( string cuenta )
integer x = 992
integer y = 92
integer width = 279
integer height = 108
integer taborder = 90
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
string Cuenta
	Cuenta=em_1x.text
	if (Cuenta <> '') then
		if this. EVENT verifica() = 1 then
		else
			em_1x.SelectText(1, Len(em_1x.Text))
			em_1x.setfocus()
		end if	  
end if
end event

event constructor;TabOrder = 2
end event

event verifica;/* Se verifica que el alumno exista y que el digito verificador corresponda y que no se 
   encuentre en la lista*/

string Digito_X
string Digito
string Cuenta
long Cuenta_A
long Cuenta_B

Cuenta=em_1x.text
Digito_X=mid(Cuenta,len(Cuenta),len(Cuenta))
Cuenta=mid(Cuenta,1,len(Cuenta)-1)
Digito=obten_digito ( long (Cuenta) )
Cuenta_A=long(Cuenta)

SELECT alumnos.cuenta  
    INTO :Cuenta_B  
	 FROM alumnos  
	 WHERE alumnos.cuenta = :Cuenta_A using gtr_sce;
	 if gtr_sce.sqlcode = 100 then
			messagebox("Atención","El alumno con clave "+string(cuenta)+" no existe.")
		   /* Alumno no existe */
			return 0
	 else		
	
		if Digito=Digito_X then
			if f_alumno_restringido(Cuenta_A) then
				if ib_usuario_especial then
					MessageBox("Usuario  Autorizado", &
					"Alumno con acceso restringido",Information!)		
				else
					MessageBox("Usuario NO Autorizado", &
		           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
					 +"Dirección de Servicios Escolares",StopSign!)
					return 0
				end if
			end if  
			
			if this. EVENT verifica_2(Cuenta) = 1 then
			   lb_1.additem (Cuenta+" - "+Digito_X)
            //lb_2.additem (Cuenta)
			   em_1x.text=''
		      return 1 /* Todo esta bien */
	      else
   			/* Ya esta en la lista */
	   		return 0
		   end if	
	 
	   else
	      /* Digito Verificador Erroneo */
         messagebox("Atención","El digito verificador es ERRONEO, favor de revisarlo")
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
//Total=lb_2.totalitems()
Total=lb_1.totalitems()

if Total > 0 then
   contador=1
	FOR contador=1 TO Total
		//Textito=lb_2.text(contador)
		Textito = mid(lb_1.text(contador),1,len(lb_1.text(contador)) - 4)
	   if Cuenta=Textito then
			Bandera=1  /*Si existe */
		end if	
	NEXT

end if

if Bandera = 1 then
	messagebox("Atención","El número de cuenta que desea introducir ~r~ "+&
	                      "        YA SE ENCUENTRA LA LISTA")
	return 0 /* Si existe */
else
	return 1 /* No existe, todo esta bien */
end if
end event

type cb_4x from commandbutton within w_imp_kardex
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1934
integer y = 256
integer width = 279
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
setpointer(Hourglass!)
int Total


Total=lb_1.totalitems()
DO UNTIL Total=0
		lb_1.DeleteItem(1)
      //lb_2.DeleteItem(1)
		Total=lb_1.totalitems()
LOOP

// Se limpia el Datawindow

//dw_1x.Reset() 
//dw_1z.Reset() 
//dw_1y.Reset() 
//st_1x.text='Total : 0'
end event

event constructor;TabOrder = 0
end event

type cb_2x from commandbutton within w_imp_kardex
event clicked pbm_bnclicked
event constructor pbm_constructor
integer x = 1934
integer y = 112
integer width = 279
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;/* Cuando se selecciona un numero de cuenta de la lista se borra */
setpointer(Hourglass!)
integer li_Index

// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_1.SelectedIndex( )

// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_1.DeleteItem(li_Index)
	//lb_2.DeleteItem(li_Index)
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_1.SelectedIndex( )
LOOP



end event

event constructor;TabOrder = 0
end event

type em_1x from editmask within w_imp_kardex
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 494
integer y = 96
integer width = 475
integer height = 84
integer taborder = 30
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
string displaydata = "Ä"
end type

event constructor;TabOrder = 1
end event

event modified;string Cuenta
string Digito_X
string Digito
/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_1x*/
if keydown(keyenter!) then	
	Cuenta=this.text
	if (Cuenta <> '') then
   	  cb_1x.triggerevent("clicked")
	end if	
end if

end event

type lb_1 from listbox within w_imp_kardex
event constructor pbm_constructor
event doubleclicked pbm_lbndblclk
event invierte_seleccion ( )
event selecciona_todo ( )
integer x = 1344
integer y = 64
integer width = 544
integer height = 372
integer taborder = 20
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;TabOrder = 0
end event

event doubleclicked;// Al hacer el doubleclick se selecciona el renglon y se borra
integer li_Index
	li_Index = lb_1.SelectedIndex( )
	lb_1.DeleteItem(li_Index)
	//lb_2.DeleteItem(li_Index)




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

type cb_impresion from commandbutton within w_imp_kardex
event clicked pbm_bnclicked
integer x = 2405
integer y = 188
integer width = 471
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Kárdex"
end type

event clicked;IF dw_preview_kardex.RowCount() > 0 Then
	dw_preview_kardex.print()
Else
	Messagebox("Aviso","No hay datos para imprimir")
End IF
end event

type hsb_1 from hscrollbar within w_imp_kardex
event constructor pbm_constructor
event lineleft pbm_sbnlineup
event lineright pbm_sbnlinedown
integer x = 3067
integer y = 308
integer width = 215
integer height = 108
boolean bringtotop = true
boolean stdheight = false
end type

event constructor;TabOrder = 0
end event

event lineleft;dw_preview_kardex.ScrollPriorPage ( ) 
end event

event lineright;dw_preview_kardex.ScrollNextPage ( ) 

end event

type dw_preview_kardex from datawindow within w_imp_kardex
event constructor pbm_constructor
event retrieveend pbm_dwnretrieveend
integer x = 37
integer y = 492
integer width = 3401
integer height = 1260
integer taborder = 140
string dataobject = "dw_composite_kardex"
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(gtr_sce)
//This.object.fecha_hoy.text =Mid(fecha_espaniol_servidor(),1,11)
end event

event retrieveend;//// Juan Campos Sánchez.  21-Enero-1998
//
//IF rowcount() > 0 Then
//	Long	Cuenta,Job
//	Real	Promedio = 0
//	Int	Creditos = 0
//	String Nom,Apat,AMat
//	Cuenta = GetItemNumber(GetRow(),"academicos_cuenta")
//	If Promedio_y_Creditos_Nuevos(Cuenta,Promedio,Creditos) Then
//		This.object.promedio.text = String(Round(Promedio,2))
//		This.object.creditos.text = String(Creditos)
//  		Nom  = w_imp_kardex.uo_nombre.dw_nombre_alumno.GetItemString(1,"nombre")
//  		APat = w_imp_kardex.uo_nombre.dw_nombre_alumno.GetItemString(1,"apaterno")
//  		AMat = w_imp_kardex.uo_nombre.dw_nombre_alumno.GetItemString(1,"amaterno")
//      This.object.nombre_completo.text = Nom+" "+APat+" "+AMat
//      This.object.cuenta_digito.text = String(Cuenta)+"-"+obten_digito(Cuenta)	
//	Else
//		Messagebox("Error al calcular promedio y créditos","Favor de revisar con detalle el promedio y créditos de este alumno")
//	End if
//End IF
end event

type lds_revision_est from datawindow within w_imp_kardex
boolean visible = false
integer x = 1874
integer y = 1692
integer width = 489
integer height = 76
integer taborder = 130
string dataobject = "dw_rev_est_fmc"
boolean vscrollbar = true
boolean livescroll = true
end type

type lds_prueba from datawindow within w_imp_kardex
boolean visible = false
integer x = 2391
integer y = 1692
integer width = 494
integer height = 68
integer taborder = 120
string dataobject = "dw_certificado_ext2"
boolean livescroll = true
end type

type gb_1 from groupbox within w_imp_kardex
integer x = 50
integer y = 4
integer width = 2203
integer height = 464
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Cuentas a Imprimir"
end type

