$PBExportHeader$w_reporte_departamentos_extraor.srw
forward
global type w_reporte_departamentos_extraor from w_ancestral
end type
type dw_reporte_departamentos_extraor from uo_dw_reporte within w_reporte_departamentos_extraor
end type
type rb_pos from radiobutton within w_reporte_departamentos_extraor
end type
type rb_lic from radiobutton within w_reporte_departamentos_extraor
end type
type rb_tit from radiobutton within w_reporte_departamentos_extraor
end type
type rb_extra from radiobutton within w_reporte_departamentos_extraor
end type
type gb_1 from groupbox within w_reporte_departamentos_extraor
end type
type cb_1 from commandbutton within w_reporte_departamentos_extraor
end type
type uo_1 from uo_per_ani within w_reporte_departamentos_extraor
end type
end forward

global type w_reporte_departamentos_extraor from w_ancestral
int Height=1853
boolean TitleBar=true
string Title="Reporte de Exámenes"
string MenuName="m_menu"
dw_reporte_departamentos_extraor dw_reporte_departamentos_extraor
rb_pos rb_pos
rb_lic rb_lic
rb_tit rb_tit
rb_extra rb_extra
gb_1 gb_1
cb_1 cb_1
uo_1 uo_1
end type
global w_reporte_departamentos_extraor w_reporte_departamentos_extraor

on w_reporte_departamentos_extraor.create
int iCurrent
call w_ancestral::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_reporte_departamentos_extraor=create dw_reporte_departamentos_extraor
this.rb_pos=create rb_pos
this.rb_lic=create rb_lic
this.rb_tit=create rb_tit
this.rb_extra=create rb_extra
this.gb_1=create gb_1
this.cb_1=create cb_1
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=dw_reporte_departamentos_extraor
this.Control[iCurrent+2]=rb_pos
this.Control[iCurrent+3]=rb_lic
this.Control[iCurrent+4]=rb_tit
this.Control[iCurrent+5]=rb_extra
this.Control[iCurrent+6]=gb_1
this.Control[iCurrent+7]=cb_1
this.Control[iCurrent+8]=uo_1
end on

on w_reporte_departamentos_extraor.destroy
call w_ancestral::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_reporte_departamentos_extraor)
destroy(this.rb_pos)
destroy(this.rb_lic)
destroy(this.rb_tit)
destroy(this.rb_extra)
destroy(this.gb_1)
destroy(this.cb_1)
destroy(this.uo_1)
end on

event open;call super::open;dw_reporte_departamentos_extraor.settransobject(gtr_sce)
end event

type dw_reporte_departamentos_extraor from uo_dw_reporte within w_reporte_departamentos_extraor
int X=398
int Y=177
int Width=3173
int Height=1481
int TabOrder=20
string DataObject="dw_reporte_departamentos_extraor"
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

type rb_pos from radiobutton within w_reporte_departamentos_extraor
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

type rb_lic from radiobutton within w_reporte_departamentos_extraor
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

type rb_tit from radiobutton within w_reporte_departamentos_extraor
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

type rb_extra from radiobutton within w_reporte_departamentos_extraor
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

type gb_1 from groupbox within w_reporte_departamentos_extraor
int Y=837
int Width=494
int Height=361
int TabOrder=30
boolean Visible=false
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_1 from commandbutton within w_reporte_departamentos_extraor
int X=65
int Y=1501
int Width=247
int Height=109
int TabOrder=10
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

dw_reporte_departamentos_extraor.retrieve(li_nivel,li_opcion,gi_anio,gi_periodo)
end event

type uo_1 from uo_per_ani within w_reporte_departamentos_extraor
int X=439
int Y=1
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

