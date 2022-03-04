$PBExportHeader$cambio_password.srw
forward
global type cambio_password from window
end type
type sle_passconf from singlelineedit within cambio_password
end type
type sle_passnew from singlelineedit within cambio_password
end type
type st_cp from statictext within cambio_password
end type
type st_np from statictext within cambio_password
end type
type cb_ok from commandbutton within cambio_password
end type
type cb_cancel from commandbutton within cambio_password
end type
type cb_3 from commandbutton within cambio_password
end type
end forward

global type cambio_password from window
integer x = 832
integer y = 356
integer width = 1371
integer height = 716
boolean titlebar = true
string title = "Cambio de Password"
boolean controlmenu = true
windowtype windowtype = response!
sle_passconf sle_passconf
sle_passnew sle_passnew
st_cp st_cp
st_np st_np
cb_ok cb_ok
cb_cancel cb_cancel
cb_3 cb_3
end type
global cambio_password cambio_password

type variables
transaction itr_sybfinpro, itr_sybcespro
string oldpass
string new_pass
string conf_new_pass
end variables

event open;//sle_passnew.visible=false
sle_passconf.visible=false
//st_np.visible=false
st_cp.visible=false
cb_ok.visible=false

if conecta_bd(itr_sybfinpro,"scob",gs_usuario,gs_password)<>1 then
	if conecta_bd(itr_sybfinpro,"scaj",gs_usuario,gs_password)<>1 then
		DESTROY itr_sybfinpro
	end if
end if

if conecta_bd(itr_sybcespro,"sce",gs_usuario,gs_password)<>1 then
	if conecta_bd(itr_sybcespro,"sadm",gs_usuario,gs_password)<>1 then
		if conecta_bd(itr_sybcespro,"scred",gs_usuario,gs_password)<>1 then
			DESTROY itr_sybcespro
		end if
	end if
end if
end event

on cambio_password.create
this.sle_passconf=create sle_passconf
this.sle_passnew=create sle_passnew
this.st_cp=create st_cp
this.st_np=create st_np
this.cb_ok=create cb_ok
this.cb_cancel=create cb_cancel
this.cb_3=create cb_3
this.Control[]={this.sle_passconf,&
this.sle_passnew,&
this.st_cp,&
this.st_np,&
this.cb_ok,&
this.cb_cancel,&
this.cb_3}
end on

on cambio_password.destroy
destroy(this.sle_passconf)
destroy(this.sle_passnew)
destroy(this.st_cp)
destroy(this.st_np)
destroy(this.cb_ok)
destroy(this.cb_cancel)
destroy(this.cb_3)
end on

event close;if isvalid(itr_sybfinpro) then
	rollback using itr_sybfinpro;
	
	disconnect using itr_sybfinpro;
	
	if itr_sybfinpro.sqlcode <> 0 then
		MessageBox ("Error al desconectar la base de datos", itr_sybfinpro.sqlerrtext, None!)
	end if
	
	DESTROY itr_sybfinpro
end if

if isvalid(itr_sybcespro) then
	rollback using itr_sybcespro;
	
	disconnect using itr_sybcespro;
	
	if itr_sybcespro.sqlcode <> 0 then
		MessageBox ("Error al desconectar la base de datos", itr_sybcespro.sqlerrtext, None!)
	end if
	
	DESTROY itr_sybcespro
end if
end event

type sle_passconf from singlelineedit within cambio_password
integer x = 626
integer y = 284
integer width = 617
integer height = 84
integer taborder = 20
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

event modified;conf_new_pass=sle_passconf.text

if conf_new_pass=new_pass then
	cb_ok.visible=true
	cb_ok.setfocus()
else
	messagebox("Error","No concuerda su password nuevo.~n Favor de verificar.",stopsign!,ok!)
   sle_passnew.setfocus()
	sle_passconf.selecttext(1,Len(sle_passnew.text))
end if
end event

type sle_passnew from singlelineedit within cambio_password
integer x = 626
integer y = 192
integer width = 617
integer height = 84
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean password = true
integer limit = 20
borderstyle borderstyle = stylelowered!
end type

on modified;new_pass=sle_passnew.text
sle_passconf.visible=true
st_cp.visible=true
sle_passconf.setfocus()
end on

type st_cp from statictext within cambio_password
integer x = 69
integer y = 296
integer width = 526
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Confirme Password:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_np from statictext within cambio_password
integer x = 123
integer y = 200
integer width = 471
integer height = 60
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
boolean enabled = false
string text = "Password Nuevo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_ok from commandbutton within cambio_password
integer x = 517
integer y = 444
integer width = 352
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "OK"
end type

event clicked;string ryu
oldpass = gs_password
/*SYBCESPRO:*/
DECLARE CambiaPass_sybcespro procedure  FOR sp_cambiapass @caller_password = :oldpass ,
						@new_password = :new_pass ,
						@loginame = :gs_usuario
USING itr_sybcespro;
If itr_sybcespro.sqlcode < 0 Then
	MessageBox ("sp_password   ", &
					string(itr_sybcespro.sqlcode)+' '+itr_sybcespro.sqlerrtext, Exclamation!)
	Return
End If

itr_sybcespro.sqlcode=0

EXECUTE CambiaPass_sybcespro;
commit using itr_sybcespro;
If itr_sybcespro.sqlcode < 0 Then
	MessageBox ("sp_password   ", &
					string(itr_sybcespro.sqlcode)+' '+itr_sybcespro.sqlerrtext, Exclamation!)
	Return
End If

Close CambiaPass_sybcespro;

/*SYBFINPRO:*/
if isvalid(itr_sybfinpro) then
	DECLARE CambiaPass_itr_sybfinpro procedure  FOR sp_cambiapass @caller_password = :oldpass ,
							@new_password = :new_pass ,
							@loginame = :gs_usuario
	USING itr_sybfinpro;
	If itr_sybfinpro.sqlcode < 0 Then
		MessageBox ("sp_password   ", &
						string(itr_sybfinpro.sqlcode)+' '+itr_sybfinpro.sqlerrtext, Exclamation!)
		Return
	End If
	
	itr_sybfinpro.sqlcode=0
	
	EXECUTE CambiaPass_itr_sybfinpro;
	commit using itr_sybfinpro;
	If itr_sybfinpro.sqlcode < 0 Then
		MessageBox ("sp_password   ", &
						string(itr_sybfinpro.sqlcode)+' '+itr_sybfinpro.sqlerrtext, Exclamation!)
		Return
	End If
	
	Close CambiaPass_itr_sybfinpro;
end if

	messagebox("Información","Password Actualizado.",none!,ok!)  
	close(cambio_password)

end event

event getfocus;activar(this)
end event

type cb_cancel from commandbutton within cambio_password
integer x = 896
integer y = 444
integer width = 352
integer height = 96
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

on clicked;close(cambio_password)
end on

type cb_3 from commandbutton within cambio_password
integer x = 896
integer y = 444
integer width = 352
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

