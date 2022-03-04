$PBExportHeader$w_formato_horas_revalidacion.srw
forward
global type w_formato_horas_revalidacion from w_master
end type
type cb_4 from commandbutton within w_formato_horas_revalidacion
end type
type cb_3 from commandbutton within w_formato_horas_revalidacion
end type
type cb_2 from commandbutton within w_formato_horas_revalidacion
end type
type em_saludo_destinatario from editmask within w_formato_horas_revalidacion
end type
type st_saludo_destinatario from statictext within w_formato_horas_revalidacion
end type
type st_prefijo_destinatario from statictext within w_formato_horas_revalidacion
end type
type em_prefijo_destinatario from editmask within w_formato_horas_revalidacion
end type
type dw_materias_revalidadas from u_dw within w_formato_horas_revalidacion
end type
type cb_redacta_dw from commandbutton within w_formato_horas_revalidacion
end type
type em_puesto_responsable_dse from editmask within w_formato_horas_revalidacion
end type
type em_responsable_dse from editmask within w_formato_horas_revalidacion
end type
type pb_2 from picturebutton within w_formato_horas_revalidacion
end type
type st_responsable from statictext within w_formato_horas_revalidacion
end type
type uo_elige_responsable from uo_responsable_dse within w_formato_horas_revalidacion
end type
type em_destinatario from editmask within w_formato_horas_revalidacion
end type
type st_3 from statictext within w_formato_horas_revalidacion
end type
type uo_1 from uo_nombre_aspirante_reval within w_formato_horas_revalidacion
end type
type cb_1 from commandbutton within w_formato_horas_revalidacion
end type
type dw_1 from u_dw within w_formato_horas_revalidacion
end type
end forward

global type w_formato_horas_revalidacion from w_master
integer width = 3758
integer height = 3088
string title = "Formato de Horas"
string menuname = "m_formato_horas_revalidacion_2"
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
em_saludo_destinatario em_saludo_destinatario
st_saludo_destinatario st_saludo_destinatario
st_prefijo_destinatario st_prefijo_destinatario
em_prefijo_destinatario em_prefijo_destinatario
dw_materias_revalidadas dw_materias_revalidadas
cb_redacta_dw cb_redacta_dw
em_puesto_responsable_dse em_puesto_responsable_dse
em_responsable_dse em_responsable_dse
pb_2 pb_2
st_responsable st_responsable
uo_elige_responsable uo_elige_responsable
em_destinatario em_destinatario
st_3 st_3
uo_1 uo_1
cb_1 cb_1
dw_1 dw_1
end type
global w_formato_horas_revalidacion w_formato_horas_revalidacion

on w_formato_horas_revalidacion.create
int iCurrent
call super::create
if this.MenuName = "m_formato_horas_revalidacion_2" then this.MenuID = create m_formato_horas_revalidacion_2
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.em_saludo_destinatario=create em_saludo_destinatario
this.st_saludo_destinatario=create st_saludo_destinatario
this.st_prefijo_destinatario=create st_prefijo_destinatario
this.em_prefijo_destinatario=create em_prefijo_destinatario
this.dw_materias_revalidadas=create dw_materias_revalidadas
this.cb_redacta_dw=create cb_redacta_dw
this.em_puesto_responsable_dse=create em_puesto_responsable_dse
this.em_responsable_dse=create em_responsable_dse
this.pb_2=create pb_2
this.st_responsable=create st_responsable
this.uo_elige_responsable=create uo_elige_responsable
this.em_destinatario=create em_destinatario
this.st_3=create st_3
this.uo_1=create uo_1
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_4
this.Control[iCurrent+2]=this.cb_3
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.em_saludo_destinatario
this.Control[iCurrent+5]=this.st_saludo_destinatario
this.Control[iCurrent+6]=this.st_prefijo_destinatario
this.Control[iCurrent+7]=this.em_prefijo_destinatario
this.Control[iCurrent+8]=this.dw_materias_revalidadas
this.Control[iCurrent+9]=this.cb_redacta_dw
this.Control[iCurrent+10]=this.em_puesto_responsable_dse
this.Control[iCurrent+11]=this.em_responsable_dse
this.Control[iCurrent+12]=this.pb_2
this.Control[iCurrent+13]=this.st_responsable
this.Control[iCurrent+14]=this.uo_elige_responsable
this.Control[iCurrent+15]=this.em_destinatario
this.Control[iCurrent+16]=this.st_3
this.Control[iCurrent+17]=this.uo_1
this.Control[iCurrent+18]=this.cb_1
this.Control[iCurrent+19]=this.dw_1
end on

on w_formato_horas_revalidacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.em_saludo_destinatario)
destroy(this.st_saludo_destinatario)
destroy(this.st_prefijo_destinatario)
destroy(this.em_prefijo_destinatario)
destroy(this.dw_materias_revalidadas)
destroy(this.cb_redacta_dw)
destroy(this.em_puesto_responsable_dse)
destroy(this.em_responsable_dse)
destroy(this.pb_2)
destroy(this.st_responsable)
destroy(this.uo_elige_responsable)
destroy(this.em_destinatario)
destroy(this.st_3)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;x=1
y=1
//rte_1.SetFocus()
end event

type cb_4 from commandbutton within w_formato_horas_revalidacion
integer x = 3483
integer y = 604
integer width = 114
integer height = 88
integer taborder = 90
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mm"
end type

event clicked;string ls_puesto_responsable_dse

ls_puesto_responsable_dse= em_puesto_responsable_dse.text

em_puesto_responsable_dse.text= f_convierte_mayusculas_a_nombre(ls_puesto_responsable_dse)
end event

type cb_3 from commandbutton within w_formato_horas_revalidacion
integer x = 3483
integer y = 516
integer width = 114
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mm"
end type

event clicked;string ls_responsable_dse

ls_responsable_dse= em_responsable_dse.text

em_responsable_dse.text= f_convierte_mayusculas_a_nombre(ls_responsable_dse)
end event

type cb_2 from commandbutton within w_formato_horas_revalidacion
integer x = 3483
integer y = 364
integer width = 114
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Mm"
end type

event clicked;string ls_destinatario

ls_destinatario= em_destinatario.text

em_destinatario.text= f_convierte_mayusculas_a_nombre(ls_destinatario)
end event

type em_saludo_destinatario from editmask within w_formato_horas_revalidacion
integer x = 411
integer y = 456
integer width = 1010
integer height = 88
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "Estimado Leopoldo"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_saludo_destinatario from statictext within w_formato_horas_revalidacion
integer x = 82
integer y = 464
integer width = 247
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Saludo"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_prefijo_destinatario from statictext within w_formato_horas_revalidacion
integer x = 23
integer y = 380
integer width = 370
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Prefijo "
alignment alignment = center!
boolean focusrectangle = false
end type

type em_prefijo_destinatario from editmask within w_formato_horas_revalidacion
integer x = 411
integer y = 364
integer width = 315
integer height = 88
integer taborder = 120
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "Lic."
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type dw_materias_revalidadas from u_dw within w_formato_horas_revalidacion
integer x = 50
integer y = 704
integer width = 3456
integer height = 1980
integer taborder = 20
string dataobject = "d_formato_horas_revalidacion_2"
boolean hscrollbar = true
boolean resizable = true
boolean hsplitscroll = true
boolean ib_rmbmenu = false
end type

event constructor;call super::constructor;this.SetTransObject(gtr_sce)
this.of_SetPrintPreview(TRUE)
end event

type cb_redacta_dw from commandbutton within w_formato_horas_revalidacion
integer x = 1563
integer y = 2712
integer width = 411
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Redactar"
end type

event clicked;long ll_indice, ll_cve_mat, ll_horas_reales, ll_indice_documento, ll_folio
string ls_cve_mat, ls_horas_reales, ls_sigla, ls_materia, ls_folio
string LS_TAB = "~t",LS_NEW_LINE="~r~n", ls_destinatario, ls_responsable_dse, ls_puesto_responsable_dse
long ll_cve_carrera, ll_cuenta
string ls_carrera, ls_apaterno, ls_amaterno, ls_nombre, ls_prefijo_destinatario, ls_saludo_destinatario
integer li_cod_carrera, li_cod_nombre, li_cancelado
//rte_1.event pfc_selectall()
//rte_1.event pfc_clear()
//rte_1.event pfc_selectall()

ls_prefijo_destinatario= em_prefijo_destinatario.text
ls_saludo_destinatario= em_saludo_destinatario.text
ls_destinatario= em_destinatario.text
ls_responsable_dse = em_responsable_dse.text
ls_puesto_responsable_dse = em_puesto_responsable_dse.text

ls_folio= uo_1.em_cuenta.text
if not isnumber(ls_folio) then
	return
end if

li_cancelado = f_obten_cancelado(ll_folio)

if li_cancelado <>0 then
	MessageBox("Aspirante con proceso cancelado",&
				"Se ha cancelado el proceso del aspirante, ~n"+ &
				 "no es posible efectuar validaciones adicionales.",StopSign!)
	return 	
end if
ll_folio = long(ls_folio)
dw_materias_revalidadas.Retrieve(ll_folio, ls_prefijo_destinatario,ls_saludo_destinatario, ls_destinatario, ls_responsable_dse, ls_puesto_responsable_dse)

end event

type em_puesto_responsable_dse from editmask within w_formato_horas_revalidacion
integer x = 1650
integer y = 604
integer width = 1829
integer height = 88
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type em_responsable_dse from editmask within w_formato_horas_revalidacion
integer x = 1650
integer y = 516
integer width = 1829
integer height = 88
integer taborder = 80
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type pb_2 from picturebutton within w_formato_horas_revalidacion
integer x = 1472
integer y = 556
integer width = 142
integer height = 92
integer taborder = 110
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "C:\Program Files\Sybase\PowerBuilder 7.0\Code Examples\Example App\indicatr.bmp"
alignment htextalign = left!
end type

event clicked;string ls_nombre_responsable, ls_puesto_responsable
ls_nombre_responsable= uo_elige_responsable.of_obten_texto()
ls_puesto_responsable= uo_elige_responsable.of_obten_puesto()
em_responsable_dse.text = ls_nombre_responsable
em_puesto_responsable_dse.text = ls_puesto_responsable



end event

type st_responsable from statictext within w_formato_horas_revalidacion
integer x = 37
integer y = 536
integer width = 338
integer height = 128
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Firma Responsable"
alignment alignment = center!
boolean focusrectangle = false
end type

type uo_elige_responsable from uo_responsable_dse within w_formato_horas_revalidacion
integer x = 393
integer y = 532
integer width = 1056
integer height = 136
integer taborder = 90
boolean border = false
end type

on uo_elige_responsable.destroy
call uo_responsable_dse::destroy
end on

type em_destinatario from editmask within w_formato_horas_revalidacion
integer x = 1646
integer y = 364
integer width = 1829
integer height = 88
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
string text = "LEOPOLDO NAVARRO FLORES"
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
end type

type st_3 from statictext within w_formato_horas_revalidacion
integer x = 1253
integer y = 380
integer width = 370
integer height = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Destinatario"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_1 from uo_nombre_aspirante_reval within w_formato_horas_revalidacion
integer x = 18
integer y = 12
integer width = 3241
integer taborder = 30
boolean enabled = true
end type

on uo_1.destroy
call uo_nombre_aspirante_reval::destroy
end on

type cb_1 from commandbutton within w_formato_horas_revalidacion
boolean visible = false
integer x = 3214
integer y = 1860
integer width = 411
integer height = 108
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Redactar"
end type

event clicked;//long ll_indice, ll_cve_mat, ll_horas_reales, ll_indice_documento, ll_folio
//string ls_cve_mat, ls_horas_reales, ls_sigla, ls_materia, ls_folio
//string LS_TAB = "~t",LS_NEW_LINE="~r~n", ls_destinatario, ls_responsable_dse, ls_puesto_responsable_dse
//long ll_cve_carrera, ll_cuenta
//string ls_carrera, ls_apaterno, ls_amaterno, ls_nombre
//integer li_cod_carrera, li_cod_nombre
//rte_1.event pfc_selectall()
//rte_1.event pfc_clear()
//rte_1.event pfc_selectall()
//
//ls_destinatario= em_destinatario.text
//ls_responsable_dse = em_responsable_dse.text
//ls_puesto_responsable_dse = em_puesto_responsable_dse.text
//
//ls_folio= uo_1.em_cuenta.text
//if not isnumber(ls_folio) then
//	return
//end if
//
//ll_folio = long(ls_folio)
//dw_1.Retrieve(ll_folio)
//ll_cuenta = f_obten_cuenta(ll_folio)
//li_cod_nombre=f_obten_nombre_aspirante_reval(ll_folio,ls_apaterno, ls_amaterno, ls_nombre)
//li_cod_carrera= f_obten_carrera_aspirante_reval(ll_folio,ll_cve_carrera,ls_carrera)
//
//
//ll_indice_documento=1
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(LS_NEW_LINE+"FORMATO PARA PAGO DE HORAS DE REVALIDACION"+LS_NEW_LINE)	
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,50)
//rte_1.of_SetTextStyleBold(TRUE)
//ll_indice_documento=ll_indice_documento + 5
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(LS_NEW_LINE+LS_NEW_LINE+LS_NEW_LINE+LS_NEW_LINE+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento + 5
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText("Estimado: "+ls_destinatario+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +1
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText("Por medio de la presente le solicito se lleve a cabo el cobro de las siguientes materias que han sido aprobadas por la Secretaría de Educación Pública como equivalentes para el alumno :"+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +2
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText("No. de Cuenta "+ string(ll_cuenta)+"-"+obten_digito(ll_cuenta)+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +1
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(LS_TAB+"Apellido Paterno "+LS_TAB+"Apellido Materno "+LS_TAB+"Nombre"+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +1
//
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(LS_TAB+ls_apaterno+LS_TAB+ls_amaterno+LS_TAB+ls_nombre+LS_NEW_LINE )	
//ll_indice_documento=ll_indice_documento +1
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(LS_TAB+"Carrera"+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +1
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(LS_TAB+ls_carrera+LS_NEW_LINE )	
//ll_indice_documento=ll_indice_documento +1
//
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento, 1)
//rte_1.ReplaceText(LS_TAB+"Clave Materia"+LS_TAB+"Sigla Materia"+LS_TAB+"Nombre Materia"+LS_TAB+"# Horas de Catálogo"+LS_NEW_LINE)
//ll_indice_documento=ll_indice_documento +1
//
//
////FOR ll_indice=1 TO dw_1.RowCount()
////	ll_indice_documento= ll_indice_documento+ 1
////	rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
////	rte_1.ReplaceText("~r~n")	
////NEXT
//
//FOR ll_indice=1 TO dw_1.RowCount()
//
//	ll_cve_mat = dw_1.GetItemNumber(ll_indice,"cve_mat")
//	ll_horas_reales = dw_1.GetItemNumber(ll_indice,"horas_reales") 
//	ls_sigla = dw_1.GetItemString(ll_indice,"sigla")
//	ls_materia = dw_1.GetItemString(ll_indice,"materia")
//	ls_materia = left(ls_materia,22)
//	ls_cve_mat = string(ll_cve_mat)
//	ls_horas_reales = string(ll_horas_reales)
//	
//	ll_indice_documento= ll_indice_documento + 1
//
//	
//	rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento, 1)
//	rte_1.ReplaceText(LS_TAB+ls_cve_mat+LS_TAB+ls_sigla+LS_TAB+ls_materia+LS_TAB+ls_horas_reales+LS_NEW_LINE)
//	
//NEXT
//
//ll_indice_documento= ll_indice_documento + 1
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText("Agradeciendo su antención, reciba un cordial saludo."+LS_NEW_LINE+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +2
//
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(ls_responsable_dse+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +1
//rte_1.SelectText(ll_indice_documento, 1, ll_indice_documento,1)
//rte_1.ReplaceText(ls_puesto_responsable_dse+LS_NEW_LINE)	
//ll_indice_documento=ll_indice_documento +1
//
//
end event

type dw_1 from u_dw within w_formato_horas_revalidacion
integer x = 50
integer y = 1300
integer width = 3451
integer height = 188
integer taborder = 40
string dataobject = "d_formato_horas_revalidacion"
end type

event constructor;call super::constructor;this.SetTransObject(gtr_sce)

end event

