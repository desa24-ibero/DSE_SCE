$PBExportHeader$w_examen_extrao_tit_2013.srw
forward
global type w_examen_extrao_tit_2013 from w_master_main
end type
type lds_prueba from datawindow within w_examen_extrao_tit_2013
end type
type lds_revision_est from datawindow within w_examen_extrao_tit_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_examen_extrao_tit_2013
end type
type uo_anio_periodo from uo_per_ani within w_examen_extrao_tit_2013
end type
type rb_extraordinario from radiobutton within w_examen_extrao_tit_2013
end type
type rb_titulo from radiobutton within w_examen_extrao_tit_2013
end type
type dw_examen_extrao_titulo from uo_master_dw within w_examen_extrao_tit_2013
end type
type dw_examen_extrao_titulo_comp from uo_master_dw within w_examen_extrao_tit_2013
end type
type dw_revision_est_resumen from uo_master_dw within w_examen_extrao_tit_2013
end type
end forward

global type w_examen_extrao_tit_2013 from w_master_main
integer width = 4507
integer height = 2812
string title = "Examenes Extraordinarios y a Titulo"
string menuname = "m_menu_general_2013_ets"
windowstate windowstate = maximized!
boolean clientedge = true
boolean center = true
lds_prueba lds_prueba
lds_revision_est lds_revision_est
uo_nombre uo_nombre
uo_anio_periodo uo_anio_periodo
rb_extraordinario rb_extraordinario
rb_titulo rb_titulo
dw_examen_extrao_titulo dw_examen_extrao_titulo
dw_examen_extrao_titulo_comp dw_examen_extrao_titulo_comp
dw_revision_est_resumen dw_revision_est_resumen
end type
global w_examen_extrao_tit_2013 w_examen_extrao_tit_2013

type variables
long il_cuenta,il_carrera,il_plan,il_sub,ii_tipo
str_revision_estudios istr_rev_est
string is_nivel
int ii_BanderasAlumno[22]
n_tr itr_seguridad, itr_original
int ii_chk = 0, ii_sw = 0

CONSTANT int b_isa = 1, b_cfp = 2, b_b3r = 3, b_b4i = 4
CONSTANT int b_bdi = 5, b_bdo = 6, b_ih = 7, b_ec = 8
CONSTANT int b_cfpi = 9, b_cfss = 10, b_pi = 11
CONSTANT int b_tf1 = 12, b_tf2 = 13, b_t1 = 14, b_t2 = 15
CONSTANT int b_t3 = 16, b_t4 = 17, b_ci = 18, b_cfb = 19
CONSTANT int b_cfd = 20, b_af = 21, b_v = 22

Transaction itr_parametros_iniciales

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_ets"

INTEGER ie_error_validacion




end variables

forward prototypes
public function integer wf_genera_rev_est ()
public function integer escursativa (long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer cursoprerrequisitos (long a_cuenta, long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer estacursada (long a_cuenta, long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer estainscritacve_mat (long a_cuenta, long a_cve_mat, integer a_anio, ref integer a_periodo)
public function integer esssot (long a_cve_mat, integer a_cve_carrera, integer a_cve_plan)
public function integer totalinscritas (long a_cuenta, integer a_anio, integer a_periodo, integer a_tipo)
public function integer puntajemayor (long a_cuenta, integer a_cve_carrera, integer a_cve_plan, integer a_unidades)
public function integer llenabanderas (long a_cuenta, ref integer a_banderas[22])
public function integer estainscrito (long a_cuenta, integer a_periodo, integer a_anio)
public function integer wf_validar ()
public subroutine wf_conecta ()
public subroutine wf_desconecta ()
public subroutine wf_limpiar ()
public function integer integracion (long a_cuenta, long a_cve_mat, integer a_puede_integracion, integer a_tema1, integer a_tema2, integer a_tema3, integer a_tema4, integer a_fundamental1, integer a_fundamental2, integer a_anio, integer a_periodo)
public function integer existemateria (long a_cve_mat, ref string a_materia, ref decimal a_creditos, ref integer a_horas)
end prototypes

public function integer wf_genera_rev_est ();long ll_cuenta,ll_carrera,ll_plan,ll_subsis
int li_baja_disciplina,li_i,li_pos
string ls_nivel,ls_nombre,ls_apaterno,ls_amaterno
DataWindowChild ldc_revision
boolean lb_res

dw_revision_est_resumen.Reset()
dw_revision_est_resumen.Insertrow(0)
dw_revision_est_resumen.Getchild("dw_rev_est_fmc_child",ldc_revision)
lds_revision_est.Reset()
ldc_revision.Reset()
lds_prueba.Reset()
lb_res = hist_alumno_areas(il_cuenta,il_carrera,il_plan,il_sub,lds_prueba,lds_revision_est,is_nivel)
for li_i = 1 to lds_revision_est.Rowcount()
	ldc_revision.insertrow(0)
	ldc_revision.SetItem(li_i,"minimos",lds_revision_est.GetItemNumber(li_i ,"minimos"))
	ldc_revision.SetItem(li_i,"cursados",lds_revision_est.GetItemNumber(li_i ,"cursados"))
next

return 1
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
	//if ls_nivel = "L" then
	if ls_nivel <> "P" then
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

public function integer estainscritacve_mat (long a_cuenta, long a_cve_mat, integer a_anio, ref integer a_periodo);/*
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
real lr_plan_estudios_puntaje_min, lr_promedio
decimal ld_promedio, ldc_creditos
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

public function integer wf_validar ();dwItemStatus l_status
int li_i,li_hrs,li_continua,li_res
decimal ldc_crd
long ll_cve_mat,ll_veces_cursada
string ls_mat

idw_trabajo.AcceptText()
for li_i = 1 to idw_trabajo.Rowcount()
	l_status = idw_trabajo.GetItemStatus(li_i, 'examen_extrao_titulo_cve_mat', Primary!)

	if l_status <> NotModified!	then
		ll_cve_mat = idw_trabajo.getitemnumber(1,"examen_extrao_titulo_cve_mat") // Lectura de la cve de la mat
		if ll_cve_mat > 0 then
			li_res = existemateria(ll_cve_mat,ls_mat,ldc_crd,li_hrs)
			choose case li_res
				case 1
					li_continua++
				case 0
					MessageBox("Aviso","La materia "+ string(ll_cve_mat)+ " no existe",Exclamation!)
					return -1
				case -1
					Messagebox("Error ","Error con la consulta de Base Datos ExisteMateria. Favor de intentar nuevamente",Exclamation!)
					return -1
			end choose
			if li_continua = 1 then
				li_res = escursativa(ll_cve_mat,il_carrera,il_plan)
				ll_veces_cursada = f_cuenta_veces_cursada(il_cuenta,ll_cve_mat,il_carrera,il_plan)
				choose case li_res
					case 0
						MessageBox("Aviso","La materia  "+ string(ll_cve_mat)+ " no pertenece al plan de estudios",Exclamation!)
						return -1
					case 100
						li_continua++
					case 101
						if (MessageBox("Aviso","La materia es cursativa y ha sido cursada ["+string(ll_veces_cursada)+"] veces, ¿Desea continuar?",Question!,YesNo!,2) = 1)then 
							li_continua++
						end if
					case -1
						Messagebox("Error","Error con la consulta de Base Datos ExisteMateria. Favor de intentar nuevamente",Exclamation!)
						return -1
				end choose
			end if
			if li_continua = 2 then
				li_res = cursoprerrequisitos(il_cuenta,ll_cve_mat,il_carrera,il_plan)
				choose case li_res
					case 1
						li_continua++
					case 0
						MessageBox("Aviso","El alumno no ha cursado los prerrequisitos para inscribir la materia "+string(ll_cve_mat),Exclamation!)
						return -1
					case -1
						Messagebox("Error","Error con la consulta de Base Datos Prerrequisitos. Favor de intentar nuevamente",Exclamation!)
						return -1
				end choose
			end if
			if li_continua = 3 then
				li_res = estacursada(il_cuenta,ll_cve_mat,il_carrera,il_plan)
				if ii_tipo = 6 then 
					choose case li_res
						case 1
							MessageBox("Aviso","El alumno ya curso la materia "+string(ll_cve_mat),Exclamation!)
							return -1
						case 2
							MessageBox("Aviso","El alumno ha reprobado la materia "+string(ll_cve_mat),Exclamation!)
							return -1
						case 0
							li_continua++
						case -1
							Messagebox("Error","Error con la consulta de Base Datos Materia Cursada. Favor de intentar nuevamente",Exclamation!)
							return -1
					end choose
				elseif ii_tipo = 2 then
					choose case li_res
						case 1
							MessageBox("Aviso","El alumno ya curso la materia "+string(ll_cve_mat),Exclamation!)
							return -1
						case 2
							li_continua++
						case 0
							MessageBox("Aviso","El alumno necesita haber reprobado la materia "+string(ll_cve_mat)+" en periodo ordinario completo",Exclamation!)
							return -1
						case -1
							Messagebox("Error","Error con la consulta de Base Datos Materia no cursada. Favor de intentar nuevamente",Exclamation!)
							return -1
					end choose
				end if
			end if
			if li_continua = 4 then
				li_res = estainscritacve_mat(il_cuenta,ll_cve_mat,gi_anio,gi_periodo)
				choose case li_res
					case 1
						MessageBox("Aviso","El alumno tiene inscrita la materia "+string(ll_cve_mat),Exclamation!)
						return -1
					case 0
						li_continua++
					case -1
						Messagebox("Error","Error con la consulta de Base Datos Materia inscrita. Favor de intentar nuevamente",Exclamation!)
						return -1
				end choose
			end if
			if li_continua = 5 then
				// Si es Posgrado no se valida el proyecto de Servicio Social.
				IF is_nivel <> "P" THEN 
					li_res = esssot(ll_cve_mat,il_carrera,il_plan)
					choose case li_res
						case 1
							MessageBox("Aviso","No se puede inscribir el servicio social ",Exclamation!)
							return -1
						case 2
							MessageBox("Aviso","No se puede inscribir el seminario de proyecto de opción terminal ",Exclamation!)
							return -1
						case 0
							li_continua++
						case -1
							Messagebox("Error","Error con la consulta de Base Datos Servicio Social u Opción Terminal. Favor de intentar nuevamente",Exclamation!)
							return -1
					end choose
				ELSE
					li_continua++
				END IF 
			end if
			if li_continua = 6 then
				li_res = totalinscritas(il_cuenta,gi_anio,gi_periodo,ii_tipo)
				if li_res = 0 then
					li_continua++
				elseif li_res = 1 then
					li_res = puntajemayor(il_cuenta,il_carrera,il_plan,10)
					choose case li_res
						case 0
							if (MessageBox("Aviso","El alumno excede el limite de materias y no supera el puntaje de calidad en una unidad ¿Desea continuar?",Question!,YesNo!,2) = 1)then 
								li_continua++
							else
								MessageBox("Aviso","No se puede inscribir mas de una materia a extraordinario si no supera el puntaje de calidad en una unidad",Exclamation!)
								return -1
							end if
						case 1
							li_continua++
						case -1
							Messagebox("Error","Error con la consulta de Base Datos Puntaje de Calidad. Favor de intentar nuevamente",Exclamation!)
							return -1
					end choose
				elseif li_res > 1 then
					MessageBox("Aviso","No se pueden inscribir mas de dos materias a extraordinario",Exclamation!)
					return -1
				elseif li_res < 0 then
					Messagebox("Error","Error con la consulta de Base Datos Cuantas Inscritas. Favor de intentar nuevamente",Exclamation!)
					return -1
				end if
			end if
			if li_continua = 7 then
				li_res = integracion(il_cuenta,ll_cve_mat,ii_banderasalumno[b_pi],&
					ii_banderasalumno[b_t1],ii_banderasalumno[b_t2],ii_banderasalumno[b_t3],&
					ii_banderasalumno[b_t4], ii_banderasalumno[b_tf1], ii_banderasalumno[b_tf2], gi_anio,gi_periodo)
				choose case li_res
					case 0
						li_continua++
					case 1
						MessageBox("Aviso","El alumno no puede inscribir materias de Integración",Exclamation!)
						return -1
					case 11
						MessageBox("Aviso","El alumno ya curso el tema I de Integracion",Exclamation!)
						return -1
					case 12
						MessageBox("Aviso","El alumno ya curso el tema II de Integracion",Exclamation!)
						return -1
					case 13
						MessageBox("Aviso","El alumno ya curso el tema III de Integracion",Exclamation!)
						return -1
					case 14
						MessageBox("Aviso","El alumno ya curso el tema IV de Integracion",Exclamation!)
						return -1
					case 100
						li_continua++
					case 101
						MessageBox("Aviso","El alumno esta cursando el tema de Integracion",Exclamation!)
						return -1
					case 1000
						li_continua++
					case -1
						Messagebox("Error","Error con la consulta de Base Datos Integración. Favor de intentar nuevamente",Exclamation!)
						return -1
				end choose
			end if
		end if
	end if
end for

return 1
end function

public subroutine wf_conecta ();//Cambio por Ajustes en Línea
//1)->
//Se conecta a la seguridad para mantener separada una transacción para la seguridad
if not (conecta_bd_n_tr(itr_seguridad,gs_sce,gs_usuario,gs_password) = 1) then
	messageBox('Error en seguridad', 'No es posible validar la seguridad del usuario',Stopsign!)
end if

itr_parametros_iniciales = gtr_sce
//Se redirige la ventana a Web, para que las validaciones coincidan con la base de web
//////////////////////////Quitar cuando se termine de probar
//gs_password = 'pruebas1'
//////////////////////////
ii_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,gtr_sce,is_controlescolar_cnx,gs_usuario,gs_password,1)
if ii_chk <> 1 then return

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

w_principal.visible = false
f_obten_titulo(w_examen_extrao_tit_2013)
end subroutine

public subroutine wf_desconecta ();//Cambio por Ajustes en Línea
//3)->
//Se conecta a la base de datos original para reasignar a la transacción principal
//////////////////////////Quitar cuando se termine de probar
//gs_password = 'desarrollo'
//////////////////////////

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

gnv_app.inv_security.of_SetSecurity(w_principal)
ii_chk = 0
//Cambio por Ajustes en Línea
//3)<-

w_principal.visible = true
f_obten_titulo(w_principal)

end subroutine

public subroutine wf_limpiar ();uo_nombre.dw_nombre_alumno.Reset()
uo_nombre.dw_carreras.Reset()
uo_nombre.dw_nombre_alumno.Insertrow(0)
uo_nombre.em_cuenta.text = ''
uo_nombre.em_digito.text = ''
il_cuenta = 0
dw_examen_extrao_titulo.reset()
uo_nombre.em_cuenta.Setfocus()

ie_error_validacion = 0 
end subroutine

public function integer integracion (long a_cuenta, long a_cve_mat, integer a_puede_integracion, integer a_tema1, integer a_tema2, integer a_tema3, integer a_tema4, integer a_fundamental1, integer a_fundamental2, integer a_anio, integer a_periodo);/*
 *		Nombre	integracion
 *		Recibe	a_cuenta,a_cve_mat,a_puede_integracion,
 *					a_tema1,a_tema2,a_tema3,a_tema4,
 *					a_fundamental1, a_fundamental2
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
 *      				15		Si se trata de un tema fundamental pero
 *								ya	se curso ese tema de acuerdo a la bandera a_fundamental1 o a_fundamental2  
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
LONG ll_area_fundamental
LONG ll_area_tema1
LONG ll_area_tema2
LONG ll_area_tema3
LONG ll_area_tema4 


SELECT area_mat.cve_area  
	INTO :area  
   FROM area_mat  
   WHERE area_mat.cve_mat = :a_cve_mat    using gtr_sce; //Revisión del area de la materia a inscribir
if gtr_sce.sqlcode = -1 AND gtr_sce.sqldbcode = 0 then gtr_sce.sqlcode = 0
if gtr_sce.sqlcode = 0 then
elseif gtr_sce.sqlcode = 100 then
		return 0
else
		return -1	//error en bd			
end if	
	
// Se validan las áreas del plan de estudios.
SELECT pe.cve_area_integ_fundamental, pe.cve_area_integ_tema1, pe.cve_area_integ_tema2, pe.cve_area_integ_tema3, pe.cve_area_integ_tema4
INTO :ll_area_fundamental, :ll_area_tema1, :ll_area_tema2, :ll_area_tema3, :ll_area_tema4 
FROM academicos ac, plan_estudios pe 
WHERE ac.cuenta = :a_cuenta 
AND ac.cve_plan = pe.cve_plan
AND ac.cve_carrera = pe.cve_plan 
using gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "!Se produjo un error al recuperar los temas de integración del plan de estudios: " + gtr_sce.SQLERRTEXT) 
	RETURN -1
END IF
IF ISNULL(ll_area_fundamental) THEN ll_area_fundamental = 0
IF ISNULL(ll_area_tema1) THEN ll_area_tema1 = 0
IF ISNULL(ll_area_tema2 ) THEN ll_area_tema2 = 0
IF ISNULL(ll_area_tema3 ) THEN ll_area_tema3 = 0
IF ISNULL(ll_area_tema4 ) THEN ll_area_tema4 = 0

// Si la materia no es de un área de untegración. 
IF ll_area_fundamental <> area AND ll_area_tema1 <> area AND ll_area_tema2 <> area AND ll_area_tema3 <> area AND ll_area_tema4 <> area THEN  return 0

// Si se trata de un área de integración.
IF ll_area_fundamental = area OR ll_area_tema1 = area OR ll_area_tema2 = area OR ll_area_tema3 = area OR ll_area_tema4 = area THEN  
	//Se verifica si el alumno no puede cursar la materia 
	if a_puede_integracion = 0 then return 1
END IF

// Se compaera el área de la materia con cada una de las áreas del plan de estudios.
IF ll_area_fundamental = area THEN 
	IF a_fundamental1 <> 0 THEN 
		RETURN 15 
	ELSE
		IF a_fundamental2 <> 0 THEN 
			RETURN 15 
		END IF				
	END IF
END IF

IF ll_area_tema1 = area THEN 
	if a_tema1  <> 0 then
		return 11
	end if		
END IF

IF ll_area_tema2 = area THEN 
	if a_tema2 <> 0 then 
		return 12
	end if		
END IF	

IF ll_area_tema3 = area THEN 
	if a_tema3 <> 0 then
		return 13
	end if		
END IF	

IF ll_area_tema4 = area THEN 
	if a_tema4 <> 0 then
		return 14
	end if			
END IF	

// Se busca en examen extraordinario. 
SELECT	area_mat.cve_area  
INTO :area  
FROM	area_mat,   
examen_extrao_titulo  
WHERE	( examen_extrao_titulo.cve_mat = area_mat.cve_mat ) and
	( area_mat.cve_area = :area ) AND  
	( examen_extrao_titulo.cuenta = :a_cuenta ) AND
	( examen_extrao_titulo.anio = :a_anio ) AND
	( examen_extrao_titulo.periodo = :a_periodo ) using gtr_sce;
			
// Si no esta en examen extraordinario 
if gtr_sce.sqlcode = 100 then
	// Se verifica si se está cursando la materia. 
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

RETURN 0







// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 

//long area
//
//SELECT area_mat.cve_area  
//	INTO :area  
//   FROM area_mat  
//   WHERE area_mat.cve_mat = :a_cve_mat    using gtr_sce; //Revisión del area de la materia a inscribir
//if gtr_sce.sqlcode = -1 AND gtr_sce.sqldbcode = 0 then gtr_sce.sqlcode = 0
//if gtr_sce.sqlcode = 0 then
//	
//	
//	if area < 2201 or area > 2205 then
//		return 0
//	elseif a_puede_integracion = 0 then //El alumno no puede cursar la materia
//			return 1
//	else
//		choose case area
//			case 2202
//				if a_tema1  <> 0 then
//					return 11
//				end if	
//			case 2203
//				if a_tema2 <> 0 then 
//					return 12
//				end if	
//			case 2204
//				if a_tema3 <> 0 then
//					return 13
//				end if	
//			case 2205
//				if a_tema4 <> 0 then
//					return 14
//				end if	
//			case else		//2201
//				return 100				
//		end choose				 	
//		SELECT	area_mat.cve_area  
//		INTO :area  
//		FROM	area_mat,   
//		examen_extrao_titulo  
//		WHERE	( examen_extrao_titulo.cve_mat = area_mat.cve_mat ) and
//			( area_mat.cve_area = :area ) AND  
//			( examen_extrao_titulo.cuenta = :a_cuenta ) AND
//			( examen_extrao_titulo.anio = :a_anio ) AND
//			( examen_extrao_titulo.periodo = :a_periodo ) using gtr_sce;
//		if gtr_sce.sqlcode = 100 then
//			SELECT	area_mat.cve_area  
//			INTO :area  
//			FROM	area_mat,   
//			mat_inscritas  
//			WHERE	( mat_inscritas.cve_mat = area_mat.cve_mat ) and
//					( area_mat.cve_area = :area ) AND  
//					( mat_inscritas.cuenta = :a_cuenta ) AND
//					( mat_inscritas.anio = :a_anio ) AND
//					( mat_inscritas.periodo = :a_periodo ) AND
//					( mat_inscritas.cve_condicion = 0 )    using gtr_sce;
//			if gtr_sce.sqlcode = -1 AND gtr_sce.sqldbcode = 0 then gtr_sce.sqlcode = 0		
//			if gtr_sce.sqlcode = 100 then
//				return 1000
//			elseif gtr_sce.sqlcode = 0  then
//				return 101
//			else
//				return -1			//error de base de datos						
//			end if
//		elseif gtr_sce.sqlcode = 0  then
//			return 101
//		else
//			return -1			//error de base de datos						
//		end if			
//	end if	
//elseif gtr_sce.sqlcode = 100 then
//		return 0
//else
//		return -1	//error en bd			
//end if

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

on w_examen_extrao_tit_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013_ets" then this.MenuID = create m_menu_general_2013_ets
this.lds_prueba=create lds_prueba
this.lds_revision_est=create lds_revision_est
this.uo_nombre=create uo_nombre
this.uo_anio_periodo=create uo_anio_periodo
this.rb_extraordinario=create rb_extraordinario
this.rb_titulo=create rb_titulo
this.dw_examen_extrao_titulo=create dw_examen_extrao_titulo
this.dw_examen_extrao_titulo_comp=create dw_examen_extrao_titulo_comp
this.dw_revision_est_resumen=create dw_revision_est_resumen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lds_prueba
this.Control[iCurrent+2]=this.lds_revision_est
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.uo_anio_periodo
this.Control[iCurrent+5]=this.rb_extraordinario
this.Control[iCurrent+6]=this.rb_titulo
this.Control[iCurrent+7]=this.dw_examen_extrao_titulo
this.Control[iCurrent+8]=this.dw_examen_extrao_titulo_comp
this.Control[iCurrent+9]=this.dw_revision_est_resumen
end on

on w_examen_extrao_tit_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lds_prueba)
destroy(this.lds_revision_est)
destroy(this.uo_nombre)
destroy(this.uo_anio_periodo)
destroy(this.rb_extraordinario)
destroy(this.rb_titulo)
destroy(this.dw_examen_extrao_titulo)
destroy(this.dw_examen_extrao_titulo_comp)
destroy(this.dw_revision_est_resumen)
end on

event open;call super::open;m_menu_general_2013_ets.m_archivo.m_salvar.visible = false
m_menu_general_2013_ets.m_archivo.m_salvar.toolbaritemvisible = false
m_menu_general_2013_ets.m_archivo.m_leer.visible = false
m_menu_general_2013_ets.m_archivo.m_leer.toolbaritemvisible = false
m_menu_general_2013_ets.m_archivo.m_imprimir.enabled = true

wf_conecta()

dw_revision_est_resumen.Settransobject(gtr_sce)
dw_examen_extrao_titulo.Settransobject(gtr_sce)
dw_examen_extrao_titulo_comp.Settransobject(gtr_sce)
uo_nombre.dw_nombre_alumno.settransobject(gtr_sce)

ii_tipo = 2




end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;long li_valida_historia_acad,li_baja_laboratorio,li_baja_disciplina,li_baja_3_reprob,li_baja_4_insc
string ls_desc_nivel
int li_res

dwItemStatus l_status

l_status = idw_trabajo.GetItemStatus(1, 0, Primary!)

IF ie_error_validacion = 0 THEN 
	if l_status <> NotModified!	then
		if idw_trabajo.rowcount() > 0 then
			if messagebox('Aviso','¿Desea guardar los cambios del alumno '+ string(il_cuenta) +' ?',Question!,Yesno!) = 1 then
				ii_sw = 1
				 triggerevent("ue_actualiza")
			end if
		END IF
	end if
END IF

il_cuenta = long(uo_nombre.of_obten_cuenta())

il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan
il_sub = uo_nombre.istr_carrera.str_cve_subsist
is_nivel = uo_nombre.istr_carrera.str_nivel

if il_carrera = 0 then return

li_res = llenabanderas(il_cuenta,ii_banderasalumno)
if li_res = 1 then
	dw_revision_est_resumen.reset()
	dw_examen_extrao_titulo_comp.reset()
	li_res = estainscrito(il_cuenta,gi_periodo,gi_anio)
	if (ii_tipo = 2 AND li_res = 0) then
		li_res = MessageBox("Aviso", "Para un examen extraordinario es necesario estar inscrito en este periodo escolar, ¿es la última materia del alumno?",Question!, YesNo!,2)
		if li_res = 2 then li_res = 0
	end if
	li_baja_laboratorio = f_obten_baja_laboratorio(il_cuenta)
	li_baja_disciplina = f_obten_baja_disciplina(il_cuenta)
	li_baja_3_reprob = f_obten_baja_3_reprob(il_cuenta)
	li_baja_4_insc = f_obten_baja_4_insc(il_cuenta)
	if li_baja_laboratorio = 1 then
		MessageBox("Aviso","El alumno tiene adeudos de material de laboratorio",StopSign!)
		wf_limpiar()
		Return
	elseif li_baja_laboratorio = -1 then
		MessageBox("Error","No es posible consultar la baja por laboratorio",StopSign!)
		wf_limpiar()
		Return
	end if
	if li_baja_disciplina = 1 then
		MessageBox("Aviso","El alumno esta dado de baja por disciplina",StopSign!)
		wf_limpiar()
		Return
	elseif li_baja_disciplina = -1 then
		MessageBox("Error","No es posible consultar la baja por disciplina",StopSign!)
		wf_limpiar()
		Return
	end if
	if li_baja_3_reprob = 1 then
		MessageBox("Aviso","El alumno esta dado de baja por 3 Reprobadas",StopSign!)
		wf_limpiar()
		Return
	elseif li_baja_3_reprob = -1 then
		MessageBox("Error","No es posible consultar la baja por 3 Reprobadas",StopSign!)
		wf_limpiar()
		Return
	end if
	if li_baja_4_insc = 1 then
		MessageBox("Aviso","El alumno esta dado de baja por 4 Inscripciones",StopSign!)
		wf_limpiar()
		Return
	elseif li_baja_4_insc = -1 then
		MessageBox("Error","No es posible consultar la baja por 4 Inscripciones",StopSign!)
		wf_limpiar()
		Return
	end if
	if ((ii_tipo = 2 AND li_res = 1) OR (ii_tipo = 6 AND li_res = 0)) then
		if (ii_banderasalumno[b_bdo] = 0) then
			desconecta_bd(gtr_scob);
			if (conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password)=1) then
				li_res = tiene_adeudos(il_cuenta,gtr_scob)
				desconecta_bd(gtr_scob)
				if (li_res = 1) then
					MessageBox("Aviso","El alumno tiene adeudos en finanzas y por lo tanto no puede inscribirse",Exclamation!)
					wf_limpiar()
					Return
				elseif (li_res = -1) then
					Messagebox("Error","Error con la consulta de Base Datos Finanzas. Favor de intentar nuevamente",None!)
					wf_limpiar()
					Return
				end if
			else
				Messagebox("Error","Error en la conexión de Base Datos Finanzas.",None!)
				wf_limpiar()
				Return
			end if
		else
			MessageBox("Aviso","El alumno debe documentos y por lo tanto no puede inscribirse",Exclamation!)
			wf_limpiar()
			Return
		end if
	elseif ii_tipo = 2 then
		MessageBox("Aviso","Para presentar un examen extraordinario es necesario que el alumno este inscrito en este periodo escolar",Exclamation!)
		wf_limpiar()
		Return
	elseif ii_tipo = 6 then
		MessageBox("Aviso","Para presentar un examen a titulo de suficiencia es necesario que el alumno no este inscrito en este periodo escolar",Exclamation!)
		wf_limpiar()
		Return
	end if
	dw_examen_extrao_titulo.retrieve(il_cuenta,gi_anio,gi_periodo,ii_tipo)
	dw_examen_extrao_titulo_comp.retrieve(il_cuenta,gi_anio,gi_periodo,ii_tipo)
else
	Messagebox("Error","Error con la consulta de Base Datos Bloqueos. Favor de intentar nuevamente",None!)
	wf_limpiar()
	Return
end if

wf_genera_rev_est()
ie_error_validacion = 0 
end event

event ue_actualiza;call super::ue_actualiza;int li_res

if il_cuenta = 0 then return
li_res = wf_validar ()
if li_res = -1 then
	ie_error_validacion = 1 
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	if ii_sw = 0 then
		triggerevent(doubleclicked!)
	end if
	return
end if

Setpointer(Hourglass!)

IF idw_trabajo.Update(True,True) = 1 Then
	Commit using gtr_sce;
	messagebox("Información","Se han guardado los cambios")		
Else
	Rollback using gtr_sce;
	Messagebox("Algunos datos son incorrectos","Los cambios no fueron guardados")
End if		

ii_sw = 0
end event

event ue_borra;call super::ue_borra;idw_trabajo.deleterow(idw_trabajo.Getrow())
end event

event ue_nuevo;call super::ue_nuevo;long ll_ren
		
ll_ren = idw_trabajo.Insertrow(0)
idw_trabajo.setitem(ll_ren,"examen_extrao_titulo_gpo","A")
idw_trabajo.setitem(ll_ren,"examen_extrao_titulo_cuenta",il_cuenta)
idw_trabajo.setitem(ll_ren,"examen_extrao_titulo_anio",gi_anio)
idw_trabajo.setitem(ll_ren,"examen_extrao_titulo_periodo",gi_periodo)
idw_trabajo.setitem(ll_ren,"examen_extrao_titulo_tipo_examen",ii_tipo)
end event

event close;call super::close;if ii_chk = 1 then wf_desconecta()

f_obten_titulo(w_principal)
w_principal.visible = true
end event

type st_sistema from w_master_main`st_sistema within w_examen_extrao_tit_2013
integer x = 722
end type

type p_ibero from w_master_main`p_ibero within w_examen_extrao_tit_2013
integer x = 23
integer y = 16
end type

type lds_prueba from datawindow within w_examen_extrao_tit_2013
boolean visible = false
integer x = 2391
integer y = 1692
integer width = 494
integer height = 68
string dataobject = "dw_certificado_ext2"
boolean livescroll = true
end type

type lds_revision_est from datawindow within w_examen_extrao_tit_2013
boolean visible = false
integer x = 1874
integer y = 1692
integer width = 489
integer height = 76
string dataobject = "dw_rev_est_fmc"
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_nombre from uo_carreras_alumno_lista within w_examen_extrao_tit_2013
event destroy ( )
integer x = 27
integer y = 296
integer width = 3241
integer height = 516
integer taborder = 10
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_menu_general_2013_ets.objeto = this
end event

type uo_anio_periodo from uo_per_ani within w_examen_extrao_tit_2013
event destroy ( )
integer x = 1751
integer y = 824
integer width = 1253
integer height = 168
integer taborder = 20
boolean bringtotop = true
boolean enabled = true
long backcolor = 1090519039
end type

on uo_anio_periodo.destroy
call uo_per_ani::destroy
end on

event constructor;call super::constructor;Integer li_periodo, li_anio

periodo_actual_mat_insc_2013(li_periodo, li_anio, gtr_sce)

if li_periodo<> gi_periodo or li_anio<>gi_anio then
	MessageBox("Aviso","El periodo seleccionado no corresponde al de las materias inscritas",StopSign!)
	return -1
else
	gi_periodo = li_periodo
	gi_anio = li_anio
end if

end event

type rb_extraordinario from radiobutton within w_examen_extrao_tit_2013
integer x = 3026
integer y = 824
integer width = 485
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Extraordinario"
boolean checked = true
end type

event clicked;ii_tipo = 2
parent.triggerevent("doubleclicked")

end event

type rb_titulo from radiobutton within w_examen_extrao_tit_2013
integer x = 3026
integer y = 908
integer width = 485
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Titulo de Suf"
end type

event clicked;ii_tipo = 6
parent.triggerevent("doubleclicked")

end event

type dw_examen_extrao_titulo from uo_master_dw within w_examen_extrao_tit_2013
integer x = 1755
integer y = 1008
integer width = 1966
integer height = 1152
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_examen_extrao_titulo_2013"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;idw_trabajo = this

end event

event itemchanged;call super::itemchanged;long ll_cve_mat
string ls_mat
int li_hrs,li_res
decimal ldc_crd

if dwo.name = 'examen_extrao_titulo_cve_mat' then
	ll_cve_mat = long(data)
	if ll_cve_mat > 0 then
		li_res = existemateria(ll_cve_mat,ls_mat,ldc_crd,li_hrs)
		choose case li_res
			case 1
				setitem(row,"materias_materia",ls_mat)  //Si existe, despliega el nombre y los creditos y las horas
				setitem(row,"materias_creditos",ldc_crd)
			case 0
				MessageBox("Aviso","La materia "+ string(ll_cve_mat)+ " no existe",Exclamation!)
				return -1
			case -1
				Messagebox("Error ","Error con la consulta de Base Datos ExisteMateria. Favor de intentar nuevamente",Exclamation!)
				return -1
		end choose
	end if
end if


// Se agrega llamado a función de validación desde el momento de capturar la materia.
if ll_cve_mat > 0 then
	li_res = wf_validar ()
	if li_res = -1 then
		ie_error_validacion = 1 
//		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
//		if ii_sw = 0 then
//			triggerevent(doubleclicked!)
//		end if
		return -1
	end if
END IF


end event

event rbuttondown;return 0 


end event

event rbuttonup;return 0
end event

type dw_examen_extrao_titulo_comp from uo_master_dw within w_examen_extrao_tit_2013
event carga ( )
boolean visible = false
integer x = 5
integer y = 2192
integer width = 1966
integer height = 196
integer taborder = 0
boolean bringtotop = true
string dataobject = "d_examen_extrao_titulo_comp"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event carga();Retrieve(il_cuenta,gi_anio,gi_periodo,ii_tipo)


end event

event constructor;call super::constructor;m_menu_general_2013_ets.dw = this
end event

type dw_revision_est_resumen from uo_master_dw within w_examen_extrao_tit_2013
integer x = 37
integer y = 828
integer width = 1696
integer height = 1472
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_composite_examen_extrao_tit_2013"
boolean hscrollbar = false
boolean vscrollbar = false
boolean border = true
boolean livescroll = false
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;dw_revision_est_resumen.Modify("DataWindow.Print.Preview.outline = 'No'")
end event

