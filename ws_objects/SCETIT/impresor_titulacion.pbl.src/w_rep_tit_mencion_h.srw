$PBExportHeader$w_rep_tit_mencion_h.srw
forward
global type w_rep_tit_mencion_h from w_master_main_rep
end type
type cb_exportar from commandbutton within w_rep_tit_mencion_h
end type
type cb_salir from commandbutton within w_rep_tit_mencion_h
end type
type dp_fecha_ini from datepicker within w_rep_tit_mencion_h
end type
type cb_2 from commandbutton within w_rep_tit_mencion_h
end type
type cb_consultar from commandbutton within w_rep_tit_mencion_h
end type
type dw_1 from datawindow within w_rep_tit_mencion_h
end type
type gb_2 from groupbox within w_rep_tit_mencion_h
end type
type gb_1 from groupbox within w_rep_tit_mencion_h
end type
type dp_fecha_fin from datepicker within w_rep_tit_mencion_h
end type
type st_fecha from statictext within w_rep_tit_mencion_h
end type
type st_fecha_fin from statictext within w_rep_tit_mencion_h
end type
end forward

global type w_rep_tit_mencion_h from w_master_main_rep
integer width = 5271
integer height = 2440
string title = "Reporte de Mención Honorifica de Licenciatura"
boolean resizable = true
string icon = "AppIcon!"
boolean center = true
event ue_obtener_fechas ( )
event ue_obtener_fecha_sem_ant ( )
cb_exportar cb_exportar
cb_salir cb_salir
dp_fecha_ini dp_fecha_ini
cb_2 cb_2
cb_consultar cb_consultar
dw_1 dw_1
gb_2 gb_2
gb_1 gb_1
dp_fecha_fin dp_fecha_fin
st_fecha st_fecha
st_fecha_fin st_fecha_fin
end type
global w_rep_tit_mencion_h w_rep_tit_mencion_h

type variables
string is_ventana, is_nom_ventana, is_grado
Datetime idt_fecha_hoy, idt_fecha_sig_mes, idt_fecha_sig_posg
Integer ii_anio_proc_titulacion


end variables

forward prototypes
public function integer wf_pos_fechas_semana_prev (datetime ar_fecha)
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

on w_rep_tit_mencion_h.create
int iCurrent
call super::create
this.cb_exportar=create cb_exportar
this.cb_salir=create cb_salir
this.dp_fecha_ini=create dp_fecha_ini
this.cb_2=create cb_2
this.cb_consultar=create cb_consultar
this.dw_1=create dw_1
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dp_fecha_fin=create dp_fecha_fin
this.st_fecha=create st_fecha
this.st_fecha_fin=create st_fecha_fin
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportar
this.Control[iCurrent+2]=this.cb_salir
this.Control[iCurrent+3]=this.dp_fecha_ini
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_consultar
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_2
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.dp_fecha_fin
this.Control[iCurrent+10]=this.st_fecha
this.Control[iCurrent+11]=this.st_fecha_fin
end on

on w_rep_tit_mencion_h.destroy
call super::destroy
destroy(this.cb_exportar)
destroy(this.cb_salir)
destroy(this.dp_fecha_ini)
destroy(this.cb_2)
destroy(this.cb_consultar)
destroy(this.dw_1)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dp_fecha_fin)
destroy(this.st_fecha)
destroy(this.st_fecha_fin)
end on

event open;is_ventana = Message.stringparm
dw_1.settransobject( gtr_sce)

TriggerEvent("ue_obtener_fechas")
wf_pos_fechas_semana_prev (idt_fecha_hoy)

choose case is_ventana
	case 'MEN_LIC' 
	dw_1.dataobject = "dw_rep_alumnos_mencion_h"
		is_nom_ventana = "Reporte de Mención Honorifica de Licenciatura"
	case 'ETQ_LIC'
		dw_1.dataobject = "dw_rep_etiquetas_mencion_h"
		is_nom_ventana = "Reporte de Etiquetas Licenciatura"
	case 'ETQ_ARC'
		dw_1.dataobject = "dw_rep_etiquetas_lic_arch"
		is_nom_ventana = "Reporte de Etiquetas Licenciatura para archivo"
		
end choose

dw_1.settransobject(gtr_sce)

This.title = is_nom_ventana
end event

type st_sistema from w_master_main_rep`st_sistema within w_rep_tit_mencion_h
end type

type p_ibero from w_master_main_rep`p_ibero within w_rep_tit_mencion_h
end type

type cb_exportar from commandbutton within w_rep_tit_mencion_h
integer x = 4110
integer y = 452
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

type cb_salir from commandbutton within w_rep_tit_mencion_h
integer x = 4517
integer y = 452
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

type dp_fecha_ini from datepicker within w_rep_tit_mencion_h
integer x = 155
integer y = 464
integer width = 457
integer height = 100
integer taborder = 120
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-12-08"), Time("14:37:15.000000"))
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

type cb_2 from commandbutton within w_rep_tit_mencion_h
integer x = 3703
integer y = 452
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

event clicked;
If dw_1.rowcount( ) > 0 Then
		PrintSetup();
		If 	dw_1.print() = -1 Then
			MessageBox('Error del Sistema', 'Error al imprimir el documento')
			return -1
		End If
Else
	MessageBox('Mensaje del Sistema', 'No existe información en el reporte para imprimir')
End If
end event

type cb_consultar from commandbutton within w_rep_tit_mencion_h
integer x = 3296
integer y = 452
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
integer li_cve_relacion, li_result

// MALH 13/11/2017 SE AGREGA FORMATO A LA FECHAS OBTENIDAS
ls_fecha = String(dp_fecha_ini.DateValue, "dd/mm/yyyy")
ls_fecha_fin = String(dp_fecha_fin.DateValue, "dd/mm/yyyy")

// MALH 13/11/2017 SE AGREGAN NUEVAS LINEAS PARA OBTENER LAS FECHAS
ls_fecha = mid(ls_fecha,7,4) + mid(ls_fecha,4,2)  + mid(ls_fecha,1,2)
ls_fecha_fin = mid(ls_fecha_fin,7,4) + mid(ls_fecha_fin,4,2)  + mid(ls_fecha_fin,1,2)

// MALH 13/11/2017 SE COMENTA DEBIDO A QUE NO SE OBTENIA CORRECTAMENTE LAS FECHAS
// ls_fecha = mid(string(dp_fecha_ini.DateValue),7,4) + mid(string(dp_fecha_ini.DateValue),4,2)  + mid(string(dp_fecha_ini.DateValue),1,2)
// ls_fecha_fin = mid(string(dp_fecha_fin.DateValue),7,4) + mid(string(dp_fecha_fin.DateValue),4,2)  + mid(string( dp_fecha_fin.DateValue),1,2)

If is_ventana = "MEN_LIC" Then
	gtr_sce.autocommit = True
End If
	
li_result = dw_1.retrieve(ls_fecha,ls_fecha_fin)

If is_ventana = "MEN_LIC" Then
	gtr_sce.autocommit = False
End If

If li_result = -1 Then
	MessageBox('Mensaje del Sistema', 'Error al ejecutar la consulta: ' + SQLCA.sqlerrtext, Information!)
	return -1
Else 
If li_result = 0 Then
	MessageBox('Mensaje del Sistema', 'No se encontaron registros en la consulta realizada...', Information!)
End IF
End If

return 0


end event

type dw_1 from datawindow within w_rep_tit_mencion_h
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

type gb_2 from groupbox within w_rep_tit_mencion_h
boolean visible = false
integer x = 128
integer y = 344
integer width = 992
integer height = 252
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

type gb_1 from groupbox within w_rep_tit_mencion_h
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

type dp_fecha_fin from datepicker within w_rep_tit_mencion_h
integer x = 635
integer y = 464
integer width = 457
integer height = 100
integer taborder = 50
boolean bringtotop = true
boolean border = true
borderstyle borderstyle = stylelowered!
date maxdate = Date("2999-12-31")
date mindate = Date("1800-01-01")
datetime value = DateTime(Date("2021-12-08"), Time("14:37:15.000000"))
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

type st_fecha from statictext within w_rep_tit_mencion_h
integer x = 155
integer y = 392
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

type st_fecha_fin from statictext within w_rep_tit_mencion_h
integer x = 640
integer y = 392
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

