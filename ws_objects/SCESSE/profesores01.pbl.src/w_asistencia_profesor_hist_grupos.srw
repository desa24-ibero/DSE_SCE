$PBExportHeader$w_asistencia_profesor_hist_grupos.srw
forward
global type w_asistencia_profesor_hist_grupos from window
end type
type cb_2 from commandbutton within w_asistencia_profesor_hist_grupos
end type
type cb_1 from commandbutton within w_asistencia_profesor_hist_grupos
end type
type st_periodo_anio from statictext within w_asistencia_profesor_hist_grupos
end type
type cb_actualiza_asistencia_grupos from commandbutton within w_asistencia_profesor_hist_grupos
end type
type dw_1 from datawindow within w_asistencia_profesor_hist_grupos
end type
type uo_1 from uo_per_ani within w_asistencia_profesor_hist_grupos
end type
end forward

global type w_asistencia_profesor_hist_grupos from window
integer x = 846
integer y = 372
integer width = 2880
integer height = 1312
boolean titlebar = true
string title = "Actualiza Asistencia de Profesores a Grupos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 79741120
cb_2 cb_2
cb_1 cb_1
st_periodo_anio st_periodo_anio
cb_actualiza_asistencia_grupos cb_actualiza_asistencia_grupos
dw_1 dw_1
uo_1 uo_1
end type
global w_asistencia_profesor_hist_grupos w_asistencia_profesor_hist_grupos

type variables
uo_control_asistencia_profesor iuo_control_asistencia
integer ii_periodo, ii_anio
uo_periodo_servicios iuo_periodo_servicios
end variables

forward prototypes
public subroutine wf_actualiza_periodo (integer ai_periodo, integer ai_anio)
end prototypes

public subroutine wf_actualiza_periodo (integer ai_periodo, integer ai_anio);//wf_actualiza_periodo
//Pone el periodo y anio correspondientes a la ventana
String ls_periodo

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

ii_periodo = ai_periodo
ii_anio= ai_anio

ls_periodo = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, ii_periodo)

IF luo_periodo_servicios.ierror = -1 THEN 
	MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
	RETURN
END IF	

st_periodo_anio.text = ls_periodo + " " + string(ii_anio)

//CHOOSE CASE ii_periodo
//	CASE 0
//		st_periodo_anio.text = "Primavera "+string(ii_anio)
//	CASE 1
//		st_periodo_anio.text = "Verano "+string(ii_anio)	
//	CASE 2
//		st_periodo_anio.text = "Otoño "+string(ii_anio)		
//END CHOOSE

end subroutine

on w_asistencia_profesor_hist_grupos.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.st_periodo_anio=create st_periodo_anio
this.cb_actualiza_asistencia_grupos=create cb_actualiza_asistencia_grupos
this.dw_1=create dw_1
this.uo_1=create uo_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.st_periodo_anio,&
this.cb_actualiza_asistencia_grupos,&
this.dw_1,&
this.uo_1}
end on

on w_asistencia_profesor_hist_grupos.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.st_periodo_anio)
destroy(this.cb_actualiza_asistencia_grupos)
destroy(this.dw_1)
destroy(this.uo_1)
end on

event open;iuo_control_asistencia = CREATE uo_control_asistencia_profesor
dw_1.SetTransObject(gtr_sce)

wf_actualiza_periodo(gi_periodo, gi_anio)



end event

event close;IF isvalid(iuo_control_asistencia) THEN
	DESTROY  iuo_control_asistencia
END IF
end event

type cb_2 from commandbutton within w_asistencia_profesor_hist_grupos
integer x = 928
integer y = 1028
integer width = 942
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Elimina Asistencia de Profesores"
end type

event clicked;int li_elimina
	
li_elimina = iuo_control_asistencia.of_elimina_asistencia_periodo(ii_periodo, ii_anio)
end event

type cb_1 from commandbutton within w_asistencia_profesor_hist_grupos
integer x = 1399
integer y = 72
integer width = 549
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Establece Período"
end type

event clicked;wf_actualiza_periodo(gi_periodo, gi_anio)
end event

type st_periodo_anio from statictext within w_asistencia_profesor_hist_grupos
integer x = 2057
integer y = 84
integer width = 681
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 79741120
boolean enabled = false
boolean focusrectangle = false
end type

type cb_actualiza_asistencia_grupos from commandbutton within w_asistencia_profesor_hist_grupos
integer x = 955
integer y = 872
integer width = 887
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualiza Asistencia en Grupos"
end type

event clicked;string ls_gpo, ls_cve_mat, ls_periodo
long ll_cve_mat
int li_asistencia, io_clases_totales, io_asistencias, io_faltas, li_confirma, li_actualiza
decimal do_porcentaje_asistencia

dw_1.Retrieve(ii_periodo, ii_anio)

//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
ls_periodo=uo_1.em_per.text
ii_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( ls_periodo, "L")

/*
CHOOSE CASE ii_periodo
	CASE 0
		ls_periodo= "Primavera"
	CASE 1
		ls_periodo= "Verano"
	CASE 2
		ls_periodo= "Otoño"
END CHOOSE	
*/

li_confirma = MessageBox("Confirmación", "¿Desea actualizar la asistencia para el periodo ["+&
        						ls_periodo+"-"+string(ii_anio)+"]?",Question!,YesNo!)
IF li_confirma <> 1 THEN
	RETURN
END IF

li_actualiza = iuo_control_asistencia.of_actual_asistencia_periodo(ii_periodo, ii_anio)

dw_1.Retrieve(ii_periodo, ii_anio)

end event

type dw_1 from datawindow within w_asistencia_profesor_hist_grupos
integer x = 69
integer y = 300
integer width = 2661
integer height = 512
integer taborder = 40
string dataobject = "d_grupos_asistencia_profesor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_per_ani within w_asistencia_profesor_hist_grupos
integer x = 69
integer y = 36
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

