$PBExportHeader$w_grupos_impartidos_bloque.srw
forward
global type w_grupos_impartidos_bloque from window
end type
type uo_periodo from uo_per_ani_grupos_mod within w_grupos_impartidos_bloque
end type
type st_tot_capt from statictext within w_grupos_impartidos_bloque
end type
type st_horas_capturadas_totales from statictext within w_grupos_impartidos_bloque
end type
type st_horas_totales from statictext within w_grupos_impartidos_bloque
end type
type st_tot_per from statictext within w_grupos_impartidos_bloque
end type
type cb_detalle_sesiones from commandbutton within w_grupos_impartidos_bloque
end type
type dw_sesiones from datawindow within w_grupos_impartidos_bloque
end type
type pb_borra_sesion from picturebutton within w_grupos_impartidos_bloque
end type
type pb_inserta_sesion from picturebutton within w_grupos_impartidos_bloque
end type
type dw_sesiones_detalle from datawindow within w_grupos_impartidos_bloque
end type
type cb_sesionar from checkbox within w_grupos_impartidos_bloque
end type
type cb_1 from commandbutton within w_grupos_impartidos_bloque
end type
type st_profesor_titular from statictext within w_grupos_impartidos_bloque
end type
type cbx_sdu_servicios_escolares from checkbox within w_grupos_impartidos_bloque
end type
type st_estatus from statictext within w_grupos_impartidos_bloque
end type
type st_hor_cap_semanal from statictext within w_grupos_impartidos_bloque
end type
type st_hor_min_semanal from statictext within w_grupos_impartidos_bloque
end type
type st_horas_capturadas from statictext within w_grupos_impartidos_bloque
end type
type st_horas_minimas from statictext within w_grupos_impartidos_bloque
end type
type dw_grupos_paquetes_b from datawindow within w_grupos_impartidos_bloque
end type
type dw_selecciona_paquete_b from datawindow within w_grupos_impartidos_bloque
end type
type mc_profesor from monthcalendar within w_grupos_impartidos_bloque
end type
type dp_fin from datepicker within w_grupos_impartidos_bloque
end type
type dp_inicio from datepicker within w_grupos_impartidos_bloque
end type
type pb_inserta_profesor from picturebutton within w_grupos_impartidos_bloque
end type
type pb_borra_profesor from picturebutton within w_grupos_impartidos_bloque
end type
type pb_inserta_horario from picturebutton within w_grupos_impartidos_bloque
end type
type sle_comentarios from singlelineedit within w_grupos_impartidos_bloque
end type
type st_2 from statictext within w_grupos_impartidos_bloque
end type
type st_1 from statictext within w_grupos_impartidos_bloque
end type
type uo_periodo_2 from uo_per_ani within w_grupos_impartidos_bloque
end type
type dw_profesor from datawindow within w_grupos_impartidos_bloque
end type
type dw_horario from datawindow within w_grupos_impartidos_bloque
end type
type gb_1 from groupbox within w_grupos_impartidos_bloque
end type
type pb_borra_horario from picturebutton within w_grupos_impartidos_bloque
end type
type gb_horario from groupbox within w_grupos_impartidos_bloque
end type
type dw_grupo from datawindow within w_grupos_impartidos_bloque
end type
type cbx_multitular from checkbox within w_grupos_impartidos_bloque
end type
end forward

global type w_grupos_impartidos_bloque from window
integer width = 7182
integer height = 3160
boolean titlebar = true
string title = "Grupos Impartidos"
string menuname = "m_grupos_impartidos_bloque"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_nuevo ( )
uo_periodo uo_periodo
st_tot_capt st_tot_capt
st_horas_capturadas_totales st_horas_capturadas_totales
st_horas_totales st_horas_totales
st_tot_per st_tot_per
cb_detalle_sesiones cb_detalle_sesiones
dw_sesiones dw_sesiones
pb_borra_sesion pb_borra_sesion
pb_inserta_sesion pb_inserta_sesion
dw_sesiones_detalle dw_sesiones_detalle
cb_sesionar cb_sesionar
cb_1 cb_1
st_profesor_titular st_profesor_titular
cbx_sdu_servicios_escolares cbx_sdu_servicios_escolares
st_estatus st_estatus
st_hor_cap_semanal st_hor_cap_semanal
st_hor_min_semanal st_hor_min_semanal
st_horas_capturadas st_horas_capturadas
st_horas_minimas st_horas_minimas
dw_grupos_paquetes_b dw_grupos_paquetes_b
dw_selecciona_paquete_b dw_selecciona_paquete_b
mc_profesor mc_profesor
dp_fin dp_fin
dp_inicio dp_inicio
pb_inserta_profesor pb_inserta_profesor
pb_borra_profesor pb_borra_profesor
pb_inserta_horario pb_inserta_horario
sle_comentarios sle_comentarios
st_2 st_2
st_1 st_1
uo_periodo_2 uo_periodo_2
dw_profesor dw_profesor
dw_horario dw_horario
gb_1 gb_1
pb_borra_horario pb_borra_horario
gb_horario gb_horario
dw_grupo dw_grupo
cbx_multitular cbx_multitular
end type
global w_grupos_impartidos_bloque w_grupos_impartidos_bloque

type variables
uo_grupo_servicios iuo_grupo_servicios 
uo_materias_servicios iuo_materias_servicios 
uo_profesor_servicios iuo_profesor_servicios 

DATASTORE ids_horario_profesor
DATASTORE ids_sesiones_grupo 

DATASTORE ids_sesiones_valida_prof 
BOOLEAN ib_permite_modulares

INTEGER ii_periodo, ii_anio 
BOOLEAN ib_modifica_salon

n_tr itr_sce , itr_parametros_iniciales, itr_seguridad

// 1 = Tradicional, 2 = Modular  
INTEGER ie_forma_imparte 

DATE idt_fecha_profesor 
STRING is_fecha_selec 

LONG il_coordinacion 
LONG il_materia 

INTEGER ie_paquete 
INTEGER ie_modo 

INTEGER ie_modo_opera

//Nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx		=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx			=	"controlescolar_inscripcion_becas"


STRING is_multititular 
INTEGER ie_cambia_periodo
BOOLEAN ib_carga  

BOOLEAN ib_permite_modular

BOOLEAN ib_modificado

INTEGER ie_horas_totales_semestre

//BOOLEAN ib_omite_set_value 









end variables

forward prototypes
public function integer wf_inicializa_servicio ()
public function integer wf_fechas_default ()
public function integer wf_despliega_grupo ()
public function integer wf_habilita ()
public function integer wf_carga_lista_paquetes ()
public function integer wf_inicializa_horario_prof ()
public function integer wf_cuenta_horas_grupo ()
public function integer wf_calcula_horas_reales (integer ai_mensajes)
public function integer wf_valida_horas_profesor ()
public function integer wf_reinicia_fecha_profesores ()
public function integer wf_recupera_profesor (integer ae_row, long al_cve_profesor)
public function integer wf_borra_horario_profesor (long al_cve_profesor)
public function integer wf_recupera_materia_asimila ()
public function integer wf_habilita_cambios ()
public function integer wf_obten_titulo ()
public function integer wf_filtra_clase_aula ()
public function integer wf_carga_horas_permitidas ()
public function integer wf_habilita_multititular ()
public function integer wf_despliega_profesor_titular (integer ai_proceso)
public function integer wf_asigna_fechas_grupo_modular ()
public function integer wf_habilita_sesion ()
public function integer wf_valida_sesiones ()
public function integer wf_inicia_fechas_feault ()
public function integer wf_cambia_periodo_trabajo (integer ai_cambia_periodo)
public function integer wf_calcula_horas_multitular (long al_profesor)
public function date wf_regresa_fecha ()
public function boolean wf_valida_aplica_sesionado (long al_cve_materia)
public function integer wf_aplica_seguridad ()
public function integer wf_ordena_profesor ()
public function integer wf_confirma_salida ()
public function boolean wf_valida_salon_en_linea ()
end prototypes

event ue_nuevo();INTEGER li_retorno 

// Se recupera desde el evento "nuevo" de dw_grupo 
//li_retorno = f_obten_periodo(ii_periodo, ii_anio, 4) 

//ii_periodo = 0 
//ii_anio = 2019

//IF NOT ib_omite_set_value THEN 

	THIS.uo_periodo.em_ani.text = string(ii_anio)
	THIS.uo_periodo.em_per.text = string(ii_periodo)
//	ib_omite_set_value = FALSE 
	
//END IF 	

iuo_grupo_servicios.ie_periodo = ii_periodo
iuo_grupo_servicios.ie_anio = ii_anio  

dw_grupo.RESET() 
dw_grupo.INSERTROW(0)
dw_grupo.SETITEM(1, "grupos_forma_imparte", 1)
dw_grupo.SETITEM(1, "grupos_cond_gpo", 1)
dw_grupo.SETITEM(1, "grupos_idioma", 1)
dw_grupo.SETITEM(1, "grupos_inscritos", 0)
dw_grupo.SETITEM(1, "grupos_tipo", 0) 
ib_permite_modulares = TRUE 
dw_grupo.TRIGGEREVENT("ue_filtra_tipo_grupo") 

ie_forma_imparte = 1 
cb_sesionar.CHECKED = FALSE 

dw_grupo.TRIGGEREVENT("ue_habilita")
dw_grupo.TRIGGEREVENT("ue_valida_asimilado")

dw_profesor.RESET()
dw_profesor.INSERTROW(0)
dw_profesor.SETITEM(1, "titularidad", 1)
dw_profesor.SETITEM(1, "profesor_cotitular_autorizado", 1)
//dw_profesor.SETITEM(1, "profesor_cotitular_autorizado", 0)
INTEGER le_row, valor
IF ie_modo_opera = 2 THEN 
	SETNULL(valor) 
ELSE
	//valor = 0
	// Por forma imparte, siempre se va a poner nulo en clase aula
	SETNULL(valor) 
END IF
dw_horario.RESET() 
le_row = dw_horario.INSERTROW(0)
dw_horario.SETITEM(le_row, "clase_aula", valor) 
ids_horario_profesor.RESET() 

ib_modifica_salon = FALSE 

wf_fechas_default()
wf_habilita() 

st_estatus.TEXT = "Alta Grupo"
ie_modo = 1 

dw_grupo.MODIFY("cve_mat.protect = 0") 
dw_grupo.MODIFY("materias_materia.protect = 0") 
dw_grupo.MODIFY("gpo.protect = 0") 

st_horas_minimas.TEXT = "0"
st_horas_capturadas.TEXT = "0" 

wf_habilita_cambios()
wf_filtra_clase_aula() 


dw_grupo.MODIFY("gpo.PROTECT = 0")
dw_grupo.MODIFY("gpo.Background.Color = '1073741824'")				

dw_grupo.MODIFY("cve_mat.PROTECT = 0")
dw_grupo.MODIFY("cve_mat.Background.Color = '1073741824'")				
dw_grupo.Modify("b_buscar.Visible = 1")	

dw_grupo.MODIFY("grupos_cve_asimilada.PROTECT = 1")
dw_grupo.MODIFY("grupos_gpo_asimilado.PROTECT = 1")
dw_grupo.Modify("grupos_cve_asimilada.Background.Color = '67108864'")
dw_grupo.Modify("grupos_gpo_asimilado.Background.Color = '67108864'")

st_profesor_titular.TEXT = "" 
sle_comentarios.TEXT = "" 

cbx_multitular.ENABLED = TRUE 
cbx_multitular.CHECKED = FALSE
cbx_multitular.TRIGGEREVENT(CLICKED!)

DATAWINDOWCHILD ldwc_tipo_prof 
DATAWINDOWCHILD ldwc_estatus_prof
dw_profesor.GETCHILD("profesor_cotitular_tipo_profesor", ldwc_tipo_prof)
ldwc_tipo_prof.SETTRANSOBJECT(itr_sce) 
ldwc_tipo_prof.RETRIEVE() 
dw_profesor.GETCHILD("profesor_cotitular_autorizado", ldwc_estatus_prof)
ldwc_estatus_prof.SETTRANSOBJECT(itr_sce) 
ldwc_estatus_prof.RETRIEVE() 

// Se reinician los detalles de sesiones.
dw_sesiones_detalle.RESET()
dw_sesiones.RESET()
dw_sesiones.VISIBLE = FALSE 


dw_grupo.SETFOCUS() 
dw_grupo.SETCOLUMN("cve_mat")  

ib_modificado = FALSE 

RETURN 



end event

public function integer wf_inicializa_servicio ();INTEGER le_pos

// Se reinicia el servicio.
iuo_grupo_servicios.of_nuevo()  
INTEGER le_horas_reales_base

iuo_grupo_servicios.il_cve_mat = dw_grupo.GETITEMNUMBER(1, "cve_mat")
iuo_grupo_servicios.is_gpo = dw_grupo.GETITEMSTRING(1, "gpo")
iuo_grupo_servicios.is_cve_mat_gpo = STRING(iuo_grupo_servicios.il_cve_mat) + iuo_grupo_servicios.is_gpo 
iuo_grupo_servicios.ie_periodo = ii_periodo
iuo_grupo_servicios.ie_anio = ii_anio  
iuo_grupo_servicios.ie_cond_gpo = dw_grupo.GETITEMNUMBER(1, "grupos_cond_gpo")  
iuo_grupo_servicios.ie_cupo = dw_grupo.GETITEMNUMBER(1, "grupos_cupo") 
iuo_grupo_servicios.ie_tipo  = dw_grupo.GETITEMNUMBER(1, "grupos_tipo")
iuo_grupo_servicios.ie_inscritos = dw_grupo.GETITEMNUMBER(1, "grupos_inscritos") 
iuo_grupo_servicios.ie_insc_desp_bajas = dw_grupo.GETITEMNUMBER(1, "grupos_insc_desp_bajas") 
iuo_grupo_servicios.il_cve_asimilada = dw_grupo.GETITEMNUMBER(1, "grupos_cve_asimilada")
iuo_grupo_servicios.is_gpo_asimilado = dw_grupo.GETITEMSTRING(1, "grupos_gpo_asimilado") 
iuo_grupo_servicios.ie_modalidad = dw_grupo.GETITEMNUMBER(1, "grupos_modalidad")  

//iuo_grupo_servicios.ie_horas_reales_tot_sem = dw_grupo.GETITEMNUMBER(1, "grupos_horas_reales")  
le_horas_reales_base = dw_grupo.GETITEMNUMBER(1, "materias_horas_reales")  

IF le_horas_reales_base > 0 THEN 
	iuo_grupo_servicios.ie_factor_horas = iuo_grupo_servicios.ie_horas_reales_tot_sem/le_horas_reales_base 
END IF

IF cb_sesionar.CHECKED THEN 
	iuo_grupo_servicios.is_sesionado = 'S' 
ELSE
	iuo_grupo_servicios.is_sesionado = 'N'
END IF 

le_pos = dw_profesor.FIND("titularidad = 1", 0, dw_profesor.ROWCOUNT() + 1) 
IF le_pos > 0 THEN 
	iuo_grupo_servicios.il_cve_profesor = dw_profesor.GETITEMNUMBER(le_pos, "cve_profesor")
ELSE
	iuo_grupo_servicios.il_cve_profesor = 0 
END IF 


iuo_grupo_servicios.ie_primer_sem = 0
iuo_grupo_servicios.is_comentarios = sle_comentarios.TEXT 
iuo_grupo_servicios.ie_forma_imparte = dw_grupo.GETITEMNUMBER(1, "grupos_forma_imparte") 
iuo_grupo_servicios.idt_fecha_inicio = dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio")
iuo_grupo_servicios.idt_fecha_fin = dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin")
iuo_grupo_servicios.il_idioma = dw_grupo.GETITEMNUMBER(1, "grupos_idioma") 

IF il_coordinacion = 9999 THEN 
	iuo_grupo_servicios.ib_afecta_sdu_serv_esc = cbx_sdu_servicios_escolares.CHECKED 
ELSE
	iuo_grupo_servicios.ib_afecta_sdu_serv_esc = FALSE
END IF	

// Si es asimilado no guarda los detalles de horario y profesor
IF iuo_grupo_servicios.ie_tipo = 2 THEN RETURN 0 


INTEGER le_row_ins 

LONG ll_cve_profesor
INTEGER le_titularidad
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin
INTEGER le_horas_totales 
INTEGER le_tipo_profesor 
INTEGER le_profesor_autorizado 
STRING ls_evalua 

// Se pasa el detalle de PROFESORES.
FOR le_pos = 1 TO dw_profesor.ROWCOUNT() 

	ll_cve_profesor = dw_profesor.GETITEMNUMBER(le_pos, "cve_profesor") 
	// Si no se ha especificado el profesor continua el ciclo. 
	IF ISNULL(ll_cve_profesor) THEN CONTINUE 
	le_titularidad = dw_profesor.GETITEMNUMBER(le_pos, "titularidad")	
	ldt_fecha_inicio = dw_profesor.GETITEMDATETIME(le_pos, "fecha_inicio")	
	ldt_fecha_fin = dw_profesor.GETITEMDATETIME(le_pos, "fecha_fin")	 
	le_horas_totales = dw_profesor.GETITEMNUMBER(le_pos, "horas_profesor")

	le_tipo_profesor =  dw_profesor.GETITEMNUMBER(le_pos, "profesor_cotitular_tipo_profesor") 
	le_profesor_autorizado = dw_profesor.GETITEMNUMBER(le_pos, "profesor_cotitular_autorizado") 
	ls_evalua = dw_profesor.GETITEMSTRING(le_pos, "profesor_cotitular_evalua")  

	
	
	le_row_ins = iuo_grupo_servicios.ids_profesor.INSERTROW(0) 
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "cve_mat", iuo_grupo_servicios.il_cve_mat)
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "gpo", iuo_grupo_servicios.is_gpo)
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "periodo", iuo_grupo_servicios.ie_periodo)
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "anio", iuo_grupo_servicios.ie_anio)   
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "cve_profesor", ll_cve_profesor)	
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "titularidad", le_titularidad)	
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "fecha_inicio", ldt_fecha_inicio)	
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "fecha_fin", ldt_fecha_fin)	    
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "horas_totales_grupo", le_horas_totales)	 
	
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "tipo_profesor", le_tipo_profesor)	 
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "autorizado", le_profesor_autorizado)	  
	
	iuo_grupo_servicios.ids_profesor.SETITEM(le_row_ins, "evalua", ls_evalua)	   
	
NEXT 


INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
INTEGER le_clase_aula 
STRING ls_comentario

iuo_grupo_servicios.ie_horas_horario = 0 

// Se pasa el detalle de HORARIOS. 
FOR le_pos = 1 TO dw_horario.ROWCOUNT() 

	le_cve_dia = dw_horario.GETITEMNUMBER(le_pos, "cve_dia") 	
	ls_cve_salon = dw_horario.GETITEMSTRING(le_pos, "cve_salon") 
	le_hora_inicio = dw_horario.GETITEMNUMBER(le_pos, "hora_inicio") 	 
	le_hora_final = dw_horario.GETITEMNUMBER(le_pos, "hora_final") 	 
	le_clase_aula = dw_horario.GETITEMNUMBER(le_pos, "clase_aula")   
	ls_comentario = dw_horario.GETITEMSTRING(le_pos, "comentario")    
	
	
	// Se inicializa el Horario del Profesor para validación.  
	le_row_ins = iuo_grupo_servicios.ids_horario.INSERTROW(0)
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_mat", iuo_grupo_servicios.il_cve_mat)	
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "gpo", iuo_grupo_servicios.is_gpo)	
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "periodo", iuo_grupo_servicios.ie_periodo)	 
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "anio", iuo_grupo_servicios.ie_anio)	
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_dia", le_cve_dia)	
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_salon", ls_cve_salon)	
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "hora_inicio", le_hora_inicio)	
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "hora_final", le_hora_final)	
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "clase_aula", le_clase_aula) 
	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "comentario", ls_comentario) 

	IF ISNULL(le_hora_inicio) THEN le_hora_inicio = 0 
	IF ISNULL(le_hora_final) THEN le_hora_final = 0 
	iuo_grupo_servicios.ie_horas_horario = iuo_grupo_servicios.ie_horas_horario + (le_hora_final - le_hora_inicio) 

NEXT 


//INTEGER le_cve_mat
//STRING ls_gpo
//INTEGER le_periodo
//INTEGER le_anio
INTEGER le_orden

// Se inicializa el detalle de SESIONES DE GRUPOS. 
FOR le_pos = 1 TO dw_sesiones_detalle.ROWCOUNT()   
	
//	le_cve_mat = dw_sesiones.GETITEMNUMBER(le_pos, "cve_mat")
//	ls_gpo = dw_sesiones.GETITEMSTRING(le_pos, "gpo")
//	le_periodo = dw_sesiones.GETITEMNUMBER(le_pos, "periodo")
//	le_anio = dw_sesiones.GETITEMNUMBER(le_pos, "anio")
	le_cve_dia = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "cve_dia")
	ls_cve_salon = dw_sesiones_detalle.GETITEMSTRING(le_pos, "cve_salon")
	le_hora_inicio = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "hora_inicio")
	le_hora_final = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "hora_final")
	ldt_fecha_inicio = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_inicio")
	ldt_fecha_fin = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_fin")
	le_orden = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "horario_modular_orden") 	


	le_pos = iuo_grupo_servicios.ids_grupo_sesion.INSERTROW(0)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "cve_mat", iuo_grupo_servicios.il_cve_mat)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "gpo", iuo_grupo_servicios.is_gpo)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "periodo", iuo_grupo_servicios.ie_periodo)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "anio", iuo_grupo_servicios.ie_anio)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "cve_dia", le_cve_dia)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "cve_salon", ls_cve_salon)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "hora_inicio", le_hora_inicio)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "hora_final", le_hora_final)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "fecha_inicio", ldt_fecha_inicio)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "fecha_fin", ldt_fecha_fin)
	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "horario_modular_orden", le_orden) 

NEXT 


iuo_grupo_servicios.ids_grupos_bloques.RESET() 
dw_sesiones.ROWSCOPY(1, dw_sesiones.ROWCOUNT(), PRIMARY!, iuo_grupo_servicios.ids_grupos_bloques, 1, PRIMARY!)   

// Se recupera el horario original
iuo_grupo_servicios.of_carga_horario_org() 

// Se llama función de cálculo de horas totales por semestre. 
ie_horas_totales_semestre = iuo_grupo_servicios.of_horas_semestre() 


RETURN 0 





end function

public function integer wf_fechas_default ();
dw_grupo.SETITEM(1, "grupos_fecha_inicio", iuo_grupo_servicios.idt_inicio_periodo)  
dw_grupo.SETITEM(1, "grupos_fecha_fin", iuo_grupo_servicios.idt_fin_periodo)  
//dw_grupo.SETITEM(1, "grupos_horas_reales", dw_grupo.GETITEMNUMBER(1, "materias_horas_reales"))  

dp_inicio.setvalue(iuo_grupo_servicios.idt_inicio_periodo)
dp_fin.setvalue(iuo_grupo_servicios.idt_fin_periodo)

RETURN 0





end function

public function integer wf_despliega_grupo ();
st_profesor_titular.TEXT = "" 

//dw_grupo.GETITEMNUMBER(1, "cve_mat", iuo_grupo_servicios.il_cve_mat)
 //dw_grupo.GETITEMSTRING(1, "gpo", iuo_grupo_servicios.is_gpo)
//iuo_grupo_servicios.is_cve_mat_gpo = STRING(iuo_grupo_servicios.il_cve_mat) + iuo_grupo_servicios.is_gpo 
//iuo_grupo_servicios.ie_periodo = ii_periodo
//iuo_grupo_servicios.ie_anio = ii_anio  
dw_grupo.SETITEM(1, "grupos_cond_gpo", iuo_grupo_servicios.ie_cond_gpo)  
dw_grupo.SETITEM(1, "grupos_cupo", iuo_grupo_servicios.ie_cupo) 
dw_grupo.SETITEM(1, "grupos_tipo", iuo_grupo_servicios.ie_tipo)
dw_grupo.SETITEM(1, "grupos_inscritos", iuo_grupo_servicios.ie_inscritos) 
dw_grupo.SETITEM(1, "grupos_insc_desp_bajas", iuo_grupo_servicios.ie_insc_desp_bajas) 
dw_grupo.SETITEM(1, "grupos_cve_asimilada", iuo_grupo_servicios.il_cve_asimilada)
dw_grupo.SETITEM(1, "grupos_gpo_asimilado", iuo_grupo_servicios.is_gpo_asimilado) 
dw_grupo.SETITEM(1, "grupos_modalidad", iuo_grupo_servicios.ie_modalidad) 



/*QUEDA PENDIENTE LA CARGA DEL PROFESOR*/
//le_pos = dw_profersor.FIND("titularidad = 1", 0, dw_profersor.ROWCOUNT() + 1) 
//IF le_pos > 0 THEN 
//	iuo_grupo_servicios.il_cve_profesor = dw_profersor.GETITEMNUMBER(le_pos, "cve_profesor")
//ELSE
//	iuo_grupo_servicios.il_cve_profesor = 0 
//END IF 

//iuo_grupo_servicios.id_prom_gpo
//iuo_grupo_servicios.id_porc_asis
//iuo_grupo_servicios.id_ema4

dw_grupo.SETITEM(1, "grupos_primer_sem", iuo_grupo_servicios.ie_primer_sem)  
sle_comentarios.TEXT = iuo_grupo_servicios.is_comentarios 

//iuo_grupo_servicios.il_demanda_inscritos

dw_grupo.SETITEM(1, "grupos_forma_imparte", iuo_grupo_servicios.ie_forma_imparte) 
ie_forma_imparte = iuo_grupo_servicios.ie_forma_imparte 
dw_grupo.SETITEM(1, "grupos_fecha_inicio", iuo_grupo_servicios.idt_fecha_inicio)
dw_grupo.SETITEM(1, "grupos_fecha_fin", iuo_grupo_servicios.idt_fecha_fin)

// SI no se ha especificado el idioma se asigna por default ESPAÑOL
IF ISNULL(iuo_grupo_servicios.il_idioma) THEN iuo_grupo_servicios.il_idioma = 1
dw_grupo.SETITEM(1, "grupos_idioma", iuo_grupo_servicios.il_idioma)  

//dw_grupo.SETITEM(1, "grupos_factor_horas", (iuo_grupo_servicios.ie_factor_horas * dw_grupo.GETITEMNUMBER(1, "materias_horas_reales"))) 
//dw_grupo.SETITEM(1, "materias_horas_reales", iuo_grupo_servicios.ie_factor_horas)
//dw_grupo.SETITEM(1, "grupos_horas_reales", (iuo_grupo_servicios.ie_factor_horas * dw_grupo.GETITEMNUMBER(1, "materias_horas_reales"))) 
//dw_grupo.SETITEM(1, "grupos_factor_horas", le_horas) 

//
//
//
//
//
//le_horas_reales_base = dw_grupo.GETITEMNUMBER(1, "materias_horas_reales")  
//IF le_horas_reales_base > 0 THEN 
//	iuo_grupo_servicios.ie_factor_horas = iuo_grupo_servicios.ie_horas_reales_tot_sem/le_horas_reales_base 
//END IF
	





// Se despliega el detalle de Horario.
dw_horario.SETTRANSOBJECT(itr_sce) 
dw_horario.RETRIEVE(iuo_grupo_servicios.il_cve_mat, iuo_grupo_servicios.is_gpo, iuo_grupo_servicios.ie_periodo, iuo_grupo_servicios.ie_anio) 

// Se despliegan Profesores asociados. 
INTEGER le_num_profesores
dw_profesor.SETTRANSOBJECT(itr_sce) 
le_num_profesores = dw_profesor.RETRIEVE(iuo_grupo_servicios.il_cve_mat, iuo_grupo_servicios.is_gpo, iuo_grupo_servicios.ie_periodo, iuo_grupo_servicios.ie_anio) 
IF le_num_profesores > 1 THEN 
	cbx_multitular.CHECKED = TRUE 
	is_multititular = 'S' 
ELSE 	
	cbx_multitular.CHECKED = FALSE  
END IF	


ids_horario_profesor.RESET() 
iuo_grupo_servicios.ids_horario_profesor.ROWSCOPY(1, iuo_grupo_servicios.ids_horario_profesor.ROWCOUNT(), PRIMARY!, ids_horario_profesor, 1, PRIMARY! )

// Si no tiene capturado horario de profesor, se genera dicho horario.
IF ids_horario_profesor.ROWCOUNT() = 0 THEN 
	POST wf_calcula_horas_multitular(0)
END IF 		
		
		
/*Se despliega el detalle de sesiones*/   
dw_sesiones.RESET()  
iuo_grupo_servicios.ids_grupos_bloques.ROWSCOPY(1, iuo_grupo_servicios.ids_grupos_bloques.ROWCOUNT(), PRIMARY!, dw_sesiones, 1, PRIMARY!) 

dw_sesiones_detalle.RESET()  
iuo_grupo_servicios.ids_grupo_sesion.ROWSCOPY(1, iuo_grupo_servicios.ids_grupo_sesion.ROWCOUNT(), PRIMARY!, dw_sesiones_detalle, 1, PRIMARY!) 

IF iuo_grupo_servicios.is_sesionado = 'S' THEN 
	cb_sesionar.CHECKED = TRUE 
ELSE 	
	cb_sesionar.CHECKED = FALSE 
END IF 	
wf_habilita_sesion()
/*Se despliega el detalle de sesiones*/  
		
//wf_habilita() 
//
//dw_grupo.MODIFY("cve_mat.protect = 1") 
//dw_grupo.MODIFY("materias_materia.protect = 1") 
//dw_grupo.MODIFY("gpo.protect = 1") 

wf_despliega_profesor_titular(1)

wf_calcula_horas_reales(0)

ib_carga = TRUE 
dw_grupo.TRIGGEREVENT("ue_valida_asimilado") 
ib_carga = FALSE 

wf_habilita() 

dw_grupo.MODIFY("cve_mat.protect = 1") 
dw_grupo.MODIFY("materias_materia.protect = 1") 
dw_grupo.MODIFY("gpo.protect = 1") 

wf_recupera_materia_asimila()

wf_habilita_cambios() 

IF NOT ib_permite_modular AND ie_forma_imparte = 2 THEN MESSAGEBOX("Aviso", "La materia no es de tipo Modular y el grupo está capturado como Modular. Para solucionar este problema agregue la materia en la opción Materias con Excepción de Validación.") 


//**//
iuo_grupo_servicios.ie_horas_totales_capt = iuo_grupo_servicios.of_cuenta_horas_sesiones() 
st_horas_capturadas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_totales_capt) 

ib_modificado = FALSE

RETURN 0 





end function

public function integer wf_habilita ();INTEGER le_imparte 
INTEGER le_tipo_grupo

le_imparte = dw_grupo.GETITEMNUMBER(1, "grupos_forma_imparte") 

// Si es modo tradicional se inabilita el seleccionador de fecha.
IF le_imparte = 1 THEN 
	
	dp_inicio.ENABLED = FALSE
	dp_fin.ENABLED = FALSE  
	wf_fechas_default() 
//	dw_grupo.MODIFY("grupos_fecha_inicio.PROTECT = 1")
//	dw_grupo.Modify("grupos_fecha_inicio.Background.Color = '67108864'")

	dw_profesor.MODIFY("b_fecha_inicio.Visible = 0")
	dw_profesor.MODIFY("b_fecha_fin.Visible = 0")

	cb_sesionar.ENABLED = FALSE
	wf_habilita_sesion()
	
	st_hor_min_semanal.VISIBLE = TRUE
	st_hor_cap_semanal.VISIBLE = TRUE
	st_horas_minimas.VISIBLE = TRUE
	st_horas_capturadas.VISIBLE = TRUE
	
	st_tot_per.VISIBLE = FALSE
	st_tot_capt.VISIBLE = FALSE
	st_horas_totales.VISIBLE = FALSE
	st_horas_capturadas_totales.VISIBLE = FALSE 
	
// Si el modo de impartición es  modular	
ELSE 
	
	dp_inicio.ENABLED = TRUE
	dp_fin.ENABLED = TRUE 
	
//	dw_grupo.MODIFY("grupos_fecha_inicio.PROTECT = 0")
//	dw_grupo.Modify("grupos_fecha_inicio.Background.Color = '1073741824'")

	cb_sesionar.ENABLED = TRUE 
	cb_sesionar.CHECKED = TRUE  
	wf_habilita_sesion() 

	IF is_multititular = "S" THEN 
		dw_profesor.MODIFY("b_fecha_inicio.Visible = 1")
		dw_profesor.MODIFY("b_fecha_fin.Visible = 1")
	ELSE
		dw_profesor.MODIFY("b_fecha_inicio.Visible = 0")
		dw_profesor.MODIFY("b_fecha_fin.Visible = 0")		
	END IF
	
	st_hor_min_semanal.VISIBLE = FALSE
	st_hor_cap_semanal.VISIBLE = FALSE	
	st_horas_minimas.VISIBLE = FALSE
	st_horas_capturadas.VISIBLE = FALSE
	
	st_tot_per.VISIBLE = TRUE
	st_tot_capt.VISIBLE = TRUE
	st_horas_totales.VISIBLE = TRUE
	st_horas_capturadas_totales.VISIBLE = TRUE 	
	
	st_tot_per.Y = 1296
	st_tot_capt.Y = 1380
	st_horas_totales.Y = 1296
	st_horas_capturadas_totales.Y = 1380
	
END IF

dw_profesor.TRIGGEREVENT("ue_fechas")  


le_tipo_grupo = dw_grupo.GETITEMNUMBER(1, "grupos_tipo")  
IF ISNULL(le_tipo_grupo) THEN le_tipo_grupo = -1 
INTEGER le_requiere_horario

IF le_tipo_grupo >= 0 THEN 
	SELECT requiere_horario
	INTO :le_requiere_horario
	FROM tipo_grupo 
	WHERE tipo = :le_tipo_grupo
	USING itr_sce; 
	IF itr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar la información del tipo de grupo: " + itr_sce.SQLERRTEXT) 
		RETURN -1	
	END IF 
ELSE
	le_requiere_horario = 0
END IF

IF le_requiere_horario = 0 THEN 

	dw_horario.ENABLED = FALSE
	pb_inserta_horario.ENABLED = FALSE
	pb_borra_horario.ENABLED = FALSE
	
	dw_profesor.ENABLED = TRUE
	pb_inserta_profesor.ENABLED = TRUE
	pb_borra_profesor.ENABLED = TRUE
	
	dw_sesiones.ENABLED = FALSE  
	pb_inserta_sesion.ENABLED = FALSE  
	pb_borra_sesion.ENABLED = FALSE  
	cb_detalle_sesiones.ENABLED = FALSE  		

ELSE

	dw_horario.ENABLED = TRUE 
	pb_inserta_horario.ENABLED = TRUE 
	pb_borra_horario.ENABLED = TRUE 
	
	dw_profesor.ENABLED = TRUE 
	pb_inserta_profesor.ENABLED = TRUE 
	pb_borra_profesor.ENABLED = TRUE 
	
	dw_sesiones.ENABLED = TRUE  
	pb_inserta_sesion.ENABLED = TRUE  
	pb_borra_sesion.ENABLED = TRUE  
	cb_detalle_sesiones.ENABLED = TRUE  		
	
	
END IF

IF le_tipo_grupo = 2 THEN 
	
	dw_horario.ENABLED = FALSE 
	pb_inserta_horario.ENABLED = FALSE
	pb_borra_horario.ENABLED = FALSE
	
	dw_profesor.ENABLED = FALSE
	pb_inserta_profesor.ENABLED = FALSE
	pb_borra_profesor.ENABLED = FALSE 
	
	cbx_multitular.ENABLED = FALSE  
	
	dw_sesiones.ENABLED = FALSE  
	pb_inserta_sesion.ENABLED = FALSE  
	pb_borra_sesion.ENABLED = FALSE  
	cb_detalle_sesiones.ENABLED = FALSE  	
	
	
ELSE
	
	cbx_multitular.ENABLED = TRUE
	
END IF 


RETURN 0 











//INTEGER le_imparte 
//INTEGER le_tipo_grupo
//
//le_imparte = dw_grupo.GETITEMNUMBER(1, "grupos_forma_imparte") 
//
//// Si es modo tradicional se inabilita el seleccionador de fecha.
//IF le_imparte = 1 THEN 
//	
//	dp_inicio.ENABLED = FALSE
//	dp_fin.ENABLED = FALSE  
//	wf_fechas_default() 
//	dw_grupo.MODIFY("grupos_fecha_inicio.PROTECT = 1")
////	dw_grupo.MODIFY("grupos_fecha_fin.PROTECT = 1")
////	dw_grupo.MODIFY("grupos_horas_reales.PROTECT = 1")
//	dw_grupo.Modify("grupos_fecha_inicio.Background.Color = '67108864'")
//	//dw_grupo.Modify("grupos_fecha_fin.Background.Color = '67108864'")	
////	dw_grupo.Modify("grupos_horas_reales.Background.Color = '67108864'")	
//
////	dw_selecciona_paquete.VISIBLE = FALSE 
////	dw_grupos_paquetes.VISIBLE = FALSE 
//
//	dw_profesor.MODIFY("b_fecha_inicio.Visible = 0")
//	dw_profesor.MODIFY("b_fecha_fin.Visible = 0")
//
//	cb_sesionar.ENABLED = FALSE
//	wf_habilita_sesion()
//ELSE 
//	
//	dp_inicio.ENABLED = TRUE
//	dp_fin.ENABLED = TRUE 
//	
//	dw_grupo.MODIFY("grupos_fecha_inicio.PROTECT = 0")
//	//dw_grupo.MODIFY("grupos_fecha_fin.PROTECT = 0")
////	dw_grupo.MODIFY("grupos_horas_reales.PROTECT = 0")
//	dw_grupo.Modify("grupos_fecha_inicio.Background.Color = '1073741824'")
//	//dw_grupo.Modify("grupos_fecha_fin.Background.Color = '1073741824'")
////	dw_grupo.Modify("grupos_horas_reales.Background.Color = '1073741824'")
//
////	dw_selecciona_paquete.VISIBLE = TRUE 
////	dw_grupos_paquetes.VISIBLE = TRUE	
//	cb_sesionar.ENABLED = TRUE 
//	wf_habilita_sesion() 
//
//	IF is_multititular = "S" THEN 
//		dw_profesor.MODIFY("b_fecha_inicio.Visible = 1")
//		dw_profesor.MODIFY("b_fecha_fin.Visible = 1")
//	ELSE
//		dw_profesor.MODIFY("b_fecha_inicio.Visible = 0")
//		dw_profesor.MODIFY("b_fecha_fin.Visible = 0")		
//	END IF
//	
//END IF
//
//dw_profesor.TRIGGEREVENT("ue_fechas")  
//
//
//le_tipo_grupo = dw_grupo.GETITEMNUMBER(1, "grupos_tipo")  
//IF ISNULL(le_tipo_grupo) THEN le_tipo_grupo = -1 
//INTEGER le_requiere_horario
//
//IF le_tipo_grupo >= 0 THEN 
//	SELECT requiere_horario
//	INTO :le_requiere_horario
//	FROM tipo_grupo 
//	WHERE tipo = :le_tipo_grupo
//	USING itr_sce; 
//	IF itr_sce.SQLCODE < 0 THEN 
//		MESSAGEBOX("Error", "Se produjo un error al recuperar la información del tipo de grupo: " + itr_sce.SQLERRTEXT) 
//		RETURN -1	
//	END IF 
//ELSE
//	le_requiere_horario = 0
//END IF
//
////IF le_tipo_grupo = 2 THEN 
////IF (le_tipo_grupo <> 0 AND le_tipo_grupo <> 3) OR le_tipo_grupo = -1 THEN  
//IF le_requiere_horario = 0 THEN 
//
//	dw_horario.ENABLED = FALSE
//	pb_inserta_horario.ENABLED = FALSE
//	pb_borra_horario.ENABLED = FALSE
//	
//	dw_profesor.ENABLED = TRUE
//	pb_inserta_profesor.ENABLED = TRUE
//	pb_borra_profesor.ENABLED = TRUE
//
//
//ELSE
//	
//	dw_horario.ENABLED = TRUE 
//	pb_inserta_horario.ENABLED = TRUE 
//	pb_borra_horario.ENABLED = TRUE 
//	
//	dw_profesor.ENABLED = TRUE 
//	pb_inserta_profesor.ENABLED = TRUE 
//	pb_borra_profesor.ENABLED = TRUE 
//	
//END IF
//
//IF le_tipo_grupo = 2 THEN 
//	
//	dw_horario.ENABLED = FALSE 
//	pb_inserta_horario.ENABLED = FALSE
//	pb_borra_horario.ENABLED = FALSE
//	
//	dw_profesor.ENABLED = FALSE
//	pb_inserta_profesor.ENABLED = FALSE
//	pb_borra_profesor.ENABLED = FALSE 
//	
//	cbx_multitular.ENABLED = FALSE 
//	
//ELSE
//	
//	cbx_multitular.ENABLED = TRUE
//	
//END IF 
//
//
//
//
//RETURN 0 
//
//
//
//
//
end function

public function integer wf_carga_lista_paquetes ();
//dw_selecciona_paquete.INSERTROW(0) 
//
//DATAWINDOWCHILD dw_child
//
//dw_selecciona_paquete.GETCHILD("id_paquete", dw_child)  
//
//dw_child.SETTRANSOBJECT(itr_sce)  
//dw_child.RETRIEVE(il_coordinacion) 
//
//INTEGER le_row
//le_row = dw_child.INSERTROW(0)
//
//dw_child.SETITEM(le_row, "id_paquete", 0)  
//dw_child.SETITEM(le_row, "descripcion", "SIN PAQUETE")  
//
//dw_child.SETSORT("id_paquete asc") 
//dw_child.SORT() 
//
RETURN 0 




end function

public function integer wf_inicializa_horario_prof ();
// Se pase el detalle del horario del profesor.
ids_horario_profesor.SETFILTER("") 
ids_horario_profesor.FILTER() 
iuo_grupo_servicios.ids_horario_profesor.DATAOBJECT = ids_horario_profesor.DATAOBJECT 
//iuo_grupo_servicios.ids_horario_profesor.RESET()  
ids_horario_profesor.ROWSCOPY(1, ids_horario_profesor.ROWCOUNT(), PRIMARY!, iuo_grupo_servicios.ids_horario_profesor, 1, PRIMARY!) 


// Se inicializa el DS de paso para validación del Horario que se edita.
LONG llh_cve_mat	
STRING lsh_gpo	
DATETIME ldth_fecha_inicio	
DATETIME ldth_fecha_fin	
INTEGER leh_cve_dia	
INTEGER leh_hora_inicio	
INTEGER leh_hora_final
INTEGER le_pos, le_row_ins 
LONG ll_cve_prof

iuo_profesor_servicios.ids_verifica_horario_paso.RESET()
IF ISVALID(iuo_profesor_servicios.ids_matriz_horario) THEN 
	iuo_profesor_servicios.ids_matriz_horario.RESET() 
END IF 

FOR le_pos = 1 TO ids_horario_profesor.ROWCOUNT() 
	
	llh_cve_mat	= ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_mat") 
	lsh_gpo = ids_horario_profesor.GETITEMSTRING(le_pos, "gpo") 
	ldth_fecha_inicio = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
	ldth_fecha_fin = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
	leh_cve_dia	= ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_dia") 
	leh_hora_inicio	= ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
	leh_hora_final = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_final")
	ll_cve_prof = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_profesor")

	le_row_ins = iuo_profesor_servicios.ids_verifica_horario_paso.INSERTROW(0) 
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "grupos_cve_mat", llh_cve_mat)	
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "grupos_gpo", lsh_gpo)	
//	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "grupos_fecha_inicio", ldth_fecha_inicio)	
//	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "grupos_fecha_fin", ldth_fecha_fin)	
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "horario_profesor_grupo_fecha_inicio", ldth_fecha_inicio)	
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "horario_profesor_grupo_fecha_fin", ldth_fecha_fin)	
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "horario_profesor_grupo_cve_dia", leh_cve_dia)	
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "horario_profesor_grupo_hora_inicio", leh_hora_inicio)	
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "horario_profesor_grupo_hora_final", leh_hora_final) 
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "grupos_cve_profesor", ll_cve_prof) 
	iuo_profesor_servicios.ids_verifica_horario_paso.SETITEM(le_row_ins, "materias_cve_coordinacion", il_coordinacion) 

NEXT 


iuo_profesor_servicios.idt_inicio_periodo = iuo_grupo_servicios.idt_inicio_periodo
iuo_profesor_servicios.idt_fin_periodo = iuo_grupo_servicios.idt_fin_periodo

iuo_profesor_servicios.ie_periodo = ii_periodo
iuo_profesor_servicios.ie_anio = ii_anio

RETURN 0 




end function

public function integer wf_cuenta_horas_grupo ();INTEGER le_ttl_prof 
INTEGER le_pos_prof 
LONG ll_cve_prof
LONG ll_horas_totales 
INTEGER le_horas_reales


// Se llama función de conteo de horas reales de profesor 
wf_inicializa_horario_prof()  

le_ttl_prof = dw_profesor.ROWCOUNT() 
le_horas_reales = dw_grupo.GETITEMNUMBER(1, "materias_horas_reales") 
IF ISNULL(le_horas_reales) THEN le_horas_reales = 0 


FOR le_pos_prof = 1 TO le_ttl_prof  

	ll_cve_prof = dw_profesor.GETITEMNUMBER(le_pos_prof, "cve_profesor")    
	ll_horas_totales = iuo_profesor_servicios.of_cuenta_horas_reales_profesor(ll_cve_prof, le_horas_reales)  
	dw_profesor.SETITEM(le_pos_prof, "horas_profesor", ll_horas_totales) 

NEXT


RETURN 0 







end function

public function integer wf_calcula_horas_reales (integer ai_mensajes);INTEGER ie_retorno


wf_inicializa_servicio() 

iuo_grupo_servicios.of_calcula_horas_semana( )
ie_retorno = iuo_grupo_servicios.of_calcula_horas_reales( )

IF ie_retorno < 0 THEN 
	IF ai_mensajes = 1 THEN 
		MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error)
	END IF
ELSEIF ie_retorno = 1 THEN 
	IF ai_mensajes = 1 THEN 
		MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error)
	END IF
END IF



IF iuo_grupo_servicios.ie_horas_totales > 0 THEN 
	st_horas_capturadas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_totales_capt)   
	st_horas_capturadas.TEXT = STRING( iuo_grupo_servicios.ie_horas_totales)
END IF 

st_horas_minimas.TEXT = STRING(iuo_grupo_servicios.ie_horas_reales_tot_sem)
st_horas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_reales_tot_per)

RETURN  ie_retorno










//INTEGER ie_retorno
//
//
//wf_inicializa_servicio() 
//
//iuo_grupo_servicios.of_calcula_horas_semana( )
//ie_retorno = iuo_grupo_servicios.of_calcula_horas_reales( )
//
//IF ie_retorno < 0 THEN 
//	IF ai_mensajes = 1 THEN 
//		MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error)
//	END IF
//ELSEIF ie_retorno = 1 THEN 
//	IF ai_mensajes = 1 THEN 
//		MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error)
//	END IF
//END IF
//
////st_horas_minimas.TEXT = "Horas mínimas sem: " + STRING(iuo_grupo_servicios.ie_horas_reales_tot_sem )  
////st_horas_capturadas.TEXT = "Horas capturadas sem: " + STRING(iuo_grupo_servicios.ie_horas_totales ) 
//
//// SE COMENTA ESTA LÍNEA, LAS HORAS MINÍMAS SERÄN SIEMPRE LAS DEFAULT 
//// SE COMENTA ESTA LÍNEA, LAS HORAS MINÍMAS SERÄN SIEMPRE LAS DEFAULT 
//// st_horas_minimas.TEXT = STRING(iuo_grupo_servicios.ie_horas_reales_tot_sem )  
//// SE COMENTA ESTA LÍNEA, LAS HORAS MINÍMAS SERÄN SIEMPRE LAS DEFAULT 
//// SE COMENTA ESTA LÍNEA, LAS HORAS MINÍMAS SERÄN SIEMPRE LAS DEFAULT 
//IF iuo_grupo_servicios.ie_horas_totales > 0 THEN 
//	st_horas_capturadas.TEXT = STRING(iuo_grupo_servicios.ie_horas_totales )  
//END IF 
//
//// DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL 
//// DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL  DESCOMENTAR EN VERSIÓN FINAL 
////IF iuo_grupo_servicios.ie_horas_reales_tot_sem <= iuo_grupo_servicios.ie_horas_totales THEN 
////	dw_profesor.ENABLED = TRUE
////	dw_profesor.VISIBLE = TRUE 
////ELSE
////	dw_profesor.ENABLED = FALSE  
////	dw_profesor.VISIBLE = FALSE  	
////END IF
//
//
//RETURN  ie_retorno
//
//
//
//
//
//
//
end function

public function integer wf_valida_horas_profesor ();LONG ll_cve_profesor, ll_cve_profesorh
INTEGER le_pos, le_posh
INTEGER le_horas_dia, le_horas_diah
INTEGER le_dia, le_dia_ant

LONG ll_cve_mat 
STRING ls_gpo
INTEGER le_tipo, le_horas_per_calculadas

ll_cve_mat = dw_grupo.GETITEMNUMBER(1, "cve_mat") 
ls_gpo = dw_grupo.GETITEMSTRING(1, "gpo") 
le_tipo = dw_grupo.GETITEMNUMBER(1, "grupos_tipo") 

// Se inicializan las propiedades asociadas al grupo que se captura.
iuo_profesor_servicios.ie_horas_reales_tot_sem = iuo_grupo_servicios.ie_horas_reales_tot_sem
// Se calculan las horas reales TOTALES del periodo 
//iuo_profesor_servicios.ie_horas_reales_periodo = iuo_grupo_servicios.of_calcula_horas_totales_semestre() 

// Se ordena el horario por dia para poder contar las horas.
ids_horario_profesor.SETSORT("cve_profesorA, cve_dia A")  
ids_horario_profesor.SORT()   
	
	
FOR le_pos = 1 TO dw_profesor.ROWCOUNT() 

	ll_cve_profesor = dw_profesor.GETITEMNUMBER(le_pos, "cve_profesor")  
	le_horas_per_calculadas = dw_profesor.GETITEMNUMBER(le_pos, "horas_profesor")  
	le_dia_ant = 0	
	le_horas_diah = 0

	FOR le_posh = 1 TO ids_horario_profesor.ROWCOUNT() 
		ll_cve_profesorh = ids_horario_profesor.GETITEMNUMBER(le_posh, "cve_profesor") 
		IF ll_cve_profesorh <> ll_cve_profesor THEN CONTINUE 
		
		le_dia = ids_horario_profesor.GETITEMNUMBER(le_posh, "cve_dia")  
		// Se permite la captura de dos horarios el mismo dia. 
		//IF le_dia <> le_dia_ant THEN 
			le_horas_dia = ids_horario_profesor.GETITEMNUMBER(le_posh, "horas_asignadas")  
			le_horas_diah = le_horas_diah + le_horas_dia 			
			le_dia_ant = le_dia 
		//END IF 
	NEXT 
	iuo_profesor_servicios.ie_horas_semanales = le_horas_diah

	iuo_profesor_servicios.ie_forma_imparte = ie_forma_imparte
	iuo_profesor_servicios.ie_horas_per_calculadas = le_horas_per_calculadas
	
	//Se pasan las horas del Horario reales del grupo actrual 
	iuo_profesor_servicios.ie_horas_horario_captura = iuo_grupo_servicios.ie_horas_horario
	
	iuo_profesor_servicios.il_cve_profesor = ll_cve_profesor 
	iuo_profesor_servicios.ie_horas_capturadas = dw_profesor.GETITEMNUMBER(le_pos, "horas_profesor")  
	IF iuo_profesor_servicios.ie_horas_capturadas <= 0 THEN CONTINUE 
	// Si sobrepasa las horas permitidas.
	iuo_profesor_servicios.ie_num_ptrofesores = dw_profesor.ROWCOUNT() 
	iuo_profesor_servicios.ib_modifica_salon = ib_modifica_salon 
	iuo_profesor_servicios.ie_horas_totales_semestre = ie_horas_totales_semestre 
	IF iuo_profesor_servicios.of_valida_horas_profesor( ll_cve_mat, ls_gpo, le_tipo) < 0 THEN 	RETURN -1
	
NEXT 


RETURN 0 



end function

public function integer wf_reinicia_fecha_profesores ();
LONG ll_pos
LONG ll_ttl_rgs 

ll_ttl_rgs = dw_profesor.ROWCOUNT()

FOR ll_pos = 0 TO ll_ttl_rgs 
	
	dw_profesor.SETITEM(ll_pos, "fecha_inicio", iuo_grupo_servicios.idt_fecha_inicio)   
	dw_profesor.SETITEM(ll_pos, "fecha_fin", iuo_grupo_servicios.idt_fecha_fin)  
	dw_profesor.SETITEM(ll_pos, "horas_profesor", 0)   

NEXT  

iuo_grupo_servicios.ids_horario_profesor.RESET() 
ids_horario_profesor.RESET() 

RETURN 0 


end function

public function integer wf_recupera_profesor (integer ae_row, long al_cve_profesor);INTEGER le_retorno 
LONG ll_coordinacion 

// Se verifica que el profesor exista y esté activo.
le_retorno = iuo_profesor_servicios.of_recupera_profesor( al_cve_profesor )  

IF le_retorno < 0 THEN 
	MESSAGEBOX("Error", iuo_profesor_servicios.is_error ) 
	RETURN -1
ELSEIF le_retorno = 100 THEN 
	MESSAGEBOX("aviso", iuo_profesor_servicios.is_error ) 
	RETURN -1		
END IF 


il_materia = dw_grupo.GETITEMNUMBER(1, "cve_mat")

// Se recupera la coordinación de la materia. 
SELECT cve_coordinacion 
INTO :ll_coordinacion
FROM materias
WHERE cve_mat = :il_materia
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la coordinación de la materia: " + itr_sce.sqlerrtext ) 
	RETURN -1 
END IF 

// Se verifica que el profesor no esté bloqueado.
le_retorno = iuo_profesor_servicios.of_profesor_bloqueado( ii_periodo, ii_anio, ll_coordinacion) 
IF le_retorno < 0 THEN RETURN -1

dw_profesor.SETITEM(ae_row, "profesor_nombre", iuo_profesor_servicios.is_nombre)
dw_profesor.SETITEM(ae_row, "profesor_amaterno", iuo_profesor_servicios.is_amaterno)
dw_profesor.SETITEM(ae_row, "profesor_apaterno", iuo_profesor_servicios.is_apaterno ) 
dw_profesor.SETITEM(ae_row, "horas_profesor", 0)   





RETURN 0 





end function

public function integer wf_borra_horario_profesor (long al_cve_profesor);// Se elimina cualquier horario que exista de este profesor.
ids_horario_profesor.SETFILTER("cve_profesor = " + STRING(al_cve_profesor))  
ids_horario_profesor.FILTER() 
ids_horario_profesor.rowsdiscard(1, ids_horario_profesor.ROWCOUNT(), PRIMARY!) 
ids_horario_profesor.SETFILTER("")  
ids_horario_profesor.FILTER() 		
	
RETURN 0 



end function

public function integer wf_recupera_materia_asimila ();
LONG ll_cve_mat_asimilada  
STRING ls_gpo_asimilado 
STRING ls_materia


ll_cve_mat_asimilada = dw_grupo.GETITEMNUMBER(1, "grupos_cve_asimilada")  
IF ISNULL(ll_cve_mat_asimilada) THEN ll_cve_mat_asimilada = 0 
//ls_gpo_asimilado = TRIM(dw_grupo.GETITEMSTRING(1, "grupos_gpo_asimilado")) 
//IF ISNULL(ls_gpo_asimilado) THEN ls_gpo_asimilado = ""

//IF ll_cve_mat_asimilada = 0 OR ls_gpo_asimilado = "" THEN RETURN 0 
IF ll_cve_mat_asimilada = 0 THEN RETURN 0 

iuo_materias_servicios.of_recupera_materia(ll_cve_mat_asimilada, ls_materia) 

dw_grupo.MODIFY("t_asimilado.Text = '" + ls_materia + "'") 


RETURN 0 




end function

public function integer wf_habilita_cambios ();
LONG ll_materia 
INTEGER le_tipo 

ll_materia  = dw_grupo.GETITEMNUMBER(1, "cve_mat") 
IF ISNULL(ll_materia) THEN ll_materia = 0  
le_tipo = dw_grupo.GETITEMNUMBER(1, "grupos_tipo")  
IF ISNULL(le_tipo) THEN le_tipo = 0 

// Si se abre en modo Cambios  
IF ie_modo_opera = 2 AND ie_modo = 2 THEN 

	THIS.uo_periodo.ENABLED = FALSE 

	// Se inhabilitan los campos de edición generales 
	//dw_grupo.MODIFY("cve_mat.PROTECT = 1")
	dw_grupo.MODIFY("materias_materia.PROTECT = 1")
	//dw_grupo.MODIFY("gpo.PROTECT = 1")
	//*dw_grupo.MODIFY("grupos_forma_imparte.PROTECT = 1")
	IF ll_materia > 0 THEN wf_valida_aplica_sesionado(ll_materia)
//	dw_grupo.MODIFY("grupos_fecha_inicio.PROTECT = 1")
	//dw_grupo.MODIFY("grupos_fecha_fin.PROTECT = 1")
//	dw_grupo.MODIFY("grupos_horas_reales.PROTECT = 1")
	dw_grupo.MODIFY("grupos_tipo.PROTECT = 1")
	//dw_grupo.MODIFY("grupos_cupo.PROTECT = 1")
	dw_grupo.MODIFY("grupos_inscritos.PROTECT = 1")
	dw_grupo.MODIFY("grupos_cve_asimilada.PROTECT = 1")
	dw_grupo.MODIFY("grupos_gpo_asimilado.PROTECT = 1")
	dw_grupo.MODIFY("grupos_idioma.PROTECT = 1")
	dw_grupo.MODIFY("grupos_cond_gpo.PROTECT = 1")
	dw_grupo.MODIFY("b_buscar_asimilada.VISIBLE = 0") 
	dw_grupo.MODIFY("b_buscar.VISIBLE = 0") 
	
	// SE COMENTA PARA OTOÑO 2020 
	//********************************************//
	IF le_tipo = 2 THEN 
		dw_grupo.MODIFY("grupos_modalidad.PROTECT = 1") 
	END IF  	
	//********************************************//
	
	IF dw_grupo.GETITEMNUMBER(1, "grupos_tipo") = 2 THEN 
		dw_grupo.MODIFY("grupos_cupo.PROTECT = 1") 
		dw_grupo.MODIFY("grupos_cupo.Background.Color = '67108864'") 
	END IF 	

	dw_sesiones.MODIFY("fecha_inicio.PROTECT = 1")
	dw_sesiones.MODIFY("fecha_fin.PROTECT = 1") 
	

	dw_grupo.Modify("materias_materia.Background.Color = '67108864'")
	dw_grupo.Modify("grupos_forma_imparte.Background.Color = '67108864'")
//	dw_grupo.Modify("grupos_fecha_inicio.Background.Color = '67108864'")
	//dw_grupo.Modify("grupos_fecha_fin.Background.Color = '67108864'")
//	dw_grupo.Modify("grupos_horas_reales.Background.Color = '67108864'")
	dw_grupo.Modify("grupos_tipo.Background.Color = '67108864'")
	dw_grupo.Modify("grupos_inscritos.Background.Color = '67108864'")
	dw_grupo.Modify("grupos_cve_asimilada.Background.Color = '67108864'")
	dw_grupo.Modify("grupos_gpo_asimilado.Background.Color = '67108864'")
	dw_grupo.Modify("grupos_idioma.Background.Color = '67108864'")
	dw_grupo.Modify("grupos_cond_gpo.Background.Color = '67108864'")
	
	// SE COMENTA PARA OTOÑO 2020 
	//********************************************//
	IF le_tipo = 2 THEN 
		dw_grupo.MODIFY("grupos_modalidad.Background.Color = '67108864'") 
	END IF 
	//********************************************//

	dw_sesiones.MODIFY("fecha_fin.Background.Color = '67108864'")  
	dw_sesiones.MODIFY("fecha_inicio.Background.Color = '67108864'") 

	pb_inserta_horario.ENABLED = FALSE
	pb_borra_horario.ENABLED = FALSE 

	// SE COMENTA PARA OTOÑO 2020 
	//********************************************//
	//dw_horario.MODIFY("clase_aula.PROTECT = 1")
	//dw_horario.MODIFY("cve_salon.PROTECT = 1")	
	//********************************************//
	dw_horario.MODIFY("cve_dia.PROTECT = 1")
	dw_horario.MODIFY("hora_inicio.PROTECT = 1")
	dw_horario.MODIFY("hora_final.PROTECT = 1")
	

	// SE COMENTA PARA OTOÑO 2020 
	//********************************************//
	//dw_horario.Modify("clase_aula.Background.Color = '67108864'")
	//dw_horario.Modify("cve_salon.Background.Color = '67108864'")
	//********************************************//
	dw_horario.Modify("cve_dia.Background.Color = '67108864'")
	dw_horario.Modify("hora_inicio.Background.Color = '67108864'")
	dw_horario.Modify("hora_final.Background.Color = '67108864'")
	

	dw_sesiones.Modify("fecha_inicio.Background.Color = '67108864'")
	dw_sesiones.Modify("fecha_fin.Background.Color = '67108864'") 
	dw_horario.MODIFY("fecha_inicio.PROTECT = 1")
	dw_horario.MODIFY("fecha_fin.PROTECT = 1")
	pb_inserta_sesion.ENABLED = FALSE
	pb_borra_sesion.ENABLED = FALSE
	cb_sesionar.ENABLED = FALSE

// Si se abre en modo de alta o si se agrega uno nuevo 
ELSE 

	IF ie_modo_opera = 2 THEN 
		THIS.uo_periodo.ENABLED = FALSE 
	ELSE
		THIS.uo_periodo.ENABLED = TRUE
	END IF 	

	// Se inhabilitan los campos de edición generales 
	//dw_grupo.MODIFY("cve_mat.PROTECT = 0")
	dw_grupo.MODIFY("materias_materia.PROTECT = 0")
	//dw_grupo.MODIFY("gpo.PROTECT = 0")
	IF ib_permite_modulares THEN dw_grupo.MODIFY("grupos_forma_imparte.PROTECT = 0")
	IF ll_materia > 0 THEN wf_valida_aplica_sesionado(ll_materia) 
	//dw_grupo.MODIFY("grupos_fecha_inicio.PROTECT = 0")
	//dw_grupo.MODIFY("grupos_fecha_fin.PROTECT = 0")
	dw_grupo.MODIFY("grupos_tipo.PROTECT = 0")
	//dw_grupo.MODIFY("grupos_cupo.PROTECT = 0")
	dw_grupo.MODIFY("grupos_inscritos.PROTECT = 0")
//	dw_grupo.MODIFY("grupos_cve_asimilada.PROTECT = 0")
//	dw_grupo.MODIFY("grupos_gpo_asimilado.PROTECT = 0")
	dw_grupo.MODIFY("grupos_idioma.PROTECT = 0")
	dw_grupo.MODIFY("grupos_cond_gpo.PROTECT = 0")
	dw_grupo.MODIFY("b_buscar_asimilada.VISIBLE = 1") 
	dw_grupo.MODIFY("b_buscar.VISIBLE = 1") 
	
	IF le_tipo = 2 THEN 
		dw_grupo.MODIFY("grupos_modalidad.PROTECT = 1") 
		dw_grupo.MODIFY("grupos_cupo.PROTECT = 1") 
	ELSE
		dw_grupo.MODIFY("grupos_modalidad.PROTECT = 0") 
		dw_grupo.MODIFY("grupos_cupo.PROTECT = 0") 
	END IF 	

	dw_grupo.Modify("materias_materia.Background.Color = '1073741824'")
	IF ib_permite_modulares THEN dw_grupo.Modify("grupos_forma_imparte.Background.Color = '1073741824'")
	//dw_grupo.Modify("grupos_fecha_inicio.Background.Color = '1073741824'")
	//dw_grupo.Modify("grupos_fecha_fin.Background.Color = '1073741824'")
	dw_grupo.Modify("grupos_tipo.Background.Color = '1073741824'")
	dw_grupo.Modify("grupos_inscritos.Background.Color = '1073741824'")
//	dw_grupo.Modify("grupos_cve_asimilada.Background.Color = '1073741824'")
//	dw_grupo.Modify("grupos_gpo_asimilado.Background.Color = '1073741824'")
	dw_grupo.Modify("grupos_idioma.Background.Color = '1073741824'")
	dw_grupo.Modify("grupos_cond_gpo.Background.Color = '1073741824'")
	IF le_tipo = 2 THEN 
		dw_grupo.Modify("grupos_modalidad.Background.Color = '67108864'")
		dw_grupo.Modify("grupos_cupo.Background.Color = '67108864'") 
	ELSE 	
		dw_grupo.Modify("grupos_modalidad.Background.Color = '1073741824'")
		dw_grupo.Modify("grupos_cupo.Background.Color = '1073741824'") 
	END IF  	


	pb_inserta_horario.ENABLED = TRUE
	pb_borra_horario.ENABLED = TRUE 

	dw_horario.MODIFY("clase_aula.PROTECT = 0")
	dw_horario.MODIFY("cve_dia.PROTECT = 0")
	dw_horario.MODIFY("hora_inicio.PROTECT = 0")
	dw_horario.MODIFY("hora_final.PROTECT = 0")
	dw_horario.MODIFY("cve_salon.PROTECT = 0")		
	

	dw_sesiones.MODIFY("fecha_inicio.PROTECT = 0")
	dw_sesiones.MODIFY("fecha_fin.PROTECT = 0") 

	dw_horario.MODIFY("clase_aula.Background.Color = '1073741824'")
	dw_horario.Modify("cve_dia.Background.Color = '1073741824'")
	dw_horario.Modify("hora_inicio.Background.Color = '1073741824'")
	dw_horario.Modify("hora_final.Background.Color = '1073741824'")
	dw_horario.MODIFY("cve_salon.Background.Color = '1073741824'")	
	
	dw_sesiones.MODIFY("fecha_fin.Background.Color = '1073741824'")  
	dw_sesiones.MODIFY("fecha_inicio.Background.Color = '1073741824'") 	
	

END IF 
wf_filtra_clase_aula() 

RETURN 0 


end function

public function integer wf_obten_titulo ();//f_obten_titulo
//Recibe 	aw_ventana	window
//Asigna el titulo de la aplicacion


string ls_nombre, ls_base_conectada, ls_plantel, ls_servidor_base
ls_nombre=gs_usuario

SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :ls_nombre
USING itr_sce;

SELECT plantel
INTO :ls_plantel
FROM planteles
WHERE actual = 1
USING itr_sce;


//if isvalid(gtr_scob) then
//	ls_servidor_base =	gtr_scob.ServerName+ ":" + gtr_scob.Database
//	ls_base_conectada = "* Conexion a Cobranzas: "+ls_servidor_base
//else
//	ls_base_conectada= ""
//end if

//if isvalid(aw_ventana) then
	THIS.title = gs_usuario+' '+ls_nombre+"  Plantel: "+ls_plantel+ls_base_conectada+" ("+itr_sce.servername+")"
//end if


RETURN 0 

end function

public function integer wf_filtra_clase_aula ();
STRING ls_query 
INTEGER le_tipo_grupo

IF dw_grupo.ROWCOUNT() > 0 THEN 
	le_tipo_grupo = dw_grupo.GETITEMNUMBER(1, "grupos_tipo") 
END IF 
IF ISNULL(le_tipo_grupo) THEN le_tipo_grupo = 100 

ls_query = "SELECT clase_aula.clase, " + & 
				  " clase_aula.nombre_aula " + &   
				" FROM clase_aula " 

IF ie_modo_opera = 2 THEN 
	
	IF ie_modo = 2 THEN 
		ls_query = ls_query + " WHERE aplica_alta = ~~'S~~' " 
	ELSE 
		ls_query = ls_query + " WHERE aplica_edicion = ~~'S~~' " 
	END IF	
	
	//ls_query = ls_query + " WHERE aplica_edicion = ~~'S~~' " 
ELSE	
//	IF ie_modo = 1 THEN 
//		ls_query = ls_query + " WHERE aplica_alta = ~~'S~~' " 
//	ELSE 
//		ls_query = ls_query + " WHERE aplica_edicion = ~~'S~~' " 
//	END IF
	 
END IF 

datawindowchild ldw_clase_aula
dw_horario.GETCHILD("clase_aula", ldw_clase_aula) 
ldw_clase_aula.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ldw_clase_aula.SETTRANSOBJECT(itr_sce) 
ldw_clase_aula.RETRIEVE()   	 

// Si el tipo de Grupo es multiplantel, sólo se puede seleccionar Clase de Aula "Otro" 
IF le_tipo_grupo = 5 THEN  
	ldw_clase_aula.SETFILTER("clase_aula.clase = 3")  
	ldw_clase_aula.FILTER() 
ELSE 	
	ldw_clase_aula.SETFILTER("")  
	ldw_clase_aula.FILTER() 	
	ldw_clase_aula.SETSORT("clase_aula.clase asc")  
	ldw_clase_aula.SORT() 
END IF 	 
	 
	 
RETURN 0 
	 

end function

public function integer wf_carga_horas_permitidas ();
LONG ll_cve_materia
INTEGER le_horas
INTEGER le_horas_totales

ll_cve_materia = dw_grupo.GETITEMNUMBER(1, "cve_mat") 
IF ISNULL(ll_cve_materia) THEN RETURN 0
//le_horas = iuo_materias_servicios.of_recupera_horas_reales(ll_cve_materia)  


wf_inicializa_servicio() 
iuo_grupo_servicios.of_calcula_horas_reales()
le_horas = iuo_grupo_servicios.ie_horas_reales_tot_sem

IF ISNULL(le_horas) THEN le_horas = 0 
dw_grupo.SETITEM(1, "materias_horas_reales", le_horas) 

//DATAWINDOWCHILD ldw_horas_permitidas
//
//dw_grupo.GETCHILD("grupos_horas_reales", ldw_horas_permitidas) 
//ldw_horas_permitidas.SETTRANSOBJECT(itr_sce) 
//ldw_horas_permitidas.RETRIEVE(ll_cve_materia) 
//
//dw_grupo.SETITEM(1, "grupos_horas_reales", le_horas)  
st_horas_minimas.TEXT = STRING(le_horas) 


//le_horas_totales = iuo_materias_servicios.of_recupera_horas_totales(ll_cve_materia, ii_periodo)
//st_horas_totales.TEXT = STRING(le_horas_totales) 
st_horas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_reales_tot_per)

RETURN 0






end function

public function integer wf_habilita_multititular ();INTEGER le_pos, le_ttl_prof 
LONG ll_cve_prof 
LONG ll_num_prof



// Se verifica si el grupo tiene multitularidad.
IF is_multititular = 'S' THEN 
	
	dw_profesor.MODIFY("b_horario.VISIBLE = 1")
	pb_inserta_profesor.ENABLED = TRUE
	pb_borra_profesor.ENABLED = TRUE

//	IF ie_forma_imparte = 1 THEN 
//		dw_profesor.MODIFY("b_fecha_inicio.Visible = 0")
//		dw_profesor.MODIFY("b_fecha_fin.Visible = 0")	
//	ELSE
		dw_profesor.MODIFY("b_fecha_inicio.Visible = 1")
		dw_profesor.MODIFY("b_fecha_fin.Visible = 1")	
//	END IF
	
ELSE
	
	// Se permite modificar horario sin importar el modo en que se imparte. 
//	IF ie_forma_imparte = 1 THEN 
//		dw_profesor.MODIFY("b_horario.VISIBLE = 0")
//	ELSE
		dw_profesor.MODIFY("b_horario.VISIBLE = 1")
//	END IF 
	
	dw_profesor.MODIFY("b_fecha_inicio.Visible = 0")
	dw_profesor.MODIFY("b_fecha_fin.Visible = 0")		
	
	pb_inserta_profesor.ENABLED = FALSE
	pb_borra_profesor.ENABLED = FALSE
	
	le_ttl_prof = dw_profesor.ROWCOUNT() 
	
	
	FOR le_pos = 1 TO le_ttl_prof 

		ll_cve_prof = dw_profesor.GETITEMNUMBER(le_pos, "cve_profesor")  
		IF ISNULL(ll_cve_prof) THEN ll_cve_prof = 0 
		IF ll_cve_prof > 0 THEN ll_num_prof ++ 
	
	NEXT	
	IF ll_num_prof > 1 THEN 
		MESSAGEBOX("Aviso", "Un grupo que no es MULTITITULAR no puede tener más de un  profesor.")
		RETURN -1 
	END IF 	
	
END IF 


RETURN 0 


end function

public function integer wf_despliega_profesor_titular (integer ai_proceso);
INTEGER le_retorno 
INTEGER le_row 
STRING ls_paterno, ls_nombre, ls_materno	
LONG ll_cve_prof
	
// Si se trata de cargar un grupo ya salvado 
IF ai_proceso = 1 THEN 

	// Se verifica que el profesor exista y esté activo.
	le_retorno = iuo_profesor_servicios.of_recupera_profesor( iuo_grupo_servicios.il_cve_profesor )  
	
	IF le_retorno < 0 THEN 
		MESSAGEBOX("Error", iuo_profesor_servicios.is_error ) 
		RETURN -1
	ELSEIF le_retorno = 100 THEN 
		MESSAGEBOX("aviso", iuo_profesor_servicios.is_error ) 
		RETURN -1		
	END IF 
	
	st_profesor_titular.TEXT = "Profesor Titular : " + STRING( iuo_grupo_servicios.il_cve_profesor) + " - " + iuo_profesor_servicios.is_apaterno + " " + iuo_profesor_servicios.is_amaterno + " " + iuo_profesor_servicios.is_nombre 
	
ELSE
	

	
	le_row = dw_profesor.FIND("titularidad = 1", 1, dw_profesor.ROWCOUNT()) 
	
	IF le_row > 0 THEN 
		
		ll_cve_prof = dw_profesor.GETITEMNUMBER(le_row, "cve_profesor") 
		IF ISNULL(ll_cve_prof) THEN ll_cve_prof = 0
		ls_nombre = dw_profesor.GETITEMSTRING(le_row, "profesor_nombre") 
		IF ISNULL(ls_nombre) THEN ls_nombre = "" 
		ls_paterno = dw_profesor.GETITEMSTRING(le_row, "profesor_apaterno") 
		IF ISNULL(ls_paterno) THEN ls_paterno = "" 
		ls_materno = dw_profesor.GETITEMSTRING(le_row, "profesor_amaterno") 
		IF ISNULL(ls_materno) THEN ls_materno = "" 
	
		st_profesor_titular.TEXT =  "Profesor Titular : " + STRING( ll_cve_prof) + " - " + ls_paterno + " " + ls_materno + " " + ls_nombre
		
	END IF
	
END IF 

INTEGER le_pos 
INTEGER le_ttl

FOR le_row = 1 TO dw_profesor.ROWCOUNT() 
	
	ll_cve_prof = dw_profesor.GETITEMNUMBER(le_row, "cve_profesor") 
	IF ISNULL(ll_cve_prof) THEN ll_cve_prof = 0 
	IF ll_cve_prof > 0 THEN le_ttl ++ 
	
	
NEXT 

st_profesor_titular.TEXT += "           Se han capturado: " + STRING(le_ttl)  + " Profesores. "

RETURN 0 



end function

public function integer wf_asigna_fechas_grupo_modular ();
INTEGER le_ttl_prof 
INTEGER le_pos 
DATETIME ldt_detalle 
DATETIME ldt_inicio 
DATETIME ldt_fin

dw_sesiones_detalle.ACCEPTTEXT() 

le_ttl_prof = dw_sesiones_detalle.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_prof 


	ldt_detalle = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_inicio") 
	IF le_pos = 1 THEN 
		ldt_inicio = ldt_detalle
	ELSE
		IF DATE(ldt_detalle) < DATE(ldt_inicio) THEN ldt_inicio = ldt_detalle 
	END IF
	
	ldt_detalle = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_fin") 
	IF le_pos = 1 THEN 
		ldt_fin = ldt_detalle 
	ELSE
		IF DATE(ldt_detalle) > DATE(ldt_fin) THEN ldt_fin = ldt_detalle 
	END IF	
	

NEXT 

dw_grupo.object.grupos_fecha_inicio[1] = ldt_inicio
dw_grupo.object.grupos_fecha_fin[1] = ldt_fin	

// Si solo existe una sesión, se asignan las fechas de inicio y fin 
IF dw_sesiones.ROWCOUNT() = 1 THEN 
	dw_sesiones.SETITEM(1, "fecha_inicio", ldt_inicio)
	dw_sesiones.SETITEM(1, "fecha_fin", ldt_fin)
END IF 	

RETURN 0 
















//
//INTEGER le_ttl_prof 
//INTEGER le_pos 
//DATETIME ldt_detalle 
//DATETIME ldt_inicio 
//DATETIME ldt_fin
//
//dw_sesiones_detalle.ACCEPTTEXT() 
//
//le_ttl_prof = dw_sesiones_detalle.ROWCOUNT() 
//
//FOR le_pos = 1 TO le_ttl_prof 
//
//
//	ldt_detalle = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_inicio") 
//	IF le_pos = 1 THEN 
//		ldt_inicio = ldt_detalle
//	ELSE
//		IF DATE(ldt_detalle) < DATE(ldt_inicio) THEN ldt_inicio = ldt_detalle 
//	END IF
//	
//	ldt_detalle = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_fin") 
//	IF le_pos = 1 THEN 
//		ldt_fin = ldt_detalle 
//	ELSE
//		IF DATE(ldt_detalle) > DATE(ldt_fin) THEN ldt_fin = ldt_detalle 
//	END IF	
//	
//
//NEXT 
//
//dw_grupo.object.grupos_fecha_inicio[1] = ldt_inicio
//dw_grupo.object.grupos_fecha_fin[1] = ldt_fin	
//
//
//RETURN 0 
//
//
//
//
//
//
//
//
//
end function

public function integer wf_habilita_sesion ();
IF cb_sesionar.CHECKED THEN 
	dw_sesiones.VISIBLE = TRUE 
	gb_horario.width = 5842
	pb_inserta_sesion.VISIBLE = TRUE 
	pb_borra_sesion.VISIBLE = TRUE 	
	cb_detalle_sesiones.VISIBLE = TRUE 			 
	
	datawindowchild ldwc_dias
	dw_sesiones.GETCHILD("cve_dia", ldwc_dias) 
	ldwc_dias.SETTRANSOBJECT(itr_sce) 
	ldwc_dias.RETRIEVE() 
	
ELSE
	
	dw_sesiones.VISIBLE = FALSE
	gb_horario.width = 4183
	pb_inserta_sesion.VISIBLE = FALSE 
	pb_borra_sesion.VISIBLE = FALSE 		
	cb_detalle_sesiones.VISIBLE = FALSE 		
	
END IF 

RETURN 0 




end function

public function integer wf_valida_sesiones ();INTEGER le_pos, le_row 
INTEGER le_ttl_horario 

LONG ll_clase_aula
LONG ll_cve_dia
LONG ll_hora_inicio
LONG ll_hora_final
STRING ls_cve_salon	

INTEGER le_ttl_sesiones 
INTEGER le_pos_sesion 
DATETIME ldt_inicio_bloque
DATETIME ldt_fin_bloque



// Se hace ciclo sobre las sesiones del grupo 
IF dw_sesiones.ROWCOUNT() = 0 THEN  
	dw_sesiones.INSERTROW(0) 
	dw_sesiones.SETITEM(1, "fecha_inicio", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio"))
	dw_sesiones.SETITEM(1, "fecha_fin", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin"))
END IF 


// Se recupera el detalle de horario 
le_ttl_horario = dw_horario.ROWCOUNT() 

// Se hace ciclo sobre las sesiones para inicializar el detalle de sesiones del grupo.
le_ttl_sesiones = dw_sesiones.ROWCOUNT() 

dw_sesiones_detalle.RESET() 

FOR le_pos_sesion = 1 TO le_ttl_sesiones 
	
	ldt_inicio_bloque = dw_sesiones.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")
	ldt_fin_bloque = dw_sesiones.GETITEMDATETIME(le_pos_sesion, "fecha_fin") 
	
	FOR le_pos = 1 TO le_ttl_horario  

		ll_clase_aula = dw_horario.GETITEMNUMBER(le_pos, "clase_aula") 
		ll_cve_dia = dw_horario.GETITEMNUMBER(le_pos, "cve_dia") 
		ll_hora_inicio = dw_horario.GETITEMNUMBER(le_pos, "hora_inicio")  
		ll_hora_final = dw_horario.GETITEMNUMBER(le_pos, "hora_final")  
		ls_cve_salon = dw_horario.GETITEMSTRING(le_pos, "cve_salon")  

		le_row = dw_sesiones_detalle.INSERTROW(0) 
		dw_sesiones_detalle.SETITEM(le_row, "cve_mat", dw_grupo.GETITEMNUMBER(1, "cve_mat"))	
		dw_sesiones_detalle.SETITEM(le_row, "gpo", dw_grupo.GETITEMSTRING(1, "gpo"))	
		dw_sesiones_detalle.SETITEM(le_row, "periodo", ii_periodo)	
		dw_sesiones_detalle.SETITEM(le_row, "anio", ii_anio)	
		dw_sesiones_detalle.SETITEM(le_row, "cve_dia", ll_cve_dia)	
		dw_sesiones_detalle.SETITEM(le_row, "cve_salon", ls_cve_salon)	
		dw_sesiones_detalle.SETITEM(le_row, "hora_inicio", ll_hora_inicio)	
		dw_sesiones_detalle.SETITEM(le_row, "hora_final", ll_hora_final)	
		dw_sesiones_detalle.SETITEM(le_row, "fecha_inicio", ldt_inicio_bloque)	
		dw_sesiones_detalle.SETITEM(le_row, "fecha_fin", ldt_fin_bloque) 	 
		dw_sesiones_detalle.SETITEM(le_row, "horario_modular_orden", le_row) 	 

	NEXT 
	
NEXT  
//dw_sesiones.saveas("", CLIPBOARD!, TRUE)
//**/
wf_calcula_horas_multitular(0)

RETURN 0





	











//INTEGER le_pos, le_row 
//INTEGER le_ttl_horario 
//
//LONG ll_clase_aula
//LONG ll_cve_dia
//LONG ll_hora_inicio
//LONG ll_hora_final
//STRING ls_cve_salon	
//
//// Se verifica si se han capturado sesiones, de lo contrario se inicializa el dw. 
//IF dw_sesiones.ROWCOUNT() = 0 THEN 
//
//	le_ttl_horario = dw_horario.ROWCOUNT() 
//	
//	FOR le_pos = 1 TO le_ttl_horario 
//		
//		//ll_clase_aula = dw_horario.GETITEMNUMBER(le_pos, "clase_aula") 
//		ll_cve_dia = dw_horario.GETITEMNUMBER(le_pos, "cve_dia") 
//		ll_hora_inicio = dw_horario.GETITEMNUMBER(le_pos, "hora_inicio")  
//		ll_hora_final = dw_horario.GETITEMNUMBER(le_pos, "hora_final")  
//		ls_cve_salon = dw_horario.GETITEMSTRING(le_pos, "cve_salon")  
//		
//		le_row = dw_sesiones.INSERTROW(0) 
////		dw_sesiones.SETITEM(le_row, "cve_mat")	
////		dw_sesiones.SETITEM(le_row, "gpo")	
////		dw_sesiones.SETITEM(le_row, "periodo")	
////		dw_sesiones.SETITEM(le_row, "anio")	
//		dw_sesiones.SETITEM(le_row, "cve_dia", ll_cve_dia)	
//		dw_sesiones.SETITEM(le_row, "cve_salon", ls_cve_salon)	
//		dw_sesiones.SETITEM(le_row, "hora_inicio", ll_hora_inicio)	
//		dw_sesiones.SETITEM(le_row, "hora_final", ll_hora_final)	
//		dw_sesiones.SETITEM(le_row, "fecha_inicio", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio"))	
//		dw_sesiones.SETITEM(le_row, "fecha_fin", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin")) 	
//		//materia		
//		
//	NEXT 	
//	dw_sesiones.TRIGGEREVENT("ordena") 
//	RETURN 0 
//	
//END IF 	
//
//
//
//
//// Se valida la información que se captura en las sesiones del grupo.
////INTEGER le_ttl_sesion  
////INTEGER le_pos_sesion 
////
////INTEGER le_cve_dia 
////INTEGER le_hora_inicio 
////INTEGER le_hora_final 
////DATETIME ldt_fecha_inicio 
////DATETIME ldt_fecha_fin 
////
////STRING ls_busqueda 
////INTEGER le_pos_row
////
////le_ttl_sesion  = dw_sesiones.ROWCOUNT() 
////
////FOR le_pos_sesion = 1 TO  le_ttl_sesion 
////
//// 	le_cve_dia = dw_sesiones.GETITEMNUMBER(le_pos_sesion, "cve_dia")
////	le_hora_inicio = dw_sesiones.GETITEMNUMBER(le_pos_sesion, "hora_inicio")
////	le_hora_final = dw_sesiones.GETITEMNUMBER(le_pos_sesion, "hora_final")
////	ldt_fecha_inicio = dw_sesiones.GETITEMDATETIME(le_pos_sesion, "fecha_inicio")
////	ldt_fecha_fin = dw_sesiones.GETITEMDATETIME(le_pos_sesion, "fecha_fin")
////	
////	// Se busca el día especificado.
////	ls_busqueda = "cve_dia = " + STRING(le_cve_dia) 
////	le_pos_row = dw_horario.FIND(ls_busqueda, 1, dw_horario.ROWCOUNT())   
////	
////	
////	IF le_pos_row > 0 THEN 
////		
////		
////		
////	END IF
////
////
////NEXT 
//
//
//dw_sesiones.TRIGGEREVENT("ordena")
//
//RETURN 0
//
//
//
//
//
//	
//
//
//
//
//
//
end function

public function integer wf_inicia_fechas_feault ();INTEGER le_pos 
INTEGER le_ttl_prof 

wf_fechas_default() 

// Se ponen fechas default en el detalle de Profesores. 
le_ttl_prof = dw_profesor.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_prof 

	dw_profesor.SETITEM(le_pos, "fecha_inicio", iuo_grupo_servicios.idt_inicio_periodo)  
	dw_profesor.SETITEM(le_pos, "fecha_fin", iuo_grupo_servicios.idt_fin_periodo)  

NEXT 

// El detalle de sesiones se reinicia, asignando el horario default. 
cb_sesionar.CHECKED = FALSE 
ids_sesiones_grupo.RESET() 
wf_habilita_sesion()

RETURN 0




end function

public function integer wf_cambia_periodo_trabajo (integer ai_cambia_periodo);
IF ai_cambia_periodo = 0 THEN RETURN 0

// Al mover el periodo se limpia la ventana para un nuevo grupo 
//ie_cambia_periodo = 0

TRIGGEREVENT("ue_nuevo")  


iuo_grupo_servicios.of_fechas_periodo() 
wf_fechas_default() 
dw_horario.TRIGGEREVENT("ue_valida_horario") 

//ie_cambia_periodo = 1

RETURN 0 
end function

public function integer wf_calcula_horas_multitular (long al_profesor);
INTEGER le_pos, le_pos_prof
LONG ll_cve_prof 
INTEGER le_ttl_reg, le_cve_dia, le_hora_inicio, le_hora_final, le_row, le_diferencia

//IF is_multititular = 'S' THEN 

IF al_profesor = 0 THEN 
	ids_horario_profesor.RESET() 
END IF 

FOR le_pos_prof = 1 TO dw_profesor.ROWCOUNT() 
	
	ll_cve_prof = dw_profesor.GETITEMNUMBER(le_pos_prof, "cve_profesor") 
	IF ISNULL(ll_cve_prof) THEN CONTINUE 

	IF ll_cve_prof <> al_profesor AND al_profesor <> 0 THEN CONTINUE 

	// Si se trata de un grupo tradicional 
	//IF ie_forma_imparte = 1 THEN 
	 IF NOT cb_sesionar.CHECKED THEN  
		le_ttl_reg = dw_horario.ROWCOUNT() 
	
		
		FOR le_pos = 1 TO le_ttl_reg 
			
			le_cve_dia = dw_horario.GETITEMNUMBER(le_pos, "cve_dia")   
			IF ISNULL(le_cve_dia) THEN CONTINUE
			le_hora_inicio = dw_horario.GETITEMNUMBER(le_pos, "hora_inicio")   
			le_hora_final = dw_horario.GETITEMNUMBER(le_pos, "hora_final")   
			
			le_row = ids_horario_profesor.INSERTROW(0) 
			ids_horario_profesor.SETITEM(le_row, "cve_profesor", ll_cve_prof)  
			ids_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
			ids_horario_profesor.SETITEM(le_row, "hora_inicio", le_hora_inicio)    
			ids_horario_profesor.SETITEM(le_row, "hora_final", le_hora_final)   
			ids_horario_profesor.SETITEM(le_row, "fecha_inicio", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio"))
			ids_horario_profesor.SETITEM(le_row, "fecha_fin", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin")) 
			
			ids_horario_profesor.SETITEM(le_row, "cve_mat"	, dw_grupo.GETITEMNUMBER(1, "cve_mat"))
			ids_horario_profesor.SETITEM(le_row, "gpo", dw_grupo.GETITEMSTRING(1, "gpo"))	 
			ids_horario_profesor.SETITEM(le_row, "periodo", ii_periodo)	
			ids_horario_profesor.SETITEM(le_row, "anio", ii_anio) 
			le_diferencia = le_hora_final - le_hora_inicio 
			ids_horario_profesor.SETITEM(le_row, "horas_asignadas", le_diferencia) 
			
			wf_cuenta_horas_grupo()
		
		NEXT 		
		
		
//	// Si se trata de un GRUPO SESIONADO 	
//	ELSEIF ie_forma_imparte = 2 AND NOT cb_sesionar.CHECKED THEN  
//		
//		le_ttl_reg = dw_profesor.ROWCOUNT() 
//		
//		FOR le_pos = 1 TO le_ttl_reg 
//			
//			le_cve_dia = dw_profesor.GETITEMNUMBER(le_pos, "cve_dia")   
//			IF ISNULL(le_cve_dia) THEN CONTINUE
//			le_hora_inicio = dw_profesor.GETITEMNUMBER(le_pos, "hora_inicio")   
//			le_hora_final = dw_profesor.GETITEMNUMBER(le_pos, "hora_final")   
//			
//			le_row = ids_horario_profesor.INSERTROW(0) 
//			ids_horario_profesor.SETITEM(le_row, "cve_profesor", ll_cve_prof)  
//			ids_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
//			ids_horario_profesor.SETITEM(le_row, "hora_inicio", le_hora_inicio)    
//			ids_horario_profesor.SETITEM(le_row, "hora_final", le_hora_final)   
//			ids_horario_profesor.SETITEM(le_row, "fecha_inicio", dw_profesor.GETITEMDATETIME(le_pos, "fecha_inicio"))
//			ids_horario_profesor.SETITEM(le_row, "fecha_fin", dw_profesor.GETITEMDATETIME(le_pos, "fecha_fin")) 
//			
//			ids_horario_profesor.SETITEM(le_row, "cve_mat"	, dw_grupo.GETITEMNUMBER(1, "cve_mat"))
//			ids_horario_profesor.SETITEM(le_row, "gpo", dw_grupo.GETITEMSTRING(1, "gpo"))	 
//			ids_horario_profesor.SETITEM(le_row, "periodo", ii_periodo)	
//			ids_horario_profesor.SETITEM(le_row, "anio", ii_anio) 
//			le_diferencia = le_hora_final - le_hora_inicio 
//			ids_horario_profesor.SETITEM(le_row, "horas_asignadas", le_diferencia) 
//			
//			wf_cuenta_horas_grupo()
//		
//		NEXT 				
		
		// Si se trata de un grupo MODULAR SESIONADO  
	//ELSEIF ie_forma_imparte = 2 AND cb_sesionar.CHECKED THEN  
	ELSE 
	//////////////////////////////////////////////////////////////////////////////
	
		le_ttl_reg = dw_sesiones_detalle.ROWCOUNT() 
		
		FOR le_pos = 1 TO le_ttl_reg 
			
			le_cve_dia = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "cve_dia")   
			IF ISNULL(le_cve_dia) THEN CONTINUE
			le_hora_inicio = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "hora_inicio")   
			le_hora_final = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "hora_final")   
			
			le_row = ids_horario_profesor.INSERTROW(0) 
			ids_horario_profesor.SETITEM(le_row, "cve_profesor", ll_cve_prof)  
			ids_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
			ids_horario_profesor.SETITEM(le_row, "hora_inicio", le_hora_inicio)    
			ids_horario_profesor.SETITEM(le_row, "hora_final", le_hora_final)   
			ids_horario_profesor.SETITEM(le_row, "fecha_inicio", dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_inicio"))
			ids_horario_profesor.SETITEM(le_row, "fecha_fin", dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_fin")) 
			
			ids_horario_profesor.SETITEM(le_row, "cve_mat"	, dw_grupo.GETITEMNUMBER(1, "cve_mat"))
			ids_horario_profesor.SETITEM(le_row, "gpo", dw_grupo.GETITEMSTRING(1, "gpo"))	 
			ids_horario_profesor.SETITEM(le_row, "periodo", ii_periodo)	
			ids_horario_profesor.SETITEM(le_row, "anio", ii_anio) 
			le_diferencia = le_hora_final - le_hora_inicio 
			ids_horario_profesor.SETITEM(le_row, "horas_asignadas", le_diferencia) 
			
			wf_cuenta_horas_grupo()
		
		NEXT 			
	
	
	//////////////////////////////////////////////////////////////////////////////
	
	
	END IF 
	
NEXT
	
//END IF 

RETURN 0 
end function

public function date wf_regresa_fecha ();
RETURN DATE("01/01/" + STRING(ii_anio)) 


end function

public function boolean wf_valida_aplica_sesionado (long al_cve_materia);
INTEGER le_permite

SELECT COUNT(*)  
INTO :le_permite
FROM grupos_valida_exepcion   
WHERE cve_mat = :al_cve_materia 
USING itr_sce; 
IF itr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar si se permiten grupos modulares para la materia " + STRING(al_cve_materia) + ":" + itr_sce.SQLERRTEXT)	 
	RETURN FALSE 
END IF 	

ib_permite_modular = FALSE 
IF le_permite > 0 THEN ib_permite_modular = TRUE 

// Si existe la materia en la tabla de excepciones, se permiten los fgrupos modulares.
IF le_permite <= 0 OR ie_modo_opera = 2 THEN  
	IF ie_modo = 1 AND le_permite > 0 THEN 
		dw_grupo.SETITEM(1, "grupos_forma_imparte", 1) 
		ie_forma_imparte = 1 
		dw_grupo.MODIFY("grupos_forma_imparte.protect = 0")  
		ie_forma_imparte = dw_grupo.GETITEMNUMBER(1, "grupos_forma_imparte") 
		dw_grupo.Modify("grupos_forma_imparte.Background.Color = '1073741824'")
		RETURN TRUE			
	ELSE
		dw_grupo.MODIFY("grupos_forma_imparte.protect = 1") 
		dw_grupo.Modify("grupos_forma_imparte.Background.Color = '67108864'")		
	END IF 	
	RETURN FALSE
ELSE 
	dw_grupo.MODIFY("grupos_forma_imparte.protect = 0")  
	ie_forma_imparte = dw_grupo.GETITEMNUMBER(1, "grupos_forma_imparte") 
	dw_grupo.Modify("grupos_forma_imparte.Background.Color = '1073741824'")
	RETURN TRUE	
END IF 	


RETURN TRUE 












end function

public function integer wf_aplica_seguridad ();//Habilita la seguridad para la ventana actual
//THIS.CHANGEMENU(m_grupos_impartidos_bloque) 
gnv_app.inv_security.of_SetSecurity(THIS)



//IF NOT dw_horario.ENABLED THEN 
//	dw_profesor.MODIFY("b_buscar.ENABLED = FALSE")
//ELSE 	
//	dw_profesor.MODIFY("b_buscar.ENABLED = TRUE")
//END IF 	
//	
//	

//IF ie_modo = 1 THEN 
//	
//	dw_grupo.ENABLED = TRUE
//	
//	
//	dw_grupo.MODIFY("cve_mat.PROTECT = 0")
//	dw_grupo.MODIFY("materias_materia.PROTECT = 0")
//	dw_grupo.MODIFY("gpo.PROTECT = 0")
//
//	dw_grupo.MODIFY("cve_mat.Background.Color = '1073741824'")
//	dw_grupo.MODIFY("materias_materia.Background.Color = '1073741824'")
//	dw_grupo.MODIFY("gpo.Background.Color = '1073741824'")
//	
//	
//END IF 	


RETURN 0 


end function

public function integer wf_ordena_profesor ();dw_profesor.SETSORT("titularidad D, cve_profesor A")
dw_profesor.SORT()	
RETURN 0
end function

public function integer wf_confirma_salida ();
IF ib_modificado THEN 
	IF MESSAGEBOX("Confirmación", "¿Desea guardar los cambios?", QUESTION!, YesNo!) = 1 THEN 
		dw_grupo.triggerevent("actualiza") 
		IF ib_modificado THEN RETURN -1 
	END IF 
END IF 
RETURN 0 



end function

public function boolean wf_valida_salon_en_linea ();
// Se verifica si existe algún registro de horario con clase aula diferente a 3 "OTRO" 
// Retorna TRUE si existe una clase aula diferente a OTRO 
IF dw_horario.FIND("clase_aula <> 3", 0, dw_horario.ROWCOUNT() + 1) > 0 THEN RETURN TRUE 
	

end function

on w_grupos_impartidos_bloque.create
if this.MenuName = "m_grupos_impartidos_bloque" then this.MenuID = create m_grupos_impartidos_bloque
this.uo_periodo=create uo_periodo
this.st_tot_capt=create st_tot_capt
this.st_horas_capturadas_totales=create st_horas_capturadas_totales
this.st_horas_totales=create st_horas_totales
this.st_tot_per=create st_tot_per
this.cb_detalle_sesiones=create cb_detalle_sesiones
this.dw_sesiones=create dw_sesiones
this.pb_borra_sesion=create pb_borra_sesion
this.pb_inserta_sesion=create pb_inserta_sesion
this.dw_sesiones_detalle=create dw_sesiones_detalle
this.cb_sesionar=create cb_sesionar
this.cb_1=create cb_1
this.st_profesor_titular=create st_profesor_titular
this.cbx_sdu_servicios_escolares=create cbx_sdu_servicios_escolares
this.st_estatus=create st_estatus
this.st_hor_cap_semanal=create st_hor_cap_semanal
this.st_hor_min_semanal=create st_hor_min_semanal
this.st_horas_capturadas=create st_horas_capturadas
this.st_horas_minimas=create st_horas_minimas
this.dw_grupos_paquetes_b=create dw_grupos_paquetes_b
this.dw_selecciona_paquete_b=create dw_selecciona_paquete_b
this.mc_profesor=create mc_profesor
this.dp_fin=create dp_fin
this.dp_inicio=create dp_inicio
this.pb_inserta_profesor=create pb_inserta_profesor
this.pb_borra_profesor=create pb_borra_profesor
this.pb_inserta_horario=create pb_inserta_horario
this.sle_comentarios=create sle_comentarios
this.st_2=create st_2
this.st_1=create st_1
this.uo_periodo_2=create uo_periodo_2
this.dw_profesor=create dw_profesor
this.dw_horario=create dw_horario
this.gb_1=create gb_1
this.pb_borra_horario=create pb_borra_horario
this.gb_horario=create gb_horario
this.dw_grupo=create dw_grupo
this.cbx_multitular=create cbx_multitular
this.Control[]={this.uo_periodo,&
this.st_tot_capt,&
this.st_horas_capturadas_totales,&
this.st_horas_totales,&
this.st_tot_per,&
this.cb_detalle_sesiones,&
this.dw_sesiones,&
this.pb_borra_sesion,&
this.pb_inserta_sesion,&
this.dw_sesiones_detalle,&
this.cb_sesionar,&
this.cb_1,&
this.st_profesor_titular,&
this.cbx_sdu_servicios_escolares,&
this.st_estatus,&
this.st_hor_cap_semanal,&
this.st_hor_min_semanal,&
this.st_horas_capturadas,&
this.st_horas_minimas,&
this.dw_grupos_paquetes_b,&
this.dw_selecciona_paquete_b,&
this.mc_profesor,&
this.dp_fin,&
this.dp_inicio,&
this.pb_inserta_profesor,&
this.pb_borra_profesor,&
this.pb_inserta_horario,&
this.sle_comentarios,&
this.st_2,&
this.st_1,&
this.uo_periodo_2,&
this.dw_profesor,&
this.dw_horario,&
this.gb_1,&
this.pb_borra_horario,&
this.gb_horario,&
this.dw_grupo,&
this.cbx_multitular}
end on

on w_grupos_impartidos_bloque.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo)
destroy(this.st_tot_capt)
destroy(this.st_horas_capturadas_totales)
destroy(this.st_horas_totales)
destroy(this.st_tot_per)
destroy(this.cb_detalle_sesiones)
destroy(this.dw_sesiones)
destroy(this.pb_borra_sesion)
destroy(this.pb_inserta_sesion)
destroy(this.dw_sesiones_detalle)
destroy(this.cb_sesionar)
destroy(this.cb_1)
destroy(this.st_profesor_titular)
destroy(this.cbx_sdu_servicios_escolares)
destroy(this.st_estatus)
destroy(this.st_hor_cap_semanal)
destroy(this.st_hor_min_semanal)
destroy(this.st_horas_capturadas)
destroy(this.st_horas_minimas)
destroy(this.dw_grupos_paquetes_b)
destroy(this.dw_selecciona_paquete_b)
destroy(this.mc_profesor)
destroy(this.dp_fin)
destroy(this.dp_inicio)
destroy(this.pb_inserta_profesor)
destroy(this.pb_borra_profesor)
destroy(this.pb_inserta_horario)
destroy(this.sle_comentarios)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uo_periodo_2)
destroy(this.dw_profesor)
destroy(this.dw_horario)
destroy(this.gb_1)
destroy(this.pb_borra_horario)
destroy(this.gb_horario)
destroy(this.dw_grupo)
destroy(this.cbx_multitular)
end on

event open;//il_coordinacion = 4300

dw_sesiones.VISIBLE = FALSE 

// 1 = Nuevo, 2 = grupos cambios
ie_modo_opera = MESSAGE.DOUBLEPARM 

il_coordinacion = f_obten_coord_de_usuario(gs_usuario)

is_multititular = 'N'
ib_modifica_salon = FALSE
ib_modificado = FALSE 

// Si se trata de servicios escolares se enciende seleccionador de descueto de Derecho y Uso de Salones 
IF il_coordinacion = 9999 THEN 
	cbx_sdu_servicios_escolares.VISIBLE = TRUE 
ELSE
	cbx_sdu_servicios_escolares.VISIBLE = FALSE
END IF

//***********************************************************
// Se habilita la seguridad 

////Se conecta a la seguridad para mantener separada una transacción para la seguridad
//if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
//	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
//end if
//
////Es necesario reasignar el transaction object para la seguridad
//gnv_app.of_SetSecurity(TRUE)
//gnv_app.itr_security = itr_seguridad
//gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
//gnv_app.itr_security.of_Connect()
//if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
//		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
//		Close(this)
//end if

////Habilita la seguridad para la ventana actual
//gnv_app.inv_security.of_SetSecurity(this)

//***********************************************************

// Se conecta la transacción local a la base activa.
INTEGER li_resultado 
itr_parametros_iniciales = gtr_sce
li_resultado	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,itr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if li_resultado <> 1 then return
//itr_sce = gtr_sce

iuo_grupo_servicios = CREATE uo_grupo_servicios  
iuo_materias_servicios = CREATE uo_materias_servicios 
iuo_profesor_servicios = CREATE uo_profesor_servicios 
ids_horario_profesor = CREATE DATASTORE   
ids_horario_profesor.DATAOBJECT = "dw_horario_prof_grupo" 
ids_sesiones_grupo = CREATE DATASTORE 
ids_sesiones_grupo.DATAOBJECT = "dw_horario_modular"  

iuo_grupo_servicios.itr_sce = itr_sce 
iuo_grupo_servicios.il_cve_coordinacion_paq = il_coordinacion 
iuo_grupo_servicios.of_inicializa_parametros() 

iuo_grupo_servicios.ie_modo_opera = ie_modo_opera

iuo_materias_servicios.itr_sce = itr_sce 

// Se recupera el periodo de alta de grupos
 f_obten_periodo(ii_periodo, ii_anio, 4)
 
//ii_anio = 2019 
//ii_periodo = 0 
 
 
THIS.uo_periodo.em_ani.text = string(ii_anio)
THIS.uo_periodo.em_per.text = string(ii_periodo)

THIS.uo_periodo.ie_anio = ii_anio 
THIS.uo_periodo.ie_periodo = ii_periodo   
THIS.uo_periodo.TRIGGEREVENT("ue_modifica") 
//wf_cambia_periodo_trabajo("N") 


// Si es verano, no se permite la captura de grupos modulares.
IF THIS.uo_periodo.ie_periodo = 1 THEN 
	THIS.dw_grupo.MODIFY("grupos_forma_imparte.PROTECT = 1") 
END IF

iuo_profesor_servicios.itr_sce = itr_sce
iuo_profesor_servicios.of_inicializa_parametros()
iuo_profesor_servicios.il_coordinacion = il_coordinacion 
iuo_grupo_servicios.of_fechas_periodo()


dw_grupo.SETTRANSOBJECT(itr_sce) 
TRIGGEREVENT("ue_nuevo") 

dw_horario.SETTRANSOBJECT(itr_sce)  

//datawindowchild ldw_clase_aula
//dw_horario.GETCHILD("clase_aula", ldw_clase_aula) 
//ldw_clase_aula.SETTRANSOBJECT(itr_sce) 
//ldw_clase_aula.RETRIEVE() 


datawindowchild ldw_cve_dia
dw_horario.GETCHILD("cve_dia", ldw_cve_dia) 
ldw_cve_dia.SETTRANSOBJECT(itr_sce) 
ldw_cve_dia.RETRIEVE() 


//wf_carga_lista_paquetes() 

wf_habilita() 

// Si se trata de modo Grupos Cambios, la ventana se abre en modo Modificación. 
IF ie_modo_opera = 2 THEN 
	ie_modo = 2 
ELSE
	ie_modo = 1
END IF

wf_filtra_clase_aula() 

// Se llama, al final la función de habilitación por modo de apertura
wf_habilita_cambios() 

wf_obten_titulo() 

dw_grupo.MODIFY("grupos_cve_asimilada.PROTECT = 1")
dw_grupo.MODIFY("grupos_gpo_asimilado.PROTECT = 1")
dw_grupo.Modify("grupos_cve_asimilada.Background.Color = '67108864'")
dw_grupo.Modify("grupos_gpo_asimilado.Background.Color = '67108864'")


dw_horario.SetRowFocusIndicator(Hand!)
dw_profesor.SetRowFocusIndicator(Hand!)

wf_habilita_sesion() 

// Se enciende bandera para que en lo sucesivo modifique las fechas para la edición de grupos.
ie_cambia_periodo = 1
w_principal.ChangeMenu(m_grupos_impartidos_salir)

//Habilita la seguridad para la ventana actual
//THIS.CHANGEMENU(m_grupos_impartidos_bloque)
//gnv_app.inv_security.of_SetSecurity(this)


wf_aplica_seguridad()

end event

event close;
DESTROY iuo_grupo_servicios 
DESTROY iuo_materias_servicios 


w_principal.ChangeMenu(m_principal)

gnv_app.inv_security.of_SetSecurity(w_principal)


end event

event closequery;IF wf_confirma_salida( ) < 0 THEN RETURN 1 
RETURN 0



end event

type uo_periodo from uo_per_ani_grupos_mod within w_grupos_impartidos_bloque
integer x = 448
integer y = 28
integer taborder = 20
end type

on uo_periodo.destroy
call uo_per_ani_grupos_mod::destroy
end on

event ue_modifica;call super::ue_modifica;
//IF PARENT.ii_periodo = THIS.ie_periodo AND PARENT.ii_anio = THIS.ie_anio THEN RETURN 

PARENT.ii_periodo = THIS.ie_periodo
PARENT.ii_anio = THIS.ie_anio 

PARENT.iuo_grupo_servicios.ie_periodo = ii_periodo 
PARENT.iuo_grupo_servicios.ie_anio = ii_anio  

//ib_omite_set_value = TRUE 
POST wf_cambia_periodo_trabajo(ie_cambia_periodo) 
//////////////////////////////////////////////////////////////////////////////////////////
////THIS.em_ani.text = string(ii_anio)
////THIS.em_per.text = string(ii_periodo)
////
////THIS.ie_anio = ii_anio 
////THIS.ie_periodo = ii_periodo   
////THIS.TRIGGEREVENT("ue_modifica") 
////
////// Si es verano, no se permite la captura de grupos modulares.
////IF THIS.ie_periodo = 1 THEN 
////	PARENT.dw_grupo.MODIFY("grupos_forma_imparte.PROTECT = 1") 
////END IF 
//
//


end event

type st_tot_capt from statictext within w_grupos_impartidos_bloque
integer x = 3191
integer y = 1584
integer width = 699
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Horas totales capturadas: "
boolean focusrectangle = false
end type

type st_horas_capturadas_totales from statictext within w_grupos_impartidos_bloque
integer x = 3904
integer y = 1580
integer width = 114
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_horas_totales from statictext within w_grupos_impartidos_bloque
integer x = 3904
integer y = 1496
integer width = 114
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_tot_per from statictext within w_grupos_impartidos_bloque
integer x = 3191
integer y = 1500
integer width = 617
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Horas totales periodo: "
boolean focusrectangle = false
end type

type cb_detalle_sesiones from commandbutton within w_grupos_impartidos_bloque
integer x = 5422
integer y = 1340
integer width = 247
integer height = 92
integer taborder = 120
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Detalle"
end type

event clicked;STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio
INTEGER le_orden

INTEGER le_pos 

LONG ll_cve_mat
INTEGER le_cve_dia 
STRING ls_cve_salon 
INTEGER le_hora_inicio 
INTEGER le_hora_final 
DATETIME ldt_fecha_inicio 
DATETIME ldt_fecha_fin 
uo_grupo_paso luo_grupo_paso2
	
ll_cve_mat = dw_grupo.GETITEMNUMBER(1, "cve_mat")    
ls_gpo = dw_grupo.GETITEMSTRING(1, "gpo")   
le_periodo = ii_periodo   
le_anio = ii_anio  


uo_grupo_paso luo_grupo_paso
luo_grupo_paso.ie_modo_opera= ie_modo_opera
luo_grupo_paso.ie_modo = ie_modo 
luo_grupo_paso.ie_anio = ii_anio
luo_grupo_paso.ids_grupo_sesion.DATAOBJECT = dw_sesiones_detalle.DATAOBJECT 
dw_sesiones_detalle.ROWSCOPY(1, dw_sesiones_detalle.ROWCOUNT(), PRIMARY!, luo_grupo_paso.ids_grupo_sesion, 1, PRIMARY! ) 

luo_grupo_paso.ids_horario.DATAOBJECT = dw_horario.DATAOBJECT 
dw_horario.ROWSCOPY(1, dw_horario.ROWCOUNT(), PRIMARY!, luo_grupo_paso.ids_horario, 1, PRIMARY!) 

luo_grupo_paso.ids_sesiones.DATAOBJECT = dw_sesiones.DATAOBJECT  
dw_sesiones.ROWSCOPY(1, dw_sesiones.ROWCOUNT(), PRIMARY!, luo_grupo_paso.ids_sesiones, 1, PRIMARY!)  

// Se pasan las fechas de inicio y fin del semestre 
luo_grupo_paso.idt_inicio_semestre = iuo_grupo_servicios.idt_inicio_periodo
luo_grupo_paso.idt_fin_semestre = iuo_grupo_servicios.idt_fin_periodo


OPENWITHPARM(w_sesiones_grupo_detalle, luo_grupo_paso) 
IF NOT ISVALID(MESSAGE.POWEROBJECTPARM) THEN RETURN -1 
luo_grupo_paso2 = MESSAGE.POWEROBJECTPARM 
dw_sesiones_detalle.RESET() 
luo_grupo_paso2.ids_grupo_sesion.ROWSCOPY(1, luo_grupo_paso2.ids_grupo_sesion.ROWCOUNT(), PRIMARY!, dw_sesiones_detalle, 1, PRIMARY!) 

wf_inicializa_servicio() 
iuo_grupo_servicios.ie_horas_totales_capt = iuo_grupo_servicios.of_cuenta_horas_sesiones() 
st_horas_capturadas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_totales_capt) 
wf_calcula_horas_multitular(0)

POST wf_asigna_fechas_grupo_modular()
 
ib_modificado = TRUE


//// Se inicializa el detalle de SESIONES DE GRUPOS. 
//FOR le_pos = 1 TO dw_sesiones_detalle.ROWCOUNT()   
//	
////	le_cve_mat = dw_sesiones.GETITEMNUMBER(le_pos, "cve_mat")
////	ls_gpo = dw_sesiones.GETITEMSTRING(le_pos, "gpo")
////	le_periodo = dw_sesiones.GETITEMNUMBER(le_pos, "periodo")
////	le_anio = dw_sesiones.GETITEMNUMBER(le_pos, "anio")
//	le_cve_dia = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "cve_dia")
//	ls_cve_salon = dw_sesiones_detalle.GETITEMSTRING(le_pos, "cve_salon")
//	le_hora_inicio = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "hora_inicio")
//	le_hora_final = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "hora_final")
//	ldt_fecha_inicio = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_inicio")
//	ldt_fecha_fin = dw_sesiones_detalle.GETITEMDATETIME(le_pos, "fecha_fin")
//	le_orden = dw_sesiones_detalle.GETITEMNUMBER(le_pos, "horario_modular_orden") 	
//
//	le_pos = iuo_grupo_servicios.ids_grupo_sesion.INSERTROW(0)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "cve_mat", ll_cve_mat)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "gpo", ls_gpo)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "periodo", le_periodo)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "anio", le_anio)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "cve_dia", le_cve_dia)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "cve_salon", ls_cve_salon)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "hora_inicio", le_hora_inicio)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "hora_final", le_hora_final)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "fecha_inicio", ldt_fecha_inicio)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "fecha_fin", ldt_fecha_fin)
//	iuo_grupo_servicios.ids_grupo_sesion.SETITEM(le_pos, "horario_modular_orden", le_orden) 
//
//NEXT 




end event

type dw_sesiones from datawindow within w_grupos_impartidos_bloque
event ordena ( )
event ue_cuenta_horas ( )
integer x = 4078
integer y = 1104
integer width = 1312
integer height = 620
integer taborder = 110
string title = "none"
string dataobject = "dw_fechas_modular"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_cuenta_horas();// Se llama función de validación de sesiones. 
wf_valida_sesiones() 
//wf_calcula_horas_multitular()
wf_inicializa_servicio() 
iuo_grupo_servicios.ie_horas_totales_capt = iuo_grupo_servicios.of_cuenta_horas_sesiones()
st_horas_capturadas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_totales_capt) 
wf_calcula_horas_multitular(0)



end event

event itemchanged;POSTEVENT("ue_cuenta_horas")
POST wf_asigna_fechas_grupo_modular()

//// Se llama función de validación de sesiones. 
//wf_valida_sesiones() 
////wf_calcula_horas_multitular()
//wf_inicializa_servicio() 
//iuo_grupo_servicios.ie_horas_totales_capt = iuo_grupo_servicios.of_cuenta_horas_sesiones()
//st_horas_capturadas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_totales_capt) 
//wf_calcula_horas_multitular()



ib_modificado = TRUE
end event

event losefocus;THIS.ACCEPTTEXT() 



end event

type pb_borra_sesion from picturebutton within w_grupos_impartidos_bloque
integer x = 5545
integer y = 1228
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row 

le_row = dw_sesiones.GETROW()
IF le_row > 0 THEN dw_sesiones.DELETEROW(le_row) 

//dw_horario.TRIGGEREVENT("ue_valida_horario") 


dw_sesiones.TRIGGEREVENT("ordena") 

ib_modificado = TRUE

end event

type pb_inserta_sesion from picturebutton within w_grupos_impartidos_bloque
integer x = 5426
integer y = 1228
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row, valor
le_row = dw_sesiones.INSERTROW(0)
SETNULL(valor) 

DATE ldt_fecha 

ldt_fecha = wf_regresa_fecha() 

dw_sesiones.SETITEM(le_row, "fecha_inicio", ldt_fecha)
dw_sesiones.SETITEM(le_row, "fecha_fin", ldt_fecha)

ib_modificado = TRUE

//dw_horario.SETITEM(le_row, "clase_aula", valor) 

//dw_sesiones.TRIGGEREVENT("ordena") 

end event

type dw_sesiones_detalle from datawindow within w_grupos_impartidos_bloque
event ordena ( )
boolean visible = false
integer x = 3314
integer y = 264
integer width = 2414
integer height = 620
integer taborder = 40
string title = "none"
string dataobject = "dw_horario_modular"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ordena();INTEGER le_pos

FOR le_pos = 1 TO ROWCOUNT() 
	THIS.SETITEM(le_pos, "horario_modular_orden", le_pos)  
NEXT 
end event

event itemchanged;
// Se llama función de validación de sesiones. 



end event

type cb_sesionar from checkbox within w_grupos_impartidos_bloque
boolean visible = false
integer x = 3529
integer y = 1164
integer width = 338
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sesionar"
end type

event clicked;
POST wf_habilita_sesion()  
POST wf_valida_sesiones() 



end event

type cb_1 from commandbutton within w_grupos_impartidos_bloque
boolean visible = false
integer x = 3346
integer y = 628
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Sesionar"
end type

event clicked;
INTEGER le_pos, le_row 
INTEGER le_ttl_horario 

LONG ll_clase_aula
LONG ll_cve_dia
LONG ll_hora_inicio
LONG ll_hora_final
STRING ls_cve_salon		

IF ids_sesiones_grupo.ROWCOUNT() = 0 THEN 
	
	le_ttl_horario = dw_horario.ROWCOUNT() 
	
	FOR le_pos = 1 TO le_ttl_horario 
		
		//ll_clase_aula = dw_horario.GETITEMNUMBER(le_pos, "clase_aula") 
		ll_cve_dia = dw_horario.GETITEMNUMBER(le_pos, "cve_dia") 
		ll_hora_inicio = dw_horario.GETITEMNUMBER(le_pos, "hora_inicio")  
		ll_hora_final = dw_horario.GETITEMNUMBER(le_pos, "hora_final")  
		ls_cve_salon = dw_horario.GETITEMSTRING(le_pos, "cve_salon")  
		
		le_row = ids_sesiones_grupo.INSERTROW(0) 
//		ids_sesiones_grupo.SETITEM(le_row, "cve_mat")	
//		ids_sesiones_grupo.SETITEM(le_row, "gpo")	
//		ids_sesiones_grupo.SETITEM(le_row, "periodo")	
//		ids_sesiones_grupo.SETITEM(le_row, "anio")	
		ids_sesiones_grupo.SETITEM(le_row, "cve_dia", ll_cve_dia)	
		ids_sesiones_grupo.SETITEM(le_row, "cve_salon", ls_cve_salon)	
		ids_sesiones_grupo.SETITEM(le_row, "hora_inicio", ll_hora_inicio)	
		ids_sesiones_grupo.SETITEM(le_row, "hora_final", ll_hora_final)	
//		ids_sesiones_grupo.SETITEM(le_row, "fecha_inicio")	
//		ids_sesiones_grupo.SETITEM(le_row, "fecha_fin") 	
		//materia		
		
		
	NEXT 
	
END IF 

uo_grupo_paso luo_grupo_paso 
luo_grupo_paso.ids_grupo_sesion = ids_sesiones_grupo 

OPENWITHPARM(w_horario_modular, luo_grupo_paso, w_grupos_impartidos_bloque)  





end event

type st_profesor_titular from statictext within w_grupos_impartidos_bloque
integer x = 119
integer y = 1780
integer width = 5582
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Profesor Titular : "
boolean focusrectangle = false
end type

type cbx_sdu_servicios_escolares from checkbox within w_grupos_impartidos_bloque
integer x = 1765
integer y = 104
integer width = 1426
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Descontar derecho y uso a Servicios Escolares"
end type

type st_estatus from statictext within w_grupos_impartidos_bloque
integer x = 1719
integer y = 28
integer width = 1367
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Alta Grupo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_hor_cap_semanal from statictext within w_grupos_impartidos_bloque
integer x = 3191
integer y = 1380
integer width = 617
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Horas capturadas sem: "
boolean focusrectangle = false
end type

type st_hor_min_semanal from statictext within w_grupos_impartidos_bloque
integer x = 3191
integer y = 1296
integer width = 617
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Horas mínimas sem: "
boolean focusrectangle = false
end type

type st_horas_capturadas from statictext within w_grupos_impartidos_bloque
integer x = 3904
integer y = 1380
integer width = 114
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_horas_minimas from statictext within w_grupos_impartidos_bloque
integer x = 3904
integer y = 1296
integer width = 114
integer height = 68
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "0"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type dw_grupos_paquetes_b from datawindow within w_grupos_impartidos_bloque
boolean visible = false
integer x = 3232
integer y = 308
integer width = 2862
integer height = 1428
integer taborder = 90
string dataobject = "dw_grupos_paquetes2"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event clicked;
IF dwo.name = "b_buscar" THEN 
	
	LONG ll_cve_materia
	STRING ls_materia 

	OPENWITHPARM(w_busca_materia, il_coordinacion) 
	ll_cve_materia = MESSAGE.doubleparm 
	
	THIS.SETITEM(row, "cve_materia", ll_cve_materia)   
	iuo_materias_servicios.of_recupera_materia( ll_cve_materia, ls_materia) 
	THIS.SETITEM(row, "materias_materia", ls_materia)     

	
END IF 







end event

event itemchanged;
STRING ls_materia 


IF dwo.name = "cve_materia" THEN 
	
	iuo_materias_servicios.of_recupera_materia( LONG(data), ls_materia)
	
	THIS.SETITEM(row, "materias_materia", ls_materia)   
	
END IF 






end event

type dw_selecciona_paquete_b from datawindow within w_grupos_impartidos_bloque
event ue_carga ( )
boolean visible = false
integer x = 3205
integer y = 52
integer width = 1893
integer height = 212
integer taborder = 100
string title = "none"
string dataobject = "dw_selecciona_grupo_paq"
boolean border = false
boolean livescroll = true
end type

event ue_carga();INTEGER id_paquete 

//id_paquete = dw_selecciona_paquete.GETITEMNUMBER(1, "id_paquete")  
//IF ISNULL(id_paquete) THEN RETURN 
//
//iuo_grupo_servicios.il_id_paquete  = id_paquete
//iuo_grupo_servicios.of_carga_grupo_paquete( )
//
//dw_selecciona_paquete.SETITEM(1, "descripcion", iuo_grupo_servicios.is_descripcion_paq) 
//
//
//dw_grupos_paquetes.SETTRANSOBJECT(itr_sce) 
//dw_grupos_paquetes.RETRIEVE(id_paquete) 
//
//ie_paquete = id_paquete

RETURN 


















end event

event itemchanged;
//IF dwo.name = "id_paquete" THEN  
//	
//	
//	
//	IF data = '0' THEN 
//		dw_grupos_paquetes.RESET() 
//		
//		IF MESSAGEBOX("Aviso", "Si no selecciona paquete, los horarios asignados a los grupos no serán validados. ¿Desea continuar?", Question!, YesNo!) = 2 THEN 
//			POSTEVENT("ue_carga")					
//			RETURN 2	
//			
//		END IF
//		dw_selecciona_paquete.SETITEM(row, "descripcion", "SIN PAQUETE") 
//		ie_paquete = 0
//		
//	ELSE 
//		POSTEVENT("ue_carga")		
//	END IF 
//	
//END IF 
//


end event

type mc_profesor from monthcalendar within w_grupos_impartidos_bloque
boolean visible = false
integer x = 3209
integer y = 284
integer width = 1253
integer height = 760
integer taborder = 70
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
weekday firstdayofweek = sunday!
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event doubleclicked;THIS.GetSelectedDate(idt_fecha_profesor) 

IF is_fecha_selec = "F" THEN 
	
	//IF idt_fecha_profesor > DATE(dw_profesor.GETITEMDATETIME(dw_profesor.GETROW(), "fecha_fin"))  THEN 
	IF idt_fecha_profesor > DATE(dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin"))  THEN  
		MESSAGEBOX("Aviso", "La fecha no puede ser posterior a la fecha de fin del curso.") 
		RETURN 
	END IF
	
	dw_profesor.SETITEM(dw_profesor.GETROW(), "fecha_fin", idt_fecha_profesor)
ELSE
	
	//IF idt_fecha_profesor < DATE(dw_profesor.GETITEMDATETIME(dw_profesor.GETROW(), "fecha_inicio"))  THEN 
	IF idt_fecha_profesor < DATE(dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio"))  THEN  
		MESSAGEBOX("Aviso", "La fecha no puede ser anterior a la fecha de inicio del curso.") 
		RETURN 
	END IF	
	
	dw_profesor.SETITEM(dw_profesor.GETROW(), "fecha_inicio", idt_fecha_profesor)
END IF

THIS.VISIBLE = FALSE 
//dw_profesor.TRIGGEREVENT("ue_fechas")  
wf_calcula_horas_multitular(0)
end event

event losefocus;THIS.VISIBLE = FALSE
end event

type dp_fin from datepicker within w_grupos_impartidos_bloque
event ue_fecha_modificada ( )
boolean visible = false
integer x = 3602
integer y = 48
integer width = 82
integer height = 84
integer taborder = 80
boolean border = true
borderstyle borderstyle = styleraised!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-09-21"), Time("12:57:55.000000"))
integer textsize = -9
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event ue_fecha_modificada();
//DATETIME ldt_valor
//GETVALUE(ldt_valor)
//
//MESSAGEBOX("", "Entra")
//
//PARENT.dw_grupo.SETITEM(1, "grupos_fecha_fin", ldt_valor)
//PARENT.dw_horario.TRIGGEREVENT("ue_valida_horario") 


end event

event valuechanged;//POSTEVENT("ue_fecha_modificada")


//DATETIME ldt_valor
//GETVALUE(ldt_valor)
//



end event

event closeup;DATETIME ldt_valor, ldt_valor_act
GETVALUE(ldt_valor)

//MESSAGEBOX("", "Entra")

ldt_valor_act = PARENT.dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin")

IF DATE(ldt_valor_act) = DATE(ldt_valor) THEN RETURN 0


IF ldt_valor < iuo_grupo_servicios.idt_inicio_periodo THEN 
	MESSAGEBOX("Error", "La fecha final no puede ser anterior a la fecha de Inicio del Semestre.") 
	THIS.setvalue( DATETIME(ldt_valor_act))
	RETURN 0
ELSEIF ldt_valor > iuo_grupo_servicios.idt_fin_periodo THEN 
	MESSAGEBOX("Error", "La fecha final no puede ser posterior a la fecha de Fin del Semestre.") 
	THIS.setvalue( DATETIME(ldt_valor_act))
	RETURN 0
END IF

PARENT.dw_grupo.SETITEM(1, "grupos_fecha_fin", ldt_valor)
PARENT.dw_horario.TRIGGEREVENT("ue_valida_horario") 


end event

type dp_inicio from datepicker within w_grupos_impartidos_bloque
event ue_fecha_modificada ( )
boolean visible = false
integer x = 2057
integer y = 460
integer width = 82
integer height = 84
integer taborder = 20
boolean border = true
borderstyle borderstyle = styleraised!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-09-21"), Time("12:57:55.000000"))
integer textsize = -9
integer fontweight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event ue_fecha_modificada();
//DATETIME ldt_valor
//GETVALUE(ldt_valor)
//
//PARENT.dw_grupo.SETITEM(1, "grupos_fecha_inicio", ldt_valor) 
//PARENT.dw_horario.TRIGGEREVENT("ue_valida_horario") 
//







end event

event valuechanged;//POSTEVENT("ue_fecha_modificada")

end event

event closeup;DATETIME ldt_valor, ldt_valor_act
GETVALUE(ldt_valor)

//MESSAGEBOX("", "Entra")

ldt_valor_act = PARENT.dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio")

IF DATE(ldt_valor_act) = DATE(ldt_valor) THEN RETURN 0

IF ldt_valor < iuo_grupo_servicios.idt_inicio_periodo THEN 
	MESSAGEBOX("Error", "La fecha inicial no puede ser anterior a la fecha de Inicio del Semestre.") 
	THIS.setvalue( DATETIME(ldt_valor_act))
	RETURN 0
ELSEIF ldt_valor > iuo_grupo_servicios.idt_fin_periodo THEN 
	MESSAGEBOX("Error", "La fecha inicial no puede ser posterior a la fecha de Fin del Semestre.") 
	THIS.setvalue( DATETIME(ldt_valor_act))
	RETURN 0
END IF

PARENT.dw_grupo.SETITEM(1, "grupos_fecha_inicio", ldt_valor)
PARENT.dw_horario.TRIGGEREVENT("ue_valida_horario") 



//DATETIME ldt_valor
//GETVALUE(ldt_valor)
//
//PARENT.dw_grupo.SETITEM(1, "grupos_fecha_inicio", ldt_valor) 
//PARENT.dw_horario.TRIGGEREVENT("ue_valida_horario") 


end event

type pb_inserta_profesor from picturebutton within w_grupos_impartidos_bloque
integer x = 5600
integer y = 2048
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;
//// Si no hay ningún profesor se inserta 
//IF dw_profesor.ROWCOUNT() = 0 THEN 
//	dw_profesor.INSERTROW(0) 
//	//RETURN  
//END IF

IF cbx_multitular.CHECKED = FALSE AND dw_profesor.ROWCOUNT() >= 1 THEN RETURN 0 

INTEGER le_row
//// Si ya existe algún registro de profesor se verifica la configuración.
//IF ie_forma_imparte = 1 THEN 
//	
////	IF iuo_grupo_servicios.ie_multiples_prof_trad = 0 THEN 
////		MESSAGEBOX("Aviso", "No se permite más de u n profesor para grupos que se imparten de manera Tradicional.") 
////		RETURN 
////	ELSE
//		le_row = dw_profesor.INSERTROW(0) 
//		dw_profesor.SETITEM(le_row, "profesor_cotitular_autorizado", 0)
//		le_row = dw_profesor.SETROW(le_row)
//		dw_profesor.SCROLLTOROW(le_row)
////	END IF
//	
//ELSE 	
//	
	
	INTEGER le_pos 
	INTEGER le_nulo
	

	FOR le_pos = 1 TO dw_profesor.ROWCOUNT() 
		
		IF ISNULL(dw_profesor.GETITEMNUMBER(le_pos, "cve_profesor")) THEN 
			le_nulo = le_pos
			EXIT 
		END IF 	
		
		
	NEXT 	

	IF le_nulo = 0 THEN 
		le_row = dw_profesor.INSERTROW(0) 
		dw_profesor.SETROW(le_row)
		dw_profesor.SCROLLTOROW(le_row)
		dw_profesor.SETITEM(le_row, "profesor_cotitular_autorizado", 0)
		dw_profesor.SETITEM(le_row, "titularidad", 0)
		dw_profesor.SETITEM(le_row, "profesor_cotitular_evalua", "S")
	ELSE
		dw_profesor.SETROW(le_nulo)
		dw_profesor.SCROLLTOROW(le_nulo)
		//dw_profesor.SETITEM(le_nulo, "titularidad", 1)
	END IF 	
	
//END IF 


IF dw_profesor.ROWCOUNT() = 1 THEN 
	dw_profesor.SETITEM(1, "titularidad", 1)
	dw_profesor.SETITEM(1, "profesor_cotitular_autorizado", 1)
END IF

dw_profesor.triggerevent("ue_fechas")
POST wf_ordena_profesor()

ib_modificado = TRUE



end event

type pb_borra_profesor from picturebutton within w_grupos_impartidos_bloque
integer x = 5600
integer y = 2148
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row 
LONG ll_cve_prof_ant

le_row = dw_profesor.GETROW()
ll_cve_prof_ant = dw_profesor.GETITEMNUMBER(le_row, "cve_profesor") 

IF MESSAGEBOX("Confirmación", "El profesor " + STRING(ll_cve_prof_ant) + " será eliminado. ¿Desea Continuar?", Question!, YesNo! ) = 2 THEN RETURN 0

IF le_row > 0 THEN dw_profesor.DELETEROW(le_row) 

IF ISNULL(ll_cve_prof_ant) THEN ll_cve_prof_ant = 0 
IF ll_cve_prof_ant <> 0 THEN wf_borra_horario_profesor(ll_cve_prof_ant)


//dw_profesor.SORT()
wf_ordena_profesor()

ib_modificado = TRUE





end event

type pb_inserta_horario from picturebutton within w_grupos_impartidos_bloque
integer x = 3209
integer y = 1156
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row, valor
le_row = dw_horario.INSERTROW(0)
SETNULL(valor) 
dw_horario.SETITEM(le_row, "clase_aula", valor) 

ib_modificado = TRUE
end event

type sle_comentarios from singlelineedit within w_grupos_impartidos_bloque
integer x = 453
integer y = 2368
integer width = 2683
integer height = 200
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
integer limit = 255
borderstyle borderstyle = stylelowered!
end type

event modified;ib_modificado = TRUE
end event

type st_2 from statictext within w_grupos_impartidos_bloque
integer x = 59
integer y = 2364
integer width = 416
integer height = 68
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Comentarios: "
boolean focusrectangle = false
end type

type st_1 from statictext within w_grupos_impartidos_bloque
integer x = 96
integer y = 52
integer width = 315
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo: "
boolean focusrectangle = false
end type

type uo_periodo_2 from uo_per_ani within w_grupos_impartidos_bloque
boolean visible = false
integer x = 3662
integer y = 28
integer width = 1253
integer height = 168
boolean enabled = true
boolean border = true
long backcolor = 1090519039
end type

on uo_periodo_2.destroy
call uo_per_ani::destroy
end on

event ue_modifica;call super::ue_modifica;
//IF PARENT.ii_periodo = THIS.ie_periodo AND PARENT.ii_anio = THIS.ie_anio THEN RETURN 

PARENT.ii_periodo = THIS.ie_periodo
PARENT.ii_anio = THIS.ie_anio 

PARENT.iuo_grupo_servicios.ie_periodo = ii_periodo 
PARENT.iuo_grupo_servicios.ie_anio = ii_anio  

//ib_omite_set_value = TRUE 
POST wf_cambia_periodo_trabajo(ie_cambia_periodo) 
//////////////////////////////////////////////////////////////////////////////////////////
////THIS.em_ani.text = string(ii_anio)
////THIS.em_per.text = string(ii_periodo)
////
////THIS.ie_anio = ii_anio 
////THIS.ie_periodo = ii_periodo   
////THIS.TRIGGEREVENT("ue_modifica") 
////
////// Si es verano, no se permite la captura de grupos modulares.
////IF THIS.ie_periodo = 1 THEN 
////	PARENT.dw_grupo.MODIFY("grupos_forma_imparte.PROTECT = 1") 
////END IF 
//
//


end event

type dw_profesor from datawindow within w_grupos_impartidos_bloque
event ue_fechas ( )
integer x = 96
integer y = 1960
integer width = 5399
integer height = 352
integer taborder = 50
string title = "none"
string dataobject = "d_profesores_grupo_bloques"
boolean controlmenu = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event ue_fechas();INTEGER le_forma_imparte 
INTEGER le_pos, le_ttl_rgs


// Si es Tradicional se asignan fechas default y se inhabilitan los campos de fechas
IF ie_forma_imparte = 1 THEN  

	le_ttl_rgs = THIS.ROWCOUNT() 
	
	FOR le_pos = 1 TO le_ttl_rgs 
		dw_profesor.SETITEM(le_pos, "fecha_inicio", iuo_grupo_servicios.idt_inicio_periodo)  
		dw_profesor.SETITEM(le_pos, "fecha_fin", iuo_grupo_servicios.idt_fin_periodo)
	NEXT 


	dw_profesor.MODIFY("fecha_inicio.PROTECT = 1")  
	dw_profesor.MODIFY("fecha_fin.PROTECT = 1") 
	
	dw_profesor.Modify("fecha_inicio.Background.Color = '67108864'")
	dw_profesor.Modify("fecha_fin.Background.Color = '67108864'")

// Si es por bloque se habilitan los campos de fechas
ELSE 
	
//	dp_inicio.ENABLED = TRUE
//	dp_fin.ENABLED = TRUE 
	
	dw_profesor.MODIFY("fecha_inicio.PROTECT = 0")  
	dw_profesor.MODIFY("fecha_fin.PROTECT = 0")	
	
	dw_profesor.Modify("fecha_inicio.Background.Color = '1073741824'") 
	dw_profesor.Modify("fecha_fin.Background.Color = '1073741824'") 
	
	// NO APLICA 15/052019 NO APLICA 15/052019 NO APLICA 15/052019
//	dw_profesor.SETITEM(GETROW(), "fecha_inicio", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio") ) 
//	dw_profesor.SETITEM(GETROW(), "fecha_fin", dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin") )
		// NO APLICA 15/052019 NO APLICA 15/052019 NO APLICA 15/052019
	
END IF

RETURN 




end event

event itemchanged;INTEGER le_pos 
INTEGER le_ttl_rgs 
INTEGER le_retorno

le_ttl_rgs = THIS.ROWCOUNT() 

ib_modificado = TRUE 

IF dwo.name = "titularidad" THEN 
	
	IF data = '0' THEN 
		RETURN 2 
	ELSE
		FOR le_pos = 1 TO le_ttl_rgs 
			IF le_pos <> row THEN 
				THIS.SETITEM(le_pos, "titularidad", 0)
				THIS.SETITEM(le_pos, "profesor_cotitular_autorizado", 0)
			ELSE
				THIS.SETITEM(le_pos, "profesor_cotitular_autorizado", 1)
			END IF 
		NEXT
	END IF 
	
	POST wf_despliega_profesor_titular(2)

//	THIS.SETSORT("titularidad D, cve_profesor A")
//	THIS.SORT()	
	POST wf_ordena_profesor()
	
ELSEIF dwo.name = "b_fecha_fin" OR dwo.name = "b_fecha_inicio" THEN     
	
	// Se verifica que la fecha seleccionada esté dentro de la vigencia del periodo de alta. 
	IF DATE(data) < DATE(iuo_grupo_servicios.idt_inicio_periodo) OR DATE(data) > DATE(iuo_grupo_servicios.idt_fin_periodo) THEN 
		MESSAGEBOX("Error", "La fecha seleccionada esta fuera de la duración del periodo " + gs_descripcion_tipo_periodo) 
		RETURN 2
	END IF

ELSEIF dwo.name = "cve_profesor"  THEN  
	
	
// SE ELIMINA ESTA VALIDACIÓN POR SOLICITUD DE FANTINE MEDINA 01/11/2019 
//	IF data = "1" AND ie_forma_imparte = 2 THEN 
//		MESSAGEBOX("Aviso", "En un grupo modular debe especificarse un profesor.") 
//		RETURN 2 		
//	END IF 	
// SE ELIMINA ESTA VALIDACIÓN POR SOLICITUD DE FANTINE MEDINA 01/11/2019 
	
	// Se verifica si el profesor ya ha sido capturado.
	LONG ll_cve_prof  	
	
	FOR le_pos = 1 TO THIS.ROWCOUNT() 
		
		IF le_pos = row THEN CONTINUE 
		
		ll_cve_prof = THIS.GETITEMNUMBER(le_pos, "cve_profesor")  
		IF ll_cve_prof = LONG(data) THEN 
			THIS.SETTEXT("")
			THIS.SETROW(le_pos)
			POST SCROLLTOROW(le_pos) 
			//THIS.SELECTROW(le_pos, TRUE) 
			POST SETCOLUMN("profesor_apaterno") 
			MESSAGEBOX("Aviso", "El profesor ha sido asignado previamente.") 
			RETURN 2 
		END IF 	
			
	NEXT 		
	
	
	ll_cve_prof = THIS.GETITEMNUMBER(row, "cve_profesor") 
	
	IF NOT ISNULL(ll_cve_prof) THEN 
		IF MESSAGEBOX("Confirmación", "Si modifica un profesor deberá capturar de nuevo el horario. ¿Desea Continuar?", Question!, YesNo! ) = 2 THEN RETURN 2 
		// Se elimina cualquier horario que exista de este profesor.
		wf_borra_horario_profesor(ll_cve_prof)		
	END IF
			
	IF wf_recupera_profesor(row, LONG(data)) < 0 THEN RETURN 2 
	
	POST wf_calcula_horas_multitular(LONG(data))
	
	POST wf_despliega_profesor_titular(2)
	
	// Se asigna NO AUTORIZADO por default 
	dw_profesor.SETITEM(row, "profesor_cotitular_autorizado", 0)
	
	IF is_multititular = 'S' THEN 
//	//////////////////////////////////////////////////////////////////////////		
//	INTEGER le_ttl_reg, le_cve_dia, le_hora_inicio, le_hora_final, le_row 	
//		
//	le_ttl_reg = dw_horario.ROWCOUNT() 
//	
//	FOR le_pos = 1 TO le_ttl_reg 
//		
//		le_cve_dia = dw_horario.GETITEMNUMBER(le_pos, "cve_dia")   
//		IF ISNULL(le_cve_dia) THEN CONTINUE
//		le_hora_inicio = dw_horario.GETITEMNUMBER(le_pos, "hora_inicio")   
//		le_hora_final = dw_horario.GETITEMNUMBER(le_pos, "hora_final")   
//		
//		le_row = ids_horario_profesor.INSERTROW(0) 
//		ids_horario_profesor.SETITEM(le_row, "cve_profesor", LONG(data)) 
//		ids_horario_profesor.SETITEM(le_row, "cve_dia", le_cve_dia)  
//		ids_horario_profesor.SETITEM(le_row, "hora_inicio", le_hora_inicio)    
//		ids_horario_profesor.SETITEM(le_row, "hora_final", le_hora_final)   
//		ids_horario_profesor.SETITEM(le_row, "fecha_inicio", dw_grupo.GETITEMNUMBER(1, "grupos_fecha_inicio"))
//		ids_horario_profesor.SETITEM(le_row, "fecha_fin", dw_grupo.GETITEMNUMBER(1, "grupos_fecha_fin")) 
//		
//		wf_cuenta_horas_grupo()
//	
//	NEXT 		
//		
//	//////////////////////////////////////////////////////////////////////////	
	END IF 
	
END IF











//	// Se verifica que el profesor exista y esté activo.
//	le_retorno = iuo_profesor_servicios.of_recupera_profesor( LONG(data) ) 
//	
//	IF le_retorno < 0 THEN 
//		MESSAGEBOX("Error", iuo_profesor_servicios.is_error ) 
//		RETURN 2
//	ELSEIF le_retorno = 100 THEN 
//		MESSAGEBOX("aviso", iuo_profesor_servicios.is_error ) 
//		RETURN 2		
//	END IF 
//	
//	// Se verifica que el profesor no esté bloqueado.
//	le_retorno = iuo_profesor_servicios.of_profesor_bloqueado( ii_periodo, ii_anio, il_coordinacion)
//	
//	THIS.SETITEM(row, "profesor_nombre", iuo_profesor_servicios.is_nombre)
//	THIS.SETITEM(row, "profesor_amaterno", iuo_profesor_servicios.is_amaterno)
//	THIS.SETITEM(row, "profesor_apaterno", iuo_profesor_servicios.is_apaterno ) 
//	THIS.SETITEM(row, "horas_profesor", 0)  


end event

event clicked;
IF dwo.name = "b_fecha_fin" OR dwo.name = "b_fecha_inicio" THEN    
	
	DATETIME ldt_seleccionada
	DATETIME ldt_lmp
	
	mc_profesor.x = dw_profesor.x + PixelsToUnits(xpos , XPixelsToUnits!)
	mc_profesor.y = dw_profesor.y + PixelsToUnits(ypos , YPixelsToUnits!)
	IF dwo.name = "b_fecha_fin"  THEN 
		ldt_seleccionada = THIS.GETITEMDATETime( row, "fecha_fin") 
		IF ISNULL(ldt_seleccionada) OR ldt_seleccionada = ldt_lmp THEN ldt_seleccionada = iuo_grupo_servicios.idt_fin_periodo
		mc_profesor.SetSelectedDate (DATE(ldt_seleccionada)) 
		is_fecha_selec = "F"
	ELSE
		ldt_seleccionada = THIS.GETITEMDATETime( row, "fecha_inicio") 
		IF ISNULL(ldt_seleccionada) OR ldt_seleccionada = ldt_lmp THEN ldt_seleccionada = iuo_grupo_servicios.idt_inicio_periodo 
		mc_profesor.SetSelectedDate (DATE(ldt_seleccionada))
		is_fecha_selec = "I"
	END IF
	mc_profesor.VISIBLE = TRUE  
	THIS.SETROW(row)

	ib_modificado = TRUE

ELSEIF dwo.name = "b_buscar" THEN  

	IF NOT dw_horario.ENABLED THEN RETURN 0


	SETROW(row)
	//uo_grupo_paso luo_grupo_paso_prof  
	LONG ll_cve_prof
	LONG ll_cve_prof_ant
	
	ll_cve_prof_ant = THIS.GETITEMNUMBER(row, "cve_profesor") 
	
	IF NOT ISNULL(ll_cve_prof_ant) THEN 
		IF MESSAGEBOX("Confirmación", "Si modifica un profesor deberá capturar de nuevo el horario. ¿Desea Continuar?", Question!, YesNo! ) = 2 THEN RETURN 2 
	END IF
	
	
	OPEN(w_busca_profesor) 
	ll_cve_prof = MESSAGE.doubleparm 
	IF ll_cve_prof = 0 OR ISNULL(ll_cve_prof) THEN RETURN 0 
	

	IF wf_recupera_profesor(row, ll_cve_prof) < 0 THEN RETURN 0 
	THIS.SETITEM(row, "cve_profesor", ll_cve_prof)  
	
	THIS.SETITEM(row, "profesor_cotitular_autorizado", 0)
	
	IF ISNULL(ll_cve_prof_ant) THEN ll_cve_prof_ant = 0 
	IF ll_cve_prof_ant <> 0 THEN wf_borra_horario_profesor(ll_cve_prof_ant)
	
	POST wf_calcula_horas_multitular(ll_cve_prof)
	POST wf_despliega_profesor_titular(2)
	
	ib_modificado = TRUE
	
ELSEIF dwo.name = "b_horario" THEN 

	SETROW(row)

	uo_grupo_paso luo_grupo_paso 
	
	// Se pasa detalle de horarios
	luo_grupo_paso.ids_horario.DATAOBJECT = dw_horario.DATAOBJECT 
	dw_horario.ROWSCOPY(1, dw_horario.ROWCOUNT(), PRIMARY!, luo_grupo_paso.ids_horario, 1, PRIMARY!)
	
	// Se pasa detalle de profesores
	luo_grupo_paso.ids_profesor.DATAOBJECT = dw_profesor.DATAOBJECT 
	dw_profesor.ROWSCOPY(1, dw_profesor.ROWCOUNT(), PRIMARY!, luo_grupo_paso.ids_profesor , 1, PRIMARY!) 
	
	// Se pasa detalle de sesiones
	IF ISVALID(ids_sesiones_valida_prof) THEN DESTROY ids_sesiones_valida_prof 
	ids_sesiones_valida_prof = CREATE DATASTORE 
	ids_sesiones_valida_prof.DATAOBJECT = dw_sesiones_detalle.DATAOBJECT 
	dw_sesiones_detalle.ROWSCOPY(1, dw_sesiones_detalle.ROWCOUNT(), PRIMARY!, ids_sesiones_valida_prof, 1, PRIMARY!) 
	
	luo_grupo_paso.ids_sesiones = ids_sesiones_valida_prof
	
	IF cb_sesionar.CHECKED THEN 
		luo_grupo_paso.is_sesion = 'S' 
	ELSE
		luo_grupo_paso.is_sesion = 'N'
	END IF
	
	luo_grupo_paso.il_cve_profesor = THIS.GETITEMNUMBER(row, "cve_profesor")
	luo_grupo_paso.ie_titular = THIS.GETITEMNUMBER(row, "titularidad") 
	IF ISNULL(luo_grupo_paso.ie_titular) THEN luo_grupo_paso.ie_titular = 0 
	
	
	// Se pasa detalle del horario del profesor que se edita.  
	luo_grupo_paso.ids_horario_profesor.DATAOBJECT = ids_horario_profesor.DATAOBJECT  
	ids_horario_profesor.SETFILTER("cve_profesor = " + STRING(luo_grupo_paso.il_cve_profesor)) 
	ids_horario_profesor.FILTER() 
	ids_horario_profesor.ROWSCOPY(1, ids_horario_profesor.ROWCOUNT(), PRIMARY!, luo_grupo_paso.ids_horario_profesor, 1, PRIMARY!) 
	
	luo_grupo_paso.idt_inicio_semestre = iuo_grupo_servicios.idt_inicio_periodo
	luo_grupo_paso.idt_fin_semestre = iuo_grupo_servicios.idt_fin_periodo
	
	
	INTEGER le_pos2 
	INTEGER le_dia 
	STRING ls_coma 
	
	FOR le_pos2 = 1 TO dw_horario.ROWCOUNT() STEP 1 
		
		le_dia = dw_horario.GETITEMNUMBER(le_pos2, "cve_dia")  
		IF ISNULL(le_dia) THEN CONTINUE 
		
		luo_grupo_paso.is_dias_cve_dia = luo_grupo_paso.is_dias_cve_dia + ls_coma + STRING(le_dia) 
		ls_coma = "," 
		
	NEXT
	
	uo_grupo_paso luo_grupo_paso_ret 
	OPENWITHPARM(w_horario_profesor, luo_grupo_paso) 
	luo_grupo_paso_ret = MESSAGE.POWEROBJECTPARM 
	IF NOT ISVALID(luo_grupo_paso_ret) THEN RETURN 0
	IF luo_grupo_paso_ret.ie_retorno = 1 THEN  
		
		INTEGER le_horas_totales
		INTEGER le_hora_inicio, le_hora_fin
		INTEGER le_diferencia
		INTEGER le_pos 
		
		DATETIME ldt_detalle 
		DATETIME ldt_inicio 
		DATETIME ldt_fin
		
		ids_horario_profesor.rowsdiscard( 1, ids_horario_profesor.ROWCOUNT(), PRIMARY!)   
		luo_grupo_paso_ret.ids_horario_profesor.ROWSCOPY(1, luo_grupo_paso_ret.ids_horario_profesor.ROWCOUNT(), PRIMARY!, ids_horario_profesor, ids_horario_profesor.ROWCOUNT() + 1, PRIMARY! ) 

		// Se asigna el horario del profesor. 
		IF ids_horario_profesor.ROWCOUNT() > 0 THEN 
		
			FOR le_pos = 1 TO ids_horario_profesor.ROWCOUNT() STEP 1 
				ids_horario_profesor.SETITEM(le_pos, "cve_mat", dw_grupo.GETITEMNUMBER(1, "cve_mat")) 
				ids_horario_profesor.SETITEM(le_pos, "gpo", dw_grupo.GETITEMSTRING(1, "gpo"))
				ids_horario_profesor.SETITEM(le_pos, "periodo", ii_periodo)
				ids_horario_profesor.SETITEM(le_pos, "anio", ii_anio) 
				
				ldt_detalle = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_inicio") 
				IF le_pos = 1 THEN 
					ldt_inicio = ldt_detalle 
				ELSE 
					IF DATE(ldt_detalle) < DATE(ldt_inicio)  THEN ldt_inicio = ldt_detalle
				END IF
				
				ldt_detalle = ids_horario_profesor.GETITEMDATETIME(le_pos, "fecha_fin") 
				IF le_pos = 1 THEN 
					ldt_fin = ldt_detalle 
				ELSE
					IF DATE(ldt_detalle) > DATE(ldt_fin)  THEN ldt_fin = ldt_detalle
				END IF			
				
				le_hora_inicio = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_inicio") 
				le_hora_fin = ids_horario_profesor.GETITEMNUMBER(le_pos, "hora_final") 
				le_diferencia = le_hora_fin - le_hora_inicio 
				ids_horario_profesor.SETITEM(le_pos, "horas_asignadas", le_diferencia) 
				
				le_horas_totales = le_horas_totales + le_diferencia 
				
			NEXT
			
			THIS.SETITEM(row, "fecha_inicio", ldt_inicio)
			THIS.SETITEM(row, "fecha_fin", ldt_fin)
			
		ELSE
			
			// Si no se asigna horario al profesor, se asignan las fechas de vigencia del grupo 
			THIS.SETITEM(row, "fecha_inicio", dw_grupo.object.grupos_fecha_inicio[1])
			THIS.SETITEM(row, "fecha_fin", dw_grupo.object.grupos_fecha_fin[1])			
			
		END IF 	
		
		
		
		////THIS.SETITEM(row, "horas_profesor", le_horas_totales)  
		
		// Si se trata de un grupo mudular se asignan las fechas máxima y mínima del horario asignadoa los profesores.
		IF dw_grupo.GETITEMNUMBER(1, "grupos_forma_imparte") = 2 THEN 
//			POST wf_asigna_fechas_grupo_modular()
		END IF 

		POST wf_cuenta_horas_grupo()
	
	END IF 

	ib_modificado = TRUE

ELSEIF dwo.name = "titularidad"	THEN 

END IF




end event

event editchanged;//INTEGER  le_pos
//LONG ll_cve_prof
//
//IF dwo.name = "cve_profesor" THEN 
//
//	FOR le_pos = 1 TO THIS.ROWCOUNT() 
//		
//		IF le_pos = row THEN CONTINUE 
//		
//		ll_cve_prof = THIS.GETITEMNUMBER(le_pos, "cve_profesor")  
//		IF ll_cve_prof = LONG(data) THEN 
//			THIS.SETROW(le_pos)
//			THIS.SCROLLTOROW(le_pos) 
//			//THIS.SELECTROW(le_pos, TRUE) 
//			THIS.SETCOLUMN("profesor_apaterno") 
//			MESSAGEBOX("Aviso", "El profesor ha sido asignado previamente.") 
//			RETURN 2 
//		END IF 	
//			
//	NEXT 	
//END IF 		
end event

type dw_horario from datawindow within w_grupos_impartidos_bloque
event ue_valida_horario ( )
event ue_tipo_aula ( )
integer x = 101
integer y = 1104
integer width = 3035
integer height = 596
integer taborder = 30
string title = "none"
string dataobject = "dw_gpo_imp_horario_bloque"
boolean vscrollbar = true
boolean livescroll = true
end type

event ue_valida_horario();INTEGER le_pos
INTEGER le_ttl_rgs 
LONG ll_cve_prof 
DATE ldt_inicio 
DATE ldt_fin 
BOOLEAN lb_cambia_fechas 
DATETIME ldt_fecha_final 
LONG ll_horas_prof




ldt_inicio  = DATE(dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio")) 
ldt_fin = DATE(dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin")) 

le_ttl_rgs = dw_profesor.ROWCOUNT() 


// Se verifica si ya se capturaron profesores.
FOR le_pos = 1 TO le_ttl_rgs 
	ll_cve_prof = dw_profesor.GETITEMNUMBER(le_pos, "cve_profesor")   
	ll_horas_prof = dw_profesor.GETITEMNUMBER(le_pos, "horas_profesor")   
	IF ISNULL(ll_horas_prof) THEN ll_horas_prof = 0 
	
	//MESSAGEBOX("", STRING(ll_cve_prof))
	
	IF NOT ISNULL(ll_cve_prof) THEN 
		IF ll_horas_prof > 0 THEN 
//			IF MESSAGEBOX("Aviso", "Si modifica las fechas de inicio y fin de curso o el horario, deberá ajustar el horario de los profesores. ¿Desea continuar?", Question!, OKCancel!) = 1 THEN 
				lb_cambia_fechas = TRUE 
//			END IF 	
		ELSE
			lb_cambia_fechas = TRUE 
		END IF
		EXIT 
	END IF
NEXT 

// Si llegó al total de registros sin cambio, por default enciende la bandera de cambio
IF le_pos > le_ttl_rgs then lb_cambia_fechas = TRUE   

IF lb_cambia_fechas THEN 
	// Se llama función que reinicia el horario de profesor
	wf_reinicia_fecha_profesores() 
	FOR le_pos = 1 TO dw_profesor.ROWCOUNT()  
		PARENT.dw_profesor.SETITEM(le_pos, "fecha_inicio", ldt_inicio)  
		PARENT.dw_profesor.SETITEM(le_pos, "fecha_fin", ldt_fin)  					
	NEXT 
ELSE
	PARENT.dw_grupo.SETITEM(1, "grupos_fecha_inicio", iuo_grupo_servicios.idt_fecha_inicio)  
	PARENT.dw_grupo.SETITEM(1, "grupos_fecha_fin", iuo_grupo_servicios.idt_fecha_fin)  
	RETURN 	
END IF 

wf_calcula_horas_reales(0)

//**//
IF iuo_grupo_servicios.ie_forma_imparte = 2 THEN 
	// Se llama función de validación de sesiones. 
	wf_valida_sesiones() 
	//wf_calcula_horas_multitular()
	wf_inicializa_servicio() 
	iuo_grupo_servicios.ie_horas_totales_capt = iuo_grupo_servicios.of_cuenta_horas_sesiones()
	st_horas_capturadas_totales.TEXT = STRING(iuo_grupo_servicios.ie_horas_totales_capt) 
	wf_calcula_horas_multitular(0)
END IF	


//**//

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// Se valida en primera instancia que se hayan capturado las horas completas y que se trate de un curso modular. 
IF iuo_grupo_servicios.ie_horas_reales_tot_sem <= iuo_grupo_servicios.ie_horas_totales AND ie_forma_imparte <> 1 AND NOT iuo_grupo_servicios.ib_mat_exep_fecha_fin THEN  
	// Se llama función de inicialización de valores 
	//wf_inicializa_servicio() 
	//MESSAGEBOX("entra aqui", "entroaqui") 
	
	// Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final 
	// Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final 	
	//iuo_grupo_servicios.of_calcula_fecha_final()  
	// Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final 
	// Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final  Se comenta el cálculo de la fecha final 		
	
	IF 	iuo_grupo_servicios.idt_fecha_fin > iuo_grupo_servicios.idt_fin_periodo THEN 
		MESSAGEBOX("Error", "La Fecha Final del curso, calculada con los horarrios y fecha de inicio definidos, no puede ser mayor a la Fecha de Fin del Periodo Escolar.")
		MESSAGEBOX("Aviso", "Se asignará la fecha de inicio del semestre.")
		DATETIME ldt_nula
		SETNULL(ldt_nula) 
		dw_grupo.SETITEM(1, "grupos_fecha_inicio", iuo_grupo_servicios.idt_inicio_periodo)  
		
		// Se regresa la fecha en el detalle de profesores
		le_ttl_rgs = dw_profesor.ROWCOUNT() 
		FOR le_pos = 1 TO le_ttl_rgs 
			dw_profesor.SETITEM(le_pos, "fecha_inicio", iuo_grupo_servicios.idt_inicio_periodo)  
			dw_profesor.SETITEM(le_pos, "fecha_fin", iuo_grupo_servicios.idt_fin_periodo)
		NEXT 			
		
		RETURN 
	END IF
	
	dw_grupo.SETITEM(1, "grupos_fecha_fin", iuo_grupo_servicios.idt_fecha_fin ) 
	//MESSAGEBOX("", STRING(iuo_grupo_servicios.idt_fecha_fin))
	dw_profesor.TRIGGEREVENT("ue_fechas") 
	
END IF 	
///////////////////////////////////////////////////////////////////////////////////////////////////////////////// 
IF is_multititular = 'N' THEN POST wf_calcula_horas_multitular(0)

RETURN  









//INTEGER ie_retorno
//
//
//wf_inicializa_servicio() 
//
//iuo_grupo_servicios.of_calcula_horas_semana( )
//ie_retorno = iuo_grupo_servicios.of_calcula_horas_reales( )
//
//IF ie_retorno < 0 THEN 
//	
//	
//ELSEIF ie_retorno = 1 THEN 
//	
//	
//END IF
//
//
//PARENT.st_horas_minimas.TEXT = "Horas mínimas sem: " + STRING(iuo_grupo_servicios.ie_horas_reales_tot_sem )  
//PARENT.st_horas_capturadas.TEXT = "Horas capturadas sem: " + STRING(iuo_grupo_servicios.ie_horas_totales ) 
//
// 
end event

event ue_tipo_aula();
STRING ls_comentario
INTEGER le_clase

le_clase = THIS.GETITEMNUMBER(GETROW(), "clase_aula")  

SELECT comentario 
INTO :ls_comentario 
FROM clase_aula 
WHERE clase = :le_clase 
USING itr_sce; 	
	
THIS.SETITEM(GETROW(), "clase_aula_comentario", ls_comentario)	 


end event

event itemchanged;LONG ll_materia 
INTEGER le_row
INTEGER le_hora

ib_modificado = TRUE

ll_materia = dw_grupo.GETITEMNUMBER(1, "cve_mat") 
IF ISNULL(ll_materia) THEN ll_materia = 0 
IF ll_materia = 0 THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado una materia.")  
	RETURN 2	
END IF

//IF iuo_grupo_servicios.ie_grupos_paquetes = 1 THEN 
//	
//	IF dw_grupos_paquetes.ROWCOUNT() = 0 THEN 
//		MESSAGEBOX("Aviso", "No se ha seleccionado un paquete de materias.")  
//		RETURN 2
//	END IF
//
//END IF 
IF dwo.name = "comentario" THEN RETURN 0 
	

IF dwo.name = "hora_inicio" THEN
	le_hora = THIS.GETITEMNUMBER( row, "hora_final") 
	IF le_hora <= INTEGER(data) THEN 
		MESSAGEBOX("Error", "La hora de inicio no puede ser mayor o igual a la hora final.")
		RETURN 2
	END IF 
ELSEIF dwo.name = "hora_final" THEN
	le_hora = THIS.GETITEMNUMBER( row, "hora_inicio") 
	IF le_hora >= INTEGER(data) 	THEN 
		MESSAGEBOX("Error", "La hora de inicio no puede ser mayor o igual a la hora final.")
		RETURN 2
	END IF
END IF 



IF dwo.name = "cve_dia" AND ie_forma_imparte = 2 AND ie_paquete <> 0 THEN  

//	le_row = dw_grupos_paquetes.FIND("cve_materia = " + STRING(ll_materia) + " AND cve_dia = " + TRIM(data) , 0, dw_grupos_paquetes.ROWCOUNT() + 1) 
//	
//	IF le_row <= 0 THEN 
//		MESSAGEBOX("Aviso", "El día no existe en el paquete seleccionado")  
//		RETURN 2 
//	ELSE
//		
//		THIS.SETITEM(row, "hora_inicio", dw_grupos_paquetes.GETITEMNUMBER(le_row, "hora_inicio"))
//		THIS.SETITEM(row, "hora_final", dw_grupos_paquetes.GETITEMNUMBER(le_row, "hora_fin"))
//		
//	END IF	
	
	
//ELSEIF dwo.name = "hora_inicio" AND iuo_grupo_servicios.ie_grupos_paquetes = 1 THEN  
//	
//		MESSAGEBOX("Aviso", "El día no existe en el paquete seleccionado")  
//		RETURN 2 	
//	
//	IF dw_grupos_paquetes.FIND("cve_materia = " + STRING(ll_materia) + " AND hora_inicio = " + TRIM(data) , 0, dw_grupos_paquetes.ROWCOUNT() + 1) <= 0 THEN  
//		MESSAGEBOX("Aviso", "El día no existe en el paquete seleccionado")  
//		RETURN 2 
//	END IF		
	
//ELSEIF dwo.name = "hora_final" AND iuo_grupo_servicios.ie_grupos_paquetes = 1 THEN   
//	
//	MESSAGEBOX("Aviso", "El día no existe en el paquete seleccionado")  
//	RETURN 2 	
//	
//	IF dw_grupos_paquetes.FIND("cve_materia = " + STRING(ll_materia) + " AND hora_fin = " + TRIM(data) , 0, dw_grupos_paquetes.ROWCOUNT() + 1) <= 0 THEN  
//		MESSAGEBOX("Aviso", "El día no existe en el paquete seleccionado")  
//		RETURN 2 
//	END IF			
	
END IF 

IF dwo.name = "clase_aula" THEN 
	
	// Se verifica si el aula seleccionda es diferente a "OTRO" y si la modalidad es a "DISTANCIA" 
	IF data <> "3"  THEN 
		INTEGER le_modadlidad 
		le_modadlidad = dw_grupo.GETITEMNUMBER(1, "grupos_modalidad") 
		IF le_modadlidad = 2 THEN 
			MESSAGEBOX("Aviso", "Un de modalidad 'DISTANCIA' solo puede ser clase aula 'OTRO'. ")  
			THIS.settext('') 
			RETURN 2 			
		END IF 
	END IF 	
	
	IF THIS.GETITEMNUMBER(row, "clase_aula") <> LONG(data) THEN 
		THIS.SETITEM(row, "comentario", "") 
	END IF
	
	POSTEVENT("ue_tipo_aula")  
	RETURN 0 
END IF

// Se permite modificar el salón sin modificar ninguna otra cosa 
IF dwo.name = "cve_salon" THEN 
	
	ib_modifica_salon = TRUE
	
	//Post 	
	
	RETURN 0 	
END IF  	


POST wf_valida_sesiones() 

POSTEVENT("ue_valida_horario") 



 
 
 
 
 
 
end event

type gb_1 from groupbox within w_grupos_impartidos_bloque
integer x = 55
integer y = 1872
integer width = 5728
integer height = 448
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type pb_borra_horario from picturebutton within w_grupos_impartidos_bloque
integer x = 3328
integer y = 1156
integer width = 110
integer height = 96
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;INTEGER le_row 

le_row = dw_horario.GETROW()

IF le_row > 0 THEN dw_horario.DELETEROW(le_row) 

dw_horario.TRIGGEREVENT("ue_valida_horario") 


ib_modificado = TRUE

end event

type gb_horario from groupbox within w_grupos_impartidos_bloque
integer x = 78
integer y = 1032
integer width = 5650
integer height = 724
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

type dw_grupo from datawindow within w_grupos_impartidos_bloque
event ue_habilita ( )
event actualiza ( )
event nuevo ( )
event ue_valida_fechas ( )
event ue_valida_asimilado ( )
event borra ( )
event consulta ( )
event ue_filtra_tipo_grupo ( )
integer x = 27
integer y = 220
integer width = 3035
integer height = 836
integer taborder = 10
string title = "none"
string dataobject = "d_grupos_bloques"
boolean border = false
boolean livescroll = true
end type

event ue_habilita();
wf_habilita() 




end event

event actualiza();
dw_grupo.ACCEPTTEXT() 
dw_horario.ACCEPTTEXT() 
dw_profesor.ACCEPTTEXT()  
dw_sesiones.ACCEPTTEXT()  

/****************************************************/
INTEGER le_existe_otro 
INTEGER le_existe_clase 
INTEGER le_modalidad 

le_modalidad = THIS.GETITEMNUMBER(1, "grupos_modalidad") 

le_existe_otro = dw_horario.FIND("clase_aula = 3", 0, dw_horario.ROWCOUNT() + 1)
le_existe_clase = dw_horario.FIND("clase_aula <> 3", 0, dw_horario.ROWCOUNT() + 1) 

// Se es modalidad presencial, ningún horario puede se clase aula OTRO 
IF le_modalidad = 1 AND le_existe_otro > 0 THEN 
	MESSAGEBOX("Aviso", "Un grupo de modalidad 'Presencial', no puede tener clase aula 'OTRO' ")	   
	RETURN  		
END IF 

// Se es modalidad HIBRIDA, NO todos los horarios son OTRO 
IF le_modalidad = 3 AND (le_existe_otro > 0 AND le_existe_clase = 0) THEN   	
	MESSAGEBOX("Aviso", "Un grupo debe tener clase aula 'OTRO' con algúna otra clase para poder ser de modalidad 'Híbrida'")	   
	RETURN 	
END IF 	
	

/****************************************************/


IF wf_habilita_multititular() < 0 THEN RETURN 

iuo_grupo_servicios.il_coordinacion = il_coordinacion 

// Si se trata de un grupo mudular se asignan las fechas máxima y mínima del horario asignadoa los profesores.
IF dw_grupo.GETITEMNUMBER(1, "grupos_forma_imparte") = 2 THEN 
	wf_asigna_fechas_grupo_modular()
END IF 

// Se llama función de inicialización de valores 
wf_inicializa_servicio() 

// Se llaman funciones de validación de datos  
IF iuo_grupo_servicios.of_valida_datos( ) < 0 THEN
	MESSAGEBOX("Aviso",  "Error - " + iuo_grupo_servicios.is_error) 
	RETURN 
END IF 

// Se agrega validación del detalle de profesores.
IF iuo_grupo_servicios.of_valida_profesor() < 0 AND iuo_grupo_servicios.ie_tipo <> 2 THEN 
	MESSAGEBOX("Aviso",  "Error - " + iuo_grupo_servicios.is_error) 
	RETURN 	
END IF 	

// Si no es un grupo asimilado, porceden todas las validaciones.
IF iuo_grupo_servicios.ie_requiere_horario = 1 THEN 

	IF iuo_grupo_servicios.of_valida_horario(iuo_grupo_servicios.ids_horario ) < 0 THEN 
		RETURN 
	END IF

	// Se llama función de conteo de horas reales de profesor 
	wf_inicializa_horario_prof()  



//////********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI 
//////********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI 
	// Se valida que se hayan cubierto todas las horas del bloque.
	// SE VERIFICA SI SE TRATA DE UN GRUPO SESIONADO
	IF iuo_grupo_servicios.is_sesionado = "N" THEN  
		IF iuo_grupo_servicios.of_valida_covertura_horario_profesor() < 0  THEN
			MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
			RETURN 
		END IF 
	// SI SE TRATA DE UN GRUPO SESIONADO	 
	ELSE
		IF iuo_grupo_servicios.of_valida_horario_prof_sesion() < 0 THEN 
			MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
			RETURN 			
		END IF 	
	END IF 	
//////********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI 
//////********AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI AQUI 	
	
	
	// Se  hace validación de derecho y uso
	/*ELIMINADO EL 12/11/2019*/	
//	iuo_grupo_servicios.of_genera_derecho_uso_bloques(il_coordinacion) 
//	// Se llama función de validación de derecho y uso 
//	IF iuo_grupo_servicios.of_calcula_derecho_uso_modular(1) < 0 THEN  
//		MESSAGEBOX("ERROR", iuo_grupo_servicios.is_error) 
//		RETURN  
//	END IF
	/*ELIMINADO EL 12/11/2019*/
	
//	// Se llaman funciones de validación de datos  
//	IF iuo_grupo_servicios.of_valida_datos( ) < 0 THEN
//		MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
//		RETURN 
//	END IF 
	
	LONG ll_cve_prof
	INTEGER le_pos 
	LONG ll_cve_mat
	STRING ls_gpo 
	
	ll_cve_mat = dw_grupo.GETITEMNUMBER(1, "cve_mat")
	ls_gpo = dw_grupo.GETITEMSTRING(1, "gpo")
	
	/*SE ELIMINA CUALQUIER DETALLE BASURA QUE QUEDE DE HORARIO DE PROFESORES ANTERIORES*/
	STRING ls_prof, ls_coma
	// Se llama función de validación de Cruce de Horario de Profesor.
	FOR le_pos = 1 TO dw_profesor.ROWCOUNT() 
		ll_cve_prof = dw_profesor.GETITEMNUMBER(le_pos, "cve_profesor")  
		IF ISNULL(ll_cve_prof) THEN ll_cve_prof = 0 
		ls_prof = ls_prof + ls_coma + STRING(ll_cve_prof) 
		ls_coma = ", " 
	NEXT 	
	ids_horario_profesor.SETFILTER("cve_profesor NOT IN( " + ls_prof + ")")   
	ids_horario_profesor.FILTER() 
	ids_horario_profesor.rowsdiscard(1, ids_horario_profesor.ROWCOUNT(), PRIMARY!) 
	ids_horario_profesor.SETFILTER("")  
	ids_horario_profesor.FILTER() 		
	
	
	
	
	
	/**/
	
	// SE VERIFICA SI SE VALIDA DOBLE PRESENCIA DEL PROFESOR 
	IF iuo_grupo_servicios.ie_doble_presencia = 1 THEN 
	
		// Se valida que el profesor no sobrepase las horas permitidas.
		IF wf_valida_horas_profesor() < 0 THEN RETURN 
		
		// Se llama función de validación de Cruce de Horario de Profesor.
		FOR le_pos = 1 TO ids_horario_profesor.ROWCOUNT() 
			ll_cve_prof = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_profesor")  
			//IF ll_cve_prof = 1 THEN CONTINUE  
			IF iuo_profesor_servicios.of_valida_horario_profesor(ll_cve_prof,ii_periodo, ii_anio, ll_cve_mat, ls_gpo) < 0 THEN  
				MESSAGEBOX("Aviso",  iuo_profesor_servicios.is_error) 
				RETURN 	
			END IF 
		NEXT 
		
//		// Se llama función de actualización de DERECHO y USO tradicional 
//		IF iuo_grupo_servicios.of_afecta_sdu_tradicional() < 0 THEN 
//			ROLLBACK USING itr_sce;
//			RETURN 	
//		END IF 
		
//		IF iuo_grupo_servicios.of_actualiza_derecho_uso_bloques() < 0 THEN 
//			ROLLBACK USING itr_sce;
//			MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error) 
//			RETURN 
//		END IF 

	// FIN VALIDA DOBLE PRESENCIA
	END IF



ELSE
	
	// VALIDACIÓN SOLO DE DATOS PRINCIPALES PARA GRUPOS ASIMILADOS 
	// Se llaman funciones de validación de datos  
	IF iuo_grupo_servicios.of_valida_datos( ) < 0 THEN
		MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
		RETURN 
	END IF 

END IF

// Se llama función de actualización de DERECHO y USO tradicional 
IF iuo_grupo_servicios.of_afecta_sdu_tradicional() < 0 THEN 
	ROLLBACK USING itr_sce;
	RETURN 	
END IF 


// Se llama servicio de actualizacion de grupos.
IF iuo_grupo_servicios.of_actualiza() < 0 THEN 
	ROLLBACK USING itr_sce;
	MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error) 
	RETURN 
END IF 



// Se llama función de validación de horario.
//iuo_grupo_servicios.of_valida_horario(lds_horario)  
// Se llama función de actualización del detalle de horario 
//iuo_grupo_servicios.of_inserta_horario()




COMMIT USING itr_sce;
MESSAGEBOX("Aviso", "El grupo fue guardado con éxito.")  

ib_modificado = FALSE 

RETURN 



















//
//dw_grupo.ACCEPTTEXT() 
//
//
//iuo_grupo_servicios.il_coordinacion = il_coordinacion 
//
//// Se llama función de inicialización de valores 
//wf_inicializa_servicio() 
//
//// Si no es un grupo asimilado, porceden todas las validaciones.
//IF iuo_grupo_servicios.ie_tipo <> 2 THEN 
//
//	// Se llaman funciones de validación de datos  
//	IF iuo_grupo_servicios.of_valida_datos( ) < 0 THEN
//		MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
//		RETURN 
//	END IF 
//
//	IF iuo_grupo_servicios.of_valida_horario(iuo_grupo_servicios.ids_horario ) < 0 THEN 
//		RETURN 
//	END IF
//
//	// Se llama función de conteo de horas reales de profesor 
//	wf_inicializa_horario_prof()  
//
//	// Se valida que se hayan cubierto todas las horas del bloque.
//	IF iuo_grupo_servicios.of_valida_covertura_horario_profesor() < 0  THEN
//		MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
//		RETURN 
//	END IF 
//	
//	// Se  hace validación de derecho y uso
//	iuo_grupo_servicios.of_genera_derecho_uso_bloques(il_coordinacion) 
//	// Se llama función de validación de derecho y uso 
//	IF iuo_grupo_servicios.of_calcula_derecho_uso_modular(1) < 0 THEN  
//		MESSAGEBOX("ERROR", iuo_grupo_servicios.is_error) 
//		RETURN  
//	END IF
//	
////	// Se llaman funciones de validación de datos  
////	IF iuo_grupo_servicios.of_valida_datos( ) < 0 THEN
////		MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
////		RETURN 
////	END IF 
//	
//	LONG ll_cve_prof
//	INTEGER le_pos 
//	LONG ll_cve_mat
//	STRING ls_gpo 
//	
//	ll_cve_mat = dw_grupo.GETITEMNUMBER(1, "cve_mat")
//	ls_gpo = dw_grupo.GETITEMSTRING(1, "gpo")
//	
//	// Se valida que el profesor no sobrepase las horas permitidas.
//	wf_valida_horas_profesor() 
//	
//	// Se llama función de validación de Cruce de Horario de Profesor.
//	FOR le_pos = 1 TO ids_horario_profesor.ROWCOUNT() 
//		ll_cve_prof = ids_horario_profesor.GETITEMNUMBER(le_pos, "cve_profesor")  
//		IF iuo_profesor_servicios.of_valida_horario_profesor(ll_cve_prof,ii_periodo, ii_anio, ll_cve_mat, ls_gpo) < 0 THEN  
//			MESSAGEBOX("Aviso",  iuo_profesor_servicios.is_error) 
//			RETURN 	
//		END IF 
//	NEXT 
//	
//	// Se llama función de actualización de DERECHO y USO tradicional 
//	IF iuo_grupo_servicios.of_afecta_sdu_tradicional() < 0 THEN 
//		RETURN 	
//	END IF 
//	
//	IF iuo_grupo_servicios.of_actualiza_derecho_uso_bloques() < 0 THEN 
//		ROLLBACK USING itr_sce;
//		MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error) 
//		RETURN 
//	END IF 
//
//ELSE
//	
//	// VALIDACIÓN SOLO DE DATOS PRINCIPALES PARA GRUPOS ASIMILADOS 
//	// Se llaman funciones de validación de datos  
//	IF iuo_grupo_servicios.of_valida_datos( ) < 0 THEN
//		MESSAGEBOX("Aviso",  iuo_grupo_servicios.is_error) 
//		RETURN 
//	END IF 
//
//END IF
//
//// Se llama servicio de actualizacion de grupos.
//IF iuo_grupo_servicios.of_actualiza() < 0 THEN 
//	ROLLBACK USING itr_sce;
//	MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error) 
//	RETURN 
//END IF 
//
//
//
//// Se llama función de validación de horario.
////iuo_grupo_servicios.of_valida_horario(lds_horario)  
//// Se llama función de actualización del detalle de horario 
////iuo_grupo_servicios.of_inserta_horario()
//
//
//COMMIT USING itr_sce;
//MESSAGEBOX("Aviso", "El grupo fue guardado con éxito.")  
//
//
//RETURN 
//
//
//
end event

event nuevo();f_obten_periodo(ii_periodo, ii_anio, 4)
//PARENT.TRIGGEREVENT("ue_nuevo")  
wf_cambia_periodo_trabajo(ie_cambia_periodo) 






end event

event ue_valida_fechas();DATETIME ldt_inicio
DATETIME ldt_fin		

//ldt_inicio = dw_grupo.GETITEMDATETIME(1, "grupos_fecha_inicio") 
//IF ISNULL(ldt_inicio) THEN RETURN 
//ldt_fin	 = dw_grupo.GETITEMDATETIME(1, "grupos_fecha_fin") 
//IF ISNULL(ldt_fin) THEN RETURN  

//wf_valida_horario_horas(0)

dw_horario.TRIGGEREVENT("ue_valida_horario") 

 RETURN  
 
 
 
 
 
 
end event

event ue_valida_asimilado();INTEGER le_tipo , le_pos, le_row_ins
LONG ll_cve_asimilada
STRING ls_gpo_asimilado
LONG ll_cve_null
STRING ls_gpo_null

LONG 	ll_cve_profesor
INTEGER	le_titularidad
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin
INTEGER le_horas_totales = 0

INTEGER le_cve_dia	
STRING ls_cve_salon	
INTEGER le_hora_inicio	
INTEGER le_hora_final	
INTEGER le_clase_aula 
INTEGER le_forma_imparte 
INTEGER le_requiere_horario
STRING ls_evalua

SETNULL(ll_cve_null)
SETNULL(ls_gpo_null) 

le_tipo  = THIS.GETITEMNUMBER(1, "grupos_tipo") 
IF ISNULL(le_tipo) THEN le_tipo = 0 
le_forma_imparte = THIS.GETITEMNUMBER(1, "grupos_forma_imparte") 
IF ISNULL(le_tipo) THEN le_tipo = -1 
IF le_tipo <> 2 THEN 
	
	SELECT requiere_horario
	INTO :le_requiere_horario
	FROM tipo_grupo 
	WHERE tipo = :le_tipo
	USING gtr_sce;  
	IF itr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar la información del tipo de grupo: " + itr_sce.SQLERRTEXT) 
		RETURN 
	END IF 	
	
	SETNULL(ll_cve_asimilada) 
	SETNULL(ls_gpo_asimilado)
	
	THIS.SETITEM(1, "grupos_cve_asimilada", ll_cve_asimilada)  
	THIS.SETITEM(1, "grupos_gpo_asimilado", ls_gpo_asimilado)  
	
	THIS.MODIFY("grupos_cve_asimilada.PROTECT = 1")  
	THIS.MODIFY("grupos_gpo_asimilado.PROTECT = 1") 
	THIS.MODIFY("grupos_idioma.PROTECT = 0")  
	IF le_forma_imparte = 2 THEN 
		IF ib_permite_modulares THEN THIS.MODIFY("grupos_forma_imparte.PROTECT = 0")  
//		THIS.MODIFY("grupos_fecha_inicio.PROTECT = 0")  
		//THIS.MODIFY("grupos_fecha_fin.PROTECT = 0")  
//		THIS.MODIFY("grupos_horas_reales.PROTECT = 0")  
	ELSE	
		IF ib_permite_modulares THEN THIS.MODIFY("grupos_forma_imparte.PROTECT = 0")  
//		THIS.MODIFY("grupos_fecha_inicio.PROTECT = 1")  
		//THIS.MODIFY("grupos_fecha_fin.PROTECT = 1")  		 
//		THIS.MODIFY("grupos_horas_reales.PROTECT = 1")  
	END IF 
	
	THIS.Modify("grupos_cve_asimilada.Background.Color = '67108864'")
	THIS.Modify("grupos_gpo_asimilado.Background.Color = '67108864'")	
	THIS.Modify("grupos_idioma.Background.Color = '1073741824'") 	
	IF le_forma_imparte = 2 THEN 
		IF ib_permite_modulares THEN THIS.Modify("grupos_forma_imparte.Background.Color = '1073741824'") 	
//		THIS.Modify("grupos_fecha_inicio.Background.Color = '1073741824'") 	
		//THIS.Modify("grupos_fecha_fin.Background.Color = '1073741824'") 				
//		THIS.Modify("grupos_horas_reales.Background.Color = '1073741824'") 				
	ELSE
		IF ib_permite_modulares THEN THIS.Modify("grupos_forma_imparte.Background.Color = '1073741824'") 	
//		THIS.Modify("grupos_fecha_inicio.Background.Color = '67108864'") 	
		//THIS.Modify("grupos_fecha_fin.Background.Color = '67108864'") 						
//		THIS.Modify("grupos_horas_reales.Background.Color = '67108864'") 				
	END IF
	
	INTEGER valor , le_row
	
	//IF ie_modo = 1 THEN 
	// Si no se trata de un grupo que se depliega
	IF NOT ib_carga THEN 
		
		
		dw_horario.RESET()
		
		IF ie_modo_opera = 2 THEN 
			SETNULL(valor) 
		ELSE
			valor = 0
		END IF		
		
		// Si requiere horario se inserta un renglón por default
		IF le_requiere_horario = 1 THEN 
			le_row = dw_horario.INSERTROW(0)
			dw_horario.SETITEM(le_row, "clase_aula", valor) 
		END IF 	
		
		// Si no tiene horario, se lim pia el detalle de profesores y horaruio de profesores. 
		IF le_requiere_horario = 0 THEN 
			dw_profesor.RESET()
			dw_profesor.INSERTROW(0)
			dw_profesor.SETITEM(1, "titularidad", 1)		
			
			ids_horario_profesor.RESET() 
		END IF 
		
	END IF
	
	wf_habilita()
	
	RETURN 
	
ELSE	
	
	THIS.MODIFY("grupos_cve_asimilada.PROTECT = 0")  
	THIS.MODIFY("grupos_gpo_asimilado.PROTECT = 0")	
	THIS.MODIFY("grupos_idioma.PROTECT = 1")  
	THIS.MODIFY("grupos_forma_imparte.PROTECT = 1")  
//	THIS.MODIFY("grupos_fecha_inicio.PROTECT = 1")  
	THIS.MODIFY("grupos_cupo.PROTECT = 1")  
	THIS.Modify("grupos_modalidad.PROTECT = 1")  
//	THIS.MODIFY("grupos_fecha_fin.PROTECT = 1")  	
	
	THIS.Modify("grupos_cve_asimilada.Background.Color = '1073741824'") 
	THIS.Modify("grupos_gpo_asimilado.Background.Color = '1073741824'") 	
	THIS.Modify("grupos_idioma.Background.Color = '67108864'")	
	THIS.Modify("grupos_forma_imparte.Background.Color = '67108864'")	
//	THIS.Modify("grupos_fecha_inicio.Background.Color = '67108864'")	
	THIS.Modify("grupos_cupo.Background.Color = '67108864'")	
	THIS.Modify("grupos_modalidad.Background.Color = '67108864'")	
//	THIS.Modify("grupos_fecha_fin.Background.Color = '67108864'")	
	PARENT.dp_inicio.ENABLED = FALSE
	PARENT.dp_fin.ENABLED = FALSE  
	
	//wf_habilita()
	
END IF
	
ll_cve_asimilada  = THIS.GETITEMNUMBER(1, "grupos_cve_asimilada") 
ls_gpo_asimilado  = THIS.GETITEMSTRING(1, "grupos_gpo_asimilado") 

wf_recupera_materia_asimila() 

IF ISNULL(ll_cve_asimilada) THEN ll_cve_asimilada = 0 
IF ISNULL(ls_gpo_asimilado) THEN ls_gpo_asimilado = "" 
IF ll_cve_asimilada = 0 OR  ls_gpo_asimilado = ""  THEN RETURN  

// Se crea instancia local de servicios de grupos para cargar la información del grupo asimilado.
uo_grupo_servicios luo_grupo_servicios 
luo_grupo_servicios = CREATE uo_grupo_servicios 
luo_grupo_servicios.itr_sce = itr_sce 
luo_grupo_servicios.of_inicializa_parametros( )

luo_grupo_servicios.il_cve_mat = ll_cve_asimilada
luo_grupo_servicios.is_gpo = ls_gpo_asimilado
luo_grupo_servicios.ie_periodo = ii_periodo 
luo_grupo_servicios.ie_anio = ii_anio 
	
IF luo_grupo_servicios.of_valida_grupo( ll_cve_asimilada, ls_gpo_asimilado) = 0 THEN 
	MESSAGEBOX("Aviso", "El grupo seleccionado no existe")  
	THIS.SETITEM(1, "grupos_cve_asimilada", ll_cve_null) 
	THIS.SETITEM(1, "grupos_gpo_asimilado", ls_gpo_null) 	
	RETURN 	
END IF 	
	
IF luo_grupo_servicios.of_carga_grupo() < 0 THEN 
	MESSAGEBOX("Aviso", luo_grupo_servicios.is_error ) 
	RETURN 
END IF

// SI no se ha especificado el idioma se asigna por default ESPAÑOL
IF ISNULL(luo_grupo_servicios.il_idioma) THEN luo_grupo_servicios.il_idioma = 1
THIS.SETITEM(1, "grupos_idioma", luo_grupo_servicios.il_idioma)
THIS.SETITEM(1, "grupos_forma_imparte", luo_grupo_servicios.ie_forma_imparte)
THIS.SETITEM(1, "grupos_fecha_inicio", luo_grupo_servicios.idt_fecha_inicio)
THIS.SETITEM(1, "grupos_fecha_fin", luo_grupo_servicios.idt_fecha_fin)
THIS.SETITEM(1, "grupos_cupo", luo_grupo_servicios.ie_cupo)
THIS.SETITEM(1, "grupos_modalidad", luo_grupo_servicios.ie_modalidad) 

// Se despliega el detalle de Horario.
dw_horario.RESET() 
// Se pasa el detalle de horarios.
FOR le_pos = 1 TO luo_grupo_servicios.ids_horario.ROWCOUNT() 
	
	le_cve_dia = luo_grupo_servicios.ids_horario.GETITEMNUMBER(le_pos, "cve_dia")	
	ls_cve_salon = luo_grupo_servicios.ids_horario.GETITEMSTRING(le_pos, "cve_salon")	
	le_hora_inicio = luo_grupo_servicios.ids_horario.GETITEMNUMBER(le_pos, "hora_inicio")	
	le_hora_final = luo_grupo_servicios.ids_horario.GETITEMNUMBER(le_pos, "hora_final")	
	le_clase_aula = luo_grupo_servicios.ids_horario.GETITEMNUMBER(le_pos, "clase_aula")
	
	// Se inicializa el Horario del Profesor para validación.  
	le_row_ins = dw_horario.INSERTROW(0)
	dw_horario.SETITEM(le_row_ins, "cve_dia", le_cve_dia) 	
	dw_horario.SETITEM(le_row_ins, "cve_salon", ls_cve_salon) 
	dw_horario.SETITEM(le_row_ins, "hora_inicio", le_hora_inicio) 	 
	dw_horario.SETITEM(le_row_ins, "hora_final", le_hora_final) 	 
	dw_horario.SETITEM(le_row_ins, "clase_aula", le_clase_aula)   	
	
NEXT 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Se despliegan Profesores asociados. 
INTEGER le_num_profesores
DATASTORE ldw_profesor
ldw_profesor = CREATE DATASTORE 
ldw_profesor.DATAOBJECT = dw_profesor.DATAOBJECT 
ldw_profesor.SETTRANSOBJECT(itr_sce) 
//le_num_profesores = ldw_profesor.RETRIEVE(iuo_grupo_servicios.il_cve_mat, iuo_grupo_servicios.is_gpo, iuo_grupo_servicios.ie_periodo, iuo_grupo_servicios.ie_anio) 
le_num_profesores = ldw_profesor.RETRIEVE(ll_cve_asimilada, ls_gpo_asimilado, ii_periodo , ii_anio ) 
IF le_num_profesores > 1 THEN 
	cbx_multitular.CHECKED = TRUE 
	is_multititular = 'S' 
END IF	

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////

// Se despliegan Profesores asociados. 
dw_profesor.RESET() 
// Se pasa el detalle de profesores.
//FOR le_pos = 1 TO luo_grupo_servicios.ids_profesor.ROWCOUNT() 
FOR le_pos = 1 TO ldw_profesor.ROWCOUNT()  
	
//	ll_cve_profesor = luo_grupo_servicios.ids_profesor.GETITEMNUMBER(le_pos, "cve_profesor")	
//	le_titularidad = luo_grupo_servicios.ids_profesor.GETITEMNUMBER(le_pos, "titularidad")	
//	ldt_fecha_inicio = luo_grupo_servicios.ids_profesor.GETITEMDATETIME(le_pos, "fecha_inicio")	
//	ldt_fecha_fin = luo_grupo_servicios.ids_profesor.GETITEMDATETIME(le_pos, "fecha_fin")	    

	ll_cve_profesor = ldw_profesor.GETITEMNUMBER(le_pos, "cve_profesor")	
	le_titularidad = ldw_profesor.GETITEMNUMBER(le_pos, "titularidad")	
	ldt_fecha_inicio = ldw_profesor.GETITEMDATETIME(le_pos, "fecha_inicio")	
	ldt_fecha_fin = ldw_profesor.GETITEMDATETIME(le_pos, "fecha_fin")	    	
	le_horas_totales = 0 
	ls_evalua = dw_profesor.GETITEMSTRING(le_pos, "profesor_cotitular_evalua")
	

	le_row_ins = dw_profesor.INSERTROW(0) 
	dw_profesor.SETITEM(le_row_ins, "cve_profesor", ll_cve_profesor) 
	dw_profesor.SETITEM(le_row_ins, "titularidad", le_titularidad)	
	dw_profesor.SETITEM(le_row_ins, "fecha_inicio", ldt_fecha_inicio)	
	dw_profesor.SETITEM(le_row_ins, "fecha_fin", ldt_fecha_fin)	  
	dw_profesor.SETITEM(le_row_ins, "horas_profesor", le_horas_totales)
	dw_profesor.SETITEM(le_row_ins, "profesor_cotitular_evalua", ls_evalua)
	
	wf_recupera_profesor(le_row_ins, ll_cve_profesor) 
	
NEXT 

ids_horario_profesor.RESET() 

INTEGER le_copia 
LONG ll_cve_mat_act 
STRING ls_gpo

ll_cve_mat_act = THIS.GETITEMNUMBER(1, "cve_mat") 
ls_gpo = THIS.GETITEMSTRING(1, "gpo") 


le_copia = luo_grupo_servicios.ids_horario_profesor.ROWSCOPY(1, luo_grupo_servicios.ids_horario_profesor.ROWCOUNT(), PRIMARY!, ids_horario_profesor, 1, PRIMARY! ) 

// Se cambia la materia y el grupo.
FOR le_pos = 1 TO ids_horario_profesor.ROWCOUNT()  
	
	ids_horario_profesor.SETITEM(le_pos, "cve_mat", ll_cve_mat_act) 
	ids_horario_profesor.SETITEM(le_pos, "gpo", ls_gpo) 
	
NEXT 


// Se carga el detalle de sesiones
dw_sesiones.RESET() 
luo_grupo_servicios.ids_grupos_bloques.ROWSCOPY(1, luo_grupo_servicios.ids_grupos_bloques.ROWCOUNT(), PRIMARY!, dw_sesiones, dw_sesiones.ROWCOUNT() + 1, PRIMARY!)



//**//
//INTEGER le_pos 
//INTEGER le_row

dw_sesiones_detalle.RESET() 
// Se inicializa el detalle de SESIONES DE GRUPOS. 
FOR le_pos = 1 TO luo_grupo_servicios.ids_grupo_sesion.ROWCOUNT()   
	
	le_row = dw_sesiones_detalle.INSERTROW(0)  
	
	dw_sesiones_detalle.SETITEM(le_row, "cve_mat", luo_grupo_servicios.il_cve_mat)
	dw_sesiones_detalle.SETITEM(le_row, "gpo", luo_grupo_servicios.is_gpo)
	dw_sesiones_detalle.SETITEM(le_row, "periodo", luo_grupo_servicios.ie_periodo) 
	dw_sesiones_detalle.SETITEM(le_row, "anio", luo_grupo_servicios.ie_anio)
	dw_sesiones_detalle.SETITEM(le_row, "cve_dia", luo_grupo_servicios.ids_grupo_sesion.GETITEMNUMBER(le_pos, "cve_dia"))
	dw_sesiones_detalle.SETITEM(le_row, "cve_salon", luo_grupo_servicios.ids_grupo_sesion.GETITEMSTRING(le_pos, "cve_salon"))
	dw_sesiones_detalle.SETITEM(le_row, "hora_inicio", luo_grupo_servicios.ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_inicio"))
	dw_sesiones_detalle.SETITEM(le_row, "hora_final", luo_grupo_servicios.ids_grupo_sesion.GETITEMNUMBER(le_pos, "hora_final"))
	dw_sesiones_detalle.SETITEM(le_row, "fecha_inicio", luo_grupo_servicios.ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_inicio"))
	dw_sesiones_detalle.SETITEM(le_row, "fecha_fin", luo_grupo_servicios.ids_grupo_sesion.GETITEMDATETIME(le_pos, "fecha_fin"))
	dw_sesiones_detalle.SETITEM(le_row, "horario_modular_orden", luo_grupo_servicios.ids_grupo_sesion.GETITEMNUMBER(le_pos, "horario_modular_orden")) 	

NEXT 

//luo_grupo_servicios.ids_grupo_sesion.ROWSCOPY(1, luo_grupo_servicios.ids_grupo_sesion.ROWCOUNT(), PRIMARY!, dw_sesiones_detalle, dw_sesiones_detalle.ROWCOUNT() + 1, PRIMARY!)

//**//

wf_habilita() 

// Se despliega el profesor Titular. 
wf_despliega_profesor_titular(0) 

RETURN 


















end event

event borra();
IF ie_modo_opera = 2 THEN 
	MESSAGEBOX("Aviso", "No es posible borrar grupos en la ventana de cambios.")
	RETURN 
END IF 	



IF MESSAGEBOX("Confirmación", "El grupo " + STRING(iuo_grupo_servicios.il_cve_mat) + " " + iuo_grupo_servicios.is_gpo + " será eliminado. ¿Desea continual?", Question!, OkCancel!) = 2 THEN RETURN 

// Se crea instancia local de servicios de grupos para cargar la información del grupo asimilado.
uo_grupo_servicios luo_grupo_servicios 
luo_grupo_servicios = CREATE uo_grupo_servicios 
luo_grupo_servicios.itr_sce = itr_sce 
luo_grupo_servicios.of_inicializa_parametros( )

luo_grupo_servicios.il_cve_mat = iuo_grupo_servicios.il_cve_mat 
luo_grupo_servicios.is_gpo = iuo_grupo_servicios.is_gpo 
luo_grupo_servicios.ie_periodo = iuo_grupo_servicios.ie_periodo 
luo_grupo_servicios.ie_anio = iuo_grupo_servicios.ie_anio  
luo_grupo_servicios.il_coordinacion = il_coordinacion 

IF luo_grupo_servicios.of_borra_grupo() = 0 THEN MESSAGEBOX("Aviso", "El grupo fue borrado con éxito.")










end event

event consulta();PARENT.TRIGGEREVENT("ue_nuevo") 



end event

event ue_filtra_tipo_grupo();
DATAWINDOWCHILD dwc_tipo_grupo
INTEGER le_forma_imparte
STRING ls_select  

le_forma_imparte = THIS.GETITEMNUMBER(1, "grupos_forma_imparte")  

THIS.GETCHILD("grupos_tipo", dwc_tipo_grupo)   

ls_select = "  SELECT tipo_grupo.tipo,   " + & 
		       "  tipo_grupo.nombre_tipo  " + & 
			   " FROM tipo_grupo " 
				
IF le_forma_imparte = 1 THEN 
	ls_select = ls_select + "  WHERE tipo_grupo.modular IN(1,0) "   
ELSE
	ls_select = ls_select + "  WHERE tipo_grupo.modular = 1  "   
END IF 

dwc_tipo_grupo.MODIFY("Datawindow.Table.Select = '" + ls_select + "'" ) 
dwc_tipo_grupo.SETTRANSOBJECT(itr_sce)  
dwc_tipo_grupo.RETRIEVE() 

dw_grupo.SETITEM(1, "grupos_tipo", 0)  





end event

event itemchanged;STRING ls_descripcion, ls_null
INTEGER le_resultado
LONG ll_cve_materia 
			INTEGER le_row, valor

SETNULL(ls_null)

ib_modificado = TRUE 

CHOOSE CASE dwo.name 
		
	CASE "materias_materia"	 
		post wf_habilita() 
		
	CASE "cve_mat" 
		
		IF ie_forma_imparte = 2 AND ie_paquete <> 0 THEN 
			
//			IF dw_grupos_paquetes.ROWCOUNT() = 0  THEN 
//				MESSAGEBOX("Aviso", "No se ha seleccionado un paquete de materias.")  
//				RETURN 2
//			END IF
//			
//			IF dw_grupos_paquetes.FIND("cve_materia = " + TRIM(data), 0, dw_grupos_paquetes.ROWCOUNT() + 1) <= 0 THEN 
//				MESSAGEBOX("Aviso", "La materia seleccionada no existe en el paquete seleccionado") 
//				RETURN 2 
//			END IF
		END IF 
		
		// Se valida que la materia pertenezca a la coordinación. 
		IF NOT(f_materia_valida(LONG(data), il_coordinacion)) then
			MessageBox("Materia Inexistente", "La materia "+string(data)+ " no existe registrada, o no pertenece a su coordinacion.",StopSign!)
			RETURN 2 
		END IF
		
		// Se verifica si la materia permite grupos sesionados. 
		ib_permite_modulares = wf_valida_aplica_sesionado(LONG(data)) 		
		
		// Si se modifica la materia, se limpia el grupo 
		le_resultado = iuo_materias_servicios.of_recupera_materia(LONG(data), ls_descripcion)  
		IF le_resultado < 0 THEN RETURN 2  
		THIS.SETITEM(1, "materias_materia", ls_descripcion) 
		THIS.SETITEM(1, "gpo", ls_null) 
		
		THIS.MODIFY("cve_mat.PROTECT = 1")
		THIS.Modify("cve_mat.Background.Color = '67108864'")		
		THIS.Modify("b_buscar.Visible = 0")		
		
		POST wf_carga_horas_permitidas() 
		iuo_grupo_servicios.of_carga_valida_exepciones(LONG(data)) 
		
		//Habilita la seguridad para la ventana actual
		POST wf_aplica_seguridad()
		
	CASE "gpo"	 
		
		ll_cve_materia = THIS.GETITEMNUMBER(1, "cve_mat") 	
		IF ISNULL(ll_cve_materia) THEN ll_cve_materia = 0  
		IF ll_cve_materia = 0 THEN RETURN 1 
		
		IF NOT f_grupo_valido(data) THEN 
			MESSAGEBOX("Grupo Invalido","El grupo escrito no corresponde a una cadena valida.",StopSign!) 
			RETURN 2 
		END IF
		
		le_resultado = iuo_grupo_servicios.of_valida_grupo(ll_cve_materia, data) 
		
		IF le_resultado > 0 THEN 
			
			iuo_grupo_servicios.il_cve_mat  = ll_cve_materia
			iuo_grupo_servicios.is_gpo  =  data
			iuo_grupo_servicios.ie_periodo  =  ii_periodo 
			iuo_grupo_servicios.ie_anio  = ii_anio 
			
			IF iuo_grupo_servicios.of_carga_grupo( ) < 0 THEN 
				MESSAGEBOX("ERROR", iuo_grupo_servicios.is_error) 
				RETURN 2
			END IF

			st_estatus.TEXT = "Modificación Grupo: " + STRING(ll_cve_materia) 	+ " " + data 
			ie_modo = 2 

			POSTEVENT("ue_filtra_tipo_grupo") 
			POST wf_despliega_grupo() 
			
			
			//Habilita la seguridad para la ventana actual
			POST wf_aplica_seguridad()
			
		// Carga grupo 
		ELSE 
			// Nuevo grupo 
			st_estatus.TEXT = "Alta Grupo: " + STRING(ll_cve_materia) 	+ " " + data 
			ie_modo = 1
		END IF
		
		THIS.MODIFY("gpo.PROTECT = 1")
		THIS.Modify("gpo.Background.Color = '67108864'")				
		
		//dw_horario.TRIGGEREVENT("ue_valida_horario") 
	

	// Si se cambia la modalidad del grupo 
	CASE "grupos_modalidad"  
		
		INTEGER le_tipo_grupo_val
		le_tipo_grupo_val = THIS.GETITEMNUMBER(row, "grupos_tipo") 
				
		// Se valida que la midalidad es "En línea" 
		IF data = '4' THEN  
			
			// Si el grupo es de asesoria 			
			IF le_tipo_grupo_val = 1 THEN 
				MESSAGEBOX("Aviso", "Un grupo de asesorias no puede impartirse en Línea. ") 
				THIS.settext('') 
				RETURN 2 
			ELSEIF le_tipo_grupo_val <> 4  THEN 	
				MESSAGEBOX("Aviso", "La modalidad 'En línea' solo puede asignarse a grupos de tipo 'En Línea'. ") 
				THIS.settext('') 
				RETURN 2 				
			END IF 	
			
		// Se valida el horario con modalidad a DISTANCIA 	
		ELSEIF data = '2' THEN  
			// Si tiene algún registro con clase aula diferente de "OTRO" envía mensaje y rechaza el valor
			IF wf_valida_salon_en_linea() THEN 
				MESSAGEBOX("Aviso", "La modalidad a 'DISTANCIA' solo permite la clase aula 'OTRO' ") 
				THIS.settext('') 
				RETURN 2 								
			END IF 
		END IF 

	
	CASE "grupos_forma_imparte" 
		
		IF ie_forma_imparte <> INTEGER(data) THEN 
			
			// Si mofica la forma de impartición de "Modular" a "Tradicional" se elimina el detalle de sesiones y se reinicia el horario de profesores al horario default.  
			IF ie_forma_imparte = 2 AND data = "1" THEN 
				IF MessageBox("Cambio en Forma de Impartición", "Si realiza un cambio en la forma de Impartición de MODULAR a TRADICIONAL, deberá capturar nuevamente el Horario de Profesores y las sesiones del Grupo. ¿Desea Contrinuar?",Question!, YesNo!) = 2 THEN RETURN 2 				
			ELSE				
				IF MessageBox("Cambio en Forma de Impartición", "Si realiza un cambio en la forma de Impartición de TRADICIONAL a MODULAR, deberá capturar Horario de Profesores y las Sesiones (si las hay) del Grupo. ¿Desea Contrinuar?",Question!, YesNo!) = 2 THEN RETURN 2 				
			END IF 
	
//			dw_profesor.RESET()
//			dw_profesor.INSERTROW(0)
//			dw_profesor.SETITEM(1, "titularidad", 1)
//			dw_profesor.SETITEM(1, "profesor_cotitular_tipo_profesor", 0)
//			dw_profesor.SETITEM(1, "profesor_cotitular_autorizado", 0)
			ids_horario_profesor.RESET() 
			dw_sesiones_detalle.RESET() 
			dw_sesiones.RESET() 
			
			wf_inicia_fechas_feault() 
			
//			SETNULL(valor) 
//			dw_horario.RESET() 
//			le_row = dw_horario.INSERTROW(0)
//			IF ie_modo_opera = 2 THEN 
//				SETNULL(valor) 
//			ELSE
//				valor = 0
//			END IF					
//			dw_horario.SETITEM(le_row, "clase_aula", valor) 			
//			
//			st_horas_capturadas.TEXT = '0'
			
		END IF		
		
		
		ie_forma_imparte = INTEGER(data)
		
//		IF ie_forma_imparte = 1 AND dw_profesor.ROWCOUNT() > 1 THEN 
//			MESSAGEBOX("Aviso", "Un grupo tradicional no puede tener más de un  profesor.")	
//			RETURN 2
//		END IF
		
		POSTEVENT("ue_habilita")
		
		POSTEVENT("ue_valida_fechas") 
		
		POSTEVENT("ue_filtra_tipo_grupo") 
	
	CASE "grupos_fecha_inicio", "grupos_fecha_fin" 
										  
		//dw_horario.TRIGGEREVENT("ue_valida_horario") 
		POSTEVENT("ue_valida_fechas") 


	CASE "grupos_tipo", "grupos_cve_asimilada", "grupos_gpo_asimilado" 
		
		// Si se modifica el tipo 
		IF dwo.name = "grupos_tipo" THEN  
			// Si el grupo es de asesoria 
			IF data = '1' THEN 
				// Se valida que la midalidad no sea "En línea" 
				IF THIS.GETITEMNUMBER(row, "grupos_modalidad") = 4 THEN 
					MESSAGEBOX("Aviso", "Un grupo de asesorias no puede impartirse en Línea. ") 
					THIS.settext('') 
					RETURN 2 
				END IF 	
			//Si el grupo no es en línea 
			ELSEIF data <> '4' THEN 
				// Se valida que la midalidad no sea "En línea" 
				IF THIS.GETITEMNUMBER(row, "grupos_modalidad") = 4 THEN 
					MESSAGEBOX("Aviso", "Un grupo de Modalidad 'En Línea' solo puede ser de tipo 'En Línea'. ") 
					THIS.settext('') 
					RETURN 2 
				END IF 		
			END IF 
		END IF 	
		
		
		POSTEVENT("ue_valida_asimilado") 
		POST wf_filtra_clase_aula() 

	CASE "grupos_cve_asimilada", "grupos_gpo_asimilado"  

		wf_recupera_materia_asimila() 
		
//	CASE "grupos_horas_reales"	 
//		
//		IF st_horas_minimas.TEXT <> data THEN 
//			
//			IF MessageBox("Cambio en Horas Reales", "Si realiza un cambio en las Horas Totales del Grupo, deberá capturar nuevamente el Horario y los profesores. ¿Desea Contrinuar?",Question!, YesNo!) = 2 THEN RETURN 2 
//			
//			dw_profesor.RESET()
//			dw_profesor.INSERTROW(0)
//			dw_profesor.SETITEM(1, "titularidad", 1)
//			ids_horario_profesor.RESET() 
//
//			SETNULL(valor) 
//			dw_horario.RESET() 
//			le_row = dw_horario.INSERTROW(0)
//			IF ie_modo_opera = 2 THEN 
//				SETNULL(valor) 
//			ELSE
//				valor = 0
//			END IF					
//			dw_horario.SETITEM(le_row, "clase_aula", valor) 			
//			
//			st_horas_capturadas.TEXT = '0'
//			
//		END IF
//		
//		
////		grupos_horas_reales
//		st_horas_minimas.TEXT = data 
//		//dw_horario.TRIGGEREVENT("ue_valida_horario")
//		//POSTEVENT("ue_valida_fechas")
//		
		
	CASE ELSE	
		
		
END CHOOSE 

//THIS.MODIFY("grupos_modalidad = '0~tIf(grupos_tipo = 2,0,1)'")






end event

event constructor;m_grupos_impartidos_bloque.dw = this 
end event

event clicked;LONG ll_cve_materia
STRING ls_materia 
STRING ls_null
IF dwo.name = "b_buscar" THEN 
	
	OPENWITHPARM(w_busca_materia, il_coordinacion) 
	ll_cve_materia = MESSAGE.doubleparm 
	
	THIS.SETITEM(1, "cve_mat", ll_cve_materia)   
	iuo_materias_servicios.of_recupera_materia( ll_cve_materia, ls_materia) 
	THIS.SETITEM(1, "materias_materia", ls_materia)     
	
	IF ll_cve_materia > 0 THEN 
		wf_carga_horas_permitidas()
	ELSE
		RETURN 0 
	END IF
	
	ib_modificado = TRUE
	
	THIS.MODIFY("cve_mat.PROTECT = 1")
	THIS.Modify("cve_mat.Background.Color = '67108864'")		
	THIS.Modify("b_buscar.Visible = 0")	
	
ELSEIF dwo.name = "b_buscar_asimilada" THEN  
	
	OPENWITHPARM(w_busca_materia, il_coordinacion) 
	ll_cve_materia = MESSAGE.doubleparm 
	
	THIS.SETITEM(1, "grupos_cve_asimilada", ll_cve_materia)   
	wf_recupera_materia_asimila() 
	SETNULL(ls_null)
	THIS.SETITEM(1, "grupos_gpo_asimilado", ls_null)	 
	
	ib_modificado = TRUE
	
END IF 



end event

type cbx_multitular from checkbox within w_grupos_impartidos_bloque
integer x = 5390
integer y = 1956
integer width = 352
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Multititular"
boolean checked = true
end type

event clicked;IF THIS.CHECKED THEN 
	is_multititular = 'S' 
ELSE
	is_multititular = 'N'
END IF

wf_habilita_multititular() 


end event

