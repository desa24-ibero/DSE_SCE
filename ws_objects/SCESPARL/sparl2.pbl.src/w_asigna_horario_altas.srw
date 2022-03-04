$PBExportHeader$w_asigna_horario_altas.srw
forward
global type w_asigna_horario_altas from w_sheet
end type
type p_1 from picture within w_asigna_horario_altas
end type
type st_fecha from statictext within w_asigna_horario_altas
end type
type em_calendar from u_em within w_asigna_horario_altas
end type
type uo_1 from uo_per_ani within w_asigna_horario_altas
end type
type p_uia from picture within w_asigna_horario_altas
end type
type dw_1 from u_dw within w_asigna_horario_altas
end type
type cb_existentes from commandbutton within w_asigna_horario_altas
end type
type cb_susceptibles from commandbutton within w_asigna_horario_altas
end type
type cb_asignar_horarios from commandbutton within w_asigna_horario_altas
end type
type em_existentes from u_em within w_asigna_horario_altas
end type
type em_susceptibles from u_em within w_asigna_horario_altas
end type
type em_asignar_horarios from u_em within w_asigna_horario_altas
end type
end forward

global type w_asigna_horario_altas from w_sheet
integer x = 214
integer width = 2783
integer height = 1590
string title = "Asignación de Horarios de Altas"
string menuname = "m_asigna_horario_altas"
long backcolor = 10789024
p_1 p_1
st_fecha st_fecha
em_calendar em_calendar
uo_1 uo_1
p_uia p_uia
dw_1 dw_1
cb_existentes cb_existentes
cb_susceptibles cb_susceptibles
cb_asignar_horarios cb_asignar_horarios
em_existentes em_existentes
em_susceptibles em_susceptibles
em_asignar_horarios em_asignar_horarios
end type
global w_asigna_horario_altas w_asigna_horario_altas

type variables
boolean ib_existentes= false, ib_susceptibles=false
boolean ib_asignar= false
end variables

forward prototypes
public subroutine wf_habilitacion_botones ()
end prototypes

public subroutine wf_habilitacion_botones ();//wf_habilitacion_botones
//Funcion que habilita/deshabilita los botones en funcion de las operaciones realizadas

if ib_existentes AND ib_susceptibles then
	cb_asignar_horarios.enabled = true
end if

if ib_asignar then
	cb_asignar_horarios.enabled = false	
end if

end subroutine

on w_asigna_horario_altas.create
int iCurrent
call super::create
if this.MenuName = "m_asigna_horario_altas" then this.MenuID = create m_asigna_horario_altas
this.p_1=create p_1
this.st_fecha=create st_fecha
this.em_calendar=create em_calendar
this.uo_1=create uo_1
this.p_uia=create p_uia
this.dw_1=create dw_1
this.cb_existentes=create cb_existentes
this.cb_susceptibles=create cb_susceptibles
this.cb_asignar_horarios=create cb_asignar_horarios
this.em_existentes=create em_existentes
this.em_susceptibles=create em_susceptibles
this.em_asignar_horarios=create em_asignar_horarios
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_1
this.Control[iCurrent+2]=this.st_fecha
this.Control[iCurrent+3]=this.em_calendar
this.Control[iCurrent+4]=this.uo_1
this.Control[iCurrent+5]=this.p_uia
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.cb_existentes
this.Control[iCurrent+8]=this.cb_susceptibles
this.Control[iCurrent+9]=this.cb_asignar_horarios
this.Control[iCurrent+10]=this.em_existentes
this.Control[iCurrent+11]=this.em_susceptibles
this.Control[iCurrent+12]=this.em_asignar_horarios
end on

on w_asigna_horario_altas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.p_1)
destroy(this.st_fecha)
destroy(this.em_calendar)
destroy(this.uo_1)
destroy(this.p_uia)
destroy(this.dw_1)
destroy(this.cb_existentes)
destroy(this.cb_susceptibles)
destroy(this.cb_asignar_horarios)
destroy(this.em_existentes)
destroy(this.em_susceptibles)
destroy(this.em_asignar_horarios)
end on

event open;x=1
y=1
end event

type p_1 from picture within w_asigna_horario_altas
integer x = 618
integer y = 246
integer width = 59
integer height = 83
boolean bringtotop = true
string picturename = "ddarrow.bmp"
boolean focusrectangle = false
end type

event clicked;em_calendar.Event pfc_ddcalendar ( )
end event

type st_fecha from statictext within w_asigna_horario_altas
integer x = 289
integer y = 173
integer width = 285
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Fecha"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_calendar from u_em within w_asigna_horario_altas
integer x = 249
integer y = 246
integer width = 369
integer taborder = 10
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
double increment = 0
string minmax = ""
end type

event constructor;Integer  li_return   

this.text= string(today())
this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_SetInitialValue(TRUE)
this.iuo_calendar.x =92
this.iuo_calendar.y =336

//this.iuo_calendar.of_SetCloseOnClick(FALSE) 
//this.iuo_calendar.of_SetCloseOnDClick(FALSE)  

//li_return = this.Event pfc_DDCalendar()
end event

type uo_1 from uo_per_ani within w_asigna_horario_altas
integer x = 1189
integer y = 51
integer width = 1251
integer height = 166
integer taborder = 50
boolean enabled = true
boolean border = true
long backcolor = 1090519039
borderstyle borderstyle = stylelowered!
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type p_uia from picture within w_asigna_horario_altas
integer x = 2597
integer y = 54
integer width = 88
integer height = 70
boolean originalsize = true
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type dw_1 from u_dw within w_asigna_horario_altas
event type integer ue_valida_row ( long al_row )
event type integer ue_valida_dw ( )
event type integer ue_valida_rep_tras ( long al_row,  time atm_hora,  long al_cuenta_inicial,  long al_cuenta_final )
event type long ue_cuenta_susceptibles ( )
event type long ue_inserta_horario_altas ( )
integer x = 1042
integer y = 336
integer width = 1397
integer height = 666
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_ext_horario_altas"
end type

event ue_valida_row;time ltm_hora_inicio
long ll_cuenta_inicial, ll_cuenta_final

ltm_hora_inicio= this.GetItemTime(al_row,"hora_inicial")

if isnull(ltm_hora_inicio) then
	MessageBox("Hora inicial nula","Es necesario capturar la hora de inicio",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

ll_cuenta_inicial= this.GetItemNumber(al_row,"cuenta_inicial")
if isnull(ll_cuenta_inicial) then
	MessageBox("Cuenta inicial nula","Es necesario capturar la cuenta de inicio",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

ll_cuenta_final= this.GetItemNumber(al_row,"cuenta_final")
if isnull(ll_cuenta_final) then
	MessageBox("Cuenta final nula","Es necesario capturar la cuenta final",StopSign!)
	ScrollToRow(al_row)
	return -1
end if

if ll_cuenta_inicial > ll_cuenta_final then
	MessageBox("Cuenta inicial invalida","Es necesario que a cuenta inicial sea menor a la cuenta final",StopSign!)
	ScrollToRow(al_row)
	return -1
end if


if event ue_valida_rep_tras(al_row, ltm_hora_inicio, ll_cuenta_inicial, ll_cuenta_final) = -1 then
	return -1
end if

return 0
end event

event ue_valida_dw;long ll_row, ll_num_rows

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

event ue_valida_rep_tras;time ltm_hora_inicio
long ll_cuenta_inicial, ll_cuenta_final, ll_num_rows, ll_row


ll_num_rows= this.RowCount()

FOR ll_row= 1 TO ll_num_rows
	IF ll_row <> al_row THEN
		ltm_hora_inicio= this.GetItemTime(ll_row,"hora_inicial")
		ll_cuenta_inicial= this.GetItemNumber(ll_row,"cuenta_inicial")
		ll_cuenta_final= this.GetItemNumber(ll_row,"cuenta_final")
		
		IF	ltm_hora_inicio = atm_hora THEN
			MessageBox("Hora inicial repetida","No se permite repetir la hora de inicio",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF
		
		IF	ll_cuenta_inicial = al_cuenta_inicial THEN
			MessageBox("Cuenta inicial repetida","No se permite repetir la cuenta inicial",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF
		
		IF	ll_cuenta_final = al_cuenta_final THEN
			MessageBox("Cuenta final repetida","No se permite repetir la cuenta final",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF

		IF	ll_cuenta_inicial <= al_cuenta_inicial and al_cuenta_inicial <= ll_cuenta_final THEN
			MessageBox("Cuenta inicial sobrepuesta","No se permite sobreponer la cuenta inicial",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF

		IF	ll_cuenta_inicial <= al_cuenta_final and al_cuenta_final <= ll_cuenta_final THEN
			MessageBox("Cuenta final sobrepuesta","No se permite sobreponer la cuenta final",StopSign!)
			ScrollToRow(ll_row)
			return -1
		END IF

	END IF
NEXT

RETURN 0
end event

event ue_cuenta_susceptibles;time ltm_hora_inicio
long ll_cuenta_inicial, ll_cuenta_final, ll_num_rows, ll_row, ll_cantidad, ll_cantidad_acum


ll_num_rows= this.RowCount()
ll_cantidad_acum= 0
FOR ll_row= 1 TO ll_num_rows
		ltm_hora_inicio= this.GetItemTime(ll_row,"hora_inicial")
		ll_cuenta_inicial= this.GetItemNumber(ll_row,"cuenta_inicial")
		ll_cuenta_final= this.GetItemNumber(ll_row,"cuenta_final")
		ll_cantidad = f_cuenta_rango_cuentas(ll_cuenta_inicial, ll_cuenta_final)
		if isnull(ll_cantidad) then
			ll_cantidad= 0
		elseif ll_cantidad = -1 then
			return -1		
		end if
		ll_cantidad_acum= ll_cantidad_acum+ ll_cantidad
NEXT

RETURN ll_cantidad_acum
end event

event ue_inserta_horario_altas;time ltm_hora_inicio
long ll_cuenta_inicial, ll_cuenta_final, ll_num_rows, ll_row, ll_cantidad, ll_cantidad_acum
datetime ldttm_hora_entrada
date ldt_hora_entrada
string ls_hora_entrada

ll_num_rows= this.RowCount()
ll_cantidad_acum= 0
ls_hora_entrada = em_calendar.text
ldt_hora_entrada = date(ls_hora_entrada)



FOR ll_row= 1 TO ll_num_rows
		ltm_hora_inicio= this.GetItemTime(ll_row,"hora_inicial")
		ll_cuenta_inicial= this.GetItemNumber(ll_row,"cuenta_inicial")
		ll_cuenta_final= this.GetItemNumber(ll_row,"cuenta_final")
		ldttm_hora_entrada= datetime(ldt_hora_entrada, ltm_hora_inicio)
		ll_cantidad = f_inserta_horario_altas(ll_cuenta_inicial, ll_cuenta_final, gi_periodo, gi_anio, ldttm_hora_entrada)
		if isnull(ll_cantidad) then
			ll_cantidad= 0
		elseif ll_cantidad = -1 then
			return -1
		end if
		ll_cantidad_acum= ll_cantidad_acum+ ll_cantidad
NEXT

RETURN ll_cantidad_acum
end event

event constructor;call super::constructor;this.of_SetTransObject(gtr_sce)

end event

type cb_existentes from commandbutton within w_asigna_horario_altas
integer x = 731
integer y = 1216
integer width = 581
integer height = 106
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contar Existentes"
end type

event clicked;long ll_existentes

ib_existentes= true
SetPointer(HourGlass!)
ll_existentes= f_cuenta_horario_altas(gi_periodo, gi_anio, "T")

em_existentes.text = string(ll_existentes)

wf_habilitacion_botones()
end event

type cb_susceptibles from commandbutton within w_asigna_horario_altas
integer x = 1393
integer y = 1216
integer width = 581
integer height = 106
integer taborder = 70
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Contar Susceptibles"
end type

event clicked;long ll_susceptibles


dw_1.AcceptText()

SetPointer(HourGlass!)
if dw_1.event ue_valida_dw() = -1 then
	MessageBox("Horarios Incorrectos","Favor de corregir la información",StopSign!)
	return 
end if


ll_susceptibles = dw_1.event ue_cuenta_susceptibles()

em_susceptibles.text = string(ll_susceptibles)

ib_susceptibles= true

wf_habilitacion_botones()
end event

type cb_asignar_horarios from commandbutton within w_asigna_horario_altas
integer x = 2055
integer y = 1216
integer width = 581
integer height = 106
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Asignar Horarios"
end type

event clicked;long ll_asignados
int li_resultado, li_confirma

li_confirma = MessageBox("Confirmación","¿Desea asignar horario de altas con los criterios establecidos?",Question!, YesNo!)

if li_confirma <> 1 then
	return 
end if

SetPointer(HourGlass!)
li_resultado = f_borra_horario_altas(gi_periodo, gi_anio)

if li_resultado = -1 then
	MessageBox("Error","No es posible borrar el horario de altas",StopSign!)
	return 
end if

SetPointer(HourGlass!)
ll_asignados=  dw_1.event ue_inserta_horario_altas() 

if ll_asignados = -1 then
	MessageBox("Error","No es posible insertar el horario de altas",StopSign!)
	return 
end if

em_asignar_horarios.text = string(ll_asignados)

ib_existentes= false
ib_susceptibles= false
ib_asignar= true

wf_habilitacion_botones()

ib_asignar= false
end event

type em_existentes from u_em within w_asigna_horario_altas
integer x = 863
integer y = 1088
integer width = 315
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
string mask = "###,###"
double increment = 0
string minmax = ""
end type

type em_susceptibles from u_em within w_asigna_horario_altas
integer x = 1525
integer y = 1088
integer width = 315
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
string mask = "###,###"
double increment = 0
string minmax = ""
end type

type em_asignar_horarios from u_em within w_asigna_horario_altas
integer x = 2187
integer y = 1091
integer width = 315
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
fontcharset fontcharset = ansi!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
string mask = "###,###"
double increment = 0
string minmax = ""
end type

