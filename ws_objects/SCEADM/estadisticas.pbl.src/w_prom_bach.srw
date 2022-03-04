$PBExportHeader$w_prom_bach.srw
$PBExportComments$Permite elegir carrera para el reporte de dw_prom_bach
forward
global type w_prom_bach from Window
end type
type cbx_division from checkbox within w_prom_bach
end type
type cbx_departamentos from checkbox within w_prom_bach
end type
type cbx_coordinacion from checkbox within w_prom_bach
end type
type cbx_carrera from checkbox within w_prom_bach
end type
type uo_2 from uo_carrera within w_prom_bach
end type
type uo_1 from uo_ver_per_ani within w_prom_bach
end type
type dw_1 from uo_dw_reporte within w_prom_bach
end type
end forward

global type w_prom_bach from Window
int X=833
int Y=361
int Width=3685
int Height=1961
boolean TitleBar=true
string Title="Aspirantes, Aceptados e Inscritos por Promedio de Bachillerato"
string MenuName="m_menu"
long BackColor=30976088
cbx_division cbx_division
cbx_departamentos cbx_departamentos
cbx_coordinacion cbx_coordinacion
cbx_carrera cbx_carrera
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_prom_bach w_prom_bach

on w_prom_bach.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_division=create cbx_division
this.cbx_departamentos=create cbx_departamentos
this.cbx_coordinacion=create cbx_coordinacion
this.cbx_carrera=create cbx_carrera
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={ this.cbx_division,&
this.cbx_departamentos,&
this.cbx_coordinacion,&
this.cbx_carrera,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_prom_bach.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_division)
destroy(this.cbx_departamentos)
destroy(this.cbx_coordinacion)
destroy(this.cbx_carrera)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type cbx_division from checkbox within w_prom_bach
int X=234
int Y=189
int Width=353
int Height=61
string Text="Divisiones"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_departamentos from checkbox within w_prom_bach
int X=590
int Y=189
int Width=485
int Height=61
string Text="Departamentos"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_coordinacion from checkbox within w_prom_bach
int X=1079
int Y=189
int Width=490
int Height=61
string Text="Coordinaciones"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_carrera from checkbox within w_prom_bach
int X=1573
int Y=189
int Width=321
int Height=61
string Text="Carreras"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type uo_2 from uo_carrera within w_prom_bach
int X=2295
int Y=17
boolean Enabled=true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_prom_bach
int X=10
int Y=17
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_prom_bach
int X=37
int Y=257
int Width=3575
int Height=1533
int TabOrder=0
string DataObject="dw_prom_bach"
end type

event carga;event primero()
object.st_1.text=uo_2.dw_carrera.object.carrera[uo_2.dw_carrera.getrow()]+' '+tit1
return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])
end event

event retrieveend;call super::retrieveend;string division,departamento,coordinacion,carrera
int clv_carr
long cont

FOR cont=1 TO rowcount
	clv_carr=object.clv_carr[cont]

	SELECT carreras.carrera,coordinaciones.coordinacion,departamentos.departamento,
			divisiones.division
	INTO :carrera,:coordinacion,:departamento,:division
	FROM carreras,coordinaciones,departamentos,divisiones
	WHERE ( coordinaciones.cve_coordinacion = carreras.cve_coordinacion ) and
		( departamentos.cve_depto = coordinaciones.cve_depto ) and
		( divisiones.cve_division = departamentos.cve_division ) and
		( ( carreras.cve_carrera = :clv_carr ) )
	USING gtr_sce;

	if cbx_division.checked then
		object.division[cont]=division
	end if
	
	if cbx_departamentos.checked then
		object.departamento[cont]=departamento
	end if
	
	if cbx_coordinacion.checked then
		object.coordinacion[cont]=coordinacion
	end if

	if cbx_carrera.checked then
		carrera=string(clv_carr,"####0000")+' '+carrera
		object.carrera[cont]=carrera
	end if
	
NEXT
sort()
groupcalc()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

