$PBExportHeader$w_rel_aspira.srw
$PBExportComments$Ventana con la relación de aspirantes
forward
global type w_rel_aspira from window
end type
type st_3 from statictext within w_rel_aspira
end type
type dw_fecha_examen from datawindow within w_rel_aspira
end type
type cbx_por_fecha from checkbox within w_rel_aspira
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_rel_aspira
end type
type cbx_carrera from checkbox within w_rel_aspira
end type
type cbx_coordinacion from checkbox within w_rel_aspira
end type
type cbx_departamentos from checkbox within w_rel_aspira
end type
type cbx_division from checkbox within w_rel_aspira
end type
type uo_2 from uo_carrera within w_rel_aspira
end type
type uo_1 from uo_ver_per_ani within w_rel_aspira
end type
type dw_1 from uo_dw_reporte within w_rel_aspira
end type
end forward

global type w_rel_aspira from window
integer x = 832
integer y = 364
integer width = 4686
integer height = 2268
boolean titlebar = true
string title = "Relación de Aspirantes"
string menuname = "m_menu"
long backcolor = 30976088
st_3 st_3
dw_fecha_examen dw_fecha_examen
cbx_por_fecha cbx_por_fecha
uo_tipo_periodo_ing uo_tipo_periodo_ing
cbx_carrera cbx_carrera
cbx_coordinacion cbx_coordinacion
cbx_departamentos cbx_departamentos
cbx_division cbx_division
uo_2 uo_2
uo_1 uo_1
dw_1 dw_1
end type
global w_rel_aspira w_rel_aspira

type variables
transaction itr_admision_web
end variables

forward prototypes
public function integer f_recupera_fechas ()
public function integer f_recupera_fecha_detalle ()
end prototypes

public function integer f_recupera_fechas ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

dw_fecha_examen.RESET()
dw_fecha_examen.INSERTROW(0)

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas
dw_fecha_examen.GETCHILD("id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 

//DATAWINDOWCHILD ldwc_fechas2
//dw_1.GETCHILD("aspiran_id_examen", ldwc_fechas2) 
//ldwc_fechas2.SETTRANSOBJECT(itr_admision_web) 
//ldwc_fechas2.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 


RETURN 0 


end function

public function integer f_recupera_fecha_detalle ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas2
dw_1.GETCHILD("aspiran_id_examen", ldwc_fechas2) 
ldwc_fechas2.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas2.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 


RETURN 0 


end function

on w_rel_aspira.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_3=create st_3
this.dw_fecha_examen=create dw_fecha_examen
this.cbx_por_fecha=create cbx_por_fecha
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.cbx_carrera=create cbx_carrera
this.cbx_coordinacion=create cbx_coordinacion
this.cbx_departamentos=create cbx_departamentos
this.cbx_division=create cbx_division
this.uo_2=create uo_2
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.st_3,&
this.dw_fecha_examen,&
this.cbx_por_fecha,&
this.uo_tipo_periodo_ing,&
this.cbx_carrera,&
this.cbx_coordinacion,&
this.cbx_departamentos,&
this.cbx_division,&
this.uo_2,&
this.uo_1,&
this.dw_1}
end on

on w_rel_aspira.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.dw_fecha_examen)
destroy(this.cbx_por_fecha)
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


INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

dw_1.settransobject(gtr_sadm)

f_recupera_fechas()


end event

event close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type st_3 from statictext within w_rel_aspira
integer x = 741
integer y = 220
integer width = 539
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fecha Aplicación:"
boolean focusrectangle = false
end type

type dw_fecha_examen from datawindow within w_rel_aspira
integer x = 1289
integer y = 196
integer width = 1202
integer height = 104
integer taborder = 20
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_por_fecha from checkbox within w_rel_aspira
integer x = 41
integer y = 220
integer width = 654
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Por Fecha Examen:"
boolean lefttext = true
end type

event clicked;IF CHECKED THEN 
	dw_fecha_examen.ENABLED = TRUE 
ELSE 
	dw_fecha_examen.ENABLED = FALSE 
END IF 
	
	
	
end event

type uo_tipo_periodo_ing from uo_tipo_periodo within w_rel_aspira
integer x = 2290
integer y = 24
integer height = 136
integer taborder = 10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type cbx_carrera from checkbox within w_rel_aspira
integer x = 1408
integer y = 332
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

type cbx_coordinacion from checkbox within w_rel_aspira
integer x = 914
integer y = 332
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

type cbx_departamentos from checkbox within w_rel_aspira
integer x = 425
integer y = 332
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

type cbx_division from checkbox within w_rel_aspira
integer x = 69
integer y = 332
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

type uo_2 from uo_carrera within w_rel_aspira
integer x = 2578
integer y = 176
integer width = 1344
integer height = 204
boolean enabled = true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_rel_aspira
integer x = 5
integer y = 8
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()
end event

type dw_1 from uo_dw_reporte within w_rel_aspira
integer x = 64
integer y = 440
integer width = 4549
integer height = 1612
integer taborder = 0
string dataobject = "dw_rel_aspira"
boolean hscrollbar = true
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_rel_aspira"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_rel_aspira_ing"
	this.SetTransObject(gtr_sadm)	
END IF


event primero()
object.st_1.text=tit1


LONG ll_id_fecha


IF cbx_por_fecha.CHECKED THEN 
	ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
	IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
		MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
		RETURN -1
	END IF
ELSE 
	ll_id_fecha = 0
END IF 

f_recupera_fecha_detalle()

return retrieve(gi_version,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()], ll_id_fecha)
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

