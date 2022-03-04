$PBExportHeader$w_estadistica_salones.srw
forward
global type w_estadistica_salones from window
end type
type cbx_por_fecha from checkbox within w_estadistica_salones
end type
type dw_fecha_examen from datawindow within w_estadistica_salones
end type
type st_3 from statictext within w_estadistica_salones
end type
type cb_buscar from commandbutton within w_estadistica_salones
end type
type uo_1 from uo_ver_per_ani within w_estadistica_salones
end type
type dw_1 from uo_dw_reporte within w_estadistica_salones
end type
end forward

global type w_estadistica_salones from window
integer x = 832
integer y = 360
integer width = 3607
integer height = 2536
boolean titlebar = true
string title = "Estadistica de Ocupación de Salones"
string menuname = "m_menu"
long backcolor = 30976088
cbx_por_fecha cbx_por_fecha
dw_fecha_examen dw_fecha_examen
st_3 st_3
cb_buscar cb_buscar
uo_1 uo_1
dw_1 dw_1
end type
global w_estadistica_salones w_estadistica_salones

type variables
transaction itr_admision_web
end variables

forward prototypes
public function integer f_recupera_fechas ()
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

DATAWINDOWCHILD ldwc_fechas2
dw_1.GETCHILD("carr_sal_id_examen", ldwc_fechas2) 
ldwc_fechas2.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas2.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 


RETURN 0 



end function

on w_estadistica_salones.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_por_fecha=create cbx_por_fecha
this.dw_fecha_examen=create dw_fecha_examen
this.st_3=create st_3
this.cb_buscar=create cb_buscar
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.cbx_por_fecha,&
this.dw_fecha_examen,&
this.st_3,&
this.cb_buscar,&
this.uo_1,&
this.dw_1}
end on

on w_estadistica_salones.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_por_fecha)
destroy(this.dw_fecha_examen)
destroy(this.st_3)
destroy(this.cb_buscar)
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



//dw_1.settransobject(gtr_sadm)
dw_1.settransobject(itr_admision_web) 


f_recupera_fechas()
end event

event close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type cbx_por_fecha from checkbox within w_estadistica_salones
integer x = 59
integer y = 248
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

type dw_fecha_examen from datawindow within w_estadistica_salones
integer x = 1335
integer y = 236
integer width = 1202
integer height = 104
integer taborder = 41
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_estadistica_salones
integer x = 768
integer y = 260
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

type cb_buscar from commandbutton within w_estadistica_salones
integer x = 2811
integer y = 68
integer width = 306
integer height = 104
integer taborder = 31
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Buscar"
end type

event clicked;
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
	

dw_1.retrieve(gi_version,gi_periodo,gi_anio, ll_id_fecha)
end event

type uo_1 from uo_ver_per_ani within w_estadistica_salones
integer x = 59
integer y = 44
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()

RETURN 

end event

type dw_1 from uo_dw_reporte within w_estadistica_salones
integer x = 59
integer y = 416
integer width = 3456
integer height = 1876
integer taborder = 0
string dataobject = "dw_estadistica_salones"
boolean hscrollbar = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;/**/

return 0
end event

