$PBExportHeader$w_constancia_04_defensa.srw
$PBExportComments$Semestre Anterior con Calificaciones
forward
global type w_constancia_04_defensa from window
end type
type uo_2 from uo_per_ani_const within w_constancia_04_defensa
end type
type uo_1 from uo_per_ani_const within w_constancia_04_defensa
end type
type cbx_verano from checkbox within w_constancia_04_defensa
end type
type uo_nombre from uo_nombre_alumno_const within w_constancia_04_defensa
end type
type st_numero from statictext within w_constancia_04_defensa
end type
type st_decimal from statictext within w_constancia_04_defensa
end type
type cb_promedio from commandbutton within w_constancia_04_defensa
end type
type st_3 from statictext within w_constancia_04_defensa
end type
type em_precision_prom from editmask within w_constancia_04_defensa
end type
type st_texto_fecha from statictext within w_constancia_04_defensa
end type
type st_fecha from statictext within w_constancia_04_defensa
end type
type em_fecha from editmask within w_constancia_04_defensa
end type
type cb_redactar from commandbutton within w_constancia_04_defensa
end type
type dw_constancia from datawindow within w_constancia_04_defensa
end type
type mle_texto_libre from multilineedit within w_constancia_04_defensa
end type
type st_2 from statictext within w_constancia_04_defensa
end type
type st_1 from statictext within w_constancia_04_defensa
end type
type mle_dirigido_a from multilineedit within w_constancia_04_defensa
end type
end forward

global type w_constancia_04_defensa from window
integer width = 4037
integer height = 3960
boolean titlebar = true
string title = "Semestre Anterior con Calificaciones"
string menuname = "m_menu_constancias"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
event ue_valida ( )
uo_2 uo_2
uo_1 uo_1
cbx_verano cbx_verano
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
global w_constancia_04_defensa w_constancia_04_defensa

type variables
str_impresion_constancias istr_constancias 
uo_periodo_servicios iuo_periodo_servicios
uo_per_ani iuo_per_ani
end variables

event ue_valida();string ls_periodo1
int li_periodo1,li_anio1,li_anio2,li_periodo2,li_min, li_aux1, li_max

ls_periodo1= uo_1.em_per.text
select descripcion into :uo_1.em_per.text from periodo where periodo=:gi_periodo using gtr_sce;

select periodo into :li_periodo1 from periodo where descripcion=:ls_periodo1 using gtr_sce;

//li_periodo1=iuo_periodo_servicios.f_recupera_id(ls_periodo1,'L')

/*
choose case ls_periodo1
	case 'Primavera'
		li_periodo1 = 0
	case 'Otoño'
		li_periodo1 = 2
end choose
*/

Select Min(periodo), Max(periodo) into :li_min, :li_max from periodo where tipo=:gs_tipo_periodo using gtr_sce;

li_anio1 = integer(uo_1.em_ani.text)

choose case li_periodo1
	case li_max
		li_periodo2 = li_min
		li_anio2 = li_anio1 +1
		if gs_tipo_periodo='S' then 
			cbx_verano.visible = true
			cbx_verano.text = 'Verano ' + string(li_anio2)
		end if
	case else
		li_periodo1=li_periodo1+1
		li_periodo2=li_periodo1+1
		li_anio2=li_anio1
		if gs_tipo_periodo='S' then
			cbx_verano.visible = true
			cbx_verano.checked = false
			cbx_verano.text = 'Verano ' + string(li_anio2)
		else
			cbx_verano.visible = false
		end if
end choose

select descripcion into :uo_1.em_per.text from periodo where periodo=:li_periodo1 using gtr_sce;
uo_2.em_ani.text = string(li_anio1)

select descripcion into :uo_2.em_per.text from periodo where periodo=:li_periodo2 using gtr_sce;
uo_2.em_ani.text = string(li_anio2)


/*	
choose case li_periodo1
	case 0
		li_periodo2 = 2
		li_anio2 = li_anio1 -1
		cbx_verano.visible = false
		cbx_verano.checked = false
	case 2
		li_periodo2 = 0
		li_anio2 = li_anio1 
		cbx_verano.visible = true
		cbx_verano.checked = false
		cbx_verano.text = 'Verano ' + string(li_anio2)
	case 1
		li_periodo2 = 0
		li_anio2 = li_anio1 
		cbx_verano.visible = true
		cbx_verano.text = 'Verano ' + string(li_anio2)
		uo_1.em_per.text =  '2'
		uo_1.em_ani.text = string(li_anio1)
end choose
*/

end event

on w_constancia_04_defensa.create
if this.MenuName = "m_menu_constancias" then this.MenuID = create m_menu_constancias
this.uo_2=create uo_2
this.uo_1=create uo_1
this.cbx_verano=create cbx_verano
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
this.Control[]={this.uo_2,&
this.uo_1,&
this.cbx_verano,&
this.uo_nombre,&
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

on w_constancia_04_defensa.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.cbx_verano)
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
int li_anio1,li_periodo1,li_anio2,li_periodo2

x=1
y=1

if isnull(gi_numscob) OR not (isvalid(gtr_scob)) then gi_numscob = 0
iuo_periodo_servicios = CREATE uo_periodo_servicios
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 

//iuo_per_ani = CREATE uo_per_ani


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

select periodo,anio
	into :li_periodo1,:li_anio1
from periodos_por_procesos
where cve_proceso = 5 and tipo_periodo=:gs_tipo_periodo using gtr_sce;

Select descripcion into :uo_1.em_per.text from periodo where periodo=:li_periodo1 using gtr_sce;

uo_1.em_ani.text = string(li_anio1)
li_periodo2=li_periodo1
li_anio2=li_anio1
iuo_periodo_servicios.f_recupera_periodo_siguiente( li_periodo2, li_anio2, gtr_sce)

/*
choose case li_periodo1
	case 0
		li_periodo2 = 2
		li_anio2 = li_anio1 -1
	case 2
		li_periodo2 = 0
		li_anio2 = li_anio1 
		cbx_verano.visible = true
		cbx_verano.text = 'Verano ' + string(li_anio2)
	case 1
		li_periodo2 = 0
		li_anio2 = li_anio1 
		cbx_verano.visible = true
		cbx_verano.text = 'Verano ' + string(li_anio2)
		uo_1.em_per.text =  '2'
		uo_1.em_ani.text = string(li_anio1)
end choose
*/

Select descripcion into :uo_2.em_per.text from periodo where periodo=:li_periodo2 using gtr_sce;

//uo_2.em_per.text = ls_descr
uo_2.em_ani.text = string(li_anio2)

end event

event close;

if gi_numscob <= 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if

gi_numscob = gi_numscob - 1


end event

event doubleclicked;string ls_texto_abierto, ls_inscrito
long ll_cuenta,ll_cta
int li_periodo, li_anio


dw_constancia.reset()
ll_cuenta = long(uo_nombre.em_cuenta.text)

  SELECT banderas_inscrito.cuenta  
    INTO :ll_cta  
    FROM banderas_inscrito  
   WHERE banderas_inscrito.cuenta = :ll_cuenta using gtr_sce ;

if ll_cta > 0 then
	select periodo,anio
	into :li_periodo,:li_anio
	from periodos_por_procesos
	where cve_proceso = 5 and tipo_periodo=:gs_tipo_periodo using gtr_sce;

	if string(f_obten_sexo_alumno( ll_cuenta )) = 'M' then
		ls_inscrito = 'inscrito'
	else
		ls_inscrito = 'inscrita'
	end if
	
//	ls_texto_abierto = 'Actualmente está ' + ls_inscrito + ' en su ' + lower(f_obten_ordinal(f_obten_num_periodo( ll_cuenta,  li_periodo ,  li_anio  ))) + ' periodo escolar ' + f_obten_desc_larga_perido_anio_2(li_periodo ,  li_anio)
	
	mle_texto_libre.text = ls_texto_abierto
else
	mle_texto_libre.text = ''
end if
end event

type uo_2 from uo_per_ani_const within w_constancia_04_defensa
integer x = 1499
integer y = 32
integer taborder = 40
end type

on uo_2.destroy
call uo_per_ani_const::destroy
end on

type uo_1 from uo_per_ani_const within w_constancia_04_defensa
integer x = 64
integer y = 32
integer taborder = 20
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani_const::destroy
end on

event constructor;call super::constructor;iw_padre = parent
end event

type cbx_verano from checkbox within w_constancia_04_defensa
boolean visible = false
integer x = 2816
integer y = 96
integer width = 512
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Verano"
end type

type uo_nombre from uo_nombre_alumno_const within w_constancia_04_defensa
integer x = 64
integer y = 240
integer width = 3241
integer height = 428
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno_const::destroy
end on

type st_numero from statictext within w_constancia_04_defensa
boolean visible = false
integer x = 1376
integer y = 960
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

type st_decimal from statictext within w_constancia_04_defensa
boolean visible = false
integer x = 1385
integer y = 1056
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

type cb_promedio from commandbutton within w_constancia_04_defensa
boolean visible = false
integer x = 3227
integer y = 1172
integer width = 306
integer height = 108
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

type st_3 from statictext within w_constancia_04_defensa
integer x = 2496
integer y = 1132
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

type em_precision_prom from editmask within w_constancia_04_defensa
integer x = 2610
integer y = 1228
integer width = 206
integer height = 100
integer taborder = 60
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

event modified;
string ls_precision
integer li_precision

ls_precision = this.text
li_precision = integer(ls_precision)

if li_precision < 1 or li_precision >4 then
	ls_precision = "1"
	this.text= ls_precision	
end if




end event

type st_texto_fecha from statictext within w_constancia_04_defensa
boolean visible = false
integer x = 279
integer y = 1420
integer width = 2889
integer height = 76
integer taborder = 80
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

type st_fecha from statictext within w_constancia_04_defensa
integer x = 2432
integer y = 764
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

type em_fecha from editmask within w_constancia_04_defensa
integer x = 2496
integer y = 860
integer width = 434
integer height = 100
integer taborder = 50
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

type cb_redactar from commandbutton within w_constancia_04_defensa
integer x = 3099
integer y = 852
integer width = 366
integer height = 108
integer taborder = 90
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
datetime ldttm_fecha
integer li_precision, li_carrera, li_plan
integer li_periodo_actual, li_anio_actual, li_x, li_y, li_w, li_h, li_ret_child, li_yh, li_yrel,li_periodo_2, li_anio_2,li_periodo_v, li_anio_v
integer li_rows_child, li_lon_reg, li_lon_reg_tot, li_num_lineas,li_rows_child2,li_rows_child3,li_pos
decimal ld_promedio, ldc_creditos, ldc_creditos_totales
string ls_texto2,ls_periodo1,ls_periodo2

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

ls_texto2 =  f_obten_asc(ls_texto_libre, li_num_lineas)

//li_num_lineas = f_obten_num_lineas(ls_texto_libre)

ls_dirigido_a = f_quita_comillas(ls_dirigido_a)

//dw_constancia.object.st_dirigido_a.text = ls_dirigido_a

ls_texto2 = f_quita_comillas(ls_texto2)

//dw_constancia.object.st_texto_libre.text = ls_texto2

li_precision = integer(em_precision_prom.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 1
end if

li_carrera = f_obten_cve_carrera(ll_cuenta)

li_plan = f_obten_cve_plan(ll_cuenta)

f_obten_promedio_creditos(ll_cuenta, li_carrera, li_plan, ld_promedio, ldc_creditos)

ldc_creditos_totales = f_obten_cred_total(li_carrera, li_plan)

ls_periodo1= uo_1.em_per.text

select periodo into :li_periodo_actual from periodo where descripcion=:ls_periodo1 using gtr_sce;

//li_periodo_actual =  iuo_periodo_servicios.f_recupera_id( ls_periodo1, "L")

/*
choose case ls_periodo1
	case 'Primavera'
		li_periodo_actual = 0
	case 'Verano'
		li_periodo_actual = 1
	case 'Otoño'
		li_periodo_actual = 2
end choose
*/
li_anio_actual= integer(uo_1.em_ani.text)

if cbx_verano.checked = true then
	li_periodo_v = 1
	li_anio_v = integer(uo_1.em_ani.text)
else
	li_periodo_v = 0
	li_anio_v = 0
end if

ls_periodo2= uo_2.em_per.text

select periodo into :li_periodo_2 from periodo where descripcion=:ls_periodo2 using gtr_sce;

/*
choose case ls_periodo2
	case 'Primavera'
		li_periodo_2 = 0
	case 'Verano'
		li_periodo_2 = 1
	case 'Otoño'
		li_periodo_2 = 2
end choose
*/

li_anio_2 = integer(uo_2.em_ani.text)

setting = dw_constancia.Object.DataWindow.Nested


datastore dwr_tabla


dwr_tabla = CREATE datastore
dwr_tabla.DataObject = 'd_mat_insc_calif_hist_desc_periodo'  
dwr_tabla.SetTransObject(gtr_sce)  
li_rows_child = dwr_tabla.Retrieve(ll_cuenta,li_periodo_actual,li_anio_actual)
li_rows_child2 = dwr_tabla.Retrieve(ll_cuenta,li_periodo_2,li_anio_2)
li_rows_child3 = dwr_tabla.Retrieve(ll_cuenta,li_periodo_v,li_anio_v)
if li_rows_child = 0 then li_rows_child = 5
if li_rows_child2 = 0 then li_rows_child2 = 5
if li_rows_child3 = 0 then li_rows_child3 = 5
li_rows_child = li_rows_child + li_rows_child2 + li_rows_child3 + 10

//st_numero.text = f_obten_ordinal(f_obten_num_periodo(ll_cuenta,li_periodo_actual,li_anio_actual))


ll_renglones = dw_constancia.Retrieve(ll_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2,ld_promedio,&
					ldc_creditos, li_precision,ldc_creditos_totales,li_periodo_actual,li_anio_actual,li_rows_child, li_num_lineas,li_periodo_2,li_anio_2,li_periodo_v,li_anio_v, li_carrera)

ll_renglon_actual =dw_constancia.GetRow()

istr_constancias.sl_cuenta = ll_cuenta
istr_constancias.si_num_constancia = 4
istr_constancias.sw_window = parent
istr_constancias.suo_user_object = uo_nombre

m_menu_constancias.istr_constancia = istr_constancias

end event

type dw_constancia from datawindow within w_constancia_04_defensa
integer x = 64
integer y = 1468
integer width = 3858
integer height = 2260
integer taborder = 100
string dataobject = "d_constancias_04_defensa"
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
istr_constancias.si_num_constancia = 4
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

type mle_texto_libre from multilineedit within w_constancia_04_defensa
integer x = 64
integer y = 1132
integer width = 2208
integer height = 288
integer taborder = 30
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

type st_2 from statictext within w_constancia_04_defensa
integer x = 64
integer y = 1056
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

type st_1 from statictext within w_constancia_04_defensa
integer x = 64
integer y = 672
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

type mle_dirigido_a from multilineedit within w_constancia_04_defensa
integer x = 64
integer y = 764
integer width = 2208
integer height = 288
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
string text = "SECRETARIA DE LA DEFENSA NACIONAL:"
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

