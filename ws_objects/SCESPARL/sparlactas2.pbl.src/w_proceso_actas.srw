$PBExportHeader$w_proceso_actas.srw
forward
global type w_proceso_actas from w_ancestral
end type
type dw_1 from uo_dw_captura within w_proceso_actas
end type
type st_periodo from statictext within w_proceso_actas
end type
end forward

global type w_proceso_actas from w_ancestral
string title = "Proceso de Actas en Líneas"
string menuname = "m_menu"
dw_1 dw_1
st_periodo st_periodo
end type
global w_proceso_actas w_proceso_actas

type variables

uo_periodo_servicios iuo_periodo_servicios
end variables

on w_proceso_actas.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.st_periodo=create st_periodo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_periodo
end on

on w_proceso_actas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_periodo)
end on

event open;call super::open;x=1
y=1
m_menu.m_registro.m_nuevo.Visible = False
m_menu.m_registro.m_nuevo.Enabled = False
m_menu.m_registro.m_borraregistro.Visible = False
m_menu.m_registro.m_borraregistro.Enabled = False

//***************************
iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce)
iuo_periodo_servicios.f_modifica_lista_columna( dw_1, 'periodo', 'L')
//***************************

dw_1.event carga() 



end event

type p_uia from w_ancestral`p_uia within w_proceso_actas
end type

type dw_1 from uo_dw_captura within w_proceso_actas
integer x = 59
integer y = 476
integer width = 3333
integer height = 1464
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_procesos_actas"
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;SetTransObject(gtr_sce)
tr_dw_propio = gtr_sce
end event

event carga;integer li_evento_baja_total = 11
int li_periodo,li_anio, li_todos_procesos = 9999
long ll_rows
f_obten_periodo(li_periodo,li_anio,li_evento_baja_total)

STRING ls_periodo

ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( li_periodo, "L") 
st_periodo.TEXT = "Periodo Baja Total: " + ls_periodo + " - " + STRING(li_anio)


//ll_rows = retrieve(li_todos_procesos,li_periodo,li_anio)
ll_rows = retrieve(li_todos_procesos,gs_tipo_periodo) 
return ll_rows
end event

type st_periodo from statictext within w_proceso_actas
integer x = 850
integer y = 168
integer width = 1751
integer height = 128
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217730
alignment alignment = center!
boolean focusrectangle = false
end type

