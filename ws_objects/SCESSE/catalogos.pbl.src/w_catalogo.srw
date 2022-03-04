$PBExportHeader$w_catalogo.srw
forward
global type w_catalogo from Window
end type
type dw_catalogo from datawindow within w_catalogo
end type
end forward

global type w_catalogo from Window
int X=731
int Y=12
int Width=2112
int Height=1964
boolean TitleBar=true
string Title="Catalogos"
string MenuName="m_catalogo"
long BackColor=31436382
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
dw_catalogo dw_catalogo
end type
global w_catalogo w_catalogo

type variables

end variables

on w_catalogo.create
if this.MenuName = "m_catalogo" then this.MenuID = create m_catalogo
this.dw_catalogo=create dw_catalogo
this.Control[]={this.dw_catalogo}
end on

on w_catalogo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_catalogo)
end on

event open;dw_catalogo.settransobject(gtr_sce)
dw_catalogo.retrieve()
this.x=1
this.y=1
g_w_frame = this
gnv_app.inv_security.of_SetSecurity(this)
//g_nv_security.fnv_secure_window (this)
end event

event closequery;int resp
if dw_catalogo.modifiedcount() > 0 or dw_catalogo.deletedcount() > 0 then
	resp = messagebox("Aviso","Los cambios no han sido guardados.~n¿Desea guardarlos ahora?",question!,yesnocancel!)
	choose case resp
		case 1 
			m_catalogo.m_registro.m_actualiza.triggerevent(clicked!)			
		case 2
			dw_catalogo.resetupdate()
		case 3
			message.returnvalue = 1 
	end choose
end if
end event

event activate;control_escolar.toolbarsheettitle="Catalogos"
end event

event close;//IF IsValid (g_nv_security) THEN
//	g_nv_security.fnv_close_security ()
//END IF

end event

type dw_catalogo from datawindow within w_catalogo
int X=517
int Y=220
int Width=1083
int Height=1428
int TabOrder=1
string DataObject="dw_edo_civil"
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
end type

event constructor;m_catalogo.dw = this
end event

