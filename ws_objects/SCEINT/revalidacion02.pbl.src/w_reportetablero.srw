$PBExportHeader$w_reportetablero.srw
forward
global type w_reportetablero from w_ancestral
end type
type dw_reporte_tablero from uo_dw_reporte within w_reportetablero
end type
type rb_pos from radiobutton within w_reportetablero
end type
type rb_lic from radiobutton within w_reportetablero
end type
type rb_tit from radiobutton within w_reportetablero
end type
type rb_extra from radiobutton within w_reportetablero
end type
type gb_1 from groupbox within w_reportetablero
end type
type cb_1 from commandbutton within w_reportetablero
end type
type uo_1 from uo_per_ani within w_reportetablero
end type
end forward

global type w_reportetablero from w_ancestral
int Height=2341
boolean TitleBar=true
string Title="Reporte SEP"
string MenuName="m_menu"
dw_reporte_tablero dw_reporte_tablero
rb_pos rb_pos
rb_lic rb_lic
rb_tit rb_tit
rb_extra rb_extra
gb_1 gb_1
cb_1 cb_1
uo_1 uo_1
end type
global w_reportetablero w_reportetablero

on w_reportetablero.create
int iCurrent
call w_ancestral::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_reporte_tablero=create dw_reporte_tablero
this.rb_pos=create rb_pos
this.rb_lic=create rb_lic
this.rb_tit=create rb_tit
this.rb_extra=create rb_extra
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_reporte_tablero
this.Control[iCurrent+2]=rb_pos
this.Control[iCurrent+3]=rb_lic
this.Control[iCurrent+4]=rb_tit
this.Control[iCurrent+5]=rb_extra
this.Control[iCurrent+6]=gb_1
this.Control[iCurrent+7]=cb_1
this.Control[iCurrent+8]=uo_1
end on

on w_reportetablero.destroy
call w_ancestral::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_reporte_tablero)
destroy(this.rb_pos)
destroy(this.rb_lic)
destroy(this.rb_tit)
destroy(this.rb_extra)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;call super::open;dw_reporte_tablero.settransobject(gtr_sce)
end event

type dw_reporte_tablero from uo_dw_reporte within w_reportetablero
int X=380
int Y=245
int Width=3173
int Height=1453
int TabOrder=30
string DataObject="dw_reporte_tablero"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type rb_pos from radiobutton within w_reportetablero
int Y=449
int Width=380
int Height=77
boolean BringToTop=true
string Text="Posgrado"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_lic from radiobutton within w_reportetablero
int Y=585
int Width=380
int Height=77
boolean BringToTop=true
string Text="Licenciatura"
boolean Checked=true
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_tit from radiobutton within w_reportetablero
int Y=905
int Width=380
int Height=77
boolean BringToTop=true
string Text="Título"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_extra from radiobutton within w_reportetablero
int Y=1041
int Width=380
int Height=81
boolean BringToTop=true
string Text="Extraordinario"
boolean Checked=true
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_reportetablero
int Y=837
int Width=494
int Height=361
int TabOrder=40
boolean Visible=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_reportetablero
int X=65
int Y=1501
int Width=247
int Height=109
int TabOrder=20
boolean BringToTop=true
string Text="Carga"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;int li_opcion
string li_nivel

if rb_lic.checked then
	li_nivel="L"
else
	li_nivel="P"
end if

if rb_extra.checked then
	li_opcion=2
else
	li_opcion=6
end if

dw_reporte_tablero.retrieve(li_opcion,li_nivel,gi_periodo,gi_anio)
end event

type uo_1 from uo_per_ani within w_reportetablero
int X=426
int Y=33
int TabOrder=10
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

