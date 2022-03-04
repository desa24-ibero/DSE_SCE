$PBExportHeader$w_rep_cortes.srw
$PBExportComments$Ventana que hace un reporte de los lugares obtenidos
forward
global type w_rep_cortes from Window
end type
type ddlb_opcion from dropdownlistbox within w_rep_cortes
end type
type uo_1 from uo_ver_per_ani within w_rep_cortes
end type
type dw_1 from uo_dw_reporte within w_rep_cortes
end type
end forward

global type w_rep_cortes from Window
int X=833
int Y=361
int Width=3708
int Height=1965
boolean TitleBar=true
string Title="Reporte para Cortes"
string MenuName="m_menu"
long BackColor=30976088
ddlb_opcion ddlb_opcion
uo_1 uo_1
dw_1 dw_1
end type
global w_rep_cortes w_rep_cortes

on w_rep_cortes.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.ddlb_opcion=create ddlb_opcion
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.ddlb_opcion,&
this.uo_1,&
this.dw_1}
end on

on w_rep_cortes.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.ddlb_opcion)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type ddlb_opcion from dropdownlistbox within w_rep_cortes
int X=2579
int Y=49
int Width=398
int Height=229
int TabOrder=11
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"NORMAL",&
"DIFERIDOS"}
end type

type uo_1 from uo_ver_per_ani within w_rep_cortes
int X=69
int Y=17
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_rep_cortes
int X=19
int Y=193
int Width=3649
int Height=1597
int TabOrder=0
string DataObject="dw_rep_cortes"
end type

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()
end event

event carga;int opcion

event primero()

IF ddlb_opcion.text='DIFERIDOS' THEN
	opcion=1
else
	opcion=0
END IF

object.st_1.text='Reporte de Resultados y Lugares Obtenidos:  '+tit1
return retrieve(gi_version,gi_periodo,gi_anio,opcion)

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

