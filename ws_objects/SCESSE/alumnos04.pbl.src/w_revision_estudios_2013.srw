$PBExportHeader$w_revision_estudios_2013.srw
forward
global type w_revision_estudios_2013 from w_master_main
end type
type lds_prueba from datawindow within w_revision_estudios_2013
end type
type lds_revision_est from datawindow within w_revision_estudios_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_revision_estudios_2013
end type
type dw_revision_estudios from uo_master_dw within w_revision_estudios_2013
end type
type cbx_legal from checkbox within w_revision_estudios_2013
end type
type rb_oficio from radiobutton within w_revision_estudios_2013
end type
type rb_folio from radiobutton within w_revision_estudios_2013
end type
type rb_expediente from radiobutton within w_revision_estudios_2013
end type
type em_numero from editmask within w_revision_estudios_2013
end type
type st_con_fecha from statictext within w_revision_estudios_2013
end type
type em_fecha from editmask within w_revision_estudios_2013
end type
type st_regularizacion from statictext within w_revision_estudios_2013
end type
type cb_2 from commandbutton within w_revision_estudios_2013
end type
type gb_revalidacion from groupbox within w_revision_estudios_2013
end type
end forward

global type w_revision_estudios_2013 from w_master_main
integer width = 3854
integer height = 2796
string title = "Revision de Estudios"
string menuname = "m_revision_estudios_2013"
lds_prueba lds_prueba
lds_revision_est lds_revision_est
uo_nombre uo_nombre
dw_revision_estudios dw_revision_estudios
cbx_legal cbx_legal
rb_oficio rb_oficio
rb_folio rb_folio
rb_expediente rb_expediente
em_numero em_numero
st_con_fecha st_con_fecha
em_fecha em_fecha
st_regularizacion st_regularizacion
cb_2 cb_2
gb_revalidacion gb_revalidacion
end type
global w_revision_estudios_2013 w_revision_estudios_2013

type variables
boolean ib_legalizado
long il_cuenta,il_carrera,il_plan,il_sub
str_revision_estudios istr_rev_est
string is_nivel

end variables

forward prototypes
public function integer wf_genera_rev_est ()
end prototypes

public function integer wf_genera_rev_est ();long ll_cuenta,ll_carrera,ll_plan,ll_subsis
int li_baja_disciplina,li_i,li_pos
string ls_nivel,ls_nombre,ls_apaterno,ls_amaterno
DataWindowChild ldc_revision
boolean lb_res

dw_revision_estudios.Getchild("dw_rev_est_fmc_child",ldc_revision)
lds_revision_est.Reset()
ldc_revision.Reset()
lds_prueba.Reset()
lb_res = hist_alumno_areas(il_cuenta,il_carrera,il_plan,il_sub,lds_prueba,lds_revision_est,is_nivel)
for li_i = 1 to lds_revision_est.Rowcount()
	ldc_revision.insertrow(0)
	ldc_revision.SetItem(li_i,"minimos",lds_revision_est.GetItemNumber(li_i ,"minimos"))
	ldc_revision.SetItem(li_i,"cursados",lds_revision_est.GetItemNumber(li_i ,"cursados"))
next

if lds_prueba.RowCount() >= 2 then
	if lds_prueba.GetItemString(2,"obs") = " *" then
		st_regularizacion.visible = true
		istr_rev_est.an_regular = 1
	else
		istr_rev_est.an_regular = 0
	end if
end if

gb_revalidacion.visible = lb_res
rb_oficio.visible = lb_res
rb_folio.visible = lb_res
rb_expediente.visible = lb_res
em_numero.visible = lb_res
em_fecha.visible = lb_res
st_con_fecha.visible = lb_res
rb_oficio.checked = true
em_numero.text = "0"
em_fecha.text = "00/00/0000"

istr_rev_est.ab_bolean = lb_res
istr_rev_est.an_oficio = 1
istr_rev_est.an_folio = 0
istr_rev_est.an_expediente = 0
istr_rev_est.an_regular = 0
istr_rev_est.ab_legal = false
istr_rev_est.as_numero = '0'
istr_rev_est.as_fecha =  "00/00/0000"
istr_rev_est.adw_prueba = lds_prueba
istr_rev_est.adw_revision = lds_revision_est
istr_rev_est.as_nivel = is_nivel
istr_rev_est.an_cve_carrera = il_carrera
li_pos = Pos (  uo_nombre.istr_carrera.str_carrera, '-' ) - 1
istr_rev_est.as_carrera =  mid(uo_nombre.istr_carrera.str_carrera, 1,li_pos)
istr_rev_est.an_cve_plan = il_plan
istr_rev_est.an_cuenta = long(il_cuenta)
istr_rev_est.as_digito = uo_nombre.of_obten_digito(il_cuenta)
istr_rev_est.as_nombre = uo_nombre.of_obten_nombre()
istr_rev_est.as_apaterno = uo_nombre.of_obten_apaterno()
istr_rev_est.as_amaterno = uo_nombre.of_obten_amaterno()


return 1
end function

on w_revision_estudios_2013.create
int iCurrent
call super::create
if this.MenuName = "m_revision_estudios_2013" then this.MenuID = create m_revision_estudios_2013
this.lds_prueba=create lds_prueba
this.lds_revision_est=create lds_revision_est
this.uo_nombre=create uo_nombre
this.dw_revision_estudios=create dw_revision_estudios
this.cbx_legal=create cbx_legal
this.rb_oficio=create rb_oficio
this.rb_folio=create rb_folio
this.rb_expediente=create rb_expediente
this.em_numero=create em_numero
this.st_con_fecha=create st_con_fecha
this.em_fecha=create em_fecha
this.st_regularizacion=create st_regularizacion
this.cb_2=create cb_2
this.gb_revalidacion=create gb_revalidacion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.lds_prueba
this.Control[iCurrent+2]=this.lds_revision_est
this.Control[iCurrent+3]=this.uo_nombre
this.Control[iCurrent+4]=this.dw_revision_estudios
this.Control[iCurrent+5]=this.cbx_legal
this.Control[iCurrent+6]=this.rb_oficio
this.Control[iCurrent+7]=this.rb_folio
this.Control[iCurrent+8]=this.rb_expediente
this.Control[iCurrent+9]=this.em_numero
this.Control[iCurrent+10]=this.st_con_fecha
this.Control[iCurrent+11]=this.em_fecha
this.Control[iCurrent+12]=this.st_regularizacion
this.Control[iCurrent+13]=this.cb_2
this.Control[iCurrent+14]=this.gb_revalidacion
end on

on w_revision_estudios_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.lds_prueba)
destroy(this.lds_revision_est)
destroy(this.uo_nombre)
destroy(this.dw_revision_estudios)
destroy(this.cbx_legal)
destroy(this.rb_oficio)
destroy(this.rb_folio)
destroy(this.rb_expediente)
destroy(this.em_numero)
destroy(this.st_con_fecha)
destroy(this.em_fecha)
destroy(this.st_regularizacion)
destroy(this.cb_2)
destroy(this.gb_revalidacion)
end on

event open;call super::open;dw_revision_estudios.Settransobject(gtr_sce)

m_revision_estudios_2013.m_salvar.visible = false
m_revision_estudios_2013.m_salvar.toolbaritemvisible = false
m_revision_estudios_2013.m_imprime.visible = false
m_revision_estudios_2013.m_imprime.toolbaritemvisible = false
end event

event closequery;//
end event

event doubleclicked;call super::doubleclicked;long li_valida_historia_acad,li_baja_laboratorio,li_baja_disciplina
string ls_desc_nivel

il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan
il_sub = uo_nombre.istr_carrera.str_cve_subsist
is_nivel = uo_nombre.istr_carrera.str_nivel


if il_carrera = 0 then return

li_valida_historia_acad = f_valida_historia_academica(il_cuenta, il_carrera, il_plan)
IF li_valida_historia_acad> 0 THEN
	MessageBox("Inconsistencia En Materias", "Favor de revisar materias aprobadas repetidas",StopSign!)
	RETURN
ELSEIF li_valida_historia_acad= -1 THEN
	MessageBox("Error en validación de Materias", "Favor de intentar nuevamente",StopSign!)
	RETURN	
END IF

//Revisa que el alumno no este dado de baja por adeudo de material de laboratorio
li_baja_laboratorio = f_obten_baja_laboratorio(il_cuenta)
if li_baja_laboratorio = 1 then
	MessageBox("Adeudo de Laboratorio","El alumno tiene adeudos de material de laboratorio",StopSign!)
	RETURN			
elseif li_baja_laboratorio = -1 then
	MessageBox("Error en Laboratorio","No es posible consultar la baja por laboratorio",StopSign!)
	RETURN			
end if
//Revisa que el alumno no este dado de baja por disciplina
li_baja_disciplina = f_obten_baja_disciplina(il_cuenta)
if li_baja_disciplina = 1 then
	MessageBox("Baja por Disciplina","El alumno esta dado de baja por disciplina",StopSign!)
	RETURN			
elseif li_baja_disciplina = -1 then
	MessageBox("Error en  Disciplina","No es posible consultar la baja por disciplina",StopSign!)
	RETURN			
end if

dw_revision_estudios.Retrieve(il_cuenta,il_carrera,il_plan)

wf_genera_rev_est()

end event

type st_sistema from w_master_main`st_sistema within w_revision_estudios_2013
integer x = 722
end type

type p_ibero from w_master_main`p_ibero within w_revision_estudios_2013
integer x = 23
integer y = 16
end type

type lds_prueba from datawindow within w_revision_estudios_2013
boolean visible = false
integer x = 2391
integer y = 1692
integer width = 494
integer height = 68
integer taborder = 60
string dataobject = "dw_certificado_ext2"
boolean livescroll = true
end type

type lds_revision_est from datawindow within w_revision_estudios_2013
boolean visible = false
integer x = 1874
integer y = 1692
integer width = 489
integer height = 76
integer taborder = 50
string dataobject = "dw_rev_est_fmc"
boolean vscrollbar = true
boolean livescroll = true
end type

type uo_nombre from uo_carreras_alumno_lista within w_revision_estudios_2013
event destroy ( )
integer x = 27
integer y = 296
integer width = 3241
integer height = 516
integer taborder = 50
boolean bringtotop = true
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_revision_estudios_2013.objeto = this
end event

type dw_revision_estudios from uo_master_dw within w_revision_estudios_2013
integer x = 27
integer y = 828
integer width = 3689
integer height = 1340
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_composite_revision_estudios_2013"
boolean hscrollbar = false
boolean vscrollbar = false
boolean livescroll = false
end type

event constructor;call super::constructor;m_revision_estudios_2013.dw = this
idw_trabajo = this
dw_revision_estudios.Modify("DataWindow.Print.Preview.outline = 'No'")
end event

type cbx_legal from checkbox within w_revision_estudios_2013
integer x = 114
integer y = 2320
integer width = 407
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Legalizado"
end type

event clicked;//Legalizado
if this.checked= true then
	ib_legalizado = true
else
	ib_legalizado = false	
end if

end event

type rb_oficio from radiobutton within w_revision_estudios_2013
boolean visible = false
integer x = 750
integer y = 2236
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Oficio"
boolean checked = true
end type

type rb_folio from radiobutton within w_revision_estudios_2013
boolean visible = false
integer x = 750
integer y = 2332
integer width = 274
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Folio"
end type

type rb_expediente from radiobutton within w_revision_estudios_2013
boolean visible = false
integer x = 750
integer y = 2420
integer width = 379
integer height = 76
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 12639424
string text = "Expediente"
end type

type em_numero from editmask within w_revision_estudios_2013
string tag = "1"
boolean visible = false
integer x = 1056
integer y = 2232
integer width = 512
integer height = 84
integer taborder = 60
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
string text = "0"
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!!!!!!!"
string displaydata = ""
end type

type st_con_fecha from statictext within w_revision_estudios_2013
boolean visible = false
integer x = 1573
integer y = 2236
integer width = 270
integer height = 72
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
boolean enabled = false
string text = "con fecha"
boolean focusrectangle = false
end type

type em_fecha from editmask within w_revision_estudios_2013
boolean visible = false
integer x = 1847
integer y = 2232
integer width = 366
integer height = 84
integer taborder = 70
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long backcolor = 16777215
string text = "2"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
string displaydata = ""
end type

type st_regularizacion from statictext within w_revision_estudios_2013
boolean visible = false
integer x = 2386
integer y = 2304
integer width = 1243
integer height = 152
boolean bringtotop = true
integer textsize = -16
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Certificado Regularizado"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_revision_estudios_2013
integer x = 3282
integer y = 500
integer width = 434
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Imprime"
end type

event clicked;if lds_prueba.rowcount() >= 2 then
	if rb_oficio.checked = true then
		istr_rev_est.an_oficio = 1
		istr_rev_est.as_numero = em_numero.text
		istr_rev_est.as_fecha =  em_fecha.text
	else
		istr_rev_est.an_oficio = 0
		istr_rev_est.as_numero = '0'
		istr_rev_est.as_fecha =  "00/00/0000"
	end if
	if rb_folio.checked = true then
		istr_rev_est.an_folio = 1
	else
		istr_rev_est.an_folio = 0
	end if
	if rb_expediente.checked = true then
		istr_rev_est.an_expediente = 1
	else
		istr_rev_est.an_expediente = 0
	end if
	if cbx_legal.checked = true then
		istr_rev_est.ab_legal = true
	else
		istr_rev_est.ab_legal = false
	end if
	openwithparm(w_opciones_imprimir_2013,istr_rev_est)
else
	messagebox("Error","No hay algo que imprimir "+string(lds_prueba.rowcount()))
end if
end event

type gb_revalidacion from groupbox within w_revision_estudios_2013
boolean visible = false
integer x = 713
integer y = 2156
integer width = 1541
integer height = 400
integer taborder = 50
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Materias equivalentes segun "
end type

