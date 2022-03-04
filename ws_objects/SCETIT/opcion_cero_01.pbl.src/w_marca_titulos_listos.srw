$PBExportHeader$w_marca_titulos_listos.srw
forward
global type w_marca_titulos_listos from w_main
end type
type iuo_estado_titulo from uo_estado_titulo within w_marca_titulos_listos
end type
type cb_asignar from u_cb within w_marca_titulos_listos
end type
type cb_cargar from u_cb within w_marca_titulos_listos
end type
type st_2 from statictext within w_marca_titulos_listos
end type
type st_1 from statictext within w_marca_titulos_listos
end type
type em_fecha_final from u_em within w_marca_titulos_listos
end type
type em_fecha_inicial from u_em within w_marca_titulos_listos
end type
type dw_1 from u_dw_captura within w_marca_titulos_listos
end type
end forward

global type w_marca_titulos_listos from w_main
integer x = 466
integer y = 372
integer width = 3105
integer height = 1782
string title = "Marca Títulos Listos para Recoger"
string menuname = "m_menu"
iuo_estado_titulo iuo_estado_titulo
cb_asignar cb_asignar
cb_cargar cb_cargar
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
dw_1 dw_1
end type
global w_marca_titulos_listos w_marca_titulos_listos

on w_marca_titulos_listos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.iuo_estado_titulo=create iuo_estado_titulo
this.cb_asignar=create cb_asignar
this.cb_cargar=create cb_cargar
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.iuo_estado_titulo
this.Control[iCurrent+2]=this.cb_asignar
this.Control[iCurrent+3]=this.cb_cargar
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_fecha_final
this.Control[iCurrent+7]=this.em_fecha_inicial
this.Control[iCurrent+8]=this.dw_1
end on

on w_marca_titulos_listos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.iuo_estado_titulo)
destroy(this.cb_asignar)
destroy(this.cb_cargar)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.dw_1)
end on

event open;call super::open;x=1
y=1
end event

type iuo_estado_titulo from uo_estado_titulo within w_marca_titulos_listos
integer x = 1287
integer y = 86
integer taborder = 30
boolean border = false
end type

on iuo_estado_titulo.destroy
call uo_estado_titulo::destroy
end on

type cb_asignar from u_cb within w_marca_titulos_listos
integer x = 2589
integer y = 106
integer width = 351
integer height = 93
integer taborder = 20
string text = "Asignar"
end type

event clicked;call super::clicked;long ll_rows, ll_row, ll_cve_estado_titulo

ll_rows= dw_1.RowCount()

if ll_rows<= 0 then
	MessageBox("No existen registros a procesar","Favor de cargar antes de asignar estatus",StopSign!)	
   return	
end if
ll_cve_estado_titulo = iuo_estado_titulo.of_obten_clave()

FOR ll_row= 1 TO ll_rows
	dw_1.SetItem(ll_row,"entrega_titulo_cve_estado_titulo",ll_cve_estado_titulo)
NEXT

end event

type cb_cargar from u_cb within w_marca_titulos_listos
integer x = 885
integer y = 106
integer width = 351
integer height = 93
integer taborder = 20
string text = "Cargar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type st_2 from statictext within w_marca_titulos_listos
integer x = 62
integer y = 198
integer width = 366
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_marca_titulos_listos
integer x = 62
integer y = 83
integer width = 366
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_marca_titulos_listos
integer x = 556
integer y = 182
integer width = 289
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_marca_titulos_listos
integer x = 556
integer y = 67
integer width = 289
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type dw_1 from u_dw_captura within w_marca_titulos_listos
integer x = 99
integer y = 310
integer width = 2842
integer height = 1050
integer taborder = 40
string dataobject = "d_marca_titulos_listos"
boolean hscrollbar = true
end type

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros, li_cve_constancia, li_cve_estatus_solicitud
long ll_row_estatus_solicitud
long ll_area_coordinacion, ll_responsable
string ls_area_coordinacion, ls_estatus_solicitud

if isnull(dw_1.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)

return li_num_registros
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
this.SetTransObject(tr_dw_propio)


end event

event nuevo;return
end event

event borra;return 
end event

