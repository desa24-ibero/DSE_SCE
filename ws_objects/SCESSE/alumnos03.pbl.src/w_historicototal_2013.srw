$PBExportHeader$w_historicototal_2013.srw
forward
global type w_historicototal_2013 from w_master_main
end type
type dw_historicototal from uo_master_dw within w_historicototal_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_historicototal_2013
end type
end forward

global type w_historicototal_2013 from w_master_main
integer width = 3474
integer height = 2668
string title = "Consulta Total Historico"
string menuname = "m_menu_general_2013"
dw_historicototal dw_historicototal
uo_nombre uo_nombre
end type
global w_historicototal_2013 w_historicototal_2013

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

on w_historicototal_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.dw_historicototal=create dw_historicototal
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_historicototal
this.Control[iCurrent+2]=this.uo_nombre
end on

on w_historicototal_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_historicototal)
destroy(this.uo_nombre)
end on

event open;call super::open;m_menu_general_2013.m_registro.m_nuevo.enabled = False
m_menu_general_2013.m_registro.m_actualiza.enabled = False
m_menu_general_2013.m_registro.m_borraregistro.enabled = False



dw_historicototal.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)



m_menu_general_2013.m_registro.m_filtrar.visible = TRUE
m_menu_general_2013.m_registro.m_ordenar.visible = TRUE
m_menu_general_2013.m_registro.m_filtrar.enabled = TRUE
m_menu_general_2013.m_registro.m_ordenar.enabled = TRUE
m_menu_general_2013.m_registro.m_filtrar.toolbaritemvisible = TRUE
m_menu_general_2013.m_registro.m_ordenar.toolbaritemvisible = TRUE
m_menu_general_2013.m_archivo.m_imprimir.enabled = TRUE
end event

event closequery;//
end event

event activate;control_escolar.toolbarsheettitle="Consulta Total Historico"



end event

event ue_inicia_proceso;call super::ue_inicia_proceso;long ll_row, ll_cuenta

//ll_row = uo_nombre.dw_nombre_alumno.GetRow()
//ll_cuenta = uo_nombre.dw_nombre_alumno.GetItemNumber(ll_row, "cuenta")
//
if f_alumno_restringido (ll_cuenta) then
	if f_usuario_especial(gs_usuario) then
		MessageBox("Usuario  Autorizado", &
		"Alumno con acceso restringido",Information!)		
	else
		MessageBox("Usuario NO Autorizado", &
	           "Alumno con acceso restringido, por favor consulte a la ~n"+ &
				 +"Dirección de Servicios Escolares",StopSign!)
//		uo_nombre.dw_nombre_alumno.Reset()	
//		uo_nombre.dw_nombre_alumno.insertrow(0)
		uo_nombre.em_digito.text=" "
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_cuenta.setfocus()

		return		
	end if
end if

if dw_historicototal.Retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
  MessageBox("Aviso","No se encontró información con esta cuenta")
end if  
end event

type st_sistema from w_master_main`st_sistema within w_historicototal_2013
end type

type p_ibero from w_master_main`p_ibero within w_historicototal_2013
end type

type dw_historicototal from uo_master_dw within w_historicototal_2013
integer x = 27
integer y = 640
integer width = 3360
integer height = 1796
integer taborder = 40
string dataobject = "d_historicototal_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this
end event

type uo_nombre from uo_nombre_alumno_2013 within w_historicototal_2013
integer x = 27
integer y = 308
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

