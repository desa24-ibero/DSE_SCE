$PBExportHeader$w_bloqueos.srw
$PBExportComments$Despliegue de bloqueos de un alumno
forward
global type w_bloqueos from window
end type
type st_replica from statictext within w_bloqueos
end type
type dw_bloqueos from datawindow within w_bloqueos
end type
type uo_nombre from uo_nombre_alumno within w_bloqueos
end type
end forward

global type w_bloqueos from window
integer x = 5
integer y = 4
integer width = 3712
integer height = 2412
boolean titlebar = true
string title = "Bloqueos"
string menuname = "m_bloqueos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
st_replica st_replica
dw_bloqueos dw_bloqueos
uo_nombre uo_nombre
end type
global w_bloqueos w_bloqueos

forward prototypes
public function integer revisa_puntaje (long cta, long carrera, integer plan)
public function integer cred_p_periodo (integer periodo, integer cred)
end prototypes

public function integer revisa_puntaje (long cta, long carrera, integer plan);//Función que revisa si el alumno cumple con un minimo de 1 punto arriba del puntaje de calidad
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

public function integer cred_p_periodo (integer periodo, integer cred);//Función que revisa si se pueden cursar %cred% numero de creditos en el semestre
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

on w_bloqueos.create
if this.MenuName = "m_bloqueos" then this.MenuID = create m_bloqueos
this.st_replica=create st_replica
this.dw_bloqueos=create dw_bloqueos
this.uo_nombre=create uo_nombre
this.Control[]={this.st_replica,&
this.dw_bloqueos,&
this.uo_nombre}
end on

on w_bloqueos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.dw_bloqueos)
destroy(this.uo_nombre)
end on

event open;//g_nv_security.fnv_secure_window (this)

dw_bloqueos.settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

event doubleclicked;if dw_bloqueos.retrieve(long(uo_nombre.em_cuenta.text)) = 0 then
	dw_bloqueos.insertrow(0)
end if
end event

event closequery;int resp
if dw_bloqueos.modifiedcount() > 0 or dw_bloqueos.deletedcount() > 0 then
	resp = messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesnocancel!)
	choose case resp
		case 1 
			m_bloqueos.m_registro.m_actualiza.triggerevent(clicked!)			
		case 2
			dw_bloqueos.resetupdate()
		case 3
			message.returnvalue = 1 
	end choose
end if
end event

event activate;control_escolar.toolbarsheettitle="Bloqueos"
end event

event close;//close(this)
end event

type st_replica from statictext within w_bloqueos
integer x = 3511
integer y = 36
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

event constructor;n_transfiere_sybase_sql ln_transfiere_sybase_sql
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql
integer li_replica_activa, li_obten_parametros_replicacion
li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

type dw_bloqueos from datawindow within w_bloqueos
integer x = 165
integer y = 452
integer width = 3378
integer height = 1236
integer taborder = 2
string dataobject = "dw_bloqueos"
boolean border = false
end type

event itemchanged;//Se revisa si se modifica el campo de extension de creditos. Para efectuar las validaciones necesarias
//Marzo 1998 DkWf CAMP

int carrera,plan,cred_cursados
decimal cred_en_curso, cred_carrera
string periodo

if dwo.name = "exten_cred" and data <> '0'  then
	if obten_carrera_plan(long(uo_nombre.em_cuenta.text),carrera,plan) = 0 then
		cred_carrera	=	revisa_total_cred(carrera,plan)
		if	cred_carrera	>=		0 then
			cred_cursados	=	revisa_creditos_cursados(long(uo_nombre.em_cuenta.text),carrera,plan)
			if	cred_cursados	>=		0	then
				cred_en_curso	=	revisa_cred_en_curso(long(uo_nombre.em_cuenta.text))
				if	cred_en_curso	>=	0	then
					if cred_carrera <= cred_cursados + cred_en_curso + 80 then//Se autoriza la extension de creditos si el numero 
					  /*de creditos cursados  más los creditos que cursa en este semestre más 80 es igual al total de creditos de su carrera o mayor*/
						if	revisa_puntaje(long(uo_nombre.em_cuenta.text),carrera,plan) = 1 then//revisa si el alumno tiene 1 punto arriba del puntaje de calidad
							if	cred_p_periodo(g_per,integer(data)) =  1 then//revisa si el periodo permite la cantidad solicitada de creditos
								if f_obten_cve_subsistema(long(uo_nombre.em_cuenta.text),carrera,plan)>0 then //Revisa si tiene cargado el subsistema
									if f_curso_prerreq_ingles(long(uo_nombre.em_cuenta.text),carrera,plan) then //Revisa si se cursó el prerrequisito de inglés
										messagebox("EXTENSIÓN AUTORIZADA","Se autoriza que el alumno con cuenta "+string(long(uo_nombre.em_cuenta.text))+" reciba una extensión de creditos.",Stopsign!) 
								  		return 0
									else
										messagebox("NO se AUTORIZA la EXTENSIÓN de creditos","El alumno no ha aprobado el prerrequisto de Inglés",Stopsign!)
										open(w_password-autorizado)
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
									open(w_password-autorizado)
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
								open(w_password-autorizado)
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
							open(w_password-autorizado)
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
						open(w_password-autorizado)
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

event itemerror;return 1
end event

type uo_nombre from uo_nombre_alumno within w_bloqueos
integer x = 229
integer y = 36
integer height = 428
integer taborder = 1
boolean enabled = true
end type

event constructor;call super::constructor;m_bloqueos.objeto = this
end event

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

