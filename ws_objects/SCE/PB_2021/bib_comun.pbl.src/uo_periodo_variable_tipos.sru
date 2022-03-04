$PBExportHeader$uo_periodo_variable_tipos.sru
$PBExportComments$Objeto con opciones para los diferentes tipos de periodos disponibles
forward
global type uo_periodo_variable_tipos from userobject
end type
type uo_trimestre from uo_periodo_variable within uo_periodo_variable_tipos
end type
type uo_semestre from uo_periodo_variable within uo_periodo_variable_tipos
end type
end forward

global type uo_periodo_variable_tipos from userobject
integer width = 919
integer height = 396
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_cambia_seleccion ( )
uo_trimestre uo_trimestre
uo_semestre uo_semestre
end type
global uo_periodo_variable_tipos uo_periodo_variable_tipos

type variables


str_periodos_seleccionados istr_periodos[] 


INTEGER ie_periodo_sem
INTEGER ie_periodo_trim

STRING is_solo_default


end variables

forward prototypes
public function integer of_recupera_periodos ()
public function integer of_inicializa_servicio (string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, string as_solo_default, n_tr atr_sce)
public subroutine f_cambia_color (string as_color)
end prototypes

event ue_cambia_seleccion();// Ejecuta código


end event

public function integer of_recupera_periodos ();Integer le_index, li_periodo, li_periodo2
Long ll_indice, ll_num_periodos
String ls_tipo_periodo, ls_desc_periodo, ls_periodo, ls_periodo2

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

str_periodos_seleccionados istr_periodos_limpia[] 

istr_periodos[] = istr_periodos_limpia[]

// Obtenemos el numero de tipos de periodos existentes en la tabla "periodo_tipo"
ll_num_periodos = luo_periodo_tipo_servicios.f_obten_num_periodos(gtr_sce)

IF luo_periodo_tipo_servicios.i_error = -1 THEN
	MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
	RETURN luo_periodo_tipo_servicios.i_error
END IF

FOR ll_indice = 1 TO ll_num_periodos
	ls_tipo_periodo = luo_periodo_tipo_servicios.f_obten_tipo_periodo(gtr_sce, ll_indice)	
	
	IF luo_periodo_tipo_servicios.i_error = -1 THEN
		MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
		RETURN luo_periodo_tipo_servicios.i_error
	END IF

	ls_desc_periodo = luo_periodo_tipo_servicios.f_obten_desc_periodo(gtr_sce, ls_tipo_periodo)			
	
	IF luo_periodo_tipo_servicios.i_error = -1 THEN
		MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
		RETURN luo_periodo_tipo_servicios.i_error
	END IF
	
	// Se inicializa el objeto de servicios de periodo.
	CHOOSE CASE ll_indice
		CASE 1
			uo_semestre.f_recupera_periodo(li_periodo, ls_periodo)

			IF uo_semestre.ierror < 0 AND gs_tipo_periodo = ls_tipo_periodo THEN 
				MessageBox("Error", uo_semestre.imensaje + " " + ls_desc_periodo + " ", StopSign!)
				RETURN -1 
			ELSE
				le_index = UPPERBOUND(istr_periodos[]) + 1
				istr_periodos[le_index].periodo = li_periodo
				istr_periodos[le_index].descripcion = ls_periodo
				istr_periodos[le_index].tipo = ls_tipo_periodo
			END IF
			
		CASE 2
			uo_trimestre.f_recupera_periodo(li_periodo2, ls_periodo2)
			
			IF uo_trimestre.ierror < 0 AND gs_tipo_periodo = ls_tipo_periodo THEN 
				MessageBox("Error", uo_trimestre.imensaje + " " + ls_desc_periodo + " ", StopSign!)
				RETURN -1 
			ELSE
				le_index = UPPERBOUND(istr_periodos[]) + 1
				istr_periodos[le_index].periodo = li_periodo2
				istr_periodos[le_index].descripcion = ls_periodo2
				istr_periodos[le_index].tipo = ls_tipo_periodo
			END IF
			
		CASE ELSE
			MessageBox("Alerta", " El tipo de periodo no ha sido defnido: " + ls_tipo_periodo, Exclamation!)
			RETURN -1 
	END CHOOSE 
NEXT 	

//uo_semestre.f_recupera_periodo(li_periodo, ls_periodo)
//IF uo_semestre.ierror < 0 THEN 
//	IF gs_tipo_periodo = "S" THEN 
//		MessageBox("Error", uo_semestre.imensaje + " Semestral ", StopSign!)
//		RETURN -1 
//	END IF
//ELSE
//	istr_periodos[1].periodo = li_periodo
//	istr_periodos[1].descripcion = ls_periodo
//	istr_periodos[1].tipo = "S" 
//END IF
//
//uo_trimestre.f_recupera_periodo(li_periodo2, ls_periodo2)
//IF uo_trimestre.ierror < 0 THEN 
//	IF gs_tipo_periodo = "T" THEN 
//		MessageBox("Error", uo_trimestre.imensaje + " Trimestral " , StopSign!)
//		RETURN -1 
//	END IF
//ELSE
//	le_index = UPPERBOUND(istr_periodos[]) + 1
//	istr_periodos[le_index].periodo = li_periodo2
//	istr_periodos[le_index].descripcion = ls_periodo2
//	istr_periodos[le_index].tipo = "T" 	
//END IF
end function

public function integer of_inicializa_servicio (string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, string as_solo_default, n_tr atr_sce);Long 		ll_indice, ll_num_periodos
String		ls_tipo_periodo

// Se cargan los diferentes tipos de periodo que están disponibles.
uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

// Se toma bandera de solo periodo default. 
is_solo_default = as_solo_default

// Obtenemos el numero de tipos de periodos existentes en la tabla "periodo_tipo"
ll_num_periodos = luo_periodo_tipo_servicios.f_obten_num_periodos(atr_sce)

IF luo_periodo_tipo_servicios.i_error = -1 THEN
	MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
	RETURN luo_periodo_tipo_servicios.i_error
END IF

FOR ll_indice = 1 TO ll_num_periodos
	ls_tipo_periodo = luo_periodo_tipo_servicios.f_obten_tipo_periodo(atr_sce, ll_indice)

	IF luo_periodo_tipo_servicios.i_error = -1 THEN
		MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
		RETURN luo_periodo_tipo_servicios.i_error
	END IF
	
	// Se inicializa el objeto de servicios de periodo.
	CHOOSE CASE ll_indice
		CASE 1
			THIS.uo_semestre.f_genera_periodo(ls_tipo_periodo, as_orientacion, as_tipo_descripcion, as_case_descripciones, is_solo_default, atr_sce)
		CASE 2
			THIS.uo_trimestre.f_genera_periodo(ls_tipo_periodo, as_orientacion, as_tipo_descripcion, as_case_descripciones, is_solo_default, atr_sce)
		CASE ELSE
			MessageBox("Alerta", " Solo es posible tener dos tipos de periodos. Por favor revisar la tabla periodo_tipo", Exclamation!)
			RETURN -1 
	END CHOOSE 
NEXT 

//**--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--**
// Se selecciona el periodo actual por omisión.
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios
luo_periodo_servicios.f_carga_periodos_activos(atr_sce)

INTEGER le_pos, le_ttl_rgs
INTEGER le_id_periodo, le_anio

le_ttl_rgs =  luo_periodo_servicios.ids_periodos_activos.ROWCOUNT() 

FOR le_pos = 1 TO le_ttl_rgs
	le_id_periodo = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "id_periodo") 
	le_anio = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "anio") 
	ls_tipo_periodo = luo_periodo_servicios.ids_periodos_activos.GETITEMSTRING(le_pos, "tipo_periodo") 

	IF le_pos = 1 THEN 
		THIS.uo_semestre.f_selecciona_periodo(le_id_periodo, "L")
		ie_periodo_sem = le_id_periodo
		THIS.uo_semestre.ie_periodo_activo = le_id_periodo
	ELSE
		THIS.uo_trimestre.f_selecciona_periodo(le_id_periodo, "L")
		ie_periodo_trim = le_id_periodo
		THIS.uo_trimestre.ie_periodo_activo = le_id_periodo 
	END IF
	
//	IF ls_tipo_periodo = "S" THEN 
//		IF gs_tipo_periodo = "S" THEN THIS.uo_semestre.f_selecciona_periodo(le_id_periodo, "L")
//		ie_periodo_sem = le_id_periodo
//		THIS.uo_semestre.ie_periodo_activo = le_id_periodo
//	ELSE
//		IF gs_tipo_periodo = "T" OR gs_tipo_periodo = "Q" THEN THIS.uo_trimestre.f_selecciona_periodo(le_id_periodo, "L")
//		ie_periodo_trim = le_id_periodo
//		THIS.uo_trimestre.ie_periodo_activo = le_id_periodo 
//	END IF

NEXT 

//**--****--****--****--****--****--****--****--****--****--****--**
//**--****--****--****--****--****--****--****--****--****--****--**

IF as_orientacion = "H" THEN 
	THIS.uo_semestre.HEIGHT = 85
	THIS.uo_trimestre.HEIGHT = 85
	THIS.uo_trimestre.X = 5
	THIS.uo_trimestre.Y = 90
END IF

// Se verifica si se permiten múltiples periodos.
IF gs_multiples_periodos = "N" THEN 
	IF gs_tipo_periodo = "T" THEN 
		THIS.uo_semestre.VISIBLE = FALSE
		IF as_orientacion = "H" THEN  
			THIS.uo_trimestre.Y = THIS.uo_semestre.Y
		ELSE
			THIS.uo_trimestre.X = THIS.uo_semestre.X
		END IF
	END IF
	IF gs_tipo_periodo = "S" THEN THIS.uo_trimestre.VISIBLE = FALSE
	IF as_orientacion = "V" THEN THIS.WIDTH = (THIS.WIDTH/2)
	IF as_orientacion = "H" THEN THIS.HEIGHT = (THIS.HEIGHT/2)
END IF

f_cambia_color(STRING(THIS.BackColor))

RETURN 0




end function

public subroutine f_cambia_color (string as_color);uo_semestre.f_cambia_color(as_color)
uo_trimestre.f_cambia_color(as_color)
end subroutine

on uo_periodo_variable_tipos.create
this.uo_trimestre=create uo_trimestre
this.uo_semestre=create uo_semestre
this.Control[]={this.uo_trimestre,&
this.uo_semestre}
end on

on uo_periodo_variable_tipos.destroy
destroy(this.uo_trimestre)
destroy(this.uo_semestre)
end on

type uo_trimestre from uo_periodo_variable within uo_periodo_variable_tipos
integer x = 466
integer y = 16
integer width = 434
integer height = 356
integer taborder = 30
boolean bringtotop = true
end type

on uo_trimestre.destroy
call uo_periodo_variable::destroy
end on

event ue_cambia_seleccion;call super::ue_cambia_seleccion;PARENT.of_recupera_periodos()
PARENT.TRIGGEREVENT("ue_cambia_seleccion")
end event

type uo_semestre from uo_periodo_variable within uo_periodo_variable_tipos
integer x = 18
integer y = 16
integer width = 421
integer height = 356
integer taborder = 20
boolean bringtotop = true
end type

on uo_semestre.destroy
call uo_periodo_variable::destroy
end on

event ue_cambia_seleccion;call super::ue_cambia_seleccion;PARENT.of_recupera_periodos()
PARENT.TRIGGEREVENT("ue_cambia_seleccion")
end event

