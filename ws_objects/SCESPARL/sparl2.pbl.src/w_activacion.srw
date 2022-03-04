$PBExportHeader$w_activacion.srw
forward
global type w_activacion from window
end type
type st_replica from statictext within w_activacion
end type
type st_2 from statictext within w_activacion
end type
type st_1 from statictext within w_activacion
end type
type p_uia from picture within w_activacion
end type
type dw_act from datawindow within w_activacion
end type
type dw_act_su from datawindow within w_activacion
end type
end forward

global type w_activacion from window
integer x = 832
integer y = 360
integer width = 3648
integer height = 2436
boolean titlebar = true
string title = "Configuración de Reinscripción en Linea"
string menuname = "m_activacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 26439471
st_replica st_replica
st_2 st_2
st_1 st_1
p_uia p_uia
dw_act dw_act
dw_act_su dw_act_su
end type
global w_activacion w_activacion

type variables

uo_periodo_servicios iuo_periodo_servicios

end variables

event open;x = 1
y = 1

	dw_act.settransobject(gtr_sce) 
	dw_act.retrieve(gs_tipo_periodo) 
	
	dw_act_su.settransobject(gtr_sce) 
	dw_act_su.retrieve(gs_tipo_periodo) 
	dw_act.visible = false 
	dw_act_su.visible = true 



iuo_periodo_servicios = CREATE uo_periodo_servicios
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce)
iuo_periodo_servicios.f_carga_periodos_tipo(gtr_sce)

iuo_periodo_servicios.f_modifica_lista_columna( dw_act, 'periodo', 'L')
iuo_periodo_servicios.f_modifica_lista_columna( dw_act_su, 'periodo', 'L')

DATAWINDOWCHILD ldwc_tipo_periodo
DATAWINDOWCHILD ldwc_tipo_periodo_su

dw_act.GETCHILD('tipo_periodo', ldwc_tipo_periodo)
dw_act_su.GETCHILD('tipo_periodo', ldwc_tipo_periodo_su)

iuo_periodo_servicios.ids_tipo_periodos.ROWSCOPY(1, iuo_periodo_servicios.ids_tipo_periodos.ROWCOUNT(), PRIMARY!, ldwc_tipo_periodo, ldwc_tipo_periodo.ROWCOUNT() + 1, PRIMARY!)  
iuo_periodo_servicios.ids_tipo_periodos.ROWSCOPY(1, iuo_periodo_servicios.ids_tipo_periodos.ROWCOUNT(), PRIMARY!, ldwc_tipo_periodo_su, ldwc_tipo_periodo_su.ROWCOUNT() + 1, PRIMARY!)  









end event

on w_activacion.create
if this.MenuName = "m_activacion" then this.MenuID = create m_activacion
this.st_replica=create st_replica
this.st_2=create st_2
this.st_1=create st_1
this.p_uia=create p_uia
this.dw_act=create dw_act
this.dw_act_su=create dw_act_su
this.Control[]={this.st_replica,&
this.st_2,&
this.st_1,&
this.p_uia,&
this.dw_act,&
this.dw_act_su}
end on

on w_activacion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_replica)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.p_uia)
destroy(this.dw_act)
destroy(this.dw_act_su)
end on

type st_replica from statictext within w_activacion
integer x = 3442
integer y = 160
integer width = 110
integer height = 88
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

type st_2 from statictext within w_activacion
integer x = 55
integer y = 2048
integer width = 247
integer height = 44
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 26439471
boolean enabled = false
string text = "C. A. M. P."
boolean focusrectangle = false
end type

type st_1 from statictext within w_activacion
integer x = 3081
integer y = 2048
integer width = 306
integer height = 44
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 15793151
long backcolor = 26439471
boolean enabled = false
string text = "DkWf 1998"
boolean focusrectangle = false
end type

type p_uia from picture within w_activacion
integer x = 3442
integer y = 12
integer width = 110
integer height = 88
string picturename = "uia2.bmp"
boolean focusrectangle = false
end type

type dw_act from datawindow within w_activacion
integer x = 27
integer y = 148
integer width = 3374
integer height = 1876
integer taborder = 1
boolean titlebar = true
string title = "General"
string dataobject = "dw_activacion"
boolean livescroll = true
end type

type dw_act_su from datawindow within w_activacion
event constructor pbm_constructor
integer x = 55
integer y = 148
integer width = 3346
integer height = 1588
integer taborder = 1
boolean titlebar = true
string title = "Especial"
string dataobject = "dw_activacion_su"
boolean livescroll = true
end type

event constructor;m_activacion.dw = this
end event

