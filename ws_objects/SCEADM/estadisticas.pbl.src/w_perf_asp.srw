$PBExportHeader$w_perf_asp.srw
$PBExportComments$Perfiles de aspirantes (TODOS)
forward
global type w_perf_asp from Window
end type
type cbx_dif_insc from checkbox within w_perf_asp
end type
type cbx_dife from checkbox within w_perf_asp
end type
type cbx_inscr from checkbox within w_perf_asp
end type
type cbx_acep from checkbox within w_perf_asp
end type
type cbx_rech from checkbox within w_perf_asp
end type
type uo_2 from uo_carrera within w_perf_asp
end type
type uo_1 from uo_ver_per_ani within w_perf_asp
end type
type dw_1 from uo_dw_reporte within w_perf_asp
end type
end forward

global type w_perf_asp from Window
int X=833
int Y=361
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Perfil Aspirante"
string MenuName="m_menu"
long BackColor=30976088
cbx_dif_insc cbx_dif_insc
cbx_dife cbx_dife
cbx_inscr cbx_inscr
cbx_acep cbx_acep
cbx_rech cbx_rech
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_perf_asp w_perf_asp

type variables

end variables

on w_perf_asp.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_dif_insc=create cbx_dif_insc
this.cbx_dife=create cbx_dife
this.cbx_inscr=create cbx_inscr
this.cbx_acep=create cbx_acep
this.cbx_rech=create cbx_rech
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.cbx_dif_insc,&
this.cbx_dife,&
this.cbx_inscr,&
this.cbx_acep,&
this.cbx_rech,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_perf_asp.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_dif_insc)
destroy(this.cbx_dife)
destroy(this.cbx_inscr)
destroy(this.cbx_acep)
destroy(this.cbx_rech)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type cbx_dif_insc from checkbox within w_perf_asp
int X=1623
int Y=173
int Width=334
int Height=77
string Text="Dif. Inscr."
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_dife from checkbox within w_perf_asp
int X=1322
int Y=173
int Width=279
int Height=77
string Text="Diferido"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_inscr from checkbox within w_perf_asp
int X=1025
int Y=173
int Width=275
int Height=77
string Text="Inscrito"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_acep from checkbox within w_perf_asp
int X=650
int Y=173
int Width=353
int Height=77
string Text="Aceptado"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_rech from checkbox within w_perf_asp
int X=247
int Y=173
int Width=380
int Height=77
string Text="Rechazado"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_2 from uo_carrera within w_perf_asp
int X=2305
int Y=9
boolean Enabled=true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_perf_asp
int X=5
int Y=5
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_perf_asp
int X=37
int Y=257
int Width=3612
int Height=1545
int TabOrder=0
string DataObject="dw_perfiles"
end type

event carga;string status

status=""

if cbx_rech.checked then
	status="0"+status
end if

if cbx_acep.checked then
	status="1"+status
end if

if cbx_inscr.checked then
	status="2"+status
end if

if cbx_dife.checked then
	status="3"+status
end if

if cbx_dif_insc.checked then
	status="4"+status
end if

event primero()
object.st_1.text=uo_2.dw_carrera.object.carrera[uo_2.dw_carrera.getrow()]+' '+tit1+' '+status
return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()],status)
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

