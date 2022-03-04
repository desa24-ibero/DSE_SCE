$PBExportHeader$w_listado_preparatorias.srw
forward
global type w_listado_preparatorias from w_ancestral
end type
type uo_1 from uo_per_ani within w_listado_preparatorias
end type
type dw_listados_preparatorias from uo_dw_reporte within w_listado_preparatorias
end type
type ddlb_busca from dropdownlistbox within w_listado_preparatorias
end type
type uo_carr from uo_carrera within w_listado_preparatorias
end type
end forward

global type w_listado_preparatorias from w_ancestral
boolean TitleBar=true
string Title="Listado de datos Preparatorias"
string MenuName="m_menu"
uo_1 uo_1
dw_listados_preparatorias dw_listados_preparatorias
ddlb_busca ddlb_busca
uo_carr uo_carr
end type
global w_listado_preparatorias w_listado_preparatorias

on w_listado_preparatorias.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_listados_preparatorias=create dw_listados_preparatorias
this.ddlb_busca=create ddlb_busca
this.uo_carr=create uo_carr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_listados_preparatorias
this.Control[iCurrent+3]=this.ddlb_busca
this.Control[iCurrent+4]=this.uo_carr
end on

on w_listado_preparatorias.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_listados_preparatorias)
destroy(this.ddlb_busca)
destroy(this.uo_carr)
end on

event open;call super::open;dw_listados_preparatorias.settransobject(gtr_sce)
end event

type uo_1 from uo_per_ani within w_listado_preparatorias
int X=2289
int Y=125
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_listados_preparatorias from uo_dw_reporte within w_listado_preparatorias
int X=0
int Y=429
int Width=3507
int Height=1706
int TabOrder=20
string DataObject="d_listados_preparatorias"
boolean TitleBar=true
string Title=""
boolean Border=true
BorderStyle BorderStyle=StyleBox!
boolean MinBox=true
boolean MaxBox=true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;integer li_periodo,li_anio

CHOOSE CASE ddlb_busca.text
	CASE "Primer Ingreso en..."
		Modify("DataWindow.Table.Select = 'SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,carreras.cve_carrera,carreras.carrera,subsistema.cve_plan,subsistema.cve_subsistema,subsistema.subsistema,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.periodo_ing,academicos.anio_ing,alumnos.sexo,alumnos.promedio_bach,escuelas.cve_escuela,escuelas.escuela,estados.cve_estado,estados.estado,municipio_localidad.municipio,municipio_localidad.localidad,academicos.nivel,academicos.cve_formaingreso FROM academicos,alumnos,escuelas,estudio_ant,carreras,subsistema,estados,municipio_localidad WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera = carreras.cve_carrera ) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_subsistema *= subsistema.cve_subsistema ) and ( alumnos.cuenta = estudio_ant.cuenta ) and ( estudio_ant.cve_escuela = escuelas.cve_escuela ) and ( escuelas.cve_sep *= estados.cve_sep ) and ( escuelas.cve_mun_loc *= municipio_localidad.cve_mun_loc ) and ( academicos.periodo_ing = :peri ) AND ( academicos.anio_ing = :anio ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr )'")
	CASE "Egresados en..."
		Modify("DataWindow.Table.Select = 'SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,carreras.cve_carrera,carreras.carrera,subsistema.cve_plan,subsistema.cve_subsistema,subsistema.subsistema,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.periodo_ing,academicos.anio_ing,alumnos.sexo,alumnos.promedio_bach,escuelas.cve_escuela,escuelas.escuela,estados.cve_estado,estados.estado,municipio_localidad.municipio,municipio_localidad.localidad,academicos.nivel,academicos.cve_formaingreso FROM academicos,alumnos,escuelas,estudio_ant,carreras,subsistema,estados,municipio_localidad WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera = carreras.cve_carrera ) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_subsistema *= subsistema.cve_subsistema ) and ( alumnos.cuenta = estudio_ant.cuenta ) and ( estudio_ant.cve_escuela = escuelas.cve_escuela ) and ( escuelas.cve_sep *= estados.cve_sep ) and ( escuelas.cve_mun_loc *= municipio_localidad.cve_mun_loc ) and ( academicos.periodo_egre = :peri ) AND ( academicos.anio_egre = :anio ) AND ( academicos.egresado = 1 ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr )'")
	CASE "Inscritos en..."
		periodo_actual(li_periodo,li_anio,gtr_sce)
		if li_periodo=gi_periodo and li_anio=gi_anio then
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,carreras.cve_carrera,carreras.carrera,subsistema.cve_plan,subsistema.cve_subsistema,subsistema.subsistema,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.periodo_ing,academicos.anio_ing,alumnos.sexo,alumnos.promedio_bach,escuelas.cve_escuela,escuelas.escuela,estados.cve_estado,estados.estado,municipio_localidad.municipio,municipio_localidad.localidad,academicos.nivel,academicos.cve_formaingreso FROM academicos,alumnos,escuelas,estudio_ant,carreras,subsistema,estados,municipio_localidad WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera = carreras.cve_carrera ) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_subsistema *= subsistema.cve_subsistema ) and ( alumnos.cuenta = estudio_ant.cuenta ) and ( estudio_ant.cve_escuela = escuelas.cve_escuela ) and ( escuelas.cve_sep *= estados.cve_sep ) and ( escuelas.cve_mun_loc *= municipio_localidad.cve_mun_loc ) and ( :carr = 9999 OR academicos.cve_carrera = :carr ) and ( academicos.cuenta in (SELECT DISTINCT mat_inscritas.cuenta FROM mat_inscritas WHERE mat_inscritas.periodo = :peri AND mat_inscritas.anio = :anio ))'")
		else
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,carreras.cve_carrera,carreras.carrera,subsistema.cve_plan,subsistema.cve_subsistema,subsistema.subsistema,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.periodo_ing,academicos.anio_ing,alumnos.sexo,alumnos.promedio_bach,escuelas.cve_escuela,escuelas.escuela,estados.cve_estado,estados.estado,municipio_localidad.municipio,municipio_localidad.localidad,academicos.nivel,academicos.cve_formaingreso FROM academicos,alumnos,escuelas,estudio_ant,carreras,subsistema,estados,municipio_localidad WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera = carreras.cve_carrera ) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_subsistema *= subsistema.cve_subsistema ) and ( alumnos.cuenta = estudio_ant.cuenta ) and ( estudio_ant.cve_escuela = escuelas.cve_escuela ) and ( escuelas.cve_sep *= estados.cve_sep ) and ( escuelas.cve_mun_loc *= municipio_localidad.cve_mun_loc ) and ( :carr = 9999 OR academicos.cve_carrera = :carr ) and ( academicos.cuenta in (SELECT DISTINCT historico.cuenta FROM historico WHERE historico.periodo = :peri AND historico.anio = :anio ))'")
		end if
	CASE "TODOS..."
		Modify("DataWindow.Table.Select = 'SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,carreras.cve_carrera,carreras.carrera,subsistema.cve_plan,subsistema.cve_subsistema,subsistema.subsistema,academicos.promedio,academicos.sem_cursados,academicos.creditos_cursados,academicos.periodo_ing,academicos.anio_ing,alumnos.sexo,alumnos.promedio_bach,escuelas.cve_escuela,escuelas.escuela,estados.cve_estado,estados.estado,municipio_localidad.municipio,municipio_localidad.localidad,academicos.nivel,academicos.cve_formaingreso FROM academicos,alumnos,escuelas,estudio_ant,carreras,subsistema,estados,municipio_localidad WHERE ( alumnos.cuenta = academicos.cuenta ) and ( academicos.cve_carrera = carreras.cve_carrera ) and ( academicos.cve_plan *= subsistema.cve_plan) and ( academicos.cve_carrera *= subsistema.cve_carrera) and ( academicos.cve_subsistema *= subsistema.cve_subsistema ) and ( alumnos.cuenta = estudio_ant.cuenta ) and ( estudio_ant.cve_escuela = escuelas.cve_escuela ) and ( escuelas.cve_sep *= estados.cve_sep ) and ( escuelas.cve_mun_loc *= municipio_localidad.cve_mun_loc ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr )'")
END CHOOSE

event primero()
return retrieve(gi_periodo,gi_anio,uo_carr.dw_carrera.object.cve_carrera[uo_carr.dw_carrera.getrow()])
end event

type ddlb_busca from dropdownlistbox within w_listado_preparatorias
int X=1737
int Y=160
int Width=545
int Height=230
int TabOrder=10
boolean BringToTop=true
string Text="Inscritos en..."
boolean VScrollBar=true
long BackColor=16777215
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
string Item[]={"Inscritos en...",&
"Primer Ingreso en...",&
"Egresados en...",&
"TODOS..."}
end type

type uo_carr from uo_carrera within w_listado_preparatorias
int X=384
int Y=106
int TabOrder=1
boolean Enabled=true
boolean BringToTop=true
long BackColor=1090519039
end type

on uo_carr.destroy
call uo_carrera::destroy
end on

