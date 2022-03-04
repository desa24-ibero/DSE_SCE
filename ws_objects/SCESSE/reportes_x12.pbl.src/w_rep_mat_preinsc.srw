$PBExportHeader$w_rep_mat_preinsc.srw
$PBExportComments$Reporte de materias preinscritas
forward
global type w_rep_mat_preinsc from w_ancestral
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
type uo_periodo from uo_periodo_variable_tipos within w_rep_mat_preinsc
end type
type em_anio from editmask within w_rep_mat_preinsc
end type
type st_2 from statictext within w_rep_mat_preinsc
end type
type ddlb_tipo_imp from dropdownlistbox within w_rep_mat_preinsc
end type
type gb_11 from groupbox within w_rep_mat_preinsc
end type
end forward

global type w_rep_mat_preinsc from w_ancestral
boolean visible = false
integer width = 3959
integer height = 2076
string title = "Demanda de Materias"
string menuname = "m_menu"
cbx_todas cbx_todas
cbx_no_curso cbx_no_curso
cbx_e_plan cbx_e_plan
cbx_e_grupo cbx_e_grupo
cbx_e_mat cbx_e_mat
dw_rep_mat_preinsc dw_rep_mat_preinsc
uo_periodo uo_periodo
em_anio em_anio
st_2 st_2
ddlb_tipo_imp ddlb_tipo_imp
gb_11 gb_11
end type
global w_rep_mat_preinsc w_rep_mat_preinsc

type variables
transaction itr_web
integer ii_tipo_imp, ii_num_resize = 0
STRING is_descripcion_periodo
end variables

event open;call super::open;/*
DESCRIPCIÓN: Pon la ventana en el extremo. Liga dw_rep_mat_preinsc a sce.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/


// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)


x=1
y=1

//if conecta_bd(itr_web,"SWEB", "preinsce","futuro")<>1 then
if conecta_bd(itr_web,gs_sweb, gs_usuario, gs_password)<>1 then
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	close(this)
	RETURN 1
else 
	dw_rep_mat_preinsc.SetTransObject(itr_web)
end if

ddlb_tipo_imp.selectitem(2)
//dw_rep_mat_preinsc.settransobject(gtr_sce)
end event

on w_rep_mat_preinsc.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cbx_todas=create cbx_todas
this.cbx_no_curso=create cbx_no_curso
this.cbx_e_plan=create cbx_e_plan
this.cbx_e_grupo=create cbx_e_grupo
this.cbx_e_mat=create cbx_e_mat
this.dw_rep_mat_preinsc=create dw_rep_mat_preinsc
this.uo_periodo=create uo_periodo
this.em_anio=create em_anio
this.st_2=create st_2
this.ddlb_tipo_imp=create ddlb_tipo_imp
this.gb_11=create gb_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_todas
this.Control[iCurrent+2]=this.cbx_no_curso
this.Control[iCurrent+3]=this.cbx_e_plan
this.Control[iCurrent+4]=this.cbx_e_grupo
this.Control[iCurrent+5]=this.cbx_e_mat
this.Control[iCurrent+6]=this.dw_rep_mat_preinsc
this.Control[iCurrent+7]=this.uo_periodo
this.Control[iCurrent+8]=this.em_anio
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.ddlb_tipo_imp
this.Control[iCurrent+11]=this.gb_11
end on

on w_rep_mat_preinsc.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_todas)
destroy(this.cbx_no_curso)
destroy(this.cbx_e_plan)
destroy(this.cbx_e_grupo)
destroy(this.cbx_e_mat)
destroy(this.dw_rep_mat_preinsc)
destroy(this.uo_periodo)
destroy(this.em_anio)
destroy(this.st_2)
destroy(this.ddlb_tipo_imp)
destroy(this.gb_11)
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
	dw_rep_mat_preinsc.height = newheight - 450
	
	ll_height_tab_final = dw_rep_mat_preinsc.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_rep_mat_preinsc.width = newwidth - 200
	dw_rep_mat_preinsc.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

type p_uia from w_ancestral`p_uia within w_rep_mat_preinsc
end type

type cbx_todas from checkbox within w_rep_mat_preinsc
boolean visible = false
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
boolean checked = true
boolean lefttext = true
end type

type cbx_no_curso from checkbox within w_rep_mat_preinsc
boolean visible = false
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
boolean visible = false
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
boolean visible = false
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
boolean visible = false
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
integer width = 3803
integer height = 1436
integer taborder = 0
string title = "Demanda de Materias"
string dataobject = "d_sp_rep_mat_preinscr"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = styleraised!
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

//CHOOSE CASE gi_periodo
//	CASE 0
//		ls_periodo = "PRIMAVERA"
//	CASE 1
//		ls_periodo = "VERANO"
//	CASE 2
//		ls_periodo = "OTOÑO"
//	CASE ELSE
//		ls_periodo = ""
//END CHOOSE
//
//
////ls_tit=ls_tit+' '+string(gi_periodo)+' '+string(gi_anio)+'.'
//ls_periodo_anio = ls_periodo+' '+string(gi_anio)+'.'
//ls_tit=ls_tit+' '+ls_periodo_anio

INTEGER le_anio
if cbx_todas.checked then
	li_status=99
	ls_tit='Todas las materias solicitadas '
end if
li_status= 99
event primero()

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER le_periodo[], periodo_x[] 
STRING ls_tipo_periodo[]
//STRING is_descripcion_periodo

DATASTORE lds_paso
lds_paso = CREATE DATASTORE 
lds_paso.DATAOBJECT = THIS.DATAOBJECT
lds_paso.SETTRANSOBJECT(itr_web)


le_anio = INTEGER(em_anio.TEXT)

PARENT.uo_periodo.of_recupera_periodos() 

IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional	

periodo_x[] = le_periodo[]
is_descripcion_periodo = ""
This.reset( )
ls_tit = ''

FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(is_descripcion_periodo) <> "" THEN is_descripcion_periodo = is_descripcion_periodo + ", "
	is_descripcion_periodo = is_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
	
	lds_paso.RESET() 
	IF lds_paso.retrieve(li_status,periodo_x[le_index],le_anio, ii_tipo_imp) > 0 THEN 
		lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, dw_rep_mat_preinsc, dw_rep_mat_preinsc.ROWCOUNT() + 1, PRIMARY!)
//	ELSE
//		This.reset( )
//		ls_tit = ''
	END IF
NEXT 	

ls_tit = Trim(ls_tit) + ' ' + is_descripcion_periodo + ' ' + STRING(le_anio) 
object.st_1.text=ls_tit

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
//return retrieve(li_status,gi_periodo,gi_anio)

RETURN 0





end event

type uo_periodo from uo_periodo_variable_tipos within w_rep_mat_preinsc
integer x = 951
integer y = 60
integer height = 324
integer taborder = 50
boolean bringtotop = true
long backcolor = 134217730
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type em_anio from editmask within w_rep_mat_preinsc
integer x = 631
integer y = 112
integer width = 215
integer height = 80
integer taborder = 106
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "yyyy"
string displaydata = "`"
end type

event constructor;TabOrder = 0

int periodo,anio
periodo_actual(periodo,anio,gtr_sce)

this.text = string(anio)
end event

event modified;long fecha

fecha = long(this.text)
if fecha < 1900 then
   messagebox ("Información", "El año DEBE ser mayor a 1900")
	this.SelectText(1, Len(this.Text))
	this.setfocus()
end if
end event

type st_2 from statictext within w_rep_mat_preinsc
integer x = 1893
integer y = 80
integer width = 498
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 134217730
string text = "Tipo impartición:"
boolean focusrectangle = false
end type

type ddlb_tipo_imp from dropdownlistbox within w_rep_mat_preinsc
integer x = 2400
integer y = 72
integer width = 549
integer height = 384
integer taborder = 122
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 12639424
boolean vscrollbar = true
string item[] = {"Tradicional","Modular"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;String ls_descripcion

IF Lower(This.text) = 'modular' THEN
	ii_tipo_imp = 2 
ELSE
	ii_tipo_imp = 1 // 1 = Tradicional
END IF
end event

type gb_11 from groupbox within w_rep_mat_preinsc
integer x = 585
integer y = 52
integer width = 315
integer height = 160
integer taborder = 50
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 134217730
string text = "Año"
borderstyle borderstyle = styleraised!
end type

