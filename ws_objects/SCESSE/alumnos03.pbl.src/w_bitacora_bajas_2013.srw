$PBExportHeader$w_bitacora_bajas_2013.srw
forward
global type w_bitacora_bajas_2013 from w_master_main
end type
type gb_3 from groupbox within w_bitacora_bajas_2013
end type
type uo_1 from uo_per_ani within w_bitacora_bajas_2013
end type
type dw_bitacora_bajas_2013 from uo_master_dw within w_bitacora_bajas_2013
end type
type rb_1 from radiobutton within w_bitacora_bajas_2013
end type
type rb_2 from radiobutton within w_bitacora_bajas_2013
end type
type rb_3 from radiobutton within w_bitacora_bajas_2013
end type
type rb_7 from radiobutton within w_bitacora_bajas_2013
end type
type rb_fechas from radiobutton within w_bitacora_bajas_2013
end type
type rb_periodo from radiobutton within w_bitacora_bajas_2013
end type
type em_fec_ini from editmask within w_bitacora_bajas_2013
end type
type em_fec_fin from editmask within w_bitacora_bajas_2013
end type
type st_1 from statictext within w_bitacora_bajas_2013
end type
type st_2 from statictext within w_bitacora_bajas_2013
end type
type gb_1 from groupbox within w_bitacora_bajas_2013
end type
end forward

global type w_bitacora_bajas_2013 from w_master_main
integer width = 3890
integer height = 2696
string title = "Bitacoras Bajas"
string menuname = "m_bitacora_bajas_2013"
boolean maxbox = false
gb_3 gb_3
uo_1 uo_1
dw_bitacora_bajas_2013 dw_bitacora_bajas_2013
rb_1 rb_1
rb_2 rb_2
rb_3 rb_3
rb_7 rb_7
rb_fechas rb_fechas
rb_periodo rb_periodo
em_fec_ini em_fec_ini
em_fec_fin em_fec_fin
st_1 st_1
st_2 st_2
gb_1 gb_1
end type
global w_bitacora_bajas_2013 w_bitacora_bajas_2013

type variables
integer ii_tip_mov

uo_periodo_servicios iuo_periodo_servicios
end variables

on w_bitacora_bajas_2013.create
int iCurrent
call super::create
if this.MenuName = "m_bitacora_bajas_2013" then this.MenuID = create m_bitacora_bajas_2013
this.gb_3=create gb_3
this.uo_1=create uo_1
this.dw_bitacora_bajas_2013=create dw_bitacora_bajas_2013
this.rb_1=create rb_1
this.rb_2=create rb_2
this.rb_3=create rb_3
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
this.Control[iCurrent+3]=this.dw_bitacora_bajas_2013
this.Control[iCurrent+4]=this.rb_1
this.Control[iCurrent+5]=this.rb_2
this.Control[iCurrent+6]=this.rb_3
this.Control[iCurrent+7]=this.rb_7
this.Control[iCurrent+8]=this.rb_fechas
this.Control[iCurrent+9]=this.rb_periodo
this.Control[iCurrent+10]=this.em_fec_ini
this.Control[iCurrent+11]=this.em_fec_fin
this.Control[iCurrent+12]=this.st_1
this.Control[iCurrent+13]=this.st_2
this.Control[iCurrent+14]=this.gb_1
end on

on w_bitacora_bajas_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.uo_1)
destroy(this.dw_bitacora_bajas_2013)
destroy(this.rb_1)
destroy(this.rb_2)
destroy(this.rb_3)
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

dw_bitacora_bajas_2013.Settransobject(gtr_sce)
ld_fecha = f_obten_fecha_servidor()

em_fec_ini.text = string(ld_fecha)
em_fec_fin.text = string(Today())

iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 
iuo_periodo_servicios.f_modifica_lista_columna( dw_bitacora_bajas_2013, 'periodo', 'C') 

end event

event ue_carga;call super::ue_carga;//Modificado por: Roberto Novoa 9/Jun/2016
//-------------------------------------------------
string ls_fec_ini, ls_fec_fin,ls_periodo, ls_select
string ls_sql_ori,ls_query,ls_sql_mod,ls_cadena

dw_bitacora_bajas_2013.reset()

if rb_fechas.checked = true then
	ls_fec_ini = string(date(em_fec_ini.text),'yyyymmdd')
	ls_fec_fin = string(date(em_fec_fin.text),'yyyymmdd')
	ls_query = ' and ( convert(date,ui_bibaj.fecha_hora) Between convert(date,~~"'+ls_fec_ini+'~~") and convert(date,~~"'+ls_fec_fin+'~~")) '
else
	ls_periodo=String(iuo_periodo_servicios.f_recupera_id(uo_1.em_per.text,'L'))
	ls_query = ' and (ui_bibaj.anio = '+ uo_1.em_ani.text + ' And ui_bibaj.periodo = '+ ls_periodo + ' )'
end if

if rb_periodo.checked = true then
/*
	choose case uo_1.em_per.text
	case 'Primavera'
		ls_periodo = '0'
	case 'Verano'
		ls_periodo = '1'
	case 'Otoño'
		ls_periodo = '2'
end choose
*/
end if

//' and (ui_bibaj.cond_insc_nuevo =  1 or  ui_bibaj.cond_insc_nuevo = 99 or ui_bibaj.cond_insc_nuevo = 99) '


Ls_select = 'SELECT ui_bibaj.cuenta,   '+ &
         'ui_bibaj.Digito,   '+&
         'ui_bibaj.cve_mat,   '+&
         'ui_bibaj.gpo,   '+&
         'ui_bibaj.periodo,   '+&
		'periodo.descripcion_corta,' + &
         'ui_bibaj.anio,   '+&
         'ui_bibaj.cond_insc_nuevo,   '+&
         'ui_bibaj.cond_insc_ante,   '+&
         'ui_bibaj.fecha_hora,   '+&
         'ui_bibaj.usuario,   '+&
         'materias.materia,   '+&
         'coordinaciones.cve_coordinacion,   '+&
         'coordinaciones.coordinacion  '+&
    'FROM ui_bibaj, coordinaciones, materias, periodo '+&
   'WHERE ( coordinaciones.cve_coordinacion = materias.cve_coordinacion ) and  '+&
	          '( ui_bibaj.cve_mat = materias.cve_mat ) and '+&
	          '( ui_bibaj.periodo = periodo.periodo ) and '+&
	          "( periodo.tipo = ~~'"+gs_tipo_periodo+ "~~' ) "+ls_query





if ii_tip_mov<>99 then
	ls_cadena= ' and (ui_bibaj.cond_insc_nuevo = '+string(ii_tip_mov)+' ) '
	Choose case ii_tip_mov
		case 0
			dw_bitacora_bajas_2013.object.t_mov.text='Normal Inscrita'
		case 1
			dw_bitacora_bajas_2013.object.t_mov.text='Baja Académica'
		case 2
			dw_bitacora_bajas_2013.object.t_mov.text='Baja Total'
	end choose
else
	ls_cadena=''
	dw_bitacora_bajas_2013.object.t_mov.text='Todos los Movimientos'
end if

choose case ii_tip_mov
	case 0
		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  0 or  ui_bibaj.cond_insc_nuevo = 99 or ui_bibaj.cond_insc_nuevo = 99) '
	case 1
		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  1 or  ui_bibaj.cond_insc_nuevo = 99 or ui_bibaj.cond_insc_nuevo = 99) '
	case 2
		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  2 or  ui_bibaj.cond_insc_nuevo = 99 or ui_bibaj.cond_insc_nuevo = 99) '		
	case 3
		ls_cadena = ''
//		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  0 or  ui_bibaj.cond_insc_nuevo = 1 or ui_bibaj.cond_insc_nuevo = 2) '
end choose

//choose case ii_tip_mov
//	case 0
//		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  1 or  ui_bibaj.cond_insc_nuevo = 99 or ui_bibaj.cond_insc_nuevo = 99) '
//	case 1
//		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  2 or  ui_bibaj.cond_insc_nuevo = 99 or ui_bibaj.cond_insc_nuevo = 99) '
//	case 2
//		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  0 or  ui_bibaj.cond_insc_nuevo = 99 or ui_bibaj.cond_insc_nuevo = 99) '
//	case 3
//		ls_cadena = ''
////		ls_cadena = ' and (ui_bibaj.cond_insc_nuevo =  0 or  ui_bibaj.cond_insc_nuevo = 1 or ui_bibaj.cond_insc_nuevo = 2) '
//end choose
//

//ls_sql_ori = dw_bitacora_bajas_2013.Getsqlselect()

//ls_sql_mod = ls_sql_ori + ls_cadena + ls_query +  ' ORDER BY cuenta'
ls_sql_mod = ls_select + ls_query + ls_cadena + ' ORDER BY cuenta'

//dw_bitacora_bajas_2013.Setsqlselect(ls_sql_mod)
dw_bitacora_bajas_2013.MODIFY("Datawindow.Table.SELECT = '" + ls_sql_mod + "'")

dw_bitacora_bajas_2013.Retrieve()
dw_bitacora_bajas_2013.Setsqlselect(ls_sql_ori)
end event

type st_sistema from w_master_main`st_sistema within w_bitacora_bajas_2013
end type

type p_ibero from w_master_main`p_ibero within w_bitacora_bajas_2013
end type

type gb_3 from groupbox within w_bitacora_bajas_2013
integer x = 2921
integer width = 869
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

type uo_1 from uo_per_ani within w_bitacora_bajas_2013
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

type dw_bitacora_bajas_2013 from uo_master_dw within w_bitacora_bajas_2013
integer x = 32
integer y = 472
integer width = 3758
integer height = 1968
integer taborder = 11
boolean bringtotop = true
string dataobject = "dw_bitacora_bajas_2013"
boolean resizable = true
end type

event constructor;call super::constructor;m_bitacora_bajas_2013.dw = this
idw_trabajo = this
end event

type rb_1 from radiobutton within w_bitacora_bajas_2013
integer x = 3109
integer y = 76
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
string text = "Baja Académica"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 1
parent.triggerevent('ue_carga')
end event

type rb_2 from radiobutton within w_bitacora_bajas_2013
integer x = 3109
integer y = 156
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
string text = "Baja Total"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 2
parent.triggerevent('ue_carga')
end event

type rb_3 from radiobutton within w_bitacora_bajas_2013
integer x = 3109
integer y = 236
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
string text = "Normal Inscrita"
boolean lefttext = true
end type

event clicked;ii_tip_mov = 0
parent.triggerevent('ue_carga')
end event

type rb_7 from radiobutton within w_bitacora_bajas_2013
integer x = 3109
integer y = 316
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

event clicked;ii_tip_mov = 99
parent.triggerevent('ue_carga')
end event

type rb_fechas from radiobutton within w_bitacora_bajas_2013
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

type rb_periodo from radiobutton within w_bitacora_bajas_2013
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

type em_fec_ini from editmask within w_bitacora_bajas_2013
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

type em_fec_fin from editmask within w_bitacora_bajas_2013
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

type st_1 from statictext within w_bitacora_bajas_2013
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

type st_2 from statictext within w_bitacora_bajas_2013
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

type gb_1 from groupbox within w_bitacora_bajas_2013
integer x = 946
integer width = 1893
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

