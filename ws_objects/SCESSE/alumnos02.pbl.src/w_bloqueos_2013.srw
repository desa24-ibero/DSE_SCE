$PBExportHeader$w_bloqueos_2013.srw
forward
global type w_bloqueos_2013 from w_master_main
end type
type st_replica from statictext within w_bloqueos_2013
end type
type dw_bloqueos from uo_master_dw within w_bloqueos_2013
end type
type uo_nombre from uo_nombre_alumno_2013 within w_bloqueos_2013
end type
end forward

global type w_bloqueos_2013 from w_master_main
integer width = 3557
integer height = 2376
string title = "Bloqueos"
string menuname = "m_bloqueos_2013"
st_replica st_replica
dw_bloqueos dw_bloqueos
uo_nombre uo_nombre
end type
global w_bloqueos_2013 w_bloqueos_2013

type variables
datawindowchild idwc_cp
end variables

forward prototypes
public function integer wf_validar ()
public function integer wf_cred_p_periodo (integer periodo, integer cred)
public function integer wf_revisa_puntaje (long cta, long carrera, integer plan)
end prototypes

public function integer wf_validar ();long ll_cuenta,ll_res

ll_cuenta = long(uo_nombre.of_obten_cuenta())

 dw_bloqueos.setitem(dw_bloqueos.getrow(),"cuenta",ll_cuenta)
 
  SELECT alumnos.cuenta  
    INTO :ll_res  
    FROM alumnos  
   WHERE alumnos.cuenta = :ll_cuenta   using gtr_sce;
if gtr_sce.sqlcode = 100 then 
	messagebox("Información","El alumno con numero de cuenta "+string(ll_cuenta)+" no esta dado de alta.~rDebe darse de alta desde la ventana de datos generales",stopsign!)
	rollback using gtr_sce;
	return -1
end if

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

on w_bloqueos_2013.create
int iCurrent
call super::create
if this.MenuName = "m_bloqueos_2013" then this.MenuID = create m_bloqueos_2013
this.st_replica=create st_replica
this.dw_bloqueos=create dw_bloqueos
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_replica
this.Control[iCurrent+2]=this.dw_bloqueos
this.Control[iCurrent+3]=this.uo_nombre
end on

on w_bloqueos_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_bloqueos)
destroy(this.uo_nombre)
end on

event open;call super::open;dw_bloqueos.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;if dw_bloqueos.retrieve(long(uo_nombre.of_obten_cuenta())) = 0 then
	dw_bloqueos.insertrow(0)
end if
end event

event ue_actualiza;call super::ue_actualiza;long ll_cuenta, ll_cuenta1
string nombre,apaterno,amaterno
string nombre1,apaterno1,amaterno1
int RenglonNac, RenglonNombre, li_res,li_replica_activa

uo_nombre.em_cuenta.enabled = true
ll_cuenta = long(uo_nombre.of_obten_cuenta())

if dw_bloqueos.Rowcount() > 0 then
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if
	dw_bloqueos.setitem(dw_bloqueos.getrow(),"cuenta",ll_cuenta)
end if

if dw_bloqueos.update(true) > 0 then
	commit using gtr_sce;
		
	//INICIO:Replica a Internet
	li_replica_activa = f_replica_Activa()
	if li_replica_activa = 1 then
		f_replica_internet(this,ll_cuenta)
		st_replica.text = 'A'
		st_replica.BackColor =RGB(0,255,0)
	else
		st_replica.text = 'I'
		st_replica.BackColor =RGB(255,0,0)
	end if
	//FIN:Replica a Internet				
				
	messagebox("Información","Se han guardado los cambios")				
	triggerevent(doubleclicked!)
else
	rollback using gtr_sce;					
	messagebox("Información","No se han guardado los cambios")	
	return
end if
end event

event ue_borra;call super::ue_borra;string cuenta
int respuesta,cont

cuenta = uo_nombre.em_cuenta.text
respuesta = messagebox("Atención","Esta seguro de querer borrar los bloqueos~r del alumno "+cuenta+ ".",StopSign!,YesNo!,2)

if respuesta = 1 then
	if dw_bloqueos.deleterow(dw_bloqueos.getrow())	= 1 then
		triggerevent('ue_actualiza')			   
	else
		messagebox("Información","No se han guardado los cambios")	
		triggerevent(doubleclicked!)
		return
	end if
elseif respuesta = 2 then
	rollback using gtr_sce;
end if
end event

event ue_nuevo;call super::ue_nuevo;long ll_cuenta,ll_res
int cont 

ll_cuenta = long(uo_nombre.of_obten_cuenta())

  SELECT banderas.cuenta  
    INTO :ll_res  
    FROM banderas  
   WHERE banderas.cuenta = :ll_cuenta   using gtr_sce;

if gtr_sce.sqlcode = 100 then
   if	dw_bloqueos.rowcount() = 1 then
		dw_bloqueos.setitem(dw_bloqueos.getrow(),"cuenta",ll_cuenta)
	elseif dw_bloqueos.rowcount() > 1 then 
		for cont = 2 to dw_bloqueos.rowcount()
			dw_bloqueos.deleterow(cont)
		next
		dw_bloqueos.setitem(dw_bloqueos.getrow(),"cuenta",ll_cuenta)
	else
		dw_bloqueos.insertrow(0)
		dw_bloqueos.setitem(dw_bloqueos.getrow(),"cuenta",ll_cuenta)
	end if
end if
end event

event activate;control_escolar.toolbarsheettitle="Bloqueos"
end event

type st_sistema from w_master_main`st_sistema within w_bloqueos_2013
end type

type p_ibero from w_master_main`p_ibero within w_bloqueos_2013
end type

type st_replica from statictext within w_bloqueos_2013
integer x = 3287
integer y = 312
integer width = 110
integer height = 88
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;integer li_replica_activa

li_replica_activa = f_replica_Activa()

if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type dw_bloqueos from uo_master_dw within w_bloqueos_2013
integer x = 18
integer y = 644
integer width = 3392
integer height = 1208
integer taborder = 40
string dataobject = "dw_bloqueos_2013"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event itemchanged;call super::itemchanged;//Se revisa si se modifica el campo de extension de creditos. Para efectuar las validaciones necesarias
//Marzo 1998 DkWf CAMP
//
int carrera,plan,cred_cursados
decimal cred_en_curso, cred_carrera
string periodo
long ll_cuenta
//
ll_cuenta = long(uo_nombre.of_obten_cuenta())
if dwo.name = "exten_cred" and data <> '0'  then
	if obten_carrera_plan(ll_cuenta,carrera,plan) = 0 then
		cred_carrera	=	revisa_total_cred(carrera,plan)
		if	cred_carrera	>=		0 then
			cred_cursados	=	revisa_creditos_cursados(ll_cuenta,carrera,plan)
			if	cred_cursados	>=		0	then
				cred_en_curso	=	revisa_cred_en_curso(ll_cuenta)
				if	cred_en_curso	>=	0	then
					if cred_carrera <= cred_cursados + cred_en_curso + 80 then//Se autoriza la extension de creditos si el numero 
					  /*de creditos cursados  más los creditos que cursa en este semestre más 80 es igual al total de creditos de su carrera o mayor*/
						if	wf_revisa_puntaje(ll_cuenta,carrera,plan) = 1 then//revisa si el alumno tiene 1 punto arriba del puntaje de calidad
							if	wf_cred_p_periodo(g_per,integer(data)) =  1 then//revisa si el periodo permite la cantidad solicitada de creditos
								if f_obten_cve_subsistema(ll_cuenta,carrera,plan)>0 then //Revisa si tiene cargado el subsistema
									if f_curso_prerreq_ingles(ll_cuenta,carrera,plan) then //Revisa si se cursó el prerrequisito de inglés
										messagebox("EXTENSIÓN AUTORIZADA","Se autoriza que el alumno con cuenta "+string(long(uo_nombre.em_cuenta.text))+" reciba una extensión de creditos.",Stopsign!) 
								  		return 0
									else
										messagebox("NO se AUTORIZA la EXTENSIÓN de creditos","El alumno no ha aprobado el prerrequisto de Inglés",Stopsign!)
										open(w_password-autorizado_2013)
										if Message.DoubleParm = 26 then
											messagebox("EXTENSIÓN AUTORIZADA","Se autoriza que el alumno con cuenta "+string(long(uo_nombre.em_cuenta.text))+" reciba una extensión de creditos.",Stopsign!)
											return 0
										else
											messagebox("Extensión NO Autorizada","Se requiere el password para autorizar la extensión en casos especiales.",Stopsign!)
											object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
											return 1
										end if
										object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
										return 1										
									
									end if
								else
									messagebox("NO se AUTORIZA la EXTENSIÓN de creditos","El alumno no tiene cargado el subsistema",Stopsign!)
									open(w_password-autorizado_2013)
									if Message.DoubleParm = 26 then
										messagebox("EXTENSIÓN AUTORIZADA","Se autoriza que el alumno con cuenta "+string(long(uo_nombre.em_cuenta.text))+" reciba una extensión de creditos.",Stopsign!)
										return 0
									else
										messagebox("Extensión NO Autorizada","Se requiere el password para autorizar la extensión en casos especiales.",Stopsign!)
										object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
										return 1
									end if
									object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
									return 1										
								end if
							else
								messagebox("NO se AUTORIZA la EXTENSIÓN de creditos","En este periodo no se permiten tales créditos",Stopsign!)
								open(w_password-autorizado_2013)
								if Message.DoubleParm = 26 then
									messagebox("EXTENSIÓN AUTORIZADA","Se autoriza que el alumno con cuenta "+string(long(uo_nombre.em_cuenta.text))+" reciba una extensión de creditos.",Stopsign!)
									return 0
								else
									messagebox("Extensión NO Autorizada","Se requiere el password para autorizar la extensión en casos especiales.",Stopsign!)
									object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
									return 1
								end if
								object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
								return 1	
							end if
						else
							messagebox("NO se AUTORIZA la EXTENSIÓN de creditos","El alumno requiere tener por lo menos 1 PUNTO arriba del PUNTAJE DE CALIDAD.",Stopsign!)
							open(w_password-autorizado_2013)
							if Message.DoubleParm = 26 then
								messagebox("EXTENSIÓN AUTORIZADA","Se autoriza que el alumno con cuenta "+string(long(uo_nombre.em_cuenta.text))+" reciba una extensión de creditos.",Stopsign!)
								return 0
							else
								messagebox("Extensión NO Autorizada","Se requiere el password para autorizar la extensión en casos especiales.",Stopsign!)
								object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
								return 1
							end if
							object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
							return 1	
						end if
					else
						messagebox("NO se AUTORIZA la EXTENSIÓN de creditos","El alumno requiere "+string(cred_carrera - (cred_cursados + cred_en_curso))+" CREDITOS para terminar. No se puede autorizar el credito si faltan mas de 80",Stopsign!)
						open(w_password-autorizado_2013)
						if Message.DoubleParm = 26 then
							messagebox("EXTENSIÓN AUTORIZADA","Se autoriza que el alumno con cuenta "+string(long(uo_nombre.em_cuenta.text))+" reciba una extensión de creditos.",Stopsign!)
							return 0
						else
							messagebox("Extensión NO Autorizada","Se requiere el password para autorizar la extensión en casos especiales.",Stopsign!)
							object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
							return 1
						end if
						object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
						return 1
					end if
				else
					object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
					return 1
				end if
			else
				object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
				return 1
			end if
		else
			object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
			return 1
		end if
	else
		object.exten_cred[row]	=	this.GetItemNumber(row,"exten_cred",Primary!,TRUE)
		return 1
	end if
end if
	
end event

event constructor;call super::constructor;idw_trabajo = this
m_bloqueos_2013.dw = this
end event

event itemerror;call super::itemerror;return 1
end event

type uo_nombre from uo_nombre_alumno_2013 within w_bloqueos_2013
integer x = 27
integer y = 308
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;m_bloqueos_2013.objeto = this
end event

