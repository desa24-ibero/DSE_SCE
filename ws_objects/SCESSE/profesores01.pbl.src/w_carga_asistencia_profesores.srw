$PBExportHeader$w_carga_asistencia_profesores.srw
$PBExportComments$Captura de Asistencia y Faltas de Profesores
forward
global type w_carga_asistencia_profesores from w_ancestral
end type
type dw_captura_asistencia_profesores from uo_dw_captura within w_carga_asistencia_profesores
end type
type cb_2 from commandbutton within w_carga_asistencia_profesores
end type
type st_dia from statictext within w_carga_asistencia_profesores
end type
type ddlb_dia from dropdownlistbox within w_carga_asistencia_profesores
end type
type st_leyenda1 from statictext within w_carga_asistencia_profesores
end type
type ddlb_semanas from dropdownlistbox within w_carga_asistencia_profesores
end type
type st_periodo from statictext within w_carga_asistencia_profesores
end type
type st_anio from statictext within w_carga_asistencia_profesores
end type
type cb_asistencia from commandbutton within w_carga_asistencia_profesores
end type
type r_1 from rectangle within w_carga_asistencia_profesores
end type
end forward

global type w_carga_asistencia_profesores from w_ancestral
integer width = 3259
integer height = 2012
string title = "Carga Listas de Asistencia de Profesores"
string menuname = "m_menu"
dw_captura_asistencia_profesores dw_captura_asistencia_profesores
cb_2 cb_2
st_dia st_dia
ddlb_dia ddlb_dia
st_leyenda1 st_leyenda1
ddlb_semanas ddlb_semanas
st_periodo st_periodo
st_anio st_anio
cb_asistencia cb_asistencia
r_1 r_1
end type
global w_carga_asistencia_profesores w_carga_asistencia_profesores

type variables
int ii_anio, ii_periodo
end variables

on w_carga_asistencia_profesores.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_captura_asistencia_profesores=create dw_captura_asistencia_profesores
this.cb_2=create cb_2
this.st_dia=create st_dia
this.ddlb_dia=create ddlb_dia
this.st_leyenda1=create st_leyenda1
this.ddlb_semanas=create ddlb_semanas
this.st_periodo=create st_periodo
this.st_anio=create st_anio
this.cb_asistencia=create cb_asistencia
this.r_1=create r_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_captura_asistencia_profesores
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.st_dia
this.Control[iCurrent+4]=this.ddlb_dia
this.Control[iCurrent+5]=this.st_leyenda1
this.Control[iCurrent+6]=this.ddlb_semanas
this.Control[iCurrent+7]=this.st_periodo
this.Control[iCurrent+8]=this.st_anio
this.Control[iCurrent+9]=this.cb_asistencia
this.Control[iCurrent+10]=this.r_1
end on

on w_carga_asistencia_profesores.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_captura_asistencia_profesores)
destroy(this.cb_2)
destroy(this.st_dia)
destroy(this.ddlb_dia)
destroy(this.st_leyenda1)
destroy(this.ddlb_semanas)
destroy(this.st_periodo)
destroy(this.st_anio)
destroy(this.cb_asistencia)
destroy(this.r_1)
end on

event open;call super::open;string ls_descripcion_usuario, ls_titulo
integer li_coordinacion
integer li_periodo_mi, li_anio_mi

uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios

dw_captura_asistencia_profesores.settransobject(gtr_sce)
//dw_gen_lis_prd.settransobject(gtr_sce)
ls_descripcion_usuario= f_obten_descripcion_usuario()
li_coordinacion= f_obten_coordinacion()
ls_titulo = "Lista de Profesores generadas por "+ls_descripcion_usuario+" de la coordinacion "+string(li_coordinacion)

periodo_actual_mat_insc(li_periodo_mi, li_anio_mi, gtr_sce)

dw_captura_asistencia_profesores.DataObject = 'd_captura_listas_profesores'
dw_captura_asistencia_profesores.SetTransObject(gtr_sce)

this.Title = ls_titulo
if f_obten_periodo(ii_periodo, ii_anio, 1) = 1 then
	
	if ii_periodo<> li_periodo_mi or ii_anio<>li_anio_mi then
		dw_captura_asistencia_profesores.DataObject = 'd_captura_listas_profesores_hist'		
		dw_captura_asistencia_profesores.SetTransObject(gtr_sce)
	end if
	
	st_periodo.text = luo_periodo_servicios.f_recupera_desc_periodo(gtr_sce, ii_periodo)
	
	IF luo_periodo_servicios.ierror = -1 THEN 
		MessageBox(luo_periodo_servicios.ititulo, luo_periodo_servicios.imensaje, StopSign!)
		RETURN luo_periodo_servicios.ierror
	END IF	
	
//	choose case ii_periodo
//		case 0
//			st_periodo.text = "Primavera"
//		case 1
//			st_periodo.text = "Verano"
//		case 2
//			st_periodo.text = "Otoño"
//	end choose

	st_anio.text = string(ii_anio)
else
	MessageBox("Atención","No se pudo cargar el periodo de captura de listas de asistencia")
	Close(this)
end if
m_menu.m_archivo.m_imprimir.Visible = False
m_menu.m_archivo.m_imprimir.Enabled = False
m_menu.m_archivo.m_configurarimpresora.Visible = False
m_menu.m_archivo.m_configurarimpresora.Enabled = False
m_menu.m_registro.m_nuevo.Visible = False
m_menu.m_registro.m_nuevo.Enabled = False
m_menu.m_registro.m_borraregistro.Visible = False
m_menu.m_registro.m_borraregistro.Enabled = False

string ls_dias[8] 
int lia_dias[7]
string lsa_semanas[50,2]
date lda_descanso[64]
int li_i = 1, li_semana_actual[2]
ddlb_semanas.Reset()
ddlb_dia.Reset()
ls_dias = {"Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Todos"}
if f_llena_semanas(ii_periodo, ii_anio, lsa_semanas,lda_descanso,li_semana_actual) >= 0 then
	do while lsa_semanas[li_i,1] <> ""
		ddlb_semanas.AddItem(lsa_semanas[li_i,1])
		li_i ++
	loop
	if li_semana_actual[2] >= 1 AND li_semana_actual[2] <=4 then li_semana_actual[1]--
	ddlb_semanas.SelectItem(li_semana_actual[1])
	if li_semana_actual[1] <=0 then li_semana_actual[1] = 1
	f_dias_habiles_semana(date(lsa_semanas[li_semana_actual[1],2]),lia_dias,lda_descanso)
	for li_i = 1 to 7 
		if lia_dias[li_i] = 1 then ddlb_dia.AddItem(ls_dias[li_i])
	next
	ddlb_dia.AddItem(ls_dias[8])
else
	MessageBox("Atencion","No se puede leer el calendario escolar")
end if	
end event

type p_uia from w_ancestral`p_uia within w_carga_asistencia_profesores
end type

type dw_captura_asistencia_profesores from uo_dw_captura within w_carga_asistencia_profesores
integer x = 73
integer y = 576
integer width = 2578
integer height = 1132
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_captura_listas_profesores"
end type

event constructor;call super::constructor;SetTransObject(gtr_sce)
tr_dw_propio = gtr_sce
end event

event carga;integer value, li_cve_coordinacion, li_dia, li_num_regs, li_coordinacion, li_respuesta
string docname,named, ls_dia, ls_texto1, ls_texto2, ls_coordinacion, ls_mens_coord

//ls_texto1 = em_mens_1.Text

li_coordinacion= integer(ls_coordinacion)
li_cve_coordinacion = f_obten_coordinacion()

if li_cve_coordinacion <> 0 and li_cve_coordinacion <> 9999 then
	ls_mens_coord = "Se generó la lista de profesores de la coordinacion "&
	+string(li_cve_coordinacion)+" "
else
	ls_mens_coord ="Se generó la lista de profesores de todas las coordinaciones "
	li_cve_coordinacion = 9999
end if

//Lee los datos 
int lia_dias[7]
int li_no_semana, li_i
string lsa_semanas[8]
lsa_semanas = {"Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Todos"}
li_dia = 8
for li_i = 1 to 8 
	if ddlb_dia.text = lsa_semanas[li_i] then li_dia = li_i - 1
next

if li_dia = 7 then
	lia_dias = {0,1,2,3,4,5,6}
else
	lia_dias[1] = li_dia
end if

li_no_semana = ddlb_semanas.FindItem(ddlb_semanas.text,0)
li_num_regs= retrieve(ii_periodo, ii_anio, li_cve_coordinacion, lia_dias,li_no_semana)

if li_num_regs >0 then
	//Orientacion Landscape
	object.DataWindow.Print.Orientation =1
	object.DataWindow.Zoom = 90	
end if

li_respuesta= MessageBox("Información",ls_mens_coord)

return 0


end event

event rowfocuschanged;call super::rowfocuschanged;if GetRow() = RowCount() then
	return 1
else
	return 0
end if
end event

type cb_2 from commandbutton within w_carga_asistencia_profesores
integer x = 398
integer y = 412
integer width = 841
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Lista Profesores"
end type

event clicked;dw_captura_asistencia_profesores.event carga()
end event

type st_dia from statictext within w_carga_asistencia_profesores
integer x = 398
integer y = 256
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
boolean enabled = false
string text = "Dia Semana:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_dia from dropdownlistbox within w_carga_asistencia_profesores
integer x = 750
integer y = 256
integer width = 539
integer height = 732
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean sorted = false
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type st_leyenda1 from statictext within w_carga_asistencia_profesores
integer x = 393
integer y = 124
integer width = 361
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
boolean enabled = false
string text = "Semana:"
alignment alignment = center!
boolean focusrectangle = false
end type

type ddlb_semanas from dropdownlistbox within w_carga_asistencia_profesores
integer x = 745
integer y = 108
integer width = 2437
integer height = 652
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

event getfocus;//
string lsa_semanas[50,2]
date lda_descanso[64]
int li_i = 1, li_semana_actual[2]
Reset()
if f_llena_semanas(ii_periodo, ii_anio, lsa_semanas,lda_descanso,li_semana_actual) >= 0 then
	do while lsa_semanas[li_i,1] <> ""
		ddlb_semanas.AddItem(lsa_semanas[li_i,1])
		li_i ++
	loop
else
	MessageBox("Atencion","No se puede leer el calendario escolar")
end if	
//


end event

event selectionchanged;string lsa_semanas[50,2], ls_dias[8] 
date lda_descanso[64]
int lia_dias[7], li_i, li_semana_actual[2]

ls_dias = {"Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Todos"}
ddlb_dia.Reset()
if f_llena_semanas(ii_periodo, ii_anio, lsa_semanas,lda_descanso,li_semana_actual) >= 0  then
	f_dias_habiles_semana(date(lsa_semanas[index,2]),lia_dias,lda_descanso)
	for li_i = 1 to 7 
		if lia_dias[li_i] = 1 then ddlb_dia.AddItem(ls_dias[li_i])
	next
	ddlb_dia.AddItem(ls_dias[8])
else
	MessageBox("Atencion","No se puede leer el calendario escolar")
end if
	



end event

type st_periodo from statictext within w_carga_asistencia_profesores
integer x = 1202
integer y = 20
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_anio from statictext within w_carga_asistencia_profesores
integer x = 1824
integer y = 20
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_asistencia from commandbutton within w_carga_asistencia_profesores
integer x = 1317
integer y = 412
integer width = 741
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Asistencia a todos"
end type

event clicked;int li_i
if dw_captura_asistencia_profesores.RowCount() > 0 then
	if (messagebox("Atención","¿Quiere poner asistencia a todos los profesores?",StopSign!,YesNo!,2) = 1) then
		for li_i = 1 to dw_captura_asistencia_profesores.Rowcount()
			dw_captura_asistencia_profesores.SetItem(li_i,"cve_asistencia",4)
		next
		messagebox("Información","Los cambios se guardaran hasta que actualize")
	end if
end if

end event

type r_1 from rectangle within w_carga_asistencia_profesores
long linecolor = 255
integer linethickness = 3
long fillcolor = 255
integer x = 2999
integer y = 1596
integer width = 82
integer height = 76
end type

