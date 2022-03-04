$PBExportHeader$w_reporte_asistencia.srw
forward
global type w_reporte_asistencia from w_ancestral
end type
type gb_1 from groupbox within w_reporte_asistencia
end type
type dw_reporte_asistencia from uo_dw_reporte within w_reporte_asistencia
end type
type st_periodo from statictext within w_reporte_asistencia
end type
type st_anio from statictext within w_reporte_asistencia
end type
type cb_guardartotales from commandbutton within w_reporte_asistencia
end type
type dw_coordinacion from datawindow within w_reporte_asistencia
end type
type vsb_coordinacion from vscrollbar within w_reporte_asistencia
end type
type rb_todas from radiobutton within w_reporte_asistencia
end type
type rb_semanas from radiobutton within w_reporte_asistencia
end type
type gb_2 from groupbox within w_reporte_asistencia
end type
type rb_materia from radiobutton within w_reporte_asistencia
end type
type rb_profesor from radiobutton within w_reporte_asistencia
end type
end forward

global type w_reporte_asistencia from w_ancestral
integer width = 3602
integer height = 2032
string menuname = "m_menu"
gb_1 gb_1
dw_reporte_asistencia dw_reporte_asistencia
st_periodo st_periodo
st_anio st_anio
cb_guardartotales cb_guardartotales
dw_coordinacion dw_coordinacion
vsb_coordinacion vsb_coordinacion
rb_todas rb_todas
rb_semanas rb_semanas
gb_2 gb_2
rb_materia rb_materia
rb_profesor rb_profesor
end type
global w_reporte_asistencia w_reporte_asistencia

type variables
int ii_anio, ii_periodo, ii_cve_coordinacion
uo_periodo_servicios  iuo_periodo_servicios
end variables

on w_reporte_asistencia.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.gb_1=create gb_1
this.dw_reporte_asistencia=create dw_reporte_asistencia
this.st_periodo=create st_periodo
this.st_anio=create st_anio
this.cb_guardartotales=create cb_guardartotales
this.dw_coordinacion=create dw_coordinacion
this.vsb_coordinacion=create vsb_coordinacion
this.rb_todas=create rb_todas
this.rb_semanas=create rb_semanas
this.gb_2=create gb_2
this.rb_materia=create rb_materia
this.rb_profesor=create rb_profesor
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_reporte_asistencia
this.Control[iCurrent+3]=this.st_periodo
this.Control[iCurrent+4]=this.st_anio
this.Control[iCurrent+5]=this.cb_guardartotales
this.Control[iCurrent+6]=this.dw_coordinacion
this.Control[iCurrent+7]=this.vsb_coordinacion
this.Control[iCurrent+8]=this.rb_todas
this.Control[iCurrent+9]=this.rb_semanas
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.rb_materia
this.Control[iCurrent+12]=this.rb_profesor
end on

on w_reporte_asistencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.dw_reporte_asistencia)
destroy(this.st_periodo)
destroy(this.st_anio)
destroy(this.cb_guardartotales)
destroy(this.dw_coordinacion)
destroy(this.vsb_coordinacion)
destroy(this.rb_todas)
destroy(this.rb_semanas)
destroy(this.gb_2)
destroy(this.rb_materia)
destroy(this.rb_profesor)
end on

event open;call super::open;string ls_descripcion_usuario
integer li_periodo_mi, li_anio_mi
periodo_actual_mat_insc(li_periodo_mi, li_anio_mi, gtr_sce)


dw_reporte_asistencia.DataObject = "d_reporte_asistencia_por_profesor"
dw_reporte_asistencia.SetTransObject(gtr_sce)

ls_descripcion_usuario= f_obten_descripcion_usuario()
ii_cve_coordinacion= f_obten_coordinacion()
if ii_cve_coordinacion = 0 then ii_cve_coordinacion = 9999
if ii_cve_coordinacion = 9999 then
	dw_coordinacion.enabled = true
	dw_coordinacion.visible = true
//	vsb_coordinacion.enabled = true
	vsb_coordinacion.visible = true
else
	dw_coordinacion.enabled = false
	dw_coordinacion.visible = false
//	vsb_coordinacion.enabled = false
	vsb_coordinacion.visible = false
end if

this.Title = "Reporte de asistencia generado por "+ls_descripcion_usuario+" de la coordinacion "+string(ii_cve_coordinacion)


if f_obten_periodo(ii_periodo, ii_anio, 1) = 1 then
	dw_reporte_asistencia.DataObject = "d_reporte_asistencia_por_profesor"
	dw_reporte_asistencia.SetTransObject(gtr_sce)
	if ii_periodo <> li_periodo_mi or ii_anio <>li_anio_mi then
		dw_reporte_asistencia.DataObject = 'd_reporte_asistencia_por_prof_hist'		
		dw_reporte_asistencia.SetTransObject(gtr_sce)
	end if
	
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
	st_periodo.text = iuo_periodo_servicios.f_recupera_descripcion(ii_periodo , "L")
/*	
	choose case ii_periodo
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
m_menu.m_archivo.m_leer.Visible = False
m_menu.m_archivo.m_leer.Enabled = False
m_menu.m_registro.m_nuevo.Visible = False
m_menu.m_registro.m_nuevo.Enabled = False
m_menu.m_registro.m_actualiza.Visible = False
m_menu.m_registro.m_actualiza.Enabled = False
m_menu.m_registro.m_borraregistro.Visible = False
m_menu.m_registro.m_borraregistro.Enabled = False
m_menu.m_registro.m_filtrar.Visible = False
m_menu.m_registro.m_filtrar.Enabled = False
m_menu.m_registro.m_ordenar.Visible = False
m_menu.m_registro.m_ordenar.Enabled = False

end event

type p_uia from w_ancestral`p_uia within w_reporte_asistencia
end type

type gb_1 from groupbox within w_reporte_asistencia
integer x = 2935
integer y = 44
integer width = 562
integer height = 316
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
string text = "Ordenar"
end type

type dw_reporte_asistencia from uo_dw_reporte within w_reporte_asistencia
event guargaconargs ( integer ai_totcol,  integer ai_coltype[100],  string as_colname[100] )
integer x = 105
integer y = 516
integer width = 3387
integer height = 1244
integer taborder = 10
boolean bringtotop = true
string dataobject = "d_reporte_asistencia_por_profesor"
boolean hscrollbar = true
end type

event guargaconargs;//0 number(int, long o real), 1 string, 2 datetime
string ls_ruta,ls_nombre,ls_cadena1, ls_cadena2
int li_i, li_ret, li_file, li_j

li_ret = RowCount()
if li_ret > 0 then
	ls_ruta = ""
	ls_nombre = ""
	if (GetFileSaveName ( "Guardar reporte de inscritos", ls_ruta,&
							ls_nombre , ".txt" ,"Archivos de texto (*.TXT),*.TXT," )= 1 ) then
		SetPointer(Hourglass!)
		li_file = FileOpen(ls_ruta, StreamMode!, Write!, LockReadWrite!, Replace!)
		for li_j = 1 to ai_totcol
			FileWrite(li_file,as_colname[li_j])
			if li_j <> ai_totcol then
				FileWrite(li_file,"~t")
			else
				FileWrite(li_file,"~n")
			end if
		next
		ls_cadena1 = ""
		for li_i = 1 to li_ret
			ls_cadena2 = string(GetItemNumber(li_i,"profesor_lista_asistencia_cve_mat"))+"-"+&
								GetItemstring(li_i,"profesor_lista_asistencia_gpo")+"-"+&
								string(GetItemNumber(li_i,"profesor_lista_asistencia_cve_asistencia"))
			if ls_cadena1 <> ls_cadena2 then
				ls_cadena1 = ls_cadena2
				for li_j = 1 to ai_totcol
					choose case ai_coltype[li_j]
						case 0
							FileWrite(li_file,string(GetItemNumber(li_i, as_colname[li_j])))
						case 1
							FileWrite(li_file,GetItemString(li_i, as_colname[li_j]))
						case 2
							FileWrite(li_file,string(GetItemDateTime(li_i, as_colname[li_j])))
					end choose
					if as_colname[li_j]="profesor_lista_asistencia_cve_asistencia" then
						choose case GetItemNumber(li_i, as_colname[li_j])
							case 0
								FileWrite(li_file," No Aplica")
							case 1
								FileWrite(li_file," No capturado")
							case 2
								FileWrite(li_file," Falta")
							case 3
								FileWrite(li_file," Falta justificada")
							case 4
								FileWrite(li_file," Asistencia")
							case 5
								FileWrite(li_file," Reposición")
						end choose
					end if
					if li_j <> ai_totcol then
						FileWrite(li_file,"~t")
					else
						FileWrite(li_file,"~n")
					end if		
				next
			end if
		next
		FileClose(li_file)
		SetPointer(Arrow!)
	end if
else
	MessageBox("Atención","No hay algo que salvar")
end if
end event

event carga;int li_cve_coordinacion
if ii_cve_coordinacion = 9999 then
	li_cve_coordinacion = dw_coordinacion.GetItemNumber(dw_coordinacion.GetRow(),"cve_coordinacion")
else
	li_cve_coordinacion = ii_cve_coordinacion
end if

return retrieve(ii_periodo, ii_anio, li_cve_coordinacion)
end event

event constructor;call super::constructor;SetTransObject(gtr_sce)
end event

type st_periodo from statictext within w_reporte_asistencia
integer x = 1659
integer y = 68
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
long backcolor = 134217731
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type st_anio from statictext within w_reporte_asistencia
integer x = 2286
integer y = 68
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
long backcolor = 134217731
boolean enabled = false
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_guardartotales from commandbutton within w_reporte_asistencia
integer x = 425
integer y = 380
integer width = 654
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar Totales"
end type

event clicked;//0 number(int, long o real), 1 string, 2 datetime
int li_totcol
int li_coltype[100]
string ls_colname[100]

if rb_materia.checked = true then
	li_totcol = 8
	ls_colname = {"materias_cve_coordinacion","profesor_lista_asistencia_cve_mat",&
	"profesor_lista_asistencia_gpo","profesor_cve_profesor",&
	"profesor_nombre_completo","profesor_lista_asistencia_cve_asistencia",&
	"porcentaje_materia_profesor","relacion_materia_profesor"}
	li_coltype = {0,0,1,0,1,0,0,1}
else
	li_totcol = 14
	ls_colname = {"materias_cve_coordinacion","profesor_lista_asistencia_cve_mat",&
	"profesor_lista_asistencia_gpo","profesor_cve_profesor",&
	"profesor_nombre_completo","profesor_lista_asistencia_cve_asistencia",&
	"porcentaje_materia_profesor","relacion_materia_profesor",&
	"promedio_profesor_asistencia","promedio_profesor_reposicion","promedio_profesor_falta",&
	"promedio_profesor_faltajus","promedio_profesor_nocap","promedio_profesor_noaplica"}
	li_coltype = {0,0,1,0,1,0,0,1,0,0,0,0,0,0}
end if


dw_reporte_asistencia.event guargaconargs(li_totcol,li_coltype,ls_colname)
end event

type dw_coordinacion from datawindow within w_reporte_asistencia
integer x = 1143
integer y = 380
integer width = 1824
integer height = 108
integer taborder = 40
boolean bringtotop = true
string dataobject = "d_coordinacion"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;SetTransObject(gtr_sce)
int i
i = retrieve()
Object.DataWindow.Zoom = 70
scrolltorow(rowcount())
end event

type vsb_coordinacion from vscrollbar within w_reporte_asistencia
integer x = 2967
integer y = 380
integer width = 73
integer height = 104
boolean bringtotop = true
end type

event linedown;dw_coordinacion.ScrollToRow(dw_coordinacion.GetRow()+1)
end event

event lineup;dw_coordinacion.ScrollToRow(dw_coordinacion.GetRow()-1)
end event

type rb_todas from radiobutton within w_reporte_asistencia
integer x = 457
integer y = 216
integer width = 453
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
string text = "Todas"
boolean checked = true
end type

event clicked;integer li_periodo_mi, li_anio_mi
periodo_actual_mat_insc(li_periodo_mi, li_anio_mi, gtr_sce)

if rb_profesor.checked then	
	dw_reporte_asistencia.DataObject = "d_reporte_asistencia_por_profesor"	
end if

dw_reporte_asistencia.SetTransObject(gtr_sce)

if ii_periodo<> li_periodo_mi or ii_anio<>li_anio_mi then
	if rb_profesor.checked then
		dw_reporte_asistencia.DataObject = 'd_reporte_asistencia_por_prof_hist'				
	end if
	dw_reporte_asistencia.SetTransObject(gtr_sce)
end if


dw_reporte_asistencia.modify("Datawindow.print.preview = Yes")
dw_reporte_asistencia.event carga()
end event

type rb_semanas from radiobutton within w_reporte_asistencia
integer x = 457
integer y = 124
integer width = 549
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
string text = "Agrupa Semanas"
end type

event clicked;integer li_periodo_mi, li_anio_mi
periodo_actual_mat_insc(li_periodo_mi, li_anio_mi, gtr_sce)

if rb_profesor.checked then	
	dw_reporte_asistencia.DataObject = "d_reporte_asistencia_prof_sem"	
end if

dw_reporte_asistencia.SetTransObject(gtr_sce)

if ii_periodo<> li_periodo_mi or ii_anio<>li_anio_mi then
	if rb_profesor.checked then
		dw_reporte_asistencia.DataObject = 'd_reporte_asist_prof_sem_hist'				
	end if
	dw_reporte_asistencia.SetTransObject(gtr_sce)
end if


dw_reporte_asistencia.modify("Datawindow.print.preview = Yes")
dw_reporte_asistencia.event carga()
end event

type gb_2 from groupbox within w_reporte_asistencia
integer x = 421
integer y = 36
integer width = 613
integer height = 316
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 29405071
string text = "Semanas Profesor"
end type

type rb_materia from radiobutton within w_reporte_asistencia
integer x = 2976
integer y = 132
integer width = 453
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
string text = "Por materia"
end type

event clicked;integer li_periodo_mi, li_anio_mi
periodo_actual_mat_insc(li_periodo_mi, li_anio_mi, gtr_sce)

rb_todas.enabled= false
rb_semanas.enabled= false

dw_reporte_asistencia.DataObject = "d_reporte_asistencia"
dw_reporte_asistencia.SetTransObject(gtr_sce)

if ii_periodo<> li_periodo_mi or ii_anio<>li_anio_mi then
	dw_reporte_asistencia.DataObject = 'd_reporte_asistencia_hist'		
	dw_reporte_asistencia.SetTransObject(gtr_sce)
end if


dw_reporte_asistencia.modify("Datawindow.print.preview = Yes")
dw_reporte_asistencia.event carga()
end event

type rb_profesor from radiobutton within w_reporte_asistencia
integer x = 2976
integer y = 236
integer width = 453
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
string text = "Por profesor"
boolean checked = true
end type

event clicked;integer li_periodo_mi, li_anio_mi
periodo_actual_mat_insc(li_periodo_mi, li_anio_mi, gtr_sce)

rb_todas.enabled= true
rb_semanas.enabled= true

if rb_todas.checked then
	dw_reporte_asistencia.DataObject = "d_reporte_asistencia_por_profesor"
else
	dw_reporte_asistencia.DataObject = "d_reporte_asistencia_prof_sem"	
end if

dw_reporte_asistencia.SetTransObject(gtr_sce)

if ii_periodo<> li_periodo_mi or ii_anio<>li_anio_mi then
	if rb_todas.checked then
		dw_reporte_asistencia.DataObject = 'd_reporte_asistencia_por_prof_hist'		
	else
		dw_reporte_asistencia.DataObject = 'd_reporte_asist_prof_sem_hist'				
	end if
	dw_reporte_asistencia.SetTransObject(gtr_sce)
end if


dw_reporte_asistencia.modify("Datawindow.print.preview = Yes")
dw_reporte_asistencia.event carga()
end event

