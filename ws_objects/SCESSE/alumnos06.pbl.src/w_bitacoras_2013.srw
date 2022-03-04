$PBExportHeader$w_bitacoras_2013.srw
forward
global type w_bitacoras_2013 from w_master_main
end type
type gb_3 from groupbox within w_bitacoras_2013
end type
type uo_1 from uo_per_ani within w_bitacoras_2013
end type
type dw_bitacora_2013 from uo_master_dw within w_bitacoras_2013
end type
type rb_1 from radiobutton within w_bitacoras_2013
end type
type rb_2 from radiobutton within w_bitacoras_2013
end type
type rb_3 from radiobutton within w_bitacoras_2013
end type
type rb_4 from radiobutton within w_bitacoras_2013
end type
type rb_5 from radiobutton within w_bitacoras_2013
end type
type rb_6 from radiobutton within w_bitacoras_2013
end type
type rb_7 from radiobutton within w_bitacoras_2013
end type
type rb_fechas from radiobutton within w_bitacoras_2013
end type
type rb_periodo from radiobutton within w_bitacoras_2013
end type
type em_fec_ini from editmask within w_bitacoras_2013
end type
type em_fec_fin from editmask within w_bitacoras_2013
end type
type st_1 from statictext within w_bitacoras_2013
end type
type st_2 from statictext within w_bitacoras_2013
end type
type gb_1 from groupbox within w_bitacoras_2013
end type
end forward

global type w_bitacoras_2013 from w_master_main
integer width = 3890
integer height = 2696
string title = "REPORTES BITACORAS HISTÓRICO"
string menuname = "m_bitacoras_2013"
gb_3 gb_3
uo_1 uo_1
dw_bitacora_2013 dw_bitacora_2013
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_4 rb_4
rb_5 rb_5
rb_6 rb_6
rb_7 rb_7
rb_fechas rb_fechas
rb_periodo rb_periodo
em_fec_ini em_fec_ini
em_fec_fin em_fec_fin
st_1 st_1
st_2 st_2
gb_1 gb_1
end type
global w_bitacoras_2013 w_bitacoras_2013

type variables
integer ii_tip_mov
uo_periodo_servicios iuo_periodo_servicios
end variables

on w_bitacoras_2013.create
int iCurrent
call super::create
if this.MenuName = "m_bitacoras_2013" then this.MenuID = create m_bitacoras_2013
this.gb_3=create gb_3
this.uo_1=create uo_1
this.dw_bitacora_2013=create dw_bitacora_2013
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
this.rb_4=create rb_4
this.rb_5=create rb_5
this.rb_6=create rb_6
this.rb_7=create rb_7
this.rb_fechas=create rb_fechas
this.rb_periodo=create rb_periodo
this.em_fec_ini=create em_fec_ini
this.em_fec_fin=create em_fec_fin
this.st_1=create st_1
this.st_2=create st_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_bitacora_2013
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_4
this.Control[iCurrent+8]=this.rb_5
this.Control[iCurrent+9]=this.rb_6
this.Control[iCurrent+10]=this.rb_7
this.Control[iCurrent+11]=this.rb_fechas
this.Control[iCurrent+12]=this.rb_periodo
this.Control[iCurrent+13]=this.em_fec_ini
this.Control[iCurrent+14]=this.em_fec_fin
this.Control[iCurrent+15]=this.st_1
this.Control[iCurrent+16]=this.st_2
this.Control[iCurrent+17]=this.gb_1
end on

on w_bitacoras_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.uo_1)
destroy(this.dw_bitacora_2013)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
destroy(this.rb_4)
destroy(this.rb_5)
destroy(this.rb_6)
destroy(this.rb_7)
destroy(this.rb_fechas)
destroy(this.rb_periodo)
destroy(this.em_fec_ini)
destroy(this.em_fec_fin)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.gb_1)
end on

event open;call super::open;date ld_fecha

dw_bitacora_2013.Settransobject(gtr_sce)
ld_fecha = f_obten_fecha_servidor()

em_fec_ini.text = string(ld_fecha)
em_fec_fin.text = string(ld_fecha)
end event

event ue_carga;call super::ue_carga;string ls_fec_ini, ls_fec_fin,ls_periodo
string ls_sql_ori,ls_query,ls_sql_mod,ls_cadena

if rb_fechas.checked = true then
	ls_fec_ini = string(date(em_fec_ini.text),'yyyymmdd')
	ls_fec_fin = string(date(em_fec_fin.text),'yyyymmdd')
	ls_query = ' and ( convert(date,ui_bicamnot.fecha_hora) Between convert(date,"'+ls_fec_ini+'") and convert(date,"'+ls_fec_fin+'")) '
end if

	//Modif. Roberto Novoa R.  May/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
	ls_periodo=String(uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L"))


/*
if rb_periodo.checked = true then
	choose case uo_1.em_per.text
	case 'Primavera'
		ls_periodo = '0'
	case 'Verano'
		ls_periodo = '1'
	case 'Otoño'
		ls_periodo = '2'
end choose
*/
	
	ls_query = ' and (ui_bicamnot.anio = '+ uo_1.em_ani.text + ' And ui_bicamnot.periodo ='+ ls_periodo + ' )'
//end if

choose case ii_tip_mov
	case 0
		ls_cadena = ' AND ( ui_bicamnot.cve_movimiento in (0,99,99,99,99,99,99,99)) '
	case 1
		ls_cadena = ' AND ( ui_bicamnot.cve_movimiento in (1,99,99,99,99,99,99,99)) '
	case 2
		ls_cadena = ' AND ( ui_bicamnot.cve_movimiento in (2,99,99,99,99,99,99,99)) '
	case 3
		ls_cadena = ' AND ( ui_bicamnot.cve_movimiento in (3,99,99,99,99,99,99,99)) '
	case 4
		ls_cadena = ' AND ( ui_bicamnot.cve_movimiento in (4,99,99,99,99,99,99,99)) '
	case 5
		ls_cadena = ' AND ( ui_bicamnot.cve_movimiento in (5,6,7,99,99,99,99,99)) '
	case else
		ls_cadena = ' AND ( ui_bicamnot.cve_movimiento in (0,1,2,3,4,5,6,7)) '
end choose

ls_sql_ori = dw_bitacora_2013.Getsqlselect()
ls_sql_mod = ls_sql_ori + ls_query + ls_cadena + ' ORDER BY ui_bicamnot.cve_movimiento, ui_bicamnot.cuenta'
dw_bitacora_2013.Setsqlselect(ls_sql_mod)
dw_bitacora_2013.Retrieve(ii_tip_mov)
dw_bitacora_2013.Setsqlselect(ls_sql_ori)
end event

type st_sistema from w_master_main`st_sistema within w_bitacoras_2013
end type

type p_ibero from w_master_main`p_ibero within w_bitacoras_2013
end type

type gb_3 from groupbox within w_bitacoras_2013
integer x = 2651
integer width = 1138
integer height = 428
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Reportes"
end type

type uo_1 from uo_per_ani within w_bitacoras_2013
integer x = 1371
integer y = 248
integer width = 1253
integer height = 168
integer taborder = 40
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_bitacora_2013 from uo_master_dw within w_bitacoras_2013
integer x = 27
integer y = 472
integer width = 3758
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_bitacora_2013"
boolean resizable = true
end type

event constructor;call super::constructor;m_bitacoras_2013.dw = this
idw_trabajo = this
end event

type rb_1 from radiobutton within w_bitacoras_2013
integer x = 2697
integer y = 76
integer width = 498
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Cambio de Nota"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 0
parent.triggerevent('ue_carga')
end event

type rb_2 from radiobutton within w_bitacoras_2013
integer x = 2697
integer y = 156
integer width = 498
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Alta de Materia"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 1
parent.triggerevent('ue_carga')
end event

type rb_3 from radiobutton within w_bitacoras_2013
integer x = 2697
integer y = 236
integer width = 498
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Baja de Materia"
boolean lefttext = true
end type

event clicked;ii_tip_mov =2
parent.triggerevent('ue_carga')
end event

type rb_4 from radiobutton within w_bitacoras_2013
integer x = 2697
integer y = 316
integer width = 498
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Borra Historia"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 3
parent.triggerevent('ue_carga')
end event

type rb_5 from radiobutton within w_bitacoras_2013
integer x = 3232
integer y = 72
integer width = 507
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Servicio Social"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 4
parent.triggerevent('ue_carga')
end event

type rb_6 from radiobutton within w_bitacoras_2013
integer x = 3232
integer y = 152
integer width = 507
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Opción Terminal"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 5
parent.triggerevent('ue_carga')
end event

type rb_7 from radiobutton within w_bitacoras_2013
integer x = 3232
integer y = 232
integer width = 507
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Todos los movs."
boolean lefttext = true
end type

event clicked;ii_tip_mov = 6
parent.triggerevent('ue_carga')
end event

type rb_fechas from radiobutton within w_bitacoras_2013
integer x = 965
integer y = 108
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Por Fecha"
boolean checked = true
end type

type rb_periodo from radiobutton within w_bitacoras_2013
integer x = 965
integer y = 292
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Por Periodo"
end type

type em_fec_ini from editmask within w_bitacoras_2013
integer x = 1541
integer y = 92
integer width = 329
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type em_fec_fin from editmask within w_bitacoras_2013
integer x = 2043
integer y = 92
integer width = 329
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
boolean autoskip = true
end type

type st_1 from statictext within w_bitacoras_2013
integer x = 1408
integer y = 116
integer width = 128
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
string text = "Del:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_bitacoras_2013
integer x = 1902
integer y = 116
integer width = 128
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
string text = " al: "
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_bitacoras_2013
integer x = 946
integer width = 1682
integer height = 428
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Parámetros"
end type

