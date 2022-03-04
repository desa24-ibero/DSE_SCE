$PBExportHeader$w_rep_aspira_pago_examen_esp.srw
$PBExportComments$Ventana con la relación de aspirantes
forward
global type w_rep_aspira_pago_examen_esp from window
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_aspira_pago_examen_esp
end type
type cbx_carrera from checkbox within w_rep_aspira_pago_examen_esp
end type
type cbx_coordinacion from checkbox within w_rep_aspira_pago_examen_esp
end type
type cbx_departamentos from checkbox within w_rep_aspira_pago_examen_esp
end type
type cbx_division from checkbox within w_rep_aspira_pago_examen_esp
end type
type uo_2 from uo_carrera_admision within w_rep_aspira_pago_examen_esp
end type
type uo_1 from uo_ver_per_ani within w_rep_aspira_pago_examen_esp
end type
type dw_1 from uo_dw_reporte within w_rep_aspira_pago_examen_esp
end type
end forward

global type w_rep_aspira_pago_examen_esp from window
integer x = 832
integer y = 364
integer width = 4142
integer height = 2180
boolean titlebar = true
string title = "Relación de Pagos Especiales de  Aspirantes "
string menuname = "m_menu"
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 30976088
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_carrera cbx_carrera
cbx_coordinacion cbx_coordinacion
cbx_departamentos cbx_departamentos
cbx_division cbx_division
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_rep_aspira_pago_examen_esp w_rep_aspira_pago_examen_esp

type variables

end variables

on w_rep_aspira_pago_examen_esp.create
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

on w_rep_aspira_pago_examen_esp.destroy
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

type uo_tipo_periodo_ing from uo_tipo_periodo within w_rep_aspira_pago_examen_esp
integer x = 2290
integer y = 24
integer height = 136
integer taborder = 10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_carrera from checkbox within w_rep_aspira_pago_examen_esp
boolean visible = false
integer x = 1655
integer y = 252
integer width = 320
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Carreras"
boolean lefttext = true
end type

type cbx_coordinacion from checkbox within w_rep_aspira_pago_examen_esp
boolean visible = false
integer x = 1161
integer y = 252
integer width = 489
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Coordinaciones"
boolean lefttext = true
end type

type cbx_departamentos from checkbox within w_rep_aspira_pago_examen_esp
boolean visible = false
integer x = 672
integer y = 252
integer width = 485
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Departamentos"
boolean lefttext = true
end type

type cbx_division from checkbox within w_rep_aspira_pago_examen_esp
boolean visible = false
integer x = 315
integer y = 252
integer width = 357
integer height = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Divisiones"
boolean lefttext = true
end type

type uo_2 from uo_carrera_admision within w_rep_aspira_pago_examen_esp
integer x = 800
integer y = 188
integer width = 1815
integer height = 192
boolean enabled = true
end type

on uo_2.destroy
call uo_carrera_admision::destroy
end on

type uo_1 from uo_ver_per_ani within w_rep_aspira_pago_examen_esp
integer x = 5
integer y = 8
integer height = 164
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_1 from uo_dw_reporte within w_rep_aspira_pago_examen_esp
integer x = 27
integer y = 396
integer width = 3845
integer height = 1576
integer taborder = 0
string dataobject = "d_rep_aspiran_pago_examen_esp"
boolean resizable = true
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "d_rep_aspiran_pago_examen_esp"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "d_rep_aspiran_pago_examen_esp_ing"
	this.SetTransObject(gtr_sadm)	
END IF


event primero()
//object.st_1.text=tit1
return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])
end event

event retrieveend;call super::retrieveend;//string division,departamento,coordinacion,carrera
//int clv_carr,bachillera
//long cont
//
//FOR cont=1 TO rowcount
//	clv_carr=object.cclv_carr[cont]
//
//	SELECT carreras.carrera,coordinaciones.coordinacion,departamentos.departamento,
//			divisiones.division
//	INTO :carrera,:coordinacion,:departamento,:division
//	FROM carreras,coordinaciones,departamentos,divisiones
//	WHERE ( coordinaciones.cve_coordinacion = carreras.cve_coordinacion ) and
//		( departamentos.cve_depto = coordinaciones.cve_depto ) and
//		( divisiones.cve_division = departamentos.cve_division ) and
//		( ( carreras.cve_carrera = :clv_carr ) )
//	USING gtr_sce;
//
//	if cbx_division.checked then
//		object.division[cont]=division
//	end if
//	
//	if cbx_departamentos.checked then
//		object.departamento[cont]=departamento
//	end if
//	
//	if cbx_coordinacion.checked then
//		object.coordinacion[cont]=coordinacion
//	end if
//
//	if cbx_carrera.checked then
//		carrera=string(clv_carr,"####0000")+' '+carrera
//		object.carrera[cont]=carrera
//	end if
//	
//NEXT
//sort()
//groupcalc()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

