$PBExportHeader$w_listado_alumnos.srw
forward
global type w_listado_alumnos from w_ancestral
end type
type uo_1 from uo_per_ani within w_listado_alumnos
end type
type dw_listados_alumnos from uo_dw_reporte within w_listado_alumnos
end type
type ddlb_busca from dropdownlistbox within w_listado_alumnos
end type
type uo_carr from uo_carrera within w_listado_alumnos
end type
end forward

global type w_listado_alumnos from w_ancestral
int Height=2333
boolean TitleBar=true
string Title="Listado de Alumnos"
string MenuName="m_menu"
uo_1 uo_1
dw_listados_alumnos dw_listados_alumnos
ddlb_busca ddlb_busca
uo_carr uo_carr
end type
global w_listado_alumnos w_listado_alumnos

on w_listado_alumnos.create
int iCurrent
call w_ancestral::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_listados_alumnos=create dw_listados_alumnos
this.ddlb_busca=create ddlb_busca
this.uo_carr=create uo_carr
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=uo_1
this.Control[iCurrent+2]=dw_listados_alumnos
this.Control[iCurrent+3]=ddlb_busca
this.Control[iCurrent+4]=uo_carr
end on

on w_listado_alumnos.destroy
call w_ancestral::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_listados_alumnos)
destroy(this.ddlb_busca)
destroy(this.uo_carr)
end on

event open;call super::open;dw_listados_alumnos.settransobject(gtr_sce)
end event

type uo_1 from uo_per_ani within w_listado_alumnos
int X=2291
int Y=125
boolean Enabled=true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_listados_alumnos from uo_dw_reporte within w_listado_alumnos
int X=1
int Y=429
int Width=3507
int Height=1705
int TabOrder=20
string DataObject="d_listados_alumnos"
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
		Modify("DataWindow.Table.Select = '   SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,alumnos.sexo,alumnos.cve_trabajo,trabajo.trabajo,alumnos.horas_trabajo,alumnos.fecha_nac,alumnos.lugar_nac,estados.estado,alumnos.cve_transp,transporte.transporte,alumnos.cve_nacion,nacionalidad.nacionalidad,alumnos.cve_religion,religion.religion,alumnos.cve_edocivil,edo_civil.edo_civil,alumnos.promedio_bach,academicos.cve_carrera,academicos.cve_plan,academicos.cve_subsistema FROM alumnos,trabajo,transporte,estados,nacionalidad,religion,edo_civil,academicos WHERE ( trabajo.cve_trabajo =* alumnos.cve_trabajo) and ( estados.cve_estado =* alumnos.lugar_nac) and ( transporte.cve_transp =* alumnos.cve_transp) and ( nacionalidad.cve_nacion =* alumnos.cve_nacion) and ( religion.cve_religion =* alumnos.cve_religion) and( edo_civil.cve_edocivil =* alumnos.cve_edocivil) and ( academicos.cuenta = alumnos.cuenta ) and ( ( academicos.periodo_ing = :peri ) AND ( academicos.anio_ing = :anio ) ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr)'")
	CASE "Egresados en..."
		Modify("DataWindow.Table.Select = '   SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,alumnos.sexo,alumnos.cve_trabajo,trabajo.trabajo,alumnos.horas_trabajo,alumnos.fecha_nac,alumnos.lugar_nac,estados.estado,alumnos.cve_transp,transporte.transporte,alumnos.cve_nacion,nacionalidad.nacionalidad,alumnos.cve_religion,religion.religion,alumnos.cve_edocivil,edo_civil.edo_civil,alumnos.promedio_bach,academicos.cve_carrera,academicos.cve_plan,academicos.cve_subsistema FROM alumnos,trabajo,transporte,estados,nacionalidad,religion,edo_civil,academicos WHERE ( trabajo.cve_trabajo =* alumnos.cve_trabajo) and ( estados.cve_estado =* alumnos.lugar_nac) and ( transporte.cve_transp =* alumnos.cve_transp) and ( nacionalidad.cve_nacion =* alumnos.cve_nacion) and ( religion.cve_religion =* alumnos.cve_religion) and ( edo_civil.cve_edocivil =* alumnos.cve_edocivil) and ( academicos.cuenta = alumnos.cuenta ) and ( ( academicos.periodo_egre = :peri ) AND ( academicos.anio_egre = :anio ) AND ( academicos.egresado = 1 )) AND ( :carr = 9999 OR academicos.cve_carrera = :carr)'")
	CASE "Inscritos en..."
		periodo_actual(li_periodo,li_anio,gtr_sce)
		if li_periodo=gi_periodo and li_anio=gi_anio then
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,alumnos.sexo,alumnos.cve_trabajo,trabajo.trabajo,alumnos.horas_trabajo,alumnos.fecha_nac,alumnos.lugar_nac,estados.estado,alumnos.cve_transp,transporte.transporte,alumnos.cve_nacion,nacionalidad.nacionalidad,alumnos.cve_religion,religion.religion,alumnos.cve_edocivil,edo_civil.edo_civil,alumnos.promedio_bach,academicos.cve_carrera,academicos.cve_plan,academicos.cve_subsistema FROM alumnos,trabajo,transporte,estados,nacionalidad,religion,edo_civil,academicos WHERE ( trabajo.cve_trabajo =* alumnos.cve_trabajo ) and ( estados.cve_estado =* alumnos.lugar_nac ) and ( transporte.cve_transp =* alumnos.cve_transp ) and ( nacionalidad.cve_nacion =* alumnos.cve_nacion ) and ( religion.cve_religion =* alumnos.cve_religion ) and ( edo_civil.cve_edocivil =* alumnos.cve_edocivil ) and ( alumnos.cuenta = academicos.cuenta ) and ( :carr = 9999 OR academicos.cve_carrera = :carr) and ( alumnos.cuenta in (SELECT DISTINCT mat_inscritas.cuenta FROM mat_inscritas WHERE mat_inscritas.periodo = :peri AND mat_inscritas.anio = :anio ) )'")
		else
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,alumnos.sexo,alumnos.cve_trabajo,trabajo.trabajo,alumnos.horas_trabajo,alumnos.fecha_nac,alumnos.lugar_nac,estados.estado,alumnos.cve_transp,transporte.transporte,alumnos.cve_nacion,nacionalidad.nacionalidad,alumnos.cve_religion,religion.religion,alumnos.cve_edocivil,edo_civil.edo_civil,alumnos.promedio_bach,academicos.cve_carrera,academicos.cve_plan,academicos.cve_subsistema FROM alumnos,trabajo,transporte,estados,nacionalidad,religion,edo_civil,academicos WHERE ( trabajo.cve_trabajo =* alumnos.cve_trabajo ) and ( estados.cve_estado =* alumnos.lugar_nac ) and ( transporte.cve_transp =* alumnos.cve_transp ) and ( nacionalidad.cve_nacion =* alumnos.cve_nacion ) and ( religion.cve_religion =* alumnos.cve_religion ) and ( edo_civil.cve_edocivil =* alumnos.cve_edocivil ) and ( alumnos.cuenta = academicos.cuenta ) and ( :carr = 9999 OR academicos.cve_carrera = :carr) and ( alumnos.cuenta in (SELECT DISTINCT historico.cuenta FROM historico WHERE historico.periodo = :peri AND historico.anio = :anio ) )'")
		end if
	CASE "TODOS..."
		Modify("DataWindow.Table.Select = '   SELECT DISTINCT alumnos.cuenta,alumnos.nombre,alumnos.apaterno,alumnos.amaterno,alumnos.sexo,alumnos.cve_trabajo,trabajo.trabajo,alumnos.horas_trabajo,alumnos.fecha_nac,alumnos.lugar_nac,estados.estado,alumnos.cve_transp,transporte.transporte,alumnos.cve_nacion,nacionalidad.nacionalidad,alumnos.cve_religion,religion.religion,alumnos.cve_edocivil,edo_civil.edo_civil,alumnos.promedio_bach,academicos.cve_carrera,academicos.cve_plan,academicos.cve_subsistema FROM alumnos,trabajo,transporte,estados,nacionalidad,religion,edo_civil,academicos WHERE ( trabajo.cve_trabajo =* alumnos.cve_trabajo) and ( estados.cve_estado =* alumnos.lugar_nac) and ( transporte.cve_transp =* alumnos.cve_transp) and ( nacionalidad.cve_nacion =* alumnos.cve_nacion) and ( religion.cve_religion =* alumnos.cve_religion) and ( edo_civil.cve_edocivil =* alumnos.cve_edocivil) and ( academicos.cuenta = alumnos.cuenta ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr)'")
END CHOOSE

event primero()
return retrieve(gi_periodo,gi_anio,uo_carr.dw_carrera.object.cve_carrera[uo_carr.dw_carrera.getrow()])
end event

type ddlb_busca from dropdownlistbox within w_listado_alumnos
int X=1738
int Y=157
int Width=545
int Height=229
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

type uo_carr from uo_carrera within w_listado_alumnos
int X=385
int Y=105
int TabOrder=1
boolean Enabled=true
boolean BringToTop=true
long BackColor=1090519039
end type

on uo_carr.destroy
call uo_carrera::destroy
end on

