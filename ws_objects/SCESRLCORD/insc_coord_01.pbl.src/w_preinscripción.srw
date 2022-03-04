$PBExportHeader$w_preinscripción.srw
forward
global type w_preinscripción from w_reinscripcion
end type
type dw_mat_preinsc from datawindow within w_preinscripción
end type
end forward

global type w_preinscripción from w_reinscripcion
string menuname = "m_preinscripcion"
dw_mat_preinsc dw_mat_preinsc
end type
global w_preinscripción w_preinscripción

forward prototypes
public subroutine inscribe_mat_preinsc ()
public function integer actualiza_status (long cta)
public function integer revisa_status_alumno (long cta)
end prototypes

public subroutine inscribe_mat_preinsc ();/*Función que revisa e inscribe las materias preinscritas
  Mayo 1998		CAMP		DkWf*/
  int reng,cont
  decimal cred_act
//  int cred_max
//	if g_per = 1 then
//		cred_max = 20
//	else
//		cred_max = I_cms
//	end if
//  
  dw_materias.insertrow(0)
  cont = dw_materias.rowcount()
  agrega_mat()
  for reng = 1 to dw_mat_preinsc.rowcount()	
	dw_materias.object.mat_inscritas_cve_mat[cont]	= dw_mat_preinsc.object.cve_mat[reng]
	dw_materias.scrolltorow(cont)
	dw_materias.setcolumn("mat_inscritas_cve_mat")
	dw_materias.triggerevent(itemchanged!)
	cred_act = dw_materias.getitemdecimal(dw_materias.getrow(),"creditos_totales")
	if  aceptado = 3 then		
		EXIT
	else
		if dw_materias.object.mat_inscritas_cve_mat[cont] <> 0 then
			dw_materias.object.mat_inscritas_gpo[cont]	= dw_mat_preinsc.object.gpo[reng]
			dw_materias.scrolltorow(cont)
			dw_materias.setcolumn("mat_inscritas_gpo")
			dw_materias.triggerevent(itemchanged!)
			if aceptado = 0 then
				agrega_mat()
				cont ++	
			else
				aceptado = 0
			end if
		end if
	end if
  next
  
  
  
  
end subroutine

public function integer actualiza_status (long cta);/*Función que cambia el status del alumno evitando asi una nueva carga de la información de preinscripcion
	Mayo 1998	CAMP	DkWf*/

UPDATE preinsc  
     SET status = 4  
   WHERE (preinsc.cuenta = :cta) AND
   			   (preinsc.periodo = :g_per) AND
			   (preinsc.anio = :g_anio);
	
	if sqlca.sqlcode = 0 then
		commit;
		return 0
	else
		rollback;
		return 1
	end if

end function

public function integer revisa_status_alumno (long cta);/*Función que revisa si el alumno se registró, su hoja de preinscripción se leyó y pagó
	Si efectuo todos estos pasos la función regresa 0 en caso contrario regresa 1
	Mayo 1998 DkWf 	CAMP*/
int	stat,tipo_preinsc= 0

if (usuario = "inscrip") OR (usuario = "inscrposg" ) then
	tipo_preinsc = i_preinsc
else
	SELECT activacion_su.preinsc  
    INTO :tipo_preinsc
    FROM activacion_su  ;
	 
	if sqlca.sqlcode <> 0 then
		tipo_preinsc = 1
	end if
	commit;
end if

  SELECT preinsc.status  
	  INTO :stat
    FROM preinsc  
 WHERE ( preinsc.cuenta = :cta ) AND
 			 ( preinsc.periodo = :g_per) AND
			 ( preinsc.anio = :g_anio);
				 
if sqlca.sqlcode = 0 then
	commit;
	if stat >= 2 then
			return stat
	else
		if tipo_preinsc = 2 then
			messagebox("NO cumplio los requisitos","El alumno con cuenta "+string(cta)+"-"+obten_digito(cta)+" NO REALIZÓ  TODOS LOS TRAMITES de preinscripción.~n~t~t No se puede inscribir",stopsign!)
			return 1
		else
			return 4
		end if
	end if	
elseif sqlca.sqlcode = 100 then	
	commit;
	if tipo_preinsc = 2 then
		messagebox("Alumno NO registrado","El alumno con cuenta "+string(cta)+"-"+obten_digito(cta)+" NO REALIZÓ LOS TRAMITES de preinscripción.~n~t~t No se puede inscribir",stopsign!)
		return 1
	else
		return 4
	end if
else
	messagebox("ERROR INFORMACIÓN",sqlca.sqlerrtext,stopsign!)
	commit;
	return 1
end if
end function

on w_preinscripción.create
int iCurrent
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_preinscripcion" then this.MenuID = create m_preinscripcion
this.dw_mat_preinsc=create dw_mat_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_mat_preinsc
end on

on w_preinscripción.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_mat_preinsc)
end on

event open;call super::open;if isvalid(w_preinscripción) then
	dw_mat_preinsc.settransobject(sqlca)
end if

end event

event inicia_proceso;call super::inicia_proceso;//Evento en el cual se procesa la preinscripcion 
//si el alumno es de posgrado no es necesario realizar los tramites
//si el alumno es de licenciatura y tipo_preinsc es 2 obligatoria necesita realizar los tramites
//si el alumno "   "    "                "  "                 "   1 normal no necesita realizar los tramites
//Mayo 1998 		CAMP(DkWf)
// Cambios Fantine Medina 29 Julio 1998
long cta
int stat

limpia_lineas_vacias()
cta = long(uo_nombre.em_cuenta.text)
if cta <> 0 then
/* Quite esto y puse la linea que sigue para que no distinguiera lic y pos en preinsc
*	if nivel = 'L' then
*		stat = revisa_status_alumno(cta)
*	else
*		stat = 2
*	end if
*/
stat = revisa_status_alumno(cta)

	if stat = 2 then
		if dw_mat_preinsc.retrieve(cta,g_per,g_anio) > 0 then
			inscribe_mat_preinsc()
			actualiza_status(cta)
		else
			return
		end if
	else
		if stat < 2 then
			borrado_cuenta()
			return
		else
			return 
		end if
	end if
end if

end event

type p_uia from w_reinscripcion`p_uia within w_preinscripción
end type

type st_1 from w_reinscripcion`st_1 within w_preinscripción
integer x = 2880
integer y = 1748
integer width = 704
end type

type dw_reinsc_mat from w_reinscripcion`dw_reinsc_mat within w_preinscripción
end type

type dw_horario_mat from w_reinscripcion`dw_horario_mat within w_preinscripción
end type

type dw_materias from w_reinscripcion`dw_materias within w_preinscripción
end type

type dw_plan from w_reinscripcion`dw_plan within w_preinscripción
end type

type uo_nombre from w_reinscripcion`uo_nombre within w_preinscripción
end type

type dw_ext_h from w_reinscripcion`dw_ext_h within w_preinscripción
end type

type dw_prerre from w_reinscripcion`dw_prerre within w_preinscripción
end type

type dw_cursada from w_reinscripcion`dw_cursada within w_preinscripción
end type

type dw_labs from w_reinscripcion`dw_labs within w_preinscripción
end type

type dw_comprobante from w_reinscripcion`dw_comprobante within w_preinscripción
boolean bringtotop = true
end type

type r_1 from w_reinscripcion`r_1 within w_preinscripción
end type

type dw_grupos_disp from w_reinscripcion`dw_grupos_disp within w_preinscripción
end type

type dw_mat_integ from w_reinscripcion`dw_mat_integ within w_preinscripción
end type

type dw_mat_preinsc from datawindow within w_preinscripción
boolean visible = false
integer x = 320
integer y = 1632
integer width = 1006
integer height = 324
integer taborder = 21
boolean bringtotop = true
string dataobject = "dw_mat_preinscritas"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

