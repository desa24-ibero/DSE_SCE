$PBExportHeader$w_rep_mat_preinsc.srw
$PBExportComments$Reporte de materias preinscritas
forward
global type w_rep_mat_preinsc from w_ancestral
end type
type uo_periodo_anio from uo_per_ani within w_rep_mat_preinsc
end type
type cbx_todas from checkbox within w_rep_mat_preinsc
end type
type cbx_no_curso from checkbox within w_rep_mat_preinsc
end type
type cbx_e_plan from checkbox within w_rep_mat_preinsc
end type
type cbx_e_grupo from checkbox within w_rep_mat_preinsc
end type
type cbx_e_mat from checkbox within w_rep_mat_preinsc
end type
type dw_rep_mat_preinsc from uo_dw_reporte within w_rep_mat_preinsc
end type
end forward

global type w_rep_mat_preinsc from w_ancestral
integer width = 3611
integer height = 2076
string title = "Reporte de Materias Preinscritas"
string menuname = "m_menu"
uo_periodo_anio uo_periodo_anio
cbx_todas cbx_todas
cbx_no_curso cbx_no_curso
cbx_e_plan cbx_e_plan
cbx_e_grupo cbx_e_grupo
cbx_e_mat cbx_e_mat
dw_rep_mat_preinsc dw_rep_mat_preinsc
end type
global w_rep_mat_preinsc w_rep_mat_preinsc

type variables
transaction itr_web

uo_periodo_servicios iuo_periodo_servicios
end variables

event open;call super::open;/*
DESCRIPCIÓN: Pon la ventana en el extremo. Liga dw_rep_mat_preinsc a sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
x=1
y=1

iuo_periodo_servicios = CREATE uo_periodo_servicios
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

periodo_actual(gi_periodo,gi_anio,gtr_sce)

//iuo_periodo_servicios.f_recupera_periodo_siguiente( gi_periodo, gi_anio, gtr_sce )

uo_periodo_anio.em_ani.text = string(gi_anio) 
uo_periodo_anio.em_per.text = string(gi_periodo) 


//if conecta_bd(itr_web,gs_sweb, "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb, gs_usuario, gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
else 
	dw_rep_mat_preinsc.SetTransObject(itr_web)
end if


//dw_rep_mat_preinsc.settransobject(gtr_sce)
end event

on w_rep_mat_preinsc.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_periodo_anio=create uo_periodo_anio
this.cbx_todas=create cbx_todas
this.cbx_no_curso=create cbx_no_curso
this.cbx_e_plan=create cbx_e_plan
this.cbx_e_grupo=create cbx_e_grupo
this.cbx_e_mat=create cbx_e_mat
this.dw_rep_mat_preinsc=create dw_rep_mat_preinsc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_periodo_anio
this.Control[iCurrent+2]=this.cbx_todas
this.Control[iCurrent+3]=this.cbx_no_curso
this.Control[iCurrent+4]=this.cbx_e_plan
this.Control[iCurrent+5]=this.cbx_e_grupo
this.Control[iCurrent+6]=this.cbx_e_mat
this.Control[iCurrent+7]=this.dw_rep_mat_preinsc
end on

on w_rep_mat_preinsc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_periodo_anio)
destroy(this.cbx_todas)
destroy(this.cbx_no_curso)
destroy(this.cbx_e_plan)
destroy(this.cbx_e_grupo)
destroy(this.cbx_e_mat)
destroy(this.dw_rep_mat_preinsc)
end on

event close;call super::close;if isvalid(itr_web) then
	if desconecta_bd(itr_web) <> 1 then
		return
	end if
end if

end event

type p_uia from w_ancestral`p_uia within w_rep_mat_preinsc
end type

type uo_periodo_anio from uo_per_ani within w_rep_mat_preinsc
event destroy ( )
integer x = 434
integer y = 60
integer width = 1253
integer height = 168
boolean enabled = true
long backcolor = 1090519039
end type

on uo_periodo_anio.destroy
call uo_per_ani::destroy
end on

type cbx_todas from checkbox within w_rep_mat_preinsc
integer x = 2414
integer y = 160
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Todas"
boolean lefttext = true
end type

type cbx_no_curso from checkbox within w_rep_mat_preinsc
integer x = 1765
integer y = 160
integer width = 539
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "No la ha Cursado"
boolean checked = true
boolean lefttext = true
end type

type cbx_e_plan from checkbox within w_rep_mat_preinsc
integer x = 2853
integer y = 44
integer width = 471
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Existe en Plan"
boolean checked = true
boolean lefttext = true
end type

type cbx_e_grupo from checkbox within w_rep_mat_preinsc
integer x = 2327
integer y = 44
integer width = 434
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Existe Grupo"
boolean checked = true
boolean lefttext = true
end type

type cbx_e_mat from checkbox within w_rep_mat_preinsc
integer x = 1801
integer y = 44
integer width = 466
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Existe Materia"
boolean checked = true
boolean lefttext = true
end type

type dw_rep_mat_preinsc from uo_dw_reporte within w_rep_mat_preinsc
event type integer carga ( )
integer x = 5
integer y = 412
integer width = 3538
integer height = 1436
integer taborder = 0
string dataobject = "d_sp_rep_mat_preinsc"
boolean hscrollbar = true
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
int li_status
string ls_tit, ls_periodo, ls_periodo_anio

ls_tit=''
li_status=0
if cbx_e_mat.checked then
	li_status=1
	ls_tit='Existe la Materia'
end if

if cbx_e_grupo.checked then
	li_status=li_status+2
	if ls_tit<>'' then
		ls_tit=ls_tit+', '
	end if
	ls_tit=ls_tit+'Existe el Grupo'
end if

if cbx_e_plan.checked then
	li_status=li_status+4
	if ls_tit<>'' then
		ls_tit=ls_tit+', '
	end if
	ls_tit=ls_tit+'Pertenece al plan'
end if

if cbx_no_curso.checked then
	li_status=li_status+8
	if ls_tit<>'' then
		ls_tit=ls_tit+', '
	end if
	ls_tit=ls_tit+'No se ha cursado'
end if

ls_periodo = iuo_periodo_servicios.f_recupera_descripcion( gi_periodo, "L")

/*
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
*/

//ls_tit=ls_tit+' '+string(gi_periodo)+' '+string(gi_anio)+'.'
ls_periodo_anio = ls_periodo+' '+string(gi_anio)+'.'
ls_tit = ls_tit + ' ' + ls_periodo_anio 

if cbx_todas.checked then
	li_status=99
	ls_tit='Todas las materias solicitadas '+ls_periodo_anio
end if

event primero()
object.st_1.text=ls_tit
return retrieve(li_status,gi_periodo,gi_anio)





end event

