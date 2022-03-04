$PBExportHeader$uo_periodo_variable.sru
forward
global type uo_periodo_variable from userobject
end type
type dw_periodos from datawindow within uo_periodo_variable
end type
end forward

global type uo_periodo_variable from userobject
integer width = 448
integer height = 304
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_cambia_seleccion ( )
dw_periodos dw_periodos
end type
global uo_periodo_variable uo_periodo_variable

type variables

//DATASTORE ids_periodos
INTEGER id_periodo
STRING descripcion
STRING descripcion_corta

STRING is_tipo_periodo

INTEGER ierror
STRING imensaje

uo_periodo_servicios iuo_periodo_servicios

STRING is_solo_default 

INTEGER ie_periodo_activo

STRING is_color
end variables

forward prototypes
public function integer f_selecciona_periodo (integer periodo, string as_tipo_descripcion)
public function integer f_recupera_periodo (ref integer aid_periodo, ref string adescripcion, string as_tipo_descripcion)
public function integer f_recupera_periodo (ref integer aid_periodo, ref string adescripcion)
public function boolean f_genera_periodo (string as_tipo_periodo, string as_orientacion, transaction atr_sce)
public function boolean f_genera_periodo (string as_tipo_periodo, string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, string as_solo_default, transaction atr_sce)
public subroutine f_cambia_color (string as_color)
public subroutine f_cambia_color ()
end prototypes

event ue_cambia_seleccion();// Ejecuta código 


end event

public function integer f_selecciona_periodo (integer periodo, string as_tipo_descripcion);INTEGER le_pos

ierror = 0
imensaje = "" 

iuo_periodo_servicios.f_recupera_descripcion(periodo, as_tipo_descripcion)
IF iuo_periodo_servicios.ierror < 0 THEN 
	ierror = -1
	imensaje = "El periodo seleccionado no está disponible para el tipo de periodo actual." 
	RETURN -1 	
	
END IF 

// Se inserta el id periodo en el dw de selacción.
dw_periodos.setitem(1, "periodo", periodo)
dw_periodos.TRIGGEREVENT("ue_selecciona_periodo")

RETURN 0









//INTEGER le_pos
//
//ierror = 0
//imensaje = "" 
//
//// Se verifica que el periodo que se selecciona sea válido
//le_pos = iuo_periodo_servicios.ids_periodos.FIND("periodo = " + string(periodo), 0, iuo_periodo_servicios.ids_periodos.ROWCOUNT()) 
//
//IF le_pos <= 0 THEN 
//	id_periodo = -1
//	descripcion = ""
//	ierror = -1
//	imensaje = "El periodo seleccionado no está disponible para el tipo de periodo actual." 
//	RETURN -1 
//END IF
//
//
//// Se inserta el id periodo en el dw de selacción.
//dw_periodos.setitem(1, "periodo", periodo)
//dw_periodos.TRIGGEREVENT("ue_selecciona_periodo")
//
//RETURN 0
//
//
//
//
//
//
//
end function

public function integer f_recupera_periodo (ref integer aid_periodo, ref string adescripcion, string as_tipo_descripcion);
// Función que recupera el periodo seleccionado.
IF id_periodo = -1 OR ISNULL(id_periodo) OR ierror = -1 THEN 
	ierror = -1
	imensaje = "No se ha seleccionado ningún periodo." 
	RETURN -1	
END IF 

aid_periodo = id_periodo 
IF as_tipo_descripcion = "L" THEN 
	adescripcion = descripcion
ELSE
	adescripcion = descripcion_corta
END IF

RETURN 0
end function

public function integer f_recupera_periodo (ref integer aid_periodo, ref string adescripcion);

RETURN f_recupera_periodo(aid_periodo, adescripcion, "L") 



//INTEGER le_periodo
//STRING ls_descripcion
//
//le_periodo = aid_periodo
//ls_descripcion = adescripcion
//
//f_recupera_periodo(le_periodo, ls_descripcion, "L") 
//
//
//aid_periodo = le_periodo
//adescripcion = ls_descripcion
//
//RETURN 0

 
end function

public function boolean f_genera_periodo (string as_tipo_periodo, string as_orientacion, transaction atr_sce);
RETURN f_genera_periodo(as_tipo_periodo, as_orientacion, "L", "L", "N", atr_sce)
end function

public function boolean f_genera_periodo (string as_tipo_periodo, string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, string as_solo_default, transaction atr_sce);STRING ls_query


is_solo_default = as_solo_default

is_tipo_periodo = as_tipo_periodo
iuo_periodo_servicios.f_carga_periodos(as_tipo_periodo, as_case_descripciones, atr_sce)
id_periodo = -1
IF iuo_periodo_servicios.ierror < 0 THEN 
	ierror = iuo_periodo_servicios.ierror 
	imensaje = iuo_periodo_servicios.imensaje
	RETURN FALSE
END IF 

dw_periodos.RESET() 
dw_periodos.insertrow(0) 

iuo_periodo_servicios.f_modifica_lista_columna(dw_periodos, "periodo", as_tipo_descripcion)

IF as_orientacion = "V" THEN 
	dw_periodos.Modify("periodo.Height='" + STRING(80 * iuo_periodo_servicios.ids_periodos.ROWCOUNT()) + "'")	
	dw_periodos.Modify("periodo.RadioButtons.Columns=1")
ELSE
	dw_periodos.Modify("periodo.Width='" + STRING(412 * iuo_periodo_servicios.ids_periodos.ROWCOUNT()) + "'")	
	dw_periodos.Modify("periodo.RadioButtons.Columns=" + STRING(iuo_periodo_servicios.ids_periodos.ROWCOUNT()))
END IF 

//dw_periodos.TRIGGEREVENT("ue_selecciona_periodo")


// Se ajusta el tamaño y posición de el dw.
INTEGER li_Height 
INTEGER li_Width 

IF as_orientacion = "V" THEN 
	li_Height = 80 * iuo_periodo_servicios.ids_periodos.ROWCOUNT() 
	li_Width = 400
ELSE
	li_Height = 80
	li_Width = 412 * iuo_periodo_servicios.ids_periodos.ROWCOUNT() 
END IF

dw_periodos.Height = li_Height
dw_periodos.Width = li_Width

THIS.Height = dw_periodos.Height + 5
THIS.Width = dw_periodos.Width + 5

f_cambia_color()

RETURN TRUE 






//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////


//STRING ls_query
//
//
//
//// Se define cadena de selección de los tipos de periodo solicitado.
//ls_query = "SELECT periodo, descripcion, tipo FROM periodo2 WHERE tipo = ~~'" + as_tipo_periodo + "~~'" 	
//
////dw_1.MODIFY("periodo.values('Primavera~t0/Verano~t1/Otoño~t2'")
//ids_periodos = CREATE DATASTORE 
//ids_periodos.DATAOBJECT = "dw_periodo_variante"
//
//
//ids_periodos.MODIFY("Datawindow.Table.Select = '" + ls_query + "'") 
//ids_periodos.SETTRANSOBJECT(gtr_sce) 
//
//ids_periodos.RETRIEVE() 
//
//INTEGER le_pos, ll_ttlrgs 
//STRING ls_opciones 
//INTEGER le_idperiodo
//STRING ls_descripcion
//
//ll_ttlrgs = ids_periodos.ROWCOUNT() 
//
//// Se hace ciclo para insertar las opciones de los radiobuttons.
//ls_opciones = "periodo.values='"
//FOR le_pos = 1 TO ll_ttlrgs 
//
//	le_idperiodo = ids_periodos.GETITEMNUMBER(le_pos, "periodo")
//	ls_descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion")
//
//	IF le_pos > 1 THEN 
//		ls_opciones = ls_opciones + "/" 
//	END IF
//
//	ls_opciones = ls_opciones + ls_descripcion + "~t" + STRING(le_idperiodo)
//
//NEXT 
//
//ls_opciones = ls_opciones + "'" 
//
//dw_periodos.insertrow(0) 
//////dw_2.MODIFY("periodo.values='Primavera~t0/Verano~t1/Otoño~t2'")
//dw_periodos.MODIFY(ls_opciones) 
//
//dw_periodos.TRIGGEREVENT("ue_selecciona_periodo")
//
//RETURN TRUE 



end function

public subroutine f_cambia_color (string as_color);
// Modifica el BackColor de los DW.
IF TRIM(is_color) = "" THEN is_color = as_color

f_cambia_color()

//RETURN 

end subroutine

public subroutine f_cambia_color ();
STRING ls_modify
 
ls_modify = dw_periodos.MODIFY("periodo.Background.Color = '" + is_color + "'") 



end subroutine

on uo_periodo_variable.create
this.dw_periodos=create dw_periodos
this.Control[]={this.dw_periodos}
end on

on uo_periodo_variable.destroy
destroy(this.dw_periodos)
end on

event constructor;
iuo_periodo_servicios = CREATE uo_periodo_servicios










end event

type dw_periodos from datawindow within uo_periodo_variable
event ue_selecciona_periodo ( )
integer width = 416
integer height = 276
integer taborder = 10
string title = "none"
string dataobject = "dw_periodo_variante"
boolean border = false
boolean livescroll = true
end type

event ue_selecciona_periodo();
INTEGER le_periodo
STRING ls_periodo
INTEGER le_pos 

// Si existe un error termina la función.
//IF ierror = -1 THEN RETURN 

// Se inicializan datos del periodo seleccionado.
id_periodo = -1 
descripcion = "" 
// Se encienden banderas de error para indicar que no se ha seleccionado ningún periodo.
ierror = 0
imensaje = "" 	

le_periodo = dw_periodos.GETITEMNUMBER(1, "periodo") 
IF ISNULL(le_periodo) THEN 
	ierror = -1 
	imensaje = "No se ha seleccionado ningún periodo." 	
	RETURN 	
END IF 
	
descripcion = iuo_periodo_servicios.f_recupera_descripcion(le_periodo, "L")
descripcion_corta = iuo_periodo_servicios.f_recupera_descripcion(le_periodo, "C")

IF iuo_periodo_servicios.ierror = 0 THEN 
	id_periodo = le_periodo
	ierror = 0
	imensaje = "" 	
END IF


//le_pos = ids_periodos.FIND("periodo = " + string(le_periodo), 0, ids_periodos.ROWCOUNT()) 
//
//IF le_pos > 0 THEN 
//	id_periodo = ids_periodos.GETITEMNUMBER(le_pos, "periodo") 
//	descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion") 
//	ierror = 0
//	imensaje = "" 
//END IF


PARENT.EVENT ue_cambia_seleccion() 

RETURN 		
	
	







//
//INTEGER le_periodo
//STRING ls_periodo
//INTEGER le_pos 
//
//// Se inicializan datos del periodo seleccionado.
//id_periodo = -1 
//descripcion = "" 
//// Se encienden banderas de error para indicar que no se ha seleccionado ningún periodo.
//ierror = -1 
//imensaje = "No se ha seleccionado ningún periodo." 
//
//le_periodo = dw_periodos.GETITEMNUMBER(1, "periodo") 
//IF ISNULL(le_periodo) THEN 
//	RETURN 	
//END IF 
//	
//le_pos = ids_periodos.FIND("periodo = " + string(le_periodo), 0, ids_periodos.ROWCOUNT()) 
//
//IF le_pos > 0 THEN 
//	id_periodo = ids_periodos.GETITEMNUMBER(le_pos, "periodo") 
//	descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion") 
//	ierror = 0
//	imensaje = "" 
//END IF
//
//RETURN 		
//	
//	
//
end event

event itemchanged;

IF NOT ISNULL(THIS.GETITEMNUMBER(1, "periodo")) THEN 
	IF 	is_solo_default = "S" THEN 
		IF INTEGER(data) <> ie_periodo_activo THEN 
			MESSAGEBOX("Aviso", "El periodo seleccionado no es el periodo activo.")
			RETURN 2
		END IF
	END IF
ELSE 
	IF 	is_solo_default = "S" THEN 
		IF INTEGER(data) <> ie_periodo_activo THEN 
			MESSAGEBOX("Aviso", "El periodo seleccionado no es el periodo activo.")
			RETURN 2
		END IF
	END IF
END IF



this.postevent("ue_selecciona_periodo") 






end event

