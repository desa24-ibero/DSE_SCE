$PBExportHeader$w_depura_hist_carreras.srw
forward
global type w_depura_hist_carreras from window
end type
type st_2 from statictext within w_depura_hist_carreras
end type
type st_1 from statictext within w_depura_hist_carreras
end type
type st_carrera from statictext within w_depura_hist_carreras
end type
type st_alumno from statictext within w_depura_hist_carreras
end type
type cb_2 from commandbutton within w_depura_hist_carreras
end type
type cb_1 from commandbutton within w_depura_hist_carreras
end type
type dw_hist from datawindow within w_depura_hist_carreras
end type
type gb_1 from groupbox within w_depura_hist_carreras
end type
end forward

global type w_depura_hist_carreras from window
integer width = 4965
integer height = 1908
boolean titlebar = true
string title = "Depuración Histórico Carreras"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_2 st_2
st_1 st_1
st_carrera st_carrera
st_alumno st_alumno
cb_2 cb_2
cb_1 cb_1
dw_hist dw_hist
gb_1 gb_1
end type
global w_depura_hist_carreras w_depura_hist_carreras

type variables
LONG il_cuenta


end variables

on w_depura_hist_carreras.create
this.st_2=create st_2
this.st_1=create st_1
this.st_carrera=create st_carrera
this.st_alumno=create st_alumno
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_hist=create dw_hist
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.st_1,&
this.st_carrera,&
this.st_alumno,&
this.cb_2,&
this.cb_1,&
this.dw_hist,&
this.gb_1}
end on

on w_depura_hist_carreras.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_carrera)
destroy(this.st_alumno)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_hist)
destroy(this.gb_1)
end on

event open;LONG ll_cuenta 


ll_cuenta = MESSAGE.DOUBLEPARM

dw_hist.SETTRANSOBJECT(gtr_sce)  
dw_hist.RETRIEVE(ll_cuenta)  

STRING ls_nombre, ls_apaterno, ls_amaterno

SELECT nombre, apaterno, amaterno
INTO :ls_nombre, :ls_apaterno, :ls_amaterno 
FROM alumnos 
WHERE cuenta = :ll_cuenta 
USING gtr_sce; 
st_alumno.TEXT = STRING(ll_cuenta) + " - " + ls_nombre + " " + ls_apaterno + " " + ls_amaterno 


LONG ll_cve_carrera 
INTEGER le_plan 
STRING ls_carrera

SELECT academicos.cve_carrera, academicos.cve_plan, carreras.carrera 
INTO :ll_cve_carrera, :le_plan, :ls_carrera 
FROM academicos, carreras
WHERE academicos.cuenta = :ll_cuenta 
AND academicos.cve_carrera = carreras.cve_carrera 
USING gtr_sce; 

st_carrera.TEXT = STRING(ll_cve_carrera) + "-" + STRING(le_plan) + "   " + ls_carrera 

il_cuenta = ll_cuenta




end event

type st_2 from statictext within w_depura_hist_carreras
integer x = 101
integer y = 76
integer width = 279
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Alumno: "
boolean focusrectangle = false
end type

type st_1 from statictext within w_depura_hist_carreras
integer x = 105
integer y = 172
integer width = 617
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Carrera-Plan Activo: "
boolean focusrectangle = false
end type

type st_carrera from statictext within w_depura_hist_carreras
integer x = 731
integer y = 172
integer width = 3346
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Carrera Activa: "
boolean focusrectangle = false
end type

type st_alumno from statictext within w_depura_hist_carreras
integer x = 389
integer y = 76
integer width = 3977
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Alumno: "
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_depura_hist_carreras
integer x = 4046
integer y = 1600
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;CLOSE(PARENT) 



end event

type cb_1 from commandbutton within w_depura_hist_carreras
integer x = 3387
integer y = 1600
integer width = 603
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Eliminar Selección"
end type

event clicked;IF MESSAGEBOX("Confirmación", "El registro seleccionado será eliminado. ¿Desea continuar?", QUESTION!, YesNoCancel!) > 1 THEN RETURN 


dw_hist.DELETEROW(dw_hist.GETSELECTEDROW(0)) 
IF dw_hist.UPDATE() < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al actualizar el histórico de carreras.") 
END IF 

MESSAGEBOX("Aviso", "El registro fue eliminado") 
dw_hist.RETRIEVE(il_cuenta) 


end event

type dw_hist from datawindow within w_depura_hist_carreras
integer x = 101
integer y = 432
integer width = 4695
integer height = 1060
integer taborder = 10
string title = "Cambios de Carrera"
string dataobject = "dw_hist_carreras_depurar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event rowfocuschanged;THIS.SELECTROW(0, FALSE) 
THIS.SELECTROW(currentrow, TRUE) 



end event

event error;MESSAGEBOX("Error", "Se produjo un error al actualizar el histórico de carreras." + errortext) 
end event

event clicked;this.setrow(row)

end event

type gb_1 from groupbox within w_depura_hist_carreras
integer x = 50
integer y = 344
integer width = 4809
integer height = 1192
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Histórico Carreras: "
end type

