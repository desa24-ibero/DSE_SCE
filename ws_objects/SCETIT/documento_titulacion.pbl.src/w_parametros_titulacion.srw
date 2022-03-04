$PBExportHeader$w_parametros_titulacion.srw
forward
global type w_parametros_titulacion from w_main
end type
type dw_parametros_titulacion from u_dw_captura within w_parametros_titulacion
end type
end forward

global type w_parametros_titulacion from w_main
integer width = 2149
integer height = 1544
string title = "Parámetros de Titulación"
string menuname = "m_menu"
boolean resizable = false
boolean ib_disableclosequery = true
dw_parametros_titulacion dw_parametros_titulacion
end type
global w_parametros_titulacion w_parametros_titulacion

type variables
string is_orden_cobro
long il_cve_relacion, il_cve_tipo_relacion, il_row, ii_num_error_codigo_total
long il_id_titulo=-1, il_n_titulo= -1, il_asigna_codigo= -1
end variables

forward prototypes
public function integer wf_asigna_codigo ()
end prototypes

public function integer wf_asigna_codigo ();return 0
end function

on w_parametros_titulacion.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_parametros_titulacion=create dw_parametros_titulacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_parametros_titulacion
end on

on w_parametros_titulacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_parametros_titulacion)
end on

event open;call super::open;X=1
Y=1
dw_parametros_titulacion.SetTransObject(gtr_sce)
dw_parametros_titulacion.of_SetDropDownCalendar ( true )
dw_parametros_titulacion.iuo_calendar.of_Register("fecha_primera_siguiente_mes", &
  dw_parametros_titulacion.iuo_calendar.DDLB)


dw_parametros_titulacion.iuo_calendar.of_Register("fecha_posgrado", &
  dw_parametros_titulacion.iuo_calendar.DDLB)


dw_parametros_titulacion.event carga()


end event

type dw_parametros_titulacion from u_dw_captura within w_parametros_titulacion
integer x = 78
integer y = 92
integer width = 1861
integer height = 764
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_parametros_titulacion"
boolean hscrollbar = true
boolean vscrollbar = false
end type

event actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
*/
int li_respuesta
/*Acepta el texto de la última columna editada*/

AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","¿Desea actualizar los cambios a los parámetros?",Question!,YesNo!,2)

	if li_respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
				return 1
			else 
				return -1
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if

end event

event actualiza_0_int;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				Este evento no presenta interacción con el usuario
*/

//transaction ltr_trans 
//ltr_trans = Create Transaction
//if GetTrans(ltr_trans) = 1 then
integer li_codigo_sql
long ll_cve_secuencia=1
string ls_mensaje_sql
AcceptText()
if ModifiedCount()+DeletedCount() > 0 Then
/*Función que solo actualiza*/

	if update(true) = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		commit using tr_dw_propio;	
		//destroy ltr_trans
		return 1
	else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using tr_dw_propio;	
		//destroy ltr_trans
		return -1
	end if
	
else
	return 1
end if

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce

end event

