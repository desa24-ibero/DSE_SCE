$PBExportHeader$w_paquetes_horario_gpo_aux.srw
forward
global type w_paquetes_horario_gpo_aux from window
end type
type cb_1 from commandbutton within w_paquetes_horario_gpo_aux
end type
type dw_horario from datawindow within w_paquetes_horario_gpo_aux
end type
end forward

global type w_paquetes_horario_gpo_aux from window
integer width = 2048
integer height = 1040
boolean titlebar = true
string title = "Horario"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_horario dw_horario
end type
global w_paquetes_horario_gpo_aux w_paquetes_horario_gpo_aux

on w_paquetes_horario_gpo_aux.create
this.cb_1=create cb_1
this.dw_horario=create dw_horario
this.Control[]={this.cb_1,&
this.dw_horario}
end on

on w_paquetes_horario_gpo_aux.destroy
destroy(this.cb_1)
destroy(this.dw_horario)
end on

event open;
uo_parametros_paquetes luo_parametros_paquetes

luo_parametros_paquetes = CREATE uo_parametros_paquetes
luo_parametros_paquetes = MESSAGE.powerobjectparm 

INTEGER le_periodo, le_anio
LONG ll_materia
STRING ls_grupo

le_periodo = luo_parametros_paquetes.ie_periodo 
le_anio = luo_parametros_paquetes.ie_anio 
ll_materia = luo_parametros_paquetes.il_cve_mat
ls_grupo = luo_parametros_paquetes.is_gpo 


dw_horario.SETTRANSOBJECT(gtr_sce) 
dw_horario.RETRIEVE(le_periodo, le_anio, ll_materia, ls_grupo) 


STRING ls_profesor 
STRING ls_tipo_grupo 
STRING ls_materia 
INTEGER le_pos 

SELECT CONVERT(VARCHAR, prof.cve_profesor) + '-' + prof.nombre + ' ' + prof.apaterno + ' ' + prof.amaterno, tipo_grupo.nombre_tipo, 
			CONVERT(varchar, grupos.cve_mat) + ' - ' + materias.materia + ' Gpo. ' + grupos.gpo as materia 
INTO :ls_profesor, :ls_tipo_grupo, :ls_materia  
FROM profesor prof, grupos, tipo_grupo, materias    
WHERE prof.cve_profesor = grupos.cve_profesor 
AND grupos.cve_mat = :ll_materia
AND grupos.gpo = :ls_grupo
AND grupos.periodo = :le_periodo
AND grupos.anio = :le_anio 
AND tipo_grupo.tipo = grupos.tipo 
AND materias.cve_mat = grupos.cve_mat 
USING gtr_sce; 

IF dw_horario.ROWCOUNT() > 0 THEN 
	FOR le_pos = 1 TO dw_horario.ROWCOUNT() 
		dw_horario.SETITEM(le_pos, "tipo_grupod", 'Tipo grupo: ' + ls_tipo_grupo)	
		dw_horario.SETITEM(le_pos, "profesor", ls_profesor)	
	NEXT 
ELSE
	le_pos = dw_horario.INSERTROW(0)
	dw_horario.SETITEM(le_pos, "tipo_grupod", 'Tipo grupo: ' + ls_tipo_grupo)	
	dw_horario.SETITEM(le_pos, "profesor", ls_profesor)		
	dw_horario.SETITEM(le_pos, "corario_hora_final", ls_materia)	
END IF













end event

type cb_1 from commandbutton within w_paquetes_horario_gpo_aux
integer x = 1554
integer y = 804
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cerrar"
end type

event clicked;CLOSE(PARENT)
end event

type dw_horario from datawindow within w_paquetes_horario_gpo_aux
integer x = 50
integer y = 40
integer width = 1906
integer height = 740
integer taborder = 10
string title = "none"
string dataobject = "dw_grupos_horario_aux"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

