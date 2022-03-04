$PBExportHeader$w_login.srw
forward
global type w_login from window
end type
type st_plantel from statictext within w_login
end type
type cb_2 from commandbutton within w_login
end type
type cb_1 from commandbutton within w_login
end type
type st_2 from statictext within w_login
end type
type st_1 from statictext within w_login
end type
type sle_password from singlelineedit within w_login
end type
type sle_usuario from singlelineedit within w_login
end type
end forward

global type w_login from window
integer width = 1339
integer height = 716
boolean titlebar = true
string title = "Acceso a generar XML"
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_plantel st_plantel
cb_2 cb_2
cb_1 cb_1
st_2 st_2
st_1 st_1
sle_password sle_password
sle_usuario sle_usuario
end type
global w_login w_login

forward prototypes
public function integer wf_login ()
end prototypes

public function integer wf_login ();gs_usuario  = Trim (sle_usuario.text)
gs_password = Trim (sle_password.text)

INTEGER le_existe

IF guo_conexion.conecta_bd() < 0 THEN RETURN -1 

// Se verifica si el usuario tiene permiso para usar la aplicación 
SELECT COUNT(*) 
INTO :le_existe 
FROM security_user_app 
WHERE user_name = :gs_usuario 
AND app_name = 'd2lxml'
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", SQLCA.SQLERRTEXT) 
	RETURN -1
END IF
guo_conexion.desconecta_bd() 
IF le_existe = 0 THEN 
	RETURN 100	
END IF 

RETURN 0  








end function

on w_login.create
this.st_plantel=create st_plantel
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_2=create st_2
this.st_1=create st_1
this.sle_password=create sle_password
this.sle_usuario=create sle_usuario
this.Control[]={this.st_plantel,&
this.cb_2,&
this.cb_1,&
this.st_2,&
this.st_1,&
this.sle_password,&
this.sle_usuario}
end on

on w_login.destroy
destroy(this.st_plantel)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.sle_password)
destroy(this.sle_usuario)
end on

event open;
STRING ls_plantel 

ls_plantel = ProfileString ("d2l_xml.ini", "PLANTEL", "Plantel", "")  
gs_plantel2 = ls_plantel 

IF ls_plantel = "CDMX" THEN 

	st_plantel.TEXT = "PLANTEL CIUDAD DE MÉXICO."
	gs_plantel = "PLANTEL CIUDAD DE MÉXICO."

ELSE
	
	st_plantel.TEXT = "PLANTEL TIJUANA." 
	gs_plantel = "PLANTEL TIJUANA." 
	st_plantel.TEXTCOLOR = RGB(200,50,50)
	st_1.TEXTCOLOR = RGB(200,50,50)
	st_2.TEXTCOLOR = RGB(200,50,50)

END IF


multiples_periodos = ProfileString ("d2l_xml.ini", "SCE", "multiplesperiodos", "N")  
gs_periodo_default = ProfileString ("d2l_xml.ini", "SCE", "periododefault", "S")  

gs_plantel = ls_plantel


end event

type st_plantel from statictext within w_login
integer x = 105
integer y = 48
integer width = 1166
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_login
integer x = 741
integer y = 464
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Cancelar"
end type

event clicked;
CLOSEWITHRETURN(PARENT, 100) 


end event

type cb_1 from commandbutton within w_login
integer x = 238
integer y = 464
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Aceptar"
end type

event clicked;
INTEGER le_retorno

IF TRIM(sle_usuario.TEXT) = "" OR TRIM(sle_password.TEXT) = "" THEN 
	MESSAGEBOX("Error", "Debe ingresar un Usuario y Contraseña.")	
	RETURN 0
END IF

le_retorno = wf_login() 

IF le_retorno = 100 THEN 
	MESSAGEBOX("Error", "El Usuario " + gs_usuario + " no tiene permitido el acceso a la aplicación. Revise el usuario y/o contraseña.")
ELSE
	CLOSEWITHRETURN(PARENT, le_retorno) 
END IF









end event

type st_2 from statictext within w_login
integer x = 178
integer y = 308
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Password: "
boolean focusrectangle = false
end type

type st_1 from statictext within w_login
integer x = 178
integer y = 200
integer width = 325
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
string text = "Usuario: "
boolean focusrectangle = false
end type

type sle_password from singlelineedit within w_login
integer x = 539
integer y = 300
integer width = 603
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
boolean password = true
borderstyle borderstyle = stylelowered!
end type

type sle_usuario from singlelineedit within w_login
integer x = 539
integer y = 188
integer width = 603
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
end type

