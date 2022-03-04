$PBExportHeader$w_confirmacion_asig_salones.srw
forward
global type w_confirmacion_asig_salones from window
end type
type st_especial from statictext within w_confirmacion_asig_salones
end type
type st_1 from statictext within w_confirmacion_asig_salones
end type
type st_periodos from statictext within w_confirmacion_asig_salones
end type
type st_mensaje from statictext within w_confirmacion_asig_salones
end type
type cb_2 from commandbutton within w_confirmacion_asig_salones
end type
type cb_1 from commandbutton within w_confirmacion_asig_salones
end type
end forward

global type w_confirmacion_asig_salones from window
integer width = 2194
integer height = 1092
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_especial st_especial
st_1 st_1
st_periodos st_periodos
st_mensaje st_mensaje
cb_2 cb_2
cb_1 cb_1
end type
global w_confirmacion_asig_salones w_confirmacion_asig_salones

on w_confirmacion_asig_salones.create
this.st_especial=create st_especial
this.st_1=create st_1
this.st_periodos=create st_periodos
this.st_mensaje=create st_mensaje
this.cb_2=create cb_2
this.cb_1=create cb_1
this.Control[]={this.st_especial,&
this.st_1,&
this.st_periodos,&
this.st_mensaje,&
this.cb_2,&
this.cb_1}
end on

on w_confirmacion_asig_salones.destroy
destroy(this.st_especial)
destroy(this.st_1)
destroy(this.st_periodos)
destroy(this.st_mensaje)
destroy(this.cb_2)
destroy(this.cb_1)
end on

event open;
STRING ls_especial 

ls_especial = MESSAGE.STRINGPARM 

IF ls_especial <> "S" THEN 
	st_especial.VISIBLE = FALSE
END IF 	


uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos_activos(gtr_sce) 



INTEGER le_periodo
INTEGER le_anio 
STRING ls_periodo 
INTEGER le_ttl_rgs
INTEGER le_pos
STRING ls_periodos
STRING ls_coma

le_ttl_rgs = luo_periodo_servicios.ids_periodos_activos.ROWCOUNT() 
FOR le_pos = 1 TO le_ttl_rgs 
	le_anio = luo_periodo_servicios.ids_periodos_activos.GETITEMNUMBER(le_pos, "anio")
	ls_periodo = luo_periodo_servicios.ids_periodos_activos.GETITEMSTRING(le_pos, "descripcion")
	ls_periodos = ls_periodos + ls_coma + 	ls_periodo + " - " + STRING(le_anio) 
	ls_coma = " ,   "
NEXT 

st_periodos.TEXT = ls_periodos 


end event

type st_especial from statictext within w_confirmacion_asig_salones
integer x = 37
integer y = 740
integer width = 1243
integer height = 92
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Se realizará Asignación ESPECIAL."
boolean focusrectangle = false
end type

type st_1 from statictext within w_confirmacion_asig_salones
integer x = 37
integer y = 528
integer width = 2030
integer height = 148
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Si los periodos no son los correctos debe ajustarlos en Periodos por Proceso (Periodo Activo)"
boolean focusrectangle = false
end type

type st_periodos from statictext within w_confirmacion_asig_salones
integer x = 64
integer y = 384
integer width = 2053
integer height = 116
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type st_mensaje from statictext within w_confirmacion_asig_salones
integer x = 82
integer y = 44
integer width = 2030
integer height = 288
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "La asignación se realizará con base en los salones disponibles en los horarios solicitados. Para esto se consideran los horarios asignados en los periodos mostrados:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_confirmacion_asig_salones
integer x = 1211
integer y = 864
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
boolean cancel = true
end type

event clicked;CLOSEWITHRETURN(PARENT, 1)
end event

type cb_1 from commandbutton within w_confirmacion_asig_salones
integer x = 1687
integer y = 864
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Continuar"
end type

event clicked;CLOSEWITHRETURN(PARENT, 0)
end event

