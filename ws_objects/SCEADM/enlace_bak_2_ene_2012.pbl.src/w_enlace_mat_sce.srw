$PBExportHeader$w_enlace_mat_sce.srw
forward
global type w_enlace_mat_sce from window
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
boolean controlmenu = true
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
Int				al_estado,al_lugar,al_nacion,al_civil,al_religion,al_bachi,al_trabajo,al_horas,al_transp
Long			pa_estado,al_plan,al_carr,al_paq,cont_2,al_mat
Long			cont_1, il_cuenta
Real			al_promedio
String			al_nombre,al_apaterno,al_amaterno,al_calle,al_colonia,al_cp,al_tele,al_sexo
String			pa_nombre,pa_apaterno,pa_amaterno,pa_calle,pa_colonia,pa_cp,pa_tele,al_grupo
DateTime	al_fecha

transaction itr_web						/* OSS 24-Ago-2011*/
Int			ii_CuentaRemedialEsp = 0	/* OSS 24-Ago-2011*/
Int			ii_CuentaRemedialMat = 0	/* OSS 24-Ago-2011*/
Long		il_folio_ini						/* OSS 24-Ago-2011*/
lONG		il_folio_fin						/* OSS 24-Ago-2011*/
end variables

forward prototypes
public function integer wf_enlace_sce (long al_cuenta, integer ai_periodo, integer ai_anio)
public function integer wf_inserta_remediales (integer ai_renglon)
public function integer wf_verifica_horarios_repetidos_x_paquete ()
public function integer wf_paquetes_materias_sin_grupo ()
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

event enlace();Long		ll_rows, ll_periodo_materias, ll_anio_materias, ll_num_aspirantes
String		ls_periodo_materias, ls_anio_materias
Integer	li_actualiza_insc_sem_ant
Int			li_Respuesta	/* OSS. 15-Sep-2011 */

SetPointer(HourGlass!)
st_ini.text = string(now())
ll_num_aspirantes= dw_1.rowcount()

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
	Return;
END IF
IF NOT ISNUMBER(ls_anio_materias)THEN
	MessageBox("Año de las materias invalido","Favor de escribir un Año destino valido",StopSign!)	
	Return;
END IF

ll_periodo_materias = long(ls_periodo_materias)
ll_anio_materias = long(ls_anio_materias)

/* OSS. 15-Sep-2011 */
IF gi_periodo <> ll_periodo_materias THEN
	MessageBox ( "Aviso:" , "El periodo de materias por paquete es distinto al periodo de aspirantes, por favor verifique..."  )
	Return
END IF

IF gi_anio <> ll_anio_materias THEN
	MessageBox ( "Aviso:" , "El Año de materias por paquete es distinto al año de aspirantes, por favor verifique..."  )
	Return
END IF

tab_1.tabpage_4.Visible = False
tab_1.tabpage_3.Visible = False

// Validar si exísten materias de un paquete con horario repetido ...
IF wf_verifica_horarios_repetidos_x_paquete ( ) = -1 THEN
	Return
END IF

IF tab_1.tabpage_3.dw_4.RowCount ( ) > 0 THEN
	
	MessageBox ( "Aviso:" , "Se encotró información de al menos un paquete con materias diferentes con mismo día y horario.~n~r~n~rPara poder continuar, es necesario corregir los horarios que a continuación se muestran." )
	tab_1.tabpage_3.Visible = True
	tab_1.SelectTab ( 3 )
	Return
	
END IF

// Validar si exísten materias de un paquete que no tengan grupo definido ...
IF wf_paquetes_materias_sin_grupo ( ) = -1 THEN
	
END IF

IF tab_1.tabpage_4.dw_6.RowCount ( ) > 0 THEN
	
	MessageBox ( "Aviso:" , "Se encotró información de al menos una materia que no tiene grupo definido.~n~r~n~rPara poder continuar, es necesario corregir los grupos de las materias que a continuación se muestran." )
	tab_1.tabpage_4.Visible = True
	tab_1.SelectTab ( 4 )
	Return
	
END IF

// Verificar si estan definidas las materias remediales para el año y periodo seleccionados ...
ii_CuentaRemedialEsp = 0
ii_CuentaRemedialMat = 0

// Verificar si esta definida remedial español ...
Select		Count ( * )
Into		:ii_CuentaRemedialEsp
From		horario
Where	cve_mat = 90203 AND
			anio = :gi_anio and
			periodo = :gi_periodo
USING	gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el horario de la materia Remedial Español.~n~r~n~r" + gtr_sce.SQLErrText  )
	Return;
END IF

IF ISNull ( ii_CuentaRemedialEsp ) THEN ii_CuentaRemedialEsp = 0

// Verificar si esta definida remedial Matemáticas ...
Select		Count ( * )
Into		:ii_CuentaRemedialMat
From		horario
Where	cve_mat = 90204 AND
			anio = :gi_anio and
			periodo = :gi_periodo
USING	gtr_sce;

IF gtr_sce.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar el horario de la materia Remedial Matemáticas.~n~r~n~r" + gtr_sce.SQLErrText  )
	Return;
END IF

IF ISNull ( ii_CuentaRemedialMat ) THEN ii_CuentaRemedialMat = 0

IF ii_CuentaRemedialEsp = 0 THEN
	li_Respuesta = MessageBox ( "Aviso:" , "No está definida la materia Remedial Español para el año y periodo a enlazar. ~n~n~n~r Si continúa no se inscribirán las materias remediales de Español ~n~r~n~r ¿Desa Continuar?" , Question! , YesNo! )
	
	IF li_Respuesta = 2 THEN
		Return
	END IF
END IF

IF ii_CuentaRemedialMat = 0 THEN
	li_Respuesta = MessageBox ( "Aviso:" , "No está definida la materia Remedial Matemáticas para el año y periodo a enlazar. ~n~n~n~r Si continúa no se inscribirán las materias remediales de Español ~n~r~n~r ¿Desa Continuar?" , Question! , YesNo! )
	
	IF li_Respuesta = 2 THEN
		Return
	END IF
END IF

IF ii_CuentaRemedialMat > 0 THEN
	dw_horarios_remedial_mat.Reset ( )
	dw_horarios_remedial_mat.SetTransObject ( gtr_sce )
	dw_horarios_remedial_mat.Retrieve ( 90204 , gi_anio , gi_periodo )
END IF

IF ii_CuentaRemedialEsp > 0 THEN
	dw_horarios_remedial_esp.Reset ( )
	dw_horarios_remedial_esp.SetTransObject ( gtr_sce )
	dw_horarios_remedial_esp.Retrieve ( 90203 , gi_anio , gi_periodo )
END IF

// Si las materias remediales ESPAÑOL y MATEMÁTICAS no estan definidas para el año y periodo,
// preguntar si se desea continuar sin realizar el proceso de inscribir las materias remediales ...
IF ii_CuentaRemedialMat = 0 AND ii_CuentaRemedialEsp = 0 THEN
	li_Respuesta = MessageBox ( "Aviso:" , "No están definidas las materias Remediales Matemáticas y Español para el año y periodo a enlazar. ~n~n~n~r Si continúa no se inscribirán las materias remediales de Español y Matemáticas~n~r~n~r ¿Desa Continuar?" , Question! , YesNo! )
	
	IF li_Respuesta = 2 THEN
		Return
	END IF
END IF
/* OSS. 15-Sep-2011 */

For cont_1=1 to dw_1.rowcount()

	il_cuenta=dw_1.object.general_cuenta[cont_1]
	st_1.text="Leyendo datos de "+string ( il_cuenta )
	event lee_dw_1()
		
	ll_rows= tab_1.tabpage_1.dw_2.retrieve(al_paq, gi_periodo, gi_anio)
	
	IF ll_rows = 0 THEN
		MessageBox ( "Error:" , "No están definidas las materias para el paquete: " + String ( al_paq ) )
	END IF
	
	For cont_2=1 to tab_1.tabpage_1.dw_2.rowcount()
		st_1.text="Leyendo datos de "+string ( il_cuenta ) +" , "+string(cont_2)+" materia."
		event lee_dw_2()

		event ins_mat_inscritas( gi_periodo , gi_anio )
	Next	
	li_actualiza_insc_sem_ant = f_actualiza_insc_sem_ant ( il_cuenta )
	if li_actualiza_insc_sem_ant= -1 then
		MessageBox("Error de Inserción","Error al actualizar la bandera de inscrito el semestre anterior",StopSign!)
	end if

	IF ll_rows > 0 THEN
		IF ii_CuentaRemedialMat > 0 AND ii_CuentaRemedialEsp > 0 THEN
			
			wf_inserta_remediales ( cont_1 );
			
		END IF
	END IF
	
	
//	commit using gtr_sce;	
Next

IF ii_CuentaRemedialMat > 0 AND ii_CuentaRemedialEsp > 0 THEN

	tab_1.tabpage_2.dw_3.SetTransObject ( gtr_sadm )
	tab_1.tabpage_2.dw_3.Retrieve ( gi_version , gi_periodo , gi_anio )
	tab_1.SelectedTab = 2
	
END IF

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

event lee_dw_1;//		al_promedio=dw_1.object.aspiran_promedio[cont_1]
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
		al_paq=dw_1.object.num_paq[cont_1]
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

al_mat = tab_1.tabpage_1.dw_2.object.clv_mat[cont_2]
al_grupo = tab_1.tabpage_1.dw_2.object.grupo[cont_2]
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

event ins_mat_inscritas(integer al_periodo, integer al_anio);/*
	Oscar Sánchez.
	Agosto de 2011.
	Descripción:	Se modifica para replicar la información a SQLServer.
					El objeto de transacción gtr_sce apunta a controlescolar_db en Sybase
					El objeto de transacción itr_web apunta a controlescolar_db en SQLServer
*/

long temp,cupo,inscritos
int tipo, clave_asimilada
string grupo_asimilado,ls_error
Boolean	lb_hacer_commit_SQLServer	= False		/* OSS, 31-Ago-2011 */
Boolean	lb_hacer_commit_Sybase		= False		/* OSS, 31-Ago-2011 */
Boolean	lb_trabajar_en_SQLServer		= True		/* OSS, 31-Ago-2011 */
Boolean	lb_trabajar_en_Sybase			= True		/* OSS, 31-Ago-2011 */

SELECT dbo.mat_inscritas.cuenta
INTO :temp
FROM dbo.mat_inscritas
WHERE ( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
	( dbo.mat_inscritas.cve_mat = :al_mat ) AND
	( dbo.mat_inscritas.gpo = :al_grupo ) AND
	( dbo.mat_inscritas.periodo = :al_periodo ) AND
	( dbo.mat_inscritas.anio = :al_anio )
USING gtr_sce;

/*Si existe la cuenta quiere decir que la materia ya se inscribio*/
if temp = il_cuenta then
	lb_trabajar_en_Sybase = False
end if

/* OSS, 31-Ago-2011 */
SELECT dbo.mat_inscritas.cuenta
INTO :temp
FROM dbo.mat_inscritas
WHERE ( dbo.mat_inscritas.cuenta = :il_cuenta ) AND
	( dbo.mat_inscritas.cve_mat = :al_mat ) AND
	( dbo.mat_inscritas.gpo = :al_grupo ) AND
	( dbo.mat_inscritas.periodo = :al_periodo ) AND
	( dbo.mat_inscritas.anio = :al_anio )
USING itr_web;

/*Si existe la cuenta quiere decir que la materia ya se inscribio*/
if temp = il_cuenta then
	lb_trabajar_en_SQLServer = False
end if

IF lb_trabajar_en_SQLServer = False AND lb_trabajar_en_Sybase = False THEN
	Return
END IF
/* OSS, 31-Ago-2011 */

/* Comentado debido a que las validaciones posteriores se hacen via trigger*/

//SELECT grupos.tipo,grupos.cupo,grupos.inscritos
//INTO :tipo,:cupo,:inscritos
//FROM grupos  
//WHERE ( grupos.cve_mat = :al_mat ) AND  
//	( grupos.gpo = :al_grupo ) AND  
//	( grupos.periodo = :gi_periodo ) AND  
//	( grupos.anio = :gi_anio )
//USING gtr_sce;
//
//if inscritos>=cupo then
//	/*Mensaje o archivo*/
//	return
//end if
//	
//if tipo=2 then
//	
//  SELECT grupos.cve_asimilada,   
//         grupos.gpo_asimilado  
//    INTO :clave_asimilada,   
//         :grupo_asimilado
//    FROM grupos  
//    WHERE ( grupos.cve_mat = :al_mat ) AND  
//         ( grupos.gpo = :al_grupo ) AND  
//         ( grupos.periodo = :gi_periodo ) AND  
//         ( grupos.anio = :gi_anio )
//	USING gtr_sce;
//	
//	UPDATE grupos  
//	SET inscritos = inscritos + 1 
//	WHERE ((( grupos.cve_mat = :clave_asimilada) AND
//		( grupos.gpo = :grupo_asimilado)) OR
//		(( grupos.cve_asimilada = :clave_asimilada) AND
//		( grupos.gpo_asimilado =:grupo_asimilado))) AND
//		( grupos.periodo = :gi_periodo) AND
//		( grupos.anio = :gi_anio)
//	USING gtr_sce;
//
//	if gtr_sce.SQLErrText<>"" then
//		ls_error=gtr_sce.SQLErrText
//		rollback using gtr_sce;
//		MessageBox("Database Error",ls_error, Exclamation!)
//		return
//	end if
//
//else
//	
//	UPDATE grupos  
//	SET inscritos = inscritos + 1 
//	WHERE ((( grupos.cve_mat = :al_mat ) AND  
//		( grupos.gpo = :al_grupo )) OR
//		(( grupos.cve_asimilada = :al_mat) AND
//		( grupos.gpo_asimilado = :al_grupo))) AND
//		( grupos.periodo = :gi_periodo) AND
//		( grupos.anio = :gi_anio)
//	USING gtr_sce;
//
//	if gtr_sce.SQLErrText<>"" then
//		ls_error=gtr_sce.SQLErrText
//		rollback using gtr_sce;
//		MessageBox("Database Error",ls_error, Exclamation!)
//		return
//	end if
//
//end if
 
IF lb_trabajar_en_Sybase = True THEN	/* OSS, 31-Ago-2011 */
	INSERT INTO mat_inscritas  
		( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
	VALUES ( :il_cuenta, :al_mat, :al_grupo, :al_periodo, :al_anio, 0, 0, 'I' )  
	USING gtr_sce;
	if gtr_sce.SQLErrText<>"" then
		ls_error=gtr_sce.SQLErrText
		rollback using gtr_sce;
		MessageBox("Sybase Database Error",ls_error, Exclamation!)
		return
	else
		lb_hacer_commit_Sybase = True
	end if
END IF	/* OSS, 31-Ago-2011 */

/* OSS, 31-Ago-2011 */
IF lb_trabajar_en_SQLServer = True THEN
	INSERT INTO mat_inscritas  
		( cuenta, cve_mat, gpo, periodo, anio, cve_condicion, acreditacion, inscripcion )
	VALUES ( :il_cuenta, :al_mat, :al_grupo, :al_periodo, :al_anio, 0, 0, 'I' )  
	USING itr_web;
	if itr_web.SQLErrText<>"" then
		ls_error = itr_web.SQLErrText
		rollback using itr_web;

		IF lb_hacer_commit_Sybase = True THEN
			rollback using gtr_sce;
		END IF
		
		MessageBox ( "Error en la base de datos web:" ,ls_error, Exclamation! )
		return
	else
		lb_hacer_commit_SQLServer = True
	end if
END IF

IF lb_hacer_commit_SQLServer = True THEN
	Commit Using itr_web;
END IF

IF lb_hacer_commit_Sybase = True THEN
	Commit Using gtr_sce;
END IF
/* OSS, 31-Ago-2011 */
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

public function integer wf_enlace_sce (long al_cuenta, integer ai_periodo, integer ai_anio);string ls_mensaje
integer li_codigo_error


DECLARE spenlacesce procedure for sp_enlace_sce
@cuenta = :al_cuenta, 
@periodo = :ai_periodo, 
@anio = :ai_anio
using gtr_sadm;

EXECUTE spenlacesce;

li_codigo_error= gtr_sadm.SQLCode

ls_mensaje= gtr_sadm.SQLErrText

if li_codigo_error = -1 then
	MessageBox("Error al ejecutar sp_enlace_sce", ls_mensaje)
	return -1
else
	COMMIT USING gtr_sadm;
	return 0
end if




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
			// Verificar si ya existe la materia remedial Matematicasen mat_inscritas ...
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
								cve_mat_rem		= 90204					AND
//								gpo_rem				=:ls_gpo_rem			AND
								cve_dia_rem		= :li_cve_dia_rem		AND
								hora_inicio_rem	= :li_hora_inicio_rem	AND
								hora_fin_rem		= :li_hora_final_rem
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
								cve_mat_rem		= 90203					AND
//								gpo_rem				=:ls_gpo_rem			AND
								cve_dia_rem		= :li_cve_dia_rem		AND
								hora_inicio_rem	= :li_hora_inicio_rem	AND
								hora_fin_rem		= :li_hora_final_rem
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

public function integer wf_verifica_horarios_repetidos_x_paquete ();Long		ll_num_paq
Int			li_cuenta
Int			li_cve_dia
Int			li_hora_inicio
Int			li_hora_final
Long		ll_cve_mat
String		ls_materia
String		ls_dia
String		ls_gpo
String		ls_cve_salon

tab_1.tabpage_3.dw_4.Reset ( )

DECLARE cur_paquetes CURSOR FOR
 SELECT	distinct dbo.aspiran.num_paq
    FROM	dbo.aspiran,
			dbo.general,
			dbo.paquetes_materias
 WHERE	( dbo.aspiran.folio = dbo.general.folio ) and  
			( dbo.general.clv_ver = dbo.aspiran.clv_ver ) and  
			( dbo.aspiran.clv_per = dbo.general.clv_per ) and  
			( dbo.general.anio = dbo.aspiran.anio ) and  
			( (dbo.aspiran.clv_ver = :gi_version ) OR
			( :gi_version = 99) ) AND  
			( dbo.aspiran.ing_per = :gi_periodo ) AND  
			( dbo.aspiran.ing_anio = :gi_anio ) AND  
			(dbo.aspiran.folio between :il_folio_ini and :il_folio_fin ) AND  
			dbo.general.cuenta <> 0 AND  
			dbo.general.cuenta in (select cuenta from controlescolar_bd.dbo.alumnos) AND  
			dbo.aspiran.pago_insc = 1 AND
			dbo.aspiran.status IN (1,2,4) and
			dbo.aspiran.num_paq = dbo.paquetes_materias.num_paq and
			dbo.aspiran.anio = dbo.paquetes_materias.anio and
			dbo.aspiran.clv_per = dbo.paquetes_materias.clv_per
USING gtr_sadm;

Open cur_paquetes;

IF gtr_sadm.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar las materias por paquete .~n~r~n~r" + gtr_sadm.SQLErrText )
	Close cur_paquetes;
	Return -1
END IF

Fetch cur_paquetes into :ll_num_paq;

DO WHILE gtr_sadm.sqlcode <> 100

	li_cuenta = 0

	// Verificar si hay materias con dia y horario iguales ...
	DECLARE cur_materias_repetidas CURSOR FOR
	Select		count ( h.cve_dia )	,
				h.cve_dia,
				h.hora_inicio,
				h.hora_final
	From		paquetes_materias pm,
				horario h
	Where	h.cve_mat		= pm.clv_mat and
				h.gpo				= pm.grupo and
				h.periodo		= pm.clv_per and
				h.anio				= pm.anio and
				pm.num_paq	= :ll_num_paq and
				pm.clv_per		= :gi_periodo and
				pm.anio			= :gi_anio
	group by h.cve_dia, h.hora_inicio, h.hora_final
	having count ( h.cve_dia ) > 1 
	Using gtr_sce;
	
	Open cur_materias_repetidas;
	
	IF gtr_sce.SQLCode = -1 THEN
		MessageBox ( "Error:" , "De base de datos al consultar Si hay horarios repetidos entre ~n~rlas materias remediales y las materias del paquete.~n~r~n~r" + gtr_sce.SQLErrText )
		Close cur_paquetes;
		Close cur_materias_repetidas;
		Return -1
	END IF
	
	Fetch cur_materias_repetidas Into :li_cuenta, :li_cve_dia, :li_hora_inicio, :li_hora_final;
	
	DO WHILE gtr_sce.sqlcode <> 100
		IF li_cuenta > 1 THEN
			// Significa que hay mas de una materia del paquete con dia y horario iguales ..
			// Obtener las materias del paquete con dia y horario iguales ...
			DECLARE cur_det_materias_repetidas CURSOR FOR
			Select		h.cve_mat,
						( select materia from materias where materias.cve_mat = h.cve_mat ),
						( select dia from dias where dias.cve_dia = h.cve_dia ),
						h.hora_inicio,
						h.hora_final,
						h.gpo,
						h.cve_salon
			From		paquetes_materias pm,
						horario h
			Where	h.cve_mat		= pm.clv_mat and
						h.gpo				= pm.grupo and
						h.periodo		= pm.clv_per and
						h.anio				= pm.anio and
						pm.num_paq	= :ll_num_paq and
						pm.clv_per		= :gi_periodo and
						pm.anio			= :gi_anio and
						h.cve_dia		= :li_cve_dia and
						h.hora_inicio	= :li_hora_inicio and
						h.hora_final		= :li_hora_final
			Using gtr_sce;
			
			Open cur_det_materias_repetidas;
			
			IF gtr_sce.SQLCode = -1 THEN
				MessageBox ( "Error:" , "De base de datos al consultar los horarios de  las materias del paquete.~n~r~n~r" + gtr_sce.SQLErrText )
				Close cur_paquetes;
				Close cur_materias_repetidas;
				Close cur_det_materias_repetidas;
				Return -1
			END IF
			
			Fetch cur_det_materias_repetidas Into :ll_cve_mat, :ls_materia, :ls_dia, :li_hora_inicio, :li_hora_final, :ls_gpo, :ls_cve_salon;
			
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
				
				Fetch cur_det_materias_repetidas Into :ll_cve_mat, :ls_materia, :ls_dia, :li_hora_inicio, :li_hora_final, :ls_gpo, :ls_cve_salon;
			LOOP
			
			Close cur_det_materias_repetidas;

		END IF
		
		Fetch cur_materias_repetidas Into :li_cuenta, :li_cve_dia, :li_hora_inicio, :li_hora_final;
	LOOP
	
	Close cur_materias_repetidas;

	
	Fetch cur_paquetes Into :ll_num_paq;
LOOP

Close cur_paquetes;

Return 1
end function

public function integer wf_paquetes_materias_sin_grupo ();Long		ll_num_paq
Long		ll_cve_mat
String		ls_materia
String		ls_grupo

tab_1.tabpage_4.dw_6.Reset ( )


DECLARE cur_paquetes CURSOR FOR
 SELECT	distinct dbo.aspiran.num_paq,
			dbo.paquetes_materias.clv_mat,
			(Select materia from v_materias where v_materias.cve_mat = dbo.paquetes_materias.clv_mat ) as materia,
			dbo.paquetes_materias.grupo
    FROM	dbo.aspiran,
			dbo.general,
			dbo.paquetes_materias
 WHERE	( dbo.aspiran.folio = dbo.general.folio ) and  
			( dbo.general.clv_ver = dbo.aspiran.clv_ver ) and  
			( dbo.aspiran.clv_per = dbo.general.clv_per ) and  
			( dbo.general.anio = dbo.aspiran.anio ) and  
			( (dbo.aspiran.clv_ver = :gi_version ) OR
			( :gi_version = 99) ) AND  
			( dbo.aspiran.ing_per = :gi_periodo ) AND  
			( dbo.aspiran.ing_anio = :gi_anio ) AND  
			(dbo.aspiran.folio between :il_folio_ini and :il_folio_fin ) AND  
			dbo.general.cuenta <> 0 AND  
			dbo.general.cuenta in (select cuenta from controlescolar_bd.dbo.alumnos) AND  
			dbo.aspiran.pago_insc = 1 AND
			dbo.aspiran.status IN (1,2,4) and
			dbo.aspiran.num_paq = dbo.paquetes_materias.num_paq and
			dbo.aspiran.anio = dbo.paquetes_materias.anio and
			dbo.aspiran.clv_per = dbo.paquetes_materias.clv_per and
			dbo.paquetes_materias.grupo = null
USING gtr_sadm;

Open cur_paquetes;

IF gtr_sadm.SQLCode = -1 THEN
	MessageBox ( "Error:" , "De base de datos al consultar las materias de un paquete que no tengan grupos.~n~r~n~r" + gtr_sadm.SQLErrText )
	Close cur_paquetes;
	Return -1
END IF

Fetch cur_paquetes into :ll_num_paq, :ll_cve_mat, :ls_materia, :ls_grupo;

DO WHILE gtr_sadm.sqlcode <> 100

	// Presentar el detalle de la materia que se repite ...
	tab_1.tabpage_4.dw_6.InsertRow ( 0 )
	tab_1.tabpage_4.dw_6.Object.num_paq		[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ll_num_paq
	tab_1.tabpage_4.dw_6.Object.cve_mat		[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ll_cve_mat
	tab_1.tabpage_4.dw_6.Object.materia		[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ls_materia
	tab_1.tabpage_4.dw_6.Object.gpo				[ tab_1.tabpage_4.dw_6.RowCount ( ) ] = ls_grupo
				
	
	Fetch cur_paquetes Into :ll_num_paq, :ll_cve_mat, :ls_materia, :ls_grupo;
LOOP

Close cur_paquetes;

Return 1
end function

on w_enlace_mat_sce.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
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
this.Control[]={this.dw_5,&
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
integer y = 376
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
integer y = 288
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
integer y = 376
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
integer y = 288
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
integer y = 588
integer width = 3657
integer height = 604
integer taborder = 0
string dataobject = "dw_aspi-alum_sce_ing_con_paq"
boolean hscrollbar = true
boolean hsplitscroll = true
borderstyle borderstyle = stylelowered!
end type

event carga;integer li_confirma, li_obten_server_bd
string ls_min, ls_max


ls_min = em_min.text
ls_max = em_max.text
il_folio_ini = long(ls_min)
il_folio_fin = long(ls_max)

li_obten_server_bd = f_obten_server_bd(gtr_sce,'controlescolar_bd',1)

if li_obten_server_bd<> 0 then
	MessageBox("Error de Enlace",'No es posible ejecutar el enlace de materias durante los Ajustes de Inscripción', StopSign!)
	return -1
end if	
	
li_confirma= MessageBox("Confirmacion","¿Desea realizar el enlace de materias? ["+ls_min+"] ["+ls_max+"]",Question!, YesNo!)

if li_confirma= 1 then
	st_1.text="Leyendo datos de los aspirantes inscritos"
	return retrieve(gi_version,gi_periodo,gi_anio,il_folio_ini,il_folio_fin)
end if

return 0
end event

event retrieveend;call super::retrieveend;parent.event enlace()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
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
integer y = 492
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
integer y = 212
integer width = 3799
integer height = 276
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
integer y = 320
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
string text = "Reporte de materias Remediales Inscritas"
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

