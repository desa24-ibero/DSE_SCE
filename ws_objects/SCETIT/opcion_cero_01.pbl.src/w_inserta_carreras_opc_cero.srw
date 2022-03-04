$PBExportHeader$w_inserta_carreras_opc_cero.srw
forward
global type w_inserta_carreras_opc_cero from w_main
end type
type uo_nombre_alumno_i from uo_nombre_alumno within w_inserta_carreras_opc_cero
end type
type cb_actualizacion from commandbutton within w_inserta_carreras_opc_cero
end type
end forward

global type w_inserta_carreras_opc_cero from w_main
integer x = 466
integer y = 372
integer width = 3310
integer height = 835
string title = "Actualiza Carreras Alumno"
string menuname = "m_inserta_carreras_opc_cero"
uo_nombre_alumno_i uo_nombre_alumno_i
cb_actualizacion cb_actualizacion
end type
global w_inserta_carreras_opc_cero w_inserta_carreras_opc_cero

type prototypes

//GetModuleHandle
Function long GetModuleHandleA(string modname) Library "KERNEL32.DLL" alias for "GetModuleHandleA;Ansi"
Function ulong FindWindowA (ulong classname, string windowname) Library "USER32.DLL" alias for "FindWindowA;Ansi"

Function boolean FlashWindow (long handle, boolean flash) Library "USER32.DLL"
Function uint GetWindow (long handle,uint relationship) Library "USER32.DLL"
Function int GetWindowTextA(long handle, ref string wintext, int length) Library "USER32.DLL" alias for "GetWindowTextA;Ansi"
Function boolean IsWindowVisible (long handle) Library "USER32.DLL"
Function uint GetWindowsDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetWindowsDirectoryA;Ansi"
Function uint GetSystemDirectoryA (ref string dirtext, uint textlen) library "KERNEL32.DLL" alias for "GetSystemDirectoryA;Ansi"
Function uint GetDriveTypeA (string drive) library "KERNEL32.DLL" alias for "GetDriveTypeA;Ansi"
Function ulong GetCurrentDirectoryA (ulong textlen, ref string dirtext) library "KERNEL32.DLL" alias for "GetCurrentDirectoryA;Ansi"

Function boolean GetUserNameA (ref string name, ref ulong len) library "ADVAPI32.DLL" alias for "GetUserNameA;Ansi"
Function ulong GetTickCount ( ) Library "KERNEL32.DLL"


end prototypes

type variables
uo_atencion_opc_cero iuo_atencion_opc_cero
end variables

forward prototypes
public function windowstate wf_obten_estado_ventana ()
public function long wf_obten_cuenta ()
public function long getmodulehandle (string as_modname)
end prototypes

public function windowstate wf_obten_estado_ventana ();//wf_obten_estado_ventana
//Check state of three radio button on screen and
//return the appropriate enumerated windowstate type

//if rb_max.checked then
//	return maximized!
//elseif rb_min.checked then
//	return minimized!
//else
//	return normal!
//end if
RETURN normal!
end function

public function long wf_obten_cuenta ();return 0
end function

public function long getmodulehandle (string as_modname);
//use win 32 getmodulehandle function
long	ll_return
ll_return = GetModuleHandleA(as_modname)
return ll_return

end function

on w_inserta_carreras_opc_cero.create
int iCurrent
call super::create
if this.MenuName = "m_inserta_carreras_opc_cero" then this.MenuID = create m_inserta_carreras_opc_cero
this.uo_nombre_alumno_i=create uo_nombre_alumno_i
this.cb_actualizacion=create cb_actualizacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre_alumno_i
this.Control[iCurrent+2]=this.cb_actualizacion
end on

on w_inserta_carreras_opc_cero.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre_alumno_i)
destroy(this.cb_actualizacion)
end on

event open;call super::open;long ll_rows

x=1
y=1

iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero
end event

event close;call super::close;if isvalid(iuo_atencion_opc_cero) THEN
	DESTROY iuo_atencion_opc_cero
end if
end event

type uo_nombre_alumno_i from uo_nombre_alumno within w_inserta_carreras_opc_cero
event destroy ( )
integer x = 11
integer y = 3
integer width = 3240
integer height = 429
integer taborder = 10
boolean enabled = true
end type

on uo_nombre_alumno_i.destroy
call uo_nombre_alumno::destroy
end on

type cb_actualizacion from commandbutton within w_inserta_carreras_opc_cero
integer x = 1426
integer y = 483
integer width = 413
integer height = 106
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualización"
end type

event clicked;integer li_cve_clase_aula, li_actualizacion, li_confirmacion
long ll_renglones, ll_cuenta
string ls_cuenta

ls_cuenta = uo_nombre_alumno_i.em_cuenta.text

if not isnumber(ls_cuenta) then
	MessageBox("Cuenta Inválida","El alumno escrito no existe", StopSign!)
else
	ll_cuenta = long(ls_cuenta) 
	if ll_cuenta>0 then
		li_confirmacion = MessageBox("Confirmación","Desea actualizar las carreras del alumno ["+ls_cuenta+"-"+obten_digito(ll_cuenta)+"]", Information!,YesNo!)			
		if li_confirmacion = 1 then
			li_actualizacion=  iuo_atencion_opc_cero.of_inserta_carreras(ll_cuenta)
			if li_actualizacion= 0 then
				MessageBox("Actualización correcta","Se han actualizado las carreras del alumno", Information!)			
				return
			elseif li_actualizacion= 100 then
				MessageBox("Alumno sin datos","El alumno NO tiene información Válida de Licenciatura Cargada~n"+&
							"NO se han actualizado las carreras del alumno", StopSign!)			
				return			
			elseif li_actualizacion= -1 then
				MessageBox("Error de Actualización","NO se han actualizado las carreras del alumno", StopSign!)			
				return			
			end if
		else
			MessageBox("Sin Actualizacion","NO se han insertado las carreras del alumno", Information!)			
			return			
		end if	
	end if
end if





end event

