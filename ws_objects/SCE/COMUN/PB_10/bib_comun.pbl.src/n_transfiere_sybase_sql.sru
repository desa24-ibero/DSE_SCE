$PBExportHeader$n_transfiere_sybase_sql.sru
forward
global type n_transfiere_sybase_sql from n_base
end type
end forward

global type n_transfiere_sybase_sql from n_base
end type
global n_transfiere_sybase_sql n_transfiere_sybase_sql

type variables


end variables

forward prototypes
public function integer of_actualizacion_update (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_incremental (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_update_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino)
public function integer of_inserta_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino)
public function integer of_delete_insert_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_delete_insert (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_obten_parametros_replica (ref integer ai_replica_activa)
public function integer of_actualizacion_objeto_replica (long al_array_cuentas[], string as_objeto, ref transaction atr_origen, ref transaction atr_destino)
public function integer of_actualizacion_objeto_replica (string as_objeto, ref transaction atr_origen, ref transaction atr_destino)
public function integer of_actualizacion_delete_insert (string as_dataobject, transaction atr_origen, transaction atr_destino)
end prototypes

public function integer of_actualizacion_update (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_update
//		al_array_cuentas[]	long
//		as_dataobject		string
//		atr_origen			transaction
//		atr_destino			transaction

long ll_rows_origen, ll_rows_destino, ll_cuenta_actual, ll_tamanio_array, ll_indice_array
long ll_actualiza_datastore
u_datastore lds_origen, lds_destino

ll_tamanio_array = UpperBound(al_array_cuentas) 

if ll_tamanio_array=0 then
	MessageBox("Faltan Datos","No existen cuentas a procesar",Information!)	
	Return 0
end if
	
lds_origen = create u_datastore
lds_destino = create u_datastore
	
lds_origen.dataobject = as_dataobject
lds_destino.dataobject = as_dataobject

lds_origen.SetTransObject(atr_origen)
lds_destino.SetTransObject(atr_destino)

ll_tamanio_array = UpperBound(al_array_cuentas) 

FOR ll_indice_array = 1 TO ll_tamanio_array
	ll_cuenta_actual = al_array_cuentas[ll_indice_array]
	ll_rows_origen  =  lds_origen.Retrieve(ll_cuenta_actual)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ll_cuenta_actual)
		//Si existen registros en el destino, actualiza
		if ll_rows_destino >= 1 then		
			ll_actualiza_datastore = of_update_datastore(lds_origen, lds_destino, atr_origen, atr_destino)
		elseif ll_rows_destino = -1 then		
			MessageBox("Error","Error en Destino",StopSign!)
			return ll_rows_destino
		end if
	elseif ll_rows_origen = -1 then		
		MessageBox("Error","Error en Origen",StopSign!)			
		return ll_rows_origen
	end if
NEXT

return 0
end function

public function integer of_actualizacion_incremental (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_incremental
//		al_array_cuentas[]	long
//		as_dataobject		string
//		atr_origen			transaction
//		atr_destino			transaction

long ll_rows_origen, ll_rows_destino, ll_cuenta_actual, ll_tamanio_array, ll_indice_array
long ll_actualiza_datastore
u_datastore lds_origen, lds_destino

ll_tamanio_array = UpperBound(al_array_cuentas) 

if ll_tamanio_array=0 then
	MessageBox("Faltan Datos","No existen cuentas a procesar",Information!)	
	Return 0
end if
	
lds_origen = create u_datastore
lds_destino = create u_datastore
	
lds_origen.dataobject = as_dataobject
lds_destino.dataobject = as_dataobject

lds_origen.SetTransObject(atr_origen)
lds_destino.SetTransObject(atr_destino)

ll_tamanio_array = UpperBound(al_array_cuentas) 

FOR ll_indice_array = 1 TO ll_tamanio_array
	ll_cuenta_actual = al_array_cuentas[ll_indice_array]
	ll_rows_origen  =  lds_origen.Retrieve(ll_cuenta_actual)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ll_cuenta_actual)
		//Si no existen registros en el destino, actualiza
		if ll_rows_destino= 0 then		
			ll_actualiza_datastore = of_inserta_datastore(lds_origen, lds_destino, atr_origen, atr_destino)
		elseif ll_rows_destino = -1 then		
			MessageBox("Error","Error en Destino",StopSign!)
			return ll_rows_destino
		end if
	elseif ll_rows_origen = -1 then		
		MessageBox("Error","Error en Origen",StopSign!)			
		return ll_rows_origen
	end if
NEXT

return 0
end function

public function integer of_update_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino);//Funcion
//of_update_datastore
//		ads_origen	u_datastore
//		ads_destino	u_datastore
//		atr_origen	transaction
//		atr_destino transaction

integer li_sfs, li_gfs, li_update_destino, li_transobject, li_columna_actual
blob lb_datastore
long ll_row_actual, ll_num_rows, li_res_item_status, ll_num_columnas
string ls_SQLPreview
any la_valores[]

li_gfs = ads_origen.GetFullState(lb_datastore)

if li_gfs = -1 or isnull(li_gfs) then
	MessageBox("Error","Error en GetFullState se datastore Origen",StopSign!)	
	Return -1
else
	li_sfs = ads_destino.SetFullState(lb_datastore)
	if li_sfs = -1 then
		MessageBox("Error","Error en SetFullState se datastore Destino",StopSign!)	
		Return -1
	else
		li_transobject = ads_destino.SetTransObject(atr_destino)
//Indico que es un registro existente para generar una instrucción UPDATE
		ll_num_rows = ads_destino.SetTransObject(atr_destino)
		ll_num_rows = ads_destino.RowCount()
		FOR ll_row_actual = 1 TO ll_num_rows
//			Obtiene los valores del renglon actual
			la_valores = ads_destino.Object.Data.Primary.Current[ll_row_actual]
//			Obtiene el numero de columnas del datastore
			ll_num_columnas = UpperBound(la_valores[1])
			FOR li_columna_actual = 1 TO ll_num_columnas
				li_res_item_status = ads_destino.SetItemStatus(ll_row_actual, li_columna_actual,Primary!, DataModified!)				
			NEXT
//			li_res_item_status = ads_destino.SetItemStatus(ll_row_actual, 0,Primary!, DataModified!)
		NEXT

		if li_transobject = 1 and li_res_item_status = 1 then
			li_update_destino = ads_destino.Update(TRUE, TRUE)
			if li_update_destino = 1 then
				COMMIT USING atr_destino;
		ELSE
				ROLLBACK USING atr_destino;
				MessageBox("Error en Inserción","Error en actualización del datastore Destino",StopSign!)	
				Return -1
			end if
		else
			MessageBox("Error","Error en SetTransObject del datastore Destino",StopSign!)	
			Return -1
		end if
	end if		
end if
return 0
end function

public function integer of_inserta_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino);//Funcion
//of_inserta_datastore
//		ads_origen	u_datastore
//		ads_destino	u_datastore
//		atr_origen	transaction
//		atr_destino transaction

integer li_sfs, li_gfs, li_update_destino, li_transobject
blob lb_datastore
long ll_row_actual, ll_num_rows

li_gfs = ads_origen.GetFullState(lb_datastore)

if li_gfs = -1 or isnull(li_gfs) then
	MessageBox("Error","Error en GetFullState se datastore Origen",StopSign!)	
	Return -1
else
	li_sfs = ads_destino.SetFullState(lb_datastore)
	if li_sfs = -1 then
		MessageBox("Error","Error en SetFullState se datastore Destino",StopSign!)	
		Return -1
	else
		li_transobject = ads_destino.SetTransObject(atr_destino)
//Indico que es un registro Nuevo para generar una instrucción INSERT
		ll_num_rows = ads_destino.SetTransObject(atr_destino)
		ll_num_rows = ads_destino.RowCount()
		FOR ll_row_actual = 1 TO ll_num_rows
			ads_destino.SetItemStatus(ll_row_actual, 0,Primary!, NewModified!)
		NEXT

		if li_transobject = 1 then
			li_update_destino = ads_destino.Update(TRUE, TRUE)
			if li_update_destino = 1 then
				COMMIT USING atr_destino;
		ELSE
				ROLLBACK USING atr_destino;
				MessageBox("Error en Inserción","Error en actualización del datastore Destino",StopSign!)	
				Return -1
			end if
		else
			MessageBox("Error","Error en SetTransObject del datastore Destino",StopSign!)	
			Return -1
		end if
	end if		
end if
return 0
end function

public function integer of_delete_insert_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino);//Funcion
//of_delete_insert_datastore
//		ads_origen	u_datastore
//		ads_destino	u_datastore
//		atr_origen	transaction
//		atr_destino transaction

integer li_sfs, li_gfs, li_update_destino, li_transobject, li_columna_actual, li_res_del
blob lb_datastore
long ll_row_actual, ll_num_rows, li_res_item_status, ll_num_columnas
string ls_SQLPreview
any la_valores[]

//Elimina los registros existentes en el Destino
ll_num_rows = ads_destino.SetTransObject(atr_destino)
ll_num_rows = ads_destino.RowCount()
FOR ll_row_actual = 1 TO ll_num_rows
	li_res_del= ads_destino.DeleteRow(0)
	if li_res_del= -1 then
		MessageBox("Error","Error eliminando los registros del datastore Destino",StopSign!)	
		return -1
	end if
NEXT

if ll_num_rows>0 then
	li_update_destino = ads_destino.Update(TRUE, TRUE)
	if li_update_destino = 1 then
		COMMIT USING atr_destino;
	else
		ROLLBACK USING atr_destino;
		MessageBox("Error en Inserción","Error en actualización del datastore Destino",StopSign!)	
		Return -1
	end if
end if

li_gfs = ads_origen.GetFullState(lb_datastore)

if li_gfs = -1 or isnull(li_gfs) then
	MessageBox("Error","Error en GetFullState se datastore Origen",StopSign!)	
	Return -1
else
	li_sfs = ads_destino.SetFullState(lb_datastore)
	if li_sfs = -1 then
		MessageBox("Error","Error en SetFullState de datastore Destino",StopSign!)	
		Return -1
	else
		li_transobject = ads_destino.SetTransObject(atr_destino)
//Indico que es un registro Nuevo para generar una instrucción INSERT
		ll_num_rows = ads_destino.SetTransObject(atr_destino)
		ll_num_rows = ads_destino.RowCount()
		FOR ll_row_actual = 1 TO ll_num_rows
			ads_destino.SetItemStatus(ll_row_actual, 0,Primary!, NewModified!)
		NEXT

		if li_transobject = 1 then
			li_update_destino = ads_destino.Update(TRUE, TRUE)
			if li_update_destino = 1 then
				COMMIT USING atr_destino;
		ELSE
				ROLLBACK USING atr_destino;
				MessageBox("Error en Inserción","Error en actualización del datastore Destino",StopSign!)	
				Return -1
			end if
		else
			MessageBox("Error","Error en SetTransObject del datastore Destino",StopSign!)	
			Return -1
		end if
	end if			
end if
return 0
end function

public function integer of_actualizacion_delete_insert (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_delete_insert
//		al_array_cuentas[]	long
//		as_dataobject		string
//		atr_origen			transaction
//		atr_destino			transaction

long ll_rows_origen, ll_rows_destino, ll_cuenta_actual, ll_tamanio_array, ll_indice_array
long ll_actualiza_datastore
u_datastore lds_origen, lds_destino

ll_tamanio_array = UpperBound(al_array_cuentas) 

if ll_tamanio_array=0 then
	MessageBox("Faltan Datos","No existen cuentas a procesar",Information!)	
	Return 0
end if
	
lds_origen = create u_datastore
lds_destino = create u_datastore
	
lds_origen.dataobject = as_dataobject
lds_destino.dataobject = as_dataobject

lds_origen.SetTransObject(atr_origen)
lds_destino.SetTransObject(atr_destino)

ll_tamanio_array = UpperBound(al_array_cuentas) 

FOR ll_indice_array = 1 TO ll_tamanio_array
	ll_cuenta_actual = al_array_cuentas[ll_indice_array]
	ll_rows_origen  =  lds_origen.Retrieve(ll_cuenta_actual)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ll_cuenta_actual)
		//Sin importar si existen registros en el destino, borra e inserta
		if ll_rows_destino>= 0 then		
			ll_actualiza_datastore = of_delete_insert_datastore(lds_origen, lds_destino, atr_origen, atr_destino)
		elseif ll_rows_destino = -1 then		
			MessageBox("Error","Error en Destino",StopSign!)
			return ll_rows_destino
		end if
	elseif ll_rows_origen = -1 then		
		MessageBox("Error","Error en Origen",StopSign!)			
		return ll_rows_origen
	end if
NEXT

return 0
end function

public function integer of_obten_parametros_replica (ref integer ai_replica_activa);//of_obten_parametros_replica
//Recibe y	Devuelve 
//		ai_replica_activa 	integer

string  ls_mensaje_sql
integer li_codigo_sql, li_replica_activa

SELECT replica_activa
INTO  :li_replica_activa
FROM parametros_replica
WHERE cve_parametros_replica = 1
USING gtr_sce;

ls_mensaje_sql= gtr_sce.SqlErrtext
li_codigo_sql= gtr_sce.SqlCode

IF li_codigo_sql= -1 THEN
	MessageBox("No es posible consultar los parametros de réplica", ls_mensaje_sql, StopSign!)
	ai_replica_activa = 0
	RETURN  li_codigo_sql
ELSEIF  li_codigo_sql = 100 THEN
	ai_replica_activa = 0
	RETURN 0
ELSE
	ai_replica_activa = li_replica_activa
	RETURN 0
END IF


end function

public function integer of_actualizacion_objeto_replica (long al_array_cuentas[], string as_objeto, ref transaction atr_origen, ref transaction atr_destino);//Funcion
//of_actualizacion_objeto_replica
//		al_array_cuentas[]	long
//		as_objeto		string
//		atr_origen		transaction
//		atr_destino		transaction

//Devuelve
//0		No se actualizó información
//-1		Error de actualización
//1		Actualización Exitosa

long ll_rows_origen, ll_rows_destino, ll_cuenta_actual, ll_tamanio_array, ll_indice_array
long ll_actualiza_datastore, ll_row_objeto_replica, ll_rows_objeto_replica
u_datastore lds_origen, lds_destino, lds_objeto_replica
string ls_class_name, ls_datawindow
integer li_replica_activa, li_obten_parametros_replicacion, li_res_actualizacion
string ls_mensaje

ll_tamanio_array = UpperBound(al_array_cuentas) 

if ll_tamanio_array=0 then
//	No existen cuentas a procesar
	Return 0
end if

li_obten_parametros_replicacion = this.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	if li_obten_parametros_replicacion<>-1 then
		//SI NO esta conectado WEB.controlescolar_bd, se conecta
		if not isvalid(atr_destino) then
			if f_conecta_con_parametros_bd(atr_origen, atr_destino, 23 )=0 then
				ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
				MessageBox("Error", ls_mensaje, StopSign!)
				return -1
			end if
		else
			atr_destino = atr_destino
		end if
	end if

	lds_objeto_replica = create u_datastore
	lds_objeto_replica.dataobject = 'd_objeto_replica'
	lds_objeto_replica.SetTransObject(atr_origen)
	
 
	ll_rows_objeto_replica  =  lds_objeto_replica.Retrieve(as_objeto)
	//Si existen registros en el origen procede
	if ll_rows_objeto_replica >= 1 then	
	
		FOR  ll_row_objeto_replica=1 to ll_rows_objeto_replica
			ls_class_name = lds_objeto_replica.GetItemString(ll_row_objeto_replica, "class_name")
			ls_datawindow= lds_objeto_replica.GetItemString(ll_row_objeto_replica, "datawindow")	
			if len(ls_datawindow)>0 then
				ll_actualiza_datastore = this.of_actualizacion_delete_insert(al_array_cuentas, ls_datawindow,atr_origen, atr_destino)
			end if				
		NEXT

	elseif ll_rows_objeto_replica = -1 then		
		MessageBox("Error","Error en of_actualizacion_objeto_replica",StopSign!)			
		return ll_rows_objeto_replica
	end if
	//	ll_rows_objeto_replica >= 1 then	
	if isvalid(atr_destino) then
		disconnect using atr_destino;
	end if
else 
	return 0			
end if
//li_replica_activa = 1

return 1

end function

public function integer of_actualizacion_objeto_replica (string as_objeto, ref transaction atr_origen, ref transaction atr_destino);//Funcion
//of_actualizacion_objeto_replica
//		as_objeto		string
//		atr_origen		transaction
//		atr_destino		transaction

//Devuelve
//0		No se actualizó información
//-1		Error de actualización
//1		Actualización Exitosa

long ll_rows_origen, ll_rows_destino, ll_cuenta_actual, ll_tamanio_array, ll_indice_array
long ll_actualiza_datastore, ll_row_objeto_replica, ll_rows_objeto_replica
u_datastore lds_origen, lds_destino, lds_objeto_replica
string ls_class_name, ls_datawindow
integer li_replica_activa, li_obten_parametros_replicacion, li_res_actualizacion
string ls_mensaje


li_obten_parametros_replicacion = this.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	if li_obten_parametros_replicacion<>-1 then
		//SI NO esta conectado WEB.controlescolar_bd, se conecta
		if not isvalid(atr_destino) then
			if f_conecta_con_parametros_bd(atr_origen, atr_destino, 23 )=0 then
				ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
				MessageBox("Error", ls_mensaje, StopSign!)
				return -1
			end if
		else
			atr_destino = atr_destino
		end if
	end if

	lds_objeto_replica = create u_datastore
	lds_objeto_replica.dataobject = 'd_objeto_replica'
	lds_objeto_replica.SetTransObject(atr_origen)
	
 
	ll_rows_objeto_replica  =  lds_objeto_replica.Retrieve(as_objeto)
	//Si existen registros en el origen procede
	if ll_rows_objeto_replica >= 1 then	
	
		FOR  ll_row_objeto_replica=1 to ll_rows_objeto_replica
			ls_class_name = lds_objeto_replica.GetItemString(ll_row_objeto_replica, "class_name")
			ls_datawindow= lds_objeto_replica.GetItemString(ll_row_objeto_replica, "datawindow")	
			if len(ls_datawindow)>0 then
				ll_actualiza_datastore = this.of_actualizacion_delete_insert(ls_datawindow,atr_origen, atr_destino)
			end if				
		NEXT

	elseif ll_rows_objeto_replica = -1 then		
		MessageBox("Error","Error en of_actualizacion_objeto_replica",StopSign!)			
		return ll_rows_objeto_replica
	end if
	//	ll_rows_objeto_replica >= 1 then	
	if isvalid(atr_destino) then
		disconnect using atr_destino;
	end if
else 
	return 0			
end if
//li_replica_activa = 1

return 1

end function

public function integer of_actualizacion_delete_insert (string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_delete_insert
//		as_dataobject		string
//		atr_origen			transaction
//		atr_destino			transaction

long ll_rows_origen, ll_rows_destino, ll_cuenta_actual, ll_tamanio_array, ll_indice_array
long ll_actualiza_datastore
u_datastore lds_origen, lds_destino

lds_origen = create u_datastore
lds_destino = create u_datastore
	
lds_origen.dataobject = as_dataobject
lds_destino.dataobject = as_dataobject

lds_origen.SetTransObject(atr_origen)
lds_destino.SetTransObject(atr_destino)

	ll_rows_origen  =  lds_origen.Retrieve()
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve()
		//Sin importar si existen registros en el destino, borra e inserta
		if ll_rows_destino>= 0 then		
			ll_actualiza_datastore = of_delete_insert_datastore(lds_origen, lds_destino, atr_origen, atr_destino)
		elseif ll_rows_destino = -1 then		
			MessageBox("Error","Error en Destino",StopSign!)
			return ll_rows_destino
		end if
	elseif ll_rows_origen = -1 then		
		MessageBox("Error","Error en Origen",StopSign!)			
		return ll_rows_origen
	end if

return 0
end function

on n_transfiere_sybase_sql.create
call super::create
end on

on n_transfiere_sybase_sql.destroy
call super::destroy
end on

