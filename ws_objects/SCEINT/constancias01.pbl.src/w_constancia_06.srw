$PBExportHeader$w_constancia_06.srw
$PBExportComments$Protocolo
forward
global type w_constancia_06 from window
end type
type uo_nombre from uo_nombre_alumno_const within w_constancia_06
end type
type st_nombre_posgrado from statictext within w_constancia_06
end type
type sle_nombre_posgrado from singlelineedit within w_constancia_06
end type
type cbx_social from checkbox within w_constancia_06
end type
type cbx_terminal from checkbox within w_constancia_06
end type
type dw_revision_est from datawindow within w_constancia_06
end type
type dw_certificado from datawindow within w_constancia_06
end type
type st_numero from statictext within w_constancia_06
end type
type st_decimal from statictext within w_constancia_06
end type
type cb_promedio from commandbutton within w_constancia_06
end type
type st_3 from statictext within w_constancia_06
end type
type em_precision_prom from editmask within w_constancia_06
end type
type st_texto_fecha from statictext within w_constancia_06
end type
type st_fecha from statictext within w_constancia_06
end type
type em_fecha from editmask within w_constancia_06
end type
type cb_redactar from commandbutton within w_constancia_06
end type
type dw_constancia from datawindow within w_constancia_06
end type
type mle_texto_libre from multilineedit within w_constancia_06
end type
type st_2 from statictext within w_constancia_06
end type
type st_1 from statictext within w_constancia_06
end type
type mle_dirigido_a from multilineedit within w_constancia_06
end type
end forward

global type w_constancia_06 from window
integer width = 3593
integer height = 3260
boolean titlebar = true
string title = "Protocolo"
string menuname = "m_menu_constancias"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
uo_nombre uo_nombre
st_nombre_posgrado st_nombre_posgrado
sle_nombre_posgrado sle_nombre_posgrado
cbx_social cbx_social
cbx_terminal cbx_terminal
dw_revision_est dw_revision_est
dw_certificado dw_certificado
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
global w_constancia_06 w_constancia_06

type variables
str_impresion_constancias istr_constancias 
end variables

on w_constancia_06.create
if this.MenuName = "m_menu_constancias" then this.MenuID = create m_menu_constancias
this.uo_nombre=create uo_nombre
this.st_nombre_posgrado=create st_nombre_posgrado
this.sle_nombre_posgrado=create sle_nombre_posgrado
this.cbx_social=create cbx_social
this.cbx_terminal=create cbx_terminal
this.dw_revision_est=create dw_revision_est
this.dw_certificado=create dw_certificado
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
this.st_nombre_posgrado,&
this.sle_nombre_posgrado,&
this.cbx_social,&
this.cbx_terminal,&
this.dw_revision_est,&
this.dw_certificado,&
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

on w_constancia_06.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.st_nombre_posgrado)
destroy(this.sle_nombre_posgrado)
destroy(this.cbx_social)
destroy(this.cbx_terminal)
destroy(this.dw_revision_est)
destroy(this.dw_certificado)
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

type uo_nombre from uo_nombre_alumno_const within w_constancia_06
integer x = 64
integer y = 44
integer width = 3241
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_const::destroy
end on

type st_nombre_posgrado from statictext within w_constancia_06
integer x = 64
integer y = 1260
integer width = 507
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
string text = "Nombre Posgrado:"
boolean focusrectangle = false
end type

type sle_nombre_posgrado from singlelineedit within w_constancia_06
integer x = 64
integer y = 1336
integer width = 2386
integer height = 92
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

type cbx_social from checkbox within w_constancia_06
boolean visible = false
integer x = 3534
integer y = 412
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Social"
boolean lefttext = true
end type

type cbx_terminal from checkbox within w_constancia_06
boolean visible = false
integer x = 3474
integer y = 304
integer width = 306
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Terminal"
boolean lefttext = true
end type

type dw_revision_est from datawindow within w_constancia_06
boolean visible = false
integer x = 3045
integer y = 972
integer width = 494
integer height = 272
integer taborder = 100
string dataobject = "dw_rev_est_fmc"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_certificado from datawindow within w_constancia_06
boolean visible = false
integer x = 2514
integer y = 972
integer width = 494
integer height = 272
integer taborder = 90
string dataobject = "dw_certificado_ext2"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_numero from statictext within w_constancia_06
boolean visible = false
integer x = 1394
integer y = 864
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

type st_decimal from statictext within w_constancia_06
boolean visible = false
integer x = 1385
integer y = 884
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

type cb_promedio from commandbutton within w_constancia_06
boolean visible = false
integer x = 3621
integer y = 1004
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

type st_3 from statictext within w_constancia_06
boolean visible = false
integer x = 2528
integer y = 544
integer width = 439
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

type em_precision_prom from editmask within w_constancia_06
boolean visible = false
integer x = 2651
integer y = 640
integer width = 192
integer height = 100
integer taborder = 40
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

event modified;
string ls_precision
integer li_precision

ls_precision = this.text
li_precision = integer(ls_precision)

if li_precision < 1 or li_precision >4 then
	ls_precision = "2"
	this.text= ls_precision	
end if

end event

type st_texto_fecha from statictext within w_constancia_06
boolean visible = false
integer x = 535
integer y = 1312
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

type st_fecha from statictext within w_constancia_06
integer x = 2555
integer y = 944
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

type em_fecha from editmask within w_constancia_06
integer x = 2619
integer y = 1040
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

type cb_redactar from commandbutton within w_constancia_06
integer x = 2683
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
string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_report, setting, ls_data, ls_data2
string ls_nivel, ls_nombre_posgrado
datetime ldttm_fecha
integer li_precision, li_carrera, li_plan, li_subsistema
integer li_periodo_actual, li_anio_actual, li_x, li_y, li_w, li_h, li_ret_child, li_yh, li_yrel
integer li_rows_child, li_lon_reg, li_lon_reg_tot, li_row
decimal ld_promedio, ldc_creditos, ldc_creditos_totales
integer li_cred_minimos, li_cred_cursados, li_rows_revision, li_pend_opcion_terminal, li_pend_servicio_social, li_pend_creditos
integer li_num_lineas,li_pos

li_pend_opcion_terminal = 0
li_pend_servicio_social = 0
li_pend_creditos = 0

ls_cuenta = uo_nombre.em_cuenta.text

if not isnumber(ls_cuenta) then
	MessageBox("Error","La cuenta escrita es inválida", StopSign!)
	m_menu_constancias.m_archivo.m_imprimir.Disable()
	return
else
	m_menu_constancias.m_archivo.m_imprimir.Enable()	
end if

ll_cuenta = long(ls_cuenta)

ls_fecha = em_fecha.text

ldttm_fecha = datetime(date(ls_fecha),time("00:00:00"))

ls_texto_fecha = f_obten_datetime_en_texto(ldttm_fecha)

st_texto_fecha.text = ls_texto_fecha

ls_dirigido_a = mle_dirigido_a.text

ls_texto_libre = mle_texto_libre.text

li_num_lineas = f_obten_num_lineas(ls_texto_libre)

ls_dirigido_a = f_quita_comillas(ls_dirigido_a)

dw_constancia.object.st_dirigido_a.text = ls_dirigido_a

ls_texto_libre = f_quita_comillas(ls_texto_libre)

dw_constancia.object.st_texto_libre.text = ls_texto_libre

li_precision = integer(em_precision_prom.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 2
end if

li_carrera = f_obten_cve_carrera(ll_cuenta)

li_plan = f_obten_cve_plan(ll_cuenta)

li_subsistema = f_obten_cve_subsistema(ll_cuenta)

ls_nivel = f_obten_nivel(ll_cuenta)

f_obten_promedio_creditos(ll_cuenta, li_carrera, li_plan, ld_promedio, ldc_creditos)

ldc_creditos_totales = f_obten_cred_total(li_carrera, li_plan)

li_periodo_actual= f_obten_periodo_actual()
li_anio_actual= f_obten_anio_actual()



setting = dw_constancia.Object.DataWindow.Nested


datastore dwr_tabla


dwr_tabla = CREATE datastore
dwr_tabla.DataObject = 'd_mat_insc_horario'  
dwr_tabla.SetTransObject(gtr_sce)  
li_rows_child = dwr_tabla.Retrieve(ll_cuenta,li_periodo_actual,li_anio_actual)

dw_certificado.Reset()
dw_revision_est.Reset()

hist_alumno_areas(ll_cuenta, li_carrera, li_plan, li_subsistema, dw_certificado, dw_revision_est, ls_nivel)
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

//if li_pend_creditos = 1 or li_pend_opcion_terminal = 1 or li_pend_servicio_social = 1 then
if li_pend_creditos = 1000 or li_pend_opcion_terminal = 1 or li_pend_servicio_social = 1 then  //////Quitar esta linea solo para pruebas
	MessageBox("Créditos Pendientes", "La constancia no puede imprimirse ya que el alumno tiene créditos pendientes")
	m_menu_constancias.m_archivo.m_imprimir.Disable()
	return
else
	m_menu_constancias.m_archivo.m_imprimir.Enable()	
end if

//Utilizado para probar la opcion terminal y servicio social
//if cbx_terminal.checked then
//	li_pend_opcion_terminal = 1
//end if
//
//if cbx_social.checked then
//	li_pend_servicio_social = 1
//end if

ls_nombre_posgrado = sle_nombre_posgrado.text

ll_renglones = dw_constancia.Retrieve(ll_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto_libre,ld_promedio,&
					ldc_creditos, li_precision,ldc_creditos_totales,li_periodo_actual,li_anio_actual,li_rows_child, &
					li_pend_creditos, li_pend_opcion_terminal, li_pend_servicio_social, ls_nivel, ls_nombre_posgrado)

ll_renglon_actual =dw_constancia.GetRow()

istr_constancias.sl_cuenta = ll_cuenta
istr_constancias.si_num_constancia = 6
istr_constancias.sw_window = parent
istr_constancias.suo_user_object = uo_nombre

m_menu_constancias.istr_constancia = istr_constancias


//
//
//
////ls_report= dw_constancia.Object.d_mat_insc_horario.DataObject
////li_ret_child= dw_constancia.getchild(ls_report, dwr_tabla)
////if li_ret_child = -1 then MessageBox ("Error", "No se pudo obtener la referencia al reporte")
//
//li_lon_reg =88
//
////li_rows_child= dwr_tabla.rowcount()
//
//li_lon_reg_tot= li_lon_reg*li_rows_child
//
//ls_data = dw_constancia.Object.cf_texto_promedio.Attributes
//ls_data2= dw_constancia.Object.DataWindow.Objects
//
//
////li_yrel =dw_constancia.object.cf_texto_promedio[ll_renglon_actual].y 
//li_yrel =dw_constancia.Object.DataWindow.cf_texto_promedio.y 
//
////dw_constancia.object.cf_texto_promedio[ll_renglon_actual].y=  li_yrel + li_lon_reg_tot
//dw_constancia.Object.DataWindow.cf_texto_promedio.y=  li_yrel + li_lon_reg_tot
//
//
//
end event

type dw_constancia from datawindow within w_constancia_06
integer x = 64
integer y = 1484
integer width = 3401
integer height = 1572
integer taborder = 60
string dataobject = "d_constancias_06"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;Datawindowchild dwr_tabla
integer li_ret_child
str_impresion_constancias lstr_constancias 


this.SetTransObject(gtr_sce)

m_menu_constancias.dw = this


//Orientación Portrait
this.Object.DataWindow.Print.Orientation	= 2

//Zoom Normal
this.Object.DataWindow.Zoom = 100	
this.Object.DataWindow.Print.Preview.Zoom = 100	


istr_constancias.sdw_datawindow = this
istr_constancias.sl_cuenta = 0
istr_constancias.si_num_constancia = 6
istr_constancias.sw_window = parent
istr_constancias.suo_user_object = uo_nombre

m_menu_constancias.istr_constancia = istr_constancias

//li_ret_child = this.getchild('cuenta', dwr_tabla)
//
//if li_ret_child = -1 then MessageBox("Error", "No se pudo obtener d_mat_insc_horario")
//
//this.SetTransObject(gtr_sce)

//dwr_tabla.Modify("DataWindow.Zoom=50")
//dwr_tabla.Object.DataWindow.Zoom = 85	

end event

type mle_texto_libre from multilineedit within w_constancia_06
integer x = 64
integer y = 944
integer width = 2386
integer height = 288
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_constancia_06
integer x = 64
integer y = 876
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

type st_1 from statictext within w_constancia_06
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

type mle_dirigido_a from multilineedit within w_constancia_06
integer x = 64
integer y = 576
integer width = 2386
integer height = 288
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "A QUIEN CORRESPONDA:"
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

