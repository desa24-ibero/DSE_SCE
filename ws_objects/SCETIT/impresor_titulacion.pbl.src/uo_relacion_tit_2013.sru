$PBExportHeader$uo_relacion_tit_2013.sru
forward
global type uo_relacion_tit_2013 from userobject
end type
type st_1 from statictext within uo_relacion_tit_2013
end type
type em_fecha_fin from editmask within uo_relacion_tit_2013
end type
type em_fecha_ini from editmask within uo_relacion_tit_2013
end type
type dw_relaciones from datawindow within uo_relacion_tit_2013
end type
type gb_1 from groupbox within uo_relacion_tit_2013
end type
end forward

global type uo_relacion_tit_2013 from userobject
integer width = 1344
integer height = 272
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_1 st_1
em_fecha_fin em_fecha_fin
em_fecha_ini em_fecha_ini
dw_relaciones dw_relaciones
gb_1 gb_1
end type
global uo_relacion_tit_2013 uo_relacion_tit_2013

type variables
Transaction itran_obj_relacion
DatawindowChild dwcRelacion
long il_filtro_tipo_relacion
end variables

forward prototypes
public function integer of_carga_control (transaction ar_tran_obj_relacion, integer ar_i_anio)
public function date of_obtiene_fecha_ini ()
public function date of_obtiene_fecha_fin ()
public function integer of_obtiene_cve_relacion ()
public function integer of_obtiene_tipo_relacion ()
end prototypes

public function integer of_carga_control (transaction ar_tran_obj_relacion, integer ar_i_anio);Integer rtncode 
itran_obj_relacion = ar_tran_obj_relacion
Long ll_row
Date ld_fecha1, ld_fecha2

If il_filtro_tipo_relacion > 0 Then
	dw_relaciones.dataobject = "dddw_relacion_doc_tit_x_tipo"
Else
	dw_relaciones.dataobject = "dddw_relacion_doc_tit"
End If

rtncode = dw_relaciones.GetChild("cve_relacion", dwcRelacion )

IF rtncode = -1 THEN 
	MessageBox("Error", "No se pudo recuperar el data window relacion")
	return -1
End If 

dw_relaciones.settransobject( itran_obj_relacion)
dwcRelacion.settransobject( itran_obj_relacion)

If il_filtro_tipo_relacion > 0 Then
	if dwcRelacion.Retrieve(ar_i_anio , il_filtro_tipo_relacion ) <= 0 then 
//	if dwcRelacion.Retrieve(ar_i_anio ) <= 0 then 
		messagebox('Información', 'No existen Relaciones para el año: ' + string (ar_i_anio) )
		return -1
	else
		dw_relaciones.retrieve(ar_i_anio , il_filtro_tipo_relacion )
	end if
Else
	if dwcRelacion.Retrieve(ar_i_anio  ) <= 0 then 
	   messagebox('Información', 'No existen Relaciones para el año: ' + string (ar_i_anio) )
		return -1
	else
		dw_relaciones.retrieve(ar_i_anio)
	end if
End If

dwcRelacion.accepttext()
ll_row = dwcRelacion.getrow()
ld_fecha1 = Date(dwcRelacion.getitemdatetime(ll_row,"fecha_inicial"))
ld_fecha2 = Date(dwcRelacion.getitemdatetime(ll_row, "fecha_final"))

em_fecha_ini.text = Right('0' + string(Day(ld_fecha1)), 2) + '/' + Right('0' + string(Month(ld_fecha1)), 2) + '/' + string(Year(ld_fecha1))
em_fecha_fin.text = Right('0' + string(Day(ld_fecha2)), 2) + '/' + Right('0' + string(Month(ld_fecha2)), 2) + '/' + string(Year(ld_fecha2))

return 0


end function

public function date of_obtiene_fecha_ini ();date	ld_fecha
string ls_fecha_inicial
long ll_row

dwcRelacion.accepttext()
ll_row = dwcRelacion.getrow()
ld_fecha = Date(dwcRelacion.getitemdatetime(ll_row, "fecha_inicial"))

return ld_fecha
end function

public function date of_obtiene_fecha_fin ();date	ld_fecha
string ls_fecha_inicial
long ll_row

dwcRelacion.accepttext()
ll_row = dwcRelacion.getrow()
ld_fecha = Date(dwcRelacion.getitemdatetime(ll_row, "fecha_final"))

return ld_fecha
end function

public function integer of_obtiene_cve_relacion ();integer li_relacion
string ls_fecha_inicial
long ll_row

dwcRelacion.accepttext()
ll_row = dwcRelacion.getrow()
li_relacion = dwcRelacion.getitemnumber(ll_row, "cve_relacion")

return li_relacion
end function

public function integer of_obtiene_tipo_relacion ();integer li_tipo_relacion
string ls_fecha_inicial
long ll_row

dwcRelacion.accepttext()
ll_row = dwcRelacion.getrow()
li_tipo_relacion = dwcRelacion.getitemnumber(ll_row, "cve_tipo_relacion")

return li_tipo_relacion
end function

on uo_relacion_tit_2013.create
this.st_1=create st_1
this.em_fecha_fin=create em_fecha_fin
this.em_fecha_ini=create em_fecha_ini
this.dw_relaciones=create dw_relaciones
this.gb_1=create gb_1
this.Control[]={this.st_1,&
this.em_fecha_fin,&
this.em_fecha_ini,&
this.dw_relaciones,&
this.gb_1}
end on

on uo_relacion_tit_2013.destroy
destroy(this.st_1)
destroy(this.em_fecha_fin)
destroy(this.em_fecha_ini)
destroy(this.dw_relaciones)
destroy(this.gb_1)
end on

type st_1 from statictext within uo_relacion_tit_2013
integer x = 837
integer y = 128
integer width = 82
integer height = 64
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
string text = "al"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_fecha_fin from editmask within uo_relacion_tit_2013
integer x = 919
integer y = 108
integer width = 361
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_ini from editmask within uo_relacion_tit_2013
integer x = 471
integer y = 108
integer width = 361
integer height = 88
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 15793151
alignment alignment = center!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type dw_relaciones from datawindow within uo_relacion_tit_2013
integer x = 46
integer y = 108
integer width = 379
integer height = 88
integer taborder = 10
string title = "none"
string dataobject = "dddw_relacion_doc_tit"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;date	ld_fecha1, ld_fecha2
string ls_fecha_inicial, ls_fecha_final
long ll_row

dwcRelacion.accepttext()
ll_row = dwcRelacion.getrow()
ld_fecha1 = Date(dwcRelacion.getitemdatetime(ll_row,"fecha_inicial"))
ld_fecha2 = Date(dwcRelacion.getitemdatetime(ll_row, "fecha_final"))

em_fecha_ini.text = Right('0' + string(Day(ld_fecha1)), 2) + '/' + Right('0' + string(Month(ld_fecha1)), 2) + '/' + string(Year(ld_fecha1))
em_fecha_fin.text = Right('0' + string(Day(ld_fecha2)), 2) + '/' + Right('0' + string(Month(ld_fecha2)), 2) + '/' + string(Year(ld_fecha2))
end event

type gb_1 from groupbox within uo_relacion_tit_2013
integer x = 14
integer y = 28
integer width = 1312
integer height = 220
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 12639424
string text = "Relación"
end type

