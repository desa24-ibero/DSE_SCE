$PBExportHeader$w_sit_rep_bloqueados_x_adeudo.srw
$PBExportComments$Esta ventana contiene los objetos relacionados con el calculo real de inscripción.
forward
global type w_sit_rep_bloqueados_x_adeudo from w_sit_ancestral
end type
type cb_genera_reporte from commandbutton within w_sit_rep_bloqueados_x_adeudo
end type
type uo_anio_periodo from uo_sit_periodo_anio within w_sit_rep_bloqueados_x_adeudo
end type
type dw_reporte from datawindow within w_sit_rep_bloqueados_x_adeudo
end type
type uo_progress_bar from uo_sit_progress_bar within w_sit_rep_bloqueados_x_adeudo
end type
end forward

global type w_sit_rep_bloqueados_x_adeudo from w_sit_ancestral
integer height = 2250
string title = "Reporte Alumnos Inscritos con Adeudos"
string menuname = "m_sit_ancestro_reporte"
boolean righttoleft = false
event ue_cierra ( )
cb_genera_reporte cb_genera_reporte
uo_anio_periodo uo_anio_periodo
dw_reporte dw_reporte
uo_progress_bar uo_progress_bar
end type
global w_sit_rep_bloqueados_x_adeudo w_sit_rep_bloqueados_x_adeudo

type variables
m_sit_ancestro_reporte menu_propietario

// determina si el progress bar a tocado el texto del porcentaje
boolean ib_invert
dec {2} ic_pct_complete
end variables

event ue_cierra;//
//  cierra bases de datos utilizadas  
// 
//if isvalid( gtr_sce)  then f_sit_desconecta_bd(gtr_sce) 
if isvalid( gtr_sfeb) then f_sit_desconecta_bd(gtr_sfeb)
if isvalid( gtr_sadm) then f_sit_desconecta_bd(gtr_sadm)
end event

on w_sit_rep_bloqueados_x_adeudo.create
int iCurrent
call super::create
if this.MenuName = "m_sit_ancestro_reporte" then this.MenuID = create m_sit_ancestro_reporte
this.cb_genera_reporte=create cb_genera_reporte
this.uo_anio_periodo=create uo_anio_periodo
this.dw_reporte=create dw_reporte
this.uo_progress_bar=create uo_progress_bar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_genera_reporte
this.Control[iCurrent+2]=this.uo_anio_periodo
this.Control[iCurrent+3]=this.dw_reporte
this.Control[iCurrent+4]=this.uo_progress_bar
end on

on w_sit_rep_bloqueados_x_adeudo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_genera_reporte)
destroy(this.uo_anio_periodo)
destroy(this.dw_reporte)
destroy(this.uo_progress_bar)
end on

event open;// Crea reporte de Alumnos bloqueados por Adeudo
// 
//
// Author: Raúl Hdez V. Julio/2002
// Modificación :
//

//			Valida conexión a la base de datos de Sistema Integral de Tesorería
if not isvalid( gtr_sit) then 
	if f_sit_conecta_bd(gtr_sit,"SIT",gs_usuario,gs_password) =0 then 
		messagebox("Aviso", "Problemas al conectarse a la bd de SIT") 
		close (this ) 
		return
	end if 
end if 

dw_reporte.settransobject( gtr_sit ) 

////			Valida conexión a la base de datos de Servicios Escolares
//if not isvalid( gtr_sce) then 
//	if f_sit_conecta_bd(gtr_sce,"SCE",gs_usuario,gs_password) =0 then 
//		messagebox("Aviso", "Problemas al conectarse a la bd de Control Escolar") 
//		close (this ) 
//		return
//	end if 
//end if 
//
//			Valida conexión a la base de datos de becas y financiamiento
//
if not isvalid( gtr_sfeb) then 
	if f_sit_conecta_bd(gtr_sfeb,"SFEB",gs_usuario,gs_password) = 0 then 
		messagebox("Aviso", "Problemas al conectarse a la bd de Beca y Financiamiento") 
		close (this) 
		return
	end if 
end if 

end event

event close;post event  ue_cierra()

end event

type st_1 from w_sit_ancestral`st_1 within w_sit_rep_bloqueados_x_adeudo
end type

type p_1 from w_sit_ancestral`p_1 within w_sit_rep_bloqueados_x_adeudo
end type

type cb_genera_reporte from commandbutton within w_sit_rep_bloqueados_x_adeudo
integer x = 358
integer y = 234
integer width = 516
integer height = 157
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Reporte"
end type

event clicked;// Lleva acabo el proceso de la generación del reporte de alumnos Bloqueados por adeudos
// vencidos y que no han pagado la inscripción  del próximo semestre, se eliminan de este
// reporte los alumnos que tienen beca o financiamiento educativo al 100%.
//
// Author: Raúl Hdez. V.
// julio/2002
//
// Fecha Modificación :
//

long		ll_tot_ctas_inscritas, ll_leidos, ll_adeudos, ll_cta_min, ll_cta_max
long     ll_cuenta, ll_recupera, ll_ren, ll_porcen_beca, ll_hasta
string   ls_mensaje_err, ls_nivel 
datetime ldt_Fvento_ins_lic, ldt_Fvento_ins_pos
double	ld_tasa_vento, ld_costo_lic, ld_costo_pos
boolean	lb_con_pago, lb_con_adeu, lb_con_33, lb_se_imprime  

//	 inicializa la barra de proceso 
ic_pct_complete = 0.0
uo_progress_bar.uf_set_position (0)

if messagebox("Aviso","Desea gerenar el reporte para  "+ &
	              " ~n el año " + string(ii_anio) + " y el período " + &
					  	uo_anio_periodo.em_periodo.text,question!,yesno!,2) <> 1 then
	uo_anio_periodo.em_periodo.setfocus()
	return
end if

dw_reporte.reset()
dw_reporte.setredraw( False)

// proceso general de cuentas
uo_sit_datastore lds_bandera_inscritos
lds_bandera_inscritos = CREATE uo_sit_datastore
lds_bandera_inscritos.DataObject = "d_sit_bandera_inscri"
lds_bandera_inscritos.settransobject(gtr_sce)

uo_sit_datastore lds_pago_reg
lds_pago_reg = CREATE uo_sit_datastore
lds_pago_reg.DataObject = "d_sit_val_pago_regist"
lds_pago_reg.SetTransObject(gtr_sit)
lds_pago_reg.retrieve(ii_anio,ii_periodo)

uo_sit_datastore lds_concepto_33
lds_concepto_33 = CREATE uo_sit_datastore
lds_concepto_33.DataObject = "d_sit_sdo_concepto33_vista"
lds_concepto_33.SetTransObject(gtr_sit)
lds_concepto_33.retrieve(ii_anio,ii_periodo,33)

uo_sit_datastore lds_becas_al100
lds_becas_al100 = CREATE uo_sit_datastore
lds_becas_al100.DataObject = "d_sit_beca_apoyo_al_100"
lds_becas_al100.SetTransObject(gtr_sfeb)
lds_becas_al100.Retrieve(ii_anio,ii_periodo)

uo_sit_datastore lds_minmax_cta
lds_minmax_cta = CREATE uo_sit_datastore
lds_minmax_cta.DataObject = "d_sit_maxmin_ctas_banderas"
lds_minmax_cta.SetTransObject(gtr_sce)
ll_recupera = lds_minmax_cta.retrieve()

choose case ll_recupera
	case is <=0
		Messagebox("Error","Al obtener ctas minima y maxima de banderas_inscrito "+ls_mensaje_err)
		Return
	case is >0
		ll_cta_min = lds_minmax_cta.object.cta_min[ll_recupera]
		ll_cta_max = lds_minmax_cta.object.cta_max[ll_recupera]
end choose
		
uo_sit_datastore lds_adeudos
lds_adeudos = CREATE uo_sit_datastore
lds_adeudos.DataObject = "d_sit_sdo_concep_deu_vista"
lds_adeudos.SetTransObject(gtr_sit)
lds_adeudos.retrieve(ll_cta_min,ll_cta_max)

uo_sit_datastore lds_max_costo_insc
lds_max_costo_insc = CREATE uo_sit_datastore
lds_max_costo_insc.DataObject = "d_sit_max_costo_inscrip"
lds_max_costo_insc.SetTransObject(gtr_sit)

//
//	Extrae la fecha vencimiento costo de inscripción reingreso Lic. 
//	
ll_recupera = f_sit_fechas_vencimiento(0,4,ii_periodo, ii_anio,1, 0, ldt_Fvento_ins_lic, &
											  ld_tasa_vento, ls_mensaje_err)
if ll_recupera <= 0 then
	Messagebox("Error","Al obtener fecha de vencimiento reingreso Lic. "+ls_mensaje_err)
else
	//
	//	Extrae la fecha vencimiento costo de inscripción reingreso Pos.
	//	
	ll_recupera = f_sit_fechas_vencimiento(ll_cuenta,6,ii_periodo, ii_anio,1, 0, ldt_Fvento_ins_pos, &
												  ld_tasa_vento, ls_mensaje_err)
	if ll_recupera <= 0 then
		Messagebox("Error","Al obtener fecha de vencimiento reingreso Pos. "+ls_mensaje_err)
	else
		// Estrae maximo costo de inscripción para reingreso Lic.
		ll_recupera = lds_max_costo_insc.retrieve(2,"L",ii_anio, ii_periodo)
		choose case ll_recupera
			case is <=0
				Messagebox("Error","Al obtener maximo costo inscripción reingreso Lic. "+lds_max_costo_insc.ds_sqlerrtext)
			case is >0
				ld_costo_lic = lds_max_costo_insc.Object.max_costo_inscrip[ll_recupera]
				// Estrae maximo costo de inscripción para reingreso Pos.
				ll_recupera = lds_max_costo_insc.retrieve(2,"P",ii_anio, ii_periodo)
				choose case ll_recupera
					case is <=0
						Messagebox("Error","Al obtener maximo costo inscripción reingreso Pos. "+lds_max_costo_insc.ds_sqlerrtext)
					case is >0
						ld_costo_pos = lds_max_costo_insc.Object.max_costo_inscrip[ll_recupera]
				end choose
		end choose
	end if
end if

If ll_recupera > 0 then
	
	ll_recupera = 0
	
	ll_tot_ctas_inscritas =  lds_bandera_inscritos.retrieve()	   //  todas las ctas 
	
	choose case ll_tot_ctas_inscritas 
	 case is < 0  
			Messagebox("Error","Tabla alumnos inscritos"+lds_bandera_inscritos.ds_sqlerrtext)
	 case 0 
			Messagebox("Error","No existe información en alumnos inscritos")
	 case else
		//		
		for ll_leidos  = 1 to  ll_tot_ctas_inscritas
	
			ll_cuenta = lds_bandera_inscritos.GetItemNumber(ll_leidos,"cuenta")
			ls_nivel  = lds_bandera_inscritos.GetItemString(ll_leidos,"academicos_nivel")
			
			lb_con_pago 	= FALSE
			lb_se_imprime 	= FALSE
			
			/* Busca si la cuenta tiene su pago registrado de inscripción para este periodo */
			
			ll_recupera = lds_pago_reg.find( "cuenta = "+ string(ll_cuenta), &
																	1, lds_pago_reg.rowcount() )
			choose case ll_recupera
				case is <0
					Messagebox("Error","al buscar si tiene pago registrado, para la cuenta : "+lds_pago_reg.ds_sqlerrtext)
					ll_leidos  = ll_tot_ctas_inscritas + 1
				case  0
					// valida si la cuenta tiene beca o financiamiento al 100%
					//
					ll_recupera = lds_becas_al100.Find( " becas_fin_cuenta = "+ string(ll_cuenta), &
																	1,lds_becas_al100.rowcount())
					choose case ll_recupera
						case is <0
							Messagebox("Error","al buscar si tiene beca al 100%, para la cuenta : "+lds_pago_reg.ds_sqlerrtext)
							ll_leidos  = ll_tot_ctas_inscritas + 1
						case  0	
							lb_se_imprime 	= TRUE
						case is >0
							// Ya tiene pago
							lb_con_pago 	= true
					end choose
				case is >0
					// Ya tiene pago
					lb_con_pago = true
			end choose	
			//				
			// Busca si la cuenta tiene el concepto 33 con importe positivo
			lb_con_33 = FALSE
			
			ll_recupera = lds_concepto_33.find( "cuenta = "+ string(ll_cuenta), &
																	1, lds_concepto_33.rowcount() )
			choose case ll_recupera
				case is <0
					Messagebox("Error","al buscar si tiene beca, para la cuenta"+ ls_mensaje_err)
					ll_leidos  = ll_tot_ctas_inscritas + 1
				case 0
				case is >0
					lb_con_33 	  = TRUE
					lb_se_imprime = TRUE
			end choose
			//
			// Busca si la cuenta tiene Adeudos
			lb_con_adeu = FALSE
			ll_adeudos = lds_adeudos.Find( "v_cuenta = " + string(ll_cuenta), &
																	1,lds_adeudos.rowcount() )
			choose case ll_adeudos
				case is <0
					Messagebox("Error","al buscar si tiene adeudos, para la cuenta"+ ls_mensaje_err)
							ll_leidos  = ll_tot_ctas_inscritas + 1
				case 0
					
				case is >0
					lb_con_adeu   = TRUE
					lb_se_imprime = TRUE
			end choose
			// Valida si hay que imprimir
			if lb_se_imprime Then
				//
				// Graba su costo de inscripción
				if lb_con_pago = FALSE  THEN
					ll_ren = dw_reporte.Insertrow(0)
					dw_reporte.Object.per_ins  [ ll_ren ]  = ii_periodo
					dw_reporte.Object.anio_ins [ ll_ren ]  = ii_anio 
					dw_reporte.Object.Cuenta[ll_ren] 		= ll_cuenta
					dw_reporte.Object.periodo[ll_ren]		= ii_periodo
					dw_reporte.Object.anio[ll_ren] 			= ii_anio
					if ls_nivel = "L" then
						 dw_reporte.Object.cve_concepto[ll_ren] = 4
						 dw_reporte.Object.cve_descri[ll_ren] 	 = "INSCRIPCION (REINGRESO LIC.)"
						 dw_reporte.Object.fecha_vento[ll_ren]  = ldt_Fvento_ins_lic
						 dw_reporte.Object.importe[ll_ren] 		 = ld_costo_lic
					else
						 dw_reporte.Object.cve_concepto[ll_ren] = 6
						 dw_reporte.Object.cve_descri[ll_ren] 	 = "INSCRIPCION (REINGRESO POS.)"
						 dw_reporte.Object.fecha_vento[ll_ren]  = ldt_Fvento_ins_pos
						 dw_reporte.Object.importe[ll_ren] 		 = ld_costo_pos
					end if
				end if
				// Graba Adeudos
				if lb_con_adeu  THEN
					for ll_hasta = ll_adeudos to lds_adeudos.Rowcount()
						if ll_cuenta <> lds_adeudos.GetItemNumber(ll_hasta,"v_cuenta") then
							exit
						else
							ll_ren = dw_reporte.Insertrow(0)
							dw_reporte.Object.per_ins	[ ll_ren ]  = ii_periodo
							dw_reporte.Object.anio_ins [ ll_ren ]  = ii_anio 
							dw_reporte.Object.Cuenta[ll_ren] 		= ll_cuenta
							dw_reporte.Object.periodo[ll_ren]		= lds_adeudos.object.v_periodo[ll_hasta]
							dw_reporte.Object.anio[ll_ren] 			= lds_adeudos.object.v_anio[ll_hasta]
							dw_reporte.Object.cve_concepto[ll_ren] = lds_adeudos.object.v_cve_concepto[ll_hasta]
							dw_reporte.Object.cve_descri[ll_ren] 	= lds_adeudos.object.conceptos_concepto[ll_hasta]
							dw_reporte.Object.fecha_vento[ll_ren] 	= lds_adeudos.object.v_fecha_vencimiento[ll_hasta]
							dw_reporte.Object.importe[ll_ren] 		= lds_adeudos.object.v_saldo[ll_hasta]
						end if
					next
				end if
				//
				// Graba concepto 33
				if lb_con_33 THEN
					for ll_hasta = 1 to lds_concepto_33.Rowcount()
						ll_ren = dw_reporte.Insertrow(0)
						dw_reporte.Object.per_ins	[ ll_ren ]  = ii_periodo
						dw_reporte.Object.anio_ins [ ll_ren ] 	= ii_anio 
						dw_reporte.Object.Cuenta[ll_ren] 		= ll_cuenta
						dw_reporte.Object.periodo[ll_ren]		= lds_concepto_33.object.periodo[ll_hasta]
						dw_reporte.Object.anio[ll_ren] 			= lds_concepto_33.object.anio[ll_hasta]
						dw_reporte.Object.cve_concepto[ll_ren] = lds_concepto_33.object.cve_concepto[ll_hasta]
						dw_reporte.Object.cve_descri[ll_ren] 	= lds_concepto_33.object.conceptos_concepto[ll_hasta]
						dw_reporte.Object.fecha_vento[ll_ren] 	= lds_concepto_33.object.fecha_vencimiento[ll_hasta]
						dw_reporte.Object.importe[ll_ren] 		= lds_concepto_33.object.saldo[ll_hasta]
					next
				end if
		end if
			//
			ic_pct_complete = ((ll_leidos * 100) / ll_tot_ctas_inscritas )
			uo_progress_bar.uf_set_position (ic_pct_complete)
		
	  next 
  		dw_reporte.sort()
		dw_reporte.setredraw(TRUE)
  
	  if ic_pct_complete >= 100.0  then 
			Beep (1)
	  end if
	end choose
		//
		messagebox("Aviso","Fin del proceso")
	//
End IF

destroy lds_bandera_inscritos
destroy lds_pago_reg
destroy lds_concepto_33
destroy lds_adeudos
destroy lds_max_costo_insc
destroy lds_minmax_cta
destroy lds_becas_al100

end event

type uo_anio_periodo from uo_sit_periodo_anio within w_sit_rep_bloqueados_x_adeudo
integer x = 1986
integer y = 26
integer taborder = 40
boolean bringtotop = true
end type

on uo_anio_periodo.destroy
call uo_sit_periodo_anio::destroy
end on

type dw_reporte from datawindow within w_sit_rep_bloqueados_x_adeudo
event ue_guarda_datos ( )
event ue_imprime ( )
integer x = 80
integer y = 403
integer width = 3324
integer height = 1245
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "d_sit_rep_alumnos_bloq_adeu"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event ue_guarda_datos;if rowcount() > 0 then
	SetPointer(HourGlass!)	
	if this.SaveAs() <> 1 then		 
		messagebox("Anteción","No se pudo guardar el archivo externo")	
	end if
	
end if
end event

event ue_imprime;if RowCount() > 0 then
	this.modify("Datawindow.print.preview = yes")
	SetPointer(HourGlass!)
	openwithparm(w_sit_conf_impr,this)
end if

end event

event constructor;//
//		Se conecta a bd 
//
//settransobject( gtr_sit ) 

window ventana_propietaria

ventana_propietaria = getparent()

menu_propietario = ventana_propietaria.menuid

menu_propietario.dw = this

dw_reporte.modify("DataWindow.Print.Preview = yes")
end event

event rbuttondown;//
//		Para imprimir el reporte
//
if Messagebox("Verifique...","¿Se imprime Reporte de alumnos con adeudos ?",Question!,YesNo!,1) = 1 then
	dw_reporte.print()
	dw_reporte.reset()
end if 

end event

type uo_progress_bar from uo_sit_progress_bar within w_sit_rep_bloqueados_x_adeudo
integer x = 2026
integer y = 240
integer width = 1061
integer taborder = 30
boolean bringtotop = true
end type

on uo_progress_bar.destroy
call uo_sit_progress_bar::destroy
end on

