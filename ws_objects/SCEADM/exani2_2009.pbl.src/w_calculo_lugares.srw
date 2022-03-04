$PBExportHeader$w_calculo_lugares.srw
$PBExportComments$Asigna Lugares de acuerdo a los puntajes
forward
global type w_calculo_lugares from w_main
end type
type dw_1 from uo_dw_captura within w_calculo_lugares
end type
type dw_2 from uo_dw_captura within w_calculo_lugares
end type
type dw_3 from uo_dw_captura within w_calculo_lugares
end type
type ddlb_opcion from dropdownlistbox within w_calculo_lugares
end type
type cb_3 from commandbutton within w_calculo_lugares
end type
type st_1 from statictext within w_calculo_lugares
end type
type cb_1 from commandbutton within w_calculo_lugares
end type
type uo_1 from uo_ver_per_ani within w_calculo_lugares
end type
type gb_1 from u_gb within w_calculo_lugares
end type
end forward

global type w_calculo_lugares from w_main
integer x = 832
integer y = 360
integer width = 3854
integer height = 2156
string title = "Cálculo de Lugares Ordenados"
string menuname = "m_menu"
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
ddlb_opcion ddlb_opcion
cb_3 cb_3
st_1 st_1
cb_1 cb_1
uo_1 uo_1
gb_1 gb_1
end type
global w_calculo_lugares w_calculo_lugares

type variables
int carr
end variables

on w_calculo_lugares.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.ddlb_opcion=create ddlb_opcion
this.cb_3=create cb_3
this.st_1=create st_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.ddlb_opcion
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.st_1
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.uo_1
this.Control[iCurrent+9]=this.gb_1
end on

on w_calculo_lugares.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.ddlb_opcion)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.gb_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)
dw_3.settransobject(gtr_sadm)
end event

type dw_1 from uo_dw_captura within w_calculo_lugares
integer y = 544
integer width = 1550
integer height = 1356
integer taborder = 40
string title = "Lugar General"
string dataobject = "dw_lugar_gen_orden"
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;m_menu.dw = this
end event

event carga;st_1.text="Cargando General"

int opcion

IF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=1
else
	opcion=0
END IF

return retrieve(gi_version,gi_periodo,gi_anio,opcion)

st_1.text="Cargando Por Carrera"
carr=9999
dw_2.event carga()
st_1.text="Ya acabe"
end event

type dw_2 from uo_dw_captura within w_calculo_lugares
integer x = 1682
integer y = 544
integer width = 1998
integer height = 1356
integer taborder = 50
string title = "Lugar por Carrera"
string dataobject = "dw_lugar_carr_orden"
borderstyle borderstyle = styleraised!
end type

event carga;int opcion

IF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=1
else
	opcion=0
END IF

return retrieve(gi_version,gi_periodo,gi_anio,carr,opcion)
end event

type dw_3 from uo_dw_captura within w_calculo_lugares
boolean visible = false
integer x = 3278
integer y = 548
integer width = 494
integer height = 792
integer taborder = 30
string dataobject = "dw_carr_exis_orden"
borderstyle borderstyle = styleraised!
end type

event carga;return retrieve(gi_version,gi_periodo,gi_anio)
end event

type ddlb_opcion from dropdownlistbox within w_calculo_lugares
integer x = 2478
integer y = 96
integer width = 398
integer height = 228
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
string item[] = {"NORMAL","DIFERIDOS"}
end type

type cb_3 from commandbutton within w_calculo_lugares
event clicked pbm_bnclicked
integer x = 2322
integer y = 404
integer width = 713
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asigna Lugar por Carrera"
end type

event clicked;long cont1, cont2
integer li_update
SetPointer(HourGlass!)

st_1.text="Cargando Carreras"
dw_3.event carga()

FOR cont2=1 TO dw_3.rowcount()
	st_1.text="Cargando siguiente Carrera"
	carr=dw_3.object.clv_carr[cont2]
	dw_2.event carga()
	FOR cont1=1 TO dw_2.rowcount()
		st_1.text="Asignando Lugar "+string(cont1)+" Carrera "+&
			string(dw_3.object.clv_carr[cont2])
		dw_2.object.lugar_car[cont1]=cont1
	NEXT
	st_1.text="Guardando Cambios"
	
//	dw_2.event actualiza()

	li_update =dw_2.Update()
	
	if li_update = 1 then		
		/*Si fue exitoso*/
		commit using gtr_sadm;	
		st_1.text="Asignación Exitosa["+string(carr)+"]"
		continue
	else
		/*Si no fue exitoso, desecha los cambios (todos) y avisa*/
		rollback using gtr_sadm;	
		//destroy ltr_trans
		st_1.text="Error de Asignación["+string(carr)+"]"
		exit
	end if
NEXT

if li_update = 1 then		
	/*Si es asi, avisa.*/
	MessageBox("Actualización Exitosa","Se asignaron lugares por carrera",Information!)
	st_1.text="Asignación Exitosa"
	return 1
else
	/*De lo contrario, avisa*/
	MessageBox("Error de Actualización","No es posible asignar lugares por carrera",StopSign!)
	st_1.text="Error de Asignación"
	return -1
end if


carr=9999
dw_2.event carga()
st_1.text="Ya acabé"
end event

type st_1 from statictext within w_calculo_lugares
integer x = 942
integer y = 248
integer width = 878
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_calculo_lugares
integer x = 475
integer y = 404
integer width = 626
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asigna Lugar General"
end type

event clicked;long cont, ll_carga,  ll_rows
integer li_update
ll_carga = dw_1.event carga()
SetPointer(HourGlass!)
ll_rows = dw_1.rowcount()

FOR cont=1 TO dw_1.rowcount()
	st_1.text="Asignando Lugar General ["+string(cont)+"]"
	dw_1.object.lugar_gen[cont]=cont
NEXT

st_1.text="Guardando Cambios"
dw_1.event actualiza()

li_update = dw_1.update(true)

if li_update = 1 then		
		/*Si es asi, guardalo en la tabla y avisa.*/
		commit using gtr_sadm;	
		//destroy ltr_trans
		MessageBox("Actualización Exitosa","Se asignaron lugares generales",Information!)
		st_1.text="Asignación Exitosa"
		return 1
else
		/*De lo contrario, desecha los cambios (todos) y avisa*/
		rollback using gtr_sadm;	
		//destroy ltr_trans
		MessageBox("Error de Actualización","No es posible asignar lugares generales",StopSign!)
		st_1.text="Error de Asignación"
		return -1
end if

//st_1.text="Ya acabé"
end event

type uo_1 from uo_ver_per_ani within w_calculo_lugares
integer x = 32
integer y = 44
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type gb_1 from u_gb within w_calculo_lugares
integer x = 2432
integer y = 24
integer width = 485
integer height = 204
integer taborder = 11
string text = "Tipo de Asignación"
end type

