$PBExportHeader$w_asigna_hora_inscripcion_config_2014.srw
forward
global type w_asigna_hora_inscripcion_config_2014 from w_main
end type
type p_ibero from picture within w_asigna_hora_inscripcion_config_2014
end type
type st_sistema from statictext within w_asigna_hora_inscripcion_config_2014
end type
type dw_ordena_fechas_inscripcion from u_dw within w_asigna_hora_inscripcion_config_2014
end type
type cb_establece_folio_sol from commandbutton within w_asigna_hora_inscripcion_config_2014
end type
type em_cuenta_registros from editmask within w_asigna_hora_inscripcion_config_2014
end type
type cb_1 from commandbutton within w_asigna_hora_inscripcion_config_2014
end type
type cb_asigna_horario_inscripcion from commandbutton within w_asigna_hora_inscripcion_config_2014
end type
type cb_limpiar from commandbutton within w_asigna_hora_inscripcion_config_2014
end type
type cb_eliminar from commandbutton within w_asigna_hora_inscripcion_config_2014
end type
type mc_calendar from monthcalendar within w_asigna_hora_inscripcion_config_2014
end type
type cb_establece_criterio from commandbutton within w_asigna_hora_inscripcion_config_2014
end type
type uo_1 from uo_per_ani within w_asigna_hora_inscripcion_config_2014
end type
type dw_cuentas_bloque_horario_insc from u_dw within w_asigna_hora_inscripcion_config_2014
end type
type rb_licenciatura from radiobutton within w_asigna_hora_inscripcion_config_2014
end type
type rb_posgrado from radiobutton within w_asigna_hora_inscripcion_config_2014
end type
type rb_preinscritos from radiobutton within w_asigna_hora_inscripcion_config_2014
end type
type rb_no_preinscritos from radiobutton within w_asigna_hora_inscripcion_config_2014
end type
type rb_todos from radiobutton within w_asigna_hora_inscripcion_config_2014
end type
type rb_ingreso from radiobutton within w_asigna_hora_inscripcion_config_2014
end type
type dw_bloque_horario_insc from u_dw within w_asigna_hora_inscripcion_config_2014
end type
type em_tamanio_bloque_mins from editmask within w_asigna_hora_inscripcion_config_2014
end type
type st_3 from statictext within w_asigna_hora_inscripcion_config_2014
end type
type cb_agregar_horario from commandbutton within w_asigna_hora_inscripcion_config_2014
end type
type st_2 from statictext within w_asigna_hora_inscripcion_config_2014
end type
type st_1 from statictext within w_asigna_hora_inscripcion_config_2014
end type
type em_fin_receso from editmask within w_asigna_hora_inscripcion_config_2014
end type
type em_inicio_receso from editmask within w_asigna_hora_inscripcion_config_2014
end type
type em_hora_fin from editmask within w_asigna_hora_inscripcion_config_2014
end type
type em_hora_ini from editmask within w_asigna_hora_inscripcion_config_2014
end type
type p_final from picture within w_asigna_hora_inscripcion_config_2014
end type
type em_calendar_final from u_em within w_asigna_hora_inscripcion_config_2014
end type
type p_inicial from picture within w_asigna_hora_inscripcion_config_2014
end type
type em_calendar_inicial from u_em within w_asigna_hora_inscripcion_config_2014
end type
type gb_preinscripcion from groupbox within w_asigna_hora_inscripcion_config_2014
end type
type gb_grado from groupbox within w_asigna_hora_inscripcion_config_2014
end type
type lb_dias_inscripcion from listbox within w_asigna_hora_inscripcion_config_2014
end type
type gb_seleccionados from groupbox within w_asigna_hora_inscripcion_config_2014
end type
end forward

global type w_asigna_hora_inscripcion_config_2014 from w_main
integer width = 5189
integer height = 3272
string title = "Asignación de Horarios Configurable"
windowstate windowstate = maximized!
long backcolor = 16777215
p_ibero p_ibero
st_sistema st_sistema
dw_ordena_fechas_inscripcion dw_ordena_fechas_inscripcion
cb_establece_folio_sol cb_establece_folio_sol
em_cuenta_registros em_cuenta_registros
cb_1 cb_1
cb_asigna_horario_inscripcion cb_asigna_horario_inscripcion
cb_limpiar cb_limpiar
cb_eliminar cb_eliminar
mc_calendar mc_calendar
cb_establece_criterio cb_establece_criterio
uo_1 uo_1
dw_cuentas_bloque_horario_insc dw_cuentas_bloque_horario_insc
rb_licenciatura rb_licenciatura
rb_posgrado rb_posgrado
rb_preinscritos rb_preinscritos
rb_no_preinscritos rb_no_preinscritos
rb_todos rb_todos
rb_ingreso rb_ingreso
dw_bloque_horario_insc dw_bloque_horario_insc
em_tamanio_bloque_mins em_tamanio_bloque_mins
st_3 st_3
cb_agregar_horario cb_agregar_horario
st_2 st_2
st_1 st_1
em_fin_receso em_fin_receso
em_inicio_receso em_inicio_receso
em_hora_fin em_hora_fin
em_hora_ini em_hora_ini
p_final p_final
em_calendar_final em_calendar_final
p_inicial p_inicial
em_calendar_inicial em_calendar_inicial
gb_preinscripcion gb_preinscripcion
gb_grado gb_grado
lb_dias_inscripcion lb_dias_inscripcion
gb_seleccionados gb_seleccionados
end type
global w_asigna_hora_inscripcion_config_2014 w_asigna_hora_inscripcion_config_2014

type variables
date idt_selected_date
long il_num_alumnos[]
integer ii_num_criterio = 0
end variables

forward prototypes
public subroutine wf_obten_grado_cond_preinsc (ref string as_grado, ref string as_cond_preinsc, ref integer ai_preinscrito)
public subroutine wf_establece_criterio_bloques (string as_grado, string as_cond_preinsc, integer ai_num_alumnos_recalculo)
public subroutine wf_ordena_dias_inscripcion ()
public subroutine wf_elimina_lista_dias ()
end prototypes

public subroutine wf_obten_grado_cond_preinsc (ref string as_grado, ref string as_cond_preinsc, ref integer ai_preinscrito);//Obtiene el criterio a utilizar para la asignacion de horario,
//ya sea con preinscritos, no preinscritos, licenciatura, posgrado o primer ingreso
//
//wf_obten_grado_cond_preinsc
//
//Recibe:
//		as_grado				string
//		as_cond_preinsc	string
//		ai_preinscrito		integer

if rb_licenciatura.checked then
	as_grado= 'L'
elseif rb_posgrado.checked then
	as_grado= 'P'
elseif rb_ingreso.checked then
	as_grado= 'I'	
end if

if rb_preinscritos.checked then
	as_cond_preinsc= 'P'
	ai_preinscrito= 1
elseif rb_no_preinscritos.checked then
	as_cond_preinsc= 'NP'
	ai_preinscrito = 0
elseif rb_todos.checked then
	as_cond_preinsc= 'T'	
end if

return
end subroutine

public subroutine wf_establece_criterio_bloques (string as_grado, string as_cond_preinsc, integer ai_num_alumnos_recalculo);//Establece el criterio a utilizar por los bloques de asignacion de horario,
//ya sea con preinscritos, no preinscritos, licenciatura, posgrado o primer ingreso 
//y establece el número de alumnos correspondientes por bloque
//
//wf_establece_criterio_bloques
//Recibe:
//		as_grado							string
//		as_cond_preinsc				string
//		ai_num_alumnos_recalculo	integer

long ll_row_bloque, ll_rows_bloque, ll_tamanio_bloque, ll_row_acumulador  
long ll_num_alumnos_bloque, ll_rows_cuenta, ll_suma_inscritos, ll_tamanio_array, ll_indice_array
long ll_num_bloques_editados= 0
string ls_criterio 

ls_criterio = as_grado + as_cond_preinsc

ll_rows_bloque = dw_bloque_horario_insc.RowCount()
ll_rows_cuenta = dw_cuentas_bloque_horario_insc.RowCount()

ll_tamanio_array = upperbound(il_num_alumnos)

//Suma los registros capturados a mano

IF ai_num_alumnos_recalculo <> 0  THEN	
	FOR ll_indice_array = 1 TO ll_tamanio_array
		IF il_num_alumnos[ll_indice_array]<>-1 THEN
			ll_suma_inscritos = ll_suma_inscritos + il_num_alumnos[ll_indice_array]
			ll_num_bloques_editados = ll_num_bloques_editados + 1
		END IF			
	NEXT
ELSE
	FOR ll_indice_array = 1 TO ll_tamanio_array
		IF il_num_alumnos[ll_indice_array]<>-1 THEN
			il_num_alumnos[ll_indice_array] = -1
		END IF			
	NEXT
	ll_suma_inscritos = 0
	ll_num_bloques_editados = 0
END IF 


if ai_num_alumnos_recalculo = -1  then	
	ll_num_bloques_editados = ll_num_bloques_editados +1
end if

if ai_num_alumnos_recalculo = 0  then	
	ll_tamanio_bloque = ll_rows_cuenta /(ll_rows_bloque - ll_num_bloques_editados)
else
	ll_tamanio_bloque = (ll_rows_cuenta  - ll_suma_inscritos) /(ll_rows_bloque - ll_num_bloques_editados)
end if

if ll_tamanio_bloque > 0 then
	ll_row_acumulador = 0
	ll_num_alumnos_bloque = ll_tamanio_bloque
end if

FOR ll_row_bloque = 1 TO ll_rows_bloque
	IF ll_row_bloque = ll_rows_bloque THEN
		IF ai_num_alumnos_recalculo = 0 THEN	
			ll_num_alumnos_bloque = ll_tamanio_bloque +(ll_rows_cuenta - ((ll_row_bloque -ll_num_bloques_editados) * ll_tamanio_bloque ) - ll_suma_inscritos)
			il_num_alumnos[ll_row_bloque] =  -1
		ELSE	
			ll_num_alumnos_bloque = (ll_rows_cuenta - ((ll_row_bloque - ll_num_bloques_editados - 1) * ll_tamanio_bloque  ) - ll_suma_inscritos)
			il_num_alumnos[ll_row_bloque] =  ll_num_alumnos_bloque
		END IF
		dw_bloque_horario_insc.SetItem(ll_row_bloque, "criterio", ls_criterio )
		dw_bloque_horario_insc.SetItem(ll_row_bloque, "num_alumnos", ll_num_alumnos_bloque )
	
	ELSE
	
		dw_bloque_horario_insc.SetItem(ll_row_bloque, "criterio", ls_criterio )
//Si el arreglo es nuevo o el criterio es nuevo asigna bloques iguales y pone el arreglo e -1's
		IF ll_row_bloque > ll_tamanio_array OR ai_num_alumnos_recalculo= 0 THEN
				dw_bloque_horario_insc.SetItem(ll_row_bloque, "num_alumnos", ll_num_alumnos_bloque )
				il_num_alumnos[ll_row_bloque] =  -1
		ELSE			
			//Si el valor existente en el arreglo es -1 (no se le ha asignado valor manual) y no se escribio un cero
			IF il_num_alumnos[ll_row_bloque]=-1  and ai_num_alumnos_recalculo <> -1 THEN
				dw_bloque_horario_insc.SetItem(ll_row_bloque, "num_alumnos", ll_num_alumnos_bloque )
				il_num_alumnos[ll_row_bloque] =  -1
			//Si el valor asignado se capturó en el datawindow como 0 
			ELSEIF ai_num_alumnos_recalculo = -1 THEN
				dw_bloque_horario_insc.SetItem(ll_row_bloque, "num_alumnos", 0 )
				il_num_alumnos[ll_row_bloque] =  -1
			//Deja el valor editado en el datawindow
			ELSE

			END IF			
		END IF			
	END IF
	ll_row_acumulador = ll_row_acumulador + ll_num_alumnos_bloque
		
NEXT                                                                                                                   

RETURN

	
end subroutine

public subroutine wf_ordena_dias_inscripcion ();//wf_ordena_dias_inscripcion
//Ordena la lista por criterio, hora_inicial, hora_final

string ls_filter, ls_grado, ls_criterio
long  ll_rows_cuenta
integer li_set_filter, li_filter, li_preinscrito
string ls_set_sort, ls_condicion_filtro[]
integer li_set_sort, li_sort, li_ItemTotal, li_ItemCount
string ls_fecha, ls_fecha_inicial, ls_time_final, ls_fecha_criterio[],ls_fecha_criterio_aux
date ldt_fecha_inicial
time ltm_fecha_inicial, ltm_fecha_final
datetime ldttm_fecha_inicial_aux, ldttm_fecha_inicial[], ldttm_fecha_final_aux, ldttm_fecha_final[]
datetime ldttm_fecha_inicial_sh
integer li_pos_guion, li_pos_asterisco, li_num_inserciones, li_pos_igual, li_num_criterio
string ls_condicion_fechas ="", ls_num_criterio, ls_fecha_original, ls_fecha_listbox
long ll_new_row

// Get the number of items in the ListBox.
li_ItemTotal = lb_dias_inscripcion.TotalItems()

if li_ItemTotal= 0 then
	MessageBox("Dias de Inscripción inexistentes", "Favor de insertar alguna fecha de inscripción", StopSign!)
	return	
end if
setpointer(Hourglass!)


// Loop through all the items.
li_num_inserciones = 0
FOR li_ItemCount = 1 to li_ItemTotal

   // Is the item selected? If so, display the text

//   IF lb_dias_inscripcion.State(li_ItemCount) = 1 THEN 

		ls_fecha_listbox=lb_dias_inscripcion.text(li_ItemCount)
		ls_fecha = ls_fecha_listbox
		li_pos_igual = pos(ls_fecha,'=')
		
		ls_num_criterio = mid(ls_fecha, 1, li_pos_igual -1)
		li_num_criterio = integer (ls_num_criterio)
		li_pos_asterisco= pos(ls_fecha, '*') 
		
// La fecha inicia un espacio después del igual		
		ls_fecha = 	mid(ls_fecha, li_pos_igual + 2 )
// La fecha termina antes del asterisco		
		li_pos_asterisco= pos(ls_fecha, '*') 
		ls_fecha = 	mid(ls_fecha, 1, li_pos_asterisco )

////		lb_dias_inscripcion.DeleteItem(li_ItemCount)

		ls_criterio = trim(mid (ls_fecha_listbox, pos(ls_fecha_listbox, '*')  + 1))
		
		if isnull(ls_criterio) or len(ls_criterio) = 0 then
			MessageBox("Hay fechas sin criterio asignado","Favor de asignar el criterio a los horarios insertados",StopSign!)
			return
		end if


		ls_fecha_criterio[li_ItemCount] = ls_num_criterio+"= "+ls_fecha + ls_grado + ls_criterio
////		lb_dias_inscripcion.InsertItem(ls_fecha_criterio[li_ItemCount], li_ItemCount)
		lb_dias_inscripcion.SetState( li_ItemCount, true)
		li_num_inserciones = li_num_inserciones+1

// La fecha inicial es la fecha libre hasta el primer guion		
		li_pos_guion = pos(ls_fecha, '-') 
		ls_fecha_inicial = mid(ls_fecha, 1, li_pos_guion - 1)
		
		ldt_fecha_inicial = date(ls_fecha_inicial)
		ldttm_fecha_inicial_sh = datetime(ldt_fecha_inicial)
		ldttm_fecha_inicial_aux = datetime(ls_fecha_inicial)
		ltm_fecha_inicial = time(ldttm_fecha_inicial_aux)
		ldttm_fecha_inicial[li_ItemCount] = ldttm_fecha_inicial_aux

// La hora final es la fecha libre del guion hasta la hora correspondiente
	
		ls_time_final = mid(ls_fecha, li_pos_guion + 2, 5)
		ltm_fecha_final = time(ls_time_final)
		ldttm_fecha_final_aux = datetime(ldt_fecha_inicial, ltm_fecha_final)
		ldttm_fecha_final[li_ItemCount] = ldttm_fecha_final_aux


		ll_new_row = dw_ordena_fechas_inscripcion.InsertRow(0)
		dw_ordena_fechas_inscripcion.SetItem(ll_new_row,"num_criterio", li_num_criterio )
		dw_ordena_fechas_inscripcion.SetItem(ll_new_row,"criterio",ls_criterio )
		dw_ordena_fechas_inscripcion.SetItem(ll_new_row,"fecha", ldt_fecha_inicial)
		dw_ordena_fechas_inscripcion.SetItem(ll_new_row,"hora_inicial", ldttm_fecha_inicial_aux)
		dw_ordena_fechas_inscripcion.SetItem(ll_new_row,"hora_final", ldttm_fecha_final_aux)
		
//		MessageBox("Elemento Seleccionado", ls_fecha, Information!)
		
//	END IF

NEXT

ls_set_sort = "criterio asc, fecha asc, hora_inicial asc, hora_final asc, num_criterio asc"

li_set_sort = dw_ordena_fechas_inscripcion.SetSort(ls_set_sort)
li_sort = dw_ordena_fechas_inscripcion.Sort()

long ll_current_row, ll_num_rows
ll_num_rows = dw_ordena_fechas_inscripcion.RowCount()

wf_elimina_lista_dias()

FOR ll_current_row = 1 to ll_num_rows

		li_num_criterio 		   = dw_ordena_fechas_inscripcion.GetItemNumber(ll_current_row,"num_criterio" )
		ls_num_criterio         = string(li_num_criterio)
		ls_criterio 		   = dw_ordena_fechas_inscripcion.GetItemString(ll_current_row,"criterio" )
		ldttm_fecha_inicial_sh  = dw_ordena_fechas_inscripcion.GetItemDatetime(ll_current_row,"fecha")
		ldttm_fecha_inicial_aux = dw_ordena_fechas_inscripcion.GetItemDatetime(ll_current_row,"hora_inicial")
		ldttm_fecha_final_aux   = dw_ordena_fechas_inscripcion.GetItemDatetime(ll_current_row,"hora_final")
		ltm_fecha_final 			= time(ldttm_fecha_final_aux)

		ls_fecha_listbox = string(li_num_criterio)+"= "+string(ldttm_fecha_inicial_aux,"dd/mm/yyyy hh:mm")+" - "+string(ldttm_fecha_final_aux,"hh:mm")+" *"+ls_criterio

		lb_dias_inscripcion.AddItem (ls_fecha_listbox)

NEXT




end subroutine

public subroutine wf_elimina_lista_dias ();//wf_elimina_lista_dias()
// Se limpia la lista de horas de inscripcion
integer li_total

setpointer(Hourglass!)
li_total=lb_dias_inscripcion.totalitems()
DO UNTIL li_total=0
		lb_dias_inscripcion.DeleteItem(1)   
		li_total=lb_dias_inscripcion.totalitems()
LOOP



end subroutine

on w_asigna_hora_inscripcion_config_2014.create
int iCurrent
call super::create
this.p_ibero=create p_ibero
this.st_sistema=create st_sistema
this.dw_ordena_fechas_inscripcion=create dw_ordena_fechas_inscripcion
this.cb_establece_folio_sol=create cb_establece_folio_sol
this.em_cuenta_registros=create em_cuenta_registros
this.cb_1=create cb_1
this.cb_asigna_horario_inscripcion=create cb_asigna_horario_inscripcion
this.cb_limpiar=create cb_limpiar
this.cb_eliminar=create cb_eliminar
this.mc_calendar=create mc_calendar
this.cb_establece_criterio=create cb_establece_criterio
this.uo_1=create uo_1
this.dw_cuentas_bloque_horario_insc=create dw_cuentas_bloque_horario_insc
this.rb_licenciatura=create rb_licenciatura
this.rb_posgrado=create rb_posgrado
this.rb_preinscritos=create rb_preinscritos
this.rb_no_preinscritos=create rb_no_preinscritos
this.rb_todos=create rb_todos
this.rb_ingreso=create rb_ingreso
this.dw_bloque_horario_insc=create dw_bloque_horario_insc
this.em_tamanio_bloque_mins=create em_tamanio_bloque_mins
this.st_3=create st_3
this.cb_agregar_horario=create cb_agregar_horario
this.st_2=create st_2
this.st_1=create st_1
this.em_fin_receso=create em_fin_receso
this.em_inicio_receso=create em_inicio_receso
this.em_hora_fin=create em_hora_fin
this.em_hora_ini=create em_hora_ini
this.p_final=create p_final
this.em_calendar_final=create em_calendar_final
this.p_inicial=create p_inicial
this.em_calendar_inicial=create em_calendar_inicial
this.gb_preinscripcion=create gb_preinscripcion
this.gb_grado=create gb_grado
this.lb_dias_inscripcion=create lb_dias_inscripcion
this.gb_seleccionados=create gb_seleccionados
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_ibero
this.Control[iCurrent+2]=this.st_sistema
this.Control[iCurrent+3]=this.dw_ordena_fechas_inscripcion
this.Control[iCurrent+4]=this.cb_establece_folio_sol
this.Control[iCurrent+5]=this.em_cuenta_registros
this.Control[iCurrent+6]=this.cb_1
this.Control[iCurrent+7]=this.cb_asigna_horario_inscripcion
this.Control[iCurrent+8]=this.cb_limpiar
this.Control[iCurrent+9]=this.cb_eliminar
this.Control[iCurrent+10]=this.mc_calendar
this.Control[iCurrent+11]=this.cb_establece_criterio
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.dw_cuentas_bloque_horario_insc
this.Control[iCurrent+14]=this.rb_licenciatura
this.Control[iCurrent+15]=this.rb_posgrado
this.Control[iCurrent+16]=this.rb_preinscritos
this.Control[iCurrent+17]=this.rb_no_preinscritos
this.Control[iCurrent+18]=this.rb_todos
this.Control[iCurrent+19]=this.rb_ingreso
this.Control[iCurrent+20]=this.dw_bloque_horario_insc
this.Control[iCurrent+21]=this.em_tamanio_bloque_mins
this.Control[iCurrent+22]=this.st_3
this.Control[iCurrent+23]=this.cb_agregar_horario
this.Control[iCurrent+24]=this.st_2
this.Control[iCurrent+25]=this.st_1
this.Control[iCurrent+26]=this.em_fin_receso
this.Control[iCurrent+27]=this.em_inicio_receso
this.Control[iCurrent+28]=this.em_hora_fin
this.Control[iCurrent+29]=this.em_hora_ini
this.Control[iCurrent+30]=this.p_final
this.Control[iCurrent+31]=this.em_calendar_final
this.Control[iCurrent+32]=this.p_inicial
this.Control[iCurrent+33]=this.em_calendar_inicial
this.Control[iCurrent+34]=this.gb_preinscripcion
this.Control[iCurrent+35]=this.gb_grado
this.Control[iCurrent+36]=this.lb_dias_inscripcion
this.Control[iCurrent+37]=this.gb_seleccionados
end on

on w_asigna_hora_inscripcion_config_2014.destroy
call super::destroy
destroy(this.p_ibero)
destroy(this.st_sistema)
destroy(this.dw_ordena_fechas_inscripcion)
destroy(this.cb_establece_folio_sol)
destroy(this.em_cuenta_registros)
destroy(this.cb_1)
destroy(this.cb_asigna_horario_inscripcion)
destroy(this.cb_limpiar)
destroy(this.cb_eliminar)
destroy(this.mc_calendar)
destroy(this.cb_establece_criterio)
destroy(this.uo_1)
destroy(this.dw_cuentas_bloque_horario_insc)
destroy(this.rb_licenciatura)
destroy(this.rb_posgrado)
destroy(this.rb_preinscritos)
destroy(this.rb_no_preinscritos)
destroy(this.rb_todos)
destroy(this.rb_ingreso)
destroy(this.dw_bloque_horario_insc)
destroy(this.em_tamanio_bloque_mins)
destroy(this.st_3)
destroy(this.cb_agregar_horario)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fin_receso)
destroy(this.em_inicio_receso)
destroy(this.em_hora_fin)
destroy(this.em_hora_ini)
destroy(this.p_final)
destroy(this.em_calendar_final)
destroy(this.p_inicial)
destroy(this.em_calendar_inicial)
destroy(this.gb_preinscripcion)
destroy(this.gb_grado)
destroy(this.lb_dias_inscripcion)
destroy(this.gb_seleccionados)
end on

event open;call super::open;integer li_periodo, li_anio, li_ret_periodo_activacion_su, li_ret_inserta_aux_cuentas_cortes

x = 1
y = 1

mc_calendar.visible = false


li_ret_periodo_activacion_su = f_obten_periodo_activacion_su(li_periodo, li_anio)


if li_ret_periodo_activacion_su <> 0 then
	MessageBox("Error de parámetros", "No es posible leer los parámetros de activacion_su para asignar horarios",StopSign!)
	this.event close()
	return	
end if


li_ret_inserta_aux_cuentas_cortes = f_inserta_aux_cuentas_cortes(li_periodo, li_anio)


if li_ret_inserta_aux_cuentas_cortes <> 0 then
	MessageBox("Error de cuentas_cortes", "No es posible obtener las cuentas cortes",StopSign!)
	this.event close()
	return	
end if


dw_bloque_horario_insc.SetTransObject(gtr_sce)

dw_cuentas_bloque_horario_insc.SetTransObject(gtr_sce)
dw_cuentas_bloque_horario_insc.Retrieve(gi_periodo, gi_anio)

end event

event close;call super::close;integer li_periodo, li_anio, li_ret_periodo_activacion_su, li_ret_elimina_aux_cuentas_cortes

x = 1
y = 1

li_ret_periodo_activacion_su = f_obten_periodo_activacion_su(li_periodo, li_anio)

if li_ret_periodo_activacion_su <> 0 then
	MessageBox("Error de parámetros", "No es posible leer los parámetros de activacion_su para asignar horarios",StopSign!)
	this.event close()
	return	
end if

li_ret_elimina_aux_cuentas_cortes = f_elimina_aux_cuentas_cortes(li_periodo, li_anio)

if li_ret_elimina_aux_cuentas_cortes <> 0 then
	MessageBox("Error de cuentas_cortes", "No es posible obtener las cuentas cortes",StopSign!)
	this.event close()
	return	
end if

end event

type p_ibero from picture within w_asigna_hora_inscripcion_config_2014
integer x = 41
integer y = 36
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type st_sistema from statictext within w_asigna_hora_inscripcion_config_2014
integer x = 773
integer y = 120
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type dw_ordena_fechas_inscripcion from u_dw within w_asigna_hora_inscripcion_config_2014
integer x = 55
integer y = 2304
integer width = 2190
integer height = 356
integer taborder = 40
string dataobject = "d_ordena_fechas_inscripcion"
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

type cb_establece_folio_sol from commandbutton within w_asigna_hora_inscripcion_config_2014
integer x = 3374
integer y = 1124
integer width = 622
integer height = 80
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Establece Folio Solicitudes"
end type

event clicked;integer li_confirma, li_res_criterio, li_preinscrito
string ls_nombre_criterio, ls_cve_criterio, ls_criterio, ls_grado, ls_cond_preinsc
long ll_cuenta_inserciones

wf_obten_grado_cond_preinsc(ls_grado, ls_cond_preinsc, li_preinscrito)

ls_criterio = ls_grado + ls_cond_preinsc

ll_cuenta_inserciones = f_cuenta_ins_horario_insc(gi_periodo, gi_anio, ls_criterio)

IF ll_cuenta_inserciones = 0 THEN
	MessageBox("Horarios no asignados","NO existen horarios asignados con esas caracteristicas",StopSign!)
	return	
END IF

IF rb_preinscritos.checked THEN
	ls_nombre_criterio = "ALUMNOS PREINSCRITOS CON HORARIO"
	ls_cve_criterio= "P"
ELSEIF rb_todos.checked THEN
	ls_nombre_criterio = "TODOS LOS ALUMNOS CON HORARIO"
	ls_cve_criterio= "T"
ELSE
	MessageBox("Selección de criterio errónea","Solo se permiten el criterio de Preinscritos y Todos",StopSign!)
	return
END IF

li_confirma = MessageBox("Confirmar Criterio de Folios de Solicitudes",&
"¿Desea generar las solicitudes de materia para el criterio de ~n ["+ls_nombre_criterio+"]?",Question!, YesNo!)

IF li_confirma <> 1 THEN
	MessageBox("Información","NO se ha asignado criterio para las solicitudes",Information!)
	return
END IF

li_res_criterio= f_establece_criterio_solicitudes(ls_cve_criterio,gi_periodo, gi_anio)
IF li_res_criterio =-1  THEN
	MessageBox("Error de asignación","NO se ha podido asignar criterio para las solicitudes",StopSign!)
	return
ELSEIF li_res_criterio =0 THEN
	MessageBox("Información","Se ha asignado el criterio para las solicitudes exitosamente",Information!)
	
ELSE 
	MessageBox("Error de asignación","NO se ha podido asignar criterio para las solicitudes",StopSign!)
	return
END IF

	
IF f_foliar_horario_solicitudes_conf_2014(ls_cve_criterio,gi_periodo, gi_anio)	= -1 THEN
	MessageBox("Error de foliación","NO se ha podido foliar las solicitudes",StopSign!)
	return
ELSE
	MessageBox("Información","Solicitudes Foliadas Exitosamente",Information!)
	return	
END IF
	
end event

type em_cuenta_registros from editmask within w_asigna_hora_inscripcion_config_2014
integer x = 3579
integer y = 448
integer width = 210
integer height = 84
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
string mask = "#,##0"
end type

type cb_1 from commandbutton within w_asigna_hora_inscripcion_config_2014
integer x = 3456
integer y = 288
integer width = 457
integer height = 84
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Restaurar Horarios"
end type

event clicked;integer li_respuesta
integer li_cuenta_inserciones
string ls_criterio, ls_cuenta_inserciones

li_respuesta= MessageBox("Confirmacion","Desea borrar los criterios establecidos?",Question!, YesNo!)

if li_respuesta = 1 then
	
	SetPointer(HourGlass!)
	
	f_borra_horario_insc(gi_periodo, gi_anio)

	ls_criterio = "T"

	li_cuenta_inserciones = f_cuenta_ins_horario_insc(gi_periodo, gi_anio, ls_criterio)
	ls_cuenta_inserciones = string(li_cuenta_inserciones)

	em_cuenta_registros.Text =ls_cuenta_inserciones

end if

return
end event

type cb_asigna_horario_inscripcion from commandbutton within w_asigna_hora_inscripcion_config_2014
integer x = 2889
integer y = 1124
integer width = 407
integer height = 80
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asigna Horario"
end type

event clicked;
integer li_codigo_sql, li_codigo_sql2
string ls_mensaje_sql, ls_mensaje_sql2, ls_calificacion_anterior 
long	ll_cuenta, ll_rows
string ls_filter
long  ll_rows_cuenta
integer li_set_filter, li_filter, li_preinscrito
string ls_set_sort, ls_condicion_filtro[]

integer li_set_sort, li_sort, li_ItemCount, li_ItemTotal
string ls_fecha, ls_fecha_inicial, ls_time_final, ls_fecha_criterio[]
date ldt_fecha_inicial
time ltm_fecha_inicial, ltm_fecha_final
datetime ldttm_fecha_inicial_aux, ldttm_fecha_inicial[], ldttm_fecha_final_aux, ldttm_fecha_final[]
integer li_pos_guion, li_pos_asterisco, li_num_inserciones
string ls_condicion_fechas ="", ls_criterio = "", ls_grado = "", ls_cond_preinsc = ""
string  ls_condicion_criterio = "", ls_condicion_fechas_criterio = ""

integer li_contador_lic_preinsc, li_contador_lic_no_preinsc, li_contador_lic_todos
integer li_contador_pos_preinsc, li_contador_pos_no_preinsc, li_contador_pos_todos
integer li_contador_lic_prim_ing

long ll_rows_bloque, ll_row_bloque_actual, ll_cuenta_horario_actual
integer li_filter_bloque, li_pos_igual

string ls_set_sort_bloque, ls_criterio_anterior = "", ls_num_criterio
integer li_set_sort_bloque, li_sort_bloque, li_inserta_horario_insc, li_periodo, li_anio
long ll_num_alumnos_bloque_actual, ll_indice_cuentas_actual, ll_indice_cuentas_mas_bloque, ll_lugar_fila= 0
long ll_rows_totales_bloque, ll_rows_cuenta_filter, ll_indice_cuentas_inicial
datetime ldttm_hora_inicial

li_contador_lic_preinsc =0 
li_contador_lic_no_preinsc =0  
li_contador_lic_todos =0  
li_contador_pos_preinsc =0  
li_contador_pos_no_preinsc =0  
li_contador_pos_todos =0  
li_contador_lic_prim_ing =0  


wf_ordena_dias_inscripcion()

li_ItemTotal = lb_dias_inscripcion.TotalItems( )

IF li_ItemTotal = 0 THEN
	MessageBox("No hay fechas elegidas","Favor de agregar horarios antes de asignar",StopSign!)
	return
ELSEIF li_ItemTotal = -1 THEN
	MessageBox("Error en lista de fechas","No es posible contar los horarios",StopSign!)
	return
END IF

setpointer(Hourglass!)
li_periodo = gi_periodo
li_anio = gi_anio
// Loop through all the items.
li_num_inserciones = 0

//Por cada fecha con criterio asignado deberá asignar horarios según el bloque 
//correspondiente y las cuentas que estén acorde al mismo
ll_indice_cuentas_actual= 1
ll_indice_cuentas_inicial = 1
FOR li_ItemCount = 1 to li_ItemTotal


//   IF lb_dias_inscripcion.State(li_ItemCount) = 1 THEN 
		
		ls_fecha =lb_dias_inscripcion.text(li_ItemCount)
		li_pos_asterisco= pos(ls_fecha, '*') 
		li_pos_igual = pos(ls_fecha,'=')

		ls_num_criterio = mid(ls_fecha, 1, li_pos_igual -1)
		
		ls_criterio = trim(mid (ls_fecha, li_pos_asterisco + 1))
		if isnull(ls_criterio) or len(ls_criterio) = 0 then
			MessageBox("Hay fechas sin criterio asignado","Favor de asignar el criterio a los horarios insertados",StopSign!)
			return
		end if
		
		ls_grado = mid( ls_criterio, 1,1)
		ls_cond_preinsc = mid( ls_criterio, 2)
		

		//Revisa el grado del criterio
		choose case ls_grado
			//Licenciatura
			case "L"
			//Revisa la condición de preinscripcion				
				choose case ls_cond_preinsc
					case 'P'
						li_contador_lic_preinsc =li_contador_lic_preinsc +1
					case 'NP'
						li_contador_lic_no_preinsc = li_contador_lic_no_preinsc +1  
					case 'T'
						li_contador_lic_todos = li_contador_lic_todos +1  
					case else
						MessageBox("Condición de Preinscripción Inválida","Favor de asignar criterios de Preinscripción válidos",StopSign!)
						return				
				end choose
			//Posgrado
			case "P"
			//Revisa la condición de preinscripcion				
				choose case ls_cond_preinsc
					case 'P'
						li_contador_pos_preinsc =li_contador_pos_preinsc + 1
					case 'NP'
						li_contador_pos_no_preinsc = li_contador_pos_no_preinsc + 1  
					case 'T'
						li_contador_pos_todos = li_contador_pos_todos + 1  
					case else
						MessageBox("Condición de Preinscripción Inválida","Favor de asignar criterios de Preinscripción válidos",StopSign!)
						return
				end choose
			//Primer Ingreso
			case "I"
				li_contador_lic_prim_ing = li_contador_lic_prim_ing + 1
			case else
		end choose
		
		IF (li_contador_lic_todos > 0) AND (li_contador_lic_preinsc >0 OR li_contador_lic_no_preinsc>0) THEN
			MessageBox("Criterios de Licenciatura Traslapados","No es posible asignar a todos y también a preinscritos o no preinscritos",StopSign!)
			return
		END IF
		
		IF (li_contador_pos_todos > 0) AND (li_contador_pos_preinsc >0 OR li_contador_pos_no_preinsc>0) THEN
			MessageBox("Criterios de Posgrado Traslapados","No es posible asignar a todos y también a preinscritos o no preinscritos",StopSign!)
			return
		END IF

		IF ls_cond_preinsc = 'T' THEN
			ls_filter = "nivel = '"+ls_grado +"'"
		ELSEIF ls_cond_preinsc = 'P' THEN
			li_preinscrito = 1
			ls_filter = "nivel = '"+ls_grado + "' AND preinscrito = "+string(li_preinscrito 	)
		ELSEIF ls_cond_preinsc = 'NP' THEN
			li_preinscrito = 0
			ls_filter = "nivel = '"+ls_grado + "' AND preinscrito = "+string(li_preinscrito 	)
		ELSE 
			ls_filter =""
		END IF

		
		ls_fecha = 	mid(ls_fecha, li_pos_igual + 2, li_pos_asterisco )
//		lb_dias_inscripcion.DeleteItem(li_ItemCount)

		ls_fecha_criterio[li_ItemCount] = ls_num_criterio+"= "+ls_fecha + ls_grado + ls_cond_preinsc
//		lb_dias_inscripcion.InsertItem(ls_fecha_criterio[li_ItemCount], li_ItemCount)
		lb_dias_inscripcion.SetState( li_ItemCount, true)
		li_num_inserciones = li_num_inserciones+1

// La fecha inicial es la fecha libre hasta el primer guion		

		li_pos_guion = pos(ls_fecha, '-') 
		ls_fecha_inicial = mid(ls_fecha, 1, li_pos_guion - 1)
		
		ldt_fecha_inicial = date(ls_fecha_inicial)
		ldttm_fecha_inicial_aux = datetime(ls_fecha_inicial)
		ltm_fecha_inicial = time(ldttm_fecha_inicial_aux)
		ldttm_fecha_inicial[li_ItemCount] = ldttm_fecha_inicial_aux

// La hora final es la fecha libre del guion hasta la hora correspondiente
		
		ls_time_final = mid(ls_fecha, li_pos_guion + 2, 5)
		ltm_fecha_final = time(ls_time_final)
		ldttm_fecha_final_aux = datetime(ldt_fecha_inicial, ltm_fecha_final)
		ldttm_fecha_final[li_ItemCount] = ldttm_fecha_final_aux

		
		ls_condicion_fechas = "( num_criterio ="+ls_num_criterio+" AND (hora_inicial >= datetime('"+STRING(ldttm_fecha_inicial_aux,"dd/mm/yyyy hh:mm")+"') AND hora_inicial <= datetime('"+STRING(ldttm_fecha_final_aux,"dd/mm/yyyy hh:mm")+"') ) )"
		ls_condicion_criterio = " AND criterio = '"+ls_criterio+ "'"
		ls_condicion_fechas_criterio = ls_condicion_fechas + ls_condicion_criterio
		
		
		MessageBox("Elemento Seleccionado", ls_fecha, Information!)
		
		//Recupera la cuenta de los alumnos y las filtra por nivel y condición de preinscripción
		ll_rows_cuenta = dw_cuentas_bloque_horario_insc.Retrieve(gi_periodo, gi_anio)
		li_set_filter = dw_cuentas_bloque_horario_insc.SetFilter(ls_filter )
		li_filter = dw_cuentas_bloque_horario_insc.Filter()
		ll_rows_cuenta_filter = dw_cuentas_bloque_horario_insc.RowCount()

		ls_set_sort = "creditos_cursados desc, promedio desc, sem_cursados asc, nombre_completo asc"

		//Ordena las cuentas por creditos, promedio, semestres y nombre
		li_set_sort = dw_cuentas_bloque_horario_insc.SetSort(ls_set_sort)
		li_sort = dw_cuentas_bloque_horario_insc.Sort()
		
		//Filtra los bloques de horario según la fecha actual y el criterio seleccionado
		ll_rows_bloque = dw_bloque_horario_insc.SetFilter(ls_condicion_fechas_criterio )
		li_filter_bloque = dw_bloque_horario_insc.Filter()
		
	
		ls_set_sort_bloque = "fecha asc, hora_inicial asc, num_horario asc"

		li_set_sort_bloque = dw_bloque_horario_insc.SetSort(ls_set_sort_bloque)
		li_sort_bloque = dw_bloque_horario_insc.Sort()

		//Recorre todos los registros del bloque de horarios asignados
		if	ls_criterio_anterior <> ls_criterio then
			ll_indice_cuentas_actual= 1
			ll_indice_cuentas_inicial = 1
		end if
		
		ll_rows_totales_bloque = dw_bloque_horario_insc.RowCount()
		FOR ll_row_bloque_actual= 1 TO ll_rows_totales_bloque
			ll_num_alumnos_bloque_actual = dw_bloque_horario_insc.GetItemNumber(ll_row_bloque_actual, "num_alumnos")
			ldttm_hora_inicial = dw_bloque_horario_insc.GetItemDateTime(ll_row_bloque_actual, "hora_inicial")
			ll_indice_cuentas_mas_bloque = ll_indice_cuentas_actual + ll_num_alumnos_bloque_actual -1
			ll_lugar_fila = 1
			FOR ll_indice_cuentas_actual = ll_indice_cuentas_inicial TO ll_indice_cuentas_mas_bloque
				ll_cuenta_horario_actual = dw_cuentas_bloque_horario_insc.GetItemNumber(ll_indice_cuentas_actual,"cuenta")
				li_inserta_horario_insc = f_inserta_horario_insc(li_periodo, li_anio, ll_cuenta_horario_actual,&
				ldttm_hora_inicial, ll_lugar_fila, ls_criterio)
				IF li_inserta_horario_insc = -1 THEN
					ls_mensaje_sql =gtr_sce.SqlErrText	
					li_codigo_sql =gtr_sce.Sqlcode
					ROLLBACK USING gtr_sce;
					MessageBox("Error al insertar en horario_insc", "Cuenta: "+string(ll_cuenta_horario_actual)+"~n"+ls_mensaje_sql,StopSign!)	
					return li_codigo_sql
				END IF
				ll_lugar_fila = ll_lugar_fila + 1
			NEXT
			if li_inserta_horario_insc= 0 then
				//Cierra la transaccion del bloque
				COMMIT USING gtr_sce;			
			end if
			ll_indice_cuentas_inicial  = ll_indice_cuentas_mas_bloque + 1
		NEXT
//	END IF
	ls_criterio_anterior = ls_criterio
	
NEXT




	
	
	if li_codigo_sql = -1 then
		ROLLBACK USING gtr_sce;
		MessageBox("Error al insertar en horario_insc", ls_mensaje_sql)	
		return li_codigo_sql
	elseif li_codigo_sql = 0 then
//		COMMIT USING gtr_sce;
		MessageBox("Inserción exitosa de horario_insc", ls_mensaje_sql)	
		return li_codigo_sql		
	end if

end event

type cb_limpiar from commandbutton within w_asigna_hora_inscripcion_config_2014
integer x = 2939
integer y = 904
integer width = 256
integer height = 80
integer taborder = 90
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Limpiar"
end type

event clicked;/* Se limpia la lista de alumnos y el datawindow*/
int li_total, li_confirmacion
li_confirmacion = MessageBox("Confirmación", "¿Desea limpiar todos los días de inscripción?",Question!, YesNo!)
if li_confirmacion<> 1 then
	RETURN
end if
wf_elimina_lista_dias()

dw_bloque_horario_insc.Reset()

end event

type cb_eliminar from commandbutton within w_asigna_hora_inscripcion_config_2014
boolean visible = false
integer x = 2939
integer y = 516
integer width = 256
integer height = 84
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar"
end type

event clicked;integer li_set_sort, li_sort, li_ItemTotal, li_ItemCount
integer li_pos_guion, li_pos_asterisco, li_num_eliminaciones
integer li_deleted_index[], li_current_deleted, li_index, li_confirmacion

if lb_dias_inscripcion.SelectedIndex()= -1 then
	MessageBox("Dias de Inscripción no seleccionados", "Favor de elegir alguna fecha de inscripción para eliminar", StopSign!)
	return	
end if
li_confirmacion = MessageBox("Confirmación", "¿Desea eliminar las fechas seleccionadas?",Question!, YesNo!)
if li_confirmacion<> 1 then
	RETURN
end if

setpointer(Hourglass!)

// Se Obtiene el primer indice del renglon seleccionado
li_Index = lb_dias_inscripcion.SelectedIndex( )

// Se eliminan todos los renglones seleccionados 
DO UNTIL li_index=-1
	// Se elimina el renglon en los dos list_box
	lb_dias_inscripcion.DeleteItem(li_Index)	
	li_num_eliminaciones = li_num_eliminaciones+1
	// Se vuelve a obtener el siguiente renglon
	li_Index = lb_dias_inscripcion.SelectedIndex( )
LOOP


if li_num_eliminaciones = 1 then
	MessageBox("Eliminación exitosa","Se eliminó ["+string(li_num_eliminaciones)+"] fecha", Information!)
elseif li_num_eliminaciones > 1 then
	MessageBox("Eliminación exitosa","Se eliminaron ["+string(li_num_eliminaciones)+"] fechas", Information!)
end if



end event

type mc_calendar from monthcalendar within w_asigna_hora_inscripcion_config_2014
integer x = 517
integer y = 660
integer width = 754
integer height = 556
integer taborder = 20
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
weekday firstdayofweek = sunday!
integer maxselectcount = 1
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = stylelowered!
boolean autosize = true
end type

event datechanged;date ldt_selected_date
this.GetSelectedDate ( ldt_selected_date )

this.SetBoldDate ( idt_selected_date, false )
this.SetBoldDate ( ldt_selected_date, true )

idt_selected_date = ldt_selected_date
em_calendar_inicial.text = string(idt_selected_date, "dd/mm/yyyy")






end event

type cb_establece_criterio from commandbutton within w_asigna_hora_inscripcion_config_2014
integer x = 2862
integer y = 288
integer width = 457
integer height = 84
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Establece Criterio"
end type

event clicked;string ls_filter, ls_grado, ls_cond_preinsc
long  ll_rows_cuenta
integer li_set_filter, li_filter, li_preinscrito
string ls_set_sort, ls_condicion_filtro[]
integer li_set_sort, li_sort, li_ItemTotal, li_ItemCount
string ls_fecha, ls_fecha_inicial, ls_time_final, ls_fecha_criterio[]
date ldt_fecha_inicial
time ltm_fecha_inicial, ltm_fecha_final
datetime ldttm_fecha_inicial_aux, ldttm_fecha_inicial[], ldttm_fecha_final_aux, ldttm_fecha_final[]
integer li_pos_guion, li_pos_asterisco, li_num_inserciones, li_pos_igual
string ls_condicion_fechas ="", ls_num_criterio, ls_fecha_original

if lb_dias_inscripcion.SelectedIndex()= -1 then
	MessageBox("Dias de Inscripción no seleccionados", "Favor de elegir alguna fecha de inscripción", StopSign!)
	return	
end if
setpointer(Hourglass!)

dw_cuentas_bloque_horario_insc.SetTransObject(gtr_sce)

wf_obten_grado_cond_preinsc(ls_grado, ls_cond_preinsc, li_preinscrito)

IF ls_cond_preinsc = 'T' THEN
	ls_filter = "nivel = '"+ls_grado +"'"
ELSE
	ls_filter = "nivel = '"+ls_grado + "' AND preinscrito = "+string(li_preinscrito 	)
END IF

// Get the number of items in the ListBox.
li_ItemTotal = lb_dias_inscripcion.TotalItems()

// Loop through all the items.
li_num_inserciones = 0
FOR li_ItemCount = 1 to li_ItemTotal

   // Is the item selected? If so, display the text

   IF lb_dias_inscripcion.State(li_ItemCount) = 1 THEN 

		ls_fecha =lb_dias_inscripcion.text(li_ItemCount)
		li_pos_igual = pos(ls_fecha,'=')
		
		ls_num_criterio = mid(ls_fecha, 1, li_pos_igual -1)
		li_pos_asterisco= pos(ls_fecha, '*') 
		
// La fecha inicia un espacio después del igual		
		ls_fecha = 	mid(ls_fecha, li_pos_igual + 2 )
// La fecha termina antes del asterisco		
		li_pos_asterisco= pos(ls_fecha, '*') 
		ls_fecha = 	mid(ls_fecha, 1, li_pos_asterisco )

		lb_dias_inscripcion.DeleteItem(li_ItemCount)

		ls_fecha_criterio[li_ItemCount] = ls_num_criterio+"= "+ls_fecha + ls_grado + ls_cond_preinsc
		lb_dias_inscripcion.InsertItem(ls_fecha_criterio[li_ItemCount], li_ItemCount)
		lb_dias_inscripcion.SetState( li_ItemCount, true)
		li_num_inserciones = li_num_inserciones+1

// La fecha inicial es la fecha libre hasta el primer guion		
		li_pos_guion = pos(ls_fecha, '-') 
		ls_fecha_inicial = mid(ls_fecha, 1, li_pos_guion - 1)
		
		ldt_fecha_inicial = date(ls_fecha_inicial)
		ldttm_fecha_inicial_aux = datetime(ls_fecha_inicial)
		ltm_fecha_inicial = time(ldttm_fecha_inicial_aux)
		ldttm_fecha_inicial[li_ItemCount] = ldttm_fecha_inicial_aux

// La hora final es la fecha libre del guion hasta la hora correspondiente
	
		ls_time_final = mid(ls_fecha, li_pos_guion + 2, 5)
		ltm_fecha_final = time(ls_time_final)
		ldttm_fecha_final_aux = datetime(ldt_fecha_inicial, ltm_fecha_final)
		ldttm_fecha_final[li_ItemCount] = ldttm_fecha_final_aux

		IF li_num_inserciones= 1 THEN
			ls_condicion_fechas = " ( num_criterio ="+ls_num_criterio+" AND (hora_inicial >= datetime('"+STRING(ldttm_fecha_inicial_aux,"dd/mm/yyyy hh:mm")+"') AND hora_inicial <= datetime('"+STRING(ldttm_fecha_final_aux,"dd/mm/yyyy hh:mm")+"') ) )"
		ELSE
			ls_condicion_fechas = ls_condicion_fechas+ "  OR ( num_criterio ="+ls_num_criterio+" AND (hora_inicial >= datetime('"+STRING(ldttm_fecha_inicial_aux,"dd/mm/yyyy hh:mm")+"') AND hora_inicial <= datetime('"+STRING(ldttm_fecha_final_aux,"dd/mm/yyyy hh:mm")+"') ) )"
		END IF		
		
		MessageBox("Elemento Seleccionado", ls_fecha, Information!)
		
	END IF

NEXT

ls_filter = ls_filter 

ll_rows_cuenta = dw_cuentas_bloque_horario_insc.Retrieve(gi_periodo, gi_anio)
li_set_filter = dw_cuentas_bloque_horario_insc.SetFilter(ls_filter )
li_filter = dw_cuentas_bloque_horario_insc.Filter()

ls_set_sort = "creditos_cursados desc, promedio desc, sem_cursados asc, nombre_completo asc"


li_set_sort = dw_cuentas_bloque_horario_insc.SetSort(ls_set_sort)
li_sort = dw_cuentas_bloque_horario_insc.Sort()

long ll_rows_bloque
integer li_filter_bloque

ll_rows_bloque = dw_bloque_horario_insc.SetFilter(ls_condicion_fechas )
li_filter_bloque = dw_bloque_horario_insc.Filter()


string ls_set_sort_bloque
integer li_set_sort_bloque, li_sort_bloque

ls_set_sort_bloque = "fecha asc, hora_inicial asc, num_horario asc"

li_set_sort_bloque = dw_bloque_horario_insc.SetSort(ls_set_sort_bloque)
li_sort_bloque = dw_bloque_horario_insc.Sort()



wf_establece_criterio_bloques(ls_grado,ls_cond_preinsc,0)


end event

type uo_1 from uo_per_ani within w_asigna_hora_inscripcion_config_2014
integer x = 1445
integer y = 44
integer width = 1253
integer height = 168
integer taborder = 20
boolean enabled = true
long backcolor = 1090519039
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_cuentas_bloque_horario_insc from u_dw within w_asigna_hora_inscripcion_config_2014
integer x = 55
integer y = 1924
integer width = 3264
integer height = 356
integer taborder = 30
string dataobject = "d_cuentas_bloque_horario_insc_2014"
boolean resizable = true
end type

type rb_licenciatura from radiobutton within w_asigna_hora_inscripcion_config_2014
integer x = 2885
integer y = 60
integer width = 439
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Licenciatura"
boolean checked = true
end type

type rb_posgrado from radiobutton within w_asigna_hora_inscripcion_config_2014
integer x = 2885
integer y = 136
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Posgrado"
end type

type rb_preinscritos from radiobutton within w_asigna_hora_inscripcion_config_2014
integer x = 3465
integer y = 56
integer width = 338
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Preinscritos"
boolean checked = true
end type

type rb_no_preinscritos from radiobutton within w_asigna_hora_inscripcion_config_2014
integer x = 3465
integer y = 120
integer width = 411
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "No Preinscritos"
end type

type rb_todos from radiobutton within w_asigna_hora_inscripcion_config_2014
integer x = 3465
integer y = 184
integer width = 251
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Todos"
end type

type rb_ingreso from radiobutton within w_asigna_hora_inscripcion_config_2014
integer x = 2885
integer y = 184
integer width = 443
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "1er Ingreso (Lic)"
end type

type dw_bloque_horario_insc from u_dw within w_asigna_hora_inscripcion_config_2014
integer x = 55
integer y = 1380
integer width = 2990
integer height = 480
integer taborder = 10
string dataobject = "d_bloque_horario_insc"
boolean resizable = true
end type

event constructor;call super::constructor;this.of_SetRowManager(TRUE)
end event

event itemchanged;call super::itemchanged;//Si se modifica el número de alumnos, se debe repartir alumnos restantes
long ll_num_alumnos 
string ls_criterio, ls_grado, ls_cond_preinsc


IF dwo.name = "num_alumnos" THEN	
	ll_num_alumnos = long(data)
	
	IF ll_num_alumnos<0  THEN
		MessageBox("Número Incorrecto", "El número de alumnos debe ser positivo",StopSign!)
		RETURN 1
	ELSEIF ll_num_alumnos= 0 THEN
		ll_num_alumnos= -1 		
	END IF

	il_num_alumnos[row] = ll_num_alumnos
	ls_criterio = this.GetItemString(row,"criterio")
	ls_grado = mid(ls_criterio, 1, 1)
	ls_cond_preinsc = mid(ls_criterio, 2, 2)
	wf_establece_criterio_bloques(ls_grado, ls_cond_preinsc, ll_num_alumnos)
END IF
end event

type em_tamanio_bloque_mins from editmask within w_asigna_hora_inscripcion_config_2014
integer x = 709
integer y = 368
integer width = 274
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "30"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###"
string displaydata = "~t/"
end type

type st_3 from statictext within w_asigna_hora_inscripcion_config_2014
integer x = 37
integer y = 376
integer width = 645
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Tamaño Bloque Mins."
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_agregar_horario from commandbutton within w_asigna_hora_inscripcion_config_2014
integer x = 2176
integer y = 288
integer width = 457
integer height = 84
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Agregar Horario"
end type

event clicked;integer li_tamanio_bloque_mins =30, li_tamanio_bloque_segs, li_indice_array
time ltm_inicio_receso, ltm_fin_receso
time ltm_hora_ini, ltm_hora_fin
date ldt_calendar_inicial, ldt_calendar_final
datetime ldttm_calendar_inicial, ldttm_calendar_final
datetime ldttm_inicio_receso, ldttm_fin_receso
datetime la_dttm_horario[], ldttm_horario_actual, ldttm_horario_siguiente
time ltm_horario_actual, ltm_horario_siguiente
date ldt_horario_actual, ldt_horario_siguiente
string ls_fecha_listbox, ls_fecha_listbox_sin_num
long ll_find_listbox
integer li_fecha_repetida
int li_total, li_indice, li_pos_igual
string ls_fecha_actual, ls_fecha_actual_sn

li_tamanio_bloque_mins = integer(em_tamanio_bloque_mins.text)
ltm_inicio_receso      = time(em_inicio_receso.text)
ltm_fin_receso         = time(em_fin_receso.text)
ltm_hora_ini           = time(em_hora_ini.text)
ltm_hora_fin           = time(em_hora_fin.text)
ldt_calendar_inicial   = date(em_calendar_inicial.text)
//ldt_calendar_final     = date(em_calendar_final.text)

ldttm_calendar_inicial = datetime (ldt_calendar_inicial, ltm_hora_ini)
ldttm_calendar_final	  = datetime (ldt_calendar_inicial, ltm_hora_fin)

ldttm_inicio_receso = datetime (ldt_calendar_inicial, ltm_inicio_receso)
ldttm_fin_receso    = datetime (ldt_calendar_inicial, ltm_fin_receso)

if li_tamanio_bloque_mins <=0 or isnull(li_tamanio_bloque_mins) then
	MessageBox("Error en tamaño de bloque", "Favor de escribir un valor válido",StopSign!)
	return
end if

if ldttm_inicio_receso > ldttm_fin_receso then
	MessageBox("Error en hora de receso inicial y final", "No puede terminar antes de iniciar",StopSign!)
	return	
end if	

ii_num_criterio = ii_num_criterio +1

ls_fecha_listbox = string(ii_num_criterio)+"= "+string(ldttm_calendar_inicial,"dd/mm/yyyy hh:mm")+" - "+string(ldttm_calendar_final,"hh:mm")+" *"
ls_fecha_listbox_sin_num = string(ldttm_calendar_inicial,"dd/mm/yyyy hh:mm")+" - "+string(ldttm_calendar_final,"hh:mm")+" *"

setpointer(Hourglass!)
li_total=lb_dias_inscripcion.totalitems()

ll_find_listbox= -1

for li_indice=1 to li_total
	ls_fecha_actual =lb_dias_inscripcion.text(li_indice)
	li_pos_igual = pos(ls_fecha_actual,'=')
	ls_fecha_actual_sn = mid(ls_fecha_actual,li_pos_igual + 2)
	if ls_fecha_actual_sn = ls_fecha_listbox_sin_num then
		ll_find_listbox = 	li_indice
		EXIT
	end if
next


if ll_find_listbox <> -1 then
	li_fecha_repetida = MessageBox("Fecha Existente", "¿Desea repetir la fecha correspondiente?",Question!, YesNo!)
	if li_fecha_repetida <> 1 then
		return	
	else
		lb_dias_inscripcion.AddItem (ls_fecha_listbox)
	end if
else
	lb_dias_inscripcion.AddItem (ls_fecha_listbox)
end if



//if ldttm_inicio_receso < ldttm_calendar_inicial then
//	MessageBox("Error en hora de receso inicial", "No puede inciar antes del horario de atención",StopSign!)
//	return	
//end if
//
//if ldttm_calendar_final < ldttm_inicio_receso  then
//	MessageBox("Error en hora de receso inicial", "No puede inciar despues del horario de atención",StopSign!)
//	return	
//end if

//Calcula el número de segundos en base a los minutos calculados
li_tamanio_bloque_segs = li_tamanio_bloque_mins * 60 



//Asigna el horario actual
ldttm_horario_actual = ldttm_calendar_inicial
ltm_horario_actual = ltm_hora_ini

//Calcula el proximo horario, sumandole al horario actual los minutos/segundos correspondientes
ltm_horario_siguiente   = RelativeTime ( ltm_hora_ini, li_tamanio_bloque_segs )
ldt_horario_actual = ldt_calendar_inicial


li_indice_array = 1

DO 
	
	ldttm_horario_actual = datetime(ldt_horario_actual, ltm_horario_actual)
	la_dttm_horario[li_indice_array]= ldttm_horario_actual

	//Si el horario siguiente todavia es antes de que temine el dia
	if ltm_horario_siguiente < ltm_hora_fin then
		//Asigna el siguiente horario calculado
		ldt_horario_siguiente = ldt_horario_actual
		ltm_horario_siguiente   = RelativeTime ( ltm_horario_actual, li_tamanio_bloque_segs )
		ldttm_horario_siguiente = datetime(ldt_calendar_inicial,  ltm_horario_siguiente)

	end if

	//Si el horario siguiente cae en el receso
	if (ltm_inicio_receso < RelativeTime (ltm_horario_siguiente, li_tamanio_bloque_segs ) AND &
		RelativeTime (ltm_horario_siguiente, li_tamanio_bloque_segs )  < ltm_fin_receso) OR &
		(ltm_inicio_receso < ltm_horario_siguiente AND &
		 ltm_horario_siguiente  < ltm_fin_receso) THEN
		 //Asigna el fin del receso como inicio del siguiente bloque
		ldt_horario_siguiente = ldt_calendar_inicial
		ltm_horario_siguiente   = ltm_fin_receso
		ldttm_horario_siguiente = datetime(ldt_calendar_inicial,  ltm_fin_receso)
	end if
	
	li_indice_array = li_indice_array + 1
	ltm_horario_actual = ltm_horario_siguiente
	ldt_horario_actual = ldt_horario_siguiente

LOOP WHILE ltm_horario_actual < ltm_hora_fin


long ll_row, ll_rows, ll_tamanio_array, ll_insertrow
datetime ldttm_hora_inicial
string ls_criterio = 'LP'
ll_tamanio_array = UpperBound ( la_dttm_horario)

FOR ll_row = 1 TO ll_tamanio_array
	ldttm_hora_inicial = la_dttm_horario[ll_row]
	
	ll_insertrow = dw_bloque_horario_insc.InsertRow(0)
	dw_bloque_horario_insc.SetItem(ll_insertrow, "num_criterio",  ii_num_criterio)
	dw_bloque_horario_insc.SetItem(ll_insertrow, "num_horario",  ll_row)
	dw_bloque_horario_insc.SetItem(ll_insertrow, "tamanio_bloque_mins",  li_tamanio_bloque_mins)
	dw_bloque_horario_insc.SetItem(ll_insertrow, "fecha", ldt_calendar_inicial )
	dw_bloque_horario_insc.SetItem(ll_insertrow, "hora_inicial",  ldttm_hora_inicial)
	dw_bloque_horario_insc.SetItem(ll_insertrow, "criterio", ls_criterio )
	dw_bloque_horario_insc.SetItem(ll_insertrow, "num_alumnos", 0 )
		
NEXT

end event

type st_2 from statictext within w_asigna_hora_inscripcion_config_2014
integer x = 41
integer y = 576
integer width = 640
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Horario Reinscripción"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_asigna_hora_inscripcion_config_2014
integer x = 187
integer y = 472
integer width = 494
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Horario Receso"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fin_receso from editmask within w_asigna_hora_inscripcion_config_2014
integer x = 1015
integer y = 468
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "15:00"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm:ss"
string displaydata = ""
end type

event modified;time ini
long dif

ini	=	time(this.text)

dif	=	secondsafter(time(em_inicio_receso.text),ini)
if dif < 0 then
	this.text =	"15:00:00"
else
	dif	=	secondsafter(time("20:00:00"),ini)
	if dif >		0 then
		this.text	=	"15:00:00"
	end if
end if
end event

type em_inicio_receso from editmask within w_asigna_hora_inscripcion_config_2014
integer x = 709
integer y = 468
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "14:00"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm:ss"
string displaydata = ""
end type

event modified;time ini
long dif

ini	=	time(this.text)

dif	=	secondsafter(time("07:00:00"),ini)
if dif < 0 then
	this.text =	"14:00:00"
else
	dif	=	secondsafter(time("20:00:00"),ini)
	if dif >		0 then
		this.text	=	"14:00:00"
	end if
end if
end event

type em_hora_fin from editmask within w_asigna_hora_inscripcion_config_2014
integer x = 1431
integer y = 568
integer width = 274
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "18:00"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm:ss"
string displaydata = ""
end type

event modified;time ini
long dif

ini	=	time(this.text)

dif	=	secondsafter(time(em_hora_ini.text),ini)
if dif < 0 then
	this.text =	"18:00:00"
else
	dif	=	secondsafter(time("20:00:00"),ini)
	if dif >		0 then
		this.text	=	"18:00:00"
	end if
end if
end event

type em_hora_ini from editmask within w_asigna_hora_inscripcion_config_2014
integer x = 1147
integer y = 568
integer width = 274
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "9:00"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = timemask!
string mask = "hh:mm:ss"
string displaydata = ""
end type

event modified;time ini
long dif

ini	=	time(this.text)

dif	=	secondsafter(time("07:00:00"),ini)
if dif < 0 then
	this.text =	"08:00:00"
else
	dif	=	secondsafter(time("20:00:00"),ini)
	if dif >		0 then
		this.text	=	"09:00:00"
	end if
end if
end event

type p_final from picture within w_asigna_hora_inscripcion_config_2014
boolean visible = false
integer x = 1819
integer y = 324
integer width = 59
integer height = 84
boolean bringtotop = true
string picturename = "ddarrow.bmp"
boolean focusrectangle = false
end type

event clicked;em_calendar_final.Event pfc_ddcalendar ( )
end event

type em_calendar_final from u_em within w_asigna_hora_inscripcion_config_2014
boolean visible = false
integer x = 1445
integer y = 324
integer width = 370
integer height = 84
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;Integer  li_return   

this.text= string(today())
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_SetInitialValue(TRUE)
//this.iuo_calendar.x =1
//this.iuo_calendar.y =1
//
this.iuo_calendar.x =143
this.iuo_calendar.y =650
//
//this.iuo_calendar.of_SetCloseOnClick(FALSE) 
//this.iuo_calendar.of_SetCloseOnDClick(FALSE)  

//li_return = this.Event pfc_DDCalendar()
//this.iuo_calendar.of_SetDropDown(TRUE)

end event

type p_inicial from picture within w_asigna_hora_inscripcion_config_2014
integer x = 1083
integer y = 568
integer width = 59
integer height = 84
boolean bringtotop = true
string picturename = "ddarrow.bmp"
boolean focusrectangle = false
end type

event clicked;//em_calendar_inicial.Event pfc_ddcalendar ( )

if mc_calendar.visible then
	mc_calendar.Hide()
else
	mc_calendar.Show()
end if


end event

type em_calendar_inicial from u_em within w_asigna_hora_inscripcion_config_2014
integer x = 709
integer y = 568
integer width = 370
integer height = 84
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;Integer  li_return   

this.text= string(today())
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_SetInitialValue(TRUE)
//this.iuo_calendar.x =1
//this.iuo_calendar.y =1
//
this.iuo_calendar.x =143
this.iuo_calendar.y =650
//
this.iuo_calendar.of_SetCloseOnClick(TRUE) 
//this.iuo_calendar.of_SetCloseOnDClick(FALSE)  

li_return = this.Event pfc_DDCalendar()
this.iuo_calendar.of_SetDropDown(TRUE)

end event

type gb_preinscripcion from groupbox within w_asigna_hora_inscripcion_config_2014
integer x = 3433
integer y = 12
integer width = 503
integer height = 256
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Preinscripción"
end type

type gb_grado from groupbox within w_asigna_hora_inscripcion_config_2014
integer x = 2839
integer y = 12
integer width = 503
integer height = 256
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
string text = "Grado"
end type

type lb_dias_inscripcion from listbox within w_asigna_hora_inscripcion_config_2014
integer x = 1865
integer y = 732
integer width = 937
integer height = 432
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
boolean sorted = false
boolean multiselect = true
borderstyle borderstyle = stylelowered!
end type

type gb_seleccionados from groupbox within w_asigna_hora_inscripcion_config_2014
integer x = 1829
integer y = 664
integer width = 1010
integer height = 536
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Dias de Reinscripción"
end type

