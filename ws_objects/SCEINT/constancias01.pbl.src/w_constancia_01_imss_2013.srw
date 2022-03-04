$PBExportHeader$w_constancia_01_imss_2013.srw
$PBExportComments$Inscripción sin Promedio y sin Créditos
forward
global type w_constancia_01_imss_2013 from w_master_main
end type
type st_1 from statictext within w_constancia_01_imss_2013
end type
type st_fecha from statictext within w_constancia_01_imss_2013
end type
type em_fecha from editmask within w_constancia_01_imss_2013
end type
type cb_redactar from commandbutton within w_constancia_01_imss_2013
end type
type cbx_1 from checkbox within w_constancia_01_imss_2013
end type
type st_2 from statictext within w_constancia_01_imss_2013
end type
type st_texto_fecha from statictext within w_constancia_01_imss_2013
end type
type dw_constancia from uo_master_dw within w_constancia_01_imss_2013
end type
type mle_dirigido_a from multilineedit within w_constancia_01_imss_2013
end type
type mle_texto_libre from multilineedit within w_constancia_01_imss_2013
end type
type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_01_imss_2013
end type
type st_version1 from statictext within w_constancia_01_imss_2013
end type
type st_version2 from statictext within w_constancia_01_imss_2013
end type
type uo_pdf from uo_imprime_pdf within w_constancia_01_imss_2013
end type
end forward

global type w_constancia_01_imss_2013 from w_master_main
integer width = 3717
integer height = 3012
string title = "Inscripción sin Promedio y sin Créditos (para el IMSS)"
string menuname = "m_menu_constancias_2013"
st_1 st_1
st_fecha st_fecha
em_fecha em_fecha
cb_redactar cb_redactar
cbx_1 cbx_1
st_2 st_2
st_texto_fecha st_texto_fecha
dw_constancia dw_constancia
mle_dirigido_a mle_dirigido_a
mle_texto_libre mle_texto_libre
uo_nombre uo_nombre
st_version1 st_version1
st_version2 st_version2
uo_pdf uo_pdf
end type
global w_constancia_01_imss_2013 w_constancia_01_imss_2013

type variables
str_impresion_constancias_2013 istr_constancias
long il_cuenta,il_carrera
int ii_vigente

LONG il_plan
end variables

event open;call super::open;string ls_fecha_servidor
datetime ldttm_fecha_servidor

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

on w_constancia_01_imss_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_constancias_2013" then this.MenuID = create m_menu_constancias_2013
this.st_1=create st_1
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.cb_redactar=create cb_redactar
this.cbx_1=create cbx_1
this.st_2=create st_2
this.st_texto_fecha=create st_texto_fecha
this.dw_constancia=create dw_constancia
this.mle_dirigido_a=create mle_dirigido_a
this.mle_texto_libre=create mle_texto_libre
this.uo_nombre=create uo_nombre
this.st_version1=create st_version1
this.st_version2=create st_version2
this.uo_pdf=create uo_pdf
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_fecha
this.Control[iCurrent+3]=this.em_fecha
this.Control[iCurrent+4]=this.cb_redactar
this.Control[iCurrent+5]=this.cbx_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.st_texto_fecha
this.Control[iCurrent+8]=this.dw_constancia
this.Control[iCurrent+9]=this.mle_dirigido_a
this.Control[iCurrent+10]=this.mle_texto_libre
this.Control[iCurrent+11]=this.uo_nombre
this.Control[iCurrent+12]=this.st_version1
this.Control[iCurrent+13]=this.st_version2
this.Control[iCurrent+14]=this.uo_pdf
end on

on w_constancia_01_imss_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.cb_redactar)
destroy(this.cbx_1)
destroy(this.st_2)
destroy(this.st_texto_fecha)
destroy(this.dw_constancia)
destroy(this.mle_dirigido_a)
destroy(this.mle_texto_libre)
destroy(this.uo_nombre)
destroy(this.st_version1)
destroy(this.st_version2)
destroy(this.uo_pdf)
end on

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
ii_vigente = uo_nombre.istr_carrera.str_vigente
il_plan = uo_nombre.istr_carrera.str_cve_plan

if il_carrera = 0 then return
end event

event closequery;//
end event

type st_sistema from w_master_main`st_sistema within w_constancia_01_imss_2013
end type

type p_ibero from w_master_main`p_ibero within w_constancia_01_imss_2013
end type

type st_1 from statictext within w_constancia_01_imss_2013
integer x = 73
integer y = 816
integer width = 279
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Dirigido a:"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_constancia_01_imss_2013
integer x = 2464
integer y = 900
integer width = 562
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Fecha (dd/mm/aaaa)"
boolean focusrectangle = false
end type

type em_fecha from editmask within w_constancia_01_imss_2013
integer x = 2528
integer y = 996
integer width = 434
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type cb_redactar from commandbutton within w_constancia_01_imss_2013
integer x = 3109
integer y = 992
integer width = 366
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Redactar"
end type

event clicked;long  ll_renglones, ll_renglon_actual
string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_texto2, ls_semtrim
datetime ldttm_fecha
integer li_num_lineas, li_ascii
boolean lb_inscrito

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

lb_inscrito = f_obten_banderas_inscrito(il_cuenta)

if not lb_inscrito then
	MessageBox("Error","El alumno no se encuentra registrado como inscrito", StopSign!)
	return
end if

//if ii_vigente = 0 then	
IF NOT f_verifica_carrera_activa(il_cuenta,il_carrera) THEN 
	MessageBox("Error","Debe escoger una carrera vigente", StopSign!)
	return
end if
	
ls_fecha = em_fecha.text

ldttm_fecha = datetime(date(ls_fecha),time("00:00:00"))

ls_texto_fecha = f_obten_datetime_en_texto(ldttm_fecha)

st_texto_fecha.text = ls_texto_fecha

ls_dirigido_a = mle_dirigido_a.text

ls_texto_libre = mle_texto_libre.text

ls_texto2= f_obten_asc(ls_texto_libre, li_num_lineas)

dw_constancia.object.st_dirigido_a.text = ls_dirigido_a

ls_texto2 = f_quita_comillas(ls_texto2)

dw_constancia.object.st_texto_libre.text = ls_texto2

ls_semtrim = LOWER(luo_periodo_tipo_servicios.f_obten_desc_periodo_msg(gs_tipo_periodo))

IF luo_periodo_tipo_servicios.i_error = -1 THEN 
	MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
	RETURN luo_periodo_tipo_servicios.i_error
END IF	

//li_num_lineas = f_obten_num_lineas(ls_texto_libre)
//if gs_tipo_periodo='S' then
//	ls_semtrim='semestre'
//else
//	ls_semtrim='trimestre'
//end if

ll_renglones = dw_constancia.Retrieve(il_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2, li_num_lineas,ls_semtrim,il_carrera, il_plan)

//dw_constancia.object.st_texto_libre_2.text = ls_texto2

dw_constancia.Object.st_folio.Alignment = 3

//dw_constancia.Object.st_folio.Alignment = 3

ll_renglon_actual =dw_constancia.GetRow()

if (ll_renglones>0) then
	uo_pdf.enabled=true
	
	//  Parametros: DW, nombre archivo, ruta archivo, escala por default. cph 29 sept 2021.
	uo_pdf.inicializa_dw(dw_constancia,"","","98") // inicializa el uo_pdf para generar PDF cph 29 sept 2021
end if

end event

type cbx_1 from checkbox within w_constancia_01_imss_2013
boolean visible = false
integer x = 3122
integer y = 1380
integer width = 329
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Habilitar"
boolean lefttext = true
end type

event clicked;if this.checked then
	m_menu_constancias.m_archivo.m_imprimir.Disable()
else
	m_menu_constancias.m_archivo.m_imprimir.Enable()
end if
end event

type st_2 from statictext within w_constancia_01_imss_2013
integer x = 73
integer y = 1192
integer width = 434
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "Texto libre final:"
boolean focusrectangle = false
end type

type st_texto_fecha from statictext within w_constancia_01_imss_2013
boolean visible = false
integer x = 73
integer y = 1580
integer width = 2309
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
string text = "12345678901234567890123456789012345678901234567890123456789012345678901234"
boolean focusrectangle = false
end type

type dw_constancia from uo_master_dw within w_constancia_01_imss_2013
integer x = 73
integer y = 1588
integer width = 3401
integer height = 1192
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_constancias_01_imss"
boolean hscrollbar = false
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;str_impresion_constancias_2013 lstr_constancias 

m_menu_constancias_2013.dw = this

this.SetTransObject(gtr_sce)

//Orientación Portrait
this.Object.DataWindow.Print.Orientation	= 2

//Zoom Normal
this.Object.DataWindow.Zoom = 100	
this.Object.DataWindow.Print.Preview.Zoom = 100	



istr_constancias.sdw_datawindow = this
istr_constancias.sl_cuenta = il_cuenta
istr_constancias.si_num_constancia = 1
istr_constancias.sw_window = parent
//istr_constancias.suo_user_object = uo_nombre

m_menu_constancias_2013.istr_constancia = istr_constancias
end event

type mle_dirigido_a from multilineedit within w_constancia_01_imss_2013
integer x = 73
integer y = 880
integer width = 2208
integer height = 288
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = "INSTITUTO MEXICANO~nDEL SEGURO SOCIAL:"
end event

type mle_texto_libre from multilineedit within w_constancia_01_imss_2013
integer x = 73
integer y = 1284
integer width = 2208
integer height = 288
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;//this.text = "Asimismo se hace constar que el período vacacional de primavera 2000 abarca del 19 de mayo al 8 de agosto."
this.text =f_obten_texto_imss()
end event

type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_01_imss_2013
event destroy ( )
integer x = 69
integer y = 288
integer width = 3241
integer height = 516
integer taborder = 10
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista_const2::destroy
end on

event constructor;call super::constructor;m_menu_constancias_2013.objeto = this
end event

type st_version1 from statictext within w_constancia_01_imss_2013
integer x = 910
integer y = 100
integer width = 82
integer height = 92
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "."
boolean focusrectangle = false
end type

event doubleclicked;st_version2.visible=true
end event

type st_version2 from statictext within w_constancia_01_imss_2013
boolean visible = false
integer x = 1015
integer y = 100
integer width = 82
integer height = 92
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "."
boolean focusrectangle = false
end type

event doubleclicked;Messagebox("Versión:",&
""+&
"Se agregrega generación de PDF. cph. 11 oct 2021.~r")

this.visible=false
end event

type uo_pdf from uo_imprime_pdf within w_constancia_01_imss_2013
integer x = 2322
integer y = 1188
integer taborder = 90
boolean bringtotop = true
boolean enabled = false
end type

on uo_pdf.destroy
call uo_imprime_pdf::destroy
end on

