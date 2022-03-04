$PBExportHeader$uo_pfc_list_box_multiple.sru
forward
global type uo_pfc_list_box_multiple from u_base
end type
type lb_1 from u_lb within uo_pfc_list_box_multiple
end type
end forward

global type uo_pfc_list_box_multiple from u_base
integer width = 987
integer height = 260
long backcolor = 12632256
long picturemaskcolor = 536870912
event ue_genera_lista ( string as_datawindow,  long ai_valores_default[],  transaction atr_transaction )
event ue_sincroniza ( )
lb_1 lb_1
end type
global uo_pfc_list_box_multiple uo_pfc_list_box_multiple

type variables
uo_datastore ids_datastore
long il_clave[]
string is_texto[]
long il_seleccionados[], il_num_registros

end variables

forward prototypes
public subroutine of_obten_lista_seleccionados (ref long al_seleccionados[])
public subroutine of_obten_lista_total (ref long al_todos[])
end prototypes

event ue_genera_lista(string as_datawindow, integer ai_valores_default[], transaction atr_transaction);//ue_genera_lista
//		as_datawindow			string
//		ai_valores_default	integer
//		atr_transaction		transaction

long ll_row_actual, ll_indice_default, ll_tamanio_default, ll_clave
string ls_texto

ids_datastore.dataobject= as_datawindow
ids_datastore.SetTransObject(atr_transaction)
il_num_registros = ids_datastore.Retrieve()
ll_tamanio_default= upperbound(ai_valores_default)

if il_num_registros >0 then
	for ll_row_actual= 1 to il_num_registros	
		ll_clave = ids_datastore.GetItemNumber(ll_row_actual,1)
		ls_texto = ids_datastore.GetItemString(ll_row_actual,2)
		il_clave[ll_row_actual]= ll_clave	
		is_texto[ll_row_actual]= ls_texto
		lb_1.AddItem(ls_texto)
		for ll_indice_default=1 to ll_tamanio_default
			if ai_valores_default[ll_indice_default]=ll_clave then
				lb_1.SelectItem(ll_row_actual)
				ll_indice_default= ll_tamanio_default+1
			end if
		next		
	next	
elseif il_num_registros= 0 then
	MessageBox("Datastore sin registros", "El datastore["+as_datawindow+"] no devuelve registros", StopSign!)
	return
end if

return
end event

event ue_sincroniza();//Sincroniza con el contenedor el proceso requerido al darse la seleccion de 
//un elemento del listbox
parent.triggerevent("ue_sincroniza")
end event

public subroutine of_obten_lista_seleccionados (ref long al_seleccionados[]);//of_obten_lista_seleccionados
//al_selecionados[]	long
//asigna los valores seleccionados en el parametro por referencia de la funcion

long ll_row_actual, ll_indice_seleccionado, ll_clave
string ls_texto

ll_indice_seleccionado=1

for ll_row_actual= 1 to il_num_registros	
	if lb_1.State(ll_row_actual)=1 then
		al_seleccionados[ll_indice_seleccionado]=il_clave[ll_row_actual]
		ll_indice_seleccionado= ll_indice_seleccionado +1
	end if
next	

return 
end subroutine

public subroutine of_obten_lista_total (ref long al_todos[]);//of_obten_lista_total
//al_todos[]	long
//asigna los valores existentes en el parametro por referencia de la funcion

long ll_row_actual, ll_indice_todos, ll_clave
string ls_texto

ll_indice_todos=1

for ll_row_actual= 1 to il_num_registros	
	al_todos[ll_indice_todos]=il_clave[ll_row_actual]
	ll_indice_todos= ll_indice_todos +1
next	

return 
end subroutine

on uo_pfc_list_box_multiple.create
int iCurrent
call super::create
this.lb_1=create lb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lb_1
end on

on uo_pfc_list_box_multiple.destroy
call super::destroy
destroy(this.lb_1)
end on

event constructor;ids_datastore= create uo_datastore
this.of_SetResize(true)

end event

event destructor;if isvalid(ids_datastore) then
	destroy ids_datastore
end if
end event

type lb_1 from u_lb within uo_pfc_list_box_multiple
integer y = 4
integer width = 978
integer height = 248
integer taborder = 30
long backcolor = 15793151
boolean hscrollbar = true
boolean multiselect = true
end type

event selectionchanged;call super::selectionchanged;long ll_seleccionados[]

il_seleccionados = ll_seleccionados
of_obten_lista_seleccionados(il_seleccionados)

parent.event ue_sincroniza()
end event

