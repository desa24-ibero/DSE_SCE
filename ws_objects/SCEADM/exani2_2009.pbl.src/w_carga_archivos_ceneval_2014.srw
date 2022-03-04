$PBExportHeader$w_carga_archivos_ceneval_2014.srw
forward
global type w_carga_archivos_ceneval_2014 from w_main
end type
type cbx_matricula_es_folio from u_cbx within w_carga_archivos_ceneval_2014
end type
type cbx_utiliza_query from u_cbx within w_carga_archivos_ceneval_2014
end type
type mle_query from multilineedit within w_carga_archivos_ceneval_2014
end type
type cb_5 from u_cb within w_carga_archivos_ceneval_2014
end type
type st_num_insertados from u_st within w_carga_archivos_ceneval_2014
end type
type st_num_consultados from u_st within w_carga_archivos_ceneval_2014
end type
type cb_4 from u_cb within w_carga_archivos_ceneval_2014
end type
type cb_3 from u_cb within w_carga_archivos_ceneval_2014
end type
type uo_1 from uo_ver_per_ani within w_carga_archivos_ceneval_2014
end type
type dw_resultado_archivo_exani_2 from u_dw within w_carga_archivos_ceneval_2014
end type
type cb_2 from u_cb within w_carga_archivos_ceneval_2014
end type
type lb_nombre_tablas from u_lb within w_carga_archivos_ceneval_2014
end type
type cb_1 from u_cb within w_carga_archivos_ceneval_2014
end type
type cb_copia_archivos from u_cb within w_carga_archivos_ceneval_2014
end type
type lb_nombre_archivos from u_lb within w_carga_archivos_ceneval_2014
end type
type lb_ruta_archivos from u_lb within w_carga_archivos_ceneval_2014
end type
type mle_selected from u_mle within w_carga_archivos_ceneval_2014
end type
type cb_carga_archivos from u_cb within w_carga_archivos_ceneval_2014
end type
type dw_resultados_archivo_ceneval from u_dw within w_carga_archivos_ceneval_2014
end type
type gb_1 from u_gb within w_carga_archivos_ceneval_2014
end type
end forward

global type w_carga_archivos_ceneval_2014 from w_main
integer width = 3707
integer height = 2544
string title = "Lectura de Archivos de Resultados"
cbx_matricula_es_folio cbx_matricula_es_folio
cbx_utiliza_query cbx_utiliza_query
mle_query mle_query
cb_5 cb_5
st_num_insertados st_num_insertados
st_num_consultados st_num_consultados
cb_4 cb_4
cb_3 cb_3
uo_1 uo_1
dw_resultado_archivo_exani_2 dw_resultado_archivo_exani_2
cb_2 cb_2
lb_nombre_tablas lb_nombre_tablas
cb_1 cb_1
cb_copia_archivos cb_copia_archivos
lb_nombre_archivos lb_nombre_archivos
lb_ruta_archivos lb_ruta_archivos
mle_selected mle_selected
cb_carga_archivos cb_carga_archivos
dw_resultados_archivo_ceneval dw_resultados_archivo_ceneval
gb_1 gb_1
end type
global w_carga_archivos_ceneval_2014 w_carga_archivos_ceneval_2014

on w_carga_archivos_ceneval_2014.create
int iCurrent
call super::create
this.cbx_matricula_es_folio=create cbx_matricula_es_folio
this.cbx_utiliza_query=create cbx_utiliza_query
this.mle_query=create mle_query
this.cb_5=create cb_5
this.st_num_insertados=create st_num_insertados
this.st_num_consultados=create st_num_consultados
this.cb_4=create cb_4
this.cb_3=create cb_3
this.uo_1=create uo_1
this.dw_resultado_archivo_exani_2=create dw_resultado_archivo_exani_2
this.cb_2=create cb_2
this.lb_nombre_tablas=create lb_nombre_tablas
this.cb_1=create cb_1
this.cb_copia_archivos=create cb_copia_archivos
this.lb_nombre_archivos=create lb_nombre_archivos
this.lb_ruta_archivos=create lb_ruta_archivos
this.mle_selected=create mle_selected
this.cb_carga_archivos=create cb_carga_archivos
this.dw_resultados_archivo_ceneval=create dw_resultados_archivo_ceneval
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_matricula_es_folio
this.Control[iCurrent+2]=this.cbx_utiliza_query
this.Control[iCurrent+3]=this.mle_query
this.Control[iCurrent+4]=this.cb_5
this.Control[iCurrent+5]=this.st_num_insertados
this.Control[iCurrent+6]=this.st_num_consultados
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.cb_3
this.Control[iCurrent+9]=this.uo_1
this.Control[iCurrent+10]=this.dw_resultado_archivo_exani_2
this.Control[iCurrent+11]=this.cb_2
this.Control[iCurrent+12]=this.lb_nombre_tablas
this.Control[iCurrent+13]=this.cb_1
this.Control[iCurrent+14]=this.cb_copia_archivos
this.Control[iCurrent+15]=this.lb_nombre_archivos
this.Control[iCurrent+16]=this.lb_ruta_archivos
this.Control[iCurrent+17]=this.mle_selected
this.Control[iCurrent+18]=this.cb_carga_archivos
this.Control[iCurrent+19]=this.dw_resultados_archivo_ceneval
this.Control[iCurrent+20]=this.gb_1
end on

on w_carga_archivos_ceneval_2014.destroy
call super::destroy
destroy(this.cbx_matricula_es_folio)
destroy(this.cbx_utiliza_query)
destroy(this.mle_query)
destroy(this.cb_5)
destroy(this.st_num_insertados)
destroy(this.st_num_consultados)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.uo_1)
destroy(this.dw_resultado_archivo_exani_2)
destroy(this.cb_2)
destroy(this.lb_nombre_tablas)
destroy(this.cb_1)
destroy(this.cb_copia_archivos)
destroy(this.lb_nombre_archivos)
destroy(this.lb_ruta_archivos)
destroy(this.mle_selected)
destroy(this.cb_carga_archivos)
destroy(this.dw_resultados_archivo_ceneval)
destroy(this.gb_1)
end on

event pfc_preclose;call super::pfc_preclose;//Se desconecta de la base .DBF y destruye el transaction object

if isvalid(gtr_ceneval) then
	disconnect using gtr_ceneval;
	destroy gtr_ceneval
end if

return 1
end event

event open;call super::open;x=1
y=1

dw_resultado_archivo_exani_2.SetTransObject(gtr_sadm)
end event

type cbx_matricula_es_folio from u_cbx within w_carga_archivos_ceneval_2014
integer x = 649
integer y = 2176
integer width = 553
integer height = 68
string text = "Matricula es folio Ibero"
boolean checked = true
end type

type cbx_utiliza_query from u_cbx within w_carga_archivos_ceneval_2014
integer x = 498
integer y = 996
integer width = 347
integer height = 68
string text = "Utiliza Query"
end type

type mle_query from multilineedit within w_carga_archivos_ceneval_2014
integer x = 2034
integer y = 696
integer width = 1527
integer height = 264
integer taborder = 21
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 1090519039
string text = "SELECT TIPO_EXA,~tAPLI, FECHA_APLI,~tCVE_INST,~tIDENTIFICA,~tFOLIO,PRLM,~tPMAT,~tPRV,~tPESP,~tPTIC,~tIRLM,~tIMAT, IRV, IESP, ITIC  FROM "
boolean autohscroll = true
boolean autovscroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_5 from u_cb within w_carga_archivos_ceneval_2014
integer x = 2030
integer y = 1008
integer width = 375
integer taborder = 30
string text = "Consulta Query"
end type

event clicked;call super::clicked;//Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
//

string docpath, docname[], ls_ruta_archivo, ls_nombre_archivo, ls_nombre_tabla, ls_sql_tabla
integer i, li_cnt, li_rtn, li_filenum, li_pos_dbf, li_pos_diagonal,li_pos_diagonal_anterior
integer li_selected_index , li_retrieve, li_SetTransObject, li_SetSQLSelect

li_cnt = lb_nombre_tablas.TotalItems()

if li_cnt <= 0 then
	MessageBox("Tablas Inexistentes", "No se han copiado las tablas", StopSign!)
	RETURN
end if

li_selected_index = lb_nombre_tablas.SelectedIndex()
if li_selected_index <= 0 then
	MessageBox("Tablas no Elegidas", "Favor de seleccionar una tabla para realizar la consulta", StopSign!)
	RETURN
end if

ls_nombre_tabla = lb_nombre_tablas.SelectedItem()

ls_sql_tabla = "SELECT TIPO_EXA,	APLI,	"+&
" FECHA_APLI,	CVE_INST,	IDENTIFICA,	FOLIO, "+&
"PRLM,	PMAT,	PRV,	PESP,	PTIC,	IRLM,	IMAT, IRV, IESP, ITIC  FROM "+ls_nombre_tabla

//ls_sql_tabla = "SELECT TIPO_EXA,	OPC_APLI,	TIPO_REG,	TIPO_RESP, "+&
//"APLI,	FECHA_APLI,	CVE_INST,	IDENTIFICA,	FOLIO, "+&
//"PRLM,	PMAT,	PRV,	PESP,	PTIC,	IRLM,	IMAT, IRV, IESP, ITIC  FROM "+ls_nombre_tabla

if f_conecta_base_ceneval('CENEVAL') = -1 then
	MessageBox("Error de Conexion", "No es posible conectarse a la base de datos del ceneval", StopSign!)
	return
end if

li_SetTransObject = dw_resultados_archivo_ceneval.SetTransObject(gtr_ceneval)
li_SetSQLSelect = dw_resultados_archivo_ceneval.SetSQLSelect(ls_sql_tabla)
li_retrieve = dw_resultados_archivo_ceneval.Retrieve()
st_num_consultados.text = "Registros: "+string(li_retrieve)
// if multiple files are picked, docpath contains the
// path only - concatenate docpath and docname




end event

type st_num_insertados from u_st within w_carga_archivos_ceneval_2014
integer x = 709
integer y = 1576
integer width = 343
string text = "Registros: 0"
end type

type st_num_consultados from u_st within w_carga_archivos_ceneval_2014
integer x = 960
integer y = 1004
integer width = 343
integer height = 68
string text = "Registros: 0"
end type

type cb_4 from u_cb within w_carga_archivos_ceneval_2014
integer x = 59
integer y = 2164
integer width = 498
integer taborder = 50
string text = "Actualiza Resultados"
end type

event clicked;call super::clicked;//Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
//

string docpath, docname[], ls_ruta_archivo, ls_nombre_archivo, ls_nombre_tabla, ls_sql_tabla
integer i, li_cnt, li_rtn, li_filenum, li_pos_dbf, li_pos_diagonal,li_pos_diagonal_anterior
integer li_selected_index , li_retrieve, li_SetTransObject, li_SetSQLSelect
long ll_rows, ll_row, ll_row_insertado, ll_folio
integer li_confirmacion, li_update, li_asigna_folio_ceneval_a_ibero
boolean lb_matricula_es_folio
li_confirmacion = 	MessageBox("Confirmación", "¿Desea almacenar los valores resultantes?", Question!, YesNo!)
if isnull(li_confirmacion) or li_confirmacion <> 1 then
	MessageBox("Información", "No se han limpiado los valores resultantes", StopSign!)
	return
end if

SetPointer (HourGlass!)

li_update = dw_resultado_archivo_exani_2.Update()
if li_update= -1 then
	ROLLBACK USING gtr_sadm;
	MessageBox("Error de Actualización", "No se han almacenado los valores resultantes", StopSign!)
	return
elseif li_update= 1 then
	  COMMIT USING gtr_sadm;
end if

if cbx_matricula_es_folio.checked then
	lb_matricula_es_folio = true
else
	lb_matricula_es_folio = false
end if

li_asigna_folio_ceneval_a_ibero = 	f_asigna_folio_ceneval_a_ibero(gi_version,gi_periodo, gi_anio, lb_matricula_es_folio)
if li_asigna_folio_ceneval_a_ibero = -1 then
	MessageBox("Error de Actualización", "No ha sido posible reasignar el folio del CENEVAL al folio IBERO - AVISAR A INFORMÁTICA", StopSign!)
	return
elseif li_asigna_folio_ceneval_a_ibero= 0 then
	MessageBox("Actualización Exitosa", "Se han almacenado los valores correctamente", Information!)
end if



end event

type cb_3 from u_cb within w_carga_archivos_ceneval_2014
integer x = 1262
integer y = 1564
integer width = 448
integer taborder = 40
string text = "Limpia Resultados"
end type

event clicked;call super::clicked;//Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
//

string docpath, docname[], ls_ruta_archivo, ls_nombre_archivo, ls_nombre_tabla, ls_sql_tabla
integer i, li_cnt, li_rtn, li_filenum, li_pos_dbf, li_pos_diagonal,li_pos_diagonal_anterior
integer li_selected_index , li_retrieve, li_SetTransObject, li_SetSQLSelect
long ll_rows, ll_row, ll_row_insertado, ll_folio
integer li_confirmacion

li_confirmacion = 	MessageBox("Confirmación", "¿Desea limpiar los valores resultantes?", Question!, YesNo!)
if isnull(li_confirmacion) or li_confirmacion <> 1 then
	MessageBox("Información", "No se han limpiado los valores resultantes", StopSign!)
	return
end if

dw_resultado_archivo_exani_2.Reset()

end event

type uo_1 from uo_ver_per_ani within w_carga_archivos_ceneval_2014
integer x = 55
integer y = 32
integer height = 164
integer taborder = 30
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

type dw_resultado_archivo_exani_2 from u_dw within w_carga_archivos_ceneval_2014
event type integer borra_todo ( )
integer x = 59
integer y = 1704
integer width = 3529
integer height = 424
integer taborder = 40
string dataobject = "d_resultado_archivo_exani_2_2014"
boolean hscrollbar = true
end type

event type integer borra_todo();//borra_todo()
//Regresa integer señalando 
//		1 si fue exito
//		-1 si fue error
//
//DESCRIPCIÓN: Borra todos los horario y actualiza.

long ll_cve_mat
integer li_cve_coordinacion, li_periodo, li_anio, li_respuesta, li_res_del, li_res_upd
string ls_gpo, ls_mensaje_sql
long ll_row, ll_num_rows, ll_row_horario
integer li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo
dwItemStatus l_status
boolean lb_desc_sdu_se

ll_num_rows = RowCount()

for ll_row=1 to ll_num_rows
	li_res_del= DeleteRow(0)
	if li_res_del= -1 then
		return -1
	end if
next

return 1

end event

type cb_2 from u_cb within w_carga_archivos_ceneval_2014
integer x = 50
integer y = 1564
integer width = 448
integer taborder = 30
string text = "Inserta Resultados"
end type

event clicked;call super::clicked;//Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
//

string docpath, docname[], ls_ruta_archivo, ls_nombre_archivo, ls_nombre_tabla, ls_sql_tabla
integer i, li_cnt, li_rtn, li_filenum, li_pos_dbf, li_pos_diagonal,li_pos_diagonal_anterior
integer li_selected_index , li_retrieve, li_SetTransObject, li_SetSQLSelect
long ll_rows, ll_row, ll_row_insertado, ll_folio
integer li_confirmacion
string ls_TIPO_EXA
string ls_OPC_APLI, ls_OPC_APLI_ANTERIOR	
string ls_TIPO_REG	
string ls_TIPO_RESP	
string ls_CVE_BPM	
string ls_APLI	
string ls_MATRICULA	
date ldt_FECHA_APLI
datetime ldttm_FECHA_APLI
string ls_CVE_INST
string ls_IDENTIFICA
string ls_FOLIO
decimal ld_PPMA
decimal ld_PPAN
decimal ld_PCC_EL
decimal ld_PCC_CL
decimal ld_PTIC	
decimal ld_IPMA
decimal ld_IPAN
decimal ld_ICC_EL
decimal ld_ICC_CL
decimal ld_ITIC  
integer li_cve_tipo_examen, li_cve_modulo_examen, li_obten_tipo_modulo_examen
long ll_rowcount

ll_rows = dw_resultados_archivo_ceneval.Rowcount()

if ll_rows <= 0 then
	MessageBox("Registros Inexistentes", "No existen registros en la tabla de los archivos", StopSign!)
	RETURN
end if

li_confirmacion = 	MessageBox("Confirmación", "¿Desea cargar los valores?", Question!, YesNo!)
if isnull(li_confirmacion) or li_confirmacion <> 1 then
	MessageBox("Información", "No se han cargado los archivos", StopSign!)
	return
end if



SetNull(li_cve_tipo_examen)
SetNull(li_cve_modulo_examen) 
//Sólo examen de Selección
ls_OPC_APLI = '01'
for ll_row=1 to ll_rows
	
	 ls_TIPO_EXA      = dw_resultados_archivo_ceneval.GetItemString(ll_row, "TIPO_EXA")
	 ls_APLI          = dw_resultados_archivo_ceneval.GetItemString(ll_row, "APLI")	
	 ldt_FECHA_APLI = dw_resultados_archivo_ceneval.GetItemDate(ll_row, "FECHA_APLI")
      ldttm_FECHA_APLI =datetime(ldt_FECHA_APLI)
	 ls_CVE_INST      = dw_resultados_archivo_ceneval.GetItemString(ll_row, "CVE_INST")
	 ls_IDENTIFICA    = dw_resultados_archivo_ceneval.GetItemString(ll_row, "IDENTIFICA")
	 ls_FOLIO         = dw_resultados_archivo_ceneval.GetItemString(ll_row, "FOLIO")
	 ls_MATRICULA         = dw_resultados_archivo_ceneval.GetItemString(ll_row, "MATRICULA")
	 ld_PPMA          = dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "PPMA")
	 ld_PPAN        = dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "PPAN")
	 ld_PCC_EL           = dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "PCC_EL")
	 ld_PCC_CL				= dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "PCC_CL")
	 ld_IPMA				= dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "IPMA")
	 ld_IPAN			= dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "IPAN")
	 ld_ICC_EL				= dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "ICC_EL")
	 ld_ICC_CL				= dw_resultados_archivo_ceneval.GetItemDecimal(ll_row, "ICC_CL")
	 
	 ll_row_insertado = dw_resultado_archivo_exani_2.InsertRow(0)
	 if ll_row_insertado= -1 then
		MessageBox("Información", "Error en la inserción del archivo EXANI-II", StopSign!)
		return
	 end if
	 if ls_OPC_APLI_ANTERIOR <> ls_OPC_APLI then	
		 SetNull(li_cve_tipo_examen)
		 SetNull(li_cve_modulo_examen) 
		 li_obten_tipo_modulo_examen = f_obten_tipo_modulo_examen(ls_OPC_APLI, li_cve_tipo_examen, li_cve_modulo_examen)
//Se ponen temporalmente en examen de diagnostico para que no tome el de las areas
		 li_cve_tipo_examen = 1
		 li_cve_modulo_examen = 1
		 if li_obten_tipo_modulo_examen = -1 then
			MessageBox("Error en Opción de Aplicación", &
			"No se encuentra una Opción de Aplicación  equivalente del archivo EXANI-II "+"["+ls_OPC_APLI+"]", StopSign!)
			return
		 end if
	 end if

//Si fuera numérico	
//	 ll_folio = f_convierte_folio(ls_FOLIO,2,6)
//	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "folio", ll_folio)
//Si es alfanumérico
	ls_FOLIO = trim(ls_FOLIO)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "folio", ls_FOLIO)
	 
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "clv_ver",gi_version)	
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "clv_per", gi_periodo)	
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "anio", gi_anio)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "cve_tipo_examen", li_cve_tipo_examen)	
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "cve_modulo_examen", li_cve_modulo_examen)
	 	 
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "TIPO_EXA", ls_TIPO_EXA)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "APLI",ls_APLI)	
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "FECHA_APLI",ldttm_FECHA_APLI)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "CVE_INST",ls_CVE_INST)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "IDENTIFICA",ls_IDENTIFICA)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "FOLIO",ls_FOLIO)
	ls_MATRICULA = trim(ls_MATRICULA)
	dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "MATRICULA",ls_MATRICULA)
	 
	 
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "PPMA",ld_PPMA)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "PPAN",ld_PPAN)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "PCC_EL",ld_PCC_EL)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "PCC_CL",ld_PCC_CL)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "IPMA",ld_IPMA)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "IPAN",ld_IPAN)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "ICC_EL",ld_ICC_EL)
	 dw_resultado_archivo_exani_2.SetItem(ll_row_insertado, "ICC_CL",ld_ICC_CL)

	 
	 ls_OPC_APLI_ANTERIOR = ls_OPC_APLI
	 
	/*statementblock*/
next

ll_rowcount = dw_resultado_archivo_exani_2.RowCount()

st_num_insertados.text = "Registros: "+string(ll_rowcount)



end event

type lb_nombre_tablas from u_lb within w_carga_archivos_ceneval_2014
integer x = 91
integer y = 724
integer width = 1851
integer height = 192
integer taborder = 30
boolean vscrollbar = false
end type

type cb_1 from u_cb within w_carga_archivos_ceneval_2014
integer x = 55
integer y = 984
integer width = 370
integer taborder = 20
string text = "Consulta Tabla"
end type

event clicked;call super::clicked;//Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
//

string docpath, docname[], ls_ruta_archivo, ls_nombre_archivo, ls_nombre_tabla, ls_sql_tabla
integer i, li_cnt, li_rtn, li_filenum, li_pos_dbf, li_pos_diagonal,li_pos_diagonal_anterior
integer li_selected_index , li_retrieve, li_SetTransObject, li_SetSQLSelect

li_cnt = lb_nombre_tablas.TotalItems()

if li_cnt <= 0 then
	MessageBox("Tablas Inexistentes", "No se han copiado las tablas", StopSign!)
	RETURN
end if

li_selected_index = lb_nombre_tablas.SelectedIndex()
if li_selected_index <= 0 then
	MessageBox("Tablas no Elegidas", "Favor de seleccionar una tabla para realizar la consulta", StopSign!)
	RETURN
end if

ls_nombre_tabla = lb_nombre_tablas.SelectedItem()

if cbx_utiliza_query.checked then
	ls_sql_tabla = mle_query.text 
	ls_sql_tabla = ls_sql_tabla +" "+ls_nombre_tabla
else

////ANTES DE 2014-01-28	
//	ls_sql_tabla = "SELECT TIPO_EXA,	APLI,	"+&
//	" FECHA_APLI,	CVE_INST,	IDENTIFICA,	FOLIO, "+&
//	"PRLM,	PMAT,	PRV,	PESP,	PTIC,	IRLM,	IMAT, IRV, IESP, ITIC  FROM "+ls_nombre_tabla

//CON EL CENEVAL 2014 Y SOLO 4 AREAS: 2014-01-28	
	ls_sql_tabla = "SELECT TIPO_EXA,	APLI,	"+&
	" FECHA_APLI,	CVE_INST,	IDENTIFICA,	FOLIO, MATRICULA, "+&
	"PPMA,	PPAN,	 PCC_EL,	PCC_CL,  IPMA, 	IPAN, 	ICC_EL,	ICC_CL FROM "+ls_nombre_tabla

//	ls_sql_tabla = "SELECT TIPO_EXA,	OPC_APLI,	TIPO_REG,	TIPO_RESP, "+&
//	"APLI,	FECHA_APLI,	CVE_INST,	IDENTIFICA,	FOLIO, "+&
//	"PRLM,	PMAT,	PRV,	PESP,	PTIC,	IRLM,	IMAT, IRV, IESP, ITIC  FROM "+ls_nombre_tabla
end if

if f_conecta_base_ceneval('CENEVAL') = -1 then
	MessageBox("Error de Conexion", "No es posible conectarse a la base de datos del ceneval", StopSign!)
	return
end if

li_SetTransObject = dw_resultados_archivo_ceneval.SetTransObject(gtr_ceneval)
li_SetSQLSelect = dw_resultados_archivo_ceneval.SetSQLSelect(ls_sql_tabla)
li_retrieve = dw_resultados_archivo_ceneval.Retrieve()
st_num_consultados.text = "Registros: "+string(li_retrieve)
// if multiple files are picked, docpath contains the
// path only - concatenate docpath and docname




end event

type cb_copia_archivos from u_cb within w_carga_archivos_ceneval_2014
integer x = 55
integer y = 556
integer width = 389
integer taborder = 10
string text = "Copiar Archivos"
end type

event clicked;call super::clicked;//Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
//

string docpath, docname[], ls_ruta_archivo, ls_nombre_archivo, ls_ruta_destino, ls_nombre_tabla
integer i, li_cnt, li_rtn, li_filenum, li_pos_dbf, li_pos_diagonal,li_pos_diagonal_anterior
integer li_num_archivos, li_archivo_actual

string ls_cve_opcion_aplicacion 
integer li_cve_tipo_examen, li_cve_modulo_examen    
int li_codigo_sql, li_SQLNRows
string ls_mensaje
integer li_clv_ver, li_clv_per, li_anio, li_criterios_absolutos
decimal ld_peso_promedio,  ld_peso_examen_seleccion, ld_peso_examen_diagnostico, ld_calificacion_global_examen
string ls_archivo_presentaron, ls_archivo_no_presentaron, ls_ruta_archivo_dsn
datetime ldttm_fecha_ultima_aplicacion  
integer li_obten_calificacion_global_examen

f_obten_parametros_evaluacion(gi_version, gi_periodo, gi_anio,  li_criterios_absolutos,&
ld_peso_promedio,  ld_peso_examen_seleccion, ld_peso_examen_diagnostico, ls_archivo_presentaron, &
ls_archivo_no_presentaron, ls_ruta_archivo_dsn, ldttm_fecha_ultima_aplicacion)



li_num_archivos = lb_ruta_archivos.TotalItems()

IF li_num_archivos = 0 THEN
	MessageBox("No se han cargado archivos", "Favor de cargar archivos .DBF antes de copiar", StopSign!)
	return
END IF
		
for li_archivo_actual=1 to li_num_archivos
	lb_ruta_archivos.SelectItem ( li_archivo_actual )
	ls_ruta_archivo = lb_ruta_archivos.SelectedItem ( )
	
	lb_nombre_archivos.SelectItem ( li_archivo_actual )
	ls_nombre_archivo = lb_nombre_archivos.SelectedItem ( )
//	ls_ruta_destino = "C:\\Archivos de programa\\Aplicaciones UIA\\CENEVAL\\"
	ls_ruta_destino = ls_ruta_archivo_dsn + "\"
	ls_ruta_destino = ls_ruta_destino+ ls_nombre_archivo
	li_FileNum = FileCopy(ls_ruta_archivo, ls_ruta_destino, TRUE)
	li_pos_dbf = pos(upper(ls_nombre_archivo), ".DBF")
	ls_nombre_tabla = mid(ls_nombre_archivo, 1, li_pos_dbf -1)
	lb_nombre_tablas.AddItem(ls_nombre_tabla)
	
next

end event

type lb_nombre_archivos from u_lb within w_carga_archivos_ceneval_2014
integer x = 1966
integer y = 352
integer width = 1143
integer height = 192
integer taborder = 30
boolean vscrollbar = false
end type

type lb_ruta_archivos from u_lb within w_carga_archivos_ceneval_2014
integer x = 55
integer y = 352
integer width = 1847
integer height = 192
integer taborder = 20
end type

type mle_selected from u_mle within w_carga_archivos_ceneval_2014
boolean visible = false
integer x = 55
integer y = 384
integer width = 1847
integer height = 192
integer taborder = 20
end type

type cb_carga_archivos from u_cb within w_carga_archivos_ceneval_2014
integer x = 55
integer y = 224
integer width = 389
integer taborder = 10
string text = "Cargar Archivos"
end type

event clicked;call super::clicked;//Exito = GetFileSaveName("Selecciona Archivo",Ruta,NombreArch,"TXT","Archivo de texto,*.TXT,")
//


string docpath, docname[], ls_ruta_archivo, ls_nombre_archivo
integer i, li_cnt, li_rtn, li_filenum, li_pos_dbf, li_pos_diagonal,li_pos_diagonal_anterior
integer li_confirmacion, li_borra_todo
long ll_rows_version

li_confirmacion = 	MessageBox("Confirmación", "¿Desea cargar los valores para el periodo elegido?", Question!, YesNo!)
if isnull(li_confirmacion) or li_confirmacion <> 1 then
	MessageBox("Información", "No se cargarán los archivos", StopSign!)
	return
end if 

 ll_rows_version= dw_resultado_archivo_exani_2.Retrieve(gi_version , gi_periodo, gi_anio)

if ll_rows_version>0 then
	li_confirmacion = 	MessageBox("Registros ya existentes", "Se encontraron ["+string(ll_rows_version)+"] registros de ese periodo.~n"+&
	            "¿Desea eliminar los existentes y continuar con la carga de los valores nuevos?", Question!, YesNo!,2)
	if isnull(li_confirmacion) or li_confirmacion <> 1 then
		MessageBox("Información", "No se cargarán los archivos", StopSign!)
		return
	end if 
	
	li_borra_todo =dw_resultado_archivo_exani_2.event borra_todo()
	if li_borra_todo = -1 then
		MessageBox("Error de Eliminación", "No es posible eliminar los registros existentes", StopSign!)
		return
	end if 

end if
 
li_rtn = GetFileOpenName("Seleccione los Archivos", &
   docpath, docname[], "DBF", &
   + "Archivos de Bases de Datos(*.DBF),*.DBF," &
   + "Todos los Archivos (*.*), *.*", &
   "C:\")

mle_selected.text = ""
IF li_rtn < 1 THEN return
li_cnt = Upperbound(docname)
 
// if only one file is picked, docpath contains the 
// path and file name

if li_cnt > 0 then

//   mle_selected.text = string(docpath)
//else
//
// if multiple files are picked, docpath contains the 
// path only - concatenate docpath and docname

   for i=1 to li_cnt
		
		if li_cnt > 1 then		
			ls_ruta_archivo =  string(docpath) &
      	   + "\" +(string(docname[i]))
		else
			ls_ruta_archivo =  string(docpath) 
		end if
		
		li_pos_dbf = pos(upper(ls_ruta_archivo), '.DBF')

		IF li_pos_dbf = 0 THEN
			MessageBox("Error en tipo de archivo", "Favor de solo elegir archivos .DBF", StopSign!)
			lb_ruta_archivos.Reset()	
			lb_nombre_archivos.Reset()
			mle_selected.text= ""
		END IF
		
		li_pos_diagonal=1
		do while li_pos_diagonal>0
			li_pos_diagonal_anterior = li_pos_diagonal
			li_pos_diagonal = pos(ls_ruta_archivo, '\', li_pos_diagonal_anterior +1)			
		loop
		
		ls_nombre_archivo = MID(ls_ruta_archivo, li_pos_diagonal_anterior + 1)
		
      mle_selected.text += ls_ruta_archivo+"~r~n"
		lb_ruta_archivos.AddItem(ls_ruta_archivo)
		lb_nombre_archivos.AddItem(ls_nombre_archivo)		

   next

else	
	MessageBox("Error", "No se seleccionaron archivos", StopSign!)
	return
end if


end event

type dw_resultados_archivo_ceneval from u_dw within w_carga_archivos_ceneval_2014
integer x = 55
integer y = 1112
integer width = 3529
integer height = 424
integer taborder = 10
string dataobject = "d_exani_2_dbf_nuevo_formato_2014"
boolean hscrollbar = true
end type

type gb_1 from u_gb within w_carga_archivos_ceneval_2014
integer x = 55
integer y = 664
integer width = 1947
integer height = 284
integer taborder = 11
string text = "Tablas"
end type

