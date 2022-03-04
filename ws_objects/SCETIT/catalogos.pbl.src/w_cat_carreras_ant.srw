$PBExportHeader$w_cat_carreras_ant.srw
forward
global type w_cat_carreras_ant from w_catalogo_ancestro
end type
type uo_nombre from uo_nombre_carrera_cats within w_cat_carreras_ant
end type
end forward

global type w_cat_carreras_ant from w_catalogo_ancestro
int Width=3624
int Height=1667
boolean TitleBar=true
string Title="Catalogo de Cambios de Carrera"
uo_nombre uo_nombre
end type
global w_cat_carreras_ant w_cat_carreras_ant

on w_cat_carreras_ant.create
int iCurrent
call super::create
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
end on

on w_cat_carreras_ant.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
end on

event open;m_ancestro_menu_catalogos.m_registro.m_cargaregistro.enabled=false

event ue_settrans(gtr_sce)

dw_catalogo.retrieve(0,0,0)

DataWindowChild cve_plan, cve_subsistema
string ls_filtro
integer rtncode

rtncode = dw_catalogo.GetChild('hist_carreras_cve_plan_ant', cve_plan)

IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

// Set the transaction object for the child

cve_plan.SetTransObject(gtr_sce)

// Populate the child with all the posible values for planes
ls_filtro = ""
cve_plan.SetFilter(ls_filtro)
cve_plan.Filter()



rtncode = dw_catalogo.GetChild('hist_carreras_cve_subsistema_ant', cve_subsistema)

IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

// Set the transaction object for the child

cve_subsistema.SetTransObject(gtr_sce)

// Populate the child with all the posible values for planes
ls_filtro = ""
cve_subsistema.SetFilter(ls_filtro)
cve_subsistema.Filter()


dw_catalogo.triggerevent("ue_ultimo")
dw_catalogo.triggerevent("ue_primero")


end event

type dw_catalogo from w_catalogo_ancestro`dw_catalogo within w_cat_carreras_ant
event ue_filtra_carrera ( )
event type integer carga ( string as_cuenta,  string as_cve_carrera,  string as_cve_plan )
int X=51
int Y=694
int Width=3057
int Height=646
string DataObject="d_carreras_anteriores"
boolean LiveScroll=false
end type

event ue_filtra_carrera;DataWindowChild cve_plan, cve_subsistema
string ls_filtro, ls_filtro_1, ls_filtro_2, ls_carrera, ls_columna, ls_plan
integer rtncode
long ll_carrera, ll_plan, ll_row

ll_row = this.GetRow()

if ll_row <=0 then
	return	
end if

ll_carrera = object.hist_carreras_cve_carrera_ant[ll_row]
ls_carrera = string(ll_carrera)

ll_plan = object.hist_carreras_cve_plan_ant[ll_row]
ls_plan = string(ll_plan)

if isnull(ls_carrera) then
	ls_carrera = "0"
end if

if isnull(ls_plan) then
	ls_plan = "0"
end if


ls_filtro_1 = "cve_carrera = "+ ls_carrera

ls_filtro_2 = "cve_plan = "+ ls_plan



rtncode = dw_catalogo.GetChild('hist_carreras_cve_plan_ant', cve_plan)

IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

// Set the transaction object for the child
	
cve_plan.SetTransObject(gtr_sce)
	
cve_plan.SetFilter(ls_filtro_1)
cve_plan.Filter()
cve_plan.Retrieve()


		
rtncode = dw_catalogo.GetChild('hist_carreras_cve_subsistema_ant', cve_subsistema)

IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

// Set the transaction object for the child
	
cve_subsistema.SetTransObject(gtr_sce)
	
// Populate the child with all the posible values for subsistema
	
if not isnull(ls_carrera) and not isnull(ls_plan) then
		ls_filtro = ls_filtro_1 +" and "+ls_filtro_2
elseif not isnull(ls_carrera) and isnull(ls_plan) then
		ls_filtro = ls_filtro_1 
elseif isnull(ls_carrera) and not isnull(ls_plan) then
		ls_filtro = ls_filtro_2		
end if
	
cve_subsistema.SetFilter(ls_filtro)
cve_subsistema.Filter()
cve_subsistema.Retrieve()
	



end event

event carga;long ll_cuenta, ll_cve_carrera, ll_cve_plan
ll_cuenta = long(as_cuenta)
ll_cve_carrera = long(as_cve_carrera)
ll_cve_plan = long(as_cve_plan)

this.Retrieve(ll_cuenta,ll_cve_carrera,ll_cve_plan )

return 0
end event

event itemchanged;DataWindowChild cve_plan, cve_subsistema
string ls_filtro, ls_filtro_1, ls_filtro_2, ls_carrera, ls_columna, ls_plan
integer rtncode
long ll_carrera, ll_plan, ll_row

ll_row = this.GetRow()

this.AcceptText()

//ls_columna =dwo.name

ls_columna =this.GetColumnName()


ll_carrera = object.hist_carreras_cve_carrera_ant[ll_row]
ls_carrera = string(ll_carrera)

ll_plan = object.hist_carreras_cve_plan_ant[ll_row]
ls_plan = string(ll_plan)

ls_filtro_1 = "cve_carrera = "+ ls_carrera

ls_filtro_2 = "cve_plan = "+ ls_plan

choose case ls_columna 
case'hist_carreras_cve_carrera_ant' 
	

	rtncode = dw_catalogo.GetChild('hist_carreras_cve_plan_ant', cve_plan)

	IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

	// Set the transaction object for the child
	
	cve_plan.SetTransObject(gtr_sce)
	
	// Populate the child with all the posible values for planes
	if isnull(ls_carrera) then
		ls_carrera = "0"
	end if
	
	cve_plan.SetFilter(ls_filtro_1)
	cve_plan.Filter()
	cve_plan.Retrieve()

case 	'hist_carreras_cve_plan_ant'
	ll_plan = object.hist_carreras_cve_plan_ant[ll_row]
	ls_plan = string(ll_plan)

end choose

if ls_columna= 'hist_carreras_cve_carrera_ant' or &
   ls_columna= 'hist_carreras_cve_plan_ant' then
		
	rtncode = dw_catalogo.GetChild('hist_carreras_cve_subsistema_ant', cve_subsistema)

	IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

	// Set the transaction object for the child
	
	cve_subsistema.SetTransObject(gtr_sce)
	
	// Populate the child with all the posible values for subsistema
	
	if not isnull(ls_carrera) and not isnull(ls_plan) then
		ls_filtro = ls_filtro_1 +" and "+ls_filtro_2
	elseif not isnull(ls_carrera) and isnull(ls_plan) then
		ls_filtro = ls_filtro_1 
	elseif isnull(ls_carrera) and not isnull(ls_plan) then
		ls_filtro = ls_filtro_2		
	end if
	
	cve_subsistema.SetFilter(ls_filtro)
	cve_subsistema.Filter()
	cve_subsistema.Retrieve()
	
end if	


end event

event dw_catalogo::ue_nuevo;// nuevo

//Cuando se activa el evento nuevo... 
//Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
//                          Var_Carrera=Se almacena la Carrera
//									 Var_Plan=Se almacena el Plan  

int VarX
int Var_Carrera
int Var_Plan
long ll_current, ll_cuenta, ll_rowcount, ll_aca_cve_carrera, ll_aca_cve_plan

visible=true
//Pon el foco dentro del DataWindow 
SetFocus()
//Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él 
//ll_rowcount=RowCount()
//scrolltorow(ll_rowcount)
this.Reset()
ll_current= insertrow(0)
scrolltorow(ll_current)
//ll_current = GetRow()
//Modifica la columna cuenta para que tenga el texto del número de cuenta (que se encuentra 
//	dentro del objeto uo_nombre en un EditMask llamado em_cuenta) 
ll_cuenta= long(parent.uo_nombre.em_cuenta.Text)

Object.hist_carreras_cuenta[ll_current]=ll_cuenta

//Verifica el estado del RadioButton rb_actual dentro del objeto uo_nombre 
////if parent.uo_nombre.rb_actual.checked then
//Si esta checado, modifica la columna cve_carrera para que tenga el mismo valor que la
//		columna academicos_cve_carrera del DataWindow dw_nombre que esta en el objeto uo_nombre
//		(Puede ser de cualquier renglón ya que la carrera actual es la misma) 

//	Object.hist_carreras_cve_carrera_act[ll_current]=&
//		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_carrera[1]
//	Object.hist_carreras_cve_plan_act[ll_current]=&
//		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_plan[1]
//
//Se asignan valores a Var_Carrera y a Var_Plan  
	Var_Carrera=parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_carrera[1]
	Var_Plan=parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_plan[1]

	Object.hist_carreras_cve_carrera_act[ll_current]=Var_Carrera
	Object.hist_carreras_cve_plan_act[ll_current]=Var_Plan


////else
////
//////De lo contrario, modifica la columna cve_carrera para que tenga el mismo valor que la
//////		columna hist_carreras_cve_carrera del DataWindow dw_nombre que esta en el objeto uo_nombre
//////		(Debe ser del renglón actual ya que varía si se tiene un largo histrorial de carreras) 
////	Object.hist_carreras_cve_carrera_act[RowCount()]=&
////		parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_carrera_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
////	Object.hist_carreras_cve_plan_act[RowCount()]=&
////		parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_plan_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
////
//////Se asignan valores a Var_Carrera y a Var_Plan  
////	Var_Carrera=parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_carrera_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
////	Var_Plan=parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_plan_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
////
////end if
	
	


end event

event dw_catalogo::constructor;call super::constructor;this.Object.DataWindow.Message.Title = "Error de Captura!"
end event

event dw_catalogo::ue_borra;call super::ue_borra;long ll_row, ll_cuenta
char lc_digito
string ls_cuenta


ll_row = dw_catalogo.GetRow()

ll_cuenta = dw_catalogo.object.hist_carreras_cuenta[ll_row]

ls_cuenta = string(ll_cuenta)

lc_digito = obten_digito(ll_cuenta)

uo_nombre.em_cuenta.text = ls_cuenta +lc_digito 
uo_nombre.em_digito.text = lc_digito

uo_nombre.em_cuenta.triggerevent(modified!)

uo_nombre.em_cuenta.triggerevent("activarbusq")



end event

event dw_catalogo::rowfocuschanged;call super::rowfocuschanged;long ll_cuenta, ll_row
string ls_cuenta
char lc_digito

ll_row = dw_catalogo.GetRow()

if ll_row <=0 then
	return
end if

ll_cuenta = dw_catalogo.GetItemNumber(ll_row, "hist_carreras_cuenta")
if isnull(ll_cuenta) then
	return
end if
ls_cuenta = string(ll_cuenta)
lc_digito = obten_digito(ll_cuenta)


uo_nombre.em_cuenta.text = ls_cuenta
uo_nombre.em_digito.text = lc_digito

uo_nombre.dw_nombre_alumno.Retrieve(ll_cuenta)

this.triggerevent("ue_filtra_carrera")
end event

event dw_catalogo::ue_valida_data_window;/*
DESCRIPCIÓN: Evento en el cual se debe llevar a cabo un proceso de validación 
	de la información contenida en el DataWindow para garantizar su integridad
	en la base de datos y la lógica que la gobierna
	
	Es necesario sobreescribirse en cada catálogo donde se desee dicha validación
	ya que por omisión regresará 1 (información correcta)
	
PARÁMETROS: Ninguno
REGRESA:  0 si toda la información esta bien
			-1 Si hubo alguna falla
AUTOR: Antonio Pica Ruiz
FECHA: 30 de Marzo de 1999
MODIFICACIÓN:
*/
integer li_forma_ingreso, li_cve_carrera_act,li_cve_plan_act, li_cve_subsistema_act
integer li_periodo_ing, li_anio_ing
long ll_row


li_forma_ingreso= dw_catalogo.object.hist_carreras_cve_formaingreso[ai_num_registro]


if isnull(li_forma_ingreso) then
	dw_catalogo.SetItem(ai_num_registro,"hist_carreras_cve_formaingreso", 0)
end if


return 0


end event

event dw_catalogo::keyboard;/*
DESCRIPCIÓN:Agrega un renglón sobre el catalogo.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR:CAMP(DkWf)
FECHA:  1996
MODIFICACIÓN:
*/
//
//if key = KeyDownArrow! then
//	if getrow() = rowcount() then  //Agrega un renglón si se esta en el último y se presiona la tecla key down arrow
////			triggerevent("ue_nuevo")
////			setcolumn(1)			
//	end if
//end if


//IF keydown(KeyEnter!) then
//	triggerevent(itemfocuschanged!)
//end if
integer li_column, li_siguiente

if key = KeyEnter! then
	li_column = this.GetColumn()
	li_siguiente = li_column+1
	this.SetColumn(li_siguiente)
end if


end event

event dw_catalogo::ue_carga;///*
//DESCRIPCIÓN: Antes de cargar algo, ve si hay modificaciones no guardadas.
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Víctor Manuel Iniestra Álvarez
//FECHA: 15 Junio 1998
//MODIFICACIÓN:
//*/

if event ue_actualizacion()=1 then
	event ue_primero()
	return retrieve()
end if
return 0
end event

type uo_nombre from uo_nombre_carrera_cats within w_cat_carreras_ant
event destroy ( )
int X=37
int Y=6
int TabOrder=10
boolean Enabled=true
boolean BringToTop=true
end type

on uo_nombre.destroy
call uo_nombre_carrera_cats::destroy
end on

