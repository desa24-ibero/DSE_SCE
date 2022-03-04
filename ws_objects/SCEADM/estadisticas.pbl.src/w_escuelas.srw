$PBExportHeader$w_escuelas.srw
$PBExportComments$Permite elegir carrera para el reporte de #escuela
forward
global type w_escuelas from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_escuelas
end type
type cbx_bachillera from checkbox within w_escuelas
end type
type cbx_carrera from checkbox within w_escuelas
end type
type cbx_coordinacion from checkbox within w_escuelas
end type
type cbx_departamentos from checkbox within w_escuelas
end type
type cbx_division from checkbox within w_escuelas
end type
type uo_2 from uo_carrera within w_escuelas
end type
type uo_1 from uo_ver_per_ani within w_escuelas
end type
type dw_1 from uo_dw_reporte within w_escuelas
end type
end forward

global type w_escuelas from Window
int X=834
int Y=362
int Width=3686
int Height=1965
boolean TitleBar=true
string Title="Perfil Alumno por Escuelas"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_bachillera cbx_bachillera
cbx_carrera cbx_carrera
cbx_coordinacion cbx_coordinacion
cbx_departamentos cbx_departamentos
cbx_division cbx_division
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_escuelas w_escuelas

on w_escuelas.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cbx_bachillera=create cbx_bachillera
this.cbx_carrera=create cbx_carrera
this.cbx_coordinacion=create cbx_coordinacion
this.cbx_departamentos=create cbx_departamentos
this.cbx_division=create cbx_division
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.cbx_bachillera,&
this.cbx_carrera,&
this.cbx_coordinacion,&
this.cbx_departamentos,&
this.cbx_division,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_escuelas.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
destroy(this.cbx_bachillera)
destroy(this.cbx_carrera)
destroy(this.cbx_coordinacion)
destroy(this.cbx_departamentos)
destroy(this.cbx_division)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_escuelas
int X=2297
int Y=32
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_bachillera from checkbox within w_escuelas
int X=1774
int Y=336
int Width=344
int Height=61
string Text="Escuelas"
boolean LeftText=true
long BackColor=16777215
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type cbx_carrera from checkbox within w_escuelas
int X=1448
int Y=336
int Width=322
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

type cbx_coordinacion from checkbox within w_escuelas
int X=955
int Y=336
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

type cbx_departamentos from checkbox within w_escuelas
int X=468
int Y=336
int Width=486
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

type cbx_division from checkbox within w_escuelas
int X=110
int Y=336
int Width=355
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

type uo_2 from uo_carrera within w_escuelas
int X=2304
int Y=186
boolean Enabled=true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_escuelas
int X=11
int Y=16
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_escuelas
int X=40
int Y=397
int Width=3577
int Height=1376
int TabOrder=0
string DataObject="dw_#escuela"
boolean HScrollBar=true
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_#escuela"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_#escuela_ing"
	this.SetTransObject(gtr_sadm)	
END IF

event primero()
return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])
object.st_1.text=uo_2.dw_carrera.object.carrera[uo_2.dw_carrera.getrow()]+' '+tit1
end event

event retrieveend;string division,departamento,coordinacion,carrera,bachillerato
int clv_carr,bachillera
long cont
SetPointer(HourGlass!)

FOR cont=1 TO rowcount
	clv_carr=object.aspiran_clv_carr[cont]
	bachillera=object.general_bachillera[cont]

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
	
	if cbx_bachillera.checked then
		SELECT escuelas.escuela  
		INTO :bachillerato  
		FROM escuelas  
		WHERE escuelas.cve_escuela = :bachillera
		USING gtr_sce;
		object.escuela[cont]=string(bachillera,"####0000")+' '+bachillerato
	end if
		
NEXT
sort()
groupcalc()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

