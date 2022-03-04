$PBExportHeader$w_genera_documento_plan_est.srw
forward
global type w_genera_documento_plan_est from w_main
end type
type uo_planes_estudios_i from uo_planes_estudios within w_genera_documento_plan_est
end type
type st_1 from statictext within w_genera_documento_plan_est
end type
type uo_clave from uo_carreras within w_genera_documento_plan_est
end type
type st_3 from statictext within w_genera_documento_plan_est
end type
type ole_documento from u_oc_impresion_word within w_genera_documento_plan_est
end type
type dw_documento_titulacion from u_dw within w_genera_documento_plan_est
end type
end forward

global type w_genera_documento_plan_est from w_main
integer x = 466
integer y = 372
integer width = 3306
integer height = 1824
string title = "Generación de Documentos de Plan de Estudios"
string menuname = "m_genera_documento_alumno"
uo_planes_estudios_i uo_planes_estudios_i
st_1 st_1
uo_clave uo_clave
st_3 st_3
ole_documento ole_documento
dw_documento_titulacion dw_documento_titulacion
end type
global w_genera_documento_plan_est w_genera_documento_plan_est

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

end variables

forward prototypes
public function integer wf_imprime_documento (long al_cuenta, long al_cve_documento, string as_columnas_marcas[], string as_query_definicion)
public function windowstate wf_obten_estado_ventana ()
public function integer wf_obten_clave ()
public function long getmodulehandle (string as_modname)
end prototypes

public function integer wf_imprime_documento (long al_cuenta, long al_cve_documento, string as_columnas_marcas[], string as_query_definicion);//f_imprime_documento
//Recibe		al_cuenta	long
//				al_cve_documento long


blob lblob_ole
long ll_campos, ll_rows, ll_tamanio_arreglo, ll_indice_arreglo
integer iDDEHandle, li_remote
string ls_filename, ls_cuenta, ls_condicion_cuenta, ls_condicion_datastore
datastore lds_datastore
string ls_presentacion, ls_error, ls_resultado_syntax, ls_marca_actual, ls_columna_actual


SELECTBLOB archivo_documento_titulac
INTO :lblob_ole
FROM documento_titulacion
WHERE cve_documento = :al_cve_documento
USING gtr_sce;

ls_cuenta= string(al_cuenta)
IF POS(upper(as_query_definicion),"WHERE") > 0 then
	ls_condicion_cuenta = " AND al.cuenta = "+ls_cuenta
ELSE
	ls_condicion_cuenta = " WHERE al.cuenta = "+ls_cuenta	
END IF

ls_condicion_datastore= as_query_definicion + ls_condicion_cuenta

lds_datastore = CREATE datastore

ls_presentacion= "Grid"

ls_resultado_syntax= gtr_sce.SyntaxFromSQL(ls_condicion_datastore, ls_presentacion, ls_error)
if ls_resultado_syntax= "" or isnull(ls_resultado_syntax) then
	MessageBox("Error en datawindow", ls_error,Stopsign!)
	return -1
end if

lds_datastore.Create(ls_resultado_syntax)
lds_datastore.SetTransObject(gtr_sce)
ll_rows= lds_datastore.Retrieve()

if ll_rows= 0 then
	MessageBox("Error en consulta","No existe información con los datos introducidos",Stopsign!)
	return -1
elseif ll_rows = -1 then
	MessageBox("Error de datawindow", "No es posible generar el reporte",Stopsign!)
	return -1
end if

IF not isnull(lblob_ole) THEN

	ole_documento.ObjectData = lblob_ole
	ole_documento.Activate(OffSite!)
//	MessageBox("Pausa","Documento ligado",Question!)
	ll_tamanio_arreglo= upperbound(as_columnas_marcas)
	FOR ll_indice_arreglo= 1 to ll_tamanio_arreglo
		ls_marca_actual= as_columnas_marcas[ll_indice_arreglo]
		IF ole_documento.object.application.ActiveDocument.Bookmarks.Exists(ls_marca_actual) THEN
			ole_documento.object.application.Selection.Goto(TRUE,0,0,ls_marca_actual)
			ls_columna_actual = lds_datastore.GetItemString(ll_rows,ll_indice_arreglo)
			ole_documento.object.application.Selection.TypeText(ls_columna_actual)
		END IF
	NEXT	
	IF ole_documento.object.application.PrintPreview = FALSE Then
	    ole_documento.object.application.PrintPreview= true
	END IF	
	ole_documento.object.application.ActiveDocument.PrintOut()

	return 0
ELSE
	MessageBox("Archivo sin Documento", "El tipo de archivo no tiene un documento relacionado",StopSign!)
	return -1
	
END IF


end function

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

public function integer wf_obten_clave ();string ls_cuenta
long ll_clave

ll_clave = uo_clave.of_obten_clave()

if  (ll_clave<=0)then
	MessageBox("Error en clave","Favor de escribir una carrera válida",StopSign!)
	return -1
end if 

return ll_clave
end function

public function long getmodulehandle (string as_modname);
//use win 32 getmodulehandle function
long	ll_return
ll_return = GetModuleHandleA(as_modname)
return ll_return

end function

on w_genera_documento_plan_est.create
int iCurrent
call super::create
if this.MenuName = "m_genera_documento_alumno" then this.MenuID = create m_genera_documento_alumno
this.uo_planes_estudios_i=create uo_planes_estudios_i
this.st_1=create st_1
this.uo_clave=create uo_clave
this.st_3=create st_3
this.ole_documento=create ole_documento
this.dw_documento_titulacion=create dw_documento_titulacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_planes_estudios_i
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.uo_clave
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.ole_documento
this.Control[iCurrent+6]=this.dw_documento_titulacion
end on

on w_genera_documento_plan_est.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_planes_estudios_i)
destroy(this.st_1)
destroy(this.uo_clave)
destroy(this.st_3)
destroy(this.ole_documento)
destroy(this.dw_documento_titulacion)
end on

event open;call super::open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(2)

x=1
y=1
end event

type uo_planes_estudios_i from uo_planes_estudios within w_genera_documento_plan_est
boolean visible = false
integer x = 329
integer y = 179
integer taborder = 20
boolean border = false
end type

on uo_planes_estudios_i.destroy
call uo_planes_estudios::destroy
end on

type st_1 from statictext within w_genera_documento_plan_est
boolean visible = false
integer x = 95
integer y = 205
integer width = 201
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plan:"
boolean focusrectangle = false
end type

type uo_clave from uo_carreras within w_genera_documento_plan_est
event destroy ( )
integer x = 329
integer y = 29
integer taborder = 10
boolean border = false
end type

on uo_clave.destroy
call uo_carreras::destroy
end on

type st_3 from statictext within w_genera_documento_plan_est
integer x = 62
integer y = 67
integer width = 271
integer height = 61
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carrera :"
boolean focusrectangle = false
end type

type ole_documento from u_oc_impresion_word within w_genera_documento_plan_est
integer x = 62
integer y = 992
integer width = 2849
integer height = 611
integer taborder = 40
boolean enabled = false
string binarykey = "w_genera_documento_plan_est.win"
end type

type dw_documento_titulacion from u_dw within w_genera_documento_plan_est
integer x = 62
integer y = 355
integer width = 2849
integer height = 579
integer taborder = 30
string dataobject = "d_documento_titulacion"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;
long ll_cuenta, ll_cve_carrera, ll_cve_plan
long ll_cve_documento
integer li_res
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[]
string ls_valores[]
boolean lb_procede_tramite, lb_alumno_susceptible

ll_cuenta = 0
ll_cve_carrera = wf_obten_clave()
ll_cve_plan= uo_planes_estudios_i.of_obten_clave()



if row <= 0 then
	MessageBox("Error", "No existe el documento base para generar",StopSign!)
	return -1	
end if

ls_valores[1] =string(ll_cve_carrera)


//ls_valores[1] ="-1"
//ls_valores[2] =string(ll_cve_carrera)
//ls_valores[3] =string(ll_cve_plan)

if ll_cve_carrera <> -1 and  ll_cve_plan <> -1 then
	li_res= MessageBox("Confirmacion","¿Desea generar el documento con el papel actual de la impresora ?",Question!,YesNo!)
	if li_res = 1 then
		ll_cve_documento = this.GetItemNumber(row, "cve_documento")	
		ls_query_datos = this.GetItemString(row, "query_datos")	
		ls_query_definicion = this.GetItemString(row, "query_definicion")	
		ole_documento.of_obten_arreglo_de_string(ls_query_datos, ls_columnas_marcas)
		if upperbound(ls_columnas_marcas) = 0 then
			MessageBox("Error", "No existen marcas a incrustar",StopSign!)
			return
		end if
		if len(trim (ls_query_definicion))= 0 then
			MessageBox("Error", "No existe query de definición",StopSign!)
			return			
		end if
//		if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
		if ole_documento.of_imprime_documento(ll_cve_documento, ll_cve_carrera, false,false) =0 then
			MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
		end if
	end if
end if


end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
01w_genera_documento_plan_est.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
11w_genera_documento_plan_est.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
