$PBExportHeader$w_busca_municipios.srw
forward
global type w_busca_municipios from window
end type
type cb_salir from commandbutton within w_busca_municipios
end type
type cb_seleccionar from commandbutton within w_busca_municipios
end type
type dw_filtro from datawindow within w_busca_municipios
end type
type dw_lista from datawindow within w_busca_municipios
end type
end forward

global type w_busca_municipios from window
integer width = 2725
integer height = 1420
boolean titlebar = true
string title = "Búsqueda de Municipios"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_salir cb_salir
cb_seleccionar cb_seleccionar
dw_filtro dw_filtro
dw_lista dw_lista
end type
global w_busca_municipios w_busca_municipios

type variables
LONG li_cve_estado



end variables

event open;li_cve_estado = MESSAGE.doubleparm 

dw_filtro.INSERTROW(0) 
dw_lista.SETTRANSOBJECT(gtr_sce)
dw_lista.RETRIEVE() 



end event

on w_busca_municipios.create
this.cb_salir=create cb_salir
this.cb_seleccionar=create cb_seleccionar
this.dw_filtro=create dw_filtro
this.dw_lista=create dw_lista
this.Control[]={this.cb_salir,&
this.cb_seleccionar,&
this.dw_filtro,&
this.dw_lista}
end on

on w_busca_municipios.destroy
destroy(this.cb_salir)
destroy(this.cb_seleccionar)
destroy(this.dw_filtro)
destroy(this.dw_lista)
end on

type cb_salir from commandbutton within w_busca_municipios
integer x = 2258
integer y = 1164
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT)
end event

type cb_seleccionar from commandbutton within w_busca_municipios
integer x = 1829
integer y = 1164
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Seleccionar"
end type

event clicked;INTEGER li_row
LONG ll_cve_mun_loc

li_row = dw_lista.GETROW() 
IF li_row = 0 THEN RETURN
ll_cve_mun_loc = dw_lista.GETITEMNUMBER(li_row, "cve_mun_loc")   

CLOSEWITHRETURN(PARENT, ll_cve_mun_loc)

end event

type dw_filtro from datawindow within w_busca_municipios
integer x = 73
integer y = 64
integer width = 2574
integer height = 216
integer taborder = 10
string title = "none"
string dataobject = "dw_municipio_busqueda_filtro"
boolean border = false
boolean livescroll = true
end type

event editchanged;STRING ls_filtro 

IF dwo.name = "cve_mun_loc"  AND TRIM(data) <> "" THEN  
	ls_filtro = "STRING(cve_mun_loc) like '%" + data + "%'"  
	
ELSEIF dwo.name = "municipio"  AND TRIM(data) <> ""   THEN  
	ls_filtro = "STRING(municipio) like '%" + data + "%'"  
	
ELSEIF dwo.name = "localidad"  AND TRIM(data) <> ""   THEN  
	ls_filtro = "STRING(localidad) like '%" + data + "%'"  	

END IF 

IF LOWER(gs_servidor) <> LOWER("Mexico") THEN 
	IF ls_filtro <> "" THEN 
		ls_filtro = "(" + ls_filtro + ") AND (STRING(cve_estado) = '" + STRING(li_cve_estado) + "')"
	ELSE
		ls_filtro = "cve_estado = " + STRING(li_cve_estado)
	END IF	
END IF

dw_lista.SETFILTER(ls_filtro) 
dw_lista.FILTER() 

dw_lista.SETSORT("cve_mun_loc ASC") 
dw_lista.SORT() 

dw_lista.event rowfocuschanged(1)
end event

event itemfocuschanged;This.setItem(row, "cve_mun_loc", 0)
This.setItem(row, "municipio", "")
This.setItem(row, "localidad", "")

This.Event EditChanged(row,dwo,"")

end event

type dw_lista from datawindow within w_busca_municipios
integer x = 73
integer y = 328
integer width = 2587
integer height = 804
integer taborder = 10
string title = "none"
string dataobject = "dw_municipio_localidad"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;THIS.SELECTROW(0, FALSE)
THIS.SELECTROW(CURRENTROW, TRUE) 
THIS.SETROW(CURRENTROW) 





end event

event doubleclicked;
cb_seleccionar.TRIGGEREVENT(CLICKED!)




end event

