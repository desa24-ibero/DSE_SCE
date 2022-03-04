$PBExportHeader$w_asig_autmatica_de_paq.srw
forward
global type w_asig_autmatica_de_paq from window
end type
type cb_asigna from commandbutton within w_asig_autmatica_de_paq
end type
type cb_consulta from commandbutton within w_asig_autmatica_de_paq
end type
type uo_1 from uo_per_ani within w_asig_autmatica_de_paq
end type
type dw_paquetes from datawindow within w_asig_autmatica_de_paq
end type
type dw_aspirantes from datawindow within w_asig_autmatica_de_paq
end type
type gb_1 from groupbox within w_asig_autmatica_de_paq
end type
type gb_2 from groupbox within w_asig_autmatica_de_paq
end type
end forward

global type w_asig_autmatica_de_paq from window
integer x = 5
integer y = 12
integer width = 3986
integer height = 2536
boolean titlebar = true
string title = "Asignación automática de paquetes"
string menuname = "m_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
cb_asigna cb_asigna
cb_consulta cb_consulta
uo_1 uo_1
dw_paquetes dw_paquetes
dw_aspirantes dw_aspirantes
gb_1 gb_1
gb_2 gb_2
end type
global w_asig_autmatica_de_paq w_asig_autmatica_de_paq

type variables
string salones[]
int num_salones
integer ii_insertando

transaction itr_web	/* OSS 24-Ago-2011*/
end variables

forward prototypes
public function long wf_obten_paquete_a_asignar (long al_row_aspirante, ref long al_row_paquete)
public function integer wf_verifica_carreras ()
public function integer wf_verifica_paq_gpos_inexist ()
end prototypes

public function long wf_obten_paquete_a_asignar (long al_row_aspirante, ref long al_row_paquete);//wf_obten_paquete_a_asignar
//Recibe:
//long 	al_row_aspirante
//Devuelve:
//long

long ll_row_actual_aspirante, ll_rows_paquetes, ll_cve_carrera, ll_row_paquete_actual, ll_inscritos,	ll_cupo,	ll_diferencia, ll_num_paq_asignado

ll_row_actual_aspirante = al_row_aspirante

IF ll_row_actual_aspirante>0 THEN
	dw_aspirantes.ScrollToRow(ll_row_actual_aspirante)
	ll_cve_carrera = dw_aspirantes.GetItemNumber(ll_row_actual_aspirante,'clv_carr')
	ll_rows_paquetes = dw_paquetes.Retrieve(ll_cve_carrera)
	
	for ll_row_paquete_actual=1 to ll_rows_paquetes
		dw_paquetes.ScrollToRow(ll_row_paquete_actual)
		ll_inscritos = dw_paquetes.GetItemNumber(ll_row_paquete_actual, 'inscritos')
		ll_cupo = dw_paquetes.GetItemNumber(ll_row_paquete_actual, 'cupo')
		ll_diferencia = dw_paquetes.GetItemNumber(ll_row_paquete_actual, 'diferencia')
		if ll_inscritos < ll_cupo then
			ll_num_paq_asignado = dw_paquetes.GetItemNumber(ll_row_paquete_actual, 'num_paq')
			al_row_paquete = ll_row_paquete_actual
			return ll_num_paq_asignado
		end if	
	next
ELSE
	MessageBox("No hay registros","No se encontraron registros pendientes de asignar",StopSign!)
	return -1
END IF
//SOLO DEBE LLEGAR AQUI SI NO SE ENCONTRARON PAQUETES CON ESPACIO
al_row_paquete = 0
return 0


end function

public function integer wf_verifica_carreras ();integer li_result

li_result = f_valida_carrera_aspirantes (gi_anio, gi_periodo)
If li_result <> 0 Then
	If li_result = 1 Then
		OpenWithParm ( w_consulta_validaciones , 'CAR')
		return 1
	End If
	If li_result = -1 Then	
		return -1
	End If
End If

return 0
end function

public function integer wf_verifica_paq_gpos_inexist ();integer li_result

li_result = f_valida_paq_gpos_inexist(gi_anio, gi_periodo)
If li_result <> 0 Then
	If li_result = 1 Then
		OpenWithParm ( w_consulta_validaciones , 'PAQ')
		return 1
	End If
	If li_result = -1 Then	
		return -1
	End If
	
End If

return 0
end function

on w_asig_autmatica_de_paq.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_asigna=create cb_asigna
this.cb_consulta=create cb_consulta
this.uo_1=create uo_1
this.dw_paquetes=create dw_paquetes
this.dw_aspirantes=create dw_aspirantes
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_asigna,&
this.cb_consulta,&
this.uo_1,&
this.dw_paquetes,&
this.dw_aspirantes,&
this.gb_1,&
this.gb_2}
end on

on w_asig_autmatica_de_paq.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_asigna)
destroy(this.cb_consulta)
destroy(this.uo_1)
destroy(this.dw_paquetes)
destroy(this.dw_aspirantes)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;dw_paquetes.SetTransObject(gtr_sadm)
dw_aspirantes.SetTransObject(gtr_sadm)


end event

type cb_asigna from commandbutton within w_asig_autmatica_de_paq
integer x = 3401
integer y = 60
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asigna"
end type

event clicked;Integer li_respuesta, li_update_aspirantes, li_update_paquetes
Long ll_rows_aspirantes, ll_row_aspirante_actual, ll_paquete_asignado, ll_rows_asignados = 1, ll_row_paquete, ll_inscritos_nuevo, ll_inscritos

ll_rows_aspirantes = dw_aspirantes.Retrieve(gi_periodo,gi_anio )

li_respuesta = MessageBox ( "Confirme:" , "¿Desea realizar la asignación automática de paquetes de los ["+string(ll_rows_aspirantes)+"] aspirantes?" , Question! , YesNo! )

IF li_respuesta <>1 THEN RETURN

FOR ll_row_aspirante_actual = 1 TO ll_rows_aspirantes
	ll_paquete_asignado = wf_obten_paquete_a_asignar(ll_row_aspirante_actual, ll_row_paquete)
	
	IF ll_paquete_asignado > 0 THEN
		dw_aspirantes.SetItem(ll_row_aspirante_actual, 'num_paq', ll_paquete_asignado)
		dw_aspirantes.SetItem(ll_row_aspirante_actual, 'status', 2)
		ll_inscritos = dw_paquetes.GetitemNumber(ll_row_paquete,'inscritos')
		
		li_update_aspirantes = dw_aspirantes.Update()
		
		IF li_update_aspirantes = 1 THEN
			COMMIT USING gtr_sadm;
//			MessageBox ( "Actualización" , "Sa ha almacenado la asignación de aspirantes" , Information! )
		ELSE
			ROLLBACK USING gtr_sadm;
			MessageBox ( "Error" , "No se ha podido almacenar la asignación de aspirantes" , StopSign!)
		END IF
		
		ll_inscritos_nuevo = ll_inscritos + 1
		dw_paquetes.SetItem(ll_row_paquete,'inscritos', ll_inscritos_nuevo)
		li_update_paquetes = dw_paquetes.Update()
		
		IF li_update_paquetes = 1 THEN
			COMMIT USING gtr_sadm;
//			MessageBox ( "Actualización" , "Sa ha almacenado la asignación de aspirantes" , Information! )
		ELSE
			ROLLBACK USING gtr_sadm;
			MessageBox ( "Error" , "No se ha podido almacenar los paquetes" , StopSign!)
		END IF
		
		ll_rows_asignados = ll_rows_asignados +1
	END IF
NEXT

//li_respuesta = MessageBox ( "Confirme:" , "¿Desea actulizar los ["+string(ll_rows_aspirantes)+"] aspirantes?" , Question! , YesNo! )

//IF li_respuesta =1 THEN 
//	li_update_aspirantes = dw_aspirantes.Update()
//	if li_update_aspirantes= 1 then
//		COMMIT USING gtr_sadm;
//		MessageBox ( "Actualización" , "Sa ha almacenado la asignación de aspirantes" , Information! )
//	else
//		ROLLBACK USING gtr_sadm;
//		MessageBox ( "Error" , "No se ha podido almacenar la asignación de aspirantes" , StopSign!)
//	end if
//	
//END IF	


end event

type cb_consulta from commandbutton within w_asig_autmatica_de_paq
integer x = 2976
integer y = 56
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;dw_aspirantes.Retrieve(gi_periodo,gi_anio )



//Validamos que la carrera de admision sea la misma de control escolar de los aspirantes
IF wf_verifica_carreras () = -1 Then
	Return
END IF

//Validamos que la carrera de admision sea la misma de control escolar de los aspirantes
IF wf_verifica_paq_gpos_inexist () = -1 Then
	Return
END IF

end event

type uo_1 from uo_per_ani within w_asig_autmatica_de_paq
integer x = 1381
integer y = 44
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_paquetes from datawindow within w_asig_autmatica_de_paq
event actualiza ( )
event type long carga ( long clv_mat,  integer a_num_paq )
event inserta_registro ( integer a_num_paq,  long a_clv_mat )
event sel_registro ( integer a_num_paq,  long a_clv_mat )
integer x = 123
integer y = 1288
integer width = 3223
integer height = 1000
string dataobject = "d_paquetes_asignacion"
boolean vscrollbar = true
boolean livescroll = true
end type

event rowfocuschanged;SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

type dw_aspirantes from datawindow within w_asig_autmatica_de_paq
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event carga ( )
integer x = 123
integer y = 332
integer width = 3598
integer height = 780
string dataobject = "d_aspirantes_asignacion_paquetes"
boolean vscrollbar = true
boolean livescroll = true
end type

event primero;/*Ve al primer renglón*/
setcolumn(1)
setfocus()
scrolltorow(1)
end event

event anterior;/*Ve al renglón anterior*/
setcolumn(1)
setfocus()
if getrow()>1 then
	scrolltorow(getrow()-1)
end if

end event

event siguiente;/*Ve al siguiente renglón*/
setcolumn(1)
setfocus()
if getrow()<rowcount() then
	scrolltorow(getrow()+1)
end if
end event

event ultimo;/*Ve al último renglón*/
setcolumn(1)
setfocus()
scrolltorow(rowcount())
end event

event actualiza();Int		li_respuesta

dw_aspirantes.Retrieve ( gi_periodo, gi_anio )

IF dw_aspirantes.RowCount ( ) = 0 THEN
	
	MessageBox ( "Aviso:" , "No exíste información para procesar" , Information! )
	Return;
	
END IF

li_respuesta = MessageBox ( "Confirme:" , "¿Desea realizar la asignación automática de paquetes?" , Question! , YesNo! )

IF li_respuesta = 2 THEN Return

// Por cada registro, asignarle un paquete y actualizar el cupo en paquetes ...
end event

event carga();IF Retrieve (gi_periodo, gi_anio   ) = 0 THEN
	
	MessageBox ( "Aviso:" , "No existe información para los criterios seleccionados..." , Information! )
	
END IF

end event

event rowfocuschanged;//if (currentrow>0 and rowcount()>0) then
//	dw_3.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow])
//	dw_4.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow])
//	dw_2.event carga(9999,object.num_paq[currentrow])
//end if

SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

event getfocus;setcolumn(1)
end event

type gb_1 from groupbox within w_asig_autmatica_de_paq
integer x = 41
integer y = 216
integer width = 3858
integer height = 948
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aspirantes"
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_asig_autmatica_de_paq
integer x = 41
integer y = 1224
integer width = 3383
integer height = 1128
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Paquetes"
borderstyle borderstyle = stylebox!
end type

