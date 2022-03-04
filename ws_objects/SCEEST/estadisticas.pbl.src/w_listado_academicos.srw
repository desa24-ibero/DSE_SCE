$PBExportHeader$w_listado_academicos.srw
forward
global type w_listado_academicos from w_ancestral
end type
type uo_1 from uo_per_ani within w_listado_academicos
end type
type dw_listados_academicos from uo_dw_reporte within w_listado_academicos
end type
type ddlb_busca from dropdownlistbox within w_listado_academicos
end type
type uo_carr from uo_carrera within w_listado_academicos
end type
end forward

global type w_listado_academicos from w_ancestral
integer height = 2320
string title = "Listado de datos Académicos"
string menuname = "m_menu"
uo_1 uo_1
dw_listados_academicos dw_listados_academicos
ddlb_busca ddlb_busca
uo_carr uo_carr
end type
global w_listado_academicos w_listado_academicos

on w_listado_academicos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_listados_academicos=create dw_listados_academicos
this.ddlb_busca=create ddlb_busca
this.uo_carr=create uo_carr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_listados_academicos
this.Control[iCurrent+3]=this.ddlb_busca
this.Control[iCurrent+4]=this.uo_carr
end on

on w_listado_academicos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_listados_academicos)
destroy(this.ddlb_busca)
destroy(this.uo_carr)
end on

event open;call super::open;dw_listados_academicos.settransobject(gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_listado_academicos
end type

type uo_1 from uo_per_ani within w_listado_academicos
integer x = 2290
integer y = 124
integer width = 1253
integer height = 168
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_listados_academicos from uo_dw_reporte within w_listado_academicos
integer x = 0
integer y = 428
integer width = 3506
integer height = 1708
integer taborder = 20
boolean titlebar = true
string dataobject = "d_listados_academicos"
boolean minbox = true
boolean maxbox = true
boolean border = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event type integer carga();integer li_periodo,li_anio, li_res
long ll_cve_carrera

CHOOSE CASE ddlb_busca.text
	CASE "Primer Ingreso en..."
		Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,carreras.carrera,academicos.cve_plan,subsistema.subsistema,academicos.nivel,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.egresado,academicos.periodo_ing,academicos.anio_ing,academicos.periodo_egre,academicos.anio_egre,academicos.cve_formaingreso,academicos.cve_carrera,academicos.cve_subsistema,alumnos.apaterno,alumnos.amaterno,alumnos.nombre FROM academicos,carreras,subsistema,alumnos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera *= carreras.cve_carrera) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_subsistema *= subsistema.cve_subsistema) and ( academicos.periodo_ing = :peri ) AND ( academicos.anio_ing = :anio ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr)'")
	CASE "Egresados en..."
		Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,carreras.carrera,academicos.cve_plan,subsistema.subsistema,academicos.nivel,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.egresado,academicos.periodo_ing,academicos.anio_ing,academicos.periodo_egre,academicos.anio_egre,academicos.cve_formaingreso,academicos.cve_carrera,academicos.cve_subsistema,alumnos.apaterno,alumnos.amaterno,alumnos.nombre FROM academicos,carreras,subsistema,alumnos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera *= carreras.cve_carrera) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_subsistema *= subsistema.cve_subsistema) and ( academicos.periodo_egre = :peri ) AND ( academicos.anio_egre = :anio ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr) AND ( academicos.egresado = 1 )'")
	CASE "Inscritos en..."
		periodo_actual(li_periodo,li_anio,gtr_sce)
		if li_periodo=gi_periodo and li_anio=gi_anio then
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,carreras.carrera,academicos.cve_plan,subsistema.subsistema,academicos.nivel,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.egresado,academicos.periodo_ing,academicos.anio_ing,academicos.periodo_egre,academicos.anio_egre,academicos.cve_formaingreso,academicos.cve_carrera,academicos.cve_subsistema,alumnos.apaterno,alumnos.amaterno,alumnos.nombre FROM academicos,carreras,subsistema,alumnos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera *= carreras.cve_carrera ) and ( academicos.cve_carrera *= subsistema.cve_carrera ) and ( academicos.cve_plan *= subsistema.cve_plan ) and ( academicos.cve_subsistema *= subsistema.cve_subsistema ) and ( :carr = 9999 OR academicos.cve_carrera = :carr) and ( academicos.cuenta in (SELECT DISTINCT mat_inscritas.cuenta FROM mat_inscritas WHERE mat_inscritas.periodo = :peri AND mat_inscritas.anio = :anio ) )'")
		else
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,carreras.carrera,academicos.cve_plan,subsistema.subsistema,academicos.nivel,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.egresado,academicos.periodo_ing,academicos.anio_ing,academicos.periodo_egre,academicos.anio_egre,academicos.cve_formaingreso,academicos.cve_carrera,academicos.cve_subsistema,alumnos.apaterno,alumnos.amaterno,alumnos.nombre FROM academicos,carreras,subsistema,alumnos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera *= carreras.cve_carrera ) and ( academicos.cve_carrera *= subsistema.cve_carrera ) and ( academicos.cve_plan *= subsistema.cve_plan ) and ( academicos.cve_subsistema *= subsistema.cve_subsistema ) and ( :carr = 9999 OR academicos.cve_carrera = :carr) and ( academicos.cuenta in (SELECT DISTINCT historico.cuenta FROM historico WHERE historico.periodo = :peri AND historico.anio = :anio ) )'")
		end if
	CASE "TODOS..."
		Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,carreras.carrera,academicos.cve_plan,subsistema.subsistema,academicos.nivel,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.egresado,academicos.periodo_ing,academicos.anio_ing,academicos.periodo_egre,academicos.anio_egre,academicos.cve_formaingreso,academicos.cve_carrera,academicos.cve_subsistema,alumnos.apaterno,alumnos.amaterno,alumnos.nombre FROM academicos,carreras,subsistema,alumnos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera *= carreras.cve_carrera) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_subsistema *= subsistema.cve_subsistema) AND ( :carr = 9999 OR academicos.cve_carrera = :carr)'")
END CHOOSE

event primero()
ll_cve_carrera =uo_carr.dw_carrera.object.cve_carrera[uo_carr.dw_carrera.getrow()]

li_res=  retrieve(gi_periodo,gi_anio,ll_cve_carrera)
return li_res

end event

event dberror;call super::dberror;return 0
end event

type ddlb_busca from dropdownlistbox within w_listado_academicos
integer x = 1737
integer y = 160
integer width = 544
integer height = 232
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Inscritos en..."
boolean vscrollbar = true
string item[] = {"Inscritos en...","Primer Ingreso en...","Egresados en...","TODOS..."}
end type

type uo_carr from uo_carrera within w_listado_academicos
integer x = 384
integer y = 108
integer width = 1344
integer height = 204
integer taborder = 1
boolean enabled = true
long backcolor = 1090519039
end type

on uo_carr.destroy
call uo_carrera::destroy
end on

