$PBExportHeader$w_sec_pesos.srw
$PBExportComments$Ventana para modificar pesos de áreas y secciones
forward
global type w_sec_pesos from Window
end type
type dw_2 from uo_dw_captura within w_sec_pesos
end type
type dw_1 from uo_dw_captura within w_sec_pesos
end type
type cb_2 from commandbutton within w_sec_pesos
end type
type uo_2 from uo_area within w_sec_pesos
end type
type uo_1 from uo_carrera within w_sec_pesos
end type
end forward

global type w_sec_pesos from Window
int X=833
int Y=361
int Width=2547
int Height=1729
boolean TitleBar=true
string Title="Pesos de Exámenes"
string MenuName="m_menu"
long BackColor=30976088
dw_2 dw_2
dw_1 dw_1
cb_2 cb_2
uo_2 uo_2
uo_1 uo_1
end type
global w_sec_pesos w_sec_pesos

on w_sec_pesos.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.uo_2=create uo_2
this.uo_1=create uo_1
this.Control[]={ this.dw_2,&
this.dw_1,&
this.cb_2,&
this.uo_2,&
this.uo_1}
end on

on w_sec_pesos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.uo_2)
destroy(this.uo_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_2.settransobject(gtr_sadm)
end event

event close;dw_1.event actualiza()
end event

type dw_2 from uo_dw_captura within w_sec_pesos
int X=37
int Y=949
int Width=2071
int Height=553
int TabOrder=0
string DataObject="dw_areas_peso"
end type

event carga;event actualiza()

return retrieve(uo_1.dw_carrera.object.cve_carrera[uo_1.dw_carrera.getrow()])
object.st_1.text=uo_1.dw_carrera.object.carrera[uo_1.dw_carrera.getrow()]
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type dw_1 from uo_dw_captura within w_sec_pesos
int X=37
int Y=185
int Width=2071
int Height=729
int TabOrder=0
string DataObject="dw_sec_peso"
end type

event actualiza;call super::actualiza;return dw_2.event actualiza()
end event

event borra;int i=0
end event

event carga;//event actualiza()

dw_2.event carga()

return retrieve(uo_1.dw_carrera.object.cve_carrera[uo_1.dw_carrera.getrow()],&
	uo_2.dw_area.object.clv_area[uo_2.dw_area.getrow()])
object.st_1.text=uo_1.dw_carrera.object.carrera[uo_1.dw_carrera.getrow()]+' '+&
	uo_2.dw_area.object.area[uo_2.dw_area.getrow()]
end event

event nuevo;int i=0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type cb_2 from commandbutton within w_sec_pesos
int X=2209
int Y=357
int Width=261
int Height=109
string Text="Reporte"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;opensheet(w_pesos_rep,w_principal,4,Original!)
end event

type uo_2 from uo_area within w_sec_pesos
int X=1422
int Y=9
boolean Enabled=true
end type

on uo_2.destroy
call uo_area::destroy
end on

type uo_1 from uo_carrera within w_sec_pesos
int X=19
int Y=9
boolean Enabled=true
end type

on uo_1.destroy
call uo_carrera::destroy
end on

