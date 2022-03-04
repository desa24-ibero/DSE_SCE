$PBExportHeader$w_bita_bachi.srw
$PBExportComments$Permite manipular la bitácora de promedios de bachillerato
forward
global type w_bita_bachi from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_bita_bachi
end type
type dw_1 from uo_dw_captura within w_bita_bachi
end type
type cb_2 from commandbutton within w_bita_bachi
end type
type uo_1 from uo_ver_per_ani within w_bita_bachi
end type
end forward

global type w_bita_bachi from Window
int X=161
int Y=602
int Width=2725
int Height=1962
boolean TitleBar=true
string Title="Bitácora de Promedios de Bachillerato"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
dw_1 dw_1
cb_2 cb_2
uo_1 uo_1
end type
global w_bita_bachi w_bita_bachi

on w_bita_bachi.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.dw_1=create dw_1
this.cb_2=create cb_2
this.uo_1=create uo_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.dw_1,&
this.cb_2,&
this.uo_1}
end on

on w_bita_bachi.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.uo_1)
end on

event open;/*Al abrir la ventana colócala en la esq. superior izquierda*/
x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

event close;/*Antes de cerrar la ventana verifica que no se pierdan cambios*/
dw_1.event actualiza()
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_bita_bachi
int X=2308
int Y=26
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type dw_1 from uo_dw_captura within w_bita_bachi
int X=29
int Y=186
int Width=2041
int Height=1584
int TabOrder=0
string DataObject="dw_bita_bachi"
end type

event nuevo;int i=0
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_bita_bachi"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_bita_bachi_ing"
	this.SetTransObject(gtr_sadm)	
END IF

if event actualiza()=1 then
	event primero()
	return retrieve(gi_version,gi_periodo,gi_anio)
end if
end event

type cb_2 from commandbutton within w_bita_bachi
int X=2114
int Y=218
int Width=560
int Height=109
int TabOrder=20
string Text="Borra Primeros"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int cont

dw_1.scrolltorow(1)
FOR cont=dw_1.rowcount() to 1 step -1
	if isnull(dw_1.object.anterior[cont]) then
		dw_1.deleterow(cont)
	end if
NEXT

end event

type uo_1 from uo_ver_per_ani within w_bita_bachi
int X=22
int Y=10
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

