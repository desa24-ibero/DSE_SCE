$PBExportHeader$w_registro_libros_posgradox.srw
forward
global type w_registro_libros_posgradox from w_main
end type
type cb_registrar from commandbutton within w_registro_libros_posgradox
end type
type uo_datos_opc_cero_i from uo_datos_opc_cero within w_registro_libros_posgradox
end type
type cb_seleccion from commandbutton within w_registro_libros_posgradox
end type
type st_3 from statictext within w_registro_libros_posgradox
end type
type uo_tipo_documento from uo_clase_documento within w_registro_libros_posgradox
end type
type ole_documento from u_oc_impresion_word within w_registro_libros_posgradox
end type
type dw_documento_titulacion from u_dw within w_registro_libros_posgradox
end type
end forward

global type w_registro_libros_posgradox from w_main
integer width = 3195
integer height = 1212
string title = "Entrega de Títulos y Registro en Libros"
string menuname = "m_genera_documento_alumno"
cb_registrar cb_registrar
uo_datos_opc_cero_i uo_datos_opc_cero_i
cb_seleccion cb_seleccion
st_3 st_3
uo_tipo_documento uo_tipo_documento
ole_documento ole_documento
dw_documento_titulacion dw_documento_titulacion
end type
global w_registro_libros_posgradox w_registro_libros_posgradox

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
public function integer wf_imprime_documento (long al_cuenta, long al_cve_documento, string as_columnas_marcas[], string as_query_definicion)
public function windowstate wf_obten_estado_ventana ()
public function long wf_obten_cuenta ()
public function long getmodulehandle (string as_modname)
public function integer wf_inserta_imprime_hoja ()
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

public function long wf_obten_cuenta ();return 0
end function

public function long getmodulehandle (string as_modname);
//use win 32 getmodulehandle function
long	ll_return
ll_return = GetModuleHandleA(as_modname)
return ll_return

end function

public function integer wf_inserta_imprime_hoja ();//wf_inserta_imprime_hoja

long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan, ll_row
integer li_res, li_existe_hoja, li_insercion_hoja
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[]
boolean lb_procede_tramite

ll_row= dw_documento_titulacion.GetRow()

if ll_row <= 0 then
	MessageBox("Error", "No existe el documento base para generar",StopSign!)
	return -1	
end if

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)
lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()


ls_valores[1] =string(ll_cuenta)
ls_valores[2] =string(ll_cve_carrera)
ls_valores[3] =string(ll_cve_plan)

if ll_cuenta <> -1 then
	li_res= MessageBox("Confirmacion","¿Desea generar el documento con el papel actual de la impresora ?",Question!,YesNo!)
	if li_res = 1 then
		li_existe_hoja=iuo_atencion_opc_cero.of_existe_hoja_libro_carrera(ll_cuenta,ll_cve_carrera,ll_cve_plan)
		if li_existe_hoja= -1 then
			return -1
		end if
		if li_existe_hoja=0 then
			li_insercion_hoja=iuo_atencion_opc_cero.of_inserta_hoja_libro_carrera(ll_cuenta,ll_cve_carrera,ll_cve_plan)
		end if
		if li_insercion_hoja= -1 then
			return -1
		end if
			
		ll_cve_documento = dw_documento_titulacion.GetItemNumber(ll_row, "cve_documento")	
		ls_query_datos = dw_documento_titulacion.GetItemString(ll_row, "query_datos")	
		ls_query_definicion = dw_documento_titulacion.GetItemString(ll_row, "query_definicion")	
		ole_documento.of_obten_arreglo_de_string(ls_query_datos, ls_columnas_marcas)
		if upperbound(ls_columnas_marcas) = 0 then
			MessageBox("Error", "No existen marcas a incrustar",StopSign!)
			return -1
		end if
		if len(trim (ls_query_definicion))= 0 then
			MessageBox("Error", "No existe query de definición",StopSign!)
			return -1			
		end if
		if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
			MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
			return 0
		else
			return -1
		end if
	end if
end if
return 0
end function

on w_registro_libros_posgradox.create
int iCurrent
call super::create
if this.MenuName = "m_genera_documento_alumno" then this.MenuID = create m_genera_documento_alumno
this.cb_registrar=create cb_registrar
this.uo_datos_opc_cero_i=create uo_datos_opc_cero_i
this.cb_seleccion=create cb_seleccion
this.st_3=create st_3
this.uo_tipo_documento=create uo_tipo_documento
this.ole_documento=create ole_documento
this.dw_documento_titulacion=create dw_documento_titulacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_registrar
this.Control[iCurrent+2]=this.uo_datos_opc_cero_i
this.Control[iCurrent+3]=this.cb_seleccion
this.Control[iCurrent+4]=this.st_3
this.Control[iCurrent+5]=this.uo_tipo_documento
this.Control[iCurrent+6]=this.ole_documento
this.Control[iCurrent+7]=this.dw_documento_titulacion
end on

on w_registro_libros_posgradox.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_registrar)
destroy(this.uo_datos_opc_cero_i)
destroy(this.cb_seleccion)
destroy(this.st_3)
destroy(this.uo_tipo_documento)
destroy(this.ole_documento)
destroy(this.dw_documento_titulacion)
end on

event open;call super::open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(5)
iuo_atencion_opc_cero = Create uo_atencion_opc_cero
x=1
y=1
end event

event close;call super::close;if isvalid(iuo_atencion_opc_cero) then
	Destroy iuo_atencion_opc_cero
end if
end event

type cb_registrar from commandbutton within w_registro_libros_posgradox
integer x = 1221
integer y = 432
integer width = 539
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Registrar en Libro"
end type

event clicked;boolean lb_procede_tramite, lb_alumno_susceptible
int li_impresion
long ll_cuenta, ll_cve_carrera, ll_cve_plan

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)

lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()
lb_alumno_susceptible =iuo_atencion_opc_cero.of_alumno_susceptible(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if not lb_procede_tramite or not lb_alumno_susceptible then
	MessageBox("Error","El alumno no es susceptible de registrarse en libros",StopSign!)
	return
end if

li_impresion = wf_inserta_imprime_hoja()



if li_impresion = -1 then
	MessageBox("Error","No fue posible registrar en libros ~n Favor de intentar nuevamente",StopSign!)
	return	
end if
end event

type uo_datos_opc_cero_i from uo_datos_opc_cero within w_registro_libros_posgradox
integer x = 27
integer y = 12
integer width = 3205
integer height = 380
integer taborder = 20
end type

on uo_datos_opc_cero_i.destroy
call uo_datos_opc_cero::destroy
end on

type cb_seleccion from commandbutton within w_registro_libros_posgradox
boolean visible = false
integer x = 1984
integer y = 1160
integer width = 411
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Selección"
end type

event clicked;integer li_cve_clase_aula
long ll_renglones
li_cve_clase_aula = uo_tipo_documento.of_obten_clave()

ll_renglones = dw_documento_titulacion.Retrieve(li_cve_clase_aula)

end event

type st_3 from statictext within w_registro_libros_posgradox
boolean visible = false
integer x = 178
integer y = 1188
integer width = 535
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Documento"
boolean focusrectangle = false
end type

type uo_tipo_documento from uo_clase_documento within w_registro_libros_posgradox
boolean visible = false
integer x = 704
integer y = 1160
integer width = 1271
integer taborder = 40
boolean border = false
end type

on uo_tipo_documento.destroy
call uo_clase_documento::destroy
end on

type ole_documento from u_oc_impresion_word within w_registro_libros_posgradox
integer x = 64
integer y = 596
integer width = 2848
integer height = 384
integer taborder = 50
boolean enabled = false
string binarykey = "w_registro_libros_posgradox.win"
end type

type dw_documento_titulacion from u_dw within w_registro_libros_posgradox
boolean visible = false
integer x = 59
integer y = 1056
integer width = 2843
integer height = 76
integer taborder = 40
string dataobject = "d_documento_titulacion"
boolean hscrollbar = true
end type

event doubleclicked;call super::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan
integer li_res
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[]
boolean lb_procede_tramite
ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)

lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()


ls_valores[1] =string(ll_cuenta)
ls_valores[2] =string(ll_cve_carrera)
ls_valores[3] =string(ll_cve_plan)

if ll_cuenta <> -1 then
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
		if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
			MessageBox("Impresion Exitos", "El documento se ha impreso exitosamente",Information!)
		end if
	end if
end if

end event


Start of PowerBuilder Binary Data Section : Do NOT Edit
0Cw_registro_libros_posgradox.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1Cw_registro_libros_posgradox.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
