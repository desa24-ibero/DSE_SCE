$PBExportHeader$w_solicitud_certificado.srw
forward
global type w_solicitud_certificado from w_doc_ole_tramite_todos
end type
type dw_solicitud_certificado from u_dw_captura within w_solicitud_certificado
end type
end forward

global type w_solicitud_certificado from w_doc_ole_tramite_todos
string title = "Solicitud de Certificados"
event metodo01 ( )
dw_solicitud_certificado dw_solicitud_certificado
end type
global w_solicitud_certificado w_solicitud_certificado

type variables
long il_cuenta=0, il_cve_documento=0, il_cve_carrera=0, il_cve_plan=0
str_alumno_opc_cero ist_parametros
end variables

event metodo01();long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan
long ll_row, ll_rows
integer li_res, li_cve_doc_control_sep
str_alumno_opc_cero lst_parametros
string ls_StringParm, ls_tipo_certificado, ls_nivel
long ll_cve_opcion_terminal, ll_cve_sem_tit, ll_cve_proy_opc_term
boolean lb_curso_opcion_terminal = false
integer li_res_parcial
long ll_cve_subsistema, ll_subsistema_especial, ll_tiene_mats_revalidadas
integer li_confirmacion

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)
ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)

if il_cuenta<>ll_cuenta and ll_cve_carrera= il_cve_carrera then
	dw_solicitud_certificado.Reset()
end if	
il_cuenta = ll_cuenta
il_cve_documento = ll_cve_documento
il_cve_carrera = ll_cve_carrera
il_cve_plan = ll_cve_plan

if ls_nivel= "L" then
	ll_rows= dw_documento_titulacion.Retrieve(12)
elseif ls_nivel= "P" then
	ll_rows= dw_documento_titulacion.Retrieve(13)
end if


li_res=1

if li_res = 1 then
	
	lst_parametros.cuenta = ll_cuenta
	lst_parametros.cve_carrera = ll_cve_carrera
	lst_parametros.cve_plan = ll_cve_plan
	lst_parametros.procede_tramite = true
	lst_parametros.revisa_cobranzas = false
	
	ist_parametros.cuenta = ll_cuenta
	ist_parametros.cve_carrera = ll_cve_carrera
	ist_parametros.cve_plan = ll_cve_plan
	ist_parametros.procede_tramite = true
	ist_parametros.revisa_cobranzas = false

	ll_cve_subsistema = f_obten_subsistema(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	
	if	ll_cve_subsistema= -1 then
		MessageBox("No es posible ver consultar el subsistema", "No se permite solicitar certificado",StopSign!)
		return			
	end if
	
	ll_subsistema_especial = f_subsistema_especial(ll_cve_subsistema, ll_cve_carrera, ll_cve_plan)

	if	ll_subsistema_especial= 1 then
		MessageBox("Subsistema Especial", "Favor de validar las materias del certificado con subsistema especial",StopSign!)
		li_confirmacion = MessageBox("Confirmación de Subsistema Especial", "¿Desea generar de todos modos la solicitud?",Question!,YesNo!,2)
		if li_confirmacion = 2 then
			return
		end if
	end if
	
	ll_tiene_mats_revalidadas = of_tiene_mats_revalidadas(ll_cuenta, ll_cve_carrera, ll_cve_plan)

	if	ll_tiene_mats_revalidadas= -1 then
		MessageBox("No es posible ver consultar las materias revalidadas", "No se permite solicitar certificado",StopSign!)
		return		
	elseif ll_tiene_mats_revalidadas >= 1 then
		MessageBox("Alumno con materias revalidadas", "Favor de validar la carta de revalidación",StopSign!)
		li_confirmacion = MessageBox("Confirmación de Revalidación", "¿Desea generar de todos modos la solicitud?",Question!,YesNo!,2)
		if li_confirmacion = 2 then
			return
		end if				
	end if
	
	
	OpenWithParm(w_diagnostico_certificado, lst_parametros, this)
	//Si el plan de estudios es ANTIGUO o NUEVO
	if ll_cve_plan = 1 or ll_cve_plan = 2 then		
		if obten_cve_opcion_terminal(ll_cve_carrera, ll_cve_plan, ll_cve_opcion_terminal, ll_cve_sem_tit, ll_cve_proy_opc_term) then
			lb_curso_opcion_terminal = curso_opcterm(ll_cuenta, ll_cve_opcion_terminal)
		else
			MessageBox("No es posible ver la opcion terminal", "No se permite solicitar certificado",StopSign!)
			return			
		end if
	end if
	
	ls_StringParm =Message.StringParm
	if LOWER(ls_StringParm)="bloqueo" then
		dw_solicitud_certificado.Reset()
		MessageBox("Bloqueos encontrados", "No se permite solicitar certificados",StopSign!)
		return
	elseif LOWER(ls_StringParm)="si" then
		li_cve_doc_control_sep= 1
		ls_tipo_certificado= "CERTIFICADO TOTAL"
	else
		li_cve_doc_control_sep= 2		
		ls_tipo_certificado = "CERTIFICADO PARCIAL"
	end if

	if ll_cve_plan = 1 or ll_cve_plan = 2 then		
		if not lb_curso_opcion_terminal then
			li_res_parcial=  MessageBox("No se ha cargado la opcion terminal", "¿Desea solicitar un certificado PARCIAL?",Question!, YesNo!,2)
			if li_res_parcial= 2 then
				MessageBox("Requiere carga de Opción Terminal", "Por favor contacte al personal de Certificación",StopSign!)				
				return
			end if
		end if
	end if	
	
	MessageBox("Tipo de certificado",&
		"El alumno tendrá un ["+ls_tipo_certificado+"]", Information!)
end if

ll_row = dw_solicitud_certificado.InsertRow(0)

dw_solicitud_certificado.ScrollToRow(ll_row)
dw_solicitud_certificado.SetItem(ll_row,"cuenta",ll_cuenta)
dw_solicitud_certificado.SetItem(ll_row,"cve_carrera",ll_cve_carrera)
dw_solicitud_certificado.SetItem(ll_row,"cve_plan",ll_cve_plan)
dw_solicitud_certificado.SetItem(ll_row,"cve_doc_control_sep",li_cve_doc_control_sep)

//if ls_nivel = "L" then
if ls_nivel <> "P" then
	if of_tiene_mats_revalidadas(ll_cuenta, ll_cve_carrera, ll_cve_plan)>0 then
		MessageBox("Alumno con materias revalidadas",&
			"Es necesario capturarle al alumno información adicional", Information!)		
		dw_solicitud_certificado.ScrollToRow(ll_row)
	end if
end if


end event

on w_solicitud_certificado.create
int iCurrent
call super::create
this.dw_solicitud_certificado=create dw_solicitud_certificado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_solicitud_certificado
end on

on w_solicitud_certificado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_solicitud_certificado)
end on

event open;call super::open;long ll_rows

dw_documento_titulacion.SetTransObject(gtr_sce)
ll_rows= dw_documento_titulacion.Retrieve(12)
iuo_atencion_opc_cero = CREATE uo_atencion_opc_cero
x=1
y=1
dw_solicitud_certificado.SetTransObject(gtr_sce)
end event

type uo_datos_opc_cero_i from w_doc_ole_tramite_todos`uo_datos_opc_cero_i within w_solicitud_certificado
integer taborder = 10
end type

type cb_seleccion from w_doc_ole_tramite_todos`cb_seleccion within w_solicitud_certificado
boolean visible = false
integer y = 1384
integer taborder = 0
end type

type st_3 from w_doc_ole_tramite_todos`st_3 within w_solicitud_certificado
integer y = 1412
end type

type uo_tipo_documento from w_doc_ole_tramite_todos`uo_tipo_documento within w_solicitud_certificado
boolean visible = false
integer y = 1384
integer taborder = 0
end type

type ole_documento from w_doc_ole_tramite_todos`ole_documento within w_solicitud_certificado
integer y = 592
integer height = 480
integer taborder = 0
end type

type dw_documento_titulacion from w_doc_ole_tramite_todos`dw_documento_titulacion within w_solicitud_certificado
integer y = 300
integer width = 2843
integer height = 224
integer taborder = 20
boolean vscrollbar = false
end type

event dw_documento_titulacion::doubleclicked;long ll_cuenta, ll_cve_documento, ll_cve_carrera, ll_cve_plan
integer li_res
string ls_query_datos, ls_query_definicion, ls_columnas_marcas[], ls_valores[], ls_nivel
boolean lb_procede_tramite, lb_alumno_susceptible

ll_cuenta = uo_datos_opc_cero_i.of_obten_cuenta()
ll_cve_carrera = uo_datos_opc_cero_i.of_obten_cve_carrera()
ll_cve_plan= uo_datos_opc_cero_i.of_obten_cve_plan(ll_cuenta)
ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)

//if uo_datos_opc_cero_i.il_cuenta

//lb_procede_tramite = uo_datos_opc_cero_i.of_procede_tramite()
//lb_alumno_susceptible =iuo_atencion_opc_cero.of_alumno_susceptible(ll_cuenta, ll_cve_carrera, ll_cve_plan)

if isnull(ll_cuenta) or isnull(ll_cve_carrera) or isnull(ll_cve_plan) or &
     ll_cuenta=0 or   ll_cve_carrera=0 or  ll_cve_plan  =0  then
	MessageBox("Error","El alumno no ha sido correctamente elegido",StopSign!)
	return
end if

//if not lb_procede_tramite or not lb_alumno_susceptible then
//	MessageBox("Error","El alumno no es susceptible del trámite",StopSign!)
//	return
//end if
//

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
		//if ls_nivel = "L" then
		if ls_nivel <> "P" then
			if ole_documento.of_imprime_documento(42, ls_valores, false,false) =0 and &
			   ole_documento.of_imprime_documento(43, ls_valores, false,false) =0 then
				MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
			end if
		elseif ls_nivel = "P" then
			if ole_documento.of_imprime_documento(44, ls_valores, false,false) =0 and &
				ole_documento.of_imprime_documento(45, ls_valores, false,false) =0 then
				MessageBox("Impresion Exitosa", "El documento se ha impreso exitosamente",Information!)
			end if
		end if
	end if
end if

end event

type dw_solicitud_certificado from u_dw_captura within w_solicitud_certificado
event type integer ue_valida_registros ( )
integer x = 64
integer y = 1104
integer width = 2848
integer height = 372
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_solicitud_certificado"
end type

event type integer ue_valida_registros();//ue_valida_registros
//Regresa -1 Si hubo un valor inválido

long ll_row, ll_rows, ll_incorporado_sep
long ll_cve_doc_control_sep, ll_legalizado, ll_cuenta, ll_cve_carrera, ll_cve_plan

ll_rows = this.RowCount()

if ll_rows> 0 then
	FOR ll_row=1 TO ll_rows
		ll_cuenta = this.GetItemNumber(ll_row, "cuenta")
		ll_cve_carrera = this.GetItemNumber(ll_row, "cve_carrera")
		ll_cve_plan = this.GetItemNumber(ll_row, "cve_plan")
		ll_cve_doc_control_sep = this.GetItemNumber(ll_row, "cve_doc_control_sep")
		ll_legalizado = this.GetItemNumber(ll_row, "legalizado")
		//SI ES UN CERTIFICADO TOTAL LEGALIZADO
		if ll_cve_doc_control_sep=1 and ll_legalizado=1 then
			if of_existe_alumno_certificacion(ll_cuenta, ll_cve_carrera,  ll_cve_doc_control_sep, ll_legalizado) >=1 then
				MessageBox("Certificado Total Legalizado preexistente","Favor de validar con Certificación si se autoriza el certificado",StopSign!)
				this.ScrollToRow(ll_row)				
			return -1
			end if
		end if
		ll_incorporado_sep =f_incorporado_sep(ll_cve_carrera, ll_cve_plan)
		//Si piden un plan NO INCORPORADO y LEGALIZADO, es un error
		if ll_incorporado_sep= 0 and ll_legalizado= 1 then
			MessageBox("Carrera no Incorporada con Certificado Legalizado","No se permite solicitar un certificado de estas características",StopSign!)
			this.ScrollToRow(ll_row)				
			return -2
		elseif ll_incorporado_sep = -1 then
			MessageBox("Error en Plan de Estudios","No es posible consultar el plan de estudios correspondiente",StopSign!)
			this.ScrollToRow(ll_row)				
			return -2			
		end if
	NEXT
end if

return 0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio= gtr_sce
end event

event ue_actualiza;// Personalizado para los catálogos
// Regresa: 1 si hace los cambios en la base de datos
// Cambios al objeto de transaccion para que permita modificar en
//	Control Escolar

integer li_valida_registros, li_confirmacion, li_cve_doc_control_sep
long 		ll_cuenta, ll_cve_carrera, ll_cve_plan, ll_legalizado, ll_row, ll_rows
string	ls_nivel 
datetime	ldttm_fecha_solicitud 
				 

if this.ModifiedCount() + this.DeletedCount() > 0 then 
	li_valida_registros = event ue_valida_registros()
	if li_valida_registros = -1 then
		li_confirmacion = MessageBox("Confirmación de tramite repetido", "¿Desea guardar de todos modos la solicitud?",Question!,YesNo!,2)
	elseif li_valida_registros = -2 then
		li_confirmacion = MessageBox("Error","No es posible almacenar", StopSign!)
		return 0
	end if
	if li_valida_registros<> -1 or li_confirmacion = 1 then
		if this.Event pfc_Update(true,true) >= 1 then 
			commit using tr_dw_propio;
			Messagebox("Aviso","Los cambios fueron guardados")
			ll_rows = this.RowCount()
//			for ll_row = 1 to ll_rows 				
//				ll_cuenta = dw_solicitud_certificado.GetItemNumber(ll_row,"cuenta")
//				ll_cve_carrera = dw_solicitud_certificado.GetItemNumber(ll_row,"cve_carrera")
//				ll_cve_plan	= dw_solicitud_certificado.GetItemNumber(ll_row,"cve_plan")
//				ls_nivel = f_obten_nivel_carrera(ll_cve_carrera)
//				ll_legalizado = dw_solicitud_certificado.GetItemNumber(ll_row,"legalizado")
//				SetNull(ldttm_fecha_solicitud)
//				li_cve_doc_control_sep = dw_solicitud_certificado.GetItemNumber(ll_row,"cve_doc_control_sep")
//				//Inserta el certificado en cuestion
//				if f_inserta_certificado_vent(ll_cuenta, ll_cve_carrera, ll_cve_plan, li_cve_doc_control_sep, ll_legalizado, ldttm_fecha_solicitud) = -1 then
//					MessageBox("Error de inserción","No es posible insertar el certificado en cuestión",StopSign!)
//					return -1	
//				end if				
//			next
			
			return 1
		else
			rollback using gtr_sce;
			Messagebox("Antención","~nAlgunos datos no son validos~n~nLos cambios NO se guardaron")	
			return 0
		end if
	else
		return 0
	end if	
else
	return FAILURE 
end if

end event

event asigna_dw_menu;return
end event

