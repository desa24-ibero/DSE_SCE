$PBExportHeader$w_selecciona_periodo.srw
forward
global type w_selecciona_periodo from window
end type
type cb_2 from commandbutton within w_selecciona_periodo
end type
type cb_1 from commandbutton within w_selecciona_periodo
end type
type uo_periodo from uo_periodo_variable_tipos within w_selecciona_periodo
end type
type em_anio from editmask within w_selecciona_periodo
end type
type st_1 from statictext within w_selecciona_periodo
end type
end forward

global type w_selecciona_periodo from window
integer width = 2053
integer height = 760
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
uo_periodo uo_periodo
em_anio em_anio
st_1 st_1
end type
global w_selecciona_periodo w_selecciona_periodo

event open;// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)
em_anio.TEXT = STRING(gi_anio) 




end event

on w_selecciona_periodo.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_periodo=create uo_periodo
this.em_anio=create em_anio
this.st_1=create st_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.uo_periodo,&
this.em_anio,&
this.st_1}
end on

on w_selecciona_periodo.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_periodo)
destroy(this.em_anio)
destroy(this.st_1)
end on

type cb_2 from commandbutton within w_selecciona_periodo
integer x = 585
integer y = 496
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[], periodo_x[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo

//DATASTORE lds_paso
//lds_paso = CREATE DATASTORE 
//lds_paso.DATAOBJECT = THIS.DATAOBJECT
//lds_paso.SETTRANSOBJECT(itr_web)
//
INTEGER le_anio
le_anio = INTEGER(em_anio.TEXT)

PARENT.uo_periodo.of_recupera_periodos() 

periodo_x[] = le_periodo[]
//is_descripcion_periodo = ""
FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
//	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
//	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
	
//	lds_paso.RESET() 
//	IF lds_paso.retrieve(li_status,periodo_x[le_index],le_anio) > 0 THEN 
//		lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, THIS, THIS.ROWCOUNT() + 1, PRIMARY!)
//	END IF
	
NEXT 	

le_anio = INTEGER(em_anio.TEXT) 

CLOSEWITHRETURN(PARENT, STRING(periodo_x[1]) + "-" + STRING(le_anio))



//ls_tit = ls_tit + ' ' + is_descripcion_periodo + ' ' + STRING(le_anio) 

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
end event

type cb_1 from commandbutton within w_selecciona_periodo
integer x = 1051
integer y = 492
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;CLOSEWITHRETURN(PARENT,"")
end event

type uo_periodo from uo_periodo_variable_tipos within w_selecciona_periodo
integer x = 343
integer y = 152
integer width = 603
integer height = 296
integer taborder = 40
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type em_anio from editmask within w_selecciona_periodo
integer x = 1074
integer y = 168
integer width = 517
integer height = 132
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_1 from statictext within w_selecciona_periodo
integer x = 59
integer y = 52
integer width = 1943
integer height = 64
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Seleccione el periodo de dónde se mueven los saldos:"
boolean focusrectangle = false
end type

