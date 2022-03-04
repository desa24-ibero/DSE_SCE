$PBExportHeader$uo_periodo_variable_tipo.sru
forward
global type uo_periodo_variable_tipo from userobject
end type
type dw_tipo_periodos from datawindow within uo_periodo_variable_tipo
end type
end forward

global type uo_periodo_variable_tipo from userobject
integer width = 1029
integer height = 360
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
dw_tipo_periodos dw_tipo_periodos
end type
global uo_periodo_variable_tipo uo_periodo_variable_tipo

type variables

uo_periodo_servicios iuo_periodo_servicios

DATASTORE ids_periodos_disponibles

INTEGER ierror
STRING imensaje

INTEGER ii_periodos[] 

INTEGER ie_periodo_activo
STRING is_tipo_periodo_activo
STRING is_desc_periodo_activo

INTEGER ii_periodos_activos[]
STRING is_descripcion_tipos_periodos
STRING is_descripcion_periodos


end variables

forward prototypes
public function integer f_carga_datos_periodos (transaction atr_sce)
public function integer f_inicializa_servicio (transaction atr_sce)
public function string f_recupera_descripcion_periodos ()
end prototypes

public function integer f_carga_datos_periodos (transaction atr_sce);
// Función de generación de periodos 
INTEGER le_anio
INTEGER le_id_periodo
INTEGER le_pos, le_ttl_rgs
STRING ls_desc_tipo_periodo
STRING ls_desc_periodos
STRING ls_coma
STRING ls_tipo_periodo
STRING ls_descripcion, ls_periodos
	
// Se asigna el periodo global actual
iuo_periodo_servicios.f_carga_periodo_activo(ie_periodo_activo, le_anio, atr_sce)

// Se selecciona el periodo actual por omisión. 
is_tipo_periodo_activo = iuo_periodo_servicios.f_recupera_descripcion_tipo(gs_tipo_periodo)	

iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", atr_sce)
is_desc_periodo_activo = iuo_periodo_servicios.f_recupera_descripcion(ie_periodo_activo, "L")
	

// Se seleccionan los periodos activos
iuo_periodo_servicios.f_carga_periodos_activos(atr_sce)
le_ttl_rgs = iuo_periodo_servicios.ids_periodos_activos.ROWCOUNT() 
FOR le_pos = 1 TO le_ttl_rgs 
	le_id_periodo = iuo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "id_periodo") 
	ii_periodos_activos[le_pos] = le_id_periodo
	
	ls_tipo_periodo = iuo_periodo_servicios.ids_periodos_activos.GETITEMSTRING(le_pos, "tipo_periodo") 
	
	// Se selecciona el periodo actual por omisión. 
	ls_desc_tipo_periodo = iuo_periodo_servicios.f_recupera_descripcion_tipo(ls_tipo_periodo)			

	ls_desc_periodos = ls_desc_periodos + ls_coma + ls_desc_tipo_periodo
	
	iuo_periodo_servicios.f_carga_periodos( ls_tipo_periodo, "L", atr_sce)
	ls_descripcion = iuo_periodo_servicios.f_recupera_descripcion(le_id_periodo, "L")
	
	ls_periodos = ls_periodos + ls_coma + ls_descripcion
	
	ls_coma = ", "
	
NEXT
	
is_descripcion_periodos = ls_periodos
is_descripcion_tipos_periodos = ls_desc_periodos
	

RETURN 0 
end function

public function integer f_inicializa_servicio (transaction atr_sce);// Función de inicialización de objeto de selección de periodos.
// Argumentos: atr_sce = Transacción que se utiliza para la carga de periodos disponibles

STRING ls_periodo 
STRING ls_desc_tipo_periodo
INTEGER le_pos, le_ttl_rgs, le_row
STRING ls_tipo_periodo
STRING ls_opciones 

// Se carga el listado de tipos de periodo. 
iuo_periodo_servicios.f_carga_periodos_tipo(atr_sce) 

// Se inicializa el listado de opciones de filtrado.
ls_opciones =  "Periodo activo "  + "~t1/" + & 
					"Todos los Periodo activos ~t2/"
					
//// Se verifica si se agrega la opción de selección de periodos.
//IF as_selecciona_periodos = "S" THEN ls_opciones = ls_opciones + "Seleccionar Periodos ~t3"
 
ls_opciones = "tipo_periodo.values='" + ls_opciones + "'" 
le_row = dw_tipo_periodos.INSERTROW(0)
dw_tipo_periodos.MODIFY(ls_opciones) 
dw_tipo_periodos.Modify("tipo_periodo.Height='160'")	
dw_tipo_periodos.Modify("tipo_periodo.RadioButtons.Columns=1")
dw_tipo_periodos.SETITEM(le_row, "tipo_periodo", 1)  

f_carga_datos_periodos(atr_sce) 

dw_tipo_periodos.TRIGGEREVENT("cambia_filtrado")

RETURN 0







end function

public function string f_recupera_descripcion_periodos ();
STRING ls_descripcion 


ls_descripcion = dw_tipo_periodos.DESCRIBE("t_periodos.TEXT")


RETURN ls_descripcion 
end function

event constructor;
iuo_periodo_servicios = CREATE uo_periodo_servicios 



end event

on uo_periodo_variable_tipo.create
this.dw_tipo_periodos=create dw_tipo_periodos
this.Control[]={this.dw_tipo_periodos}
end on

on uo_periodo_variable_tipo.destroy
destroy(this.dw_tipo_periodos)
end on

type dw_tipo_periodos from datawindow within uo_periodo_variable_tipo
event type integer cambia_filtrado ( )
integer x = 18
integer y = 12
integer width = 1001
integer height = 352
integer taborder = 10
string title = "none"
string dataobject = "d_tipo_periodo_filtro"
boolean border = false
boolean livescroll = true
end type

event type integer cambia_filtrado();
// Función de generación de periodos 
INTEGER le_tipo_filtrado 
INTEGER le_anio
INTEGER le_id_periodo
INTEGER le_pos, le_ttl_rgs
INTEGER li_limpia[]
STRING ls_desc_tipo_periodo
STRING ls_desc_periodos
STRING ls_coma
STRING ls_tipo_periodo
STRING ls_descripcion, ls_periodos

le_tipo_filtrado = THIS.GETITEMNUMBER(1, "tipo_periodo") 

// Se reinicia el array de instancia.
ii_periodos[] = li_limpia[] 

IF le_tipo_filtrado = 1 THEN 
	
	dw_tipo_periodos.MODIFY("t_tipo_periodos.text = '" + is_tipo_periodo_activo + "'")
	dw_tipo_periodos.MODIFY("t_periodos.text = '" + is_desc_periodo_activo + "'")
	ii_periodos[1] = ie_periodo_activo
	
ELSEIF le_tipo_filtrado = 2 THEN 

	dw_tipo_periodos.MODIFY("t_tipo_periodos.text = '" + is_descripcion_tipos_periodos + "'")
	dw_tipo_periodos.MODIFY("t_periodos.text = '" + is_descripcion_periodos + "'")	
	ii_periodos[] = ii_periodos_activos[]

END IF


RETURN 0










//
//// Función de generación de periodos 
//INTEGER le_tipo_filtrado 
//INTEGER le_anio
//INTEGER le_id_periodo
//INTEGER le_pos, le_ttl_rgs
//INTEGER li_limpia[]
//STRING ls_desc_tipo_periodo
//STRING ls_desc_periodos
//STRING ls_coma
//STRING ls_tipo_periodo
//STRING ls_descripcion, ls_periodos
//
//le_tipo_filtrado = THIS.GETITEMNUMBER(1, "tipo_periodo") 
//
//// Se reinicia el array de instancia.
//ii_periodos[] = li_limpia[] 
//
//IF le_tipo_filtrado = 1 THEN 
//	
//	// Se asigna el periodo global actual
//	iuo_periodo_servicios.f_carga_periodo_activo(le_id_periodo, le_anio, itr_transaction)
//	ii_periodos[1] = le_id_periodo
//	
//	// Se selecciona el periodo actual por omisión. 
//	ls_desc_periodos = iuo_periodo_servicios.f_recupera_descripcion_tipo(gs_tipo_periodo)	
//	
//	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", itr_transaction)
//	ls_periodos = iuo_periodo_servicios.f_recupera_descripcion(le_id_periodo, "L")
//	
//ELSEIF le_tipo_filtrado = 2 THEN 
//	
//	// Se seleccionan los periodos activos
//	iuo_periodo_servicios.f_carga_periodos_activos(itr_transaction)
//	le_ttl_rgs = iuo_periodo_servicios.ids_periodos_activos.ROWCOUNT() 
//	FOR le_pos = 1 TO le_ttl_rgs 
//		le_id_periodo = iuo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "id_periodo") 
//		ii_periodos[le_pos] = le_id_periodo
//		
//		ls_tipo_periodo = iuo_periodo_servicios.ids_periodos_activos.GETITEMSTRING(le_pos, "tipo_periodo") 
//		
//		// Se selecciona el periodo actual por omisión. 
//		ls_desc_tipo_periodo = iuo_periodo_servicios.f_recupera_descripcion_tipo(ls_tipo_periodo)			
//
//		ls_desc_periodos = ls_desc_periodos + ls_coma + ls_desc_tipo_periodo
//		
//		iuo_periodo_servicios.f_carga_periodos( ls_tipo_periodo, "L", itr_transaction)
//		ls_descripcion = iuo_periodo_servicios.f_recupera_descripcion(le_id_periodo, "L")
//		
//		ls_periodos = ls_periodos + ls_coma + ls_descripcion
//		
//		ls_coma = ", "
//		
//	NEXT
//	
//// Verificar si este caso es necesario.	
////ELSEIF le_tipo_filtrado = 3 THEN 
//
//END IF
//
//dw_tipo_periodos.MODIFY("t_tipo_periodos.text = '" + ls_desc_periodos + "'")
//dw_tipo_periodos.MODIFY("t_periodos.text = '" + ls_periodos + "'")
//
//
//RETURN 0
//
//
//
end event

event itemchanged; THIS.POSTEVENT("cambia_filtrado")
end event

