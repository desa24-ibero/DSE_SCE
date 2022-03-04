$PBExportHeader$w_indultos_periodo.srw
forward
global type w_indultos_periodo from w_main
end type
type cbx_ingles from checkbox within w_indultos_periodo
end type
type dw_banderas_indultos_consulta from u_dw within w_indultos_periodo
end type
type cb_1 from u_cb within w_indultos_periodo
end type
type dw_banderas_indultos from u_dw within w_indultos_periodo
end type
type st_periodo_establecido from u_st within w_indultos_periodo
end type
type cb_consulta_indultos from u_cb within w_indultos_periodo
end type
type cb_4 from u_cb within w_indultos_periodo
end type
type dw_hist_indultos_vigentes from u_dw within w_indultos_periodo
end type
type cb_3 from u_cb within w_indultos_periodo
end type
type st_avance from u_st within w_indultos_periodo
end type
type st_procesamiento from u_st within w_indultos_periodo
end type
type uo_1 from uo_per_ani within w_indultos_periodo
end type
end forward

global type w_indultos_periodo from w_main
integer width = 4699
integer height = 1836
string title = "Indutos por Periodo"
cbx_ingles cbx_ingles
dw_banderas_indultos_consulta dw_banderas_indultos_consulta
cb_1 cb_1
dw_banderas_indultos dw_banderas_indultos
st_periodo_establecido st_periodo_establecido
cb_consulta_indultos cb_consulta_indultos
cb_4 cb_4
dw_hist_indultos_vigentes dw_hist_indultos_vigentes
cb_3 cb_3
st_avance st_avance
st_procesamiento st_procesamiento
uo_1 uo_1
end type
global w_indultos_periodo w_indultos_periodo

type variables
string is_nombre_archivo= ""
n_cortes in_cortes
datetime ldtm_fecha_inicial, ldtm_fecha_final
integer ii_periodo = 0, ii_anio = 0


end variables

forward prototypes
public function integer wf_carga_prerreq_alumnos ()
public function integer wf_corte_alumnos ()
public function integer wf_ejecuta_indultos ()
end prototypes

public function integer wf_carga_prerreq_alumnos ();return 0

end function

public function integer wf_corte_alumnos ();return 0
end function

public function integer wf_ejecuta_indultos ();// wf_ejecuta_indultos
//Efectua los cortes de los alumnos
integer li_return_carga
string ls_mensaje 
long ll_cuentas[], ll_row, ll_rows, ll_cuenta, ll_row2, ll_rows2
long ll_found, ll_row_insert
String  	Nivel, ls_nombre_completo
Long 	Plan, Carrera, ll_cve_mat
Integer li_carrera_plan, li_nombre_completo
Long ll_cve_carrera, ll_cve_plan
Integer ai_ya_puede_int, ai_ya_curso_int
Integer ai_ya_puede_ss, ai_ya_curso_ss
decimal ld_promedio
long ll_cve_flag_promedio
int li_baja_3_reprob_normal, li_baja_4_insc_normal, li_cve_flag_promedio_normal
int li_corte_servicio_social
int li_corte_integracion
int li_corte_egresado, li_egresado, li_actualiza_periodo_egreso 
string ls_cve_indulto
long ll_row_banderas_indultos
integer li_update_banderas_indultos

ll_rows = dw_hist_indultos_vigentes.RowCount()
if  ll_rows <= 0 then
	MessageBox("Error","No se han consultado los alumnos",StopSign!)
	return -1
end if

FOR ll_row = 1 TO ll_rows
	
	st_procesamiento.text = string(ll_row)+"/"+string(ll_rows)
	dw_hist_indultos_vigentes.ScrollToRow(ll_row)
	ll_cuenta = dw_hist_indultos_vigentes.GetItemNumber(ll_row, "cuenta")
	ls_cve_indulto = dw_hist_indultos_vigentes.GetItemString(ll_row, "cve_indulto")

	ll_row_banderas_indultos	= dw_banderas_indultos.Retrieve(ll_cuenta)
	if ll_row_banderas_indultos= -1 then
		MessageBox("Error","No se puede recuperar al alumnocon cuenta ["+string(ll_cuenta)+"]",StopSign!)
		return -1
	elseif ll_row_banderas_indultos= 0 then
		MessageBox("Error","No existe el alumno con cuenta ["+string(ll_cuenta)+"]",StopSign!)
		return -1
	end if
	
	//Asigna los valores de los indultos
	li_baja_3_reprob_normal = 0
	li_baja_4_insc_normal = 0
	li_cve_flag_promedio_normal = 0
	
	
	choose case ls_cve_indulto
	//Indulto por Promedio
	case 'P'
		dw_banderas_indultos.SetItem(ll_row_banderas_indultos,'cve_flag_promedio',li_cve_flag_promedio_normal)
	//Indulto por 3 Reprobadas
	case '3'
		dw_banderas_indultos.SetItem(ll_row_banderas_indultos,'baja_3_reprob',li_baja_3_reprob_normal)
	//Indulto por 4 Inscripciones
	case '4'
		dw_banderas_indultos.SetItem(ll_row_banderas_indultos,'baja_4_insc',li_baja_4_insc_normal)
	//Indulto por Ingles
	case 'I'
		dw_banderas_indultos.SetItem(ll_row_banderas_indultos,'cve_flag_prerreq_ingles',0)		
		dw_banderas_indultos.SetItem(ll_row_banderas_indultos,'exten_cred',60)		
	//Indulto Inválido
	case else
		MessageBox("Error","No existe se permite el tipo de indulto ["+ls_cve_indulto+"]",StopSign!)
		return -1
	end choose

	li_update_banderas_indultos = dw_banderas_indultos.Update()
	
	if li_update_banderas_indultos = -1 then
		MessageBox("Error","No es posible desbloquear al alumno con cuenta ["+string(ll_cuenta)+"]",StopSign!)
		return -1
	elseif li_update_banderas_indultos = 1 then
		COMMIT USING gtr_sce;		
	end if
	
	
	
NEXT


RETURN 0

end function

on w_indultos_periodo.create
int iCurrent
call super::create
this.cbx_ingles=create cbx_ingles
this.dw_banderas_indultos_consulta=create dw_banderas_indultos_consulta
this.cb_1=create cb_1
this.dw_banderas_indultos=create dw_banderas_indultos
this.st_periodo_establecido=create st_periodo_establecido
this.cb_consulta_indultos=create cb_consulta_indultos
this.cb_4=create cb_4
this.dw_hist_indultos_vigentes=create dw_hist_indultos_vigentes
this.cb_3=create cb_3
this.st_avance=create st_avance
this.st_procesamiento=create st_procesamiento
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cbx_ingles
this.Control[iCurrent+2]=this.dw_banderas_indultos_consulta
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_banderas_indultos
this.Control[iCurrent+5]=this.st_periodo_establecido
this.Control[iCurrent+6]=this.cb_consulta_indultos
this.Control[iCurrent+7]=this.cb_4
this.Control[iCurrent+8]=this.dw_hist_indultos_vigentes
this.Control[iCurrent+9]=this.cb_3
this.Control[iCurrent+10]=this.st_avance
this.Control[iCurrent+11]=this.st_procesamiento
this.Control[iCurrent+12]=this.uo_1
end on

on w_indultos_periodo.destroy
call super::destroy
destroy(this.cbx_ingles)
destroy(this.dw_banderas_indultos_consulta)
destroy(this.cb_1)
destroy(this.dw_banderas_indultos)
destroy(this.st_periodo_establecido)
destroy(this.cb_consulta_indultos)
destroy(this.cb_4)
destroy(this.dw_hist_indultos_vigentes)
destroy(this.cb_3)
destroy(this.st_avance)
destroy(this.st_procesamiento)
destroy(this.uo_1)
end on

event open;call super::open;x=1
y=1

dw_hist_indultos_vigentes.SetTransObject(gtr_sce)
dw_hist_indultos_vigentes.SetRowFocusIndicator(Hand!)
dw_banderas_indultos.SetTransObject(gtr_sce)
dw_banderas_indultos_consulta.SetTransObject(gtr_sce)
IF not isvalid(in_cortes) THEN
	in_cortes = CREATE n_cortes
END IF
end event

event close;call super::close;IF isvalid(in_cortes) THEN
	DESTROY in_cortes 
END IF
end event

type cbx_ingles from checkbox within w_indultos_periodo
integer x = 2889
integer y = 92
integer width = 1093
integer height = 64
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long textcolor = 33554432
long backcolor = 67108864
string text = "Procesar solo Prerrequisito  Inglés"
end type

type dw_banderas_indultos_consulta from u_dw within w_indultos_periodo
integer x = 2121
integer y = 404
integer width = 2455
integer height = 332
integer taborder = 70
boolean enabled = false
boolean titlebar = true
string title = "Consulta de Indultos"
string dataobject = "d_banderas_indultos_consulta"
boolean maxbox = true
borderstyle borderstyle = styleraised!
end type

type cb_1 from u_cb within w_indultos_periodo
integer x = 1275
integer y = 256
integer width = 471
integer taborder = 60
string text = "Ejecutar Indultos"
end type

event clicked;call super::clicked;integer li_res_indultos, li_confirmacion
long	ll_rowcount, ll_rows


ll_rowcount = dw_hist_indultos_vigentes.RowCount()

if ll_rowcount <= 0 then
	MessageBox("Error de Carga", "No es posible consultar a los alumnos",StopSign!)
	RETURN
END IF

li_confirmacion = 	MessageBox("Confirmación", "¿Desea efectuar el indulto de los ["+string(ll_rowcount)+"] alumnos?",Question!, YesNo!)

SetPointer(HourGlass!)
cb_3.enabled = false
ldtm_fecha_inicial = fecha_servidor(gtr_sce)
IF li_confirmacion = 1 THEN
	li_res_indultos = wf_ejecuta_indultos()
	IF li_res_indultos = 0 THEN
		MessageBox("Ejecución Exitosa", "Se ha efectuado el indulto de los ["+string(ll_rowcount)+"] alumnos",Information!)
	ELSEIF li_res_indultos = -1 THEN
		MessageBox("Error de Ejecución", "No es posible continuar con los indultos",StopSign!)
	END IF
ELSE
	MessageBox("Sin actualización", "No se han efectuado los indultos",Information!)
END IF
dw_hist_indultos_vigentes.ScrollToRow(1)
ldtm_fecha_final= fecha_servidor(gtr_sce)
cb_3.enabled = true


end event

type dw_banderas_indultos from u_dw within w_indultos_periodo
integer x = 2121
integer y = 1268
integer width = 2455
integer height = 364
integer taborder = 60
boolean enabled = false
boolean titlebar = true
string title = "Avance de Aplicación de Indultos"
string dataobject = "d_banderas_indultos"
boolean maxbox = true
borderstyle borderstyle = styleraised!
end type

type st_periodo_establecido from u_st within w_indultos_periodo
integer x = 1920
integer y = 84
integer width = 841
integer height = 92
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
string text = ""
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type cb_consulta_indultos from u_cb within w_indultos_periodo
integer x = 293
integer y = 256
integer width = 681
integer taborder = 50
string text = "Consultar Alumnos Indultados"
end type

event clicked;call super::clicked;integer li_return_carga, li_periodo[], li_anio
long ll_rows
if ii_periodo = 0 and ii_anio = 0 then
	MessageBox("Error de Periodo", "Favor de establecer un periodo antes de consultar",StopSign!)
	RETURN	
end if


li_periodo = {ii_periodo}
li_anio = ii_anio

//choose case ii_periodo
//	case 0
////		li_periodo = {1,2}
//		li_periodo = {0}
//		li_anio = ii_anio
//	case 1
////		li_periodo = {2,1}
//		li_periodo = {1}
//		li_anio = ii_anio
//	case 2
////		li_periodo = {0}
//		li_periodo = {2}
////		li_anio = ii_anio +1
//		li_anio = ii_anio
//	case else
//		MessageBox("Error de Periodo", "Periodo["+string(ii_periodo)+"] desconocido",StopSign!)
//		RETURN	
//end choose

IF cbx_ingles.CHECKED THEN 
	ll_rows = dw_hist_indultos_vigentes.Retrieve(li_anio,li_periodo, 'I')
ELSE
	ll_rows = dw_hist_indultos_vigentes.Retrieve(li_anio,li_periodo, '9999')
END IF
	

if ll_rows = -1 then
	MessageBox("Error de Carga", "No es posible consultar a los alumnos",StopSign!)
	RETURN
END IF
end event

type cb_4 from u_cb within w_indultos_periodo
integer x = 1371
integer y = 84
integer width = 439
integer taborder = 50
string text = "Establece Periodo"
end type

event clicked;call super::clicked;

string pathname, filename , ls_mensaje_periodo, ls_periodo

integer value, li_periodo, li_anio, li_confirmacion

li_periodo = gi_periodo
li_anio = gi_anio


uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, "U", gtr_sce)

ls_periodo = luo_periodo_servicios.f_recupera_descripcion(gi_periodo, "L") 

//choose case gi_periodo
//	case 0
//		ls_periodo = 'PRIMAVERA'
//	case 1
//		ls_periodo = 'VERANO'
//	case 2
//		ls_periodo = 'OTOÑO'
//	case else
//		ls_periodo = 'NULO'
//end choose



ls_mensaje_periodo = "¿Dese establecido el periodo de Indultos en "+ls_periodo +" - " + STRING(li_anio)+ "?"

li_confirmacion = MessageBox("Confirmación", ls_mensaje_periodo, Question!, YesNo!)
if li_confirmacion<> 1 then
	Messagebox("Cancelación","No se ha cambiado el perido de Indultos",Information!)
	return
else
	Messagebox("Información","Perido de Indultos establecido",Information!)	
end if

st_periodo_establecido.text = ls_periodo +" - " + STRING(li_anio)

ii_periodo = li_periodo 
ii_anio    =li_anio 


dw_hist_indultos_vigentes.Reset()


end event

type dw_hist_indultos_vigentes from u_dw within w_indultos_periodo
integer x = 73
integer y = 404
integer width = 1975
integer height = 1236
integer taborder = 30
boolean titlebar = true
string title = "Indultos Registrados"
string dataobject = "d_hist_indultos_vigentes"
boolean maxbox = true
boolean resizable = true
end type

event rowfocuschanged;call super::rowfocuschanged;long ll_row, ll_cuenta, ll_row_banderas_indultos

IF dw_hist_indultos_vigentes.ROWCOUNT() <= 0 THEN RETURN 0 

ll_row = currentrow	

ll_cuenta = dw_hist_indultos_vigentes.GetItemNumber(ll_row, "cuenta")

ll_row_banderas_indultos	= dw_banderas_indultos_consulta.Retrieve(ll_cuenta)

if ll_row_banderas_indultos= -1 then
	MessageBox("Error","No se puede recuperar al alumno con cuenta ["+string(ll_cuenta)+"]",StopSign!)
	return -1
elseif ll_row_banderas_indultos= 0 then
	MessageBox("Error","No existe el alumno con cuenta ["+string(ll_cuenta)+"]",StopSign!)
	return -1
end if

end event

type cb_3 from u_cb within w_indultos_periodo
integer x = 2779
integer y = 256
integer width = 87
integer taborder = 50
boolean enabled = false
string text = "..."
end type

event clicked;call super::clicked;IF not isnull(ldtm_fecha_inicial) AND &
   not isnull(ldtm_fecha_final) THEN
	MessageBox("Periodo de Ejecución","Inicio: ["+string(ldtm_fecha_inicial,"dd/mm/yyyy hh:mm:ss")+"]~n"+&
												 "Fin   : ["+string(ldtm_fecha_final,"dd/mm/yyyy hh:mm:ss")+"]")
END IF

end event

type st_avance from u_st within w_indultos_periodo
integer x = 2199
integer y = 268
integer width = 192
string text = "Avance:"
end type

type st_procesamiento from u_st within w_indultos_periodo
integer x = 2409
integer y = 256
integer width = 352
integer height = 92
string text = ""
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type uo_1 from uo_per_ani within w_indultos_periodo
integer x = 55
integer y = 48
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

