$PBExportHeader$w_edita_aspirantes_web.srw
$PBExportComments$Ventana que califica secciones, áreas y da los puntajes en base a las calificaciones dadas por el CENEVAL.
forward
global type w_edita_aspirantes_web from w_main
end type
type dw_fecha_examen from datawindow within w_edita_aspirantes_web
end type
type st_3 from statictext within w_edita_aspirantes_web
end type
type cb_consulta_folio from commandbutton within w_edita_aspirantes_web
end type
type em_folio_buscar from editmask within w_edita_aspirantes_web
end type
type cb_consulta_aspirantes from commandbutton within w_edita_aspirantes_web
end type
type cb_almacena_cambios from commandbutton within w_edita_aspirantes_web
end type
type dw_general_web from datawindow within w_edita_aspirantes_web
end type
type dw_aspiran_web from datawindow within w_edita_aspirantes_web
end type
type dw_resultado_examen_modulo_cons from u_dw within w_edita_aspirantes_web
end type
type dw_modulo_examen from u_dw within w_edita_aspirantes_web
end type
type dw_resultado_examen_modulo from u_dw within w_edita_aspirantes_web
end type
type dw_aspiran_pago_examen from u_dw within w_edita_aspirantes_web
end type
type em_max from editmask within w_edita_aspirantes_web
end type
type em_min from editmask within w_edita_aspirantes_web
end type
type st_1 from statictext within w_edita_aspirantes_web
end type
type cb_califica from commandbutton within w_edita_aspirantes_web
end type
type uo_1 from uo_ver_per_ani within w_edita_aspirantes_web
end type
end forward

global type w_edita_aspirantes_web from w_main
integer x = 832
integer y = 360
integer width = 6016
integer height = 2504
string title = "Edición Aspirantes Web"
string menuname = "m_menu_web"
boolean controlmenu = false
event type long num_folios ( integer min_max )
event type integer obten_carr ( long fol )
event cal_are ( long fol,  integer area,  integer carr )
event type real pes_are ( long fol,  integer area,  integer carr )
event da_puntaje ( long fol,  real acumula )
dw_fecha_examen dw_fecha_examen
st_3 st_3
cb_consulta_folio cb_consulta_folio
em_folio_buscar em_folio_buscar
cb_consulta_aspirantes cb_consulta_aspirantes
cb_almacena_cambios cb_almacena_cambios
dw_general_web dw_general_web
dw_aspiran_web dw_aspiran_web
dw_resultado_examen_modulo_cons dw_resultado_examen_modulo_cons
dw_modulo_examen dw_modulo_examen
dw_resultado_examen_modulo dw_resultado_examen_modulo
dw_aspiran_pago_examen dw_aspiran_pago_examen
em_max em_max
em_min em_min
st_1 st_1
cb_califica cb_califica
uo_1 uo_1
end type
global w_edita_aspirantes_web w_edita_aspirantes_web

type variables
transaction itr_admision_web
end variables

forward prototypes
public function integer f_recupera_fechas ()
end prototypes

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

event obten_carr;int carr

SELECT aspiran.clv_carr
INTO :carr
FROM aspiran  
WHERE ( aspiran.folio = :fol ) AND
	( aspiran.clv_ver = :gi_version ) AND  
	( aspiran.clv_per = :gi_periodo ) AND  
	( aspiran.anio = :gi_anio )   
USING gtr_sadm;
	
return carr

end event

event cal_are(long fol, integer area, integer carr);real valor

		SELECT sum(round(cali_sec.calif,2) * round(sec_peso.peso,2))
		INTO :valor  
		FROM cali_sec, sec_peso  
		WHERE ( cali_sec.folio = :fol ) AND  
			( cali_sec.clv_ver = :gi_version ) AND  
			( cali_sec.clv_per = :gi_periodo ) AND  
			( cali_sec.anio = :gi_anio ) AND  
			( cali_sec.clv_area = :area ) and  
			( sec_peso.clv_carr= :carr ) and
			( sec_peso.clv_area = :area ) and  
			( sec_peso.clv_sec = cali_sec.clv_sec )
		USING gtr_sadm;
					
		UPDATE cali_are
		SET calif = round(:valor,2)
		WHERE ( cali_are.folio = :fol ) AND  
			( cali_are.clv_ver = :gi_version ) AND  
			( cali_are.clv_per = :gi_periodo ) AND  
			( cali_are.anio = :gi_anio ) AND  
			( cali_are.clv_area = :area )   
		USING gtr_sadm;
end event

event pes_are;real valor

		SELECT round(cali_are.calif,2)*round(area_pes.peso,5)/100.00000
		INTO :valor
		FROM cali_are, area_pes  
		WHERE ( cali_are.clv_area = area_pes.clv_area ) and  
			( cali_are.folio = :fol ) AND  
			( cali_are.clv_ver = :gi_version ) AND  
			( cali_are.clv_per = :gi_periodo ) AND  
			( cali_are.anio = :gi_anio ) AND  
			( area_pes.clv_carr = :carr ) AND  
			( cali_are.clv_area = :area )
		USING gtr_sadm;		

return round(valor,2)
end event

event da_puntaje(long fol, real acumula);real valor

//		UPDATE aspiran
//		SET puntaje = round(:acumula+round(promedio,2) * 40.00000,2)
//		WHERE ( aspiran.folio = :fol ) AND  
//			( aspiran.clv_ver = :gi_version ) AND  
//			( aspiran.clv_per = :gi_periodo ) AND  
//			( aspiran.anio = :gi_anio )   
//		USING gtr_sadm;


		UPDATE aspiran
		SET puntaje = round(:acumula+round(aspiran.promedio,2) * promedio_peso.peso,2)
		FROM aspiran, promedio_peso
		WHERE ( aspiran.folio = :fol ) AND  
			( aspiran.clv_ver = :gi_version ) AND  
			( aspiran.clv_per = :gi_periodo ) AND  
			( aspiran.anio = :gi_anio )   AND
			( aspiran.clv_carr = promedio_peso.clv_carr)
		USING gtr_sadm;
		
		
		
end event

public function integer f_recupera_fechas ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

dw_fecha_examen.RESET()
dw_fecha_examen.INSERTROW(0)

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas
dw_fecha_examen.GETCHILD("id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 

RETURN 0 



end function

on w_edita_aspirantes_web.create
int iCurrent
call super::create
if this.MenuName = "m_menu_web" then this.MenuID = create m_menu_web
this.dw_fecha_examen=create dw_fecha_examen
this.st_3=create st_3
this.cb_consulta_folio=create cb_consulta_folio
this.em_folio_buscar=create em_folio_buscar
this.cb_consulta_aspirantes=create cb_consulta_aspirantes
this.cb_almacena_cambios=create cb_almacena_cambios
this.dw_general_web=create dw_general_web
this.dw_aspiran_web=create dw_aspiran_web
this.dw_resultado_examen_modulo_cons=create dw_resultado_examen_modulo_cons
this.dw_modulo_examen=create dw_modulo_examen
this.dw_resultado_examen_modulo=create dw_resultado_examen_modulo
this.dw_aspiran_pago_examen=create dw_aspiran_pago_examen
this.em_max=create em_max
this.em_min=create em_min
this.st_1=create st_1
this.cb_califica=create cb_califica
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_fecha_examen
this.Control[iCurrent+2]=this.st_3
this.Control[iCurrent+3]=this.cb_consulta_folio
this.Control[iCurrent+4]=this.em_folio_buscar
this.Control[iCurrent+5]=this.cb_consulta_aspirantes
this.Control[iCurrent+6]=this.cb_almacena_cambios
this.Control[iCurrent+7]=this.dw_general_web
this.Control[iCurrent+8]=this.dw_aspiran_web
this.Control[iCurrent+9]=this.dw_resultado_examen_modulo_cons
this.Control[iCurrent+10]=this.dw_modulo_examen
this.Control[iCurrent+11]=this.dw_resultado_examen_modulo
this.Control[iCurrent+12]=this.dw_aspiran_pago_examen
this.Control[iCurrent+13]=this.em_max
this.Control[iCurrent+14]=this.em_min
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.cb_califica
this.Control[iCurrent+17]=this.uo_1
end on

on w_edita_aspirantes_web.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fecha_examen)
destroy(this.st_3)
destroy(this.cb_consulta_folio)
destroy(this.em_folio_buscar)
destroy(this.cb_consulta_aspirantes)
destroy(this.cb_almacena_cambios)
destroy(this.dw_general_web)
destroy(this.dw_aspiran_web)
destroy(this.dw_resultado_examen_modulo_cons)
destroy(this.dw_modulo_examen)
destroy(this.dw_resultado_examen_modulo)
destroy(this.dw_aspiran_pago_examen)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.st_1)
destroy(this.cb_califica)
destroy(this.uo_1)
end on

event activate;x=1
y=1

end event

event open;call super::open;integer li_conexion

li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)


//transaction		atr_transaccion_parametros
//transaction		atr_transaccion_nueva_bd
//integer 			ai_cve_conexion
//string				as_usuario
//string				as_password

if li_conexion <>1 then
	MessageBox("Error de conexion a la bae del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

dw_aspiran_web.SetTransObject(itr_admision_web )
dw_general_web.SetTransObject(itr_admision_web)

dw_aspiran_web.SetRowFocusIndicator(Hand!)
dw_general_web.SetRowFocusIndicator(Hand!)


f_recupera_fechas() 




//
//
//
//
//dw_aspiran_pago_examen.SetTransObject(gtr_sadm)
//dw_resultado_examen_modulo.SetTransObject(gtr_sadm)
//dw_modulo_examen.SetTransObject(gtr_sadm)
//dw_resultado_examen_modulo_cons.SetTransObject(gtr_sadm)
//this.of_SetResize(TRUE)
//
//this.inv_resize.of_Register &
// (dw_aspiran_pago_examen, this.inv_resize.SCALERIGHT)
//
//this.inv_resize.of_Register &
// (dw_resultado_examen_modulo, this.inv_resize.SCALERIGHT)
//
//this.inv_resize.of_Register &
// (dw_resultado_examen_modulo_cons, this.inv_resize.SCALERIGHTBOTTOM)
//
//
//dw_resultado_examen_modulo_cons.of_SetSort(TRUE)
//dw_resultado_examen_modulo_cons.inv_sort.of_SetColumnHeader(TRUE)
//

end event

type dw_fecha_examen from datawindow within w_edita_aspirantes_web
integer x = 622
integer y = 240
integer width = 1202
integer height = 104
integer taborder = 50
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_edita_aspirantes_web
integer x = 55
integer y = 264
integer width = 539
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fecha Aplicación:"
boolean focusrectangle = false
end type

type cb_consulta_folio from commandbutton within w_edita_aspirantes_web
integer x = 3291
integer y = 96
integer width = 571
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta Folio"
end type

event clicked;string ls_folio
long ll_folio

ls_folio = em_folio_buscar.text

long ll_row
long ll_row2

// Get the row num. for the beginning of the search

// from the instance variable, il_found

ll_row = 1

// Search using predefined criteria

ll_row = dw_aspiran_web.Find( "folio = "+ls_folio,  ll_row, dw_aspiran_web.RowCount())
ll_row2 = dw_general_web.Find( "folio = "+ls_folio,  ll_row, dw_general_web.RowCount())

IF ll_row > 0 THEN
        // Row found, scroll to it and make it current
        dw_aspiran_web.ScrollToRow(ll_row)
ELSE
        // No row was found
        MessageBox("No Encontrado", "Folio aspiran no encontrado.")
END IF

IF ll_row2 > 0 THEN
        // Row found, scroll to it and make it current
        dw_general_web.ScrollToRow(ll_row2)
ELSE 
        // No row was found
        MessageBox("No Encontrado", "Folio generalno encontrado.")
END IF




end event

type em_folio_buscar from editmask within w_edita_aspirantes_web
integer x = 2958
integer y = 104
integer width = 288
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "0"
alignment alignment = right!
string mask = "######"
end type

type cb_consulta_aspirantes from commandbutton within w_edita_aspirantes_web
integer x = 905
integer y = 388
integer width = 590
integer height = 108
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta Aspirantes"
end type

event clicked;long foli,fol,ll_folio_inicial, ll_folio_final, ll_rows, ll_row, ll_folio, ll_row_resultado, ll_insertrow
int carr,area, li_cve_tipo_examen = 1, li_cve_modulo_examen = 1, li_update
real valor, acumula
dec ld_area_ceneval_1, ld_area_ceneval_2, ld_area_ceneval_3, ld_area_ceneval_4, ld_area_ceneval_5
dec ld_area_1, ld_area_2, ld_area_3, ld_area_4, ld_area_5, ld_calificacion_global, ld_numerador
dec ld_peso_area_1, ld_peso_area_2, ld_peso_area_3, ld_peso_area_4, ld_peso_area_5, ld_peso_total
integer li_cve_area_examen_1, li_cve_area_examen_2, li_cve_area_examen_3, li_cve_area_examen_4, li_cve_area_examen_5
integer li_obten_parametros_area_examen, li_confirma_periodo
LONG ll_id_fecha 

SetPointer(HourGlass!)

li_confirma_periodo = MESSAGEbOX ('Confirmación','Desea Consultar la información?',Question!)


ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
	RETURN -1
END IF


if li_confirma_periodo= -1 or isnull(li_confirma_periodo) then
	MessageBox("Error al confirmar", "Es necesario Confirmar", StopSign!)
	return
elseif li_confirma_periodo<> 1 then
	MessageBox("Cancelación del proceso", "No almacenarán los cambios", StopSign!)
	return
END IF


long  ll_rows_aspiran, ll_rows_general

ll_folio =999999

ll_rows_aspiran = dw_aspiran_web.Retrieve(gi_version,gi_periodo, gi_anio, ll_id_fecha )
ll_rows_general= dw_general_web.Retrieve(ll_folio, gi_version,gi_periodo, gi_anio, ll_id_fecha )

if ll_rows_aspiran<= 0 then
	MessageBox("Error","No se ha podido consultar la información", StopSign!)
	return	
end if

if ll_rows_general<= 0 then
	MessageBox("Error","No se ha podido consultar la información", StopSign!)
	return	
end if


end event

type cb_almacena_cambios from commandbutton within w_edita_aspirantes_web
integer x = 2921
integer y = 388
integer width = 571
integer height = 108
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Almacena Cambios"
end type

event clicked;long foli,fol,ll_folio_inicial, ll_folio_final, ll_rows, ll_row, ll_folio, ll_row_resultado, ll_insertrow
int carr,area, li_cve_tipo_examen = 1, li_cve_modulo_examen = 1, li_update
real valor, acumula
dec ld_area_ceneval_1, ld_area_ceneval_2, ld_area_ceneval_3, ld_area_ceneval_4, ld_area_ceneval_5
dec ld_area_1, ld_area_2, ld_area_3, ld_area_4, ld_area_5, ld_calificacion_global, ld_numerador
dec ld_peso_area_1, ld_peso_area_2, ld_peso_area_3, ld_peso_area_4, ld_peso_area_5, ld_peso_total
integer li_cve_area_examen_1, li_cve_area_examen_2, li_cve_area_examen_3, li_cve_area_examen_4, li_cve_area_examen_5
integer li_obten_parametros_area_examen, li_confirma_periodo

SetPointer(HourGlass!)

li_confirma_periodo = MESSAGEbOX ('Confirmación','Desea Almacenar la información?',Question!)

if li_confirma_periodo= -1 or isnull(li_confirma_periodo) then
	MessageBox("Error al confirmar", "Es necesario Confirmar", StopSign!)
	return
elseif li_confirma_periodo<> 1 then
	MessageBox("Cancelación del proceso", "No almacenarán los cambios", StopSign!)
	return
END IF


if dw_aspiran_web.Update()=1 and dw_general_web.Update()=1 then
	MessageBox("Exito","Se han almacenado los datos", Information!)
	return
elseif li_confirma_periodo<> 1 then
	MessageBox("Error","No se ha almacenado la información", StopSign!)
	return	
end if
end event

type dw_general_web from datawindow within w_edita_aspirantes_web
integer x = 2354
integer y = 516
integer width = 3456
integer height = 1756
integer taborder = 110
string title = "none"
string dataobject = "d_general_web_prepa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event itemfocuschanged;long ll_folio_actual


if this.Rowcount()<=0 or dw_aspiran_web.RowCount()<=0 then
	return	
end if

ll_folio_actual = this.GetitemNumber(row,"folio")

this.ScrollToRow(row)

string ls_folio


ls_folio = string (ll_folio_actual)


long ll_row2, ll_row

// Get the row num. for the beginning of the search

// from the instance variable, il_found

ll_row = 1

// Search using predefined criteria

ll_row2 = dw_aspiran_web.Find( "folio = "+ls_folio,  ll_row, dw_aspiran_web.RowCount())

IF ll_row2 > 0 THEN
        // Row found, scroll to it and make it current
        dw_aspiran_web.ScrollToRow(ll_row2)
ELSE 
        // No row was found
        MessageBox("No Encontrado", "Folio aspiran no encontrado.")
END IF




end event

event doubleclicked;if dwo.name = "bachillera" then
	openwithparm(w_busqueda_2013,"escuela")
	object.bachillera[row]=ok
end if



end event

type dw_aspiran_web from datawindow within w_edita_aspirantes_web
integer x = 27
integer y = 512
integer width = 2318
integer height = 1768
integer taborder = 80
string title = "none"
string dataobject = "d_aspiran_web"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
end type

event itemfocuschanged;long ll_folio_actual


if this.Rowcount()<=0 or dw_general_web.RowCount()<=0 then
	return	
end if

ll_folio_actual = this.GetitemNumber(row,"folio")

this.ScrollToRow(row)

string ls_folio


ls_folio = string (ll_folio_actual)


long ll_row2, ll_row

// Get the row num. for the beginning of the search

// from the instance variable, il_found

ll_row = 1

// Search using predefined criteria

ll_row2 = dw_general_web.Find( "folio = "+ls_folio,  ll_row, dw_general_web.RowCount())

IF ll_row2 > 0 THEN
        // Row found, scroll to it and make it current
        dw_general_web.ScrollToRow(ll_row2)
ELSE 
        // No row was found
        MessageBox("No Encontrado", "Folio general no encontrado.")
END IF




end event

type dw_resultado_examen_modulo_cons from u_dw within w_edita_aspirantes_web
boolean visible = false
integer x = 50
integer y = 1868
integer width = 3438
integer height = 468
integer taborder = 130
string dataobject = "d_resultado_examen_modulo"
boolean hscrollbar = true
boolean resizable = true
end type

type dw_modulo_examen from u_dw within w_edita_aspirantes_web
boolean visible = false
integer x = 59
integer y = 852
integer width = 2162
integer height = 196
integer taborder = 90
string dataobject = "d_modulo_examen_lista"
end type

type dw_resultado_examen_modulo from u_dw within w_edita_aspirantes_web
boolean visible = false
integer x = 50
integer y = 1512
integer width = 3438
integer height = 332
integer taborder = 120
string dataobject = "d_resultado_examen_modulo_folio"
boolean hscrollbar = true
boolean resizable = true
end type

type dw_aspiran_pago_examen from u_dw within w_edita_aspirantes_web
boolean visible = false
integer x = 50
integer y = 1088
integer width = 3438
integer height = 408
integer taborder = 100
string dataobject = "d_aspiran_pago_examen"
boolean hscrollbar = true
boolean resizable = true
end type

type em_max from editmask within w_edita_aspirantes_web
boolean visible = false
integer x = 2377
integer y = 172
integer width = 407
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ","
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_edita_aspirantes_web
boolean visible = false
integer x = 2377
integer y = 44
integer width = 407
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type st_1 from statictext within w_edita_aspirantes_web
boolean visible = false
integer x = 937
integer y = 228
integer width = 1189
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_califica from commandbutton within w_edita_aspirantes_web
boolean visible = false
integer x = 2382
integer y = 348
integer width = 430
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Califica"
end type

event clicked;long foli,fol,ll_folio_inicial, ll_folio_final, ll_rows, ll_row, ll_folio, ll_row_resultado, ll_insertrow
int carr,area, li_cve_tipo_examen = 1, li_cve_modulo_examen = 1, li_update
real valor, acumula
dec ld_area_ceneval_1, ld_area_ceneval_2, ld_area_ceneval_3, ld_area_ceneval_4, ld_area_ceneval_5
dec ld_area_1, ld_area_2, ld_area_3, ld_area_4, ld_area_5, ld_calificacion_global, ld_numerador
dec ld_peso_area_1, ld_peso_area_2, ld_peso_area_3, ld_peso_area_4, ld_peso_area_5, ld_peso_total
integer li_cve_area_examen_1, li_cve_area_examen_2, li_cve_area_examen_3, li_cve_area_examen_4, li_cve_area_examen_5
integer li_obten_parametros_area_examen, li_confirma_periodo

SetPointer(HourGlass!)

li_confirma_periodo = f_confirma_periodo()
if li_confirma_periodo= -1 or isnull(li_confirma_periodo) then
	MessageBox("Error al elegir el periodo", "No es una versión de examen válida", StopSign!)
	return
elseif li_confirma_periodo<> 1 then
	MessageBox("Cancelación del proceso", "No se ejecutará el proceso cálculo de calificaciones", StopSign!)
	return
END IF

SetPointer(HourGlass!)

ll_folio_inicial = long(em_min.text)
ll_folio_final   = long(em_max.text)

ll_rows = dw_aspiran_pago_examen.Retrieve(gi_version,gi_periodo, gi_anio,ll_folio_inicial, ll_folio_final)
	
//Solo examen de seleccion (sin diagnóstico)
li_cve_tipo_examen = 1
li_cve_modulo_examen = 1

li_obten_parametros_area_examen = f_obten_parametros_area_examen(li_cve_tipo_examen, li_cve_modulo_examen,& 
ld_peso_area_1, ld_peso_area_2, ld_peso_area_3, ld_peso_area_4, ld_peso_area_5,&
li_cve_area_examen_1, li_cve_area_examen_2, li_cve_area_examen_3, li_cve_area_examen_4, li_cve_area_examen_5)

 	
IF li_obten_parametros_area_examen = -1 THEN
	MessageBox("Error al consultar parametros_area_examen", "No es posible determinar la ponderación del examen", StopSign!)
	return
END IF

for ll_row=1 to ll_rows
	dw_aspiran_pago_examen.ScrollToRow(ll_row)
	ll_folio = dw_aspiran_pago_examen.GetItemNumber(ll_row,"folio")
	st_1.text = "Folio ["+string(ll_folio)+"] "+string(ll_row)+" de "+string(ll_rows)
	
	dw_resultado_examen_modulo.Reset()
	ll_row_resultado = dw_resultado_examen_modulo.Retrieve(ll_folio,gi_version,gi_periodo, gi_anio, li_cve_tipo_examen, li_cve_modulo_examen)
	
   //Si no existe el renglón es porque es nuevo y hay que insertarlo
	if ll_row_resultado = 0 then
		ll_insertrow = dw_resultado_examen_modulo.InsertRow(0)
		if ll_insertrow = -1 or isnull(ll_insertrow) then
			MessageBox("Error de inserción", "Error de inserción de resultado del módulo",StopSign!)
			return
		else
			ll_row_resultado = ll_insertrow
			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "folio", ll_folio)
			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "clv_ver", gi_version)
			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "clv_per", gi_periodo)
			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "anio", gi_anio)
			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "cve_tipo_examen", li_cve_tipo_examen)
			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "cve_modulo_examen", li_cve_modulo_examen)			
		end if		
	end if
	//Obtiene el puntaje obtenido
	ld_area_ceneval_1 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_1")
	ld_area_ceneval_2 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_2")
	ld_area_ceneval_3 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_3")
	ld_area_ceneval_4 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_4")
	ld_area_ceneval_5 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_5")
	//Convierte el puntaje a la escala 0-100
	ld_area_1 = f_convierte_puntaje_ceneval(ld_area_ceneval_1)
	ld_area_2 = f_convierte_puntaje_ceneval(ld_area_ceneval_2)
	ld_area_3 = f_convierte_puntaje_ceneval(ld_area_ceneval_3)
	ld_area_4 = f_convierte_puntaje_ceneval(ld_area_ceneval_4)
	ld_area_5 = f_convierte_puntaje_ceneval(ld_area_ceneval_5)

	ld_numerador = (ld_area_1*ld_peso_area_1 + ld_area_2*ld_peso_area_2 + &
	  ld_area_3*ld_peso_area_3 + ld_area_4*ld_peso_area_4 + ld_area_5*ld_peso_area_5)
	  
	if ld_numerador >0.01 then
		ld_calificacion_global = ld_numerador /100
	elseif  isnull(ld_numerador) then 
		ld_calificacion_global = 0
	else
		ld_calificacion_global = 0
	end if
	//Asigna el puntaje obtenido
	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_1", ld_area_1)			
	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_2", ld_area_2)			
	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_3", ld_area_3)			
	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_4", ld_area_4)			
	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_5", ld_area_5)			
	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "calificacion_global_examen", ld_calificacion_global)			
	li_update = dw_resultado_examen_modulo.Update()
	if li_update = 1 then
		commit using gtr_sadm;
	else 
		rollback using gtr_sadm;
		MessageBox("Error de actualización", "Error de actualización de resultado del módulo",StopSign!)
		return		
	end if
	f_asigna_puntaje_aspiran(ll_folio,gi_version,gi_periodo, gi_anio)

next
dw_resultado_examen_modulo.Reset()

dw_resultado_examen_modulo_cons.Retrieve(gi_version,gi_periodo, gi_anio, ll_folio_inicial, ll_folio_final,li_cve_tipo_examen, li_cve_modulo_examen)


//min=long(em_min.text)
//max=long(em_max.text)
//FOR fol=min TO max
//
//  SELECT aspiran.folio  
//  INTO :foli
//  FROM aspiran  
//  WHERE ( aspiran.clv_ver = :gi_version ) AND  
//         ( aspiran.clv_per = :gi_periodo ) AND  
//         ( aspiran.anio = :gi_anio ) AND  
//         ( aspiran.pago_exam = 1 ) AND  
//         ( aspiran.folio = :fol )    
//	USING gtr_sadm;
//
//	if fol=foli then
//		
//		carr=event obten_carr(fol)
//		FOR area=1 TO 4
//			st_1.text='Calificando el área '+string(area)+' del Folio '+string(fol)+' de '+string(max)
//			event cal_are(fol,area,carr)
//		NEXT
//		commit using gtr_sce;
//	
//		acumula=0
//		FOR area=1 TO 4
//			st_1.text='Dando puntaje al área '+string(area)+' del Folio '+string(fol)+' de '+string(max)
//			acumula=acumula+event pes_are(fol,area,carr)
//		NEXT
//		st_1.text='Dando puntaje al Folio '+string(fol)+' de '+string(max)
//		event da_puntaje(fol,acumula)	
//		commit using gtr_sce;
//	else
//		st_1.text='No existe o no pago el folio '+string(fol)
//	end if
//NEXT
//st_1.text='Ya acabe'
end event

type uo_1 from uo_ver_per_ani within w_edita_aspirantes_web
integer x = 27
integer y = 48
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()

RETURN 

end event

