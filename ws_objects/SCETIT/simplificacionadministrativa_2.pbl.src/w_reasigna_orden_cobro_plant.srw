$PBExportHeader$w_reasigna_orden_cobro_plant.srw
forward
global type w_reasigna_orden_cobro_plant from Window
end type
type st_3 from statictext within w_reasigna_orden_cobro_plant
end type
type st_2 from statictext within w_reasigna_orden_cobro_plant
end type
type sle_orden_cobro_destino from singlelineedit within w_reasigna_orden_cobro_plant
end type
type cb_cancelar from commandbutton within w_reasigna_orden_cobro_plant
end type
type cb_aceptar from commandbutton within w_reasigna_orden_cobro_plant
end type
type sle_orden_cobro from singlelineedit within w_reasigna_orden_cobro_plant
end type
type st_1 from statictext within w_reasigna_orden_cobro_plant
end type
end forward

global type w_reasigna_orden_cobro_plant from Window
int X=845
int Y=371
int Width=1701
int Height=774
boolean TitleBar=true
string Title="Reasignación de Ordenes de Cobro (Planteles)"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_3 st_3
st_2 st_2
sle_orden_cobro_destino sle_orden_cobro_destino
cb_cancelar cb_cancelar
cb_aceptar cb_aceptar
sle_orden_cobro sle_orden_cobro
st_1 st_1
end type
global w_reasigna_orden_cobro_plant w_reasigna_orden_cobro_plant

forward prototypes
public function boolean wf_ordenes_validas (string as_orden_origen, string as_orden_destino)
end prototypes

public function boolean wf_ordenes_validas (string as_orden_origen, string as_orden_destino);//wf_ordenes_validas
// Revisa si las ordenes origen y destino son validas
//as_orden_origen
//as_orden_destino


int li_i
boolean lb_sirve_origen = true, lb_sirve_destino = true
int li_char
string ls_null
SetNull(ls_null)

if as_orden_origen = "" or  as_orden_origen= ls_null then 
	MessageBox("Atención", "Escriba algo en la orden de cobro Origen", StopSign!)
	return false
end if
	
if as_orden_destino = "" or  as_orden_destino=  ls_null then 
	MessageBox("Atención", "Escriba algo en la orden de cobro Destino", StopSign!)
	return false
end if
	
li_i = 1
do while li_i <= len(as_orden_origen) and lb_sirve_origen = true
	li_char = asc(mid(as_orden_origen,li_i,1))
	if li_char <> 45 AND (li_char < 48 OR li_char > 57 ) then lb_sirve_origen = false
	li_i ++
loop

if not lb_sirve_origen then 
	MessageBox("Atención", "Sólo se admiten números o guiones en la orden de cobro Origen", StopSign!)
	return false
end if

li_i = 1
do while li_i <= len(as_orden_destino) and lb_sirve_destino = true
	li_char = asc(mid(as_orden_destino,li_i,1))
	if li_char <> 45 AND (li_char < 48 OR li_char > 57 ) then lb_sirve_destino = false
	li_i ++
loop

if not lb_sirve_destino then 
	MessageBox("Atención", "Sólo se admiten números o guiones en la orden de cobro Destino", StopSign!)
	return false
end if
	
if not f_existe_orden_cobro_planteles(as_orden_origen) then
	MessageBox("Atención", "No existen registros correspondientes a la orden de cobro Origen", StopSign!)
	return false
end if

if f_existe_orden_cobro_planteles(as_orden_destino) then
	MessageBox("Atención", "La orden de cobro Destino ya se encuentra asignada", StopSign!)
	return false
end if


return true
end function

on w_reasigna_orden_cobro_plant.create
this.st_3=create st_3
this.st_2=create st_2
this.sle_orden_cobro_destino=create sle_orden_cobro_destino
this.cb_cancelar=create cb_cancelar
this.cb_aceptar=create cb_aceptar
this.sle_orden_cobro=create sle_orden_cobro
this.st_1=create st_1
this.Control[]={this.st_3,&
this.st_2,&
this.sle_orden_cobro_destino,&
this.cb_cancelar,&
this.cb_aceptar,&
this.sle_orden_cobro,&
this.st_1}
end on

on w_reasigna_orden_cobro_plant.destroy
destroy(this.st_3)
destroy(this.st_2)
destroy(this.sle_orden_cobro_destino)
destroy(this.cb_cancelar)
destroy(this.cb_aceptar)
destroy(this.sle_orden_cobro)
destroy(this.st_1)
end on

event open;x=1
y=1
end event

type st_3 from statictext within w_reasigna_orden_cobro_plant
int X=688
int Y=278
int Width=241
int Height=77
boolean Enabled=false
string Text="====>"
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Terminal"
FontCharSet FontCharSet=Oem!
FontFamily FontFamily=Modern!
FontPitch FontPitch=Fixed!
end type

type st_2 from statictext within w_reasigna_orden_cobro_plant
int X=907
int Y=106
int Width=519
int Height=122
boolean Enabled=false
string Text="Orden de cobro Destino/Definitiva"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type sle_orden_cobro_destino from singlelineedit within w_reasigna_orden_cobro_plant
int X=940
int Y=262
int Width=457
int Height=109
int TabOrder=20
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=12
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cb_cancelar from commandbutton within w_reasigna_orden_cobro_plant
int X=903
int Y=509
int Width=333
int Height=106
int TabOrder=40
string Text="Cancelar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;close( parent)
end event

type cb_aceptar from commandbutton within w_reasigna_orden_cobro_plant
int X=406
int Y=509
int Width=333
int Height=106
int TabOrder=30
string Text="Aceptar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;string ls_orden_origen, ls_orden_destino
integer li_resultado_asignacion, li_confirma

ls_orden_origen = sle_orden_cobro.text 
ls_orden_destino = sle_orden_cobro_destino.text

// Revisa si las ordenes origen y destino son validas
if wf_ordenes_validas(ls_orden_origen, ls_orden_destino) then
	li_confirma = MessageBox("Confirmacion", "Desea sustituir la orden de cobro ["+ls_orden_origen &
	                        +"] con la orden ["+ ls_orden_destino+"]", Question!, YesNo!)
	if li_confirma = 1 then

		li_resultado_asignacion = f_reasigna_orden_cobro_plant(ls_orden_origen, ls_orden_destino)
		if li_resultado_asignacion= -1 then
			MessageBox("Atención", "Favor de Intentar nuevamente", StopSign!)
			return 	
		elseif li_resultado_asignacion= 0 then
			MessageBox("Actualizacion Exitosa", "Se ha reasignado exitosamente la orden de cobro", Information!)
			return 	
		elseif li_resultado_asignacion= 100 then
			MessageBox("Actualizacion sin Registros", "No existen registros a reasignar", Information!)
			return 	
		end if
	end if
else
	MessageBox("Atención", "Favor de corregir la informacion", StopSign!)
	return 
end if
end event

type sle_orden_cobro from singlelineedit within w_reasigna_orden_cobro_plant
int X=212
int Y=262
int Width=457
int Height=109
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean AutoHScroll=false
int Limit=12
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_reasigna_orden_cobro_plant
int X=194
int Y=106
int Width=490
int Height=122
boolean Enabled=false
string Text="Orden de cobro Origen/Temporal"
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=33554432
long BackColor=67108864
int TextSize=-10
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

