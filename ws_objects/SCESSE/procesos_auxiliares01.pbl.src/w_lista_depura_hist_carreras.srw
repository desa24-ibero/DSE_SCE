$PBExportHeader$w_lista_depura_hist_carreras.srw
forward
global type w_lista_depura_hist_carreras from window
end type
type cb_1 from commandbutton within w_lista_depura_hist_carreras
end type
type uo_nombre from uo_nombre_alumno_2013 within w_lista_depura_hist_carreras
end type
type cb_revisar from commandbutton within w_lista_depura_hist_carreras
end type
type dw_lista from datawindow within w_lista_depura_hist_carreras
end type
end forward

global type w_lista_depura_hist_carreras from window
integer width = 5614
integer height = 2548
boolean titlebar = true
string title = "Cuentas con registros de carreras duplicadas"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
uo_nombre uo_nombre
cb_revisar cb_revisar
dw_lista dw_lista
end type
global w_lista_depura_hist_carreras w_lista_depura_hist_carreras

on w_lista_depura_hist_carreras.create
this.cb_1=create cb_1
this.uo_nombre=create uo_nombre
this.cb_revisar=create cb_revisar
this.dw_lista=create dw_lista
this.Control[]={this.cb_1,&
this.uo_nombre,&
this.cb_revisar,&
this.dw_lista}
end on

on w_lista_depura_hist_carreras.destroy
destroy(this.cb_1)
destroy(this.uo_nombre)
destroy(this.cb_revisar)
destroy(this.dw_lista)
end on

event open;dw_lista.TRIGGEREVENT("carga")
dw_lista.SETROWFOCUSINDICATOR(hand!)
end event

type cb_1 from commandbutton within w_lista_depura_hist_carreras
integer x = 3378
integer y = 248
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;LONG ll_cuenta 
LONG ll_row 

ll_cuenta = LONG(uo_nombre.em_cuenta.text) 
IF ISNULL(ll_cuenta) or ll_cuenta<= 0 THEN 
	MESSAGEBOX("Error", "La cuenta no es válida.") 
	RETURN  
END IF 	

ll_row = dw_lista.FIND("hist_carreras_cuenta = " + STRING(ll_cuenta), 1,  dw_lista.ROWCOUNT() + 1)  
IF ll_row <= 0 THEN 
	MESSAGEBOX("Aviso", "No se encontró la cuenta solicitada.") 
	RETURN 
ELSE
	dw_lista.SCROLLTOROW(ll_row)  
	dw_lista.SETROW(ll_row) 
END IF 	

RETURN 
end event

type uo_nombre from uo_nombre_alumno_2013 within w_lista_depura_hist_carreras
integer x = 101
integer y = 44
integer taborder = 30
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type cb_revisar from commandbutton within w_lista_depura_hist_carreras
integer x = 3863
integer y = 248
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisar"
end type

event clicked;LONG  ll_cuenta 
LONG ll_row 

ll_row = dw_lista.GETROW()

ll_cuenta = dw_lista.getitemnumber(ll_row, "hist_carreras_cuenta")   
OPENWITHPARM(w_depura_hist_carreras, ll_cuenta)  

dw_lista.TRIGGEREVENT("carga")
dw_lista.SETROWFOCUSINDICATOR(hand!)

end event

type dw_lista from datawindow within w_lista_depura_hist_carreras
event carga ( )
integer x = 96
integer y = 416
integer width = 4933
integer height = 1948
integer taborder = 10
string dataobject = "dw_lista_depura_hist_carreras"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga();dw_lista.SETTRANSOBJECT(gtr_sce) 
dw_lista.RETRIEVE() 
dw_lista.SETSORT("hist_carreras_cuenta asc")
dw_lista.SORT() 
dw_lista.GROUPCALC() 


end event

event rowfocuschanged;THIS.SETROW(currentrow) 
THIS.SELECTROW(0, FALSE) 
THIS.SELECTROW(currentrow, TRUE)  





end event

event doubleclicked;cb_revisar.TRIGGEREVENT("clicked") 


end event

event clicked;THIS.SETROW(row) 
end event

