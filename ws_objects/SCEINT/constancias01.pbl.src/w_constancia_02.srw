$PBExportHeader$w_constancia_02.srw
$PBExportComments$Inscripción con Promedio y con Créditos
forward
global type w_constancia_02 from window
end type
type uo_nombre from uo_nombre_alumno_const within w_constancia_02
end type
type st_numero from statictext within w_constancia_02
end type
type st_decimal from statictext within w_constancia_02
end type
type cb_promedio from commandbutton within w_constancia_02
end type
type st_3 from statictext within w_constancia_02
end type
type em_precision_prom from editmask within w_constancia_02
end type
type st_texto_fecha from statictext within w_constancia_02
end type
type st_fecha from statictext within w_constancia_02
end type
type em_fecha from editmask within w_constancia_02
end type
type cb_redactar from commandbutton within w_constancia_02
end type
type dw_constancia from datawindow within w_constancia_02
end type
type mle_texto_libre from multilineedit within w_constancia_02
end type
type st_2 from statictext within w_constancia_02
end type
type st_1 from statictext within w_constancia_02
end type
type mle_dirigido_a from multilineedit within w_constancia_02
end type
end forward

global type w_constancia_02 from window
integer width = 3616
integer height = 3516
boolean titlebar = true
string title = "Inscripción con Promedio y con Créditos"
string menuname = "m_menu_constancias"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_nombre uo_nombre
st_numero st_numero
st_decimal st_decimal
cb_promedio cb_promedio
st_3 st_3
em_precision_prom em_precision_prom
st_texto_fecha st_texto_fecha
st_fecha st_fecha
em_fecha em_fecha
cb_redactar cb_redactar
dw_constancia dw_constancia
mle_texto_libre mle_texto_libre
st_2 st_2
st_1 st_1
mle_dirigido_a mle_dirigido_a
end type
global w_constancia_02 w_constancia_02

type variables
str_impresion_constancias istr_constancias
end variables

on w_constancia_02.create
if this.MenuName = "m_menu_constancias" then this.MenuID = create m_menu_constancias
this.uo_nombre=create uo_nombre
this.st_numero=create st_numero
this.st_decimal=create st_decimal
this.cb_promedio=create cb_promedio
this.st_3=create st_3
this.em_precision_prom=create em_precision_prom
this.st_texto_fecha=create st_texto_fecha
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.cb_redactar=create cb_redactar
this.dw_constancia=create dw_constancia
this.mle_texto_libre=create mle_texto_libre
this.st_2=create st_2
this.st_1=create st_1
this.mle_dirigido_a=create mle_dirigido_a
this.Control[]={this.uo_nombre,&
this.st_numero,&
this.st_decimal,&
this.cb_promedio,&
this.st_3,&
this.em_precision_prom,&
this.st_texto_fecha,&
this.st_fecha,&
this.em_fecha,&
this.cb_redactar,&
this.dw_constancia,&
this.mle_texto_libre,&
this.st_2,&
this.st_1,&
this.mle_dirigido_a}
end on

on w_constancia_02.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.st_numero)
destroy(this.st_decimal)
destroy(this.cb_promedio)
destroy(this.st_3)
destroy(this.em_precision_prom)
destroy(this.st_texto_fecha)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.cb_redactar)
destroy(this.dw_constancia)
destroy(this.mle_texto_libre)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.mle_dirigido_a)
end on

event open;string ls_fecha_servidor
datetime ldttm_fecha_servidor

x=1
y=1

if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0

gi_numscob = gi_numscob +1

if gi_numscob <= 1 then
	if (conecta_bd_n_tr(gtr_scob,gs_scob,gs_usuario,gs_password) <> 1) then
		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
		close(this)
		return
	end if
end if

ldttm_fecha_servidor= fecha_servidor(gtr_sce)

ls_fecha_servidor = string(ldttm_fecha_servidor, "dd/mm/yyyy")

em_fecha.text = ls_fecha_servidor




end event

event close;
if gi_numscob <= 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if

gi_numscob = gi_numscob - 1



end event

type uo_nombre from uo_nombre_alumno_const within w_constancia_02
integer x = 64
integer y = 48
integer width = 3241
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_const::destroy
end on

type st_numero from statictext within w_constancia_02
boolean visible = false
integer x = 1376
integer y = 780
integer width = 2322
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
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_decimal from statictext within w_constancia_02
boolean visible = false
integer x = 1385
integer y = 912
integer width = 2322
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
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_promedio from commandbutton within w_constancia_02
boolean visible = false
integer x = 3227
integer y = 1052
integer width = 306
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Promedio"
end type

event clicked;long ll_cuenta
integer li_carrera, li_plan, li_precision
decimal ld_promedio, ldc_creditos
string ls_cuenta

ls_cuenta = uo_nombre.em_cuenta.text

ll_cuenta = long(ls_cuenta)


//ll_cuenta = long(em_cuenta.text)
//li_carrera = integer(em_carrera.text)
//li_plan = integer(em_plan.text)
li_precision = integer(em_precision_prom.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 2
end if

li_carrera = f_obten_cve_carrera(ll_cuenta)

li_plan = f_obten_cve_plan(ll_cuenta)

f_obten_promedio_creditos(ll_cuenta, li_carrera, li_plan, ld_promedio, ldc_creditos)


//st_res_creditos.Text = string(li_creditos)
//st_res_promedio.Text = string(ld_promedio)
//

st_decimal.Text = f_obten_decimal_en_texto(ld_promedio,li_precision)
st_numero.Text = f_obten_numero_en_texto(Long(ldc_creditos))


end event

type st_3 from statictext within w_constancia_02
integer x = 2501
integer y = 1008
integer width = 434
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
string text = "Precisión Prom."
boolean focusrectangle = false
end type

type em_precision_prom from editmask within w_constancia_02
integer x = 2624
integer y = 1104
integer width = 187
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###0"
end type

event modified;string ls_precision
integer li_precision

ls_precision = this.text
li_precision = integer(ls_precision)

if li_precision < 1 or li_precision >4 then
	ls_precision = "1"
	this.text= ls_precision	
end if



end event

type st_texto_fecha from statictext within w_constancia_02
boolean visible = false
integer x = 279
integer y = 1324
integer width = 2889
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
string text = "none"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_fecha from statictext within w_constancia_02
integer x = 2437
integer y = 576
integer width = 562
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
string text = "Fecha (dd/mm/aaaa)"
boolean focusrectangle = false
end type

type em_fecha from editmask within w_constancia_02
integer x = 2501
integer y = 672
integer width = 434
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type cb_redactar from commandbutton within w_constancia_02
integer x = 3099
integer y = 668
integer width = 366
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Redactar"
end type

event clicked;long ll_cuenta, ll_renglones, ll_renglon_actual
string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_texto2
datetime ldttm_fecha
integer li_precision, li_carrera, li_plan, li_num_lineas,li_pos
decimal ld_promedio, ldc_creditos, ldc_creditos_totales
boolean lb_inscrito

ls_cuenta = uo_nombre.em_cuenta.text

if not isnumber(ls_cuenta) then
	MessageBox("Error","La cuenta escrita es inválida", StopSign!)
	return
end if

ll_cuenta = long(ls_cuenta)

lb_inscrito = f_obten_banderas_inscrito(ll_cuenta)

if not lb_inscrito then
	MessageBox("Error","El alumno no se encuentra registrado como inscrito", StopSign!)
	return
end if

ls_fecha = em_fecha.text

ldttm_fecha = datetime(date(ls_fecha),time("00:00:00"))

ls_texto_fecha = f_obten_datetime_en_texto(ldttm_fecha)

st_texto_fecha.text = ls_texto_fecha

ls_dirigido_a = mle_dirigido_a.text

ls_texto_libre = mle_texto_libre.text

ls_texto2 = f_obten_asc(ls_texto_libre, li_num_lineas)

//li_num_lineas = f_obten_num_lineas(ls_texto_libre)

ls_dirigido_a = f_quita_comillas(ls_dirigido_a)

dw_constancia.object.st_dirigido_a.text = ls_dirigido_a

ls_texto2 = f_quita_comillas(ls_texto2)

dw_constancia.object.st_texto_libre.text = ls_texto2

li_precision = integer(em_precision_prom.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 2
end if

li_carrera = f_obten_cve_carrera(ll_cuenta)

li_plan = f_obten_cve_plan(ll_cuenta)

f_obten_promedio_creditos(ll_cuenta, li_carrera, li_plan, ld_promedio, ldc_creditos)

ldc_creditos_totales = f_obten_cred_total(li_carrera, li_plan)

//ld_promedio = round(ld_promedio, li_precision)

ll_renglones = dw_constancia.Retrieve(ll_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2,ld_promedio,&
ldc_creditos, li_precision,ldc_creditos_totales, li_num_lineas)

ll_renglon_actual =dw_constancia.GetRow()

istr_constancias.sl_cuenta = ll_cuenta
istr_constancias.si_num_constancia = 2
istr_constancias.sw_window = parent
istr_constancias.suo_user_object = uo_nombre

m_menu_constancias.istr_constancia = istr_constancias

end event

type dw_constancia from datawindow within w_constancia_02
integer x = 64
integer y = 1356
integer width = 3401
integer height = 1960
integer taborder = 60
string dataobject = "d_constancias_02"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;
str_impresion_constancias lstr_constancias 


m_menu_constancias.dw = this

this.SetTransObject(gtr_sce)

//Orientación Portrait
this.Object.DataWindow.Print.Orientation	= 2

//Zoom Normal
this.Object.DataWindow.Zoom = 100	
this.Object.DataWindow.Print.Preview.Zoom = 100	




istr_constancias.sdw_datawindow = this
istr_constancias.sl_cuenta = 0
istr_constancias.si_num_constancia = 2
istr_constancias.sw_window = parent
istr_constancias.suo_user_object = uo_nombre

m_menu_constancias.istr_constancia = istr_constancias

end event

type mle_texto_libre from multilineedit within w_constancia_02
integer x = 64
integer y = 1008
integer width = 2208
integer height = 288
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_constancia_02
integer x = 64
integer y = 908
integer width = 434
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
string text = "Texto libre final:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_constancia_02
integer x = 64
integer y = 492
integer width = 279
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
string text = "Dirigido a:"
boolean focusrectangle = false
end type

type mle_dirigido_a from multilineedit within w_constancia_02
integer x = 64
integer y = 576
integer width = 2208
integer height = 288
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
string text = "A QUIEN CORRESPONDA:"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

