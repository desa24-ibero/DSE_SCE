$PBExportHeader$w_resultado_examen_individual_2017.srw
$PBExportComments$Altas, bajas, despliegue, consulta y modificación de datos básicos de un aspirante.
forward
global type w_resultado_examen_individual_2017 from w_main
end type
type dw_res_examen_global from datawindow within w_resultado_examen_individual_2017
end type
type cb_4 from commandbutton within w_resultado_examen_individual_2017
end type
type uo_nombre from uo_nombre_aspirante2 within w_resultado_examen_individual_2017
end type
type cb_3 from commandbutton within w_resultado_examen_individual_2017
end type
type cb_1 from commandbutton within w_resultado_examen_individual_2017
end type
type dw_solicitud from datawindow within w_resultado_examen_individual_2017
end type
type cb_2 from commandbutton within w_resultado_examen_individual_2017
end type
type dw_1 from datawindow within w_resultado_examen_individual_2017
end type
type dw_3 from datawindow within w_resultado_examen_individual_2017
end type
type dw_2 from datawindow within w_resultado_examen_individual_2017
end type
end forward

global type w_resultado_examen_individual_2017 from w_main
integer x = 5
integer y = 4
integer width = 3758
integer height = 2664
string title = "Resultado de Examen Individual"
string menuname = "m_resultado_examen_individual"
boolean ib_disableclosequery = true
dw_res_examen_global dw_res_examen_global
cb_4 cb_4
uo_nombre uo_nombre
cb_3 cb_3
cb_1 cb_1
dw_solicitud dw_solicitud
cb_2 cb_2
dw_1 dw_1
dw_3 dw_3
dw_2 dw_2
end type
global w_resultado_examen_individual_2017 w_resultado_examen_individual_2017

type variables
string st_salones[]
int in_num_salones
boolean ib_nueva_insercion = false
st_confirma_usuario ist_confirma_usuario 


DATASTORE ids_parametros_area_examen2017



end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
public function integer wf_valida_folio (boolean ab_nueva_insercion)
public function integer f_carga_detalle_default (long folio)
public function integer f_calcula_calificaciones ()
end prototypes

public function long obten_foto (long cuenta, ref string foto);return 0
end function

public function integer wf_valida_folio (boolean ab_nueva_insercion);//wf_valida_folio()
//boolean 	ab_nueva_insercion

//uo_nombre.cbx_nuevo.Checked = FALSE
long ll_rowcount_3, ll_folio_test_vocacional, ll_folio, ll_rowcount_2, ll_row
integer li_clv_ver, li_clv_per, li_anio, li_pago_exam
long al_ref_folio
integer ai_ref_clv_ver, ai_ref_clv_per, ai_ref_anio, li_existe_folio_test_vocacional
string as_ref_apaterno, as_ref_amaterno,	as_ref_nombre	
integer li_dw_2_Update, li_dw_3_Update
decimal ld_area_1, ld_area_2, ld_area_3, ld_area_4, ld_area_5
ll_rowcount_3 = dw_3.RowCount()
ll_rowcount_2 = dw_2.RowCount()

//Valida que ya se haya insertado un folio
if ab_nueva_insercion then
	//Si se desea guardar un registro exige que se este insertando
	if ll_rowcount_3 = 0 then
		MessageBox("Error de Inserción", "Favor de Insertar antes de actualizar",StopSign!)
		return -1
	end if
else
	//Si no es una inserción esta bien...
	if ll_rowcount_3 = 0 then
		return 0
	end if
end if

dw_3.AcceptText()


//ll_folio = dw_3.GetItemNumber(ll_rowcount_3,"folio")
//li_clv_ver = dw_3.GetItemNumber(ll_rowcount_3,"clv_ver")
//li_clv_per = dw_3.GetItemNumber(ll_rowcount_3,"clv_per")
//li_anio = dw_3.GetItemNumber(ll_rowcount_3,"anio")

for ll_row=1 to ll_rowcount_3
//	ld_area_1= dw_3.GetItemNumber(ll_row,"area_1")
//	ld_area_2= dw_3.GetItemNumber(ll_row,"area_2")
//	ld_area_3= dw_3.GetItemNumber(ll_row,"area_3")
//	ld_area_4= dw_3.GetItemNumber(ll_row,"area_4")
//Modificado	 6-Febrero-2014
//	ld_area_5= dw_3.GetItemNumber(ll_row,"area_5")
	
	if isnull(ld_area_1) or ld_area_1< 0 or ld_area_1>100 then
		MessageBox("Error de Calificación", "Favor de corregir la calificación 1",StopSign!)
		dw_3.ScrollToRow(ll_row)
		return -1
	end if
	if isnull(ld_area_2) or ld_area_2< 0 or ld_area_2>100 then
		MessageBox("Error de Calificación", "Favor de corregir la calificación 2",StopSign!)
		dw_3.ScrollToRow(ll_row)
		return -1
	end if
	if isnull(ld_area_3) or ld_area_3< 0 or ld_area_3>100 then
		MessageBox("Error de Calificación", "Favor de corregir la calificación 3",StopSign!)
		dw_3.ScrollToRow(ll_row)
		return -1
	end if
	if isnull(ld_area_4) or ld_area_4< 0 or ld_area_4>100 then
		MessageBox("Error de Calificación", "Favor de corregir la calificación 4",StopSign!)
		dw_3.ScrollToRow(ll_row)
		return -1
	end if
//Modificado	 6-Febrero-2014
//	if isnull(ld_area_5) or ld_area_5< 0 or ld_area_5>100 then
//		MessageBox("Error de Calificación", "Favor de corregir la calificación 5",StopSign!)
//		dw_3.ScrollToRow(ll_row)
//		return -1
//	end if
	
	/*statementblock*/
next

////Valida que no sea un folio nulo
//if isnull(ll_folio_test_vocacional) then
//		MessageBox("Folio Incorrecto", "Favor de escribir un folio válido",StopSign!)
//	return -1
//end if
//
////Valida que el folio sea positivo
//if ll_folio_test_vocacional<=0 then
//		MessageBox("Folio Incorrecto", "Favor de escribir un folio mayor que 0",StopSign!)
//	return -1
//end if
//

//li_existe_folio_test_vocacional = f_existe_folio_test_vocacional(ll_folio_test_vocacional, ll_folio, li_clv_ver, li_clv_per, li_anio, &
//al_ref_folio, ai_ref_clv_ver, ai_ref_clv_per, ai_ref_anio, as_ref_apaterno, as_ref_amaterno, as_ref_nombre)

////Valida que el folio sea positivo
//if li_existe_folio_test_vocacional >=1 then
//		MessageBox("Folio Duplicado", "El folio ["+string(ll_folio_test_vocacional)+"] ya ha sido asignado al aspirante:~n"+&
//		"["+as_ref_apaterno+" "+as_ref_amaterno+" "+as_ref_nombre+"] con folio ["+string(al_ref_folio)+"] "+&
//		"versión ["+string(ai_ref_clv_ver)+"] periodo ["+string(ai_ref_clv_per)+"] año ["+string(ai_ref_anio)+"]", StopSign!)
//	return -1
//end if

return 0
end function

public function integer f_carga_detalle_default (long folio);	
STRING ls_query

ls_query = " SELECT " + STRING(folio) + " AS folio, " + &    
	  + STRING(gi_version) + " AS clv_ver, " + &    
	  + STRING(gi_periodo) + " AS clv_per, " + &    
	  + STRING(gi_anio) + " AS anio, " + &    
	  " 0 AS calificacion_global_examen, " + &    
	  " a.descripcion, " + &  
	  " 0 AS resultado_excoba, " + &  
	+ STRING(folio) + " AS folio , " + &  
	" a.id_area, " + &  
	" 0 AS resultado_ponderado " + & 
 " FROM area_evaluacion a " 
 
DATASTORE lds_carga
lds_carga = CREATE DATASTORE 
lds_carga.DATAOBJECT = dw_3.DATAOBJECT 
lds_carga.MODIFY("Datawindow.Table.Select = '" + ls_query + "'" ) 
lds_carga.SETTRANSOBJECT(gtr_sadm)
lds_carga.RETRIEVE(folio,gi_version,gi_periodo,gi_anio) 

dw_3.RESET() 
lds_carga.ROWSCOPY(1, lds_carga.ROWCOUNT(), PRIMARY!, dw_3, dw_3.ROWCOUNT() + 1, PRIMARY!) 

RETURN 0 



end function

public function integer f_calcula_calificaciones ();INTEGER le_pos
DECIMAL ld_calificacion
LONG ll_cve_carrera, ll_encuentra
STRING ls_busca 
INTEGER le_area_evaluacion 
DECIMAL ld_porcentaje_ponderado, ld_calif_ponderada 
DECIMAL ld_total_puntos , ld_porcentaje_total
INTEGER le_num_areas
DECIMAL ld_prcn_examen, ld_prcn_promedio, ld_promedio_aspiran, ld_puntaje_total

// Se filtra el ds de carreras con la carrera correspondiente 
ll_cve_carrera = dw_2.GETITEMNUMBER(1, "clv_carr") 
IF ISNULL(ll_cve_carrera) THEN ll_cve_carrera = 9999 
ld_promedio_aspiran = dw_2.GETITEMNUMBER(1, "promedio")  
IF ISNULL(ld_promedio_aspiran) THEN ld_promedio_aspiran = 0 

ls_busca = "cve_carrera = " + STRING(ll_cve_carrera)  
ll_encuentra = ids_parametros_area_examen2017.FIND(ls_busca, 0, ids_parametros_area_examen2017.ROWCOUNT() + 1)  
// Si no encuentra datos para la carrera en particular, toma la generica 
IF ll_encuentra <= 0 THEN 
	ll_cve_carrera = 9999 
END IF 




le_num_areas = dw_3.ROWCOUNT() 
IF le_num_areas <= 0 THEN RETURN -1

FOR le_pos = 1 TO le_num_areas
	
	// Se toma la calificación del área CAPTURADA EN BASE 100 
	ld_calificacion = dw_3.GETITEMDECIMAL(le_pos, "resultado_examen_mod_area_2017_resultado_excoba")  
	IF ISNULL(ld_calificacion) THEN ld_calificacion = 0 
	
	ld_total_puntos = ld_total_puntos + ld_calificacion
	
	// Se calcula el resultado ponderado
	le_area_evaluacion = dw_3.GETITEMNUMBER(le_pos, "resultado_examen_mod_area_2017_cve_area_examen")  
	IF ISNULL(le_area_evaluacion) THEN CONTINUE 

	// Se busca el peso del área para calcular el resultado ponderado.
	ls_busca = "cve_carrera = " + STRING(ll_cve_carrera)  + " AND parametros_area_exam_peso_cve_area_examen = " + STRING(le_area_evaluacion)  
	ll_encuentra = ids_parametros_area_examen2017.FIND(ls_busca, 0, ids_parametros_area_examen2017.ROWCOUNT() + 1)  
	// Se recupera el peso en porcentaje 
	IF ll_encuentra > 0 THEN 
		
		ld_porcentaje_ponderado = ids_parametros_area_examen2017.GETITEMDECIMAL(ll_encuentra, "parametros_area_exam_peso_peso_area") 

		ld_prcn_examen = ids_parametros_area_examen2017.GETITEMDECIMAL(ll_encuentra, "porcentaje_examen") 
		IF ISNULL(ld_prcn_examen) THEN ld_prcn_examen = 0 
		ld_prcn_promedio = ids_parametros_area_examen2017.GETITEMDECIMAL(ll_encuentra, "porcentaje_promedio") 
		IF ISNULL(ld_prcn_promedio) THEN ld_prcn_promedio = 0 		
		
		
	END IF
		
	ld_calif_ponderada = (ld_calificacion * ld_porcentaje_ponderado)/100 
	dw_3.SETITEM(le_pos, "resultado_examen_mod_area_2017_resultado_ponderado", ld_calif_ponderada) 
	ld_porcentaje_total = ld_porcentaje_total + ld_calif_ponderada

NEXT 

ld_total_puntos = ld_total_puntos/le_num_areas

dw_res_examen_global.SETITEM(1, "calificacion_global_examen", ld_total_puntos) 
dw_res_examen_global.SETITEM(1, "calificacion_global_porc", ld_porcentaje_total) 

// Se asigna el puntaje total del aspirante 
//*SE ACTUALIZA EL PUNTAJE DEL ASPIRANTE*//
ld_puntaje_total = (ld_promedio_aspiran * (ld_prcn_promedio/100.00)) + (ld_total_puntos * (ld_prcn_examen/100.00))  
ld_puntaje_total = ROUND(ld_puntaje_total, 2) * 100


dw_2.SETITEM(1, "puntaje", ld_puntaje_total)


//LONG l_folio
//l_folio = LONG(uo_nombre.em_cuenta.text) 
//
//UPDATE aspiran
//SET puntaje = :ld_puntaje_total 
//WHERE folio = :l_folio
//USING gtr_sadm; 




//ids_update_aspiran_2017.SETITEM(ll_row_aspiran, "puntaje", ld_puntaje_total)




RETURN 0
 
end function

on w_resultado_examen_individual_2017.create
int iCurrent
call super::create
if this.MenuName = "m_resultado_examen_individual" then this.MenuID = create m_resultado_examen_individual
this.dw_res_examen_global=create dw_res_examen_global
this.cb_4=create cb_4
this.uo_nombre=create uo_nombre
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_solicitud=create dw_solicitud
this.cb_2=create cb_2
this.dw_1=create dw_1
this.dw_3=create dw_3
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_res_examen_global
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.cb_3
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_solicitud
this.Control[iCurrent+7]=this.cb_2
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.dw_3
this.Control[iCurrent+10]=this.dw_2
end on

on w_resultado_examen_individual_2017.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_res_examen_global)
destroy(this.cb_4)
destroy(this.uo_nombre)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_solicitud)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.dw_2)
end on

event open;boolean lb_seguridad
//g_nv_security.fnv_secure_window(this)
x=1
y=1

lb_seguridad= true
//Seguridad via PFC
lb_seguridad= gnv_app.inv_security.of_SetSecurity(this)


IF NOT lb_seguridad THEN
	
//	   MessageBox("Security", "Unable to set security")
//	   Close(this)
END IF


this.x = 1
this.y = 1

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = true
uo_nombre.cbx_nuevo.enabled = true
end event

event doubleclicked;uo_nombre.cbx_nuevo.checked = false

int in_flag
in_flag = 0

if dw_2.event carga(long(uo_nombre.em_cuenta.text)) = 0 then
	in_flag = in_flag + 1
else
	dw_2.modify("lugar_nac.width=887")		
end if	

if in_flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if

//dw_3.setitem(1,"nombre",uo_nombre.dw_nombre_aspirante.getitemstring(1,"nombre"))
//dw_3.setitem(1,"apaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"apaterno"))
//dw_3.setitem(1,"amaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"amaterno"))


// Se carga la configuración de evaluación del examen. 
ids_parametros_area_examen2017 = CREATE DATASTORE 
ids_parametros_area_examen2017.DATAOBJECT = "dw_parametros_area_examen2017"
ids_parametros_area_examen2017.SETTRANSOBJECT(gtr_sadm) 
ids_parametros_area_examen2017.RETRIEVE() 


end event

type dw_res_examen_global from datawindow within w_resultado_examen_individual_2017
integer x = 9
integer y = 740
integer width = 2702
integer height = 216
integer taborder = 30
string title = "none"
string dataobject = "dw_update_resultado_examen_modulo_2017_2"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sadm)
end event

type cb_4 from commandbutton within w_resultado_examen_individual_2017
boolean visible = false
integer x = 2821
integer y = 456
integer width = 567
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar Resultados"
end type

event clicked;long ll_rowcount_2, ll_rowcount_3, ll_row_insert, ll_folio, ll_clv_carr, ll_folio_test_vocacional=0
long ll_row_insert_diagnostico
integer li_clv_ver, li_clv_per, li_anio, li_pago_exam=1, li_cve_tipo_examen , li_cve_modulo_examen
integer li_cve_tipo_examen_diagnostico , li_cve_modulo_examen_diagnostico
real lr_promedio 
integer li_existe_pago_en_cajas, li_confirmacion, li_obten_carrera_modulo_examen
boolean lb_existe_selecccion
ll_rowcount_2 = dw_2.RowCount()
ll_rowcount_3 = dw_3.RowCount()

if ll_rowcount_2 = 0 then
	MessageBox("Error", "Favor de eligir un aspirante válido para cargar los resultados del examen de admisión ",StopSign!)	
	return
end if	

if ll_rowcount_3 = 1 then
	li_cve_tipo_examen = dw_3.GetItemNumber(ll_rowcount_3,"cve_tipo_examen")
 	li_cve_modulo_examen = dw_3.GetItemNumber(ll_rowcount_3,"cve_modulo_examen")
	if li_cve_tipo_examen= 1 and li_cve_modulo_examen=1 then
		lb_existe_selecccion = true
	end if
end if

if ll_rowcount_3 <= 1 then

	ll_folio = dw_2.GetItemNumber(ll_rowcount_2,"folio")
	li_clv_ver = dw_2.GetItemNumber(ll_rowcount_2,"clv_ver")
	li_clv_per = dw_2.GetItemNumber(ll_rowcount_2,"clv_per")
	li_anio = dw_2.GetItemNumber(ll_rowcount_2,"anio")
	ll_clv_carr = dw_2.GetItemNumber(ll_rowcount_2,"clv_carr")
   li_pago_exam  = dw_2.GetItemNumber(ll_rowcount_2,"pago_exam")		
	if	li_pago_exam <>1 then
			MessageBox("Pago Faltante", "No se encontró el pago del examen del aspirante", Information!)
			return
	end if
	
	dw_res_examen_global.INSERTROW(0)
	dw_res_examen_global.SETITEM(1, "folio", ll_folio)
	dw_res_examen_global.SETITEM(1, "clv_ver", li_clv_ver)
	dw_res_examen_global.SETITEM(1, "clv_per", li_clv_per)
	dw_res_examen_global.SETITEM(1, "anio", li_anio)
	dw_res_examen_global.SETITEM(1, "calificacion_global_examen", 0)
	dw_res_examen_global.SETITEM(1, "calificacion_global_porc	", 0)
	
	//Inserta Registro del examen de Selección
	if not lb_existe_selecccion then
		
		DATASTORE lds_areas 
		lds_areas = CREATE DATASTORE 
		lds_areas.DATAOBJECT = "dw_lista_areas_carreras_eval"
		lds_areas.SETTRANSOBJECT(gtr_sadm) 
		lds_areas.RETRIEVE(ll_clv_carr)  
		
		INTEGER lePos, id_area_ins
		STRING ls_descripcion_area
		
		FOR lePos = 1 TO lds_areas.ROWCOUNT () 
		
			id_area_ins = lds_areas.GETITEMNUMBER(lePos, "id_area") 
			ls_descripcion_area = lds_areas.GETITEMSTRING(lePos, "descripcion") 
		
			ll_row_insert = dw_3.InsertRow(0)	
	//		li_cve_tipo_examen  = 1
	//		li_cve_modulo_examen = 1
			dw_3.SetItem(ll_row_insert,"resultado_examen_mod_area_2017_folio",ll_folio)
			dw_3.SetItem(ll_row_insert,"resultado_examen_mod_area_2017_resultado_excoba",0)
			dw_3.SetItem(ll_row_insert,"resultado_examen_mod_area_2017_resultado_ponderado",0)
			dw_3.SetItem(ll_row_insert,"resultado_examen_mod_area_2017_cve_area_examen",id_area_ins)
			dw_3.SetItem(ll_row_insert,"area_evaluacion_descripcion", ls_descripcion_area) 
	//		dw_3.SetItem(ll_row_insert,"folio",ll_folio)
	//		dw_3.SetItem(ll_row_insert,"clv_ver",li_clv_ver)
	//		dw_3.SetItem(ll_row_insert,"clv_per",li_clv_per)
	//		dw_3.SetItem(ll_row_insert,"anio",li_anio)
	//		dw_3.SetItem(ll_row_insert,"cve_tipo_examen",li_cve_tipo_examen)
	//		dw_3.SetItem(ll_row_insert,"cve_modulo_examen",li_cve_modulo_examen)	 
	
		NEXT	
	
	end if
	
//	//Inserta Registro del examen de Diagnóstico
//	ll_row_insert_diagnostico = dw_3.InsertRow(0)	
//	
//	li_obten_carrera_modulo_examen = f_obten_carrera_modulo_examen(ll_clv_carr, li_cve_tipo_examen_diagnostico, li_cve_modulo_examen_diagnostico)
//	if	li_obten_carrera_modulo_examen = -1 then
//			MessageBox("Mensaje", "No se encontró un módulo equivalente para la carrera del aspirante", Information!)
//			return
//	end if
//
//	dw_3.SetItem(ll_row_insert_diagnostico,"folio",ll_folio)
//	dw_3.SetItem(ll_row_insert_diagnostico,"clv_ver",li_clv_ver)
//	dw_3.SetItem(ll_row_insert_diagnostico,"clv_per",li_clv_per)
//	dw_3.SetItem(ll_row_insert_diagnostico,"anio",li_anio)
//	dw_3.SetItem(ll_row_insert_diagnostico,"cve_tipo_examen",li_cve_tipo_examen_diagnostico)
//	dw_3.SetItem(ll_row_insert_diagnostico,"cve_modulo_examen",li_cve_modulo_examen_diagnostico)	 

	ib_nueva_insercion = true
else 
	MessageBox("Información", "Ya se han registrado las calificaciones del examen para el aspirante",StopSign!)
	return
end if

end event

type uo_nombre from uo_nombre_aspirante2 within w_resultado_examen_individual_2017
integer width = 3241
integer taborder = 10
boolean enabled = true
long backcolor = 1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante2::destroy
end on

type cb_3 from commandbutton within w_resultado_examen_individual_2017
event clicked pbm_bnclicked
integer x = 2821
integer y = 772
integer width = 567
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;//dw_2.event actualiza()
//uo_nombre.cbx_nuevo.Checked = FALSE
long ll_rowcount_3, ll_folio_test_vocacional, ll_folio, ll_rowcount_2
integer li_clv_ver, li_clv_per, li_anio, li_pago_exam
long al_ref_folio
integer ai_ref_clv_ver, ai_ref_clv_per, ai_ref_anio, li_existe_folio_test_vocacional
string as_ref_apaterno, as_ref_amaterno,	as_ref_nombre	
integer li_dw_2_Update, li_dw_3_Update, li_dw_4_Update

integer li_confirmacion
long ll_row, ll_rows, ll_row_horario, ll_rows_horario
boolean lb_usuario_especial

dw_res_examen_global.ACCEPTTEXT()
dw_3.ACCEPTTEXT()

ll_rows = dw_3.RowCount()

IF ll_rows = 0 THEN
		MessageBox("Sin Información", "No existe información a actualizar", StopSign!)
		RETURN
END IF

li_confirmacion= MessageBox("Confirmación","¿Desea actualizar los puntajes del aspirante?",Question!,YesNo!)
IF li_confirmacion<>1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF	
END IF

lb_usuario_especial = f_usuario_especial(gs_usuario)
IF not (lb_usuario_especial) THEN
	MessageBox("Usuario Normal", "Es necesario ser un usuario especial para actualizar ésta información", StopSign!)
	RETURN
END IF	

if wf_valida_folio(ib_nueva_insercion)<> -1 then


	ll_rowcount_3 = dw_3.RowCount()
	ll_rowcount_2 = dw_2.RowCount()

	li_dw_2_Update = dw_2.Update(true)  
	li_dw_3_Update = dw_3.Update(true)
	li_dw_4_Update = dw_res_examen_global.Update(true)

	if li_dw_2_Update=1 and	li_dw_3_Update= 1 AND li_dw_4_Update  = 1 then	
		COMMIT USING gtr_sadm;
		MessageBox("Confirmación", "Se ha almacenado la información del folio correctamente",Information!)
		ib_nueva_insercion = false
	else
		ROLLBACK USING gtr_sadm;
		MessageBox("Error de Actualización", "Favor de corregir la información",StopSign!)
		ib_nueva_insercion = true
	end if
else
	MessageBox("Error de Actualización", "Favor de corregir la información",StopSign!)
end if

return


end event

type cb_1 from commandbutton within w_resultado_examen_individual_2017
event clicked pbm_bnclicked
boolean visible = false
integer x = 2482
integer y = 588
integer width = 329
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;parent.event doubleclicked(0,0,0)
end event

type dw_solicitud from datawindow within w_resultado_examen_individual_2017
event constructor pbm_constructor
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
boolean visible = false
integer x = 3369
integer y = 1008
integer width = 3401
integer height = 1648
string dataobject = "dw_solicitud"
end type

event constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild carr1
getchild("x",carr1)
carr1.settransobject(gtr_sce)
carr1.retrieve()

settransobject(gtr_sadm)
end event

event primero;uo_nombre.event primero()
end event

event anterior;uo_nombre.event anterior()
end event

event siguiente;uo_nombre.event siguiente()
end event

event ultimo;uo_nombre.event ultimo()
end event

event carga;return retrieve(folio,gi_version,gi_periodo,gi_anio)
end event

type cb_2 from commandbutton within w_resultado_examen_individual_2017
event clicked pbm_bnclicked
boolean visible = false
integer x = 3383
integer y = 452
integer width = 827
integer height = 384
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Solicitud"
end type

event clicked;if dw_2.rowcount()>0 then
	dw_solicitud.event carga(dw_2.object.folio[1])
	openwithparm(conf_impr,dw_solicitud)
end if
end event

type dw_1 from datawindow within w_resultado_examen_individual_2017
boolean visible = false
integer x = 3369
integer y = 60
integer width = 832
integer height = 940
string dataobject = "dw_salonxcarrera"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sadm)
end event

event retrieverow;in_num_salones=in_num_salones+1
st_salones[in_num_salones]=object.salon[row]

end event

type dw_3 from datawindow within w_resultado_examen_individual_2017
integer x = 9
integer y = 980
integer width = 3689
integer height = 1308
integer taborder = 40
string dataobject = "d_resultado_examen_modulo_indiv_2017"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sadm)
end event

event itemchanged;//long cuenta
//string nombre
//
//if row>0 and getcolumnname() = "cuenta" then
//	cuenta=long(data)
//	if cuenta<>0 then
//		SELECT apaterno+' '+amaterno+' '+nombre
//		INTO :nombre
//		FROM alumnos
//		WHERE alumnos.cuenta = :cuenta
//		USING gtr_SCE;
//		commit using gtr_SCE;
//		
//		if nombre="" then
//			object.ya_inscri[row]=0
//		else
//			object.ya_inscri[row]=1
//		end if
//		messagebox(string(cuenta)+'-'+string(obten_digito(cuenta)),nombre)
//	else
//		object.ya_inscri[row]=0		
//	end if
//end if

POST f_calcula_calificaciones()









end event

event dberror;MessageBox("Error de Actualización", sqlerrtext + "~n" + sqlsyntax, StopSign!)

return 0
end event

type dw_2 from datawindow within w_resultado_examen_individual_2017
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
integer x = 9
integer y = 420
integer width = 3232
integer height = 308
integer taborder = 20
string dataobject = "dw_aspiran_limitado_resultados"
end type

event primero();//event actualiza()
if wf_valida_folio(ib_nueva_insercion)<> -1 and not ib_nueva_insercion then
	uo_nombre.event primero()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if

end event

event anterior();//event actualiza()

if wf_valida_folio(ib_nueva_insercion)<> -1 and not ib_nueva_insercion then
	uo_nombre.event anterior()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if

end event

event siguiente();//event actualiza()

if wf_valida_folio(ib_nueva_insercion)<> -1 and not ib_nueva_insercion then
	uo_nombre.event siguiente()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if
end event

event ultimo();//event actualiza()

if wf_valida_folio(ib_nueva_insercion)<> -1  and not ib_nueva_insercion then
	uo_nombre.event ultimo()
else
	Messagebox("Captura pendiente", "Favor de concluir la captura actual", StopSign!)
end if
end event

event actualiza();//datetime ldFechaNace
//int respuesta, liAnio, liPeriodo, liVersion
//long fol
//string lsApaterno, lsAmaterno, lsNombre
//
///*Cuando se dispara el evento actualiza...*/
//	/*Acepta el texto de la última columna editada*/
//	w_pago_examen_especial.uo_nombre.dw_nombre_aspirante.AcceptText()
//	AcceptText()
//	dw_3.AcceptText()
//	/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
//	if (ModifiedCount()+dw_3.ModifiedCount()) > 0 Then
//		/*Pregunta si se desean guardar los cambios hechos*/
//		//respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
//		respuesta=1
//		if respuesta = 1 then
//			if object.salon[1]="INVA" then
//				rollback using gtr_sadm;
//				messagebox("Carrera Inválida","Deberás cambiarla ya que no tiene salones asignados")
//			else
//				if w_pago_examen_especial.uo_nombre.cbx_nuevo.text = "Nuevo" then
//				
//					tit1=""
//					DO UNTIL tit1<>""
//						open(w_folio_ceneval)
//						fol=long(tit1)
//					LOOP
//					tit1=uo_nombre.uo_1.dw_ver.object.version[uo_nombre.uo_1.dw_ver.getrow()]+' '+&
//						uo_nombre.uo_1.dw_per.object.periodo[uo_nombre.uo_1.dw_per.getrow()]+' '+&
//						uo_nombre.uo_1.em_ani.text
//					
//					w_pago_examen_especial.uo_nombre.em_cuenta.text = string(fol)
//					w_pago_examen_especial.uo_nombre.em_digito.text = obten_digito(fol)
//					object.folio[1]=fol
//					object.clv_ver[1]=gi_version
//					object.clv_per[1]=gi_periodo
//					object.anio[1]=gi_anio
//					object.ing_per[1]=gi_periodo
//					object.ing_anio[1]=gi_anio
//					object.sol_per[1]=gi_periodo
//					object.sol_anio[1]=gi_anio
//					dw_3.object.folio[1]=fol
//					dw_3.object.clv_ver[1]=gi_version
//					dw_3.object.clv_per[1]=gi_periodo
//					dw_3.object.anio[1]=gi_anio
//				
//				end if /*w_pago_examen_especial.uo_nombre.cbx_nuevo.text = "Nuevo"*/
//			
//				/*Checa que los renglones cumplan con las reglas de validación*/
//				if update(true) = 1 then
//					dw_3.update(true)
//					/*Si es asi, guardalo en la tabla y avisa.*/
//					commit using gtr_sadm;
////					liAnio
////					liPeriodo
////					liVersion
////					lsApaterno
////					lsAmaterno
////					lsNombre
//					//messagebox("Información","Se han guardado los cambios")			
//					w_pago_examen_especial.uo_nombre.cbx_nuevo.text = "Modificar"
//				else
//					/*De lo contrario, desecha los cambios (todos) y avisa*/
//					rollback using gtr_sadm;
//					messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
//				end if
//			
//			end if /*object.salon[1]="INVA"*/
//		else
//			/*De lo contrario, solo avisa que no se guardó nada.*/
//			messagebox("Información","No se han guardado los cambios")
//		end if /*respuesta = 1*/
//	end if /*(ModifiedCount()+dw_3.ModifiedCount()) > 0*/
end event

event nuevo;event actualiza()

if gi_version<>99 then
	uo_nombre.cbx_nuevo.text = "Nuevo"

	uo_nombre.cbx_nuevo.checked = true

	uo_nombre.em_cuenta.text = ""
	uo_nombre.em_digito.text = ""

	event carga(1)
	insertrow(getrow())
	dw_3.insertrow(dw_3.getrow())

	uo_nombre.dw_nombre_aspirante.event carga(1)
	uo_nombre.dw_nombre_aspirante.insertrow(uo_nombre.dw_nombre_aspirante.getrow())

	object.salon[1]="INVA"
	object.num_paq[1]=0
	object.status[1]=0
	object.pago_exam[1]=0
	object.pago_insc[1]=0
	object.clv_carr[1]=0
	dw_3.object.ya_inscri[1]=0
	dw_3.object.cuenta[1]=0
	dw_3.object.sexo[1]='M'
	dw_3.object.religion[1]=2

	dw_3.object.lugar_nac[1]=1
	dw_3.object.nacional[1]=1
	dw_3.object.edo_civil[1]=0
	dw_3.object.trabajo[1]=0
	dw_3.object.transporte[1]=2
	uo_nombre.dw_nombre_aspirante.setfocus()
end if
end event

event borra();long fol
int carr,num_paq, li_num_error
string salon_ant, ls_error

if rowcount()>0 then
	if w_pago_examen_especial.uo_nombre.cbx_nuevo.checked then
		if RowCount()>0 then
			if object.pago_exam[1]=0 then
				if object.pago_insc[1]=0 then
					carr=object.clv_carr[1]
					fol=object.folio[1]
					salon_ant=object.salon[1]
					num_paq=object.num_paq[1]
		
					if num_paq>0 then
						UPDATE paquetes
						SET inscritos = inscritos-1
						WHERE paquetes.num_paq = :num_paq
						USING gtr_SADM;
						li_num_error = gtr_SADM.SQLCode
						ls_error= gtr_SADM.SQLErrtext
						if li_num_error = 0 then
							COMMIT USING gtr_SADM;
						else 
							ROLLBACK USING gtr_SADM;
							MessageBox("Error en el update de paquetes",ls_error)
						end if
					end if
					
					DELETE FROM bita_bachi
					WHERE (bita_bachi.folio=:fol) AND
						(bita_bachi.clv_ver=:gi_version) AND
						(bita_bachi.clv_per=:gi_periodo) AND
						(bita_bachi.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_bachi",ls_error)
					end if

					
					DELETE FROM bita_res
					WHERE (bita_res.folio=:fol) AND
						(bita_res.clv_ver=:gi_version) AND
						(bita_res.clv_per=:gi_periodo) AND
						(bita_res.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_res",ls_error)
					end if

					
					DELETE FROM bita_carr
					WHERE (bita_carr.folio=:fol) AND
						(bita_carr.clv_ver=:gi_version) AND
						(bita_carr.clv_per=:gi_periodo) AND
						(bita_carr.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_carr",ls_error)
					end if
					
					DELETE FROM padres
					WHERE (padres.folio=:fol) AND
						(padres.clv_ver=:gi_version) AND
						(padres.clv_per=:gi_periodo) AND
						(padres.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de padres",ls_error)
					end if
			
			
					// Si fue un apartado de lugar no hay que hacer la disminución
	            if gi_version <> 0 then		
 						UPDATE carr_sal
						SET folios = folios -1
						WHERE (clv_ver= :gi_version) AND
								(clv_per= :gi_periodo) AND
								(anio= :gi_anio) AND
								(salon= :salon_ant) AND
								(clv_carr= :carr)
						USING gtr_SADM;
						li_num_error = gtr_SADM.SQLCode
						ls_error= gtr_SADM.SQLErrtext
						if li_num_error = 0 then
							COMMIT USING gtr_SADM;
						else 
							ROLLBACK USING gtr_SADM;
							MessageBox("Error en el update de carr_sal",ls_error)
						end if
					end if
			
			
					DELETE FROM cali_sec
					WHERE (cali_sec.folio=:fol) AND
						(cali_sec.clv_ver=:gi_version) AND
						(cali_sec.clv_per=:gi_periodo) AND
						(cali_sec.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de cali_sec",ls_error)
					end if
					
					
					DELETE FROM cali_are
					WHERE (cali_are.folio=:fol) AND
						(cali_are.clv_ver=:gi_version) AND
						(cali_are.clv_per=:gi_periodo) AND
						(cali_are.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de cali_are",ls_error)
					end if

					
					dw_3.deleterow(1)		
					if dw_3.update(true) = 1 then
						deleterow(1)		
						if update(true) = 1 then
							commit using gtr_SADM;
						end if
					end if
				else
					messagebox("No se puede borrar","Cajas no le ha hecho el rembolso de su Inscripción")
				end if
			else
				messagebox("No se puede borrar","Cajas no le ha hecho el rembolso de su Examen")
			end if
		end if
	end if
end if
end event

event type integer carga(long folio);/*event actualiza()*/
integer li_version, li_cve_tipo_examen= 1, li_cve_modulo_examen=1
INTEGER le_rows_detalle, le_rows_global

li_version = gi_sol_version

dw_3.DATAOBJECT = "d_resultado_examen_modulo_indiv_2017"
dw_3.settransobject(gtr_sadm)
if gi_version = 99 then
	le_rows_detalle = dw_3.retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	le_rows_detalle = dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)
end if
IF le_rows_detalle <= 0 AND folio > 0 THEN f_carga_detalle_default(folio)


//dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)

if gi_version = 99 then
	le_rows_global = dw_res_examen_global.retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	le_rows_global = dw_res_examen_global.retrieve(folio,gi_version,gi_periodo,gi_anio)
end if

IF le_rows_global <= 0 AND folio > 0 THEN 
	dw_res_examen_global.INSERTROW(0) 
	dw_res_examen_global.SETITEM(1, "folio", folio)
	dw_res_examen_global.SETITEM(1, "clv_ver", gi_version)
	dw_res_examen_global.SETITEM(1, "clv_per", gi_periodo)
	dw_res_examen_global.SETITEM(1, "anio", gi_anio)
END IF

if gi_version = 99 then
   return retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	return retrieve(folio,gi_version,gi_periodo,gi_anio)
end if

//return retrieve(folio,gi_version,gi_periodo,gi_anio)






end event

event itemchanged;long columna,fol
int carr_act,carr_ant,cupo,cont,usados
string salon_ant
datetime hoy
real prom_ant,prom_nue,porc_uso_salon

columna = getcolumn()

//if columna=2 then
//	em_carrera.event modified()
//end if

if columna=3 then

	uo_nombre.cbx_nuevo.checked = true

	hoy=datetime(today(),now())
	fol=object.folio[1]
	prom_ant=object.promedio[1]
	prom_nue=real(data)
	
	INSERT INTO bita_bachi  
		( folio, clv_ver, clv_per, anio, fecha, nuevo, anterior, usuario )  
	VALUES ( :fol,:gi_version,:gi_periodo,:gi_anio,:hoy,:prom_nue,:prom_ant,:gs_usuario)
	using gtr_SADM;
	commit using gtr_sadm;

	event actualiza()
	
end if
end event

event constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

settransobject(gtr_sadm)
m_resultado_examen_individual.dw = this
end event

event retrieveend;//if rowcount>0 then
//	em_carrera.text=string(object.clv_carr[1])
//else
//	em_carrera.text=""
//end if
end event

event dberror;MessageBox("Error de Actualización", sqlerrtext + "~n" + sqlsyntax, StopSign!)

return 0
end event

