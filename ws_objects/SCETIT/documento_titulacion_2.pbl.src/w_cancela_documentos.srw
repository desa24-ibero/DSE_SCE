$PBExportHeader$w_cancela_documentos.srw
forward
global type w_cancela_documentos from w_main
end type
type cb_1 from commandbutton within w_cancela_documentos
end type
type dw_documento_titulacion from u_dw within w_cancela_documentos
end type
type uo_datos_opc_cero_i from uo_datos_opc_cero_sin_rev within w_cancela_documentos
end type
end forward

global type w_cancela_documentos from w_main
integer x = 466
integer y = 372
integer width = 3306
integer height = 1770
string title = "Cancelación de Documentos"
string menuname = "m_genera_documento_alumno"
event metodo01 ( )
cb_1 cb_1
dw_documento_titulacion dw_documento_titulacion
uo_datos_opc_cero_i uo_datos_opc_cero_i
end type
global w_cancela_documentos w_cancela_documentos

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
public function long getmodulehandle (string as_modname)
public function long wf_obten_cuenta ()
end prototypes

event metodo01();boolean lb_procede_tramite, lb_alumno_susceptible
long ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_cve_tramite, ll_num_tramites

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)


ll_num_tramites= dw_documento_titulacion.Retrieve(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if ll_num_tramites= -1 then
	MessageBox("Error","No es posible consultar los tramites",StopSign!)	
end if


end event

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

public function long getmodulehandle (string as_modname);
//use win 32 getmodulehandle function
long	ll_return
ll_return = GetModuleHandleA(as_modname)
return ll_return

end function

public function long wf_obten_cuenta ();return 0
end function

on w_cancela_documentos.create
int iCurrent
call super::create
if this.MenuName = "m_genera_documento_alumno" then this.MenuID = create m_genera_documento_alumno
this.cb_1=create cb_1
this.dw_documento_titulacion=create dw_documento_titulacion
this.uo_datos_opc_cero_i=create uo_datos_opc_cero_i
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_documento_titulacion
this.Control[iCurrent+3]=this.uo_datos_opc_cero_i
end on

on w_cancela_documentos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_documento_titulacion)
destroy(this.uo_datos_opc_cero_i)
end on

event open;call super::open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Reset()


x=1
y=1

iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero
end event

event close;call super::close;if isvalid(iuo_atencion_opc_cero) THEN
	DESTROY iuo_atencion_opc_cero
end if
end event

type cb_1 from commandbutton within w_cancela_documentos
integer x = 1254
integer y = 1430
integer width = 713
integer height = 106
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Cancelaciones"
end type

event clicked;integer li_confirmacion
long ll_cuenta_dw, ll_cve_carrera_dw, ll_cuenta_uo, ll_cve_carrera_uo

IF dw_documento_titulacion.Rowcount()>0 THEN
	ll_cuenta_dw = dw_documento_titulacion.GetItemNumber(1,"bit_documento_titulacion_cuenta")
	ll_cve_carrera_dw= dw_documento_titulacion.GetItemNumber(1,"bit_documento_titulacion_cve_carrera")

	ll_cuenta_uo = uo_datos_opc_cero_i.of_obten_cuenta()
	ll_cve_carrera_uo = uo_datos_opc_cero_i.of_obten_cve_carrera()

	IF ll_cuenta_dw<>ll_cuenta_uo OR ll_cve_carrera_dw<>ll_cve_carrera_uo THEN
		MessageBox("Error al actualizar", "El alumno o la carrera no corresponden a la información mostrada", StopSign!)		
		return
	END IF
	
	li_confirmacion = MessageBox("Confirme Actualización", "¿Desea Actualizar los registros cancelados?", Question!, YesNo!)

	IF li_confirmacion = 1 THEN
		IF dw_documento_titulacion.Update()= 1 THEN
			commit using gtr_sce;
			MessageBox("Actualización Exitosa", "Se han actualizado los cambios", Information!)
		ELSE
			rollback using gtr_sce;
			MessageBox("Error al actualizar", "No es posible actualizar los cambios", StopSign!)
		END IF
	ELSE
		MessageBox("Sin Cambios", "No se han actualizado los cambios", Information!)
	END IF
ELSE
	
END IF
end event

type dw_documento_titulacion from u_dw within w_cancela_documentos
integer x = 55
integer y = 448
integer width = 3112
integer height = 915
integer taborder = 20
string dataobject = "d_cancela_documentos"
boolean ib_rmbmenu = false
end type

type uo_datos_opc_cero_i from uo_datos_opc_cero_sin_rev within w_cancela_documentos
integer x = 26
integer y = 10
integer taborder = 10
end type

on uo_datos_opc_cero_i.destroy
call uo_datos_opc_cero_sin_rev::destroy
end on

