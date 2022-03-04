$PBExportHeader$w_constanciabak.srw
forward
global type w_constanciabak from window
end type
type cb_casar2 from commandbutton within w_constanciabak
end type
type mle_auxiliar from multilineedit within w_constanciabak
end type
type cb_casar from commandbutton within w_constanciabak
end type
type dw_1 from datawindow within w_constanciabak
end type
type rte_texto_libre from richtextedit within w_constanciabak
end type
type cb_4 from commandbutton within w_constanciabak
end type
type st_revisa_documentos from statictext within w_constanciabak
end type
type cb_3 from commandbutton within w_constanciabak
end type
type st_4 from statictext within w_constanciabak
end type
type em_num_contancia from editmask within w_constanciabak
end type
type cb_2 from commandbutton within w_constanciabak
end type
type st_anio from statictext within w_constanciabak
end type
type st_periodo from statictext within w_constanciabak
end type
type st_d_m from statictext within w_constanciabak
end type
type st_dia_mes from statictext within w_constanciabak
end type
type cb_1 from commandbutton within w_constanciabak
end type
type cb_sem_cursados from commandbutton within w_constanciabak
end type
type st_sem from statictext within w_constanciabak
end type
type st_texto_sem_cursados from statictext within w_constanciabak
end type
type st_carr from statictext within w_constanciabak
end type
type st_texto_carrera from statictext within w_constanciabak
end type
type cb_carrera from commandbutton within w_constanciabak
end type
type st_precision from statictext within w_constanciabak
end type
type em_precision from editmask within w_constanciabak
end type
type cb_calcula from commandbutton within w_constanciabak
end type
type st_res_creditos from statictext within w_constanciabak
end type
type st_res_promedio from statictext within w_constanciabak
end type
type st_3 from statictext within w_constanciabak
end type
type st_2 from statictext within w_constanciabak
end type
type st_plan from statictext within w_constanciabak
end type
type st_carrera from statictext within w_constanciabak
end type
type em_plan from editmask within w_constanciabak
end type
type em_carrera from editmask within w_constanciabak
end type
type st_1 from statictext within w_constanciabak
end type
type em_cuenta from editmask within w_constanciabak
end type
type st_decimal from statictext within w_constanciabak
end type
type st_dec from statictext within w_constanciabak
end type
type cb_decimal from commandbutton within w_constanciabak
end type
type em_numero_decimal from editmask within w_constanciabak
end type
type st_ordinal from statictext within w_constanciabak
end type
type st_ord from statictext within w_constanciabak
end type
type cb_ordinal from commandbutton within w_constanciabak
end type
type em_ordinal from editmask within w_constanciabak
end type
type st_fech from statictext within w_constanciabak
end type
type st_fecha from statictext within w_constanciabak
end type
type st_num from statictext within w_constanciabak
end type
type st_numero from statictext within w_constanciabak
end type
type em_numero from editmask within w_constanciabak
end type
type em_fecha from editmask within w_constanciabak
end type
type cb_numero from commandbutton within w_constanciabak
end type
type cb_fecha from commandbutton within w_constanciabak
end type
end forward

global type w_constanciabak from window
integer x = 1056
integer y = 484
integer width = 3657
integer height = 1956
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
cb_casar2 cb_casar2
mle_auxiliar mle_auxiliar
cb_casar cb_casar
dw_1 dw_1
rte_texto_libre rte_texto_libre
cb_4 cb_4
st_revisa_documentos st_revisa_documentos
cb_3 cb_3
st_4 st_4
em_num_contancia em_num_contancia
cb_2 cb_2
st_anio st_anio
st_periodo st_periodo
st_d_m st_d_m
st_dia_mes st_dia_mes
cb_1 cb_1
cb_sem_cursados cb_sem_cursados
st_sem st_sem
st_texto_sem_cursados st_texto_sem_cursados
st_carr st_carr
st_texto_carrera st_texto_carrera
cb_carrera cb_carrera
st_precision st_precision
em_precision em_precision
cb_calcula cb_calcula
st_res_creditos st_res_creditos
st_res_promedio st_res_promedio
st_3 st_3
st_2 st_2
st_plan st_plan
st_carrera st_carrera
em_plan em_plan
em_carrera em_carrera
st_1 st_1
em_cuenta em_cuenta
st_decimal st_decimal
st_dec st_dec
cb_decimal cb_decimal
em_numero_decimal em_numero_decimal
st_ordinal st_ordinal
st_ord st_ord
cb_ordinal cb_ordinal
em_ordinal em_ordinal
st_fech st_fech
st_fecha st_fecha
st_num st_num
st_numero st_numero
em_numero em_numero
em_fecha em_fecha
cb_numero cb_numero
cb_fecha cb_fecha
end type
global w_constanciabak w_constanciabak

on w_constanciabak.create
this.cb_casar2=create cb_casar2
this.mle_auxiliar=create mle_auxiliar
this.cb_casar=create cb_casar
this.dw_1=create dw_1
this.rte_texto_libre=create rte_texto_libre
this.cb_4=create cb_4
this.st_revisa_documentos=create st_revisa_documentos
this.cb_3=create cb_3
this.st_4=create st_4
this.em_num_contancia=create em_num_contancia
this.cb_2=create cb_2
this.st_anio=create st_anio
this.st_periodo=create st_periodo
this.st_d_m=create st_d_m
this.st_dia_mes=create st_dia_mes
this.cb_1=create cb_1
this.cb_sem_cursados=create cb_sem_cursados
this.st_sem=create st_sem
this.st_texto_sem_cursados=create st_texto_sem_cursados
this.st_carr=create st_carr
this.st_texto_carrera=create st_texto_carrera
this.cb_carrera=create cb_carrera
this.st_precision=create st_precision
this.em_precision=create em_precision
this.cb_calcula=create cb_calcula
this.st_res_creditos=create st_res_creditos
this.st_res_promedio=create st_res_promedio
this.st_3=create st_3
this.st_2=create st_2
this.st_plan=create st_plan
this.st_carrera=create st_carrera
this.em_plan=create em_plan
this.em_carrera=create em_carrera
this.st_1=create st_1
this.em_cuenta=create em_cuenta
this.st_decimal=create st_decimal
this.st_dec=create st_dec
this.cb_decimal=create cb_decimal
this.em_numero_decimal=create em_numero_decimal
this.st_ordinal=create st_ordinal
this.st_ord=create st_ord
this.cb_ordinal=create cb_ordinal
this.em_ordinal=create em_ordinal
this.st_fech=create st_fech
this.st_fecha=create st_fecha
this.st_num=create st_num
this.st_numero=create st_numero
this.em_numero=create em_numero
this.em_fecha=create em_fecha
this.cb_numero=create cb_numero
this.cb_fecha=create cb_fecha
this.Control[]={this.cb_casar2,&
this.mle_auxiliar,&
this.cb_casar,&
this.dw_1,&
this.rte_texto_libre,&
this.cb_4,&
this.st_revisa_documentos,&
this.cb_3,&
this.st_4,&
this.em_num_contancia,&
this.cb_2,&
this.st_anio,&
this.st_periodo,&
this.st_d_m,&
this.st_dia_mes,&
this.cb_1,&
this.cb_sem_cursados,&
this.st_sem,&
this.st_texto_sem_cursados,&
this.st_carr,&
this.st_texto_carrera,&
this.cb_carrera,&
this.st_precision,&
this.em_precision,&
this.cb_calcula,&
this.st_res_creditos,&
this.st_res_promedio,&
this.st_3,&
this.st_2,&
this.st_plan,&
this.st_carrera,&
this.em_plan,&
this.em_carrera,&
this.st_1,&
this.em_cuenta,&
this.st_decimal,&
this.st_dec,&
this.cb_decimal,&
this.em_numero_decimal,&
this.st_ordinal,&
this.st_ord,&
this.cb_ordinal,&
this.em_ordinal,&
this.st_fech,&
this.st_fecha,&
this.st_num,&
this.st_numero,&
this.em_numero,&
this.em_fecha,&
this.cb_numero,&
this.cb_fecha}
end on

on w_constanciabak.destroy
destroy(this.cb_casar2)
destroy(this.mle_auxiliar)
destroy(this.cb_casar)
destroy(this.dw_1)
destroy(this.rte_texto_libre)
destroy(this.cb_4)
destroy(this.st_revisa_documentos)
destroy(this.cb_3)
destroy(this.st_4)
destroy(this.em_num_contancia)
destroy(this.cb_2)
destroy(this.st_anio)
destroy(this.st_periodo)
destroy(this.st_d_m)
destroy(this.st_dia_mes)
destroy(this.cb_1)
destroy(this.cb_sem_cursados)
destroy(this.st_sem)
destroy(this.st_texto_sem_cursados)
destroy(this.st_carr)
destroy(this.st_texto_carrera)
destroy(this.cb_carrera)
destroy(this.st_precision)
destroy(this.em_precision)
destroy(this.cb_calcula)
destroy(this.st_res_creditos)
destroy(this.st_res_promedio)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_plan)
destroy(this.st_carrera)
destroy(this.em_plan)
destroy(this.em_carrera)
destroy(this.st_1)
destroy(this.em_cuenta)
destroy(this.st_decimal)
destroy(this.st_dec)
destroy(this.cb_decimal)
destroy(this.em_numero_decimal)
destroy(this.st_ordinal)
destroy(this.st_ord)
destroy(this.cb_ordinal)
destroy(this.em_ordinal)
destroy(this.st_fech)
destroy(this.st_fecha)
destroy(this.st_num)
destroy(this.st_numero)
destroy(this.em_numero)
destroy(this.em_fecha)
destroy(this.cb_numero)
destroy(this.cb_fecha)
end on

type cb_casar2 from commandbutton within w_constanciabak
integer x = 2437
integer y = 1696
integer width = 338
integer height = 108
integer taborder = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Casar 2"
end type

event clicked;long ll_cuenta
integer li_carrera, li_plan, li_precision
decimal ld_promedio
string ls_texto_libre

ll_cuenta = long(em_cuenta.text)
li_carrera = integer(em_carrera.text)
li_plan = integer(em_plan.text)
li_precision = integer(em_precision.text)

rte_texto_libre.SelectTextAll()
rte_texto_libre.SetAlignment ( Justify! )
ls_texto_libre=rte_texto_libre.CopyRTF()

//ls_texto_libre = mle_auxiliar.Text


dw_1.Retrieve(ll_cuenta,ls_texto_libre)

dw_1.object.st_texto_libre.text = ls_texto_libre


end event

type mle_auxiliar from multilineedit within w_constanciabak
integer x = 1157
integer y = 992
integer width = 2226
integer height = 280
integer taborder = 200
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long textcolor = 33554432
boolean hscrollbar = true
boolean vscrollbar = true
borderstyle borderstyle = stylelowered!
end type

type cb_casar from commandbutton within w_constanciabak
integer x = 2039
integer y = 1704
integer width = 338
integer height = 108
integer taborder = 220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Casar"
end type

event clicked;long ll_cuenta
integer li_carrera, li_plan, li_precision
decimal ld_promedio
string ls_texto_libre

ll_cuenta = long(em_cuenta.text)
li_carrera = integer(em_carrera.text)
li_plan = integer(em_plan.text)
li_precision = integer(em_precision.text)

rte_texto_libre.SelectTextAll()
rte_texto_libre.SetAlignment ( Justify! )
rte_texto_libre.Copy()
mle_auxiliar.Paste()
ls_texto_libre = mle_auxiliar.Text


dw_1.Retrieve(ll_cuenta,ls_texto_libre)

dw_1.object.st_texto_libre.text = ls_texto_libre

integer li_rtn

li_rtn = rte_texto_libre.SaveDocument("c:\windows\escritorio\prueba_formato", FileTypeText!)


end event

type dw_1 from datawindow within w_constanciabak
integer x = 1157
integer y = 1288
integer width = 2318
integer height = 368
integer taborder = 210
string dataobject = "d_test"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(gtr_sce)
end event

type rte_texto_libre from richtextedit within w_constanciabak
integer x = 1147
integer y = 528
integer width = 2098
integer height = 432
integer taborder = 190
boolean init_hscrollbar = true
boolean init_vscrollbar = true
boolean init_wordwrap = true
boolean init_pictureframe = true
boolean init_toolbar = true
long init_leftmargin = 5
long init_topmargin = 5
long init_rightmargin = 5
long init_bottommargin = 5
borderstyle borderstyle = stylelowered!
end type

on rte_texto_libre.create
HScrollBar=true
VScrollBar=true
PicturesAsFrame=true
ToolBar=true
WordWrap=true
LeftMargin=5
TopMargin=5
RightMargin=5
BottomMargin=5
end on

event constructor;this.Border = TRUE
end event

type cb_4 from commandbutton within w_constanciabak
integer x = 87
integer y = 572
integer width = 471
integer height = 108
integer taborder = 180
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Revisa Doctos."
end type

event clicked;long ll_cuenta
string ls_mensaje_constancia


ll_cuenta = long(em_cuenta.text)

ls_mensaje_constancia= f_revisa_adeudos_const(ll_cuenta)

if len(trim(ls_mensaje_constancia)) >0 then
	MessageBox("Error en documentos", ls_mensaje_constancia, StopSign!)	
end if




end event

type st_revisa_documentos from statictext within w_constanciabak
integer x = 384
integer y = 684
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_constanciabak
integer x = 32
integer y = 1680
integer width = 251
integer height = 108
integer taborder = 170
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Insertar"
end type

event clicked;integer li_cve_constancia
string  ls_cve_constancia
ls_cve_constancia = em_num_contancia.text

li_cve_constancia = integer(ls_cve_constancia)

f_inserta_folio_constancia(118979, li_cve_constancia)
end event

type st_4 from statictext within w_constanciabak
integer x = 306
integer y = 1744
integer width = 471
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Num. Constancia"
boolean focusrectangle = false
end type

type em_num_contancia from editmask within w_constanciabak
integer x = 805
integer y = 1740
integer width = 247
integer height = 100
integer taborder = 160
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "1"
borderstyle borderstyle = stylelowered!
string mask = "#"
end type

type cb_2 from commandbutton within w_constanciabak
integer x = 681
integer y = 476
integer width = 306
integer height = 108
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Per: Anio"
end type

event clicked;string ls_fecha, ls_fecha_texto
integer li_periodo_actual, li_anio_actual
date ldt_fecha

ls_fecha= em_fecha.Text
ldt_fecha = date(ls_fecha)


li_anio_actual= f_obten_anio_actual()
li_periodo_actual= f_obten_periodo_actual()

st_anio.Text = string(li_anio_actual)
st_periodo.Text = string(li_periodo_actual)


end event

type st_anio from statictext within w_constanciabak
integer x = 672
integer y = 780
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_periodo from statictext within w_constanciabak
integer x = 384
integer y = 780
integer width = 219
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_d_m from statictext within w_constanciabak
integer x = 41
integer y = 876
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "D. Mes"
boolean focusrectangle = false
end type

type st_dia_mes from statictext within w_constanciabak
integer x = 384
integer y = 876
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_constanciabak
integer x = 160
integer y = 432
integer width = 274
integer height = 108
integer taborder = 240
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Dia Mes"
end type

event clicked;string ls_fecha, ls_fecha_texto
date ldt_fecha

ls_fecha= em_fecha.Text
ldt_fecha = date(ls_fecha)


ls_fecha_texto= f_obten_dia_mes_en_texto(ldt_fecha)

st_dia_mes.Text = ls_fecha_texto

end event

type cb_sem_cursados from commandbutton within w_constanciabak
integer x = 1545
integer y = 280
integer width = 384
integer height = 108
integer taborder = 230
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "S. Cursados"
end type

event clicked;string ls_sem_cursados, ls_sem_cursados_texto, ls_cuenta
long ll_numero
int li_sem_cursados

ls_cuenta= em_cuenta.Text
ll_numero = long(ls_cuenta)

li_sem_cursados = f_obten_sem_cursados(ll_numero)

ls_sem_cursados_texto= f_obten_ordinal(li_sem_cursados)

st_texto_sem_cursados.Text = ls_sem_cursados_texto
end event

type st_sem from statictext within w_constanciabak
integer x = 41
integer y = 1552
integer width = 293
integer height = 52
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Sem. C."
boolean focusrectangle = false
end type

type st_texto_sem_cursados from statictext within w_constanciabak
integer x = 375
integer y = 1552
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_carr from statictext within w_constanciabak
integer x = 41
integer y = 1436
integer width = 293
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "T. Carrera:"
boolean focusrectangle = false
end type

type st_texto_carrera from statictext within w_constanciabak
integer x = 375
integer y = 1436
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type cb_carrera from commandbutton within w_constanciabak
integer x = 1143
integer y = 280
integer width = 320
integer height = 108
integer taborder = 150
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "T. Carrera"
end type

event clicked;string ls_carrera, ls_carrera_texto
long ll_numero

ls_carrera= em_cuenta.Text
ll_numero = long(ls_carrera)


ls_carrera_texto= f_obten_texto_carrera(ll_numero)

st_texto_carrera.Text = ls_carrera_texto
end event

type st_precision from statictext within w_constanciabak
integer x = 2025
integer y = 412
integer width = 261
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Precision"
boolean focusrectangle = false
end type

type em_precision from editmask within w_constanciabak
integer x = 2309
integer y = 400
integer width = 293
integer height = 100
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type cb_calcula from commandbutton within w_constanciabak
integer x = 850
integer y = 564
integer width = 293
integer height = 108
integer taborder = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Calcula"
end type

event clicked;long ll_cuenta
integer li_carrera, li_plan, li_precision
decimal ld_promedio, ldc_creditos

ll_cuenta = long(em_cuenta.text)
li_carrera = integer(em_carrera.text)
li_plan = integer(em_plan.text)
li_precision = integer(em_precision.text)

if li_precision > 4 or li_precision <0 then
	li_precision = 2
end if

f_obten_promedio_creditos(ll_cuenta, li_carrera, li_plan, ld_promedio, ldc_creditos)


st_res_creditos.Text = string(ldc_creditos)
st_res_promedio.Text = string(ld_promedio)


st_decimal.Text = f_obten_decimal_en_texto(ld_promedio,li_precision)
st_numero.Text = f_obten_numero_en_texto(Long(ldc_creditos))


end event

type st_res_creditos from statictext within w_constanciabak
integer x = 3040
integer y = 316
integer width = 475
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_res_promedio from statictext within w_constanciabak
integer x = 3040
integer y = 160
integer width = 475
integer height = 84
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_3 from statictext within w_constanciabak
integer x = 2715
integer y = 316
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Créditos"
boolean focusrectangle = false
end type

type st_2 from statictext within w_constanciabak
integer x = 2725
integer y = 164
integer width = 265
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Promedio"
boolean focusrectangle = false
end type

type st_plan from statictext within w_constanciabak
integer x = 2025
integer y = 288
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Plan"
boolean focusrectangle = false
end type

type st_carrera from statictext within w_constanciabak
integer x = 2025
integer y = 172
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Carrera"
boolean focusrectangle = false
end type

type em_plan from editmask within w_constanciabak
integer x = 2309
integer y = 276
integer width = 293
integer height = 100
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type em_carrera from editmask within w_constanciabak
integer x = 2309
integer y = 156
integer width = 293
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type st_1 from statictext within w_constanciabak
integer x = 2025
integer y = 48
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Cuenta"
boolean focusrectangle = false
end type

type em_cuenta from editmask within w_constanciabak
integer x = 2309
integer y = 36
integer width = 293
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "######"
end type

type st_decimal from statictext within w_constanciabak
integer x = 375
integer y = 1200
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_dec from statictext within w_constanciabak
integer x = 41
integer y = 1200
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Decimal"
boolean focusrectangle = false
end type

type cb_decimal from commandbutton within w_constanciabak
integer x = 718
integer y = 292
integer width = 270
integer height = 108
integer taborder = 100
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Decimal"
end type

event clicked;string ls_numero, ls_numero_texto
real lr_numero

ls_numero= em_numero_decimal.Text
lr_numero = real(ls_numero)


ls_numero_texto= f_obten_decimal_en_texto(lr_numero,2)

st_decimal.Text = ls_numero_texto
end event

type em_numero_decimal from editmask within w_constanciabak
integer x = 617
integer y = 156
integer width = 384
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = decimalmask!
string mask = "#,###.###0"
end type

type st_ordinal from statictext within w_constanciabak
integer x = 375
integer y = 1316
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_ord from statictext within w_constanciabak
integer x = 41
integer y = 1316
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Ordinal"
boolean focusrectangle = false
end type

type cb_ordinal from commandbutton within w_constanciabak
integer x = 1573
integer y = 412
integer width = 261
integer height = 108
integer taborder = 130
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Ordinal"
end type

event clicked;string ls_numero, ls_numero_texto
long ll_numero

ls_numero= em_ordinal.Text
ll_numero = long(ls_numero)


ls_numero_texto= f_obten_ordinal(ll_numero)

st_ordinal.Text = ls_numero_texto


end event

type em_ordinal from editmask within w_constanciabak
integer x = 1545
integer y = 156
integer width = 311
integer height = 100
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
string mask = "#,###"
end type

type st_fech from statictext within w_constanciabak
integer x = 41
integer y = 976
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Fecha"
boolean focusrectangle = false
end type

type st_fecha from statictext within w_constanciabak
integer x = 384
integer y = 976
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type st_num from statictext within w_constanciabak
integer x = 41
integer y = 1092
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
string text = "Número"
boolean focusrectangle = false
end type

type st_numero from statictext within w_constanciabak
integer x = 375
integer y = 1092
integer width = 704
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean focusrectangle = false
end type

type em_numero from editmask within w_constanciabak
integer x = 1111
integer y = 156
integer width = 311
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#,##0"
end type

type em_fecha from editmask within w_constanciabak
integer x = 105
integer y = 148
integer width = 366
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type cb_numero from commandbutton within w_constanciabak
integer x = 1138
integer y = 412
integer width = 261
integer height = 108
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Número"
end type

event clicked;string ls_numero, ls_numero_texto
long ll_numero

ls_numero= em_numero.Text
ll_numero = long(ls_numero)


ls_numero_texto= f_obten_numero_en_texto(ll_numero)

st_numero.Text = ls_numero_texto
end event

type cb_fecha from commandbutton within w_constanciabak
integer x = 142
integer y = 300
integer width = 274
integer height = 108
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fecha"
end type

event clicked;string ls_fecha, ls_fecha_texto
date ldt_fecha

ls_fecha= em_fecha.Text
ldt_fecha = date(ls_fecha)


ls_fecha_texto= f_obten_fecha_en_texto(ldt_fecha)

st_fecha.Text = ls_fecha_texto


end event

