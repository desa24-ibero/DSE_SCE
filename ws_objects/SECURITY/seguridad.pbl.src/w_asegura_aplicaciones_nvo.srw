$PBExportHeader$w_asegura_aplicaciones_nvo.srw
forward
global type w_asegura_aplicaciones_nvo from window
end type
type lb_usuario_actual from listbox within w_asegura_aplicaciones_nvo
end type
type p_1 from picture within w_asegura_aplicaciones_nvo
end type
type st_aplicaciones_existentes from statictext within w_asegura_aplicaciones_nvo
end type
type pb_quitar from picturebutton within w_asegura_aplicaciones_nvo
end type
type pb_agregar from picturebutton within w_asegura_aplicaciones_nvo
end type
type st_2 from statictext within w_asegura_aplicaciones_nvo
end type
type st_1 from statictext within w_asegura_aplicaciones_nvo
end type
type lb_usuarios_existentes from listbox within w_asegura_aplicaciones_nvo
end type
type lb_usuarios_con_permisos from listbox within w_asegura_aplicaciones_nvo
end type
type ddlb_aplicaciones from dropdownlistbox within w_asegura_aplicaciones_nvo
end type
end forward

global type w_asegura_aplicaciones_nvo from window
integer width = 2392
integer height = 1498
boolean titlebar = true
string title = "Asegura aplicaciones"
string menuname = "m_menu_salir"
boolean controlmenu = true
boolean minbox = true
long backcolor = 78682240
lb_usuario_actual lb_usuario_actual
p_1 p_1
st_aplicaciones_existentes st_aplicaciones_existentes
pb_quitar pb_quitar
pb_agregar pb_agregar
st_2 st_2
st_1 st_1
lb_usuarios_existentes lb_usuarios_existentes
lb_usuarios_con_permisos lb_usuarios_con_permisos
ddlb_aplicaciones ddlb_aplicaciones
end type
global w_asegura_aplicaciones_nvo w_asegura_aplicaciones_nvo

type variables

end variables

on w_asegura_aplicaciones_nvo.create
if this.MenuName = "m_menu_salir" then this.MenuID = create m_menu_salir
this.lb_usuario_actual=create lb_usuario_actual
this.p_1=create p_1
this.st_aplicaciones_existentes=create st_aplicaciones_existentes
this.pb_quitar=create pb_quitar
this.pb_agregar=create pb_agregar
this.st_2=create st_2
this.st_1=create st_1
this.lb_usuarios_existentes=create lb_usuarios_existentes
this.lb_usuarios_con_permisos=create lb_usuarios_con_permisos
this.ddlb_aplicaciones=create ddlb_aplicaciones
this.Control[]={this.lb_usuario_actual,&
this.p_1,&
this.st_aplicaciones_existentes,&
this.pb_quitar,&
this.pb_agregar,&
this.st_2,&
this.st_1,&
this.lb_usuarios_existentes,&
this.lb_usuarios_con_permisos,&
this.ddlb_aplicaciones}
end on

on w_asegura_aplicaciones_nvo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lb_usuario_actual)
destroy(this.p_1)
destroy(this.st_aplicaciones_existentes)
destroy(this.pb_quitar)
destroy(this.pb_agregar)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.lb_usuarios_existentes)
destroy(this.lb_usuarios_con_permisos)
destroy(this.ddlb_aplicaciones)
end on

event open;x = 1
y = 1
end event

type lb_usuario_actual from listbox within w_asegura_aplicaciones_nvo
integer x = 176
integer y = 1178
integer width = 2088
integer height = 90
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
end type

type p_1 from picture within w_asegura_aplicaciones_nvo
integer x = 15
integer y = 13
integer width = 421
integer height = 365
string picturename = "uia.bmp"
boolean focusrectangle = false
end type

type st_aplicaciones_existentes from statictext within w_asegura_aplicaciones_nvo
integer x = 560
integer y = 10
integer width = 695
integer height = 77
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78682240
boolean enabled = false
string text = "Aplicaciones Existentes"
long bordercolor = 27827287
boolean focusrectangle = false
end type

type pb_quitar from picturebutton within w_asegura_aplicaciones_nvo
integer x = 1075
integer y = 835
integer width = 304
integer height = 144
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "quitar.bmp"
alignment htextalign = left!
end type

event clicked;string ls_usuario_borrar, ls_aplicacion
DataStore lds_user_app
lds_user_app = Create DataStore
lds_user_app.DataObject = "ds_user_app"
lds_user_app.SetTransObject(gnv_app.inv_trans)

if lb_usuarios_con_permisos.SelectedItem() <> "" and ddlb_aplicaciones.text <> ""then
	ls_usuario_borrar =  lb_usuarios_con_permisos.SelectedItem()
	if (lb_usuarios_con_permisos.DeleteItem(lb_usuarios_con_permisos.SelectedIndex())>=0) then
      ls_aplicacion = Mid(ddlb_aplicaciones.text,1,Pos(ddlb_aplicaciones.text,".-")-1)
		if (lds_user_app.Retrieve(ls_usuario_borrar,ls_aplicacion,0) = 1) then
			lds_user_app.DeleteRow(1)
			if lds_user_app.Update() = 1 then
				commit using gnv_app.inv_trans;
			else
				rollback using gnv_app.inv_trans;
				MessageBox("Error de Comunicación","Error borrando usuarios BD. Favor de intentar nuevamente", None!)
				ddlb_aplicaciones.Event SelectionChanged(0)
			end if
		else	
			MessageBox("Error de Comunicación","Error consultando usuarios BD. Favor de intentar nuevamente", None!)
			ddlb_aplicaciones.Event SelectionChanged(0)
		end if

	end if
else
	MessageBox("Atención","Debe seleccionar un usuario y una aplicación", Exclamation!)
end if
Destroy lds_user_app

end event

type pb_agregar from picturebutton within w_asegura_aplicaciones_nvo
integer x = 1075
integer y = 637
integer width = 304
integer height = 144
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean originalsize = true
string picturename = "agregar.bmp"
vtextalign vtextalign = vcenter!
end type

event clicked;int li_user_skey, li_app_skey
string ls_usuario, ls_aplicacion

U_DataStore lds_convierte_id_name_a_skey,lds_user_app
lds_convierte_id_name_a_skey = Create U_DataStore
lds_convierte_id_name_a_skey.DataObject = "d_convierte_id_name_a_skey"
lds_convierte_id_name_a_skey.SetTransObject(gnv_app.inv_trans)

lds_user_app = Create U_DataStore
lds_user_app.DataObject = "ds_user_app"
lds_user_app.SetTransObject(gnv_app.inv_trans)

if lb_usuarios_existentes.SelectedItem() <> "" and ddlb_aplicaciones.text <> ""then
	if (lb_usuarios_con_permisos. event AddItem(lb_usuarios_existentes.SelectedItem()) > 0 ) then
//		if (lds_convierte_id_name_a_skey.Retrieve(lb_usuarios_existentes.SelectedItem() ,Mid(ddlb_aplicaciones.text,1,Pos(ddlb_aplicaciones.text,".-")-1)) = 1) then
			lds_user_app.InsertRow(0)
			ls_usuario = lb_usuarios_existentes.SelectedItem()
			ls_aplicacion = Mid(ddlb_aplicaciones.text,1,Pos(ddlb_aplicaciones.text,".-")-1)
			lds_user_app.SetItem(1,"security_user_app_app_name", ls_aplicacion )
			lds_user_app.SetItem(1,"security_user_app_user_name", ls_usuario)
			lds_user_app.SetItem(1,"security_user_app_permiso_modificar", 0)
			if lds_user_app.Update() = 1 then
				commit using gnv_app.inv_trans;
			else
				rollback using gnv_app.inv_trans;
				MessageBox("Error de Comunicación","Error insertando usuarios BD. Favor de intentar nuevamente", None!)
				ddlb_aplicaciones.Event SelectionChanged(0)
			end if
//		else	
//			MessageBox("Error de Comunicación","Error consultando usuarios BD. Favor de intentar nuevamente", None!)
//			ddlb_aplicaciones.Event SelectionChanged(0)
//		end if
	end if
else
	MessageBox("Atención","Debe seleccionar un usuario y una aplicación", Exclamation!)
end if
Destroy lds_convierte_id_name_a_skey
Destroy lds_user_app
end event

type st_2 from statictext within w_asegura_aplicaciones_nvo
integer x = 1393
integer y = 410
integer width = 691
integer height = 77
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78682240
boolean enabled = false
string text = "Usuarios con permiso"
long bordercolor = 27827287
boolean focusrectangle = false
end type

type st_1 from statictext within w_asegura_aplicaciones_nvo
integer x = 183
integer y = 410
integer width = 691
integer height = 77
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 78682240
boolean enabled = false
string text = "Usuarios Existentes"
long bordercolor = 27827287
boolean focusrectangle = false
end type

type lb_usuarios_existentes from listbox within w_asegura_aplicaciones_nvo
integer x = 183
integer y = 493
integer width = 870
integer height = 637
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event constructor;DataStore lds_user_def
int li_ret, li_i
lds_user_def = Create DataStore
lds_user_def.DataObject = "ds_users"
lds_user_def.SetTransObject(gnv_app.inv_trans)
li_ret = lds_user_def.Retrieve()
if li_ret >= 0 then
	for li_i = 1 to li_ret
		AddItem(	lds_user_def.GetItemString(li_i,"name"))
		lb_usuario_actual.AddItem(	lds_user_def.GetItemString(li_i,"name")+".-"+&
											lds_user_def.GetItemString(li_i,"description"))
	next
	if li_ret > 0 then SelectItem(1)
else
	MessageBox("Error de Comunicación","Error con la consulta de aplicaciones BD. Favor de intentar nuevamente", None!)
end if
Destroy lds_user_def
end event

event selectionchanged;lb_usuario_actual.SelectItem(index)
lb_usuario_actual.SelectItem (0)
end event

event doubleclicked;pb_agregar.event clicked()
end event

type lb_usuarios_con_permisos from listbox within w_asegura_aplicaciones_nvo
event type long additem ( string newitem )
integer x = 1393
integer y = 493
integer width = 870
integer height = 637
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event additem;int li_i
for li_i = 1 to TotalItems()
	if newitem = text(li_i) then 
		MessageBox("Aviso","El usuario ya está en la lista")
		return 0
	end if
next
return AddItem(newitem)
end event

event doubleclicked;pb_quitar.event clicked()
end event

type ddlb_aplicaciones from dropdownlistbox within w_asegura_aplicaciones_nvo
integer x = 560
integer y = 90
integer width = 1712
integer height = 320
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
boolean vscrollbar = true
end type

event constructor;DataStore lds_user_app
int li_ret, li_i
lds_user_app = Create DataStore
lds_user_app.DataObject = "ds_user_app"
lds_user_app.SetTransObject(gnv_app.inv_trans)
li_ret = lds_user_app.Retrieve(gs_usuario,".",1)
if li_ret >= 0 then
	for li_i = 1 to li_ret
		AddItem(	lds_user_app.GetItemString(li_i,"security_apps_application")+".-"+&
					lds_user_app.GetItemString(li_i,"security_apps_description"))
	next
else
	MessageBox("Error de Comunicación","Error con la consulta de aplicaciones BD. Favor de intentar nuevamente", None!)
end if
Destroy lds_user_app

end event

event selectionchanged;DataStore lds_user_app
int li_ret, li_i
string ls_usuario, ls_aplicacion

lb_usuarios_con_permisos.Reset()
lds_user_app = Create DataStore
lds_user_app.DataObject = "ds_user_app"
lds_user_app.SetTransObject(gnv_app.inv_trans)
ls_usuario = "."
ls_aplicacion =Mid(text,1,Pos(text,".-")-1)
li_ret = lds_user_app.Retrieve(ls_usuario, ls_aplicacion, 0)
if li_ret >= 0 then
	for li_i = 1 to li_ret
		lb_usuarios_con_permisos.AddItem(lds_user_app.GetItemString(li_i,"security_user_app_user_name"))
	next
else
	MessageBox("Error de Comunicación","Error con la consulta de usuarios BD. Favor de intentar nuevamente", None!)
end if
Destroy lds_user_app
end event

