$PBExportHeader$w_reporte_profesores_cot_evaluar.srw
forward
global type w_reporte_profesores_cot_evaluar from window
end type
type cbx_titular from checkbox within w_reporte_profesores_cot_evaluar
end type
type cb_3 from commandbutton within w_reporte_profesores_cot_evaluar
end type
type cb_2 from commandbutton within w_reporte_profesores_cot_evaluar
end type
type cb_1 from commandbutton within w_reporte_profesores_cot_evaluar
end type
type uo_periodo from uo_per_ani within w_reporte_profesores_cot_evaluar
end type
type st_1 from statictext within w_reporte_profesores_cot_evaluar
end type
type dw_profesores from datawindow within w_reporte_profesores_cot_evaluar
end type
end forward

global type w_reporte_profesores_cot_evaluar from window
integer width = 5888
integer height = 2560
boolean titlebar = true
string title = "Reporte de Profesores Cotitulares"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cbx_titular cbx_titular
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
uo_periodo uo_periodo
st_1 st_1
dw_profesores dw_profesores
end type
global w_reporte_profesores_cot_evaluar w_reporte_profesores_cot_evaluar

type variables

INTEGER ii_periodo 
INTEGER ii_anio 

end variables

on w_reporte_profesores_cot_evaluar.create
this.cbx_titular=create cbx_titular
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.uo_periodo=create uo_periodo
this.st_1=create st_1
this.dw_profesores=create dw_profesores
this.Control[]={this.cbx_titular,&
this.cb_3,&
this.cb_2,&
this.cb_1,&
this.uo_periodo,&
this.st_1,&
this.dw_profesores}
end on

on w_reporte_profesores_cot_evaluar.destroy
destroy(this.cbx_titular)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.uo_periodo)
destroy(this.st_1)
destroy(this.dw_profesores)
end on

event open;THIS.uo_periodo.ie_anio = gi_anio 
THIS.uo_periodo.ie_periodo = gi_periodo   
THIS.uo_periodo.TRIGGEREVENT("ue_modifica") 
end event

type cbx_titular from checkbox within w_reporte_profesores_cot_evaluar
integer x = 1787
integer y = 84
integer width = 471
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Incluir Titular"
end type

type cb_3 from commandbutton within w_reporte_profesores_cot_evaluar
integer x = 3781
integer y = 56
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 
end event

type cb_2 from commandbutton within w_reporte_profesores_cot_evaluar
integer x = 2880
integer y = 56
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;INTEGER li_rows 
INTEGER li_result1 

li_rows = dw_profesores.ROWCOUNT() 

If li_rows > 0 Then
	li_result1 = dw_profesores.saveas( "", Excel!, True)
	If li_result1 = 1 Then MessageBox("Mensaje del Sistema", "Archivo generado de manera satisfactoria")
Else
	MessageBox('Mensaje del Sistema', 'No existe información para generar el archivo solicitado')	
End If
end event

type cb_1 from commandbutton within w_reporte_profesores_cot_evaluar
integer x = 2464
integer y = 56
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Recuperar"
end type

event clicked;dw_profesores.TRIGGEREVENT("carga")
end event

type uo_periodo from uo_per_ani within w_reporte_profesores_cot_evaluar
integer x = 448
integer y = 28
integer width = 1253
integer height = 168
integer taborder = 20
boolean enabled = true
boolean border = true
long backcolor = 1090519039
end type

event ue_modifica;call super::ue_modifica;
PARENT.ii_periodo = THIS.ie_periodo
PARENT.ii_anio = THIS.ie_anio 




end event

on uo_periodo.destroy
call uo_per_ani::destroy
end on

type st_1 from statictext within w_reporte_profesores_cot_evaluar
integer x = 96
integer y = 52
integer width = 315
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo: "
boolean focusrectangle = false
end type

type dw_profesores from datawindow within w_reporte_profesores_cot_evaluar
event carga ( )
integer x = 105
integer y = 260
integer width = 5490
integer height = 2092
integer taborder = 10
string title = "none"
string dataobject = "dw_reporte_prof_cot_evaluar"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event carga();STRING ls_query 

ls_query = " SELECT  g.cve_mat, g.gpo, m.materia, pc.fecha_inicio, pc.fecha_fin,  " + &
						 " pc.horas_totales_grupo as ~~'Horas Totales~~',   " + & 
                            " pa.cve_profesor,  ~~' ~~' + pa.nombre + ~~' ~~' +  pa.apaterno + ~~' ~~' + pa.amaterno AS ~~'Titular~~',    " + &
                            " pb.cve_profesor,  ~~' ~~' + pb.nombre + ~~' ~~' +  pb.apaterno + ~~' ~~' + pb.amaterno AS ~~'Profesor~~' , pc.evalua   " + &
			" FROM grupos g, materias m, profesor pa, profesor pb, profesor_cotitular pc  " + &
			" WHERE g.periodo = " + STRING(ii_periodo)  + &  
			" AND g.anio = " + STRING(ii_anio) + & 
			" AND g.cve_mat = m.cve_mat   " + &
			" AND pc.cve_mat = g.cve_mat   " + &
			" AND pc.gpo = g.gpo   " + &
			" AND pc.periodo = g.periodo   " + &
			" AND pc.anio = g.anio   " + &
			" AND g.cve_profesor = pa.cve_profesor   " + &
			" AND pb.cve_profesor = pc.cve_profesor   " 
			
			IF NOT cbx_titular.CHECKED THEN 
				ls_query = ls_query + " AND pa.cve_profesor <> pc.cve_profesor  " 
			END IF 	

THIS.MODIFY("Datawindow.Table.Select = '" + ls_query + "'")
THIS.SETTRANSOBJECT(gtr_sce) 
IF THIS.RETRIEVE() <= 0 THEN MESSAGEBOX("Aviso", "No se encontro información para el periodo solicitado.") 



    










end event

