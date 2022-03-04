$PBExportHeader$w_constancia_04_telmex_2013_resp.srw
forward
global type w_constancia_04_telmex_2013_resp from w_master_main
end type
type st_1 from statictext within w_constancia_04_telmex_2013_resp
end type
type st_fecha from statictext within w_constancia_04_telmex_2013_resp
end type
type em_fecha from editmask within w_constancia_04_telmex_2013_resp
end type
type cb_redactar from commandbutton within w_constancia_04_telmex_2013_resp
end type
type st_2 from statictext within w_constancia_04_telmex_2013_resp
end type
type st_texto_fecha from statictext within w_constancia_04_telmex_2013_resp
end type
type dw_constancia from uo_master_dw within w_constancia_04_telmex_2013_resp
end type
type st_numero from statictext within w_constancia_04_telmex_2013_resp
end type
type st_decimal from statictext within w_constancia_04_telmex_2013_resp
end type
type st_3 from statictext within w_constancia_04_telmex_2013_resp
end type
type em_precision_prom from editmask within w_constancia_04_telmex_2013_resp
end type
type cb_promedio from commandbutton within w_constancia_04_telmex_2013_resp
end type
type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_04_telmex_2013_resp
end type
type uo_1 from uo_per_ani within w_constancia_04_telmex_2013_resp
end type
type mle_dirigido_a from multilineedit within w_constancia_04_telmex_2013_resp
end type
type mle_texto_libre from multilineedit within w_constancia_04_telmex_2013_resp
end type
end forward

global type w_constancia_04_telmex_2013_resp from w_master_main
integer width = 3717
integer height = 3012
string title = "TELMEX"
string menuname = "m_menu_constancias_2013"
st_1 st_1
st_fecha st_fecha
em_fecha em_fecha
cb_redactar cb_redactar
st_2 st_2
st_texto_fecha st_texto_fecha
dw_constancia dw_constancia
st_numero st_numero
st_decimal st_decimal
st_3 st_3
em_precision_prom em_precision_prom
cb_promedio cb_promedio
uo_nombre uo_nombre
uo_1 uo_1
mle_dirigido_a mle_dirigido_a
mle_texto_libre mle_texto_libre
end type
global w_constancia_04_telmex_2013_resp w_constancia_04_telmex_2013_resp

type variables
str_impresion_constancias_2013 istr_constancias
long il_cuenta,il_carrera,il_plan
end variables

forward prototypes
public function string wf_obten_texto_final (long al_cuenta)
end prototypes

public function string wf_obten_texto_final (long al_cuenta);string ls_sexo, ls_inscrit, ls_periodo, ls_periodo_texto
string ls_dia_mes_inicial, ls_dia_mes_final, ls_texto_final
integer li_periodo_actual, li_anio_actual
datetime ldttm_fecha_inicial, ldttm_fecha_final

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 

ls_sexo = f_obten_sexo_alumno( al_cuenta )

choose case (ls_sexo) 
	case "F" 
		ls_inscrit= "inscrita" 
	case else 
		ls_inscrit= "inscrito"
end choose
	
	
ls_periodo = f_obten_ordinal(f_obten_sem_cursados( al_cuenta ))

li_periodo_actual= f_obten_periodo_actual()

ls_periodo_texto = UPPER(luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, li_periodo_actual))

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN ""
END IF

//choose case li_periodo_actual  
//	case 0 
//		ls_periodo_texto="PRIMAVERA" 
//	case 1 
//		ls_periodo_texto="VERANO"   
//	case 2 
//		ls_periodo_texto= "OTOÑO" 
//	case else 
//		ls_periodo_texto= " "
//end choose


li_anio_actual=f_obten_anio_actual()

ldttm_fecha_inicial= f_obten_fechahora_evento( li_periodo_actual ,  li_anio_actual ,1)

ldttm_fecha_final= f_obten_fechahora_evento( li_periodo_actual ,  li_anio_actual ,2)

ls_dia_mes_inicial= f_obten_dia_mes_en_texto_dttm( ldttm_fecha_inicial)

ls_dia_mes_final= f_obten_dia_mes_en_texto_dttm(  ldttm_fecha_final )

IF li_periodo_actual = 1 THEN 
	ls_texto_final="Asimismo se hace constar que actualmente está "+ls_inscrit+" en el periodo " + lower(string(ls_periodo_texto))+ &
	  " "+ string(li_anio_actual)+" (del "+lower(string(ls_dia_mes_inicial))+ &
	  " al "+lower(string(ls_dia_mes_final))+")."	
ELSE
	ls_texto_final="Asimismo se hace constar que actualmente está "+ls_inscrit+" en su "+ &
	  lower(string(ls_periodo))+" periodo " + lower(string(ls_periodo_texto))+ &
	  " "+ string(li_anio_actual)+" (del "+lower(string(ls_dia_mes_inicial))+ &
	  " al "+lower(string(ls_dia_mes_final))+")."
END IF

return ls_texto_final

end function

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

on w_constancia_04_telmex_2013_resp.create
int iCurrent
call super::create
if this.MenuName = "m_menu_constancias_2013" then this.MenuID = create m_menu_constancias_2013
this.st_1=create st_1
this.st_fecha=create st_fecha
this.em_fecha=create em_fecha
this.cb_redactar=create cb_redactar
this.st_2=create st_2
this.st_texto_fecha=create st_texto_fecha
this.dw_constancia=create dw_constancia
this.st_numero=create st_numero
this.st_decimal=create st_decimal
this.st_3=create st_3
this.em_precision_prom=create em_precision_prom
this.cb_promedio=create cb_promedio
this.uo_nombre=create uo_nombre
this.uo_1=create uo_1
this.mle_dirigido_a=create mle_dirigido_a
this.mle_texto_libre=create mle_texto_libre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_fecha
this.Control[iCurrent+3]=this.em_fecha
this.Control[iCurrent+4]=this.cb_redactar
this.Control[iCurrent+5]=this.st_2
this.Control[iCurrent+6]=this.st_texto_fecha
this.Control[iCurrent+7]=this.dw_constancia
this.Control[iCurrent+8]=this.st_numero
this.Control[iCurrent+9]=this.st_decimal
this.Control[iCurrent+10]=this.st_3
this.Control[iCurrent+11]=this.em_precision_prom
this.Control[iCurrent+12]=this.cb_promedio
this.Control[iCurrent+13]=this.uo_nombre
this.Control[iCurrent+14]=this.uo_1
this.Control[iCurrent+15]=this.mle_dirigido_a
this.Control[iCurrent+16]=this.mle_texto_libre
end on

on w_constancia_04_telmex_2013_resp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_fecha)
destroy(this.em_fecha)
destroy(this.cb_redactar)
destroy(this.st_2)
destroy(this.st_texto_fecha)
destroy(this.dw_constancia)
destroy(this.st_numero)
destroy(this.st_decimal)
destroy(this.st_3)
destroy(this.em_precision_prom)
destroy(this.cb_promedio)
destroy(this.uo_nombre)
destroy(this.uo_1)
destroy(this.mle_dirigido_a)
destroy(this.mle_texto_libre)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan

if il_carrera = 0 then return
end event

type st_sistema from w_master_main`st_sistema within w_constancia_04_telmex_2013_resp
end type

type p_ibero from w_master_main`p_ibero within w_constancia_04_telmex_2013_resp
end type

type st_1 from statictext within w_constancia_04_telmex_2013_resp
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

type st_fecha from statictext within w_constancia_04_telmex_2013_resp
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

type em_fecha from editmask within w_constancia_04_telmex_2013_resp
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

type cb_redactar from commandbutton within w_constancia_04_telmex_2013_resp
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
string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_texto2,setting
datetime ldttm_fecha
integer li_num_lineas, li_ascii, li_precision
integer li_periodo_actual,li_anio_actual,li_rows_child
decimal ld_promedio, ldc_creditos, ldc_creditos_totales
boolean lb_inscrito

ls_fecha = em_fecha.text

ldttm_fecha = datetime(date(ls_fecha),time("00:00:00"))

ls_texto_fecha = f_obten_datetime_en_texto(ldttm_fecha)

st_texto_fecha.text = ls_texto_fecha

ls_dirigido_a = mle_dirigido_a.text

//ls_texto_libre = wf_obten_texto_final(il_cuenta)

IF TRIM(mle_texto_libre.text) = "" OR ISNULL(mle_texto_libre.text) THEN 
	//mle_texto_libre.text= ls_texto_libre
ELSE
	ls_texto_libre = mle_texto_libre.text
END IF

ls_texto2 =  f_obten_asc(ls_texto_libre, li_num_lineas)

dw_constancia.object.st_dirigido_a.text = ls_dirigido_a

ls_texto2 = f_quita_comillas(ls_texto2)

IF ISNULL(ls_texto2) THEN ls_texto2 = "" 
dw_constancia.object.st_texto_libre.text = ls_texto2

li_precision = integer(em_precision_prom.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 2
end if

f_obten_promedio_creditos(il_cuenta, il_carrera, il_plan, ld_promedio, ldc_creditos)

ldc_creditos_totales = f_obten_cred_total(il_carrera, il_plan)

li_periodo_actual= gi_periodo
li_anio_actual= gi_anio

setting = dw_constancia.Object.DataWindow.Nested

datastore dwr_tabla

dwr_tabla = CREATE datastore
dwr_tabla.DataObject = 'd_mat_insc_calif_hist'  
dwr_tabla.SetTransObject(gtr_sce)  
li_rows_child = dwr_tabla.Retrieve(il_cuenta,li_periodo_actual,li_anio_actual, li_precision, il_carrera)

li_rows_child = li_rows_child +1

st_numero.text = f_obten_ordinal(f_obten_num_periodo(il_cuenta,li_periodo_actual,li_anio_actual, il_carrera))

STRING ls_semtrim 
uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios
ls_semtrim = LOWER(luo_periodo_tipo_servicios.f_obten_desc_periodo_msg(gs_tipo_periodo))

/*Se verifica si tene materias en el periodo solicitado*/ 
LONG ll_materias 
SELECT COUNT(*) 
INTO :ll_materias 
 FROM materias,   
		historico  
WHERE ( materias.cve_mat = historico.cve_mat ) and  
		(historico.cuenta = :il_cuenta ) AND  
		(historico.periodo = :li_periodo_actual ) AND  
		(historico.anio = :li_anio_actual )  AND  
		historico.calificacion not in ("BA","BJ") AND  
		historico.cve_carrera = :il_carrera    
USING gtr_sce;		
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al verificar las materias cursadas.") 
	RETURN -1 
END IF 
IF ll_materias  <= 0 THEN 
	MESSAGEBOX("Aviso", "No se encontraron materias para el periodo seleccionado")
	RETURN -1
END IF
/**/

ll_renglones = dw_constancia.Retrieve(il_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2,ld_promedio,&
					ldc_creditos, li_precision,ldc_creditos_totales,li_periodo_actual,li_anio_actual,li_rows_child, li_num_lineas,il_carrera, ls_semtrim)
					
ll_renglon_actual =dw_constancia.GetRow()
end event

type st_2 from statictext within w_constancia_04_telmex_2013_resp
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

type st_texto_fecha from statictext within w_constancia_04_telmex_2013_resp
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

type dw_constancia from uo_master_dw within w_constancia_04_telmex_2013_resp
integer x = 73
integer y = 1608
integer width = 3401
integer height = 1172
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_constancias_04_telmex"
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
istr_constancias.si_num_constancia = 4
istr_constancias.sw_window = parent
//istr_constancias.suo_user_object = uo_nombre

m_menu_constancias_2013.istr_constancia = istr_constancias
end event

type st_numero from statictext within w_constancia_04_telmex_2013_resp
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

type st_decimal from statictext within w_constancia_04_telmex_2013_resp
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

type st_3 from statictext within w_constancia_04_telmex_2013_resp
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

type em_precision_prom from editmask within w_constancia_04_telmex_2013_resp
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

type cb_promedio from commandbutton within w_constancia_04_telmex_2013_resp
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

type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_04_telmex_2013_resp
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

type uo_1 from uo_per_ani within w_constancia_04_telmex_2013_resp
integer x = 2062
integer y = 100
integer taborder = 30
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type mle_dirigido_a from multilineedit within w_constancia_04_telmex_2013_resp
integer x = 78
integer y = 908
integer width = 2208
integer height = 288
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean enabled = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;this.text = "FUNDACION TELMEX~nVIZCAÍNAS NO. 16~nCOL. CENTRO~nMEXICO, D.F."

end event

type mle_texto_libre from multilineedit within w_constancia_04_telmex_2013_resp
integer x = 78
integer y = 1276
integer width = 2208
integer height = 288
integer taborder = 50
boolean bringtotop = true
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

