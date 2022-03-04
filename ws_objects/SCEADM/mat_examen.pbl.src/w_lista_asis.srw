$PBExportHeader$w_lista_asis.srw
$PBExportComments$Ventana con las listas de asistencias
forward
global type w_lista_asis from window
end type
type st_1 from statictext within w_lista_asis
end type
type dw_fecha_examen from datawindow within w_lista_asis
end type
type cbx_por_fecha from checkbox within w_lista_asis
end type
type uo_1 from uo_ver_per_ani within w_lista_asis
end type
type dw_1 from uo_dw_reporte within w_lista_asis
end type
end forward

global type w_lista_asis from window
integer x = 832
integer y = 360
integer width = 4160
integer height = 3064
boolean titlebar = true
string title = "Listas de Asistencia"
string menuname = "m_menu"
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 30976088
st_1 st_1
dw_fecha_examen dw_fecha_examen
cbx_por_fecha cbx_por_fecha
uo_1 uo_1
dw_1 dw_1
end type
global w_lista_asis w_lista_asis

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

on w_lista_asis.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_1=create st_1
this.dw_fecha_examen=create dw_fecha_examen
this.cbx_por_fecha=create cbx_por_fecha
this.uo_1=create uo_1
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.dw_fecha_examen,&
this.cbx_por_fecha,&
this.uo_1,&
this.dw_1}
end on

on w_lista_asis.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.dw_fecha_examen)
destroy(this.cbx_por_fecha)
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

type st_1 from statictext within w_lista_asis
boolean visible = false
integer x = 3081
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

type dw_fecha_examen from datawindow within w_lista_asis
integer x = 2455
integer y = 40
integer width = 1202
integer height = 104
integer taborder = 30
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cbx_por_fecha from checkbox within w_lista_asis
boolean visible = false
integer x = 2391
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

type uo_1 from uo_ver_per_ani within w_lista_asis
integer x = 69
integer y = 16
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()

RETURN 

end event

type dw_1 from uo_dw_reporte within w_lista_asis
integer x = 18
integer y = 188
integer width = 3991
integer height = 2572
integer taborder = 0
string dataobject = "dw_lista_asis"
boolean resizable = true
end type

event carga;event primero()
object.st_1.text='Lista de Asistencia del exámen de Admisión correspondiente al '+tit1+' salón '


LONG ll_id_fecha 
ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen") 
IF ISNULL(ll_id_fecha) THEN ll_id_fecha = 0 

IF ll_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen") 
	RETURN 0
END IF 



STRING ls_fecha_aplicacion, ls_inicio, ls_fin
DATETIME ldt_fecha 
INTEGER le_version


  SELECT examen_fecha.fecha_examen,   
         examen_turno.hora_inicio,   
         examen_turno.hora_fin,   
         examen_fecha.cve_ver 
  INTO :ldt_fecha, : ls_inicio, :ls_fin, :le_version 
    FROM examen_fecha,   
         examen_turno  
   WHERE  examen_fecha.id_examen =  :ll_id_fecha
	USING itr_admision_web;


ls_fecha_aplicacion = string(  ldt_fecha , 'dd/mm/yyyy' ) + '  de  ' + ls_inicio  + ' a  ' +  ls_fin + '  Ver: ' + string( le_version )

object.st_1.text='Lista de Asistencia del exámen de Admisión correspondiente al '+ls_fecha_aplicacion+' salón '

return retrieve(gi_version,gi_periodo,gi_anio, ll_id_fecha)


end event

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event retrieveend;call super::retrieveend;long ll_row, ll_no_lista = 1
string ls_salon = '', ls_salon_actual

for ll_row=1 to rowcount
	ls_salon_actual = this.GetItemString(ll_row, "salon")

	IF ls_salon_actual<> ls_salon then 
		ll_no_lista = 1
		ls_salon = ls_salon_actual
	END IF
	this.SetItem(ll_row, "no_lista", ll_no_lista)
	ll_no_lista= ll_no_lista + 1
	
next

end event

