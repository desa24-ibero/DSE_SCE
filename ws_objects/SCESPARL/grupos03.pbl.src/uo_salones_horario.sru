$PBExportHeader$uo_salones_horario.sru
forward
global type uo_salones_horario from UserObject
end type
type dw_salones_horario from datawindow within uo_salones_horario
end type
end forward

global type uo_salones_horario from UserObject
int Width=355
int Height=99
boolean Border=true
long BackColor=79741120
long PictureMaskColor=536870912
long TabBackColor=16777215
dw_salones_horario dw_salones_horario
end type
global uo_salones_horario uo_salones_horario

type variables
integer ii_periodo, ii_anio
string is_cve_salon
end variables

forward prototypes
public function integer of_establece_periodo (integer ai_periodo, integer ai_anio)
public function string of_obten_salon ()
end prototypes

public function integer of_establece_periodo (integer ai_periodo, integer ai_anio);//of_establece_periodo
//Recibe ai_periodo 	integer
//			ai_anio		integer

datawindowchild dw_child
integer li_return, li_null
long ll_rows_child, ll_rows_padre


SetNull(li_null)
//Obtiene la referencia al datawindow child en dw_child
li_return = dw_salones_horario.GetChild("cve_salon", dw_child)

//Revisa los errores
IF li_return = -1 THEN
	MessageBox("Error","No es posible mostrar los salones utilizados en el plan grupos",StopSign!)	
	ii_anio= li_null
	ii_periodo = li_null
	RETURN -1
ELSE
	//Asigna el objeto de transaccion para el dw_child y obtiene sus registros
	dw_child.SetTransObject(gtr_sce)
	ll_rows_child= dw_child.Retrieve(ai_periodo, ai_anio)
	ii_anio= ai_anio
	ii_periodo = ai_periodo
	IF ll_rows_child>0 THEN
		dw_salones_horario.SetTransObject(gtr_sce)		
		ll_rows_padre = dw_salones_horario.Retrieve()
	END IF
	RETURN 1
END IF

RETURN -1
end function

public function string of_obten_salon ();//of_obten_salon
//Devuelve el salon elegido

long ll_row_salon
string ls_cve_salon
ll_row_salon = this.dw_salones_horario.GetRow()

IF ll_row_salon > 0 THEN
	ls_cve_salon = this.dw_salones_horario.GetItemString(ll_row_salon, "cve_salon")
ELSE
 	ls_cve_salon=""
END IF

is_cve_salon= ls_cve_salon

RETURN is_cve_salon

end function

on uo_salones_horario.create
this.dw_salones_horario=create dw_salones_horario
this.Control[]={this.dw_salones_horario}
end on

on uo_salones_horario.destroy
destroy(this.dw_salones_horario)
end on

event constructor;dw_salones_horario.SetTransObject(gtr_sce)
end event

type dw_salones_horario from datawindow within uo_salones_horario
int X=4
int Width=336
int Height=86
int TabOrder=10
string DataObject="d_uo_salones_horario"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
end type

