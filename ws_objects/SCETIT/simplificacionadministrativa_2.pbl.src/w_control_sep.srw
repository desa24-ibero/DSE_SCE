$PBExportHeader$w_control_sep.srw
forward
global type w_control_sep from window
end type
type em_anio from editmask within w_control_sep
end type
type st_1 from statictext within w_control_sep
end type
type cb_nuevogr from commandbutton within w_control_sep
end type
type cb_nuevodi from commandbutton within w_control_sep
end type
type cb_nuevoti from commandbutton within w_control_sep
end type
type cb_nuevodu from commandbutton within w_control_sep
end type
type cb_nuevoct from commandbutton within w_control_sep
end type
type cb_cancelar_folio from commandbutton within w_control_sep
end type
type cb_cerrar from commandbutton within w_control_sep
end type
type cb_nuevocp from commandbutton within w_control_sep
end type
type dw_control_sep from datawindow within w_control_sep
end type
end forward

global type w_control_sep from window
integer x = 832
integer y = 364
integer width = 3447
integer height = 660
boolean titlebar = true
string title = "Folios Registrados"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 15793151
em_anio em_anio
st_1 st_1
cb_nuevogr cb_nuevogr
cb_nuevodi cb_nuevodi
cb_nuevoti cb_nuevoti
cb_nuevodu cb_nuevodu
cb_nuevoct cb_nuevoct
cb_cancelar_folio cb_cancelar_folio
cb_cerrar cb_cerrar
cb_nuevocp cb_nuevocp
dw_control_sep dw_control_sep
end type
global w_control_sep w_control_sep

forward prototypes
public subroutine nuevo (integer ai_opcion)
end prototypes

public subroutine nuevo (integer ai_opcion);DataStore lds_maximo
long	ll_maximo, ll_maximo_base
int li_anio, li_periodo, li_anio_usa
int li_cves[4]
choose case ai_opcion
	case 1
		li_cves = {1,2}
	case 2
		li_cves = {1,2}
	case 3
		li_cves = {3}
	case else
		li_cves = {4,5,6}
end choose
	
	
lds_maximo = Create DataStore
lds_maximo.dataobject = "d_maximo_numero"
lds_maximo.SetTrans(gtr_sce)
lds_maximo.Retrieve(li_cves)
ll_maximo = lds_maximo.getitemnumber(1,"maximo")
if isnull(ll_maximo) then ll_maximo = 0
Destroy lds_maximo
periodo_actual(li_periodo, li_anio,gtr_sce)

IF (em_anio.TEXT = "0000" OR TRIM(em_anio.TEXT) = "")  AND (ai_opcion = 1 OR ai_opcion = 2) THEN 
	MESSAGEBOX("Aviso", "No ha seleccionado el año de los folios de los certificados.") 
	em_anio.SETFOCUS()
	RETURN 
END IF 

// Si se trata de certifgicados 
IF ai_opcion = 1 OR ai_opcion = 2 THEN 
	
	li_anio_usa = LONG(em_anio.TEXT) 
	ll_maximo_base = MOD((li_anio_usa + 1), 100) * 1000000 
	
	SELECT MAX(numero)  
	INTO :ll_maximo
	 FROM control_sep  
	WHERE control_sep.cve_doc_control_sep in ( 1,2 )    
	AND numero < :ll_maximo_base 	 
	USING gtr_sce;  
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al buscar el folio máximo:" + gtr_sce.SQLERRTEXT) 
		RETURN 
	END IF 
	
	if truncate(mod(ll_maximo,100000000)/1000000,0) = mod(li_anio_usa,100) then
		ll_maximo = mod(ll_maximo,100000000) + 1
	else
		ll_maximo = (mod(li_anio_usa,100)*1000000)+1
	end if
	ll_maximo += (100000000*ai_opcion)   	
	
	
ELSE
	li_anio_usa = li_anio
	
	if truncate(mod(ll_maximo,100000000)/1000000,0) = mod(li_anio_usa,100) then
		ll_maximo = mod(ll_maximo,100000000) + 1
	else
		ll_maximo = (mod(li_anio_usa,100)*1000000)+1
	end if
	ll_maximo += (100000000*ai_opcion)   	
	
END IF 







closewithreturn(this,ll_maximo)





end subroutine

on w_control_sep.create
this.em_anio=create em_anio
this.st_1=create st_1
this.cb_nuevogr=create cb_nuevogr
this.cb_nuevodi=create cb_nuevodi
this.cb_nuevoti=create cb_nuevoti
this.cb_nuevodu=create cb_nuevodu
this.cb_nuevoct=create cb_nuevoct
this.cb_cancelar_folio=create cb_cancelar_folio
this.cb_cerrar=create cb_cerrar
this.cb_nuevocp=create cb_nuevocp
this.dw_control_sep=create dw_control_sep
this.Control[]={this.em_anio,&
this.st_1,&
this.cb_nuevogr,&
this.cb_nuevodi,&
this.cb_nuevoti,&
this.cb_nuevodu,&
this.cb_nuevoct,&
this.cb_cancelar_folio,&
this.cb_cerrar,&
this.cb_nuevocp,&
this.dw_control_sep}
end on

on w_control_sep.destroy
destroy(this.em_anio)
destroy(this.st_1)
destroy(this.cb_nuevogr)
destroy(this.cb_nuevodi)
destroy(this.cb_nuevoti)
destroy(this.cb_nuevodu)
destroy(this.cb_nuevoct)
destroy(this.cb_cancelar_folio)
destroy(this.cb_cerrar)
destroy(this.cb_nuevocp)
destroy(this.dw_control_sep)
end on

event open;x=100;y=1200
dw_control_sep.retrieve(Message.DoubleParm)
//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)

end event

type em_anio from editmask within w_control_sep
integer x = 27
integer y = 448
integer width = 443
integer height = 80
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "0000"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
end type

type st_1 from statictext within w_control_sep
integer x = 27
integer y = 368
integer width = 443
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 15793151
string text = "Año certificado"
boolean focusrectangle = false
end type

type cb_nuevogr from commandbutton within w_control_sep
integer x = 1454
integer y = 456
integer width = 398
integer height = 76
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuevo GR"
end type

event clicked;nuevo(6)
end event

type cb_nuevodi from commandbutton within w_control_sep
integer x = 1454
integer y = 372
integer width = 398
integer height = 76
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuevo DI"
end type

event clicked;nuevo(5)
end event

type cb_nuevoti from commandbutton within w_control_sep
integer x = 983
integer y = 456
integer width = 398
integer height = 76
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuevo TI"
end type

event clicked;nuevo(4)
end event

type cb_nuevodu from commandbutton within w_control_sep
integer x = 987
integer y = 372
integer width = 398
integer height = 76
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuevo DU"
end type

event clicked;nuevo(3)
end event

type cb_nuevoct from commandbutton within w_control_sep
integer x = 507
integer y = 372
integer width = 398
integer height = 76
integer taborder = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuevo CT"
end type

event clicked;nuevo(1)
	
end event

type cb_cancelar_folio from commandbutton within w_control_sep
integer x = 2153
integer y = 392
integer width = 562
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar Folio"
end type

event clicked;dw_control_sep.Event cancelafolio(dw_control_sep.GetRow())
dw_control_sep.retrieve(Message.DoubleParm)
end event

type cb_cerrar from commandbutton within w_control_sep
integer x = 2770
integer y = 392
integer width = 562
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;closewithreturn(parent,0)
end event

type cb_nuevocp from commandbutton within w_control_sep
integer x = 507
integer y = 456
integer width = 398
integer height = 76
integer taborder = 70
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Nuevo CP"
end type

event clicked;nuevo(2)
end event

type dw_control_sep from datawindow within w_control_sep
event type integer cancelafolio ( integer ai_row )
event actualiza ( )
integer x = 32
integer y = 32
integer width = 3287
integer height = 320
integer taborder = 30
string dataobject = "d_contol_sep"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event cancelafolio;if (Messagebox("Aviso", "Esta seguro que desea cancelar el folio no. " +&
				string(GetItemNumber(ai_row,"numero"))+"?",Question!,OkCancel!,1) = 1 ) then
				SetItem(ai_row,"cancelado",1)
				Event actualiza()
end if
return 1
end event

event actualiza;if Update() = 1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
else
		rollback using gtr_sce;
		MessageBox("Atención","No se han guardado los cambios")
end if
end event

event constructor;SetTrans(gtr_sce)
SetRowFocusIndicator(Hand!)
end event

event doubleclicked;long ll_numero 
if row > 0 then
	ll_numero = getitemnumber(row,"numero")
	ll_numero += 1000000000
	closewithreturn(parent, ll_numero)
end if
end event

