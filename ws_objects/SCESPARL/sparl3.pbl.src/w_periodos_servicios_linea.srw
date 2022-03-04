$PBExportHeader$w_periodos_servicios_linea.srw
forward
global type w_periodos_servicios_linea from w_master
end type
type dw_1 from u_dw within w_periodos_servicios_linea
end type
end forward

global type w_periodos_servicios_linea from w_master
integer x = 466
integer y = 372
integer width = 3109
integer height = 1389
string title = "Periodos para Servicios en Línea"
string menuname = "m_periodos_servicios_linea"
dw_1 dw_1
end type
global w_periodos_servicios_linea w_periodos_servicios_linea

on w_periodos_servicios_linea.create
int iCurrent
call super::create
if this.MenuName = "m_periodos_servicios_linea" then this.MenuID = create m_periodos_servicios_linea
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_periodos_servicios_linea.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.event pfc_retrieve()
end event

type dw_1 from u_dw within w_periodos_servicios_linea
event type integer ue_valida_dw ( )
event type integer ue_valida_row ( long al_row )
integer x = 66
integer y = 74
integer width = 2911
integer height = 1062
integer taborder = 10
string dataobject = "d_periodos_servicios_linea"
boolean hscrollbar = true
end type

event type integer ue_valida_dw();// event ue_valida_dw
long ll_row, ll_num_rows

ll_num_rows = this.RowCount()

if ll_num_rows <= 0 then
	MessageBox("No existen horarios","Es necesario capturar al menos un horario",StopSign!)
	return -1
end if

for ll_row = 1 to ll_num_rows
	if event ue_valida_row(ll_row) = -1 then
		return -1
	end if
next

return 0




end event

event type integer ue_valida_row(long al_row);//event ue_valida_row;
datetime ldttm_fecha_inicial, ldttm_fecha_final, ldttm_fecha_inicial_row, ldttm_fecha_final_row
long ll_cve_menu, ll_row_actual, ll_num_rows, ll_cve_menu_row
string ls_liga, ls_liga_row

ldttm_fecha_inicial= this.GetItemDatetime(al_row,"fecha_inicial")
ldttm_fecha_final= this.GetItemDatetime(al_row,"fecha_final")
ls_liga= this.GetItemString(al_row,"liga")
ll_cve_menu= this.GetItemNumber(al_row,"cve_menu")


if isnull(ldttm_fecha_inicial) then
	MessageBox("Fecha inicial nula","Es necesario capturar la fecha inicial",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

if isnull(ldttm_fecha_final) then
	MessageBox("Fecha final nula","Es necesario capturar la fecha final",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

if isnull(ll_cve_menu) then
	MessageBox("Clave de Menú nula","Es necesario capturar la clave de menu",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

if isnull(ls_liga) then
	MessageBox("Liga nula","Es necesario capturar la liga",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

if ldttm_fecha_inicial > ldttm_fecha_final then
	MessageBox("Fecha inicial inválida","Es necesario que la fecha inicial sea menor a la fecha final",StopSign!)
	ScrollToRow(al_row)
	return -1
end if
ll_num_rows= this.RowCount()

for ll_row_actual=1 to ll_num_rows
	if ll_row_actual <> al_row then
		ldttm_fecha_inicial_row= this.GetItemDatetime(ll_row_actual,"fecha_inicial")
		ldttm_fecha_final_row= this.GetItemDatetime(ll_row_actual,"fecha_final")
		ls_liga_row= this.GetItemString(ll_row_actual,"liga")
		ll_cve_menu_row= this.GetItemNumber(ll_row_actual,"cve_menu")
		if ll_cve_menu_row= ll_cve_menu then
			if (ldttm_fecha_inicial_row <= ldttm_fecha_inicial and ldttm_fecha_inicial<= ldttm_fecha_final_row) or &
				(ldttm_fecha_inicial_row <= ldttm_fecha_final and ldttm_fecha_final<= ldttm_fecha_final_row) then
					MessageBox("Rango de fechas inválido","No se permite traslapar fechas entre menús",StopSign!)
					ScrollToRow(al_row)
					return -1			
			elseif (ldttm_fecha_inicial <= ldttm_fecha_inicial_row and ldttm_fecha_inicial_row<= ldttm_fecha_final) or &
					(ldttm_fecha_inicial <= ldttm_fecha_final_row and ldttm_fecha_final_row<= ldttm_fecha_final) then
					MessageBox("Rango de fechas inválido","No se permite traslapar fechas entre menús",StopSign!)
					ScrollToRow(al_row)
					return -1			
			end if
		end if		
	end if	
next

return 0


end event

event constructor;call super::constructor;THIS.SetTransObject(gtr_sce)
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("fecha_inicial", &
  this.iuo_calendar.DDLB)
this.iuo_calendar.of_Register("fecha_final", &
  this.iuo_calendar.DDLB)


end event

event type long pfc_retrieve();call super::pfc_retrieve;return this.retrieve()
end event

event type integer ue_actualiza();// Personalizado para los catálogos del SIT
// Juan Campos Sánchez.
// Regresa: 1 si hace los cambios en la base de datos
// Cambios al objeto de transaccion para que permita modificar en
//	Control Escolar
// Julio-2001.
 
//if this.ModifiedCount() + this.DeletedCount() > 0 then 
	if this.Event ue_valida_dw() = 0 then 
		if this.Event pfc_Update(true,true) >= 1 then 
			commit using gtr_sce;
			Messagebox("Aviso","Los cambios fueron guardados")
			return 1
		else
			rollback using gtr_sce;
			Messagebox("Antención","~nAlgunos datos no son validos~n~nLos cambios NO se guardaron")	
			return 0
		end if
	else
		return 0
	end if
//else
//	return FAILURE 
//end if

end event

