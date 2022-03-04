$PBExportHeader$w_consulta_becas_fin.srw
$PBExportComments$Consulta el porcetaje de apoyo de beca o financiamiento de un alumno o aspirante
forward
global type w_consulta_becas_fin from Window
end type
type st_porcentaje from statictext within w_consulta_becas_fin
end type
type uo_nombre_adm from uo_nombre_alumno_adm within w_consulta_becas_fin
end type
type rb_aspirante from radiobutton within w_consulta_becas_fin
end type
type rb_alumno from radiobutton within w_consulta_becas_fin
end type
type uo_nombre from uo_nombre_alumno within w_consulta_becas_fin
end type
type uo_1 from uo_per_ani within w_consulta_becas_fin
end type
type gb_tipo from groupbox within w_consulta_becas_fin
end type
end forward

global type w_consulta_becas_fin from Window
int X=845
int Y=371
int Width=3357
int Height=1101
boolean TitleBar=true
string Title="Consulta de apoyos de becas y financiamiento"
string MenuName="m_menu"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
event inicia_proceso ( )
st_porcentaje st_porcentaje
uo_nombre_adm uo_nombre_adm
rb_aspirante rb_aspirante
rb_alumno rb_alumno
uo_nombre uo_nombre
uo_1 uo_1
gb_tipo gb_tipo
end type
global w_consulta_becas_fin w_consulta_becas_fin

event inicia_proceso;long ll_cuenta
int li_porc
if rb_alumno.checked = true then
	ll_cuenta = long(uo_nombre.em_cuenta.text)
else
	ll_cuenta = long(uo_nombre_adm.em_cuenta.text)
end if
//MessageBox("",string(ll_cuenta)+"-"+obten_digito(ll_cuenta))


DECLARE proc_porcentaje_apoyo procedure for SYBFINPRO.becas_fin_bd.dbo.sp_porcentaje_apoyo
@cuenta = :ll_cuenta,
@anio = :gi_anio,
@periodo = :gi_periodo
USING gtr_sce;
fu_errorbd(gtr_sce, "DECLARE")

EXECUTE proc_porcentaje_apoyo;
fu_errorbd(gtr_sce, "EXECUTE")

FETCH  proc_porcentaje_apoyo INTO :li_porc;
//fu_errorbd(gtr_sce, "FETCH")

CLOSE proc_porcentaje_apoyo;
fu_errorbd(gtr_sce, "CLOSE")

st_porcentaje.text = "El porcentaje de apoyo para la cuenta "+&
			string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+" es "+string(li_porc)




end event

on w_consulta_becas_fin.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_porcentaje=create st_porcentaje
this.uo_nombre_adm=create uo_nombre_adm
this.rb_aspirante=create rb_aspirante
this.rb_alumno=create rb_alumno
this.uo_nombre=create uo_nombre
this.uo_1=create uo_1
this.gb_tipo=create gb_tipo
this.Control[]={this.st_porcentaje,&
this.uo_nombre_adm,&
this.rb_aspirante,&
this.rb_alumno,&
this.uo_nombre,&
this.uo_1,&
this.gb_tipo}
end on

on w_consulta_becas_fin.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_porcentaje)
destroy(this.uo_nombre_adm)
destroy(this.rb_aspirante)
destroy(this.rb_alumno)
destroy(this.uo_nombre)
destroy(this.uo_1)
destroy(this.gb_tipo)
end on

type st_porcentaje from statictext within w_consulta_becas_fin
int X=464
int Y=685
int Width=2578
int Height=205
boolean Enabled=false
string Text="El porcentaje de apoyo para la cuenta 0 es 0"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-18
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_nombre_adm from uo_nombre_alumno_adm within w_consulta_becas_fin
event destroy ( )
int X=55
int Y=221
int TabOrder=30
boolean Visible=false
end type

on uo_nombre_adm.destroy
call uo_nombre_alumno_adm::destroy
end on

type rb_aspirante from radiobutton within w_consulta_becas_fin
int X=2629
int Y=99
int Width=340
int Height=77
string Text="Aspirante"
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

event clicked;//dw_adeuda.enabled = false
//dw_doc.enabled = false
//dw_telefono.enabled = false
//uo_nombre.enabled = false
//r_1.enabled = false
//r_2.enabled = false
//dw_adeuda.visible = false
//dw_doc.visible = false
//dw_telefono.visible = false
//uo_nombre.visible = false
//r_1.visible = false
//r_2.visible = false

uo_nombre_adm.enabled = true
uo_nombre_adm.visible = true
end event

type rb_alumno from radiobutton within w_consulta_becas_fin
int X=2260
int Y=102
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
//dw_telefono.enabled = true
//uo_nombre.enabled = true
//r_1.enabled = true
//r_2.enabled = true
//dw_adeuda.visible = true
//dw_doc.visible = true
//dw_telefono.visible = true
//uo_nombre.visible = true
//r_1.visible = true
//r_2.visible = true

uo_nombre_adm.enabled = false
uo_nombre_adm.visible = false
end event

type uo_nombre from uo_nombre_alumno within w_consulta_becas_fin
int X=51
int Y=224
int TabOrder=20
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type uo_1 from uo_per_ani within w_consulta_becas_fin
int X=688
int Y=45
int TabOrder=10
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type gb_tipo from groupbox within w_consulta_becas_fin
int X=2015
int Y=64
int Width=1229
int Height=131
int TabOrder=30
string Text="tipo"
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

