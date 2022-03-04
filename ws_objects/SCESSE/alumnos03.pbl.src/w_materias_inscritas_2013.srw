$PBExportHeader$w_materias_inscritas_2013.srw
forward
global type w_materias_inscritas_2013 from w_master_main
end type
type dw_mat_insc from uo_master_dw within w_materias_inscritas_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_materias_inscritas_2013
end type
type dw_imprime_materias_inscritas from uo_master_dw within w_materias_inscritas_2013
end type
type dw_periodo_mat_inscritas from uo_master_dw within w_materias_inscritas_2013
end type
end forward

global type w_materias_inscritas_2013 from w_master_main
integer width = 4549
integer height = 2668
string title = "Materias inscritas y horario"
string menuname = "m_menu_general_base_2013"
dw_mat_insc dw_mat_insc
uo_nombre uo_nombre
dw_imprime_materias_inscritas dw_imprime_materias_inscritas
dw_periodo_mat_inscritas dw_periodo_mat_inscritas
end type
global w_materias_inscritas_2013 w_materias_inscritas_2013

type variables
datawindowchild idwc_cp
end variables

forward prototypes
public function integer wf_validar ()
public function integer wf_cred_p_periodo (integer periodo, integer cred)
public function integer wf_revisa_puntaje (long cta, long carrera, integer plan)
end prototypes

public function integer wf_validar ();//long ll_cuenta,ll_res
//
//ll_cuenta = long(uo_nombre.of_obten_cuenta())
//
// dw_bloqueos.setitem(dw_bloqueos.getrow(),"cuenta",ll_cuenta)
// 
//  SELECT alumnos.cuenta  
//    INTO :ll_res  
//    FROM alumnos  
//   WHERE alumnos.cuenta = :ll_cuenta   using gtr_sce;
//if gtr_sce.sqlcode = 100 then 
//	messagebox("Información","El alumno con numero de cuenta "+string(ll_cuenta)+" no esta dado de alta.~rDebe darse de alta desde la ventana de datos generales",stopsign!)
//	rollback using gtr_sce;
//	return -1
//end if

return 1
end function

public function integer wf_cred_p_periodo (integer periodo, integer cred);//Función que revisa si se pueden cursar %cred% numero de creditos en el semestre
//%periodo% Regresa 1 si se puede y 0 en caso contrario
//Abril 1998 CAMP DkWf
int per
per = periodo+1
if per = 3 then
	per = 0
end if
if per =	0 or per	=2	then
	if cred <= 64 then
		return 1
	else
		messagebox("NO se extiende más de 64","NO se puede CONCEDER una extensión MAYOR a 64 creditos",stopsign!)
		return 0
	end if
else
	if cred <= 24 then
		return 1
	else
				messagebox("NO se extiende más de 24","NO se puede CONCEDER una extensión MAYOR a 24 creditos",stopsign!)
		return 0
	end if
end if
end function

public function integer wf_revisa_puntaje (long cta, long carrera, integer plan);//Función que revisa si el alumno cumple con un minimo de 1 punto arriba del puntaje de calidad
//Regresa un 1 si cumple y 0 en caso contrario
//Abril 1998 CAMP	DkWf
real punt_min,punt_alumno
decimal creditos

//DECLARE promedio procedure for calcula_promedio
//@cuenta	=	:cta,
//@cve_carr	=	:carrera,
//@plan	=	:plan,
//@promedio	=	:punt_alumno,
//@creditos	=	:creditos,
//  
  SELECT plan_estudios.puntaje_min  
    INTO :punt_min
    FROM plan_estudios  
   WHERE ( plan_estudios.cve_carrera = :carrera ) AND  
         ( plan_estudios.cve_plan = :plan )    using gtr_sce;
			
if gtr_sce.sqlcode = 0 then
	commit using gtr_sce;
	if cred_prom(cta,creditos,punt_alumno) = 1 then
		if punt_alumno >= punt_min + 1 then
			return 1			
		else
				messagebox("El PUNTAJE del alumno NO CUMPLE","El puntaje minimo es "+string(punt_min)+".~rEl puntaje del alumno con cuenta "+&
				string(cta)+ " es "+string(punt_alumno)+".~rSe requiere al menos un punto sobre el puntaje de calidad para tener extensión de creditos.",stopsign!)
			return 0
		end if
	else
		messagebox("ERROR",gtr_sce.sqlerrtext,stopsign!)
		return 0
	end if
else
	commit using gtr_sce;
	messagebox("ERROR",gtr_sce.sqlerrtext,stopsign!)
	return 0
end if
end function

on w_materias_inscritas_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_base_2013" then this.MenuID = create m_menu_general_base_2013
this.dw_mat_insc=create dw_mat_insc
this.uo_nombre=create uo_nombre
this.dw_imprime_materias_inscritas=create dw_imprime_materias_inscritas
this.dw_periodo_mat_inscritas=create dw_periodo_mat_inscritas
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mat_insc
this.Control[iCurrent+2]=this.uo_nombre
this.Control[iCurrent+3]=this.dw_imprime_materias_inscritas
this.Control[iCurrent+4]=this.dw_periodo_mat_inscritas
end on

on w_materias_inscritas_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_mat_insc)
destroy(this.uo_nombre)
destroy(this.dw_imprime_materias_inscritas)
destroy(this.dw_periodo_mat_inscritas)
end on

event open;call super::open;dw_mat_insc.settransobject(gtr_sce)
dw_imprime_materias_inscritas.settransobject(gtr_sce)
dw_periodo_mat_inscritas.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

event closequery;//
end event

event activate;control_escolar.toolbarsheettitle="Materias Inscritas y Horario"
end event

event doubleclicked;call super::doubleclicked;// Juan campos. Enero-1997.

//Integer 	Periodo = 0,Año = 0
//Periodo_Actual(Periodo,Año,sqlca)

long ll_row, ll_cuenta
int  li_baja_laboratorio, li_baja_disciplina
boolean lb_permite_consulta = true
String ls_desc_periodo

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

ll_cuenta = long(uo_nombre.of_obten_cuenta())

if ll_cuenta = 0 then return

if f_alumno_restringido (ll_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()

		return		
	end if
end if

li_baja_laboratorio = f_obten_baja_laboratorio(ll_cuenta)
li_baja_disciplina = f_obten_baja_disciplina(ll_cuenta)
if li_baja_laboratorio = 1 then
	MessageBox("Aviso","El alumno tiene adeudos de material de laboratorio",StopSign!)
	lb_permite_consulta = false			
elseif li_baja_laboratorio = -1 then
	MessageBox("Aviso","No es posible consultar la baja por laboratorio",StopSign!)
	lb_permite_consulta = false			
end if
if li_baja_disciplina = 1 then
	MessageBox("Aviso","El alumno esta dado de baja por disciplina",StopSign!)
	lb_permite_consulta = false			
elseif li_baja_disciplina = -1 then
	MessageBox("Aviso","No es posible consultar la baja por disciplina",StopSign!)
	lb_permite_consulta = false			
end if

IF NOT lb_permite_consulta THEN
		uo_nombre.dw_nombre_alumno.Reset()	
		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()	
		return
END IF

//**--**--**--**--**
DataWindowChild dwc_condicion_insc 
dw_mat_insc.GetChild('mat_inscritas_cve_condicion', dwc_condicion_insc)
dwc_condicion_insc.settransobject(gtr_sce) 
dwc_condicion_insc.RETRIEVE()
//**--**--**--**--**

if dw_mat_insc.Retrieve(ll_cuenta) = 0 then 
	// MALH 31/08/2017 Cambio para Chalco
	// Se agrega el llamado a la funcion f_obten_desc_tipo_msg
	ls_desc_periodo = luo_periodo_tipo_servicios.f_obten_desc_periodo_msg(gs_tipo_periodo) 
	
	IF luo_periodo_tipo_servicios.i_error = -1 THEN
		MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
		RETURN luo_periodo_tipo_servicios.i_error
	END IF

	MessageBox("Aviso","No tiene materias inscritas este " + Lower(ls_desc_periodo))
	
// MALH 31/08/2017 Cambio para Chalco
//	if gs_tipo_periodo='S' then
//		MessageBox("Aviso","No tiene materias inscritas este semestre")
//	else
//		MessageBox("Aviso","No tiene materias inscritas este trimestre")
//	end if
end if  

dw_periodo_mat_inscritas.Retrieve(gs_tipo_periodo)
dw_imprime_materias_inscritas.Retrieve(ll_cuenta)
end event

type st_sistema from w_master_main`st_sistema within w_materias_inscritas_2013
end type

type p_ibero from w_master_main`p_ibero within w_materias_inscritas_2013
end type

type dw_mat_insc from uo_master_dw within w_materias_inscritas_2013
integer x = 27
integer y = 640
integer width = 4393
integer height = 1788
integer taborder = 40
string dataobject = "dw_mat_insc_2013"
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_base_2013.dw = this
end event

event ue_imprimir_dw;openwithparm(conf_impr,dw_imprime_materias_inscritas)
end event

type uo_nombre from uo_nombre_alumno_2013 within w_materias_inscritas_2013
integer x = 27
integer y = 308
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_general_base_2013.objeto = this
end event

type dw_imprime_materias_inscritas from uo_master_dw within w_materias_inscritas_2013
boolean visible = false
integer x = 32
integer y = 1964
integer width = 864
integer height = 360
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_imprime_materias_inscritas_2013"
boolean hscrollbar = false
boolean resizable = true
end type

type dw_periodo_mat_inscritas from uo_master_dw within w_materias_inscritas_2013
integer x = 3273
integer y = 408
integer width = 891
integer height = 88
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_periodo_mat_inscritas_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

