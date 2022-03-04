$PBExportHeader$w_aspi_alum_revalid.srw
forward
global type w_aspi_alum_revalid from window
end type
type dw_aspi_alum_revalid from datawindow within w_aspi_alum_revalid
end type
end forward

global type w_aspi_alum_revalid from window
integer x = 846
integer y = 372
integer width = 2734
integer height = 640
boolean titlebar = true
string title = "Seleccion de los Aspirantes a Revalidacion"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
dw_aspi_alum_revalid dw_aspi_alum_revalid
end type
global w_aspi_alum_revalid w_aspi_alum_revalid

type variables
str_aspi_alum_revalid istr_aspirante
end variables

on w_aspi_alum_revalid.create
this.dw_aspi_alum_revalid=create dw_aspi_alum_revalid
this.Control[]={this.dw_aspi_alum_revalid}
end on

on w_aspi_alum_revalid.destroy
destroy(this.dw_aspi_alum_revalid)
end on

event open;istr_aspirante = message.powerobjectparm

end event

event close;long ll_num_rows

ll_num_rows = dw_aspi_alum_revalid.RowCount()
istr_aspirante.num_rows = ll_num_rows

//dw_inicio.retrieve(ll_cuenta)
CloseWithReturn(w_aspi_alum_revalid, istr_aspirante)

end event

type dw_aspi_alum_revalid from datawindow within w_aspi_alum_revalid
integer x = 50
integer y = 44
integer width = 2569
integer height = 428
integer taborder = 10
string dataobject = "d_aspi_alum_revalid"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;long ll_null
SetNull(ll_null)

this.SetTransObject(gtr_sce)

this.Object.bo_folio.Action = "0"
this.Object.bo_cuenta.Action = "0"
this.Object.bo_apaterno.Action = "0"
this.Object.bo_amaterno.Action = "0"
this.Object.bo_nombre.Action = "0"

istr_aspirante = message.powerobjectparm
//MessageBox("apaterno",istr_aspirante.apaterno)
//MessageBox("amaterno",istr_aspirante.amaterno)
//MessageBox("nombre",istr_aspirante.nombre)
istr_aspirante.num_rows =this.Retrieve(ll_null, ll_null, istr_aspirante.apaterno, istr_aspirante.amaterno, istr_aspirante.nombre, gs_tipo_periodo) 





end event

event buttonclicked;string ls_type, ls_name

ls_name = string(dwo.Name)

//if ls_name<> "" and not isnull(ls_name) then
//	MessageBox("Boton",ls_name)
//end if
		
if ls_name ="bo_apaterno" then
	this.SetSort("apaterno A")
end if

if ls_name="bo_amaterno" then
	this.SetSort("amaterno A")
end if

if ls_name="bo_nombre" then
	this.SetSort("nombre A")
end if

if ls_name="bo_folio" then
	this.SetSort("folio A")
end if

if ls_name="bo_cuenta" then
	this.SetSort("cuenta A")
end if

this.Sort()

		
		
end event

event doubleclicked;/*Este evento funciona para realizar el Retrieve de los datos
tras la selección del alumno
*/
string ls_apaterno, ls_amaterno, ls_nombre
long ll_folio, ll_num_rows, ll_cuenta

ll_num_rows = this.RowCount()

if ll_num_rows > 0 then
	ll_folio = this.getitemnumber(this.getrow(),"folio")
	ll_cuenta = this.getitemnumber(this.getrow(),"cuenta")
	ls_apaterno = this.getitemstring(this.getrow(),"apaterno")
	ls_amaterno = this.getitemstring(this.getrow(),"amaterno")
	ls_nombre = this.getitemstring(this.getrow(),"nombre")
else
	ll_folio = 0
end if

istr_aspirante.folio = ll_folio
istr_aspirante.cuenta = ll_cuenta
istr_aspirante.apaterno = ls_apaterno
istr_aspirante.amaterno = ls_amaterno
istr_aspirante.nombre = ls_nombre

istr_aspirante.num_rows = ll_num_rows
//
////dw_inicio.retrieve(ll_cuenta)
CloseWithReturn(w_aspi_alum_revalid, istr_aspirante)

end event

event retrieveend;istr_aspirante.num_rows = this.rowcount()

////dw_inicio.retrieve(ll_cuenta)
if istr_aspirante.num_rows = 0 then
	istr_aspirante.folio = 0
	CloseWithReturn(w_aspi_alum_revalid, istr_aspirante)
end if
end event

