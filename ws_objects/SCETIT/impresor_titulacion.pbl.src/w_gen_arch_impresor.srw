$PBExportHeader$w_gen_arch_impresor.srw
forward
global type w_gen_arch_impresor from window
end type
type dw_grado from datawindow within w_gen_arch_impresor
end type
type dw_consec from datawindow within w_gen_arch_impresor
end type
type lds_salida from datawindow within w_gen_arch_impresor
end type
type cb_1 from commandbutton within w_gen_arch_impresor
end type
type rb_tsu from radiobutton within w_gen_arch_impresor
end type
type rb_mencion_posg from radiobutton within w_gen_arch_impresor
end type
type rb_mencion_lic from radiobutton within w_gen_arch_impresor
end type
type rb_duplicados from radiobutton within w_gen_arch_impresor
end type
type gb_4 from groupbox within w_gen_arch_impresor
end type
type gb_fechas_manual from groupbox within w_gen_arch_impresor
end type
type uo_relacion from uo_relacion_tit_2013 within w_gen_arch_impresor
end type
type cbx_exa_gral_conoc from checkbox within w_gen_arch_impresor
end type
type cbx_codcompleto from checkbox within w_gen_arch_impresor
end type
type rb_rgs from radiobutton within w_gen_arch_impresor
end type
type rb_posg from radiobutton within w_gen_arch_impresor
end type
type rb_lic from radiobutton within w_gen_arch_impresor
end type
type st_fecha_rgs from statictext within w_gen_arch_impresor
end type
type st_fecha_posgrado from statictext within w_gen_arch_impresor
end type
type st_fecha_lic from statictext within w_gen_arch_impresor
end type
type cb_salir from commandbutton within w_gen_arch_impresor
end type
type cb_generar from commandbutton within w_gen_arch_impresor
end type
type dw_1 from datawindow within w_gen_arch_impresor
end type
type gb_2 from groupbox within w_gen_arch_impresor
end type
type gb_1 from groupbox within w_gen_arch_impresor
end type
type rb_manual from radiobutton within w_gen_arch_impresor
end type
type rb_relacion from radiobutton within w_gen_arch_impresor
end type
type dp_fecha_fin from datepicker within w_gen_arch_impresor
end type
type dp_fecha_ini from datepicker within w_gen_arch_impresor
end type
type st_fecha_fin from statictext within w_gen_arch_impresor
end type
type st_fecha from statictext within w_gen_arch_impresor
end type
end forward

global type w_gen_arch_impresor from window
integer width = 2331
integer height = 1968
boolean titlebar = true
string title = "Generación de Archivos para Impresor"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_obtener_fechas ( )
event ue_obtener_fecha_sem_ant ( )
dw_grado dw_grado
dw_consec dw_consec
lds_salida lds_salida
cb_1 cb_1
rb_tsu rb_tsu
rb_mencion_posg rb_mencion_posg
rb_mencion_lic rb_mencion_lic
rb_duplicados rb_duplicados
gb_4 gb_4
gb_fechas_manual gb_fechas_manual
uo_relacion uo_relacion
cbx_exa_gral_conoc cbx_exa_gral_conoc
cbx_codcompleto cbx_codcompleto
rb_rgs rb_rgs
rb_posg rb_posg
rb_lic rb_lic
st_fecha_rgs st_fecha_rgs
st_fecha_posgrado st_fecha_posgrado
st_fecha_lic st_fecha_lic
cb_salir cb_salir
cb_generar cb_generar
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
rb_manual rb_manual
rb_relacion rb_relacion
dp_fecha_fin dp_fecha_fin
dp_fecha_ini dp_fecha_ini
st_fecha_fin st_fecha_fin
st_fecha st_fecha
end type
global w_gen_arch_impresor w_gen_arch_impresor

type variables
string is_ventana, is_nom_ventana, is_grado
Datetime idt_fecha_hoy, idt_fecha_sig_mes, idt_fecha_sig_mes_posg
Integer ii_anio_proc_titulacion
end variables

forward prototypes
public function integer wf_pos_fechas_semana_prev (datetime ar_fecha)
public function integer wf_actualiza_fec_expedicion ()
public function string of_modifica_nombre (string as_cadena)
end prototypes

event ue_obtener_fechas();SELECT getdate() as fecha_hoy,  fecha_primera_siguiente_mes,  fecha_posgrado
	INTO :idt_fecha_hoy, :idt_fecha_sig_mes, :idt_fecha_sig_mes_posg
FROM parametros_titulacion
where  cve_parametro = 1
USING gtr_sce;




end event

public function integer wf_pos_fechas_semana_prev (datetime ar_fecha);integer li_num_dia, li_dias_inc
Date ld_fecha_ini_ant, ld_fecha_fin_ant

li_num_dia = DayNumber(Date(ar_fecha))
/*Obtenemos la fecha del viernes de la semana anterior a la fecha dada*/
li_dias_inc = li_num_dia + 1
ld_fecha_fin_ant = RelativeDate(Date(ar_fecha), - li_dias_inc)


/*Obtenemos la fecha del lunes de la semana anterior a la fecha dada*/
li_dias_inc = 4
ld_fecha_ini_ant = RelativeDate(Date(ld_fecha_fin_ant), - li_dias_inc)


dp_fecha_ini.setvalue(Datetime(ld_fecha_ini_ant))
dp_fecha_fin.setvalue(Datetime(ld_fecha_fin_ant))

return 0
end function

public function integer wf_actualiza_fec_expedicion ();integer ii_resp, li_cont, li_max, li_hora_ini
datetime ldt_fecha

//ldt_fecha = Datetime(dp_fecha_exped.DateValue)

//ii_resp = Messagebox("¡ Confirmar !", "¿Desea actualizar la informacin?",Question!,YesNo!,1)
//If ii_resp = 1 then
	dw_1.accepttext( )
	
	li_cont = 1
	li_max= dw_1.rowcount( )
	
	Do While li_cont <= li_max
		dw_1.setitem( li_cont, 'fecha_expedicion', ldt_fecha)
		li_cont  = li_cont + 1
	Loop
	
	
	If dw_1.Update() = 1 then
		commit using gtr_sce;
	Else
		Rollback using gtr_sce;
		return -1
	End if
//End if

return 0
end function

public function string of_modifica_nombre (string as_cadena);STRING ls_val[]  
INTEGER li_posi , li = 1  
INTEGER le_pos 
STRING ls_retorno 

as_cadena = TRIM(as_cadena) 

// Se divide la cadena por espacios. 
DO WHILE POS(as_cadena , ' ') > 0
   li_posi = POS(as_cadena , ' ')
   ls_val[li] = LEFT(as_cadena , li_posi - 1)
   li ++
   as_cadena = TRIM(MID(as_cadena , li_posi + 1, LEN(as_cadena)))  
loop
ls_val[li] = as_cadena

// Se substituye la primer letra de cada palabra con mayúscula y el resto en minúscula. 
FOR le_pos = 1 TO UPPERBOUND(ls_val)

	IF LEN(ls_retorno) > 0 THEN ls_retorno = ls_retorno + " " 
	
	IF LEN(ls_val[le_pos]) > 3 THEN 
		ls_retorno = ls_retorno + UPPER(LEFT(ls_val[le_pos], 1)) + LOWER(RIGHT(ls_val[le_pos], LEN(ls_val[le_pos]) - 1)) 
	ELSE 	
		ls_retorno = ls_retorno + LOWER(ls_val[le_pos]) 
	END IF 	
	
NEXT 

RETURN ls_retorno 






end function

on w_gen_arch_impresor.create
this.dw_grado=create dw_grado
this.dw_consec=create dw_consec
this.lds_salida=create lds_salida
this.cb_1=create cb_1
this.rb_tsu=create rb_tsu
this.rb_mencion_posg=create rb_mencion_posg
this.rb_mencion_lic=create rb_mencion_lic
this.rb_duplicados=create rb_duplicados
this.gb_4=create gb_4
this.gb_fechas_manual=create gb_fechas_manual
this.uo_relacion=create uo_relacion
this.cbx_exa_gral_conoc=create cbx_exa_gral_conoc
this.cbx_codcompleto=create cbx_codcompleto
this.rb_rgs=create rb_rgs
this.rb_posg=create rb_posg
this.rb_lic=create rb_lic
this.st_fecha_rgs=create st_fecha_rgs
this.st_fecha_posgrado=create st_fecha_posgrado
this.st_fecha_lic=create st_fecha_lic
this.cb_salir=create cb_salir
this.cb_generar=create cb_generar
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.rb_manual=create rb_manual
this.rb_relacion=create rb_relacion
this.dp_fecha_fin=create dp_fecha_fin
this.dp_fecha_ini=create dp_fecha_ini
this.st_fecha_fin=create st_fecha_fin
this.st_fecha=create st_fecha
this.Control[]={this.dw_grado,&
this.dw_consec,&
this.lds_salida,&
this.cb_1,&
this.rb_tsu,&
this.rb_mencion_posg,&
this.rb_mencion_lic,&
this.rb_duplicados,&
this.gb_4,&
this.gb_fechas_manual,&
this.uo_relacion,&
this.cbx_exa_gral_conoc,&
this.cbx_codcompleto,&
this.rb_rgs,&
this.rb_posg,&
this.rb_lic,&
this.st_fecha_rgs,&
this.st_fecha_posgrado,&
this.st_fecha_lic,&
this.cb_salir,&
this.cb_generar,&
this.dw_1,&
this.gb_2,&
this.gb_1,&
this.rb_manual,&
this.rb_relacion,&
this.dp_fecha_fin,&
this.dp_fecha_ini,&
this.st_fecha_fin,&
this.st_fecha}
end on

on w_gen_arch_impresor.destroy
destroy(this.dw_grado)
destroy(this.dw_consec)
destroy(this.lds_salida)
destroy(this.cb_1)
destroy(this.rb_tsu)
destroy(this.rb_mencion_posg)
destroy(this.rb_mencion_lic)
destroy(this.rb_duplicados)
destroy(this.gb_4)
destroy(this.gb_fechas_manual)
destroy(this.uo_relacion)
destroy(this.cbx_exa_gral_conoc)
destroy(this.cbx_codcompleto)
destroy(this.rb_rgs)
destroy(this.rb_posg)
destroy(this.rb_lic)
destroy(this.st_fecha_rgs)
destroy(this.st_fecha_posgrado)
destroy(this.st_fecha_lic)
destroy(this.cb_salir)
destroy(this.cb_generar)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.rb_manual)
destroy(this.rb_relacion)
destroy(this.dp_fecha_fin)
destroy(this.dp_fecha_ini)
destroy(this.st_fecha_fin)
destroy(this.st_fecha)
end on

event open;is_ventana = Message.stringparm
dw_1.settransobject( gtr_sce)
dw_consec.SetTransObject(gtr_sce)
dw_grado.SetTransObject(gtr_sce)

TriggerEvent("ue_obtener_fechas")
wf_pos_fechas_semana_prev (idt_fecha_hoy)

st_fecha_lic.text = String(idt_fecha_sig_mes, "DD/MM/YYYY")
st_fecha_posgrado.text = String(idt_fecha_sig_mes_posg, "DD/MM/YYYY")
st_fecha_rgs.text = String(idt_fecha_sig_mes_posg, "DD/MM/YYYY")

rb_lic.checked = True

ii_anio_proc_titulacion =f_obtiene_anio_proc_tit()
uo_relacion.of_carga_control( gtr_sce, ii_anio_proc_titulacion)
dw_grado.retrieve()
rb_manual.triggerevent("clicked")
end event

type dw_grado from datawindow within w_gen_arch_impresor
boolean visible = false
integer x = 1998
integer y = 208
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "dddw_grado_carr"
boolean resizable = true
boolean livescroll = true
end type

type dw_consec from datawindow within w_gen_arch_impresor
boolean visible = false
integer x = 2103
integer y = 368
integer width = 686
integer height = 400
integer taborder = 90
string title = "none"
string dataobject = "dddw_consecutivo_imp"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type lds_salida from datawindow within w_gen_arch_impresor
boolean visible = false
integer x = 160
integer y = 1960
integer width = 5303
integer height = 1772
integer taborder = 70
string title = "none"
boolean resizable = true
boolean livescroll = true
end type

type cb_1 from commandbutton within w_gen_arch_impresor
boolean visible = false
integer x = 1810
integer y = 1700
integer width = 402
integer height = 112
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "none"
end type

event clicked;uo_servicios_cadena_tit luo_servicios_cadena_tit 
luo_servicios_cadena_tit = CREATE uo_servicios_cadena_tit 

luo_servicios_cadena_tit.of_modifica_nombre( "JUAN DE DIOS BATIZ")
end event

type rb_tsu from radiobutton within w_gen_arch_impresor
integer x = 169
integer y = 1328
integer width = 1042
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Técnico Superior Universitario (TSU)"
end type

type rb_mencion_posg from radiobutton within w_gen_arch_impresor
integer x = 169
integer y = 1216
integer width = 617
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Menciones Posgrado"
end type

type rb_mencion_lic from radiobutton within w_gen_arch_impresor
integer x = 169
integer y = 1104
integer width = 686
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Menciones Licenciatura"
end type

type rb_duplicados from radiobutton within w_gen_arch_impresor
integer x = 174
integer y = 992
integer width = 398
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Duplicados"
end type

type gb_4 from groupbox within w_gen_arch_impresor
integer x = 119
integer y = 68
integer width = 905
integer height = 160
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
end type

type gb_fechas_manual from groupbox within w_gen_arch_impresor
integer x = 119
integer y = 256
integer width = 1115
integer height = 276
integer taborder = 80
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 12639424
string text = "Manual"
end type

type uo_relacion from uo_relacion_tit_2013 within w_gen_arch_impresor
integer x = 119
integer y = 228
integer taborder = 30
end type

on uo_relacion.destroy
call uo_relacion_tit_2013::destroy
end on

type cbx_exa_gral_conoc from checkbox within w_gen_arch_impresor
integer x = 951
integer y = 768
integer width = 786
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Sólo Exa Gral Conocimientos"
end type

type cbx_codcompleto from checkbox within w_gen_arch_impresor
boolean visible = false
integer x = 174
integer y = 1496
integer width = 535
integer height = 80
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Código Completo"
end type

type rb_rgs from radiobutton within w_gen_arch_impresor
integer x = 174
integer y = 880
integer width = 667
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Revalidación General"
end type

type rb_posg from radiobutton within w_gen_arch_impresor
integer x = 174
integer y = 768
integer width = 393
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Posgrado"
end type

type rb_lic from radiobutton within w_gen_arch_impresor
integer x = 174
integer y = 656
integer width = 416
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Licenciatura"
end type

type st_fecha_rgs from statictext within w_gen_arch_impresor
boolean visible = false
integer x = 1221
integer y = 860
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_fecha_posgrado from statictext within w_gen_arch_impresor
boolean visible = false
integer x = 1221
integer y = 736
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_fecha_lic from statictext within w_gen_arch_impresor
boolean visible = false
integer x = 1221
integer y = 612
integer width = 325
integer height = 72
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 67108864
boolean focusrectangle = false
end type

type cb_salir from commandbutton within w_gen_arch_impresor
integer x = 1193
integer y = 1708
integer width = 361
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Salir"
end type

event clicked;Close ( Parent )
end event

type cb_generar from commandbutton within w_gen_arch_impresor
integer x = 407
integer y = 1708
integer width = 361
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Generar"
end type

event clicked;string ls_fecha, ls_fecha_fin, ls_fecha_expedicion
integer li_rows, li_result1, li_cve_relacion 
LONG  li_i, ll_consecutivo, ll_consec,  ll_cuenta , ll_consec2
STRING ls_nivel, ls_cvegrado



IF rb_relacion.checked  Then
		dp_fecha_ini.value = datetime(uo_relacion.of_obtiene_fecha_ini( ))
		dp_fecha_fin.value = datetime(uo_relacion.of_obtiene_fecha_fin( ))
		li_cve_relacion = uo_relacion.of_obtiene_cve_relacion()
End If

// Licenciatura 
If rb_lic.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_lic_cod"
//	Else
		//dw_1.dataobject = "dw_gen_arch_imp_lic"
		dw_1.dataobject = "dw_gen_arch_imp_lic_2021"
//	End If
	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes),7,4) + mid(string(idt_fecha_sig_mes),4,2)  + mid(string(idt_fecha_sig_mes),1,2)	
	ls_nivel = "L"
End If

//TSU
If rb_tsu.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_tsu_cod"
//	Else
		//dw_1.dataobject = "dw_gen_arch_imp_tsu"
		dw_1.dataobject = "dw_gen_arch_imp_tsu_2021"
//	End If
	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes),7,4) + mid(string(idt_fecha_sig_mes),4,2)  + mid(string(idt_fecha_sig_mes),1,2)	
	ls_nivel = "T"
End If

//Posgrado 
If rb_posg.checked Then
//	If cbx_codcompleto.checked Then
//		If cbx_exa_gral_conoc.checked Then
//			dw_1.dataobject = "dw_gen_arch_imp_posg_cod_exg"
//		Else
//			dw_1.dataobject = "dw_gen_arch_imp_posg_cod"
//		End If
//	Else
		If cbx_exa_gral_conoc.checked Then
			dw_1.dataobject = "dw_gen_arch_imp_posg_exg_2021"
		Else
			dw_1.dataobject = "dw_gen_arch_imp_posg_2021"
		End If
//	End If
	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes_posg),7,4) + mid(string(idt_fecha_sig_mes_posg),4,2)  + mid(string(idt_fecha_sig_mes_posg),1,2)	
	ls_nivel = "P"
End If

// Revalidación General 
If rb_rgs.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_rgs_cod"
//	Else
		//dw_1.dataobject = "dw_gen_arch_imp_rgs"
		dw_1.dataobject = "dw_gen_arch_imp_rgs_2021"
//	End If
	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes_posg),7,4) + mid(string(idt_fecha_sig_mes_posg),4,2)  + mid(string(idt_fecha_sig_mes_posg),1,2)		
	ls_nivel = "R"
End If

If rb_duplicados.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_duplic_cod"
//	Else
		dw_1.dataobject = "dw_gen_arch_imp_duplic_2021"
//	End If
	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes_posg),7,4) + mid(string(idt_fecha_sig_mes_posg),4,2)  + mid(string(idt_fecha_sig_mes_posg),1,2)		
	ls_nivel = "D"
End If

If rb_mencion_lic.checked Then
	//dw_1.dataobject = "dw_gen_arch_imp_lic_mencion"
	dw_1.dataobject = "dw_gen_arch_imp_lic_mencion_2020"
	ls_nivel = "OL"
End If

If rb_mencion_posg.checked Then
	dw_1.dataobject = "dw_gen_arch_imp_posg_mencion_2020"
	ls_nivel = "OP"
End If

	
dw_1.settransobject( gtr_sce)
ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string(dp_fecha_fin.DateValue),1,2)
li_rows = dw_1.retrieve(ls_fecha, ls_fecha_fin, li_cve_relacion) //,ls_fecha_expedicion)

//*****************************************************************************

uo_servicios_cadena_tit luo_servicios_cadena_tit 
luo_servicios_cadena_tit = CREATE uo_servicios_cadena_tit 
STRING ls_cadena 
LONG ll_pos 
LONG ll_row 
DATASTORE lds_paso 
STRING ls_cuenta 
LONG ll_cve_carrera 
STRING ls_carrera 
INTEGER le_cve_plan

lds_paso = CREATE DATASTORE 
lds_paso.DATAOBJECT = "dw_correccion_nombres_titulo_imp"  

FOR ll_pos = 1 TO li_rows
	
	ls_cuenta = dw_1.GETITEMSTRING(ll_pos, "cuenta")  
	ll_cve_carrera = dw_1.GETITEMNUMBER(ll_pos, "cve_carrera")   
	ls_carrera = dw_1.GETITEMSTRING(ll_pos, "carrera") 	 
	le_cve_plan = dw_1.GETITEMNUMBER(ll_pos, "cve_plan") 	 
	
	ll_row = lds_paso.INSERTROW(0) 
	lds_paso.SETITEM(ll_row, "cuenta", ls_cuenta)
	lds_paso.SETITEM(ll_row, "cve_carrera", ll_cve_carrera) 
	lds_paso.SETITEM(ll_row, "carrera", ls_carrera)
	lds_paso.SETITEM(ll_row, "cve_plan", le_cve_plan)
	
	ls_cadena = dw_1.GETITEMSTRING(ll_pos, "nombre") 
	lds_paso.SETITEM(ll_row, "nombre_org", ls_cadena)
	ls_cadena = luo_servicios_cadena_tit.of_modifica_nombre(ls_cadena) 
	dw_1.SETITEM(ll_pos, "nombre", ls_cadena) 
	lds_paso.SETITEM(ll_row, "nombre", ls_cadena)	
	
	ls_cadena = dw_1.GETITEMSTRING(ll_pos, "apellido_pat") 
	lds_paso.SETITEM(ll_row, "a_paterno_org", ls_cadena)
	ls_cadena = luo_servicios_cadena_tit.of_modifica_nombre(ls_cadena) 
	dw_1.SETITEM(ll_pos, "apellido_pat", ls_cadena) 
	lds_paso.SETITEM(ll_row, "a_paterno", ls_cadena)	
	
	ls_cadena = dw_1.GETITEMSTRING(ll_pos, "apellido_mat") 
	lds_paso.SETITEM(ll_row, "a_materno_org", ls_cadena) 	 
	ls_cadena = luo_servicios_cadena_tit.of_modifica_nombre(ls_cadena) 
	dw_1.SETITEM(ll_pos, "apellido_mat", ls_cadena) 
	lds_paso.SETITEM(ll_row, "a_materno", ls_cadena) 				
	
	///////////////////////////////////////////////////
	
//CUENTA
//NOMBRE
//APELLIDO_PAT
//APELLIDO_MAT
//TITULO
//CARRERA
//FECHA_EXPEDICION
//PLANTEL
//RECTOR
//DIRECTOR_SERV_ESCOLARES
//CVE_CARRERA
//CVE_PLAN
	
	
	///////////////////////////////////////////////////

NEXT 

uo_parametros_corr_titulacion luo_parametros_corr_titulacion 
luo_parametros_corr_titulacion = CREATE uo_parametros_corr_titulacion 
luo_parametros_corr_titulacion.ids_paso = CREATE DATASTORE 
luo_parametros_corr_titulacion.ids_paso.DATAOBJECT = "dw_correccion_nombres_titulo_imp"  

lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, luo_parametros_corr_titulacion.ids_paso, 1, PRIMARY!)   

OPENWITHPARM(w_correccion_nombres_impresor, luo_parametros_corr_titulacion)   




STRING ls_nombre  , ls_fechaacu
STRING ls_apaterno 
STRING ls_amaterno
STRING ls_folio
STRING ls_curp
LONG ll_folio
STRING ls_N_TITULO
STRING LS_ACUERDO
DATETIME LDT_FECACUERDO
LONG ll_N_ACTA	
LONG ll_N_LIBRO
LONG ll_N_HOJA , ll_i , ll_opct
STRING ls_RECTOR
STRING ls_DIRECTOR_SERV_ESCOLARES
STRING LS_FECHA_ACUERDO,  ls_gradodes
DATETIME ldt_FECHA
DATETIME ldt_FECHA_EXPEDICION 
//STRING ls_FECHA
//STRING ls_FECHA_EXPEDICION 
STRING ls_TITULO, ls_PLANTEL
STRING ls_MENCION
STRING ls_RECONOCIMIENTO 
STRING ls_SEGURO, ls_SEXO 
Integer li_cadena , li_sep


//DATASTORE lds_salida 
//lds_salida = CREATE DATASTORE 
lds_salida.RESET() 
lds_salida.DATAOBJECT = dw_1.DATAOBJECT + "_sal"
lds_salida.SETTRANSOBJECT(gtr_sce)

// Se recupera de nuevo la información con los nombres modificados.
li_rows = dw_1.retrieve(ls_fecha, ls_fecha_fin, li_cve_relacion) //,ls_fecha_expedicion) 

 IF ls_nivel <> 'P'  and  ls_nivel <>  'D'  and  ls_nivel <> 'R' then

FOR ll_pos = 1 TO li_rows 
	  SETNULL(ldt_FECHA_EXPEDICION)
	  SETNULL(ldt_FECHA)
	  SETNULL(ldt_FECACUERDO)
       SETNULL(LS_FECHA_ACUERDO)
//       SETNULL(LS_FECHA_EXPEDICION)
		// Si no se trata de menciones 
	IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
		
		ls_cuenta = dw_1.GETITEMSTRING(ll_pos, "CUENTA")  
		ll_cve_carrera = dw_1.GETITEMNUMBER(ll_pos, "CVE_CARRERA")   
		ls_carrera = dw_1.GETITEMSTRING(ll_pos, "CARRERA") 	 
		le_cve_plan = dw_1.GETITEMNUMBER(ll_pos, "CVE_PLAN") 	 
		ls_nombre = dw_1.GETITEMSTRING(ll_pos, "NOMBRE") 
		ls_apaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_PAT") 
		ls_amaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_MAT") 
		ls_cvegrado = dw_1.GETITEMSTRING(ll_pos, "CVE_GRADO") 	
		ll_cuenta = dw_1.GETITEMNUMBER(ll_pos, "CVE_CUENTA")   
		li_sep = dw_1.GETITEMNUMBER(ll_pos, "SEP")   

		ls_nombre = ls_nombre +' '  + 	ls_apaterno + ' ' + ls_amaterno
		// En TSU no existe esta columna 
		IF ls_nivel <> "T" THEN 
			ls_TITULO = dw_1.GETITEMSTRING(ll_pos, "TITULO") 	
			ls_carrera = of_modifica_nombre(ls_carrera) 
			ls_carrera = ls_TITULO + ' ' + ls_carrera
		END IF 	
		
		IF LS_NIVEL = "L"  OR LS_NIVEL = "T" or  LS_NIVEL = "P"  OR LS_NIVEL = "R" THEN
		    ls_curp = dw_1.GETITEMSTRING(ll_pos, "CURP") 
		END IF
		ldt_FECHA = dw_1.GETITEMDATETIME(ll_pos, "FECHA") 	
		ldt_FECHA_EXPEDICION	 = dw_1.GETITEMDATETIME(ll_pos, "FECHA_EXPEDICION") 	
		ls_N_TITULO = dw_1.GETITEMSTRING(ll_pos, "Num_titulo") 	
		ll_N_ACTA = dw_1.GETITEMNUMBER(ll_pos, "N_ACTA") 	
		ll_N_LIBRO = dw_1.GETITEMNUMBER(ll_pos, "N_LIBRO") 	
		ll_N_HOJA = dw_1.GETITEMNUMBER(ll_pos, "N_HOJA") 	
		ls_PLANTEL = dw_1.GETITEMSTRING(ll_pos, "PLANTEL") 	
		ls_RECTOR = dw_1.GETITEMSTRING(ll_pos, "RECTOR") 	
		ls_DIRECTOR_SERV_ESCOLARES = dw_1.GETITEMSTRING(ll_pos, "DIRECTOR_SERV_ESCOLARES") 	
		ls_MENCION = dw_1.GETITEMSTRING(ll_pos, "MENCION") 	
		ls_RECONOCIMIENTO = dw_1.GETITEMSTRING(ll_pos, "RECONOCIMIENTO") 	
		ls_SEXO = dw_1.GETITEMSTRING(ll_pos, "SEXO") 	
		ls_SEGURO = dw_1.GETITEMSTRING(ll_pos, "SEGURO") 		 
//	    ll_folio = dw_1.GETITEMNUMBER(ll_pos, "FOLIO") 	
	li_sep = dw_1.GETITEMNUMBER(ll_pos, "SEP")   
				
	   IF ls_nivel = 'D'  OR  ls_nivel = 'R' THEN
				ls_ACUERDO = dw_1.GETITEMSTRING(ll_pos, "NUM_ACUERDO") 		 
	              lDT_FECACUERDO = dw_1.GETITEMDATETIME(ll_pos, "FECHA_ACUERDO") 	
			     ls_curp = dw_1.GETITEMSTRING(ll_pos, "CURP") 
		
				 if  not isnull (  lDT_FECACUERDO)   then
						ls_FECHA_ACUERDO = "Ciudad de México, a " + luo_servicios_cadena_tit.of_fecha_a_texto( lDT_FECACUERDO) 
				end if
	   END IF
	
		if  not isnull (ldt_FECHA)   then
	        ls_FECHA = luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA)
//		else
//		if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + ' no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return
//
		end if
		
	    if  not isnull (ldt_FECHA_EXPEDICION)   then
	        	ls_FECHA_EXPEDICION =   luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA_EXPEDICION) 
//		else
//			if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + ' no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return
		end if
	
		
	ELSE
		
		ls_cuenta = dw_1.GETITEMSTRING(ll_pos, "CUENTA")  
		ls_carrera = dw_1.GETITEMSTRING(ll_pos, "CARRERA") 	 
		ls_nombre = dw_1.GETITEMSTRING(ll_pos, "NOMBRE") 
		ls_apaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_PAT") 
		ls_amaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_MAT") 
		li_sep = dw_1.GETITEMNUMBER(ll_pos, "SEP")   
		ls_N_TITULO = dw_1.GETITEMSTRING(ll_pos, "Num_titulo") 
		
		if ls_nivel = 'OP' then
			ll_N_ACTA = dw_1.GETITEMNUMBER(ll_pos, "N_ACTA") 	
			ll_N_LIBRO = dw_1.GETITEMNUMBER(ll_pos, "N_LIBRO") 	
			ll_N_HOJA = dw_1.GETITEMNUMBER(ll_pos, "N_HOJA") 	
		End if

			ls_nombre = ls_nombre +' '  + 	ls_apaterno + ' ' + ls_amaterno
		// En TSU no existe esta columna 
		IF ls_nivel <> "T" THEN 
			ls_TITULO = dw_1.GETITEMSTRING(ll_pos, "TITULO") 	
			ls_carrera = of_modifica_nombre(ls_carrera) 
			ls_carrera = ls_TITULO + ' ' + ls_carrera
		END IF 	
		ldt_FECHA_EXPEDICION	 = dw_1.GETITEMDATETIME(ll_pos, "FECHA_EXPEDICION") 	
		ls_PLANTEL = dw_1.GETITEMSTRING(ll_pos, "PLANTEL") 	
		ls_RECTOR = dw_1.GETITEMSTRING(ll_pos, "RECTOR") 	
		ls_DIRECTOR_SERV_ESCOLARES = dw_1.GETITEMSTRING(ll_pos, "DIRECTOR_SERV_ESCOLARES") 	
		
//		IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
//		if  not isnull (ldt_FECHA)   then
//	        ls_FECHA = luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA)
//		else
//			if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + 'no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return
//		end if
//		end if
		
	    if  not isnull (ldt_FECHA_EXPEDICION)   then
	        	ls_FECHA_EXPEDICION =  luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA_EXPEDICION) 
//			else
//					if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + 'no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return
		end if
		
	END IF 	
	
		IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
		select consecutivo
		into :ll_consecutivo
		from consecutivo_impresor
		where cuenta = :ll_cuenta and
				 cve_carrera = :ll_cve_carrera and
				 cve_plan = :le_cve_plan
	   USING gtr_sce;
				 
if ll_consecutivo > 0 then
		ll_folio = ll_consecutivo
		else
			
			
		select max(consecutivo)
		into :ll_consec2
		from consecutivo_impresor
		USING gtr_sce;
		
		IF SQLCA.SQLCode = -1 Then
			 MessageBox( 'Aviso','Error al consultar la tabla [consecutivo_impresor], verifique' + SQLCA.SQLErrText )
			 Return 
		else
			if ll_consec2 > 0 then
				if ll_folio > 0 then
					ll_folio = ll_folio +1 
				else
				ll_folio =  ll_consec2 
				ll_folio = ll_folio +1 
				end if 
			else
				if  ll_folio < 1 then
				 ll_consec2 =  1
				 ll_folio =  ll_consec2
				else						  
//aqui va el incrementeo a mano  ll_consec = 19999				
				ll_folio = ll_folio + 1
				 end if 

			end if 
		 End If
		  	li_i = dw_consec.INSERTROW(0)  	
		
	    dw_consec.SETITEM(li_i , "cuenta",  ll_cuenta )
		dw_consec.SETITEM(li_i , "cve_plan",  le_cve_plan )
		dw_consec.SETITEM(li_i , "cve_carrera", ll_cve_carrera )
	    dw_consec.SETITEM(li_i , "consecutivo",ll_folio )
	    dw_consec.SETITEM(li_i , "nivel", ls_cvegrado )
	    dw_consec.SETITEM(li_i , "TIPO_ARCHIVO", ls_nivel )
	end if		
	
end if

//    ls_folio = string( ll_folio )
//	li_cadena = len(ls_folio)
	ls_folio = ( String(  ll_folio, fill( "0", 6 )+";"+fill( "0", 6 )+";00000;empty" ) )

	ll_row = lds_salida.INSERTROW(0)  	
	if li_sep = 0 then
	   lds_salida.SETITEM(ll_row, "Documento", "Plan Libre" )
	else
		  lds_salida.SETITEM(ll_row, "Documento", "Original" )
	End if
	// Si no se trata de menciones 
	IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
		ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 
		lds_salida.SETITEM(ll_row, "No", STRING(ll_row) + ".-")
//		lds_salida.SETITEM(ll_row, "Num_Cuenta", ls_cuenta)
		lds_salida.SETITEM(ll_row, "Nombre", ls_nombre)
//		lds_salida.SETITEM(ll_row, "Apellido_Paterno", ls_apaterno)
//		lds_salida.SETITEM(ll_row, "Apellido_Materno", ls_amaterno)
	    lds_salida.SETITEM(ll_row, "Carrera", ls_carrera)	
		lds_salida.SETITEM(ll_row, "Fecha_de_Expedición", ls_FECHA_EXPEDICION)	
		lds_salida.SETITEM(ll_row, "Num_titulo", ls_N_TITULO)	
		
	IF ls_nivel = "L" THEN 
//			lds_salida.SETITEM(ll_row, "Título", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 		
		    lds_salida.SETITEM(ll_row, "CURP", ls_curp )
			 lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
		ELSEIF ls_nivel = "P" THEN 	
//			lds_salida.SETITEM(ll_row, "Grado", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 
			  lds_salida.SETITEM(ll_row, "CURP", ls_curp )
			 lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
		ELSEIF ls_nivel = "E" THEN 	
			lds_salida.SETITEM(ll_row, "Diploma", ls_TITULO)	
		ELSEIF ls_nivel	= "T" THEN 
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 
			   lds_salida.SETITEM(ll_row, "CURP", ls_curp )
			 	lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
		ELSEIF ls_nivel = "R" THEN 	
		       lds_salida.SETITEM(ll_row, "CURP", ls_curp)
				lds_salida.SETITEM(ll_row, "NUM_ACUERDO", ls_ACUERDO)	
			    lds_salida.SETITEM(ll_row, "FECHA_ACUERDO", ls_FECHA_ACUERDO)
				lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 		
		ELSEIF ls_nivel = "D" THEN 	
			    lds_salida.SETITEM(ll_row, "CURP", ls_curp)
				lds_salida.SETITEM(ll_row, "NUM_ACUERDO", ls_ACUERDO)	
			    lds_salida.SETITEM(ll_row, "FECHA_ACUERDO", ls_FECHA_ACUERDO)
			    lds_salida.SETITEM(ll_row, "VALOR", 'Duplicado')
				lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
		END IF 	
		    lds_salida.SETITEM(ll_row, "Num_Cuenta", ls_cuenta)
	ELSE
		
		lds_salida.SETITEM(ll_row, "No", STRING(ll_row) + ".-")
		lds_salida.SETITEM(ll_row, "Num_Cuenta", ls_cuenta)
		lds_salida.SETITEM(ll_row, "Nombre", ls_nombre)
		
//		lds_salida.SETITEM(ll_row, "Num_titulo", ls_N_TITULO )
//		If ls_nivel = 'OP' Then
//			lds_salida.SETITEM(ll_row, "N_ACTA",  ll_N_ACTA )
//			lds_salida.SETITEM(ll_row, "N_LIBRO", ll_N_LIBRO )
//			lds_salida.SETITEM(ll_row, "N_HOJA",  ll_N_HOJA )
//		End if
		
//		lds_salida.SETITEM(ll_row, "Apellido_Paterno", ls_apaterno)
//		lds_salida.SETITEM(ll_row, "Apellido_Materno", ls_amaterno)
		IF ls_nivel = "OL" THEN 
//			lds_salida.SETITEM(ll_row, "Título", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 		
		ELSEIF ls_nivel = "OP" THEN 	
//			lds_salida.SETITEM(ll_row, "Grado", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 
		END IF 	
		lds_salida.SETITEM(ll_row, "Carrera", ls_carrera)	
		lds_salida.SETITEM(ll_row, "Fecha_de_Expedición", ls_FECHA_EXPEDICION)	
		lds_salida.SETITEM(ll_row, "Plantel", ls_PLANTEL)	
		lds_salida.SETITEM(ll_row, "Rector", ls_RECTOR)	
		lds_salida.SETITEM(ll_row, "Dir_de_Servicios_Escolares", ls_DIRECTOR_SERV_ESCOLARES)	
		
	END IF 
	
																			
	
	

NEXT 

//*****************************************************************************  


If ll_row > 0 Then
	
	
	 If dw_consec.Update() = 1 Then
//		Commit USING SQLCA; // Ok. se confirma el guardado de los 2 DWs
	  Commit   USING gtr_sce;
		Else
				
		Rollback  USING gtr_sce; // Hubo algún error, se cancela el guardado en los DWs
		 MessageBox( 'Aviso','Error al  guardar el consecutivo en la tabla [consecutivo_impresor], verifique' + SQLCA.SQLErrText )
		  Return 
	End If
	//li_result1 = dw_1.saveas( "", dBASE3!, True)
	li_result1 = lds_salida.saveas( "", Excel!, True)
	If li_result1 = 1 Then MessageBox("Mensaje del Sistema", "Archivo generado de manera satisfactoria")
Else
	MessageBox('Mensaje del Sistema', 'No existe información para generar el archivo solicitado')	
End If
else
dw_1.SetFilter("")
dw_1.Filter()
// aqui la parte de los archivos divididos
For ll_i = 1 to dw_grado.rowcount()
	 ls_cvegrado = dw_grado.object.cve_grado[ll_i]
	 ls_gradodes = dw_grado.object.grado[ll_i]
	
dw_1.SetFilter("cve_grado = '"+ 	 ls_cvegrado + "'")
dw_1.Filter()
li_rows  = dw_1.rowcount()
 lds_salida.reset()
 
 IF ls_nivel = 'D' THEN
	if  ls_cvegrado = 'L' then
		 lds_salida.dataobject = "dw_gen_arch_imp_lic_2021_sal"
          lds_salida.settransobject( gtr_sce)
	else
		 lds_salida.dataobject = "dw_gen_arch_imp_posg_2021_sal"
          lds_salida.settransobject( gtr_sce)
	end if
 End if
 
if li_rows  < 1 then continue
FOR ll_pos = 1 TO li_rows 
	  SETNULL(ldt_FECHA_EXPEDICION)
	  SETNULL(ldt_FECHA)
	  SETNULL(ldt_FECACUERDO)
       SETNULL(LS_FECHA_ACUERDO)
//       SETNULL(LS_FECHA_EXPEDICION)
		// Si no se trata de menciones 
	IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
		
		ls_cuenta = dw_1.GETITEMSTRING(ll_pos, "CUENTA")  
		ll_cve_carrera = dw_1.GETITEMNUMBER(ll_pos, "CVE_CARRERA")   
		ls_carrera = dw_1.GETITEMSTRING(ll_pos, "CARRERA") 	 
		le_cve_plan = dw_1.GETITEMNUMBER(ll_pos, "CVE_PLAN") 	 
		ls_nombre = dw_1.GETITEMSTRING(ll_pos, "NOMBRE") 
		ls_apaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_PAT") 
		ls_amaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_MAT") 
		ls_cvegrado = dw_1.GETITEMSTRING(ll_pos, "CVE_GRADO") 	
		ll_cuenta = dw_1.GETITEMNUMBER(ll_pos, "CVE_CUENTA")   
		li_sep = dw_1.GETITEMNUMBER(ll_pos, "SEP")   
		
		ls_nombre = ls_nombre +' '  + 	ls_apaterno + ' ' + ls_amaterno
		// En TSU no existe esta columna 
		IF ls_nivel <> "T" THEN 
			ls_TITULO = dw_1.GETITEMSTRING(ll_pos, "TITULO") 
		END IF 	
		
		IF ls_nivel <> "P" THEN 
			ls_carrera = of_modifica_nombre(ls_carrera) 
			ls_carrera = ls_TITULO + ' ' + ls_carrera
		end if 
		 
		IF ls_nivel = "P" THEN 
			ls_carrera = of_modifica_nombre(ls_carrera) 
		end if 
		
		IF LS_NIVEL = "L"  OR LS_NIVEL = "T" or  LS_NIVEL = "P"  OR LS_NIVEL = "R" THEN
		    ls_curp = dw_1.GETITEMSTRING(ll_pos, "CURP") 
		END IF
		ldt_FECHA = dw_1.GETITEMDATETIME(ll_pos, "FECHA") 	
		ldt_FECHA_EXPEDICION	 = dw_1.GETITEMDATETIME(ll_pos, "FECHA_EXPEDICION") 	
		ls_N_TITULO = dw_1.GETITEMSTRING(ll_pos, "Num_titulo") 	
		ll_N_ACTA = dw_1.GETITEMNUMBER(ll_pos, "N_ACTA") 	
		ll_N_LIBRO = dw_1.GETITEMNUMBER(ll_pos, "N_LIBRO") 	
		ll_N_HOJA = dw_1.GETITEMNUMBER(ll_pos, "N_HOJA") 	
		ls_PLANTEL = dw_1.GETITEMSTRING(ll_pos, "PLANTEL") 	
		ls_RECTOR = dw_1.GETITEMSTRING(ll_pos, "RECTOR") 	
		ls_DIRECTOR_SERV_ESCOLARES = dw_1.GETITEMSTRING(ll_pos, "DIRECTOR_SERV_ESCOLARES") 	
		ls_MENCION = dw_1.GETITEMSTRING(ll_pos, "MENCION") 	
		ls_RECONOCIMIENTO = dw_1.GETITEMSTRING(ll_pos, "RECONOCIMIENTO") 	
		ls_SEXO = dw_1.GETITEMSTRING(ll_pos, "SEXO") 	
		ls_SEGURO = dw_1.GETITEMSTRING(ll_pos, "SEGURO") 		 
//	    ll_folio = dw_1.GETITEMNUMBER(ll_pos, "FOLIO") 	
				
	  If ls_nivel = 'D' and 	 ls_cvegrado <> 'L' THEN
			ll_opct = dw_1.GETITEMNUMBER(ll_pos, "cve_titulacion")   
	  End if
	  
	    If ls_nivel = 'R'  THEN
			ll_opct = dw_1.GETITEMNUMBER(ll_pos, "cve_titulacion")   
	  End if
	  
	   IF ls_nivel = 'D'  OR  ls_nivel = 'R' THEN
//				ls_ACUERDO = dw_1.GETITEMSTRING(ll_pos, "NUM_ACUERDO") 		 
//	              lDT_FECACUERDO = dw_1.GETITEMDATETIME(ll_pos, "FECHA_ACUERDO") 	
			     ls_curp = dw_1.GETITEMSTRING(ll_pos, "CURP") 
		
//				 if  not isnull (  lDT_FECACUERDO)   then
//						ls_FECHA_ACUERDO = "Ciudad de México, a " +  luo_servicios_cadena_tit.of_fecha_a_texto( lDT_FECACUERDO) 
//				end if
	   END IF
	
		if  not isnull (ldt_FECHA)   then
	        ls_FECHA = luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA)
//		else
//		if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + ' no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return

		end if
		
	    if  not isnull (ldt_FECHA_EXPEDICION)   then
	        	ls_FECHA_EXPEDICION =  luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA_EXPEDICION) 
//		else
//			if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + ' no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return
		end if
	
		
	ELSE
		
		ls_cuenta = dw_1.GETITEMSTRING(ll_pos, "CUENTA")  
		ls_carrera = dw_1.GETITEMSTRING(ll_pos, "CARRERA") 	 
		ls_nombre = dw_1.GETITEMSTRING(ll_pos, "NOMBRE") 
		ls_apaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_PAT") 
		ls_amaterno = dw_1.GETITEMSTRING(ll_pos, "APELLIDO_MAT") 
		li_sep = dw_1.GETITEMNUMBER(ll_pos, "SEP")   
			ls_nombre = ls_nombre +' '  + 	ls_apaterno + ' ' + ls_amaterno
		// En TSU no existe esta columna 
		IF ls_nivel <> "T" THEN 
			ls_TITULO = dw_1.GETITEMSTRING(ll_pos, "TITULO") 	
			ls_carrera = ls_TITULO + ' ' + ls_carrera
		END IF 	
		ldt_FECHA_EXPEDICION	 = dw_1.GETITEMDATETIME(ll_pos, "FECHA_EXPEDICION") 	
		ls_PLANTEL = dw_1.GETITEMSTRING(ll_pos, "PLANTEL") 	
		ls_RECTOR = dw_1.GETITEMSTRING(ll_pos, "RECTOR") 	
		ls_DIRECTOR_SERV_ESCOLARES = dw_1.GETITEMSTRING(ll_pos, "DIRECTOR_SERV_ESCOLARES") 	
		
//		IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
		if  not isnull (ldt_FECHA)   then
	        ls_FECHA = luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA)
//		else
//			if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + 'no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return
		end if
//		end if
		
	    if  not isnull (ldt_FECHA_EXPEDICION)   then
	        	ls_FECHA_EXPEDICION = luo_servicios_cadena_tit.of_fecha_a_texto(ldt_FECHA_EXPEDICION) 
//			else
//					if MessageBox ( 'Mensaje del Sistema', 'La cuenta ' + ls_cuenta + 'no tiene fecha de expediciòn, Desea Continuar? ' , Question! , YesNoCancel! , 1  ) <> 1 then return
		end if
		
	END IF 	
	
		IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
		select consecutivo
		into :ll_consecutivo
		from consecutivo_impresor
		where cuenta = :ll_cuenta and
				 cve_carrera = :ll_cve_carrera and
				 cve_plan = :le_cve_plan
	   USING gtr_sce;
				 
if ll_consecutivo > 0 then
		ll_folio = ll_consecutivo
		else
			
			
		select max(consecutivo)
		into :ll_consec2
		from consecutivo_impresor
		USING gtr_sce;
		
		IF SQLCA.SQLCode = -1 Then
			 MessageBox( 'Aviso','Error al consultar la tabla [consecutivo_impresor], verifique' + SQLCA.SQLErrText )
			 Return 
		else
			if ll_consec2 > 0 then
				if ll_folio > 0 then
					ll_folio = ll_folio +1 
				else
				ll_folio =  ll_consec2 
				ll_folio = ll_folio +1 
				end if 
			else
				if  ll_folio < 1 then
				 ll_consec2 =  794
				 ll_folio =  ll_consec2
				else						  
//aqui va el incrementeo a mano  ll_consec = 19999				
				ll_folio = ll_folio + 1
				 end if 

			end if 
		 End If
		  	li_i = dw_consec.INSERTROW(0)  	
		
	    dw_consec.SETITEM(li_i , "cuenta",  ll_cuenta )
		dw_consec.SETITEM(li_i , "cve_plan",  le_cve_plan )
		dw_consec.SETITEM(li_i , "cve_carrera", ll_cve_carrera )
	    dw_consec.SETITEM(li_i , "consecutivo",ll_folio )
	    dw_consec.SETITEM(li_i , "nivel", ls_cvegrado )
	    dw_consec.SETITEM(li_i , "TIPO_ARCHIVO", ls_nivel )
	end if		
	
end if

//    ls_folio = string( ll_folio )
//	li_cadena = len(ls_folio)
	ls_folio = ( String(  ll_folio, fill( "0", 6 )+";"+fill( "0", 6 )+";00000;empty" ) )

	ll_row = lds_salida.INSERTROW(0)  	
	if  ls_nivel <> 'D' then
			if li_sep = 0 then
				lds_salida.SETITEM(ll_row, "Documento", "Plan Libre" )
			else
				  lds_salida.SETITEM(ll_row, "Documento", "Original" )
			End if
	end if
	// Si no se trata de menciones 
	IF ls_nivel <> "OL" AND ls_nivel <> "OP" THEN 
		
		lds_salida.SETITEM(ll_row, "No", STRING(ll_row) + ".-")
//		lds_salida.SETITEM(ll_row, "Num_Cuenta", ls_cuenta)
		lds_salida.SETITEM(ll_row, "Nombre", ls_nombre)
//		lds_salida.SETITEM(ll_row, "Apellido_Paterno", ls_apaterno)
//		lds_salida.SETITEM(ll_row, "Apellido_Materno", ls_amaterno)
	    lds_salida.SETITEM(ll_row, "Carrera", ls_carrera)	
		lds_salida.SETITEM(ll_row, "Fecha_de_Expedición", ls_FECHA_EXPEDICION)	
		lds_salida.SETITEM(ll_row, "Num_titulo", ls_N_TITULO)	
		
	IF ls_nivel = "L" THEN 
//			lds_salida.SETITEM(ll_row, "Título", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 		
		    lds_salida.SETITEM(ll_row, "CURP", ls_curp )
			 lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
		ELSEIF ls_nivel = "P" THEN 	
//			lds_salida.SETITEM(ll_row, "Grado", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 
				lds_salida.SETITEM(ll_row, "Num_titulo", ls_N_TITULO )
				if 	li_sep = 1 then
				lds_salida.SETITEM(ll_row, "N_ACTA",  ll_N_ACTA )
				lds_salida.SETITEM(ll_row, "N_LIBRO", ll_N_LIBRO )
				lds_salida.SETITEM(ll_row, "N_HOJA",  ll_N_HOJA )
				end if 
			  lds_salida.SETITEM(ll_row, "CURP", ls_curp )
			 lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
			 lds_salida.SETITEM(ll_row, "Fecha_de_Examen", 	   ls_FECHA)
		
		ELSEIF ls_nivel = "E" THEN 	
			lds_salida.SETITEM(ll_row, "Diploma", ls_TITULO)	
		ELSEIF ls_nivel	= "T" THEN 
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 
			   lds_salida.SETITEM(ll_row, "CURP", ls_curp )
			 	lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
		ELSEIF ls_nivel = "R" THEN 	
				select num_acuerdo  ,
        				 fecha_acuerdo
			into :ls_acuerdo , :ls_fechaacu
				from  opc_titulacion
				where cve_titulacion = 	:ll_opct  using(gtr_sce); 
			 
		       lds_salida.SETITEM(ll_row, "CURP", ls_curp)
				lds_salida.SETITEM(ll_row, "NUM_ACUERDO", ls_acuerdo)	
			    lds_salida.SETITEM(ll_row, "FECHA_ACUERDO", ls_fechaacu)
				lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 		
					setnull( ls_fechaacu )
				setnull( ls_acuerdo )
		ELSEIF ls_nivel = "D" THEN 	
			
			select num_acuerdo  ,
        				 fecha_acuerdo
			into :ls_acuerdo , :ls_fechaacu
				from  opc_titulacion
				where cve_titulacion = 	:ll_opct  using(gtr_sce); 
			 
			    lds_salida.SETITEM(ll_row, "CURP", ls_curp)
				 if  ls_cvegrado <> 'L' then
				lds_salida.SETITEM(ll_row, "NUM_ACUERDO",ls_acuerdo)	
			    lds_salida.SETITEM(ll_row, "FECHA_ACUERDO",ls_fechaacu)
			    lds_salida.SETITEM(ll_row, "Documento", 'Duplicado')
				lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
				setnull( ls_fechaacu )
				setnull( ls_acuerdo )
				else
						lds_salida.SETITEM(ll_row, "Folio", 	ls_folio)
						   lds_salida.SETITEM(ll_row, "Documento", 'Duplicado')
				end if
		END IF 	
		    lds_salida.SETITEM(ll_row, "Num_Cuenta", ls_cuenta)
	ELSE
		
		lds_salida.SETITEM(ll_row, "No", STRING(ll_row) + ".-")
		lds_salida.SETITEM(ll_row, "Num_Cuenta", ls_cuenta)
		lds_salida.SETITEM(ll_row, "Nombre", ls_nombre)
//		lds_salida.SETITEM(ll_row, "Apellido_Paterno", ls_apaterno)
//		lds_salida.SETITEM(ll_row, "Apellido_Materno", ls_amaterno)
		IF ls_nivel = "OL" THEN 
			lds_salida.SETITEM(ll_row, "Título", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 		
		ELSEIF ls_nivel = "OP" THEN 	
			lds_salida.SETITEM(ll_row, "Grado", ls_TITULO)	
			ls_carrera = luo_servicios_cadena_tit.of_modifica_carrera(ls_carrera) 
		END IF
		
			IF ls_nivel <> "T" THEN 
			ls_TITULO = dw_1.GETITEMSTRING(ll_pos, "TITULO") 	
			ls_carrera = ls_TITULO + ' ' + ls_carrera
		END IF 	
		
		lds_salida.SETITEM(ll_row, "Carrera", ls_carrera)	
		lds_salida.SETITEM(ll_row, "Fecha_de_Expedición", ls_FECHA_EXPEDICION)	
		lds_salida.SETITEM(ll_row, "Plantel", ls_PLANTEL)	
		lds_salida.SETITEM(ll_row, "Rector", ls_RECTOR)	
		lds_salida.SETITEM(ll_row, "Dir_de_Servicios_Escolares", ls_DIRECTOR_SERV_ESCOLARES)	
		
	END IF 
	
																			
	
	

NEXT 

//*****************************************************************************  


If ll_row > 0 Then
	
	
	 If dw_consec.Update() = 1 Then
//		Commit USING SQLCA; // Ok. se confirma el guardado de los 2 DWs
	  Commit   USING gtr_sce;
		Else
				
		Rollback  USING gtr_sce; // Hubo algún error, se cancela el guardado en los DWs
		 MessageBox( 'Aviso','Error al  guardar el consecutivo en la tabla [consecutivo_impresor], verifique' + SQLCA.SQLErrText )
		  Return 
	End If
	MessageBox("Mensaje del Sistema", "El Archivo por Generar es Sobre el Grado " + ls_gradodes  )
	//li_result1 = dw_1.saveas( "", dBASE3!, True)
	li_result1 = lds_salida.saveas( "", Excel!, True)
	If li_result1 = 1 Then MessageBox("Mensaje del Sistema", "Archivo generado de manera satisfactoria")
Else
	MessageBox('Mensaje del Sistema', 'No existe información para generar el archivo solicitado')	
End If

Next

End if 
return 0





//
//

//
//
////CUENTA 
////NOMBRE
////APELLIDO_PAT
////APELLIDO_MAT
//STRING ls_titulo 
////CARRERA
////FECHA
////FECHA_EXPEDICION
////N_TITULO
////N_ACTA
////N_LIBRO
////N_HOJA
////PLANTEL
////RECTOR
////DIRECTOR_SERV_ESCOLARES
////MENCION
////RECONOCIMIENTO
////SEXO
////SEGURO
//






// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 
// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 
// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 




//string ls_fecha, ls_fecha_fin, ls_fecha_expedicion
//integer li_rows, li_result1, li_cve_relacion
//
//IF rb_relacion.checked  Then
//		dp_fecha_ini.value = datetime(uo_relacion.of_obtiene_fecha_ini( ))
//		dp_fecha_fin.value = datetime(uo_relacion.of_obtiene_fecha_fin( ))
//		li_cve_relacion = uo_relacion.of_obtiene_cve_relacion()
//End If
//
//// Licenciatura 
//If rb_lic.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_lic_cod"
//	Else
//		//dw_1.dataobject = "dw_gen_arch_imp_lic"
//		dw_1.dataobject = "dw_gen_arch_imp_lic_2020"
//	End If
//	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes),7,4) + mid(string(idt_fecha_sig_mes),4,2)  + mid(string(idt_fecha_sig_mes),1,2)	
//End If
//
////TSU
//If rb_tsu.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_tsu_cod"
//	Else
//		dw_1.dataobject = "dw_gen_arch_imp_tsu"
//	End If
//	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes),7,4) + mid(string(idt_fecha_sig_mes),4,2)  + mid(string(idt_fecha_sig_mes),1,2)	
//End If
//
////Posgrado 
//If rb_posg.checked Then
//	If cbx_codcompleto.checked Then
//		If cbx_exa_gral_conoc.checked Then
//			dw_1.dataobject = "dw_gen_arch_imp_posg_cod_exg"
//		Else
//			dw_1.dataobject = "dw_gen_arch_imp_posg_cod"
//		End If
//	Else
//		If cbx_exa_gral_conoc.checked Then
//			dw_1.dataobject = "dw_gen_arch_imp_posg_exg"
//		Else
//			dw_1.dataobject = "dw_gen_arch_imp_posg"
//		End If
//	End If
//	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes_posg),7,4) + mid(string(idt_fecha_sig_mes_posg),4,2)  + mid(string(idt_fecha_sig_mes_posg),1,2)	
//End If
//
//// Revalidación General 
//If rb_rgs.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_rgs_cod"
//	Else
//		dw_1.dataobject = "dw_gen_arch_imp_rgs"
//	End If
//	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes_posg),7,4) + mid(string(idt_fecha_sig_mes_posg),4,2)  + mid(string(idt_fecha_sig_mes_posg),1,2)		
//End If
//
//If rb_duplicados.checked Then
//	If cbx_codcompleto.checked Then
//		dw_1.dataobject = "dw_gen_arch_imp_duplic_cod"
//	Else
//		dw_1.dataobject = "dw_gen_arch_imp_duplic"
//	End If
//	ls_fecha_expedicion = mid(string(idt_fecha_sig_mes_posg),7,4) + mid(string(idt_fecha_sig_mes_posg),4,2)  + mid(string(idt_fecha_sig_mes_posg),1,2)		
//End If
//
//If rb_mencion_lic.checked Then
//	dw_1.dataobject = "dw_gen_arch_imp_lic_mencion"
//End If
//
//If rb_mencion_posg.checked Then
//	dw_1.dataobject = "dw_gen_arch_imp_posg_mencion"
//End If
//
//	
//dw_1.settransobject( gtr_sce)
//ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
//ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string(dp_fecha_fin.DateValue),1,2)
//li_rows = dw_1.retrieve(ls_fecha, ls_fecha_fin, li_cve_relacion) //,ls_fecha_expedicion)
//
////*****************************************************************************
//
//uo_servicios_cadena_tit luo_servicios_cadena_tit 
//luo_servicios_cadena_tit = CREATE uo_servicios_cadena_tit 
//STRING ls_cadena 
//LONG ll_pos 
//LONG ll_row 
//DATASTORE lds_paso 
//STRING ls_cuenta 
//LONG ll_cve_carrera 
//STRING ls_carrera 
//INTEGER le_cve_plan
//
//lds_paso = CREATE DATASTORE 
//lds_paso.DATAOBJECT = "dw_correccion_nombres_titulo_imp"  
//
//FOR ll_pos = 1 TO li_rows
//	
//	ls_cuenta = dw_1.GETITEMSTRING(ll_pos, "cuenta")  
//	ll_cve_carrera = dw_1.GETITEMNUMBER(ll_pos, "cve_carrera")   
//	ls_carrera = dw_1.GETITEMSTRING(ll_pos, "carrera") 	 
//	le_cve_plan = dw_1.GETITEMNUMBER(ll_pos, "cve_plan") 	 
//	
//	ll_row = lds_paso.INSERTROW(0) 
//	lds_paso.SETITEM(ll_row, "cuenta", ls_cuenta)
//	lds_paso.SETITEM(ll_row, "cve_carrera", ll_cve_carrera) 
//	lds_paso.SETITEM(ll_row, "carrera", ls_carrera)
//	lds_paso.SETITEM(ll_row, "cve_plan", le_cve_plan)
//	
//	ls_cadena = dw_1.GETITEMSTRING(ll_pos, "nombre") 
//	lds_paso.SETITEM(ll_row, "nombre_org", ls_cadena)
//	ls_cadena = luo_servicios_cadena_tit.of_modifica_nombre(ls_cadena) 
//	dw_1.SETITEM(ll_pos, "nombre", ls_cadena) 
//	lds_paso.SETITEM(ll_row, "nombre", ls_cadena)	
//	
//	ls_cadena = dw_1.GETITEMSTRING(ll_pos, "apellido_pat") 
//	lds_paso.SETITEM(ll_row, "a_paterno_org", ls_cadena)
//	ls_cadena = luo_servicios_cadena_tit.of_modifica_nombre(ls_cadena) 
//	dw_1.SETITEM(ll_pos, "apellido_pat", ls_cadena) 
//	lds_paso.SETITEM(ll_row, "a_paterno", ls_cadena)	
//	
//	ls_cadena = dw_1.GETITEMSTRING(ll_pos, "apellido_mat") 
//	ls_cadena = luo_servicios_cadena_tit.of_modifica_nombre(ls_cadena) 
//	dw_1.SETITEM(ll_pos, "apellido_mat", ls_cadena) 
//	lds_paso.SETITEM(ll_row, "a_materno", ls_cadena) 				
//	lds_paso.SETITEM(ll_row, "a_materno_org", ls_cadena) 	 
//
//NEXT 
//
//uo_parametros_corr_titulacion luo_parametros_corr_titulacion 
//luo_parametros_corr_titulacion = CREATE uo_parametros_corr_titulacion 
//luo_parametros_corr_titulacion.ids_paso = CREATE DATASTORE 
//luo_parametros_corr_titulacion.ids_paso.DATAOBJECT = "dw_correccion_nombres_titulo_imp"  
//
//lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, luo_parametros_corr_titulacion.ids_paso, 1, PRIMARY!)   
//
//OPENWITHPARM(w_correccion_nombres_impresor, luo_parametros_corr_titulacion)   
//
//// Se recupera de nuevo la información con los nombres modificados.
//li_rows = dw_1.retrieve(ls_fecha, ls_fecha_fin, li_cve_relacion) //,ls_fecha_expedicion) 
//
//
//STRING ls_nombre 
//STRING ls_apaterno 
//STRING ls_amaterno 
//
//DATASTORE lds_salida 
//lds_salida = CREATE DATASTORE 
//lds_salida.DATAOBJECT = ""
//
//
//FOR ll_pos = 1 TO li_rows 
//	
//	ls_cuenta = dw_1.GETITEMSTRING(ll_pos, "n_cuenta")  
//	ll_cve_carrera = dw_1.GETITEMNUMBER(ll_pos, "id_carrera")   
//	ls_carrera = dw_1.GETITEMSTRING(ll_pos, "des_carrera") 	 
//	le_cve_plan = dw_1.GETITEMNUMBER(ll_pos, "cve_plan") 	 
//	ls_nombre = dw_1.GETITEMSTRING(ll_pos, "nombres") 
//	ls_apaterno = dw_1.GETITEMSTRING(ll_pos, "a_pat") 
//	ls_amaterno = dw_1.GETITEMSTRING(ll_pos, "a_mat") 
//
////	ll_row = lds_salida.INSERTROW(0)  	
////	lds_salida.SETITEM(ll_row, "cuenta", )
////	lds_salida.SETITEM(ll_row, "nombre", )
////	lds_salida.SETITEM(ll_row, "apellido_pat", )
////	lds_salida.SETITEM(ll_row, "apellido_mat", )
////	lds_salida.SETITEM(ll_row, "titulo", )	
////	lds_salida.SETITEM(ll_row, "carrera", )	
////	lds_salida.SETITEM(ll_row, "fecha", )	
////	lds_salida.SETITEM(ll_row, "fecha_expedicion", )	
////	lds_salida.SETITEM(ll_row, "n_titulov", )	
////	lds_salida.SETITEM(ll_row, "n_acta", )	
////	lds_salida.SETITEM(ll_row, "n_libro", )	
////	lds_salida.SETITEM(ll_row, "n_hoja", )	
////	lds_salida.SETITEM(ll_row, "plantel", )	
////	lds_salida.SETITEM(ll_row, "rector", )	
////	lds_salida.SETITEM(ll_row, "director_serv_escolares", )	
////	lds_salida.SETITEM(ll_row, "mencion", )	
////	lds_salida.SETITEM(ll_row, "reconocimieto", )	
////	lds_salida.SETITEM(ll_row, "sexo", )	
////	lds_salida.SETITEM(ll_row, "seguro", ) 	
//	
//	
//NEXT 
//
//
//
//
//
//
////*****************************************************************************  
//
//
//If li_rows > 0 Then
//	//li_result1 = dw_1.saveas( "", dBASE3!, True)
//	li_result1 = dw_1.saveas( "", Excel!, True)
//	If li_result1 = 1 Then MessageBox("Mensaje del Sistema", "Archivo generado de manera satisfactoria")
//Else
//	MessageBox('Mensaje del Sistema', 'No existe información para generar el archivo solicitado')	
//End If
//
//return 0
//
//
//
//
//
////
////
//
////
////
//////CUENTA 
//////NOMBRE
//////APELLIDO_PAT
//////APELLIDO_MAT
////STRING ls_titulo 
//////CARRERA
//////FECHA
//////FECHA_EXPEDICION
//////N_TITULO
//////N_ACTA
//////N_LIBRO
//////N_HOJA
//////PLANTEL
//////RECTOR
//////DIRECTOR_SERV_ESCOLARES
//////MENCION
//////RECONOCIMIENTO
//////SEXO
//////SEGURO
////
//
//
//
//
//
//
end event

type dw_1 from datawindow within w_gen_arch_impresor
boolean visible = false
integer x = 3173
integer y = 1392
integer width = 887
integer height = 500
boolean bringtotop = true
string title = "none"
string dataobject = "dw_gen_arch_imp_lic"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_2 from groupbox within w_gen_arch_impresor
integer x = 119
integer y = 564
integer width = 1687
integer height = 896
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 553648127
string text = "Archivo"
end type

type gb_1 from groupbox within w_gen_arch_impresor
integer x = 64
integer y = 36
integer width = 1842
integer height = 1596
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
end type

type rb_manual from radiobutton within w_gen_arch_impresor
integer x = 146
integer y = 120
integer width = 325
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Manual"
boolean checked = true
end type

event clicked;uo_relacion.visible = False
uo_relacion.bringtotop = False
gb_fechas_manual.visible = True
dp_fecha_ini.visible = True
dp_fecha_fin.visible = True
st_fecha.visible = True
st_fecha_fin.visible = True
uo_relacion.visible = False

gb_fechas_manual.bringtoTop = True
dp_fecha_ini.bringtoTop = True
dp_fecha_fin.bringtoTop = True
st_fecha.bringtoTop = True
st_fecha_fin.bringtoTop = True
end event

type rb_relacion from radiobutton within w_gen_arch_impresor
integer x = 498
integer y = 120
integer width = 407
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Por Relación"
end type

event clicked;gb_fechas_manual.visible = False
dp_fecha_ini.visible = False
dp_fecha_fin.visible = False
st_fecha.visible = False
st_fecha_fin.visible = False
uo_relacion.visible = True
uo_relacion.bringtotop = True


end event

type dp_fecha_fin from datepicker within w_gen_arch_impresor
integer x = 709
integer y = 400
integer width = 457
integer height = 100
integer taborder = 40
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-01-14"), Time("09:32:18.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;If dp_fecha_ini.datevalue > dp_fecha_fin.datevalue Then
	MessageBox('Mensaje del Sistema', 'La fecha final no puede ser menor a la fecha inicial')
	dp_fecha_fin.setvalue( Datetime(dp_fecha_ini.datevalue))
	return -1
End If
end event

type dp_fecha_ini from datepicker within w_gen_arch_impresor
integer x = 165
integer y = 400
integer width = 457
integer height = 100
integer taborder = 10
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2022-01-14"), Time("09:32:18.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

event valuechanged;If dp_fecha_ini.datevalue > dp_fecha_fin.datevalue Then
	MessageBox('Mensaje del Sistema', 'La fecha inicial no puede ser mayor a la fecha final')
	dp_fecha_ini.setvalue( Datetime(dp_fecha_fin.datevalue))
	return -1
End If
end event

type st_fecha_fin from statictext within w_gen_arch_impresor
integer x = 709
integer y = 312
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha Fin"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_gen_arch_impresor
integer x = 165
integer y = 312
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
string text = "Fecha Inicio"
boolean focusrectangle = false
end type

