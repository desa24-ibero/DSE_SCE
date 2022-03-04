$PBExportHeader$w_pfcsecurity_login_sce.srw
forward
global type w_pfcsecurity_login_sce from w_response
end type
type p_logo from picture within w_pfcsecurity_login_sce
end type
type st_plantel from statictext within w_pfcsecurity_login_sce
end type
type dw_info from u_dw within w_pfcsecurity_login_sce
end type
type cb_ok from u_cb within w_pfcsecurity_login_sce
end type
type cb_cancel from u_cb within w_pfcsecurity_login_sce
end type
end forward

global type w_pfcsecurity_login_sce from w_response
integer x = 1431
integer y = 884
integer width = 2171
integer height = 784
string title = "Database Login"
long backcolor = 77956459
p_logo p_logo
st_plantel st_plantel
dw_info dw_info
cb_ok cb_ok
cb_cancel cb_cancel
end type
global w_pfcsecurity_login_sce w_pfcsecurity_login_sce

type variables
Protected:
string is_ini_file
end variables

event open;call super::open;string ls_test
is_ini_file = gnv_app.of_getappinifile ( )

dw_info.reset()
dw_info.insertrow(0)
ls_test = ProfileString(is_ini_file,"SCE_Database","DBMS", "not found")
if ls_test = "not found" then
	messagebox(gnv_app.iapp_object.displayname,'Unable to open INI file "'+is_ini_file+'".~r~nHalting.',stopsign!)
	halt close
	return
end if

dw_info.object.DBMS[1]       =ls_test
dw_info.object.Database[1]   =ProfileString(is_ini_file,"SCE_Database","DataBase",         " ")
dw_info.object.LogID[1]      =ProfileString(is_ini_file,"SCE_Database","LogID",            " ")
//dw_info.object.LogPass[1]    =ProfileString(is_ini_file,"SCE_Database","LogPass",      " ")
dw_info.object.ServerName[1] =ProfileString(is_ini_file,"SCE_Database","ServerName",       " ")
dw_info.object.UserID[1]     =ProfileString(is_ini_file,"SCE_Database","UserID",           " ")
//dw_info.object.DBPass[1]    =ProfileString(is_ini_file,"SCE_Database","DbPass", " ")
dw_info.object.Lock[1]       =ProfileString(is_ini_file,"SCE_Database","Lock",             " ")
dw_info.object.DbParm[1]     =ProfileString(is_ini_file,"SCE_Database","DbParm",           " ")

this.of_setbase(true)
inv_base.of_center()



// Se verifica el plantel actual.
STRING ls_plantel
ls_plantel = ProfileString(is_ini_file,"Plantel","Plantel", "Ciudad_de_Mexico") 

IF ls_plantel = "Ciudad_de_Mexico" THEN 
	p_logo.PictureName = "anEscudo-Logo.png"
	st_plantel.TEXT = "Plantel Ciudad de México"
	dw_info.MODIFY("logid_t_red.visible = 0")
	dw_info.MODIFY("logpass_t_red.visible = 0")		
ELSE
	p_logo.PictureName = "anEscudo-Logo_Tijuana.png"
	st_plantel.TEXT = "Plantel Tijuana"
	st_plantel.TEXTCOLOR = RGB(200,50,50)
//	dw_info.MODIFY("logid_t.TextColor = 3289800")
//	dw_info.MODIFY("logpass_t.TextColor = 3289800")	
	dw_info.MODIFY("logid_t.visible = 0")
	dw_info.MODIFY("logpass_t.visible = 0")	
END IF



end event

on w_pfcsecurity_login_sce.create
int iCurrent
call super::create
this.p_logo=create p_logo
this.st_plantel=create st_plantel
this.dw_info=create dw_info
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.p_logo
this.Control[iCurrent+2]=this.st_plantel
this.Control[iCurrent+3]=this.dw_info
this.Control[iCurrent+4]=this.cb_ok
this.Control[iCurrent+5]=this.cb_cancel
end on

on w_pfcsecurity_login_sce.destroy
call super::destroy
destroy(this.p_logo)
destroy(this.st_plantel)
destroy(this.dw_info)
destroy(this.cb_ok)
destroy(this.cb_cancel)
end on

type p_logo from picture within w_pfcsecurity_login_sce
integer x = 78
integer y = 200
integer width = 887
integer height = 428
boolean originalsize = true
boolean focusrectangle = false
end type

type st_plantel from statictext within w_pfcsecurity_login_sce
integer x = 105
integer y = 36
integer width = 2011
integer height = 100
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
long backcolor = 67108864
string text = "Plantel Ciudad de México"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_info from u_dw within w_pfcsecurity_login_sce
integer x = 992
integer y = 200
integer width = 1088
integer height = 240
integer taborder = 30
string dataobject = "d_pfcsecurity_login_info_sce"
boolean vscrollbar = false
boolean border = false
boolean livescroll = false
borderstyle borderstyle = stylebox!
end type

event pfc_prermbmenu;call super::pfc_prermbmenu;// Set up the PopUp Menu.
am_dw.m_table.m_dash11.visible = false
am_dw.m_table.m_insert.visible = False
am_dw.m_table.m_addrow.visible = False
am_dw.m_table.m_delete.visible = False

end event

event constructor;call super::constructor;of_setupdateable(false)
end event

type cb_ok from u_cb within w_pfcsecurity_login_sce
integer x = 1143
integer y = 512
integer taborder = 10
string text = "OK"
boolean default = true
end type

event clicked;integer li_usuario_autorizado


if dw_info.accepttext() = -1 then return


gnv_app.inv_trans.DBMS       =dw_info.object.DBMS[1]
gnv_app.inv_trans.Database   =dw_info.object.DataBase[1]
gnv_app.inv_trans.LogID      =dw_info.object.Logid[1]
gnv_app.inv_trans.LogPass    =dw_info.object.LogPass[1]
gnv_app.inv_trans.ServerName =dw_info.object.ServerName[1]
gnv_app.inv_trans.UserID     =dw_info.object.UserID[1]
gnv_app.inv_trans.DBPass     =dw_info.object.DbPass[1]
gnv_app.inv_trans.Lock       =dw_info.object.Lock[1]
gnv_app.inv_trans.DbParm     =dw_info.object.DbParm[1]

connect using gnv_app.inv_trans;

if gnv_app.inv_trans.sqlcode <> 0 then
	MessageBox("Conexión Incorrecta", "El password escrito es inválido")
	
	// error on connect
	return
else
	gs_usuario=gnv_app.inv_trans.LogID
	gs_password=gnv_app.inv_trans.LogPass
	li_usuario_autorizado= f_usuario_valido_aplicacion(GetApplication().appname, &
	                       gs_usuario, gnv_app.inv_trans)
	choose case li_usuario_autorizado								  
		case 0
			MessageBox("Acceso no Permitido", "El usuario firmado no puede accesar esta aplicacion", StopSign!)
			disconnect using gnv_app.inv_trans;
			return
		case -1
			MessageBox("Acceso no Permitido", "Favor de volver a intentar", StopSign!)
			disconnect using gnv_app.inv_trans;
			return
	end choose			
end if

if dw_info.modifiedcount() > 0 then
	setprofilestring(is_ini_file,'SCE_Database','DBMS',gnv_app.inv_trans.dbms)
	setprofilestring(is_ini_file,'SCE_Database','Database',gnv_app.inv_trans.database)
	setprofilestring(is_ini_file,'SCE_Database','logid',gnv_app.inv_trans.logid)
	setprofilestring(is_ini_file,'SCE_Database','logpass',gnv_app.inv_trans.logpass)
	setprofilestring(is_ini_file,'SCE_Database','servername',gnv_app.inv_trans.servername)
	setprofilestring(is_ini_file,'SCE_Database','userid',gnv_app.inv_trans.userid)
	setprofilestring(is_ini_file,'SCE_Database','DBPass',gnv_app.inv_trans.DBPass)
	setprofilestring(is_ini_file,'SCE_Database','lock',gnv_app.inv_trans.lock)
	setprofilestring(is_ini_file,'SCE_Database','DBparm',gnv_app.inv_trans.dbparm)
end if

close(parent)

end event

type cb_cancel from u_cb within w_pfcsecurity_login_sce
integer x = 1586
integer y = 512
integer taborder = 20
string text = "Cancel"
boolean cancel = true
end type

event clicked;call super::clicked;close(parent)
end event

