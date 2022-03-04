$PBExportHeader$w_enlace_mat_sce.srw
forward
global type w_enlace_mat_sce from window
end type
type cbx_1 from checkbox within w_enlace_mat_sce
end type
type dw_5 from datawindow within w_enlace_mat_sce
end type
type cb_1 from commandbutton within w_enlace_mat_sce
end type
type dw_horarios_remedial_esp from datawindow within w_enlace_mat_sce
end type
type dw_horarios_remedial_mat from datawindow within w_enlace_mat_sce
end type
type st_5 from statictext within w_enlace_mat_sce
end type
type st_4 from statictext within w_enlace_mat_sce
end type
type st_fin from statictext within w_enlace_mat_sce
end type
type st_ini from statictext within w_enlace_mat_sce
end type
type dw_1 from uo_dw_reporte within w_enlace_mat_sce
end type
type uo_1 from uo_ver_per_ani within w_enlace_mat_sce
end type
type em_max from editmask within w_enlace_mat_sce
end type
type em_min from editmask within w_enlace_mat_sce
end type
type gb_1 from groupbox within w_enlace_mat_sce
end type
type gb_2 from groupbox within w_enlace_mat_sce
end type
type gb_4 from groupbox within w_enlace_mat_sce
end type
type st_1 from statictext within w_enlace_mat_sce
end type
type tab_1 from tab within w_enlace_mat_sce
end type
type tabpage_1 from userobject within tab_1
end type
type em_periodo from editmask within tabpage_1
end type
type em_anio from editmask within tabpage_1
end type
type st_7 from statictext within tabpage_1
end type
type st_6 from statictext within tabpage_1
end type
type dw_2 from datawindow within tabpage_1
end type
type tabpage_1 from userobject within tab_1
em_periodo em_periodo
em_anio em_anio
st_7 st_7
st_6 st_6
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type cb_5 from commandbutton within tabpage_2
end type
type cb_4 from commandbutton within tabpage_2
end type
type dw_3 from datawindow within tabpage_2
end type
type tabpage_2 from userobject within tab_1
cb_5 cb_5
cb_4 cb_4
dw_3 dw_3
end type
type tabpage_3 from userobject within tab_1
end type
type cb_3 from commandbutton within tabpage_3
end type
type cb_2 from commandbutton within tabpage_3
end type
type dw_4 from datawindow within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_3 cb_3
cb_2 cb_2
dw_4 dw_4
end type
type tabpage_4 from userobject within tab_1
end type
type cb_7 from commandbutton within tabpage_4
end type
type cb_6 from commandbutton within tabpage_4
end type
type dw_6 from datawindow within tabpage_4
end type
type tabpage_4 from userobject within tab_1
cb_7 cb_7
cb_6 cb_6
dw_6 dw_6
end type
type tab_1 from tab within w_enlace_mat_sce
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type
type gb_3 from groupbox within w_enlace_mat_sce
end type
end forward

global type w_enlace_mat_sce from window
integer x = 832
integer y = 364
integer width = 4078
integer height = 2644
boolean titlebar = true
string title = "Inscripción de Materias de Admisión al Sistema de Control Escolar"
string menuname = "m_menu"
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
event type long num_folios ( integer min_max )
event enlace ( )
event type integer checa ( long cuento )
event lee_dw_1 ( )
event lee_dw_2 ( )
event ins_alumnos ( )
event ins_estudio_ant ( )
event ins_hist_reingreso ( )
event ins_mat_inscritas ( integer al_periodo,  integer al_anio )
event act_alumnos ( )
event act_domicilio ( )
event act_padre ( )
event act_estudio_ant ( )
event act_academicos ( )
event act_banderas ( )
event ins_hist_carreras ( )
event inscribe_materias ( integer al_periodo,  integer al_anio )
cbx_1 cbx_1
dw_5 dw_5
cb_1 cb_1
dw_horarios_remedial_esp dw_horarios_remedial_esp
dw_horarios_remedial_mat dw_horarios_remedial_mat
st_5 st_5
st_4 st_4
st_fin st_fin
st_ini st_ini
dw_1 dw_1
uo_1 uo_1
em_max em_max
em_min em_min
gb_1 gb_1
gb_2 gb_2
gb_4 gb_4
st_1 st_1
tab_1 tab_1
gb_3 gb_3
end type
global w_enlace_mat_sce w_enlace_mat_sce

type variables
Int				al_estado, al_lugar, al_nacion, al_civil, al_religion, al_bachi, al_trabajo, al_horas, al_transp
Long			pa_estado, al_plan, al_carr, al_paq, cont_2, al_folio, al_clv_ver //, al_mat 
Long			cont_1, il_cuenta, il_propedeutico[], il_indice //,  il_teoria_lab[]
Real			al_promedio
String			al_nombre,al_apaterno,al_amaterno,al_calle,al_colonia,al_cp,al_tele,al_sexo
String			pa_nombre,pa_apaterno,pa_amaterno,pa_calle,pa_colonia,pa_cp,pa_tele //,al_grupo
DateTime	al_fecha
uo_paquetes iuo_paquetes

transaction itr_web						/* OSS 24-Ago-2011*/
Long		il_folio_ini						/* OSS 24-Ago-2011*/
lONG		il_folio_fin						/* OSS 24-Ago-2011*/ 

// Materias enlazadas con Laboratorio
DATASTORE ids_teoria_aboratorio 
// Alumnos con propedéuticos
DATASTORE ids_propedeuticos
// Grupos de cursos Propedeuticos
DATASTORE ids_grupos_prop 
// Datastore con las materias del paquete 
DATASTORE ids_paquete
DATASTORE ids_paquete_control

DATASTORE  ids_tiu 

STRING is_materias_tiu
//DATASTORE ids_teo_lab_proc


INTEGER ie_anio, ie_periodo 











end variables

forward prototypes
public function integer wf_enlace_sce (long al_cuenta, integer ai_periodo, integer ai_anio)
public function integer wf_inserta_remediales (integer ai_renglon)
public function integer wf_verifica_horarios_repetidos_x_paquete ()
public function integer wf_paquetes_materias_sin_grupo ()
public function integer wf_verifica_carreras (integer ar_ing_anio, integer ar_ing_periodo)
public function integer wf_verifica_paq_gpos_inexist (integer ar_ing_anio, integer ar_ing_periodo)
public function string wf_inserta_propedeuticos (long al_cve_carrera, long al_cve_plan, transaction at_transaction)
public function long wf_inserta_mat_rechazadas_x_horario (long al_cve_mat_prop, string as_gpo_prop)
public function long wf_inserta_mat_rechazadas_sin_prop (long al_cve_mat, string as_gpo)
public function string wf_busca_nvo_gpo_propedeutico (datastore ads_info_materia, long al_cve_mat_prop, string as_gpo_prop)
public function long wf_inserta_mat_rechazadas_x_horario (datastore ads_info_materia, long al_cve_mat_prop, string as_gpo_prop)
public function boolean wf_existe_mat_teoria_lab (long al_mat_lab)
public function boolean wf_tiene_propedeuticos (long al_cuenta, long al_periodo, long al_anio, long al_cve_carrera, long al_cve_plan, long al_cve_mat)
public function boolean wf_existe_propedeutico_mat_inscritas (long al_cuenta, long al_cve_propedeutico)
public subroutine wf_elimina_propedeutico_asignado (long al_cve_materia)
public function string wf_busca_gpo_propedeutico (long al_cve_propedeutico)
public function long wf_inserta_mat_rechazadas_x_cupo (long al_cve_mat_prop)
public function long wf_obtiene_cuenta_propedeutico (long al_cve_carrera, long al_cve_plan, long al_cve_mat, ref string as_enlace)
public function string wf_asigna_teoria_lab (long al_cuenta, long al_periodo, long al_anio, long al_cve_carrera, long al_cve_plan, long al_cve_mat)
public function long wf_cve_mat_pertenece_teoria_lab (long al_cve_carrera, long al_cve_plan, long al_cve_mat)
public function integer wf_valida_horario_mat_inscritas (long cta, long mat, string gpo)
public function integer wf_inscribe_materia (long al_cuenta, long al_cve_mat, string as_grupo, integer al_periodo, integer al_anio)
public function integer wf_valida_materia_inscrita (long al_cuenta, long al_cve_mat, integer al_periodo, integer al_anio)
public function string wf_busca_gpo_propedeutico (long al_cve_prop, integer ai_periodo, integer ai_anio, long al_materias[])
end prototypes

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

event enlace();Long		ll_rows, ll_periodo_materias, ll_anio_materias, ll_valida_carrera, ll_valida_gpos_inex, &
			ll_cuantos_web, ll_resultado, ll_cuantos, ll_nulo[], ll_residuo /* OSS. 03-ene-2012 */
String		ls_periodo_materias, ls_anio_materias
Integer	li_actualiza_insc_sem_ant, li_result, li_Respuesta, li_multiplo = 20 /* OSS. 15-Sep-2011 */ 

SetPointer(HourGlass!)
st_ini.text = string(now())

ls_periodo_materias = tab_1.tabpage_1.em_periodo.text
ls_anio_materias = tab_1.tabpage_1.em_anio.text

//tab_1.tabpage_1.em_periodo.GetData(ls_periodo_materias)
tab_1.tabpage_1.em_anio.GetData(ls_anio_materias)

CHOOSE CASE ls_periodo_materias
	CASE "Primavera"
		ls_periodo_materias= "0"
	CASE "Verano"
		ls_periodo_materias= "1"
	CASE "Otoño"		
		ls_periodo_materias= "2"
END CHOOSE 

IF NOT ISNUMBER(ls_periodo_materias) THEN
	MessageBox("Periodo de las materias invalido","Favor de escribir un periodo destino valido",StopSign!)
	RETURN;
END IF

IF NOT ISNUMBER(ls_anio_materias)THEN
	MessageBox("Año de las materias invalido","Favor de escribir un Año destino valido",StopSign!)	
	RETURN;
END IF

ll_periodo_materias = long(ls_periodo_materias)
ll_anio_materias = long(ls_anio_materias)

/* OSS. 15-Sep-2011 */
IF gi_periodo <> ll_periodo_materias THEN
	MessageBox ( "Aviso:" , "El periodo de materias por paquete es distinto al periodo de aspirantes, por favor verifique..."  )
	RETURN
END IF

IF gi_anio <> ll_anio_materias THEN
	MessageBox ( "Aviso:" , "El Año de materias por paquete es distinto al año de aspirantes, por favor verifique..."  )
	RETURN
END IF

tab_1.tabpage_4.Visible = FALSE
tab_1.tabpage_3.Visible = FALSE

//Validamos que la carrera de admision sea la misma de control escolar de los aspirantes
ll_resultado = wf_verifica_carreras (gi_anio, gi_periodo)

IF ll_resultado = -1 OR ll_resultado = 1 THEN
	RETURN
END IF

//Validamos que la carrera de admision sea la misma de control escolar de los aspirantes
ll_resultado = wf_verifica_paq_gpos_inexist (gi_anio, gi_periodo)

IF ll_resultado = -1 OR ll_resultado = 1 THEN
	RETURN
END IF

// Validar si exísten materias de un paquete con horario repetido ...
IF wf_verifica_horarios_repetidos_x_paquete ( ) = -1 THEN
	RETURN
END IF

IF tab_1.tabpage_3.dw_4.RowCount ( ) > 0 THEN
	MessageBox ( "Aviso:" , "Se encontró información de al menos un paquete con materias diferentes con mismo día y horario.~n~r~n~rPara poder continuar, es necesario corregir los horarios que a continuación se muestran." )
	tab_1.tabpage_3.Visible = True
	tab_1.SelectTab ( 3 )
	RETURN
END IF

// Validar si exísten materias de un paquete que no tengan grupo definido ...
IF wf_paquetes_materias_sin_grupo ( ) = -1 THEN
	RETURN
END IF

IF tab_1.tabpage_4.dw_6.RowCount ( ) > 0 THEN
	MessageBox ( "Aviso:" , "Se encontró información de al menos una materia que no tiene grupo definido.~n~r~n~rPara poder continuar, es necesario corregir los grupos de las materias que a continuación se muestran." )
	tab_1.tabpage_4.Visible = True
	tab_1.SelectTab ( 4 )
	RETURN
END IF

STRING ls_sql
LONG ll_num_rows

ls_sql = " SELECT pa.cuenta, pa.cve_carrera, pa.id_prop, vp.cve_mat, vp.cve_prerreq, vp.enlace, ~~'N~~' as procesado  " + & 
			" FROM admision_bd.dbo.prop_alumno_asignacion pa,  " + & 
				"  admision_bd.dbo.prop_rel_materia pm,  " + & 
				" admision_bd.dbo.v_prerrequisitos_esp vp " + & 
			" WHERE pa.periodo = " + STRING(gi_periodo) + & 
			" AND pa.anio = " + STRING(gi_anio) + &
			" AND pm.id_prop = pa.id_prop  " + & 
			" AND vp.cve_carrera = pa.cve_carrera " + &  
			" AND vp.cve_prerreq = pm.cve_materia " + & 
			" ORDER BY pa.cuenta, vp.cve_mat, vp.cve_prerreq " 

// Se crea datastore para carga de propedeúticos asignados.
ids_propedeuticos = CREATE DATASTORE 
ids_propedeuticos.DATAOBJECT = "dw_propedeuticos_aplicados"
ids_propedeuticos.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
ids_propedeuticos.SETTRANSOBJECT(gtr_sce) 
ll_num_rows = ids_propedeuticos.RETRIEVE() 
IF ll_num_rows < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar los cursos propedéuticos" + gtr_sce.SQLERRTEXT) 
	RETURN 
END IF 	

// Se crea Datastore con la relación teoria-laboratoriode primer ingreso
ids_teoria_aboratorio = CREATE DATASTORE 
ids_teoria_aboratorio.DATAOBJECT = "dw_teoria_lab_1er_ing"
ids_teoria_aboratorio.SETTRANSOBJECT(gtr_sce)
ll_num_rows = ids_teoria_aboratorio.RETRIEVE() 
IF ll_num_rows < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las materias Teoria-Laboratorio de primer ingreso." + gtr_sce.SQLERRTEXT)  	
	RETURN 
END IF 


// Se crea datastore con los grupos propedeuticos disponibles.
ids_grupos_prop = CREATE DATASTORE 
ids_grupos_prop.DATAOBJECT = "dw_grupos_propedeuticos_disp" 

// Se crea datastore con los grupos Teoria-Lab que se INSCRIBEN
//ids_teo_lab_proc = CREATE DATASTORE 
//ids_teo_lab_proc.DATAOBJECT = "dw_grupos_teo_lab_proc" 

ids_paquete = CREATE DATASTORE 
ids_paquete.DATAOBJECT = tab_1.tabpage_1.dw_2.DATAOBJECT 

// Se cargan las materias TIU 
STRING ls_query_tiu
INTEGER le_ttl_mat_tiu
INTEGER le_pos 
STRING ls_materia, ls_coma

ids_tiu = CREATE DATASTORE 
ids_tiu.DATAOBJECT = "dw_materias_tiu"  

ls_query_tiu = " SELECT DISTINCT cve_mat " + &  
					" FROM grupos_division  " + & 
					" WHERE periodo = " + STRING(gi_periodo) + & 
					" AND anio = " + STRING(gi_anio) 
					
ids_tiu.MODIFY("Datawindow.TABLE.SELECT = '" + ls_query_tiu + "'" )  
ids_tiu.SETTRANSOBJECT(gtr_sce) 
le_ttl_mat_tiu = ids_tiu.RETRIEVE() 
FOR le_pos = 1 TO le_ttl_mat_tiu  
	
	ls_materia = STRING(ids_tiu.GETITEMNUMBER(le_pos, "cve_mat"))  
	IF ISNULL(ls_materia) THEN ls_materia = "" 
	is_materias_tiu = is_materias_tiu + ls_coma + ls_materia 
	ls_coma = ", " 
	
NEXT 

FOR cont_1 = 1 TO dw_1.rowcount()
	
	ll_residuo = mod(cont_1, li_multiplo)
	IF ll_residuo = 0 THEN
		GarbageCollect()
	END IF
	
	//uo_paquetes iuo_paquetes
	iuo_paquetes = CREATE uo_paquetes 
	
//	il_teoria_lab[] = ll_nulo[]
	il_cuenta=dw_1.object.general_cuenta[cont_1]
	st_1.text="Leyendo datos de "+string ( il_cuenta )
	EVENT lee_dw_1()
	
	
//	clv_carr 
//	clv_plan 
	
	
	//SFF 28-Nov-2014
	ll_valida_carrera = 0
	li_result = f_valida_carrera_asp_x_cta (gi_anio, gi_periodo, il_cuenta)
	
	IF li_result <> 0 THEN
		IF li_result = 1 THEN
			MessageBox ( "Error:" , "No se procesara esta cuenta por tener diferente carrera en admisión y control escolar. Cuenta: " + String ( il_cuenta ) )
			ll_valida_carrera = 1
		END IF

		IF li_result = -1 THEN
			RETURN
		END IF
	END IF

	//SFF 28-Nov-2014
	ll_valida_gpos_inex = 0
	li_result = f_valida_paq_gpos_inexist_x_num_paq (gi_anio, gi_periodo, al_paq)
	
	IF li_result <> 0 THEN
		IF li_result = 1 THEN
			MessageBox ( "Error:" , "No se procesara este paquete, por que tiene grupos inexistentes. NumPaq: " + String ( al_paq ) )
			ll_valida_gpos_inex = 1
		END IF

		IF li_result = -1 THEN
			RETURN
		END IF
	END IF
	
	IF ll_valida_carrera = 0  AND ll_valida_gpos_inex = 0 THEN
		ll_rows = tab_1.tabpage_1.dw_2.retrieve(al_paq, gi_periodo, gi_anio)
		
		IF ll_rows = 0 THEN
			MessageBox ( "Error:" , "No están definidas las materias para el paquete: " + String ( al_paq ) )
		END IF
		
		// OSS 03-Ene-2011
		// Verificar si las materias del paquete ya fueron inscritas para el aspirante ...
		ll_cuantos = 0
		
		SELECT Count (dbo.mat_inscritas.cuenta)
		INTO :ll_cuantos
		FROM	 dbo.mat_inscritas
		WHERE dbo.mat_inscritas.cuenta = :il_cuenta
		AND dbo.mat_inscritas.periodo = :gi_periodo
		AND dbo.mat_inscritas.anio = :gi_anio
		USING gtr_sce;
		
	
		// Si tiene materias inscritas solicita la confirmación de borrado. 
		IF ll_cuantos > 0 THEN	
			
			// Si se pide confirmación por cada una de las cuentas.
			IF cbx_1.checked THEN 
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene materias inscritas.~n~r¿Desea borrar y volver a inscribir las materias?" , Question! , YesNo! )
			ELSEIF li_respuesta <> 1 THEN
				MessageBox ( "Aviso" , "Ya existen materias inscritas.~nSe borrará todo y se volverán a inscribir las materias" , Information!, OK!, 1)				
				li_respuesta = 1
			END IF				
			
			// Si la respuesta es positiva se procede al borrado 
			IF li_respuesta = 1 THEN 
				
				DELETE prop_materias_rechazadas
				FROM prop_materias_rechazadas a, general b
				WHERE b.folio = a.folio
				AND b.clv_ver = a.clv_ver
				AND b.clv_per = a.clv_per
				AND b.anio = a.anio
				AND CONVERT(DATE, a.fecha) = CONVERT(DATE, GETDATE())
				AND b.cuenta = :il_cuenta
				AND b.clv_per = :gi_periodo
				AND b.anio = :gi_anio
				AND a.cve_mat <> 24077
				USING gtr_sadm; 
				
				DELETE  FROM dbo.mat_inscritas
				WHERE dbo.mat_inscritas.cuenta = :il_cuenta
				AND dbo.mat_inscritas.periodo = :gi_periodo
				AND dbo.mat_inscritas.anio = :gi_anio
				AND dbo.mat_inscritas.cve_mat <> 24077
				USING gtr_sce;
				
				Commit Using gtr_sadm;
				Commit Using gtr_sce;
			
			// Si no se borran y reinscriben las materias, contimúa conb el sigiuiente registro 
			ELSE
				CONTINUE 
			END IF 
			
		END IF
		
		IF li_respuesta = 1 OR ll_cuantos = 0  THEN
			
			// Se reinicia DS de materios Teoria-Lab 
			ids_paquete.RESET() 
			
			tab_1.tabpage_1.dw_2.ROWSCOPY(1, tab_1.tabpage_1.dw_2.ROWCOUNT(), PRIMARY!, ids_paquete, 1, PRIMARY!) 
			EVENT inscribe_materias(gi_periodo, gi_anio )

		END IF
		
		ll_cuantos = 0
		// OSS 03-Ene-2011
		//ll_cuantos_web = 0 ///SFF Dic2014
		li_actualiza_insc_sem_ant = f_actualiza_insc_sem_ant ( il_cuenta )
		
		IF li_actualiza_insc_sem_ant= -1 THEN
			MessageBox("Error de Inserción","Error al actualizar la bandera de inscrito el semestre anterior",StopSign!)
		END IF
		
		// MALH 11/12/2018 SE AGREGA UPDATE PARA ACTUALIZAR EL ESTATUS DEL ASPIRANTE A "INSCRITO"
		UPDATE admision_bd.dbo.aspiran SET status = 2 // 2 = INSCRITO
		FROM admision_bd.dbo.aspiran a, admision_bd.dbo.general b 
		WHERE b.folio = a.folio
		AND b.clv_ver = a.clv_ver
		AND b.clv_per = a.clv_per
		AND b.anio = a.anio
		AND b.cuenta  = :il_cuenta
		AND a.ing_per = :gi_periodo
		AND a.ing_anio = :gi_anio
		USING gtr_sadm;
		
		Commit Using gtr_sadm;	
	END IF
NEXT

tab_1.tabpage_2.dw_3.SetTransObject ( gtr_sadm )
tab_1.tabpage_2.dw_3.Retrieve ( gi_version , gi_periodo , gi_anio )
tab_1.SelectedTab = 2

st_fin.text = String ( Now ( ) )
st_1.text = "Enlace Terminado"

end event

event type integer checa(long cuento);string ls_error
long cuen

SELECT alumnos.cuenta
INTO :cuen
FROM alumnos
WHERE alumnos.cuenta=:cuento
USING gtr_sce;
ls_error=gtr_sce.SQLErrText
	
if gtr_sce.SQLCode = 100 then
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
	return 0 /*Alumno nuevo*/
else
	if gtr_sce.SQLCode > 0 then
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
		return -1
	else
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
		return 1	/*Alumno viejo*/
	end if
End If
end event

event lee_dw_1();//		al_promedio=dw_1.object.aspiran_promedio[cont_1]
//		al_nombre=dw_1.object.general_nombre[cont_1]
//		al_apaterno=dw_1.object.general_apaterno[cont_1]
//		al_amaterno=dw_1.object.general_amaterno[cont_1]
//		al_calle=dw_1.object.general_calle[cont_1]
//		al_cp=dw_1.object.general_codigo_pos[cont_1]
//		pa_tele=dw_1.object.padres_telefono[cont_1]
//		al_colonia=dw_1.object.general_colonia[cont_1]
//		al_estado=dw_1.object.general_estado[cont_1]
//		al_tele=dw_1.object.general_telefono[cont_1]
//		al_fecha=dw_1.object.general_fecha_nac[cont_1]
//		al_lugar=dw_1.object.general_lugar_nac[cont_1]
//		al_nacion=dw_1.object.general_nacional[cont_1]
//		al_sexo=dw_1.object.general_sexo[cont_1]
//		al_civil=dw_1.object.general_edo_civil[cont_1]
//		al_religion=dw_1.object.general_religion[cont_1]
//		al_bachi=dw_1.object.general_bachillera[cont_1]
//		al_trabajo=dw_1.object.general_trabajo[cont_1]
//		al_horas=dw_1.object.general_trab_hor[cont_1]
//		al_transp=dw_1.object.general_transporte[cont_1]
//		al_plan=dw_1.object.paquetes_clv_plan[cont_1]
//		al_carr=dw_1.object.paquetes_clv_carr[cont_1]
		al_folio = dw_1.object.folio[cont_1]
		al_clv_ver = dw_1.object.aspiran_clv_ver[cont_1]
		al_plan = dw_1.object.clv_plan[cont_1]
		al_carr = dw_1.object.aspiran_clv_carr[cont_1]
		al_paq = dw_1.object.num_paq[cont_1]
//		pa_nombre=dw_1.object.padres_nombre[cont_1]
//		pa_apaterno=dw_1.object.padres_apaterno[cont_1]
//		pa_amaterno=dw_1.object.padres_amaterno[cont_1]
//		pa_calle=dw_1.object.padres_calle[cont_1]
//		pa_cp=dw_1.object.padres_codigo_pos[cont_1]
//		pa_colonia=dw_1.object.padres_colonia[cont_1]
//		pa_estado=dw_1.object.padres_estado[cont_1]
//
end event

event lee_dw_2();/*
			al_mat=dw_2.object.clv_mat[cont_2]
			al_grupo=dw_2.object.grupo[cont_2]
*/

//al_mat = tab_1.tabpage_1.dw_2.object.clv_mat[cont_2]
//al_grupo = tab_1.tabpage_1.dw_2.object.grupo[cont_2]
end event

event ins_alumnos();string ls_error
  INSERT INTO alumnos  
         ( cuenta,   
           nombre,   
           apaterno,   
           amaterno,   
           sexo,   
           cve_trabajo,   
           horas_trabajo,   
           fecha_nac,   
           lugar_nac,   
           cve_transp,   
           cve_nacion,   
           cve_religion,   
           cve_edocivil,   
           promedio_bach)  
  VALUES ( :il_cuenta,   
           :al_nombre,   
           :al_apaterno,   
           :al_amaterno,   
           :al_sexo,   
           :al_trabajo,   
           :al_horas,   
           :al_fecha,   
           :al_lugar,   
           :al_transp,   
           :al_nacion,   
           :al_religion,   
           :al_civil,   
           :al_promedio)  
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event ins_estudio_ant();string ls_error

INSERT INTO dbo.estudio_ant
	( cuenta,cve_escuela,cve_carrera,cve_grado )
VALUES ( :il_cuenta,:al_bachi,NULL,'B')
USING gtr_sce;

ls_error=gtr_sce.SQLErrText
commit using gtr_sce;
if ls_error<>"" then
	MessageBox("Database Error",ls_error, Exclamation!)
end if
end event

event ins_hist_reingreso();int a,b,c
string ls_error
	
	  SELECT academicos.periodo_ing,   
         academicos.anio_ing,   
         academicos.cve_formaingreso  
    INTO :a,:b,:c  
    FROM academicos  
   WHERE academicos.cuenta = :il_cuenta
	USING gtr_sce;

if (a<>gi_periodo or b<>gi_anio or c<>0) then 
	  INSERT INTO hist_reingreso  
				( cuenta,   
				  cve_formaingreso,   
				  periodo_ing,   
				  anio_ing )  
	  VALUES ( :il_cuenta,   
				  :c,   
				  :a,   
				  :b )  
		USING gtr_sce;
		ls_error=gtr_sce.SQLErrText
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
end if
end event

event ins_mat_inscritas(integer al_periodo, integer al_anio);RETURN 

///*
//	Oscar Sánchez.
//	Agosto de 2011.
//	Descripción:	Se modifica para replicar la información a SQLServer.
//					El objeto de transacción gtr_sce apunta a controlescolar_db en Sybase
//					El objeto de transacción itr_web apunta a controlescolar_db en SQLServer
//*/
//
//Long temp,cupo,inscritos, cve_propedeutico, ll_conflicto_horario, ll_nulo[] 
//Int tipo, clave_asimilada
//string grupo_asimilado,ls_error, ls_nvo_gpo, ls_enlace
////Boolean	lb_hacer_commit_SQLServer	= FALSE		/* OSS, 31-Ago-2011 */
////Boolean	lb_hacer_commit_Sybase		= FALSE		/* OSS, 31-Ago-2011 */
//Boolean	lb_trabajar_en_SQLServer		= TRUE		/* OSS, 31-Ago-2011 */
//Boolean	lb_trabajar_en_Sybase			= TRUE		/* OSS, 31-Ago-2011 */
//
///*
//uo_paquetes luo_paquetes
//luo_paquetes = CREATE uo_paquetes 
//*/
////IF NOT ISVALID(iuo_paquetes)  THEN iuo_paquetes = CREATE uo_paquetes 
//
//
//SELECT dbo.mat_inscritas.cuenta
//INTO :temp
//FROM dbo.mat_inscritas
//WHERE dbo.mat_inscritas.cuenta = :il_cuenta
//AND dbo.mat_inscritas.cve_mat = :al_mat
//AND dbo.mat_inscritas.gpo = :al_grupo
//AND dbo.mat_inscritas.periodo = :al_periodo
//AND dbo.mat_inscritas.anio = :al_anio
//USING gtr_sce; 
//
///*Si existe la cuenta quiere decir que la materia ya se inscribio*/
//IF temp = il_cuenta THEN
//	lb_trabajar_en_Sybase = FALSE
//END IF
//
///* OSS, 31-Ago-2011 */
//SELECT dbo.mat_inscritas.cuenta
//INTO :temp
//FROM dbo.mat_inscritas
//WHERE dbo.mat_inscritas.cuenta = :il_cuenta
//AND dbo.mat_inscritas.cve_mat = :al_mat
//AND dbo.mat_inscritas.gpo = :al_grupo
//AND dbo.mat_inscritas.periodo = :al_periodo
//AND dbo.mat_inscritas.anio = :al_anio
//USING itr_web;
//
///*Si existe la cuenta quiere decir que la materia ya se inscribio*/
//IF temp = il_cuenta THEN
//	lb_trabajar_en_SQLServer = FALSE
//END IF
//
//IF lb_trabajar_en_SQLServer = FALSE AND lb_trabajar_en_Sybase = FALSE THEN
//	RETURN
//END IF
//
//// Si existen en el arreglo una clave que se descartara de teoria o laboratorio
//IF UpperBound(il_teoria_lab) > 0 THEN
//	IF wf_existe_mat_teoria_lab(al_mat) = TRUE THEN 
//		RETURN
//	END IF
//END IF 
//
//// MALH 29/05/2018 Valida si tiene propedeutico y almacena los valores en un arreglo 
//IF wf_tiene_propedeuticos(il_cuenta, gi_periodo, gi_anio, al_carr, al_plan, al_mat) THEN
//	// Otiene la clave del propedeutico que reemplazará a la materia base
//	cve_propedeutico = il_propedeutico[1]
//	
//	IF wf_existe_propedeutico_mat_inscritas(il_cuenta, cve_propedeutico) = TRUE THEN  // Si existe el propedeutico ya no intenta insertarlo de nuevo
//		RETURN
//	END IF		
//	
//	// Valida si tiene teoria y laboratorioy almacena los valores en un arreglo 
//	ls_enlace = wf_asigna_teoria_lab(il_cuenta, gi_periodo, gi_anio, al_carr, al_plan, al_mat)
//
//	IF cve_propedeutico > 0 AND ls_enlace <> "O" THEN
//		// Se obtiene el primer grupo que se encuentre disponible para el propedeutico
//		ls_nvo_gpo = wf_busca_gpo_propedeutico(cve_propedeutico)
//
//		IF Len(ls_nvo_gpo) = 0 THEN // No se encontro grupo con cupo para asignarlo al propedeutico
//			wf_inserta_mat_rechazadas_x_cupo(cve_propedeutico)
//			RETURN
//		ELSE
//			// Se agrega la materia procesada al arreglo de instancia
//			il_indice = UpperBound(iuo_paquetes.il_materias)
//			IF ISNULL(il_indice) THEN il_indice  = 0
//			iuo_paquetes.il_materias[il_indice + 1] = al_mat
//			
//			al_mat = cve_propedeutico
//			al_grupo = ls_nvo_gpo
//		END IF
//		
//		// Se elima del arreglo la materia propedeutico que se intenta reemplazar
//		wf_elimina_propedeutico_asignado(al_mat)
//		
//		// Se inicializan variables de instancia necesarias para la validacion de horarios
//		iuo_paquetes.il_periodo = al_periodo
//		iuo_paquetes.il_anio = al_anio
//		iuo_paquetes.il_clv_carr = al_carr
//		iuo_paquetes.il_cuenta = il_cuenta
//		// Se agrega la materia procesada al arreglo de instancia
//		il_indice = UpperBound(iuo_paquetes.il_materias)
//		IF ISNULL(il_indice) THEN il_indice = 0
//		iuo_paquetes.il_materias[il_indice + 1] = al_mat
//		
//		// Se valida que la materia del propedeutico no entre en conflicto de horario con alguna otra materia
//		ll_conflicto_horario = iuo_paquetes.of_valida_horarios(al_paq, al_mat, al_grupo)
//		
//		//**//
//		//IF ll_conflicto_horario = 0 THEN 
//			//ll_conflicto_horario = wf_valida_horario_mat_inscritas(il_cuenta, al_mat, al_grupo) 
//		//END IF
//		//**//
//		
//		IF ll_conflicto_horario < 0 THEN // Si no se pudo realizar la validacion del horario del propedeutico a insertar
//			wf_inserta_mat_rechazadas_x_horario(al_mat, al_grupo)
//		ELSEIF ll_conflicto_horario > 0 THEN // Si existe conflicto de horario en el propedeutico a insertar
//			// Al buscar un nuevo grupo propedeutico ya se esta validando que exista cupo en el mismo
//			ls_nvo_gpo = wf_busca_nvo_gpo_propedeutico(iuo_paquetes.ids_prop_conflicto_horario, al_mat, al_grupo)
//
//			IF LEN(ls_nvo_gpo) = 0 THEN  // No se encontro nuevo grupo sin conflicto de horario para asignarlo al propedeutico
//				wf_inserta_mat_rechazadas_x_horario(iuo_paquetes.ids_prop_conflicto_horario, al_mat, al_grupo) 
//			ELSE
//				al_grupo = ls_nvo_gpo
//				ll_conflicto_horario = 0
//			END IF
//		END IF
//	ELSE
//		// Otiene la clave del propedeutico que reemplazará a la materia base
//		cve_propedeutico = wf_obtiene_cuenta_propedeutico(al_carr, al_plan, 9999, ls_enlace)
//
//		IF cve_propedeutico > 0 AND ls_enlace <> "O" THEN
//			wf_inserta_mat_rechazadas_sin_prop(cve_propedeutico, al_grupo)
//		END IF 			
//	END IF
//ELSE
//	IF wf_cve_mat_pertenece_teoria_lab(al_carr, al_plan, al_mat) > 0 THEN // Si la materia a inscribir pertenece esta configurada como teoria o laboratorio no se inserta
//		RETURN
//	END IF 
//END IF
//
//IF lb_trabajar_en_Sybase = TRUE THEN	/* OSS, 31-Ago-2011 */
//	IF ll_conflicto_horario = 0 THEN // 0 = No existe conflicto de horario en el propedeutico a insertar
//		INSERT INTO mat_inscritas (cuenta, 
//											 cve_mat, 
//											 gpo, 
//											 periodo, 
//											 anio, 
//											 cve_condicion, 
//											 acreditacion, 
//											 inscripcion)
//		VALUES (:il_cuenta, 
//					:al_mat, 
//					:al_grupo, 
//					:al_periodo, 
//					:al_anio, 
//					0, 
//					0, 
//					'I')  
//		USING gtr_sce;
//		
//		IF gtr_sce.SQLErrText<>"" THEN
//			ls_error = gtr_sce.SQLErrText
//			ROLLBACK USING gtr_sce;
//			MessageBox("Sybase Database Error", ls_error, Exclamation!)
//			RETURN
//		ELSE
//			ls_error = wf_inserta_propedeuticos( al_carr, al_plan, gtr_sce)
//			IF ls_error <> "" THEN
//				ROLLBACK USING gtr_sce;
//				MessageBox("Sybase Database Error", ls_error, Exclamation!)
//				RETURN
//			/*ELSE
//				lb_hacer_commit_Sybase = TRUE*/
//			END IF			
//		END IF
//	END IF		
//END IF	/* OSS, 31-Ago-2011 */
//
///* OSS, 31-Ago-2011 */
//IF lb_trabajar_en_SQLServer = TRUE THEN
//	IF ll_conflicto_horario = 0 THEN // 0 = No existe conflicto de horario en el propedeutico a insertar
//		INSERT INTO mat_inscritas (cuenta, 
//											cve_mat, 
//											gpo, 
//											periodo, 
//											anio, 
//											cve_condicion, 
//											acreditacion, 
//											inscripcion)
//		VALUES (:il_cuenta, 
//					:al_mat,
//					:al_grupo,
//					:al_periodo,
//					:al_anio, 
//					0, 
//					0, 
//					'I' )  
//		USING itr_web;
//		
//		IF itr_web.SQLErrText <> "" THEN
//			ls_error = itr_web.SQLErrText
//			ROLLBACK USING itr_web;
//	
//			//IF lb_hacer_commit_Sybase = TRUE THEN
//				ROLLBACK USING gtr_sce;
//			//END IF
//			
//			MessageBox ( "Error en la base de datos web:" ,ls_error, Exclamation! )
//			RETURN
//		ELSE
//			ls_error = wf_inserta_propedeuticos( al_carr, al_plan, itr_web)
//			IF ls_error <> "" THEN
//				ROLLBACK USING itr_web;
//		
//				//IF lb_hacer_commit_Sybase = TRUE THEN
//					ROLLBACK USING gtr_sce;
//				//END IF
//				
//				MessageBox ( "Error en la base de datos web:" ,ls_error, Exclamation! )
//				RETURN
//			/*ELSE
//				lb_hacer_commit_SQLServer = TRUE*/
//			END IF
//		END IF
//	END IF		
//END IF
//
//IF lb_trabajar_en_SQLServer = TRUE THEN
////IF lb_hacer_commit_SQLServer = TRUE THEN
//	Commit Using itr_web;
////END IF
//END IF	
//
//IF lb_trabajar_en_Sybase = TRUE THEN	/* OSS, 31-Ago-2011 */
////IF lb_hacer_commit_Sybase = TRUE THEN
//	Commit Using gtr_sce;
////END IF
//END IF
///* OSS, 31-Ago-2011 */
end event

event act_alumnos();string ls_error
  UPDATE alumnos  
     SET nombre = :al_nombre,   
         apaterno = :al_apaterno,  
			amaterno = :al_amaterno,
         sexo = :al_sexo,   
         cve_trabajo = :al_trabajo,   
         horas_trabajo = :al_horas,   
         fecha_nac = :al_fecha,   
         lugar_nac = :al_lugar,   
         cve_transp = :al_transp,   
         cve_nacion = :al_nacion,   
         cve_religion = :al_religion,   
         cve_edocivil = :al_civil,   
         promedio_bach = :al_promedio			
   WHERE alumnos.cuenta = :il_cuenta   
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_domicilio();string ls_error
  UPDATE domicilio  
     SET calle = :al_calle,   
         colonia = :al_colonia,   
         cve_estado = :al_estado,   
         cod_postal = :al_cp,   
         telefono = :al_tele  
   WHERE domicilio.cuenta = :il_cuenta
   USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_padre();string ls_error

  UPDATE padre  
     SET nombre = :pa_nombre,   
         apaterno = :pa_apaterno,   
         amaterno = :pa_amaterno,   
         calle = :pa_calle,   
         colonia = :pa_colonia,   
         cve_estado = :pa_estado,   
         cod_postal = :pa_cp,   
         telefono = :pa_tele  
   WHERE padre.cuenta = :il_cuenta   
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_estudio_ant();string ls_error
UPDATE estudio_ant  
     SET cve_escuela = :al_bachi,   
         cve_carrera = NULL  
   WHERE ( estudio_ant.cuenta = :il_cuenta ) AND  
         ( estudio_ant.cve_grado = 'B' )
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_academicos();string ls_error

	UPDATE academicos  
     SET cve_carrera = :al_carr,   
         cve_plan = :al_plan,   
         cve_subsistema = 0,   
         nivel = 'L',   
         promedio = 0,   
         sem_cursados = 0,   
         creditos_cursados = 0,   
         egresado = 0,   
         periodo_ing=:gi_periodo,   
         anio_ing=:gi_anio,   
         cve_formaingreso = 0  
   WHERE academicos.cuenta = :il_cuenta
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event act_banderas();string ls_error
  UPDATE banderas  
     SET insc_sem_ant = 1,   
         cve_flag_promedio = 0,   
         baja_3_reprob = 0,   
         baja_4_insc = 0,   
         baja_disciplina = 0,   
         baja_documentos = 0,   
         invasor_hora = 0,   
         exten_cred = 0,   
         cve_flag_prerreq_ingles = 0,   
         cve_flag_serv_social = 0,   
         puede_integracion = 0,   
         tema_fundamental_1 = 0,   
         tema_fundamental_2 = 0,   
         tema_1 = 0,   
         tema_2 = 0,   
         tema_3 = 0,   
         tema_4 = 0,   
         creditos_integ = 0,   
         cve_flag_biblioteca = 0,   
         cve_flag_diapositeca = 0,   
         adeuda_finanzas = 0,   
         verano = 0  
   WHERE banderas.cuenta = :il_cuenta
	USING gtr_sce;
	ls_error=gtr_sce.SQLErrText
	commit using gtr_sce;
	if ls_error<>"" then
		MessageBox("Database Error",ls_error, Exclamation!)
	end if
end event

event ins_hist_carreras();int carr_ant,plan_ant,subs_ant,peri_ant,anio_ant,forma_ingreso
string ls_error

  SELECT academicos.cve_carrera,   
         academicos.cve_plan,   
         academicos.cve_subsistema,   
         academicos.periodo_ing,   
         academicos.anio_ing,  
			academicos.cve_formaingreso
    INTO :carr_ant,   
         :plan_ant,   
         :subs_ant,   
         :peri_ant,   
         :anio_ant,  
			:forma_ingreso
    FROM academicos  
   WHERE academicos.cuenta = :il_cuenta
	USING gtr_sce;
	
	if (carr_ant<>al_carr or plan_ant<>al_plan) then
	
		  INSERT INTO hist_carreras  
				( cuenta,   
				  cve_formaingreso,   
				  cve_carrera_ant,   
				  cve_plan_ant,   
				  cve_subsistema_ant,   
				  cve_carrera_act,   
				  cve_plan_act,   
				  cve_subsistema_act,   
				  periodo_ing,   
				  anio_ing )  
	  VALUES ( :il_cuenta,   
				  :forma_ingreso,   
				  :carr_ant,   
				  :plan_ant,   
				  :subs_ant,   
				  :al_carr,   
				  :al_plan,   
				  0,   
				  :peri_ant,   
				  :anio_ant )
		USING gtr_sce;
		ls_error=gtr_sce.SQLErrText
		commit using gtr_sce;
		if ls_error<>"" then
			MessageBox("Database Error",ls_error, Exclamation!)
		end if
	end if
end event

event inscribe_materias(integer al_periodo, integer al_anio);LONG temp,cupo,inscritos, cve_propedeutico, ll_conflicto_horario, ll_nulo[] 
INTEGER tipo, clave_asimilada
STRING grupo_asimilado,ls_error, ls_nvo_gpo, ls_enlace
STRING ls_busca_prop
LONG ll_pos_prop 
LONG ll_cve_prop 
LONG ll_teoria, ll_lab 
LONG ll_mat_verifica_teo_lab 
//STRING ls_gpo

STRING ls_sql 
INTEGER ll_num_rows
STRING ls_sustituye, ls_procesado
INTEGER le_row_ins 
LONG ll_pos

BOOLEAN lb_encuentra	
INTEGER le_pos 
INTEGER le_pos_teo_lab
INTEGER le_borra 
LONG ll_cve_mat 
STRING ls_gpo

LONG ll_cve_mat_tl 
STRING ls_gpo_tl 
LONG ll_materias_proc[] 
INTEGER le_indice 



	
IF il_cuenta = 212149 	THEN 
	il_cuenta = il_cuenta
END IF
	
ids_propedeuticos.SETFILTER("")  
ids_propedeuticos.FILTER() 	
	
// Se hace ciclo sobre las materias del paquete 
DO
	
	// Se verifica si ya se procesaron todas las materias del paquete
	IF ids_paquete.ROWCOUNT() = 0 THEN RETURN 
	
	// Se toma la Primera materia 
	ll_cve_mat = ids_paquete.GETITEMNUMBER(1, "clv_mat")  
	ls_gpo = ids_paquete.GETITEMSTRING(1, "grupo") 

	le_indice ++ 
	ll_materias_proc[le_indice] = ll_cve_mat 

	// Se verifica si la materia ya fue inscrita.
	temp = wf_valida_materia_inscrita(il_cuenta,  ll_cve_mat, al_periodo, al_anio)
	
	/*Si existe la cuenta quiere decir que la materia ya se inscribio*/
	IF temp > 0 THEN   
		RETURN
	END IF	
	
	ll_lab = 0 
	ll_cve_mat_tl = 0
	ls_gpo_tl = "" 
			
	// Se verifica si se trata de una materia de TEORIA-LABORATORIO 
	le_pos_teo_lab = ids_teoria_aboratorio.FIND("cve_teoria = " + STRING(ll_cve_mat) + " AND cve_carrera = " + STRING(al_carr)  + " AND cve_plan = " + STRING(al_plan), 1, ids_teoria_aboratorio.ROWCOUNT() + 1)  
	IF le_pos_teo_lab > 0 THEN 
		ll_lab = ids_teoria_aboratorio.GETITEMNUMBER(le_pos_teo_lab, "cve_lab")
	ELSE
		le_pos_teo_lab = ids_teoria_aboratorio.FIND("cve_lab = " + STRING(ll_cve_mat) + " AND cve_carrera = " + STRING(al_carr)  + " AND cve_plan = " + STRING(al_plan), 1, ids_teoria_aboratorio.ROWCOUNT() + 1)  
		IF le_pos_teo_lab > 0 THEN 
			ll_lab = ids_teoria_aboratorio.GETITEMNUMBER(le_pos_teo_lab, "cve_teoria")	
		END IF 	
	END IF 
	
	// Si existe materia complementaria, busca la clave. 
	IF ll_lab > 0 THEN  
		le_pos_teo_lab = ids_paquete.FIND("clv_mat = " + STRING(ll_lab), 1, ids_paquete.ROWCOUNT())  
		IF le_pos_teo_lab > 0 THEN 
			ll_cve_mat_tl = ll_lab 
			ls_gpo_tl = ids_paquete.GETITEMSTRING(le_pos_teo_lab, "grupo") 
		END IF 
	END IF 	
	
	// Se verifica si la materia tiene un propedéutico que la reemplace.
	ls_busca_prop = "prop_alumno_asignacion_cuenta = " + STRING(il_cuenta) + " AND v_prerrequisitos_esp_cve_mat = " + STRING(ll_cve_mat) + " and procesado <> 'S' " 
	ll_pos_prop = ids_propedeuticos.FIND(ls_busca_prop, 0, ids_propedeuticos.ROWCOUNT()) 

	// Si la materia no tiene propedéutico, se verifica si la materia complementaria tiene. 
	IF ll_pos_prop <= 0 AND ll_cve_mat_tl > 0 THEN 
		// Se verifica si la materia tiene un propedéutico que la reemplace.
		ls_busca_prop = "prop_alumno_asignacion_cuenta = " + STRING(il_cuenta) + " AND v_prerrequisitos_esp_cve_mat = " + STRING(ll_cve_mat_tl) + " and procesado <> 'S' "   
		ll_pos_prop = ids_propedeuticos.FIND(ls_busca_prop, 0, ids_propedeuticos.ROWCOUNT()) 	
	END IF
	
	// Si encuentra la materia, toma la clave del propedeútico y se inscribe 
	IF ll_pos_prop > 0 THEN 
		
		// Se marca el registro como "procesado" 
		ids_propedeuticos.SETITEM(ll_pos_prop, "procesado", "S") 	
		 
		// Se toma la clave del Prop y si sustituye o no. 
		ll_cve_prop = ids_propedeuticos.GETITEMNUMBER(ll_pos_prop, "v_prerrequisitos_esp_cve_prerreq") 
		ls_sustituye = ids_propedeuticos.GETITEMSTRING(ll_pos_prop, "v_prerrequisitos_esp_enlace") 

		// Se busca un grupo donde pueda insertarse el curso 		
		ls_nvo_gpo = wf_busca_gpo_propedeutico(ll_cve_prop, al_periodo, al_anio, ll_materias_proc)
		
		// Si no encuentra ningun grupo inserta la materia en rechazadas
		IF TRIM(ls_nvo_gpo) = "" THEN 
			wf_inserta_mat_rechazadas_x_horario(ll_cve_prop, ls_nvo_gpo) 
		// Si encuentra un grupo, se inscribe el propedéutico.	
		ELSE
			wf_inscribe_materia(il_cuenta, ll_cve_prop, ls_nvo_gpo, al_periodo, al_anio)  
		END IF
	
		// Si el Prop se agrega en vez de sustituir
		IF ls_sustituye = "O" THEN 
			wf_inscribe_materia(il_cuenta, ll_cve_mat, ls_gpo, al_periodo, al_anio)
			// Si tiene materia Teoria-Lab, la inscribe
			IF ll_cve_mat_tl > 0 THEN 
				wf_inscribe_materia(il_cuenta, ll_cve_mat_tl, ls_gpo_tl, al_periodo, al_anio)  	
			END IF				
		END IF	
	
	/*SI NO ENCUENTRA PROPEDÉUTICO INSCRIBE TEORIA - LABORATORIO*/
	ELSE
		// Se inscribe la materia actual
		wf_inscribe_materia(il_cuenta, ll_cve_mat, ls_gpo, al_periodo, al_anio)  

		// Si tiene materia Teoria-Lab, la inscribe
		IF ll_cve_mat_tl > 0 THEN 
			wf_inscribe_materia(il_cuenta, ll_cve_mat_tl, ls_gpo_tl, al_periodo, al_anio)  	
		END IF	
	
	END IF 
	
	// Se eliminan las materias procesadas del DS de materias temporales. 
	le_borra = ids_paquete.FIND("clv_mat = " + STRING(ll_cve_mat), 1, ids_paquete.ROWCOUNT())  
	IF le_borra > 0 THEN 
		ids_paquete.DELETEROW(le_borra)  
	END IF 	
	
	IF ll_cve_mat_tl > 0 THEN 
		le_borra = ids_paquete.FIND("clv_mat = " + STRING(ll_cve_mat_tl), 1, ids_paquete.ROWCOUNT())  
		IF le_borra > 0 THEN 
			ids_paquete.DELETEROW(le_borra)  
		END IF 		
	END IF 	

LOOP WHILE ids_paquete.ROWCOUNT() > 0 


// SE VERIFICA SI YA SE PROCESARON TODOS LOS PROPEDÉUTICOS 
ids_propedeuticos.SETFILTER("prop_alumno_asignacion_cuenta = " + STRING(il_cuenta) + " AND procesado = 'N'")  
ids_propedeuticos.FILTER() 
ll_num_rows = ids_propedeuticos.ROWCOUNT() 

// Se hace ciclo para verificar que todos los propedéuticos restantes sean para agregar (Enlace = O) 
FOR le_pos = 1 TO ll_num_rows 
	
	// Se toma la clave del prop y el tipo de enlace. 
	ll_cve_prop = ids_propedeuticos.GETITEMNUMBER(le_pos, "v_prerrequisitos_esp_cve_prerreq")  
	ls_sustituye = ids_propedeuticos.GETITEMSTRING(le_pos, "v_prerrequisitos_esp_enlace") 
	ids_propedeuticos.SETITEM(le_pos, "procesado", "S") 
	
	// Se verifica si la materia ya fue inscrita.
	temp = wf_valida_materia_inscrita(il_cuenta,  ll_cve_prop, al_periodo, al_anio)
	/*Si existe, la materia ya se inscribio y continua el ciclo*/ 
	IF temp > 0 THEN CONTINUE    
	
	// Si es una curso que se agrega, se busca un grupo disponible.
	IF ls_sustituye = "O" THEN 
		ls_gpo = wf_busca_gpo_propedeutico(ll_cve_prop, al_periodo, al_anio, ll_materias_proc)	

		IF TRIM(ls_gpo) = "" THEN 
			wf_inserta_mat_rechazadas_x_horario(ll_cve_prop, "") 
		// Si encuentra un grupo, se inscribe el propedéutico.	
		ELSE
			wf_inscribe_materia(il_cuenta, ll_cve_prop, ls_gpo, al_periodo, al_anio)  
		END IF
		
	END IF 
	
NEXT 	



RETURN 













//		ls_sql = " SELECT g.cve_mat, g.gpo, g.cupo, g.inscritos, g.cupo - g.inscritos AS diponibles " + & 
//				" FROM controlescolar_bd.dbo.grupos g " + & 
//				" WHERE g.cve_mat = " + STRING(ll_cve_prop) + &  
//				" AND g.periodo =  " + STRING(gi_periodo) + &
//				" AND g.anio = " + STRING(gi_anio) + &
//				" AND g.cupo > g.inscritos "
//	
//		// Se filtran los grupos disponibles del propedéutico 
//		ids_grupos_prop.DATAOBJECT = "dw_grupos_propedeuticos_disp" 
//		ids_grupos_prop.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'" ) 
//		ids_grupos_prop.SETTRANSOBJECT(gtr_sce)
//		ll_num_rows = ids_grupos_prop.RETRIEVE() 
//		IF ll_num_rows < 0 THEN 
//			MESSAGEBOX("Error", "Se produjo un error al recuperar los grupos propedéuticos." + gtr_sce.SQLERRTEXT)  	 
//			RETURN 
//		END IF 	
//		
//		FOR le_pos = 1 TO ll_num_rows 
//				
//			ls_nvo_gpo = ids_grupos_prop.GETITEMSTRING(le_pos, "gpo") 
//				
//			// Se inicializan variables de instancia necesarias para la validacion de horarios
//			iuo_paquetes.il_periodo = al_periodo
//			iuo_paquetes.il_anio = al_anio
//			iuo_paquetes.il_clv_carr = al_carr
//			iuo_paquetes.il_cuenta = il_cuenta	
//
//			// Se valida que la materia del propedeutico no entre en conflicto de horario con alguna otra materia
//			ll_conflicto_horario = iuo_paquetes.of_valida_horarios(al_paq, ll_cve_prop, ls_nvo_gpo)
//			
//			// Si no se pudo verificar el horario
//			IF ll_conflicto_horario < 0 THEN 
//				wf_inserta_mat_rechazadas_x_horario(ll_cve_mat, ls_gpo)
//			// Si existe conflicto de horario en el propedeutico a insertar Continua con el siguiente grupo 
//			ELSEIF ll_conflicto_horario > 0 THEN 
//				CONTINUE 
//			// Si no hay conflicto se selecciona el grupo para inscribirlo 
//			ELSE
//				lb_encuentra = TRUE 
//				EXIT 
//			END IF 	
//			
//		NEXT 


//	// Se verifica si la materia ya fue inscrita 	
//	SELECT dbo.mat_inscritas.cuenta
//	INTO :temp
//	FROM dbo.mat_inscritas
//	WHERE dbo.mat_inscritas.cuenta = :il_cuenta
//	AND dbo.mat_inscritas.cve_mat = :ll_cve_mat
//	AND dbo.mat_inscritas.gpo = :ls_gpo
//	AND dbo.mat_inscritas.periodo = :al_periodo
//	AND dbo.mat_inscritas.anio = :al_anio
//	USING gtr_sce; 



//****************************************************************************************
//<// Si existen en el arreglo una clave que se descartara de teoria o laboratorio
//IF UpperBound(il_teoria_lab) > 0 THEN
//	IF wf_existe_mat_teoria_lab(al_mat) = TRUE THEN 
//		RETURN
//	END IF
//END IF 
//
//// MALH 29/05/2018 Valida si tiene propedeutico y almacena los valores en un arreglo 
//IF wf_tiene_propedeuticos(il_cuenta, gi_periodo, gi_anio, al_carr, al_plan, al_mat) THEN
//	
//	// Otiene la clave del propedeutico que reemplazará a la materia base
//	cve_propedeutico = il_propedeutico[1]
//	
//	IF wf_existe_propedeutico_mat_inscritas(il_cuenta, cve_propedeutico) = TRUE THEN  // Si existe el propedeutico ya no intenta insertarlo de nuevo
//		RETURN
//	END IF		
//	
//	// Valida si tiene teoria y laboratorioy almacena los valores en un arreglo 
//	ls_enlace = wf_asigna_teoria_lab(il_cuenta, gi_periodo, gi_anio, al_carr, al_plan, al_mat)
//
//	IF cve_propedeutico > 0 AND ls_enlace <> "O" THEN
//		// Se obtiene el primer grupo que se encuentre disponible para el propedeutico
//		ls_nvo_gpo = wf_busca_gpo_propedeutico(cve_propedeutico)
//
//		IF Len(ls_nvo_gpo) = 0 THEN // No se encontro grupo con cupo para asignarlo al propedeutico
//			wf_inserta_mat_rechazadas_x_cupo(cve_propedeutico)
//			RETURN
//		ELSE
//			// Se agrega la materia procesada al arreglo de instancia
//			il_indice = UpperBound(iuo_paquetes.il_materias)
//			IF ISNULL(il_indice) THEN il_indice  = 0
//			iuo_paquetes.il_materias[il_indice + 1] = al_mat
//			
//			al_mat = cve_propedeutico
//			al_grupo = ls_nvo_gpo
//		END IF
//		
//		// Se elima del arreglo la materia propedeutico que se intenta reemplazar
//		wf_elimina_propedeutico_asignado(al_mat)
//		
//		// Se inicializan variables de instancia necesarias para la validacion de horarios
//		iuo_paquetes.il_periodo = al_periodo
//		iuo_paquetes.il_anio = al_anio
//		iuo_paquetes.il_clv_carr = al_carr
//		iuo_paquetes.il_cuenta = il_cuenta
//		// Se agrega la materia procesada al arreglo de instancia
//		il_indice = UpperBound(iuo_paquetes.il_materias)
//		IF ISNULL(il_indice) THEN il_indice = 0
//		iuo_paquetes.il_materias[il_indice + 1] = al_mat
//		
//		// Se valida que la materia del propedeutico no entre en conflicto de horario con alguna otra materia
//		ll_conflicto_horario = iuo_paquetes.of_valida_horarios(al_paq, al_mat, al_grupo)
//		
//		//**//
//		//IF ll_conflicto_horario = 0 THEN 
//			//ll_conflicto_horario = wf_valida_horario_mat_inscritas(il_cuenta, al_mat, al_grupo) 
//		//END IF
//		//**//
//		
//		IF ll_conflicto_horario < 0 THEN // Si no se pudo realizar la validacion del horario del propedeutico a insertar
//			wf_inserta_mat_rechazadas_x_horario(al_mat, al_grupo)
//		ELSEIF ll_conflicto_horario > 0 THEN // Si existe conflicto de horario en el propedeutico a insertar
//			// Al buscar un nuevo grupo propedeutico ya se esta validando que exista cupo en el mismo
//			ls_nvo_gpo = wf_busca_nvo_gpo_propedeutico(iuo_paquetes.ids_prop_conflicto_horario, al_mat, al_grupo)
//
//			IF LEN(ls_nvo_gpo) = 0 THEN  // No se encontro nuevo grupo sin conflicto de horario para asignarlo al propedeutico
//				wf_inserta_mat_rechazadas_x_horario(iuo_paquetes.ids_prop_conflicto_horario, al_mat, al_grupo) 
//			ELSE
//				al_grupo = ls_nvo_gpo
//				ll_conflicto_horario = 0
//			END IF
//		END IF
//	ELSE
//		// Otiene la clave del propedeutico que reemplazará a la materia base
//		cve_propedeutico = wf_obtiene_cuenta_propedeutico(al_carr, al_plan, 9999, ls_enlace)
//
//		IF cve_propedeutico > 0 AND ls_enlace <> "O" THEN
//			wf_inserta_mat_rechazadas_sin_prop(cve_propedeutico, al_grupo)
//		END IF 			
//	END IF
//ELSE
//	IF wf_cve_mat_pertenece_teoria_lab(al_carr, al_plan, al_mat) > 0 THEN // Si la materia a inscribir pertenece esta configurada como teoria o laboratorio no se inserta
//		RETURN
//	END IF 
//END IF
//
//
//IF ll_conflicto_horario = 0 THEN // 0 = No existe conflicto de horario en el propedeutico a insertar
//	INSERT INTO mat_inscritas (cuenta,  cve_mat,  gpo,  periodo,  anio, 
//										cve_condicion,  acreditacion,  inscripcion)
//	VALUES (:il_cuenta, :al_mat, :al_grupo, :al_periodo, :al_anio, 
//				0, 0, 'I')  
//	USING gtr_sce;
//	
//	IF gtr_sce.SQLErrText<>"" THEN
//		ls_error = gtr_sce.SQLErrText
//		ROLLBACK USING gtr_sce;
//		MessageBox("Sybase Database Error", ls_error, Exclamation!)
//		RETURN
//	ELSE
//		ls_error = wf_inserta_propedeuticos( al_carr, al_plan, gtr_sce)
//		IF ls_error <> "" THEN
//			ROLLBACK USING gtr_sce;
//			MessageBox("Sybase Database Error", ls_error, Exclamation!)
//			RETURN
//		/*ELSE
//			lb_hacer_commit_Sybase = TRUE*/
//		END IF			
//	END IF
//END IF		
//
//
//Commit Using gtr_sce;
//



end event

public function integer wf_enlace_sce (long al_cuenta, integer ai_periodo, integer ai_anio);String ls_mensaje
Integer li_codigo_error

DECLARE spenlacesce PROCEDURE FOR sp_enlace_sce
@cuenta = :al_cuenta, 
@periodo = :ai_periodo, 
@anio = :ai_anio
USING gtr_sadm;

EXECUTE spenlacesce;

li_codigo_error= gtr_sadm.SQLCode
ls_mensaje= gtr_sadm.SQLErrText

IF li_codigo_error = -1 THEN 
	MessageBox("Error al ejecutar sp_enlace_sce", ls_mensaje)
	RETURN -1
ELSE
	COMMIT USING gtr_sadm;
	RETURN 0
END IF




end function

public function integer wf_inserta_remediales (integer ai_renglon);Long			ll_folio
Long			ll_clv_carr
Dec			ld_puntos_matematicas
Dec			ld_puntos_espanol
Int				li_hora_inicio
Int				li_hora_final
Int				li_cont
Int				li_num_paq
Int				li_cve_dia
Boolean		lb_remedial_mat_insertada = False
Boolean		lb_remedial_esp_insertada = False
String			ls_MensajeError
String			ls_gpo
Int				li_cve_mat
String			ls_gpo_rem
Int				li_cve_dia_rem
Int				li_hora_inicio_rem
Int				li_hora_final_rem
Int				li_no_mat_con_horarios_cruzados
DateTime	ldt_fecha_hora_actual
Int				li_clv_ver
Int				li_respuesta
Int				li_cuantos

ll_folio		= dw_1.Object.folio [ ai_renglon ];
ll_clv_carr	= dw_1.Object.clv_carr [ ai_renglon ];
li_num_paq	= tab_1.tabpage_1.dw_2.Object.num_paq [ 1 ];

IF gi_version = 99 THEN
	li_clv_ver = dw_1.Object.aspiran_clv_ver [ ai_renglon ]
ELSE
	li_clv_ver = gi_version
END IF

/* *************************************************************
	Verificar si se requiere agregar la materia de REMEDIAL MATEMATICAS
	**************************************************************/

Select		a.folio,
			area_1 + area_2 as Matematicas
Into		:ll_folio,
			:ld_puntos_matematicas
From		aspiran a,
			resultado_examen_modulo rem
Where	a.folio							= rem.folio		and
			a.clv_ver						= rem.clv_ver	and
			a.clv_per						= rem.clv_per	and
			a.anio							= rem.anio		and
			a.status						in ( 1,2 )			and	/* Tabla status, 1 = 'ACEPTADO', 2 = 'INSCRITO' */
			a.promedio					<= 73			and
			( area_1 + area_2			<= 110 )			and
			rem.cve_tipo_examen	= 1				and	/* Tabla tipo_examen, 1 = 'Selección' */
			a.anio							= :gi_anio		and
			a.clv_ver						= :li_clv_ver	and
			a.clv_per						= :gi_periodo	and
			a.folio							= :ll_folio
Using	gtr_sadm;

IF gtr_sadm.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De Base de Datos al verificar si se debe agregar la materia Remedial Matemáticas.~n~r~n~r" + gtr_sadm.SQLErrText )
	Return -1
END IF

IF gtr_sadm.SQLCode = 0 THEN
	// Verificar en que horario se puede tomar la materia REMEDIAL MATEMATICAS ...
	
	dw_horarios_remedial_mat.Reset ( )
	dw_horarios_remedial_mat.SetTransObject ( gtr_sce )
	dw_horarios_remedial_mat.Retrieve ( 90204 , gi_anio , gi_periodo )
	
	dw_5.Reset ( )
	/*
		El siguiente FOR es para verificar la materia REMEDIAL MATEMÁTICAS con menor número
		de inscritos (asi esta ordenada la dw), se evalúa que renglón de la dw tiene un horario que
		no se cruce con el horario de alguna materia del paquete ...
	*/
	FOR li_cont = 1 TO dw_horarios_remedial_mat.RowCount ( )
		ls_gpo_rem		= dw_horarios_remedial_mat.Object.gpo		[ li_cont ]
		li_cve_dia_rem	= dw_horarios_remedial_mat.Object.cve_dia	[ li_cont ]

		// Obtener la hora de inicio y hora final de la materia REMEDIAL MATEMÁTICAS ...
		li_hora_inicio_rem	= dw_horarios_remedial_mat.Object.horario_hora_inicio	[ li_cont ]
		li_hora_final_rem	= dw_horarios_remedial_mat.Object.horario_hora_final		[ li_cont ]
		
		/*
			El siguiente query verifica que el horario de la materia REMEDIAL MATEMÁTICAS
			no se cruce con alguna materia del paquete, si el resultado del count es '0' significa
			que el horario no se cruza, mayor a '0' significa que se cruza con alguna materia ...
		*/
		
		Select		distinct
					h.cve_mat,
					h.gpo,
					h.cve_dia,
					h.hora_inicio,
					h.hora_final,
					GetDate ( )
		Into		:li_cve_mat,
					:ls_gpo,
					:li_cve_dia,
					:li_hora_inicio,
					:li_hora_final,
					:ldt_fecha_hora_actual
		From		paquetes_materias pm,
					horario h
		Where	h.cve_mat		= pm.clv_mat and
					h.gpo				= pm.grupo and
					h.periodo		= pm.clv_per and
					h.anio				= pm.anio and
					pm.num_paq	= :li_num_paq and
					pm.clv_per		= :gi_periodo and
					pm.anio			= :gi_anio	and
					h.cve_dia		= :li_cve_dia_rem	/* Para evaluar solo las materias del paquete que coincidan con el día de la materia remedial */
					and  /* La sig. condición es para que devuelva el número de registros que se cruzan con el horario de la materia remedial*/
					(

						(
							( :li_hora_inicio_rem between h.hora_inicio and h.hora_final ) or
							( :li_hora_final_rem between h.hora_inicio and h.hora_final )
						) and
						(
							
							(
								( :li_hora_inicio_rem < h.hora_final ) or
								( :li_hora_final_rem <= h.hora_final )
							) and 
							(
								:li_hora_final_rem > h.hora_inicio
							)
						)

					)
		Using	gtr_sce;
		
		IF gtr_sce.SQLCode = -1 THEN
			MessageBox ( "Error:" , "De Base de Datos al verificar si la materia Remedial Matemáticas no se cruza con algún horario del paquete de materias.~n~r~n~r" + gtr_sce.SQLErrText )
			Return -1
		END IF
		
		IF gtr_sce.SQLCode = 100 THEN
			// Verificar si ya existe la materia remedial Matematicas en mat_inscritas ...
			Select		cuenta
			Into		:il_cuenta
			From		mat_inscritas
			Where	cuenta	= :il_cuenta		and
						cve_mat	= 90204			and
//						gpo		= :ls_gpo_rem	and
						periodo	= :gi_periodo	and
						anio		= :gi_anio
			Using		gtr_sce;
			
			IF gtr_sce.SQLCode = 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene inscrita la materia Remedial Matemáticas.~n~r¿Desea Borrar y volver a inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					// Eliminar el registro de Materias Inscritas en Sybase ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90204			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :gi_periodo	and
								anio		= :gi_anio
					Using		gtr_sce;
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :gi_periodo			AND
								anio					= :gi_anio				AND
								cve_mat_rem		= 90204					//AND		/*Comentado SFF DIC 2014*/
//								cve_dia_rem		= :li_cve_dia_rem		AND
//								hora_inicio_rem	= :li_hora_inicio_rem	AND
//								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					// Eliminar el registro de Materias Inscritas en SQL Server ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90204			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :gi_periodo	and
								anio		= :gi_anio
					Using		itr_web;
					
					Commit Using gtr_sce;
					Commit Using itr_web;
					Commit Using gtr_sadm;
				END IF
			END IF
			
			INSERT INTO mat_inscritas  
			( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
			VALUES ( :il_cuenta, 90204, :ls_gpo_rem, :gi_periodo, :gi_anio, 0, 0, 'I' )  
			USING gtr_sce;
			
			IF gtr_sce.SQLCode = -1 THEN
				ls_MensajeError = gtr_sce.SQLErrText
				RollBack Using gtr_sce;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Matemáticas.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sce.SQLCode = 0 THEN
				INSERT INTO mat_inscritas  
				( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
				VALUES ( :il_cuenta, 90204, :ls_gpo_rem, :gi_periodo, :gi_anio, 0, 0, 'I' )  
				USING itr_web;
				
				IF itr_web.SQLCode = -1 THEN
					ls_MensajeError = itr_web.SQLErrText
					RollBack Using gtr_sce;
					RollBack Using itr_web;
					
					MessageBox ( "SQLServer Error:" , "De base de Datos.~n~r Al insertar la materia en mat_inscritas .~n~r~n~r" + ls_MensajeError  )
					return -1
				END IF
				
				
				Commit Using gtr_sce;
				Commit Using itr_web;
			END IF
			
			
			/*SFF DIC 2014*/
			// Verificar si ya existe la materia remedial Matematicas en aspiran_remediales_inscritas ...
			Select		folio
			Into		:il_cuenta
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :gi_periodo			AND
						anio					= :gi_anio				AND
						cve_mat_rem		= 90204					//AND
//						cve_dia_rem		= :li_cve_dia_rem		AND
//						hora_inicio_rem	= :li_hora_inicio_rem	AND
//						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;

			
			If (gtr_sce.SQLCode = 0) And (il_cuenta > 0) Then 
				// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
				Delete From aspiran_remediales_inscritas
				Where	folio					= :ll_folio				AND
							clv_ver				= :li_clv_ver				AND
							clv_per				= :gi_periodo			AND
							anio					= :gi_anio				AND
							cve_mat_rem		= 90204					//AND
//							cve_dia_rem		= :li_cve_dia_rem		AND
//							hora_inicio_rem	= :li_hora_inicio_rem	AND
//							hora_fin_rem		= :li_hora_final_rem
				Using		gtr_sadm;
				
				Commit Using gtr_sadm;
			End If
			
			
			lb_remedial_mat_insertada = True
			
			// Insertar en aspiran_remediales_inscritas ...
			INSERT INTO aspiran_remediales_inscritas
			( folio,		clv_ver,		clv_per,		anio,		fecha,			clv_carr,		num_paq,		cve_mat_rem,	gpo_rem,		cve_dia_rem,		hora_inicio_rem,		hora_fin_rem,			mat_insertada )
			VALUES 
			( :ll_folio,	:li_clv_ver,	:gi_periodo,	:gi_anio,	GetDate ( ),	:ll_clv_carr,	:li_num_paq,	90204,			:ls_gpo_rem,	:li_cve_dia_rem,	:li_hora_inicio_rem,	:li_hora_final_rem,	1 )
			Using gtr_sadm;
			
			IF gtr_sadm.SQLCode = -1 THEN
				ls_MensajeError = gtr_sadm.SQLErrText
				RollBack Using gtr_sadm;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Matemáticas en aspiran_remediales_inscritas.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sadm.SQLCode = 0 THEN
				Commit Using gtr_sadm;
			END IF
			
			EXIT
		END IF
		
		IF gtr_sce.SQLCode = 0 THEN
			// Significa que una materia remedial se cruza con algún horario de las materias del paquete ...

			// Verificar si la materia Remedial fue insertada en la bitácora ...
			Select		Count ( folio )
			Into		:li_cuantos
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :gi_periodo			AND
						anio					= :gi_anio				AND
						cve_mat_rem		= 90204					AND
						cve_dia_rem		= :li_cve_dia_rem		AND
						hora_inicio_rem	= :li_hora_inicio_rem	AND
						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;
			
			IF gtr_sadm.SQLCode = 0 and li_cuantos > 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene una bitácora de Materia remedial Matemáticas no inscrita.~n~r¿Desea Borrar y volver a intentar inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :gi_periodo			AND
								anio					= :gi_anio				AND
								cve_mat_rem		= 90204					AND
								cve_dia_rem		= :li_cve_dia_rem		AND
								hora_inicio_rem	= :li_hora_inicio_rem	AND
								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					Commit Using gtr_sadm;
				END IF
			END IF

			// Insertar los posibles renglones de las materias del paquete que se cruzan con la materia remedial ...
			dw_5.InsertRow ( 0 )

			dw_5.Object.folio					[ dw_5.RowCount ( ) ] = ll_folio
			dw_5.Object.clv_ver				[ dw_5.RowCount ( ) ] = li_clv_ver
			dw_5.Object.clv_per				[ dw_5.RowCount ( ) ] = gi_periodo
			dw_5.Object.anio					[ dw_5.RowCount ( ) ] = gi_anio
			dw_5.Object.fecha					[ dw_5.RowCount ( ) ] = ldt_fecha_hora_actual
			dw_5.Object.clv_carr				[ dw_5.RowCount ( ) ] = ll_clv_carr
			dw_5.Object.num_paq			[ dw_5.RowCount ( ) ] = li_num_paq
			dw_5.Object.cve_mat_rem		[ dw_5.RowCount ( ) ] = 90204
			dw_5.Object.gpo_rem			[ dw_5.RowCount ( ) ] = ls_gpo_rem
			dw_5.Object.cve_dia_rem		[ dw_5.RowCount ( ) ] = li_cve_dia_rem
			dw_5.Object.hora_inicio_rem	[ dw_5.RowCount ( ) ] = li_hora_inicio_rem
			dw_5.Object.hora_fin_rem		[ dw_5.RowCount ( ) ] = li_hora_final_rem
			dw_5.Object.cve_mat				[ dw_5.RowCount ( ) ] = li_cve_mat
			dw_5.Object.gpo					[ dw_5.RowCount ( ) ] = ls_gpo
			dw_5.Object.cve_dia				[ dw_5.RowCount ( ) ] = li_cve_dia
			dw_5.Object.hora_inicio			[ dw_5.RowCount ( ) ] = li_hora_inicio
			dw_5.Object.hora_fin				[ dw_5.RowCount ( ) ] = li_hora_final
			dw_5.Object.mat_insertada		[ dw_5.RowCount ( ) ] = 0
			dw_5.Object.comentarios		[ dw_5.RowCount ( ) ] = 'El horario y día de la materia remedial Matemáticas coincide con el horario y dia de una materia Inscrita'
			
			li_no_mat_con_horarios_cruzados ++
		END IF
		
	NEXT

	IF lb_remedial_mat_insertada = False THEN
		
		// Insertar en aspiran_remediales_inscritas ...
		dw_5.Update ( )
		
		IF gtr_sadm.SQLCode = 0 THEN
			Commit Using gtr_sadm;
		END IF
	END IF
END IF


/* *************************************************************
	Verificar si se requiere agregar la materia de REMEDIAL ESPAÑOL
	**************************************************************/

Select		a.folio,
			area_3 + area_4 as espanol
Into		:ll_folio,
			:ld_puntos_espanol
From		aspiran a,
			resultado_examen_modulo rem
Where	a.folio							= rem.folio		and
			a.clv_ver						= rem.clv_ver	and
			a.clv_per						= rem.clv_per	and
			a.anio							= rem.anio		and
			a.status						in ( 1,2 )			and	/* Tabla status, 1 = 'ACEPTADO', 2 = 'INSCRITO' */
			a.promedio					<= 73			and
			( area_3 + area_4			<= 110 )			and
			rem.cve_tipo_examen	= 1				and	/* Tabla tipo_examen, 1 = 'Selección' */
			a.anio							= :gi_anio		and
			a.clv_ver						= :li_clv_ver	and
			a.clv_per						= :gi_periodo	and
			a.folio							= :ll_folio
Using	gtr_sadm;

IF gtr_sadm.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De Base de Datos al verificar si se debe agregar la materia Remedial Español.~n~r~n~r" + gtr_sadm.SQLErrText )
	Return -1
END IF

IF gtr_sadm.SQLCode = 0 THEN
	// Verificar en que horario se puede tomar la materia REMEDIAL ESPAÑOL ...
	
	dw_horarios_remedial_esp.Reset ( )
	dw_horarios_remedial_esp.SetTransObject ( gtr_sce )
	dw_horarios_remedial_esp.Retrieve ( 90203 , gi_anio , gi_periodo )
	
	/*
		El siguiente FOR es para verificar la materia REMEDIAL ESPAÑOL con menor número
		de inscritos (asi esta ordenada la dw), se evalúa que renglón de la dw tiene un horario que
		no se cruce con el horario de alguna materia del paquete ...
	*/
	FOR li_cont = 1 TO dw_horarios_remedial_esp.RowCount ( )
		ls_gpo_rem		= dw_horarios_remedial_esp.Object.gpo		[ li_cont ]
		li_cve_dia_rem	= dw_horarios_remedial_esp.Object.cve_dia	[ li_cont ]
		
		// Obtener la hora de inicio y hora final de la materia REMEDIAL ESPAÑOL ...
		li_hora_inicio_rem	= dw_horarios_remedial_esp.Object.horario_hora_inicio	[ li_cont ]
		li_hora_final_rem	= dw_horarios_remedial_esp.Object.horario_hora_final	[ li_cont ]
		
		/*
			El siguiente query verifica que el horario de la materia REMEDIAL ESPAÑOL
			no se cruce con alguna materia del paquete, si el resultado del count es '0' significa
			que el horario no se cruza, mayor a '0' significa que se cruza con alguna materia ...
		*/

		Select		distinct
					h.cve_mat,
					h.gpo,
					h.cve_dia,
					h.hora_inicio,
					h.hora_final,
					GetDate ( )
		Into		:li_cve_mat,
					:ls_gpo,
					:li_cve_dia,
					:li_hora_inicio,
					:li_hora_final,
					:ldt_fecha_hora_actual
		From		paquetes_materias pm,
					horario h
		Where	h.cve_mat		= pm.clv_mat and
					h.gpo				= pm.grupo and
					h.periodo		= pm.clv_per and
					h.anio				= pm.anio and
					pm.num_paq	= :li_num_paq and
					pm.clv_per		= :gi_periodo and
					pm.anio			= :gi_anio and
					h.cve_dia		= :li_cve_dia_rem	/* Para evaluar solo las materias del paquete que coincidan con el día de la materia remedial */
					and  /* La sig. condición es para que devuelva el número de registros que se cruzan con el horario de la materia remedial*/
					(

						(
							( :li_hora_inicio_rem between h.hora_inicio and h.hora_final ) or
							( :li_hora_final_rem between h.hora_inicio and h.hora_final )
						) and
						(

							(
								( :li_hora_inicio_rem < h.hora_final ) or
								( :li_hora_final_rem <= h.hora_final )
							) and 
							(
								:li_hora_final_rem > h.hora_inicio
							)

						)

					)
		Using	gtr_sce;
		
		IF gtr_sce.SQLCode = -1 THEN
			MessageBox ( "Error:" , "De Base de Datos al verificar si la materia Remedial Español no se cruza con algún horario del paquete de materias.~n~r~n~r" + gtr_sce.SQLErrText )
			Return -1
		END IF
		
		IF gtr_sce.SQLCode = 100 THEN
			// Verificar si ya existe la materia remedial Español mat_inscritas ...
			Select		cuenta
			Into		:il_cuenta
			From		mat_inscritas
			Where	cuenta	= :il_cuenta		and
						cve_mat	= 90203			and
//						gpo		= :ls_gpo_rem	and
						periodo	= :gi_periodo	and
						anio		= :gi_anio
			Using		gtr_sce;
			
			IF gtr_sce.SQLCode = 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene inscrita la materia Remedial Español.~n~r¿Desea Borrar y volvera inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					// Eliminar el registro de Materias Inscritas en Sybase ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90203			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :gi_periodo	and
								anio		= :gi_anio
					Using		gtr_sce;
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :gi_periodo			AND
								anio					= :gi_anio				AND
								cve_mat_rem		= 90203					//AND
//								cve_dia_rem		= :li_cve_dia_rem		AND  /*Comentado SFF DIc2014*/
//								hora_inicio_rem	= :li_hora_inicio_rem	AND
//								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					// Eliminar el registro de Materias Inscritas en SQL Server ...
					Delete
					From		mat_inscritas
					Where	cuenta	= :il_cuenta		and
								cve_mat	= 90203			and
//								gpo		= :ls_gpo_rem	and
								periodo	= :gi_periodo	and
								anio		= :gi_anio
					Using		itr_web;
					
					Commit Using gtr_sce;
					Commit Using itr_web;
					Commit Using gtr_sadm;
				END IF
			END IF
			
			INSERT INTO mat_inscritas  
			( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
			VALUES ( :il_cuenta, 90203, :ls_gpo_rem, :gi_periodo, :gi_anio, 0, 0, 'I' )  
			USING gtr_sce;
			
			IF gtr_sce.SQLCode = -1 THEN
				ls_MensajeError = gtr_sce.SQLErrText
				RollBack Using gtr_sce;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Español.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sce.SQLCode = 0 THEN
				INSERT INTO mat_inscritas  
				( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
				VALUES ( :il_cuenta, 90203, :ls_gpo_rem, :gi_periodo, :gi_anio, 0, 0, 'I' )  
				USING itr_web;
				
				IF itr_web.SQLCode = -1 THEN
					ls_MensajeError = itr_web.SQLErrText
					RollBack Using gtr_sce;
					RollBack Using itr_web;
					
					MessageBox ( "SQLServer Error:" , "De base de Datos.~n~r Al insertar la materia en mat_inscritas.~n~r~n~r" + ls_MensajeError  )
					return -1
				END IF
				
				
				Commit Using gtr_sce;
				Commit Using itr_web;
			END IF
			
			/*SFF DIC 2014*/
			// Verificar si ya existe la materia remedial Matematicas en aspiran_remediales_inscritas ...
			Select		folio
			Into		:il_cuenta
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :gi_periodo			AND
						anio					= :gi_anio				AND
						cve_mat_rem		= 90203					//AND
//						cve_dia_rem		= :li_cve_dia_rem		AND
//						hora_inicio_rem	= :li_hora_inicio_rem	AND
//						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;

			
			If (gtr_sce.SQLCode = 0) And (il_cuenta > 0) Then 
				// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
				Delete From aspiran_remediales_inscritas
				Where	folio					= :ll_folio				AND
							clv_ver				= :li_clv_ver				AND
							clv_per				= :gi_periodo			AND
							anio					= :gi_anio				AND
							cve_mat_rem		= 90203					//AND
//							cve_dia_rem		= :li_cve_dia_rem		AND
//							hora_inicio_rem	= :li_hora_inicio_rem	AND
//							hora_fin_rem		= :li_hora_final_rem
				Using		gtr_sadm;
				
				Commit Using gtr_sadm;
			End If			
			
			lb_remedial_esp_insertada = True
			
			// Insertar en aspiran_remediales_inscritas ...
			INSERT INTO aspiran_remediales_inscritas
			( folio, clv_ver, clv_per, anio, fecha, clv_carr, num_paq, cve_mat_rem, gpo_rem, cve_dia_rem, hora_inicio_rem, hora_fin_rem, mat_insertada )
			VALUES 
			( :ll_folio, :li_clv_ver, :gi_periodo, :gi_anio, GetDate ( ), :ll_clv_carr, :li_num_paq, 90203, :ls_gpo_rem, :li_cve_dia_rem, :li_hora_inicio_rem, :li_hora_final_rem, 1 )
			Using gtr_sadm;
			
			IF gtr_sadm.SQLCode = -1 THEN
				ls_MensajeError = gtr_sadm.SQLErrText
				RollBack Using gtr_sadm;
				MessageBox ( "Error:" , "De base de Datos.~n~r Al insertar la materia remedial Español en aspiran_remediales_inscritas.~n~r~n~r" + ls_MensajeError  )
				return -1
			END IF
				
			IF gtr_sadm.SQLCode = 0 THEN
				Commit Using gtr_sadm;
			END IF
			EXIT
		END IF
		
		IF gtr_sce.SQLCode = 0 THEN
			// Significa que una materia remedial se cruza con algún horario de las materias del paquete ...
			
			// Verificar si la materia Remedial fue insertada en la bitácora ...
			Select		Count ( folio )
			Into		:li_cuantos
			From		aspiran_remediales_inscritas
			Where	folio					= :ll_folio				AND
						clv_ver				= :li_clv_ver				AND
						clv_per				= :gi_periodo			AND
						anio					= :gi_anio				AND
						cve_mat_rem		= 90203					AND
						cve_dia_rem		= :li_cve_dia_rem		AND
						hora_inicio_rem	= :li_hora_inicio_rem	AND
						hora_fin_rem		= :li_hora_final_rem
			Using		gtr_sadm;
			
			IF gtr_sadm.SQLCode = 0 and li_cuantos > 0 THEN
				li_respuesta = MessageBox ( "Aviso" , "El alumno con cuenta [" + String ( il_cuenta ) + "]  ya tiene una bitácora de Materia remedial Español no inscrita.~n~r¿Desea Borrar y volver a intentar inscribir la materia?" , StopSign! , YesNo! )
				
				IF li_respuesta = 2 THEN
					Return -1
				END IF
				
				IF li_respuesta = 1 THEN
					
					// Eliminar el registro en Sybase (admision) de la bitácora de materias remediales inscritas ...
					Delete From aspiran_remediales_inscritas
					Where	folio					= :ll_folio				AND
								clv_ver				= :li_clv_ver				AND
								clv_per				= :gi_periodo			AND
								anio					= :gi_anio				AND
								cve_mat_rem		= 90203					AND
								cve_dia_rem		= :li_cve_dia_rem		AND
								hora_inicio_rem	= :li_hora_inicio_rem	AND
								hora_fin_rem		= :li_hora_final_rem
					Using		gtr_sadm;

					
					Commit Using gtr_sadm;
				END IF
			END IF
			
			// Insertar los posibles renglones de las materias del paquete que se cruzan con la materia remedial ...
			dw_5.InsertRow ( 0 )

			dw_5.Object.folio					[ dw_5.RowCount ( ) ] = ll_folio
			dw_5.Object.clv_ver				[ dw_5.RowCount ( ) ] = li_clv_ver
			dw_5.Object.clv_per				[ dw_5.RowCount ( ) ] = gi_periodo
			dw_5.Object.anio					[ dw_5.RowCount ( ) ] = gi_anio
			dw_5.Object.fecha					[ dw_5.RowCount ( ) ] = ldt_fecha_hora_actual
			dw_5.Object.clv_carr				[ dw_5.RowCount ( ) ] = ll_clv_carr
			dw_5.Object.num_paq			[ dw_5.RowCount ( ) ] = li_num_paq
			dw_5.Object.cve_mat_rem		[ dw_5.RowCount ( ) ] = 90203
			dw_5.Object.gpo_rem			[ dw_5.RowCount ( ) ] = ls_gpo_rem
			dw_5.Object.cve_dia_rem		[ dw_5.RowCount ( ) ] = li_cve_dia_rem
			dw_5.Object.hora_inicio_rem	[ dw_5.RowCount ( ) ] = li_hora_inicio_rem
			dw_5.Object.hora_fin_rem		[ dw_5.RowCount ( ) ] = li_hora_final_rem
			dw_5.Object.cve_mat				[ dw_5.RowCount ( ) ] = li_cve_mat
			dw_5.Object.gpo					[ dw_5.RowCount ( ) ] = ls_gpo
			dw_5.Object.cve_dia				[ dw_5.RowCount ( ) ] = li_cve_dia
			dw_5.Object.hora_inicio			[ dw_5.RowCount ( ) ] = li_hora_inicio
			dw_5.Object.hora_fin				[ dw_5.RowCount ( ) ] = li_hora_final
			dw_5.Object.mat_insertada		[ dw_5.RowCount ( ) ] = 0
			dw_5.Object.comentarios		[ dw_5.RowCount ( ) ] = 'El horario y día de la materia remedial Matemáticas coincide con el horario y dia de una materia Inscrita'
			
			li_no_mat_con_horarios_cruzados ++
		END IF
		
	NEXT

	IF lb_remedial_esp_insertada = False THEN
		// Significa que nigún horario de las materias remediales se ajusta a los horarios de las materias del paquete ...

		// Insertar en aspiran_remediales_inscritas ...
		dw_5.Update ( )
		
		IF gtr_sadm.SQLCode = 0 THEN
			Commit Using gtr_sadm;
		END IF
	END IF
END IF


Return 1
end function

public function integer wf_verifica_horarios_repetidos_x_paquete ();Long		ll_num_paq, ll_cve_mat
Int			li_cuenta, li_cve_dia, li_hora_inicio, li_hora_final
String		ls_materia, ls_dia, ls_gpo, ls_cve_salon

tab_1.tabpage_3.dw_4.Reset ( )

DECLARE cur_paquetes CURSOR FOR
	SELECT DISTINCT dbo.aspiran.num_paq
    FROM	dbo.aspiran,
			dbo.general,
			dbo.paquetes_materias
	WHERE dbo.aspiran.folio = dbo.general.folio
	AND dbo.general.clv_ver = dbo.aspiran.clv_ver
	AND dbo.aspiran.clv_per = dbo.general.clv_per
	AND dbo.general.anio = dbo.aspiran.anio
	AND ( dbo.aspiran.clv_ver = :gi_version OR  :gi_version = 99 )
	AND dbo.aspiran.ing_per = :gi_periodo
	AND dbo.aspiran.ing_anio = :gi_anio 
	AND dbo.aspiran.folio BETWEEN :il_folio_ini AND :il_folio_fin
	AND dbo.general.cuenta <> 0 
	AND dbo.general.cuenta IN (SELECT cuenta FROM controlescolar_bd.dbo.alumnos) 
	AND dbo.aspiran.pago_insc = 1 
	AND dbo.aspiran.status IN (1,2,4) 
	AND dbo.aspiran.num_paq = dbo.paquetes_materias.num_paq 
	AND dbo.aspiran.anio = dbo.paquetes_materias.anio 
	AND dbo.aspiran.clv_per = dbo.paquetes_materias.clv_per 
	USING gtr_sadm; 

	OPEN cur_paquetes;

	IF gtr_sadm.SQLCode = -1 THEN
		MessageBox ( "Error:" , "De base de datos al consultar las materias por paquete .~n~r~n~r" + gtr_sadm.SQLErrText )
		CLOSE cur_paquetes;
		RETURN -1
	END IF

	FETCH cur_paquetes INTO :ll_num_paq;

	DO WHILE gtr_sadm.sqlcode <> 100
		li_cuenta = 0

		// Verificar si hay materias con dia y horario iguales ...
		DECLARE cur_materias_repetidas CURSOR FOR
			SELECT count ( h.cve_dia )	,
					   h.cve_dia,
					   h.hora_inicio,
					   h.hora_final
			FROM paquetes_materias pm, horario h, grupos g
			WHERE h.cve_mat = pm.clv_mat 
			AND h.gpo = pm.grupo 
			AND h.periodo = pm.clv_per 
			AND h.anio = pm.anio 
			AND pm.num_paq	= :ll_num_paq 
			AND pm.clv_per = :gi_periodo 
			AND pm.anio = :gi_anio 
							AND g.cve_mat = pm.clv_mat 
							AND g.gpo =  pm.grupo
							AND g.periodo =  pm.clv_per
							AND g.anio =   pm.anio
							AND g.forma_imparte =  1
			GROUP BY h.cve_dia, h.hora_inicio, h.hora_final
			HAVING count ( h.cve_dia ) > 1 
			USING gtr_sce;
	
		//AND g.modalidad NOT IN(2,4)
	
			OPEN cur_materias_repetidas;
	
			IF gtr_sce.SQLCode = -1 THEN
				MessageBox ( "Error:" , "De base de datos al consultar Si hay horarios repetidos entre ~n~rlas materias remediales y las materias del paquete.~n~r~n~r" + gtr_sce.SQLErrText )
				CLOSE cur_paquetes;
				CLOSE cur_materias_repetidas;
				RETURN -1
			END IF
	
			FETCH cur_materias_repetidas INTO :li_cuenta, :li_cve_dia, :li_hora_inicio, :li_hora_final;
	
			DO WHILE gtr_sce.sqlcode <> 100
				IF li_cuenta > 1 THEN
					// Significa que hay mas de una materia del paquete con dia y horario iguales ..
					// Obtener las materias del paquete con dia y horario iguales ...
					DECLARE cur_det_materias_repetidas CURSOR FOR
						SELECT  h.cve_mat,
									( SELECT materia FROM materias WHERE materias.cve_mat = h.cve_mat ),
									( SELECT dia FROM dias WHERE dias.cve_dia = h.cve_dia ),
									h.hora_inicio,
									h.hora_final,
									h.gpo,
									h.cve_salon
						FROM paquetes_materias pm, horario h, grupos g 
						WHERE h.cve_mat = pm.clv_mat 
						AND h.gpo = pm.grupo
						AND h.periodo = pm.clv_per 
						AND h.anio = pm.anio 
						AND pm.num_paq	= :ll_num_paq 
						AND pm.clv_per = :gi_periodo 
						AND pm.anio = :gi_anio 
						AND h.cve_dia = :li_cve_dia 
						AND h.hora_inicio	= :li_hora_inicio
						AND h.hora_final = :li_hora_final 
							AND g.cve_mat = pm.clv_mat 
							AND g.gpo =  pm.grupo
							AND g.periodo =  pm.clv_per
							AND g.anio =   pm.anio
							AND g.forma_imparte =  1
						USING gtr_sce;
						
						//AND g.modalidad NOT IN(2,4)  
					
						OPEN cur_det_materias_repetidas;
			
						IF gtr_sce.SQLCode = -1 THEN
							MessageBox ( "Error:" , "De base de datos al consultar los horarios de  las materias del paquete.~n~r~n~r" + gtr_sce.SQLErrText )
							CLOSE cur_paquetes;
							CLOSE cur_materias_repetidas;
							CLOSE cur_det_materias_repetidas;
							RETURN -1
						END IF
			
						FETCH cur_det_materias_repetidas INTO :ll_cve_mat, :ls_materia, :ls_dia, :li_hora_inicio, :li_hora_final, :ls_gpo, :ls_cve_salon;
			
						DO WHILE gtr_sce.sqlcode <> 100
							// Presentar el detalle de la materia que se repite ...
							tab_1.tabpage_3.dw_4.InsertRow ( 0 )
							tab_1.tabpage_3.dw_4.Object.num_paq		[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = ll_num_paq
							tab_1.tabpage_3.dw_4.Object.cve_mat		[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = ll_cve_mat
							tab_1.tabpage_3.dw_4.Object.materia		[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = ls_materia
							tab_1.tabpage_3.dw_4.Object.dia				[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = ls_dia
							tab_1.tabpage_3.dw_4.Object.hora_inicio	[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = li_hora_inicio
							tab_1.tabpage_3.dw_4.Object.hora_final		[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = li_hora_final
							tab_1.tabpage_3.dw_4.Object.gpo				[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = ls_gpo
							tab_1.tabpage_3.dw_4.Object.cve_salon		[ tab_1.tabpage_3.dw_4.RowCount ( ) ] = ls_cve_salon
							
							FETCH cur_det_materias_repetidas INTO :ll_cve_mat, :ls_materia, :ls_dia, :li_hora_inicio, :li_hora_final, :ls_gpo, :ls_cve_salon;
						LOOP
					CLOSE cur_det_materias_repetidas;
				END IF
				
				FETCH cur_materias_repetidas INTO :li_cuenta, :li_cve_dia, :li_hora_inicio, :li_hora_final;
			LOOP
		CLOSE cur_materias_repetidas;
	
		FETCH cur_paquetes INTO :ll_num_paq;
	LOOP
CLOSE cur_paquetes;

RETURN 1
end function

public function integer wf_paquetes_materias_sin_grupo ();Long ll_num_paq, ll_cve_mat
String ls_materia, ls_grupo

tab_1.tabpage_4.dw_6.Reset ( )

DECLARE cur_paquetes CURSOR FOR
	SELECT DISTINCT dbo.aspiran.num_paq,
							dbo.paquetes_materias.clv_mat,
							(SELECT materia FROM v_materias WHERE v_materias.cve_mat = dbo.paquetes_materias.clv_mat ) as materia,
							dbo.paquetes_materias.grupo
    FROM	dbo.aspiran,
			dbo.general,
			dbo.paquetes_materias
	WHERE dbo.aspiran.folio = dbo.general.folio
	AND dbo.general.clv_ver = dbo.aspiran.clv_ver
	AND dbo.aspiran.clv_per = dbo.general.clv_per
	AND dbo.general.anio = dbo.aspiran.anio
	AND (dbo.aspiran.clv_ver = :gi_version OR :gi_version = 99) 
	AND dbo.aspiran.ing_per = :gi_periodo
	AND dbo.aspiran.ing_anio = :gi_anio
	AND dbo.aspiran.folio BETWEEN :il_folio_ini AND :il_folio_fin
	AND dbo.general.cuenta <> 0 
	AND dbo.general.cuenta IN (SELECT cuenta FROM controlescolar_bd.dbo.alumnos) 
	AND dbo.aspiran.pago_insc = 1 
	AND dbo.aspiran.status IN (1,2,4) 
	AND dbo.aspiran.num_paq = dbo.paquetes_materias.num_paq 
	AND dbo.aspiran.ing_anio = dbo.paquetes_materias.anio 
	AND dbo.aspiran.ing_per = dbo.paquetes_materias.clv_per 
	AND dbo.paquetes_materias.grupo = NULL 
	USING gtr_sadm;

	OPEN cur_paquetes;

	IF gtr_sadm.SQLCode = -1 THEN
		MessageBox ( "Error:" , "De base de datos al consultar las materias de un paquete que no tengan grupos.~n~r~n~r" + gtr_sadm.SQLErrText )
		CLOSE cur_paquetes;
		RETURN -1
	END IF

	FETCH cur_paquetes INTO :ll_num_paq, :ll_cve_mat, :ls_materia, :ls_grupo;

	DO WHILE gtr_sadm.sqlcode <> 100
		// Presentar el detalle de la materia que se repite ...
		tab_1.tabpage_4.dw_6.InsertRow ( 0 )
		tab_1.tabpage_4.dw_6.Object.num_paq		[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ll_num_paq
		tab_1.tabpage_4.dw_6.Object.cve_mat		[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ll_cve_mat
		tab_1.tabpage_4.dw_6.Object.materia		[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ls_materia
		tab_1.tabpage_4.dw_6.Object.gpo				[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ls_grupo
				
		FETCH cur_paquetes INTO :ll_num_paq, :ll_cve_mat, :ls_materia, :ls_grupo;
	LOOP

CLOSE cur_paquetes;

RETURN 1
end function

public function integer wf_verifica_carreras (integer ar_ing_anio, integer ar_ing_periodo);integer li_result

li_result = f_valida_carrera_aspirantes (ar_ing_anio, ar_ing_periodo)

IF li_result <> 0 THEN
	IF li_result = 1 THEN
		OpenWithParm ( w_consulta_validaciones , 'CAR')
		RETURN 1
	END IF

	IF li_result = -1 THEN
		RETURN -1
	END IF
END IF

RETURN 0
end function

public function integer wf_verifica_paq_gpos_inexist (integer ar_ing_anio, integer ar_ing_periodo);integer li_result

li_result = f_valida_paq_gpos_inexist(ar_ing_anio, ar_ing_periodo)

IF li_result <> 0 THEN 
	IF li_result = 1 THEN
		OpenWithParm ( w_consulta_validaciones , 'PAQ')
		RETURN 1
	END IF
	
	IF li_result = -1 THEN
		RETURN -1
	END IF
END IF

RETURN 0
end function

public function string wf_inserta_propedeuticos (long al_cve_carrera, long al_cve_plan, transaction at_transaction);RETURN ""

//String 	ls_desc_error, ls_nvo_gpo
//Long 		ll_indice, ll_cve_prerreq, ll_conflicto_horario
//
///*
//uo_paquetes luo_paquetes
//luo_paquetes = CREATE uo_paquetes
//*/
//
//FOR ll_indice = 1 TO UpperBound(il_propedeutico) 
//	ll_cve_prerreq = il_propedeutico[ll_indice]
//	
//	// Se obtiene el primer grupo que se encuentre disponible para el propedeutico
//	ls_nvo_gpo = wf_busca_gpo_propedeutico(ll_cve_prerreq)
//
//	IF Len(ls_nvo_gpo) = 0 THEN // No se encontro grupo con cupo para asignarlo al propedeutico
//		wf_inserta_mat_rechazadas_x_cupo(ll_cve_prerreq)
//		RETURN ""
//	ELSE
//		al_grupo = ls_nvo_gpo
//	END IF
//	
//	// Se inicializan variables de instancia necesarias para la validacion de horarios
//	iuo_paquetes.il_periodo = gi_periodo
//	iuo_paquetes.il_anio = gi_anio
//	iuo_paquetes.il_clv_carr = al_cve_carrera
//	iuo_paquetes.il_cuenta = il_cuenta
//	
//	// Se agrega la materia procesada al arreglo de instancia
//	il_indice = UpperBound(iuo_paquetes.il_materias)
//	IF ISNULL(il_indice) THEN il_indice  = 0
//	iuo_paquetes.il_materias[il_indice + 1] = ll_cve_prerreq
//	
//	// Validamos que el propedeutico no entre en conflicto con alguna materia del paquete
//	ll_conflicto_horario = iuo_paquetes.of_valida_horarios(al_paq, ll_cve_prerreq, al_grupo)
//
//	IF ll_conflicto_horario < 0 THEN // Si no se pudo realizar la validacion del horario del propedeutico a insertar
//		wf_inserta_mat_rechazadas_x_horario(ll_cve_prerreq, al_grupo)
//
//	ELSEIF ll_conflicto_horario > 0 THEN // Si existe conflicto de horario en el propedeutico a insertar
//		// Al buscar un nuevo grupo propedeutico ya se esta validando que exista cupo en el mismo
//		ls_nvo_gpo = wf_busca_nvo_gpo_propedeutico(iuo_paquetes.ids_prop_conflicto_horario, ll_cve_prerreq, al_grupo)
//
//		IF LEN(ls_nvo_gpo) = 0 THEN  // No se encontro nuevo grupo sin conflicto de horario para asignarlo al propedeutico
//			wf_inserta_mat_rechazadas_x_horario(iuo_paquetes.ids_prop_conflicto_horario, ll_cve_prerreq, al_grupo)
//		ELSE
//			al_grupo = ls_nvo_gpo
//			ll_conflicto_horario = 0
//		END IF
//	END IF
//
//	IF ll_conflicto_horario = 0 THEN 
//		INSERT INTO mat_inscritas (cuenta, 
//											cve_mat, 
//											gpo, 
//											periodo, 
//											anio, 
//											cve_condicion, 
//											acreditacion, 
//											inscripcion)
//		VALUES (:il_cuenta, 
//					:ll_cve_prerreq,
//					:al_grupo,
//					:gi_periodo,
//					:gi_anio, 
//					0, 
//					0, 
//					'I' )  
//		USING at_transaction;
//		
//		IF at_transaction.sqlcode = -1 THEN 
//			ls_desc_error = "De base de datos al insertar el propedeutico en mat_inscritas.~n~r~n~r" + at_transaction.SQLErrText
//			RETURN ls_desc_error
//		END IF
//	END IF		
//NEXT
//
//RETURN ""
end function

public function long wf_inserta_mat_rechazadas_x_horario (long al_cve_mat_prop, string as_gpo_prop);String ls_null, ls_comentarios, ls_materia_prop
Long 	ll_null, ll_existe

SetNull(ll_null)
SetNull(ls_null)

ls_comentarios = "No fue posible validar el horario de la materia propedeutico " + String(al_cve_mat_prop)

// Se obtiene la descripcion de la materia en conflicto
SELECT ISNULL(materia,"")
INTO :ls_materia_prop
FROM controlescolar_bd.dbo.materias
WHERE cve_mat = :al_cve_mat_prop
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al obtener la descripcion de la materia en conflicto con el propedeutico.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

SELECT COUNT(1)
INTO :ll_existe
FROM prop_materias_rechazadas
WHERE folio = :al_folio
AND clv_ver = :al_clv_ver
AND clv_per = :gi_periodo
AND anio = :gi_anio
AND CONVERT(DATE, fecha) = CONVERT(DATE, GETDATE())
AND num_paq = :al_paq
AND clv_carr = :al_carr
AND clv_plan = :al_plan
AND cve_mat = :al_cve_mat_prop
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al consultar la tabla prop_materias_rechazadas.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

IF ll_existe = 0 THEN 
	INSERT INTO prop_materias_rechazadas (folio,
														clv_ver,
														clv_per,
														anio,
														fecha,
														num_paq,
														clv_carr,
														clv_plan,
														cve_mat_prop,
														materia_prop,
														gpo_prop,
														hora_inicio_prop,
														hora_fin_prop,
														cve_dia_prop,
														cve_mat,
														materia,
														gpo,
														hora_inicio,
														hora_fin,
														cve_dia,
														comentarios)
	VALUES (:al_folio, 
				:al_clv_ver,
				:gi_periodo,
				:gi_anio,
				GETDATE(), 
				:al_paq, 
				:al_carr, 
				:al_plan,
				:al_cve_mat_prop,
				:ls_materia_prop,
				:as_gpo_prop,
				:ll_null, //hora_inicio_prop
				:ll_null, //hora_fin_prop
				:ll_null, //cve_dia_prop
				:ll_null, //cve_mat
				:ls_null, //materia,
				:ls_null, //gpo,
				:ll_null, //hora_inicio
				:ll_null, //hora_fin
				:ll_null, //cve_dia
				:ls_comentarios)  
	USING gtr_sadm;
	
	IF gtr_sadm.sqlcode = -1 THEN
		ROLLBACK USING gtr_sadm;
		MessageBox("Error:" ,"De base de datos al insertar materia rechazada por horario.~n~r~n~r" + gtr_sadm.SQLErrText )
		RETURN -1
	ELSE
		COMMIT USING gtr_sadm;
	END IF
END IF

RETURN 1
end function

public function long wf_inserta_mat_rechazadas_sin_prop (long al_cve_mat, string as_gpo);String ls_null, ls_comentarios, ls_materia
Long 	ll_null, ll_existe

SetNull(ll_null)
SetNull(ls_null)

// Se recuperan los datos de la materia recibidos en el DS
ls_comentarios = "El propedeutico " +  String (al_cve_mat) +  " no pudo reemplazar por alguna materia del paquete " + String(al_paq)

// Se obtiene la descripcion de la materia en conflicto
SELECT ISNULL(materia,"")
INTO :ls_materia
FROM controlescolar_bd.dbo.materias
WHERE cve_mat = :al_cve_mat
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al obtener la descripcion de la materia en conflicto con el propedeutico.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

SELECT COUNT(1)
INTO :ll_existe
FROM prop_materias_rechazadas
WHERE folio = :al_folio
AND clv_ver = :al_clv_ver
AND clv_per = :gi_periodo
AND anio = :gi_anio
AND CONVERT(DATE, fecha) = CONVERT(DATE, GETDATE())
AND num_paq = :al_paq
AND clv_carr = :al_carr
AND clv_plan = :al_plan
AND cve_mat = :al_cve_mat
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al consultar la tabla prop_materias_rechazadas.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

IF ll_existe = 0 THEN 
	INSERT INTO prop_materias_rechazadas (folio,
														clv_ver,
														clv_per,
														anio,
														fecha,
														num_paq,
														clv_carr,
														clv_plan,
														cve_mat_prop,
														materia_prop,
														gpo_prop,
														hora_inicio_prop,
														hora_fin_prop,
														cve_dia_prop,
														cve_mat,
														materia,
														gpo,
														hora_inicio,
														hora_fin,
														cve_dia,
														comentarios)

	VALUES (:al_folio, 
				:al_clv_ver,
				:gi_periodo,
				:gi_anio,
				GETDATE(), 
				:al_paq, 
				:al_carr, 
				:al_plan,
				:al_cve_mat,
				:ls_materia,
				:as_gpo,
				:ll_null, 
				:ll_null,
				:ll_null,
				:ll_null,
				:ls_null,
				:ls_null,
				:ll_null,
				:ll_null, 
				:ll_null,
				:ls_comentarios)  
	USING gtr_sadm;

	IF gtr_sadm.sqlcode = -1 THEN 
		ROLLBACK USING gtr_sadm;
		MessageBox("Error:" ,"De base de datos al insertar materia rechazada por falta de propedeutico.~n~r~n~r" + gtr_sadm.SQLErrText )
		RETURN -1
	ELSE
		COMMIT USING gtr_sadm;
	END IF
END IF	

RETURN 1
end function

public function string wf_busca_nvo_gpo_propedeutico (datastore ads_info_materia, long al_cve_mat_prop, string as_gpo_prop);String ls_gpo, ls_datos_materia_conflicto, ls_token, ls_nvo_gpo
Long 	ll_hora_inicio_prop, ll_hora_fin_prop, ll_cve_dia_prop, ll_indice, &
		ll_cve_mat, ll_hora_inicio, ll_hora_fin, ll_cve_dia, ll_pos, ll_conflicto_horario, ll_resultado

/*
uo_paquetes luo_paquetes
luo_paquetes = CREATE uo_paquetes
*/

// Se recuperan los datos de la materia recibidos en el DS
ll_hora_inicio_prop = ads_info_materia.getItemNumber(1, "hora_inicial")
ll_hora_fin_prop = ads_info_materia.getItemNumber(1, "hora_final")
ll_cve_dia_prop = ads_info_materia.getItemNumber(1, "id_dia")
ls_datos_materia_conflicto = ads_info_materia.getItemString(1, "materia_conflicto")
ls_datos_materia_conflicto = TRIM(ls_datos_materia_conflicto)

IF LEN(ls_datos_materia_conflicto) > 0 THEN ls_datos_materia_conflicto = ls_datos_materia_conflicto +  ","

DO WHILE LEN(ls_datos_materia_conflicto) > 0
	ll_indice = ll_indice + 1
	ll_pos = Pos(ls_datos_materia_conflicto, ",")
	ls_token = Mid(ls_datos_materia_conflicto,0, ll_pos - 1) 
	ls_datos_materia_conflicto = Mid(ls_datos_materia_conflicto, ll_pos + 1, LEN(ls_datos_materia_conflicto)) 
	
	CHOOSE CASE ll_indice
		CASE 1 // Clave Materia
			ll_cve_mat = Long(ls_token)
		CASE 2 // Grupo
			ls_gpo = ls_token
		CASE 3 // Hora Inicio
			ll_hora_inicio = Long(ls_token)
		CASE 4 // Hora Fin
			ll_hora_fin = Long(ls_token)
		CASE 5 // Día
			ll_cve_dia = Long(ls_token)
	END CHOOSE			
LOOP

DATASTORE lds_horarios
lds_horarios = CREATE DATASTORE 
lds_horarios.DATAOBJECT = "d_horarios_mat_propedeutico" 
lds_horarios.SETTRANSOBJECT(gtr_sce) 
ll_resultado = lds_horarios.RETRIEVE(gi_periodo, gi_anio, al_cve_mat_prop, ll_hora_inicio_prop, ll_hora_fin_prop, &
												as_gpo_prop, ll_hora_inicio, ll_hora_fin, ls_gpo)

IF ll_resultado <= 0 THEN 
    RETURN ""
END IF 

// Se inicializan variables de instancia necesarias para la validacion de horarios
iuo_paquetes.il_periodo = gi_periodo
iuo_paquetes.il_anio = gi_anio
iuo_paquetes.il_clv_carr = al_carr

FOR ll_indice = 1 TO lds_horarios.rowcount( )
	// Se obtiene el grupo del posible horario disponible
	as_gpo_prop = lds_horarios.getItemString(ll_indice, "horario_gpo")
	
	// Se valida que la materia del propedeutico no entre en conflicto de horario con alguna otra materia
	ll_conflicto_horario = iuo_paquetes.of_valida_horarios(al_paq, al_cve_mat_prop, as_gpo_prop)
	
	IF ll_conflicto_horario = 0 THEN 
		RETURN as_gpo_prop
	END IF		
NEXT

RETURN ""
end function

public function long wf_inserta_mat_rechazadas_x_horario (datastore ads_info_materia, long al_cve_mat_prop, string as_gpo_prop);Datetime ldt_fecha
String ls_comentarios, ls_materia, ls_gpo, ls_datos_materia_conflicto, ls_token, ls_materia_prop
Long 	ll_hora_inicio_prop, ll_hora_fin_prop, ll_cve_dia_prop, &
		ll_cve_mat, ll_hora_inicio, ll_hora_fin, ll_cve_dia, ll_indice, ll_pos, ll_existe

// Se recuperan los datos de la materia recibidos en el DS
ll_hora_inicio_prop = ads_info_materia.getItemNumber(1, "hora_inicial")
ll_hora_fin_prop = ads_info_materia.getItemNumber(1, "hora_final")
ll_cve_dia_prop = ads_info_materia.getItemNumber(1, "id_dia")
ls_datos_materia_conflicto = ads_info_materia.getItemString(1, "materia_conflicto")
ls_datos_materia_conflicto = TRIM(ls_datos_materia_conflicto)
ls_comentarios = "El dia y horario de la materia propedeutico coincide con el dia y horario de la materia "

IF LEN(ls_datos_materia_conflicto) > 0 THEN ls_datos_materia_conflicto = ls_datos_materia_conflicto +  ","

DO WHILE LEN(ls_datos_materia_conflicto) > 0
	ll_indice = ll_indice + 1
	ll_pos = Pos(ls_datos_materia_conflicto, ",")
	ls_token = Mid(ls_datos_materia_conflicto,0, ll_pos - 1) 
	ls_datos_materia_conflicto = Mid(ls_datos_materia_conflicto, ll_pos + 1, LEN(ls_datos_materia_conflicto)) 
	
	CHOOSE CASE ll_indice
		CASE 1 // Clave Materia
			ll_cve_mat = Long(ls_token)
			ls_comentarios = ls_comentarios + String(ll_cve_mat)
		CASE 2 // Grupo
			ls_gpo = ls_token
		CASE 3 // Hora Inicio
			ll_hora_inicio = Long(ls_token)
		CASE 4 // Hora Fin
			ll_hora_fin = Long(ls_token)
		CASE 5 // Día
			ll_cve_dia = Long(ls_token)
	END CHOOSE			
LOOP

// Se obtiene la descripcion de la materia en conflicto
SELECT ISNULL(materia,"")
INTO :ls_materia
FROM controlescolar_bd.dbo.materias
WHERE cve_mat = :ll_cve_mat
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al obtener la descripcion de la materia en conflicto con el propedeutico.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

// Se obtiene la descripcion de la materia del propedeutico
SELECT ISNULL(materia,"")
INTO :ls_materia_prop
FROM controlescolar_bd.dbo.materias
WHERE cve_mat = :al_cve_mat_prop
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al obtener la descripcion de la materia propedeutico.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

SELECT COUNT(1)
INTO :ll_existe
FROM prop_materias_rechazadas
WHERE folio = :al_folio
AND clv_ver = :al_clv_ver
AND clv_per = :gi_periodo
AND anio = :gi_anio
AND CONVERT(DATE, fecha) = CONVERT(DATE, GETDATE())
AND num_paq = :al_paq
AND clv_carr = :al_carr
AND clv_plan = :al_plan
AND cve_mat = :al_cve_mat_prop
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al consultar la tabla prop_materias_rechazadas.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

IF ll_existe = 0 THEN 
	INSERT INTO prop_materias_rechazadas (folio,
														clv_ver,
														clv_per,
														anio,
														fecha,
														num_paq,
														clv_carr,
														clv_plan,
														cve_mat_prop,
														materia_prop,
														gpo_prop,
														hora_inicio_prop,
														hora_fin_prop,   
														cve_dia_prop,    
														cve_mat,         
														materia,			
														gpo,             
														hora_inicio,
														hora_fin,        
														cve_dia,         
														comentarios)
	VALUES (:al_folio, 
				:al_clv_ver,
				:gi_periodo,
				:gi_anio,
				GETDATE(), 
				:al_paq, 
				:al_carr, 
				:al_plan,
				:al_cve_mat_prop,
				:ls_materia_prop,
				:as_gpo_prop,
				:ll_hora_inicio_prop, 
				:ll_hora_fin_prop,
				:ll_cve_dia_prop,
				:ll_cve_mat,
				:ls_materia,
				:ls_gpo,
				:ll_hora_inicio,
				:ll_hora_fin, 
				:ll_cve_dia,
				:ls_comentarios)  
	USING gtr_sadm;
	
	IF gtr_sadm.sqlcode = -1 THEN 
		ROLLBACK USING gtr_sadm;
		MessageBox("Error:" ,"De base de datos al insertar materia rechazada por horario.~n~r~n~r" + gtr_sadm.SQLErrText )
		RETURN -1
	ELSE
		COMMIT USING gtr_sadm;
	END IF
END IF

RETURN 1
end function

public function boolean wf_existe_mat_teoria_lab (long al_mat_lab);RETURN FALSE
//Long ll_indice
//
//FOR ll_indice = 1 TO UpperBound(il_teoria_lab)
//	IF il_teoria_lab[ll_indice] =  al_mat_lab THEN
//		RETURN TRUE
//	END IF		
//NEXT	
//
//RETURN FALSE
end function

public function boolean wf_tiene_propedeuticos (long al_cuenta, long al_periodo, long al_anio, long al_cve_carrera, long al_cve_plan, long al_cve_mat);Long ll_indice1, ll_cve_prerreq, ll_nulo[]

il_propedeutico[] = ll_nulo[] 

DECLARE cur_propedeuticos CURSOR FOR
	SELECT ISNULL(c.cve_prerreq, 0)
	FROM prop_alumno_asignacion a
	INNER JOIN prop_rel_materia b ON b.id_prop = a.id_prop
	INNER JOIN controlescolar_bd.dbo.prerrequisitos_esp c  ON c.cve_prerreq = b.cve_materia
	LEFT JOIN controlescolar_bd.dbo.teoria_lab_primer_ing d ON d.cve_carrera = c.cve_carrera
	AND d.cve_plan = c.cve_plan
	AND (d.cve_teoria = :al_cve_mat OR d.cve_lab  = :al_cve_mat)
	WHERE a.cuenta = :al_cuenta
	AND a.periodo = :al_periodo
	AND a.anio = :al_anio
	AND c.cve_carrera = :al_cve_carrera
	AND c.cve_plan = :al_cve_plan
	AND c.cve_mat = :al_cve_mat
	USING gtr_sadm;

	OPEN cur_propedeuticos;

	IF gtr_sadm.SQLCode = -1 THEN
		MessageBox ( "Error:" , "De base de datos al consultar los propedeuticos.~n~r~n~r" + gtr_sadm.SQLErrText )
		CLOSE cur_propedeuticos;
		RETURN FALSE
	END IF

	FETCH cur_propedeuticos INTO :ll_cve_prerreq;

	DO WHILE gtr_sadm.sqlcode <> 100
		ll_indice1 = ll_indice1  + 1
		il_propedeutico[ll_indice1] = ll_cve_prerreq
		
		FETCH cur_propedeuticos INTO :ll_cve_prerreq;
	LOOP

CLOSE cur_propedeuticos;

IF UpperBound(il_propedeutico) > 0 THEN 
	RETURN TRUE
END IF

RETURN FALSE
end function

public function boolean wf_existe_propedeutico_mat_inscritas (long al_cuenta, long al_cve_propedeutico);Long ll_existe

SELECT COUNT(1)
INTO :ll_existe
FROM mat_inscritas
WHERE cuenta = :al_cuenta
AND cve_mat = :al_cve_propedeutico
USING gtr_sce;

IF gtr_sce.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al consultar la tabla mat_inscritas.~n~r~n~r" + gtr_sce.SQLErrText )
	RETURN FALSE
END IF

IF ll_existe > 0 THEN 
	RETURN TRUE
END IF 	

RETURN FALSE
end function

public subroutine wf_elimina_propedeutico_asignado (long al_cve_materia);Long i, ll_indice, ll_array[] 

ll_indice = UpperBound(ll_array[])

FOR i = 1 TO UpperBound(il_propedeutico)
	IF il_propedeutico[i] <> al_cve_materia THEN 
		ll_indice = ll_indice + 1
		ll_array[ll_indice] = il_propedeutico[i]
	END IF
NEXT

il_propedeutico[] = ll_array[]

RETURN
end subroutine

public function string wf_busca_gpo_propedeutico (long al_cve_propedeutico);String ls_gpo

ls_gpo = ""

SELECT TOP 1 gpo
INTO :ls_gpo
FROM grupos
WHERE anio = :gi_anio
AND periodo = :gi_periodo
AND cve_mat = :al_cve_propedeutico
AND inscritos < cupo
USING gtr_sce;

IF gtr_sce.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al consultar la tabla grupos.~n~r~n~r" + gtr_sce.SQLErrText )
	RETURN ""
END IF

RETURN ls_gpo
end function

public function long wf_inserta_mat_rechazadas_x_cupo (long al_cve_mat_prop);String ls_null, ls_comentarios, ls_materia_prop
Long 	ll_null, ll_existe

SetNull(ll_null)
SetNull(ls_null)

ls_comentarios = "La materia propedeutico " + String(al_cve_mat_prop) + " no tiene grupo disponible con cupo "

// Se obtiene la descripcion de la materia en conflicto
SELECT ISNULL(materia,"")
INTO :ls_materia_prop
FROM controlescolar_bd.dbo.materias
WHERE cve_mat = :al_cve_mat_prop
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al obtener la descripcion de la materia en conflicto con el propedeutico.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

SELECT COUNT(1)
INTO :ll_existe
FROM prop_materias_rechazadas
WHERE folio = :al_folio
AND clv_ver = :al_clv_ver
AND clv_per = :gi_periodo
AND anio = :gi_anio
AND CONVERT(DATE, fecha) = CONVERT(DATE, GETDATE())
AND num_paq = :al_paq
AND clv_carr = :al_carr
AND clv_plan = :al_plan
AND cve_mat = :al_cve_mat_prop
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al consultar la tabla prop_materias_rechazadas.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

IF ll_existe = 0 THEN 
	INSERT INTO prop_materias_rechazadas (folio,
														clv_ver,
														clv_per,
														anio,
														fecha,
														num_paq,
														clv_carr,
														clv_plan,
														cve_mat_prop,
														materia_prop,
														gpo_prop,
														hora_inicio_prop,
														hora_fin_prop,
														cve_dia_prop,
														cve_mat,
														materia,
														gpo,
														hora_inicio,
														hora_fin,
														cve_dia,
														comentarios)
	VALUES (:al_folio, 
				:al_clv_ver,
				:gi_periodo,
				:gi_anio,
				GETDATE(), 
				:al_paq, 
				:al_carr, 
				:al_plan,
				:al_cve_mat_prop,
				:ls_materia_prop,
				:ls_null,// gpo_prop,
				:ll_null, // hora_inicio_prop
				:ll_null, // hora_fin_prop
				:ll_null, // cve_dia_prop
				:ll_null, // cve_mat
				:ls_null, // materia
				:ls_null, // gpo
				:ll_null, // hora_inicio
				:ll_null, // hora_fin
				:ll_null, // cve_dia
				:ls_comentarios)  
	USING gtr_sadm;
	
	IF gtr_sadm.sqlcode = -1 THEN 
		ROLLBACK USING gtr_sadm;
		MessageBox("Error:" ,"De base de datos al insertar materia rechazada por horario.~n~r~n~r" + gtr_sadm.SQLErrText )
		RETURN -1
	ELSE
		COMMIT USING gtr_sadm;
	END IF
END IF

RETURN 1
end function

public function long wf_obtiene_cuenta_propedeutico (long al_cve_carrera, long al_cve_plan, long al_cve_mat, ref string as_enlace);RETURN 0

//Long ll_cve_propedeutico, ll_cve_teoria, ll_cve_lab, ll_indice
//
//SELECT ISNULL(a.cve_prerreq, 0), ISNULL(c.cve_teoria, 0), ISNULL(c.cve_lab, 0), a.enlace
//INTO :ll_cve_propedeutico, :ll_cve_teoria, :ll_cve_lab, :as_enlace
//FROM controlescolar_bd.dbo.prerrequisitos_esp a 
//INNER JOIN prop_rel_materia b ON b.cve_materia = a.cve_prerreq
//LEFT JOIN controlescolar_bd.dbo.teoria_lab_primer_ing c ON c.cve_carrera = a.cve_carrera
//AND c.cve_plan = a.cve_plan
//AND (c.cve_teoria = :al_cve_mat OR c.cve_lab  = :al_cve_mat)
//WHERE a.cve_carrera = :al_cve_carrera
//AND a.cve_plan = :al_cve_plan
//AND a.cve_mat = :al_cve_mat
//USING gtr_sadm;
//
//IF gtr_sadm.sqlcode = -1 THEN 
//	MessageBox("Error:" ,"De base de datos al obtener la clave del propedeutico.~n~r~n~r" + gtr_sadm.SQLErrText )
//	RETURN -1
//END IF
//
//ll_indice = UpperBound(il_teoria_lab) + 1
//
//IF as_enlace <> "O" THEN 
//	IF ll_cve_teoria = al_cve_mat THEN 
//		il_teoria_lab[ll_indice] = ll_cve_lab
//	ELSEIF ll_cve_lab = al_cve_mat THEN 
//		il_teoria_lab[ll_indice] = ll_cve_teoria
//	END IF
//END IF	
//
//RETURN ll_cve_propedeutico
end function

public function string wf_asigna_teoria_lab (long al_cuenta, long al_periodo, long al_anio, long al_cve_carrera, long al_cve_plan, long al_cve_mat);RETURN ""

//Long ll_indice2, ll_cve_teoria, ll_cve_lab, ll_nulo[]
//String ls_enlace, ls_enlace_resp
//
//il_teoria_lab[] = ll_nulo[] 
//
//DECLARE cur_teoria_lab CURSOR FOR
//	SELECT DISTINCT ISNULL(d.cve_teoria, 0), ISNULL(d.cve_lab, 0), c.enlace
//	FROM prop_alumno_asignacion a
//	INNER JOIN prop_rel_materia b ON b.id_prop = a.id_prop
//	INNER JOIN controlescolar_bd.dbo.prerrequisitos_esp c  ON c.cve_prerreq = b.cve_materia
//	LEFT JOIN controlescolar_bd.dbo.teoria_lab_primer_ing d ON d.cve_carrera = c.cve_carrera
//	AND d.cve_plan = c.cve_plan
//	AND (d.cve_teoria = :al_cve_mat OR d.cve_lab  = :al_cve_mat)
//	WHERE a.cuenta = :al_cuenta
//	AND a.periodo = :al_periodo
//	AND a.anio = :al_anio
//	AND c.cve_carrera = :al_cve_carrera
//	AND c.cve_plan = :al_cve_plan
//	USING gtr_sadm;
//
//	OPEN cur_teoria_lab;
//
//	IF gtr_sadm.SQLCode = -1 THEN
//		MessageBox ( "Error:" , "De base de datos al consultar los propedeuticos.~n~r~n~r" + gtr_sadm.SQLErrText )
//		CLOSE cur_teoria_lab;
//		RETURN ls_enlace_resp
//	END IF
//
//	FETCH cur_teoria_lab INTO :ll_cve_teoria, :ll_cve_lab, :ls_enlace;
//
//	DO WHILE gtr_sadm.sqlcode <> 100
//		IF ls_enlace <> "O" THEN
//			ll_indice2 = ll_indice2  + 1
//			ls_enlace_resp = ls_enlace
//
//			IF ll_cve_teoria = al_cve_mat THEN 
//				il_teoria_lab[ll_indice2] = ll_cve_lab
//			ELSEIF ll_cve_lab = al_cve_mat THEN 
//				il_teoria_lab[ll_indice2] = ll_cve_teoria
//			END IF
//		END IF
//
//		FETCH cur_teoria_lab INTO :ll_cve_teoria, :ll_cve_lab, :ls_enlace;
//	LOOP
//
//CLOSE cur_teoria_lab;
//
//RETURN ls_enlace_resp
end function

public function long wf_cve_mat_pertenece_teoria_lab (long al_cve_carrera, long al_cve_plan, long al_cve_mat);Long ll_existe

SELECT COUNT(1)
INTO :ll_existe
FROM controlescolar_bd.dbo.teoria_lab_primer_ing
WHERE (cve_teoria = :al_cve_mat OR cve_lab  = :al_cve_mat)
AND cve_carrera = :al_cve_carrera
AND cve_plan = :al_cve_plan
USING gtr_sadm;

IF gtr_sadm.sqlcode = -1 THEN 
	MessageBox("Error:" ,"De base de datos al leer la tabla teoria_lab_primer_ing.~n~r~n~r" + gtr_sadm.SQLErrText )
	RETURN -1
END IF

RETURN ll_existe
end function

public function integer wf_valida_horario_mat_inscritas (long cta, long mat, string gpo);
INTEGER li_resultado
STRING ls_mensaje
INTEGER li_materia_cruce
STRING ls_grupo_cruce
STRING ls_sesionado 

DECLARE  sp_validacion_materias_encimadas PROCEDURE FOR sp_srl_validacion_materias_enc
@CUENTA				= :cta,
@MATERIA				= :mat,
@GRUPO					= :gpo,
@RESULTADO			= :li_resultado OUTPUT,
@MENSAJE				= :ls_mensaje OUTPUT,
@MATERIA_CRUCE	= :li_materia_cruce OUTPUT,
@GRUPO_CRUCE		= :ls_grupo_cruce OUTPUT
USING gtr_sce ;

EXECUTE sp_validacion_materias_encimadas ;

FETCH sp_validacion_materias_encimadas INTO :li_resultado, :ls_mensaje, :li_materia_cruce, :ls_grupo_cruce, :ls_sesionado;

CLOSE sp_validacion_materias_encimadas;
	
IF	li_resultado <> 0 THEN
	//MessageBox ("El horario se encima", "El alumno con número de cuenta "+string(cta)+" no puede inscribir la materia " + String (mat) + " grupo '" + gpo + "'. ~rTiene inscrita la materia " + String (li_materia_cruce) + " grupo '" + ls_grupo_cruce + "' en horario similar al de la materia que se quiere inscribir.",Exclamation!)
	Return 1
END IF
Commit using gtr_sce;

RETURN 0 


end function

public function integer wf_inscribe_materia (long al_cuenta, long al_cve_mat, string as_grupo, integer al_periodo, integer al_anio);
STRING ls_error 

// Se inscribe la materia.
INSERT INTO mat_inscritas (cuenta,  cve_mat,  gpo,  periodo,  anio, 
									cve_condicion,  acreditacion,  inscripcion)
VALUES (:al_cuenta, :al_cve_mat, :as_grupo, :al_periodo, :al_anio, 
			0, 0, 'I')  
USING gtr_sce;

IF gtr_sce.sqlcode < 0 THEN
	ls_error = gtr_sce.SQLErrText
	ROLLBACK USING gtr_sce;
	MessageBox("Sybase Database Error", ls_error, Exclamation!)
	RETURN -1
ELSE
	//ls_error = wf_inserta_propedeuticos( al_carr, al_plan, gtr_sce)
	IF ls_error <> "" THEN
		ROLLBACK USING gtr_sce;
		MessageBox("Sybase Database Error", ls_error, Exclamation!)
		RETURN - 1
	END IF			
END IF

Commit Using gtr_sce;

RETURN 0 
end function

public function integer wf_valida_materia_inscrita (long al_cuenta, long al_cve_mat, integer al_periodo, integer al_anio);
STRING ls_error 
INTEGER le_numero

// Se verifica si la matertia ya fue inscrita.
SELECT COUNT(*) 
INTO :le_numero
FROM mat_inscritas
WHERE cuenta = :al_cuenta 
AND cve_mat = :al_cve_mat 
AND periodo = :al_periodo 
AND anio = :al_anio
USING gtr_sce;

IF gtr_sce.SQLErrText<>"" THEN
	ls_error = gtr_sce.SQLErrText
	ROLLBACK USING gtr_sce;
	MessageBox("Sybase Database Error", ls_error, Exclamation!)
	RETURN -1
ELSE
	ls_error = wf_inserta_propedeuticos( al_carr, al_plan, gtr_sce)
	IF ls_error <> "" THEN
		ROLLBACK USING gtr_sce;
		MessageBox("Sybase Database Error", ls_error, Exclamation!)
		RETURN - 1
	END IF			
END IF

Commit Using gtr_sce;

RETURN le_numero 



end function

public function string wf_busca_gpo_propedeutico (long al_cve_prop, integer ai_periodo, integer ai_anio, long al_materias[]);STRING ls_nvo_gpo 
STRING ls_sql 
INTEGER ll_num_rows, le_pos
LONG ll_conflicto_horario 
BOOLEAN lb_encuentra

ls_sql = " SELECT g.cve_mat, g.gpo, g.cupo, g.inscritos, g.cupo - g.inscritos AS diponibles " + & 
		" FROM controlescolar_bd.dbo.grupos g " + & 
		" WHERE g.cve_mat = " + STRING(al_cve_prop) + &  
		" AND g.periodo =  " + STRING(ai_periodo) + &
		" AND g.anio = " + STRING(ai_anio) + &
		" AND g.cupo > g.inscritos "

// Se filtran los grupos disponibles del propedéutico 
ids_grupos_prop.DATAOBJECT = "dw_grupos_propedeuticos_disp" 
ids_grupos_prop.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'" ) 
ids_grupos_prop.SETTRANSOBJECT(gtr_sce)
ll_num_rows = ids_grupos_prop.RETRIEVE() 
IF ll_num_rows < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar los grupos propedéuticos." + gtr_sce.SQLERRTEXT)  	 
	RETURN ""
END IF 	
		
FOR le_pos = 1 TO ll_num_rows 
		
	ls_nvo_gpo = ids_grupos_prop.GETITEMSTRING(le_pos, "gpo") 
		
	// Se inicializan variables de instancia necesarias para la validacion de horarios
	iuo_paquetes.il_periodo = ai_periodo
	iuo_paquetes.il_anio = ai_anio
	iuo_paquetes.il_clv_carr = al_carr
	iuo_paquetes.il_cuenta = il_cuenta	
	iuo_paquetes.il_materias[] = al_materias[] 

	// Se valida que la materia del propedeutico no entre en conflicto de horario con alguna otra materia
	ll_conflicto_horario = iuo_paquetes.of_valida_horarios(al_paq, al_cve_prop, ls_nvo_gpo)
	
	// Si no se pudo verificar el horario
	IF ll_conflicto_horario < 0 THEN 
		RETURN "" 
	// Si existe conflicto de horario en el propedeutico a insertar Continua con el siguiente grupo 
	ELSEIF ll_conflicto_horario > 0 THEN 
		CONTINUE 
	// Si no hay conflicto se selecciona el grupo para inscribirlo 
	ELSE
		lb_encuentra = TRUE 
		EXIT 
	END IF 	
	
NEXT 

IF NOT lb_encuentra THEN ls_nvo_gpo = ""

RETURN ls_nvo_gpo

end function

on w_enlace_mat_sce.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_1=create cbx_1
this.dw_5=create dw_5
this.cb_1=create cb_1
this.dw_horarios_remedial_esp=create dw_horarios_remedial_esp
this.dw_horarios_remedial_mat=create dw_horarios_remedial_mat
this.st_5=create st_5
this.st_4=create st_4
this.st_fin=create st_fin
this.st_ini=create st_ini
this.dw_1=create dw_1
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_4=create gb_4
this.st_1=create st_1
this.tab_1=create tab_1
this.gb_3=create gb_3
this.Control[]={this.cbx_1,&
this.dw_5,&
this.cb_1,&
this.dw_horarios_remedial_esp,&
this.dw_horarios_remedial_mat,&
this.st_5,&
this.st_4,&
this.st_fin,&
this.st_ini,&
this.dw_1,&
this.uo_1,&
this.em_max,&
this.em_min,&
this.gb_1,&
this.gb_2,&
this.gb_4,&
this.st_1,&
this.tab_1,&
this.gb_3}
end on

on w_enlace_mat_sce.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_1)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.dw_horarios_remedial_esp)
destroy(this.dw_horarios_remedial_mat)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_fin)
destroy(this.st_ini)
destroy(this.dw_1)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_4)
destroy(this.st_1)
destroy(this.tab_1)
destroy(this.gb_3)
end on

event open;String		ls_sintaxis_sql	/* OSS 24-Ago-2011 */
String		ls_mensaje		/* OSS 14-Dic-2011 */

x=1
y=1

dw_1.settransobject(gtr_sadm)

tab_1.tabpage_1.dw_2.settransobject(gtr_sadm)


tab_1.tabpage_1.em_periodo.text = string (gi_periodo)
tab_1.tabpage_1.em_anio.text = string (gi_anio)

/* OSS 24-Ago-2011 */

IF f_conecta_pas_parametros_bd ( gtr_sce , itr_web , 11 , gs_usuario , gs_password ) = 0 THEN
	ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
	MessageBox("Error", ls_mensaje, StopSign!)
	return -1
END IF



//// Se crea datastore para el manejo de Teoria-Laboratorio. 
//ids_teoria_aboratorio = CREATE DATASTORE 
//ids_teoria_aboratorio.DATAOBJECT = "dw_teoria_lab_1er_ing"
//// Se crea datastore para carga de propedeúticos asignados.
//ids_preopeduticos = CREATE DATASTORE 
//ids_preopeduticos.DATAOBJECT = "dw_propedeuticos_aplicados"









//// Establecer la conexión a la base de datos web de SQLServer ...
////if isvalid(itr_web) = false  then
////	itr_web = CREATE transaction//Creación de la transacción
////end if
////
/////* Populate sqlca from current PB.INI settings */
////itr_web.DBMS		= ProfileString (gs_startupfile, "WEB_PARAM", "dbms",       "")
////itr_web.database	= ProfileString (gs_startupfile, "WEB_PARAM", "database",   "")
////itr_web.userid		= ProfileString (gs_startupfile, "WEB_PARAM", "userid",     "")
////itr_web.dbpass		= ProfileString (gs_startupfile, "WEB_PARAM", "dbpass",     "")
////
////
////itr_web.servername	= ProfileString (gs_startupfile, "WEB_PARAM", "servername", "")
////itr_web.dbparm		= ProfileString (gs_startupfile, "WEB_PARAM", "dbparm",     "OJSyntax='PB'")
////
////itr_web.logid		= gs_usuario
////itr_web.logpass	= gs_password
////
//////Conexión a la base de datos
////connect using itr_web;
////
////if itr_web.sqlcode <> 0 then
////	MessageBox ("No hay conexión con la Base de Datos "+"WEB_PARAM"+".", itr_web.sqlerrtext, None!)
////	Close ( This )
////ELSE
////	if itr_web.DBMS = 'OLE DB' then
////		ls_sintaxis_sql = 'SET IMPLICIT_TRANSACTIONS OFF'
////		EXECUTE IMMEDIATE :ls_sintaxis_sql USING itr_web;
////	end if
////end if


/*
IF conecta_bd(itr_web,"WEB_PARAM", gs_usuario, gs_password)<>1 THEN
	
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	
	Close ( This )
END IF
*/

dw_5.SetTransObject ( gtr_sadm )



 




/* OSS 24-Ago-2011 */
end event

type cbx_1 from checkbox within w_enlace_mat_sce
integer x = 2336
integer y = 260
integer width = 1449
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Confirmar borrado de materias inscritas por alumno"
end type

type dw_5 from datawindow within w_enlace_mat_sce
boolean visible = false
integer x = 1582
integer y = 2388
integer width = 1202
integer height = 472
integer taborder = 60
string title = "none"
string dataobject = "dw_aspiran_remediales_inscritas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_enlace_mat_sce
integer x = 3250
integer y = 72
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Buscar"
end type

event clicked;str_aspirante	lstr_aspirante
Int					li_renglon_encontrado

lstr_aspirante.folio		= 0
lstr_aspirante.clv_ver	= gi_version
lstr_aspirante.clv_per	= gi_periodo
lstr_aspirante.anio		= gi_anio

OpenWithParm ( w_busqueda_aspirante , lstr_aspirante )

lstr_aspirante = Message.powerObjectparm

IF lstr_aspirante.folio > 0 THEN
	// Presentar el folio del aspirante ...
	em_min.Text = String ( lstr_aspirante.folio )
	em_max.Text = String ( lstr_aspirante.folio )

	// Obtener la versión y asignarla a la variable global ...
	gi_version = lstr_aspirante.clv_ver	
	li_renglon_encontrado = uo_1.dw_ver.Find ( 'clv_ver=' + String ( gi_version ) , 1 , uo_1.dw_ver.RowCount ( ) )
	uo_1.dw_ver.SelectRow ( li_renglon_encontrado , True )
	uo_1.dw_ver.SCrollToRow ( li_renglon_encontrado )

	dw_1.Event Carga ( )
END IF
end event

type dw_horarios_remedial_esp from datawindow within w_enlace_mat_sce
boolean visible = false
integer x = 827
integer y = 2376
integer width = 718
integer height = 396
integer taborder = 50
string title = "none"
string dataobject = "dw_horarios_mat_remediales"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_horarios_remedial_mat from datawindow within w_enlace_mat_sce
boolean visible = false
integer y = 2376
integer width = 718
integer height = 396
integer taborder = 50
string title = "none"
string dataobject = "dw_horarios_mat_remediales"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_5 from statictext within w_enlace_mat_sce
integer x = 32
integer y = 388
integer width = 466
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fin del Enlace:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_4 from statictext within w_enlace_mat_sce
integer x = 32
integer y = 300
integer width = 466
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inicio del Enlace:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_fin from statictext within w_enlace_mat_sce
integer x = 558
integer y = 388
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_ini from statictext within w_enlace_mat_sce
integer x = 558
integer y = 300
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_1 from uo_dw_reporte within w_enlace_mat_sce
integer x = 73
integer y = 604
integer width = 3657
integer height = 604
integer taborder = 0
string dataobject = "dw_aspi-alum_sce_ing_con_paq"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event carga;Integer li_confirma, li_obten_server_bd
String ls_min, ls_max

ls_min = em_min.text
ls_max = em_max.text
il_folio_ini = Long(ls_min)
il_folio_fin = Long(ls_max)

li_obten_server_bd = f_obten_server_bd(gtr_sce,'controlescolar_bd',1)

/* 04-Ene-2012 Toño indica que se quite esta validación */
//if li_obten_server_bd<> 0 then
//	MessageBox("Error de Enlace",'No es posible ejecutar el enlace de materias durante los Ajustes de Inscripción', StopSign!)
//	return -1
//end if	
	
li_confirma= MessageBox("Confirmación","¿Desea realizar el enlace de materias? ["+ls_min+"] ["+ls_max+"]",Question!, YesNo!)

IF li_confirma= 1 THEN
	st_1.text="Leyendo datos de los aspirantes inscritos"
	RETURN retrieve(gi_version,gi_periodo,gi_anio,il_folio_ini,il_folio_fin)
END IF

RETURN 0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event retrieveend;call super::retrieveend;PARENT.EVENT enlace()
end event

type uo_1 from uo_ver_per_ani within w_enlace_mat_sce
integer x = 27
integer y = 56
integer height = 168
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_enlace_mat_sce
integer x = 2757
integer y = 80
integer width = 338
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_enlace_mat_sce
integer x = 2400
integer y = 80
integer width = 338
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type gb_1 from groupbox within w_enlace_mat_sce
integer y = 508
integer width = 3799
integer height = 744
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Aspirantes"
end type

type gb_2 from groupbox within w_enlace_mat_sce
integer x = 2336
integer width = 818
integer height = 212
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rango de Folios"
borderstyle borderstyle = stylebox!
end type

type gb_4 from groupbox within w_enlace_mat_sce
integer y = 216
integer width = 3799
integer height = 292
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Avance Enlace"
end type

type st_1 from statictext within w_enlace_mat_sce
integer x = 1275
integer y = 360
integer width = 2473
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;text=""
end event

type tab_1 from tab within w_enlace_mat_sce
integer x = 5
integer y = 1276
integer width = 3794
integer height = 1104
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
end on

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3758
integer height = 976
long backcolor = 67108864
string text = "Materias por Paquete"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
em_periodo em_periodo
em_anio em_anio
st_7 st_7
st_6 st_6
dw_2 dw_2
end type

on tabpage_1.create
this.em_periodo=create em_periodo
this.em_anio=create em_anio
this.st_7=create st_7
this.st_6=create st_6
this.dw_2=create dw_2
this.Control[]={this.em_periodo,&
this.em_anio,&
this.st_7,&
this.st_6,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.em_periodo)
destroy(this.em_anio)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.dw_2)
end on

type em_periodo from editmask within tabpage_1
integer x = 2423
integer y = 344
integer width = 389
integer height = 104
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
string mask = "#"
boolean autoskip = true
boolean spin = true
string displaydata = "Primavera~t0/Verano~t1/Otoño~t2/"
double increment = 1
string minmax = "0~~2"
boolean usecodetable = true
end type

type em_anio from editmask within tabpage_1
integer x = 2423
integer y = 224
integer width = 389
integer height = 104
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
string mask = "####"
end type

type st_7 from statictext within tabpage_1
integer x = 1897
integer y = 340
integer width = 466
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Periodo Materias"
boolean focusrectangle = false
end type

type st_6 from statictext within tabpage_1
integer x = 1998
integer y = 220
integer width = 366
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Año Materias"
boolean focusrectangle = false
end type

type dw_2 from datawindow within tabpage_1
integer x = 78
integer y = 64
integer width = 1381
integer height = 684
integer taborder = 40
string dataobject = "dw_paquetes_materias"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 3758
integer height = 976
long backcolor = 67108864
string text = "Reporte de Materias Propedéutico Inscritas"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_5 cb_5
cb_4 cb_4
dw_3 dw_3
end type

on tabpage_2.create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.dw_3=create dw_3
this.Control[]={this.cb_5,&
this.cb_4,&
this.dw_3}
end on

on tabpage_2.destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.dw_3)
end on

type cb_5 from commandbutton within tabpage_2
integer x = 1998
integer y = 28
integer width = 293
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;IF tab_1.tabpage_2.dw_3.RowCount ( ) > 0 THEN
	PrintSetup ( )
	tab_1.tabpage_2.dw_3.Print ( )
END IF
end event

type cb_4 from commandbutton within tabpage_2
integer x = 1385
integer y = 28
integer width = 498
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar a Excel"
end type

event clicked;IF tab_1.tabpage_2.dw_3.SaveAs ( "" , Excel! , TRUE ) <> 1 THEN
	tab_1.tabpage_2.dw_3.SaveAs ( "" , Clipboard! , TRUE )
	MessageBox("No se pudo guardar el archivo","La información se encuentra en el Clipboard")	
END IF
end event

type dw_3 from datawindow within tabpage_2
integer x = 73
integer y = 92
integer width = 3607
integer height = 828
integer taborder = 30
string title = "none"
string dataobject = "dw_aspiran_remediales_inscritas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event rowfocuschanged;SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
boolean visible = false
integer x = 18
integer y = 112
integer width = 3758
integer height = 976
long backcolor = 67108864
string text = "Materias con Horario repetido"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_3 cb_3
cb_2 cb_2
dw_4 dw_4
end type

on tabpage_3.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.dw_4=create dw_4
this.Control[]={this.cb_3,&
this.cb_2,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.dw_4)
end on

type cb_3 from commandbutton within tabpage_3
integer x = 1888
integer y = 32
integer width = 343
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;IF tab_1.tabpage_3.dw_4.RowCount ( ) > 0 THEN
	PrintSetup ( )
	tab_1.tabpage_3.dw_4.Print ( )
END IF
end event

type cb_2 from commandbutton within tabpage_3
integer x = 1307
integer y = 32
integer width = 498
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar a Excel"
end type

event clicked;IF tab_1.tabpage_3.dw_4.SaveAs ( "" , Excel! , TRUE ) <> 1 THEN
	tab_1.tabpage_3.dw_4.SaveAs ( "" , Clipboard! , TRUE )
	MessageBox("No se pudo guardar el archivo","La información se encuentra en el Clipboard")	
END IF
end event

type dw_4 from datawindow within tabpage_3
integer x = 119
integer y = 184
integer width = 3259
integer height = 760
integer taborder = 50
string title = "none"
string dataobject = "dw_detalle_materias_repetidas_enlace_sce"
boolean vscrollbar = true
boolean resizable = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;SelectRow ( 0, False )

SelectRow ( CurrentRow , True )
end event

type tabpage_4 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 112
integer width = 3758
integer height = 976
long backcolor = 67108864
string text = "Materias sin Grupo"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
cb_7 cb_7
cb_6 cb_6
dw_6 dw_6
end type

on tabpage_4.create
this.cb_7=create cb_7
this.cb_6=create cb_6
this.dw_6=create dw_6
this.Control[]={this.cb_7,&
this.cb_6,&
this.dw_6}
end on

on tabpage_4.destroy
destroy(this.cb_7)
destroy(this.cb_6)
destroy(this.dw_6)
end on

type cb_7 from commandbutton within tabpage_4
integer x = 1888
integer y = 32
integer width = 343
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Imprimir"
end type

event clicked;IF tab_1.tabpage_4.dw_6.RowCount ( ) > 0 THEN
	PrintSetup ( )
	tab_1.tabpage_4.dw_6.Print ( )
END IF
end event

type cb_6 from commandbutton within tabpage_4
integer x = 1307
integer y = 32
integer width = 498
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar a Excel"
end type

event clicked;IF tab_1.tabpage_4.dw_6.SaveAs ( "" , Excel! , TRUE ) <> 1 THEN
	tab_1.tabpage_4.dw_6.SaveAs ( "" , Clipboard! , TRUE )
	MessageBox("No se pudo guardar el archivo","La información se encuentra en el Clipboard")	
END IF
end event

type dw_6 from datawindow within tabpage_4
integer x = 119
integer y = 184
integer width = 2007
integer height = 704
integer taborder = 40
string title = "none"
string dataobject = "dw_detalle_paq_mat_sin_grupo_enlace_sce"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event rowfocuschanged;SelectRow ( 0, False )

SelectRow ( CurrentRow , True )
end event

type gb_3 from groupbox within w_enlace_mat_sce
integer x = 3163
integer width = 626
integer height = 212
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar por Aspirante"
borderstyle borderstyle = stylebox!
end type

