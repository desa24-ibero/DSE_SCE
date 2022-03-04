$PBExportHeader$w_sit_rep_adeudo_alum_fol.srw
$PBExportComments$Esta ventana contiene los objetos relacionados con el calculo real de inscripción.
forward
global type w_sit_rep_adeudo_alum_fol from w_sit_ancestral
end type
type cb_genera_reporte from commandbutton within w_sit_rep_adeudo_alum_fol
end type
type uo_anio_periodo from uo_sit_periodo_anio within w_sit_rep_adeudo_alum_fol
end type
type dw_reporte from datawindow within w_sit_rep_adeudo_alum_fol
end type
type rb_lic from radiobutton within w_sit_rep_adeudo_alum_fol
end type
type rb_posgrado from radiobutton within w_sit_rep_adeudo_alum_fol
end type
type gb_nivel from groupbox within w_sit_rep_adeudo_alum_fol
end type
type uo_progress_bar from uo_sit_progress_bar within w_sit_rep_adeudo_alum_fol
end type
type cb_filtra from commandbutton within w_sit_rep_adeudo_alum_fol
end type
end forward

global type w_sit_rep_adeudo_alum_fol from w_sit_ancestral
integer height = 2250
string title = "Reporte Alumnos Bloqueados por Adeudos"
string menuname = "m_sit_ancestro_reporte"
boolean righttoleft = false
event type long ue_carga_datos ( integer ai_anio,  integer ai_periodo )
event ue_cierra ( )
cb_genera_reporte cb_genera_reporte
uo_anio_periodo uo_anio_periodo
dw_reporte dw_reporte
rb_lic rb_lic
rb_posgrado rb_posgrado
gb_nivel gb_nivel
uo_progress_bar uo_progress_bar
cb_filtra cb_filtra
end type
global w_sit_rep_adeudo_alum_fol w_sit_rep_adeudo_alum_fol

type variables
m_sit_ancestro_reporte menu_propietario

long		il_cta_min, il_cta_max
integer	ii_archevi, ii_anio_ant, ii_periodo_ant
boolean 	ib_cuenta_ok, ib_solo_una_vez
datetime	idt_Fvento_ins_lic, idt_Fvento_ins_pos
double	id_tasa_vento, id_costo_max_insc, id_costo_min_insc, id_costo_med_insc
double	id_costo_pos
string	is_nivel

uo_sit_datastore ids_adeudos
uo_sit_datastore ids_pre_inscritos
uo_sit_datastore ids_pago_reg
uo_sit_datastore ids_concepto_33
uo_sit_datastore ids_becas_al100


// determina si el progress bar a tocado el texto del porcentaje
boolean ib_invert
dec {2} ic_pct_complete
end variables

event ue_carga_datos;// Carga los datastore y variables con la información correspondiente al 
// año y período seleccionado
//
// Raúl Hdez. V 4/10/02
//
// Modifico R.H.V  22/05/2003 Para el periodo de verano se incluye otro nivel (medio)
// ademas de los minimo y maximo para el costo de inscripción para reingreso Lic.

long 	 ll_recupera, ll_con_error, ll_regresa
string ls_mensaje_err, ls_busca

ll_regresa = 0

	//Obtiene las cuentas y el nivel  de los alumnos pre-inscritos
	ll_recupera = ids_pre_inscritos.Retrieve(is_nivel,ii_anio,ii_periodo)
	
	choose case ll_recupera
		case is <0 
			Messagebox("Error","Al obtener cuentas para este año y período "+ &
						  " ~n Error db: " + ids_pre_inscritos.ds_sqlerrtext)
			ll_regresa = -1
		case 0
			Messagebox("Aviso","No existen cuentas para este año y período")
			ll_regresa = -1
	end choose

if ll_regresa <> -1 Then

	//Obtiene por cuenta, si tiene pago registrado de inscripción para este año y período 
	ll_recupera = ids_pago_reg.retrieve(ii_anio,ii_periodo)
	
	choose case ll_recupera
		case is <0 
			Messagebox("Error","Al obtener cuentas con pagos inscripción en mov_alumnos "+ &
						  " ~n Error db: " + ids_pago_reg.ds_sqlerrtext)
			ll_regresa = -1
		case else
			//
	end choose
end if

if ll_regresa <> -1 Then

	//Obtiene cuentas con el concepto 33 (acuerdo esp. con bloqueo) con importe positivo
	ll_recupera = ids_concepto_33.retrieve(ii_anio,ii_periodo,33)
	
	choose case ll_recupera
		case is <0 
			Messagebox("Error","Al obtener cuentas con el concepto 33,en mov_alumnos "+ &
						  " ~n Error db: " + ids_concepto_33.ds_sqlerrtext)
			ll_regresa = -1
		case else
			//
	end choose
end if

if ll_regresa <> -1 Then
	
	//Obtiene cuentas con beca o financiamiento al 100%
	ll_recupera = ids_becas_al100.Retrieve(ii_anio,ii_periodo)
	
	choose case ll_recupera
		case is <0 
			Messagebox("Error","Al obtener cuentas con beca o FE al 100%, en mov_alumnos "+ &
						  " ~n Error db: " + ids_becas_al100.ds_sqlerrtext)
			ll_regresa = -1
		case else
			//
	end choose
end if


if ll_regresa <> -1 Then
 if ib_solo_una_vez  then
 else
	
	//Obtiene las cuentas con adeudos solo una sola vez durante el proceso
	ll_recupera = ids_adeudos.retrieve()
	
	choose case ll_recupera
		case is <0
			Messagebox("Error","Al obtener ctas con adeudos de mov_alumnos "+ &
							" ~n Error db: " + ids_adeudos.ds_sqlerrtext)
			ll_regresa = -1
			ib_solo_una_vez = false
		case  0 
//			Messagebox("Aviso","No existen cuentas con adeudos para este año y período")
//			ll_regresa = -1
			ib_solo_una_vez = true
		case is > 0
			ib_solo_una_vez = true		
		case else
	end choose
  end if
end if

uo_sit_datastore lds_max_costo_insc
lds_max_costo_insc = CREATE uo_sit_datastore
lds_max_costo_insc.DataObject = "d_sit_max_min_costo_inscrip"
lds_max_costo_insc.SetTransObject(gtr_sit)

if ll_regresa <> -1 Then
	//
	//	Extrae la fecha vencimiento costo de inscripción reingreso Lic. 
	//	
	ll_recupera = f_sit_fechas_vencimiento(0,4,ii_periodo, ii_anio,1, 0, idt_Fvento_ins_lic, &
														id_tasa_vento, ls_mensaje_err)
	if ll_recupera <= 0 then
		Messagebox("Error","Al obtener fecha de vencimiento reingreso Lic. "+ls_mensaje_err)
		ll_regresa = -1
	else
		//
		//	Extrae la fecha vencimiento costo de inscripción reingreso Pos.
		//	
		ll_recupera = f_sit_fechas_vencimiento(0,6,ii_periodo, ii_anio,1, 0, idt_Fvento_ins_pos, &
															id_tasa_vento, ls_mensaje_err)
		if ll_recupera <= 0 then
			Messagebox("Error","Al obtener fecha de vencimiento reingreso Pos. "+ls_mensaje_err)
			ll_regresa = -1
		else
			// Estrae maximo y minimo costo de inscripción para reingreso Lic.
			// Modifico R.H.V  22/05/2003 incluir nivel costo medio solo para verano
			ll_recupera = lds_max_costo_insc.retrieve(2,"L",ii_anio, ii_periodo)
			choose case ll_recupera
				case is <=0
					Messagebox("Error","Al obtener maximo y minimo costo inscripción reingreso Lic. "+lds_max_costo_insc.ds_sqlerrtext)
					ll_regresa = -1
				case is >0
					// 
					choose case lds_max_costo_insc.rowcount() 
						case 2 
							id_costo_min_insc = lds_max_costo_insc.Object.costo[1]
							id_costo_med_insc = 0.00
							id_costo_max_insc = lds_max_costo_insc.Object.costo[lds_max_costo_insc.rowcount()]
						case 3
							id_costo_min_insc = lds_max_costo_insc.Object.costo[1]
							id_costo_med_insc = lds_max_costo_insc.Object.costo[2]
							id_costo_max_insc = lds_max_costo_insc.Object.costo[lds_max_costo_insc.rowcount()]
						case else
							//Messagebox("Aviso","Existen mas de 3 niveles para el costo inscripción reingreso Lic. ")
							id_costo_min_insc = lds_max_costo_insc.Object.costo[1]
							id_costo_med_insc = 0.00
							id_costo_max_insc = lds_max_costo_insc.Object.costo[lds_max_costo_insc.rowcount()]
					end choose
					//
					// Estrae maximo costo de inscripción para reingreso Posgrado.
					ll_recupera = lds_max_costo_insc.retrieve(2,"P",ii_anio, ii_periodo)
					choose case ll_recupera
						case is <=0
							Messagebox("Error","Al obtener maximo y minimo costo inscripción reingreso Pos. "+lds_max_costo_insc.ds_sqlerrtext)
							ll_regresa = -1
						case is >0
							id_costo_pos = lds_max_costo_insc.Object.costo[lds_max_costo_insc.rowcount()]
					end choose
			end choose
		end if
 end if
end if


Destroy lds_max_costo_insc

return ll_regresa

end event

event ue_cierra;//
//  cierra bases de datos utilizadas  
// 
destroy ids_pre_inscritos
destroy ids_pago_reg
destroy ids_concepto_33
destroy ids_becas_al100

if isvalid(gtr_sit)  then f_sit_desconecta_bd(gtr_sit)
if isvalid(gtr_sce)  then f_sit_desconecta_bd(gtr_sce)
if isvalid(gtr_sfeb) then f_sit_desconecta_bd(gtr_sfeb)

FileWrite(ii_archevi," ")
FileWrite(ii_archevi,"El proceso termino a las "+string(f_sit_fecha_hora_servidor()))
//
// cierra archivo de bitacora de evidencias para este proceso
//
integer li_cierra
li_cierra = Fileclose(ii_archevi)
if li_cierra < 1 then
	messagebox("Error","Al cerrar archivo de evidencias")
end if


end event

on w_sit_rep_adeudo_alum_fol.create
int iCurrent
call super::create
if this.MenuName = "m_sit_ancestro_reporte" then this.MenuID = create m_sit_ancestro_reporte
this.cb_genera_reporte=create cb_genera_reporte
this.uo_anio_periodo=create uo_anio_periodo
this.dw_reporte=create dw_reporte
this.rb_lic=create rb_lic
this.rb_posgrado=create rb_posgrado
this.gb_nivel=create gb_nivel
this.uo_progress_bar=create uo_progress_bar
this.cb_filtra=create cb_filtra
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_genera_reporte
this.Control[iCurrent+2]=this.uo_anio_periodo
this.Control[iCurrent+3]=this.dw_reporte
this.Control[iCurrent+4]=this.rb_lic
this.Control[iCurrent+5]=this.rb_posgrado
this.Control[iCurrent+6]=this.gb_nivel
this.Control[iCurrent+7]=this.uo_progress_bar
this.Control[iCurrent+8]=this.cb_filtra
end on

on w_sit_rep_adeudo_alum_fol.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_genera_reporte)
destroy(this.uo_anio_periodo)
destroy(this.dw_reporte)
destroy(this.rb_lic)
destroy(this.rb_posgrado)
destroy(this.gb_nivel)
destroy(this.uo_progress_bar)
destroy(this.cb_filtra)
end on

event open;//
// Crea reporte de Alumnos Pre_inscritos con Adeudos
// 
// Author: Raúl Hdez V. Octubre/2002
// Modificación :
//

long	 	ll_recupera, ll_regresa


//			Valida conexión a la base de datos de SIT
if not isvalid( gtr_sit) then 
	if f_sit_conecta_bd(gtr_sit,"SIT",gs_usuario,gs_password) =0 then 
		messagebox("Aviso", "Problemas al conectarse a la bd de Tesorería SIT")
		close (this ) 
		return
	end if 
end if 
dw_reporte.settransobject(gtr_sit) 

//			Valida conexión a la base de datos de Servicios Escolares
if not isvalid( gtr_sce) then 
	if f_sit_conecta_bd(gtr_sce,"SCE",gs_usuario,gs_password) =0 then 
		messagebox("Aviso", "Problemas al conectarse a la bd de Control Escolar") 
		close (this ) 
		return
	end if 
end if 

//			Valida conexión a la base de datos de becas y financiamiento
if not isvalid( gtr_sfeb) then 
	if f_sit_conecta_bd(gtr_sfeb,"SFEB",gs_usuario,gs_password) = 0 then 
		messagebox("Aviso", "Problemas al conectarse a la bd de Beca y Financiamiento") 
		close (this) 
		return
	end if 
end if 

//Obtiene las cuentas y el nivel  de los alumnos inscritos
ids_pre_inscritos = CREATE uo_sit_datastore
ids_pre_inscritos.DataObject = "d_sit_pre_insc_fol"
ids_pre_inscritos.SettransObject(gtr_sce)

//Obtiene por cuenta si tiene su pago registrado de inscripción para este año y periodo 
ids_pago_reg = CREATE uo_sit_datastore
ids_pago_reg.DataObject = "d_sit_val_pago_regist"
ids_pago_reg.SetTransObject(gtr_sit)

//Obtiene cuentas con el concepto 33 (acuerdo esp. con bloqueo) con importe positivo
ids_concepto_33 = CREATE uo_sit_datastore
ids_concepto_33.DataObject = "d_sit_sdo_concepto33_vista"
ids_concepto_33.SetTransObject(gtr_sit)

//Obtiene cuentas con beca o financiamiento al 100%
ids_becas_al100 = CREATE uo_sit_datastore
ids_becas_al100.DataObject = "d_sit_beca_apoyo_al_100"
ids_becas_al100.SetTransobject(gtr_sfeb)


//Obtiene las cuentas con adeudos
ids_adeudos = CREATE uo_sit_datastore
ids_adeudos.DataObject = "d_sit_sdo_concep_deu_vista"
ids_adeudos.SetTransObject(gtr_sit)

// Abre archivo de bitacora de evidencias para este proceso
//
ii_archevi = FileOpen( "bit_rep_adeudos" + string(today(), "m-d-yy" )+ ".txt", LineMode!, Write!, Shared!, Append!)

if ii_archevi < 1 then
	messagebox("Error","Al abrir archivo de evidencias")
	FileWrite(ii_archevi,"Error al abrir archivo de evidencias para este proceso")
	close (this)
end if

FileWrite(ii_archevi,"Evidencias del Reporte de Alumnos Pre-inscritos con Adeudos.")
string  ls_temporal
FileWrite(ii_archevi,"Generado el "+string(f_sit_fecha_hora_servidor()))
FileWrite(ii_archevi,"")

end event

event close;call super::close;post event  ue_cierra()
end event

type st_1 from w_sit_ancestral`st_1 within w_sit_rep_adeudo_alum_fol
end type

type p_1 from w_sit_ancestral`p_1 within w_sit_rep_adeudo_alum_fol
end type

type cb_genera_reporte from commandbutton within w_sit_rep_adeudo_alum_fol
integer x = 77
integer y = 323
integer width = 307
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;// Lleva acabo el proceso de la generación del reporte de alumnos pre_inscritos
// con adeudos vencidos y que no han pagado la inscripción del próximo semestre,
// se eliminan de este reporte los alumnos que tienen beca o financiamiento educativo
// al 100%.
//
// Author: Raúl Hdez. V.
// Octubre/2002
//
// Fecha Modificación :
//

long		ll_tot_ctas_inscritas, ll_leidos, ll_adeudos
long     ll_cuenta, ll_recupera, ll_ren, ll_hasta, ll_porcent_apoyo, ll_folio
string   ls_mensaje_err, ls_nivel, ls_tipo_apoyo, ls_nombre, ls_digito_cta, ls_pago_insc
integer	li_cve_apoyo, li_horas_apoyo
double	ld_tasa_vento
datetime	ld_null
boolean	lb_con_pago, lb_con_adeu, lb_con_33, lb_se_imprime, lb_se_graba 

//	 inicializa la barra de proceso 
ic_pct_complete = 0.0
uo_progress_bar.uf_set_position (0)

if rb_lic.checked = False and rb_posgrado.checked = false then
	Messagebox("Aviso","Seleccione el Nivel a procesar")
	return
end if


if rb_lic.checked then
	ls_nivel = "Licenciatura "
else
	ls_nivel = "Posgrado "
end if

														// proceso general de cuentas
if messagebox("Aviso","Desea correr el reporte para el "+ &
              " ~n nivel de " + ls_nivel + " con el año " + string(ii_anio) + &
				  " ~n y el período " + &
				  	uo_anio_periodo.em_periodo.text,question!,yesno!,2) <> 1 then
	uo_anio_periodo.em_periodo.setfocus()
	Return
end if

//
// Inicia proceso

// Evento de carga de datastore 
ll_ren = event ue_carga_datos(ii_anio,ii_periodo)
if ll_ren = -1 then
	return
end if

dw_reporte.reset()
dw_reporte.setredraw( False)
		
ll_tot_ctas_inscritas =  ids_pre_inscritos.rowcount()	   //  todas las ctas 

//ll_tot_ctas_inscritas = 100

choose case ll_tot_ctas_inscritas 
	case is < 0  
		Messagebox("Error","Tabla alumnos horario_insc sce"+ids_pre_inscritos.ds_sqlerrtext)
	case 0 
		Messagebox("Error","No existe información en tabla horario_insc sce ")
	case else
		//		
		
		for ll_leidos  = 1 to  ll_tot_ctas_inscritas
	
			ll_cuenta 	  = ids_pre_inscritos.GetItemNumber(ll_leidos,"horario_insc_cuenta")
			
//if ll_cuenta = 140328  then
//else
//	goto continua
//end if
			
			lb_con_pago 	= FALSE
			lb_se_imprime 	= FALSE
			ls_pago_insc   = "N"   //indica en el dw si la cta ya pago su inscripción, para no imprimir
			
			/* Busca si la cuenta tiene su pago registrado de inscripción para este periodo */
			ll_recupera = ids_pago_reg.find( "cuenta = "+ string(ll_cuenta), &
																	1, ids_pago_reg.rowcount() )
			choose case ll_recupera
				case is <0
					Messagebox("Error","al buscar si tiene pago registrado, para la cuenta : "+ids_pago_reg.ds_sqlerrtext)
					ll_leidos  = ll_tot_ctas_inscritas + 1
				case  0
					// valida si la cuenta tiene beca o financiamiento al 100%
					ll_recupera = ids_becas_al100.Find( " becas_fin_cuenta = "+ string(ll_cuenta), &
																	1,ids_becas_al100.rowcount())
					choose case ll_recupera
						case is <0
							Messagebox("Error","al buscar si tiene beca al 100%, para la cuenta : "+ids_pago_reg.ds_sqlerrtext)
							ll_leidos  = ll_tot_ctas_inscritas + 1
						case  0	
							lb_se_imprime 	= TRUE
						case is >0
							// Ya tiene pago
							lb_con_pago 	= true
							ls_pago_insc = "S"
					end choose
				case is >0
					// Ya tiene pago
					lb_con_pago = true
					ls_pago_insc = "S"
			end choose	
			//				
			// Busca si la cuenta tiene el concepto 33 con importe positivo
			lb_con_33 = FALSE
			
			ll_recupera = ids_concepto_33.find( "cuenta = "+ string(ll_cuenta), &
																	1, ids_concepto_33.rowcount() )
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
			ll_adeudos = ids_adeudos.Find( "v_cuenta = " + string(ll_cuenta), &
																	1,ids_adeudos.rowcount() )
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
				ls_digito_cta =  f_sit_obten_digito(ll_cuenta)
				ls_nivel  = ids_pre_inscritos.GetItemString(ll_leidos,"academicos_nivel")
				ll_folio	 = ids_pre_inscritos.GetItemNumber(ll_leidos,"horario_insc_folio_sol_mat")
				ls_nombre = ids_pre_inscritos.GetItemString(ll_leidos,"alumnos_nombre_completo")
				//
				//identifica si tiene beca
				ll_recupera = f_sit_dat_apoyos(ll_cuenta,ii_anio,ii_periodo, &
														ls_tipo_apoyo, li_cve_apoyo, ll_porcent_apoyo, &
														li_horas_apoyo,ls_mensaje_err)
				choose case ll_recupera
					case is<0
						Messagebox("Error","al buscar si tiene apoyo, para la cuenta"+ ls_mensaje_err)
							ll_leidos  = ll_tot_ctas_inscritas + 1
					case else
				end choose
				//
				// Graba Adeudos
				if lb_con_adeu  THEN
					
					lb_se_graba = true
					
					for ll_hasta = ll_adeudos to ids_adeudos.Rowcount()
					  if ll_cuenta <> ids_adeudos.GetItemNumber(ll_hasta,"v_cuenta") then
							exit
					  else
						 // filtra los conceptos de inscripcion del mismo año y periodo
						 choose case ids_adeudos.object.v_cve_concepto[ll_hasta]
								
							case 1,2,3,4,5,6,7,17,18,30,31
								if ii_periodo = ids_adeudos.object.v_periodo[ll_hasta] and &
								   ii_anio	  = ids_adeudos.object.v_anio[ll_hasta] then
									lb_se_graba = false
								else
									lb_se_graba = true
								end if
								
							case else
									lb_se_graba = true
						end choose
						//
						if lb_se_graba then
							ll_ren = dw_reporte.Insertrow(0)
							dw_reporte.Object.per_ins	[ ll_ren ]  = ii_periodo
							dw_reporte.Object.anio_ins [ ll_ren ]  = ii_anio 
							dw_reporte.Object.Cuenta[ll_ren] 		= ll_cuenta
							dw_reporte.Object.folio[ll_ren]			= ll_folio
							dw_reporte.Object.nombre[ll_ren]			= ls_nombre
							dw_reporte.Object.tipo_proceso[ll_ren]	= is_nivel
							dw_reporte.Object.digito_cta[ll_ren]	= ls_digito_cta
							dw_reporte.Object.con_beca[ll_ren]		= ls_tipo_apoyo
							dw_reporte.Object.con_pago_insc[ll_ren]= ls_pago_insc
							
							if ls_nivel = "L" then					
								dw_reporte.Object.costo_min[ll_ren] = id_costo_min_insc
								dw_reporte.Object.costo_max[ll_ren] = id_costo_max_insc
								dw_reporte.Object.costo_med[ll_ren] = id_costo_med_insc
							else
								dw_reporte.Object.costo_min[ll_ren] = id_costo_pos
								dw_reporte.Object.costo_max[ll_ren] = id_costo_pos
								dw_reporte.Object.costo_med[ll_ren] = id_costo_pos
							end if
							//
							dw_reporte.Object.periodo[ll_ren]		= ids_adeudos.object.v_periodo[ll_hasta]
							dw_reporte.Object.anio[ll_ren] 			= ids_adeudos.object.v_anio[ll_hasta]
							dw_reporte.Object.cve_concepto[ll_ren] = ids_adeudos.object.v_cve_concepto[ll_hasta]
							dw_reporte.Object.cve_descri[ll_ren] 	= ids_adeudos.object.conceptos_concepto[ll_hasta]
							dw_reporte.Object.fecha_vento[ll_ren] 	= ids_adeudos.object.v_fecha_vencimiento[ll_hasta]
							dw_reporte.Object.importe[ll_ren] 		= ids_adeudos.object.v_saldo[ll_hasta]
						end if
					end if	
					next
				end if
				//
				// Graba concepto 33
				if lb_con_33  THEN
					for ll_hasta = 1 to ids_concepto_33.Rowcount()
						ll_ren = dw_reporte.Insertrow(0)
						dw_reporte.Object.per_ins	[ ll_ren ]  = ii_periodo
						dw_reporte.Object.anio_ins [ ll_ren ] 	= ii_anio 
						dw_reporte.Object.Cuenta[ll_ren] 		= ll_cuenta
						dw_reporte.Object.folio[ll_ren]			= ll_folio
						dw_reporte.Object.nombre[ll_ren]			= ls_nombre
						dw_reporte.Object.tipo_proceso[ll_ren]	= is_nivel
						dw_reporte.Object.digito_cta[ll_ren]	= ls_digito_cta
						dw_reporte.Object.con_beca[ll_ren]		= ls_tipo_apoyo
						dw_reporte.Object.con_pago_insc[ll_ren]= ls_pago_insc
						
						if ls_nivel = "L" then					
							dw_reporte.Object.costo_min[ll_ren] = id_costo_min_insc
							dw_reporte.Object.costo_max[ll_ren] = id_costo_max_insc
							dw_reporte.Object.costo_med[ll_ren] = id_costo_med_insc
						else
							dw_reporte.Object.costo_min[ll_ren] = id_costo_pos
							dw_reporte.Object.costo_max[ll_ren] = id_costo_pos
							dw_reporte.Object.costo_med[ll_ren] = id_costo_pos

						end if
						dw_reporte.Object.periodo[ll_ren]		= ids_concepto_33.object.periodo[ll_hasta]
						dw_reporte.Object.anio[ll_ren] 			= ids_concepto_33.object.anio[ll_hasta]
						dw_reporte.Object.cve_concepto[ll_ren] = ids_concepto_33.object.cve_concepto[ll_hasta]
						dw_reporte.Object.cve_descri[ll_ren] 	= ids_concepto_33.object.conceptos_concepto[ll_hasta]
						dw_reporte.Object.fecha_vento[ll_ren] 	= ids_concepto_33.object.fecha_vencimiento[ll_hasta]
						dw_reporte.Object.importe[ll_ren] 		= ids_concepto_33.object.saldo[ll_hasta]
					next
				end if
				//
				// Graba registro cuando no tiene adeudos ni concepto 33 pero debe inscripcion
				//
				if ls_pago_insc = "N" and lb_con_33 = false and lb_con_adeu = false THEN
	
						ll_ren = dw_reporte.Insertrow(0)
						dw_reporte.Object.per_ins	[ ll_ren ]  = ii_periodo
						dw_reporte.Object.anio_ins [ ll_ren ] 	= ii_anio 
						dw_reporte.Object.Cuenta[ll_ren] 		= ll_cuenta
						dw_reporte.Object.folio[ll_ren]			= ll_folio
						dw_reporte.Object.nombre[ll_ren]			= ls_nombre
						dw_reporte.Object.tipo_proceso[ll_ren]	= is_nivel
						dw_reporte.Object.digito_cta[ll_ren]	= ls_digito_cta
						dw_reporte.Object.con_beca[ll_ren]		= ls_tipo_apoyo
						dw_reporte.Object.con_pago_insc[ll_ren]= ls_pago_insc
						
						if ls_nivel = "L" then					
							dw_reporte.Object.costo_min[ll_ren] = id_costo_min_insc
							dw_reporte.Object.costo_max[ll_ren] = id_costo_max_insc
							dw_reporte.Object.costo_med[ll_ren] = id_costo_med_insc
						else
							dw_reporte.Object.costo_min[ll_ren] = id_costo_pos
							dw_reporte.Object.costo_max[ll_ren] = id_costo_pos
							dw_reporte.Object.costo_med[ll_ren] = id_costo_pos
						end if
						dw_reporte.Object.periodo[ll_ren]		= ii_periodo
						dw_reporte.Object.anio[ll_ren] 			= ii_anio
						dw_reporte.Object.cve_concepto[ll_ren] = 0
						dw_reporte.Object.cve_descri[ll_ren] 	= ""
						isnull(ld_null)
						dw_reporte.Object.fecha_vento[ll_ren] 	= ld_null
						dw_reporte.Object.importe[ll_ren] 		= 0	
				end if
			end if
//continua:
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

end event

type uo_anio_periodo from uo_sit_periodo_anio within w_sit_rep_adeudo_alum_fol
integer x = 2264
integer y = 26
integer taborder = 50
boolean bringtotop = true
end type

on uo_anio_periodo.destroy
call uo_sit_periodo_anio::destroy
end on

type dw_reporte from datawindow within w_sit_rep_adeudo_alum_fol
event ue_guarda_datos ( )
event ue_imprime ( )
integer x = 77
integer y = 477
integer width = 3324
integer height = 1283
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "d_sit_rep_alum_preins_adeu_fol"
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

window ventana_propietaria

ventana_propietaria = getparent()

menu_propietario = ventana_propietaria.menuid

menu_propietario.dw = this

dw_reporte.modify("DataWindow.Print.Preview = yes")
end event

event rbuttondown;//
//		Para imprimir el reporte
//
if Messagebox("Verifique...","¿Se imprime Reporte de alumnos pre_inscritos con adeudos ?",Question!,YesNo!,1) = 1 then
	dw_reporte.print()
	dw_reporte.reset()
end if 

end event

type rb_lic from radiobutton within w_sit_rep_adeudo_alum_fol
integer x = 571
integer y = 349
integer width = 421
integer height = 74
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 29534863
string text = "Licenciatura"
borderstyle borderstyle = stylelowered!
end type

event clicked;is_nivel = "L"
end event

type rb_posgrado from radiobutton within w_sit_rep_adeudo_alum_fol
integer x = 1020
integer y = 349
integer width = 391
integer height = 74
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 29534863
string text = "Posgrado"
borderstyle borderstyle = stylelowered!
end type

event clicked;is_nivel = "P"
end event

type gb_nivel from groupbox within w_sit_rep_adeudo_alum_fol
integer x = 530
integer y = 288
integer width = 969
integer height = 157
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 29534863
string text = "Nivel"
borderstyle borderstyle = stylelowered!
end type

type uo_progress_bar from uo_sit_progress_bar within w_sit_rep_adeudo_alum_fol
event destroy ( )
integer x = 2286
integer y = 250
integer width = 1083
integer taborder = 30
boolean bringtotop = true
end type

on uo_progress_bar.destroy
call uo_sit_progress_bar::destroy
end on

type cb_filtra from commandbutton within w_sit_rep_adeudo_alum_fol
integer x = 1646
integer y = 323
integer width = 384
integer height = 128
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Filtra Datos"
end type

event clicked;string ls_nulo

SetNull(ls_nulo)

dw_reporte.SetFilter(ls_nulo)

dw_reporte.Filter()


end event

