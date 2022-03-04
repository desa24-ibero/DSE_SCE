$PBExportHeader$w_bitacoras_2014.srw
$PBExportComments$Reporte de bitácora, de  los movimientos al histórico.   Juan Campos. Marzo-1997.
forward
global type w_bitacoras_2014 from window
end type
type st_sistema from statictext within w_bitacoras_2014
end type
type p_ibero from picture within w_bitacoras_2014
end type
type cbx_todos from checkbox within w_bitacoras_2014
end type
type st_periodo_año from statictext within w_bitacoras_2014
end type
type uo_cap_periodo from uo_periodo within w_bitacoras_2014
end type
type dw_bitacora_periodo from datawindow within w_bitacoras_2014
end type
type em_fecha_final from editmask within w_bitacoras_2014
end type
type st_fecha from statictext within w_bitacoras_2014
end type
type st_2 from statictext within w_bitacoras_2014
end type
type st_1 from statictext within w_bitacoras_2014
end type
type em_fecha_inicio from editmask within w_bitacoras_2014
end type
type dw_bitacora from datawindow within w_bitacoras_2014
end type
type rr_1 from roundrectangle within w_bitacoras_2014
end type
type rr_2 from roundrectangle within w_bitacoras_2014
end type
end forward

global type w_bitacoras_2014 from window
integer x = 5
integer y = 4
integer width = 4128
integer height = 2664
boolean titlebar = true
string title = "REPORTES BITACORAS HISTÓRICO"
string menuname = "m_bitacoras"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
st_sistema st_sistema
p_ibero p_ibero
cbx_todos cbx_todos
st_periodo_año st_periodo_año
uo_cap_periodo uo_cap_periodo
dw_bitacora_periodo dw_bitacora_periodo
em_fecha_final em_fecha_final
st_fecha st_fecha
st_2 st_2
st_1 st_1
em_fecha_inicio em_fecha_inicio
dw_bitacora dw_bitacora
rr_1 rr_1
rr_2 rr_2
end type
global w_bitacoras_2014 w_bitacoras_2014

type variables
boolean primeravez = false
end variables

on w_bitacoras_2014.create
if this.MenuName = "m_bitacoras" then this.MenuID = create m_bitacoras
this.st_sistema=create st_sistema
this.p_ibero=create p_ibero
this.cbx_todos=create cbx_todos
this.st_periodo_año=create st_periodo_año
this.uo_cap_periodo=create uo_cap_periodo
this.dw_bitacora_periodo=create dw_bitacora_periodo
this.em_fecha_final=create em_fecha_final
this.st_fecha=create st_fecha
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_inicio=create em_fecha_inicio
this.dw_bitacora=create dw_bitacora
this.rr_1=create rr_1
this.rr_2=create rr_2
this.Control[]={this.st_sistema,&
this.p_ibero,&
this.cbx_todos,&
this.st_periodo_año,&
this.uo_cap_periodo,&
this.dw_bitacora_periodo,&
this.em_fecha_final,&
this.st_fecha,&
this.st_2,&
this.st_1,&
this.em_fecha_inicio,&
this.dw_bitacora,&
this.rr_1,&
this.rr_2}
end on

on w_bitacoras_2014.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_sistema)
destroy(this.p_ibero)
destroy(this.cbx_todos)
destroy(this.st_periodo_año)
destroy(this.uo_cap_periodo)
destroy(this.dw_bitacora_periodo)
destroy(this.em_fecha_final)
destroy(this.st_fecha)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_inicio)
destroy(this.dw_bitacora)
destroy(this.rr_1)
destroy(this.rr_2)
end on

event open;// Documentación pendiente
// Juan Campos. Febrero-1997.

//g_nv_security.fnv_secure_window (this)

this.x = 1
This.y = 1

String  Parametro 

dw_bitacora.SetTransObject(gtr_sce)
dw_bitacora_periodo.SetTransObject(gtr_sce)

Parametro	= Message.StringParm 
em_fecha_final.visible	= false

If Parametro = "POR_FECHAS" Then
  	w_bitacoras.title = "REPORTE BITÁCORA HISTÓRICO POR FECHAS"	 
  	em_fecha_inicio.visible		=	True
  	em_fecha_inicio.enabled	=	True
  	em_fecha_final.visible	=	True
  	em_fecha_final.enabled	=	True
  	st_1.visible	= True
  	st_2.visible	= True
  	rr_1.visible	= True
  	rr_2.visible	= True
//  	w_bitacoras.uo_cap_periodo.visible = False
//  	w_bitacoras.uo_cap_periodo.enabled = False
  	st_fecha.visible = True
  	st_periodo_año.visible = False
  	dw_bitacora.visible = True
  	dw_bitacora.enabled = True
  	dw_bitacora_periodo.visible = False
  	dw_bitacora_periodo.enabled = False
  	dw_bitacora.height = 1350
  em_fecha_inicio.setfocus()
End If     

If Parametro = "POR_PERIODO" Then
  	w_bitacoras.title = "REPORTE BITÁCORA HISTÓRICO POR PERIODO"	 
  	em_fecha_inicio.visible = False
  	em_fecha_inicio.enabled = False
  	em_fecha_final.visible = False
  	em_fecha_final.enabled = False
  	st_1.visible = False
  	st_2.visible = False
  	rr_1.visible = False
  	rr_2.visible = False
  	w_bitacoras.uo_cap_periodo.visible = True
  	w_bitacoras.uo_cap_periodo.enabled = True 
  	st_fecha.visible = False
  	st_periodo_año.visible = True
  	dw_bitacora.visible = False
  	dw_bitacora.enabled = False
  	dw_bitacora_periodo.visible = True
  	dw_bitacora_periodo.enabled = True
  	dw_bitacora_periodo.x = 28
  	dw_bitacora_periodo.y = 297
  	dw_bitacora_periodo.height = 1350
  	st_periodo_año.x = 1180 
  	st_periodo_año.y = 21
  	w_bitacoras.uo_cap_periodo.x = 46
  	w_bitacoras.uo_cap_periodo.y = 137
End If     
end event

event close;//close(this)
end event

type st_sistema from statictext within w_bitacoras_2014
integer x = 782
integer y = 124
integer width = 229
integer height = 100
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_ibero from picture within w_bitacoras_2014
integer x = 37
integer y = 40
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type cbx_todos from checkbox within w_bitacoras_2014
integer x = 2240
integer y = 372
integer width = 338
integer height = 76
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "TODOS"
boolean lefttext = true
end type

event clicked;if this.checked  then
//   w_bitacoras.uo_cap_periodo.visible = False
  	w_bitacoras.uo_cap_periodo.enabled = False
else	  
  	w_bitacoras.uo_cap_periodo.enabled = true
end if
end event

type st_periodo_año from statictext within w_bitacoras_2014
integer x = 2661
integer y = 228
integer width = 571
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "PERIODO   AÑO"
alignment alignment = center!
long bordercolor = 8388608
boolean focusrectangle = false
end type

type uo_cap_periodo from uo_periodo within w_bitacoras_2014
integer x = 2592
integer y = 328
integer width = 818
integer height = 172
integer taborder = 10
long backcolor = 16777215
borderstyle borderstyle = styleraised!
end type

on uo_cap_periodo.destroy
call uo_periodo::destroy
end on

type dw_bitacora_periodo from datawindow within w_bitacoras_2014
integer x = 46
integer y = 1496
integer width = 3447
integer height = 956
integer taborder = 40
string dataobject = "dw_bitacora_periodo"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_bitacora_periodo.object.fecha_hoy.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)
end event

event retrieveend;// Se asigna el digito verificador a una columna auxiliar, "cve_movimiento".
// pero esto es solo hasta que el retrieve del data window termina para que la 
// asignacion no afecte a otras columnas. Ver codigo del query del data window.
// Juan Campos. febrero-1997


Integer Contador,Renglon
long    CuentaInt
Char    Digito

primeravez = True 

FOR Contador = 1 To RowCount()
  SetRow(Contador)		
  CuentaInt = GetItemNumber(GetRow(),1)  
  Digito = obten_digito(CuentaInt)  
  SetItem(Contador,2,Integer(Digito))
NEXT
 
dw_bitacora_periodo.SetRow(1)
dw_bitacora_periodo.ScrollToRow(dw_bitacora.GetRow())  
dw_bitacora_periodo.SetRowFocusIndicator(Hand!)  


 
end event

event rowfocuschanged;// Juan Campos. Marzo-1997.

if not primeravez then

dw_bitacora_periodo.SetRow(dw_bitacora.GetRow())
dw_bitacora_periodo.ScrollToRow(dw_bitacora.GetRow())  
dw_bitacora_periodo.SetRowFocusIndicator(Hand!)     

end if


end event

type em_fecha_final from editmask within w_bitacoras_2014
integer x = 1577
integer y = 368
integer width = 439
integer height = 92
integer taborder = 20
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

event modified;
If em_fecha_final.text = "" Then 
  em_fecha_final.setfocus() 
Else
  em_fecha_final.setfocus()
  m_bitacoras.m_reporte.show()
End If
end event

event losefocus;// 	Se incrementa en uno el dia. Esto es un truco para que el between tome el rango
// 	de la fecha correctamente.
// 	Ejemplo:  
//  	Rango  '18-02-97' Between '20-02-97'    Error. Si existen datos con estas fechas nos 
//                                                 trae del '18-02-97' al '19-02-97'. 
//
//  	Rango  ´18-02-97  Between '20-02-97' + Un Dia  Ok Rango Correcto nos trae del '18-02-97' al '20-02-97'. 
// 	Juan Campos. Febrero 1997.

String  	Dia, Mes, Año
Integer 	DiaEntero
 
//Dia       		= Mid(em_fecha_auxiliar.text, 1, 2)
//Mes       		= Mid(em_fecha_auxiliar.text, 4, 2)
//Año       		= Mid(em_fecha_auxiliar.text, 7, 2)
//DiaEntero 	= Integer(Dia) + 1
//Dia       		= String(DiaEntero)
//
//em_fecha_final.text = Dia + "-" + Mes +"-"+ año


end event

type st_fecha from statictext within w_bitacoras_2014
integer x = 1257
integer y = 232
integer width = 1129
integer height = 80
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "FECHA VALIDA: DIA-MES-AÑO"
alignment alignment = center!
long bordercolor = 15793151
boolean focusrectangle = false
end type

type st_2 from statictext within w_bitacoras_2014
integer x = 1147
integer y = 368
integer width = 425
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "Fecha_Final:"
boolean border = true
long bordercolor = 8388608
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_1 from statictext within w_bitacoras_2014
integer x = 110
integer y = 368
integer width = 448
integer height = 92
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "Fecha_Inicio:"
boolean border = true
long bordercolor = 8388608
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type em_fecha_inicio from editmask within w_bitacoras_2014
integer x = 562
integer y = 368
integer width = 439
integer height = 92
integer taborder = 30
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
string displaydata = "~b"
end type

event modified;if em_fecha_inicio.text = "" Then 
  em_fecha_inicio.setfocus()
Else
  em_fecha_final.setfocus()	
End If


end event

event getfocus;em_fecha_inicio.selecttext(1,len(em_fecha_inicio.text))
end event

type dw_bitacora from datawindow within w_bitacoras_2014
integer x = 41
integer y = 528
integer width = 3447
integer height = 956
integer taborder = 50
string dataobject = "dw_bitacora_2014"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_bitacora.object.fecha_hoy.text = Mid(fecha_espaniol_servidor(gtr_sce),1,11)


end event

event retrieveend;// Se asigna el digito verificador a una columna auxiliar, "cve_movimiento".
// pero esto es solo hasta que el retrieve del data window termina para que la 
// asignacion no afecte a otras columnas. Ver codigo del query del data window.
// Juan Campos. febrero-1997


Integer 	Contador,Renglon
long    	CuentaInt
Char    	Digito

primeravez = True 

FOR Contador = 1 To RowCount()
  	SetRow(Contador)		
  	CuentaInt = GetItemNumber(GetRow(),1)  
  	Digito = obten_digito(CuentaInt)  
  	SetItem(Contador,2,Integer(Digito))
NEXT
 
dw_bitacora.SetRow(1)
dw_bitacora.ScrollToRow(dw_bitacora.GetRow())  
dw_bitacora.SetRowFocusIndicator(Hand!) 


end event

event rowfocuschanged; // Juan Campos. Marzo-1997.

if not primeravez then
	dw_bitacora.SetRow(dw_bitacora.GetRow())
	dw_bitacora.ScrollToRow(dw_bitacora.GetRow())  
	dw_bitacora.SetRowFocusIndicator(Hand!)     
end if


end event

type rr_1 from roundrectangle within w_bitacoras_2014
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 16777215
integer x = 128
integer y = 352
integer width = 887
integer height = 124
integer cornerheight = 42
integer cornerwidth = 40
end type

type rr_2 from roundrectangle within w_bitacoras_2014
long linecolor = 16777215
integer linethickness = 3
long fillcolor = 16777215
integer x = 1143
integer y = 352
integer width = 887
integer height = 124
integer cornerheight = 42
integer cornerwidth = 40
end type

