$PBExportHeader$w_sparl.srw
forward
global type w_sparl from window
end type
type mdi_1 from mdiclient within w_sparl
end type
end forward

global type w_sparl from window
integer x = 5
integer y = 4
integer width = 3657
integer height = 2400
boolean titlebar = true
string title = "Sistema de Reinscripción en Linea"
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 26964016
mdi_1 mdi_1
end type
global w_sparl w_sparl

on w_sparl.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_sparl.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;

string ls_plantel,ls_nombre
Integer li_return

ls_nombre=gs_usuario

setpointer(Hourglass!)

if Pos(usuario,"inscrip") > 0 then
	gi_nivel_usuario = 1
elseif Pos(usuario,"inscpos") > 0 then
	gi_nivel_usuario = 2
else
	gi_nivel_usuario = 13
end if

//SELECT first_name+' '+last_name
//INTO :ls_nombre
//FROM pc_user_def
//WHERE pc_user_def.user_id = :usuario USING gtr_sce;

SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :ls_nombre
USING gtr_sce;


SELECT plantel
INTO :ls_plantel
FROM planteles
WHERE actual = 1 USING gtr_sce;

//title=usuario+' '+ls_nombre+"  Plantel: "+ls_plantel
title= ' '+gs_usuario+' '+ls_nombre+' '+ '  Plantel: '+ls_plantel

//Seguridad via PFC


/**/gnv_app.of_SetSecurity(TRUE)
//Comentado para aprovechar el uso de una transaccion
//gnv_app.itr_security = CREATE n_tr
/**/gnv_app.itr_security = gtr_sce
/**/gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
//gnv_app.itr_security.of_Connect()

li_return = gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, &
gs_usuario, "Default")

gnv_app.inv_security.of_SetSecurity(this)



end event

type mdi_1 from mdiclient within w_sparl
long BackColor=276856960
end type

