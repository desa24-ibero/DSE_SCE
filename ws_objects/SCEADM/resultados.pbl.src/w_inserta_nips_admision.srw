$PBExportHeader$w_inserta_nips_admision.srw
forward
global type w_inserta_nips_admision from window
end type
type st_3 from statictext within w_inserta_nips_admision
end type
type dw_fecha_examen from datawindow within w_inserta_nips_admision
end type
type uo_1 from uo_ver_per_ani within w_inserta_nips_admision
end type
type st_proceso from statictext within w_inserta_nips_admision
end type
type cb_insertar from commandbutton within w_inserta_nips_admision
end type
type cb_salir from commandbutton within w_inserta_nips_admision
end type
end forward

global type w_inserta_nips_admision from window
integer width = 2441
integer height = 916
boolean titlebar = true
string title = "Inserta Nips de Admisión"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
st_3 st_3
dw_fecha_examen dw_fecha_examen
uo_1 uo_1
st_proceso st_proceso
cb_insertar cb_insertar
cb_salir cb_salir
end type
global w_inserta_nips_admision w_inserta_nips_admision

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

RETURN 0 



end function

on w_inserta_nips_admision.create
this.st_3=create st_3
this.dw_fecha_examen=create dw_fecha_examen
this.uo_1=create uo_1
this.st_proceso=create st_proceso
this.cb_insertar=create cb_insertar
this.cb_salir=create cb_salir
this.Control[]={this.st_3,&
this.dw_fecha_examen,&
this.uo_1,&
this.st_proceso,&
this.cb_insertar,&
this.cb_salir}
end on

on w_inserta_nips_admision.destroy
destroy(this.st_3)
destroy(this.dw_fecha_examen)
destroy(this.uo_1)
destroy(this.st_proceso)
destroy(this.cb_insertar)
destroy(this.cb_salir)
end on

event open;x=1
y=1

dw_fecha_examen.INSERTROW(0)

INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

f_recupera_fechas()
end event

type st_3 from statictext within w_inserta_nips_admision
boolean visible = false
integer x = 41
integer y = 272
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

type dw_fecha_examen from datawindow within w_inserta_nips_admision
boolean visible = false
integer x = 635
integer y = 248
integer width = 1202
integer height = 104
integer taborder = 40
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_ver_per_ani within w_inserta_nips_admision
event destroy ( )
integer x = 27
integer y = 48
integer taborder = 30
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;
f_recupera_fechas()

RETURN 



end event

type st_proceso from statictext within w_inserta_nips_admision
integer x = 46
integer y = 268
integer width = 2290
integer height = 272
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "EN ESPERA..."
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type cb_insertar from commandbutton within w_inserta_nips_admision
integer x = 1385
integer y = 620
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Insertar"
end type

event clicked;long	ll_clv_ver, ll_clv_per, ll_anio, ll_obten_version_vigente, ll_inserta_nips_admision
long ll_cuenta_nips_insertados
string ls_proceso, ls_periodo
integer li_confirmacion
SetPointer(HourGlass!)
ls_proceso= "INICIO DEL PROCESO..."
st_proceso.text = ls_proceso

ls_proceso= "OBTENIENDO LA VERSION VIGENTE..."
st_proceso.text = ls_proceso


// Comentado 01/12/2017 
//ll_obten_version_vigente = f_obten_version_vigente(ll_clv_ver, ll_clv_per, ll_anio)
//IF ll_obten_version_vigente= -1 THEN
//	MessageBox("No se encuentra una versión vigente", "Favor de Insertar una en la ventana de Parámetros.~n No es posible realizar la inserción", StopSign!)
//	RETURN	
//END IF

// El periodo y la versión se toman de los parámetros de entrada seleccionados contenidos en las variables globales:
//gi_version, gi_periodo, gi_anio

ll_clv_per = gi_periodo
ll_clv_ver = gi_version
ll_anio = gi_anio

CHOOSE CASE ll_clv_per
	CASE 0
		ls_periodo = "Primavera"
	CASE 1
		ls_periodo = "Verano"
	CASE 2
		ls_periodo = "Otoño"
	CASE ELSE
		ls_periodo = ""
END CHOOSE

li_confirmacion = MessageBox("Confirmacion", "Desea insertar nips para el Año:"+string(ll_anio)+"~n"+&
																								"Periodo:"+ls_periodo+"~n"+&
																								"Versión:"+string(ll_clv_ver),Question!,YesNo!)
IF li_confirmacion<>1 THEN
	MessageBox("Cancelación", "Se ha cancelado la inserción",Information!)
	return
END IF

ls_proceso= "INSERTANDO LOS NIPS..."
st_proceso.text = ls_proceso
ll_inserta_nips_admision = f_inserta_nips_admision(ll_clv_ver, ll_clv_per, ll_anio)

IF ll_obten_version_vigente= -1 THEN
	MessageBox("No es posible insertar", "No se realizó la inserción", StopSign!)
	RETURN	
END IF

ls_proceso= "CONTANDO LOS NIPS TOTALES..."
st_proceso.text = ls_proceso

ll_cuenta_nips_insertados = f_cuenta_nips_insertados(ll_clv_ver, ll_clv_per, ll_anio)

IF ll_cuenta_nips_insertados= -1 THEN
	MessageBox("No es posible contar", "No se puede contar los nips insertados", StopSign!)
	ll_cuenta_nips_insertados = 0
END IF

ls_proceso= "INSERCION TERMINADA"
st_proceso.text = ls_proceso

ls_proceso = "SE INSERTARON ["+string(ll_inserta_nips_admision)+"] EN ESTA OCASION ~n"+&
			"ACTUALMENTE EXISTEN ["+string(ll_cuenta_nips_insertados)+"] EN TOTAL"

MessageBox("Inserción de Nips Realizada Exitosamente", ls_proceso, Information!)

st_proceso.text = ls_proceso

SetPointer(Arrow!)

end event

type cb_salir from commandbutton within w_inserta_nips_admision
integer x = 1925
integer y = 620
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Salir"
end type

event clicked;close(parent)
end event

