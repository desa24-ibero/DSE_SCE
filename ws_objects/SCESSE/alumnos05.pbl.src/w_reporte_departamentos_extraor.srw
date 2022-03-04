$PBExportHeader$w_reporte_departamentos_extraor.srw
forward
global type w_reporte_departamentos_extraor from w_ancestral
end type
type dw_reporte_departamentos_extraor from uo_dw_reporte within w_reporte_departamentos_extraor
end type
type rb_tit from radiobutton within w_reporte_departamentos_extraor
end type
type rb_extra from radiobutton within w_reporte_departamentos_extraor
end type
type gb_1 from groupbox within w_reporte_departamentos_extraor
end type
type cb_1 from commandbutton within w_reporte_departamentos_extraor
end type
type uo_1 from uo_per_ani within w_reporte_departamentos_extraor
end type
type uo_nivel from uo_nivel_rbutton within w_reporte_departamentos_extraor
end type
end forward

global type w_reporte_departamentos_extraor from w_ancestral
integer width = 3808
integer height = 1852
string title = "Reporte de Exámenes"
string menuname = "m_menu"
event carga ( )
dw_reporte_departamentos_extraor dw_reporte_departamentos_extraor
rb_tit rb_tit
rb_extra rb_extra
gb_1 gb_1
cb_1 cb_1
uo_1 uo_1
uo_nivel uo_nivel
end type
global w_reporte_departamentos_extraor w_reporte_departamentos_extraor

event carga();Return
end event

on w_reporte_departamentos_extraor.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_reporte_departamentos_extraor=create dw_reporte_departamentos_extraor
this.rb_tit=create rb_tit
this.rb_extra=create rb_extra
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_1=create uo_1
this.uo_nivel=create uo_nivel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_reporte_departamentos_extraor
this.Control[iCurrent+2]=this.rb_tit
this.Control[iCurrent+3]=this.rb_extra
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.uo_nivel
end on

on w_reporte_departamentos_extraor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_reporte_departamentos_extraor)
destroy(this.rb_tit)
destroy(this.rb_extra)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.uo_nivel)
end on

event open;call super::open;dw_reporte_departamentos_extraor.settransobject(gtr_sce)
m_menu.m_registro.m_cargaregistro.enabled = false


// Se inicializa el objeto de servicios de nivel. 
uo_nivel.f_genera_nivel( "V", "L", "L", gtr_sce) 


end event

type p_uia from w_ancestral`p_uia within w_reporte_departamentos_extraor
integer x = 96
end type

type dw_reporte_departamentos_extraor from uo_dw_reporte within w_reporte_departamentos_extraor
integer x = 576
integer y = 176
integer width = 3173
integer height = 1480
integer taborder = 20
string dataobject = "dw_reporte_departamentos_extraor"
boolean controlmenu = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type rb_tit from radiobutton within w_reporte_departamentos_extraor
integer x = 18
integer y = 904
integer width = 535
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

type rb_extra from radiobutton within w_reporte_departamentos_extraor
integer x = 18
integer y = 980
integer width = 535
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

type gb_1 from groupbox within w_reporte_departamentos_extraor
boolean visible = false
integer y = 836
integer width = 576
integer height = 360
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
end type

type cb_1 from commandbutton within w_reporte_departamentos_extraor
integer x = 64
integer y = 1500
integer width = 247
integer height = 108
integer taborder = 10
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


li_nivel = parent.uo_nivel.cve_nivel 

if rb_extra.checked then
	li_opcion=2
else
	li_opcion=6
end if

dw_reporte_departamentos_extraor.retrieve(li_nivel,li_opcion,gi_anio,gi_periodo)
end event

type uo_1 from uo_per_ani within w_reporte_departamentos_extraor
integer x = 571
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_nivel from uo_nivel_rbutton within w_reporte_departamentos_extraor
integer x = 18
integer y = 456
integer width = 535
integer height = 296
integer taborder = 40
boolean bringtotop = true
end type

on uo_nivel.destroy
call uo_nivel_rbutton::destroy
end on

