$PBExportHeader$n_transfiere_sybase_sql_bck.sru
forward
global type n_transfiere_sybase_sql_bck from n_base
end type
end forward

global type n_transfiere_sybase_sql_bck from n_base
end type
global n_transfiere_sybase_sql_bck n_transfiere_sybase_sql_bck

type variables


end variables

forward prototypes
public function integer of_actualizacion_update (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_incremental (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_update_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino)
public function integer of_inserta_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino)
public function integer of_delete_insert_datastore (u_datastore ads_origen, u_datastore ads_destino, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_delete_insert (long al_array_cuentas[], string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_incremental_actas (integer ai_periodo, integer ai_anio, string as_nivel, string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_publicacion_actas (integer ai_periodo, integer ai_anio, string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_periodo_delete_insert (integer ai_periodo, integer ai_anio, string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_incremental_ets (integer ai_periodo, integer ai_anio, string as_dataobject, transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_incremental_actas (integer ai_periodo, integer ai_anio, string as_nivel, string as_dataobject, integer ai_cve_tipo_examen[], transaction atr_origen, transaction atr_destino)
public function integer of_actualizacion_publicacion_actas (integer ai_periodo, integer ai_anio, integer ai_cve_tipo_examen[], string as_dataobject, transaction atr_origen, transaction atr_destino)
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

public function integer of_actualizacion_incremental_actas (integer ai_periodo, integer ai_anio, string as_nivel, string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_incremental_actas
//		ai_periodo			integer
//		ai_anio				integer
//		as_nivel				string
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



//Obtiene los registros del origen
	ll_rows_origen  =  lds_origen.Retrieve(ai_periodo, ai_anio, as_nivel)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ai_periodo, ai_anio, as_nivel)
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

return 0
end function

public function integer of_actualizacion_publicacion_actas (integer ai_periodo, integer ai_anio, string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_publicacion_actas
//		ai_periodo			integer
//		ai_anio				integer
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



//Obtiene los registros del origen
	ll_rows_origen  =  lds_origen.Retrieve(ai_periodo, ai_anio)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ai_periodo, ai_anio)
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

return 0
end function

public function integer of_actualizacion_periodo_delete_insert (integer ai_periodo, integer ai_anio, string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_periodo_delete_insert
//		ai_periodo			integer
//		ai_anio				integer
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

//Obtiene la información del Origen
	ll_rows_origen  =  lds_origen.Retrieve(ai_periodo, ai_anio)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ai_periodo, ai_anio)
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

public function integer of_actualizacion_incremental_ets (integer ai_periodo, integer ai_anio, string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_incremental_ets
//		ai_periodo			integer
//		ai_anio				integer
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



//Obtiene los registros del origen
	ll_rows_origen  =  lds_origen.Retrieve(ai_periodo, ai_anio)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ai_periodo, ai_anio)
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

return 0
end function

public function integer of_actualizacion_incremental_actas (integer ai_periodo, integer ai_anio, string as_nivel, string as_dataobject, integer ai_cve_tipo_examen[], transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_incremental_actas
//		ai_periodo			integer
//		ai_anio				integer
//		as_nivel				string
//		ai_cve_tipo_examen integer
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


//Obtiene los registros del origen
	ll_rows_origen  =  lds_origen.Retrieve(ai_periodo, ai_anio, as_nivel, ai_cve_tipo_examen )
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ai_periodo, ai_anio, as_nivel, ai_cve_tipo_examen )
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

return 0
end function

public function integer of_actualizacion_publicacion_actas (integer ai_periodo, integer ai_anio, integer ai_cve_tipo_examen[], string as_dataobject, transaction atr_origen, transaction atr_destino);//Funcion
//of_actualizacion_publicacion_actas
//		ai_periodo			integer
//		ai_anio				integer
//		ai_cve_tipo_examen[] integer
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



//Obtiene los registros del origen
	ll_rows_origen  =  lds_origen.Retrieve(ai_periodo, ai_anio, ai_cve_tipo_examen)
	//Si existen registros en el origen procede
	if ll_rows_origen >= 1 then		
		ll_rows_destino =  lds_destino.Retrieve(ai_periodo, ai_anio, ai_cve_tipo_examen)
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

return 0
end function

on n_transfiere_sybase_sql_bck.create
call super::create
end on

on n_transfiere_sybase_sql_bck.destroy
call super::destroy
end on

