$PBExportHeader$w_hoja_res.srw
$PBExportComments$Ventana que genera las hojas de respuestas
forward
global type w_hoja_res from window
end type
type uo_1 from uo_ver_per_ani within w_hoja_res
end type
type em_max from editmask within w_hoja_res
end type
type em_min from editmask within w_hoja_res
end type
type dw_1 from uo_dw_reporte within w_hoja_res
end type
end forward

global type w_hoja_res from window
integer x = 832
integer y = 360
integer width = 4361
integer height = 1992
boolean titlebar = true
string title = "Hojas de Respuestas"
string menuname = "m_menu"
long backcolor = 30976088
event type long num_folios ( integer min_max )
uo_1 uo_1
em_max em_max
em_min em_min
dw_1 dw_1
end type
global w_hoja_res w_hoja_res

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

on w_hoja_res.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.em_max=create em_max
this.em_min=create em_min
this.dw_1=create dw_1
this.Control[]={this.uo_1,&
this.em_max,&
this.em_min,&
this.dw_1}
end on

on w_hoja_res.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_hoja_res
integer x = 27
integer y = 24
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type em_max from editmask within w_hoja_res
integer x = 2825
integer y = 52
integer width = 338
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_hoja_res
integer x = 2469
integer y = 52
integer width = 338
integer height = 100
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type dw_1 from uo_dw_reporte within w_hoja_res
integer x = 18
integer y = 192
integer width = 4215
integer height = 1540
integer taborder = 0
string dataobject = "dw_hoja_res"
boolean hscrollbar = true
boolean resizable = true
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event carga;event primero()
return retrieve(gi_version,gi_periodo,gi_anio,long(em_min.text),long(em_max.text))
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

