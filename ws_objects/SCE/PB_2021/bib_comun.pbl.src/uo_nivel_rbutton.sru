$PBExportHeader$uo_nivel_rbutton.sru
forward
global type uo_nivel_rbutton from userobject
end type
type dw_niveles from datawindow within uo_nivel_rbutton
end type
end forward

global type uo_nivel_rbutton from userobject
integer width = 576
integer height = 304
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_cambia_seleccion ( )
dw_niveles dw_niveles
end type
global uo_nivel_rbutton uo_nivel_rbutton

type variables


DATASTORE ids_niveles
STRING cve_nivel
STRING descripcion
STRING descripcion_corta

INTEGER ierror
STRING imensaje

//uo_periodo_servicios iuo_periodo_servicios 
uo_nivel_servicios iuo_nivel_servicios 

STRING is_color 



end variables

forward prototypes
public subroutine f_cambia_color (string as_color)
public subroutine f_cambia_color ()
public function boolean f_genera_nivel (string as_orientacion, transaction atr_sce)
public function integer f_selecciona_nivel (string as_nivel, string as_tipo_descripcion)
public function integer f_recupera_nivel (ref string as_id_periodo, ref string adescripcion, string as_tipo_descripcion)
public function integer f_recupera_nivel (ref string as_id_periodo, ref string adescripcion)
public function boolean f_genera_nivel (string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, transaction atr_sce, string as_todos, string as_seleccionados)
public function boolean f_genera_nivel (string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, transaction atr_sce)
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
 
ls_modify = dw_niveles.MODIFY("periodo.Background.Color = '" + is_color + "'") 



end subroutine

public function boolean f_genera_nivel (string as_orientacion, transaction atr_sce);
RETURN f_genera_nivel(as_orientacion, "L", "L", atr_sce, "N", "N")
end function

public function integer f_selecciona_nivel (string as_nivel, string as_tipo_descripcion);INTEGER le_pos

ierror = 0
imensaje = "" 

iuo_nivel_servicios.f_recupera_descripcion(as_nivel, as_tipo_descripcion)
IF iuo_nivel_servicios.ierror < 0 THEN 
	ierror = -1
	imensaje = "El nivel seleccionado no está disponible." 
	RETURN -1 	
	
END IF 

// Se inserta el id periodo en el dw de selacción.
dw_niveles.setitem(1, "cve_nivel", as_nivel)
dw_niveles.TRIGGEREVENT("ue_selecciona_nivel")

RETURN 0




end function

public function integer f_recupera_nivel (ref string as_id_periodo, ref string adescripcion, string as_tipo_descripcion);
// Función que recupera el periodo seleccionado.
IF cve_nivel = "" OR ISNULL(cve_nivel) OR ierror = -1 THEN 
	ierror = -1
	imensaje = "No se ha seleccionado ningún nivel." 
	RETURN -1	
END IF 

as_id_periodo = cve_nivel 
IF as_tipo_descripcion = "L" THEN 
	adescripcion = descripcion
ELSE
	adescripcion = descripcion_corta
END IF

RETURN 0
end function

public function integer f_recupera_nivel (ref string as_id_periodo, ref string adescripcion);

RETURN f_recupera_nivel(as_id_periodo, adescripcion, "L") 




end function

public function boolean f_genera_nivel (string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, transaction atr_sce, string as_todos, string as_seleccionados);STRING ls_query
INTEGER le_cuenta_todos
INTEGER le_cuenta_selec
INTEGER le_width

iuo_nivel_servicios.f_carga_niveles(as_case_descripciones, atr_sce)
cve_nivel = ""
IF iuo_nivel_servicios.ierror < 0 THEN 
	ierror = iuo_nivel_servicios.ierror 
	imensaje = iuo_nivel_servicios.imensaje
	RETURN FALSE
END IF 

dw_niveles.RESET() 
dw_niveles.insertrow(0) 
// Se inserta por default Licenciatura 
dw_niveles.SETITEM(1, "cve_nivel", "L")
cve_nivel = "L" 


IF as_todos = "S" THEN iuo_nivel_servicios.ib_todos = TRUE 
IF as_seleccionados = "S" THEN iuo_nivel_servicios.ib_seleccionados = TRUE 

iuo_nivel_servicios.f_modifica_lista_columna(dw_niveles, "cve_nivel", as_tipo_descripcion)


IF as_todos = "S" THEN le_cuenta_todos = 1 
IF as_seleccionados = "S" THEN le_cuenta_selec = 1 

IF as_orientacion = "V" THEN 
	dw_niveles.Modify("cve_nivel.Height='" + STRING(80 * (iuo_nivel_servicios.ids_niveles.ROWCOUNT() + le_cuenta_todos + le_cuenta_selec)) + "'")	 
	dw_niveles.Modify("cve_nivel.RadioButtons.Columns=1") 
ELSE
	dw_niveles.Modify("cve_nivel.Width='" + STRING(400 * (iuo_nivel_servicios.ids_niveles.ROWCOUNT() + le_cuenta_todos + le_cuenta_selec)) + "'")	 
	dw_niveles.Modify("cve_nivel.RadioButtons.Columns=" + STRING(iuo_nivel_servicios.ids_niveles.ROWCOUNT())) 
END IF 


// Se ajusta el tamaño y posición de el dw.
INTEGER li_Height 
INTEGER li_Width 

IF as_seleccionados = "S" THEN
	le_width = 480
ELSE
	le_width = 430	
END IF

IF as_orientacion = "V" THEN 
	// Se limita el ajuste de la altura a 4 posiciones 
	IF (iuo_nivel_servicios.ids_niveles.ROWCOUNT() + le_cuenta_todos + le_cuenta_selec)  <= 4 THEN 
		li_Height = 80 * (iuo_nivel_servicios.ids_niveles.ROWCOUNT() + le_cuenta_todos + le_cuenta_selec )
	ELSE
		li_Height = 340 
		dw_niveles.VScrollBar = TRUE
	END IF
	li_Width = le_width 
ELSE
	li_Height = 80
	li_Width = le_width * (iuo_nivel_servicios.ids_niveles.ROWCOUNT() + le_cuenta_todos + le_cuenta_selec )
END IF

dw_niveles.Height = li_Height
dw_niveles.Width = li_Width

THIS.Height = dw_niveles.Height + 15
THIS.Width = dw_niveles.Width + 5

f_cambia_color()

RETURN TRUE 



end function

public function boolean f_genera_nivel (string as_orientacion, string as_tipo_descripcion, string as_case_descripciones, transaction atr_sce);
RETURN f_genera_nivel(as_orientacion, as_tipo_descripcion, as_case_descripciones, atr_sce, "N", "N") 


end function

on uo_nivel_rbutton.create
this.dw_niveles=create dw_niveles
this.Control[]={this.dw_niveles}
end on

on uo_nivel_rbutton.destroy
destroy(this.dw_niveles)
end on

event constructor;
iuo_nivel_servicios = CREATE uo_nivel_servicios










end event

type dw_niveles from datawindow within uo_nivel_rbutton
event ue_selecciona_nivel ( )
integer width = 549
integer height = 276
integer taborder = 10
string title = "none"
string dataobject = "dw_nivel_variante"
boolean border = false
boolean livescroll = true
end type

event ue_selecciona_nivel();
STRING ls_cve_nivel 
STRING ls_nivel 
INTEGER le_pos 

// Se inicializan datos del periodo seleccionado.
cve_nivel = "" 
descripcion = "" 
// Se encienden banderas de error para indicar que no se ha seleccionado ningún periodo.
ierror = 0
imensaje = "" 	

ls_cve_nivel = dw_niveles.GETITEMSTRING(1, "cve_nivel") 
IF ISNULL(ls_cve_nivel) THEN 
	ierror = -1 
	imensaje = "No se ha seleccionado ningún periodo." 	
	RETURN 	
END IF 
	
// Todos	
IF ls_cve_nivel = "A" THEN 
	cve_nivel = "A" 
	descripcion = "Todos"
	descripcion_corta = "Todos"
	ierror = 0
	imensaje = "" 		
// Seleccionados 	
ELSEIF ls_cve_nivel = "S" THEN 
	cve_nivel = "S"
	descripcion = "Seleccionados"
	descripcion_corta = "Seleccionados"
	ierror = 0 
	imensaje = "" 		
// Nivel de el catálogo 	
ELSE
	descripcion = iuo_nivel_servicios.f_recupera_descripcion(ls_cve_nivel, "L")
	descripcion_corta = iuo_nivel_servicios.f_recupera_descripcion(ls_cve_nivel, "C")
	IF iuo_nivel_servicios.ierror = 0 THEN 
		cve_nivel = ls_cve_nivel
		ierror = 0
		imensaje = "" 	
	END IF	
END IF

PARENT.EVENT ue_cambia_seleccion() 

RETURN 		
	
	





//IF ib_todos THEN 
//	ls_opciones = ls_opciones + "/Todos" + "~t" + "A" 
//END IF
//	
//IF ib_seleccionados THEN 
//	ls_opciones = ls_opciones + "/Seleccionados" + "~t" + "S" 
//END IF

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

this.postevent("ue_selecciona_nivel") 






end event

