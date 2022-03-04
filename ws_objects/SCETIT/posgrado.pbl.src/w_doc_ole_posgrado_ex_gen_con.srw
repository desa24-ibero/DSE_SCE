$PBExportHeader$w_doc_ole_posgrado_ex_gen_con.srw
forward
global type w_doc_ole_posgrado_ex_gen_con from w_main
end type
type cb_3 from u_cb within w_doc_ole_posgrado_ex_gen_con
end type
type cb_guarda_examen from u_cb within w_doc_ole_posgrado_ex_gen_con
end type
type cb_2 from commandbutton within w_doc_ole_posgrado_ex_gen_con
end type
type uo_nombre_alumno_posgrado_i from uo_nombre_alumno_posgrado within w_doc_ole_posgrado_ex_gen_con
end type
type st_periodo from statictext within w_doc_ole_posgrado_ex_gen_con
end type
type uo_1 from uo_per_ani within w_doc_ole_posgrado_ex_gen_con
end type
type cb_1 from u_cb within w_doc_ole_posgrado_ex_gen_con
end type
type pb_1 from u_pb within w_doc_ole_posgrado_ex_gen_con
end type
type st_fecha from statictext within w_doc_ole_posgrado_ex_gen_con
end type
type em_calendar from u_em within w_doc_ole_posgrado_ex_gen_con
end type
type st_1 from statictext within w_doc_ole_posgrado_ex_gen_con
end type
type dw_detail from u_dw within w_doc_ole_posgrado_ex_gen_con
end type
type dw_master from u_dw within w_doc_ole_posgrado_ex_gen_con
end type
type cb_seleccion from commandbutton within w_doc_ole_posgrado_ex_gen_con
end type
type st_3 from statictext within w_doc_ole_posgrado_ex_gen_con
end type
type uo_tipo_documento from uo_clase_documento within w_doc_ole_posgrado_ex_gen_con
end type
type ole_documento from u_oc_impresion_word within w_doc_ole_posgrado_ex_gen_con
end type
type dw_documento_titulacion from u_dw within w_doc_ole_posgrado_ex_gen_con
end type
type uo_carreras_i from uo_carreras_posgrado within w_doc_ole_posgrado_ex_gen_con
end type
type gb_1 from u_gb within w_doc_ole_posgrado_ex_gen_con
end type
end forward

global type w_doc_ole_posgrado_ex_gen_con from w_main
integer width = 3877
integer height = 2156
string title = "Examen General de Conocimientos (Posgrado)"
string menuname = "m_genera_documento_posgrado"
cb_3 cb_3
cb_guarda_examen cb_guarda_examen
cb_2 cb_2
uo_nombre_alumno_posgrado_i uo_nombre_alumno_posgrado_i
st_periodo st_periodo
uo_1 uo_1
cb_1 cb_1
pb_1 pb_1
st_fecha st_fecha
em_calendar em_calendar
st_1 st_1
dw_detail dw_detail
dw_master dw_master
cb_seleccion cb_seleccion
st_3 st_3
uo_tipo_documento uo_tipo_documento
ole_documento ole_documento
dw_documento_titulacion dw_documento_titulacion
uo_carreras_i uo_carreras_i
gb_1 gb_1
end type
global w_doc_ole_posgrado_ex_gen_con w_doc_ole_posgrado_ex_gen_con

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
uo_atencion_posgrado iuo_atencion_posgrado
boolean lb_seleccion= false
long il_periodo, il_anio, il_cve_carrera
date idt_fecha
end variables

forward prototypes
public function integer wf_imprime_documento (long al_cuenta, long al_cve_documento, string as_columnas_marcas[], string as_query_definicion)
public function windowstate wf_obten_estado_ventana ()
public function long wf_obten_cuenta ()
public function long getmodulehandle (string as_modname)
public function date wf_obten_fecha ()
public function long wf_obten_cve_carrera ()
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

public function date wf_obten_fecha ();date ldt_fecha
string ls_fecha

ls_fecha = em_calendar.text
ldt_fecha = date(ls_fecha)

return ldt_fecha
end function

public function long wf_obten_cve_carrera ();long ll_cve_carrera

ll_cve_carrera = uo_carreras_i.of_obten_clave()

return ll_cve_carrera
end function

on w_doc_ole_posgrado_ex_gen_con.create
int iCurrent
call super::create
if this.MenuName = "m_genera_documento_posgrado" then this.MenuID = create m_genera_documento_posgrado
this.cb_3=create cb_3
this.cb_guarda_examen=create cb_guarda_examen
this.cb_2=create cb_2
this.uo_nombre_alumno_posgrado_i=create uo_nombre_alumno_posgrado_i
this.st_periodo=create st_periodo
this.uo_1=create uo_1
this.cb_1=create cb_1
this.pb_1=create pb_1
this.st_fecha=create st_fecha
this.em_calendar=create em_calendar
this.st_1=create st_1
this.dw_detail=create dw_detail
this.dw_master=create dw_master
this.cb_seleccion=create cb_seleccion
this.st_3=create st_3
this.uo_tipo_documento=create uo_tipo_documento
this.ole_documento=create ole_documento
this.dw_documento_titulacion=create dw_documento_titulacion
this.uo_carreras_i=create uo_carreras_i
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_guarda_examen
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.uo_nombre_alumno_posgrado_i
this.Control[iCurrent+5]=this.st_periodo
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.pb_1
this.Control[iCurrent+9]=this.st_fecha
this.Control[iCurrent+10]=this.em_calendar
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.dw_detail
this.Control[iCurrent+13]=this.dw_master
this.Control[iCurrent+14]=this.cb_seleccion
this.Control[iCurrent+15]=this.st_3
this.Control[iCurrent+16]=this.uo_tipo_documento
this.Control[iCurrent+17]=this.ole_documento
this.Control[iCurrent+18]=this.dw_documento_titulacion
this.Control[iCurrent+19]=this.uo_carreras_i
this.Control[iCurrent+20]=this.gb_1
end on

on w_doc_ole_posgrado_ex_gen_con.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_3)
destroy(this.cb_guarda_examen)
destroy(this.cb_2)
destroy(this.uo_nombre_alumno_posgrado_i)
destroy(this.st_periodo)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.st_fecha)
destroy(this.em_calendar)
destroy(this.st_1)
destroy(this.dw_detail)
destroy(this.dw_master)
destroy(this.cb_seleccion)
destroy(this.st_3)
destroy(this.uo_tipo_documento)
destroy(this.ole_documento)
destroy(this.dw_documento_titulacion)
destroy(this.uo_carreras_i)
destroy(this.gb_1)
end on

event open;call super::open;long ll_rows

dw_master.SetTransObject(gtr_sce)
dw_detail.SetTransObject(gtr_sce)

//dw_master.of_SetDropDownCalendar(true)
//dw_master.iuo_calendar.of_Register("fecha_examen",  dw_master.iuo_calendar.DDLB)
//dw_master.iuo_calendar.of_Register("fecha_limite_doctos",  dw_master.iuo_calendar.DDLB)
//dw_master.iuo_calendar.of_SetSaturdayBold(TRUE)
////dw_master.iuo_calendar.of_SetSaturdayColor(lnv_color.GREEN)
//dw_master.iuo_calendar.of_SetSundayBold(TRUE)
dw_master.of_SetLinkage(True)
dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(19)

x=1
y=1

iuo_atencion_posgrado = CREATE uo_atencion_posgrado
end event

event close;call super::close;if isvalid(iuo_atencion_posgrado) THEN
	DESTROY iuo_atencion_posgrado
end if
end event

event pfc_postupdate;call super::pfc_postupdate;integer li_res_update
powerobject lpw_dw[]

lpw_dw[1] = dw_detail

li_res_update = dw_detail.update()

if li_res_update = 1 then
	COMMIT USING gtr_sce;
else
	ROLLBACK USING gtr_sce;
	MessageBox("Error en detalle","No es posible almacenar a los alumnos",Stopsign!)
end if

return li_res_update
end event

type cb_3 from u_cb within w_doc_ole_posgrado_ex_gen_con
integer x = 3552
integer y = 560
integer width = 247
integer taborder = 50
string text = "Jurado"
end type

event clicked;call super::clicked;str_jurado_posgrado lst_parametros, lst_parametros_return
long ll_row

if dw_master.RowCount()>0 then
	ll_row = dw_master.GetRow()
	lst_parametros.cve_presidente = dw_master.GetItemNumber(ll_row, "cve_presidente")
	lst_parametros.cve_vocal =	dw_master.GetItemNumber(ll_row, "cve_vocal")
	lst_parametros.cve_secretario = dw_master.GetItemNumber(ll_row, "cve_secretario")
	lst_parametros.cve_suplente_1 = dw_master.GetItemNumber(ll_row, "cve_suplente_1")
	lst_parametros.cve_suplente_2 = dw_master.GetItemNumber(ll_row, "cve_suplente_2")
	lst_parametros.nombre_presidente = dw_master.GetItemString(ll_row, "nombre_presidente")
	lst_parametros.nombre_vocal = dw_master.GetItemString(ll_row, "nombre_vocal")
	lst_parametros.nombre_secretario = dw_master.GetItemString(ll_row, "nombre_secretario")
	lst_parametros.nombre_suplente_1 = dw_master.GetItemString(ll_row, "nombre_suplente_1")
	lst_parametros.nombre_suplente_2 = dw_master.GetItemString(ll_row, "nombre_suplente_2")

end if

OpenWithParm(w_seleccion_jurado, lst_parametros, parent)
lst_parametros_return =Message.PowerObjectParm
if dw_master.RowCount()>0 then
	ll_row = dw_master.GetRow()
	dw_master.SetItem(ll_row, "cve_presidente", lst_parametros_return.cve_presidente )
	dw_master.SetItem(ll_row, "cve_vocal", lst_parametros_return.cve_vocal )
	dw_master.SetItem(ll_row, "cve_secretario", lst_parametros_return.cve_secretario )
	dw_master.SetItem(ll_row, "cve_suplente_1", lst_parametros_return.cve_suplente_1 )
	dw_master.SetItem(ll_row, "cve_suplente_2", lst_parametros_return.cve_suplente_2 )
	dw_master.SetItem(ll_row, "nombre_presidente", lst_parametros_return.nombre_presidente )
	dw_master.SetItem(ll_row, "nombre_vocal", lst_parametros_return.nombre_vocal )
	dw_master.SetItem(ll_row, "nombre_secretario", lst_parametros_return.nombre_secretario )
	dw_master.SetItem(ll_row, "nombre_suplente_1", lst_parametros_return.nombre_suplente_1 )
	dw_master.SetItem(ll_row, "nombre_suplente_2", lst_parametros_return.nombre_suplente_2 )

end if


end event

type cb_guarda_examen from u_cb within w_doc_ole_posgrado_ex_gen_con
integer x = 3365
integer y = 1176
integer width = 393
integer taborder = 50
string text = "Guarda Examen"
end type

event clicked;call super::clicked;long  ll_rows_master, ll_rows_detail
int   li_master, li_detail

ll_rows_master = dw_master.Rowcount() 
ll_rows_detail = dw_detail.Rowcount() 

if ll_rows_master>1 then
	MessageBox("Más de un valor","Solo se permite un examen por carrera y periodo",StopSign!)
	return
elseif ll_rows_master=0 then
	MessageBox("Examen Faltante","Favor de insertar un examen",StopSign!)	
	return
end if

if ll_rows_detail=0 then
	MessageBox("Alumno Faltante","Favor de insertar al menos un alumno al examen",StopSign!)	
	return
end if

li_master = dw_master.Update()


if li_master=1  then	
	li_detail = dw_detail.Update()
	if li_detail= 1 then	
		COMMIT USING gtr_sce;
		MessageBox("Examen Almacenado","Se ha almacendo exitosamente al examen",Information!)	
	else
		ROLLBACK USING gtr_sce;
		MessageBox("No es posible grabar alumnos","No es posible almacenar al examen",StopSign!)	
	end if
else
	ROLLBACK USING gtr_sce;
	MessageBox("No es posible grabar examen","No es posible almacenar al examen",StopSign!)	
end if



end event

type cb_2 from commandbutton within w_doc_ole_posgrado_ex_gen_con
integer x = 1531
integer y = 1180
integer width = 251
integer height = 80
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "Añadir =>"
end type

event clicked;dw_detail.event pfc_InsertRow()
end event

type uo_nombre_alumno_posgrado_i from uo_nombre_alumno_posgrado within w_doc_ole_posgrado_ex_gen_con
integer x = 55
integer y = 888
integer taborder = 50
boolean enabled = true
end type

on uo_nombre_alumno_posgrado_i.destroy
call uo_nombre_alumno_posgrado::destroy
end on

type st_periodo from statictext within w_doc_ole_posgrado_ex_gen_con
integer x = 114
integer y = 204
integer width = 283
integer height = 56
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = " Periodo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_1 from uo_per_ani within w_doc_ole_posgrado_ex_gen_con
integer x = 443
integer y = 152
integer width = 1248
integer height = 164
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_1 from u_cb within w_doc_ole_posgrado_ex_gen_con
integer x = 3058
integer y = 124
integer taborder = 40
string text = "Seleccionar"
end type

event clicked;call super::clicked;date ldt_fecha
long ll_cve_carrera, ll_rows
integer li_periodo, li_anio

il_periodo = gi_periodo
il_anio = gi_anio
idt_fecha = wf_obten_fecha()
il_cve_carrera = wf_obten_cve_carrera()

ll_rows = dw_master.Retrieve(il_periodo,il_anio, il_cve_carrera)
if ll_rows = 0 then
	MessageBox("Información Inexistente","No existen exámenes con los criterios solicitados",Information!)
end if
lb_seleccion = true
end event

type pb_1 from u_pb within w_doc_ole_posgrado_ex_gen_con
integer x = 2665
integer y = 180
integer width = 96
integer height = 108
integer taborder = 40
string text = ""
boolean originalsize = false
string picturename = "ddarrow.bmp"
end type

event clicked;call super::clicked;em_calendar.Event pfc_ddcalendar ( )
end event

type st_fecha from statictext within w_doc_ole_posgrado_ex_gen_con
integer x = 1755
integer y = 200
integer width = 210
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_calendar from u_em within w_doc_ole_posgrado_ex_gen_con
integer x = 1984
integer y = 192
integer width = 667
integer height = 84
integer taborder = 30
integer textsize = -10
fontcharset fontcharset = ansi!
long backcolor = 15793151
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

event constructor;call super::constructor;Integer  li_return   

this.text= string(today())
this.of_SetDropDownCalendar(TRUE)

iuo_calendar.of_SetSaturdayBold(TRUE)
iuo_calendar.of_SetSundayBold(TRUE)


this.iuo_calendar.of_SetInitialValue(TRUE)
////this.iuo_calendar.x =1
//this.iuo_calendar.y =1
//
this.iuo_calendar.x =143
this.iuo_calendar.y =650
//
//this.iuo_calendar.of_SetCloseOnClick(FALSE) 
//this.iuo_calendar.of_SetCloseOnDClick(FALSE)  

//li_return = this.Event pfc_DDCalendar()
//this.iuo_calendar.of_SetDropDown(TRUE)

end event

type st_1 from statictext within w_doc_ole_posgrado_ex_gen_con
integer x = 146
integer y = 72
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Carrera:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_detail from u_dw within w_doc_ole_posgrado_ex_gen_con
integer x = 55
integer y = 1260
integer width = 3205
integer height = 360
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Alumnos Examen"
string dataobject = "d_alumno_examen_gral_con"
end type

event constructor;call super::constructor;this.of_SetLinkage(TRUE)
inv_Linkage.of_LinkTo(dw_master)
inv_Linkage.of_setUseColLinks(3)

inv_Linkage.of_setarguments( "fecha_examen", "fecha_examen")
end event

event pfc_insertrow;long ll_row, ll_periodo, ll_anio, ll_cve_carrera, ll_cuenta, ll_cve_plan
date ldt_fecha
datetime ldttm_fecha


IF super::event pfc_insertrow()<=0 then
	MessageBox("Error Encontrado","No se ha añadido el registro",StopSign!)
	return 0
end if

ll_cuenta = uo_nombre_alumno_posgrado_i.of_obten_cuenta()
//ll_cve_plan = of_obten_plan_certificado_total(ll_cuenta, il_cve_carrera)
ll_cve_plan = of_obten_plan_academicos(ll_cuenta, il_cve_carrera)

ll_row= dw_master.GetRow()

ll_periodo = dw_master.GetItemNumber(ll_row,"periodo")
ll_anio= dw_master.GetItemNumber(ll_row,"anio")
ll_cve_carrera= dw_master.GetItemNumber(ll_row,"cve_carrera")
ldttm_fecha = dw_master.GetItemDateTime(ll_row,"fecha_examen")
ldt_fecha =date(ldttm_fecha)

this.SetItem(ll_row,"cuenta",ll_cuenta)
this.SetItem(ll_row,"cve_carrera",ll_cve_carrera)
this.SetItem(ll_row,"cve_plan",ll_cve_plan)
this.SetItem(ll_row,"periodo",ll_periodo)
this.SetItem(ll_row,"anio",ll_anio)
this.SetItem(ll_row,"fecha_examen",ldt_fecha)
return ll_row

end event

event pfc_preinsertrow;long  ll_cuenta, ll_cve_plan, ll_rows
integer li_existe_alumno

ll_rows= this.rowcount()

if not lb_seleccion then
	MessageBox ("Selección Inválida","Favor de seleccionar periodo, carrera y fecha",StopSign!)	
	return 0
end if

ll_cuenta = uo_nombre_alumno_posgrado_i.of_obten_cuenta()

if ll_cuenta = -1 then
	MessageBox ("Alumno Inválido","Favor de seleccionar un alumno de la carrera en cuestión",StopSign!)	
	return 0	
end if

li_existe_alumno = of_existe_alumno_certificado_total(ll_cuenta, il_cve_carrera)


if li_existe_alumno = -1 then
	MessageBox ("Error de Consulta","Favor de seleccionar e intentar nuevamente",StopSign!)	
	return 0	
elseif li_existe_alumno = 0 then
	MessageBox ("Alumno Inválido","Favor de seleccionar un alumno con certificado total de la carrera en cuestión",StopSign!)	
	return 0	
end if

//ll_cve_plan = of_obten_plan_certificado_total(ll_cuenta, il_cve_carrera)

ll_cve_plan = of_obten_plan_academicos(ll_cuenta, il_cve_carrera)
if ll_cve_plan= -1 then
	MessageBox ("Plan Inválido","No es posible consultar el plan de estudios del alumno en cuestión",StopSign!)	
	return 0	
end if

if ll_rows >0 then
	if this.find("cuenta = "+string(ll_cuenta),1, ll_rows)>0 then
		MessageBox ("Cuenta Duplicada","Se ha repetido al alumno en cuestión",StopSign!)	
		return 0	
	end if
end if

return 1
end event

type dw_master from u_dw within w_doc_ole_posgrado_ex_gen_con
integer x = 55
integer y = 332
integer width = 3479
integer height = 544
integer taborder = 40
boolean bringtotop = true
boolean titlebar = true
string title = "Examen"
string dataobject = "d_examen_gral_conocimientos"
end type

event constructor;call super::constructor;this.of_SetLinkage(TRUE)
this.SetRowFocusIndicator(Hand!)
end event

event retrieveend;call super::retrieveend;dw_detail.Retrieve(il_periodo, il_anio, il_cve_carrera)

end event

event pfc_postinsertrow;call super::pfc_postinsertrow;long ll_row
if not lb_seleccion then
	MessageBox ("Selección Inválida","Favor de seleccionar periodo, carrera y fecha",StopSign!)	
	return 
end if

ll_row= this.GetRow()
this.SetItem(ll_row,"cve_carrera",il_cve_carrera)
this.SetItem(ll_row,"periodo",il_periodo)
this.SetItem(ll_row,"anio",il_anio)
this.SetItem(ll_row,"fecha_examen",idt_fecha)
return 
end event

type cb_seleccion from commandbutton within w_doc_ole_posgrado_ex_gen_con
boolean visible = false
integer x = 2231
integer y = 1792
integer width = 411
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Selección"
end type

event clicked;integer li_cve_clase_documento
long ll_renglones
li_cve_clase_documento = uo_tipo_documento.of_obten_clave()

ll_renglones = dw_documento_titulacion.Retrieve(li_cve_clase_documento)

end event

type st_3 from statictext within w_doc_ole_posgrado_ex_gen_con
boolean visible = false
integer x = 32
integer y = 1684
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

type uo_tipo_documento from uo_clase_documento within w_doc_ole_posgrado_ex_gen_con
boolean visible = false
integer x = 955
integer y = 1808
integer width = 1271
integer taborder = 20
boolean border = false
end type

on uo_tipo_documento.destroy
call uo_clase_documento::destroy
end on

type ole_documento from u_oc_impresion_word within w_doc_ole_posgrado_ex_gen_con
boolean visible = false
integer x = 32
integer y = 1676
integer width = 2848
integer height = 384
integer taborder = 50
boolean enabled = false
string binarykey = "w_doc_ole_posgrado_ex_gen_con.win"
end type

type dw_documento_titulacion from u_dw within w_doc_ole_posgrado_ex_gen_con
integer x = 55
integer y = 1628
integer width = 3205
integer height = 316
integer taborder = 40
boolean bringtotop = true
string title = "Documento a Imprimir"
string dataobject = "d_documento_titulacion"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event doubleclicked;call super::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan
integer li_res, li_res_obten_fecha_opcion, li_res_usa_folio_existente
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[]
boolean lb_procede_tramite, lb_alumno_susceptible
long ll_row_actual, ll_periodo, ll_anio
datetime ldttm_fecha_examen, ldttm_fecha_nula
long ll_opcion_titulacion, ll_long_nulo, ll_inserta_folio_monedas, ll_folio_monedas

if dw_master.Rowcount()<>1 then
	MessageBox("Número de examenes incorrectos", "Favor de corregir al examen",StopSign!)
	return
end if

SetNull(ldttm_fecha_nula)
SetNull(ll_long_nulo)


if dw_master.Rowcount()=1 then
	ll_row_actual= dw_master.Getrow()
//asigna el periodo en la cuenta	
	ll_cuenta = dw_master.GetItemNumber(ll_row_actual, "periodo")
	ll_cve_carrera = dw_master.GetItemNumber(ll_row_actual, "cve_carrera")
//asigna el anio en el plan
	ll_cve_plan= dw_master.GetItemNumber(ll_row_actual, "anio")
	
	ll_periodo = ll_cuenta
	ll_anio = ll_cve_plan
	ldttm_fecha_examen= dw_master.GetItemDateTime(ll_row_actual, "fecha_examen")
	ll_opcion_titulacion= dw_master.GetItemNumber(ll_row_actual, "opcion_titulacion")
end if

if row <= 0 then
	MessageBox("Error", "No existe el documento base para generar",StopSign!)
	return -1	
end if

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
		if ll_cve_documento= 56 then
			ll_folio_monedas= of_existe_folio_monedas(ll_cuenta, ll_cve_carrera, ll_cve_plan)
			if ll_folio_monedas>0 then
				li_res_usa_folio_existente = MessageBox("Existe un folio anterior para el alumno", "¿Desea reutilizarlo?",Question!, YesNo!)								
			end if 	
			if ll_folio_monedas=0 or li_res_usa_folio_existente=2 then			
				li_res_obten_fecha_opcion = of_obten_fecha_opcion(ll_cuenta, ll_cve_carrera, ll_cve_plan, ldttm_fecha_examen , ll_opcion_titulacion)
					if isnull(ldttm_fecha_examen) then
						MessageBox("La fecha del examen es nula", "No es posible generar el documento",StopSign!)
						return					
					end if 
					if isnull(ll_opcion_titulacion) then
						MessageBox("La opcion de titulacion es nula", "No es posible generar el documento",StopSign!)
						return					
					end if 
					ll_inserta_folio_monedas = of_inserta_folio_monedas(ll_cuenta, ll_cve_carrera, ll_cve_plan, ldttm_fecha_examen , ll_opcion_titulacion, ll_periodo, ll_anio)
					if ll_inserta_folio_monedas = -1 then 				
						MessageBox("Error en la foliación de monedas", "No es posible generar el documento",StopSign!)
						return
					else
						if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
							MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
						end if					
					end if				
					
			else
				if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
					MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
				end if										
			end if		
		else			
			if ole_documento.of_imprime_documento(ll_cve_documento, ls_valores, false,false) =0 then
				MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
			end if
		end if		
	end if
end if

end event

type uo_carreras_i from uo_carreras_posgrado within w_doc_ole_posgrado_ex_gen_con
integer x = 416
integer y = 36
integer width = 2459
integer height = 136
integer taborder = 40
boolean border = false
end type

on uo_carreras_i.destroy
call uo_carreras_posgrado::destroy
end on

type gb_1 from u_gb within w_doc_ole_posgrado_ex_gen_con
integer x = 55
integer y = 4
integer width = 2857
integer height = 328
integer taborder = 11
string text = "Seleccione"
end type


Start of PowerBuilder Binary Data Section : Do NOT Edit
04w_doc_ole_posgrado_ex_gen_con.bin 
2B00000600e011cfd0e11ab1a1000000000000000000000000000000000003003e0009fffe00000006000000000000000000000001000000010000000000001000fffffffe00000000fffffffe0000000000000000fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffdfffffffeffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff006f00520074006f004500200074006e00790072000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000050016ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000fffffffe00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ffffffffffffffffffffffff000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
14w_doc_ole_posgrado_ex_gen_con.bin 
End of PowerBuilder Binary Data Section : No Source Expected After This Point
