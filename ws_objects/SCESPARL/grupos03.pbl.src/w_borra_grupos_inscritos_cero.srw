$PBExportHeader$w_borra_grupos_inscritos_cero.srw
forward
global type w_borra_grupos_inscritos_cero from w_master
end type
type st_periodo_establecido from statictext within w_borra_grupos_inscritos_cero
end type
type cb_establece_periodo from u_cb within w_borra_grupos_inscritos_cero
end type
type uo_1 from uo_per_ani within w_borra_grupos_inscritos_cero
end type
type dw_horarios from u_dw within w_borra_grupos_inscritos_cero
end type
type dw_grupos from u_dw within w_borra_grupos_inscritos_cero
end type
type cb_genera_archivo_gpo from commandbutton within w_borra_grupos_inscritos_cero
end type
type cb_elimina_grupos from commandbutton within w_borra_grupos_inscritos_cero
end type
type em_cantidad_materias_lab from editmask within w_borra_grupos_inscritos_cero
end type
type cb_contar_grupos from commandbutton within w_borra_grupos_inscritos_cero
end type
type gb_1 from groupbox within w_borra_grupos_inscritos_cero
end type
end forward

global type w_borra_grupos_inscritos_cero from w_master
integer x = 846
integer width = 2958
integer height = 784
string title = "Borra Grupos con Cero Inscritos"
st_periodo_establecido st_periodo_establecido
cb_establece_periodo cb_establece_periodo
uo_1 uo_1
dw_horarios dw_horarios
dw_grupos dw_grupos
cb_genera_archivo_gpo cb_genera_archivo_gpo
cb_elimina_grupos cb_elimina_grupos
em_cantidad_materias_lab em_cantidad_materias_lab
cb_contar_grupos cb_contar_grupos
gb_1 gb_1
end type
global w_borra_grupos_inscritos_cero w_borra_grupos_inscritos_cero

type variables
string is_nivel = "L"
string is_nombre_nivel = "Licenciatura"
string is_bloqueo_finanzas = "Bloquear"
integer ii_adeuda_finanzas = 1
st_confirma_usuario ist_confirma_usuario
long il_creditos
integer ii_periodo, ii_anio 

uo_periodo_servicios iuo_periodo_servicios




end variables

on w_borra_grupos_inscritos_cero.create
int iCurrent
call super::create
this.st_periodo_establecido=create st_periodo_establecido
this.cb_establece_periodo=create cb_establece_periodo
this.uo_1=create uo_1
this.dw_horarios=create dw_horarios
this.dw_grupos=create dw_grupos
this.cb_genera_archivo_gpo=create cb_genera_archivo_gpo
this.cb_elimina_grupos=create cb_elimina_grupos
this.em_cantidad_materias_lab=create em_cantidad_materias_lab
this.cb_contar_grupos=create cb_contar_grupos
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_periodo_establecido
this.Control[iCurrent+2]=this.cb_establece_periodo
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.dw_horarios
this.Control[iCurrent+5]=this.dw_grupos
this.Control[iCurrent+6]=this.cb_genera_archivo_gpo
this.Control[iCurrent+7]=this.cb_elimina_grupos
this.Control[iCurrent+8]=this.em_cantidad_materias_lab
this.Control[iCurrent+9]=this.cb_contar_grupos
this.Control[iCurrent+10]=this.gb_1
end on

on w_borra_grupos_inscritos_cero.destroy
call super::destroy
destroy(this.st_periodo_establecido)
destroy(this.cb_establece_periodo)
destroy(this.uo_1)
destroy(this.dw_horarios)
destroy(this.dw_grupos)
destroy(this.cb_genera_archivo_gpo)
destroy(this.cb_elimina_grupos)
destroy(this.em_cantidad_materias_lab)
destroy(this.cb_contar_grupos)
destroy(this.gb_1)
end on

event open;
y=1
dw_grupos.SetTransObject(gtr_sce)
dw_horarios.SetTransObject(gtr_sce)


iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "L", gtr_sce) 






end event

type st_periodo_establecido from statictext within w_borra_grupos_inscritos_cero
integer x = 2048
integer y = 124
integer width = 722
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 79741120
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_establece_periodo from u_cb within w_borra_grupos_inscritos_cero
integer x = 1513
integer y = 116
integer width = 462
integer taborder = 30
boolean bringtotop = true
string text = "Establece Periodo"
end type

event clicked;call super::clicked;string ls_periodo, ls_anio, ls_periodo_anio
long ll_total_items_origen, ll_total_items_destino

//CHOOSE CASE gi_periodo
//	CASE 0
//		ls_periodo= "PRIMAVERA"
//	CASE 1
//		ls_periodo= "VERANO"
//	CASE 2
//		ls_periodo= "OTOÑO"
//	CASE ELSE 
//		ls_periodo= "ERROR GRAVE"		
//END CHOOSE

// Se recupera la descripción del periodo. 
ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( gi_periodo, "L") 



ls_periodo_anio = ls_periodo + " "+ STRING(gi_anio) 

st_periodo_establecido.text = ls_periodo_anio

ii_periodo= gi_periodo
ii_anio = gi_anio


end event

type uo_1 from uo_per_ani within w_borra_grupos_inscritos_cero
event destroy ( )
integer x = 210
integer y = 72
integer width = 1253
integer height = 168
integer taborder = 20
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_horarios from u_dw within w_borra_grupos_inscritos_cero
boolean visible = false
integer x = 1509
integer y = 580
integer width = 1344
integer height = 580
integer taborder = 60
string dataobject = "d_horarios_inscritos_cero"
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

type dw_grupos from u_dw within w_borra_grupos_inscritos_cero
boolean visible = false
integer x = 64
integer y = 580
integer width = 1349
integer height = 580
integer taborder = 70
string dataobject = "d_grupos_inscritos_cero"
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

type cb_genera_archivo_gpo from commandbutton within w_borra_grupos_inscritos_cero
integer x = 1120
integer y = 356
integer width = 549
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Genera Archivo"
end type

event clicked;long ll_rows, ll_res_genera, ll_res_genera_horario

ll_rows = dw_grupos.RowCount()

IF ll_rows = -1 THEN	
	RETURN	
END IF
MessageBox("Archivo de grupos","Favor de dar el nombre del archivo de grupos", Information!)
ll_res_genera = dw_grupos.SaveAs("",Excel!,TRUE)
MessageBox("Archivo de horarios","Favor de dar el nombre del archivo de horarios", Information!)
ll_res_genera_horario = dw_horarios.SaveAs("",Excel!,TRUE)

IF ll_res_genera = 1 AND ll_res_genera_horario = 1 THEN
	cb_elimina_grupos.enabled=true
ELSE
	if ll_res_genera<>1 then
		MessageBox("Archivo de grupos","No es posible almacerar el archivo de grupos", Information!)	
	elseif ll_res_genera_horario<>1 then
		MessageBox("Archivo de horarios","No es posible almacerar el archivo de horarios", Information!)
	end if		
	cb_elimina_grupos.enabled=false	
END IF

RETURN
end event

type cb_elimina_grupos from commandbutton within w_borra_grupos_inscritos_cero
integer x = 1696
integer y = 356
integer width = 549
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Eliminar Grupos"
end type

event clicked;integer li_confirmacion
long ll_row, ll_rows, ll_row_horario, ll_rows_horario

ll_rows = dw_grupos.RowCount()
ll_rows_horario = dw_horarios.RowCount()

li_confirmacion= MessageBox("Confirmación","¿Desea eliminar los ["+string(ll_rows)+"] grupos con cero inscritos?",Question!,YesNo!)
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

LONG ll_cve_mat
STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio	
STRING ls_mensaje 


FOR ll_row = 1 TO ll_rows 
	
	ll_cve_mat = dw_grupos.GETITEMNUMBER(ll_row, "cve_mat") 
	ls_gpo = dw_grupos.GETITEMSTRING(ll_row, "gpo") 
	le_periodo = dw_grupos.GETITEMNUMBER(ll_row, "periodo")  
	le_anio = dw_grupos.GETITEMNUMBER(ll_row, "anio") 
	
	DELETE FROM grupos 
	WHERE cve_mat = :ll_cve_mat 
	AND gpo = :ls_gpo 
	AND periodo = :le_periodo 
	AND anio = :le_anio 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sce.SQLERRTEXT
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al borrar el grupo: " + ls_mensaje)
		RETURN -1
	END IF 
	
	DELETE FROM horario
	WHERE cve_mat = :ll_cve_mat 
	AND gpo = :ls_gpo 
	AND periodo = :le_periodo 
	AND anio = :le_anio 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sce.SQLERRTEXT
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al borrar el horario: " + ls_mensaje)
		RETURN -1
	END IF 
	
	DELETE FROM horario_profesor_grupo 
	WHERE cve_mat = :ll_cve_mat 
	AND gpo = :ls_gpo 
	AND periodo = :le_periodo 
	AND anio = :le_anio 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sce.SQLERRTEXT
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al borrar el horario del profesor: " + ls_mensaje)
		RETURN -1
	END IF 
	
	DELETE FROM profesor_cotitular 
	WHERE cve_mat = :ll_cve_mat 
	AND gpo = :ls_gpo 
	AND periodo = :le_periodo 
	AND anio = :le_anio 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sce.SQLERRTEXT
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al borrar profesores: " + ls_mensaje) 
		RETURN -1
	END IF 
	
	/**/
	// Se elimina el detalle de sesiones anterior.
	DELETE FROM horario_modular 
	WHERE cve_mat = :ll_cve_mat 
	AND gpo = :ls_gpo 
	AND periodo = :le_periodo 
	AND anio = :le_anio 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_mensaje = " Se produjo un error al borrar el horario de sesiones de grupo anteriores: " + gtr_sce.sqlerrtext  
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al borrar grupos bloques: " + ls_mensaje) 
		RETURN -1
	END IF 
	
	DELETE FROM  grupos_bloques
	WHERE cve_mat = :ll_cve_mat 
	AND gpo = :ls_gpo 
	AND periodo = :le_periodo 
	AND anio = :le_anio 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_mensaje = gtr_sce.SQLERRTEXT
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al borrar grupos bloques: " + ls_mensaje) 
		RETURN -1
	END IF 

NEXT


COMMIT USING gtr_sce;
MessageBox("Eliminacion exitosa","Se han eliminado correctamente los grupos y los horarios con cero inscritos",Information!)








// PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL 
// PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL 

//FOR ll_row = 1 TO ll_rows
//	dw_grupos.DeleteRow(dw_grupos.GetRow())
//NEXT
//FOR ll_row_horario = 1 TO ll_rows_horario
//	dw_horarios.DeleteRow(dw_horarios.GetRow())
//NEXT
//
//ll_rows = dw_grupos.RowCount()
//ll_rows_horario = dw_horarios.RowCount()
//
//IF ll_rows = 0 AND ll_rows_horario = 0 THEN
//	IF dw_horarios.Update()= 1 THEN
//		IF dw_grupos.Update()= 1 THEN
//			COMMIT USING gtr_sce;
//			MessageBox("Eliminacion exitosa","Se han eliminado correctamente los grupos y los horarios con cero inscritos",Information!)
//		ELSE
//			ROLLBACK USING gtr_sce;		
//			MessageBox("Error de Eliminacion","No es posible eliminar los grupos y los horarios* con cero inscritos",Information!)			
//		END IF	
//	ELSE
//		ROLLBACK USING gtr_sce;		
//		MessageBox("Error de Eliminacion","No es posible eliminar los grupos* y los horarios con cero inscritos",Information!)
//	END IF
//ELSE
//	MessageBox("Error de Eliminacion","Aun existen grupos y horarios con cero inscritos",Information!)
//END IF

// PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL 
// PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL  PROCESO DE BORRADO ORIGINAL 



end event

type em_cantidad_materias_lab from editmask within w_borra_grupos_inscritos_cero
integer x = 699
integer y = 352
integer width = 393
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 33554431
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###,###"
end type

type cb_contar_grupos from commandbutton within w_borra_grupos_inscritos_cero
integer x = 119
integer y = 352
integer width = 549
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contar Grupos"
end type

event clicked;long ll_rows, ll_rows_horario

ll_rows = dw_grupos.Retrieve(ii_periodo, ii_anio)
ll_rows_horario = dw_horarios.Retrieve(ii_periodo, ii_anio)

IF ll_rows = -1 THEN
	
	RETURN	
END IF


em_cantidad_materias_lab.text= string(ll_rows)
cb_genera_archivo_gpo.enabled = true


end event

type gb_1 from groupbox within w_borra_grupos_inscritos_cero
integer x = 64
integer y = 268
integer width = 2254
integer height = 260
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
string text = "Grupos con Inscritos Cero"
end type

