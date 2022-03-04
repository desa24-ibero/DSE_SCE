$PBExportHeader$w_resumen_paquetes_prop.srw
forward
global type w_resumen_paquetes_prop from window
end type
type cb_1 from commandbutton within w_resumen_paquetes_prop
end type
type dw_resumen from datawindow within w_resumen_paquetes_prop
end type
type gb_1 from groupbox within w_resumen_paquetes_prop
end type
end forward

global type w_resumen_paquetes_prop from window
integer width = 2834
integer height = 1180
boolean titlebar = true
string title = "Propedéuticos requeridos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_resumen dw_resumen
gb_1 gb_1
end type
global w_resumen_paquetes_prop w_resumen_paquetes_prop

event open;INTEGER li_periodo
INTEGER le_anio
LONG ll_coordinacion
uo_parametros_paquetes luo_parametros_paquetes

luo_parametros_paquetes = CREATE uo_parametros_paquetes
luo_parametros_paquetes = MESSAGE.powerobjectparm 

li_periodo = luo_parametros_paquetes.ie_periodo  
le_anio = luo_parametros_paquetes.ie_anio  
ll_coordinacion = luo_parametros_paquetes.il_coordinacion  

dw_resumen.SETTRANSOBJECT(gtr_sce) 
dw_resumen.RETRIEVE(li_periodo, le_anio, ll_coordinacion) 


LONG ll_ttl_rgs
LONG ll_pos 
LONG ll_cve_prop 
LONG ll_pos_enc
LONG ll_solicitados, ll_creados
LONG ll_diferencia 
LONG ll_row_ins
LONG ll_cve_prerreq
STRING ls_materia

DATASTORE lds_requeridos
lds_requeridos = CREATE DATASTORE 
lds_requeridos.DATAOBJECT = "dw_demanda_propedeuticos" 
lds_requeridos.SETTRANSOBJECT(gtr_sce) 
ll_ttl_rgs = lds_requeridos.RETRIEVE(li_periodo, le_anio, ll_coordinacion) 

FOR ll_pos = 1 TO ll_ttl_rgs 
	
	ll_cve_prop = lds_requeridos.GETITEMNUMBER(ll_pos, "cve_prerreq")  
	ll_solicitados = lds_requeridos.GETITEMNUMBER(ll_pos, "requeridos")  
	ll_cve_prerreq = lds_requeridos.GETITEMNUMBER(ll_pos, "cve_prerreq")  		
	ls_materia = lds_requeridos.GETITEMSTRING(ll_pos, "materia")  		 
	
	ll_pos_enc = dw_resumen.FIND("paquetes_materias_clv_mat = " + STRING(ll_cve_prop), 0, dw_resumen.ROWCOUNT())  
	IF ll_pos_enc > 0 THEN 
		
		ll_creados = dw_resumen.GETITEMNUMBER(ll_pos_enc, "creados") 
		IF ISNULL(ll_creados) THEN ll_creados = 0 
		ll_diferencia = ll_solicitados - ll_creados 
		IF ll_diferencia < 0 THEN ll_diferencia = 0
		
		dw_resumen.SETITEM(ll_pos_enc, "solicitados", ll_solicitados) 
		dw_resumen.SETITEM(ll_pos_enc, "faltantes", ll_diferencia)
		
	ELSE
				
		ll_row_ins = dw_resumen.INSERTROW(0) 
		dw_resumen.SETITEM(ll_row_ins, "solicitados", ll_solicitados) 
		dw_resumen.SETITEM(ll_row_ins, "faltantes", ll_solicitados) 
		dw_resumen.SETITEM(ll_row_ins, "creados", 0)  
		dw_resumen.SETITEM(ll_row_ins, "paquetes_materias_clv_mat", ll_cve_prerreq)  
		dw_resumen.SETITEM(ll_row_ins, "materias_materia", ls_materia)  
		
	END IF
		
	
NEXT 














//--SELECT SUM(pa.cupo), pm.clv_mat, pa.num_paq, pm.num_paq, pe.cve_carrera, pe.cve_plan, pa.cupo
//--SELECT * 
//--SELECT pm.clv_mat, pa.num_paq, pm.num_paq, pe.cve_carrera, pe.cve_plan, pa.cupo
//SELECT 0 AS solicitados, 0 AS faltantes, SUM(pa.cupo), pm.clv_mat, m.materia
//FROM paquetes pa, 
//	paquetes_materias pm, 
//	prerrequisitos_esp pe, 
//	academicos a, 
//	v_prop_alumno_asignacion p, 
//	carreras c, 
//	v_prop_rel_materia rm, 
//	materias m    
//WHERE pa.periodo = 2 
//AND pa.anio = 2018 
//AND pa.num_paq = pm.num_paq 
//AND pm.clv_mat = pe.cve_prerreq 
//AND pe.cve_carrera = a.cve_carrera 
//AND pe.cve_plan = a.cve_plan 
//AND a.cuenta = p.cuenta 
//AND p.periodo = pa.periodo  
//AND p.anio = pa.anio 
//AND c.cve_carrera = a.cve_carrera 
//AND c.cve_coordinacion = 130
//AND rm.id_prop = p.id_prop 
//AND rm.cve_materia = pe.cve_prerreq
//AND m.cve_mat = rm.cve_materia
//GROUP BY  pm.clv_mat, m.materia
//
end event

on w_resumen_paquetes_prop.create
this.cb_1=create cb_1
this.dw_resumen=create dw_resumen
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.dw_resumen,&
this.gb_1}
end on

on w_resumen_paquetes_prop.destroy
destroy(this.cb_1)
destroy(this.dw_resumen)
destroy(this.gb_1)
end on

type cb_1 from commandbutton within w_resumen_paquetes_prop
integer x = 2185
integer y = 876
integer width = 517
integer height = 132
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Aceptar"
end type

event clicked;CLOSE(PARENT)
end event

type dw_resumen from datawindow within w_resumen_paquetes_prop
integer x = 151
integer y = 164
integer width = 2473
integer height = 580
integer taborder = 10
string title = "none"
string dataobject = "dw_paquetes_creados_resumen"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_resumen_paquetes_prop
integer x = 78
integer y = 64
integer width = 2615
integer height = 744
integer taborder = 10
integer textsize = -12
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
string text = "Propedéuticos requeridos: "
end type

