$PBExportHeader$w_control_sep_planteles.srw
forward
global type w_control_sep_planteles from window
end type
type cb_cancelar_folio from commandbutton within w_control_sep_planteles
end type
type cb_cerrar from commandbutton within w_control_sep_planteles
end type
type dw_control_sep from datawindow within w_control_sep_planteles
end type
end forward

global type w_control_sep_planteles from window
integer x = 832
integer y = 364
integer width = 3447
integer height = 660
boolean titlebar = true
string title = "Folios Registrados"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 15793151
cb_cancelar_folio cb_cancelar_folio
cb_cerrar cb_cerrar
dw_control_sep dw_control_sep
end type
global w_control_sep_planteles w_control_sep_planteles

forward prototypes
public subroutine nuevo (integer ai_opcion)
end prototypes

public subroutine nuevo (integer ai_opcion);DataStore lds_maximo
long	ll_maximo
int li_anio, li_periodo
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
if truncate(mod(ll_maximo,100000000)/1000000,0) = mod(li_anio,100) then
	ll_maximo = mod(ll_maximo,100000000) + 1
else
	ll_maximo = (mod(li_anio,100)*1000000)+1
end if
ll_maximo += (100000000*ai_opcion)
closewithreturn(this,ll_maximo)
end subroutine

on w_control_sep_planteles.create
this.cb_cancelar_folio=create cb_cancelar_folio
this.cb_cerrar=create cb_cerrar
this.dw_control_sep=create dw_control_sep
this.Control[]={this.cb_cancelar_folio,&
this.cb_cerrar,&
this.dw_control_sep}
end on

on w_control_sep_planteles.destroy
destroy(this.cb_cancelar_folio)
destroy(this.cb_cerrar)
destroy(this.dw_control_sep)
end on

event open;long ll_cuenta, ll_cve_plantel
x=100;y=1200

str_cuenta_cve_plantel lstr_cuenta_cve_plantel

lstr_cuenta_cve_plantel =Message.PowerObjectParm	
ll_cuenta = lstr_cuenta_cve_plantel.cuenta
ll_cve_plantel = lstr_cuenta_cve_plantel.cve_plantel
dw_control_sep.retrieve(ll_cuenta)
//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)

end event

type cb_cancelar_folio from commandbutton within w_control_sep_planteles
integer x = 2153
integer y = 432
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

event clicked;long ll_cuenta, ll_cve_plantel

str_cuenta_cve_plantel lstr_cuenta_cve_plantel
lstr_cuenta_cve_plantel =Message.PowerObjectParm	
ll_cuenta = lstr_cuenta_cve_plantel.cuenta
ll_cve_plantel = lstr_cuenta_cve_plantel.cve_plantel

IF dw_control_sep.getRow( ) > 0 THEN
	dw_control_sep.Event cancelafolio(dw_control_sep.GetRow())
	dw_control_sep.retrieve(ll_cuenta)
ELSE
	closewithreturn(parent,0)
END IF 

end event

type cb_cerrar from commandbutton within w_control_sep_planteles
integer x = 2770
integer y = 432
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

type dw_control_sep from datawindow within w_control_sep_planteles
event type integer cancelafolio ( integer ai_row )
event actualiza ( )
integer x = 32
integer y = 32
integer width = 3287
integer height = 372
integer taborder = 30
string dataobject = "d_control_sep_planteles"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event type integer cancelafolio(integer ai_row);IF (Messagebox("Aviso", "Esta seguro que desea cancelar el folio no. " +&
			string(GetItemNumber(ai_row,"numero"))+"?",Question!,OkCancel!,1) = 1 ) then
			SetItem(ai_row,"cancelado",1)
			Event actualiza()
END IF

RETURN 1
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

event doubleclicked;long ll_numero, ll_cve_plantel
str_cuenta_cve_plantel lstr_cuenta_cve_plantel
if row > 0 then
	ll_numero = getitemnumber(row,"numero")
	ll_cve_plantel = getitemnumber(row,"cve_plantel")
	lstr_cuenta_cve_plantel.cuenta  = ll_numero
	lstr_cuenta_cve_plantel.cve_plantel  = ll_cve_plantel
//	ll_numero += 1000000000
	closewithreturn(parent, lstr_cuenta_cve_plantel)
end if
end event

