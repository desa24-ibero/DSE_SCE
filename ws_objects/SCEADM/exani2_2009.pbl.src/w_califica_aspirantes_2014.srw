$PBExportHeader$w_califica_aspirantes_2014.srw
$PBExportComments$Ventana que califica secciones, áreas y da los puntajes en base a las calificaciones dadas por el CENEVAL.
forward
global type w_califica_aspirantes_2014 from w_main
end type
type dw_resultado_examen_modulo_cons from u_dw within w_califica_aspirantes_2014
end type
type dw_modulo_examen from u_dw within w_califica_aspirantes_2014
end type
type dw_resultado_examen_modulo from u_dw within w_califica_aspirantes_2014
end type
type dw_aspiran_pago_examen from u_dw within w_califica_aspirantes_2014
end type
type em_max from editmask within w_califica_aspirantes_2014
end type
type em_min from editmask within w_califica_aspirantes_2014
end type
type st_1 from statictext within w_califica_aspirantes_2014
end type
type cb_califica from commandbutton within w_califica_aspirantes_2014
end type
type uo_1 from uo_ver_per_ani within w_califica_aspirantes_2014
end type
end forward

global type w_califica_aspirantes_2014 from w_main
integer x = 832
integer y = 360
integer width = 3566
integer height = 2040
string title = "Califica Aspirantes"
string menuname = "m_menu"
boolean controlmenu = false
event type long num_folios ( integer min_max )
event type integer obten_carr ( long fol )
event cal_are ( long fol,  integer area,  integer carr )
event type real pes_are ( long fol,  integer area,  integer carr )
event da_puntaje ( long fol,  real acumula )
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
global w_califica_aspirantes_2014 w_califica_aspirantes_2014

type variables

end variables

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

on w_califica_aspirantes_2014.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
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
this.Control[iCurrent+1]=this.dw_resultado_examen_modulo_cons
this.Control[iCurrent+2]=this.dw_modulo_examen
this.Control[iCurrent+3]=this.dw_resultado_examen_modulo
this.Control[iCurrent+4]=this.dw_aspiran_pago_examen
this.Control[iCurrent+5]=this.em_max
this.Control[iCurrent+6]=this.em_min
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.cb_califica
this.Control[iCurrent+9]=this.uo_1
end on

on w_califica_aspirantes_2014.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
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

event open;call super::open;dw_aspiran_pago_examen.SetTransObject(gtr_sadm)
dw_resultado_examen_modulo.SetTransObject(gtr_sadm)
dw_modulo_examen.SetTransObject(gtr_sadm)
dw_resultado_examen_modulo_cons.SetTransObject(gtr_sadm)
this.of_SetResize(TRUE)

this.inv_resize.of_Register &
 (dw_aspiran_pago_examen, this.inv_resize.SCALERIGHT)

this.inv_resize.of_Register &
 (dw_resultado_examen_modulo, this.inv_resize.SCALERIGHT)

this.inv_resize.of_Register &
 (dw_resultado_examen_modulo_cons, this.inv_resize.SCALERIGHTBOTTOM)


dw_resultado_examen_modulo_cons.of_SetSort(TRUE)
dw_resultado_examen_modulo_cons.inv_sort.of_SetColumnHeader(TRUE)


end event

type dw_resultado_examen_modulo_cons from u_dw within w_califica_aspirantes_2014
integer x = 50
integer y = 1348
integer width = 3438
integer height = 468
integer taborder = 70
string dataobject = "d_resultado_examen_modulo"
boolean hscrollbar = true
boolean resizable = true
end type

type dw_modulo_examen from u_dw within w_califica_aspirantes_2014
integer x = 59
integer y = 332
integer width = 2162
integer height = 196
integer taborder = 40
string dataobject = "d_modulo_examen_lista"
end type

type dw_resultado_examen_modulo from u_dw within w_califica_aspirantes_2014
integer x = 50
integer y = 992
integer width = 3438
integer height = 332
integer taborder = 60
string dataobject = "d_resultado_examen_modulo_folio"
boolean hscrollbar = true
boolean resizable = true
end type

type dw_aspiran_pago_examen from u_dw within w_califica_aspirantes_2014
integer x = 50
integer y = 568
integer width = 3438
integer height = 408
integer taborder = 50
string dataobject = "d_aspiran_pago_examen_2014"
boolean hscrollbar = true
boolean resizable = true
end type

type em_max from editmask within w_califica_aspirantes_2014
integer x = 2377
integer y = 172
integer width = 407
integer height = 100
integer taborder = 20
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

type em_min from editmask within w_califica_aspirantes_2014
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

type st_1 from statictext within w_califica_aspirantes_2014
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

type cb_califica from commandbutton within w_califica_aspirantes_2014
integer x = 2382
integer y = 348
integer width = 430
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Califica"
end type

event clicked;//Modificado el 21 de Enero de 2014
//Por la nueva ponderación del CENEVAL 2014 
//Desaparece la sección 5 de Tecnologías de información y Comunicación


long foli,fol,ll_folio_inicial, ll_folio_final, ll_rows, ll_row, ll_folio, ll_row_resultado, ll_insertrow
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
//Modificado	 21-Enero-2014
//	ld_area_ceneval_5 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_5")
	//Convierte el puntaje a la escala 0-100
	ld_area_1 = f_convierte_puntaje_ceneval(ld_area_ceneval_1)
	ld_area_2 = f_convierte_puntaje_ceneval(ld_area_ceneval_2)
	ld_area_3 = f_convierte_puntaje_ceneval(ld_area_ceneval_3)
	ld_area_4 = f_convierte_puntaje_ceneval(ld_area_ceneval_4)
//Modificado	 21-Enero-2014
//	ld_area_5 = f_convierte_puntaje_ceneval(ld_area_ceneval_5)
	ld_numerador = (ld_area_1*ld_peso_area_1 + ld_area_2*ld_peso_area_2 + &
	  ld_area_3*ld_peso_area_3 + ld_area_4*ld_peso_area_4 )
	  
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
//Modificado	 21-Enero-2014
//	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_5", ld_area_5)			
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

type uo_1 from uo_ver_per_ani within w_califica_aspirantes_2014
integer x = 27
integer y = 48
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

