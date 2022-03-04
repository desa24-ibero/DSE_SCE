$PBExportHeader$w_cambios_nota.srw
$PBExportComments$Se realiza el proceso de cambio de nota de alguna materia que este inscrita en la tabla de historico.  Se modifica solo la calificación.     Juan Campos Enero-1997.
forward
global type w_cambios_nota from window
end type
type st_nombre_materia from statictext within w_cambios_nota
end type
type cb_cambia_nota from commandbutton within w_cambios_nota
end type
type dw_mov_historico_materias from datawindow within w_cambios_nota
end type
type uo_nombre from uo_nombre_alumno within w_cambios_nota
end type
end forward

global type w_cambios_nota from window
integer x = 5
integer y = 4
integer width = 3378
integer height = 1656
boolean titlebar = true
string title = "CAMBIOS DE NOTA"
string menuname = "m_cambios_nota"
boolean controlmenu = true
long backcolor = 27291696
event reset ( )
st_nombre_materia st_nombre_materia
cb_cambia_nota cb_cambia_nota
dw_mov_historico_materias dw_mov_historico_materias
uo_nombre uo_nombre
end type
global w_cambios_nota w_cambios_nota

type variables
window EstaVentana
boolean  Enter=False,Tab=false
Integer RenglonTab = 1
n_cortes in_cortes
end variables

event reset;// Juan Campos. Feb-1998.

EstaVentana.SetRedraw(False)
st_nombre_materia.text =""
dw_mov_historico_materias.Reset()
dw_mov_historico_materias.InsertRow(0)
EstaVentana.SetRedraw(True)
end event

on w_cambios_nota.create
if this.MenuName = "m_cambios_nota" then this.MenuID = create m_cambios_nota
this.st_nombre_materia=create st_nombre_materia
this.cb_cambia_nota=create cb_cambia_nota
this.dw_mov_historico_materias=create dw_mov_historico_materias
this.uo_nombre=create uo_nombre
this.Control[]={this.st_nombre_materia,&
this.cb_cambia_nota,&
this.dw_mov_historico_materias,&
this.uo_nombre}
end on

on w_cambios_nota.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre_materia)
destroy(this.cb_cambia_nota)
destroy(this.dw_mov_historico_materias)
destroy(this.uo_nombre)
end on

event open;// Cambios de Nota.
// Versión 2.0. 	Por: Juan Campos Feb-1998.

This.x = 1
This.y = 1
EstaVentana = This

uo_nombre.em_cuenta.setfocus()
 
if not isvalid(in_cortes) then
	in_cortes = create n_cortes
end if
end event

event doubleclicked;// Juan Campos. Marzo-1997
  
If Long(uo_nombre.em_cuenta.text)  = 0 Then
	w_cambios_nota.uo_nombre.em_cuenta.SetFocus()
Else
   w_cambios_nota.TriggerEvent("Reset")	
	dw_mov_historico_materias.SetFocus() 
End If






end event

event close;
Rollback using gtr_sce;
//Close(this)
end event

event activate;control_escolar.toolbarsheettitle="Cambios de Nota"

end event

type st_nombre_materia from statictext within w_cambios_nota
integer x = 37
integer y = 464
integer width = 2592
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "none"
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_cambia_nota from commandbutton within w_cambios_nota
event key pbm_keydown
integer x = 2775
integer y = 880
integer width = 453
integer height = 108
integer taborder = 30
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cambia Nota"
end type

event key;if keydown(keyenter!) Then This.EVENT Clicked()
end event

event clicked;// Se valida la calificación. Cambia la calificación de la materia
// en historico. si el movimiento es exitoso, se registra en una bitácora.
// Ver 2.0. Juan Campos Feb-1998.
long cuenta
long materia
string califnueva
string ls_gpo, ls_mensaje_bloqueos = "", ls_mensaje_3r = "", ls_mensaje_4i = "", ls_mensaje_promedio = "", ls_mensaje_promedio_original = ""

dwItemStatus RowModificado
IF dw_mov_historico_materias.ModifiedCount( ) > 0 Then
	IF dw_mov_historico_materias.RowCount()>0 then
		ls_gpo = dw_mov_historico_materias.GetItemString(1,"historico_gpo")
		IF ls_gpo <> "ZZ"	then
			If Messagebox("Son correctos los datos","Desea continuar",Question!,YesNo!,1) = 1 Then	
				IF dw_mov_historico_materias.Update(True,True) = 1 Then
 					Commit using gtr_sce;
					MessageBox("Aviso","El Cambio de nota fue realizado. ")
					cuenta = dw_mov_historico_materias.GetItemNumber(1,"cuenta")
					materia = dw_mov_historico_materias.GetItemNumber(1,"historico_cve_mat")
					califnueva = dw_mov_historico_materias.GetItemString(1,"historico_calificacion")
					If Materia = 4078 Then    // actualiza bandera prerreq. ingles
						If Not Act_Bandera_Prerreq_Ingles(Cuenta,CalifNueva) then
					 		Messagebox("ATENCIÓN","La bandera de Prerrequisito de ingles NO se actualizo") 	
				  			End If
						End IF
					If Not actualiza_bandera(Cuenta,0) then // Actualiza creditos,promedio y banderas
  			    		Messagebox("ATENCIÓN","Los catálogos, Académicos, Banderas de bloqueos de servicios escolares, NO se actualizaron")
  		   	    	MessageBox("IMPORTANTE","Revisar promedio, créditos y Banderas bloqueos del alumno, en sus respectivos catálogos")		  	  
		      	End if
					integer li_corte_3r_4i, li_corte_promedio_creditos, li_baja_3_reprob, li_baja_4_insc
					long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_flag_promedio, ll_cve_flag_promedio_original
					decimal ld_promedio, ldc_creditos
					ll_cuenta = cuenta
					//Corte de 3 Reprobadas y 4 Inscripciones
					li_corte_3r_4i = in_cortes.of_corte_3r_4i(ll_cuenta, ll_cve_carrera, ll_cve_plan, li_baja_3_reprob, li_baja_4_insc)
					
					ll_cve_flag_promedio_original = in_cortes.of_obten_cve_flag_promedio(ll_cuenta)
					//Calculo de Promedios y Créditos SIN mover Banderas
					li_corte_promedio_creditos = in_cortes.of_corte_promedio_creditos_sb(ll_cuenta, ll_cve_carrera, ll_cve_plan, ld_promedio, ldc_creditos)					
					
 				Else
					Rollback using gtr_sce;
					Messagebox("Algunos datos son incorrectos","Los cambios no fueron guardados")
				End if		
			Else
				Rollback using gtr_sce;
				Messagebox("Los cambios no fueron guardados","")
			End IF	
		Else
			Rollback using gtr_sce;
			Messagebox("Grupo de Intercambio","No se permiten cambios de nota en grupos de intercambio.~nUtilice las ventanas de Intercambio Provisional/Definitivo para este efecto.",StopSign!)		
		End If
	Else
		Rollback using gtr_sce;
		Messagebox("Error","No existen materias a actualizar")		
	End If
Else
	Rollback using gtr_sce;
	Messagebox("No hay cambios para guardar","Asegurate de teclear ENTER, en la calificación")	
End if

if li_baja_3_reprob= 1 then
	ls_mensaje_3r = 'El alumno ha sido dado de baja por 3 reprobadas.~n'
else
	ls_mensaje_3r = ''
end if

if li_baja_4_insc = 1 then
	ls_mensaje_4i = 'El alumno ha sido dado de baja por 4 inscripciones.~n'
else
	ls_mensaje_4i = ''
end if

if ll_cve_flag_promedio <>0 then
	
	if ll_cve_flag_promedio_original = 1 then
		ls_mensaje_promedio_original= 'El alumno estaba AMONESTADO por promedio.~n'
	elseif ll_cve_flag_promedio_original = 2 then
		ls_mensaje_promedio_original= 'El alumno estaba DADO DE BAJA por promedio.~n'
	else
		ls_mensaje_promedio_original = ''
	end if	
		
	if ll_cve_flag_promedio = 1 then
		ls_mensaje_promedio= 'El alumno ha sido AMONESTADO por promedio.~n'
	elseif ll_cve_flag_promedio = 2 then
		ls_mensaje_promedio= 'El alumno ha sido DADO DE BAJA por promedio.~n'
	else
		ls_mensaje_promedio = ''
	end if
else
	ls_mensaje_promedio = ''
end if

if  li_baja_3_reprob= 1 or li_baja_4_insc = 1  or ll_cve_flag_promedio <>0 then
	ls_mensaje_bloqueos = ls_mensaje_3r +  ls_mensaje_4i + ls_mensaje_promedio_original+ ls_mensaje_promedio
	MessageBox("Alumno bloqueado", ls_mensaje_bloqueos, Information!)
end if


w_cambios_nota.TriggerEvent("Reset") 	 
uo_nombre.em_cuenta.SetFocus()


end event

type dw_mov_historico_materias from datawindow within w_cambios_nota
event key pbm_dwnkey
integer x = 37
integer y = 568
integer width = 2592
integer height = 876
integer taborder = 20
string dataobject = "dw_mov_historico_materias"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event key;// Juan Campos Sánchez.	 Febrero-1998.

If Key = KeyEnter! Then
	Enter = True
Else
	Enter = False
End if

If Key = KeyTab! Then
	Tab = True
Else
	Tab = False
End if





end event

event rowfocuschanged;// Juan Campos Sánchez.	 Febrero-1998.

If Enter Then
	SetRow(1)
	SetRowFocusIndicator(Hand!)  
	ScrollToRow(1)  	
Elseif Tab Then
	SetRow(RenglonTab)
	SetRowFocusIndicator(Hand!)  
	ScrollToRow(RenglonTab)  
End If

end event

event constructor;This.SetTransObject(gtr_sce)


end event

event itemchanged;// Juan Campos Sánchez.	Feb-1998.
Long Materia, ll_cuenta, ll_cve_carrera, ll_cve_plan

Accepttext()
If dwo.Name = 'historico_cve_mat' Then
	ll_cuenta = long (uo_nombre.em_cuenta.text)
	in_cortes.of_obten_carrera_plan(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	Materia = GetItemNumber(GetRow(),"historico_cve_mat")
	If Retrieve(ll_cuenta,Materia,ll_cve_carrera, ll_cve_plan) = 0 Then
      Messagebox("El alumno no tiene registrada esta materia","")		
      w_cambios_nota.TriggerEvent("Reset")
	Else
		Select materia Into :st_nombre_materia.text From materias
		Where cve_mat =:Materia using gtr_sce;
		SetColumn("historico_calificacion")
 	End if
ElseIF dwo.Name = 'historico_calificacion' Then
	RenglonTab =GetRow()
	If Tipo_evaluacion(GetItemNumber(GetRow(),"historico_cve_mat"),GetItemString(GetRow(),"historico_calificacion")) Then
		if parent.cb_cambia_nota.enabled = true then parent.cb_cambia_nota.event clicked()
		Return 0
	Else
		Return 1
	End if	
End IF


end event

event itemerror;Long Materia, ll_cuenta, ll_cve_carrera, ll_cve_plan

If RowCount() > 0 Then	
	ll_cuenta = long (uo_nombre.em_cuenta.text)
	in_cortes.of_obten_carrera_plan(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	Retrieve(ll_cuenta, GetItemNumber(GetRow(),"historico_cve_mat",Primary!,True),ll_cve_carrera, ll_cve_plan)
End if
end event

event getfocus;SetRow(1)
end event

type uo_nombre from uo_nombre_alumno within w_cambios_nota
integer x = 37
integer y = 24
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

event rbuttondown;call super::rbuttondown;w_cambios_nota.uo_nombre.em_cuenta.selecttext(1,len(w_cambios_nota.uo_nombre.text))
end event

