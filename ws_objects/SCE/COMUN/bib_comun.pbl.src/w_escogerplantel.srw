$PBExportHeader$w_escogerplantel.srw
forward
global type w_escogerplantel from window
end type
type ddlb_servidores from dropdownlistbox within w_escogerplantel
end type
end forward

global type w_escogerplantel from window
integer x = 832
integer y = 360
integer width = 1024
integer height = 820
boolean titlebar = true
string title = "Escoger Plantel"
boolean controlmenu = true
boolean minbox = true
long backcolor = 8421376
ddlb_servidores ddlb_servidores
end type
global w_escogerplantel w_escogerplantel

on w_escogerplantel.create
this.ddlb_servidores=create ddlb_servidores
this.Control[]={this.ddlb_servidores}
end on

on w_escogerplantel.destroy
destroy(this.ddlb_servidores)
end on

event open;x = 400
y = 100
string ls_servidores
int li_inicio = 1, li_final

ls_servidores = ProfileString(+gs_startupfile,gs_servidores,"SCE","")
if isnull(ls_servidores) then ls_servidores = ""
if ls_servidores <> "" then
	li_final = Pos(ls_servidores,",", li_inicio)
	do while li_final <> 0
		ddlb_servidores.AddItem(trim(mid(ls_servidores,li_inicio,li_final - li_inicio)))
		li_inicio = li_final + 1
		li_final = Pos(ls_servidores,",", li_inicio)
	loop 
	ddlb_servidores.AddItem(trim(mid(ls_servidores,li_inicio,len(ls_servidores) - li_inicio + 1 )))
end if


end event

type ddlb_servidores from dropdownlistbox within w_escogerplantel
integer x = 146
integer y = 84
integer width = 654
integer height = 484
integer taborder = 1
integer textsize = -9
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if (MessageBox("Atención", "¿Está seguro que desea cambiarse a "+&
			ddlb_servidores.Text(index)+"?",Question!,YesNo!,1)=1) then
	string ls_DBMS, ls_Database, ls_ServerName, ls_Prompt
	int li_res 
	ls_DBMS = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"DBMS","")
	ls_Database = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"Database","")
	ls_ServerName = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"ServerName","")
	ls_Prompt = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"Prompt","")
	li_res = SetProfileString (gs_startupfile,gs_sce, "DBMS", ls_DBMS )
	li_res += SetProfileString (gs_startupfile,gs_sce, "Database", ls_Database )
	li_res += SetProfileString (gs_startupfile,gs_sce, "ServerName", ls_ServerName )
	li_res += SetProfileString (gs_startupfile,gs_sce, "Prompt", ls_Prompt)
	li_res += SetProfileString (gs_startupfile,gs_servidores, "Actual",ddlb_servidores.Text(index))
	if li_res = 5 then
		Messagebox("Atención", "La próxima vez que entre al sistema será al de :"+&
		ddlb_servidores.Text(index))
	end if
end if
end event

