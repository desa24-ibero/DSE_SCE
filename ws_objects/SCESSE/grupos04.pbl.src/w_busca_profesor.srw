$PBExportHeader$w_busca_profesor.srw
forward
global type w_busca_profesor from window
end type
type st_2 from statictext within w_busca_profesor
end type
type st_1 from statictext within w_busca_profesor
end type
type cb_2 from commandbutton within w_busca_profesor
end type
type cb_seleccionar from commandbutton within w_busca_profesor
end type
type dw_filtro from datawindow within w_busca_profesor
end type
type dw_lista from datawindow within w_busca_profesor
end type
end forward

global type w_busca_profesor from window
integer width = 3735
integer height = 1540
boolean titlebar = true
string title = "Búsqueda de Materias por Coordinación"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
cb_2 cb_2
cb_seleccionar cb_seleccionar
dw_filtro dw_filtro
dw_lista dw_lista
end type
global w_busca_profesor w_busca_profesor

type variables
LONG il_coordinacion  

STRING is_sort

end variables

event open;
il_coordinacion = MESSAGE.doubleparm 

dw_filtro.INSERTROW(0) 


dw_lista.SETTRANSOBJECT(gtr_sce) 
dw_lista.RETRIEVE() 


is_sort = "asc"
end event

on w_busca_profesor.create
this.st_2=create st_2
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_seleccionar=create cb_seleccionar
this.dw_filtro=create dw_filtro
this.dw_lista=create dw_lista
this.Control[]={this.st_2,&
this.st_1,&
this.cb_2,&
this.cb_seleccionar,&
this.dw_filtro,&
this.dw_lista}
end on

on w_busca_profesor.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_seleccionar)
destroy(this.dw_filtro)
destroy(this.dw_lista)
end on

type st_2 from statictext within w_busca_profesor
integer x = 73
integer y = 184
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Filtro "
boolean focusrectangle = false
end type

type st_1 from statictext within w_busca_profesor
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

type cb_2 from commandbutton within w_busca_profesor
integer x = 3191
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

type cb_seleccionar from commandbutton within w_busca_profesor
integer x = 2761
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
LONG ll_cve_profesor


le_row = dw_lista.GETROW() 
ll_cve_profesor = dw_lista.GETITEMNUMBER(le_row, "cve_profesor")   

CLOSEWITHRETURN(PARENT, ll_cve_profesor)    





end event

type dw_filtro from datawindow within w_busca_profesor
integer x = 73
integer y = 268
integer width = 3511
integer height = 112
integer taborder = 10
string title = "none"
string dataobject = "dw_profesor_busca_filtro"
boolean border = false
boolean livescroll = true
end type

event editchanged;STRING ls_filtro 

IF dwo.name = "cve_profesor"  AND TRIM(data) <> "" THEN  
	
	ls_filtro = "STRING(cve_profesor) like '%" + data + "%'"  
	
ELSEIF dwo.name = "apaterno"  AND TRIM(data) <> ""   THEN  
	
	ls_filtro = "apaterno like '%" + data + "%'"  
	
ELSEIF dwo.name = "amaterno"  AND TRIM(data) <> ""   THEN  
	
	ls_filtro = "amaterno like '%" + data + "%'"  	

ELSEIF dwo.name = "nombre"  AND TRIM(data) <> ""   THEN   
	
	ls_filtro = "nombre like '%" + data + "%'"  	
	
END IF 


dw_lista.SETFILTER(ls_filtro) 
dw_lista.FILTER() 

dw_lista.SETSORT("cve_mat ASC") 
dw_lista.SORT() 







end event

type dw_lista from datawindow within w_busca_profesor
integer x = 73
integer y = 428
integer width = 3511
integer height = 804
integer taborder = 10
string title = "none"
string dataobject = "dw_profesor_busca_lista"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;THIS.SELECTROW(0, FALSE)
THIS.SELECTROW(CURRENTROW, TRUE) 
THIS.SETROW(CURRENTROW) 





end event

event doubleclicked;
STRING ls_sort

CHOOSE CASE dwo.name 
		
	CASE "cve_profesor_t", "apaterno_t", "amaterno_t", "nombre_t" 
		
		ls_sort = dwo.name 
		
		IF is_sort = "asc" THEN 
			is_sort = "desc"
		ELSE
			is_sort = "asc"
		END IF
		
		ls_sort = LEFT(ls_sort, LEN(ls_sort) - 2) 
		THIS.SETSORT(ls_sort + " " + is_sort) 
		THIS.SORT() 
		
	CASE ELSE
		
		cb_seleccionar.TRIGGEREVENT(CLICKED!) 		
		
END CHOOSE








end event

