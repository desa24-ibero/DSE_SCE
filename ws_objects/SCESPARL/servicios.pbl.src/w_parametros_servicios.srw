$PBExportHeader$w_parametros_servicios.srw
forward
global type w_parametros_servicios from w_master
end type
type rb_2 from radiobutton within w_parametros_servicios
end type
type rb_1 from radiobutton within w_parametros_servicios
end type
type cb_actualiza_parametros_servicios from u_cb within w_parametros_servicios
end type
type dw_parametros_servicios from u_dw within w_parametros_servicios
end type
end forward

global type w_parametros_servicios from w_master
integer x = 846
integer width = 3643
integer height = 2672
string title = "Parámetros de Servicios en Línea -            Ver. 23 feb 2021."
rb_2 rb_2
rb_1 rb_1
cb_actualiza_parametros_servicios cb_actualiza_parametros_servicios
dw_parametros_servicios dw_parametros_servicios
end type
global w_parametros_servicios w_parametros_servicios

type variables
string is_nivel = "L"
string is_nombre_nivel = "Licenciatura"
string is_bloqueo_finanzas = "Bloquear"
integer ii_adeuda_finanzas = 1
st_confirma_usuario ist_confirma_usuario
long il_creditos
integer ii_periodo, ii_anio
n_tr itr_web 



uo_periodo_servicios iuo_periodo_servicios


end variables

on w_parametros_servicios.create
int iCurrent
call super::create
this.rb_2=create rb_2
this.rb_1=create rb_1
this.cb_actualiza_parametros_servicios=create cb_actualiza_parametros_servicios
this.dw_parametros_servicios=create dw_parametros_servicios
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_2
this.Control[iCurrent+2]=this.rb_1
this.Control[iCurrent+3]=this.cb_actualiza_parametros_servicios
this.Control[iCurrent+4]=this.dw_parametros_servicios
end on

on w_parametros_servicios.destroy
call super::destroy
destroy(this.rb_2)
destroy(this.rb_1)
destroy(this.cb_actualiza_parametros_servicios)
destroy(this.dw_parametros_servicios)
end on

event open;x=1
y=1

iuo_periodo_servicios = CREATE uo_periodo_servicios
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 


if conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
	return
else 
	// Se modifican los listados de periodos disponibles 
	iuo_periodo_servicios.f_modifica_lista_columna( dw_parametros_servicios, "periodo_preinscripcion", "L")
	iuo_periodo_servicios.f_modifica_lista_columna( dw_parametros_servicios, "periodo_mat_inscritas", "L")
	dw_parametros_servicios.SetTransObject(itr_web)
	dw_parametros_servicios.Retrieve(gs_tipo_periodo)	
End if

//if conecta_bd(itr_web,"WEB_PARAM", "sceparam","grgfmc06")<>1 then
////if conecta_bd(itr_web,"WEB_PARAM", "sa","u1a2kdes")<>1 then
//	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
//	close(this)
//else 
//	dw_parametros_servicios.SetTransObject(itr_web)
//	dw_parametros_servicios.Retrieve()
//end if
//
//
end event

event close;call super::close;if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if
end event

event closequery;RETURN 0
end event

type rb_2 from radiobutton within w_parametros_servicios
integer x = 471
integer y = 2428
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Servicios"
boolean checked = true
end type

event clicked;dw_parametros_servicios.dataobject = 'd_parametros_servicios_02'
dw_parametros_servicios.SetTransObject(itr_web)
dw_parametros_servicios.height =556
dw_parametros_servicios.Retrieve(gs_tipo_periodo)
end event

type rb_1 from radiobutton within w_parametros_servicios
boolean visible = false
integer x = 475
integer y = 1336
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Login"
end type

event clicked;dw_parametros_servicios.dataobject = 'd_parametros_servicios'
dw_parametros_servicios.SetTransObject(itr_web)
dw_parametros_servicios.height =1048
dw_parametros_servicios.Retrieve()

end event

type cb_actualiza_parametros_servicios from u_cb within w_parametros_servicios
integer x = 1563
integer y = 2416
integer width = 498
integer taborder = 40
boolean bringtotop = true
string text = "Actualiza Parámetros"
end type

event clicked;call super::clicked;integer li_confirmacion,li_res
long ll_row, ll_rows, ll_row_horario, ll_rows_horario
boolean lb_usuario_especial
pipeline lp_trans

ll_rows = dw_parametros_servicios.RowCount()

IF ll_rows = 0 THEN
		MessageBox("Sin Información", "No existe información a actualizar", StopSign!)
		RETURN
END IF

li_confirmacion= MessageBox("Confirmación","¿Desea actualizar los parámetros de los Servicios en Línea?",Question!,YesNo!)
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
	IF dw_parametros_servicios.Update()= 1 THEN
		COMMIT USING itr_web;
		
		lp_trans = CREATE pipeline
		lp_trans.DataObject = "pl_trans_param_serv"
		li_res = lp_trans.Start(itr_web, gtr_sce, dw_parametros_servicios)
		if li_Res = 1 then
			MessageBox("Actualización exitosa","Se han actualizado correctamente los parámetros de los Servicios en Línea",Information!)
			dw_parametros_servicios.Retrieve(gs_tipo_periodo)
		else
			MessageBox("Error en Actualización","Error al actualizar parámetros de los Servicios en Línea en Sybase",Information!)			
		end if
	ELSE
		ROLLBACK USING itr_web;		
		MessageBox("Error de Actualización","No es posible actualizar los parámetros de los Servicios en Línea",Information!)			
	END IF	
ELSE
	MessageBox("Error de Actualización","No existe información a actualizar",Information!)
END IF

end event

type dw_parametros_servicios from u_dw within w_parametros_servicios
integer x = 73
integer y = 32
integer width = 3438
integer height = 2348
integer taborder = 70
string dataobject = "d_parametros_servicios_02"
end type

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

