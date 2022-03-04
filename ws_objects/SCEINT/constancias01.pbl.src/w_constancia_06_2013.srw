$PBExportHeader$w_constancia_06_2013.srw
$PBExportComments$Inscripción sin Promedio y sin Créditos
forward
global type w_constancia_06_2013 from w_master_main
end type
type st_1 from statictext within w_constancia_06_2013
end type
type mle_dirigido_a from multilineedit within w_constancia_06_2013
end type
type st_fecha from statictext within w_constancia_06_2013
end type
type em_fecha from editmask within w_constancia_06_2013
end type
type cb_redactar from commandbutton within w_constancia_06_2013
end type
type mle_texto_libre from multilineedit within w_constancia_06_2013
end type
type st_2 from statictext within w_constancia_06_2013
end type
type st_texto_fecha from statictext within w_constancia_06_2013
end type
type dw_constancia from uo_master_dw within w_constancia_06_2013
end type
type st_numero from statictext within w_constancia_06_2013
end type
type st_decimal from statictext within w_constancia_06_2013
end type
type st_3 from statictext within w_constancia_06_2013
end type
type em_precision_prom from editmask within w_constancia_06_2013
end type
type cb_promedio from commandbutton within w_constancia_06_2013
end type
type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_06_2013
end type
type dw_certificado from datawindow within w_constancia_06_2013
end type
type dw_revision_est from datawindow within w_constancia_06_2013
end type
type st_nombre_posgrado from statictext within w_constancia_06_2013
end type
type sle_nombre_posgrado from singlelineedit within w_constancia_06_2013
end type
type st_version1 from statictext within w_constancia_06_2013
end type
type st_version2 from statictext within w_constancia_06_2013
end type
type uo_pdf from uo_imprime_pdf within w_constancia_06_2013
end type
end forward

global type w_constancia_06_2013 from w_master_main
integer width = 3717
integer height = 3012
string title = "Protocolo"
string menuname = "m_menu_constancias_2013"
st_1 st_1
mle_dirigido_a mle_dirigido_a
st_fecha st_fecha
em_fecha em_fecha
cb_redactar cb_redactar
mle_texto_libre mle_texto_libre
st_2 st_2
st_texto_fecha st_texto_fecha
dw_constancia dw_constancia
st_numero st_numero
st_decimal st_decimal
st_3 st_3
em_precision_prom em_precision_prom
cb_promedio cb_promedio
uo_nombre uo_nombre
dw_certificado dw_certificado
dw_revision_est dw_revision_est
st_nombre_posgrado st_nombre_posgrado
sle_nombre_posgrado sle_nombre_posgrado
st_version1 st_version1
st_version2 st_version2
uo_pdf uo_pdf
end type
global w_constancia_06_2013 w_constancia_06_2013

type variables
str_impresion_constancias_2013 istr_constancias
long il_cuenta,il_carrera,il_plan,il_subsistema
string is_nivel
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

on w_constancia_06_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_constancias_2013" then this.MenuID = create m_menu_constancias_2013
this.st_1=create st_1
this.mle_dirigido_a=create mle_dirigido_a
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.cb_redactar=create cb_redactar
this.mle_texto_libre=create mle_texto_libre
this.st_2=create st_2
this.st_texto_fecha=create st_texto_fecha
this.dw_constancia=create dw_constancia
this.st_numero=create st_numero
this.st_decimal=create st_decimal
this.st_3=create st_3
this.em_precision_prom=create em_precision_prom
this.cb_promedio=create cb_promedio
this.uo_nombre=create uo_nombre
this.dw_certificado=create dw_certificado
this.dw_revision_est=create dw_revision_est
this.st_nombre_posgrado=create st_nombre_posgrado
this.sle_nombre_posgrado=create sle_nombre_posgrado
this.st_version1=create st_version1
this.st_version2=create st_version2
this.uo_pdf=create uo_pdf
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.mle_dirigido_a
this.Control[iCurrent+3]=this.st_fecha
this.Control[iCurrent+4]=this.em_fecha
this.Control[iCurrent+5]=this.cb_redactar
this.Control[iCurrent+6]=this.mle_texto_libre
this.Control[iCurrent+7]=this.st_2
this.Control[iCurrent+8]=this.st_texto_fecha
this.Control[iCurrent+9]=this.dw_constancia
this.Control[iCurrent+10]=this.st_numero
this.Control[iCurrent+11]=this.st_decimal
this.Control[iCurrent+12]=this.st_3
this.Control[iCurrent+13]=this.em_precision_prom
this.Control[iCurrent+14]=this.cb_promedio
this.Control[iCurrent+15]=this.uo_nombre
this.Control[iCurrent+16]=this.dw_certificado
this.Control[iCurrent+17]=this.dw_revision_est
this.Control[iCurrent+18]=this.st_nombre_posgrado
this.Control[iCurrent+19]=this.sle_nombre_posgrado
this.Control[iCurrent+20]=this.st_version1
this.Control[iCurrent+21]=this.st_version2
this.Control[iCurrent+22]=this.uo_pdf
end on

on w_constancia_06_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.mle_dirigido_a)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.cb_redactar)
destroy(this.mle_texto_libre)
destroy(this.st_2)
destroy(this.st_texto_fecha)
destroy(this.dw_constancia)
destroy(this.st_numero)
destroy(this.st_decimal)
destroy(this.st_3)
destroy(this.em_precision_prom)
destroy(this.cb_promedio)
destroy(this.uo_nombre)
destroy(this.dw_certificado)
destroy(this.dw_revision_est)
destroy(this.st_nombre_posgrado)
destroy(this.sle_nombre_posgrado)
destroy(this.st_version1)
destroy(this.st_version2)
destroy(this.uo_pdf)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan
il_subsistema = uo_nombre.istr_carrera.str_cve_subsist
is_nivel = uo_nombre.istr_carrera.str_nivel

if il_carrera = 0 then return
end event

type st_sistema from w_master_main`st_sistema within w_constancia_06_2013
end type

type p_ibero from w_master_main`p_ibero within w_constancia_06_2013
end type

type st_1 from statictext within w_constancia_06_2013
integer x = 73
integer y = 836
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

type mle_dirigido_a from multilineedit within w_constancia_06_2013
integer x = 73
integer y = 912
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
string text = "A QUIEN CORRESPONDA:"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_fecha from statictext within w_constancia_06_2013
integer x = 2464
integer y = 920
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

type em_fecha from editmask within w_constancia_06_2013
integer x = 2528
integer y = 1016
integer width = 434
integer height = 100
integer taborder = 50
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

type cb_redactar from commandbutton within w_constancia_06_2013
integer x = 3109
integer y = 1012
integer width = 366
integer height = 108
integer taborder = 70
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
string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_texto2,setting,ls_nombre_posgrado,ls_desc_nivel
datetime ldttm_fecha
integer li_num_lineas, li_ascii, li_precision
integer li_periodo_actual,li_anio_actual,li_rows_child
decimal ld_promedio, ldc_creditos, ldc_creditos_totales
boolean lb_error_plan
integer li_pend_opcion_terminal,li_pend_servicio_social,li_pend_creditos
integer li_rows_revision,li_row,li_cred_minimos,li_cred_cursados

li_pend_opcion_terminal = 0
li_pend_servicio_social = 0
li_pend_creditos = 0

//if is_nivel <> 'L' then	
if is_nivel = 'P' then	
	MessageBox("Error","Debe escoger solo carreras de 'Licenciatura'", StopSign!)
	return
end if

ls_fecha = em_fecha.text

ldttm_fecha = datetime(date(ls_fecha),time("00:00:00"))

ls_texto_fecha = f_obten_datetime_en_texto(ldttm_fecha)

st_texto_fecha.text = ls_texto_fecha

ls_dirigido_a = mle_dirigido_a.text

ls_dirigido_a = f_quita_comillas(ls_dirigido_a)

ls_texto_libre = mle_texto_libre.text

ls_texto2 = f_obten_asc(ls_texto_libre, li_num_lineas)

ls_texto2 = f_quita_comillas(ls_texto2)

dw_constancia.object.st_dirigido_a.text = ls_dirigido_a

dw_constancia.object.st_texto_libre.text = ls_texto2

li_precision = integer(em_precision_prom.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 2
end if


f_obten_promedio_creditos(il_cuenta, il_carrera, il_plan, ld_promedio, ldc_creditos)

ldc_creditos_totales = f_obten_cred_total(il_carrera, il_plan)

li_periodo_actual= f_obten_periodo_actual()
li_anio_actual= f_obten_anio_actual()

setting = dw_constancia.Object.DataWindow.Nested

datastore dwr_tabla


dwr_tabla = CREATE datastore
dwr_tabla.DataObject = 'd_mat_insc_horario'  
dwr_tabla.SetTransObject(gtr_sce)  
li_rows_child = dwr_tabla.Retrieve(il_cuenta,li_periodo_actual,li_anio_actual)

dw_certificado.Reset()
dw_revision_est.Reset()

hist_alumno_areas(il_cuenta, il_carrera, il_plan, il_subsistema, dw_certificado, dw_revision_est, is_nivel)
li_rows_revision= dw_revision_est.Rowcount()
for li_row = 1 to li_rows_revision
	li_cred_minimos = dw_revision_est.GetItemNumber(li_row,"minimos")
	li_cred_cursados = dw_revision_est.GetItemNumber(li_row,"cursados")
	//Si le faltan créditos y no son de 3 (opcion terminal) ni de 4 (servicio social) no se puede imprimir la constancia
	if li_cred_cursados < li_cred_minimos  then
		if li_row = 3 then
			li_pend_opcion_terminal = 1
		elseif li_row=4 then
			li_pend_servicio_social = 1			
		else
			li_pend_creditos = 1
			exit
		end if	
	end if
next

if li_pend_creditos = 1 or li_pend_opcion_terminal = 1 or li_pend_servicio_social = 1 then
	MessageBox("Créditos Pendientes", "La constancia no puede imprimirse ya que el alumno tiene créditos pendientes")
	m_menu_constancias_2013.m_archivo.m_imprimir.Disable()
	return
else
	m_menu_constancias_2013.m_archivo.m_imprimir.Enable()	
end if

ls_nombre_posgrado = sle_nombre_posgrado.text

ll_renglones = dw_constancia.Retrieve(il_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2,ld_promedio,&
					ldc_creditos, li_precision,ldc_creditos_totales,li_periodo_actual,li_anio_actual,li_rows_child,&
					li_pend_creditos, li_pend_opcion_terminal, li_pend_servicio_social,is_nivel,ls_nombre_posgrado,il_carrera, il_plan)

ll_renglon_actual =dw_constancia.GetRow()

if (ll_renglones>0) then
	uo_pdf.enabled=true
	
	//  Parametros: DW, nombre archivo, ruta archivo, escala por default. cph 29 sept 2021.
	uo_pdf.inicializa_dw(dw_constancia,"","","98") // inicializa el uo_pdf para generar PDF cph 29 sept 2021
end if
end event

type mle_texto_libre from multilineedit within w_constancia_06_2013
integer x = 73
integer y = 1288
integer width = 2208
integer height = 288
integer taborder = 30
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

type st_2 from statictext within w_constancia_06_2013
integer x = 73
integer y = 1212
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

type st_texto_fecha from statictext within w_constancia_06_2013
boolean visible = false
integer x = 73
integer y = 1600
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

type dw_constancia from uo_master_dw within w_constancia_06_2013
integer x = 73
integer y = 1804
integer width = 3401
integer height = 976
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_constancias_06"
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
istr_constancias.si_num_constancia = 3
istr_constancias.sw_window = parent
//istr_constancias.suo_user_object = uo_nombre

m_menu_constancias_2013.istr_constancia = istr_constancias
end event

type st_numero from statictext within w_constancia_06_2013
boolean visible = false
integer x = 1417
integer y = 1132
integer width = 2322
integer height = 76
boolean bringtotop = true
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

type st_decimal from statictext within w_constancia_06_2013
boolean visible = false
integer x = 1426
integer y = 1264
integer width = 2322
integer height = 76
boolean bringtotop = true
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

type st_3 from statictext within w_constancia_06_2013
integer x = 2542
integer y = 1360
integer width = 434
integer height = 76
boolean bringtotop = true
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

type em_precision_prom from editmask within w_constancia_06_2013
integer x = 2665
integer y = 1456
integer width = 187
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "2"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "###0"
end type

event modified;string ls_precision
integer li_precision

ls_precision = this.text
li_precision = integer(ls_precision)

if li_precision < 1 or li_precision >4 then
	ls_precision = "2"
	this.text= ls_precision	
end if



end event

type cb_promedio from commandbutton within w_constancia_06_2013
boolean visible = false
integer x = 3269
integer y = 1404
integer width = 306
integer height = 108
integer taborder = 80
boolean bringtotop = true
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

type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_06_2013
event destroy ( )
integer x = 78
integer y = 308
integer width = 3241
integer height = 516
integer taborder = 10
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista_const2::destroy
end on

event constructor;call super::constructor;m_menu_constancias_2013.objeto = this
end event

type dw_certificado from datawindow within w_constancia_06_2013
boolean visible = false
integer x = 2272
integer y = 20
integer width = 494
integer height = 272
integer taborder = 90
boolean bringtotop = true
string dataobject = "dw_certificado_ext2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_revision_est from datawindow within w_constancia_06_2013
boolean visible = false
integer x = 2802
integer y = 20
integer width = 494
integer height = 272
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_rev_est_fmc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_nombre_posgrado from statictext within w_constancia_06_2013
integer x = 73
integer y = 1608
integer width = 507
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
string text = "Nombre Posgrado:"
boolean focusrectangle = false
end type

type sle_nombre_posgrado from singlelineedit within w_constancia_06_2013
integer x = 73
integer y = 1684
integer width = 2386
integer height = 92
integer taborder = 90
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type st_version1 from statictext within w_constancia_06_2013
integer x = 905
integer y = 108
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

type st_version2 from statictext within w_constancia_06_2013
boolean visible = false
integer x = 1010
integer y = 108
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

type uo_pdf from uo_imprime_pdf within w_constancia_06_2013
integer x = 2318
integer y = 1196
integer taborder = 80
boolean bringtotop = true
boolean enabled = false
end type

on uo_pdf.destroy
call uo_imprime_pdf::destroy
end on

