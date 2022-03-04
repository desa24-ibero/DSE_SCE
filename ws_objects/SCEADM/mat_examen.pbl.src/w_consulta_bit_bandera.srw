$PBExportHeader$w_consulta_bit_bandera.srw
forward
global type w_consulta_bit_bandera from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_consulta_bit_bandera
end type
type cbx_folio from checkbox within w_consulta_bit_bandera
end type
type st_1 from statictext within w_consulta_bit_bandera
end type
type em_folio from editmask within w_consulta_bit_bandera
end type
type uo_sel_carrera from uo_carrera within w_consulta_bit_bandera
end type
type cbx_status from checkbox within w_consulta_bit_bandera
end type
type cbx_pago_insc from checkbox within w_consulta_bit_bandera
end type
type cbx_pago_exam from checkbox within w_consulta_bit_bandera
end type
type dw_status_seleccion from datawindow within w_consulta_bit_bandera
end type
type cb_buscar from commandbutton within w_consulta_bit_bandera
end type
type uo_1 from uo_ver_per_ani within w_consulta_bit_bandera
end type
type dw_1 from uo_dw_reporte within w_consulta_bit_bandera
end type
end forward

global type w_consulta_bit_bandera from Window
int X=834
int Y=362
int Width=3694
int Height=1965
boolean TitleBar=true
string Title="Bitácora de Cambios a Aspirantes"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_folio cbx_folio
st_1 st_1
em_folio em_folio
uo_sel_carrera uo_sel_carrera
cbx_status cbx_status
cbx_pago_insc cbx_pago_insc
cbx_pago_exam cbx_pago_exam
dw_status_seleccion dw_status_seleccion
cb_buscar cb_buscar
uo_1 uo_1
dw_1 dw_1
end type
global w_consulta_bit_bandera w_consulta_bit_bandera

on w_consulta_bit_bandera.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cbx_folio=create cbx_folio
this.st_1=create st_1
this.em_folio=create em_folio
this.uo_sel_carrera=create uo_sel_carrera
this.cbx_status=create cbx_status
this.cbx_pago_insc=create cbx_pago_insc
this.cbx_pago_exam=create cbx_pago_exam
this.dw_status_seleccion=create dw_status_seleccion
this.cb_buscar=create cb_buscar
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.cbx_folio,&
this.st_1,&
this.em_folio,&
this.uo_sel_carrera,&
this.cbx_status,&
this.cbx_pago_insc,&
this.cbx_pago_exam,&
this.dw_status_seleccion,&
this.cb_buscar,&
this.uo_1,&
this.dw_1}
end on

on w_consulta_bit_bandera.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.cbx_folio)
destroy(this.st_1)
destroy(this.em_folio)
destroy(this.uo_sel_carrera)
destroy(this.cbx_status)
destroy(this.cbx_pago_insc)
destroy(this.cbx_pago_exam)
destroy(this.dw_status_seleccion)
destroy(this.cb_buscar)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
dw_1.Object.DataWindow.Print.Orientation = 1
dw_1.Object.DataWindow.Zoom	 = 66


end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_consulta_bit_bandera
int X=2308
int Y=38
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_folio from checkbox within w_consulta_bit_bandera
int X=1357
int Y=304
int Width=512
int Height=80
string Text="Todos los Folios"
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if this.checked then
	em_folio.enabled = false
else
	em_folio.enabled = true
end if


end event

type st_1 from statictext within w_consulta_bit_bandera
int X=1331
int Y=208
int Width=201
int Height=80
boolean Enabled=false
string Text="Folio: "
Alignment Alignment=Right!
boolean FocusRectangle=false
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type em_folio from editmask within w_consulta_bit_bandera
int X=1584
int Y=208
int Width=285
int Height=80
int TabOrder=30
Alignment Alignment=Right!
string Mask="#####0"
string DisplayData="4"
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;string ls_texto, ls_error
long ll_folio, ll_folio_aux
integer li_codigo

ls_texto = this.text

if ls_texto = "" then
	ls_texto = "0"
	em_folio.text=ls_texto
end if 

if not isnumber(ls_texto) then
	MessageBox("Error", "El folio escrito es inválido")
	return
else
	ll_folio = long(ls_texto)
end if


select folio into :ll_folio_aux
from aspiran
where folio = :ll_folio
using gtr_sadm;


li_codigo = gtr_sadm.SQLCode
ls_error = gtr_sadm.SQLErrtext

if li_codigo = 100 then
	MessageBox("Error", "El folio escrito no existe")
	return
elseif li_codigo = -1 then
	MessageBox("Error al buscar el alumno", ls_error)
	return
end if


end event

type uo_sel_carrera from uo_carrera within w_consulta_bit_bandera
int X=2322
int Y=186
int TabOrder=40
boolean Enabled=true
long BackColor=1090519039
end type

on uo_sel_carrera.destroy
call uo_carrera::destroy
end on

type cbx_status from checkbox within w_consulta_bit_bandera
int X=55
int Y=208
int Width=344
int Height=80
string Text="Status"
boolean Checked=true
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_pago_insc from checkbox within w_consulta_bit_bandera
int X=914
int Y=208
int Width=366
int Height=80
string Text="Pago Insc."
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_pago_exam from checkbox within w_consulta_bit_bandera
int X=450
int Y=208
int Width=413
int Height=80
string Text="Pago Exam."
boolean LeftText=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_status_seleccion from datawindow within w_consulta_bit_bandera
int X=2977
int Y=214
int Width=494
int Height=381
int TabOrder=20
boolean Visible=false
string DataObject="dw_status_seleccion"
boolean LiveScroll=true
end type

type cb_buscar from commandbutton within w_consulta_bit_bandera
int X=1964
int Y=237
int Width=307
int Height=106
int TabOrder=10
string Text="Buscar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;/**/
integer array_li_status[ ], li_carrera
long ll_tamanio,  ll_siguiente, ll_folio
string ls_texto

//SetNull(array_li_status)

ls_texto = em_folio.text

if ls_texto = "" then
	ls_texto = "0"
	em_folio.text=ls_texto
end if 

if cbx_folio.Checked then
	ll_folio = 999999
else
	if not isnumber(ls_texto) then
		MessageBox("Error", "El folio escrito es inválido")
		return
	else
		ll_folio = long(ls_texto)
	end if
end if

IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	dw_1.dataobject = "dw_consulta_bit_bandera"
	dw_1.SetTransObject(gtr_sadm)
ELSE
	dw_1.dataobject = "dw_consulta_bit_band_ing"
	dw_1.SetTransObject(gtr_sadm)	
END IF

dw_1.Object.DataWindow.Print.Orientation = 1
dw_1.Object.DataWindow.Zoom	 = 66

li_carrera= uo_sel_carrera.dw_carrera.object.cve_carrera[uo_sel_carrera.dw_carrera.getrow()]

if cbx_status.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=1
end if

if cbx_pago_exam.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=2
end if

if cbx_pago_insc.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=3
end if

ll_tamanio=UpperBound(array_li_status)		
ll_siguiente=ll_tamanio+1
array_li_status[ll_siguiente]=10


dw_1.retrieve(gi_version, gi_periodo, gi_anio, array_li_status, li_carrera, ll_folio)

end event

type uo_1 from uo_ver_per_ani within w_consulta_bit_bandera
int X=18
int Y=22
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_consulta_bit_bandera
int X=22
int Y=416
int Width=3566
int Height=1338
int TabOrder=0
string DataObject="dw_consulta_bit_bandera"
boolean HScrollBar=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;/**/
integer array_li_status[ ], li_carrera
long ll_tamanio,  ll_siguiente, ll_folio
string ls_texto

//SetNull(array_li_status)

ls_texto = em_folio.text

if ls_texto = "" then
	ls_texto = "0"
	em_folio.text=ls_texto
end if 

if cbx_folio.Checked then
	ll_folio = 999999
else
	if not isnumber(ls_texto) then
		MessageBox("Error", "El folio escrito es inválido")
		return 0
	else
		ll_folio = long(ls_texto)
	end if
end if

IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_consulta_bit_bandera"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_consulta_bit_band_ing"
	this.SetTransObject(gtr_sadm)	
END IF

dw_1.Object.DataWindow.Print.Orientation = 1
dw_1.Object.DataWindow.Zoom	 = 66

li_carrera= uo_sel_carrera.dw_carrera.object.cve_carrera[uo_sel_carrera.dw_carrera.getrow()]

if cbx_status.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=1
end if

if cbx_pago_exam.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=2
end if

if cbx_pago_insc.Checked then
	ll_tamanio=UpperBound(array_li_status)		
	ll_siguiente=ll_tamanio+1
	array_li_status[ll_siguiente]=3
end if

ll_tamanio=UpperBound(array_li_status)		
ll_siguiente=ll_tamanio+1
array_li_status[ll_siguiente]=10


dw_1.retrieve(gi_version, gi_periodo, gi_anio, array_li_status, li_carrera, ll_folio)

return 0
end event

