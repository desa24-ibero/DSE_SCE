$PBExportHeader$w_reset_banderas.srw
forward
global type w_reset_banderas from Window
end type
type cb_extension_creditos from commandbutton within w_reset_banderas
end type
type st_1 from statictext within w_reset_banderas
end type
type em_extension_creditos from editmask within w_reset_banderas
end type
type rb_desbloquear from radiobutton within w_reset_banderas
end type
type rb_bloquear from radiobutton within w_reset_banderas
end type
type cb_adeuda_finanzas from commandbutton within w_reset_banderas
end type
type em_cantidad_nivel from editmask within w_reset_banderas
end type
type cb_contar_nivel from commandbutton within w_reset_banderas
end type
type rb_posgrado from radiobutton within w_reset_banderas
end type
type rb_licenciatura from radiobutton within w_reset_banderas
end type
type gb_2 from groupbox within w_reset_banderas
end type
type gb_1 from groupbox within w_reset_banderas
end type
end forward

global type w_reset_banderas from Window
int X=845
int Y=371
int Width=2055
int Height=1229
boolean TitleBar=true
string Title="Reset de Banderas"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
cb_extension_creditos cb_extension_creditos
st_1 st_1
em_extension_creditos em_extension_creditos
rb_desbloquear rb_desbloquear
rb_bloquear rb_bloquear
cb_adeuda_finanzas cb_adeuda_finanzas
em_cantidad_nivel em_cantidad_nivel
cb_contar_nivel cb_contar_nivel
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
gb_2 gb_2
gb_1 gb_1
end type
global w_reset_banderas w_reset_banderas

type variables
string is_nivel = "L"
string is_nombre_nivel = "Licenciatura"
string is_bloqueo_finanzas = "Bloquear"
integer ii_adeuda_finanzas = 1
st_confirma_usuario ist_confirma_usuario
long il_creditos
end variables

on w_reset_banderas.create
this.cb_extension_creditos=create cb_extension_creditos
this.st_1=create st_1
this.em_extension_creditos=create em_extension_creditos
this.rb_desbloquear=create rb_desbloquear
this.rb_bloquear=create rb_bloquear
this.cb_adeuda_finanzas=create cb_adeuda_finanzas
this.em_cantidad_nivel=create em_cantidad_nivel
this.cb_contar_nivel=create cb_contar_nivel
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.gb_2=create gb_2
this.gb_1=create gb_1
this.Control[]={this.cb_extension_creditos,&
this.st_1,&
this.em_extension_creditos,&
this.rb_desbloquear,&
this.rb_bloquear,&
this.cb_adeuda_finanzas,&
this.em_cantidad_nivel,&
this.cb_contar_nivel,&
this.rb_posgrado,&
this.rb_licenciatura,&
this.gb_2,&
this.gb_1}
end on

on w_reset_banderas.destroy
destroy(this.cb_extension_creditos)
destroy(this.st_1)
destroy(this.em_extension_creditos)
destroy(this.rb_desbloquear)
destroy(this.rb_bloquear)
destroy(this.cb_adeuda_finanzas)
destroy(this.em_cantidad_nivel)
destroy(this.cb_contar_nivel)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type cb_extension_creditos from commandbutton within w_reset_banderas
int X=1346
int Y=790
int Width=560
int Height=106
int TabOrder=60
string Text="Establece Créditos"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_confirma, li_resultado_elimina
long ll_cant_alumnos
string ls_creditos
long ll_creditos

ls_creditos = em_extension_creditos.text 

IF NOT IsNumber(ls_creditos) THEN
	MessageBox("Créditos inválidos", "Favor de escribir un valor permitido", StopSign!)
	RETURN
ELSE
	ll_creditos= long(ls_creditos)
END IF

IF ll_creditos<0 THEN
	MessageBox("Créditos inválidos", "Favor de escribir un valor mayor a 0", StopSign!)
	RETURN
END IF

ll_cant_alumnos = f_cuenta_alumnos_nivel(is_nivel)

IF ll_cant_alumnos= -1 THEN
	RETURN	
END IF

em_cantidad_nivel.text = string(ll_cant_alumnos)

li_confirma=MessageBox("Confirme Actualización", "¿Desea establecer en ["+string(ll_creditos)+"] los creditos de los ["+string(ll_cant_alumnos)+"] alumnos de "+is_nombre_nivel+"?",Question!, YesNo!)
							 
IF li_confirma <> 1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF
END IF

SetPointer(HourGlass!)
li_resultado_elimina= f_actualiza_creditos(is_nivel, ll_creditos)

IF li_resultado_elimina <> -1 THEN	
	MessageBox("Actualización Exitosa", "El proceso modifico a los créditos de los alumnos exitosamente", Information!)
	RETURN
END IF

end event

type st_1 from statictext within w_reset_banderas
int X=775
int Y=624
int Width=614
int Height=77
boolean Enabled=false
string Text="Extensión de Créditos:"
Alignment Alignment=Right!
boolean FocusRectangle=false
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_extension_creditos from editmask within w_reset_banderas
int X=1430
int Y=602
int Width=391
int Height=106
int TabOrder=40
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###"
long BackColor=33554431
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type rb_desbloquear from radiobutton within w_reset_banderas
int X=216
int Y=582
int Width=424
int Height=77
string Text="Desbloquear"
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_adeuda_finanzas=0
is_bloqueo_finanzas = "Desbloquear"
end event

type rb_bloquear from radiobutton within w_reset_banderas
int X=216
int Y=499
int Width=325
int Height=77
string Text="Bloquear"
boolean Checked=true
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ii_adeuda_finanzas=1
is_bloqueo_finanzas = "Bloquear"
end event

type cb_adeuda_finanzas from commandbutton within w_reset_banderas
int X=187
int Y=790
int Width=512
int Height=106
int TabOrder=60
string Text="Adeuda Finanzas"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;integer li_confirma, li_resultado_elimina
long ll_cant_alumnos

ll_cant_alumnos = f_cuenta_alumnos_nivel(is_nivel)

IF ll_cant_alumnos= -1 THEN
	RETURN	
END IF

em_cantidad_nivel.text = string(ll_cant_alumnos)

li_confirma=MessageBox("Confirme Actualización", "¿Desea " + is_bloqueo_finanzas+ " los ["+string(ll_cant_alumnos)+"] alumnos?",Question!, YesNo!)
							 
IF li_confirma <> 1 THEN
	RETURN
ELSE
	Open(w_confirma_usuario)
	ist_confirma_usuario = Message.PowerObjectParm
	IF not (ist_confirma_usuario.usuario = gs_usuario and ist_confirma_usuario.password = gs_password) THEN
		MessageBox("Usuario Distinto", "El usuario escrito no es el mismo que se registró originalmente", StopSign!)
		RETURN
	END IF
END IF

SetPointer(HourGlass!)
li_resultado_elimina= f_actualiza_adeuda_finanzas(is_nivel, ii_adeuda_finanzas)

IF li_resultado_elimina <> -1 THEN	
	MessageBox("Actualización Exitosa", "El proceso de "+is_bloqueo_finanzas+" modifico a los alumnos exitosamente", Information!)
	RETURN
END IF

end event

type em_cantidad_nivel from editmask within w_reset_banderas
int X=1430
int Y=90
int Width=391
int Height=106
int TabOrder=30
Alignment Alignment=Right!
BorderStyle BorderStyle=StyleLowered!
string Mask="###,###"
string Text="0"
long BackColor=33554431
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_contar_nivel from commandbutton within w_reset_banderas
int X=1009
int Y=90
int Width=380
int Height=106
int TabOrder=10
string Text="Contar Nivel"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;long ll_cuenta_alumnos


ll_cuenta_alumnos = f_cuenta_alumnos_nivel(is_nivel)

IF ll_cuenta_alumnos = -1 THEN
	RETURN	
END IF


em_cantidad_nivel.text= string(ll_cuenta_alumnos)
end event

type rb_posgrado from radiobutton within w_reset_banderas
int X=219
int Y=160
int Width=417
int Height=77
string Text="Posgrado"
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_nivel = "P"
is_nombre_nivel = "Posgrado"

end event

type rb_licenciatura from radiobutton within w_reset_banderas
int X=219
int Y=90
int Width=417
int Height=77
string Text="Licenciatura"
boolean Checked=true
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;is_nivel = "L"
is_nombre_nivel = "Licenciatura"

end event

type gb_2 from groupbox within w_reset_banderas
int X=183
int Y=422
int Width=512
int Height=285
int TabOrder=50
string Text="Finanzas"
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_reset_banderas
int X=183
int Y=26
int Width=516
int Height=240
int TabOrder=20
string Text="Nivel"
long BackColor=79741120
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

