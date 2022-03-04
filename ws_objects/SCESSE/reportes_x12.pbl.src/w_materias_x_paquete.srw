$PBExportHeader$w_materias_x_paquete.srw
forward
global type w_materias_x_paquete from w_ancestral
end type
type dw_materias_x_paquete from uo_dw_reporte within w_materias_x_paquete
end type
type em_paq from editmask within w_materias_x_paquete
end type
type st_1 from statictext within w_materias_x_paquete
end type
type uo_periodo from uo_periodo_variable_tipos within w_materias_x_paquete
end type
type em_1 from editmask within w_materias_x_paquete
end type
type st_2 from statictext within w_materias_x_paquete
end type
type ddlb_tipo_imp from dropdownlistbox within w_materias_x_paquete
end type
type gb_11 from groupbox within w_materias_x_paquete
end type
end forward

global type w_materias_x_paquete from w_ancestral
string title = "Reporte de Materias por Paquete"
string menuname = "m_menu"
dw_materias_x_paquete dw_materias_x_paquete
em_paq em_paq
st_1 st_1
uo_periodo uo_periodo
em_1 em_1
st_2 st_2
ddlb_tipo_imp ddlb_tipo_imp
gb_11 gb_11
end type
global w_materias_x_paquete w_materias_x_paquete

type variables
integer ii_tipo_imp, ii_num_resize = 0
end variables

on w_materias_x_paquete.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_materias_x_paquete=create dw_materias_x_paquete
this.em_paq=create em_paq
this.st_1=create st_1
this.uo_periodo=create uo_periodo
this.em_1=create em_1
this.st_2=create st_2
this.ddlb_tipo_imp=create ddlb_tipo_imp
this.gb_11=create gb_11
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_materias_x_paquete
this.Control[iCurrent+2]=this.em_paq
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.uo_periodo
this.Control[iCurrent+5]=this.em_1
this.Control[iCurrent+6]=this.st_2
this.Control[iCurrent+7]=this.ddlb_tipo_imp
this.Control[iCurrent+8]=this.gb_11
end on

on w_materias_x_paquete.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_materias_x_paquete)
destroy(this.em_paq)
destroy(this.st_1)
destroy(this.uo_periodo)
destroy(this.em_1)
destroy(this.st_2)
destroy(this.ddlb_tipo_imp)
destroy(this.gb_11)
end on

event open;call super::open;
// Se inicializa el objeto de periodos
THIS.uo_periodo.of_inicializa_servicio( "V", "L", "L", "N", gtr_sce)

dw_materias_x_paquete.settransobject(gtr_sce)
ddlb_tipo_imp.selectitem(2)
end event

event resize;call super::resize;long ll_height_win, ll_height_dw, ll_dif_height_tab, ll_height_tab, ll_width_tab, ll_height_tab_final

if ii_num_resize > 0 then
	ll_height_dw = dw_materias_x_paquete.height
	ll_height_win = this.height

	ll_height_tab = dw_materias_x_paquete.height
	ll_width_tab = dw_materias_x_paquete.width

	dw_materias_x_paquete.width = newwidth - 50
	dw_materias_x_paquete.height = newheight - 450
	
	ll_height_tab_final = dw_materias_x_paquete.height
	
	ll_dif_height_tab = ll_height_tab_final - ll_height_tab  

	dw_materias_x_paquete.width = newwidth - 200
	dw_materias_x_paquete.height = ll_height_dw + ll_dif_height_tab
else
	ii_num_resize = ii_num_resize +1
end if
end event

type p_uia from w_ancestral`p_uia within w_materias_x_paquete
end type

type dw_materias_x_paquete from uo_dw_reporte within w_materias_x_paquete
integer x = 5
integer y = 420
integer width = 3355
integer height = 1652
string dataobject = "d_materias_x_paquete"
boolean hscrollbar = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
INTEGER le_index
INTEGER periodo_x[] 
STRING ls_tipo_periodo[]
STRING ls_descripcion_periodo
INTEGER le_anio
STRING ls_titulo

PARENT.uo_periodo.of_recupera_periodos() 


FOR le_index = 1 TO UPPERBOUND(PARENT.uo_periodo.istr_periodos[])
	IF TRIM(ls_descripcion_periodo) <> "" THEN ls_descripcion_periodo = ls_descripcion_periodo + ", "
	ls_descripcion_periodo = ls_descripcion_periodo + PARENT.uo_periodo.istr_periodos[le_index].descripcion 
	periodo_x[le_index] = PARENT.uo_periodo.istr_periodos[le_index].periodo
	ls_tipo_periodo[le_index] = PARENT.uo_periodo.istr_periodos[le_index].tipo
NEXT 	
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**		
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
le_anio = INTEGER(em_1.TEXT) 

IF ii_tipo_imp = 0 THEN ii_tipo_imp = 1 // 1 = Tradicional	

event primero()
IF integer(em_paq.text) > 0 THEN
	IF retrieve(integer(em_paq.text), periodo_x[], le_anio,ii_tipo_imp) > 0 THEN 
		ls_titulo =  "Reporte del paquete # " + string( em_paq.text ) + " de materias de Primer Ingreso para " + ls_descripcion_periodo + " " + em_1.TEXT
		THIS.MODIFY("t_titulo.text = '" + ls_titulo + "'") 	
	ELSE
		THIS.MODIFY("t_titulo.text = ' ' ") 	
		This.reset( )
	END IF
ELSE
	THIS.MODIFY("t_titulo.text = ' ' ") 	
	This.reset( )
	RETURN 0
END IF

RETURN THIS.ROWCOUNT() 







end event

type em_paq from editmask within w_materias_x_paquete
integer x = 2085
integer y = 276
integer width = 247
integer height = 100
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "0##"
string displaydata = ""
end type

type st_1 from statictext within w_materias_x_paquete
integer x = 1815
integer y = 168
integer width = 837
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 134217730
boolean enabled = false
string text = "Paquete de Primer Ingreso:"
boolean focusrectangle = false
end type

type uo_periodo from uo_periodo_variable_tipos within w_materias_x_paquete
integer x = 777
integer y = 36
integer height = 356
integer taborder = 40
boolean bringtotop = true
long backcolor = 134217730
end type

on uo_periodo.destroy
call uo_periodo_variable_tipos::destroy
end on

type em_1 from editmask within w_materias_x_paquete
integer x = 475
integer y = 96
integer width = 215
integer height = 80
integer taborder = 96
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

type st_2 from statictext within w_materias_x_paquete
integer x = 1815
integer y = 44
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

type ddlb_tipo_imp from dropdownlistbox within w_materias_x_paquete
integer x = 2322
integer y = 36
integer width = 549
integer height = 384
integer taborder = 132
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

type gb_11 from groupbox within w_materias_x_paquete
integer x = 425
integer y = 36
integer width = 315
integer height = 160
integer taborder = 92
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

