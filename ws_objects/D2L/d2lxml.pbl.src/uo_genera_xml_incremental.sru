$PBExportHeader$uo_genera_xml_incremental.sru
forward
global type uo_genera_xml_incremental from nonvisualobject
end type
end forward

global type uo_genera_xml_incremental from nonvisualobject
end type
global uo_genera_xml_incremental uo_genera_xml_incremental

type variables

DATASTORE ids_movmat_inscritas
DATASTORE ids_mat_inscritas
DATASTORE ids_mat_inscritas_bit_fecha

DATASTORE ids_grupos 
DATASTORE ids_bit_grupos 
DATASTORE ids_grupos_bit_fecha
end variables

forward prototypes
public function integer f_carga_movmat_inscritas ()
public function integer f_inserta_mat_inscritas_modificadas ()
public function integer f_inserta_grupos_modificados ()
public function integer f_carga_mov_grupos ()
end prototypes

public function integer f_carga_movmat_inscritas ();
LONG ll_total_mov

ids_mat_inscritas = CREATE DATASTORE  
IF gs_plantel2 = "CDMX" THEN 
	ids_mat_inscritas.DATAOBJECT = "dw_mat_inscritas"  
ELSE
	ids_mat_inscritas.DATAOBJECT = "dw_mat_inscritas_tij"  
END IF 
ids_mat_inscritas.SETTRANSOBJECT(SQLCA) 
ll_total_mov = ids_mat_inscritas.RETRIEVE(ge_periodo, ge_anio)  

// Se cargan los movimietos de la fecha que se procesa. 
// Se perocesan los movimientos del dia anterior 
ids_movmat_inscritas = CREATE DATASTORE 
IF gs_plantel2 = "CDMX" THEN 
	ids_movmat_inscritas.DATAOBJECT = "dw_movmat_inscritas"  
ELSE
	ids_movmat_inscritas.DATAOBJECT = "dw_movmat_inscritas_tij"  
END IF
ids_movmat_inscritas.SETTRANSOBJECT(SQLCA) 
ll_total_mov = ids_movmat_inscritas.RETRIEVE(gf_fecha_ejecucion, ge_periodo, ge_anio) 

ids_mat_inscritas_bit_fecha = CREATE DATASTORE 
ids_mat_inscritas_bit_fecha.DATAOBJECT = "dw_archivo_mat_insc_bit_fec" 
ids_mat_inscritas_bit_fecha.SETTRANSOBJECT(SQLCA)  
ll_total_mov = ids_mat_inscritas_bit_fecha.RETRIEVE() 

RETURN ll_total_mov 
















end function

public function integer f_inserta_mat_inscritas_modificadas ();
LONG ll_ttl_mov
LONG ll_pos


LONG ll_cuenta 
LONG ll_cuenta_ant 
LONG ll_materia 
STRING ls_grupo 
INTEGER le_cve_condicion 
INTEGER le_cve_condicion_mat_insc
INTEGER le_pos_mat 
INTEGER ll_pos_reportado
STRING ls_busqueda 
STRING ls_bandera_enc 
STRING ls_movimieto
INTEGER le_rec_status 
LONG ll_row_inserta 
INTEGER le_update
STRING ls_tipo_grupo 

LONG ll_cuenta_activa
LONG ll_materia_activa
STRING ls_grupo_activa
INTEGER le_cve_condicion_activa
STRING ls_tipo_grupo_activa



// Se carga la información para procesar 
f_carga_movmat_inscritas( )

ll_ttl_mov = ids_movmat_inscritas.ROWCOUNT() 


FOR ll_pos = 1 TO ll_ttl_mov 

	ls_movimieto = ids_movmat_inscritas.GETITEMSTRING(ll_pos, "movimiento")
	
	ll_cuenta = ids_movmat_inscritas.GETITEMNUMBER(ll_pos, "cuenta") 
	ll_materia = ids_movmat_inscritas.GETITEMNUMBER(ll_pos, "cve_mat")  
	ls_grupo = ids_movmat_inscritas.GETITEMSTRING(ll_pos, "gpo") 
	le_cve_condicion = ids_movmat_inscritas.GETITEMNUMBER(ll_pos, "cve_condicion") 
	ls_tipo_grupo = ids_movmat_inscritas.GETITEMSTRING(ll_pos, "tipo_grupo")	

	// Se verifica si hubo un cambio de cuenta
	IF ll_cuenta <> ll_cuenta_ant THEN 
		
//		ids_mat_inscritas_bit_fecha.SETFILTER("cuenta = " + STRING(ll_cuenta))
//		ids_mat_inscritas_bit_fecha.FILTER() 

		// Se filtra la nueva cuenta
		ids_mat_inscritas.SETFILTER("cuenta = " + STRING(ll_cuenta))
		ids_mat_inscritas.FILTER()		
		
		ll_cuenta_ant = ll_cuenta 
		
	END IF 	
	
	
	// Si es el registro que se inserta en el trigger, continua puesto que este es el registro tal cual se encuentra en mat_inscritas
	IF ls_movimieto = "IN" THEN 

		// Se agrega la materia inscrita como una modificación.
		ls_busqueda = "cuenta = " + STRING(ll_cuenta) + " AND cve_mat = " + STRING(ll_materia)   
		le_pos_mat = ids_mat_inscritas.FIND(ls_busqueda, 0, ids_mat_inscritas.ROWCOUNT() + 1)  
		IF 	le_pos_mat > 0 THEN 		
		
			ll_cuenta_activa = ids_mat_inscritas.GETITEMNUMBER(le_pos_mat, "cuenta") 
			ll_materia_activa = ids_mat_inscritas.GETITEMNUMBER(le_pos_mat, "cve_mat")  
			ls_grupo_activa = ids_mat_inscritas.GETITEMSTRING(le_pos_mat, "gpo") 
			le_cve_condicion_activa = ids_mat_inscritas.GETITEMNUMBER(le_pos_mat, "cve_condicion") 
			ls_tipo_grupo_activa = ids_mat_inscritas.GETITEMSTRING(le_pos_mat, "tipo_grupo")			
			
			IF ll_cuenta_activa = 177883 AND ll_materia = 21009 THEN 
				ll_cuenta_activa = 177883
			END IF
			
			
			ls_busqueda = "cuenta = " + STRING(ll_cuenta_activa) + " AND cve_mat = " + STRING(ll_materia_activa) + " AND gpo = '"	+ ls_grupo_activa + "' " + & 
								" AND estatus_reporte = " + STRING(2) + " AND cve_condicion = " + STRING(le_cve_condicion_activa) + " AND tipo_grupo = '" + ls_tipo_grupo_activa + "' " 
						
			ll_pos_reportado = ids_mat_inscritas_bit_fecha.FIND(ls_busqueda, 0, ids_mat_inscritas_bit_fecha.ROWCOUNT() + 1)  
	
			// Si no se ha reportado se agrega. 
			IF ll_pos_reportado <= 0 THEN 			
			
				// Se inserta renglón en rl histórico de D2L 
				ll_row_inserta = ids_mat_inscritas_bit_fecha.INSERTROW(0)
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "cuenta", ll_cuenta_activa)
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "cve_mat", ll_materia_activa)
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "gpo", ls_grupo_activa) 
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "periodo", ge_periodo) 
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "anio", ge_anio) 
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "fecha_reporte", gf_fecha_ejecucion)
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "estatus_reporte", 2)
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "cve_condicion", le_cve_condicion_activa)
				ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "tipo_grupo", ls_tipo_grupo_activa) 		
				
			END IF
		
		END IF		
		
		
		
		
		CONTINUE 
		
	END IF

	IF ll_cuenta = 202696 THEN 
		ll_cuenta = 202696
	END IF
	
	// Se busca la cuenta en las materias inscritas.
	ls_busqueda = "cuenta = " + STRING(ll_cuenta) + " AND cve_mat = " + STRING(ll_materia) + " AND gpo = '"	+ ls_grupo + "' AND tipo_grupo = '" + ls_tipo_grupo + "' "  
	le_pos_mat = ids_mat_inscritas.FIND(ls_busqueda, 0, ids_mat_inscritas.ROWCOUNT() + 1)  
	IF 	le_pos_mat > 0 THEN 
		le_cve_condicion_mat_insc = ids_mat_inscritas.GETITEMNUMBER(le_pos_mat, "cve_condicion") 
		IF ISNULL(le_cve_condicion_mat_insc) THEN le_cve_condicion_mat_insc = 4 /*Se asigna valor sin determinar*/ 
		ls_bandera_enc = "S"
	ELSE
		le_cve_condicion_mat_insc = -1  
		ls_bandera_enc = "N"
	END IF 
	
	// Si la encontró se verifica la situación del histórico.
	IF ls_bandera_enc = "S" THEN 
		
		// Si la condición actual es "normal" y es diferente a la del histórico se marca como create/update 
		IF le_cve_condicion_mat_insc = 0 AND le_cve_condicion_mat_insc <> le_cve_condicion THEN 
			le_rec_status = 2
		// Si la condición es normal	y es igual a la de la materia inscrita, se pasa al siguiente registro.
		ELSEIF le_cve_condicion_mat_insc = 0 AND le_cve_condicion_mat_insc = le_cve_condicion THEN 
			CONTINUE 
		// Cualquier otra condición actual es delete	 
		ELSE
			le_rec_status = 3
		END IF 
	
	// Si no la encuentra pone eliminar sin importar la condición.
	ELSE
		
		le_rec_status = 3
		
	END IF 
	
	// Se verifica que no se haya reportado antes. 
	ls_busqueda = "cuenta = " + STRING(ll_cuenta) + " AND cve_mat = " + STRING(ll_materia) + " AND gpo = '"	+ ls_grupo + "' " + & 
						" AND estatus_reporte = " + STRING(le_rec_status) + " AND cve_condicion = " + STRING(le_cve_condicion) + " AND tipo_grupo = '" + ls_tipo_grupo + "' " 
						
	ll_pos_reportado = ids_mat_inscritas_bit_fecha.FIND(ls_busqueda, 0, ids_mat_inscritas_bit_fecha.ROWCOUNT() + 1)  
	
	// Si no se ha reportado se agrega. 
	IF ll_pos_reportado <= 0 THEN 
		// Se inserta renglón en rl histórico de D2L 
		ll_row_inserta = ids_mat_inscritas_bit_fecha.INSERTROW(0)
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "cuenta", ll_cuenta)
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "cve_mat", ll_materia)
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "gpo", ls_grupo) 
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "periodo", ge_periodo) 
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "anio", ge_anio) 
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "fecha_reporte", gf_fecha_ejecucion)
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "estatus_reporte", le_rec_status)
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "cve_condicion", le_cve_condicion)
		ids_mat_inscritas_bit_fecha.SETITEM(ll_row_inserta, "tipo_grupo", ls_tipo_grupo) 
	END IF
	
NEXT

// Se hace la actualización de los registros modificados.
le_update = ids_mat_inscritas_bit_fecha.UPDATE() 
IF le_update < 0 THEN 
	ROLLBACK USING SQLCA;
	MESSAGEBOX("Error", "Se produjo un error al insertar los cambios en mat_inscritas" )
	RETURN -1
ELSE
	COMMIT USING SQLCA;
END IF


RETURN 0



end function

public function integer f_inserta_grupos_modificados ();LONG ll_ttl_grupos
LONG ll_pos 

LONG ll_cve_mat
STRING ls_gpo
INTEGER le_cond_gpo
LONG ll_cve_profesor, ll_cve_profesor_act
STRING ls_movimiento
STRING ls_cve_mat_gpo

INTEGER le_tipo
LONG ll_cve_mat_ant 
STRING ls_gpo_ant
STRING ls_busqueda 
LONG ll_pos_gpo
LONG ll_pos_gpo_bit, ll_row_insert
STRING ls_tipo_grupo

// Materia y grupo activos
LONG ll_cve_mat_act
STRING ls_gpo_act 


INTEGER le_cond_gpo_act
INTEGEr le_rec_estatus

//DATASTORE ids_grupos 
//DATASTORE ids_bit_grupos 
//DATASTORE ids_grupos_bit_fecha

f_carga_mov_grupos() 


ll_ttl_grupos = ids_bit_grupos.ROWCOUNT() 

// Se hace ciclo sobre los grupos modificados
FOR ll_pos = 1 TO ll_ttl_grupos  
	
	ls_cve_mat_gpo = ids_bit_grupos.GETITEMSTRING(ll_pos, "cve_mat_gpo")  
	ll_cve_mat = ids_bit_grupos.GETITEMNUMBER(ll_pos, "cve_mat") 
	ls_gpo = ids_bit_grupos.GETITEMSTRING(ll_pos, "gpo") 
	le_cond_gpo = ids_bit_grupos.GETITEMNUMBER(ll_pos, "cond_gpo") 
	ll_cve_profesor	= ids_bit_grupos.GETITEMNUMBER(ll_pos, "cve_profesor") 
	ls_movimiento = ids_bit_grupos.GETITEMSTRING(ll_pos, "movimiento") 
	le_tipo = ids_bit_grupos.GETITEMNUMBER(ll_pos, "tipo")  
	ls_tipo_grupo = ids_bit_grupos.GETITEMSTRING(ll_pos, "tipo_grupo")  


	// Se verifica el tipo de movimiento, si es el dato que se inserta corresponde al que esta en la tabla de grupos, por lo que se omite.
	IF ls_movimiento = "IN" THEN CONTINUE 

	// Se verifica si se trata del mismo grupo, si es diferente se asigna la llave al grupo anterior 
	IF ll_cve_mat <> ll_cve_mat_ant OR ls_gpo <> ls_gpo_ant THEN 
		ll_cve_mat_ant = ll_cve_mat
		ls_gpo_ant = ls_gpo			
	END IF 

	// Se busca este grupo en el ds. 
	ls_busqueda = "cve_mat = " + STRING(ll_cve_mat) + " AND gpo = '" + ls_gpo + "' AND tipo_grupo = '" + ls_tipo_grupo + "'" 
	ll_pos_gpo = ids_grupos.FIND(ls_busqueda, 0, ids_grupos.ROWCOUNT() + 1)  
	
	// Si hubo un cambio en el grupo
	IF ll_pos_gpo > 0 THEN 
		
		ll_cve_mat_act = ids_grupos.GETITEMNUMBER(ll_pos_gpo, "cve_mat") 
		ls_gpo_act = ids_grupos.GETITEMSTRING(ll_pos_gpo, "gpo")  
		le_cond_gpo_act = ids_grupos.GETITEMNUMBER(ll_pos_gpo, "cond_gpo") 
		ll_cve_profesor_act = ids_grupos.GETITEMNUMBER(ll_pos_gpo, "cve_profesor") 
		
		le_rec_estatus = 2 
		
	// Si no lo encuentra en la tabla grupos, asume que está eliminado  
	ELSE 
		
		// Se colocan valores por default 
		ll_cve_mat_act = 0
		ls_gpo_act = ''
		le_cond_gpo_act = 0
		ll_cve_profesor_act = 0
		
		le_rec_estatus = 3
		
	END IF

	// Se busca el registro en el ds de cambios. 
	ls_busqueda = 	"cve_mat = " + STRING(ll_cve_mat) + " AND gpo = '" + ls_gpo + "' AND cond_gpo = " + STRING(le_cond_gpo_act) + &  
						" AND cve_profesor = " + STRING(ll_cve_profesor_act) + " AND  estatus_reporte = " + STRING(le_rec_estatus) + " AND tipo_grupo = '" + ls_tipo_grupo + "'"   


	ll_pos_gpo_bit = ids_grupos_bit_fecha.FIND(ls_busqueda, 0, ids_grupos_bit_fecha.ROWCOUNT() + 1)  
	
	// Si encuentra el movimiento en grupo no inserta en bitacora de cambios y continúa el ciclo.
	IF ll_pos_gpo_bit > 0 THEN CONTINUE 
	
	// Se verifica si ha cambiado alguno de los valores significativos.
	IF le_cond_gpo_act <> le_cond_gpo OR ll_cve_profesor_act <> ll_cve_profesor THEN  
		
		// Se inserta el registro en la bitácora. 
		ll_row_insert = ids_grupos_bit_fecha.INSERTROW(0) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "cve_mat_gpo", ls_cve_mat_gpo) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "cve_mat", ll_cve_mat) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "gpo", ls_gpo)  
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "periodo", ge_periodo) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "anio", ge_anio) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "cond_gpo", le_cond_gpo_act) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "tipo", le_tipo) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "cve_profesor", ll_cve_profesor_act) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "fecha_reporte", gf_fecha_ejecucion) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "estatus_reporte", le_rec_estatus) 
		ids_grupos_bit_fecha.SETITEM(ll_row_insert, "tipo_grupo", ls_tipo_grupo) 
		
	END IF
	
	

NEXT

INTEGER le_update

// Se hace la actualización de los registros modificados.
le_update = ids_grupos_bit_fecha.UPDATE() 
IF le_update < 0 THEN 
	ROLLBACK USING SQLCA;
	MESSAGEBOX("Error", "Se produjo un error al insertar los cambios en grupos" )
	RETURN -1
ELSE
	COMMIT USING SQLCA;	
END IF



RETURN 0
end function

public function integer f_carga_mov_grupos ();LONG ll_grupos



ids_grupos = CREATE DATASTORE 
IF gs_plantel2 = "CDMX" THEN 
	ids_grupos.DATAOBJECT = "dw_grupos" 
ELSE
	ids_grupos.DATAOBJECT = "dw_grupos_tij" 
END IF
ids_grupos.SETTRANSOBJECT(SQLCA) 
ll_grupos = ids_grupos.RETRIEVE(ge_periodo, ge_anio)  

ids_bit_grupos = CREATE DATASTORE
IF gs_plantel2 = "CDMX" THEN 
	ids_bit_grupos.DATAOBJECT = "dw_grupos_bit"  
ELSE
	ids_bit_grupos.DATAOBJECT = "dw_grupos_bit_tij"  
END IF
ids_bit_grupos.SETTRANSOBJECT(SQLCA)
ll_grupos = ids_bit_grupos.RETRIEVE(gf_fecha_ejecucion, ge_periodo, ge_anio)

ids_grupos_bit_fecha = CREATE DATASTORE 
ids_grupos_bit_fecha.DATAOBJECT = "dw_archivo_grupos_bit_fec"
ids_grupos_bit_fecha.SETTRANSOBJECT(SQLCA) 
ll_grupos = ids_grupos_bit_fecha.RETRIEVE() 


RETURN 0 



end function

on uo_genera_xml_incremental.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_genera_xml_incremental.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
//SELECT periodo, anio  
//INTO :ge_periodo, :ge_anio  
//FROM periodos_por_procesos
//WHERE cve_proceso = 0 
//AND tipo_periodo = :gs_tipo_periodo 
//USING SQLCA;
//IF SQLCA.SQLCODE < 0 THEN 
//	MESSAGEBOX("Error", "Se produjo un error al recuperar el periodo activo: " + SQLCA.SQLERRTEXT) 
//	RETURN 0 
//END IF






end event

