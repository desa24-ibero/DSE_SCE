$PBExportHeader$w_invasor_hora.srw
forward
global type w_invasor_hora from window
end type
type p_1 from picture within w_invasor_hora
end type
type st_hora_actual from statictext within w_invasor_hora
end type
type st_hora_entrada from statictext within w_invasor_hora
end type
type st_cuenta from statictext within w_invasor_hora
end type
type st_2 from statictext within w_invasor_hora
end type
type sle_clave from singlelineedit within w_invasor_hora
end type
type st_1 from statictext within w_invasor_hora
end type
type oval_1 from oval within w_invasor_hora
end type
type rr_1 from roundrectangle within w_invasor_hora
end type
type oval_2 from oval within w_invasor_hora
end type
type r_1 from rectangle within w_invasor_hora
end type
end forward

global type w_invasor_hora from window
integer x = 1056
integer y = 484
integer width = 2702
integer height = 1716
windowtype windowtype = response!
windowstate windowstate = maximized!
long backcolor = 255
p_1 p_1
st_hora_actual st_hora_actual
st_hora_entrada st_hora_entrada
st_cuenta st_cuenta
st_2 st_2
sle_clave sle_clave
st_1 st_1
oval_1 oval_1
rr_1 rr_1
oval_2 oval_2
r_1 r_1
end type
global w_invasor_hora w_invasor_hora

type variables

end variables

on w_invasor_hora.create
this.p_1=create p_1
this.st_hora_actual=create st_hora_actual
this.st_hora_entrada=create st_hora_entrada
this.st_cuenta=create st_cuenta
this.st_2=create st_2
this.sle_clave=create sle_clave
this.st_1=create st_1
this.oval_1=create oval_1
this.rr_1=create rr_1
this.oval_2=create oval_2
this.r_1=create r_1
this.Control[]={this.p_1,&
this.st_hora_actual,&
this.st_hora_entrada,&
this.st_cuenta,&
this.st_2,&
this.sle_clave,&
this.st_1,&
this.oval_1,&
this.rr_1,&
this.oval_2,&
this.r_1}
end on

on w_invasor_hora.destroy
destroy(this.p_1)
destroy(this.st_hora_actual)
destroy(this.st_hora_entrada)
destroy(this.st_cuenta)
destroy(this.st_2)
destroy(this.sle_clave)
destroy(this.st_1)
destroy(this.oval_1)
destroy(this.rr_1)
destroy(this.oval_2)
destroy(this.r_1)
end on

event open;string ls_parm
ls_parm = Message.StringParm
st_cuenta.text = "Cuenta:" + string(long(Mid(ls_parm,1,10)))+"-"+obten_digito(long(Mid(ls_parm,1,10)))
st_hora_actual.text = Mid(ls_parm,11,19)
st_hora_entrada.text = "Hora entrada:" + Mid(ls_parm,30,19)

end event

type p_1 from picture within w_invasor_hora
integer x = 32
integer y = 32
integer width = 110
integer height = 92
boolean originalsize = true
string picturename = "uia2.bmp"
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type st_hora_actual from statictext within w_invasor_hora
integer x = 27
integer y = 124
integer width = 955
integer height = 100
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 255
boolean enabled = false
string text = "hh:mm am dd/mm/yyyy"
boolean focusrectangle = false
end type

type st_hora_entrada from statictext within w_invasor_hora
integer x = 352
integer y = 1180
integer width = 1120
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean enabled = false
string text = "Hora entrada: hh:mm am/pm dd/mm/yyyy"
boolean focusrectangle = false
end type

type st_cuenta from statictext within w_invasor_hora
integer x = 352
integer y = 1076
integer width = 1138
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean enabled = false
string text = "Cuenta: 0000000000-0"
boolean focusrectangle = false
end type

type st_2 from statictext within w_invasor_hora
integer x = 384
integer y = 1340
integer width = 247
integer height = 92
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean enabled = false
string text = "Clave"
boolean focusrectangle = false
end type

type sle_clave from singlelineedit within w_invasor_hora
integer x = 645
integer y = 1340
integer width = 823
integer height = 92
integer taborder = 10
integer textsize = -22
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
boolean password = true
borderstyle borderstyle = stylelowered!
end type

event modified;string ls_clave

ls_clave = text

SELECT dbo.activacion_su.clave
	 INTO :ls_clave  
 FROM dbo.activacion_su 
 WHERE dbo.activacion_su.clave = :ls_clave 
 AND tipo_periodo = :gs_tipo_periodo
 using sqlca;

If sqlca.sqlcode	=	0	then
	close(parent)
else
	MessageBox("NO AUTORIZADO"," NO esta AUTORIZADO para desbloquear terminal",stopsign!,ok!)
	setfocus()
	selecttext(1,Len(text))
end if
end event

type st_1 from statictext within w_invasor_hora
integer x = 352
integer y = 476
integer width = 1993
integer height = 548
integer textsize = -22
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 255
boolean enabled = false
string text = "El alumno ha quedado bloqueado por invadir su hora de entrada. Para continuar teclee un password autorizado"
boolean focusrectangle = false
end type

type oval_1 from oval within w_invasor_hora
long linecolor = 65535
integer linethickness = 3
long fillcolor = 65535
integer x = 992
integer y = 28
integer width = 453
integer height = 388
end type

type rr_1 from roundrectangle within w_invasor_hora
integer linethickness = 3
integer x = 1179
integer y = 48
integer width = 69
integer height = 240
integer cornerheight = 42
integer cornerwidth = 48
end type

type oval_2 from oval within w_invasor_hora
integer linethickness = 3
integer x = 1175
integer y = 308
integer width = 87
integer height = 76
end type

type r_1 from rectangle within w_invasor_hora
long linecolor = 16711680
integer linethickness = 3
long fillcolor = 128
integer x = 1385
integer y = 1472
integer width = 87
integer height = 76
end type

