$PBExportHeader$w_genera_lista_prof_nvo.srw
forward
global type w_genera_lista_prof_nvo from w_ancestral
end type
type cb_2 from commandbutton within w_genera_lista_prof_nvo
end type
type em_mens_2 from editmask within w_genera_lista_prof_nvo
end type
type st_dia from statictext within w_genera_lista_prof_nvo
end type
type st_leyenda1 from statictext within w_genera_lista_prof_nvo
end type
type dw_lista_profesores from uo_dw_reporte within w_genera_lista_prof_nvo
end type
type ddlb_semanas from dropdownlistbox within w_genera_lista_prof_nvo
end type
type cb_crea from commandbutton within w_genera_lista_prof_nvo
end type
type ddlb_dia from dropdownlistbox within w_genera_lista_prof_nvo
end type
type st_periodo from statictext within w_genera_lista_prof_nvo
end type
type st_anio from statictext within w_genera_lista_prof_nvo
end type
type rr_1 from roundrectangle within w_genera_lista_prof_nvo
end type
end forward

global type w_genera_lista_prof_nvo from w_ancestral
integer width = 3817
integer height = 2380
string menuname = "m_menu_impresion"
cb_2 cb_2
em_mens_2 em_mens_2
st_dia st_dia
st_leyenda1 st_leyenda1
dw_lista_profesores dw_lista_profesores
ddlb_semanas ddlb_semanas
cb_crea cb_crea
ddlb_dia ddlb_dia
st_periodo st_periodo
st_anio st_anio
rr_1 rr_1
end type
global w_genera_lista_prof_nvo w_genera_lista_prof_nvo

type variables
int ii_anio, ii_periodo
uo_periodo_servicios iuo_periodo_servicios
end variables

on w_genera_lista_prof_nvo.create
int iCurrent
call super::create
if this.MenuName = "m_menu_impresion" then this.MenuID = create m_menu_impresion
this.cb_2=create cb_2
this.em_mens_2=create em_mens_2
this.st_dia=create st_dia
this.st_leyenda1=create st_leyenda1
this.dw_lista_profesores=create dw_lista_profesores
this.ddlb_semanas=create ddlb_semanas
this.cb_crea=create cb_crea
this.ddlb_dia=create ddlb_dia
this.st_periodo=create st_periodo
this.st_anio=create st_anio
this.rr_1=create rr_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.em_mens_2
this.Control[iCurrent+3]=this.st_dia
this.Control[iCurrent+4]=this.st_leyenda1
this.Control[iCurrent+5]=this.dw_lista_profesores
this.Control[iCurrent+6]=this.ddlb_semanas
this.Control[iCurrent+7]=this.cb_crea
this.Control[iCurrent+8]=this.ddlb_dia
this.Control[iCurrent+9]=this.st_periodo
this.Control[iCurrent+10]=this.st_anio
this.Control[iCurrent+11]=this.rr_1
end on

on w_genera_lista_prof_nvo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.em_mens_2)
destroy(this.st_dia)
destroy(this.st_leyenda1)
destroy(this.dw_lista_profesores)
destroy(this.ddlb_semanas)
destroy(this.cb_crea)
destroy(this.ddlb_dia)
destroy(this.st_periodo)
destroy(this.st_anio)
destroy(this.rr_1)
end on

event open;call super::open;string ls_descripcion_usuario, ls_titulo
integer li_coordinacion

//This.m_menu_impresion.m_cargaregistro.enabled = false

dw_lista_profesores.settransobject(gtr_sce)
ls_descripcion_usuario= f_obten_descripcion_usuario()
li_coordinacion= f_obten_coordinacion()
ls_titulo = "Lista de Profesores generadas por "+ls_descripcion_usuario+" de la coordinacion "+string(li_coordinacion)

this.Title = ls_titulo


if f_obten_periodo(ii_periodo, ii_anio, 1) = 1 then
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
	st_periodo.text = iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")

/*choose case ii_periodo
		case 0
			st_periodo.text = "Primavera"
		case 1
			st_periodo.text = "Verano"
		case 2
			st_periodo.text = "Otoño"
	end choose
*/

	st_anio.text = string(ii_anio) 
else
	MessageBox("Atención","No se pudo cargar el periodo de captura de listas de asistencia")
	Close(this)
end if


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
	if li_semana_actual[2] >= 4 AND li_semana_actual[2] <=7 then li_semana_actual[1]++
	ddlb_semanas.SelectItem(li_semana_actual[1])
	//MessageBox("",string(li_semana_actual[1])+" "+string(li_semana_actual[2]))
	f_dias_habiles_semana(date(lsa_semanas[li_semana_actual[1],2]),lia_dias,lda_descanso)
	for li_i = 1 to 7 
		if lia_dias[li_i] = 1 then ddlb_dia.AddItem(ls_dias[li_i])
	next
	ddlb_dia.AddItem(ls_dias[8])
else
	MessageBox("Atencion","No se puede leer el calendario escolar")
end if	


	
	



end event

type p_uia from w_ancestral`p_uia within w_genera_lista_prof_nvo
end type

type cb_2 from commandbutton within w_genera_lista_prof_nvo
event clicked pbm_bnclicked
integer x = 434
integer y = 612
integer width = 841
integer height = 104
integer taborder = 60
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Lista Profesores"
end type

event clicked;dw_lista_profesores.event carga()
end event

type em_mens_2 from editmask within w_genera_lista_prof_nvo
integer x = 439
integer y = 500
integer width = 2885
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "LEYENDA"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
end type

type st_dia from statictext within w_genera_lista_prof_nvo
integer x = 466
integer y = 396
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

type st_leyenda1 from statictext within w_genera_lista_prof_nvo
integer x = 475
integer y = 284
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

type dw_lista_profesores from uo_dw_reporte within w_genera_lista_prof_nvo
integer x = 87
integer y = 800
integer width = 3575
integer height = 1316
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_listas_profesores"
boolean hscrollbar = true
boolean resizable = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;integer li_cve_coordinacion, li_num_regs
string  ls_mens_coord


li_cve_coordinacion = f_obten_coordinacion()

if li_cve_coordinacion <> 0 and li_cve_coordinacion <> 9999 then
	ls_mens_coord = "Se generó la lista de profesores de la coordinacion "&
	+string(li_cve_coordinacion)+" "
else
	ls_mens_coord ="Se generó la lista de profesores de todas las coordinaciones "
	li_cve_coordinacion = 9999
end if

object.st_leyenda1.text =ddlb_semanas.text//ls_texto1
object.st_leyenda2.text = em_mens_2.Text

//Lee los datos 
int lia_dias[7],li_dia
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

MessageBox("Información",ls_mens_coord)
return 0


end event

event clicked;//
end event

event rbuttondown;//
end event

type ddlb_semanas from dropdownlistbox within w_genera_lista_prof_nvo
integer x = 887
integer y = 280
integer width = 2437
integer height = 652
integer taborder = 20
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

event selectionchanged;string lsa_semanas[50,2], ls_dias[8] 
date lda_descanso[64]
int lia_dias[7], li_i,li_semana_actual[2]

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

type cb_crea from commandbutton within w_genera_lista_prof_nvo
integer x = 1349
integer y = 612
integer width = 471
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Crea"
end type

event clicked;string ls_errtext
int li_i, lia_dias[7]
int li_no_semana
string lsa_semanas[8]
date ld_fch_entsal


lsa_semanas = {"Domingo","Lunes","Martes","Miercoles","Jueves","Viernes","Sabado","Todos"}
for li_i = 1 to 7 
	if ddlb_dia.text = lsa_semanas[li_i] then
		lia_dias[li_i] = 1
	else
		lia_dias[li_i] = 0
	end if
next
if ddlb_dia.text = lsa_semanas[8] then
	for li_i = 1 to 7
		if ddlb_dia.FindItem(lsa_semanas[li_i],0) > 0 then 
			lia_dias[li_i] = 1
		else
			lia_dias[li_i] = 0
		end if
	next
end if

li_no_semana = ddlb_semanas.FindItem(ddlb_semanas.text,0)
gtr_sce.sqlcode = 0
SetPointer(HourGlass!)
text = "Semana "+string(li_no_semana)
for li_i = 0 to 6
	ld_fch_entsal = date(string(year(today()))+'/'+string(month(today()))+'/'+string(li_i))
	if lia_dias[li_i + 1] = 1 and gtr_sce.sqlcode <> -1 then
		INSERT INTO dbo.profesor_lista_asistencia(cve_mat, 
		gpo, 
		periodo, 
		anio, 
		no_semana,
		cve_dia,
		fch_entsal,
		hora_inicio,
		cve_asistencia,
		cve_profesor)
		SELECT 	horario.cve_mat,
			horario.gpo,
			:ii_periodo,
			:ii_anio,
			:li_no_semana,
			:li_i,
			:ld_fch_entsal,
			horario.hora_inicio,
			1, 
			grupos.cve_profesor
		FROM 		horario,   
        			grupos   
  		WHERE ( horario.cve_mat = grupos.cve_mat ) and  
        	( horario.gpo = grupos.gpo ) and  
 			( grupos.anio = horario.anio) and
			( grupos.periodo = horario.periodo) and
			( grupos.anio = :ii_anio ) and
			( grupos.periodo = :ii_periodo ) and
        	( grupos.cond_gpo = 1 ) AND  
        	( grupos.tipo = 0 ) AND  
        	( horario.cve_dia = :li_i) USING gtr_sce;  
	end if
next
SetPointer(Arrow!)
text = "Fin"
Enabled = False
if gtr_sce.sqlcode <> -1 then
	Commit using gtr_sce;
	MessageBox("Atención","Se han guardado los cambios")
else
	ls_errtext = gtr_sce.sqlerrtext
	RollBack Using gtr_sce;
	MessageBox("Atención","Los cambios no se guardaron. "+ls_errtext)
end if


end event

event constructor;integer li_cve_coordinacion

li_cve_coordinacion = f_obten_coordinacion()

if li_cve_coordinacion <> 0 and li_cve_coordinacion <> 9999 then
	visible = False
	enabled = False
else
	visible = True
	enabled = True
end if



end event

type ddlb_dia from dropdownlistbox within w_genera_lista_prof_nvo
integer x = 887
integer y = 392
integer width = 539
integer height = 744
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

type st_periodo from statictext within w_genera_lista_prof_nvo
integer x = 1198
integer y = 92
integer width = 581
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 29405071
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_anio from statictext within w_genera_lista_prof_nvo
integer x = 1824
integer y = 92
integer width = 247
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 29405071
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type rr_1 from roundrectangle within w_genera_lista_prof_nvo
integer linethickness = 4
long fillcolor = 134217731
integer x = 1134
integer y = 52
integer width = 1010
integer height = 152
integer cornerheight = 40
integer cornerwidth = 46
end type

