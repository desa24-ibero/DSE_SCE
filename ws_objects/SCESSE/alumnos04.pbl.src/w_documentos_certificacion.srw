$PBExportHeader$w_documentos_certificacion.srw
forward
global type w_documentos_certificacion from Window
end type
type uo_nombre_adm from uo_nombre_alumno_adm within w_documentos_certificacion
end type
type rb_alumno from radiobutton within w_documentos_certificacion
end type
type cb_imprime_recibo from commandbutton within w_documentos_certificacion
end type
type uo_nombre from uo_nombre_alumno within w_documentos_certificacion
end type
type dw_telefono from datawindow within w_documentos_certificacion
end type
type r_1 from rectangle within w_documentos_certificacion
end type
type gb_tipo from groupbox within w_documentos_certificacion
end type
end forward

global type w_documentos_certificacion from Window
int X=4
int Y=3
int Width=3628
int Height=1280
boolean TitleBar=true
string Title="Documentos para Certificación"
string MenuName="m_documentos"
long BackColor=10789024
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean VScrollBar=true
boolean Resizable=true
uo_nombre_adm uo_nombre_adm
rb_alumno rb_alumno
cb_imprime_recibo cb_imprime_recibo
uo_nombre uo_nombre
dw_telefono dw_telefono
r_1 r_1
gb_tipo gb_tipo
end type
global w_documentos_certificacion w_documentos_certificacion

event open;//g_nv_security.fnv_secure_window (this)

//if isnull(gi_numsadm) OR not (isvalid(gtr_sadm)) then gi_numsadm = 0
//if gi_numsadm <= 0 then
//	if conecta_bd(gtr_sadm,"sadm",gs_usuario,gs_password)<>1 then
//		MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de cobranzas", StopSign!)
//		close(this)
//	end if
//end if
//gi_numsadm++
//
//uo_nombre_adm.dw_nombre_alumno.SetTransObject(gtr_sadm)
dw_telefono.settransobject(gtr_sce)
//dw_doc.settransobject(gtr_sce)
//dw_adeuda.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

end event

event doubleclicked;dw_telefono.retrieve(long(uo_nombre.em_cuenta.text))

//dw_doc.retrieve(long(uo_nombre.em_cuenta.text)) 

//dw_adeuda.retrieve(long(uo_nombre.em_cuenta.text))

//if keydown(keyenter!) or keydown(keyTab!) Then em_campo.setfocus()


end event

on w_documentos_certificacion.create
if this.MenuName = "m_documentos" then this.MenuID = create m_documentos
this.uo_nombre_adm=create uo_nombre_adm
this.rb_alumno=create rb_alumno
this.cb_imprime_recibo=create cb_imprime_recibo
this.uo_nombre=create uo_nombre
this.dw_telefono=create dw_telefono
this.r_1=create r_1
this.gb_tipo=create gb_tipo
this.Control[]={this.uo_nombre_adm,&
this.rb_alumno,&
this.cb_imprime_recibo,&
this.uo_nombre,&
this.dw_telefono,&
this.r_1,&
this.gb_tipo}
end on

on w_documentos_certificacion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre_adm)
destroy(this.rb_alumno)
destroy(this.cb_imprime_recibo)
destroy(this.uo_nombre)
destroy(this.dw_telefono)
destroy(this.r_1)
destroy(this.gb_tipo)
end on

event activate;control_escolar.toolbarsheettitle="Documentos"
end event

event close;//close(this)

if gi_numsadm = 1 then
	if desconecta_bd(gtr_sadm) <> 1 then
		return
	end if
end if
gi_numsadm --



end event

type uo_nombre_adm from uo_nombre_alumno_adm within w_documentos_certificacion
int X=77
int Y=32
int TabOrder=20
boolean Visible=false
boolean Enabled=true
end type

on uo_nombre_adm.destroy
call uo_nombre_alumno_adm::destroy
end on

type rb_alumno from radiobutton within w_documentos_certificacion
int X=1810
int Y=896
int Width=285
int Height=77
string Text="Alumno"
BorderStyle BorderStyle=StyleLowered!
boolean Checked=true
long TextColor=33554432
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//dw_adeuda.enabled = true
//dw_doc.enabled = true
dw_telefono.enabled = true
uo_nombre.enabled = true
r_1.enabled = true
//r_2.enabled = true
//dw_adeuda.visible = true
//dw_doc.visible = true
dw_telefono.visible = true
uo_nombre.visible = true
r_1.visible = true
//r_2.visible = true

uo_nombre_adm.enabled = false
uo_nombre_adm.visible = false
end event

type cb_imprime_recibo from commandbutton within w_documentos_certificacion
int X=1020
int Y=880
int Width=622
int Height=106
int TabOrder=30
string Text="Imprime Recibo"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_cuenta
if rb_alumno.checked = true then
	ll_cuenta = long(uo_nombre.em_cuenta.text)
else
	ll_cuenta = long(uo_nombre_adm.em_cuenta.text)
end if
if ll_cuenta <> 0 then
	openwithparm(w_recibo_documentos_certificacion,ll_cuenta)
else
	MessageBox("Aviso","No se puede generar el recibo de documentos de la cuenta 0")
end if
end event

type uo_nombre from uo_nombre_alumno within w_documentos_certificacion
int X=73
int Y=32
int TabOrder=10
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

event constructor;call super::constructor;m_documentos.objeto = this
end event

type dw_telefono from datawindow within w_documentos_certificacion
int X=183
int Y=480
int Width=3072
int Height=224
string DataObject="dw_tel_ing_doc"
boolean Border=false
boolean LiveScroll=true
end type

type r_1 from rectangle within w_documentos_certificacion
int X=91
int Y=458
int Width=3182
int Height=294
boolean Enabled=false
int LineThickness=3
long LineColor=15793151
long FillColor=10789024
end type

type gb_tipo from groupbox within w_documentos_certificacion
int X=1671
int Y=848
int Width=534
int Height=141
int TabOrder=40
string Text="Tipo"
BorderStyle BorderStyle=StyleLowered!
long TextColor=33554432
long BackColor=10789024
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

