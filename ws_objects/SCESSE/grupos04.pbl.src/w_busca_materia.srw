$PBExportHeader$w_busca_materia.srw
forward
global type w_busca_materia from window
end type
type st_1 from statictext within w_busca_materia
end type
type cb_2 from commandbutton within w_busca_materia
end type
type cb_seleccionar from commandbutton within w_busca_materia
end type
type dw_filtro from datawindow within w_busca_materia
end type
type dw_lista from datawindow within w_busca_materia
end type
end forward

global type w_busca_materia from window
integer width = 3433
integer height = 1532
boolean titlebar = true
string title = "Búsqueda de Materias por Coordinación"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_1 st_1
cb_2 cb_2
cb_seleccionar cb_seleccionar
dw_filtro dw_filtro
dw_lista dw_lista
end type
global w_busca_materia w_busca_materia

type variables
LONG il_coordinacion  



end variables

event open;
il_coordinacion = MESSAGE.doubleparm 

dw_filtro.INSERTROW(0) 


dw_lista.SETTRANSOBJECT(gtr_sce) 
dw_lista.RETRIEVE(il_coordinacion) 



end event

on w_busca_materia.create
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_seleccionar=create cb_seleccionar
this.dw_filtro=create dw_filtro
this.dw_lista=create dw_lista
this.Control[]={this.st_1,&
this.cb_2,&
this.cb_seleccionar,&
this.dw_filtro,&
this.dw_lista}
end on

on w_busca_materia.destroy
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_seleccionar)
destroy(this.dw_filtro)
destroy(this.dw_lista)
end on

type st_1 from statictext within w_busca_materia
integer x = 27
integer y = 44
integer width = 2807
integer height = 100
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "* Una vez seleccionada la materia haga doble click sobre ella o presione el botón seleccionar."
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_busca_materia
integer x = 2798
integer y = 1276
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

type cb_seleccionar from commandbutton within w_busca_materia
integer x = 2368
integer y = 1276
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

event clicked;INTEGER le_row
LONG ll_cve_materia


le_row = dw_lista.GETROW() 
ll_cve_materia = dw_lista.GETITEMNUMBER(le_row, "cve_mat")   

CLOSEWITHRETURN(PARENT, ll_cve_materia)    





end event

type dw_filtro from datawindow within w_busca_materia
integer x = 73
integer y = 164
integer width = 3099
integer height = 216
integer taborder = 10
string title = "none"
string dataobject = "dw_materias_busqueda1_filtro"
boolean border = false
boolean livescroll = true
end type

event editchanged;STRING ls_filtro 

IF dwo.name = "materia"  AND TRIM(data) <> "" THEN  
	
	
	ls_filtro = "materia like '%" + data + "%'"  
	
ELSEIF dwo.name = "cve_mat"  AND TRIM(data) <> ""   THEN  
	
	ls_filtro = "STRING(cve_mat) like '%" + data + "%'"  
	
ELSEIF dwo.name = "sigla"  AND TRIM(data) <> ""   THEN  
	
	ls_filtro = "STRING(sigla) like '%" + data + "%'"  	
	
END IF 


dw_lista.SETFILTER(ls_filtro) 
dw_lista.FILTER() 

dw_lista.SETSORT("cve_mat ASC") 
dw_lista.SORT() 


//cve_mat
//
//
//
//dw_filtro.INSERTROW(0) 
//dw_lista.RETRIEVE(il_coordinacion) 




end event

type dw_lista from datawindow within w_busca_materia
integer x = 73
integer y = 428
integer width = 3099
integer height = 804
integer taborder = 10
string title = "none"
string dataobject = "dw_materias_busqueda1"
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

