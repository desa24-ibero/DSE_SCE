$PBExportHeader$w_rep_hist_indulto_periodo.srw
forward
global type w_rep_hist_indulto_periodo from w_ancestral
end type
type dw_rep_hist_indulto_periodo from uo_dw_reporte within w_rep_hist_indulto_periodo
end type
type uo_2 from uo_per_ani within w_rep_hist_indulto_periodo
end type
type st_periodo from statictext within w_rep_hist_indulto_periodo
end type
type cb_consulta_periodo from commandbutton within w_rep_hist_indulto_periodo
end type
end forward

global type w_rep_hist_indulto_periodo from w_ancestral
integer width = 4375
integer height = 2072
string title = "Reporte de Indultos"
string menuname = "m_menu"
long backcolor = 67108864
dw_rep_hist_indulto_periodo dw_rep_hist_indulto_periodo
uo_2 uo_2
st_periodo st_periodo
cb_consulta_periodo cb_consulta_periodo
end type
global w_rep_hist_indulto_periodo w_rep_hist_indulto_periodo

type variables
int  ii_periodo, ii_anio
uo_periodo_servicios iuo_periodo_servicios
end variables

on w_rep_hist_indulto_periodo.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_rep_hist_indulto_periodo=create dw_rep_hist_indulto_periodo
this.uo_2=create uo_2
this.st_periodo=create st_periodo
this.cb_consulta_periodo=create cb_consulta_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_rep_hist_indulto_periodo
this.Control[iCurrent+2]=this.uo_2
this.Control[iCurrent+3]=this.st_periodo
this.Control[iCurrent+4]=this.cb_consulta_periodo
end on

on w_rep_hist_indulto_periodo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_rep_hist_indulto_periodo)
destroy(this.uo_2)
destroy(this.st_periodo)
destroy(this.cb_consulta_periodo)
end on

event open;call super::open;
dw_rep_hist_indulto_periodo.SetTransObject(gtr_sce)


end event

type p_uia from w_ancestral`p_uia within w_rep_hist_indulto_periodo
boolean visible = false
end type

type dw_rep_hist_indulto_periodo from uo_dw_reporte within w_rep_hist_indulto_periodo
integer x = 101
integer y = 308
integer width = 4091
integer height = 1532
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_rep_hist_indulto_periodo"
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event inicia_transaction_object;tr_dw_propio = gtr_sce



end event

event carga;long ll_rows


ll_rows = this.retrieve(gi_periodo,gi_anio )

return ll_rows
end event

event asigna_dw_menu;call super::asigna_dw_menu;menu_propietario.dw	= this
end event

type uo_2 from uo_per_ani within w_rep_hist_indulto_periodo
integer x = 101
integer y = 40
integer taborder = 41
boolean bringtotop = true
boolean enabled = true
end type

on uo_2.destroy
call uo_per_ani::destroy
end on

type st_periodo from statictext within w_rep_hist_indulto_periodo
integer x = 1806
integer y = 224
integer width = 681
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 10789024
boolean enabled = false
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_consulta_periodo from commandbutton within w_rep_hist_indulto_periodo
integer x = 1883
integer y = 68
integer width = 526
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta Periodo"
end type

event clicked;long ll_row
int li_retorno, li_periodo, li_anio

ii_periodo =gi_periodo
ii_anio =gi_anio


	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
	st_periodo.text = iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")

/*
choose case gi_periodo
	case 0
		st_periodo.text = "PRIMAVERA " + String(gi_anio)
	case 1
		st_periodo.text = "VERANO " + String(gi_anio)
	case 2
		st_periodo.text = "OTOÑO " + String(gi_anio)
end choose
*/



dw_rep_hist_indulto_periodo.event carga()
end event

