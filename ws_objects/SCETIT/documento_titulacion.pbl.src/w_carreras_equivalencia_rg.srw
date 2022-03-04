$PBExportHeader$w_carreras_equivalencia_rg.srw
forward
global type w_carreras_equivalencia_rg from w_main
end type
type dw_carreras_equivalencia_rg from u_dw_captura within w_carreras_equivalencia_rg
end type
end forward

global type w_carreras_equivalencia_rg from w_main
integer width = 3077
integer height = 1008
string title = "Carreras Equivalencia R.G."
string menuname = "m_menu"
boolean ib_disableclosequery = true
dw_carreras_equivalencia_rg dw_carreras_equivalencia_rg
end type
global w_carreras_equivalencia_rg w_carreras_equivalencia_rg

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

on w_carreras_equivalencia_rg.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_carreras_equivalencia_rg=create dw_carreras_equivalencia_rg
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_carreras_equivalencia_rg
end on

on w_carreras_equivalencia_rg.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_carreras_equivalencia_rg)
end on

event open;call super::open;
X=1
Y=1
dw_carreras_equivalencia_rg.SetTransObject(gtr_sce)

dw_carreras_equivalencia_rg.event carga()


end event

type dw_carreras_equivalencia_rg from u_dw_captura within w_carreras_equivalencia_rg
integer x = 78
integer y = 92
integer width = 2830
integer height = 596
integer taborder = 20
boolean bringtotop = true
string dataobject = "d_carreras_equivalencia_rg"
boolean hscrollbar = true
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
long ll_row, ll_rows, ll_incorporado_sep_libre, ll_incorporado_sep_rg
long ll_cve_carrera_libre, ll_cve_plan_libre, ll_cve_carrera_rg, ll_cve_plan_rg
long ll_existe_plan_libre, ll_existe_plan_rg
string ls_mensaje_sql

AcceptText()
ll_rows = this.Rowcount()
FOR ll_row= 1 TO ll_rows
	ll_cve_carrera_libre = this.GetItemNumber(ll_row, "cve_carrera_libre")
	ll_cve_plan_libre = this.GetItemNumber(ll_row, "cve_plan_libre")
	
	ll_existe_plan_libre = f_existe_plan(ll_cve_carrera_libre, ll_cve_plan_libre)
	IF ll_existe_plan_libre= -1 THEN
		MessageBox("Error en R.G.", "No es posible consultar el posgrado R.G.", StopSign!)
		ScrollToRow(ll_row)
		return -1
	ELSEIF ll_existe_plan_libre= 0 THEN
		MessageBox("Error en R.G.", "El plan de estudios del primer Posgrado no existe", StopSign!)
		ScrollToRow(ll_row)
		return -1
	END IF
	
	ll_incorporado_sep_libre = f_incorporado_sep(ll_cve_carrera_libre, ll_cve_plan_libre)
	IF ll_incorporado_sep_libre= -1 THEN
		MessageBox("Error en Libre", "No es posible consultar el posgrado libre", StopSign!)
		ScrollToRow(ll_row)
		return -1
	ELSEIF ll_incorporado_sep_libre= 1 THEN
		MessageBox("Error en Libre", "El primer Posgrado debe ser libre", StopSign!)
		ScrollToRow(ll_row)
		return -1
	END IF
	
	ll_cve_carrera_rg = this.GetItemNumber(ll_row, "cve_carrera_rg")
	ll_cve_plan_rg = this.GetItemNumber(ll_row, "cve_plan_rg")
	ll_existe_plan_rg = f_existe_plan(ll_cve_carrera_rg, ll_cve_plan_rg)
	IF ll_existe_plan_rg= -1 THEN
		MessageBox("Error en R.G.", "No es posible consultar el posgrado R.G.", StopSign!)
		ScrollToRow(ll_row)
		return -1
	ELSEIF ll_existe_plan_rg= 0 THEN
		MessageBox("Error en R.G.", "El plan de estudios del segundo Posgrado no existe", StopSign!)
		ScrollToRow(ll_row)
		return -1
	END IF
	
	ll_incorporado_sep_rg = f_incorporado_sep(ll_cve_carrera_rg, ll_cve_plan_rg)
	IF ll_incorporado_sep_rg= -1 THEN
		MessageBox("Error en R.G.", "No es posible consultar el posgrado R.G.", StopSign!)
		ScrollToRow(ll_row)
		return -1
	ELSEIF ll_incorporado_sep_rg= 0 THEN
		MessageBox("Error en R.G.", "El segundo Posgrado debe ser incorporado", StopSign!)
		ScrollToRow(ll_row)
		return -1
	END IF
	
NEXT



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

