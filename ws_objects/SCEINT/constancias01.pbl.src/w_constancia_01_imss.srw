$PBExportHeader$w_constancia_01_imss.srw
forward
global type w_constancia_01_imss from window
end type
type cbx_1 from checkbox within w_constancia_01_imss
end type
type uo_nombre from uo_nombre_alumno_const within w_constancia_01_imss
end type
type st_texto_fecha from statictext within w_constancia_01_imss
end type
type st_fecha from statictext within w_constancia_01_imss
end type
type em_fecha from editmask within w_constancia_01_imss
end type
type cb_redactar from commandbutton within w_constancia_01_imss
end type
type dw_constancia from datawindow within w_constancia_01_imss
end type
type mle_texto_libre from multilineedit within w_constancia_01_imss
end type
type st_2 from statictext within w_constancia_01_imss
end type
type st_1 from statictext within w_constancia_01_imss
end type
type mle_dirigido_a from multilineedit within w_constancia_01_imss
end type
end forward

global type w_constancia_01_imss from window
integer width = 3639
integer height = 3524
boolean titlebar = true
string title = "Inscripción sin Promedio y sin Créditos (para el IMSS)"
string menuname = "m_menu_constancias"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cbx_1 cbx_1
uo_nombre uo_nombre
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
global w_constancia_01_imss w_constancia_01_imss

type variables
str_impresion_constancias istr_constancias

end variables

on w_constancia_01_imss.create
if this.MenuName = "m_menu_constancias" then this.MenuID = create m_menu_constancias
this.cbx_1=create cbx_1
this.uo_nombre=create uo_nombre
this.st_texto_fecha=create st_texto_fecha
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.cb_redactar=create cb_redactar
this.dw_constancia=create dw_constancia
this.mle_texto_libre=create mle_texto_libre
this.st_2=create st_2
this.st_1=create st_1
this.mle_dirigido_a=create mle_dirigido_a
this.Control[]={this.cbx_1,&
this.uo_nombre,&
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

on w_constancia_01_imss.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_1)
destroy(this.uo_nombre)
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

type cbx_1 from checkbox within w_constancia_01_imss
boolean visible = false
integer x = 3255
integer y = 844
integer width = 329
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Habilitar"
boolean lefttext = true
end type

event clicked;if this.checked then
	m_menu_constancias.m_archivo.m_imprimir.Disable()
else
	m_menu_constancias.m_archivo.m_imprimir.Enable()
end if
end event

type uo_nombre from uo_nombre_alumno_const within w_constancia_01_imss
integer x = 73
integer y = 44
integer width = 3241
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_const::destroy
end on

type st_texto_fecha from statictext within w_constancia_01_imss
boolean visible = false
integer x = 64
integer y = 1316
integer width = 2309
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
string text = "12345678901234567890123456789012345678901234567890123456789012345678901234"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_constancia_01_imss
integer x = 2455
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

type em_fecha from editmask within w_constancia_01_imss
integer x = 2519
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

type cb_redactar from commandbutton within w_constancia_01_imss
integer x = 3099
integer y = 668
integer width = 366
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Redactar"
end type

event clicked;long ll_cuenta, ll_renglones, ll_renglon_actual
string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_texto2, ls_semtrim
datetime ldttm_fecha
integer li_num_lineas, li_ascii,li_pos
boolean lb_inscrito

ls_cuenta = uo_nombre.em_cuenta.text

if not isnumber(ls_cuenta) then
	MessageBox("Error","La cuenta escrita es inválida", StopSign!)
	m_menu_constancias.m_archivo.m_imprimir.Disable()
	return
else
	m_menu_constancias.m_archivo.m_imprimir.Enable()	
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

ls_texto2= f_obten_asc(ls_texto_libre, li_num_lineas)

ls_dirigido_a = f_quita_comillas(ls_dirigido_a)

dw_constancia.object.st_dirigido_a.text = ls_dirigido_a

ls_texto2 = f_quita_comillas(ls_texto2)

dw_constancia.object.st_texto_libre.text = ls_texto2

//li_num_lineas = f_obten_num_lineas(ls_texto_libre)
if gs_tipo_periodo='S' then
	ls_semtrim='semestre'
else
	ls_semtrim='trimestre'
end if

ll_renglones = dw_constancia.Retrieve(ll_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2, li_num_lineas, ls_semtrim)

//dw_constancia.object.st_texto_libre_2.text = ls_texto2

dw_constancia.Object.st_folio.Alignment = 3

//dw_constancia.Object.st_folio.Alignment = 3

ll_renglon_actual =dw_constancia.GetRow()

istr_constancias.sl_cuenta = ll_cuenta
istr_constancias.si_num_constancia = 1
istr_constancias.sw_window = parent
istr_constancias.suo_user_object = uo_nombre

m_menu_constancias.istr_constancia = istr_constancias
end event

type dw_constancia from datawindow within w_constancia_01_imss
integer x = 64
integer y = 1396
integer width = 3401
integer height = 1884
integer taborder = 50
string dataobject = "d_constancias_01_imss"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;str_impresion_constancias lstr_constancias 

//lstr_constancias = CREATE str_impresion_constancias



m_menu_constancias.dw = this

this.SetTransObject(gtr_sce)


//m_menu_constancias.dw = this


//Orientación Portrait
this.Object.DataWindow.Print.Orientation	= 2

//Zoom Normal
this.Object.DataWindow.Zoom = 100	
this.Object.DataWindow.Print.Preview.Zoom = 100	



istr_constancias.sdw_datawindow = this
istr_constancias.sl_cuenta = 0
istr_constancias.si_num_constancia = 1
istr_constancias.sw_window = parent
istr_constancias.suo_user_object = uo_nombre

m_menu_constancias.istr_constancia = istr_constancias
end event

type mle_texto_libre from multilineedit within w_constancia_01_imss
integer x = 64
integer y = 1008
integer width = 2208
integer height = 288
integer taborder = 60
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

event constructor;//this.text = "Asimismo se hace constar que el período vacacional de primavera 2000 abarca del 19 de mayo al 8 de agosto."
this.text =f_obten_texto_imss()
end event

type st_2 from statictext within w_constancia_01_imss
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

type st_1 from statictext within w_constancia_01_imss
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

type mle_dirigido_a from multilineedit within w_constancia_01_imss
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
boolean enabled = false
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = "INSTITUTO MEXICANO~nDEL SEGURO SOCIAL:"
end event

