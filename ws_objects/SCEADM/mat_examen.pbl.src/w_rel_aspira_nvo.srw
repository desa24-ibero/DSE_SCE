$PBExportHeader$w_rel_aspira_nvo.srw
forward
global type w_rel_aspira_nvo from Window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_rel_aspira_nvo
end type
type cbx_carrera from checkbox within w_rel_aspira_nvo
end type
type cbx_coordinacion from checkbox within w_rel_aspira_nvo
end type
type cbx_departamentos from checkbox within w_rel_aspira_nvo
end type
type cbx_division from checkbox within w_rel_aspira_nvo
end type
type uo_2 from uo_carrera within w_rel_aspira_nvo
end type
type uo_1 from uo_ver_per_ani within w_rel_aspira_nvo
end type
type dw_1 from uo_dw_reporte within w_rel_aspira_nvo
end type
end forward

global type w_rel_aspira_nvo from Window
int X=834
int Y=362
int Width=3463
int Height=1754
boolean TitleBar=true
string Title="Relación de Aspirantes"
string MenuName="m_menu"
long BackColor=30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_carrera cbx_carrera
cbx_coordinacion cbx_coordinacion
cbx_departamentos cbx_departamentos
cbx_division cbx_division
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_rel_aspira_nvo w_rel_aspira_nvo

type variables

end variables

on w_rel_aspira_nvo.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cbx_carrera=create cbx_carrera
this.cbx_coordinacion=create cbx_coordinacion
this.cbx_departamentos=create cbx_departamentos
this.cbx_division=create cbx_division
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.uo_tipo_periodo_ing,&
this.cbx_carrera,&
this.cbx_coordinacion,&
this.cbx_departamentos,&
this.cbx_division,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_rel_aspira_nvo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_tipo_periodo_ing)
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

type uo_tipo_periodo_ing from uo_tipo_periodo within w_rel_aspira_nvo
int X=2293
int Y=22
int TabOrder=10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_carrera from checkbox within w_rel_aspira_nvo
int X=1360
int Y=227
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

type cbx_coordinacion from checkbox within w_rel_aspira_nvo
int X=867
int Y=227
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

type cbx_departamentos from checkbox within w_rel_aspira_nvo
int X=377
int Y=227
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

type cbx_division from checkbox within w_rel_aspira_nvo
int X=18
int Y=227
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

type uo_2 from uo_carrera within w_rel_aspira_nvo
int X=2052
int Y=170
boolean Enabled=true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_rel_aspira_nvo
int X=4
int Y=6
boolean Enabled=true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_rel_aspira_nvo
int X=4
int Y=378
int Width=3397
int Height=1181
int TabOrder=0
string DataObject="dw_rel_aspira_nvo"
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_rel_aspira_nvo"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_rel_aspira_nvo_ing"
	this.SetTransObject(gtr_sadm)	
END IF

event primero()
object.st_1.text=tit1


return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])
end event

event retrieveend;call super::retrieveend;string division,departamento,coordinacion,carrera
int clv_carr,bachillera
long cont

FOR cont=1 TO rowcount
	clv_carr=object.cclv_carr[cont]

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

