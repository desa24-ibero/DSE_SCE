$PBExportHeader$w_fecha.srw
$PBExportComments$Ventana para cambiar fechas
forward
global type w_fecha from Window
end type
type uo_1 from uo_ver_per_ani within w_fecha
end type
type dw_1 from uo_dw_captura within w_fecha
end type
end forward

global type w_fecha from Window
int X=833
int Y=361
int Width=3671
int Height=1957
boolean TitleBar=true
string Title="Fechas de Actividades"
string MenuName="m_menu"
long BackColor=30976088
uo_1 uo_1
dw_1 dw_1
end type
global w_fecha w_fecha

type variables
int ord
end variables

on w_fecha.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.uo_1,&
this.dw_1}
end on

on w_fecha.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_1 from uo_ver_per_ani within w_fecha
int X=1
int Y=17
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_captura within w_fecha
int X=23
int Y=201
int Width=3447
int Height=1557
int TabOrder=20
string DataObject="dw_fecha"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

event nuevo;call super::nuevo;long ll_renglon

ll_renglon=rowcount()
object.clv_ver[ll_renglon]=gi_version
object.clv_per[ll_renglon]=gi_periodo
object.anio[ll_renglon]=gi_anio
end event

