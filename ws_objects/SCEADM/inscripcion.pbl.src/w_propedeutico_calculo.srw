$PBExportHeader$w_propedeutico_calculo.srw
forward
global type w_propedeutico_calculo from window
end type
type cbx_omitir_manual from checkbox within w_propedeutico_calculo
end type
type cb_cargar from commandbutton within w_propedeutico_calculo
end type
type cb_1 from commandbutton within w_propedeutico_calculo
end type
type uo_per_ani from uo_per_ani_admision within w_propedeutico_calculo
end type
type cb_asignar from commandbutton within w_propedeutico_calculo
end type
type dw_propedéuticos from datawindow within w_propedeutico_calculo
end type
end forward

global type w_propedeutico_calculo from window
integer width = 5659
integer height = 2104
boolean titlebar = true
string title = "Asignación de cursos Propedéuticos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_omitir_manual cbx_omitir_manual
cb_cargar cb_cargar
cb_1 cb_1
uo_per_ani uo_per_ani
cb_asignar cb_asignar
dw_propedéuticos dw_propedéuticos
end type
global w_propedeutico_calculo w_propedeutico_calculo

type variables
INTEGER ie_periodo, ie_anio 

uo_paquetes_materias iuo_paquetes_materias


end variables

on w_propedeutico_calculo.create
this.cbx_omitir_manual=create cbx_omitir_manual
this.cb_cargar=create cb_cargar
this.cb_1=create cb_1
this.uo_per_ani=create uo_per_ani
this.cb_asignar=create cb_asignar
this.dw_propedéuticos=create dw_propedéuticos
this.Control[]={this.cbx_omitir_manual,&
this.cb_cargar,&
this.cb_1,&
this.uo_per_ani,&
this.cb_asignar,&
this.dw_propedéuticos}
end on

on w_propedeutico_calculo.destroy
destroy(this.cbx_omitir_manual)
destroy(this.cb_cargar)
destroy(this.cb_1)
destroy(this.uo_per_ani)
destroy(this.cb_asignar)
destroy(this.dw_propedéuticos)
end on

event open;
iuo_paquetes_materias = CREATE uo_paquetes_materias 



end event

event close;IF ISVALID(gtr_sfeb) THEN 
	DISCONNECT USING gtr_sfeb; 
END IF
end event

type cbx_omitir_manual from checkbox within w_propedeutico_calculo
integer x = 3941
integer y = 120
integer width = 933
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Omitir asignación manual"
boolean checked = true
end type

type cb_cargar from commandbutton within w_propedeutico_calculo
integer x = 1938
integer y = 104
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;INTEGER le_periodo, le_anio 
STRING ls_omitir_manual

le_periodo = parent.uo_per_ani.ie_periodo
le_anio = parent.uo_per_ani.ie_anio



dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
dw_propedéuticos.RETRIEVE(le_periodo,  le_anio, 'T')

end event

type cb_1 from commandbutton within w_propedeutico_calculo
integer x = 4978
integer y = 104
integer width = 402
integer height = 112
integer taborder = 20
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

type uo_per_ani from uo_per_ani_admision within w_propedeutico_calculo
event destroy ( )
integer x = 183
integer y = 80
integer taborder = 20
boolean enabled = true
long backcolor = 67108864
end type

on uo_per_ani.destroy
call uo_per_ani_admision::destroy
end on

event ue_modifica;call super::ue_modifica;
PARENT.ie_periodo = THIS.ie_periodo
PARENT.ie_anio = THIS.ie_anio
end event

type cb_asignar from commandbutton within w_propedeutico_calculo
integer x = 1504
integer y = 104
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asignar"
end type

event clicked;INTEGER le_periodo, le_anio 
STRING ls_omitir_manual

le_periodo = parent.uo_per_ani.ie_periodo
le_anio = parent.uo_per_ani.ie_anio

if (conecta_bd_n_tr(gtr_sfeb,gs_sfeb,gs_usuario,gs_password) <> 1) then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de becas.", StopSign!)
	return
end if

// Se verifica si se omiten las asignaciones manuales 
IF cbx_omitir_manual.CHECKED THEN 
	ls_omitir_manual = 'M'
ELSE
	ls_omitir_manual = 'T'
END IF 

// Se carga la información pata todas las carreras. 
iuo_paquetes_materias.f_carga_aspirantes( le_periodo,  le_anio, 9999,ls_omitir_manual) 

// Se llama la ejecución de la asignación de propedéuticos. 
iuo_paquetes_materias.f_asigna_propedeuticos( 9999)


dw_propedéuticos.SETTRANSOBJECT(gtr_sadm) 
dw_propedéuticos.RETRIEVE(le_periodo,  le_anio, 'T')

end event

type dw_propedéuticos from datawindow within w_propedeutico_calculo
integer x = 69
integer y = 324
integer width = 5490
integer height = 1608
integer taborder = 10
string title = "Estimación de Propedéuticos"
string dataobject = "dw_prop_resultado_asignacion"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

