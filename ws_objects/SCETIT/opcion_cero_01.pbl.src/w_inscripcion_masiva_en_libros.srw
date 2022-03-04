$PBExportHeader$w_inscripcion_masiva_en_libros.srw
forward
global type w_inscripcion_masiva_en_libros from w_main
end type
type cb_inscribir from u_cb within w_inscripcion_masiva_en_libros
end type
type cb_cargar from u_cb within w_inscripcion_masiva_en_libros
end type
type dw_1 from uo_dw_reporte within w_inscripcion_masiva_en_libros
end type
type st_2 from statictext within w_inscripcion_masiva_en_libros
end type
type st_1 from statictext within w_inscripcion_masiva_en_libros
end type
type em_fecha_final from u_em within w_inscripcion_masiva_en_libros
end type
type em_fecha_inicial from u_em within w_inscripcion_masiva_en_libros
end type
end forward

global type w_inscripcion_masiva_en_libros from w_main
integer x = 466
integer y = 372
integer width = 3105
integer height = 1782
string title = "Inscripción Masiva en Libros"
string menuname = "m_menu"
cb_inscribir cb_inscribir
cb_cargar cb_cargar
dw_1 dw_1
st_2 st_2
st_1 st_1
em_fecha_final em_fecha_final
em_fecha_inicial em_fecha_inicial
end type
global w_inscripcion_masiva_en_libros w_inscripcion_masiva_en_libros

on w_inscripcion_masiva_en_libros.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_inscribir=create cb_inscribir
this.cb_cargar=create cb_cargar
this.dw_1=create dw_1
this.st_2=create st_2
this.st_1=create st_1
this.em_fecha_final=create em_fecha_final
this.em_fecha_inicial=create em_fecha_inicial
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_inscribir
this.Control[iCurrent+2]=this.cb_cargar
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.em_fecha_final
this.Control[iCurrent+7]=this.em_fecha_inicial
end on

on w_inscripcion_masiva_en_libros.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_inscribir)
destroy(this.cb_cargar)
destroy(this.dw_1)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.em_fecha_final)
destroy(this.em_fecha_inicial)
end on

event open;call super::open;x=1
y=1
end event

type cb_inscribir from u_cb within w_inscripcion_masiva_en_libros
integer x = 1342
integer y = 1430
integer width = 351
integer height = 93
integer taborder = 20
string text = "Inscribir"
end type

event clicked;call super::clicked;integer li_confirmacion, li_insercion
long ll_row, ll_rows_totales
long ll_cuenta, ll_cve_carrera, ll_cve_plan
uo_atencion_opc_cero luo_atencion_opc_cero
ll_rows_totales = dw_1.RowCount()

if ll_rows_totales= 0 then
	MessageBox("Sin Datos","No existen registros a insertar", Information!)	
	return
end if

li_confirmacion= MessageBox("Confirmación","¿Desea inscribir a los ["+string(ll_rows_totales)+"] Alumnos?", Question!, YesNo!)

if li_confirmacion= 1 then
	luo_atencion_opc_cero = CREATE uo_atencion_opc_cero
	SetPointer(HourGlass!)
	FOR ll_row = 1 to ll_rows_totales
		ll_cuenta = dw_1.GetItemNumber(ll_row,"cuenta")
		ll_cve_carrera = dw_1.GetItemNumber(ll_row,"cve_carrera")
		ll_cve_plan = dw_1.GetItemNumber(ll_row,"cve_plan")	
		if ll_cuenta>0 and ll_cve_carrera>0 and ll_cve_plan>0 then
			li_insercion= luo_atencion_opc_cero.of_inserta_hoja_libro_carrera(ll_cuenta,ll_cve_carrera, ll_cve_plan )
			if li_insercion = -1 then
				MessageBox("Error de Insercion", "No es posible continuar la insercion", StopSign!)
				return
			end if
		end if
	NEXT	
end if
MessageBox("Insercion Exitosa", "Se insertaron ["+string(ll_rows_totales)+"] Alumnos", Information!)

end event

type cb_cargar from u_cb within w_inscripcion_masiva_en_libros
integer x = 1342
integer y = 106
integer width = 351
integer height = 93
integer taborder = 20
string text = "Cargar"
end type

event clicked;call super::clicked;dw_1.Triggerevent("carga")

end event

type dw_1 from uo_dw_reporte within w_inscripcion_masiva_en_libros
integer x = 99
integer y = 310
integer width = 2842
integer height = 1050
integer taborder = 30
string dataobject = "d_inscripcion_masiva_en_libros"
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

if isnull(dw_1.DataObject) then
	return 0
end if

ls_fecha_inicial= em_fecha_inicial.text
ls_fecha_final= em_fecha_final.text

ldt_fecha_inicial =date(ls_fecha_inicial)
ldt_fecha_final =date(ls_fecha_final)

if ldt_fecha_final < ldt_fecha_inicial then
	MessageBox("Error de fechas","La fecha inicial no debe ser mayor a la fecha final")
end if 



ldt_fecha_final= RelativeDate(ldt_fecha_final, +1)

ldttm_fecha_inicial =datetime(ldt_fecha_inicial)
ldttm_fecha_final =datetime(ldt_fecha_final)

li_num_registros= dw_1.retrieve(ldttm_fecha_inicial, ldttm_fecha_final)

return li_num_registros



end event

type st_2 from statictext within w_inscripcion_masiva_en_libros
integer x = 183
integer y = 198
integer width = 366
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Final:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_1 from statictext within w_inscripcion_masiva_en_libros
integer x = 183
integer y = 83
integer width = 366
integer height = 51
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Fecha Inicial:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fecha_final from u_em within w_inscripcion_masiva_en_libros
integer x = 677
integer y = 182
integer width = 289
integer taborder = 20
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

type em_fecha_inicial from u_em within w_inscripcion_masiva_en_libros
integer x = 677
integer y = 67
integer width = 289
integer taborder = 10
maskdatatype maskdatatype = datetimemask!
string mask = "dd/mm/yyyy"
end type

