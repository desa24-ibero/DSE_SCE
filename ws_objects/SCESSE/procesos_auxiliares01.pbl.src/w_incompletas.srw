$PBExportHeader$w_incompletas.srw
forward
global type w_incompletas from w_ancestral
end type
type cb_proceso from commandbutton within w_incompletas
end type
type uo_1 from uo_per_ani within w_incompletas
end type
type dw_historico_incompletas from uo_dw_reporte within w_incompletas
end type
type st_anio_periodo from statictext within w_incompletas
end type
type rb_servicio_social from radiobutton within w_incompletas
end type
type rb_otras from radiobutton within w_incompletas
end type
type dw_banderas_incompletas from datawindow within w_incompletas
end type
type gb_1 from groupbox within w_incompletas
end type
end forward

global type w_incompletas from w_ancestral
integer width = 3474
integer height = 2584
string title = "Vencimiento de Incompletas"
string menuname = "m_menu"
long backcolor = 10789024
cb_proceso cb_proceso
uo_1 uo_1
dw_historico_incompletas dw_historico_incompletas
st_anio_periodo st_anio_periodo
rb_servicio_social rb_servicio_social
rb_otras rb_otras
dw_banderas_incompletas dw_banderas_incompletas
gb_1 gb_1
end type
global w_incompletas w_incompletas

type variables
uo_periodo_servicios iuo_periodo_servicios 


end variables

forward prototypes
public function string wf_recupera_materias_ss ()
end prototypes

public function string wf_recupera_materias_ss ();
STRING ls_sql, ls_retorno 
DATASTORE lds_materias
INTEGER le_total , le_pos

LONG ll_cve_mat

ls_sql = " SELECT DISTINCT cve_mat " + &
			" FROM area_mat  " + &
			" WHERE cve_area IN(SELECT cve_area_servicio_social FROM plan_estudios) " 
			
lds_materias = CREATE DATASTORE 
lds_materias.DATAOBJECT= "dw_lista_matrerias_ss" 
lds_materias.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
lds_materias.SETTRANSOBJECT(gtr_sce) 
le_total = lds_materias.RETRIEVE() 
IF le_total < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar las materias de Servicio Social :" + gtr_sce.SQLERRTEXT) 
	RETURN "" 
END IF 

// Se genera la cedana de materias de Servicio Social. 
FOR le_pos = 1 TO le_total 
	
	ll_cve_mat = lds_materias.GETITEMNUMBER(le_pos, "cve_mat")
	IF ISNULL(ll_cve_mat) THEN ll_cve_mat = 0 
	
	IF LEN(TRIM(ls_retorno)) > 0 THEN ls_retorno = ls_retorno + ", " 
	ls_retorno = ls_retorno + STRING(ll_cve_mat)
	
NEXT 

RETURN ls_retorno 





end function

on w_incompletas.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_proceso=create cb_proceso
this.uo_1=create uo_1
this.dw_historico_incompletas=create dw_historico_incompletas
this.st_anio_periodo=create st_anio_periodo
this.rb_servicio_social=create rb_servicio_social
this.rb_otras=create rb_otras
this.dw_banderas_incompletas=create dw_banderas_incompletas
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_proceso
this.Control[iCurrent+2]=this.uo_1
this.Control[iCurrent+3]=this.dw_historico_incompletas
this.Control[iCurrent+4]=this.st_anio_periodo
this.Control[iCurrent+5]=this.rb_servicio_social
this.Control[iCurrent+6]=this.rb_otras
this.Control[iCurrent+7]=this.dw_banderas_incompletas
this.Control[iCurrent+8]=this.gb_1
end on

on w_incompletas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_proceso)
destroy(this.uo_1)
destroy(this.dw_historico_incompletas)
destroy(this.st_anio_periodo)
destroy(this.rb_servicio_social)
destroy(this.rb_otras)
destroy(this.dw_banderas_incompletas)
destroy(this.gb_1)
end on

event open;call super::open;	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)


end event

type p_uia from w_ancestral`p_uia within w_incompletas
boolean visible = false
integer width = 128
integer height = 140
boolean enabled = false
end type

type cb_proceso from commandbutton within w_incompletas
integer x = 818
integer y = 144
integer width = 1138
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Poner NA o 5"
end type

event clicked;int li_i, li_cve_flag_serv_social=1
long ll_row_banderas, ll_num_rows_banderas
setpointer(Hourglass!)
for li_i = 1 to dw_historico_incompletas.RowCount()
	if Mid(dw_historico_incompletas.GetItemString(li_i,"materias_evaluacion"),1,2) = "NU" then
		dw_historico_incompletas.SetItem(li_i,"historico_calificacion","5")
	else
		dw_historico_incompletas.SetItem(li_i,"historico_calificacion","NA")
	end if
next
if rb_servicio_social.checked then
	ll_num_rows_banderas = dw_banderas_incompletas.RowCount()
	FOR ll_row_banderas= 1 TO ll_num_rows_banderas
		dw_banderas_incompletas.SetItem(ll_row_banderas,"banderas_cve_flag_serv_social",li_cve_flag_serv_social)
	NEXT 
end if
IF rb_servicio_social.checked THEN
	if dw_historico_incompletas.Update() = 1 AND dw_banderas_incompletas.Update() =1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
	else
		rollback using gtr_sce;
		MessageBox("Atención","Los cambios no se han guardado")
	end if
ELSE
	if dw_historico_incompletas.Update() = 1 then
		commit using gtr_sce;
		MessageBox("Atención","Se han guardado los cambios")
	else
		rollback using gtr_sce;
		MessageBox("Atención","Los cambios no se han guardado")
	end if
END IF

setpointer(Arrow!)
Enabled = false
end event

type uo_1 from uo_per_ani within w_incompletas
integer x = 2062
integer y = 124
integer width = 1253
integer height = 168
integer taborder = 20
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_historico_incompletas from uo_dw_reporte within w_incompletas
integer x = 55
integer y = 380
integer width = 3278
integer height = 1104
integer taborder = 10
string dataobject = "d_historico_incompletas"
boolean hscrollbar = true
boolean border = true
end type

event carga;integer li_periodo, li_anio
string ls_periodo

st_anio_periodo.text = "Materias incompletas hasta "

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	li_anio=Integer(uo_1.em_ani.text) 
	li_periodo=uo_1.iuo_periodo_servicios.f_recupera_id(uo_1.em_per.text, "L")

st_anio_periodo.text += uo_1.iuo_periodo_servicios.f_recupera_descripcion(li_periodo , "L")

/*
choose case gi_periodo
	case 0
		st_anio_periodo.text += "Primavera"
	case 1
		st_anio_periodo.text += "Verano"
	case 2
		st_anio_periodo.text += "Otoño"
end choose
*/

st_anio_periodo.text += " de "+string(gi_anio)
dw_historico_incompletas.object.compute_1.expression="'"+st_anio_periodo.text+"'"

return retrieve(li_anio,li_periodo,gs_tipo_periodo)

end event

event constructor;call super::constructor;SetTransObject(gtr_sce)
end event

event retrieveend;call super::retrieveend;cb_proceso.Enabled = true
end event

type st_anio_periodo from statictext within w_incompletas
integer x = 832
integer y = 296
integer width = 1742
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
long bordercolor = 10789024
boolean focusrectangle = false
end type

type rb_servicio_social from radiobutton within w_incompletas
integer x = 160
integer y = 220
integer width = 521
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Servicio Social"
boolean automatic = false
end type

event clicked;integer li_banderas

STRING ls_mat_ss 
ls_mat_ss = wf_recupera_materias_ss()

dw_historico_incompletas.Reset()
//dw_historico_incompletas.SetFilter("historico_cve_mat IN (8763,3748)")
dw_historico_incompletas.SetFilter("historico_cve_mat IN (" + ls_mat_ss + ")") 
dw_historico_incompletas.event carga()
li_banderas= dw_banderas_incompletas.Retrieve(gi_anio, gi_periodo, gs_tipo_periodo)
rb_otras.checked = false
checked = true

end event

type rb_otras from radiobutton within w_incompletas
integer x = 160
integer y = 112
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Otras"
boolean automatic = false
end type

event clicked;
STRING ls_mat_ss 
ls_mat_ss = wf_recupera_materias_ss()

dw_historico_incompletas.Reset()
//dw_historico_incompletas.SetFilter("historico_cve_mat NOT IN (8763,3748)")
dw_historico_incompletas.SetFilter("historico_cve_mat NOT IN (" + ls_mat_ss + ")")
dw_historico_incompletas.event carga()
rb_servicio_social.checked = false
checked = true

end event

type dw_banderas_incompletas from datawindow within w_incompletas
integer x = 64
integer y = 1496
integer width = 3282
integer height = 816
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string title = "none"
string dataobject = "d_banderas_incompletas"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;SetTransObject(gtr_sce)
end event

type gb_1 from groupbox within w_incompletas
integer x = 128
integer y = 12
integer width = 567
integer height = 328
integer taborder = 1
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
string text = "Materias"
end type

