$PBExportHeader$w_rep_tit_lic_impresor.srw
forward
global type w_rep_tit_lic_impresor from w_master_main_rep
end type
type gb_2 from groupbox within w_rep_tit_lic_impresor
end type
type gb_fechas_manual from groupbox within w_rep_tit_lic_impresor
end type
type cbx_exa_gral_conoc from checkbox within w_rep_tit_lic_impresor
end type
type cb_exportar from commandbutton within w_rep_tit_lic_impresor
end type
type cb_salir from commandbutton within w_rep_tit_lic_impresor
end type
type st_fecha_expedicion from statictext within w_rep_tit_lic_impresor
end type
type rb_doctorado from radiobutton within w_rep_tit_lic_impresor
end type
type rb_maestria from radiobutton within w_rep_tit_lic_impresor
end type
type dp_fecha_exped from datepicker within w_rep_tit_lic_impresor
end type
type mc_1 from monthcalendar within w_rep_tit_lic_impresor
end type
type cb_2 from commandbutton within w_rep_tit_lic_impresor
end type
type cb_consultar from commandbutton within w_rep_tit_lic_impresor
end type
type dw_1 from datawindow within w_rep_tit_lic_impresor
end type
type uo_relacion from uo_relacion_tit_2013 within w_rep_tit_lic_impresor
end type
type gb_grado from groupbox within w_rep_tit_lic_impresor
end type
type gb_1 from groupbox within w_rep_tit_lic_impresor
end type
type st_fecha from statictext within w_rep_tit_lic_impresor
end type
type st_fecha_fin from statictext within w_rep_tit_lic_impresor
end type
type dw_tipo_doc_duplic from datawindow within w_rep_tit_lic_impresor
end type
type st_1 from statictext within w_rep_tit_lic_impresor
end type
type em_anio from editmask within w_rep_tit_lic_impresor
end type
type rb_manual from radiobutton within w_rep_tit_lic_impresor
end type
type rb_relacion from radiobutton within w_rep_tit_lic_impresor
end type
type gb_tipo_doc from groupbox within w_rep_tit_lic_impresor
end type
type gb_4 from groupbox within w_rep_tit_lic_impresor
end type
type dp_fecha_ini from datepicker within w_rep_tit_lic_impresor
end type
type dp_fecha_fin from datepicker within w_rep_tit_lic_impresor
end type
type cbx_mencion_lic from checkbox within w_rep_tit_lic_impresor
end type
end forward

global type w_rep_tit_lic_impresor from w_master_main_rep
integer width = 5271
integer height = 2440
string title = "Untitled"
boolean resizable = true
string icon = "AppIcon!"
boolean center = true
event ue_obtener_fechas ( )
event ue_obtener_fecha_sem_ant ( )
gb_2 gb_2
gb_fechas_manual gb_fechas_manual
cbx_exa_gral_conoc cbx_exa_gral_conoc
cb_exportar cb_exportar
cb_salir cb_salir
st_fecha_expedicion st_fecha_expedicion
rb_doctorado rb_doctorado
rb_maestria rb_maestria
dp_fecha_exped dp_fecha_exped
mc_1 mc_1
cb_2 cb_2
cb_consultar cb_consultar
dw_1 dw_1
uo_relacion uo_relacion
gb_grado gb_grado
gb_1 gb_1
st_fecha st_fecha
st_fecha_fin st_fecha_fin
dw_tipo_doc_duplic dw_tipo_doc_duplic
st_1 st_1
em_anio em_anio
rb_manual rb_manual
rb_relacion rb_relacion
gb_tipo_doc gb_tipo_doc
gb_4 gb_4
dp_fecha_ini dp_fecha_ini
dp_fecha_fin dp_fecha_fin
cbx_mencion_lic cbx_mencion_lic
end type
global w_rep_tit_lic_impresor w_rep_tit_lic_impresor

type variables
string is_ventana, is_nom_ventana, is_grado
Datetime idt_fecha_hoy, idt_fecha_sig_mes, idt_fecha_sig_posg
Integer ii_anio_proc_titulacion, ii_cve_documento  , gi_year


end variables

forward prototypes
public function integer wf_pos_fechas_semana_prev (datetime ar_fecha)
public function integer wf_actualiza_fec_expedicion ()
public function integer wf_valida_relacion_duplicados (integer ar_cve_tipo_relacion, integer ar_tipo_documento)
public function integer wf_fecha_libre (integer tipo_rel)
end prototypes

event ue_obtener_fechas();SELECT getdate() as fecha_hoy,  fecha_primera_siguiente_mes,  fecha_posgrado 
	INTO : idt_fecha_hoy, :idt_fecha_sig_mes, :idt_fecha_sig_posg
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

ldt_fecha = Datetime(dp_fecha_exped.DateValue)

//ii_resp = Messagebox("¡ Confirmar !", "¿Desea actualizar la información?",Question!,YesNo!,1)
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

public function integer wf_valida_relacion_duplicados (integer ar_cve_tipo_relacion, integer ar_tipo_documento);
If (ar_cve_tipo_relacion = 1 And ar_tipo_documento <> 80) Or (ar_cve_tipo_relacion = 5 And ar_tipo_documento <> 81) Or &
   (ar_cve_tipo_relacion = 6 And ar_tipo_documento <> 82) Or (ar_cve_tipo_relacion = 9 And ar_tipo_documento <> 84) Then
	MessageBox('Alerta del Sistema', 'El tipo de documento seleccionado no corresponde con el tipo de la relación elegida...', StopSign!)
	return -1
End If


return 0
end function

public function integer wf_fecha_libre (integer tipo_rel);integer li_valores 

uo_relacion.il_filtro_tipo_relacion = tipo_rel
if   uo_relacion.of_carga_control(  gtr_sce , ii_anio_proc_titulacion) = 0 then
return 1
else
return 0
end if 



end function

on w_rep_tit_lic_impresor.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_fechas_manual=create gb_fechas_manual
this.cbx_exa_gral_conoc=create cbx_exa_gral_conoc
this.cb_exportar=create cb_exportar
this.cb_salir=create cb_salir
this.st_fecha_expedicion=create st_fecha_expedicion
this.rb_doctorado=create rb_doctorado
this.rb_maestria=create rb_maestria
this.dp_fecha_exped=create dp_fecha_exped
this.mc_1=create mc_1
this.cb_2=create cb_2
this.cb_consultar=create cb_consultar
this.dw_1=create dw_1
this.uo_relacion=create uo_relacion
this.gb_grado=create gb_grado
this.gb_1=create gb_1
this.st_fecha=create st_fecha
this.st_fecha_fin=create st_fecha_fin
this.dw_tipo_doc_duplic=create dw_tipo_doc_duplic
this.st_1=create st_1
this.em_anio=create em_anio
this.rb_manual=create rb_manual
this.rb_relacion=create rb_relacion
this.gb_tipo_doc=create gb_tipo_doc
this.gb_4=create gb_4
this.dp_fecha_ini=create dp_fecha_ini
this.dp_fecha_fin=create dp_fecha_fin
this.cbx_mencion_lic=create cbx_mencion_lic
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_fechas_manual
this.Control[iCurrent+3]=this.cbx_exa_gral_conoc
this.Control[iCurrent+4]=this.cb_exportar
this.Control[iCurrent+5]=this.cb_salir
this.Control[iCurrent+6]=this.st_fecha_expedicion
this.Control[iCurrent+7]=this.rb_doctorado
this.Control[iCurrent+8]=this.rb_maestria
this.Control[iCurrent+9]=this.dp_fecha_exped
this.Control[iCurrent+10]=this.mc_1
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.cb_consultar
this.Control[iCurrent+13]=this.dw_1
this.Control[iCurrent+14]=this.uo_relacion
this.Control[iCurrent+15]=this.gb_grado
this.Control[iCurrent+16]=this.gb_1
this.Control[iCurrent+17]=this.st_fecha
this.Control[iCurrent+18]=this.st_fecha_fin
this.Control[iCurrent+19]=this.dw_tipo_doc_duplic
this.Control[iCurrent+20]=this.st_1
this.Control[iCurrent+21]=this.em_anio
this.Control[iCurrent+22]=this.rb_manual
this.Control[iCurrent+23]=this.rb_relacion
this.Control[iCurrent+24]=this.gb_tipo_doc
this.Control[iCurrent+25]=this.gb_4
this.Control[iCurrent+26]=this.dp_fecha_ini
this.Control[iCurrent+27]=this.dp_fecha_fin
this.Control[iCurrent+28]=this.cbx_mencion_lic
end on

on w_rep_tit_lic_impresor.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_fechas_manual)
destroy(this.cbx_exa_gral_conoc)
destroy(this.cb_exportar)
destroy(this.cb_salir)
destroy(this.st_fecha_expedicion)
destroy(this.rb_doctorado)
destroy(this.rb_maestria)
destroy(this.dp_fecha_exped)
destroy(this.mc_1)
destroy(this.cb_2)
destroy(this.cb_consultar)
destroy(this.dw_1)
destroy(this.uo_relacion)
destroy(this.gb_grado)
destroy(this.gb_1)
destroy(this.st_fecha)
destroy(this.st_fecha_fin)
destroy(this.dw_tipo_doc_duplic)
destroy(this.st_1)
destroy(this.em_anio)
destroy(this.rb_manual)
destroy(this.rb_relacion)
destroy(this.gb_tipo_doc)
destroy(this.gb_4)
destroy(this.dp_fecha_ini)
destroy(this.dp_fecha_fin)
destroy(this.cbx_mencion_lic)
end on

event open;is_ventana = Message.stringparm
dw_1.settransobject( gtr_sce)

TriggerEvent("ue_obtener_fechas")
wf_pos_fechas_semana_prev (idt_fecha_hoy)

ii_anio_proc_titulacion =f_obtiene_anio_proc_tit()
gi_year = ii_anio_proc_titulacion 

choose case is_ventana
	case 'LIC_IMP' 
		dw_1.dataobject = "dw_rep_titulos_lic_impresor"
		is_nom_ventana = "Reporte de Títulos de Licenciatura"
		st_fecha.text = "Fecha Inicio"
		//dp_fecha_ini.visible = True
		st_fecha_expedicion.visible = False
		cbx_mencion_lic.visible = True
		gb_grado.visible = False
		rb_maestria.visible = False
		rb_doctorado.visible = False
		//dp_fecha_fin.visible = True
		dp_fecha_exped.visible = False
		dp_fecha_exped.setvalue(idt_fecha_sig_mes)		
		cbx_exa_gral_conoc.visible = False
		uo_relacion.il_filtro_tipo_relacion = 1
	case 'TSU' 
		dw_1.dataobject = "dw_rep_titulos_tsu_impresor"
		is_nom_ventana = "Reporte de Títulos de Técnico Superior Universitario (TSU)"
		st_fecha.text = "Fecha Inicio"
		//dp_fecha_ini.visible = True
		st_fecha_expedicion.visible = False
		cbx_mencion_lic.visible = False
		gb_grado.visible = False
		rb_maestria.visible = False
		rb_doctorado.visible = False
		//dp_fecha_fin.visible = True
		dp_fecha_exped.visible = False
		dp_fecha_exped.setvalue(idt_fecha_sig_mes)		
		cbx_exa_gral_conoc.visible = False
		uo_relacion.il_filtro_tipo_relacion = 9
	case 'POS_TIT'
		dw_1.dataobject = "dw_rep_titulos_posg_imp"
		is_nom_ventana = "Reporte de Títulos de Posgrado"
		//dp_fecha_ini.visible = True
		st_fecha_expedicion.visible = False
		st_fecha.text = "Fecha Inicio"
		cbx_mencion_lic.visible = False
		gb_grado.visible = True
		rb_maestria.visible = True
		rb_doctorado.visible = True
		rb_maestria.checked = True
		is_grado = 'M'
		//dp_fecha_fin.visible = True
		dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		cbx_exa_gral_conoc.visible = True
		uo_relacion.il_filtro_tipo_relacion = 5		
	case 'POS_RGS'
		dw_1.dataobject = "dw_rep_titulos_rgs"
		is_nom_ventana = "Reporte de Títulos de Revalidación General"
		//dp_fecha_ini.visible = True
		st_fecha_expedicion.visible = False
		st_fecha.text = "Fecha Inicio"
		cbx_mencion_lic.visible = False
		gb_grado.visible = False
		rb_maestria.visible = False
		rb_doctorado.visible = False
		rb_maestria.checked = False
		//dp_fecha_fin.visible = True
		dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		cbx_exa_gral_conoc.visible = False
	case 'POS_EXA' 
		dw_1.dataobject = "dw_rep_rel_exam_posgrado"
		is_nom_ventana = "Reporte de Relación de Examenes Posgrado"
		st_fecha.text = "Fecha Inicio"
		st_fecha_expedicion.visible = False
		dp_fecha_exped.visible = False
		cbx_mencion_lic.visible = False
		gb_grado.visible = False
		rb_maestria.visible = False
		rb_doctorado.visible = False
		dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		cbx_exa_gral_conoc.visible = False
		uo_relacion.visible = False
		dp_fecha_ini.visible = True
		dp_fecha_fin.visible = True
		st_fecha.visible = True
		st_fecha_fin.visible = True
		gb_2.visible = True
		gb_1.bringtotop = False
		gb_2.bringtotop = True		
		dp_fecha_ini.bringtotop = True
		dp_fecha_fin.bringtotop = True
		st_fecha.bringtotop = True
		st_fecha_fin.bringtotop = True
		dp_fecha_ini.enabled = True
		dp_fecha_fin.enabled = True
	case 'POS_DIP'
		dw_1.dataobject = "dw_rep_diplomas_imp"
		is_nom_ventana = "Reporte de Diplomas de Posgrado"
		//dp_fecha_ini.visible = True
		st_fecha.text = "Fecha Expedición"
		st_fecha_expedicion.visible = False
		cbx_mencion_lic.visible = False
		gb_grado.visible = True
		rb_maestria.visible = True
		rb_doctorado.visible = True
		rb_maestria.checked = True
		is_grado = 'M'
		//dp_fecha_fin.visible = True
		dp_fecha_exped.visible = False
		dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		cbx_exa_gral_conoc.visible = True
	case 'POS_ESP'
		dw_1.dataobject = "dw_rep_titulos_posg_imp"
		is_nom_ventana = "Reporte de Títulos de Especialización"
		//dp_fecha_ini.visible = True
		st_fecha.text = "Fecha Expedición"
		st_fecha_expedicion.visible = False
		cbx_mencion_lic.visible = False
		gb_grado.visible = False
		rb_maestria.visible = False
		rb_doctorado.visible = False
		is_grado = 'E'
		//dp_fecha_fin.visible = True
		dp_fecha_exped.visible = False
		dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		cbx_exa_gral_conoc.checked = False
		cbx_exa_gral_conoc.visible = False
	case 'TIT_DUP'
		dw_1.dataobject = "dw_rep_titulos_duplicados"
		is_nom_ventana = "Reporte de Títulos Duplicados"
		//dp_fecha_ini.visible = True
		st_fecha_expedicion.visible = False
		st_fecha.text = "Fecha Inicio"
		cbx_mencion_lic.visible = False
		gb_grado.visible = False
		rb_maestria.visible = False
		rb_doctorado.visible = False
		rb_maestria.checked = False
		//dp_fecha_fin.visible = True
		dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		cbx_exa_gral_conoc.visible = False
		dw_tipo_doc_duplic.settransobject(gtr_sce)
		dw_tipo_doc_duplic.retrieve( )
		gb_tipo_doc.visible = true
		gb_tipo_doc.bringtotop = True
		dw_tipo_doc_duplic.enabled = true
		dw_tipo_doc_duplic.visible = true
		dw_tipo_doc_duplic.bringtotop = True
	case 'POS_MEN', 'LIC_MEN'
		If is_ventana = 'POS_MEN' Then
			dw_1.dataobject = "dw_rep_menciones_posg_imp"
			is_nom_ventana = "Reporte de Menciones de Posgrado"
			gb_grado.visible = True
			rb_maestria.visible = True
			rb_doctorado.visible = True
			rb_maestria.checked = True
			is_grado = 'M'
			if wf_fecha_libre(8) = 1 then
			  uo_relacion.il_filtro_tipo_relacion = 8
			  	dp_fecha_ini.visible = false
				dp_fecha_fin.visible = false
				gb_fechas_manual.visible = false
				st_fecha.visible = false
				st_fecha_fin.visible = false
				rb_relacion.checked = true
				rb_manual.checked = false
			else
				gb_4.visible = True
				rb_manual.visible = True
				rb_relacion.visible = True
				uo_relacion.visible = false
				
				dp_fecha_ini.visible = True
				dp_fecha_fin.visible = True
				gb_fechas_manual.visible = True
			     st_fecha.visible = true
				st_fecha_fin.visible = true
			    rb_relacion.checked = false
				rb_manual.checked = true
				gb_fechas_manual.bringtoTop = True
				dp_fecha_ini.bringtoTop = True
				dp_fecha_fin.bringtoTop = True
				st_fecha.bringtoTop = True
				st_fecha_fin.bringtoTop = True
			end if
		Else
			dw_1.dataobject = "dw_rep_menciones_lic_imp"
			is_nom_ventana = "Reporte de Menciones de Licenciatura"
			gb_grado.visible = False
			rb_maestria.visible = False
			rb_doctorado.visible = False
			rb_maestria.checked = False
			if wf_fecha_libre(7)  = 1 then
		     	uo_relacion.il_filtro_tipo_relacion = 7
				 dp_fecha_ini.visible = false
				dp_fecha_fin.visible = false
				gb_fechas_manual.visible = false
				st_fecha.visible = false
				st_fecha_fin.visible = false
				rb_relacion.checked = true
				rb_manual.checked = false
				
			
		     else
				gb_4.visible = True
				rb_manual.visible = True
				rb_relacion.visible = True
			    uo_relacion.visible = false
				 
				dp_fecha_ini.visible = True
				dp_fecha_fin.visible = True
				gb_fechas_manual.visible = True
			     st_fecha.visible = true
				st_fecha_fin.visible = true
				rb_relacion.checked = false
				rb_manual.checked = true
				gb_fechas_manual.bringtoTop = True
				dp_fecha_ini.bringtoTop = True
				dp_fecha_fin.bringtoTop = True
				st_fecha.bringtoTop = True
				st_fecha_fin.bringtoTop = True
			end if
		End If
		st_fecha_expedicion.visible = False
		st_fecha.text = "Fecha Inicio"
		cbx_mencion_lic.visible = False

		If is_ventana = 'POS_MEN' Then
			dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		Else
			dp_fecha_exped.setvalue(idt_fecha_sig_mes)
		End If
		cbx_exa_gral_conoc.visible = False
		
case 'LIC_ARC' 
		dw_1.dataobject = "dw_rep_titulos_lic_archivo"
		is_nom_ventana = "Reporte de Títulos de Licenciatura para Archivo"
		st_fecha.text = "Fecha Inicio"
		st_fecha_expedicion.visible = False
		cbx_mencion_lic.visible = False
		gb_grado.visible = False
		rb_maestria.visible = False
		rb_doctorado.visible = False
		dp_fecha_exped.visible = False
		dp_fecha_exped.setvalue(idt_fecha_sig_mes)		
		cbx_exa_gral_conoc.visible = False
		uo_relacion.il_filtro_tipo_relacion = 1		
end choose

This.title = is_nom_ventana

ii_anio_proc_titulacion =f_obtiene_anio_proc_tit()
em_anio.TEXT = STRING(ii_anio_proc_titulacion) 

if  is_ventana  <>  'POS_MEN'  then 
	if   is_ventana  <>  'LIC_MEN'   then
     uo_relacion.of_carga_control( gtr_sce, ii_anio_proc_titulacion)
	  end if
end if	  

end event

type st_sistema from w_master_main_rep`st_sistema within w_rep_tit_lic_impresor
end type

type p_ibero from w_master_main_rep`p_ibero within w_rep_tit_lic_impresor
end type

type gb_2 from groupbox within w_rep_tit_lic_impresor
boolean visible = false
integer x = 128
integer y = 332
integer width = 1623
integer height = 212
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
end type

type gb_fechas_manual from groupbox within w_rep_tit_lic_impresor
boolean visible = false
integer x = 101
integer y = 340
integer width = 1655
integer height = 208
integer taborder = 90
integer textsize = -9
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 12639424
string text = "Manual"
end type

type cbx_exa_gral_conoc from checkbox within w_rep_tit_lic_impresor
integer x = 2542
integer y = 456
integer width = 837
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Sólo Exa Gral Conocimientos"
end type

type cb_exportar from commandbutton within w_rep_tit_lic_impresor
integer x = 4192
integer y = 484
integer width = 352
integer height = 96
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Exportar"
end type

event clicked;If dw_1.rowcount( ) > 0 Then
	dw_1.saveas( "", Excel!, True)	
Else
	MessageBox('Mensaje del Sistema', 'No existe información en el reporte para exportar')
End If
end event

type cb_salir from commandbutton within w_rep_tit_lic_impresor
integer x = 4571
integer y = 484
integer width = 352
integer height = 96
integer taborder = 90
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

type st_fecha_expedicion from statictext within w_rep_tit_lic_impresor
boolean visible = false
integer x = 2789
integer y = 280
integer width = 475
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Expedición"
boolean focusrectangle = false
end type

type rb_doctorado from radiobutton within w_rep_tit_lic_impresor
integer x = 2158
integer y = 452
integer width = 352
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Doctorado"
end type

event clicked;is_grado = 'D'
Parent.title = is_nom_ventana
cb_consultar.event clicked( )
end event

type rb_maestria from radiobutton within w_rep_tit_lic_impresor
integer x = 1806
integer y = 452
integer width = 329
integer height = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "Maestría"
end type

event clicked;is_grado = 'M'
Parent.title = is_nom_ventana
cb_consultar.event clicked( )
end event

type dp_fecha_exped from datepicker within w_rep_tit_lic_impresor
boolean visible = false
integer x = 2793
integer y = 356
integer width = 457
integer height = 100
integer taborder = 130
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-11-04"), Time("14:35:45.000000"))
integer textsize = -10
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
integer calendarfontweight = 400
boolean todaysection = true
boolean todaycircle = true
end type

type mc_1 from monthcalendar within w_rep_tit_lic_impresor
boolean visible = false
integer x = 1751
integer y = 500
integer width = 1006
integer height = 760
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long titletextcolor = 134217742
long trailingtextcolor = 134217745
long monthbackcolor = 1073741824
long titlebackcolor = 134217741
integer maxselectcount = 31
integer scrollrate = 1
boolean todaysection = true
boolean todaycircle = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_rep_tit_lic_impresor
integer x = 3813
integer y = 484
integer width = 352
integer height = 96
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Imprimir"
end type

event clicked;string ls_fecha_envio, ls_fecha
DataStore Ds_reporte_direct
long	ll_result

If dw_1.rowcount( ) > 0 Then
	choose case is_ventana
		case 'LIC_IMP' 
			If 	cbx_mencion_lic.checked Then
				dw_1.Object.Datawindow.zoom = 90
			Else
				dw_1.Object.Datawindow.zoom = 85
			End If
		case 'POS_TIT', 'POS_RGS', 'POS_EXA', 'POS_DIP', 'POS_ESP', 'TIT_DUP'
			dw_1.Object.Datawindow.zoom = 85
		case 'TSU', 'LIC_ARC'
			dw_1.Object.Datawindow.zoom = 90
	end choose

//	If is_ventana = 'POS_RGS' Then
//		ll_result = wf_actualiza_fec_expedicion ()
//		If ll_result = 0 Then
//				If 	dw_1.print( ) = -1 Then
//					MessageBox('Error del Sistema', 'Error al imprimir el documento')
//					return -1
//				End If
//		End If
//	Else
		PrintSetup();
		If 	dw_1.print() = -1 Then
			MessageBox('Error del Sistema', 'Error al imprimir el documento')
			return -1
		End If

		dw_1.Object.Datawindow.zoom = 100
//	End If
	
	/*Impresión de la hoja adicional a la relación de titulos con la información de los directivos*/
	If is_ventana = 'POS_TIT' Or  is_ventana = 'POS_RGS' Or is_ventana = 'POS_ESP' Then
		Ds_reporte_direct = Create DataStore
		Ds_reporte_direct.dataobject = "dw_rep_titulos_direct_posg"
		Ds_reporte_direct.settransobject( gtr_sce)
		
		ls_fecha = mid(string(dp_fecha_exped.DateValue),7,4) + mid(string(dp_fecha_exped.DateValue),4,2)  + mid(string(dp_fecha_exped.DateValue),1,2)		
		If is_ventana = 'POS_RGS' Then
			Ds_reporte_direct.retrieve(ls_fecha, 'R')
		Else
			Ds_reporte_direct.retrieve(ls_fecha, is_grado)			
		End If

		Ds_reporte_direct.Object.Datawindow.zoom = 85
	
		If 	Ds_reporte_direct.print( ) = -1 Then
			MessageBox('Error del Sistema', 'Error al imprimir el documento (Hoja Adicional de Relación de Titulos)')
		End If
		
		Ds_reporte_direct.Object.Datawindow.zoom = 100
	End IF
	
	//If is_ventana = 'POS_RGS' OR is_ventana = 'POS_TIT' Then ll_result = wf_actualiza_fec_expedicion ()

Else
	MessageBox('Mensaje del Sistema', 'No existe información en el reporte para imprimir')
End If
end event

type cb_consultar from commandbutton within w_rep_tit_lic_impresor
integer x = 3433
integer y = 484
integer width = 352
integer height = 96
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "&Consultar"
end type

event clicked;string ls_fecha, ls_fecha_fin, ls_fecha_expedicion
integer li_cve_relacion, li_cve_tipo_relacion, li_result

IF is_ventana <> 'POS_EXA'  Then
	if is_ventana  = 'POS_MEN' or is_ventana  =  'LIC_MEN' then
	    if rb_relacion.checked = true then
		dp_fecha_ini.value = datetime(uo_relacion.of_obtiene_fecha_ini( ))
		dp_fecha_fin.value = datetime(uo_relacion.of_obtiene_fecha_fin( ))
		li_cve_relacion = uo_relacion.of_obtiene_cve_relacion()
	  end if
	else
		dp_fecha_ini.value = datetime(uo_relacion.of_obtiene_fecha_ini( ))
		dp_fecha_fin.value = datetime(uo_relacion.of_obtiene_fecha_fin( ))
		li_cve_relacion = uo_relacion.of_obtiene_cve_relacion()
	end if
End If

//DateValue = uo_relacion.of_obtiene_fecha_ini( )
//dp_fecha_fin.DateValue = uo_relacion.of_obtiene_fecha_fin( )

choose case is_ventana
	case 'LIC_IMP' 
		If 	cbx_mencion_lic.checked Then
			dw_1.dataobject = "dw_rep_menc_honor_lic_imp"
			dw_1.settransobject( gtr_sce)
		Else
			dw_1.dataobject = "dw_rep_titulos_lic_impresor"
			dw_1.settransobject( gtr_sce)
		End If
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string( dp_fecha_fin.DateValue),1,2)				
		dw_1.retrieve(ls_fecha,ls_fecha_fin,li_cve_relacion)
	case 'TSU' 
		dw_1.dataobject = "dw_rep_titulos_tsu_impresor"
		dw_1.settransobject( gtr_sce)
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string( dp_fecha_fin.DateValue),1,2)				
		dw_1.retrieve(ls_fecha,ls_fecha_fin,li_cve_relacion)
	case 'POS_TIT', 'POS_ESP'
		ls_fecha_expedicion = mid(String(dp_fecha_exped.DateValue),7,4) + mid(String(dp_fecha_exped.DateValue),4,2)  + mid(String(dp_fecha_exped.DateValue),1,2)		
		If cbx_exa_gral_conoc.checked Then 
			dw_1.dataobject = "dw_rep_titulos_posg_imp_exg"
		Else
			dw_1.dataobject = "dw_rep_titulos_posg_imp"
		End If

		dw_1.settransobject( gtr_sce)
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string( dp_fecha_fin.DateValue),1,2)				
		dw_1.retrieve(ls_fecha, ls_fecha_fin, is_grado,li_cve_relacion)		
	case 'POS_RGS'
		ls_fecha_expedicion = mid(String(dp_fecha_exped.DateValue),7,4) + mid(String(dp_fecha_exped.DateValue),4,2)  + mid(String(dp_fecha_exped.DateValue),1,2)		
		dw_1.dataobject = "dw_rep_titulos_rgs"
		dw_1.settransobject( gtr_sce)
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string( dp_fecha_fin.DateValue),1,2)				
		dw_1.retrieve(ls_fecha, ls_fecha_fin,li_cve_relacion)		
	case 'POS_EXA' 
		dw_1.dataobject = "dw_rep_rel_exam_posgrado"
		dw_1.settransobject( gtr_sce)
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)		
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string(dp_fecha_fin.DateValue),1,2)		
		dw_1.retrieve(ls_fecha, ls_fecha_fin)
	case 'POS_DIP'
		If cbx_exa_gral_conoc.checked Then 		
			dw_1.dataobject = "dw_rep_diplomas_imp_exg"
		Else
			dw_1.dataobject = "dw_rep_diplomas_imp"
			//li_incorporado_sep = 1
		End If
		dw_1.settransobject( gtr_sce)
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)	
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string(dp_fecha_fin.DateValue),1,2)				
		dw_1.retrieve(ls_fecha, ls_fecha_fin, is_grado, li_cve_relacion)	
		
	case 'POS_MEN', 'LIC_MEN'
		ls_fecha_expedicion = mid(String(dp_fecha_exped.DateValue),7,4) + mid(String(dp_fecha_exped.DateValue),4,2)  + mid(String(dp_fecha_exped.DateValue),1,2)		
		If is_ventana = 'POS_MEN' Then
			dw_1.dataobject = "dw_rep_menciones_posg_imp"
		Else
			dw_1.dataobject = "dw_rep_menciones_lic_imp"
		End If
		dw_1.settransobject( gtr_sce)
		
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string( dp_fecha_fin.DateValue),1,2)				
		
		If is_ventana = 'POS_MEN' Then
			dw_1.retrieve(ls_fecha, ls_fecha_fin, is_grado,li_cve_relacion)		
		Else
			dw_1.retrieve(ls_fecha, ls_fecha_fin)	
//			dw_1.retrieve(ls_fecha, ls_fecha_fin, li_cve_relacion)	
		End If

	case 'TIT_DUP'
		li_cve_tipo_relacion = uo_relacion.of_obtiene_tipo_relacion( )
		li_result = wf_valida_relacion_duplicados(li_cve_tipo_relacion, ii_cve_documento)
		If li_result = 0 Then
			dw_1.dataobject = "dw_rep_titulos_duplicados"
			dw_1.settransobject( gtr_sce)
			ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)	
			ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string(dp_fecha_fin.DateValue),1,2)				
			dw_1.retrieve(ls_fecha, ls_fecha_fin, li_cve_relacion, ii_cve_documento)
		Else
			Return -1
		End If
		
	case 'LIC_ARC' 
		dw_1.dataobject = "dw_rep_titulos_lic_archivo"
		dw_1.settransobject( gtr_sce)
		ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
		ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string( dp_fecha_fin.DateValue),1,2)				
		dw_1.retrieve(ls_fecha,ls_fecha_fin,li_cve_relacion)		
end choose
end event

type dw_1 from datawindow within w_rep_tit_lic_impresor
integer x = 96
integer y = 648
integer width = 4859
integer height = 1704
integer taborder = 20
string title = "none"
string dataobject = "dw_rep_titulos_lic_impresor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_relacion from uo_relacion_tit_2013 within w_rep_tit_lic_impresor
integer x = 123
integer y = 336
integer taborder = 70
boolean bringtotop = true
end type

on uo_relacion.destroy
call uo_relacion_tit_2013::destroy
end on

type gb_grado from groupbox within w_rep_tit_lic_impresor
integer x = 1765
integer y = 336
integer width = 768
integer height = 252
integer taborder = 110
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Grado"
end type

type gb_1 from groupbox within w_rep_tit_lic_impresor
integer x = 91
integer y = 288
integer width = 4869
integer height = 332
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
end type

type st_fecha from statictext within w_rep_tit_lic_impresor
boolean visible = false
integer x = 142
integer y = 408
integer width = 352
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "Fecha Inicio"
boolean focusrectangle = false
end type

type st_fecha_fin from statictext within w_rep_tit_lic_impresor
boolean visible = false
integer x = 960
integer y = 408
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
boolean enabled = false
string text = "Fecha Fin"
boolean focusrectangle = false
end type

type dw_tipo_doc_duplic from datawindow within w_rep_tit_lic_impresor
boolean visible = false
integer x = 1504
integer y = 448
integer width = 1541
integer height = 88
integer taborder = 20
boolean bringtotop = true
string title = "none"
string dataobject = "dddw_doc_tit_duplic"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;If row > 0 then
	ii_cve_documento = integer(data)
End If
end event

event retrieveend;If rowcount > 0 And This.getrow() > 0 then
	ii_cve_documento = This.getitemnumber(This.getrow(), "cve_documento")
End If
end event

type st_1 from statictext within w_rep_tit_lic_impresor
integer x = 3401
integer y = 376
integer width = 713
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12639424
string text = "Cambiar año de Relación: "
boolean focusrectangle = false
end type

type em_anio from editmask within w_rep_tit_lic_impresor
integer x = 4133
integer y = 364
integer width = 402
integer height = 92
integer taborder = 140
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
string mask = "####"
string minmax = "~~"
end type

event modified;
INTEGER le_anio

le_anio = INTEGER(em_anio.TEXT) 


// Se verifica que sea un año válido 
IF le_anio <= 1900 OR le_anio > YEAR(today()) THEN 
	MESSAGEBOX("", "El año seleccionado no es válido.") 
	em_anio.TEXT = STRING(ii_anio_proc_titulacion)  
END IF 	

// Se recuperan las relaciones del año seleccionado.
ii_anio_proc_titulacion = le_anio 
gi_year = le_anio 

	
if is_ventana = 'POS_MEN' then
	 uo_relacion.il_filtro_tipo_relacion = 8
	   uo_relacion.of_carga_control(  gtr_sce , ii_anio_proc_titulacion)
else 
	If is_ventana = 'LIC_MEN' Then
		 uo_relacion.il_filtro_tipo_relacion = 7
		   uo_relacion.of_carga_control(  gtr_sce , ii_anio_proc_titulacion)
	else
          uo_relacion.of_carga_control( gtr_sce, ii_anio_proc_titulacion)
    end if 
end if


end event

type rb_manual from radiobutton within w_rep_tit_lic_impresor
boolean visible = false
integer x = 955
integer y = 208
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

type rb_relacion from radiobutton within w_rep_tit_lic_impresor
boolean visible = false
integer x = 1307
integer y = 208
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
choose case is_ventana
	case 'POS_MEN', 'LIC_MEN'
	If is_ventana = 'POS_MEN' Then
			dw_1.dataobject = "dw_rep_menciones_posg_imp"
			is_nom_ventana = "Reporte de Menciones de Posgrado"
			gb_grado.visible = True
			rb_maestria.visible = True
			rb_doctorado.visible = True
			rb_maestria.checked = True
			is_grado = 'M'
			if wf_fecha_libre(8) = 1 then
			  uo_relacion.il_filtro_tipo_relacion = 8
			  	dp_fecha_ini.visible = false
				dp_fecha_fin.visible = false
				gb_fechas_manual.visible = false
				st_fecha.visible = false
				st_fecha_fin.visible = false
				rb_relacion.checked = true
				rb_manual.checked = false
			else
//			    MessageBox('Mensaje del Sistema', 'No existe existen relaciones para este año, continue opcion manual.')	
				gb_4.visible = True
				rb_manual.visible = True
				rb_relacion.visible = True
				uo_relacion.visible = false
				
				dp_fecha_ini.visible = True
				dp_fecha_fin.visible = True
				gb_fechas_manual.visible = True
			     st_fecha.visible = true
				st_fecha_fin.visible = true
			    rb_relacion.checked = false
				rb_manual.checked = true
				gb_fechas_manual.bringtoTop = True
				dp_fecha_ini.bringtoTop = True
				dp_fecha_fin.bringtoTop = True
				st_fecha.bringtoTop = True
				st_fecha_fin.bringtoTop = True
			end if
		Else
			dw_1.dataobject = "dw_rep_menciones_lic_imp"
			is_nom_ventana = "Reporte de Menciones de Licenciatura"
			gb_grado.visible = False
			rb_maestria.visible = False
			rb_doctorado.visible = False
			rb_maestria.checked = False
			if wf_fecha_libre(7)  = 1 then
		     	uo_relacion.il_filtro_tipo_relacion = 7
				 dp_fecha_ini.visible = false
				dp_fecha_fin.visible = false
				gb_fechas_manual.visible = false
				st_fecha.visible = false
				st_fecha_fin.visible = false
				rb_relacion.checked = true
				rb_manual.checked = false
				
			
		     else
//				  MessageBox('Mensaje del Sistema', 'No existe existen relaciones para este año, continue opcion manual.')	
				gb_4.visible = True
				rb_manual.visible = True
				rb_relacion.visible = True
			    uo_relacion.visible = false
				 
				dp_fecha_ini.visible = True
				dp_fecha_fin.visible = True
				gb_fechas_manual.visible = True
			     st_fecha.visible = true
				st_fecha_fin.visible = true
				rb_relacion.checked = false
				rb_manual.checked = true
				gb_fechas_manual.bringtoTop = True
				dp_fecha_ini.bringtoTop = True
				dp_fecha_fin.bringtoTop = True
				st_fecha.bringtoTop = True
				st_fecha_fin.bringtoTop = True
			end if
		End If
		st_fecha_expedicion.visible = False
		st_fecha.text = "Fecha Inicio"
		cbx_mencion_lic.visible = False

		If is_ventana = 'POS_MEN' Then
			dp_fecha_exped.setvalue(idt_fecha_sig_posg)
		Else
			dp_fecha_exped.setvalue(idt_fecha_sig_mes)
		End If
		cbx_exa_gral_conoc.visible = False
		
end choose

end event

type gb_tipo_doc from groupbox within w_rep_tit_lic_impresor
boolean visible = false
integer x = 1481
integer y = 340
integer width = 1627
integer height = 252
integer taborder = 120
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Tipo Documento"
end type

type gb_4 from groupbox within w_rep_tit_lic_impresor
boolean visible = false
integer x = 928
integer y = 156
integer width = 905
integer height = 160
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 553648127
end type

type dp_fecha_ini from datepicker within w_rep_tit_lic_impresor
boolean visible = false
integer x = 489
integer y = 400
integer width = 457
integer height = 100
integer taborder = 120
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-11-04"), Time("14:35:45.000000"))
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

type dp_fecha_fin from datepicker within w_rep_tit_lic_impresor
boolean visible = false
integer x = 1266
integer y = 400
integer width = 457
integer height = 100
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-11-04"), Time("14:35:45.000000"))
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

type cbx_mencion_lic from checkbox within w_rep_tit_lic_impresor
integer x = 1573
integer y = 452
integer width = 576
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
string text = "Mención Honorifica"
end type

event clicked;cb_consultar.event clicked( )
end event

