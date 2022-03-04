$PBExportHeader$w_verifica_soloadeudos.srw
forward
global type w_verifica_soloadeudos from window
end type
type uo_1 from uo_per_ani within w_verifica_soloadeudos
end type
type st_1 from statictext within w_verifica_soloadeudos
end type
type cbx_1 from checkbox within w_verifica_soloadeudos
end type
type cb_1 from commandbutton within w_verifica_soloadeudos
end type
end forward

global type w_verifica_soloadeudos from window
integer x = 1038
integer y = 892
integer width = 1371
integer height = 652
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 0
uo_1 uo_1
st_1 st_1
cbx_1 cbx_1
cb_1 cb_1
end type
global w_verifica_soloadeudos w_verifica_soloadeudos

type variables
Datastore dw_band
uo_administrador_liberacion iuo_administrador_liberacion
end variables

on w_verifica_soloadeudos.create
this.uo_1=create uo_1
this.st_1=create st_1
this.cbx_1=create cbx_1
this.cb_1=create cb_1
this.Control[]={this.uo_1,&
this.st_1,&
this.cbx_1,&
this.cb_1}
end on

on w_verifica_soloadeudos.destroy
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
dw_band.retrieve()

st_1.text = string(dw_band.rowcount())+" datos."
//dw_band.SetRowFocusIndicator ( Hand!)

//periodo_actual_insc (gi_periodo,gi_anio)
messagebox(string(gi_periodo)+""+string(gi_anio),"")


if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if

end event

event close;
if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

end event

type uo_1 from uo_per_ani within w_verifica_soloadeudos
integer x = 14
integer y = 364
integer taborder = 21
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_1 from statictext within w_verifica_soloadeudos
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
boolean focusrectangle = false
end type

type cbx_1 from checkbox within w_verifica_soloadeudos
integer x = 128
integer y = 20
integer width = 782
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 0
string text = "Verifica todos los alumnos"
boolean automatic = false
boolean lefttext = true
end type

event clicked;if checked = true then
	dw_band = Create Datastore
	dw_band.DataObject = 'd_banderas_adeuda'
	
	dw_band.settransobject(gtr_sce)
	dw_band.retrieve()
	checked = false
else
	dw_band = Create Datastore
	dw_band.DataObject = 'd_banderas_adeuda2'

	dw_band.settransobject(gtr_sce)
	dw_band.retrieve()	
	checked = true
end if
end event

type cb_1 from commandbutton within w_verifica_soloadeudos
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
int li_file
string ls_ruta, ls_nombre
long ll_cuenta
long ll_tot,ll_i
string ls_control_correcto, ls_nombre_ds

datastore lds_importe_adeudo
if conecta_bd(gtr_scob,gs_scob,gs_usuario,gs_password) = 0 then
	return
end if

if conecta_bd(ltr_sfeb,gs_sfeb,gs_usuario,gs_password) = 0 then
	return
end if

ls_nombre_ds = "d_importe_adeudo"

IF iuo_administrador_liberacion.of_liberacion_vigente("SIT") THEN
	IF iuo_administrador_liberacion.of_obten_control_correcto("SIT","sparl","d_importe_adeudo", "datawindow", ls_control_correcto) THEN
		ls_nombre_ds = ls_control_correcto
	END IF
END IF

lds_importe_adeudo = Create DataStore
lds_importe_adeudo.DataObject = ls_nombre_ds
lds_importe_adeudo.SetTransObject(gtr_scob)

if (GetFileSaveName ( "Guardar reporte de adeudos", ls_ruta,&
							ls_nombre , ".txt" ,"Archivos de texto (*.TXT),*.TXT," )= 1 ) then
	li_file = FileOpen(ls_ruta, LineMode!, Write!, LockReadWrite!, Replace!)
	ll_tot = dw_band.rowcount()
	st_1.text = "Se actualizarán "+string(ll_tot)+" datos."
	for ll_i = 1 to ll_tot
		ll_cuenta = dw_band.getitemnumber(ll_i,"cuenta")
		if ( (tiene_adeudos(ll_cuenta,gtr_scob) = 0) ) then
				dw_band.setitem(ll_i,"adeuda_finanzas",0)
		else
				dw_band.setitem(ll_i,"adeuda_finanzas",1)
				lds_importe_adeudo.Retrieve(ll_cuenta)
				FileWrite(li_file, string(ll_cuenta)+"~t"+obten_digito(ll_cuenta)+"~t"+&
				string(lds_importe_adeudo.GetItemNumber(1,"importe_adeudo")))
		end if
		st_1.text = string(ll_i)+" de "+string(ll_tot)
	next
	if dw_band.update(TRUE) = 1 then
		st_1.text = "Se actualizaron "+string(ll_tot)+" datos."
		if messagebox("Aceptado","Se actualizo la información.~nDesea aceptar esta modificación?",Question!,YesNo!,1) = 1 then
			commit using gtr_sce;
			messagebox("Aceptado","OK")
		else
			rollback using gtr_sce;
			messagebox("No hubo cambios","OK")
		end if				
	else
		rollback using gtr_sce;
		messagebox("ERROR al Actualizar",gtr_sce.sqlerrtext)
	end if
	FileClose(li_file)
end if
Destroy lds_importe_adeudo
desconecta_bd(gtr_scob)
Destroy ltr_sfeb




end event

