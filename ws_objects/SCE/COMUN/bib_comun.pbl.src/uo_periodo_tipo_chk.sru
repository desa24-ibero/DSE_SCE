$PBExportHeader$uo_periodo_tipo_chk.sru
forward
global type uo_periodo_tipo_chk from userobject
end type
type dw_periodos from datawindow within uo_periodo_tipo_chk
end type
end forward

global type uo_periodo_tipo_chk from userobject
integer width = 489
integer height = 260
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_cambia_seleccion ( )
dw_periodos dw_periodos
end type
global uo_periodo_tipo_chk uo_periodo_tipo_chk

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
public subroutine f_cambia_color (string as_color)
public subroutine f_cambia_color ()
public function any f_recupera_seleccion ()
public function boolean f_genera_periodo (transaction atr_sce)
end prototypes

event ue_cambia_seleccion();// Ejecuta código 


end event

public subroutine f_cambia_color (string as_color);
// Modifica el BackColor de los DW.
IF TRIM(is_color) = "" THEN is_color = as_color

f_cambia_color()

//RETURN 

end subroutine

public subroutine f_cambia_color ();
STRING ls_modify
 
ls_modify = dw_periodos.MODIFY("tipo_periodo.Background.Color = '" + is_color + "'") 



end subroutine

public function any f_recupera_seleccion ();
STRING ls_periodos[] 
INTEGER le_pos 
INTEGER le_seleccionado
INTEGER le_pos_array

// Se hace ciclo para pasar a arreglo de retorno los valores seleccionados. 
FOR le_pos = 1 TO dw_periodos.ROWCOUNT() 

	le_seleccionado = dw_periodos.GETITEMNUMBER(le_pos, "seleccionado") 
	IF ISNULL(le_seleccionado)  THEN le_seleccionado = 0 
	IF le_seleccionado = 0 THEN CONTINUE 
	
	le_pos_array ++
	ls_periodos[le_pos_array] = dw_periodos.GETITEMSTRING(le_pos, "tipo_periodo")

NEXT 


RETURN ls_periodos[]






end function

public function boolean f_genera_periodo (transaction atr_sce);STRING ls_opciones 
STRING ls_descripcion, ls_idtipoperiodo
INTEGER ll_ttlrgs 
INTEGER le_pos
INTEGER le_row

iuo_periodo_servicios.f_carga_periodos_tipo(atr_sce)
IF iuo_periodo_servicios.ierror < 0 THEN 
	ierror = iuo_periodo_servicios.ierror 
	imensaje = iuo_periodo_servicios.imensaje
	RETURN FALSE
END IF 

dw_periodos.RESET() 

//*******************************************
ll_ttlrgs = iuo_periodo_servicios.ids_tipo_periodos.ROWCOUNT() 

FOR le_pos = 1 TO ll_ttlrgs 

	ls_idtipoperiodo = iuo_periodo_servicios.ids_tipo_periodos.GETITEMSTRING(le_pos, "id_tipo")
	ls_descripcion = iuo_periodo_servicios.ids_tipo_periodos.GETITEMSTRING(le_pos, "descripcion")

	IF le_pos > 1 THEN 
		ls_opciones = ls_opciones + "/" 
	END IF

	ls_opciones = ls_opciones + ls_descripcion + "~t" + STRING(ls_idtipoperiodo)

NEXT 

ls_opciones = "tipo_periodo.values='" + ls_opciones + "'"  

dw_periodos.MODIFY(ls_opciones)  
//*******************************************

// Se hace ciclo para insertar cada valor de tipo de periodo.
INTEGER le_row_ins

FOR le_row = 1 TO iuo_periodo_servicios.ids_tipo_periodos.ROWCOUNT()
	le_row_ins = dw_periodos.insertrow(0)  
	// Se inserta el Id del periodo
	dw_periodos.SETITEM(le_row_ins, "tipo_periodo", iuo_periodo_servicios.ids_tipo_periodos.GETITEMSTRING(le_row, "id_tipo"))	 
	dw_periodos.SETITEM(le_row_ins, "seleccionado", 1)	 
NEXT

f_cambia_color()

RETURN TRUE 







end function

on uo_periodo_tipo_chk.create
this.dw_periodos=create dw_periodos
this.Control[]={this.dw_periodos}
end on

on uo_periodo_tipo_chk.destroy
destroy(this.dw_periodos)
end on

event constructor;
iuo_periodo_servicios = CREATE uo_periodo_servicios










end event

type dw_periodos from datawindow within uo_periodo_tipo_chk
event ue_selecciona_periodo ( )
integer width = 471
integer height = 240
integer taborder = 10
string title = "none"
string dataobject = "d_tipo_periodo_filtro_chk"
boolean border = false
end type

event ue_selecciona_periodo();RETURN 

//INTEGER le_periodo
//STRING ls_periodo
//INTEGER le_pos 
//
//// Si existe un error termina la función.
////IF ierror = -1 THEN RETURN 
//
//// Se inicializan datos del periodo seleccionado.
//id_periodo = -1 
//descripcion = "" 
//// Se encienden banderas de error para indicar que no se ha seleccionado ningún periodo.
//ierror = 0
//imensaje = "" 	
//
//le_periodo = dw_periodos.GETITEMNUMBER(1, "periodo") 
//IF ISNULL(le_periodo) THEN 
//	ierror = -1 
//	imensaje = "No se ha seleccionado ningún periodo." 	
//	RETURN 	
//END IF 
//	
//descripcion = iuo_periodo_servicios.f_recupera_descripcion(le_periodo, "L")
//descripcion_corta = iuo_periodo_servicios.f_recupera_descripcion(le_periodo, "C")
//
//IF iuo_periodo_servicios.ierror = 0 THEN 
//	id_periodo = le_periodo
//	ierror = 0
//	imensaje = "" 	
//END IF
//
//
////le_pos = ids_periodos.FIND("periodo = " + string(le_periodo), 0, ids_periodos.ROWCOUNT()) 
////
////IF le_pos > 0 THEN 
////	id_periodo = ids_periodos.GETITEMNUMBER(le_pos, "periodo") 
////	descripcion = ids_periodos.GETITEMSTRING(le_pos, "descripcion") 
////	ierror = 0
////	imensaje = "" 
////END IF
//
//
//PARENT.EVENT ue_cambia_seleccion() 
//
//RETURN 		
//	
//	

end event

event itemchanged;

//IF NOT ISNULL(THIS.GETITEMNUMBER(1, "periodo")) THEN 
//	IF 	is_solo_default = "S" THEN 
//		IF INTEGER(data) <> ie_periodo_activo THEN 
//			MESSAGEBOX("Aviso", "El periodo seleccionado no es el periodo activo.")
//			RETURN 2
//		END IF
//	END IF
//ELSE 
//	IF 	is_solo_default = "S" THEN 
//		IF INTEGER(data) <> ie_periodo_activo THEN 
//			MESSAGEBOX("Aviso", "El periodo seleccionado no es el periodo activo.")
//			RETURN 2
//		END IF
//	END IF
//END IF



this.postevent("ue_selecciona_periodo") 






end event

