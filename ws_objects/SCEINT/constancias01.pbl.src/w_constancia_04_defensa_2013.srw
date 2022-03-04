$PBExportHeader$w_constancia_04_defensa_2013.srw
forward
global type w_constancia_04_defensa_2013 from w_master_main
end type
type st_1 from statictext within w_constancia_04_defensa_2013
end type
type st_fecha from statictext within w_constancia_04_defensa_2013
end type
type em_fecha from editmask within w_constancia_04_defensa_2013
end type
type cb_redactar from commandbutton within w_constancia_04_defensa_2013
end type
type st_2 from statictext within w_constancia_04_defensa_2013
end type
type st_texto_fecha from statictext within w_constancia_04_defensa_2013
end type
type dw_constancia from uo_master_dw within w_constancia_04_defensa_2013
end type
type st_numero from statictext within w_constancia_04_defensa_2013
end type
type st_decimal from statictext within w_constancia_04_defensa_2013
end type
type st_3 from statictext within w_constancia_04_defensa_2013
end type
type em_precision_prom from editmask within w_constancia_04_defensa_2013
end type
type cb_promedio from commandbutton within w_constancia_04_defensa_2013
end type
type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_04_defensa_2013
end type
type mle_dirigido_a from multilineedit within w_constancia_04_defensa_2013
end type
type mle_texto_libre from multilineedit within w_constancia_04_defensa_2013
end type
type cbx_verano from checkbox within w_constancia_04_defensa_2013
end type
type uo_2 from uo_per_ani within w_constancia_04_defensa_2013
end type
type uo_1 from uo_per_ani within w_constancia_04_defensa_2013
end type
type em_anio_verano from editmask within w_constancia_04_defensa_2013
end type
type st_version1 from statictext within w_constancia_04_defensa_2013
end type
type st_version2 from statictext within w_constancia_04_defensa_2013
end type
type uo_pdf from uo_imprime_pdf within w_constancia_04_defensa_2013
end type
end forward

global type w_constancia_04_defensa_2013 from w_master_main
integer width = 3872
integer height = 3012
string title = "Semestre Anterior con Calificaciones"
string menuname = "m_menu_constancias_2013"
event ue_valida ( )
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
mle_dirigido_a mle_dirigido_a
mle_texto_libre mle_texto_libre
cbx_verano cbx_verano
uo_2 uo_2
uo_1 uo_1
em_anio_verano em_anio_verano
st_version1 st_version1
st_version2 st_version2
uo_pdf uo_pdf
end type
global w_constancia_04_defensa_2013 w_constancia_04_defensa_2013

type variables
str_impresion_constancias_2013 istr_constancias
long il_cuenta,il_carrera,il_plan
end variables

forward prototypes
public function string wf_obten_texto_final (long al_cuenta)
public function integer wf_cambia_verano ()
end prototypes

event ue_valida();uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)  






////string ls_periodo1
////int li_periodo1,li_anio1,li_periodo2,li_anio2
////
////ls_periodo1= uo_1.em_per.text
////choose case ls_periodo1
////	case 'Primavera'
////		li_periodo1 = 0
////	case 'Otoño'
////		li_periodo1 = 2
////end choose
////li_anio1= integer(uo_1.em_ani.text)
////
////choose case li_periodo1
////	case 0
////		li_periodo2 = 2
////		li_anio2 = li_anio1 -1
////		cbx_verano.visible = false
////		cbx_verano.checked = false
////	case 2
////		li_periodo2 = 0
////		li_anio2 = li_anio1 
////		cbx_verano.visible = true
////		cbx_verano.checked = false
////		cbx_verano.text = 'Verano ' + string(li_anio2)
////end choose
////
////uo_2.em_per.text = string(li_periodo2)
////uo_2.em_ani.text = string(li_anio2)
////
////
//
//// CODIGO SUBSTITUIDO 
//
//
//string ls_periodo1
//int li_periodo1,li_anio1,li_periodo2,li_anio2 
//STRING ls_periodo_2
//
//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios 
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce) 
//
//ls_periodo1= uo_1.em_per.text 
//
//li_periodo1 = luo_periodo_servicios.f_recupera_id_periodo_x_desc(gtr_sce, ls_periodo1)
//
//IF luo_periodo_servicios.ierror = -1 THEN 
//	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
//	RETURN
//END IF
//
////choose case ls_periodo1
////	case 'Primavera'
////		li_periodo1 = 0
////	case 'Otoño'
////		li_periodo1 = 2
////end choose
//
//li_anio1= integer(uo_1.em_ani.text)
//
//
//luo_periodo_servicios.f_recupera_periodo_siguiente(li_periodo1, li_anio1, gtr_sce)  
//luo_periodo_servicios.ls_periodo1
//
//li_periodo2 = li_periodo1 
//li_anio2 = li_anio1
//luo_periodo_servicios.f_recupera_periodo_anterior(li_periodo2, li_anio2, gtr_sce) 
//
//
//choose case li_periodo1
//	case 0
////		li_periodo2 = 2
////		li_anio2 = li_anio1 -1
//		cbx_verano.visible = false
//		cbx_verano.checked = false
//	case 2
////		li_periodo2 = 0
////		li_anio2 = li_anio1 
//		cbx_verano.visible = true
//		cbx_verano.checked = false
//		cbx_verano.text = 'Verano ' + string(li_anio2)
//	case 1
//		li_periodo2 = 0
//		li_anio2 = li_anio1 
//		cbx_verano.visible = true
//		cbx_verano.text = 'Verano ' + string(li_anio2)
////		uo_1.em_per.text =  '2'
////		uo_1.em_ani.text = string(li_anio1)
//end choose
//
//
////uo_2.em_per.text = string(li_periodo2)
//
//ls_periodo_2 = luo_periodo_servicios.f_recupera_descripcion( li_periodo2,'L')
//
//uo_1.em_per.text = ls_periodo_2 
//uo_1.em_ani.text = string(li_anio2) 
//
//uo_2.em_per.text = ls_periodo_2 
//uo_2.em_ani.text = string(li_anio2) 
//
//
//
//
//
//
end event

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
	
	
ls_periodo =f_obten_ordinal(f_obten_sem_cursados( al_cuenta ))

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


ls_texto_final="Asimismo se hace constar que actualmente está "+ls_inscrit+" en su "+ &
  lower(string(ls_periodo))+" período escolar " + lower(string(ls_periodo_texto))+ &
  " "+ string(li_anio_actual)+" (del "+lower(string(ls_dia_mes_inicial))+ &
  " al "+lower(string(ls_dia_mes_final))+")."

return ls_texto_final

end function

public function integer wf_cambia_verano ();

RETURN 0 



end function

event open;call super::open;string ls_fecha_servidor
datetime ldttm_fecha_servidor
string ls_periodo1
int li_periodo1,li_anio1,li_periodo2,li_anio2





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

select periodo,anio
	into :li_periodo1,:li_anio1
from periodos_por_procesos
where cve_proceso = 5 using gtr_sce;

em_anio_verano.TEXT = STRING(li_anio1)  

//uo_1.em_per.text = string(f_obten_nombre_periodo(li_periodo1)) 
//uo_1.em_ani.text = string(li_anio1)

choose case li_periodo1
	case 0
		li_periodo2 = 2
		li_anio2 = li_anio1 -1
	case 2
		li_periodo2 = 0
		li_anio2 = li_anio1 
//		cbx_verano.visible = true
//		cbx_verano.text = 'Verano ' + string(li_anio2)
	case 1
		li_periodo2 = 0
		li_anio2 = li_anio1 
//		cbx_verano.visible = true
//		cbx_verano.text = 'Verano ' + string(li_anio2)
//		uo_1.em_per.text =  '2'
//		uo_1.em_ani.text = string(li_anio1)
end choose

//uo_2.em_per.text = string(f_obten_nombre_periodo(li_periodo2)) 
//uo_2.em_ani.text = string(li_anio2)
//

end event

event close;
if gi_numscob <= 1 then
	if desconecta_bd_n_tr(gtr_scob) <> 1 then
		return
	end if
end if

gi_numscob = gi_numscob - 1
end event

on w_constancia_04_defensa_2013.create
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
this.mle_dirigido_a=create mle_dirigido_a
this.mle_texto_libre=create mle_texto_libre
this.cbx_verano=create cbx_verano
this.uo_2=create uo_2
this.uo_1=create uo_1
this.em_anio_verano=create em_anio_verano
this.st_version1=create st_version1
this.st_version2=create st_version2
this.uo_pdf=create uo_pdf
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
this.Control[iCurrent+14]=this.mle_dirigido_a
this.Control[iCurrent+15]=this.mle_texto_libre
this.Control[iCurrent+16]=this.cbx_verano
this.Control[iCurrent+17]=this.uo_2
this.Control[iCurrent+18]=this.uo_1
this.Control[iCurrent+19]=this.em_anio_verano
this.Control[iCurrent+20]=this.st_version1
this.Control[iCurrent+21]=this.st_version2
this.Control[iCurrent+22]=this.uo_pdf
end on

on w_constancia_04_defensa_2013.destroy
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
destroy(this.mle_dirigido_a)
destroy(this.mle_texto_libre)
destroy(this.cbx_verano)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.em_anio_verano)
destroy(this.st_version1)
destroy(this.st_version2)
destroy(this.uo_pdf)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan

if il_carrera = 0 then return

INTEGER li_periodo 
INTEGER li_anio 
STRING ls_inscrito, ls_texto_abierto

dw_constancia.RESET() 

if il_cuenta > 0 then
	select periodo,anio
	into :li_periodo,:li_anio
	from periodos_por_procesos
	where cve_proceso = 5 using gtr_sce;

	if string(f_obten_sexo_alumno( il_cuenta )) = 'M' then
		ls_inscrito = 'inscrito'
	else
		ls_inscrito = 'inscrita'
	end if
	
	//ls_texto_abierto = 'Actualmente está ' + ls_inscrito + ' en su ' + lower(f_obten_ordinal(f_obten_num_periodo( il_cuenta,  li_periodo ,  li_anio, il_carrera  ))) + ' semestre ' + f_obten_desc_larga_perido_anio_2(li_periodo ,  li_anio)
	
	ls_texto_abierto = 'Actualmente está ' + ls_inscrito + ' en su ' + lower(f_obten_ordinal(f_obten_sem_cursados_2013_carrera( il_cuenta,il_carrera,  il_plan  ))) + ' semestre ' + f_obten_desc_larga_perido_anio_2(li_periodo ,  li_anio)
	
	
	mle_texto_libre.text = ls_texto_abierto
else
	mle_texto_libre.text = ''
end if
end event

type st_sistema from w_master_main`st_sistema within w_constancia_04_defensa_2013
end type

type p_ibero from w_master_main`p_ibero within w_constancia_04_defensa_2013
end type

type st_1 from statictext within w_constancia_04_defensa_2013
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

type st_fecha from statictext within w_constancia_04_defensa_2013
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

type em_fecha from editmask within w_constancia_04_defensa_2013
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

type cb_redactar from commandbutton within w_constancia_04_defensa_2013
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
string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_report, setting, ls_data, ls_data2
datetime ldttm_fecha
integer li_precision, li_carrera, li_plan
integer li_periodo_actual, li_anio_actual, li_x, li_y, li_w, li_h, li_ret_child, li_yh, li_yrel,li_periodo_2, li_anio_2,li_periodo_v, li_anio_v
integer li_rows_child, li_lon_reg, li_lon_reg_tot, li_num_lineas,li_rows_child2,li_rows_child3,li_pos
decimal ld_promedio, ldc_creditos, ldc_creditos_totales
string ls_texto2,ls_periodo1,ls_periodo2
INTEGER le_periodoA, le_anioA, le_periodoB, le_anioB, le_periodoC, le_anioC



ls_fecha = em_fecha.text

ldttm_fecha = datetime(date(ls_fecha),time("00:00:00"))

ls_texto_fecha = f_obten_datetime_en_texto(ldttm_fecha)

st_texto_fecha.text = ls_texto_fecha

ls_dirigido_a = mle_dirigido_a.text

ls_texto_libre = mle_texto_libre.text

ls_texto2 =  f_obten_asc(ls_texto_libre, li_num_lineas)

ls_dirigido_a = f_quita_comillas(ls_dirigido_a)

ls_texto2 = f_quita_comillas(ls_texto2)

li_precision = integer(em_precision_prom.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 2
end if

f_obten_promedio_creditos(il_cuenta, il_carrera, il_plan, ld_promedio, ldc_creditos)

ldc_creditos_totales = f_obten_cred_total(il_carrera, il_plan)

// Recupera el periodo inicial 
ls_periodo1= uo_1.em_per.text
IF POS(ls_periodo1, '*') > 0 THEN 
	ls_periodo1 = string(Replace(ls_periodo1, POS(ls_periodo1, '*'), 1, ''))
END IF
select periodo into :li_periodo_actual from periodo where descripcion=:ls_periodo1 using gtr_sce;
li_anio_actual= integer(uo_1.em_ani.text)

if cbx_verano.checked = true then
	li_periodo_v = 1 
	li_anio_v = INTEGER(em_anio_verano.TEXT) 
	//li_anio_v = integer(uo_1.em_ani.text)
else
	li_periodo_v = 0
	li_anio_v = 0
end if


ls_periodo2= uo_2.em_per.text
IF POS(ls_periodo2, '*') > 0 THEN 
	ls_periodo2 = string(Replace(ls_periodo2, POS(ls_periodo2, '*'), 1, ''))
END IF
select periodo into :li_periodo_2 from periodo where descripcion=:ls_periodo2 using gtr_sce;
li_anio_2 = integer(uo_2.em_ani.text)

setting = dw_constancia.Object.DataWindow.Nested

datastore dwr_tabla

dwr_tabla = CREATE datastore
dwr_tabla.DataObject = 'd_mat_insc_calif_hist_desc_periodo'  
dwr_tabla.SetTransObject(gtr_sce)  
li_rows_child = dwr_tabla.Retrieve(il_cuenta,li_periodo_actual,li_anio_actual)
li_rows_child2 = dwr_tabla.Retrieve(il_cuenta,li_periodo_2,li_anio_2)
li_rows_child3 = dwr_tabla.Retrieve(il_cuenta,li_periodo_v,li_anio_v)
if li_rows_child = 0 then li_rows_child = 5
if li_rows_child2 = 0 then li_rows_child2 = 5
if li_rows_child3 = 0 then li_rows_child3 = 5
li_rows_child = li_rows_child + li_rows_child2 + li_rows_child3 + 10

st_numero.text = f_obten_ordinal(f_obten_num_periodo(il_cuenta,li_periodo_actual,li_anio_actual, il_carrera))


// Se verifica que exista un plan válido.
IF f_obten_num_periodo_max_carreras(il_cuenta, il_carrera) < 0 THEN 
	RETURN 0
END IF

// Se asigna el orden de presentación de los periodos.
DATASTORE lds_orden 
lds_orden = CREATE DATASTORE 
lds_orden.DATAOBJECT = "d_orden_periodo_defensa" 
lds_orden.INSERTROW(0)
lds_orden.INSERTROW(0)
lds_orden.INSERTROW(0)

lds_orden.SETITEM(1, "periodo",li_periodo_actual) 
lds_orden.SETITEM(1, "anio", li_anio_actual) 

lds_orden.SETITEM(2, "periodo",li_periodo_v) 
lds_orden.SETITEM(2, "anio", li_anio_v) 

lds_orden.SETITEM(3, "periodo",li_periodo_2) 
lds_orden.SETITEM(3, "anio", li_anio_2) 

lds_orden.SETSORT("anio asc, periodo asc") 
lds_orden.SORT() 

le_periodoA = lds_orden.GETITEMNUMBER(1, "periodo")
le_anioA = lds_orden.GETITEMNUMBER(1, "anio") 
le_periodoB = lds_orden.GETITEMNUMBER(2, "periodo")
le_anioB = lds_orden.GETITEMNUMBER(2, "anio") 
le_periodoC = lds_orden.GETITEMNUMBER(3, "periodo")
le_anioC = lds_orden.GETITEMNUMBER(3, "anio") 


ll_renglones = dw_constancia.Retrieve(il_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2,ld_promedio,&
					ldc_creditos, li_precision,ldc_creditos_totales,le_periodoC,le_anioC,li_rows_child, li_num_lineas,le_periodoA,le_anioA,le_periodoB,le_anioB,il_carrera)  


//ll_renglones = dw_constancia.Retrieve(il_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2,ld_promedio,&
//					ldc_creditos, li_precision,ldc_creditos_totales,li_periodo_actual,li_anio_actual,li_rows_child, li_num_lineas,li_periodo_2,li_anio_2,li_periodo_v,li_anio_v,il_carrera)

ll_renglon_actual =dw_constancia.GetRow()


if (ll_renglones>0) then
	uo_pdf.enabled=true
	
	//  Parametros: DW, nombre archivo, ruta archivo, escala por default. cph 29 sept 2021.
	uo_pdf.inicializa_dw(dw_constancia,"","","98") // inicializa el uo_pdf para generar PDF cph 29 sept 2021
end if




//long  ll_renglones, ll_renglon_actual
//string ls_cuenta, ls_dirigido_a, ls_texto_libre, ls_texto_fecha, ls_fecha, ls_report, setting, ls_data, ls_data2
//datetime ldttm_fecha
//integer li_precision, li_carrera, li_plan
//integer li_periodo_actual, li_anio_actual, li_x, li_y, li_w, li_h, li_ret_child, li_yh, li_yrel,li_periodo_2, li_anio_2,li_periodo_v, li_anio_v
//integer li_rows_child, li_lon_reg, li_lon_reg_tot, li_num_lineas,li_rows_child2,li_rows_child3,li_pos
//decimal ld_promedio, ldc_creditos, ldc_creditos_totales
//string ls_texto2,ls_periodo1,ls_periodo2
//
//ls_fecha = em_fecha.text
//
//ldttm_fecha = datetime(date(ls_fecha),time("00:00:00"))
//
//ls_texto_fecha = f_obten_datetime_en_texto(ldttm_fecha)
//
//st_texto_fecha.text = ls_texto_fecha
//
//ls_dirigido_a = mle_dirigido_a.text
//
//ls_texto_libre = mle_texto_libre.text
//
//ls_texto2 =  f_obten_asc(ls_texto_libre, li_num_lineas)
//
////li_num_lineas = f_obten_num_lineas(ls_texto_libre)
//
//ls_dirigido_a = f_quita_comillas(ls_dirigido_a)
//
////dw_constancia.object.st_dirigido_a.text = ls_dirigido_a
//
//ls_texto2 = f_quita_comillas(ls_texto2)
//
////dw_constancia.object.st_texto_libre.text = ls_texto2
//
//li_precision = integer(em_precision_prom.text)
//
//if li_precision > 4 or li_precision <0 then
//	li_precision = 2
//end if
//
////li_carrera = f_obten_cve_carrera(ll_cuenta)
////
////li_plan = f_obten_cve_plan(ll_cuenta)
//
//f_obten_promedio_creditos(il_cuenta, il_carrera, il_plan, ld_promedio, ldc_creditos)
//
//ldc_creditos_totales = f_obten_cred_total(il_carrera, il_plan)
//
//ls_periodo1= uo_1.em_per.text
//
//ls_periodo1 = string(Replace(ls_periodo1, POS(ls_periodo1, '*'), 1, ''))
//
//select periodo into :li_periodo_actual from periodo where descripcion=:ls_periodo1 using gtr_sce;
//
//
///*choose case ls_periodo1
//	case 'Primavera'
//		li_periodo_actual = 0
//	case 'Verano'
//		li_periodo_actual = 1
//	case 'Otoño'
//		li_periodo_actual = 2
//end choose*/
//li_anio_actual= integer(uo_1.em_ani.text)
//
////li_periodo_actual = uo_1.ie_periodo
////li_anio_actual = uo_1.ie_anio
////
//if cbx_verano.checked = true then
//	li_periodo_v = 1
//	li_anio_v = integer(uo_1.em_ani.text)
//else
//	li_periodo_v = 0
//	li_anio_v = 0
//end if
//
//ls_periodo2= uo_2.em_per.text
//select periodo into :li_periodo_2 from periodo where descripcion=:ls_periodo2 using gtr_sce;
//
///*choose case ls_periodo2
//	case 'Primavera'
//		li_periodo_2 = 0
//	case 'Verano'
//		li_periodo_2 = 1
//	case 'Otoño'
//		li_periodo_2 = 2
//end choose*/
//li_anio_2 = integer(uo_2.em_ani.text)
//
//setting = dw_constancia.Object.DataWindow.Nested
//
////li_periodo_2 = uo_2.ie_periodo
////li_anio_2 = uo_2.ie_periodo
//
//datastore dwr_tabla
//
//
//dwr_tabla = CREATE datastore
//dwr_tabla.DataObject = 'd_mat_insc_calif_hist_desc_periodo'  
//dwr_tabla.SetTransObject(gtr_sce)  
//li_rows_child = dwr_tabla.Retrieve(il_cuenta,li_periodo_actual,li_anio_actual)
//li_rows_child2 = dwr_tabla.Retrieve(il_cuenta,li_periodo_2,li_anio_2)
//li_rows_child3 = dwr_tabla.Retrieve(il_cuenta,li_periodo_v,li_anio_v)
//if li_rows_child = 0 then li_rows_child = 5
//if li_rows_child2 = 0 then li_rows_child2 = 5
//if li_rows_child3 = 0 then li_rows_child3 = 5
//li_rows_child = li_rows_child + li_rows_child2 + li_rows_child3 + 10
//
//st_numero.text = f_obten_ordinal(f_obten_num_periodo(il_cuenta,li_periodo_actual,li_anio_actual, il_carrera))
//
//
//// Se verifica que exista un plan válido.
//IF f_obten_num_periodo_max_carreras(il_cuenta, il_carrera) < 0 THEN 
//	RETURN 0
//END IF
//
//
//
//ll_renglones = dw_constancia.Retrieve(il_cuenta, ldttm_fecha, ls_dirigido_a, ls_texto2,ld_promedio,&
//					ldc_creditos, li_precision,ldc_creditos_totales,li_periodo_actual,li_anio_actual,li_rows_child, li_num_lineas,li_periodo_2,li_anio_2,li_periodo_v,li_anio_v,il_carrera)
//
//ll_renglon_actual =dw_constancia.GetRow()
//
//
//
end event

type st_2 from statictext within w_constancia_04_defensa_2013
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

type st_texto_fecha from statictext within w_constancia_04_defensa_2013
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

type dw_constancia from uo_master_dw within w_constancia_04_defensa_2013
integer x = 73
integer y = 1608
integer width = 3401
integer height = 1172
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_constancias_04_defensa"
boolean hscrollbar = false
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event constructor;call super::constructor;str_impresion_constancias_2013 lstr_constancias 

m_menu_constancias_2013.dw = this

this.SetTransObject(gtr_sce)

//Orientación Portrait
//this.Object.DataWindow.Print.Orientation	= 2

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

type st_numero from statictext within w_constancia_04_defensa_2013
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

type st_decimal from statictext within w_constancia_04_defensa_2013
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

type st_3 from statictext within w_constancia_04_defensa_2013
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

type em_precision_prom from editmask within w_constancia_04_defensa_2013
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

type cb_promedio from commandbutton within w_constancia_04_defensa_2013
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

type uo_nombre from uo_carreras_alumno_lista_const2 within w_constancia_04_defensa_2013
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

type mle_dirigido_a from multilineedit within w_constancia_04_defensa_2013
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
string text = "SECRETARIA DE LA DEFENSA NACIONAL:"
boolean vscrollbar = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type mle_texto_libre from multilineedit within w_constancia_04_defensa_2013
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

type cbx_verano from checkbox within w_constancia_04_defensa_2013
integer x = 2318
integer y = 32
integer width = 366
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 553648127
string text = "Verano"
end type

event clicked;
IF THIS.CHECKED THEN 
	em_anio_verano.VISIBLE = TRUE 	
ELSE
	em_anio_verano.VISIBLE = FALSE 	
END IF 




end event

type uo_2 from uo_per_ani within w_constancia_04_defensa_2013
integer x = 2313
integer y = 128
integer taborder = 20
boolean bringtotop = true
boolean enabled = true
end type

on uo_2.destroy
call uo_per_ani::destroy
end on

type uo_1 from uo_per_ani within w_constancia_04_defensa_2013
integer x = 1038
integer y = 128
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type em_anio_verano from editmask within w_constancia_04_defensa_2013
boolean visible = false
integer x = 2697
integer y = 28
integer width = 402
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
end type

type st_version1 from statictext within w_constancia_04_defensa_2013
integer x = 891
integer y = 92
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

type st_version2 from statictext within w_constancia_04_defensa_2013
boolean visible = false
integer x = 855
integer y = 192
integer width = 114
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

type uo_pdf from uo_imprime_pdf within w_constancia_04_defensa_2013
integer x = 2304
integer y = 1180
integer taborder = 110
boolean bringtotop = true
boolean enabled = false
end type

on uo_pdf.destroy
call uo_imprime_pdf::destroy
end on

