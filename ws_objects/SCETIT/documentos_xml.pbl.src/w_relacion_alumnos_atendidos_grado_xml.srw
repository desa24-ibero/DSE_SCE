$PBExportHeader$w_relacion_alumnos_atendidos_grado_xml.srw
forward
global type w_relacion_alumnos_atendidos_grado_xml from w_main
end type
type cb_get_folder from commandbutton within w_relacion_alumnos_atendidos_grado_xml
end type
type st_leyenda_ruta_archivo from statictext within w_relacion_alumnos_atendidos_grado_xml
end type
type st_ruta from statictext within w_relacion_alumnos_atendidos_grado_xml
end type
type rb_posgrado from radiobutton within w_relacion_alumnos_atendidos_grado_xml
end type
type rb_licenciatura from radiobutton within w_relacion_alumnos_atendidos_grado_xml
end type
type cb_generar_xml from u_cb within w_relacion_alumnos_atendidos_grado_xml
end type
type cb_cargar from u_cb within w_relacion_alumnos_atendidos_grado_xml
end type
type dw_1 from uo_dw_reporte within w_relacion_alumnos_atendidos_grado_xml
end type
type st_2 from statictext within w_relacion_alumnos_atendidos_grado_xml
end type
type st_1 from statictext within w_relacion_alumnos_atendidos_grado_xml
end type
type em_fecha_final from u_em within w_relacion_alumnos_atendidos_grado_xml
end type
type em_fecha_inicial from u_em within w_relacion_alumnos_atendidos_grado_xml
end type
type gb_nivel from groupbox within w_relacion_alumnos_atendidos_grado_xml
end type
end forward

global type w_relacion_alumnos_atendidos_grado_xml from w_main
integer width = 5221
integer height = 2700
string title = "Relación de Alumnos Atendidos por Grado "
string menuname = "m_menu"
cb_get_folder cb_get_folder
st_leyenda_ruta_archivo st_leyenda_ruta_archivo
st_ruta st_ruta
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
cb_generar_xml cb_generar_xml
cb_cargar cb_cargar
dw_1 dw_1
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
gb_nivel gb_nivel
end type
global w_relacion_alumnos_atendidos_grado_xml w_relacion_alumnos_atendidos_grado_xml

type variables
uo_genera_xml_cuenta iuo_genera_xml_cuenta


end variables

on w_relacion_alumnos_atendidos_grado_xml.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_get_folder=create cb_get_folder
this.st_leyenda_ruta_archivo=create st_leyenda_ruta_archivo
this.st_ruta=create st_ruta
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.cb_generar_xml=create cb_generar_xml
this.cb_cargar=create cb_cargar
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
this.gb_nivel=create gb_nivel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_get_folder
this.Control[iCurrent+2]=this.st_leyenda_ruta_archivo
this.Control[iCurrent+3]=this.st_ruta
this.Control[iCurrent+4]=this.rb_posgrado
this.Control[iCurrent+5]=this.rb_licenciatura
this.Control[iCurrent+6]=this.cb_generar_xml
this.Control[iCurrent+7]=this.cb_cargar
this.Control[iCurrent+8]=this.dw_1
this.Control[iCurrent+9]=this.st_2
this.Control[iCurrent+10]=this.st_1
this.Control[iCurrent+11]=this.em_fecha_final
this.Control[iCurrent+12]=this.em_fecha_inicial
this.Control[iCurrent+13]=this.gb_nivel
end on

on w_relacion_alumnos_atendidos_grado_xml.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_get_folder)
destroy(this.st_leyenda_ruta_archivo)
destroy(this.st_ruta)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.cb_generar_xml)
destroy(this.cb_cargar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
destroy(this.gb_nivel)
end on

event open;call super::open;x=1
y=1
end event

type cb_get_folder from commandbutton within w_relacion_alumnos_atendidos_grado_xml
integer x = 4229
integer y = 192
integer width = 114
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
string text = "..."
end type

event clicked;string ls_ruta
integer li_result
if not ISVALID(iuo_genera_xml_cuenta) then
	iuo_genera_xml_cuenta = CREATE uo_genera_xml_cuenta
	SQLCA = gtr_sce
else
	SQLCA = gtr_sce
end if
ls_ruta = st_ruta.text 
if ls_ruta = "" then
	ls_ruta = iuo_genera_xml_cuenta.of_obten_ruta_archivo('titulo_digital')
	st_ruta.text =  ls_ruta
end if


li_result = GetFolder( "Elija la Ruta de los archivos", ls_ruta )
st_ruta.text =  ls_ruta

end event

type st_leyenda_ruta_archivo from statictext within w_relacion_alumnos_atendidos_grado_xml
integer x = 1888
integer y = 196
integer width = 343
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Ruta Archivo"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_ruta from statictext within w_relacion_alumnos_atendidos_grado_xml
integer x = 2277
integer y = 196
integer width = 1915
integer height = 84
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 15793151
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type rb_posgrado from radiobutton within w_relacion_alumnos_atendidos_grado_xml
integer x = 1376
integer y = 184
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Posgrado"
end type

type rb_licenciatura from radiobutton within w_relacion_alumnos_atendidos_grado_xml
integer x = 1376
integer y = 100
integer width = 343
integer height = 64
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Licenciatura"
boolean checked = true
end type

type cb_generar_xml from u_cb within w_relacion_alumnos_atendidos_grado_xml
integer x = 4594
integer y = 52
integer taborder = 20
string text = "Generar XML"
end type

event clicked;call super::clicked;long ll_rows, ll_row_actual, ll_cuenta, ll_cve_carrera, ll_cve_plan
string ls_cuenta 

ll_rows = dw_1.RowCount()

if ll_rows = 0 then
	MessageBox("Sin Registros", "No existen registros a procesar",Stopsign!)
	return	
end if

if not ISVALID(iuo_genera_xml_cuenta) then
	iuo_genera_xml_cuenta = CREATE uo_genera_xml_cuenta
	SQLCA = gtr_sce
else
	SQLCA = gtr_sce
end if


for ll_row_actual=1 to ll_rows
	ll_cuenta = dw_1.GetItemNumber(ll_row_actual, "cuenta")
	ll_cve_carrera= dw_1.GetItemNumber(ll_row_actual, "cve_carrera")
	ll_cve_plan= dw_1.GetItemNumber(ll_row_actual, "cve_plan")
	ls_cuenta = string(ll_cuenta)
	
	iuo_genera_xml_cuenta.of_calcula_titulo(ll_cuenta, ll_cve_carrera, ll_cve_plan)
	iuo_genera_xml_cuenta.genera_xml(ls_cuenta)  
	
next


end event

type cb_cargar from u_cb within w_relacion_alumnos_atendidos_grado_xml
integer x = 2807
integer y = 52
integer taborder = 20
string text = "Cargar"
end type

event clicked;call super::clicked;string ls_ruta
dw_1.Triggerevent("carga")
if not ISVALID(iuo_genera_xml_cuenta) then
	iuo_genera_xml_cuenta = CREATE uo_genera_xml_cuenta
	SQLCA = gtr_sce
else
	SQLCA = gtr_sce
end if

ls_ruta = iuo_genera_xml_cuenta.of_obten_ruta_archivo('titulo_digital')
st_ruta.text =  ls_ruta


end event

type dw_1 from uo_dw_reporte within w_relacion_alumnos_atendidos_grado_xml
integer x = 101
integer y = 312
integer width = 4873
integer height = 2112
integer taborder = 30
string dataobject = "d_relacion_alumnos_atendidos_grado"
boolean hscrollbar = true
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio=gtr_sce
this.SetTransObject(tr_dw_propio)
end event

event carga;string ls_fecha_inicial, ls_fecha_final
date ldt_fecha_inicial, ldt_fecha_final
datetime ldttm_fecha_inicial, ldttm_fecha_final
integer li_num_registros, li_cve_constancia, li_cve_estatus_solicitud
long ll_row_estatus_solicitud
long ll_area_coordinacion, ll_responsable
string ls_area_coordinacion, ls_estatus_solicitud
string ls_licenciatura, ls_posgrado, ls_nivel

if isnull(dw_1.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

IF rb_licenciatura.checked then
	ls_nivel = 'L'
ELSEIF rb_posgrado.checked then
	ls_nivel = 'P'
ELSE
	MessageBox('Sin nivel', "Es obligatorio elegir un Nivel", StopSign!)
	return -1
END IF



if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final, ls_nivel)

return li_num_registros



end event

type st_2 from statictext within w_relacion_alumnos_atendidos_grado_xml
integer x = 110
integer y = 200
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final:"
boolean focusrectangle = false
end type

type st_1 from statictext within w_relacion_alumnos_atendidos_grado_xml
integer x = 110
integer y = 84
integer width = 366
integer height = 52
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial:"
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_relacion_alumnos_atendidos_grado_xml
integer x = 530
integer y = 184
integer width = 320
integer height = 84
integer taborder = 20
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_relacion_alumnos_atendidos_grado_xml
integer x = 530
integer y = 68
integer width = 320
integer height = 84
integer taborder = 10
alignment alignment = center!
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type gb_nivel from groupbox within w_relacion_alumnos_atendidos_grado_xml
integer x = 1330
integer y = 24
integer width = 453
integer height = 256
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Nivel"
end type

