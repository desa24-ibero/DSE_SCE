$PBExportHeader$w_cortes_archivo.srw
forward
global type w_cortes_archivo from w_main
end type
type cbx_cortes_simulacion from checkbox within w_cortes_archivo
end type
type cb_inicia_tablas from commandbutton within w_cortes_archivo
end type
type cbx_integracion_sim from u_cbx within w_cortes_archivo
end type
type cbx_servicio_social_sim from u_cbx within w_cortes_archivo
end type
type cbx_promedio_creditos_sin_bloqueo from u_cbx within w_cortes_archivo
end type
type cb_3 from u_cb within w_cortes_archivo
end type
type st_avance from u_st within w_cortes_archivo
end type
type st_procesamiento from u_st within w_cortes_archivo
end type
type cbx_egresado from u_cbx within w_cortes_archivo
end type
type cbx_integracion from u_cbx within w_cortes_archivo
end type
type cbx_servicio_social from u_cbx within w_cortes_archivo
end type
type cbx_promedio_creditos from u_cbx within w_cortes_archivo
end type
type cb_2 from u_cb within w_cortes_archivo
end type
type dw_cortes_cuentas from u_dw within w_cortes_archivo
end type
type uo_1 from uo_per_ani within w_cortes_archivo
end type
type cb_1 from u_cb within w_cortes_archivo
end type
type st_texto_ruta from u_st within w_cortes_archivo
end type
type sle_ruta_archivo from u_sle within w_cortes_archivo
end type
type cb_buscar_archivo from u_cb within w_cortes_archivo
end type
type dw_cuentas_archivo_cortes from u_dw within w_cortes_archivo
end type
type gb_1 from u_gb within w_cortes_archivo
end type
type gb_2 from u_gb within w_cortes_archivo
end type
end forward

global type w_cortes_archivo from w_main
integer width = 4384
integer height = 1600
string title = "Cortes por Archivo"
cbx_cortes_simulacion cbx_cortes_simulacion
cb_inicia_tablas cb_inicia_tablas
cbx_integracion_sim cbx_integracion_sim
cbx_servicio_social_sim cbx_servicio_social_sim
cbx_promedio_creditos_sin_bloqueo cbx_promedio_creditos_sin_bloqueo
cb_3 cb_3
st_avance st_avance
st_procesamiento st_procesamiento
cbx_egresado cbx_egresado
cbx_integracion cbx_integracion
cbx_servicio_social cbx_servicio_social
cbx_promedio_creditos cbx_promedio_creditos
cb_2 cb_2
dw_cortes_cuentas dw_cortes_cuentas
uo_1 uo_1
cb_1 cb_1
st_texto_ruta st_texto_ruta
sle_ruta_archivo sle_ruta_archivo
cb_buscar_archivo cb_buscar_archivo
dw_cuentas_archivo_cortes dw_cuentas_archivo_cortes
gb_1 gb_1
gb_2 gb_2
end type
global w_cortes_archivo w_cortes_archivo

type variables
string is_nombre_archivo= ""
n_cortes in_cortes
n_cortes_sim in_cortes_sim
datetime ldtm_fecha_inicial, ldtm_fecha_final

end variables

forward prototypes
public function integer wf_carga_prerreq_alumnos ()
public function integer wf_corte_alumnos ()
public function integer wf_habilita ()
end prototypes

public function integer wf_carga_prerreq_alumnos ();// wf_carga_prerreq_alumnos
//Carga los prerrequisitos de los alumnos
integer li_return_carga
string ls_mensaje 
long ll_cuentas[], ll_row, ll_rows, ll_cuenta, ll_row2, ll_rows2
long ll_found, ll_row_insert
String  	Nivel, ls_nombre_completo
Long 	Plan, Carrera, ll_cve_mat
Integer li_carrera_plan, li_nombre_completo
Long ll_cve_carrera, ll_cve_plan

dw_cuentas_archivo_cortes.Reset()
dw_cortes_cuentas.Reset()

IF cbx_cortes_simulacion.CHECKED THEN 
	
	dw_cuentas_archivo_cortes.MODIFY("Datawindow.Table.SELECT = ' SELECT cuenta FROM preinsc ' ") 
	dw_cuentas_archivo_cortes.SETTRANSOBJECT(gtr_sce) 
	IF dw_cuentas_archivo_cortes.RETRIEVE() < 0 THEN 
		MessageBox("Error al recuperar las materias preinscritas. ", ls_mensaje, StopSign!)
		dw_cuentas_archivo_cortes.Reset()
		RETURN -1			
	END IF 
	
ELSE 	
	
	
	li_return_carga = dw_cuentas_archivo_cortes.ImportFile(is_nombre_archivo)
	
	//Valida que no haya cuentas 0 o vacias
	IF li_return_carga> 0 THEN
		ll_rows = dw_cuentas_archivo_cortes.RowCount()
		FOR ll_row = 1 TO ll_rows
			ll_cuenta = dw_cuentas_archivo_cortes.GetItemNumber(ll_row, "cuenta")
			IF ll_cuenta= 0 OR ISNULL(ll_cuenta) THEN
				li_return_carga= -4
			END IF
		NEXT
	END IF
	
	IF li_return_carga  < 0 THEN
		
		CHOOSE CASE li_return_carga
			CASE -1  
				ls_mensaje = "No hay registros"
			CASE -2  
				ls_mensaje = "Archivo Vacío"
			CASE -3  
				ls_mensaje = "Argumento Inválido"
			CASE -4  
				ls_mensaje = "Entrada Invalida"
			CASE -5  
				ls_mensaje = "No es posible abrir el archivo"
			CASE -6  
				ls_mensaje = "No es posible cerrar el archivo"
			CASE -7  
				ls_mensaje = "Error leyendo el archivo"
			CASE -8  
				ls_mensaje = "No es un archivo TXT"
			CASE -9  
				ls_mensaje = "El usuario canceló la importación"
			CASE -10
				ls_mensaje = "Formato de archivo dBase no soportado (not version 2 or 3)"
			CASE -11 
				ls_mensaje = "XML Parsing Error; XML parser libraries not found or XML not well formed"
			CASE -12
				ls_mensaje = "XML Template does not exist or does not match the DataWindow"
			CASE -13
				ls_mensaje = "Unsupported DataWindow style for import"
			CASE -14
				ls_mensaje = "Error resolving DataWindow nesting"
			CASE ELSE
				ls_mensaje = "Error desconocido"
		END CHOOSE
		MessageBox("Error en la carga del archivo", ls_mensaje, StopSign!)
		dw_cuentas_archivo_cortes.Reset()
		RETURN -1	
	END IF

END IF 

ll_cve_mat = 4078

ll_rows = dw_cuentas_archivo_cortes.RowCount() 
IF ll_rows = 0 THEN RETURN -1
FOR ll_row = 1 TO ll_rows
	ll_cuenta = dw_cuentas_archivo_cortes.GetItemNumber(ll_row, "cuenta")
	ll_cuentas[ll_row] = ll_cuenta
NEXT

ll_rows2 = dw_cortes_cuentas.Retrieve(ll_cuentas)

STRING ls_tipo_periodo 

FOR ll_row = 1 TO ll_rows
	ll_cuenta = dw_cuentas_archivo_cortes.GetItemNumber(ll_row, "cuenta")

	// Se verifica que el tipo de periodo del alumno sea igual al del contexto de trabajo. 
	SELECT pe.tipo_periodo 
	INTO :ls_tipo_periodo 
	FROM academicos ac, plan_estudios pe 
	WHERE ac.cuenta = :ll_cuenta 
	AND ac.cve_plan = pe.cve_plan 
	AND ac.cve_carrera = pe.cve_carrera  
	USING gtr_sce; 
	// Se verifica que sea el mismo tipo de periodo. 
	IF ls_tipo_periodo <> gs_tipo_periodo THEN 
		MESSAGEBOX("Aviso", "El alumno con la cuenta: " + STRING(ll_cuenta) + " no corresponde a un periodo de tipo " + gs_descripcion_tipo_periodo + ".", Exclamation!)		
		dw_cuentas_archivo_cortes.Reset()
		RETURN -1			
	END IF
	
	ll_found  = dw_cortes_cuentas.Find("cuenta ="+string(ll_cuenta), 1, ll_rows)
	li_carrera_plan = in_cortes.of_obten_carrera_plan(ll_cuenta, ll_cve_carrera , ll_cve_plan)
	
	IF li_carrera_plan = -1 THEN
		dw_cortes_cuentas.Reset()
		RETURN -1
	END IF

	li_nombre_completo = in_cortes.of_obten_nombre_completo(ll_cuenta, ls_nombre_completo)
	
	
	IF li_nombre_completo = -1 THEN
		dw_cortes_cuentas.Reset()
		RETURN -1
	END IF
		
//	IF ll_found<=0 THEN
		ll_row_insert = dw_cortes_cuentas.InsertRow(0)
		
		dw_cortes_cuentas.SetItem(ll_row_insert, "cuenta", ll_cuenta)
		dw_cortes_cuentas.SetItem(ll_row_insert, "cve_plan", ll_cve_plan) 
		dw_cortes_cuentas.SetItem(ll_row_insert, "cve_carrera", ll_cve_carrera)      
		dw_cortes_cuentas.SetItem(ll_row_insert, "nombre_completo", ls_nombre_completo)      
//	ELSE
//		dw_cortes_cuentas.SelectRow (ll_found, true)
//	END IF
	
NEXT


RETURN 0

end function

public function integer wf_corte_alumnos ();// wf_corte_alumnos
//Efectua los cortes de los alumnos
integer li_return_carga
string ls_mensaje 
long ll_cuentas[], ll_row, ll_rows, ll_cuenta, ll_row2, ll_rows2
long ll_found, ll_row_insert
String Nivel, ls_nombre_completo
Long 	Plan, Carrera, ll_cve_mat
Integer li_carrera_plan, li_nombre_completo
Long ll_cve_carrera, ll_cve_plan
Integer ai_ya_puede_int, ai_ya_curso_int
Integer ai_ya_puede_ss, ai_ya_curso_ss
decimal ld_promedio, ldc_creditos
long ll_cve_flag_promedio
int li_corte_promedio_creditos
int li_corte_servicio_social
int li_corte_integracion
int li_corte_egresado, li_egresado, li_actualiza_periodo_egreso 

ll_rows = dw_cortes_cuentas.RowCount()

FOR ll_row = 1 TO ll_rows
	
	st_procesamiento.text = string(ll_row)+"/"+string(ll_rows)
	dw_cortes_cuentas.ScrollToRow(ll_row)
	ll_cuenta = dw_cortes_cuentas.GetItemNumber(ll_row, "cuenta")
	ll_cve_carrera = dw_cortes_cuentas.GetItemNumber(ll_row, "cve_carrera")
	ll_cve_plan = dw_cortes_cuentas.GetItemNumber(ll_row, "cve_plan")
	
	// Promedio y Créditos
	IF cbx_promedio_creditos.Checked THEN
		li_corte_promedio_creditos = in_cortes.of_corte_promedio_creditos( ll_cuenta, ll_cve_carrera, ll_cve_plan, ld_promedio, ldc_creditos, ll_cve_flag_promedio)
		IF li_corte_promedio_creditos = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_promedio_creditos",1)
			dw_cortes_cuentas.SetItem(ll_row, "promedio",ld_promedio)
			dw_cortes_cuentas.SetItem(ll_row, "creditos",ldc_creditos)
		END IF
	END IF
	
	// Servicio Social
	IF cbx_servicio_social.Checked THEN
		li_corte_servicio_social = in_cortes.of_corte_servicio_social(  ll_cuenta, ll_cve_carrera, ll_cve_plan, ai_ya_puede_ss, ai_ya_curso_ss)
		IF li_corte_servicio_social = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_servicio_social",1)
			dw_cortes_cuentas.SetItem(ll_row, "puede_ss",ai_ya_puede_ss)
			dw_cortes_cuentas.SetItem(ll_row, "curso_ss",ai_ya_curso_ss)
		END IF
	END IF
	
	// Integración
	IF cbx_integracion.Checked THEN
		li_corte_integracion = in_cortes.of_corte_integracion(  ll_cuenta, ll_cve_carrera, ll_cve_plan, ai_ya_puede_int, ai_ya_curso_int)
		IF li_corte_integracion = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_integracion",1)
			dw_cortes_cuentas.SetItem(ll_row, "puede_integ",ai_ya_puede_int)
			dw_cortes_cuentas.SetItem(ll_row, "curso_integ",ai_ya_curso_int)
		END IF
	END IF
	
	//Egresado
	IF cbx_egresado.Checked THEN
		//Se solicita que si un alumno ya es egresado, no actualice su periodo y anio de egreso
		li_corte_egresado = in_cortes.of_corte_egresado(  ll_cuenta, ll_cve_carrera, ll_cve_plan, gi_periodo, gi_anio, li_egresado)
		IF li_corte_egresado = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_egresado",1)
			dw_cortes_cuentas.SetItem(ll_row, "egresad",li_egresado)
			IF li_egresado = 1 THEN
				dw_cortes_cuentas.SetItem(ll_row, "periodo_egre",gi_periodo)
				dw_cortes_cuentas.SetItem(ll_row, "anio_egre",gi_anio)
			END IF
		END IF
	END IF
	
	// Promedio y Créditos sin bloqueo
	IF cbx_promedio_creditos_sin_bloqueo.Checked THEN
		li_corte_promedio_creditos = in_cortes.of_corte_promedio_creditos_sb( ll_cuenta, ll_cve_carrera, ll_cve_plan, ld_promedio, ldc_creditos)
		IF li_corte_promedio_creditos = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_promedio_creditos_sb",1)
			dw_cortes_cuentas.SetItem(ll_row, "promedio",ld_promedio)
			dw_cortes_cuentas.SetItem(ll_row, "creditos",ldc_creditos)
		END IF
	END IF
	
	
	//**--**
	
	// Servicio Social
	IF cbx_servicio_social_sim.Checked THEN
		
		IF not isvalid(in_cortes_sim) THEN
			in_cortes_sim = CREATE n_cortes_sim
		END IF		
		
		li_corte_servicio_social = in_cortes_sim.of_corte_servicio_social(  ll_cuenta, ll_cve_carrera, ll_cve_plan, ai_ya_puede_ss, ai_ya_curso_ss)
		IF li_corte_servicio_social = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_servicio_social",1)
			dw_cortes_cuentas.SetItem(ll_row, "puede_ss",ai_ya_puede_ss)
			dw_cortes_cuentas.SetItem(ll_row, "curso_ss",ai_ya_curso_ss)
		END IF
	END IF
	
	// Integración
	IF cbx_integracion_sim.Checked THEN 
		
		IF not isvalid(in_cortes_sim) THEN
			in_cortes_sim = CREATE n_cortes_sim
		END IF		
		
		li_corte_integracion = in_cortes_sim.of_corte_integracion(  ll_cuenta, ll_cve_carrera, ll_cve_plan, ai_ya_puede_int, ai_ya_curso_int)
		IF li_corte_integracion = -1 THEN
			dw_cortes_cuentas.SelectRow (ll_row, true)
			RETURN -1
		ELSE
			dw_cortes_cuentas.SetItem(ll_row, "c_integracion",1)
			dw_cortes_cuentas.SetItem(ll_row, "puede_integ",ai_ya_puede_int)
			dw_cortes_cuentas.SetItem(ll_row, "curso_integ",ai_ya_curso_int)
		END IF
	END IF	
	
	//**--**
	
NEXT


RETURN 0

end function

public function integer wf_habilita ();// Si se trata de cortes reales
IF cbx_cortes_simulacion.CHECKED THEN 
	
	gb_2.ENABLED = TRUE 
	cb_inicia_tablas.ENABLED = TRUE 
	cbx_servicio_social_sim.ENABLED = TRUE 
	cbx_integracion_sim.ENABLED = TRUE 
	
	gb_1.ENABLED = FALSE 
	cb_buscar_archivo.ENABLED = FALSE 
	st_texto_ruta.ENABLED = FALSE 
	sle_ruta_archivo.ENABLED = FALSE 
	//cb_1.ENABLED = FALSE 
	cbx_promedio_creditos.ENABLED = FALSE 
	cbx_servicio_social.ENABLED = FALSE 
	cbx_integracion.ENABLED = FALSE 
	cbx_egresado.ENABLED = FALSE 
	cbx_promedio_creditos_sin_bloqueo.ENABLED = FALSE 	
	
// Si se trata de cortes para simulación 
ELSE 
	
	gb_2.ENABLED = FALSE 
	cb_inicia_tablas.ENABLED = FALSE
	cbx_servicio_social_sim.ENABLED = FALSE 
	cbx_integracion_sim.ENABLED = FALSE 	
	
	gb_1.ENABLED = TRUE 
	cb_buscar_archivo.ENABLED = TRUE 
	st_texto_ruta.ENABLED = TRUE 
	sle_ruta_archivo.ENABLED = TRUE 
	//cb_1.ENABLED = TRUE 
	cbx_promedio_creditos.ENABLED = TRUE 
	cbx_servicio_social.ENABLED = TRUE 
	cbx_integracion.ENABLED = TRUE 
	cbx_egresado.ENABLED = TRUE 
	cbx_promedio_creditos_sin_bloqueo.ENABLED = TRUE 	
	
	
END IF 	 


RETURN 0 
end function

on w_cortes_archivo.create
int iCurrent
call super::create
this.cbx_cortes_simulacion=create cbx_cortes_simulacion
this.cb_inicia_tablas=create cb_inicia_tablas
this.cbx_integracion_sim=create cbx_integracion_sim
this.cbx_servicio_social_sim=create cbx_servicio_social_sim
this.cbx_promedio_creditos_sin_bloqueo=create cbx_promedio_creditos_sin_bloqueo
this.cb_3=create cb_3
this.st_avance=create st_avance
this.st_procesamiento=create st_procesamiento
this.cbx_egresado=create cbx_egresado
this.cbx_integracion=create cbx_integracion
this.cbx_servicio_social=create cbx_servicio_social
this.cbx_promedio_creditos=create cbx_promedio_creditos
this.cb_2=create cb_2
this.dw_cortes_cuentas=create dw_cortes_cuentas
this.uo_1=create uo_1
this.cb_1=create cb_1
this.st_texto_ruta=create st_texto_ruta
this.sle_ruta_archivo=create sle_ruta_archivo
this.cb_buscar_archivo=create cb_buscar_archivo
this.dw_cuentas_archivo_cortes=create dw_cuentas_archivo_cortes
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_cortes_simulacion
this.Control[iCurrent+2]=this.cb_inicia_tablas
this.Control[iCurrent+3]=this.cbx_integracion_sim
this.Control[iCurrent+4]=this.cbx_servicio_social_sim
this.Control[iCurrent+5]=this.cbx_promedio_creditos_sin_bloqueo
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.st_avance
this.Control[iCurrent+8]=this.st_procesamiento
this.Control[iCurrent+9]=this.cbx_egresado
this.Control[iCurrent+10]=this.cbx_integracion
this.Control[iCurrent+11]=this.cbx_servicio_social
this.Control[iCurrent+12]=this.cbx_promedio_creditos
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.dw_cortes_cuentas
this.Control[iCurrent+15]=this.uo_1
this.Control[iCurrent+16]=this.cb_1
this.Control[iCurrent+17]=this.st_texto_ruta
this.Control[iCurrent+18]=this.sle_ruta_archivo
this.Control[iCurrent+19]=this.cb_buscar_archivo
this.Control[iCurrent+20]=this.dw_cuentas_archivo_cortes
this.Control[iCurrent+21]=this.gb_1
this.Control[iCurrent+22]=this.gb_2
end on

on w_cortes_archivo.destroy
call super::destroy
destroy(this.cbx_cortes_simulacion)
destroy(this.cb_inicia_tablas)
destroy(this.cbx_integracion_sim)
destroy(this.cbx_servicio_social_sim)
destroy(this.cbx_promedio_creditos_sin_bloqueo)
destroy(this.cb_3)
destroy(this.st_avance)
destroy(this.st_procesamiento)
destroy(this.cbx_egresado)
destroy(this.cbx_integracion)
destroy(this.cbx_servicio_social)
destroy(this.cbx_promedio_creditos)
destroy(this.cb_2)
destroy(this.dw_cortes_cuentas)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.st_texto_ruta)
destroy(this.sle_ruta_archivo)
destroy(this.cb_buscar_archivo)
destroy(this.dw_cuentas_archivo_cortes)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;

x=1
y=1
dw_cuentas_archivo_cortes.SetTransObject(gtr_sce)
dw_cortes_cuentas.SetTransObject(gtr_sce)
IF not isvalid(in_cortes) THEN
	in_cortes = CREATE n_cortes
END IF 


//// Si se trata de cortes reales
//IF le_proceso = 1 THEN 
	
	gb_2.ENABLED = FALSE 
	cb_inicia_tablas.ENABLED = FALSE 
	cbx_servicio_social_sim.ENABLED = FALSE 
	cbx_integracion_sim.ENABLED = FALSE 
	
//// Si se trata de cortes para simulación 
//ELSE 
//	
//	gb_1.VISIBLE = FALSE 
//	cb_buscar_archivo.VISIBLE = FALSE 
//	st_texto_ruta.VISIBLE = FALSE 
//	sle_ruta_archivo.VISIBLE = FALSE 
//	cb_1.VISIBLE = FALSE 
//	cbx_promedio_creditos.VISIBLE = FALSE 
//	cbx_servicio_social.VISIBLE = FALSE 
//	cbx_integracion.VISIBLE = FALSE 
//	cbx_egresado.VISIBLE = FALSE 
//	cbx_promedio_creditos_sin_bloqueo.VISIBLE = FALSE 
//	
//	
//END IF 	

end event

event close;call super::close;IF isvalid(in_cortes) THEN
	DESTROY in_cortes 
END IF
end event

type cbx_cortes_simulacion from checkbox within w_cortes_archivo
integer x = 3154
integer y = 124
integer width = 699
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cortes para Simulación"
end type

event clicked;POST wf_habilita()

end event

type cb_inicia_tablas from commandbutton within w_cortes_archivo
integer x = 3150
integer y = 252
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Iniciar Datos"
end type

event clicked;STRING	ls_sql  
Long		ll_num_reng
Int			li_anio
Int			li_periodo

// Oscar Sánchez, 26-Nov-2018. Obtener la cantidad de alumnos en preinsc y preguntar si se desea continuar con el proceso.
Select			count (*),
				periodo,
				anio
Into			:ll_num_reng,
				:li_periodo,
				:li_anio
From			preinsc
GROUP BY	periodo, anio
Using			gtr_sce;

IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al contar el número de alumnos en la tabla preinsc: ~n~r~n~r" + gtr_sce.SQLERRTEXT) 
	ROLLBACK USING gtr_sce;
	RETURN 
END IF

IF MessageBox ( "Por favor, confirme: " , "La tabla preinsc contiene " + String  ( ll_num_reng ) + " alumnos para el periodo " + String ( li_periodo ) + " y año " + String ( li_anio ) + "~n~r~n~r¿Desea continuar?" , Question!, YesNo! ) = 2 THEN
	MessageBox ( "Aviso:" , "Ha decidido no inicializar los datos." )
	RETURN
END IF

setpointer(Hourglass!)

ls_sql = "DELETE FROM mat_inscritas_sim"
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF

ls_sql = "DELETE FROM grupos_sim" 
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF

// Oscar Sánchez, 28-Sep-2018. Se agregan columnas para grupos modulares ...
ls_sql = "INSERT INTO grupos_sim(cve_mat_gpo, cve_mat, gpo, periodo, anio, " + & 
						"cond_gpo, cupo, tipo, inscritos, insc_desp_bajas, " + &  
						"cve_asimilada, gpo_asimilado, cve_profesor, prom_gpo, porc_asis, " + &  
						"ema4, primer_sem, comentarios, forma_imparte, fecha_inicio, fecha_fin) " + & 
"SELECT cve_mat_gpo, cve_mat, gpo, periodo, anio, " + &  
						"cond_gpo, cupo, tipo, 0, insc_desp_bajas, " + &  
						"cve_asimilada, gpo_asimilado, cve_profesor, prom_gpo, porc_asis, " + &  
						"ema4, primer_sem, comentarios, forma_imparte, fecha_inicio, fecha_fin " + &  
"FROM grupos WHERE periodo = " + STRING(gi_periodo) + " AND anio = " + STRING(gi_anio) 

EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF


ls_sql = "DELETE FROM horario_sim "
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF

ls_sql = "INSERT INTO horario_sim(cve_mat, gpo, periodo, anio, cve_dia, " + &  
						"cve_salon, hora_inicio, hora_final, clase_aula) " + & 
"SELECT cve_mat, gpo, periodo, anio, cve_dia, " + &  
		"cve_salon, hora_inicio, hora_final, clase_aula " + & 
"FROM horario WHERE periodo = " + STRING(gi_periodo) + " AND anio = " + STRING(gi_anio)  
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF

//ls_sql = "DELETE FROM mat_preinsc_sim " 
//EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
//IF gtr_sce.SQLCODE < 0 THEN 
//	ROLLBACK USING gtr_sce;
//	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
//	f_habilita_procesamiento(FALSE)
//	RETURN 
//END IF

//ls_sql = "INSERT INTO mat_preinsc_sim(cuenta, cve_mat, gpo, status, periodo, " + &   
//										"anio, orden, proceso_preinsc) " + &  
//"SELECT cuenta, cve_mat, gpo, status, periodo, " + &   
//			"anio, orden, proceso_preinsc " + &   
//"FROM mat_preinsc_sim " 
//EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
//IF gtr_sce.SQLCODE < 0 THEN 
//	ROLLBACK USING gtr_sce;
//	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
//	f_habilita_procesamiento(FALSE)
//	RETURN 
//END IF


ls_sql = "DELETE FROM preinsc_sim "
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF

ls_sql = "INSERT INTO preinsc_sim(cuenta, 	folio, 	status, 	periodo, " + &  
									"anio, 	noimpresiones) " + &  
"SELECT cuenta, 	folio, 	status, 	periodo, " + &  
		"anio, 	noimpresiones " + &  
"FROM preinsc WHERE periodo = " + STRING(gi_periodo) + " AND anio = " + STRING(gi_anio) 

EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF


ls_sql = " DELETE FROM historico_re " 
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF

// Se cargas históricos.
ls_sql = " INSERT INTO historico_re (cuenta, cve_mat, gpo, periodo, anio, cve_carrera, cve_plan, calificacion, observacion) " + & 
			" select distinct  " + & 
			" h.cuenta, " + & 
			" h.cve_mat, " + & 
			" isnull(h.gpo,'A'), " + & 
			" h.periodo, " + & 
			" h.anio, " + & 
			" h.cve_carrera, " + & 
			" h.cve_plan, " + & 
			" h.calificacion, " + & 
			" h.observacion " + & 
			" from historico h, academicos a, preinsc p " + & 
			" where h.cuenta = a.cuenta " + & 
			" and        h.cuenta = p.cuenta " + & 
			" and   a.nivel <> 'P' " + & 
			" UNION  " + & 
			" SELECT  " + & 
			" mi.cuenta, " + & 
			" mi.cve_mat, " + & 
			" mi.gpo, " + & 
			" mi.periodo, " + & 
			" mi.anio, " + & 
			" ac.cve_carrera, " + & 
			" ac.cve_plan, " + & 
			" 'AC' as calificacion, " + & 
			" null as observacion " + & 
			" FROM mat_inscritas mi, academicos ac  " + & 
			" WHERE mi.cuenta = ac.cuenta  " + & 
			" AND ac.nivel <> 'P'  " + & 
			" AND mi.cve_condicion NOT IN(1,2) " 
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF


ls_sql = " DELETE FROM historico_pos_re " 
EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF

ls_sql = " INSERT INTO historico_pos_re(cuenta, cve_mat, gpo, periodo, anio, cve_carrera, cve_plan, calificacion, observacion)  " + &
" select distinct  " + &
" h.cuenta, " + &
" h.cve_mat, " + &
" h.gpo, " + &
" h.periodo, " + &
" h.anio, " + &
" h.cve_carrera, " + &
" h.cve_plan, " + &
" h.calificacion, " + &
" h.observacion " + &
" from historico h, academicos a, preinsc p " + &
" where h.cuenta = a.cuenta " + &
" and        h.cuenta = p.cuenta " + &
" and   a.nivel = 'P' " + &
" UNION  " + &
" SELECT  " + &
" mi.cuenta, " + &
" mi.cve_mat, " + &
" mi.gpo, " + &
" mi.periodo, " + &
" mi.anio, " + &
" ac.cve_carrera, " + &
" ac.cve_plan, " + &
" 'AC' as calificacion, " + &
" null as observacion " + &
" FROM mat_inscritas mi, academicos ac  " + &
" WHERE mi.cuenta = ac.cuenta  " + &
" AND ac.nivel = 'P'  " + & 
" AND mi.cve_condicion NOT IN(1,2) "  

EXECUTE IMMEDIATE :ls_sql USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al cargar las tablas de simulación: " + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF



COMMIT USING gtr_sce; 
setpointer(Arrow!) 

MESSAGEBOX("Aviso", "Las tablas fueron cargadas con éxito") 













end event

type cbx_integracion_sim from u_cbx within w_cortes_archivo
integer x = 3150
integer y = 460
integer width = 338
integer height = 68
boolean enabled = false
string text = "Integración  "
end type

type cbx_servicio_social_sim from u_cbx within w_cortes_archivo
integer x = 3150
integer y = 384
integer width = 430
integer height = 68
boolean enabled = false
string text = "Servicio Social   "
end type

type cbx_promedio_creditos_sin_bloqueo from u_cbx within w_cortes_archivo
integer x = 2222
integer y = 444
integer width = 786
integer height = 68
string text = "Promedio y Créditos sin Bloqueo"
end type

type cb_3 from u_cb within w_cortes_archivo
integer x = 3959
integer y = 568
integer width = 87
integer taborder = 50
boolean enabled = false
string text = "..."
end type

event clicked;call super::clicked;IF not isnull(ldtm_fecha_inicial) AND &
   not isnull(ldtm_fecha_final) THEN
	MessageBox("Periodo de Ejecución","Inicio: ["+string(ldtm_fecha_inicial,"dd/mm/yyyy hh:mm:ss")+"]~n"+&
												 "Fin   : ["+string(ldtm_fecha_final,"dd/mm/yyyy hh:mm:ss")+"]")
END IF

end event

type st_avance from u_st within w_cortes_archivo
integer x = 3401
integer y = 584
integer width = 192
string text = "Avance:"
end type

type st_procesamiento from u_st within w_cortes_archivo
integer x = 3593
integer y = 572
integer width = 352
integer height = 92
string text = ""
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type cbx_egresado from u_cbx within w_cortes_archivo
integer x = 2222
integer y = 364
integer width = 288
integer height = 68
string text = "Egresado "
end type

type cbx_integracion from u_cbx within w_cortes_archivo
integer x = 2222
integer y = 284
integer width = 338
integer height = 68
string text = "Integración  "
end type

type cbx_servicio_social from u_cbx within w_cortes_archivo
integer x = 2222
integer y = 208
integer width = 430
integer height = 68
string text = "Servicio Social   "
end type

type cbx_promedio_creditos from u_cbx within w_cortes_archivo
integer x = 2222
integer y = 128
integer width = 521
integer height = 68
string text = "Promedio y Créditos  "
end type

type cb_2 from u_cb within w_cortes_archivo
integer x = 1883
integer y = 572
integer width = 471
integer taborder = 40
string text = "Ejecutar Cortes"
end type

event clicked;call super::clicked;integer li_res_cortes, li_confirmacion
long	ll_rowcount

IF NOT cbx_promedio_creditos.checked and NOT cbx_servicio_social.checked and &
	NOT cbx_integracion.checked       and NOT cbx_egresado.checked and &
	NOT cbx_promedio_creditos_sin_bloqueo.checked and NOT cbx_servicio_social_sim.checked and &
	NOT cbx_integracion_sim.checked THEN
	MessageBox("No hay cortes seleccionados", "Favor de seleccionar al menos un tipo de corte",StopSign!)
	RETURN
END IF

ll_rowcount = dw_cortes_cuentas.RowCount()

li_confirmacion = 	MessageBox("Confirmación", "¿Desea efectuar los cortes de los ["+string(ll_rowcount)+"] alumnos?",Question!, YesNo!)
SetPointer(HourGlass!)
cb_3.enabled = false
ldtm_fecha_inicial = fecha_servidor(gtr_sce)
IF li_confirmacion = 1 THEN
	li_res_cortes = wf_corte_alumnos()
	IF li_res_cortes = 0 THEN
		MessageBox("Ejecución Exitosa", "Se ha efectuado el corte de los ["+string(ll_rowcount)+"] alumnos",Information!)
	ELSEIF li_res_cortes = -1 THEN
		MessageBox("Error de Ejecución", "No es posible continuar con la ejecución de los cortes",StopSign!)
	END IF
ELSE
	MessageBox("Sin actualización", "No se han efectuado los cortes",Information!)
END IF
ldtm_fecha_final= fecha_servidor(gtr_sce)
cb_3.enabled = true
end event

type dw_cortes_cuentas from u_dw within w_cortes_archivo
integer x = 667
integer y = 700
integer width = 3611
integer height = 680
integer taborder = 20
string dataobject = "d_cortes_cuentas_ext"
boolean hscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean righttoleft = true
end type

event dberror;MessageBox("Codigo ["+string(sqldbcode)+"]", sqlerrtext +"~n "+ sqlsyntax, StopSign!)

return 0
end event

type uo_1 from uo_per_ani within w_cortes_archivo
integer x = 55
integer y = 48
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_1 from u_cb within w_cortes_archivo
integer x = 55
integer y = 572
integer width = 416
integer taborder = 30
string text = "Cargar Alumnos"
end type

event clicked;call super::clicked;integer li_return_carga
li_return_carga = wf_carga_prerreq_alumnos()
IF li_return_carga= -1 THEN
	MessageBox("Error de Carga", "Favor de revisar el archivo a cargar",StopSign!)
	RETURN
ELSE
	MessageBox("Carga Exitosa", "Se ha cargado el archivo exitosamente",Information!)
	RETURN
END IF
end event

type st_texto_ruta from u_st within w_cortes_archivo
integer x = 55
integer y = 440
integer width = 146
string text = "Ruta:"
end type

type sle_ruta_archivo from u_sle within w_cortes_archivo
integer x = 238
integer y = 436
integer width = 1719
integer height = 76
integer taborder = 20
long backcolor = 80269524
end type

type cb_buscar_archivo from u_cb within w_cortes_archivo
integer x = 55
integer y = 284
integer width = 416
integer taborder = 10
string text = "Buscar Archivo..."
end type

event clicked;call super::clicked;

string pathname, filename

integer value
is_nombre_archivo = "" 
value = GetFileOpenName("Seleccione el Archivo", &
		+ pathname, filename, "TXT", &
		+ "Text Files (*.TXT),*.TXT")

IF value = 1 THEN 
	is_nombre_archivo = pathname
	sle_ruta_archivo.text = is_nombre_archivo
ELSE
	MessageBox("Sin Archivo","No se ha abierto ningún archivo",Information!)
END IF


end event

type dw_cuentas_archivo_cortes from u_dw within w_cortes_archivo
integer x = 41
integer y = 700
integer width = 535
integer height = 680
integer taborder = 10
string dataobject = "d_carga_archivo_cortes"
end type

type gb_1 from u_gb within w_cortes_archivo
integer x = 2153
integer y = 44
integer width = 878
integer height = 508
integer taborder = 11
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Seleccione el tipo de corte"
end type

type gb_2 from u_gb within w_cortes_archivo
integer x = 3081
integer y = 44
integer width = 1184
integer height = 508
integer taborder = 21
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Seleccione el tipo de corte (Sumulación)"
end type

