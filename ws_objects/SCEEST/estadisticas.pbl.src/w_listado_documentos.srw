$PBExportHeader$w_listado_documentos.srw
forward
global type w_listado_documentos from w_ancestral
end type
type uo_1 from uo_per_ani within w_listado_documentos
end type
type dw_listados_documentos from uo_dw_reporte within w_listado_documentos
end type
type ddlb_busca from dropdownlistbox within w_listado_documentos
end type
type uo_carr from uo_carrera within w_listado_documentos
end type
type rb_normal from radiobutton within w_listado_documentos
end type
type rb_bloqueados_inscritos from radiobutton within w_listado_documentos
end type
type rb_bloqueados_inscritos_detallado from radiobutton within w_listado_documentos
end type
end forward

global type w_listado_documentos from w_ancestral
integer height = 2320
string title = "Listado de Documentos"
string menuname = "m_menu"
uo_1 uo_1
dw_listados_documentos dw_listados_documentos
ddlb_busca ddlb_busca
uo_carr uo_carr
rb_normal rb_normal
rb_bloqueados_inscritos rb_bloqueados_inscritos
rb_bloqueados_inscritos_detallado rb_bloqueados_inscritos_detallado
end type
global w_listado_documentos w_listado_documentos

on w_listado_documentos.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_listados_documentos=create dw_listados_documentos
this.ddlb_busca=create ddlb_busca
this.uo_carr=create uo_carr
this.rb_normal=create rb_normal
this.rb_bloqueados_inscritos=create rb_bloqueados_inscritos
this.rb_bloqueados_inscritos_detallado=create rb_bloqueados_inscritos_detallado
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.dw_listados_documentos
this.Control[iCurrent+3]=this.ddlb_busca
this.Control[iCurrent+4]=this.uo_carr
this.Control[iCurrent+5]=this.rb_normal
this.Control[iCurrent+6]=this.rb_bloqueados_inscritos
this.Control[iCurrent+7]=this.rb_bloqueados_inscritos_detallado
end on

on w_listado_documentos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_listados_documentos)
destroy(this.ddlb_busca)
destroy(this.uo_carr)
destroy(this.rb_normal)
destroy(this.rb_bloqueados_inscritos)
destroy(this.rb_bloqueados_inscritos_detallado)
end on

event open;call super::open;dw_listados_documentos.settransobject(gtr_sce)
end event

type p_uia from w_ancestral`p_uia within w_listado_documentos
end type

type uo_1 from uo_per_ani within w_listado_documentos
integer x = 2290
integer y = 32
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_listados_documentos from uo_dw_reporte within w_listado_documentos
integer x = 0
integer y = 512
integer width = 3506
integer height = 1616
integer taborder = 20
boolean titlebar = true
string dataobject = "d_listados_documentos"
boolean minbox = true
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
boolean border = true
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sce
end event

event carga;integer li_periodo,li_anio

SetPointer(Hourglass!)
IF rb_normal.checked THEN
	this.dataobject = 'd_listados_documentos'
	this.settransobject(gtr_sce)
	CHOOSE CASE ddlb_busca.text
		CASE "Primer Ingreso en..."
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,academicos.nivel,academicos.cve_carrera,academicos.cve_plan,alumnos.apaterno,alumnos.amaterno,alumnos.nombre,dbo.tipo_documento.cve_documento,dbo.tipo_documento.documento,dbo.flag_documentos.cve_flag_documento,dbo.flag_documentos.desc_flag_documento FROM academicos,alumnos,dbo.documentos,dbo.tipo_documento,dbo.flag_documentos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( alumnos.cuenta = dbo.documentos.cuenta ) and ( dbo.documentos.cve_documento = dbo.tipo_documento.cve_documento ) and ( dbo.documentos.cve_flag_documento = dbo.flag_documentos.cve_flag_documento ) and ( academicos.periodo_ing = :peri ) AND ( academicos.anio_ing = :anio ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr)'")
		CASE "Egresados en..."
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,academicos.nivel,academicos.cve_carrera,academicos.cve_plan,alumnos.apaterno,alumnos.amaterno,alumnos.nombre,dbo.tipo_documento.cve_documento,dbo.tipo_documento.documento,dbo.flag_documentos.cve_flag_documento,dbo.flag_documentos.desc_flag_documento FROM academicos,alumnos,dbo.documentos,dbo.tipo_documento,dbo.flag_documentos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( alumnos.cuenta = dbo.documentos.cuenta ) and ( dbo.documentos.cve_documento = dbo.tipo_documento.cve_documento ) and ( dbo.documentos.cve_flag_documento = dbo.flag_documentos.cve_flag_documento ) and ( academicos.periodo_egre = :peri ) AND ( academicos.anio_egre = :anio ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr) AND ( academicos.egresado = 1 )'")
		CASE "Inscritos en..."
//Comentado 2015-06_30			
//			periodo_actual(li_periodo,li_anio,gtr_sce)
			periodo_actual_mat_insc(li_periodo,li_anio,gtr_sce)
			if li_periodo=gi_periodo and li_anio=gi_anio then
				Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,academicos.nivel,academicos.cve_carrera,academicos.cve_plan,alumnos.apaterno,alumnos.amaterno,alumnos.nombre,dbo.tipo_documento.cve_documento,dbo.tipo_documento.documento,dbo.flag_documentos.cve_flag_documento,dbo.flag_documentos.desc_flag_documento FROM academicos,alumnos,dbo.documentos,dbo.tipo_documento,dbo.flag_documentos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( alumnos.cuenta = dbo.documentos.cuenta ) and ( dbo.documentos.cve_documento = dbo.tipo_documento.cve_documento ) and ( dbo.documentos.cve_flag_documento = dbo.flag_documentos.cve_flag_documento ) and ( :carr = 9999 OR academicos.cve_carrera = :carr) and ( academicos.cuenta in (SELECT DISTINCT mat_inscritas.cuenta FROM mat_inscritas WHERE mat_inscritas.periodo = :peri AND mat_inscritas.anio = :anio ) )'")
			else
				Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,academicos.nivel,academicos.cve_carrera,academicos.cve_plan,alumnos.apaterno,alumnos.amaterno,alumnos.nombre,dbo.tipo_documento.cve_documento,dbo.tipo_documento.documento,dbo.flag_documentos.cve_flag_documento,dbo.flag_documentos.desc_flag_documento FROM academicos,alumnos,dbo.documentos,dbo.tipo_documento,dbo.flag_documentos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( alumnos.cuenta = dbo.documentos.cuenta ) and ( dbo.documentos.cve_documento = dbo.tipo_documento.cve_documento ) and ( dbo.documentos.cve_flag_documento = dbo.flag_documentos.cve_flag_documento ) and ( :carr = 9999 OR academicos.cve_carrera = :carr) and ( academicos.cuenta in (SELECT DISTINCT historico.cuenta FROM historico WHERE historico.periodo = :peri AND historico.anio = :anio ) )'")
			end if
		CASE "TODOS..."
			Modify("DataWindow.Table.Select = 'SELECT DISTINCT academicos.cuenta,academicos.nivel,academicos.cve_carrera,academicos.cve_plan,alumnos.apaterno,alumnos.amaterno,alumnos.nombre,dbo.tipo_documento.cve_documento,dbo.tipo_documento.documento,dbo.flag_documentos.cve_flag_documento,dbo.flag_documentos.desc_flag_documento FROM academicos,alumnos,dbo.documentos,dbo.tipo_documento,dbo.flag_documentos WHERE ( alumnos.cuenta = academicos.cuenta ) and ( alumnos.cuenta = dbo.documentos.cuenta ) and ( dbo.documentos.cve_documento = dbo.tipo_documento.cve_documento ) and ( dbo.documentos.cve_flag_documento = dbo.flag_documentos.cve_flag_documento ) AND ( :carr = 9999 OR academicos.cve_carrera = :carr)'")
	END CHOOSE
event primero()
return retrieve(gi_periodo,gi_anio,uo_carr.dw_carrera.object.cve_carrera[uo_carr.dw_carrera.getrow()])
ELSEIF rb_bloqueados_inscritos.checked then
	this.dataobject = 'd_listados_baja_documentos_inscritos'
	this.settransobject(gtr_sce)
	RETURN retrieve()
ELSEIF rb_bloqueados_inscritos_detallado.checked then
	this.dataobject = 'd_listados_baja_documentos_inscritos_det'
	this.settransobject(gtr_sce)
	RETURN retrieve()
END IF 

end event

type ddlb_busca from dropdownlistbox within w_listado_documentos
integer x = 1737
integer y = 68
integer width = 544
integer height = 228
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
string text = "Inscritos en..."
boolean vscrollbar = true
string item[] = {"Inscritos en...","Primer Ingreso en...","Egresados en...","TODOS..."}
end type

type uo_carr from uo_carrera within w_listado_documentos
integer x = 384
integer y = 16
integer width = 1344
integer height = 204
integer taborder = 1
boolean enabled = true
long backcolor = 1090519039
end type

on uo_carr.destroy
call uo_carrera::destroy
end on

type rb_normal from radiobutton within w_listado_documentos
integer x = 2286
integer y = 220
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217731
string text = "Normal"
boolean checked = true
end type

type rb_bloqueados_inscritos from radiobutton within w_listado_documentos
integer x = 2286
integer y = 308
integer width = 672
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217731
string text = "Bloqueados - Inscritos"
end type

type rb_bloqueados_inscritos_detallado from radiobutton within w_listado_documentos
integer x = 2286
integer y = 396
integer width = 974
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 134217731
string text = "Bloqueados - Inscritos - Detallado"
end type

