$PBExportHeader$uo_aspirante_revalidacion_org_pb10.sru
forward
global type uo_aspirante_revalidacion_org_pb10 from userobject
end type
type rb_buscar from radiobutton within uo_aspirante_revalidacion_org_pb10
end type
type rb_edicion from radiobutton within uo_aspirante_revalidacion_org_pb10
end type
type st_2 from statictext within uo_aspirante_revalidacion_org_pb10
end type
type st_1 from statictext within uo_aspirante_revalidacion_org_pb10
end type
type st_nombre from statictext within uo_aspirante_revalidacion_org_pb10
end type
type st_amaterno from statictext within uo_aspirante_revalidacion_org_pb10
end type
type st_apaterno from statictext within uo_aspirante_revalidacion_org_pb10
end type
type em_nombre from editmask within uo_aspirante_revalidacion_org_pb10
end type
type em_amaterno from editmask within uo_aspirante_revalidacion_org_pb10
end type
type em_apaterno from editmask within uo_aspirante_revalidacion_org_pb10
end type
type em_folio from editmask within uo_aspirante_revalidacion_org_pb10
end type
type em_digito from editmask within uo_aspirante_revalidacion_org_pb10
end type
type em_cuenta from editmask within uo_aspirante_revalidacion_org_pb10
end type
type rr_1 from roundrectangle within uo_aspirante_revalidacion_org_pb10
end type
end forward

global type uo_aspirante_revalidacion_org_pb10 from userobject
integer width = 2386
integer height = 448
boolean border = true
long backcolor = 79741120
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
rb_buscar rb_buscar
rb_edicion rb_edicion
st_2 st_2
st_1 st_1
st_nombre st_nombre
st_amaterno st_amaterno
st_apaterno st_apaterno
em_nombre em_nombre
em_amaterno em_amaterno
em_apaterno em_apaterno
em_folio em_folio
em_digito em_digito
em_cuenta em_cuenta
rr_1 rr_1
end type
global uo_aspirante_revalidacion_org_pb10 uo_aspirante_revalidacion_org_pb10

type variables
str_aspi_alum_revalid istr_aspirante
integer ii_moviendo_cuenta, ii_cuenta_valida
integer  ii_moviendo_folio, ii_folio_valido
integer ii_limpiando_nombre, ii_elegi_para_nuevo
long il_cuenta, il_folio
string is_apaterno, is_amaterno, is_nombre

end variables

on uo_aspirante_revalidacion_org_pb10.create
this.rb_buscar=create rb_buscar
this.rb_edicion=create rb_edicion
this.st_2=create st_2
this.st_1=create st_1
this.st_nombre=create st_nombre
this.st_amaterno=create st_amaterno
this.st_apaterno=create st_apaterno
this.em_nombre=create em_nombre
this.em_amaterno=create em_amaterno
this.em_apaterno=create em_apaterno
this.em_folio=create em_folio
this.em_digito=create em_digito
this.em_cuenta=create em_cuenta
this.rr_1=create rr_1
this.Control[]={this.rb_buscar,&
this.rb_edicion,&
this.st_2,&
this.st_1,&
this.st_nombre,&
this.st_amaterno,&
this.st_apaterno,&
this.em_nombre,&
this.em_amaterno,&
this.em_apaterno,&
this.em_folio,&
this.em_digito,&
this.em_cuenta,&
this.rr_1}
end on

on uo_aspirante_revalidacion_org_pb10.destroy
destroy(this.rb_buscar)
destroy(this.rb_edicion)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_nombre)
destroy(this.st_amaterno)
destroy(this.st_apaterno)
destroy(this.em_nombre)
destroy(this.em_amaterno)
destroy(this.em_apaterno)
destroy(this.em_folio)
destroy(this.em_digito)
destroy(this.em_cuenta)
destroy(this.rr_1)
end on

type rb_buscar from radiobutton within uo_aspirante_revalidacion_org_pb10
integer x = 1856
integer y = 16
integer width = 453
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar"
boolean checked = true
boolean lefttext = true
end type

event clicked;long ll_rows
string ls_status

ll_rows= w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.RowCount()

ii_limpiando_nombre= 0
ii_moviendo_cuenta= 0
ii_moviendo_folio= 0
em_folio.enabled= true
em_cuenta.enabled= true

w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = false

if ll_rows > 0 then
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = false
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.is_estatus = 'Modificando'
	if rb_edicion.text = "Nuevo" then
		rb_edicion.text = "Modificando"
	end if
end if
ls_status= "BUSQUEDA"

w_solicitud_revalidacion.st_status.text =ls_status


//if ll_rows > 0 then
//	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = true
//	if rb_edicion.text = "Nuevo" then
//		rb_edicion.text = "Modificando"
//	end if
//	em_folio.enabled= false
//	em_cuenta.enabled= false
//else
//	rb_buscar.checked= true
//	ii_limpiando_nombre= 0
//	ii_moviendo_cuenta= 0
//	ii_moviendo_folio= 0	
//end if


end event

event constructor;w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = false
end event

type rb_edicion from radiobutton within uo_aspirante_revalidacion_org_pb10
integer x = 1856
integer y = 96
integer width = 453
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Modificar"
boolean lefttext = true
end type

event clicked;long ll_rows
string ls_status

ll_rows= w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.RowCount()

ii_limpiando_nombre= 1
ii_moviendo_cuenta= 1
ii_moviendo_folio= 1

if ll_rows > 0 then
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = true
	if this.text <> "Nuevo" then
		this.text = "Modificando"
	end if
	em_folio.enabled= false
	em_cuenta.enabled= false
else
	rb_buscar.checked= true
	ii_limpiando_nombre= 0
	ii_moviendo_cuenta= 0
	ii_moviendo_folio= 0	
end if

ls_status= "EDICION"

w_solicitud_revalidacion.st_status.text =ls_status

end event

type st_2 from statictext within uo_aspirante_revalidacion_org_pb10
integer x = 1079
integer y = 28
integer width = 187
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Folio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within uo_aspirante_revalidacion_org_pb10
integer x = 137
integer y = 28
integer width = 251
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cuenta:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_nombre from statictext within uo_aspirante_revalidacion_org_pb10
integer x = 1719
integer y = 204
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Nombre"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_amaterno from statictext within uo_aspirante_revalidacion_org_pb10
integer x = 960
integer y = 204
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Apellido Materno"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_apaterno from statictext within uo_aspirante_revalidacion_org_pb10
integer x = 183
integer y = 204
integer width = 485
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
string text = "Apellido Paterno"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_nombre from editmask within uo_aspirante_revalidacion_org_pb10
integer x = 1618
integer y = 320
integer width = 686
integer height = 92
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event modified;long ll_null, ll_num_rows_folio, ll_cuenta, ll_folio
integer li_resp
string ls_apaterno, ls_amaterno, ls_nombre, ls_digito, ls_nombre_total
SetNull(ll_null)

if ii_limpiando_nombre = 1 or em_nombre.text ="" or isnull(em_nombre.text) or &
	is_nombre=em_nombre.text then
	return
else
	ii_elegi_para_nuevo = 0
end if

is_nombre=em_nombre.text
istr_aspirante.cuenta =ll_null
istr_aspirante.folio =ll_null
istr_aspirante.apaterno =""
istr_aspirante.amaterno =""
istr_aspirante.nombre =em_nombre.text
openwithparm(w_aspi_alum_revalid,istr_aspirante)
istr_aspirante = Message.PowerObjectParm

if istr_aspirante.num_rows  = 0 then
	messagebox("Aviso","No existe ningun "+istr_aspirante.nombre+" dado de alta.")
//	CloseWithReturn(w_aspi_alum_revalid, istr_aspirante)
	ii_limpiando_nombre = 1
	em_apaterno.Text = ""
	em_amaterno.Text = ""
	em_nombre.Text = ""
	ii_limpiando_nombre = 0
end if	

ll_num_rows_folio= w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Retrieve(istr_aspirante.folio)

ls_apaterno= istr_aspirante.apaterno
if isnull(ls_apaterno) then
	ls_apaterno = ""
end if
ls_amaterno= istr_aspirante.amaterno
if isnull(ls_amaterno) then
	ls_amaterno= ""
end if
ls_nombre= istr_aspirante.nombre
if isnull(ls_nombre) then
	ls_nombre= ""
end if
ls_nombre_total = ls_apaterno+" "+ls_amaterno+" "+ls_nombre

li_resp = 0
if ll_num_rows_folio = 0 then
	li_resp = messagebox("Pregunta","El aspirante"+ls_nombre_total+ " no existe.~n ¿Desea darlo de alta? ",Question!, YesNo!)
end if

if li_resp = 1 then

	ii_limpiando_nombre = 1
	ii_moviendo_cuenta= 1
	
	ii_elegi_para_nuevo = 1

	em_folio.enabled = false
	
	ls_apaterno= istr_aspirante.apaterno
	ls_amaterno= istr_aspirante.amaterno
	ls_nombre= istr_aspirante.nombre
	ll_cuenta= istr_aspirante.cuenta
	ll_folio=istr_aspirante.folio

	ls_digito = obten_digito(ll_cuenta)
	
	em_apaterno.Text = ls_apaterno
	em_amaterno.Text = ls_amaterno
	em_nombre.Text = ls_nombre
	em_cuenta.Text = string(ll_cuenta)
	em_digito.Enabled = true
	em_digito.Text = ls_digito
	em_digito.Enabled = false
	rb_edicion.Text ="Nuevo"
	rb_edicion.Checked =false
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.TriggerEvent("ue_nuevo")
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = true
end if



//parent.parent.dw_datos_solicitud.Retrieve(istr_aspirante.folio)

end event

type em_amaterno from editmask within uo_aspirante_revalidacion_org_pb10
integer x = 859
integer y = 320
integer width = 686
integer height = 92
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event modified;integer li_resp
long ll_null, ll_num_rows_folio, ll_cuenta, ll_folio
string ls_apaterno, ls_amaterno, ls_nombre, ls_digito, ls_nombre_total
SetNull(ll_null)

if ii_limpiando_nombre = 1 or em_amaterno.text ="" or isnull(em_amaterno.text) or &
   is_amaterno =em_amaterno.text then
	return
else
	ii_elegi_para_nuevo = 0
end if

is_amaterno =em_amaterno.text

istr_aspirante.cuenta =ll_null
istr_aspirante.folio =ll_null
istr_aspirante.apaterno =""
istr_aspirante.amaterno =em_amaterno.text
istr_aspirante.nombre =""

openwithparm(w_aspi_alum_revalid,istr_aspirante)
istr_aspirante = Message.PowerObjectParm

if istr_aspirante.num_rows  = 0 then
	messagebox("Aviso","No existe ningun "+istr_aspirante.amaterno+" dado de alta.")
//	CloseWithReturn(w_aspi_alum_revalid, istr_aspirante)
	ii_limpiando_nombre = 1
	em_apaterno.Text = ""
	em_amaterno.Text = ""
	em_nombre.Text = ""
	ii_limpiando_nombre = 0
end if	

ll_num_rows_folio= w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Retrieve(istr_aspirante.folio)

ls_apaterno= istr_aspirante.apaterno
if isnull(ls_apaterno) then
	ls_apaterno = ""
end if
ls_amaterno= istr_aspirante.amaterno
if isnull(ls_amaterno) then
	ls_amaterno= ""
end if
ls_nombre= istr_aspirante.nombre
if isnull(ls_nombre) then
	ls_nombre= ""
end if
ls_nombre_total = ls_apaterno+" "+ls_amaterno+" "+ls_nombre

li_resp = 0
if ll_num_rows_folio = 0 then
	li_resp = messagebox("Pregunta","El aspirante "+ls_nombre_total+ " no existe.~n ¿Desea darlo de alta? ",Question!, YesNo!)
end if

if li_resp = 1 then

	ii_limpiando_nombre = 1
	ii_moviendo_cuenta= 1

	ii_elegi_para_nuevo = 1
	
	em_folio.enabled = false
	
	ls_apaterno= istr_aspirante.apaterno
	ls_amaterno= istr_aspirante.amaterno
	ls_nombre= istr_aspirante.nombre
	ll_cuenta= istr_aspirante.cuenta
	ll_folio=istr_aspirante.folio

	ls_digito = obten_digito(ll_cuenta)
	
	em_apaterno.Text = ls_apaterno
	em_amaterno.Text = ls_amaterno
	em_nombre.Text = ls_nombre
	em_cuenta.Text = string(ll_cuenta)
	em_digito.Enabled = true
	em_digito.Text = ls_digito
	em_digito.Enabled = false
	rb_edicion.Text ="Nuevo"
	rb_edicion.Checked =true
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.TriggerEvent("ue_nuevo")
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = true
	return
end if
ii_limpiando_nombre= 0

//parent.parent.dw_datos_solicitud.Retrieve(istr_aspirante.folio)

end event

type em_apaterno from editmask within uo_aspirante_revalidacion_org_pb10
integer x = 82
integer y = 320
integer width = 686
integer height = 92
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
end type

event modified;long ll_null, ll_num_rows_folio, ll_cuenta, ll_folio
integer li_resp
SetNull(ll_null)
string ls_apaterno, ls_amaterno, ls_nombre, ls_digito, ls_nombre_total

if ii_limpiando_nombre = 1 or em_apaterno.text ="" or isnull(em_apaterno.text) or &
	is_apaterno =em_apaterno.text then
	return
else
	ii_elegi_para_nuevo = 0
end if

is_apaterno =em_apaterno.text

istr_aspirante.cuenta =ll_null
istr_aspirante.folio =ll_null
istr_aspirante.apaterno =em_apaterno.text
istr_aspirante.amaterno =""
istr_aspirante.nombre =""

openwithparm(w_aspi_alum_revalid,istr_aspirante)
istr_aspirante = Message.PowerObjectParm

if istr_aspirante.num_rows  = 0 then
	messagebox("Aviso","No existe ningun "+istr_aspirante.apaterno+" dado de alta.")
//	CloseWithReturn(w_aspi_alum_revalid, istr_aspirante)
	ii_limpiando_nombre = 1
	em_apaterno.Text = ""
	em_amaterno.Text = ""
	em_nombre.Text = ""
	ii_limpiando_nombre = 0
end if	

ll_num_rows_folio = w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Retrieve(istr_aspirante.folio)

ls_apaterno= istr_aspirante.apaterno
if isnull(ls_apaterno) then
	ls_apaterno = ""
end if
ls_amaterno= istr_aspirante.amaterno
if isnull(ls_amaterno) then
	ls_amaterno= ""
end if
ls_nombre= istr_aspirante.nombre
if isnull(ls_nombre) then
	ls_nombre= ""
end if
ls_nombre_total = ls_apaterno+" "+ls_amaterno+" "+ls_nombre

li_resp = 0
if ll_num_rows_folio = 0 then
	li_resp = messagebox("Pregunta","El aspirante"+ls_nombre_total+ " no existe.~n ¿Desea darlo de alta? ",Question!, YesNo!)
end if


if li_resp = 1 then

	ii_limpiando_nombre = 1
	ii_moviendo_cuenta= 1

	ii_elegi_para_nuevo = 1	
	
	em_folio.enabled = false
	
	ls_apaterno= istr_aspirante.apaterno
	ls_amaterno= istr_aspirante.amaterno
	ls_nombre= istr_aspirante.nombre
	ll_cuenta= istr_aspirante.cuenta
	ll_folio=istr_aspirante.folio

	ls_digito = obten_digito(ll_cuenta)
	
	em_apaterno.Text = ls_apaterno
	em_amaterno.Text = ls_amaterno
	em_nombre.Text = ls_nombre
	em_cuenta.Text = string(ll_cuenta)
	em_digito.Enabled = true
	em_digito.Text = ls_digito
	em_digito.Enabled = false
	rb_edicion.Text ="Nuevo"
	rb_edicion.Checked = true
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.TriggerEvent("ue_nuevo")
	w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = true
	return
end if

ii_limpiando_nombre= 0

//parent.parent.dw_datos_solicitud.Retrieve(istr_aspirante.folio)

end event

type em_folio from editmask within uo_aspirante_revalidacion_org_pb10
integer x = 1271
integer y = 16
integer width = 334
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#######"
end type

event modified;integer li_lon_folio
long ll_folio, ll_folio_busqueda, ll_num_rows_folio
string ls_foliototal, ls_folio, ls_digito, ls_digito_valido

ls_foliototal= this.text

if ii_moviendo_folio = 1 or ls_foliototal="" or isnull(ls_foliototal) then
	return
end if

ii_moviendo_folio= 1

if not isnumber(ls_foliototal) then
	MessageBox("Error", "El folio escrito no es valido :"+ls_foliototal, StopSign!)
	this.Text = ""
	ii_moviendo_folio= 0
	return
else
	ll_folio_busqueda= long(ls_foliototal)
end if

if ll_folio_busqueda = il_folio and  ii_folio_valido= 0 then
	this.Text = ""
	ii_moviendo_folio= 0
	return
elseif ls_foliototal = string(il_folio) and  ii_folio_valido= 1 then
	ii_moviendo_folio= 0
	return	
end if	
	
	
SELECT dbo.aspirantes_revalidacion.folio 
INTO	 :ll_folio
FROM   dbo.aspirantes_revalidacion
WHERE  dbo.aspirantes_revalidacion.folio = :ll_folio_busqueda
USING gtr_sce;

if gtr_sce.SQLCode = 100 or isnull(ll_folio) then
	MessageBox("Error", "El folio escrito no existe", StopSign!)
	this.Text = ""
	ii_moviendo_folio= 0
	ii_folio_valido = 0
	return
else
	ll_num_rows_folio = w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Retrieve(ll_folio)
end if

this.Text = ls_foliototal
il_folio = ll_folio
ii_folio_valido = 1
ii_moviendo_folio= 0
return




end event

type em_digito from editmask within uo_aspirante_revalidacion_org_pb10
integer x = 741
integer y = 16
integer width = 78
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!"
end type

type em_cuenta from editmask within uo_aspirante_revalidacion_org_pb10
integer x = 398
integer y = 16
integer width = 334
integer height = 96
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!"
end type

event modified;integer li_lon_cuenta, li_resp
long ll_cuenta, ll_cuenta_busqueda, ll_folio, ll_num_rows_folio
string ls_cuentatotal, ls_cuenta, ls_digito, ls_digito_valido
string ls_apaterno, ls_amaterno, ls_nombre

ls_cuentatotal= this.text

if ii_moviendo_cuenta= 1 or ls_cuentatotal="" or isnull(ls_cuentatotal) then
	return
else
	ii_elegi_para_nuevo = 0
end if


ii_moviendo_cuenta= 1 
em_digito.Enabled = true

li_lon_cuenta = len(ls_cuentatotal)

ls_cuenta = mid(ls_cuentatotal,1, li_lon_cuenta -1)

ls_digito = mid(ls_cuentatotal, li_lon_cuenta, 1 )

if not isnumber(ls_cuenta) then
	MessageBox("Error", "La cuenta escrita no es valida", StopSign!)
	this.Text = ""
	em_digito.Text = ""	
	return
else
	ll_cuenta_busqueda= long(ls_cuenta)
end if

ls_digito_valido = obten_digito(ll_cuenta_busqueda)

if ll_cuenta_busqueda = il_cuenta and ls_digito_valido = ls_digito  then
	this.Text = ls_cuenta
	em_digito.Enabled = false
	ii_moviendo_cuenta= 0
	return
elseif ls_cuentatotal = string(il_cuenta) and ii_cuenta_valida= 1 then
	em_digito.Enabled = false
	ii_moviendo_cuenta= 0
	return
end if

//MessageBox("Cuenta"+string(ll_cuenta_busqueda),"Digito"+string(ls_digito))
//MessageBox("Cuenta"+string(ll_cuenta_busqueda),"Digito"+string(ls_digito_valido))

SELECT dbo.alumnos.cuenta,  
       dbo.alumnos.apaterno, 
		 dbo.alumnos.amaterno, 
		 dbo.alumnos.nombre
INTO	 :ll_cuenta,
       :ls_apaterno,
		 :ls_amaterno,
		 :ls_nombre
FROM   dbo.alumnos
WHERE  dbo.alumnos.cuenta = :ll_cuenta_busqueda
USING gtr_sce;

if gtr_sce.SQLCode = 100 or isnull(ll_cuenta) then
	MessageBox("Error", "La cuenta escrita no existe", StopSign!)
	this.Text = ""
	em_digito.Text = ""
	em_digito.Enabled = false
	ii_moviendo_cuenta= 0
	il_cuenta = 0
	ii_cuenta_valida= 0
	return
end if

if ls_digito_valido <> ls_digito then
   MessageBox("Error", "El dígito no es valido", StopSign!)
	this.Text = ""
	em_digito.Text = ""
	em_digito.Enabled = false
	ii_moviendo_cuenta= 0
	il_cuenta = 0
	ii_cuenta_valida= 0
	return
else	
	SELECT dbo.aspirantes_revalidacion.cuenta,  
       dbo.aspirantes_revalidacion.folio
	INTO	 :ll_cuenta,
	       :ll_folio
	FROM   dbo.aspirantes_revalidacion
	WHERE  dbo.aspirantes_revalidacion.cuenta = :ll_cuenta_busqueda
	USING gtr_sce;
	if gtr_sce.SQLCode = 100 or isnull(ll_cuenta) then
		
		li_resp = 0
		li_resp = messagebox("Pregunta","El aspirante escrito no existe.~n ¿Desea darlo de alta? ",Question!, YesNo!)

		if li_resp = 1 then

			ii_limpiando_nombre = 1
			ii_moviendo_cuenta= 1
			em_folio.Enabled = false
			
			ii_elegi_para_nuevo = 1			
			
			em_apaterno.Text = ls_apaterno
			em_amaterno.Text = ls_amaterno
			em_nombre.Text = ls_nombre
			em_cuenta.Text = string(ll_cuenta)
			em_digito.Enabled = true
			em_digito.Text = ls_digito_valido
			em_digito.Enabled = false
			rb_edicion.Text ="Nuevo"
			rb_edicion.Checked = true			
			w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.TriggerEvent("ue_nuevo")
			w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Enabled = true
		end if
	else
		ll_num_rows_folio = w_solicitud_revalidacion.tab_datos.tabpage_sol_revalidacion.dw_datos_solicitud.Retrieve(ll_folio)
	end if
end if	

this.Text = ls_cuenta
em_digito.Text = ls_digito_valido
em_digito.Enabled = false
ii_moviendo_cuenta= 0
ii_moviendo_folio= 0
ii_limpiando_nombre= 0
il_cuenta = long(ls_cuenta)
ii_cuenta_valida= 1
return




end event

event losefocus;return
end event

type rr_1 from roundrectangle within uo_aspirante_revalidacion_org_pb10
integer linethickness = 3
long fillcolor = 10789024
integer x = 64
integer y = 192
integer width = 2263
integer height = 100
integer cornerheight = 38
integer cornerwidth = 48
end type

