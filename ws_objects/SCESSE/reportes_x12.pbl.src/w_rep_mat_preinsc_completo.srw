$PBExportHeader$w_rep_mat_preinsc_completo.srw
$PBExportComments$Reporte de materias preinscritas
forward
global type w_rep_mat_preinsc_completo from w_ancestral
end type
type uo_periodo_anio from uo_per_ani within w_rep_mat_preinsc_completo
end type
type cbx_todas from checkbox within w_rep_mat_preinsc_completo
end type
type dw_rep_mat_preinsc from uo_dw_reporte within w_rep_mat_preinsc_completo
end type
end forward

global type w_rep_mat_preinsc_completo from w_ancestral
integer width = 3611
integer height = 2076
string title = "Reporte de Materias Preinscritas"
string menuname = "m_menu"
uo_periodo_anio uo_periodo_anio
cbx_todas cbx_todas
dw_rep_mat_preinsc dw_rep_mat_preinsc
end type
global w_rep_mat_preinsc_completo w_rep_mat_preinsc_completo

type variables
transaction itr_web
int ii_cve_coordinacion, ii_num_resize = 0
Transaction itr_parametros_iniciales
n_tr itr_seguridad, itr_original

//nombre de la conexion en parametros_conexion
CONSTANT	string	is_controlescolar_cnx	=	"controlescolar_inscripcion"
CONSTANT	string	is_tesoreria_cnx			=	"controlescolar_inscripcion_tesoreria"
CONSTANT	string	is_becas_cnx				=	"controlescolar_inscripcion_becas"

end variables

event open;call super::open;/*
DESCRIPCIÓN: Pon la ventana en el extremo. Liga dw_rep_mat_preinsc a sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/



int li_chk
x=1
y=1

itr_parametros_iniciales = gtr_sce

li_chk	=	f_conecta_pas_parametros_act_bd(itr_parametros_iniciales,itr_web,is_controlescolar_cnx,gs_usuario,gs_password,0)
if li_chk <> 1 then return

dw_rep_mat_preinsc.SetTransObject(itr_web)

//if conecta_bd(itr_web,"SWEB", "preinsce","futuro")<>1 then
//	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
//	close(this)
//else 
//	dw_rep_mat_preinsc.SetTransObject(itr_web)
//end if

//dw_rep_mat_preinsc.settransobject(gtr_sce)

ii_cve_coordinacion = f_obten_coord_de_usuario(gs_usuario)

if  ii_cve_coordinacion = -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar la coordinacion del usuario",StopSign!)
	close(this)
end if

end event

on w_rep_mat_preinsc_completo.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_periodo_anio=create uo_periodo_anio
this.cbx_todas=create cbx_todas
this.dw_rep_mat_preinsc=create dw_rep_mat_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_periodo_anio
this.Control[iCurrent+2]=this.cbx_todas
this.Control[iCurrent+3]=this.dw_rep_mat_preinsc
end on

on w_rep_mat_preinsc_completo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo_anio)
destroy(this.cbx_todas)
destroy(this.dw_rep_mat_preinsc)
end on

event close;call super::close;if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

end event

event resize;call super::resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_rep_mat_preinsc.height
	ll_height_win = this.height

	ll_height_tab = dw_rep_mat_preinsc.height
	ll_width_tab = dw_rep_mat_preinsc.width

	dw_rep_mat_preinsc.width = newwidth - 50
	dw_rep_mat_preinsc.height = newheight - 850
	
	ll_height_tab_final = dw_rep_mat_preinsc.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_rep_mat_preinsc.width = newwidth - 200
	dw_rep_mat_preinsc.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

type p_uia from w_ancestral`p_uia within w_rep_mat_preinsc_completo
end type

type uo_periodo_anio from uo_per_ani within w_rep_mat_preinsc_completo
event destroy ( )
integer x = 503
integer y = 88
integer width = 1253
integer height = 168
boolean enabled = true
long backcolor = 1090519039
end type

on uo_periodo_anio.destroy
call uo_per_ani::destroy
end on

type cbx_todas from checkbox within w_rep_mat_preinsc_completo
boolean visible = false
integer x = 1778
integer y = 108
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Todas"
boolean checked = true
boolean lefttext = true
end type

type dw_rep_mat_preinsc from uo_dw_reporte within w_rep_mat_preinsc_completo
event type integer carga ( )
integer x = 5
integer y = 412
integer width = 3538
integer height = 1436
integer taborder = 0
string dataobject = "d_sp_rep_mat_preinsc_coord"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
end type

event carga;/*
DESCRIPCIÓN: En base al tipo de materias que se quieran desplegar, arma el status y carga
				 las materias que lo cumplan.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
int li_status, li_cve_coordinacion
string ls_tit, ls_periodo, ls_periodo_anio
li_cve_coordinacion = ii_cve_coordinacion
ls_tit=''
li_status=0

CHOOSE CASE gi_periodo
	CASE 0
		ls_periodo = "PRIMAVERA"
	CASE 1
		ls_periodo = "VERANO"
	CASE 2
		ls_periodo = "OTOÑO"
	CASE ELSE
		ls_periodo = ""
END CHOOSE

//ls_tit=ls_tit+' '+string(gi_periodo)+' '+string(gi_anio)+'.'
ls_periodo_anio = ls_periodo+' '+string(gi_anio)+'.'
ls_tit=ls_tit+' '+ls_periodo_anio

if cbx_todas.checked then
	li_status=99
	ls_tit='Todas las materias solicitadas '+ls_periodo_anio
end if

event primero()
object.st_1.text=ls_tit
return retrieve(li_status,gi_periodo,gi_anio,li_cve_coordinacion)


end event

