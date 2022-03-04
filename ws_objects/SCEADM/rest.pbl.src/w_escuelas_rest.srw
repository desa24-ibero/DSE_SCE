$PBExportHeader$w_escuelas_rest.srw
forward
global type w_escuelas_rest from Window
end type
type cb_1 from commandbutton within w_escuelas_rest
end type
type uo_1 from uo_ver_per_ani within w_escuelas_rest
end type
type dw_1 from uo_dw_reporte within w_escuelas_rest
end type
end forward

global type w_escuelas_rest from Window
int X=833
int Y=361
int Width=3635
int Height=1965
boolean TitleBar=true
string Title="Resultados por Escuelas del Rest"
string MenuName="m_menu"
long BackColor=30976088
cb_1 cb_1
uo_1 uo_1
dw_1 dw_1
end type
global w_escuelas_rest w_escuelas_rest

on w_escuelas_rest.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_1=create cb_1
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.cb_1,&
this.uo_1,&
this.dw_1}
end on

on w_escuelas_rest.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type cb_1 from commandbutton within w_escuelas_rest
int X=2579
int Y=49
int Width=737
int Height=109
int TabOrder=1
string Text="Filtra escuelas de estudio"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string filtro

filtro= "total_escuela>15 and general_bachillera in (4,5,6,7,9,18,20,21,26,31,34,37,38,40,46,51,54,56,59,60,63,&
			66,74,78,88,98,100,109,124,134,178,181,232,237,238,243,249,306,313,332,348,372,424,&
			426,444,446,453,663,680,688)"
dw_1.SetFilter(filtro)
dw_1.Filter( )
end event

type uo_1 from uo_ver_per_ani within w_escuelas_rest
int X=28
int Y=25
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_escuelas_rest
int X=19
int Y=201
int Width=3521
int Height=1581
int TabOrder=0
string DataObject="dw_escuelas_rest"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;event primero()
object.st_1.text=parent.title+' '+tit1
return retrieve(gi_version,gi_periodo,gi_anio)
end event

event constructor;call super::constructor;DataWindowChild bachi
getchild("general_bachillera",bachi)
bachi.settransobject(gtr_sce)
bachi.retrieve()

end event

