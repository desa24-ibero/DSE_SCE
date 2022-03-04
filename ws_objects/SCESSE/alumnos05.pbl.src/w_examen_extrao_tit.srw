$PBExportHeader$w_examen_extrao_tit.srw
forward
global type w_examen_extrao_tit from window
end type
type dw_examen_extrao_titulo_comp from datawindow within w_examen_extrao_tit
end type
type st_plan from statictext within w_examen_extrao_tit
end type
type st_carrera from statictext within w_examen_extrao_tit
end type
type rb_titulo from radiobutton within w_examen_extrao_tit
end type
type rb_extraordinario from radiobutton within w_examen_extrao_tit
end type
type uo_anio_periodo from uo_per_ani within w_examen_extrao_tit
end type
type st_13 from statictext within w_examen_extrao_tit
end type
type st_12 from statictext within w_examen_extrao_tit
end type
type st_11 from statictext within w_examen_extrao_tit
end type
type st_10 from statictext within w_examen_extrao_tit
end type
type st_9 from statictext within w_examen_extrao_tit
end type
type st_8 from statictext within w_examen_extrao_tit
end type
type st_7 from statictext within w_examen_extrao_tit
end type
type st_6 from statictext within w_examen_extrao_tit
end type
type st_5 from statictext within w_examen_extrao_tit
end type
type st_4 from statictext within w_examen_extrao_tit
end type
type st_3 from statictext within w_examen_extrao_tit
end type
type st_2 from statictext within w_examen_extrao_tit
end type
type st_15 from statictext within w_examen_extrao_tit
end type
type st_18 from statictext within w_examen_extrao_tit
end type
type st_14 from statictext within w_examen_extrao_tit
end type
type st_1 from statictext within w_examen_extrao_tit
end type
type dw_revision_est_total from datawindow within w_examen_extrao_tit
end type
type dw_examen_extrao_titulo from datawindow within w_examen_extrao_tit
end type
type uo_1 from uo_nombre_alumno within w_examen_extrao_tit
end type
type dw_revision_est_resumen from datawindow within w_examen_extrao_tit
end type
end forward

global type w_examen_extrao_tit from window
integer x = 832
integer y = 364
integer width = 3461
integer height = 2032
boolean titlebar = true
string title = "Examenes Extraordinarios y a Titulo"
string menuname = "m_examen_extrao_tit"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
event inicia_proceso ( )
dw_examen_extrao_titulo_comp dw_examen_extrao_titulo_comp
st_plan st_plan
st_carrera st_carrera
rb_titulo rb_titulo
rb_extraordinario rb_extraordinario
uo_anio_periodo uo_anio_periodo
st_13 st_13
st_12 st_12
st_11 st_11
st_10 st_10
st_9 st_9
st_8 st_8
st_7 st_7
st_6 st_6
st_5 st_5
st_4 st_4
st_3 st_3
st_2 st_2
st_15 st_15
st_18 st_18
st_14 st_14
st_1 st_1
dw_revision_est_total dw_revision_est_total
dw_examen_extrao_titulo dw_examen_extrao_titulo
uo_1 uo_1
dw_revision_est_resumen dw_revision_est_resumen
end type
global w_examen_extrao_tit w_examen_extrao_tit

type prototypes
SUBROUTINE Adeudos(long cuenta,ref long adeudo) RPCFUNC ALIAS FOR "cob_sp_adeudos"
end prototypes

type variables
int ii_tipo
long  il_cuenta
int ii_cve_carrera
int ii_cve_plan

int ii_BanderasAlumno[22]
CONSTANT int b_isa = 1, b_cfp = 2, b_b3r = 3, b_b4i = 4
CONSTANT int b_bdi = 5, b_bdo = 6, b_ih = 7, b_ec = 8
CONSTANT int b_cfpi = 9, b_cfss = 10, b_pi = 11
CONSTANT int b_tf1 = 12, b_tf2 = 13, b_t1 = 14, b_t2 = 15
CONSTANT int b_t3 = 16, b_t4 = 17, b_ci = 18, b_cfb = 19
CONSTANT int b_cfd = 20, b_af = 21, b_v = 22


Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_ets"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

end variables

forward prototypes
public function integer estainscrito (long a_cuenta, integer a_periodo, integer a_anio)
public function integer puntajemayor (long a_cuenta, integer a_cve_carrera, integer a_cve_plan, integer a_unidades)
public function integer totalinscritas (long a_cuenta, integer a_anio, integer a_periodo, integer a_tipo)
public function integer llenabanderas (long a_cuenta, ref integer a_banderas[22])
public function integer adeudosfinanzas (long a_cuenta, ref long a_adeudos)
public function integer cursoprerrequisitos (long a_cuenta, long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer esssot (long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer estacursada (long a_cuenta, long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer estainscritacve_mat (long a_cuenta, long a_cve_mat, integer a_anio, integer a_periodo)
public function integer integracion (long a_cuenta, long a_cve_mat, integer a_puede_integracion, integer a_tema1, integer a_tema2, integer a_tema3, integer a_tema4, integer a_anio, integer a_periodo)
public function integer escursativa (long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer existemateria (long a_cve_mat, ref string a_materia, ref decimal a_creditos, ref integer a_horas)
end prototypes

event inicia_proceso();int li_res, li_baja_laboratorio, li_baja_disciplina, li_baja_3_reprob, li_baja_4_insc
il_cuenta=Message.LongParm
DataStore ds_academicos
ds_academicos = CREATE DataStore
ds_academicos.DataObject = "d_carreraalumno"
ds_academicos.SetTransObject(gtr_sce)
ii_cve_carrera = 0
ii_cve_plan = 0
st_carrera.text = ""
st_plan.text = ""
if (ds_academicos.Retrieve(il_cuenta)>0) then
	li_res = llenabanderas(il_cuenta,ii_banderasalumno)
	if li_res = 1 then
		dw_revision_est_resumen.reset()
		dw_revision_est_total.reset()
		st_carrera.text = ds_academicos.GetItemString(1,"carreras_carrera")
		st_plan.text = ds_academicos.GetItemString(1,"nombre_plan_nombre_plan")
		ii_cve_carrera = ds_academicos.GetItemNumber(1,"academicos_cve_carrera")
		ii_cve_plan = ds_academicos.GetItemNumber(1,"academicos_cve_plan")
		hist_alumno_areas(il_cuenta,ii_cve_carrera,ii_cve_plan,&
		ds_academicos.GetItemNumber(1,"academicos_cve_subsistema"),dw_revision_est_total,&
		dw_revision_est_resumen,ds_academicos.GetItemString(1,"academicos_nivel"))
		li_res = estainscrito(il_cuenta,gi_periodo,gi_anio)
		if (ii_tipo = 2 AND li_res = 0) then
			li_res = MessageBox("Importante", "Para un examen extraoridinario es necesario estar inscrito en este periodo escolar, ¿es la última materia del alumno?",Question!, YesNo!,2)
			if li_res = 2 then li_res = 0
		end if
		li_baja_laboratorio = f_obten_baja_laboratorio(il_cuenta)
		li_baja_disciplina = f_obten_baja_disciplina(il_cuenta)
		li_baja_3_reprob = f_obten_baja_3_reprob(il_cuenta)
		li_baja_4_insc = f_obten_baja_4_insc(il_cuenta)
		if li_baja_laboratorio = 1 then
			MessageBox("Adeudo de Laboratorio","El alumno tiene adeudos de material de laboratorio",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		elseif li_baja_laboratorio = -1 then
			MessageBox("Error en Laboratorio","No es posible consultar la baja por laboratorio",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		end if
		if li_baja_disciplina = 1 then
			MessageBox("Baja por Disciplina","El alumno esta dado de baja por disciplina",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		elseif li_baja_disciplina = -1 then
			MessageBox("Error en  Disciplina","No es posible consultar la baja por disciplina",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		end if
		if li_baja_3_reprob = 1 then
			MessageBox("Baja por 3 Reprobadas","El alumno esta dado de baja por 3 Reprobadas",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		elseif li_baja_3_reprob = -1 then
			MessageBox("Error en 3 Reprobadas","No es posible consultar la baja por 3 Reprobadas",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		end if
		if li_baja_4_insc = 1 then
			MessageBox("Baja por 4 Inscripciones","El alumno esta dado de baja por 4 Inscripciones",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		elseif li_baja_4_insc = -1 then
			MessageBox("Error en 4 Inscripciones","No es posible consultar la baja por 4 Inscripciones",StopSign!)
			dw_examen_extrao_titulo.enabled = false			
		end if
			if ((ii_tipo = 2 AND li_res = 1) OR (ii_tipo = 6 AND li_res = 0)) then
				//ii_banderasalumno[b_bdo] = 0 //Quitar
				if (ii_banderasalumno[b_bdo] = 0) then
					desconecta_bd(gtr_scob);
					if (conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)=1) then
						li_res = tiene_adeudos(il_cuenta,gtr_scob)
						desconecta_bd(gtr_scob)
						if (li_res = 1) then
							MessageBox("Adeuda Finanzas","El alumno tiene adeudos en finanzas y por lo tanto no puede inscribirse",Exclamation!)
							dw_examen_extrao_titulo.enabled = false
						elseif (li_res = 0) then
							dw_examen_extrao_titulo.enabled = true
						elseif (li_res = -1) then
							Messagebox("Error de Comunicación","Error con la consulta de Base Datos Finanzas. Favor de intentar nuevamente",None!)
							dw_examen_extrao_titulo.enabled = false
						end if
					else
						Messagebox("Error de Comunicación","Error en la conexión de Base Datos Finanzas.",None!)
						dw_examen_extrao_titulo.enabled = false
					end if
				else
					MessageBox("Adeuda documentos","El alumno debe documentos y por lo tanto no puede inscribirse",Exclamation!)
					dw_examen_extrao_titulo.enabled = false
				end if
			elseif ii_tipo = 2 then
				MessageBox("El alumno no puede inscribirse","Para presentar un examen extraordinario es necesario que el alumno este inscrito en este periodo escolar",Exclamation!)
				dw_examen_extrao_titulo.enabled = false
			elseif ii_tipo = 6 then
				MessageBox("El alumno no puede inscribirse","Para presentar un examen a titulo de suficiencia es necesario que el alumno no este inscrito en este periodo escolar",Exclamation!)
				dw_examen_extrao_titulo.enabled = false
			end if
			dw_examen_extrao_titulo.retrieve(il_cuenta,gi_anio,gi_periodo,ii_tipo)
			dw_examen_extrao_titulo.SetFocus()
	else
		Messagebox("Error de Comunicación","Error con la consulta de Base Datos Bloqueos. Favor de intentar nuevamente",None!)
		dw_examen_extrao_titulo.enabled = false
	end if
end if
DESTROY (ds_academicos)
end event

public function integer estainscrito (long a_cuenta, integer a_periodo, integer a_anio);/*
 *		Nombre	estainscrito
 *		Recibe	a_cuenta,a_periodo,a_anio
 *		Regresa	1  si el alumno a_cuenta esta inscrito en el periodo a_anio a_periodo
 *					0  en caso contrario
 *					-1	error de comunicacion
 *					FMC19011999
 */
 
int li_res
DataStore lds_mat_inscritas
lds_mat_inscritas = Create DataStore
lds_mat_inscritas.DataObject = "d_mat_inscritas"
lds_mat_inscritas.SetTransObject(gtr_sce)
li_res = lds_mat_inscritas.Retrieve(a_cuenta,a_periodo,a_anio)
if li_res > 0 then
	Destroy lds_mat_inscritas
	return 1
elseif li_res = 0 then
	Destroy lds_mat_inscritas
	return 0
else
	Destroy lds_mat_inscritas
	return -1
end if

end function

public function integer puntajemayor (long a_cuenta, integer a_cve_carrera, integer a_cve_plan, integer a_unidades);/*
 *		Nombre	puntajemayor
 *		Recibe	a_cuenta,a_cve_carrera,a_cve_plan,a_unidades
 *		Regresa	1  si el alumnos a_cuenta supera en a_unidades el puntaje 
 *						requerido para la carrera a_cve_carrera a_cve_plan. 
 *						a_unidades esta dado en base 100 y el promedio se calcula en el momento
 *					0  en caso contrario
 *					-1	error de comunicacion
 *					FMC21011999
 */
 
DataStore lds_plan_estudios
int li_res, li_ret
decimal ldc_creditos
real lr_plan_estudios_puntaje_min, lr_promedio
decimal ld_promedio
lds_plan_estudios = CREATE DataStore
lds_plan_estudios.DataObject = "dw_planes_estudio" 
lds_plan_estudios.SetTransObject(gtr_sce)
li_res = lds_plan_estudios.Retrieve(a_cve_carrera,a_cve_plan)
if li_res = 1 then
	lr_plan_estudios_puntaje_min = lds_plan_estudios.GetItemNumber(1,"plan_estudios_puntaje_min")
	lr_plan_estudios_puntaje_min *= 10
	
//	f_obten_promedio_creditos_trans( a_cuenta, a_cve_carrera, a_cve_plan,ld_promedio, li_creditos, itr_seguridad)
	
  	DECLARE Emp_proc procedure for calcula_promedio
    	@cuenta   = :a_cuenta,
    	@cve_carr = :a_cve_carrera, 
    	@plan     = :a_cve_plan,
    	@promedio = :lr_promedio out, 
    	@creditos = :ldc_creditos out
  		USING itr_seguridad;
	EXECUTE Emp_proc ;
	if itr_seguridad.sqlcode = 0 then
		FETCH Emp_proc INTO :lr_promedio,:ldc_creditos;
		if itr_seguridad.sqlcode = 0 then
			lr_promedio *= 10
			if (lr_plan_estudios_puntaje_min + a_unidades <= lr_promedio) then
				li_ret  = 1
			else
				li_ret = 0
			end if
		else
			li_ret = -1
		end if
	else
		li_ret = -1
	end if
	CLOSE Emp_proc;
else
	li_ret = -1
end if
DESTROY lds_plan_estudios
return li_ret
end function

public function integer totalinscritas (long a_cuenta, integer a_anio, integer a_periodo, integer a_tipo);/*
 *		Nombre	totalinscritas
 *		Recibe	a_cuenta,a_anio,a_periodo
 *		Regresa	i	en donde i es un numero positivo indicando cuantas materias
 *						ha inscrito el alumno a_cuenta en extraordinario o titulo 
 *						para el periodo a_anio a_periodo
 *					-1	error de comunicacion
 *					FMC21011999
 */


DataStore lds_examen_extrao_titulo
int li_ret
lds_examen_extrao_titulo = Create DataStore
lds_examen_extrao_titulo.DataObject = "d_examen_extrao_titulo"
lds_examen_extrao_titulo.SetTransObject(gtr_sce)
li_ret = lds_examen_extrao_titulo.Retrieve(a_cuenta,a_anio,a_periodo,a_tipo)
Destroy lds_examen_extrao_titulo
return li_ret
end function

public function integer llenabanderas (long a_cuenta, ref integer a_banderas[22]);/*
 *		Nombre	llenaa_banderass
 *		Recibe	a_cuenta,a_a_banderass[22]
 *		Regresa	1  si los datos se llenaron exitosamente en a_banderas[22] 
 *						con los bloqueos del alumno a_cuenta
 *					-1	error de comunicacion
 *					FMC04031999
 */
int li_ret
DataStore lds_banderas
lds_banderas = Create DataStore
lds_banderas.DataObject = "d_banderas"
lds_banderas.SetTransObject(gtr_sce)
li_ret = lds_banderas.Retrieve(a_cuenta)
if li_ret = 1 then
	a_banderas[b_isa]=lds_banderas.GetItemNumber(1,"insc_sem_ant")
	a_banderas[b_cfp]=lds_banderas.GetItemNumber(1,"cve_flag_promedio")
	a_banderas[b_b3r]=lds_banderas.GetItemNumber(1,"baja_3_reprob")
	a_banderas[b_b4i]=lds_banderas.GetItemNumber(1,"baja_4_insc")
	a_banderas[b_bdi]=lds_banderas.GetItemNumber(1,"baja_disciplina")
	a_banderas[b_bdo]=lds_banderas.GetItemNumber(1,"baja_documentos")
	a_banderas[b_ih]=lds_banderas.GetItemNumber(1,"invasor_hora")
	a_banderas[b_ec]=lds_banderas.GetItemNumber(1,"exten_cred")
	a_banderas[b_cfss]=lds_banderas.GetItemNumber(1,"cve_flag_serv_social")
	a_banderas[b_pi]=lds_banderas.GetItemNumber(1,"puede_integracion")
	a_banderas[b_tf1]=lds_banderas.GetItemNumber(1,"tema_fundamental_1")
	a_banderas[b_tf2]=lds_banderas.GetItemNumber(1,"tema_fundamental_2")
	a_banderas[b_t1]=lds_banderas.GetItemNumber(1,"tema_1")
	a_banderas[b_t2]=lds_banderas.GetItemNumber(1,"tema_2")
	a_banderas[b_t3]=lds_banderas.GetItemNumber(1,"tema_3")
	a_banderas[b_t4]=lds_banderas.GetItemNumber(1,"tema_4")
	a_banderas[b_ci]=lds_banderas.GetItemNumber(1,"creditos_integ")
	a_banderas[b_cfb]=lds_banderas.GetItemNumber(1,"cve_flag_biblioteca")
	a_banderas[b_af]=lds_banderas.GetItemNumber(1,"adeuda_finanzas")
else 
	li_ret = -1
end if
Destroy lds_banderas
return li_ret

end function

public function integer adeudosfinanzas (long a_cuenta, ref long a_adeudos);/*
 *		Nombre	adeudosfinanzas
 *		Recibe	a_cuenta, a_adeudo
 *		Regresa	0	si el argumento a_adeudo se lleno 
 *						correctamente de acuerdo a la cantidad que
 *						el alumno con a_cuenta debe en cobranzas
 *					-1	error de comunicacion
 *					FMC05031999
 */
long ll_adeudos 
int li_ret
ll_adeudos = 0;


//SUBROUTINE Adeudos(long cuenta,ref long adeudo) RPCFUNC ALIAS FOR "cob_sp_adeudos"
//gtr_sce.Adeudos(a_cuenta,a_adeudos)
//SYBFINPRO.db_cobranzas.dbo.

DECLARE Adeudos PROCEDURE FOR SYBFINPRO.db_cobranzas.dbo.cob_sp_adeudos
	@cuenta = :a_cuenta,
	@adeudo = ll_adeudos out
USING gtr_sce;
EXECUTE Adeudos ;
if gtr_sce.sqlcode = 0 then
	FETCH Adeudos INTO :a_adeudos;
	if gtr_sce.sqlcode = 0 then
	else
		li_ret = -1
	end if
else
	li_ret = -1
end if
CLOSE Adeudos;
return li_ret
end function

public function integer cursoprerrequisitos (long a_cuenta, long a_cve_mat, integer a_cve_carrera, integer a_cve_plan);/*
 *		Nombre	cursoprerrequisitos
 *		Recibe	a_cuenta,a_cve_mat,a_cve_carrera,a_cve_plan
 *		Regresa	1  si el alumno a_cuenta ha cursado los prerrequisitos necesarios
 *						para cursar la materia a_cve_mat dada la carrera a_cve_carrera a_cve_plan
 *					0  en caso contrario
 *					-1	error de comunicacion
 *					FMC19011999
 */

long cvmat,respuesta
int cont, verifica,c,bandera=0,op3=0
char enlace,cumple='N'/*Variable que indica si se cumplieron los prerrequisitos*/
c= 0
DataStore lds_prerrequisito
lds_prerrequisito = Create DataStore
lds_prerrequisito.DataObject = "dw_prerrequisitos"
lds_prerrequisito.SetTransObject(gtr_sce)
respuesta = lds_prerrequisito.Retrieve(a_cve_mat,a_cve_carrera,a_cve_plan)
if respuesta = 0 then  //Consulta los prerrequisitos de la materia 
	Destroy lds_prerrequisito
	return 1
elseif respuesta > 0 then/*Si la materia tiene prerrequisitos se revisa si se cumplen*/
	for cont = 1 to lds_prerrequisito.rowcount() // Revisión de los prerrequisitos en la tabla historico
		cvmat	=	lds_prerrequisito.object.cve_prerreq[cont]
		enlace	=	lds_prerrequisito.object.enlace[cont]
		SELECT historico.cve_mat  
		INTO :cvmat  
		FROM historico  
		WHERE ( historico.cuenta = :a_cuenta ) AND  
				( historico.cve_mat = :cvmat ) AND 
				( historico.cve_carrera	=	:a_cve_carrera ) AND
				( historico.cve_plan	=	:a_cve_plan ) AND
				( historico.calificacion IN ("AC","6","7","8","9","10", "MB","B","S","E","RE")) using gtr_sce;
		if gtr_sce.sqlcode = 100 then//Este if se ejecuta si el alumno no ha llevado esa materia
			if cont > 1 then
				if (isnull(enlace) and lds_prerrequisito.object.enlace[cont - 1]	=	'Y')	 then
					op3 = 1
				else
					op3 = 0
				end if
			else
				op3 = 0
			end if
			if (	(	enlace = 'Y'	) or (isnull(enlace) and cont	=	1) or op3 = 1	)	then	
				//Si el	alumno no ha cursado la materia y es requerida se le niega la inscripción de la materia				
				Destroy lds_prerrequisito
				return 0	
			end if
		elseif gtr_sce.sqlcode = 0 then//Si el alumno ya curso la materia
			if enlace = 'O' then
				cumple	=	'S'
				cont++
			else 
				bandera = 1
			end if
		elseif gtr_sce.sqlcode < 0 then
			Destroy lds_prerrequisito
			return -1		//			error bd						
		end if
		commit using gtr_sce;
	next
else 			//if respuesta < 0 
	Destroy lds_prerrequisito
	return -1			//Error en la comunicación con la base de datos .
end if	
if (	(	bandera	=	0 and cumple	=	'S'	) or bandera	=	1	) then
	Destroy lds_prerrequisito
	return 1
else
	Destroy lds_prerrequisito
	return 0
end if


end function

public function integer esssot (long a_cve_mat, integer a_cve_carrera, integer a_cve_plan);/*
 *		Nombre	esssot
 *		Recibe	a_cve_mat,a_cve_carrera,a_cve_plan
 *		Regresa	1  si a_cve_mat es servicio social dada la carrera a_cve_carrera a_cve_plan
 *					2  si a_cve_mat es opcion terminal dada la carrera a_cve_carrera a_cve_plan
 *					0  ninguna de las anteriores
 *					-1	error de comunicacion
 *					FMC19011999
 */

DataStore lds_seminario_servicio
lds_seminario_servicio = Create DataStore
lds_seminario_servicio.DataObject = "d_seminario_servicio"
lds_seminario_servicio.SetTransObject(gtr_sce)
if (lds_seminario_servicio.Retrieve(a_cve_carrera,a_cve_plan)=1) then
	if (lds_seminario_servicio.GetItemNumber(1,"servicio_social")=a_cve_mat) then
		Destroy lds_seminario_servicio
		return 1	
	elseif (lds_seminario_servicio.GetItemNumber(1,"seminario_proyecto_terminal")=a_cve_mat) then
		Destroy lds_seminario_servicio
		return 2
	else
		Destroy lds_seminario_servicio
		return 0
	end if
else
	Destroy lds_seminario_servicio
	return -1
end if
return 0
end function

public function integer estacursada (long a_cuenta, long a_cve_mat, integer a_cve_carrera, integer a_cve_plan);/*
 *		Nombre	estacursada
 *		Recibe	a_cuenta,a_cve_mat,a_cve_carrera,a_cve_plan
 *		Regresa	1  si el alumno a_cuenta tiene aprobada la materia a_cve_mat
 *						dada la carrera a_cve_carrera a_cve_plan
 *					2  si el alumno a_cuenta tiene reprobada la materia a_cve_mat
 *						dada la carrera a_cve_carrera a_cve_plan
 *					0  ninguna de las anteriores
 *					-1	error de comunicacion
 *					FMC19011999
 */
 
 
int ren
string cal
long revisa
DataStore lds_cursada
lds_cursada = Create DataStore
lds_cursada.DataObject = "d_cursada"
lds_cursada.SetTransObject(gtr_sce)
revisa = lds_cursada.retrieve(a_cuenta,a_cve_mat,a_cve_carrera,a_cve_plan)	
if revisa > 0 then
	lds_cursada.SetFilter('calificacion IN ("10","9","8","7","6","MB","B","S","E","RE","IN","AC")')
	lds_cursada.Filter()
	if lds_cursada.RowCount() > 0 then
		Destroy lds_cursada
		return 1
	else 
		lds_cursada.SetFilter('calificacion IN ("5","NA")')
		lds_cursada.Filter()
		if lds_cursada.RowCount() > 0 then
			Destroy lds_cursada
			return 2
		else		//Queda "BA", "BJ"
			Destroy lds_cursada
			return 0
		end if
	end if
elseif revisa = 0 then
	Destroy lds_cursada
	return 0
else
	Destroy lds_cursada
	return -1
end if


end function

public function integer estainscritacve_mat (long a_cuenta, long a_cve_mat, integer a_anio, integer a_periodo);/*
 *		Nombre	estainscritacve_mat
 *		Recibe	a_cuenta,a_cve_mat, a_anio, a_periodo
 *		Regresa	1  si el alumno a_cuenta tiene inscrita la materia a_cve_mat ya sea en 
 *						titulo, extraordinario u ordinario para el periodo a_anio a_periodo
 *						0  en caso contrario
 *					-1	error de comunicacion
 *					FMC19011999
 */
 
 DataStore lds_inscrita_extrao, lds_inscrita_ordinario
 int li_res
 int li_ret
 
 lds_inscrita_extrao = Create DataStore
 lds_inscrita_ordinario = Create DataStore
 lds_inscrita_extrao.DataObject = "d_inscrita_extrao"
 lds_inscrita_ordinario.DataObject = "d_inscrita_ordinario"
 lds_inscrita_extrao.SetTransObject(gtr_sce)
 lds_inscrita_ordinario.SetTransObject(gtr_sce)
 li_res =	lds_inscrita_extrao.Retrieve(a_cuenta,a_anio,a_periodo,a_cve_mat)
 if li_res = 0 then
	li_res += lds_inscrita_ordinario.Retrieve(a_cuenta,a_anio,a_periodo,a_cve_mat)
	if li_res = 0 then
		li_ret = 0
	elseif li_res > 0 then
		li_ret = 1
	else
		li_ret = -1
	end if
elseif li_res > 0 then
	li_ret = 1
else
	li_ret = -1
end if

Destroy lds_inscrita_extrao
Destroy lds_inscrita_ordinario
return li_ret
end function

public function integer integracion (long a_cuenta, long a_cve_mat, integer a_puede_integracion, integer a_tema1, integer a_tema2, integer a_tema3, integer a_tema4, integer a_anio, integer a_periodo);/*
 *		Nombre	integracion
 *		Recibe	a_cuenta,a_cve_mat,a_puede_integracion,
 *					a_tema1,a_tema2,a_tema3,a_tema4,
 *					a_anio,a_periodo
 *		Regresa		0 		si la materia a_cve_mat no es de integracion
 *						1		si la materia a_cve_mat si pertenece a integracion pero el
 *								alumno no tiene habilitada la bandera a_puede_integracion
 *						11		si la materia a_cve_mat pertence al tema1 de integracion pero
 *								ya se curso ese tema de acuerdo a la bandera a_tema1
 *						12		si la materia a_cve_mat pertence al tema2 de integracion pero
 *								ya	se curso ese tema de acuerdo a la bandera a_tema2
 *						13		si la materia a_cve_mat pertence al tema3 de integracion pero
 *								ya	se curso ese tema de acuerdo a la bandera a_tema3
 *						14		si la materia a_cve_mat pertence al tema4 de integracion pero
 *								ya	se curso ese tema de acuerdo a la bandera a_tema4
 *						100	si la materia a_cve_mat pertenece a alguno de los temas
 *								fundamentales de integracion y se tiene habilitada la bandera
 *						101	si la materia a_cve_mat pertenece a alguno de los temas
 *								(1,2,3 o 4)	de integracion pero el alumno a_cuenta esta
 *								cursando ese mismo tema en extraordinario, titulo u ordinario
 *								para el periodo a_anio a_periodo
 *								a_puede_integracion
 *						1000	en caso contrario
 *								si la materia a_cve_mat pertenece a alguno de los temas (1,2,3 o 4)
 *								de integracion y el alumno a_cuenta puede cursar ese tema,
 *								es decir tiene habilitadas las banderas a_puede_integracion,
 *								a_tema1,a_tema2,a_tema3,a_tema4 segun corresponda y no esta
 *								cursando ni en extraordinario ni en semestre	normal para el
 *								periodo a_anio a_periodo el tema coorespondiente a la materia
 *								a_cve_mat
 *						-1		error de comunicacion
 *					FMC19011999
 */
 

long area

SELECT area_mat.cve_area  
	INTO :area  
   FROM area_mat  
   WHERE area_mat.cve_mat = :a_cve_mat    using gtr_sce; //Revisión del area de la materia a inscribir
if gtr_sce.sqlcode = -1 AND gtr_sce.sqldbcode = 0 then gtr_sce.sqlcode = 0
if gtr_sce.sqlcode = 0 then
	if area < 2201 or area > 2205 then
		return 0
	elseif a_puede_integracion = 0 then //El alumno no puede cursar la materia
			return 1
	else
		choose case area
			case 2202
				if a_tema1  <> 0 then
					return 11
				end if	
			case 2203
				if a_tema2 <> 0 then 
					return 12
				end if	
			case 2204
				if a_tema3 <> 0 then
					return 13
				end if	
			case 2205
				if a_tema4 <> 0 then
					return 14
				end if	
			case else		//2201
				return 100				
		end choose				 	
		SELECT	area_mat.cve_area  
		INTO :area  
		FROM	area_mat,   
		examen_extrao_titulo  
		WHERE	( examen_extrao_titulo.cve_mat = area_mat.cve_mat ) and
			( area_mat.cve_area = :area ) AND  
			( examen_extrao_titulo.cuenta = :a_cuenta ) AND
			( examen_extrao_titulo.anio = :a_anio ) AND
			( examen_extrao_titulo.periodo = :a_periodo ) using gtr_sce;
		if gtr_sce.sqlcode = 100 then
			SELECT	area_mat.cve_area  
			INTO :area  
			FROM	area_mat,   
			mat_inscritas  
			WHERE	( mat_inscritas.cve_mat = area_mat.cve_mat ) and
					( area_mat.cve_area = :area ) AND  
					( mat_inscritas.cuenta = :a_cuenta ) AND
					( mat_inscritas.anio = :a_anio ) AND
					( mat_inscritas.periodo = :a_periodo ) AND
					( mat_inscritas.cve_condicion = 0 )    using gtr_sce;
			if gtr_sce.sqlcode = -1 AND gtr_sce.sqldbcode = 0 then gtr_sce.sqlcode = 0		
			if gtr_sce.sqlcode = 100 then
				return 1000
			elseif gtr_sce.sqlcode = 0  then
				return 101
			else
				return -1			//error de base de datos						
			end if
		elseif gtr_sce.sqlcode = 0  then
			return 101
		else
			return -1			//error de base de datos						
		end if			
	end if	
elseif gtr_sce.sqlcode = 100 then
		return 0
else
		return -1	//error en bd			
end if

end function

public function integer escursativa (long a_cve_mat, integer a_cve_carrera, integer a_cve_plan);/*
 *		Nombre	escursativa
 *		Recibe	a_cve_mat,a_cve_carrera,a_cve_plan
 *		Regresa	0		la materia a_cve_mat no pertence al plan de estudios
 *					100	la materia no es cursativa
 *					101	la materia es cursativa
 *					-1	error de comunicacion
 *					FMC19011999
 */

DataWindowChild subsistema_child
integer rtncode, li_ret_subsistema

DataStore lds_mat_prerrequisito,lds_materia
string ls_nivel
int li_cursativa, li_res

lds_materia = Create DataStore
lds_materia.DataObject = "dw_mad_prerrequisito_c"
lds_materia.SetTransObject(gtr_sce)
if (lds_materia.Retrieve(a_cve_mat)=1) then
	ls_nivel = lds_materia.GetItemString(1,"nivel")
	Destroy lds_materia
	lds_mat_prerrequisito = Create DataStore
	if ls_nivel = "L" then
		lds_mat_prerrequisito.DataObject = "dw_mad_prerrequisito_b"
		rtncode = lds_mat_prerrequisito.GetChild('cve_subsistema', subsistema_child)
		IF rtncode = -1 THEN 
			 MessageBox("OK", "Sin DataWindowChild",Information!,Ok!)
		ELSE
		// Set the transaction object for the child
			subsistema_child.SetTransObject(gtr_sce)
		// Populate with values for eastern states
			li_ret_subsistema = subsistema_child.Retrieve(a_cve_carrera,a_cve_plan)
		// Set transaction object for main DW and retrieve
		END IF
	else
		lds_mat_prerrequisito.DataObject = "dw_mad_prerrequisito_pos_b"
	end if
	lds_mat_prerrequisito.SetTransObject(gtr_sce)
	li_res = lds_mat_prerrequisito.Retrieve(a_cve_mat,a_cve_carrera,a_cve_plan)
	if ( li_res = 1) then
		li_cursativa = lds_mat_prerrequisito.GetItemNumber(1,"cursativa")
		Destroy lds_mat_prerrequisito
		return li_cursativa+100
	elseif ( li_res = 0) then
		Destroy lds_mat_prerrequisito
		return 0
	else
		Destroy lds_mat_prerrequisito
		return -1
	end if
else
	//Error de comunicacion
	Destroy lds_materia
	return -1
end if
end function

public function integer existemateria (long a_cve_mat, ref string a_materia, ref decimal a_creditos, ref integer a_horas);/*
 *		Nombre	existemateria
 *		Recibe	a_cve_mat,a_materia,a_creditos,a_horas
 *		Regresa	1	si la materia a_cve_mat existe en cuyo caso cambia los valores de
 *						a_materia,a_creditos y a_horas al valor correspondiente a a_cve_mat
 *					0  en caso contrario
 *					-1	error de comunicacion
 *					FMC26011999
 */

DataStore lds_materias
int li_res, li_ret
lds_materias = CREATE DataStore
lds_materias.DataObject = "w_materias2"
lds_materias.SetTransObject(gtr_sce)
li_res = lds_materias.Retrieve(a_cve_mat) 
if ( li_res = 1 ) then
	a_materia = lds_materias.GetItemString(1,"materias_materia")
	a_creditos = lds_materias.GetItemDecimal(1,"materias_creditos")
	a_horas = lds_materias.GetItemNumber(1,"materias_horas_reales")
	li_ret = 1
elseif ( li_res = 0 ) then
	li_ret = 0
else
	li_ret = -1
end if
Destroy lds_materias
return li_ret

end function

on w_examen_extrao_tit.create
if this.MenuName = "m_examen_extrao_tit" then this.MenuID = create m_examen_extrao_tit
this.dw_examen_extrao_titulo_comp=create dw_examen_extrao_titulo_comp
this.st_plan=create st_plan
this.st_carrera=create st_carrera
this.rb_titulo=create rb_titulo
this.rb_extraordinario=create rb_extraordinario
this.uo_anio_periodo=create uo_anio_periodo
this.st_13=create st_13
this.st_12=create st_12
this.st_11=create st_11
this.st_10=create st_10
this.st_9=create st_9
this.st_8=create st_8
this.st_7=create st_7
this.st_6=create st_6
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.st_2=create st_2
this.st_15=create st_15
this.st_18=create st_18
this.st_14=create st_14
this.st_1=create st_1
this.dw_revision_est_total=create dw_revision_est_total
this.dw_examen_extrao_titulo=create dw_examen_extrao_titulo
this.uo_1=create uo_1
this.dw_revision_est_resumen=create dw_revision_est_resumen
this.Control[]={this.dw_examen_extrao_titulo_comp,&
this.st_plan,&
this.st_carrera,&
this.rb_titulo,&
this.rb_extraordinario,&
this.uo_anio_periodo,&
this.st_13,&
this.st_12,&
this.st_11,&
this.st_10,&
this.st_9,&
this.st_8,&
this.st_7,&
this.st_6,&
this.st_5,&
this.st_4,&
this.st_3,&
this.st_2,&
this.st_15,&
this.st_18,&
this.st_14,&
this.st_1,&
this.dw_revision_est_total,&
this.dw_examen_extrao_titulo,&
this.uo_1,&
this.dw_revision_est_resumen}
end on

on w_examen_extrao_tit.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_examen_extrao_titulo_comp)
destroy(this.st_plan)
destroy(this.st_carrera)
destroy(this.rb_titulo)
destroy(this.rb_extraordinario)
destroy(this.uo_anio_periodo)
destroy(this.st_13)
destroy(this.st_12)
destroy(this.st_11)
destroy(this.st_10)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_15)
destroy(this.st_18)
destroy(this.st_14)
destroy(this.st_1)
destroy(this.dw_revision_est_total)
destroy(this.dw_examen_extrao_titulo)
destroy(this.uo_1)
destroy(this.dw_revision_est_resumen)
end on

event open;x = 1
y = 1
ii_tipo = 2
il_cuenta = 0
rb_extraordinario.checked = true
uo_anio_periodo.BackColor = RGB(160,160,164)
dw_revision_est_resumen.object.datawindow.color = RGB(160,160,164)
//WindowState = Maximized!
//g_nv_security.fnv_secure_window(this)


long ll_row
int li_retorno, li_periodo, li_anio, li_coord_usuario, li_chk, li_num_items, li_item_actual

//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

//itr_parametros_iniciales = gtr_sce
////Se redirige la ventana a Web, para que las validaciones coincidan con la base de web
//li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
//if li_chk <> 1 then return



//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = itr_seguridad
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

//Cambio por Ajustes en Línea
//1)<-


//***RESTO


//Cambio por Ajustes en Línea
//2)->
//Se vuelve a poner porque en el constructor de los datawindows ya previamente se había ejecutado apuntando a sybase

dw_examen_extrao_titulo.SetTransObject(gtr_sce)
dw_examen_extrao_titulo_comp.SetTransObject(gtr_sce)
dw_revision_est_resumen.SetTransObject(gtr_sce)
dw_revision_est_total.SetTransObject(gtr_sce)

uo_1.dw_nombre_alumno.settransobject(gtr_sce)
uo_1.dw_nombre_alumno.insertrow(0)
f_obten_titulo(w_principal)

w_principal.ChangeMenu(m_grupos_impartidos_salir)

//Cambio por Ajustes en Línea
//2)<-



end event

event close;//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
if not (conecta_bd_n_tr(itr_original,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en conectividad', 'No es posible reconectarse al origen. Favor de reiniciar la aplicación',Stopsign!)
	HALT CLOSE		
end if

//Se asigna la transacción original
gtr_sce = itr_original 

//Es necesario reasignar el transaction object para la seguridad
gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if

f_obten_titulo(w_principal)
w_principal.ChangeMenu(m_principal)
gnv_app.inv_security.of_SetSecurity(w_principal)
//Cambio por Ajustes en Línea
//3)<-

end event

type dw_examen_extrao_titulo_comp from datawindow within w_examen_extrao_tit
event carga ( )
boolean visible = false
integer x = 59
integer y = 460
integer width = 494
integer height = 92
integer taborder = 41
string dataobject = "d_examen_extrao_titulo_comp"
boolean livescroll = true
end type

event carga;Retrieve(il_cuenta,gi_anio,gi_periodo,ii_tipo)
end event

event itemchanged;SetTransObject(gtr_sce)
end event

event constructor;SetTransObject(gtr_sce)
end event

type st_plan from statictext within w_examen_extrao_tit
integer x = 1646
integer y = 668
integer width = 1733
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
boolean focusrectangle = false
end type

type st_carrera from statictext within w_examen_extrao_tit
integer x = 1646
integer y = 604
integer width = 1733
integer height = 64
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
boolean focusrectangle = false
end type

type rb_titulo from radiobutton within w_examen_extrao_tit
integer x = 2894
integer y = 532
integer width = 485
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Titulo de Suf"
end type

event clicked;ii_tipo = 6
parent.triggerevent("inicia_proceso",0,il_cuenta)

end event

type rb_extraordinario from radiobutton within w_examen_extrao_tit
integer x = 2894
integer y = 448
integer width = 485
integer height = 84
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Extraordinario"
boolean checked = true
end type

event clicked;ii_tipo = 2
parent.triggerevent("inicia_proceso",0,il_cuenta)

end event

type uo_anio_periodo from uo_per_ani within w_examen_extrao_tit
integer x = 1646
integer y = 448
integer width = 1253
integer height = 168
integer taborder = 40
boolean enabled = true
long backcolor = 1090519039
end type

on uo_anio_periodo.destroy
call uo_per_ani::destroy
end on

event constructor;call super::constructor;DataStore lds_anio_per_mat_inscritas
lds_anio_per_mat_inscritas = Create DataStore
lds_anio_per_mat_inscritas.DataObject = "d_anio_per_mat_inscritas"
lds_anio_per_mat_inscritas.SetTransObject(gtr_sce)
if ( lds_anio_per_mat_inscritas.Retrieve() > 0 ) then
	gi_anio = lds_anio_per_mat_inscritas.GetItemNumber(1,"anio")
	gi_periodo = lds_anio_per_mat_inscritas.GetItemNumber(1,"periodo")
	G_Per = gi_periodo
	G_year = gi_anio
else
	MessageBox("Error","Error al consultar materias inscritas")
end if
Destroy lds_anio_per_mat_inscritas

//gi_anio = 1998
//gi_periodo = 2
end event

type st_13 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 1536
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Menor Optativa"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_12 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 1452
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mayor Optativa"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_11 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 1360
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema IV"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_10 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 1276
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema III"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_9 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 1184
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema II"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_8 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 1100
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Tema I"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_7 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 1008
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Integ Fundamental"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_6 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 924
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Menor Obligatoria"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_5 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 832
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Servicio Social"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_4 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 748
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Opción Terminal"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 656
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mayor Obligatoria"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_2 from statictext within w_examen_extrao_tit
integer x = 59
integer y = 572
integer width = 507
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Básica"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_15 from statictext within w_examen_extrao_tit
integer x = 1330
integer y = 460
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Completa"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_18 from statictext within w_examen_extrao_tit
integer x = 1083
integer y = 460
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Faltantes"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_14 from statictext within w_examen_extrao_tit
integer x = 837
integer y = 460
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Cursados"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_1 from statictext within w_examen_extrao_tit
integer x = 590
integer y = 460
integer width = 247
integer height = 92
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean enabled = false
string text = "Mínimos"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_revision_est_total from datawindow within w_examen_extrao_tit
boolean visible = false
integer x = 2469
integer y = 2016
integer width = 946
integer height = 300
integer taborder = 10
string dataobject = "dw_certificado_ext2"
boolean livescroll = true
end type

type dw_examen_extrao_titulo from datawindow within w_examen_extrao_tit
event carga ( )
event keyboard pbm_dwnkey
event borramateria ( )
integer x = 1646
integer y = 736
integer width = 1733
integer height = 1028
integer taborder = 50
string dataobject = "d_examen_extrao_titulo"
boolean border = false
boolean livescroll = true
end type

event carga;Retrieve(il_cuenta,gi_anio,gi_periodo,ii_tipo)
end event

event keyboard;long cvmat
int col

//col = getcolumn()
//if keyflags= 6 then
//	col = 2
//end if
//if key = keyenter! or key = keytab! then
//	if col = 2 then	
//		accepttext()
//		return 1
//	end if
//end if

if key = KeyDownArrow! then
	if rowcount() = 0 and il_cuenta <> 0 then
		scrolltorow(insertrow(0))
		//agrega_mat()
		return		
	elseif il_cuenta = 0 then
		return
	end if
	
	if getrow() = rowcount() then  //Agrega un renglón si se esta en el último y se presiona la tecla key down arrow
		if getitemnumber(getrow(),"examen_extrao_titulo_cve_mat") > 0 and &
			getitemstring(getrow(),"examen_extrao_titulo_gpo") <> " " then
			scrolltorow(insertrow(0))
			//SetColumn("examen_extrao_titulo_cve_mat")
			//agrega_mat()			
		end if
	end if
//elseif key = KeyA! or key =  KeyB! or key =  KeyC! or key =  KeyD! or key =  KeyE! or key =  KeyF! or &
//		key =  KeyG! or key =  KeyH! or key =  KeyI! or key =  KeyJ! or key =  KeyK! or key =  KeyL! or &
//		key =  KeyM! or key =  KeyN! or key =  KeyO! or key =  KeyP! or key =  KeyQ! or key =  KeyR! or &
//		key =  KeyS! or key =  KeyT! or key =  KeyU! or key =  KeyV! or key =  KeyW! or key =  KeyX! or &
//		key =  KeyY! or key =  KeyZ! then		
//	if col = 2 then
//		if getrow() = rowcount() then			
//				if getitemnumber(getrow(),1) > 0 and getitemstring(getrow(),2) <> " " then				
//					messagebox("Atención", "No es posible modificar el grupo de una materia inscrita",Exclamation!)
//					setitem(getrow(),2,getitemstring(getrow(),2,primary!,true))		
//					return 1
//				else
//					return 0
//				end if			
//		else	
//			messagebox("Atención", "No es posible modificar el grupo de una materia inscrita",Exclamation!)
//			setitem(getrow(),2,getitemstring(getrow(),2,primary!,true))			
//			return 1
//		end if
//	end if
//elseif key = Key0! or key = Key1! or key = Key2! or key = Key3! or key = Key4! or key = Key5! or key = Key6! or&
//		key = Key7! or key = Key8! or key = Key9! or key = Keynumpad1! or key = Keynumpad2! or key = Keynumpad3!&
//		or key = Keynumpad4! or key = Keynumpad5! or key = Keynumpad6! or key = Keynumpad7! or key = Keynumpad8!&
//		or key = Keynumpad9! or key = Keynumpad0! then	
//	if col = 1  then
//		if getrow() = rowcount() then
//			if getitemnumber(getrow(),1) > 0 and getitemstring(getrow(),2) <> " " then		
//				messagebox("Atención", "No es posible modificar la clave de una materia inscrita",Exclamation!)
//				setitem(getrow(),1,getitemnumber(getrow(),1,primary!,true))	
//				return 0
//			else
//				return 0
//			end if
//		else			
//			messagebox("Atención", "No es posible modificar la clave de una materia inscrita",Exclamation!)
//			setitem(getrow(),1,getitemnumber(getrow(),1,primary!,true))			
//			return 1
//		end if
//	elseif col = 2 then
//		if getrow() = rowcount() then
//			if getitemnumber(getrow(),1) > 0 and getitemstring(getrow(),2) <> " " then				
//				setitem(getrow(),2,getitemstring(getrow(),2,primary!,true))				
//			else
//				return 0
//			end if
//		else			
//			setitem(getrow(),2,getitemstring(getrow(),2,primary!,true))			
//		end if
//	end if	
end if


end event

event borramateria;if GetRow()>0 then
	if (MessageBox("Atencion","Esta seguro de querer borrar la materia seleccionada?",Question!,YesNo!,2) = 1) then
		DeleteRow(GetRow())
		if Update() = 1 then
			COMMIT using gtr_sce;
		else
			ROLLBACK using gtr_sce;
			MessageBox("Atención","No se pudo borrar la materia",Exclamation!)
		end if
		Event carga()
	end if
end if
end event

event constructor;SetTransObject(gtr_sce)
SetRowFocusIndicator(Hand!) 


end event

event itemchanged;string ls_mat
long ll_cve_mat
int li_hrs
decimal ldc_crd
int li_res
int li_continua
long ll_veces_cursada
if dwo.name = "examen_extrao_titulo_cve_mat" then
setpointer(Hourglass!)
accepttext()
li_continua = 0

ll_cve_mat = getitemnumber(getrow(),"examen_extrao_titulo_cve_mat",Primary!,False) // Lectura de la cve de la mat
if ll_cve_mat > 0 then
	li_res = existemateria(ll_cve_mat,ls_mat,ldc_crd,li_hrs)
	choose case li_res
		case 1
			li_continua++
			setitem(getrow(),"materias_materia",ls_mat)  //Si existe, despliega el nombre y los creditos y las horas
			setitem(getrow(),"materias_creditos",ldc_crd)
		case 0
			MessageBox("Materia inexistente","La materia no existe",Exclamation!)
		case -1
			Messagebox("Error de Comunicación","Error con la consulta de Base Datos ExisteMateria. Favor de intentar nuevamente",None!)
	end choose
	if li_continua = 1 then
		li_res = escursativa(ll_cve_mat,ii_cve_carrera,ii_cve_plan)
		ll_veces_cursada = f_cuenta_veces_cursada(il_cuenta,ll_cve_mat,ii_cve_carrera,ii_cve_plan)
		choose case li_res
			case 0
				MessageBox("No puede inscribir","La materia no pertenece al plan de estudios",Exclamation!)
			case 100
				li_continua++
			case 101
				if (MessageBox("Atencion","La materia es cursativa y ha sido cursada ["+string(ll_veces_cursada)+"] veces, ¿Desea continuar?",Question!,YesNo!,2) = 1)then 
					li_continua++
				end if
			case -1
				Messagebox("Error de Comunicación","Error con la consulta de Base Datos ExisteMateria. Favor de intentar nuevamente",None!)
		end choose
	end if
	if li_continua = 2 then
		li_res = cursoprerrequisitos(il_cuenta,ll_cve_mat,ii_cve_carrera,ii_cve_plan)
		choose case li_res
			case 1
				li_continua++
			case 0
				MessageBox("Faltan prerrequisitos","El alumno no ha cursado los prerrequisitos para inscribir la materia "+string(ll_cve_mat),Exclamation!)
			case -1
				Messagebox("Error de Comunicación","Error con la consulta de Base Datos Prerrequisitos. Favor de intentar nuevamente",None!)
		end choose
	end if
	if li_continua = 3 then
		li_res = estacursada(il_cuenta,ll_cve_mat,ii_cve_carrera,ii_cve_plan)
		if ii_tipo = 6 then 
			choose case li_res
				case 1
					MessageBox("Materia cursada","El alumno ya curso la materia "+string(ll_cve_mat),Exclamation!)
				case 2
					MessageBox("Materia reprobada","El alumno ha reprobado la materia "+string(ll_cve_mat),Exclamation!)
				case 0
					li_continua++
				case -1
					Messagebox("Error de Comunicación","Error con la consulta de Base Datos Materia Cursada. Favor de intentar nuevamente",None!)
			end choose
		elseif ii_tipo = 2 then
			choose case li_res
				case 1
					MessageBox("Materia cursada","El alumno ya curso la materia "+string(ll_cve_mat),Exclamation!)
				case 2
					li_continua++
				case 0
					MessageBox("Materia no cursada","El alumno necesita haber reprobado la materia "+string(ll_cve_mat)+" en periodo ordinario completo",Exclamation!)
				case -1
					Messagebox("Error de Comunicación","Error con la consulta de Base Datos Materia no cursada. Favor de intentar nuevamente",None!)
			end choose
		end if
	end if
	if li_continua = 4 then
		li_res = estainscritacve_mat(il_cuenta,ll_cve_mat,gi_anio,gi_periodo)
		choose case li_res
			case 1
				MessageBox("Materia inscrita","El alumno tiene inscrita la materia "+string(ll_cve_mat),Exclamation!)
			case 0
				li_continua++
			case -1
				Messagebox("Error de Comunicación","Error con la consulta de Base Datos Materia inscrita. Favor de intentar nuevamente",None!)
		end choose
	end if
	if li_continua = 5 then
		li_res = esssot(ll_cve_mat,ii_cve_carrera,ii_cve_plan)
		choose case li_res
			case 1
				MessageBox("Servicio Social","No se puede inscribir el servicio social ",Exclamation!)
			case 2
				MessageBox("Seminario de Proyecto de Opción Terminal","No se puede inscribir el seminario de proyecto de opción terminal ",Exclamation!)
			case 0
				li_continua++
			case -1
				Messagebox("Error de Comunicación","Error con la consulta de Base Datos Servicio Social u Opción Terminal. Favor de intentar nuevamente",None!)
		end choose
	end if
	if li_continua = 6 then
		//if ii_tipo = 6 then
		//	li_continua++
		//elseif ii_tipo = 2 then
			li_res = totalinscritas(il_cuenta,gi_anio,gi_periodo,ii_tipo)
			if li_res = 0 then
				li_continua++
			elseif li_res = 1 then
				li_res = puntajemayor(il_cuenta,ii_cve_carrera,ii_cve_plan,10)
				choose case li_res
					case 0
						if (MessageBox("Atencion","El alumno excede el limite de materias y no supera el puntaje de calidad en una unidad ¿Desea continuar?",Question!,YesNo!,2) = 1)then 
							li_continua++
						else
							MessageBox("Excede Límite","No se puede inscribir mas de una materia a extraordinario si no supera el puntaje de calidad en una unidad",Exclamation!)
						end if
					case 1
						li_continua++
					case -1
						Messagebox("Error de Comunicación","Error con la consulta de Base Datos Puntaje de Calidad. Favor de intentar nuevamente",None!)
				end choose
			elseif li_res > 1 then
				MessageBox("Excede Límite","No se pueden inscribir mas de dos materias a extraordinario",Exclamation!)
			elseif li_res < 0 then
				Messagebox("Error de Comunicación","Error con la consulta de Base Datos Cuantas Inscritas. Favor de intentar nuevamente",None!)
			end if
		end if
	//end if
	if li_continua = 7 then
		li_res = integracion(il_cuenta,ll_cve_mat,ii_banderasalumno[b_pi],&
			ii_banderasalumno[b_t1],ii_banderasalumno[b_t2],ii_banderasalumno[b_t3],&
			ii_banderasalumno[b_t4],gi_anio,gi_periodo)
		choose case li_res
			case 0
				li_continua++
			case 1
				MessageBox("No puede llevar integración","El alumno no puede inscribir materias de Integración",Exclamation!)
			case 11
				MessageBox("Ya curso el tema","El alumno ya curso el tema I de Integracion",Exclamation!)
			case 12
				MessageBox("Ya curso el tema","El alumno ya curso el tema II de Integracion",Exclamation!)
			case 13
				MessageBox("Ya curso el tema","El alumno ya curso el tema III de Integracion",Exclamation!)
			case 14
				MessageBox("Ya curso el tema","El alumno ya curso el tema IV de Integracion",Exclamation!)
			case 100
				li_continua++
			case 101
				MessageBox("Esta cursando el tema","El alumno esta cursando el tema de Integracion",Exclamation!)
			case 1000
				li_continua++
			case -1
				Messagebox("Error de Comunicación","Error con la consulta de Base Datos Integración. Favor de intentar nuevamente",None!)
		end choose
	end if
	if li_continua = 8 then
		setitem(getrow(),"examen_extrao_titulo_gpo","A")
		setitem(getrow(),"examen_extrao_titulo_cuenta",il_cuenta)
		setitem(getrow(),"examen_extrao_titulo_anio",gi_anio)
		setitem(getrow(),"examen_extrao_titulo_periodo",gi_periodo)
		setitem(getrow(),"examen_extrao_titulo_tipo_examen",ii_tipo)
		if update(TRUE) = 1 then 
			COMMIT using gtr_sce;
			scrolltorow(insertrow(0))
		else
			ROLLBACK USING gtr_sce;
			setitem(getrow(),"examen_extrao_titulo_cve_mat",0)
			Messagebox("Error de Comunicación","No fue posible guardar la materia "+&
							string(ll_cve_mat),None!)
		end if
	else
		setitem(getrow(),"examen_extrao_titulo_cve_mat",0)
	end if
end if
setpointer(Arrow!)
end if
end event

event itemerror;return 1
end event

event rowfocuschanged;if currentrow = rowcount() then
	setcolumn("examen_extrao_titulo_cve_mat")
end if

end event

type uo_1 from uo_nombre_alumno within w_examen_extrao_tit
integer x = 32
integer y = 32
integer height = 428
integer taborder = 30
boolean enabled = true
end type

on uo_1.destroy
call uo_nombre_alumno::destroy
end on

type dw_revision_est_resumen from datawindow within w_examen_extrao_tit
integer x = 585
integer y = 564
integer width = 1029
integer height = 1180
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_rev_est_fmc"
boolean border = false
boolean livescroll = true
end type

