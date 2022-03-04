$PBExportHeader$w_seuia.srw
forward
global type w_seuia from w_ancestral
end type
type dw_programas_planteles from uo_dw_captura_con_transaction within w_seuia
end type
type ddlb_planteles from dropdownlistbox within w_seuia
end type
end forward

global type w_seuia from w_ancestral
integer width = 3301
integer height = 1944
string title = "SEUIA"
string menuname = "m_menu"
dw_programas_planteles dw_programas_planteles
ddlb_planteles ddlb_planteles
end type
global w_seuia w_seuia

on w_seuia.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_programas_planteles=create dw_programas_planteles
this.ddlb_planteles=create ddlb_planteles
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_programas_planteles
this.Control[iCurrent+2]=this.ddlb_planteles
end on

on w_seuia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_programas_planteles)
destroy(this.ddlb_planteles)
end on

event open;call super::open;dw_programas_planteles.event asignatransaction(gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_seuia
end type

type dw_programas_planteles from uo_dw_captura_con_transaction within w_seuia
integer x = 73
integer y = 440
integer width = 3003
boolean bringtotop = true
string dataobject = "d_programas_planteles"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event carga;int li_cve_plantel
SELECT cve_plantel INTO :li_cve_plantel FROM planteles WHERE actual = 1 using gtr_sce;
retrieve(li_cve_plantel)
end event

event nuevo;call super::nuevo;int li_cve_plantel
string ls_plantel
ls_plantel = ddlb_planteles.Text
if isnull(ls_plantel) then ls_plantel = ""
if ls_plantel <> "" then
	li_cve_plantel = Integer(Mid(ls_plantel,1,2))
	SetItem(RowCount(),"cve_plantel",li_cve_plantel)
else
	DeleteRow(RowCount())
	MessageBox("Atención","No se puede agregar un nuevo programa si no hay plantel seleccionado")
end if

end event

type ddlb_planteles from dropdownlistbox within w_seuia
integer x = 2222
integer y = 64
integer width = 850
integer height = 592
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;datastore	lds_planteles
int li_i

lds_planteles = CREATE DataStore
lds_planteles.DataObject = "d_planteles"
lds_Planteles.SetTransObject(gtr_sce)


if lds_planteles.retrieve() > 0 then
	for li_i = 1 to lds_planteles.rowcount()
		AddItem(string(lds_planteles.GetItemNumber(li_i,"cve_plantel"),"00")+"-"+lds_planteles.GetItemString(li_i,"plantel"))
	next
end if
DESTROY lds_planteles
end event

event selectionchanged;int li_cve_plantel
if index > 0 then
	li_cve_plantel = Integer(Mid(Text(index),1,2))
	dw_programas_planteles.Retrieve(li_cve_plantel)
end if
end event

