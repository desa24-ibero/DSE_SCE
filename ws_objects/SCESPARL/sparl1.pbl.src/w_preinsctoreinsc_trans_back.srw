$PBExportHeader$w_preinsctoreinsc_trans_back.srw
forward
global type w_preinsctoreinsc_trans_back from window
end type
type st_direccion from statictext within w_preinsctoreinsc_trans_back
end type
type st_periodo from statictext within w_preinsctoreinsc_trans_back
end type
type st_1 from statictext within w_preinsctoreinsc_trans_back
end type
type st_estado from statictext within w_preinsctoreinsc_trans_back
end type
type cb_3 from commandbutton within w_preinsctoreinsc_trans_back
end type
type cb_2 from commandbutton within w_preinsctoreinsc_trans_back
end type
type cb_1 from commandbutton within w_preinsctoreinsc_trans_back
end type
end forward

global type w_preinsctoreinsc_trans_back from window
integer width = 2446
integer height = 664
boolean titlebar = true
string title = "Transferencia de Preinscripciones. "
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_direccion st_direccion
st_periodo st_periodo
st_1 st_1
st_estado st_estado
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
end type
global w_preinsctoreinsc_trans_back w_preinsctoreinsc_trans_back

type variables

n_tr itr_web


end variables

forward prototypes
public function integer w_transfiere (integer pe_direccion)
end prototypes

public function integer w_transfiere (integer pe_direccion);// Función de transferencia de información de mat_preinsc 
// Argumentos: pe_direccion (1 = Sybase -> SQL, 2 = SQL -> Sybase )


IF pe_direccion = 1 THEN 
	st_direccion.TEXT = "Dirección de Transferencia: Sybase -> SQL"
ELSE
	st_direccion.TEXT = "Dirección de Transferencia: SQL -> Sybase"
END IF

Open(w_confirma_usuario)

st_confirma_usuario lst_confirma_usuario

lst_confirma_usuario = Message.PowerObjectParm
IF not (lst_confirma_usuario.usuario = gs_usuario and lst_confirma_usuario.password = gs_password) THEN
	MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
	st_direccion.TEXT = ""
	RETURN -1
END IF

DATASTORE lds_sybase
DATASTORE lds_sql
DATASTORE lds_sql_rechazadas
DATASTORE lds_preinsc
DATASTORE lds_preinsc_syb

STRING ls_error
STRING ls_sql
STRING ls_sql_select
LONG ll_rows, ll_total 
LONG ll_row_actual 

LONG ll_cuenta 
LONG ll_cve_mat
STRING ls_gpo
INTEGER le_status
INTEGER le_periodo
INTEGER le_anio
LONG le_orden
INTEGER le_tipo
INTEGER le_proceso_preinsc
INTEGER le_copia 
LONG ll_row_ins

LONG ll_cuenta_pre
LONG ll_folio_pre
LONG ll_status_pre
LONG ll_periodo_pre
LONG ll_anio_pre
LONG ll_noimpresiones_pre


ls_sql_select = " SELECT mat_preinsc.cuenta, " + & 
         " mat_preinsc.cve_mat, " + &    
         " mat_preinsc.gpo, " + &    
         " mat_preinsc.status, " + &    
         " mat_preinsc.periodo, " + &    
         " mat_preinsc.anio, " + &    
         " mat_preinsc.orden, " + &    
		" 0 as tipo, " + & 	
         " mat_preinsc.proceso_preinsc " + &   
    " FROM mat_preinsc "    


lds_sybase = CREATE DATASTORE 
lds_sybase.DATAOBJECT = "d_mat_preinsc_transfer" 
lds_sybase.SETTRANSOBJECT(gtr_sce) 
lds_sybase.MODIFY("Datawindow.Table.Select = '" + ls_sql_select + "'")

lds_sql = CREATE DATASTORE 
lds_sql.DATAOBJECT = "d_mat_preinsc_transfer_sql" 
lds_sql.SETTRANSOBJECT(itr_web) 
//lds_sql.MODIFY("Datawindow.Table.Select = '" + ls_sql_select + "'")

//1 = Sybase -> SQL
IF pe_direccion = 1 THEN 

	// Se limpian las tablas de respaldo
	ls_sql = "DELETE FROM mat_preinsc_simulacion " 
	EXECUTE IMMEDIATE :ls_sql USING itr_web;
	IF itr_web.SQLCODE < 0 THEN 
		ls_error = itr_web.SQLERRTEXT
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1 
	END IF	

	// Se respalda la información
	ls_sql = "INSERT INTO mat_preinsc_simulacion(cuenta, cve_mat, gpo, status, periodo, " + &   
										"anio, orden, proceso_preinsc) " + &  
				"SELECT cuenta, cve_mat, gpo, status, periodo, " + &   
							"anio, orden, proceso_preinsc " + &   
				"FROM mat_preinsc " 
	EXECUTE IMMEDIATE :ls_sql USING itr_web;
	IF itr_web.SQLCODE < 0 THEN 
		ls_error = itr_web.SQLERRTEXT
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + ls_error) 
		RETURN -1
	END IF	
	

	// Se limpia mat_preinsc_aux para recibir la transferencia 
	ls_sql = "DELETE FROM mat_preinsc_aux "  
	EXECUTE IMMEDIATE :ls_sql USING itr_web;
	IF itr_web.SQLCODE < 0 THEN 
		ls_error = itr_web.SQLERRTEXT
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1
	END IF			
	
	// 	Se transfieren las materias preinscritas. 
	lds_sybase.MODIFY("Datawindow.Table.Select = '" + ls_sql_select + " WHERE status IN (254, 255)" + "'")   
	lds_sybase.SETTRANSOBJECT(gtr_sce)  
	ll_rows = lds_sybase.RETRIEVE() 
	
	GARBAGECOLLECT()
	
	lds_sql.DATAOBJECT = "d_mat_preinsc_transfer_sql" 
	lds_sql.SETTRANSOBJECT(itr_web) 	
	
	FOR ll_row_actual = 1 TO ll_rows
		
		ll_cuenta = lds_sybase.GETITEMNUMBER(ll_row_actual, "cuenta") 
		ll_cve_mat = lds_sybase.GETITEMNUMBER(ll_row_actual, "cve_mat") 	
		ls_gpo = lds_sybase.GETITEMSTRING(ll_row_actual, "gpo") 	
		le_status = lds_sybase.GETITEMNUMBER(ll_row_actual, "status") 	
		le_periodo = lds_sybase.GETITEMNUMBER(ll_row_actual, "periodo") 	
		le_anio = lds_sybase.GETITEMNUMBER(ll_row_actual, "anio") 	
		le_orden = lds_sybase.GETITEMNUMBER(ll_row_actual, "orden") 	
		le_tipo = lds_sybase.GETITEMNUMBER(ll_row_actual, "tipo") 	
		le_proceso_preinsc = lds_sybase.GETITEMNUMBER(ll_row_actual, "proceso_preinsc")  
		
		ll_row_ins = lds_sql.INSERTROW(0) 
		lds_sql.SETITEM(ll_row_ins, "cuenta", ll_cuenta) 
		lds_sql.SETITEM(ll_row_ins, "cve_mat", ll_cve_mat) 	
		lds_sql.SETITEM(ll_row_ins, "gpo", ls_gpo) 	
		lds_sql.SETITEM(ll_row_ins, "status", le_status) 	
		lds_sql.SETITEM(ll_row_ins, "periodo", le_periodo) 	
		lds_sql.SETITEM(ll_row_ins, "anio", le_anio) 	
		lds_sql.SETITEM(ll_row_ins, "orden", le_orden) 	
		lds_sql.SETITEM(ll_row_ins, "tipo", le_tipo) 	 
		lds_sql.SETITEM(ll_row_ins, "proceso_preinsc", le_proceso_preinsc)  
		
		st_estado.TEXT = "Registro materias Inscritas: " + STRING(ll_row_actual) + " de " + STRING(ll_rows)
		
	NEXT
	
	IF lds_sql.UPDATE() < 0 THEN 
		ls_error = itr_web.SQLERRTEXT
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1		
	END IF


	// Se limpia mat_preinsc_rechazadas 
	ls_sql = "DELETE FROM mat_preinsc_rechazadas " 
	EXECUTE IMMEDIATE :ls_sql USING itr_web;
	IF itr_web.SQLCODE < 0 THEN 
		ls_error = itr_web.SQLERRTEXT
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1
	END IF			

	// Se transfieren las materias rechazadas. 
	lds_sybase.MODIFY("Datawindow.Table.Select = '" + ls_sql_select + " WHERE status NOT IN (254, 255, 0)" + "'")   
	ll_rows = lds_sybase.RETRIEVE() 
	lds_sql_rechazadas = CREATE DATASTORE 
	lds_sql_rechazadas.DATAOBJECT = "dw_mat_preinscritas_rechazadas" 
	lds_sql_rechazadas.SETTRANSOBJECT(itr_web)

	FOR ll_row_actual = 1 TO ll_rows
		
		ll_cuenta = lds_sybase.GETITEMNUMBER(ll_row_actual, "cuenta") 
		ll_cve_mat = lds_sybase.GETITEMNUMBER(ll_row_actual, "cve_mat") 	
		ls_gpo = lds_sybase.GETITEMSTRING(ll_row_actual, "gpo") 	
		le_status = lds_sybase.GETITEMNUMBER(ll_row_actual, "status") 	
		le_periodo = lds_sybase.GETITEMNUMBER(ll_row_actual, "periodo") 	
		le_anio = lds_sybase.GETITEMNUMBER(ll_row_actual, "anio") 	
		le_orden = lds_sybase.GETITEMNUMBER(ll_row_actual, "orden") 	
		le_tipo = lds_sybase.GETITEMNUMBER(ll_row_actual, "tipo") 	
		le_proceso_preinsc = lds_sybase.GETITEMNUMBER(ll_row_actual, "proceso_preinsc")  
		
		ll_row_ins = lds_sql_rechazadas.INSERTROW(0) 
		lds_sql_rechazadas.SETITEM(ll_row_ins, "cuenta", ll_cuenta) 
		lds_sql_rechazadas.SETITEM(ll_row_ins, "cve_mat", ll_cve_mat) 	
		lds_sql_rechazadas.SETITEM(ll_row_ins, "gpo", ls_gpo) 	
		lds_sql_rechazadas.SETITEM(ll_row_ins, "status", le_status) 	
		lds_sql_rechazadas.SETITEM(ll_row_ins, "periodo", le_periodo) 	
		lds_sql_rechazadas.SETITEM(ll_row_ins, "anio", le_anio) 	
		lds_sql_rechazadas.SETITEM(ll_row_ins, "orden", le_orden) 	
		lds_sql_rechazadas.SETITEM(ll_row_ins, "tipo", le_tipo) 	 
		lds_sql_rechazadas.SETITEM(ll_row_ins, "proceso_preinsc", le_proceso_preinsc)  
		
		st_estado.TEXT = "Registro materias rechazadas : " + STRING(ll_row_actual) + " de " + STRING(ll_rows)
		
	NEXT	
	
	st_estado.TEXT = "Actualizando en SQLSERVER ... "
	
	IF lds_sql_rechazadas.UPDATE() < 0 THEN 
		ls_error = itr_web.SQLERRTEXT 
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1		
	END IF


	// Se limpia mat_preinsc 	
	ls_sql = " DELETE FROM mat_preinsc WHERE EXISTS (SELECT * FROM mat_preinsc_aux " + & 
				" WHERE mat_preinsc.cuenta = mat_preinsc_aux.cuenta " + &   
				" AND mat_preinsc.cve_mat = mat_preinsc_aux.cve_mat " + & 
				" AND mat_preinsc.gpo = mat_preinsc_aux.gpo collate SQL_Latin1_General_CP1_CI_AS " + & 
				" AND mat_preinsc.periodo = mat_preinsc_aux.periodo " + & 
				" AND mat_preinsc.anio = mat_preinsc_aux.anio " + & 
				" AND mat_preinsc.orden = mat_preinsc_aux.orden ) " + &
				" OR EXISTS (SELECT * FROM mat_preinsc_rechazadas " + & 
				" WHERE mat_preinsc.cuenta = mat_preinsc_rechazadas.cuenta  " + &   
				" AND mat_preinsc.cve_mat = mat_preinsc_rechazadas.cve_mat " + & 
				" AND mat_preinsc.gpo = mat_preinsc_rechazadas.gpo  collate SQL_Latin1_General_CP1_CI_AS " + & 
				" AND mat_preinsc.periodo = mat_preinsc_rechazadas.periodo " + & 
				" AND mat_preinsc.anio = mat_preinsc_rechazadas.anio " + & 
				" AND mat_preinsc.orden = mat_preinsc_rechazadas.orden ) " 
				
	EXECUTE IMMEDIATE :ls_sql USING itr_web;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1
	END IF		

	// Se copia la información a la tabla productiva. 
	ls_sql = "INSERT INTO mat_preinsc(cuenta, cve_mat, gpo, status, periodo, " + &   
										"anio, orden, proceso_preinsc) " + &  
				"SELECT cuenta, cve_mat, gpo, status, periodo, " + &   
							"anio, orden, proceso_preinsc " + &   
				"FROM mat_preinsc_aux "  
	EXECUTE IMMEDIATE :ls_sql USING itr_web;
	IF itr_web.SQLCODE < 0 THEN 
		ls_error = itr_web.SQLERRTEXT
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + ls_error)  
		RETURN -1
	END IF	


	// Se actualiza el orden
	ls_sql = " UPDATE mat_preinsc " + &    
				" SET orden = isnull( (SELECT orden " + &    
				" FROM mat_preinsc_aux au " + &    
				" WHERE au.cuenta = mat_preinsc.cuenta " + &    
				" AND au.cve_mat = mat_preinsc.cve_mat " + &    
				" AND au.gpo = mat_preinsc.gpo collate SQL_Latin1_General_CP1_CI_AS " + &   
				" AND au.periodo = mat_preinsc.periodo " + &   
				" AND au.anio = mat_preinsc.anio), orden) "  
	EXECUTE IMMEDIATE :ls_sql USING itr_web;
	IF itr_web.SQLCODE < 0 THEN 
		ls_error = itr_web.SQLERRTEXT
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + ls_error)  
		RETURN -1
	END IF		


	COMMIT USING itr_web; 
	
	
//2 = SQL -> Sybase 
ELSE 
	
	// Se limpian las tablas de respaldo
	ls_sql = "DELETE FROM mat_preinsc_simulacion " 
	EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1 
	END IF	

//	// Se respalda la información
//	ls_sql = "INSERT INTO mat_preinsc_simulacion(cuenta, cve_mat, gpo, status, periodo, " + &   
//										"anio, orden, proceso_preinsc) " + &  
//				"SELECT cuenta, cve_mat, gpo, status, periodo, " + &   
//							"anio, orden, proceso_preinsc " + &   
//				"FROM mat_preinsc " 
//	EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
//	IF gtr_sce.SQLCODE < 0 THEN 
//		ls_error = gtr_sce.SQLERRTEXT 
//		ROLLBACK USING gtr_sce;
//		MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + ls_error) 
//		RETURN -1
//	END IF	
	
	// Se limpia mat_preinsc 	
	ls_sql = "DELETE FROM mat_preinsc_aux " 
	EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1
	END IF			
	
	ls_sql = "DELETE FROM preinsc " 
	EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1
	END IF			
	
	
	lds_preinsc_syb = CREATE DATASTORE 
	lds_preinsc_syb.DATAOBJECT = "d_preinsc_trans_syb" 
	lds_preinsc_syb.SETTRANSOBJECT(gtr_sce) 
	
	lds_preinsc = CREATE DATASTORE 
	lds_preinsc.DATAOBJECT = "d_preinsc_trans" 
	lds_preinsc.SETTRANSOBJECT(itr_web)
	//lds_preinsc.RETRIEVE()
	IF lds_preinsc.RETRIEVE() < 0 THEN 
		ls_error = itr_web.SQLERRTEXT 
		ROLLBACK USING itr_web;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1		
	END IF	
	ll_rows = lds_preinsc.ROWCOUNT() 
	
	FOR ll_row_actual = 1 TO ll_rows
		
		ll_cuenta_pre = lds_preinsc.GETITEMNUMBER(ll_row_actual, "cuenta")
		ll_folio_pre = lds_preinsc.GETITEMNUMBER(ll_row_actual, "folio")
		ll_status_pre = lds_preinsc.GETITEMNUMBER(ll_row_actual, "status")
		ll_periodo_pre = lds_preinsc.GETITEMNUMBER(ll_row_actual, "periodo")
		ll_anio_pre = lds_preinsc.GETITEMNUMBER(ll_row_actual, "anio")
		ll_noimpresiones_pre = lds_preinsc.GETITEMNUMBER(ll_row_actual, "noimpresiones") 
	
		ll_row_ins = lds_preinsc_syb.INSERTROW(0) 
		lds_preinsc_syb.SETITEM(ll_row_ins, "cuenta",  ll_cuenta_pre)
		lds_preinsc_syb.SETITEM(ll_row_ins, "folio",  ll_folio_pre)
		lds_preinsc_syb.SETITEM(ll_row_ins, "status",  ll_status_pre)
		lds_preinsc_syb.SETITEM(ll_row_ins, "periodo",  ll_periodo_pre)
		lds_preinsc_syb.SETITEM(ll_row_ins, "anio",  ll_anio_pre)
		lds_preinsc_syb.SETITEM(ll_row_ins, "noimpresiones",  ll_noimpresiones_pre)
		
		st_estado.TEXT = "Registro Preinscripción: " + STRING(ll_row_actual) + " de " + STRING(ll_rows)		
		
	NEXT

	// Se inserta preinsc 
	IF lds_preinsc_syb.UPDATE() < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error) 
		RETURN -1		
	END IF		
	
	
	lds_sql = CREATE DATASTORE 
	lds_sql.DATAOBJECT = "d_mat_preinsc_transfer_sql2" 
	lds_sql.SETTRANSOBJECT(itr_web) 	
	IF lds_sql.RETRIEVE() < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1		
	END IF

	ll_rows = lds_sql.ROWCOUNT()

	FOR ll_row_actual = 1 TO ll_rows
		
		ll_cuenta = lds_sql.GETITEMNUMBER(ll_row_actual, "cuenta") 
		ll_cve_mat = lds_sql.GETITEMNUMBER(ll_row_actual, "cve_mat") 	
		ls_gpo = lds_sql.GETITEMSTRING(ll_row_actual, "gpo") 	
		le_status = lds_sql.GETITEMNUMBER(ll_row_actual, "status") 	
		le_periodo = lds_sql.GETITEMNUMBER(ll_row_actual, "periodo") 	
		le_anio = lds_sql.GETITEMNUMBER(ll_row_actual, "anio") 	
		le_orden = lds_sql.GETITEMNUMBER(ll_row_actual, "orden") 	
		le_tipo = lds_sql.GETITEMNUMBER(ll_row_actual, "tipo") 	
		le_proceso_preinsc = lds_sql.GETITEMNUMBER(ll_row_actual, "proceso_preinsc")  
		
		
		ll_row_ins = lds_sybase.INSERTROW(0) 
		lds_sybase.SETITEM(ll_row_ins, "cuenta", ll_cuenta) 
		lds_sybase.SETITEM(ll_row_ins, "cve_mat", ll_cve_mat) 	
		lds_sybase.SETITEM(ll_row_ins, "gpo", ls_gpo) 	
		lds_sybase.SETITEM(ll_row_ins, "status", le_status) 	
		lds_sybase.SETITEM(ll_row_ins, "periodo", le_periodo) 	
		lds_sybase.SETITEM(ll_row_ins, "anio", le_anio) 	
		lds_sybase.SETITEM(ll_row_ins, "orden", le_orden) 	
		lds_sybase.SETITEM(ll_row_ins, "tipo", le_tipo) 	 
		lds_sybase.SETITEM(ll_row_ins, "proceso_preinsc", le_proceso_preinsc)  
		
		st_estado.TEXT = "Registro materias Inscritas: " + STRING(ll_row_actual) + " de " + STRING(ll_rows)

		INSERT INTO mat_preinsc_aux(cuenta, cve_mat, gpo, status, periodo, anio, orden,  proceso_preinsc)
		VALUES (:ll_cuenta, :ll_cve_mat, :ls_gpo, :le_status, :le_periodo, :le_anio, :le_orden, :le_proceso_preinsc)
		USING gtr_sce;
		IF gtr_sce.SQLCODE < 0 THEN 
			ls_error = gtr_sce.SQLERRTEXT
			ROLLBACK USING gtr_sce;
			MESSAGEBOX("Error", "Se produjo un error al insertar en SQL Sqerver: " + ls_error )  
			RETURN -1 
		END IF		
		
	NEXT

	// Se limpia mat_preinsc 	
	ls_sql = " DELETE FROM mat_preinsc "
	
	EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + ls_error)
		RETURN -1
	END IF		
	
	ls_sql = "INSERT INTO mat_preinsc(cuenta, cve_mat, gpo, status, periodo, " + &   
										"anio, orden, proceso_preinsc) " + &  
				"SELECT cuenta, cve_mat, gpo, status, periodo, " + &   
							"anio, orden, proceso_preinsc " + &   
				"FROM mat_preinsc_aux "  
	EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + ls_error) 
		RETURN -1
	END IF		
	
	ls_sql = " UPDATE mat_preinsc " + &    
				" SET orden = isnull( (SELECT orden " + &    
				" FROM mat_preinsc_aux au " + &    
				" WHERE au.cuenta = mat_preinsc.cuenta " + &    
				" AND au.cve_mat = mat_preinsc.cve_mat " + &    
				" AND au.gpo = mat_preinsc.gpo " + &   
				" AND au.periodo = mat_preinsc.periodo " + &   
				" AND au.anio = mat_preinsc.anio), orden)  "  
	EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce;
		MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + ls_error) 
		RETURN -1
	END IF			
	
	
//	IF lds_sybase.UPDATE() < 0 THEN 
//		ROLLBACK USING gtr_sce;
//		MESSAGEBOX("Error", "Se produjo un error al transferir la información de preinscripciones: " + gtr_sce.SQLERRTEXT) 
//		RETURN -1		
//	END IF	

	COMMIT USING gtr_sce; 

END IF

st_estado.TEXT = "Transferencia Finalizada. " 

cb_2.ENABLED = FALSE
cb_1.ENABLED = FALSE

RETURN 0 





		//lds_sql.SetItemStatus(ll_row_actual, 0,Primary!, NewModified!)
		
//		INSERT INTO mat_preinsc(cuenta, cve_mat, gpo, status, periodo, anio, orden, tipo, proceso_preinsc)
//		VALUES (:ll_cuenta, :ll_cve_mat, :ls_gpo, :le_status, :le_periodo, :le_anio, :le_orden, :le_tipo, :le_proceso_preinsc)
//		USING itr_web;
//		IF itr_web.SQLCODE < 0 THEN 
//			ROLLBACK USING itr_web;
//			MESSAGEBOX("Error", "Se produjo un error al insertar en SQL Sqerver: " + itr_web.SQLERRTEXT) 
//			RETURN -1 
//		END IF

end function

on w_preinsctoreinsc_trans_back.create
this.st_direccion=create st_direccion
this.st_periodo=create st_periodo
this.st_1=create st_1
this.st_estado=create st_estado
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_direccion,&
this.st_periodo,&
this.st_1,&
this.st_estado,&
this.cb_3,&
this.cb_2,&
this.cb_1}
end on

on w_preinsctoreinsc_trans_back.destroy
destroy(this.st_direccion)
destroy(this.st_periodo)
destroy(this.st_1)
destroy(this.st_estado)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;
if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
	return
End if

STRING ls_periodo

SELECT	periodo,
		anio 
INTO	:g_per,
		:g_anio 
FROM		activacion_su 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción del periodo: " + gtr_sce.SQLERRTEXT) 
	RETURN -1
END IF



SELECT descripcion
INTO:ls_periodo
FROM periodo 
WHERE periodo = :g_per 
USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción del periodo: " + gtr_sce.SQLERRTEXT) 
	RETURN -1
END IF

st_periodo.TEXT = ls_periodo + " - " + STRING(g_anio) 






end event

event closequery;DISCONNECT USING itr_web;



end event

type st_direccion from statictext within w_preinsctoreinsc_trans_back
integer x = 46
integer y = 460
integer width = 1637
integer height = 72
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_periodo from statictext within w_preinsctoreinsc_trans_back
integer x = 841
integer y = 360
integer width = 809
integer height = 76
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_1 from statictext within w_preinsctoreinsc_trans_back
integer x = 59
integer y = 360
integer width = 782
integer height = 72
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Periodo que se transfiere: "
boolean focusrectangle = false
end type

type st_estado from statictext within w_preinsctoreinsc_trans_back
integer x = 59
integer y = 64
integer width = 1591
integer height = 284
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Comenzar transferencia..."
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_preinsctoreinsc_trans_back
integer x = 1705
integer y = 392
integer width = 663
integer height = 112
integer taborder = 1
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;
CLOSE(PARENT)


end event

type cb_2 from commandbutton within w_preinsctoreinsc_trans_back
integer x = 1705
integer y = 60
integer width = 663
integer height = 112
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SQL >>  SYBASE"
end type

event clicked;
IF MESSAGEBOX("Confirmación", "Se realizará la transferencia de materias inscritas de SQL Server a SYBASE. ¿Desea Continuar?", Question!, OKCancel!) = 2 THEN RETURN 
w_transfiere(2)


end event

type cb_1 from commandbutton within w_preinsctoreinsc_trans_back
integer x = 1705
integer y = 196
integer width = 663
integer height = 112
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "SYBASE  >> SQL"
end type

event clicked;
IF MESSAGEBOX("Confirmación", "Se realizará la transferencia de materias inscritas de SYBASE a SQL Server. ¿Desea Continuar?", Question!, OKCancel!) = 2 THEN RETURN 

w_transfiere(1)
end event

