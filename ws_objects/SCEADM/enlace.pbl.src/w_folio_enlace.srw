$PBExportHeader$w_folio_enlace.srw
forward
global type w_folio_enlace from window
end type
type st_1 from statictext within w_folio_enlace
end type
type em_folio from editmask within w_folio_enlace
end type
end forward

global type w_folio_enlace from window
integer width = 859
integer height = 346
boolean titlebar = true
string title = "Favor de Escribir el Número de Folio"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
st_1 st_1
em_folio em_folio
end type
global w_folio_enlace w_folio_enlace

type variables
long il_folio 
integer ii_clv_ver, ii_clv_per, ii_anio
end variables

on w_folio_enlace.create
this.st_1=create st_1
this.em_folio=create em_folio
this.Control[]={this.st_1,&
this.em_folio}
end on

on w_folio_enlace.destroy
destroy(this.st_1)
destroy(this.em_folio)
end on

event open;str_aspirante lstr_aspirante
long ll_num_empleado, ll_row
x= 1
y= 1
//Creacion del objeto encargado de duplicar las solicitudes

lstr_aspirante = Message.PowerObjectParm		

il_folio = lstr_aspirante.folio
ii_clv_ver = lstr_aspirante.clv_ver
ii_clv_per = lstr_aspirante.clv_per
ii_anio = lstr_aspirante.anio

end event

type st_1 from statictext within w_folio_enlace
integer x = 69
integer y = 86
integer width = 190
integer height = 74
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Folio:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_folio from editmask within w_folio_enlace
integer x = 322
integer y = 70
integer width = 380
integer height = 106
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

event modified;long ll_folio_escrito,ll_folio_consultado
str_aspirante lstr_aspirante

ll_folio_escrito=long(text)
						
	SELECT aspiran.folio
	INTO :ll_folio_consultado
	FROM aspiran
	WHERE (aspiran.folio = :ll_folio_escrito) AND
			(aspiran.clv_ver = :ii_clv_ver) AND
			(aspiran.clv_per = :ii_clv_per) AND
			(aspiran.anio = :ii_anio)
	USING gtr_sadm;
	if isnull(ll_folio_consultado) then
		ll_folio_consultado=1
	end if

	if (ll_folio_escrito<>ll_folio_consultado)and(ll_folio_escrito>1) then
		lstr_aspirante.folio = ll_folio_escrito
		lstr_aspirante.clv_ver = ii_clv_ver
		lstr_aspirante.clv_per = ii_clv_per
		CloseWithReturn(parent,lstr_aspirante)
	else
		messagebox("Ese folio ya existe","Favor de Verificarlo")
	end if


end event

