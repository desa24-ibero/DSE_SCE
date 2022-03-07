﻿$PBExportHeader$w_verifica_adeudos2.srw
forward
global type w_verifica_adeudos2 from window
end type
type uo_1 from uo_per_ani within w_verifica_adeudos2
end type
type st_1 from statictext within w_verifica_adeudos2
end type
type cbx_1 from checkbox within w_verifica_adeudos2
end type
type cb_1 from commandbutton within w_verifica_adeudos2
end type
end forward

global type w_verifica_adeudos2 from window
integer x = 1038
integer y = 892
integer width = 1371
integer height = 652
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 29534863
uo_1 uo_1
st_1 st_1
cbx_1 cbx_1
cb_1 cb_1
end type
global w_verifica_adeudos2 w_verifica_adeudos2

type variables
Datastore dw_band
end variables

on w_verifica_adeudos2.create
this.uo_1=create uo_1
this.st_1=create st_1
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.Control[]={this.uo_1,&
this.st_1,&
this.cbx_1,&
this.cb_1}
end on

on w_verifica_adeudos2.destroy
destroy(this.uo_1)
destroy(this.st_1)
destroy(this.cbx_1)
destroy(this.cb_1)
end on

event open;x = 1038
y = 893
dw_band = Create Datastore
dw_band.DataObject = 'd_banderas_adeuda'

dw_band.settransobject(gtr_sce)
dw_band.retrieve(gs_tipo_periodo) 

st_1.text = string(dw_band.rowcount())+" datos."
//dw_band.SetRowFocusIndicator ( Hand!)

//periodo_actual_insc (gi_periodo,gi_anio)
messagebox(string(gi_periodo)+"-"+string(gi_anio),"")
end event

type uo_1 from uo_per_ani within w_verifica_adeudos2
integer x = 14
integer y = 364
integer taborder = 21
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_1 from statictext within w_verifica_adeudos2
integer x = 96
integer y = 268
integer width = 832
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_verifica_adeudos2
integer x = 128
integer y = 20
integer width = 782
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Verifica todos los alumnos"
boolean automatic = false
boolean lefttext = true
end type

event clicked;if checked = true then
	dw_band = Create Datastore
	dw_band.DataObject = 'd_banderas_adeuda'
	
	dw_band.settransobject(gtr_sce)
	dw_band.retrieve(gs_tipo_periodo)
	checked = false
else
	dw_band = Create Datastore
	dw_band.DataObject = 'd_banderas_adeuda2'

	dw_band.settransobject(gtr_sce)
	dw_band.retrieve(gs_tipo_periodo)	
	checked = true
end if


st_1.text = string(dw_band.rowcount())+" datos."
end event

type cb_1 from commandbutton within w_verifica_adeudos2
integer x = 105
integer y = 140
integer width = 827
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Verifica adeudos de Alumnos"
end type

event clicked;transaction ltr_scob, ltr_sfeb
long ll_cuenta
long ll_tot,ll_i
if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password) = 0 then
//if conecta_bd(gtr_scob,"scob","sa",gs_password) = 0 then
	return
end if

if conecta_bd(ltr_sfeb,gs_sfeb,gs_usuario,gs_password) = 0 then
//if conecta_bd(ltr_sfeb,"sfeb","sa",gs_password) = 0 then
	return
end if


//open(w_status)
//w_status.title = "Porcentaje verificación"
ll_tot = dw_band.rowcount()
st_1.text = "Se actualizarán "+string(ll_tot)+" datos."
for ll_i = 1 to ll_tot
	ll_cuenta = dw_band.getitemnumber(ll_i,"cuenta")
	if ( (tiene_adeudos(ll_cuenta,gtr_scob) = 0) AND &
		( (pago_inscripcion(ll_cuenta, gi_anio ,gi_periodo, gtr_scob) = 1) OR (f_pago_anticipado(ll_cuenta,  gtr_scob) = 1 ) OR (tiene_beca(ll_cuenta,gi_anio,gi_periodo, ltr_sfeb) = 100) )) then
			dw_band.setitem(ll_i,"adeuda_finanzas",0)
	else
			dw_band.setitem(ll_i,"adeuda_finanzas",1)
	end if
	//w_status.altera_nivel(ll_i,ll_tot + 5)
	st_1.text = string(ll_i)+" de "+string(ll_tot)
next

if dw_band.update(TRUE) = 1 then
	//w_status.altera_nivel(ll_i + 5,ll_tot + 5)
	//close(w_status)
	st_1.text = "Se actualizaron "+string(ll_tot)+" datos."
	if messagebox("Aceptado","Se actualizo la información.~nDesea aceptar esta modificación?",Question!,YesNo!,1) = 1 then
		commit using gtr_sce;
		messagebox("Aceptado","OK")
	else
		rollback using gtr_sce;
		messagebox("No hubo cambios","OK")
	end if				
else
	//close(w_status)
	rollback using gtr_sce;
	messagebox("ERROR al Actualizar",gtr_sce.sqlerrtext)
end if
desconecta_bd(gtr_scob)
desconecta_bd(ltr_sfeb)
Destroy ltr_sfeb



end event
