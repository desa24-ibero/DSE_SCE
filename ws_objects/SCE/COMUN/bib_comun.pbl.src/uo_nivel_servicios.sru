$PBExportHeader$uo_nivel_servicios.sru
forward
global type uo_nivel_servicios from nonvisualobject
end type
end forward

global type uo_nivel_servicios from nonvisualobject
end type
global uo_nivel_servicios uo_nivel_servicios

type variables
DATASTORE ids_niveles


//INTEGER id_periodo
//STRING descripcion

INTEGER ierror
STRING imensaje

INTEGER ie_periodo_activo_tipo
INTEGER ie_anio_activo_tipo 


BOOLEAN ib_todos 
BOOLEAN ib_seleccionados 



end variables

forward prototypes
public function integer f_modifica_lista_columna (ref datawindow adw_datawindow, string as_nombre_columna, string as_tipo_descripcion)
public function integer f_recupera_id (string as_descripcion, string as_tipo_descripcion)
public function string f_genera_cadena_opciones (string as_tipo_descripcion)
public function string f_genera_cadena_decodifica (string as_tipo_descripcion)
public function integer f_modifica_decodificacion (datawindow adw_datawindow, string as_nombre_campo, string as_tipo_descripcion, string as_campo_base)
public function integer f_carga_niveles (string as_case_descripciones, transaction atr_sce)
public function integer f_carga_niveles (transaction atr_sce)
public function string f_recupera_descripcion (string as_id_nivel, string as_tipo_descripcion)
end prototypes

public function integer f_modifica_lista_columna (ref datawindow adw_datawindow, string as_nombre_columna, string as_tipo_descripcion);

STRING ls_opciones 
// Función que modifica el listado de la columna en modo de edición ddlb solicitada.
// Argumentos: adw_datawindow: Datawindow que se modifica. Por referencia
// 					as_nombre_columna = Nombre de la columna que se modifica
//					as_tipo_descripcion = Tipo de Descripción que se desea. 'C' = Descripción Corta, 'L' = Descrpción Larga. 



INTEGER le_idperiodo
STRING ls_descripcion

ls_opciones = f_genera_cadena_opciones(as_tipo_descripcion) 

// Se hace ciclo para insertar las opciones de los radiobuttons.
ls_opciones = TRIM(as_nombre_columna) + ".values='" + ls_opciones + "'" 

adw_datawindow.MODIFY(ls_opciones) 

RETURN 0 





end function

public function integer f_recupera_id (string as_descripcion, string as_tipo_descripcion);INTEGER le_pos
INTEGER le_id

ierror = 0
imensaje = "" 

// Se elimina marca de periodo activo
IF POS(as_descripcion, '*') > 0 THEN as_descripcion = LEFT(as_descripcion, LEN(as_descripcion) - 1)


IF as_tipo_descripcion = "C" THEN 
	le_pos = ids_niveles.FIND("descripcion_corta = '" + string(as_descripcion) + "'", 0, ids_niveles.ROWCOUNT()) 
ELSE
	le_pos = ids_niveles.FIND("nivel = '" + string(as_descripcion) + "'", 0, ids_niveles.ROWCOUNT()) 
END IF 

IF le_pos <= 0 THEN 
	ierror = -1
	imensaje = "El nivel seleccionado no está disponible."  
	RETURN le_id
END IF

le_id = ids_niveles.GETITEMNUMBER(le_pos, "cve_nivel")  


RETURN le_id

end function

public function string f_genera_cadena_opciones (string as_tipo_descripcion);
STRING ls_opciones 


STRING ls_idperiodo
STRING ls_descripcion
INTEGER ll_ttlrgs 
INTEGER le_pos
INTEGER le_row


ll_ttlrgs = ids_niveles.ROWCOUNT() 

FOR le_pos = 1 TO ll_ttlrgs 

	ls_idperiodo = ids_niveles.GETITEMSTRING(le_pos, "cve_nivel")
	IF as_tipo_descripcion = "C" THEN 
		ls_descripcion = ids_niveles.GETITEMSTRING(le_pos, "desc_corta")
	ELSE
		ls_descripcion = ids_niveles.GETITEMSTRING(le_pos, "nivel")
	END IF

	IF le_pos > 1 THEN 
		ls_opciones = ls_opciones + "/" 
	END IF

	ls_opciones = ls_opciones + ls_descripcion + "~t" + STRING(ls_idperiodo) 

NEXT 


IF ib_todos THEN 
	ls_opciones = ls_opciones + "/Todos" + "~t" + "A" 
END IF
	
IF ib_seleccionados THEN 
	ls_opciones = ls_opciones + "/Seleccionados" + "~t" + "S" 
END IF



RETURN ls_opciones






end function

public function string f_genera_cadena_decodifica (string as_tipo_descripcion);STRING ls_opciones 

STRING ls_idnivel
STRING ls_descripcion
INTEGER ll_ttlrgs 
INTEGER le_pos

ll_ttlrgs = ids_niveles.ROWCOUNT() 

FOR le_pos = 1 TO ll_ttlrgs 

	ls_idnivel = ids_niveles.GETITEMSTRING(le_pos, "cve_nivel")
	IF as_tipo_descripcion = "C" THEN 
		ls_descripcion = ids_niveles.GETITEMSTRING(le_pos, "desc_corta")
	ELSE
		ls_descripcion = ids_niveles.GETITEMSTRING(le_pos, "nivel")
	END IF

	ls_opciones = ls_opciones + " when ~~'" + ls_idnivel + "~~' then ~~'" + ls_descripcion + "~~' "

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

public function integer f_carga_niveles (string as_case_descripciones, transaction atr_sce);
STRING ls_query 

IF ISNULL(as_case_descripciones) OR TRIM(as_case_descripciones) = "" THEN as_case_descripciones = "L" 

IF as_case_descripciones = "U" THEN 
	// Se define cadena de selección de los tipos de periodo solicitado.
	ls_query = "SELECT cve_nivel, UPPER(nivel), UPPER(desc_corta) FROM nivel "
ELSE
	// Se define cadena de selección de los tipos de periodo solicitado.
	ls_query = "SELECT cve_nivel, nivel, desc_corta FROM nivel" 
END IF

//dw_1.MODIFY("periodo.values('Primavera~t0/Verano~t1/Otoño~t2'")
ids_niveles = CREATE DATASTORE 
ids_niveles.DATAOBJECT = "dw_nivel_lista"
ids_niveles.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
ids_niveles.SETTRANSOBJECT(atr_sce) 

IF ids_niveles.RETRIEVE() < 0 THEN 
	ierror = -1
	imensaje	= "Se produjo un error al recuperar los periodos."
END IF




RETURN 0





end function

public function integer f_carga_niveles (transaction atr_sce);
RETURN  f_carga_niveles("L", atr_sce) 


end function

public function string f_recupera_descripcion (string as_id_nivel, string as_tipo_descripcion);
INTEGER le_pos
STRING ls_descripcion

ierror = 0
imensaje = "" 

// Se verifica que el periodo que se selecciona sea válido
le_pos = ids_niveles.FIND("cve_nivel = '" + string(as_id_nivel) + "'", 0, ids_niveles.ROWCOUNT()) 

IF le_pos <= 0 THEN 
	ierror = -1
	imensaje = "El periodo seleccionado no está disponible para el tipo de periodo actual." 
	RETURN ls_descripcion
END IF

IF as_tipo_descripcion = "C" THEN 
	ls_descripcion = ids_niveles.GETITEMSTRING(le_pos, "desc_corta") 
ELSE
	ls_descripcion = ids_niveles.GETITEMSTRING(le_pos, "nivel") 
END IF 

RETURN ls_descripcion


end function

on uo_nivel_servicios.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_nivel_servicios.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

