$PBExportHeader$w_resultados_examen_exani2_2017.srw
forward
global type w_resultados_examen_exani2_2017 from w_main
end type
type cbx_por_fecha from checkbox within w_resultados_examen_exani2_2017
end type
type st_1 from statictext within w_resultados_examen_exani2_2017
end type
type st_3 from statictext within w_resultados_examen_exani2_2017
end type
type dw_fecha_examen from datawindow within w_resultados_examen_exani2_2017
end type
type uo_tipo_periodo_ing from uo_tipo_periodo within w_resultados_examen_exani2_2017
end type
type uo_1 from uo_ver_per_ani within w_resultados_examen_exani2_2017
end type
type dw_1 from uo_dw_reporte within w_resultados_examen_exani2_2017
end type
end forward

global type w_resultados_examen_exani2_2017 from w_main
integer x = 832
integer y = 364
integer width = 5294
integer height = 2316
string title = "Resultados de Examen"
string menuname = "m_menu"
long backcolor = 67108864
cbx_por_fecha cbx_por_fecha
st_1 st_1
st_3 st_3
dw_fecha_examen dw_fecha_examen
uo_tipo_periodo_ing uo_tipo_periodo_ing
uo_1 uo_1
dw_1 dw_1
end type
global w_resultados_examen_exani2_2017 w_resultados_examen_exani2_2017

type variables
transaction itr_admision_web


end variables

forward prototypes
public function integer f_recupera_fechas ()
end prototypes

public function integer f_recupera_fechas ();
// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

dw_fecha_examen.RESET()
dw_fecha_examen.INSERTROW(0)

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas
dw_fecha_examen.GETCHILD("id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 

RETURN 0 



end function

on w_resultados_examen_exani2_2017.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_por_fecha=create cbx_por_fecha
this.st_1=create st_1
this.st_3=create st_3
this.dw_fecha_examen=create dw_fecha_examen
this.uo_tipo_periodo_ing=create uo_tipo_periodo_ing
this.uo_1=create uo_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_por_fecha
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.dw_fecha_examen
this.Control[iCurrent+5]=this.uo_tipo_periodo_ing
this.Control[iCurrent+6]=this.uo_1
this.Control[iCurrent+7]=this.dw_1
end on

on w_resultados_examen_exani2_2017.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_por_fecha)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.dw_fecha_examen)
destroy(this.uo_tipo_periodo_ing)
destroy(this.uo_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)

INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

f_recupera_fechas()
end event

event close;call super::close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type cbx_por_fecha from checkbox within w_resultados_examen_exani2_2017
integer x = 2720
integer y = 52
integer width = 654
integer height = 80
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

type st_1 from statictext within w_resultados_examen_exani2_2017
integer x = 3410
integer y = 60
integer width = 553
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
boolean enabled = false
string text = "Fecha Aplicación:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_3 from statictext within w_resultados_examen_exani2_2017
integer x = 64
integer y = 260
integer width = 571
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Fecha Aplicación:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_fecha_examen from datawindow within w_resultados_examen_exani2_2017
integer x = 3991
integer y = 40
integer width = 1202
integer height = 104
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_tipo_periodo_ing from uo_tipo_periodo within w_resultados_examen_exani2_2017
integer x = 2290
integer y = 24
integer height = 144
integer taborder = 10
end type

on uo_tipo_periodo_ing.destroy
call uo_tipo_periodo::destroy
end on

type uo_1 from uo_ver_per_ani within w_resultados_examen_exani2_2017
integer x = 5
integer y = 8
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;
f_recupera_fechas()

RETURN 

end event

type dw_1 from uo_dw_reporte within w_resultados_examen_exani2_2017
integer x = 9
integer y = 184
integer width = 5198
integer height = 1868
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_resultados_examen_exani2_2017"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = styleraised!
end type

event carga;IF uo_tipo_periodo_ing.rb_registro.Checked THEN
	this.dataobject = "dw_resultados_examen_exani2_2017"
	this.SetTransObject(gtr_sadm)
ELSE
	this.dataobject = "dw_resultados_examen_exani2_ing_2017"
	this.SetTransObject(gtr_sadm)	
END IF


long ll_id_fecha
IF cbx_por_fecha.CHECKED THEN 
	ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
	IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
		MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
		RETURN -1
	END IF	
ELSE
	ll_id_fecha = 9999
END IF

event primero()


// Se recuperan las fechas de examen de la versión solicitada
LONG li_clv_ver_nueva, llrows
li_clv_ver_nueva = gi_version
DATAWINDOWCHILD ldwc_fechas
dw_1.GETCHILD("aspiran_id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
llrows = ldwc_fechas.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 

return retrieve(gi_version,gi_periodo,gi_anio, ll_id_fecha) 
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

