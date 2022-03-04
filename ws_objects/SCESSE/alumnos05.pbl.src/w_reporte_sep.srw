$PBExportHeader$w_reporte_sep.srw
forward
global type w_reporte_sep from w_ancestral
end type
type dw_reporte_sep from uo_dw_reporte within w_reporte_sep
end type
type rb_tit from radiobutton within w_reporte_sep
end type
type rb_extra from radiobutton within w_reporte_sep
end type
type gb_1 from groupbox within w_reporte_sep
end type
type cb_1 from commandbutton within w_reporte_sep
end type
type uo_1 from uo_per_ani within w_reporte_sep
end type
type uo_nivel from uo_nivel_rbutton within w_reporte_sep
end type
end forward

global type w_reporte_sep from w_ancestral
integer width = 3758
string title = "Reporte SEP"
string menuname = "m_menu"
dw_reporte_sep dw_reporte_sep
rb_tit rb_tit
rb_extra rb_extra
gb_1 gb_1
cb_1 cb_1
uo_1 uo_1
uo_nivel uo_nivel
end type
global w_reporte_sep w_reporte_sep

on w_reporte_sep.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_reporte_sep=create dw_reporte_sep
this.rb_tit=create rb_tit
this.rb_extra=create rb_extra
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.uo_nivel=create uo_nivel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_reporte_sep
this.Control[iCurrent+2]=this.rb_tit
this.Control[iCurrent+3]=this.rb_extra
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_nivel
end on

on w_reporte_sep.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_reporte_sep)
destroy(this.rb_tit)
destroy(this.rb_extra)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.uo_nivel)
end on

event open;call super::open;dw_reporte_sep.settransobject(gtr_sce)
m_menu.m_registro.m_cargaregistro.enabled = false

uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce) 



end event

type p_uia from w_ancestral`p_uia within w_reporte_sep
end type

type dw_reporte_sep from uo_dw_reporte within w_reporte_sep
integer x = 503
integer y = 244
integer width = 3173
integer height = 1824
integer taborder = 30
string dataobject = "dw_reporte_sep"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type rb_tit from radiobutton within w_reporte_sep
integer x = 9
integer y = 904
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Título"
boolean lefttext = true
end type

type rb_extra from radiobutton within w_reporte_sep
integer x = 9
integer y = 1040
integer width = 379
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Extraordinario"
boolean checked = true
boolean lefttext = true
end type

type gb_1 from groupbox within w_reporte_sep
boolean visible = false
integer y = 836
integer width = 494
integer height = 360
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type cb_1 from commandbutton within w_reporte_sep
integer x = 64
integer y = 1500
integer width = 247
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga"
end type

event clicked;int li_opcion
string li_nivel

//if rb_lic.checked then
//	li_nivel="L"
//elseif rb_pos.checked then
//	li_nivel="P"
//elseif rb_tsu.checked then	
//	li_nivel="T"
//end if

li_nivel = PARENT.uo_nivel.cve_nivel 

if rb_extra.checked then
	li_opcion=2
else
	li_opcion=6
end if

dw_reporte_sep.retrieve(li_nivel,li_opcion,gi_anio,gi_periodo)
end event

type uo_1 from uo_per_ani within w_reporte_sep
integer x = 425
integer y = 32
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_nivel from uo_nivel_rbutton within w_reporte_sep
integer x = 14
integer y = 468
integer width = 471
integer taborder = 40
boolean bringtotop = true
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

