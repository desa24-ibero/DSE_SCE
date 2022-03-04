$PBExportHeader$uo_periodo_servicios.sru
forward
global type uo_periodo_servicios from nonvisualobject
end type
end forward

global type uo_periodo_servicios from nonvisualobject
end type
global uo_periodo_servicios uo_periodo_servicios

type variables
DATASTORE ids_periodos

DATASTORE ids_tipo_periodos

DATASTORE ids_periodos_activos



//INTEGER id_periodo
//STRING descripcion

INTEGER ierror
STRING imensaje, ititulo = "Error"

INTEGER ie_periodo_activo_tipo
INTEGER ie_anio_activo_tipo
end variables

forward prototypes
public function integer f_modifica_lista_columna (ref datawindow adw_datawindow, string as_nombre_columna, string as_tipo_descripcion)
public function string f_recupera_descripcion (integer ai_id_periodo, string as_tipo_descripcion)
public function integer f_recupera_id (string as_descripcion, string as_tipo_descripcion)
public function string f_genera_cadena_opciones (string as_tipo_descripcion)
public function integer f_recupera_posgrado (integer ai_id_periodo)
public function integer f_carga_periodos (string as_tipo_periodo, string as_case_descripciones, transaction atr_sce)
public function integer f_carga_periodos (string as_tipo_periodo, transaction atr_sce)
public function integer f_recupera_periodo_anterior (ref integer ai_periodo, ref integer ai_anio, transaction atr_sce)
public function string f_genera_cadena_decodifica (string as_tipo_descripcion)
public function integer f_modifica_decodificacion (datawindow adw_datawindow, string as_nombre_campo, string as_tipo_descripcion, string as_campo_base)
public function integer f_carga_periodos_tipo (transaction atr_sce)
public function string f_recupera_descripcion_tipo (string as_id_tipo_periodo)
public function integer f_carga_periodos_activos (transaction atr_sce)
public function integer f_carga_periodo_activo (ref integer ai_periodo, ref integer ai_anio, string as_tipo_periodo, transaction trans)
public function integer f_carga_periodo_activo (ref integer ai_periodo, ref integer ai_anio, transaction trans)
public function integer f_recupera_periodo_siguiente (ref integer ai_periodo, ref integer ai_anio, transaction atr_sce)
public function string f_recupera_desc_periodo (transaction atr_app, long al_periodo)
public function string f_recupera_desc_corta_periodo (transaction atr_app, long al_periodo)
public function long f_recupera_id_periodo_x_desc (transaction atr_app, string as_descripcion)
public function string f_recupera_tipo_periodo (transaction atr_app, long al_periodo)
public function long f_recupera_id_periodo_x_desc_corta (transaction atr_app, string as_desc_corta)
end prototypes

public function integer f_modifica_lista_columna (ref datawindow adw_datawindow, string as_nombre_columna, string as_tipo_descripcion);
//INTEGER le_pos, ll_ttlrgs 
STRING ls_opciones 
// Función que modifica el listado de la columna en modo de edición ddlb solicitada.
// Argumentos: adw_datawindow: Datawindow que se modifica. Por referencia
// 					as_nombre_columna = Nombre de la columna que se modifica
//					as_tipo_descripcion = Tipo de Descripción que se desea. 'C' = Descripción Corta, 'L' = Descrpción Larga. 



INTEGER le_idperiodo
STRING ls_descripcion

//ll_ttlrgs = ids_periodos.ROWCOUNT() 

ls_opciones = f_genera_cadena_opciones(as_tipo_descripcion) 

// Se hace ciclo para insertar las opciones de los radiobuttons.
ls_opciones = TRIM(as_nombre_columna) + ".values='" + ls_opciones + "'" 
//FOR le_pos = 1 TO ll_ttlrgs 
//
//	le_idperiodo = ids_periodos.GETITEMNUMBER(le_pos, "periodo")
//	IF as_tipo_descripcion = "C" THEN 
//		ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion_corta")
//	ELSE
//		ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion")
//	END IF
//
//	IF le_pos > 1 THEN 
//		ls_opciones = ls_opciones + "/" 
//	END IF
//
//	ls_opciones = ls_opciones + ls_descripcion + "~t" + STRING(le_idperiodo)
//
//NEXT 

//ls_opciones = ls_opciones + "'" 

adw_datawindow.MODIFY(ls_opciones) 

RETURN 0 

end function

public function string f_recupera_descripcion (integer ai_id_periodo, string as_tipo_descripcion);
INTEGER le_pos
STRING ls_descripcion

ierror = 0
imensaje = "" 

// Se verifica que el periodo que se selecciona sea válido
le_pos = ids_periodos.FIND("periodo = " + string(ai_id_periodo), 0, ids_periodos.ROWCOUNT()) 

IF le_pos <= 0 THEN 
	ierror = -1
	imensaje = "El periodo seleccionado no está disponible para el tipo de periodo actual." 
	RETURN ls_descripcion
END IF

IF as_tipo_descripcion = "C" THEN 
	ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion_corta") 
ELSE
	ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion") 
END IF 

RETURN ls_descripcion


end function

public function integer f_recupera_id (string as_descripcion, string as_tipo_descripcion);INTEGER le_pos
INTEGER le_id

ierror = 0
imensaje = "" 

// Se elimina marca de periodo activo
IF POS(as_descripcion, '*') > 0 THEN as_descripcion = LEFT(as_descripcion, LEN(as_descripcion) - 1)


IF as_tipo_descripcion = "C" THEN 
	le_pos = ids_periodos.FIND("descripcion_corta = '" + string(as_descripcion) + "'", 0, ids_periodos.ROWCOUNT()) 
ELSE
	le_pos = ids_periodos.FIND("descripcion = '" + string(as_descripcion) + "'", 0, ids_periodos.ROWCOUNT()) 
END IF 

IF le_pos <= 0 THEN 
	ierror = -1
	imensaje = "El periodo seleccionado no está disponible para el tipo de periodo actual." 
	RETURN le_id
END IF

le_id = ids_periodos.GETITEMNUMBER(le_pos, "periodo") 


RETURN le_id

end function

public function string f_genera_cadena_opciones (string as_tipo_descripcion);
STRING ls_opciones 


INTEGER le_idperiodo
STRING ls_descripcion
INTEGER ll_ttlrgs 
INTEGER le_pos
INTEGER le_row


ll_ttlrgs = ids_periodos.ROWCOUNT() 

FOR le_pos = 1 TO ll_ttlrgs 

	le_idperiodo = ids_periodos.GETITEMNUMBER(le_pos, "periodo")
	IF as_tipo_descripcion = "C" THEN 
		ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion_corta")
	ELSE
		ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion")
	END IF

	// Se verifica si se trata del periodo activo para colocar marca en la descripción.
	IF le_idperiodo = ie_periodo_activo_tipo THEN ls_descripcion = ls_descripcion + "*"


	IF le_pos > 1 THEN 
		ls_opciones = ls_opciones + "/" 
	END IF

	ls_opciones = ls_opciones + ls_descripcion + "~t" + STRING(le_idperiodo)

NEXT 

RETURN ls_opciones






end function

public function integer f_recupera_posgrado (integer ai_id_periodo);
INTEGER le_pos
INTEGER le_posgrado

ierror = 0
imensaje = "" 

// Se verifica que el periodo que se selecciona sea válido
le_pos = ids_periodos.FIND("periodo = " + string(ai_id_periodo), 0, ids_periodos.ROWCOUNT()) 

IF le_pos <= 0 THEN 
	ierror = -1
	imensaje = "El periodo seleccionado no está disponible para el tipo de periodo actual." 
	RETURN 0
END IF


le_posgrado = ids_periodos.GETITEMNUMBER(le_pos, "posgrado") 


RETURN le_posgrado


end function

public function integer f_carga_periodos (string as_tipo_periodo, string as_case_descripciones, transaction atr_sce);
STRING ls_query 

IF ISNULL(as_case_descripciones) OR TRIM(as_case_descripciones) = "" THEN as_case_descripciones = "L" 

IF as_case_descripciones = "U" THEN 
	// Se define cadena de selección de los tipos de periodo solicitado.
	ls_query = "SELECT periodo, UPPER(descripcion), tipo, UPPER(descripcion_corta), posgrado FROM periodo WHERE tipo = ~~'" + as_tipo_periodo + "~~'" 	
ELSE
	// Se define cadena de selección de los tipos de periodo solicitado.
	ls_query = "SELECT periodo, descripcion, tipo, descripcion_corta, posgrado FROM periodo WHERE tipo = ~~'" + as_tipo_periodo + "~~'" 	
END IF

//dw_1.MODIFY("periodo.values('Primavera~t0/Verano~t1/Otoño~t2'")
ids_periodos = CREATE DATASTORE 
ids_periodos.DATAOBJECT = "dw_periodo_variante"
ids_periodos.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ids_periodos.SETTRANSOBJECT(atr_sce) 

IF ids_periodos.RETRIEVE() < 0 THEN 
	ierror = -1
	imensaje	= "Se produjo un error al recuperar los periodos."
END IF

// Se carga el periodo activo por tipo.
f_carga_periodo_activo(ie_periodo_activo_tipo, ie_anio_activo_tipo, as_tipo_periodo, atr_sce)


RETURN 0





end function

public function integer f_carga_periodos (string as_tipo_periodo, transaction atr_sce);
RETURN  f_carga_periodos(as_tipo_periodo, "L", atr_sce) 


end function

public function integer f_recupera_periodo_anterior (ref integer ai_periodo, ref integer ai_anio, transaction atr_sce);
INTEGER le_periodo_minimo
INTEGER le_periodo_maximo
INTEGER le_periodo 

// Se reupera el periodo mínimo y máximo del tipo de periodo

SELECT MIN(periodo), MAX(periodo)
INTO :le_periodo_minimo, :le_periodo_maximo 
FROM periodo
WHERE tipo = :gs_tipo_periodo
USING atr_sce;
// Se verifica un posible error
IF atr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar periodos: " + atr_sce.SQLERRTEXT)
	RETURN -1
END IF

IF ai_periodo = le_periodo_minimo THEN 
	ai_periodo = le_periodo_maximo 
	ai_anio = ai_anio - 1
ELSE
	
	SELECT MAX(periodo)
	INTO :le_periodo 
	FROM periodo
	WHERE tipo = :gs_tipo_periodo
	AND periodo < :ai_periodo
	USING atr_sce;
	IF atr_sce.SQLCODE < 0 OR ISNULL(le_periodo) THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar periodos: " + atr_sce.SQLERRTEXT)
		RETURN -1		
	END IF
	
	ai_periodo = le_periodo

END IF	


RETURN 0
end function

public function string f_genera_cadena_decodifica (string as_tipo_descripcion);STRING ls_opciones 

INTEGER le_idperiodo
STRING ls_descripcion
INTEGER ll_ttlrgs 
INTEGER le_pos

ll_ttlrgs = ids_periodos.ROWCOUNT() 

FOR le_pos = 1 TO ll_ttlrgs 

	le_idperiodo = ids_periodos.GETITEMNUMBER(le_pos, "periodo")
	IF as_tipo_descripcion = "C" THEN 
		ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion_corta")
	ELSE
		ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion")
	END IF

	ls_opciones = ls_opciones + " when " + STRING(le_idperiodo) + " then ~~'" + ls_descripcion + "~~' "

NEXT 

RETURN ls_opciones


end function

public function integer f_modifica_decodificacion (datawindow adw_datawindow, string as_nombre_campo, string as_tipo_descripcion, string as_campo_base);
STRING ls_expresion 
STRING ls_cadena_modifica
INTEGER le_pos
STRING ls_segmento
STRING ls_segmento2


// Se llama función de generación de cadena de modificación.
ls_cadena_modifica = f_genera_cadena_decodifica(as_tipo_descripcion)

ls_cadena_modifica = " case ( " + as_campo_base + " " + ls_cadena_modifica + " ) "


// Se toma la descripción del campo que se quiere modificar.
ls_expresion = adw_datawindow.DESCRIBE(as_nombre_campo  + ".expression") 

ls_expresion = LEFT(ls_expresion, LEN(ls_expresion) - 1)
ls_expresion = RIGHT(ls_expresion, LEN(ls_expresion) - 1)



le_pos = pos(ls_expresion, "&&&",1)

ls_segmento = MID(ls_expresion, 1, le_pos - 1)
ls_segmento2 = MID(ls_expresion, le_pos + 3, LEN(ls_expresion)) 


// Se eliminan las comillas dobres que agrega powerbuilder.
DO 
	le_pos = 0
	le_pos = pos(ls_segmento, '~~"',le_pos +1)
	IF le_pos > 0 THEN 
		ls_segmento = REPLACE(ls_segmento, le_pos, 2, '"')
	END IF
LOOP WHILE le_pos > 0 



// Se eliminan las comillas dobres que agrega powerbuilder.
DO 
	le_pos = 0
	le_pos = pos(ls_segmento2, '~~"',le_pos +1)
	IF le_pos > 0 THEN 
		ls_segmento2 = REPLACE(ls_segmento2, le_pos, 2, '"')
	END IF
LOOP WHILE le_pos > 0 

ls_expresion = ls_segmento + '" + ' + ls_cadena_modifica + ' + " ' + ls_segmento2 


STRING  ls_modifica
STRING ls_expresion_final

ls_expresion_final = as_nombre_campo  + ".expression = '" + ls_expresion + "'"
ls_modifica = adw_datawindow.MODIFY(ls_expresion_final)






RETURN 0 

 
 
 
 
 
end function

public function integer f_carga_periodos_tipo (transaction atr_sce);
STRING ls_sql

// Se carga el listado de tipo de periodo.
ids_tipo_periodos = CREATE DATASTORE 
ids_tipo_periodos.DATAOBJECT = "d_tipo_periodo_lista" 
ids_tipo_periodos.SETTRANSOBJECT(atr_sce)

ls_sql = " SELECT id_tipo, descripcion " + & 
			" FROM periodo_tipo " 

ids_tipo_periodos.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'")
ids_tipo_periodos.RETRIEVE()


RETURN 0 











end function

public function string f_recupera_descripcion_tipo (string as_id_tipo_periodo);
INTEGER le_pos
STRING ls_descripcion

ierror = 0
imensaje = "" 

// Se verifica que el periodo que se selecciona sea válido
le_pos = ids_tipo_periodos.FIND("id_tipo = '" + as_id_tipo_periodo + "'", 0, ids_tipo_periodos.ROWCOUNT()) 

IF le_pos <= 0 THEN 
	ierror = -1
	imensaje = "El tipo de periodo:" + as_id_tipo_periodo + " no está disponible." 
	RETURN ls_descripcion
END IF

ls_descripcion = ids_tipo_periodos.GETITEMSTRING(le_pos, "descripcion") 

RETURN ls_descripcion


end function

public function integer f_carga_periodos_activos (transaction atr_sce);
STRING ls_sql
LONG ll_ttl_rgs

ls_sql = "SELECT ppp.periodo,  p.tipo, ppp.anio, p.descripcion " + & 
			" FROM periodos_por_procesos ppp, periodo p " + & 
			" WHERE ppp.cve_proceso = 0 " + &   
			" AND ppp.periodo = p.periodo	"	
		
ids_periodos_activos = CREATE DATASTORE 
ids_periodos_activos.DATAOBJECT = "d_periodos_activos" 
ids_periodos_activos.SETTRANSOBJECT(atr_sce) 
ids_periodos_activos.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
ll_ttl_rgs = ids_periodos_activos.RETRIEVE() 
IF ll_ttl_rgs < 0 THEN 
	ierror = -1
	imensaje = " Se produjo un error al recuperar el listado de periodos activos."
	RETURN -1 
END IF 

RETURN 0 





end function

public function integer f_carga_periodo_activo (ref integer ai_periodo, ref integer ai_anio, string as_tipo_periodo, transaction trans);
// Función que recupera el periodo activo actual.
SELECT pp.periodo, pp.anio
INTO :ai_periodo, :ai_anio 
FROM periodos_por_procesos pp, periodo p
WHERE pp.cve_proceso = 0
AND pp.periodo = p.periodo
AND p.tipo = :as_tipo_periodo 
USING trans;
// Se verifica un posible error.
IF trans.SQLCODE < 0 THEN 
	ierror = -1
	imensaje	= trans.SQLERRTEXT
	RETURN -1	
END IF



RETURN 0

end function

public function integer f_carga_periodo_activo (ref integer ai_periodo, ref integer ai_anio, transaction trans);

RETURN f_carga_periodo_activo(ai_periodo, ai_anio, gs_tipo_periodo, trans)





end function

public function integer f_recupera_periodo_siguiente (ref integer ai_periodo, ref integer ai_anio, transaction atr_sce);

INTEGER le_periodo_maximo
INTEGER le_periodo_minimo

// Se reupera el periodo mínimo y máximo del tipo de periodo

SELECT MIN(periodo), MAX(periodo)
INTO :le_periodo_minimo, :le_periodo_maximo 
FROM periodo
WHERE tipo = :gs_tipo_periodo
USING atr_sce;
// Se verifica un posible error
IF atr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar periodos: " + atr_sce.SQLERRTEXT)
	RETURN -1
END IF

IF ai_periodo = le_periodo_maximo THEN 
	ai_periodo = le_periodo_minimo
	ai_anio = ai_anio + 1
ELSE
    ai_periodo = ai_periodo + 1
END IF	


RETURN 0



end function

public function string f_recupera_desc_periodo (transaction atr_app, long al_periodo);String ls_desc_periodo
String ls_nombre_funcion = "f_recupera_desc_periodo"

SELECT ISNULL(descripcion, "")
INTO :ls_desc_periodo
FROM periodo
WHERE periodo = :al_periodo
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	imensaje = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	ierror = -1
ELSE
	IF ls_desc_periodo = "" THEN
		imensaje = "La descripción obtenida de la función  " + ls_nombre_funcion + ", no es válida: vacío"
		ierror = -1
	END IF
END IF

RETURN ls_desc_periodo
end function

public function string f_recupera_desc_corta_periodo (transaction atr_app, long al_periodo);String ls_desc_corta_periodo
String ls_nombre_funcion = "f_recupera_desc_corta_periodo"

SELECT ISNULL(descripcion_corta, "")
INTO :ls_desc_corta_periodo
FROM periodo
WHERE periodo = :al_periodo
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	imensaje = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	ierror = -1
ELSE
	IF ls_desc_corta_periodo = "" THEN
		imensaje = "La descripción obtenida de la función  " + ls_nombre_funcion + ", no es válida: vacío"
		ierror = -1
	END IF
END IF

RETURN ls_desc_corta_periodo
end function

public function long f_recupera_id_periodo_x_desc (transaction atr_app, string as_descripcion);Long ll_periodo = -1
String ls_nombre_funcion = "f_recupera_id_periodo_x_desc"

as_descripcion = Lower(as_descripcion)

SELECT periodo
INTO :ll_periodo
FROM periodo
WHERE Lower(descripcion) = :as_descripcion
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	imensaje = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	ierror = -1
ELSE
	IF ll_periodo = -1 THEN
		imensaje = "El periodo obtenido de la función  " + ls_nombre_funcion + ", no es válido: " +  String(ll_periodo)
		ierror = -1
	END IF
END IF

RETURN ll_periodo
end function

public function string f_recupera_tipo_periodo (transaction atr_app, long al_periodo);String ls_tipo
String ls_nombre_funcion = "f_recupera_tipo_periodo"

SELECT ISNULL(tipo, "")
INTO :ls_tipo
FROM periodo
WHERE periodo = :al_periodo
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	imensaje = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	ierror = -1
ELSE
	IF ls_tipo = "" THEN
		imensaje = "El tipo obtenido de la función  " + ls_nombre_funcion + ", no es válido: vacío"
		ierror = -1
	END IF
END IF

RETURN ls_tipo
end function

public function long f_recupera_id_periodo_x_desc_corta (transaction atr_app, string as_desc_corta);Long ll_periodo = -1
String ls_nombre_funcion = "f_recupera_id_periodo_x_desc_corta"

as_desc_corta = Lower(as_desc_corta)

SELECT periodo
INTO :ll_periodo
FROM periodo
WHERE Lower(descripcion_corta) = :as_desc_corta
USING atr_app;
		
IF atr_app.sqlcode < 0  Then
	imensaje = "Error al consultar la función " + ls_nombre_funcion + ". " + atr_app.sqlErrText
	ierror = -1
ELSE
	IF ll_periodo = -1 THEN
		imensaje = "El periodo obtenido de la función  " + ls_nombre_funcion + ", no es válido: " +  String(ll_periodo)
		ierror = -1
	END IF
END IF

RETURN ll_periodo
end function

on uo_periodo_servicios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_periodo_servicios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

