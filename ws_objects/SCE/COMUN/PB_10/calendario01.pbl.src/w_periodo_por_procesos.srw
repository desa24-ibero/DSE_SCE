$PBExportHeader$w_periodo_por_procesos.srw
forward
global type w_periodo_por_procesos from w_ancestral
end type
type dw_1 from uo_dw_captura within w_periodo_por_procesos
end type
type st_replica from statictext within w_periodo_por_procesos
end type
end forward

global type w_periodo_por_procesos from w_ancestral
integer width = 3758
integer height = 2572
string menuname = "m_periodo_procesos"
dw_1 dw_1
st_replica st_replica
end type
global w_periodo_por_procesos w_periodo_por_procesos

type variables

end variables

on w_periodo_por_procesos.create
int iCurrent
call super::create
if this.MenuName = "m_periodo_procesos" then this.MenuID = create m_periodo_procesos
this.dw_1=create dw_1
this.st_replica=create st_replica
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_replica
end on

on w_periodo_por_procesos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_replica)
end on

event open;call super::open;m_periodo_procesos.m_registro.m_nuevo.Visible = False
m_periodo_procesos.m_registro.m_nuevo.Enabled = False
m_periodo_procesos.m_registro.m_borraregistro.Visible = False
m_periodo_procesos.m_registro.m_borraregistro.Enabled = False
end event

type p_uia from w_ancestral`p_uia within w_periodo_por_procesos
end type

type dw_1 from uo_dw_captura within w_periodo_por_procesos
integer x = 37
integer y = 576
integer width = 3474
integer height = 1728
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_periodos_por_procesos_cap"
boolean resizable = true
end type

event constructor;call super::constructor;SetTransObject(gtr_sce)
tr_dw_propio = gtr_sce
end event

event carga;return retrieve(999)
end event

type st_replica from statictext within w_periodo_por_procesos
integer x = 3342
integer y = 160
integer width = 110
integer height = 88
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

event constructor;n_transfiere_sybase_sql_2 ln_transfiere_sybase_sql
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql_2
integer li_replica_activa, li_obten_parametros_replicacion
li_obten_parametros_replicacion = ln_transfiere_sybase_sql.of_obten_parametros_replica(li_replica_activa)
if li_replica_activa = 1 then
	THIS.text = 'A'
	THIS.BackColor =RGB(0,255,0)
else
	THIS.text = 'I'
	THIS.BackColor =RGB(255,0,0)
end if

end event

