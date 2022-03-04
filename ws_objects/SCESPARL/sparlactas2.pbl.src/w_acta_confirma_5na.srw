$PBExportHeader$w_acta_confirma_5na.srw
forward
global type w_acta_confirma_5na from w_master
end type
type st_periodo_anio from statictext within w_acta_confirma_5na
end type
type rb_extrao_tit from radiobutton within w_acta_confirma_5na
end type
type rb_ordinario from radiobutton within w_acta_confirma_5na
end type
type st_dbparam from statictext within w_acta_confirma_5na
end type
type st_minutos from statictext within w_acta_confirma_5na
end type
type st_3 from statictext within w_acta_confirma_5na
end type
type st_status from statictext within w_acta_confirma_5na
end type
type cb_1 from u_cb within w_acta_confirma_5na
end type
type cb_actualiza_parametros_servicios from u_cb within w_acta_confirma_5na
end type
type dw_acta_evaluacion_preeliminar_sin_conf from u_dw within w_acta_confirma_5na
end type
type gb_tipo_examen from groupbox within w_acta_confirma_5na
end type
end forward

global type w_acta_confirma_5na from w_master
integer x = 846
integer width = 4978
integer height = 2872
string title = "Calificar con 5 o NA las actas no Confirmadas"
string menuname = "m_menugeneral"
windowstate windowstate = maximized!
st_periodo_anio st_periodo_anio
rb_extrao_tit rb_extrao_tit
rb_ordinario rb_ordinario
st_dbparam st_dbparam
st_minutos st_minutos
st_3 st_3
st_status st_status
cb_1 cb_1
cb_actualiza_parametros_servicios cb_actualiza_parametros_servicios
dw_acta_evaluacion_preeliminar_sin_conf dw_acta_evaluacion_preeliminar_sin_conf
gb_tipo_examen gb_tipo_examen
end type
global w_acta_confirma_5na w_acta_confirma_5na

type variables
string is_nivel = "L"
string is_nombre_nivel = "Licenciatura"
string is_bloqueo_finanzas = "Bloquear"
integer ii_adeuda_finanzas = 1
st_confirma_usuario ist_confirma_usuario
long il_creditos
integer ii_periodo, ii_anio
n_tr itr_web
end variables

forward prototypes
public function integer wf_confirma_5na ()
end prototypes

public function integer wf_confirma_5na ();//wf_confirma_5na()
DataStore lds_cuenta_sin_calificacion_por_materia
long ll_i, ll_rows_actas, ll_rows_alumnos
int  li_j, li_alumnos_actas, li_alumnos, li_cve_tipo_examen
string ls_tipo
long ll_no_acta, ll_cve_mat
string ls_gpo
int li_periodo, li_anio
long  ll_num_segundos
real lr_num_minutos
time ltm_hora_inicial, ltm_hora_final
ltm_hora_inicial = now()

//Datawindow de Materias sin calificacion
lds_cuenta_sin_calificacion_por_materia = Create DataStore
if rb_ordinario.checked  = true then
	lds_cuenta_sin_calificacion_por_materia.DataObject = "d_alumno_acta_evaluacion_sin_conf" 
elseif rb_extrao_tit.checked  = true then
	lds_cuenta_sin_calificacion_por_materia.DataObject = "d_alumno_acta_evaluacion_sin_conf_ets" 
end if
lds_cuenta_sin_calificacion_por_materia.SetTransObject(itr_web)

//
dw_acta_evaluacion_preeliminar_sin_conf.SetFilter("")
ll_rows_actas = dw_acta_evaluacion_preeliminar_sin_conf.Retrieve(gs_tipo_periodo) 
//for ll_i = 1 to dw_acta_evaluacion_preeliminar_sin_conf.Rowcount()
for ll_i = 1 to ll_rows_actas
	ll_no_acta = dw_acta_evaluacion_preeliminar_sin_conf.GetItemNumber(ll_i, "acta_evaluacion_preeliminar_no_acta")
	ll_cve_mat = dw_acta_evaluacion_preeliminar_sin_conf.GetItemNumber(ll_i,"acta_evaluacion_preeliminar_cve_mat")
	ls_gpo = dw_acta_evaluacion_preeliminar_sin_conf.GetItemString(ll_i,"acta_evaluacion_preeliminar_gpo")
	li_periodo= dw_acta_evaluacion_preeliminar_sin_conf.GetItemNumber(ll_i,"acta_evaluacion_preeliminar_periodo")
	li_anio= dw_acta_evaluacion_preeliminar_sin_conf.GetItemNumber(ll_i,"acta_evaluacion_preeliminar_anio")
	li_cve_tipo_examen= dw_acta_evaluacion_preeliminar_sin_conf.GetItemNumber(ll_i,"cve_tipo_examen")
	//Muestra el acta que se está procesando
	st_status.text = "Calificando acta núm.: "+&
		string(ll_no_acta)+" Materia :"+&
		string(ll_cve_mat)+"-"+ls_gpo
	//Obtiene los inscritos del acta		
	li_alumnos_actas = dw_acta_evaluacion_preeliminar_sin_conf.GetItemNumber(ll_i,"acta_evaluacion_preeliminar_inscritos")
	//Recupera al grupo sin materias
	li_alumnos = lds_cuenta_sin_calificacion_por_materia.Retrieve(ll_cve_mat,	ls_gpo, li_periodo, li_anio, li_cve_tipo_examen) 
	
	if li_alumnos = li_alumnos_actas then
		ls_tipo = Mid(lds_cuenta_sin_calificacion_por_materia.GetItemString(1,"materias_evaluacion"),1,2)
		//Por cada alumno del acta
		ll_rows_alumnos =lds_cuenta_sin_calificacion_por_materia.RowCount()
		for li_j = 1 to ll_rows_alumnos
			//Si la evaluacion es NUMERICA O NUMERICA INCOMPLETA pone 5
			if  ls_tipo = "NU" then
				lds_cuenta_sin_calificacion_por_materia.SetItem(li_j,"calificacion_confirmada","5")	
			else
			//Si la evaluacion es ALFANUMERICA O ALFNUMERICA INCOMPLETA pone NA
				lds_cuenta_sin_calificacion_por_materia.SetItem(li_j,"calificacion_confirmada","NA")
			end if
		next
		//Actualiza las calificaciones
		if lds_cuenta_sin_calificacion_por_materia.Update() = 1 then
			//Mueve el cve_estatus_acta a CONFIRMADA (3)
			dw_acta_evaluacion_preeliminar_sin_conf.Setitem(ll_i,"cve_estatus_acta",3)
			//Establece que dicha CONFIRMACION fue POR SISTEMA (0)
			dw_acta_evaluacion_preeliminar_sin_conf.Setitem(ll_i,"cve_origen_confirmacion",0)
			//Actualiza el acta
			if dw_acta_evaluacion_preeliminar_sin_conf.Update() = 1 then
				commit using itr_web;
			else
				rollback using itr_web;
				MessageBox("Atencion", "Los cambios no se han guardado para el acta ["+string(ll_no_acta)+"]")
			end if
		else
			rollback using itr_web;
			MessageBox("Atencion", "Los cambios no se han guardado para el acta ["+string(ll_no_acta)+"]")
		end if
		//Actualiza y actualiza status
	else
		MessageBox("Atencion","Los inscritos no coinciden para el acta num:" +string(ll_no_acta)+"]")
	end if
	
next
Destroy lds_cuenta_sin_calificacion_por_materia
ll_rows_actas = dw_acta_evaluacion_preeliminar_sin_conf.Retrieve(gs_tipo_periodo)
ltm_hora_final = now()

ll_num_segundos = SecondsAfter ( ltm_hora_inicial, ltm_hora_final )

lr_num_minutos = ll_num_segundos / 60

st_minutos.text = string(lr_num_minutos,"#,###.####")

return ll_rows_actas


end function

on w_acta_confirma_5na.create
int iCurrent
call super::create
if this.MenuName = "m_menugeneral" then this.MenuID = create m_menugeneral
this.st_periodo_anio=create st_periodo_anio
this.rb_extrao_tit=create rb_extrao_tit
this.rb_ordinario=create rb_ordinario
this.st_dbparam=create st_dbparam
this.st_minutos=create st_minutos
this.st_3=create st_3
this.st_status=create st_status
this.cb_1=create cb_1
this.cb_actualiza_parametros_servicios=create cb_actualiza_parametros_servicios
this.dw_acta_evaluacion_preeliminar_sin_conf=create dw_acta_evaluacion_preeliminar_sin_conf
this.gb_tipo_examen=create gb_tipo_examen
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_periodo_anio
this.Control[iCurrent+2]=this.rb_extrao_tit
this.Control[iCurrent+3]=this.rb_ordinario
this.Control[iCurrent+4]=this.st_dbparam
this.Control[iCurrent+5]=this.st_minutos
this.Control[iCurrent+6]=this.st_3
this.Control[iCurrent+7]=this.st_status
this.Control[iCurrent+8]=this.cb_1
this.Control[iCurrent+9]=this.cb_actualiza_parametros_servicios
this.Control[iCurrent+10]=this.dw_acta_evaluacion_preeliminar_sin_conf
this.Control[iCurrent+11]=this.gb_tipo_examen
end on

on w_acta_confirma_5na.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_periodo_anio)
destroy(this.rb_extrao_tit)
destroy(this.rb_ordinario)
destroy(this.st_dbparam)
destroy(this.st_minutos)
destroy(this.st_3)
destroy(this.st_status)
destroy(this.cb_1)
destroy(this.cb_actualiza_parametros_servicios)
destroy(this.dw_acta_evaluacion_preeliminar_sin_conf)
destroy(this.gb_tipo_examen)
end on

event open;
INTEGER le_periodo
STRING ls_periodo 
INTEGER le_anio
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos(gs_tipo_periodo, 'L', gtr_sce) 
luo_periodo_servicios.f_carga_periodo_activo( le_periodo, le_anio, gs_tipo_periodo, gtr_sce)
ls_periodo = luo_periodo_servicios.f_recupera_descripcion( le_periodo, 'L')
THIS.st_periodo_anio.TEXT = ls_periodo + " " + STRING(le_anio)


x=1
y=1


if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
//if conecta_bd(itr_web,"WEB_PARAM", gs_usuario,gs_password )<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_acta_evaluacion_preeliminar_sin_conf.SetTransObject(itr_web)
	dw_acta_evaluacion_preeliminar_sin_conf.Retrieve(gs_tipo_periodo)
end if


st_dbparam.text =itr_web.DBParm 



end event

event close;call super::close;if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if
end event

event closequery;RETURN 0
end event

type st_periodo_anio from statictext within w_acta_confirma_5na
integer x = 3511
integer y = 44
integer width = 983
integer height = 116
boolean bringtotop = true
integer textsize = -16
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "PERIODO - AÑO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type rb_extrao_tit from radiobutton within w_acta_confirma_5na
integer x = 1559
integer y = 148
integer width = 795
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Extraordinario y a Título de Suf."
end type

event clicked;dw_acta_evaluacion_preeliminar_sin_conf.dataobject = 'd_acta_evaluacion_preeliminar_sin_co_ets'
dw_acta_evaluacion_preeliminar_sin_conf.SetTransObject(itr_web)
end event

type rb_ordinario from radiobutton within w_acta_confirma_5na
integer x = 1559
integer y = 60
integer width = 407
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ordinario"
boolean checked = true
end type

event clicked;dw_acta_evaluacion_preeliminar_sin_conf.dataobject = 'd_acta_evaluacion_preeliminar_sin_conf'
dw_acta_evaluacion_preeliminar_sin_conf.SetTransObject(itr_web)
end event

type st_dbparam from statictext within w_acta_confirma_5na
integer x = 78
integer y = 320
integer width = 4704
integer height = 72
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "DBPARAM"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_minutos from statictext within w_acta_confirma_5na
integer x = 1143
integer y = 52
integer width = 270
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = right!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_3 from statictext within w_acta_confirma_5na
integer x = 891
integer y = 72
integer width = 210
integer height = 48
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Minutos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_status from statictext within w_acta_confirma_5na
integer x = 942
integer y = 228
integer width = 1518
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Status"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from u_cb within w_acta_confirma_5na
integer x = 357
integer y = 56
integer width = 498
integer taborder = 50
boolean bringtotop = true
string text = "Consultar"
end type

event clicked;call super::clicked;dw_acta_evaluacion_preeliminar_sin_conf.Retrieve(gs_tipo_periodo)
end event

type cb_actualiza_parametros_servicios from u_cb within w_acta_confirma_5na
integer x = 2441
integer y = 56
integer width = 1029
integer taborder = 40
boolean bringtotop = true
string text = "Calificar con 5 o NA las actas no Confirmadas"
end type

event clicked;call super::clicked;integer li_confirmacion
long ll_row, ll_rows, ll_row_horario, ll_rows_horario
boolean lb_usuario_especial
long  ll_num_segundos
real lr_num_minutos
time ltm_hora_inicial, ltm_hora_final

ll_rows = dw_acta_evaluacion_preeliminar_sin_conf.RowCount()

IF ll_rows = 0 THEN
		MessageBox("Sin Información", "No existe información a actualizar", StopSign!)
		RETURN
END IF

li_confirmacion= MessageBox("Confirmación","¿Desea calificar con 5 y NA las actas faltantes?",Question!,YesNo!)
IF li_confirmacion<>1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF	
END IF

lb_usuario_especial = f_usuario_especial(gs_usuario)
IF not (lb_usuario_especial) THEN
	MessageBox("Usuario Normal", "Es necesario ser un usuario especial para actualizar ésta información", StopSign!)
	RETURN
END IF	

IF ll_rows > 0 THEN
	wf_confirma_5na()
//	IF dw_acta_evaluacion_preeliminar_sin_conf.Update()= 1 THEN
//		COMMIT USING itr_web;
//		MessageBox("Actualización exitosa","Se han actualizado correctamente los parámetros de los Servicios en Línea",Information!)
//		dw_acta_evaluacion_preeliminar_sin_conf.Retrieve()
//	ELSE
//		ROLLBACK USING itr_web;		
//		MessageBox("Error de Actualización","No es posible actualizar los parámetros de los Servicios en Línea",Information!)			
//	END IF	
ELSE
	MessageBox("Error de Actualización","No existe información a actualizar",Information!)
END IF

end event

type dw_acta_evaluacion_preeliminar_sin_conf from u_dw within w_acta_confirma_5na
event primero ( )
event siguiente ( )
event ultimo ( )
integer x = 78
integer y = 388
integer width = 4704
integer height = 2224
integer taborder = 70
string dataobject = "d_acta_evaluacion_preeliminar_sin_conf"
boolean hscrollbar = true
boolean resizable = true
end type

event primero();
/*Ve al primer renglón*/
setcolumn(1)
setfocus()
scrolltorow(1)

end event

event siguiente();scrollnextpage ( )
end event

event ultimo();/*Ve al último renglón*/
setcolumn(1)
setfocus()
scrolltorow(rowcount())
end event

event dberror;//////////////////////////////////////////////////////////////////////////////
//	Event:			dberror
//	Description:	Display messagebox that a database error has occurred.
// 					If appropriate delay displaying the database error until the appropriate
// 					Rollback has been performed.
//////////////////////////////////////////////////////////////////////////////
//	Rev. History	Version
//						5.0   Initial version
// 					5.0.02 Suppress error messages until after a rollback has been performed
// 					6.0 	Enhanced to use new dberrorattrib to support all error attributes.
// 					6.0	Enhanced to support Transaction Management by other objects
// 					6.0 	Enhanced to send notification to the SqlSpy service.
//////////////////////////////////////////////////////////////////////////////
//	Copyright © 1996-1999 Sybase, Inc. and its subsidiaries.  All rights reserved.  Any distribution of the 
// PowerBuilder Foundation Classes (PFC) source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//////////////////////////////////////////////////////////////////////////////
w_master	lw_parent
string	ls_message
string	ls_sqlspyheading
string	ls_sqlspymessage
string	ls_msgparm[1]
powerobject lpo_updaterequestor
n_cst_dberrorattrib lnv_dberrorattrib

// The error message.
ls_message = "A database error has occurred.~r~n~r~n~r~n" + &
	"Database error code:  " + String (sqldbcode) + "~r~n~r~n" + &
	"Database error message:~r~n" + sqlerrtext

// Set the error attributes.
lnv_dberrorattrib.il_sqldbcode = sqldbcode
lnv_dberrorattrib.is_sqlerrtext = sqlerrtext
lnv_dberrorattrib.is_sqlsyntax = sqlsyntax
lnv_dberrorattrib.idwb_buffer = buffer
lnv_dberrorattrib.il_row = row
lnv_dberrorattrib.is_errormsg = ls_message
lnv_dberrorattrib.ipo_inerror = this

// If available trigger the SQLSpy service.
If IsValid(gnv_app.inv_debug) then
	If IsValid(gnv_app.inv_debug.inv_sqlspy) then

		// Create the heading and message for the SQLSpy.
		ls_sqlspyheading = "DBError - " + this.ClassName() + "(" + string(row) + ")"
		ls_sqlspymessage = "Database error code:  " + String (sqldbcode) + "~r~n" + &
			"Database error message:  " + sqlerrtext
		
		// Send the information to the service for processing.
		gnv_app.inv_debug.inv_sqlspy.of_sqlSyntax  &
			(ls_sqlspyheading, "/*** " + ls_sqlspymessage + " ***/")
	end if
end if

// Determine if Transaction Management is being performed by another object.
If IsValid(ipo_UpdateRequestor) then
	lpo_updaterequestor = ipo_UpdateRequestor
else
	// Determine if the window is in the save process. 
	this.of_GetParentWindow(lw_parent)
	If IsValid(lw_parent) then
		If lw_parent.TriggerEvent ("pfc_descendant") = 1 then	
			If lw_parent.of_GetSaveStatus() then
				lpo_updaterequestor = lw_parent
			end if
		end if
	end if
end if

If IsValid(lpo_updaterequestor) then
	// Suppress the error message (let the UpdateRequestor display it).
	// MetaClass check, Dynamic Function Call.
	lpo_updaterequestor.Dynamic Function of_SetDBErrorMsg(lnv_dberrorattrib)
else
	// Display the message immediately.
	If IsValid(gnv_app.inv_error) then
		ls_msgparm[1] = ls_message
		gnv_app.inv_error.of_Message ("pfc_dwdberror", ls_msgparm, &
					gnv_app.iapp_object.DisplayName)
	else
		of_MessageBox ("pfc_dberror", gnv_app.iapp_object.DisplayName, &
			ls_message, StopSign!, Ok!, 1)
	end if
end if

return 0
end event

event constructor;call super::constructor;m_menugeneral.dw = this
modify("Datawindow.print.preview = Yes")

end event

type gb_tipo_examen from groupbox within w_acta_confirma_5na
integer x = 1499
integer width = 896
integer height = 220
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo de Examen"
end type

