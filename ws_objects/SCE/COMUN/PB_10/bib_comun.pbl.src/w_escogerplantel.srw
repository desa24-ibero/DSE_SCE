$PBExportHeader$w_escogerplantel.srw
forward
global type w_escogerplantel from Window
end type
type ddlb_servidores from dropdownlistbox within w_escogerplantel
end type
end forward

global type w_escogerplantel from Window
int X=833
int Y=361
int Width=1025
int Height=821
boolean TitleBar=true
string Title="Escoger Plantel"
long BackColor=8421376
boolean ControlMenu=true
boolean MinBox=true
ddlb_servidores ddlb_servidores
end type
global w_escogerplantel w_escogerplantel

on w_escogerplantel.create
this.ddlb_servidores=create ddlb_servidores
this.Control[]={ this.ddlb_servidores}
end on

on w_escogerplantel.destroy
destroy(this.ddlb_servidores)
end on

event open;x = 400
y = 100
string ls_servidores
int li_inicio = 1, li_final

ls_servidores = ProfileString(+gs_startupfile,"Servidores","SCE","")
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
int X=147
int Y=85
int Width=654
int Height=485
int TabOrder=1
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-9
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event selectionchanged;if (MessageBox("Atención", "¿Está seguro que desea cambiarse a "+&
			ddlb_servidores.Text(index)+"?",Question!,YesNo!,1)=1) then
	string ls_DBMS, ls_Database, ls_ServerName, ls_Prompt
	int li_res 
	ls_DBMS = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"DBMS","")
	ls_Database = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"Database","")
	ls_ServerName = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"ServerName","")
	ls_Prompt = ProfileString(gs_startupfile,ddlb_servidores.Text(index),"Prompt","")
	li_res = SetProfileString (gs_startupfile,"SCE", "DBMS", ls_DBMS )
	li_res += SetProfileString (gs_startupfile,"SCE", "Database", ls_Database )
	li_res += SetProfileString (gs_startupfile,"SCE", "ServerName", ls_ServerName )
	li_res += SetProfileString (gs_startupfile,"SCE", "Prompt", ls_Prompt)
	li_res += SetProfileString (gs_startupfile,"Servidores", "Actual",ddlb_servidores.Text(index))
	if li_res = 5 then
		Messagebox("Atención", "La próxima vez que entre al sistema será al de :"+&
		ddlb_servidores.Text(index))
	end if
end if
end event

