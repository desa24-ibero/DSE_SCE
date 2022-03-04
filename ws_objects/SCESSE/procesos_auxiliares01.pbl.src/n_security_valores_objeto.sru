$PBExportHeader$n_security_valores_objeto.sru
forward
global type n_security_valores_objeto from nonvisualobject
end type
end forward

global type n_security_valores_objeto from nonvisualobject
end type
global n_security_valores_objeto n_security_valores_objeto

type variables
string is_application
string is_usuario
uo_datastore ids_valores_objeto, ids_ext_sort
end variables

forward prototypes
public function integer of_codes_dropdownlistbox (ref dropdownlistbox addlb_recibido, string as_window, string as_control)
public function integer of_codes_dddw (ref datawindowchild adddw_recibido, string as_window, string as_control)
end prototypes

public function integer of_codes_dropdownlistbox (ref dropdownlistbox addlb_recibido, string as_window, string as_control);//of_codes_dropdownlistbox
//El presente metodo asigna la lista de valores correspondientes al dropdownlistbox 
//del usuario que se encuentra firmado
//Recibe:	 addlb_recibido	dropdownlistbox
//				as_window		string
//				as_control		string
//Devuelve:	 integer

long ll_num_rows, ll_row_actual, ll_code[], ll_row_inserted, ll_row_actual_sort, ll_num_rows_sort, ll_code_value
string ls_code[], ls_description[], ls_code_description
integer li_valor_retorno

//Obtiene los posibles valores que se pueden mostrar en el control para el usuario firmado
ll_num_rows = ids_valores_objeto.Retrieve(is_application, as_window, as_control, "dropdownlistbox", is_usuario)

//De no existir el perfil del usuario obtiene los valores de default para todos
IF ll_num_rows= 0 THEN
	ll_num_rows = ids_valores_objeto.Retrieve(is_application, as_window, as_control, "dropdownlistbox", "*")
END IF

addlb_recibido.Reset()

FOR ll_row_actual = 1 TO ll_num_rows
	ls_code[ll_row_actual]= ids_valores_objeto.GetItemString(ll_row_actual, "code_value")	
	ll_code[ll_row_actual]= long(ls_code[ll_row_actual])
	ls_description[ll_row_actual]= ids_valores_objeto.GetItemString(ll_row_actual, "code_description")
	
	ll_row_inserted= ids_ext_sort.InsertRow(0)
	ids_ext_sort.SetItem(ll_row_inserted, "code_value", ll_code[ll_row_actual])
	ids_ext_sort.SetItem(ll_row_inserted, "code_description", ls_description[ll_row_actual])	
NEXT

ids_ext_sort.SetSort("code_value A")
ids_ext_sort.Sort()

ll_num_rows_sort= ids_ext_sort.RowCount()

FOR ll_row_actual_sort = 1 TO ll_num_rows_sort
	ll_code_value = ids_ext_sort.GetItemNumber(ll_row_actual_sort, "code_value")
	ls_code_description = ids_ext_sort.GetItemString(ll_row_actual_sort, "code_description")
	li_valor_retorno= addlb_recibido.InsertItem(ls_code_description, ll_code_value)
	IF li_valor_retorno = -1 THEN
		RETURN -1
	END IF
NEXT

RETURN 0

end function

public function integer of_codes_dddw (ref datawindowchild adddw_recibido, string as_window, string as_control);//of_codes_dropdownlistbox
//El presente metodo asigna la lista de valores correspondientes al dropdownlistbox 
//del usuario que se encuentra firmado
//Recibe:	 adddw_recibido	dropdowndatawindow
//				as_window		string
//				as_control		string
//Devuelve:	 integer

long ll_num_rows, ll_row_actual, ll_code[], ll_row_inserted, ll_row_actual_sort, ll_num_rows_sort, ll_code_value
string ls_code[], ls_description[], ls_code_description
integer li_valor_retorno, li_res_create
string ls_code_column, ls_description_column, ls_table_name, ls_where_instruction
string ls_SQLselect, ls_presentation, ls_error
uo_datastore lds_datastore
long ll_rv
blob ablb_data	 
	 
//Obtiene los posibles valores que se pueden mostrar en el control para el usuario firmado
ll_num_rows = ids_valores_objeto.Retrieve(is_application, as_window, as_control, "dropdowndatawindow", is_usuario)

IF	ll_num_rows= -1 THEN
	MessageBox("Error en la consulta", "No es posible consultar la tabla [security_user_control]", StopSign!)
	RETURN -1
END IF	


//De no existir el perfil del usuario obtiene los valores de default para todos
IF ll_num_rows= 0 THEN
	ll_num_rows = ids_valores_objeto.Retrieve(is_application, as_window, as_control, "dropdowndatawindow", "*")
END IF

adddw_recibido.Reset()

IF ll_num_rows = -1 THEN
	RETURN -1
END IF

IF ll_num_rows > 0 THEN
	ll_row_actual= ids_valores_objeto.GetRow()
	ls_code_column= ids_valores_objeto.GetItemString(ll_row_actual, "code_column")	
	ls_description_column= ids_valores_objeto.GetItemString(ll_row_actual, "description_column")
	ls_table_name= ids_valores_objeto.GetItemString(ll_row_actual, "table_name")	
	ls_where_instruction= ids_valores_objeto.GetItemString(ll_row_actual, "where_instruction")
	IF isnull(ls_where_instruction) OR ls_where_instruction="" THEN
		ls_where_instruction	= ""
	ELSE
		ls_where_instruction = " WHERE "+ls_where_instruction		
	END IF
	lds_datastore = CREATE uo_datastore
	
	ls_SQLselect= "SELECT "+ls_code_column+" , "+ls_description_column+" FROM "+ls_table_name + ls_where_instruction
	ls_presentation= "style(type=grid)"
	
	li_res_create= lds_datastore.Create(gtr_sce.SyntaxFromSQL(ls_SQLselect,  ls_presentation, ls_error))
	
	IF	li_res_create= -1 THEN
		MessageBox("Criterios de busqueda mal definidos", "La consulta de permisos definida para el objeto ["+as_control+"] ~n"+&
						"y usuario ["+gs_usuario+"] deben ser corregidos", StopSign!)
		RETURN -1
	END IF
	
	gtr_sce.Autocommit= true
	lds_datastore.SetTransObject(gtr_sce)	
	ll_num_rows= lds_datastore.Retrieve()
	gtr_sce.Autocommit= false
			
	IF	ll_num_rows= -1 THEN
		ll_rv = lds_datastore.GetFullState(ablb_data)
		MessageBox("Error en la consulta", "No es posible consultar la tabla ["+ls_table_name+"]~n"+string(ablb_data), StopSign!)
		RETURN -1
	END IF	
	
	FOR ll_row_actual = 1 TO ll_num_rows
		ll_code[ll_row_actual]= lds_datastore.GetItemNumber(ll_row_actual, ls_code_column)	
		ls_description[ll_row_actual]= lds_datastore.GetItemString(ll_row_actual, ls_description_column)
	
		ll_row_inserted= ids_ext_sort.InsertRow(0)
		ids_ext_sort.SetItem(ll_row_inserted, "code_value", ll_code[ll_row_actual])
		ids_ext_sort.SetItem(ll_row_inserted, "code_description", ls_description[ll_row_actual])	
	NEXT

	ids_ext_sort.SetSort("code_value A")
	ids_ext_sort.Sort()

	ll_num_rows_sort= ids_ext_sort.RowCount()
 
	FOR ll_row_actual_sort = 1 TO ll_num_rows_sort
		ll_code_value = ids_ext_sort.GetItemNumber(ll_row_actual_sort, "code_value")
		ls_code_description = ids_ext_sort.GetItemString(ll_row_actual_sort, "code_description")
		li_valor_retorno= adddw_recibido.InsertRow(0)
		IF li_valor_retorno = -1 THEN
			RETURN -1
		ELSE
			adddw_recibido.SetItem(li_valor_retorno,"code_value", ll_code_value)
			adddw_recibido.SetItem(li_valor_retorno,"code_description", ls_code_description)
		END IF
	NEXT
END IF

RETURN 0

end function

on n_security_valores_objeto.create
TriggerEvent( this, "constructor" )
end on

on n_security_valores_objeto.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;is_application = GetApplication().appname
is_usuario =gs_usuario
ids_valores_objeto = CREATE datastore
ids_valores_objeto.dataobject = 'd_security_valores_objeto'
ids_valores_objeto.SetTransObject(gtr_sce)

ids_ext_sort = CREATE datastore
ids_ext_sort.dataobject = 'd_ext_sort_value_description'
ids_ext_sort.SetTransObject(gtr_sce)

end event

event destructor;IF isvalid(ids_valores_objeto) THEN
	DESTROY ids_valores_objeto 
END IF

IF isvalid(ids_ext_sort) THEN
	DESTROY ids_ext_sort 
END IF

end event

