$PBExportHeader$w_reporte_adeudo_documentos.srw
forward
global type w_reporte_adeudo_documentos from w_ancestral
end type
type gb_3 from groupbox within w_reporte_adeudo_documentos
end type
type dw_1 from uo_dw_reporte within w_reporte_adeudo_documentos
end type
type st_2 from statictext within w_reporte_adeudo_documentos
end type
type sle_adeudos from singlelineedit within w_reporte_adeudo_documentos
end type
type rb_primer_ingreso_bach from radiobutton within w_reporte_adeudo_documentos
end type
type rb_reingreso from radiobutton within w_reporte_adeudo_documentos
end type
type rb_licenciatura from radiobutton within w_reporte_adeudo_documentos
end type
type rb_maestria from radiobutton within w_reporte_adeudo_documentos
end type
type rb_doctorado from radiobutton within w_reporte_adeudo_documentos
end type
type rb_primer_ingreso_todo from radiobutton within w_reporte_adeudo_documentos
end type
type uo_tipo_periodo from uo_periodo_tipo_chk within w_reporte_adeudo_documentos
end type
type rb_tsu from radiobutton within w_reporte_adeudo_documentos
end type
type gb_1 from groupbox within w_reporte_adeudo_documentos
end type
type gb_2 from groupbox within w_reporte_adeudo_documentos
end type
end forward

global type w_reporte_adeudo_documentos from w_ancestral
integer width = 3593
integer height = 1932
string title = "Reporte de Adeudo de Documentos"
string menuname = "m_menu"
gb_3 gb_3
dw_1 dw_1
st_2 st_2
sle_adeudos sle_adeudos
rb_primer_ingreso_bach rb_primer_ingreso_bach
rb_reingreso rb_reingreso
rb_licenciatura rb_licenciatura
rb_maestria rb_maestria
rb_doctorado rb_doctorado
rb_primer_ingreso_todo rb_primer_ingreso_todo
uo_tipo_periodo uo_tipo_periodo
rb_tsu rb_tsu
gb_1 gb_1
gb_2 gb_2
end type
global w_reporte_adeudo_documentos w_reporte_adeudo_documentos

type variables
string is_nivel = "L"
string is_cve_grado = "L"
string is_grado2 = ""
string is_ingreso = "PI"
end variables

on w_reporte_adeudo_documentos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.gb_3=create gb_3
this.dw_1=create dw_1
this.st_2=create st_2
this.sle_adeudos=create sle_adeudos
this.rb_primer_ingreso_bach=create rb_primer_ingreso_bach
this.rb_reingreso=create rb_reingreso
this.rb_licenciatura=create rb_licenciatura
this.rb_maestria=create rb_maestria
this.rb_doctorado=create rb_doctorado
this.rb_primer_ingreso_todo=create rb_primer_ingreso_todo
this.uo_tipo_periodo=create uo_tipo_periodo
this.rb_tsu=create rb_tsu
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.st_2
this.Control[iCurrent+4]=this.sle_adeudos
this.Control[iCurrent+5]=this.rb_primer_ingreso_bach
this.Control[iCurrent+6]=this.rb_reingreso
this.Control[iCurrent+7]=this.rb_licenciatura
this.Control[iCurrent+8]=this.rb_maestria
this.Control[iCurrent+9]=this.rb_doctorado
this.Control[iCurrent+10]=this.rb_primer_ingreso_todo
this.Control[iCurrent+11]=this.uo_tipo_periodo
this.Control[iCurrent+12]=this.rb_tsu
this.Control[iCurrent+13]=this.gb_1
this.Control[iCurrent+14]=this.gb_2
end on

on w_reporte_adeudo_documentos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.sle_adeudos)
destroy(this.rb_primer_ingreso_bach)
destroy(this.rb_reingreso)
destroy(this.rb_licenciatura)
destroy(this.rb_maestria)
destroy(this.rb_doctorado)
destroy(this.rb_primer_ingreso_todo)
destroy(this.uo_tipo_periodo)
destroy(this.rb_tsu)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;dw_1.SetTransObject(gtr_sce) 

THIS.uo_tipo_periodo.f_genera_periodo( gtr_sce) 
THIS.uo_tipo_periodo.f_cambia_color( "29534863" )


end event

type p_uia from w_ancestral`p_uia within w_reporte_adeudo_documentos
end type

type gb_3 from groupbox within w_reporte_adeudo_documentos
integer x = 1993
integer y = 32
integer width = 631
integer height = 340
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Tipo Periodo"
end type

type dw_1 from uo_dw_reporte within w_reporte_adeudo_documentos
integer x = 78
integer y = 428
integer width = 3383
integer height = 1244
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_reporte_docs_lic_prim_ing"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event carga;

STRING ls_periodos[] 

ls_periodos[]  = PARENT.uo_tipo_periodo.f_recupera_seleccion() 

IF UPPERBOUND(ls_periodos) = 0 THEN 
	MESSAGEBOX("Aviso", "Debe seleccionar un tipo de periodo.") 
	RETURN -1
END IF

long ll_rows
IF is_ingreso = "PI" THEN 
	// Licenciatura y Postécnico 
	IF is_cve_grado = "L" OR is_cve_grado = "P" THEN
		dw_1.dataobject = "d_reporte_docs_lic_prim_ing"
		dw_1.SetTransObject(gtr_sce)
		//ll_rows  = this.Retrieve(is_ingreso,is_cve_grado, ls_periodos)		
		ll_rows  = this.Retrieve(ls_periodos, is_cve_grado)		 
	ELSE
		MessageBox("Combinación Incorrecta", "Favor de intentar otro reporte",StopSign!)
		return -1
	END IF
ELSEIF is_ingreso = "PIT" THEN 
	// Licenciatura y Postécnico 
	IF is_cve_grado = "L" OR is_cve_grado = "P" THEN
		dw_1.dataobject = "d_reporte_docs_lic_prim_ing_adeudo"
		dw_1.SetTransObject(gtr_sce)
		//ll_rows  = this.Retrieve(is_ingreso,is_cve_grado)		
		ll_rows  = this.Retrieve(ls_periodos, is_cve_grado)	 
	ELSE
		MessageBox("Combinación Incorrecta", "Favor de intentar otro reporte",StopSign!)
		return -1
	END IF
ELSEIF is_ingreso = "RI" THEN
	// Licenciatura y Postécnico
	IF is_cve_grado = "L" OR is_cve_grado = "P" THEN 
		dw_1.dataobject = "d_reporte_docs_lic_reing"
		dw_1.SetTransObject(gtr_sce)
		//ll_rows  = this.Retrieve(is_ingreso,is_cve_grado)		
		ll_rows  = this.Retrieve(ls_periodos, is_cve_grado)		
	ELSEIF is_cve_grado = "E" OR is_cve_grado = "M" THEN
		dw_1.dataobject = "d_reporte_docs_mae_esp"
		dw_1.SetTransObject(gtr_sce)
		//ll_rows  = this.Retrieve(is_ingreso,is_cve_grado)		
		ll_rows  = this.Retrieve(ls_periodos)		
//	ELSEIF is_cve_grado = "M" THEN
//		dw_1.dataobject = "d_reporte_docs_mae_esp"
//		dw_1.SetTransObject(gtr_sce)
//		ll_rows  = this.Retrieve(is_ingreso,is_cve_grado)		
	ELSEIF is_cve_grado = "D" THEN
		dw_1.dataobject = "d_reporte_docs_doc"
		dw_1.SetTransObject(gtr_sce)
//		ll_rows  = this.Retrieve(is_ingreso,is_cve_grado)
		ll_rows  = this.Retrieve(ls_periodos)		 
	END IF
	
END IF
sle_adeudos.text = string(ll_rows)

return ll_rows 




end event

type st_2 from statictext within w_reporte_adeudo_documentos
integer x = 2715
integer y = 136
integer width = 434
integer height = 60
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Total Adeudos:"
alignment alignment = right!
boolean focusrectangle = false
end type

type sle_adeudos from singlelineedit within w_reporte_adeudo_documentos
integer x = 3173
integer y = 116
integer width = 247
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

type rb_primer_ingreso_bach from radiobutton within w_reporte_adeudo_documentos
integer x = 613
integer y = 96
integer width = 599
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "1er. Ingreso Lic."
boolean checked = true
boolean lefttext = true
end type

event clicked;is_ingreso = "PI"
end event

type rb_reingreso from radiobutton within w_reporte_adeudo_documentos
integer x = 613
integer y = 280
integer width = 599
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Reingreso"
boolean lefttext = true
end type

event clicked;is_ingreso = "RI"
end event

type rb_licenciatura from radiobutton within w_reporte_adeudo_documentos
integer x = 1367
integer y = 100
integer width = 517
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Licenciatura"
boolean checked = true
boolean lefttext = true
end type

event clicked;is_nivel = "L"
is_cve_grado = "L"

end event

type rb_maestria from radiobutton within w_reporte_adeudo_documentos
integer x = 1367
integer y = 160
integer width = 517
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Maestría/Espec."
boolean lefttext = true
end type

event clicked;is_nivel = "P"
is_cve_grado = "M"
end event

type rb_doctorado from radiobutton within w_reporte_adeudo_documentos
integer x = 1367
integer y = 220
integer width = 517
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Doctorado"
boolean lefttext = true
end type

event clicked;is_nivel = "P"
is_cve_grado = "D"
end event

type rb_primer_ingreso_todo from radiobutton within w_reporte_adeudo_documentos
integer x = 613
integer y = 188
integer width = 599
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "1er. Ingreso Todos"
boolean lefttext = true
end type

event clicked;is_ingreso = "PIT"
end event

type uo_tipo_periodo from uo_periodo_tipo_chk within w_reporte_adeudo_documentos
integer x = 2066
integer y = 120
integer height = 176
integer taborder = 20
boolean bringtotop = true
long backcolor = 134217730
end type

on uo_tipo_periodo.destroy
call uo_periodo_tipo_chk::destroy
end on

event constructor;call super::constructor;
THIS.backcolor = 29534863
end event

type rb_tsu from radiobutton within w_reporte_adeudo_documentos
integer x = 1367
integer y = 284
integer width = 517
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "TSU"
boolean lefttext = true
end type

event clicked;is_nivel = "T"
is_cve_grado = "P"


end event

type gb_1 from groupbox within w_reporte_adeudo_documentos
integer x = 549
integer y = 32
integer width = 741
integer height = 340
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Alumnos"
end type

type gb_2 from groupbox within w_reporte_adeudo_documentos
integer x = 1330
integer y = 32
integer width = 631
integer height = 340
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29534863
string text = "Grado"
end type

