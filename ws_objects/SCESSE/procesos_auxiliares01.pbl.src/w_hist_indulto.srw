$PBExportHeader$w_hist_indulto.srw
forward
global type w_hist_indulto from window
end type
type uo_1 from uo_per_ani within w_hist_indulto
end type
type uo_nombre from uo_nombre_alumno within w_hist_indulto
end type
type dw_reingresos_hist_indulto from datawindow within w_hist_indulto
end type
type dw_hist_reingreso from datawindow within w_hist_indulto
end type
end forward

global type w_hist_indulto from window
integer x = 5
integer y = 4
integer width = 3529
integer height = 1772
boolean titlebar = true
string title = "Indultos"
string menuname = "m_reingresos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 27291696
uo_1 uo_1
uo_nombre uo_nombre
dw_reingresos_hist_indulto dw_reingresos_hist_indulto
dw_hist_reingreso dw_hist_reingreso
end type
global w_hist_indulto w_hist_indulto

type variables
long cuenta = 0
boolean cap_anio 
end variables

on w_hist_indulto.create
if this.MenuName = "m_reingresos" then this.MenuID = create m_reingresos
this.uo_1=create uo_1
this.uo_nombre=create uo_nombre
this.dw_reingresos_hist_indulto=create dw_reingresos_hist_indulto
this.dw_hist_reingreso=create dw_hist_reingreso
this.Control[]={this.uo_1,&
this.uo_nombre,&
this.dw_reingresos_hist_indulto,&
this.dw_hist_reingreso}
end on

on w_hist_indulto.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.uo_nombre)
destroy(this.dw_reingresos_hist_indulto)
destroy(this.dw_hist_reingreso)
end on

event open;// Juan Campos. Abril-1997.

this.x = 1
this.y = 1
String  Parametro 

Parametro = Message.StringParm 

dw_hist_reingreso.SetTransObject(gtr_sce)
dw_reingresos_hist_indulto.SetTransObject(gtr_sce)
this.uo_nombre.em_cuenta.setfocus()
 

end event

event doubleclicked;// Juan Campos. Abril-1997.
int res
Cuenta = long(w_hist_indulto.uo_nombre.em_cuenta.text)
long ll_row

if cuenta <> 0 then  
	if dw_hist_reingreso.retrieve(Cuenta) = 0 Then 
		ll_row = dw_hist_reingreso.insertrow(0)
		dw_hist_reingreso.SetItem(ll_row, 'periodo', gi_periodo)
		dw_hist_reingreso.SetItem(ll_row, 'anio', gi_anio)
	else
		if (MessageBox("Atención", "Este alumno ya tiene un reingreso desea insertar uno nuevo?",&
			Information! , YesNo!, 2) = 1) then
			dw_hist_reingreso.insertrow(0)
		end if
	end if

	dw_hist_reingreso.setfocus()
else
	w_hist_indulto.uo_nombre.em_cuenta.setfocus()
end if
end event

type uo_1 from uo_per_ani within w_hist_indulto
integer x = 2034
integer y = 492
integer taborder = 21
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type uo_nombre from uo_nombre_alumno within w_hist_indulto
integer x = 50
integer y = 36
integer width = 3241
integer height = 444
integer taborder = 20
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type dw_reingresos_hist_indulto from datawindow within w_hist_indulto
boolean visible = false
integer x = 2135
integer y = 1056
integer width = 928
integer height = 388
integer taborder = 10
string dataobject = "dw_reingresos_hist_indulto"
boolean border = false
boolean livescroll = true
end type

type dw_hist_reingreso from datawindow within w_hist_indulto
event keyboard pbm_dwnkey
integer x = 146
integer y = 928
integer width = 2391
integer height = 608
integer taborder = 30
string dataobject = "dw_hist_indulto"
boolean border = false
boolean livescroll = true
end type

event itemchanged;// Juan Campos. Abril-1997.

long	añoaux
string	columna

SetRow(1)
Columna = GetColumnname( )

if Columna = "anio" Then  // año 
	if dw_hist_reingreso.AcceptText( ) = 1 Then
		AñoAux = GetitemNumber(1,"anio")	
		if AñoAux < 100 then
			SetItem(1,"anio", 1900 + AñoAux)
			AcceptText( )
			AñoAux = GetitemNumber(1,"anio")			   
		End if
		if AñoAux > 1950  And AñoAux < 2100 Then
//		  cap_anio = true
//		  IF keydown(keyenter!) then
//	        SetColumn("cve_indulto")
//        end if
//		  IF keydown(keytab!) then
//	        SetColumn("anio")	
//        end if
			Filter()
		  	return 0  // acepta el valor
		Else
			cap_anio = False
			Messagebox("Años Validos","1950 al 2100]")
      		setitem(1,"anio","")
			Return 1 // rechaza el valor y no deja cambiar de focus
		end if		
	else
		cap_anio = false
      	setitem(1,"anio","")
	   	Return 1 // rechaza el valor y no deja cambiar de focus
	end if
end if

end event

