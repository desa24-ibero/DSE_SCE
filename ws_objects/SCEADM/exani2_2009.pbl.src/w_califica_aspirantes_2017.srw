$PBExportHeader$w_califica_aspirantes_2017.srw
$PBExportComments$Ventana que califica secciones, áreas y da los puntajes en base a las calificaciones dadas por el CENEVAL.
forward
global type w_califica_aspirantes_2017 from w_main
end type
type st_3 from statictext within w_califica_aspirantes_2017
end type
type dw_fecha_examen from datawindow within w_califica_aspirantes_2017
end type
type st_progreso from statictext within w_califica_aspirantes_2017
end type
type dw_reporte from datawindow within w_califica_aspirantes_2017
end type
type dw_resultado_examen_modulo_cons from u_dw within w_califica_aspirantes_2017
end type
type dw_modulo_examen from u_dw within w_califica_aspirantes_2017
end type
type dw_resultado_examen_modulo from u_dw within w_califica_aspirantes_2017
end type
type dw_aspiran_pago_examen from u_dw within w_califica_aspirantes_2017
end type
type em_max from editmask within w_califica_aspirantes_2017
end type
type em_min from editmask within w_califica_aspirantes_2017
end type
type st_1 from statictext within w_califica_aspirantes_2017
end type
type cb_califica from commandbutton within w_califica_aspirantes_2017
end type
type uo_1 from uo_ver_per_ani within w_califica_aspirantes_2017
end type
end forward

global type w_califica_aspirantes_2017 from w_main
integer x = 832
integer y = 360
integer width = 4987
integer height = 2456
string title = "Califica Aspirantes"
string menuname = "m_menu"
boolean controlmenu = false
boolean ib_disableclosequery = true
event type long num_folios ( integer min_max )
event type integer obten_carr ( long fol )
event cal_are ( long fol,  integer area,  integer carr )
event type real pes_are ( long fol,  integer area,  integer carr )
event da_puntaje ( long fol,  real acumula )
st_3 st_3
dw_fecha_examen dw_fecha_examen
st_progreso st_progreso
dw_reporte dw_reporte
dw_resultado_examen_modulo_cons dw_resultado_examen_modulo_cons
dw_modulo_examen dw_modulo_examen
dw_resultado_examen_modulo dw_resultado_examen_modulo
dw_aspiran_pago_examen dw_aspiran_pago_examen
em_max em_max
em_min em_min
st_1 st_1
cb_califica cb_califica
uo_1 uo_1
end type
global w_califica_aspirantes_2017 w_califica_aspirantes_2017

type variables

DATASTORE ids_examen_excoba_2017
DATASTORE ids_examen_modulo_2017
DATASTORE ids_parametros_area_examen2017

DATASTORE ids_resultado_examen_modulo_2017
DATASTORE ids_resultado_examen_mod_area_2017

DATASTORE ids_area_evaluacion
DATASTORE ids_parametros_area_exam_peso

DATASTORE ids_update_aspiran_2017  


transaction itr_admision_web


DATASTORE ids_resultado_examen_modsql_2017
DATASTORE ids_resultado_exa_mod_areasql_2017 
end variables

forward prototypes
public function integer f_carga_informacion ()
public function integer f_recupera_fechas ()
end prototypes

event num_folios;long folios

if min_max=0 then
	SELECT min(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
else
	SELECT max(aspiran.folio)
	INTO :folios
	FROM aspiran  
	WHERE ( aspiran.clv_ver = :gi_version ) AND  
		( aspiran.clv_per = :gi_periodo ) AND  
		( aspiran.anio = :gi_anio )
	USING gtr_sadm;
end if

return folios
end event

event obten_carr;int carr

SELECT aspiran.clv_carr
INTO :carr
FROM aspiran  
WHERE ( aspiran.folio = :fol ) AND
	( aspiran.clv_ver = :gi_version ) AND  
	( aspiran.clv_per = :gi_periodo ) AND  
	( aspiran.anio = :gi_anio )   
USING gtr_sadm;
	
return carr

end event

event cal_are(long fol, integer area, integer carr);real valor

		SELECT sum(round(cali_sec.calif,2) * round(sec_peso.peso,2))
		INTO :valor  
		FROM cali_sec, sec_peso  
		WHERE ( cali_sec.folio = :fol ) AND  
			( cali_sec.clv_ver = :gi_version ) AND  
			( cali_sec.clv_per = :gi_periodo ) AND  
			( cali_sec.anio = :gi_anio ) AND  
			( cali_sec.clv_area = :area ) and  
			( sec_peso.clv_carr= :carr ) and
			( sec_peso.clv_area = :area ) and  
			( sec_peso.clv_sec = cali_sec.clv_sec )
		USING gtr_sadm;
					
		UPDATE cali_are
		SET calif = round(:valor,2)
		WHERE ( cali_are.folio = :fol ) AND  
			( cali_are.clv_ver = :gi_version ) AND  
			( cali_are.clv_per = :gi_periodo ) AND  
			( cali_are.anio = :gi_anio ) AND  
			( cali_are.clv_area = :area )   
		USING gtr_sadm;
end event

event pes_are;real valor

		SELECT round(cali_are.calif,2)*round(area_pes.peso,5)/100.00000
		INTO :valor
		FROM cali_are, area_pes  
		WHERE ( cali_are.clv_area = area_pes.clv_area ) and  
			( cali_are.folio = :fol ) AND  
			( cali_are.clv_ver = :gi_version ) AND  
			( cali_are.clv_per = :gi_periodo ) AND  
			( cali_are.anio = :gi_anio ) AND  
			( area_pes.clv_carr = :carr ) AND  
			( cali_are.clv_area = :area )
		USING gtr_sadm;		

return round(valor,2)
end event

event da_puntaje(long fol, real acumula);real valor

//		UPDATE aspiran
//		SET puntaje = round(:acumula+round(promedio,2) * 40.00000,2)
//		WHERE ( aspiran.folio = :fol ) AND  
//			( aspiran.clv_ver = :gi_version ) AND  
//			( aspiran.clv_per = :gi_periodo ) AND  
//			( aspiran.anio = :gi_anio )   
//		USING gtr_sadm;


		UPDATE aspiran
		SET puntaje = round(:acumula+round(aspiran.promedio,2) * promedio_peso.peso,2)
		FROM aspiran, promedio_peso
		WHERE ( aspiran.folio = :fol ) AND  
			( aspiran.clv_ver = :gi_version ) AND  
			( aspiran.clv_per = :gi_periodo ) AND  
			( aspiran.anio = :gi_anio )   AND
			( aspiran.clv_carr = promedio_peso.clv_carr)
		USING gtr_sadm;
		
		
		
end event

public function integer f_carga_informacion ();LONG ll_rows
LONG ll_folio_inicial , ll_folio_final
LONG ll_id_fecha 

ll_folio_inicial = long(em_min.text)
ll_folio_final   = long(em_max.text)

ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
	RETURN -1
END IF


// Carga el archivo con los resultados enviado por EXCOBA
ids_examen_excoba_2017 = CREATE DATASTORE 
ids_examen_excoba_2017.DATAOBJECT = "dw_resultado_examen_excoba_2017"
ids_examen_excoba_2017.SETTRANSOBJECT(gtr_sadm)
ll_rows = ids_examen_excoba_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_folio_inicial, ll_folio_final, ll_id_fecha) 

////Reporta el resultado del examen
//ids_examen_modulo_2017 = CREATE DATASTORE 
//ids_examen_modulo_2017.DATAOBJECT = "dw_resultado_examen_modulo_2017"
//ids_examen_modulo_2017.SETTRANSOBJECT(gtr_sadm)
//ll_rows = ids_examen_modulo_2017.RETRIEVE() 

// Se carga la configuración de la evaluación. 
ids_area_evaluacion = CREATE DATASTORE 
ids_area_evaluacion.DATAOBJECT = "dw_area_evaluacion_2017"  
ids_area_evaluacion.SETTRANSOBJECT(gtr_sadm) 
ll_rows = ids_area_evaluacion.RETRIEVE()

// Se carga la configuración de evaluación del examen. 
ids_parametros_area_examen2017 = CREATE DATASTORE 
ids_parametros_area_examen2017.DATAOBJECT = "dw_parametros_area_examen2017"
ids_parametros_area_examen2017.SETTRANSOBJECT(gtr_sadm) 
ll_rows = ids_parametros_area_examen2017.RETRIEVE() 

//// Se carga el detalle de configuración de evaluación.
//ids_parametros_area_exam_peso = CREATE DATASTORE 
//ids_parametros_area_exam_peso.DATAOBJECT = "dw_parametros_area_exam_peso2" 
//ids_parametros_area_exam_peso.SETTRANSOBJECT(gtr_sadm) 
//ids_parametros_area_exam_peso.RETRIEVE()


// Datastores de Actualización del resultado de la evaluación. 
ids_resultado_examen_modulo_2017 = CREATE DATASTORE 
ids_resultado_examen_modulo_2017.DATAOBJECT = "dw_update_resultado_examen_modulo_2017"
ids_resultado_examen_modulo_2017.SETTRANSOBJECT(gtr_sadm)
ll_rows = ids_resultado_examen_modulo_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_id_fecha) 


ids_resultado_examen_mod_area_2017 = CREATE DATASTORE 
ids_resultado_examen_mod_area_2017.DATAOBJECT = "dw_update_resultado_examen_mod_area_2017" 
ids_resultado_examen_mod_area_2017.SETTRANSOBJECT(gtr_sadm)
ll_rows = ids_resultado_examen_mod_area_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_id_fecha)


ids_update_aspiran_2017 = CREATE DATASTORE 
ids_update_aspiran_2017.DATAOBJECT = "dw_update_aspiran_2017" 
ids_update_aspiran_2017.SETTRANSOBJECT(gtr_sadm)
ll_rows = ids_update_aspiran_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_id_fecha) 

//ids_resultado_examen_modsql_2017 = CREATE DATASTORE 
//ids_resultado_examen_modsql_2017.DATAOBJECT = "dw_update_resultado_examen_modsql_2017"
//ids_resultado_examen_modsql_2017.SETTRANSOBJECT(itr_admision_web)
////ids_resultado_examen_modsql_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_id_fecha)
//
//ids_resultado_exa_mod_areasql_2017 = CREATE DATASTORE  
//ids_resultado_exa_mod_areasql_2017.DATAOBJECT = "dw_update_resultado_ex_mod_areasql_2017"
//ids_resultado_exa_mod_areasql_2017.SETTRANSOBJECT(itr_admision_web)
////ids_resultado_exa_mod_areasql_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_id_fecha)  
//

RETURN 0 





//dw_resultado_examen_excoba_2017
//dw_resultado_examen_modulo_2017
//dw_resultado_examen_mod_area_2017
end function

public function integer f_recupera_fechas ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

dw_fecha_examen.RESET()
dw_fecha_examen.INSERTROW(0)

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas
dw_fecha_examen.GETCHILD("id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 

RETURN 0 



end function

on w_califica_aspirantes_2017.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.st_3=create st_3
this.dw_fecha_examen=create dw_fecha_examen
this.st_progreso=create st_progreso
this.dw_reporte=create dw_reporte
this.dw_resultado_examen_modulo_cons=create dw_resultado_examen_modulo_cons
this.dw_modulo_examen=create dw_modulo_examen
this.dw_resultado_examen_modulo=create dw_resultado_examen_modulo
this.dw_aspiran_pago_examen=create dw_aspiran_pago_examen
this.em_max=create em_max
this.em_min=create em_min
this.st_1=create st_1
this.cb_califica=create cb_califica
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_3
this.Control[iCurrent+2]=this.dw_fecha_examen
this.Control[iCurrent+3]=this.st_progreso
this.Control[iCurrent+4]=this.dw_reporte
this.Control[iCurrent+5]=this.dw_resultado_examen_modulo_cons
this.Control[iCurrent+6]=this.dw_modulo_examen
this.Control[iCurrent+7]=this.dw_resultado_examen_modulo
this.Control[iCurrent+8]=this.dw_aspiran_pago_examen
this.Control[iCurrent+9]=this.em_max
this.Control[iCurrent+10]=this.em_min
this.Control[iCurrent+11]=this.st_1
this.Control[iCurrent+12]=this.cb_califica
this.Control[iCurrent+13]=this.uo_1
end on

on w_califica_aspirantes_2017.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_3)
destroy(this.dw_fecha_examen)
destroy(this.st_progreso)
destroy(this.dw_reporte)
destroy(this.dw_resultado_examen_modulo_cons)
destroy(this.dw_modulo_examen)
destroy(this.dw_resultado_examen_modulo)
destroy(this.dw_aspiran_pago_examen)
destroy(this.em_max)
destroy(this.em_min)
destroy(this.st_1)
destroy(this.cb_califica)
destroy(this.uo_1)
end on

event activate;x=1
y=1

end event

event open;call super::open;dw_aspiran_pago_examen.SetTransObject(gtr_sadm)
dw_resultado_examen_modulo.SetTransObject(gtr_sadm)
dw_modulo_examen.SetTransObject(gtr_sadm)
dw_resultado_examen_modulo_cons.SetTransObject(gtr_sadm)
this.of_SetResize(TRUE)

this.inv_resize.of_Register &
 (dw_aspiran_pago_examen, this.inv_resize.SCALERIGHT)

this.inv_resize.of_Register &
 (dw_resultado_examen_modulo, this.inv_resize.SCALERIGHT)

this.inv_resize.of_Register &
 (dw_resultado_examen_modulo_cons, this.inv_resize.SCALERIGHTBOTTOM)


dw_resultado_examen_modulo_cons.of_SetSort(TRUE)
dw_resultado_examen_modulo_cons.inv_sort.of_SetColumnHeader(TRUE)

INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

f_recupera_fechas()
end event

event close;call super::close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type st_3 from statictext within w_califica_aspirantes_2017
integer x = 64
integer y = 260
integer width = 571
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Fecha Aplicación:"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_fecha_examen from datawindow within w_califica_aspirantes_2017
integer x = 658
integer y = 236
integer width = 1202
integer height = 104
integer taborder = 30
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_progreso from statictext within w_califica_aspirantes_2017
integer x = 73
integer y = 392
integer width = 2999
integer height = 128
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 67108864
boolean focusrectangle = false
end type

type dw_reporte from datawindow within w_califica_aspirantes_2017
integer x = 55
integer y = 536
integer width = 4805
integer height = 1656
integer taborder = 70
string dataobject = "dw_resultado_examen_modulo_2017"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

type dw_resultado_examen_modulo_cons from u_dw within w_califica_aspirantes_2017
boolean visible = false
integer x = 50
integer y = 1348
integer width = 3438
integer height = 468
integer taborder = 90
string dataobject = "d_resultado_examen_modulo"
boolean hscrollbar = true
boolean resizable = true
end type

type dw_modulo_examen from u_dw within w_califica_aspirantes_2017
boolean visible = false
integer x = 59
integer y = 332
integer width = 2162
integer height = 196
integer taborder = 50
string dataobject = "d_modulo_examen_lista"
end type

type dw_resultado_examen_modulo from u_dw within w_califica_aspirantes_2017
boolean visible = false
integer x = 50
integer y = 992
integer width = 3438
integer height = 332
integer taborder = 80
string dataobject = "d_resultado_examen_modulo_folio"
boolean hscrollbar = true
boolean resizable = true
end type

type dw_aspiran_pago_examen from u_dw within w_califica_aspirantes_2017
boolean visible = false
integer x = 50
integer y = 568
integer width = 3438
integer height = 408
integer taborder = 60
string dataobject = "d_aspiran_pago_examen_2014"
boolean hscrollbar = true
boolean resizable = true
end type

type em_max from editmask within w_califica_aspirantes_2017
integer x = 2377
integer y = 172
integer width = 407
integer height = 100
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ","
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(1))
end event

event getfocus;text=string(event num_folios(1))
end event

type em_min from editmask within w_califica_aspirantes_2017
integer x = 2377
integer y = 44
integer width = 407
integer height = 100
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;text=string(event num_folios(0))
end event

event getfocus;text=string(event num_folios(0))
end event

type st_1 from statictext within w_califica_aspirantes_2017
boolean visible = false
integer x = 937
integer y = 228
integer width = 1189
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type cb_califica from commandbutton within w_califica_aspirantes_2017
integer x = 2880
integer y = 56
integer width = 430
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Califica"
end type

event clicked;st_progreso.TEXT = "Cargando Información..."

long ll_id_fecha
ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
	RETURN -1
END IF


IF f_carga_informacion() < 0 THEN RETURN 



/**************************************/
// Se pasan los datos a los DS de actualización de SQLSERVER 
DATASTORE lds_update_aspiran_2017 
lds_update_aspiran_2017 = CREATE DATASTORE 
lds_update_aspiran_2017.DATAOBJECT = ids_update_aspiran_2017.DATAOBJECT 

ids_resultado_examen_modsql_2017 = CREATE DATASTORE 
ids_resultado_examen_modsql_2017.DATAOBJECT = ids_resultado_examen_modulo_2017.DATAOBJECT 
ids_resultado_examen_modsql_2017.SETTRANSOBJECT(itr_admision_web)
//ids_resultado_examen_modsql_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_id_fecha)

ids_resultado_exa_mod_areasql_2017 = CREATE DATASTORE  
ids_resultado_exa_mod_areasql_2017.DATAOBJECT = ids_resultado_examen_mod_area_2017.DATAOBJECT 
ids_resultado_exa_mod_areasql_2017.SETTRANSOBJECT(itr_admision_web)
//ids_resultado_exa_mod_areasql_2017.RETRIEVE(gi_version,gi_periodo,gi_anio, ll_id_fecha)  
/**************************************/

LONG ll_pos, ll_ttl_evaluaciones
LONG folio
DECIMAL ld_espaniol_primaria
DECIMAL ld_matematicas_primaria
DECIMAL ld_espaniol_secundaria
DECIMAL ld_matematicas_secundaria
DECIMAL ld_cs_naturales_secundaria
DECIMAL ld_cs_sociales_secundaria
DECIMAL ld_asignatura_1
DECIMAL ld_asignatura_2
DECIMAL ld_asignatura_3 
LONG ll_cve_carrera
STRING ls_busca 
LONG ll_encuentra , ll_row_aspiran
DECIMAL resultado_excoba   
DECIMAL resultado_ponderado
INTEGER le_numero_reactivos 
DECIMAL ld_peso_area
LONG ll_row_resul_area, ll_row_resul_total
INTEGER le_area
INTEGER le_pos_area 
DECIMAL ld_aciertos_area
DECIMAL ld_total_aciertos
DECIMAL le_total_reactivos
DECIMAL ld_calificacion_global_examen 
DECIMAL ld_calificacion_global_porc, 	ld_puntaje_total, ld_promedio_aspiran, ld_prcn_promedio, ld_prcn_examen
STRING ls_busca_resultado 

LONG ll_folio 
INTEGER le_clv_ver 
INTEGER le_clv_per 
INTEGER le_anio 
DECIMAL ld_promedio 
DECIMAL ld_puntaje 
STRING ls_error
DECIMAL ld_calificacion_global_examenU
DECIMAL ld_calificacion_global_porcU

INTEGER le_cve_area_examenU, le_ttl_delete
DECIMAL ld_resultado_excobaU
DECIMAL ld_resultado_ponderadoU
	
ll_ttl_evaluaciones = ids_examen_excoba_2017.ROWCOUNT()  

// Se hace ciclo para evaluar cada uno de los aspirantes reportados.
FOR ll_pos = 1 TO ll_ttl_evaluaciones 

	st_progreso.TEXT = "Procesando " + STRING(ll_pos) + " de " + STRING(ll_ttl_evaluaciones)

	folio = ids_examen_excoba_2017.GETITEMNUMBER(ll_pos, "aspiran_folio")
	IF ISNULL(folio) THEN CONTINUE 
	ll_cve_carrera =  ids_examen_excoba_2017.GETITEMNUMBER(ll_pos, "resultado_examen_excoba_2017_cve_carrera") 
	IF ISNULL(ll_cve_carrera) THEN CONTINUE 
	ld_espaniol_primaria = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_espaniol_primaria")
	IF ISNULL(ld_espaniol_primaria) THEN ld_espaniol_primaria = 0 
	ld_matematicas_primaria = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_matematicas_primaria")
	IF ISNULL(ld_matematicas_primaria) THEN ld_matematicas_primaria = 0 
	ld_espaniol_secundaria = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_espaniol_secundaria")
	IF ISNULL(ld_espaniol_secundaria) THEN ld_espaniol_secundaria = 0 
	ld_matematicas_secundaria = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_matematicas_secundaria")
	IF ISNULL(ld_matematicas_secundaria) THEN ld_matematicas_secundaria = 0 
	ld_cs_naturales_secundaria = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_cs_naturales_secundaria")
	IF ISNULL(ld_cs_naturales_secundaria) THEN ld_cs_naturales_secundaria = 0 
	ld_cs_sociales_secundaria = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_cs_sociales_secundaria")
	IF ISNULL(ld_cs_sociales_secundaria) THEN ld_cs_sociales_secundaria = 0 
	ld_asignatura_1 = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_asignatura_1")
	IF ISNULL(ld_asignatura_1) THEN ld_asignatura_1 = 0 
	ld_asignatura_2 = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_asignatura_2")
	IF ISNULL(ld_asignatura_2) THEN ld_asignatura_2 = 0 
	ld_asignatura_3 = ids_examen_excoba_2017.GETITEMDECIMAL(ll_pos, "resultado_examen_excoba_2017_asignatura_3")
	IF ISNULL(ld_asignatura_3) THEN ld_asignatura_3 = 0 
	
	// Se busca el porcentaje de ponderación 
	// Se verifica si existe configuración para la carrera, de lo contrario se asigna "cualquier carrera" 
	ls_busca = "cve_carrera = " + STRING(ll_cve_carrera)  
	ll_encuentra = ids_parametros_area_examen2017.FIND(ls_busca, 0, ids_parametros_area_examen2017.ROWCOUNT() + 1)  
	IF ll_encuentra <= 0 THEN  ll_cve_carrera = 9999 
	

		
	// Se hace ciclo por cada una de las áreas 
	FOR le_pos_area = 1 TO ids_area_evaluacion.ROWCOUNT() 

		ls_busca = "cve_carrera = " + STRING(ll_cve_carrera)  + " AND parametros_area_exam_peso_cve_area_examen = " + STRING(le_pos_area) 
		ll_encuentra = ids_parametros_area_examen2017.FIND(ls_busca, 0, ids_parametros_area_examen2017.ROWCOUNT() + 1)  
		IF ll_encuentra > 0 THEN 
			// Se recupera el peso en porcentaje del área 
			ld_peso_area = ids_parametros_area_examen2017.GETITEMDECIMAL(ll_encuentra, "parametros_area_exam_peso_peso_area") 
			IF ISNULL(ld_peso_area) THEN ld_peso_area = 0 
			ld_prcn_examen = ids_parametros_area_examen2017.GETITEMDECIMAL(ll_encuentra, "porcentaje_examen") 
			IF ISNULL(ld_prcn_examen) THEN ld_prcn_examen = 0 
			ld_prcn_promedio = ids_parametros_area_examen2017.GETITEMDECIMAL(ll_encuentra, "porcentaje_promedio") 
			IF ISNULL(ld_prcn_promedio) THEN ld_prcn_promedio = 0 
		END IF		
		
		le_area = ids_area_evaluacion.GETITEMNUMBER(le_pos_area, "id_area")
		
		//*ESTA PARTE DEL CÖDIGO ESTA EN DURO PORQUE DEPENDE DE EL NUMERO DE AREAS QUE REPORTA EXCOBA*
		CHOOSE CASE le_pos_area 
			CASE 1
				ld_aciertos_area = ld_espaniol_primaria
			CASE 2
				ld_aciertos_area = ld_matematicas_primaria
			CASE 3
				ld_aciertos_area = ld_espaniol_secundaria
			CASE 4
				ld_aciertos_area = ld_matematicas_secundaria
			CASE 5
				ld_aciertos_area = ld_cs_naturales_secundaria
			CASE 6
				ld_aciertos_area = ld_cs_sociales_secundaria
			CASE 7
				ld_aciertos_area = ld_asignatura_1
			CASE 8
				ld_aciertos_area = ld_asignatura_2
			CASE 9
				ld_aciertos_area = ld_asignatura_3
		END CHOOSE
		
		//Se asigna el valor del área y el número de aciertos.
		le_numero_reactivos = ids_area_evaluacion.GETITEMNUMBER(le_pos_area, "numero_reactivos") 
			//*En esta versión son 20 por default* 
		IF ISNULL(le_numero_reactivos) THEN le_numero_reactivos = 20 
	
		// Se calculan los resultados.
		resultado_excoba = (ld_aciertos_area * 100.00) /le_numero_reactivos
		resultado_ponderado = (ld_aciertos_area * ld_peso_area) /le_numero_reactivos
	
		ls_busca_resultado = " folio = " + STRING(folio) + " AND cve_area_examen = " + STRING(le_area) 
		ll_row_resul_area = ids_resultado_examen_mod_area_2017.FIND(ls_busca_resultado, 0, ids_resultado_examen_mod_area_2017.ROWCOUNT() + 1) 
		IF ll_row_resul_area <= 0 THEN 
			ll_row_resul_area = ids_resultado_examen_mod_area_2017.INSERTROW(0) 
		END IF
		
		// Se insertan los datos en el detalle de resultado por área. 
		ids_resultado_examen_mod_area_2017.SETITEM(ll_row_resul_area, "folio", folio)
		ids_resultado_examen_mod_area_2017.SETITEM(ll_row_resul_area, "cve_area_examen", le_area)
		ids_resultado_examen_mod_area_2017.SETITEM(ll_row_resul_area, "resultado_excoba", resultado_excoba)
		ids_resultado_examen_mod_area_2017.SETITEM(ll_row_resul_area, "resultado_ponderado", resultado_ponderado) 

		ld_total_aciertos = ld_total_aciertos  + ld_aciertos_area
		le_total_reactivos = le_total_reactivos + le_numero_reactivos
		
		ld_calificacion_global_examen = ld_calificacion_global_examen + resultado_ponderado

	NEXT 

	ld_calificacion_global_porc = (ld_total_aciertos * 100.00) / le_total_reactivos


	ls_busca_resultado = " folio = " + STRING(folio) + " AND clv_ver = " + STRING(gi_version) + " AND clv_per = " + STRING(gi_periodo) + " AND anio = " + STRING (gi_anio)
	ll_row_resul_total = ids_resultado_examen_modulo_2017.FIND(ls_busca_resultado, 0, ids_resultado_examen_modulo_2017.ROWCOUNT() + 1)  
	IF ll_row_resul_total <= 0 THEN 
		ll_row_resul_total = ids_resultado_examen_modulo_2017.INSERTROW(0)
	END IF
	ids_resultado_examen_modulo_2017.SETITEM(ll_row_resul_total, "folio", folio)
	ids_resultado_examen_modulo_2017.SETITEM(ll_row_resul_total, "clv_ver", gi_version)
	ids_resultado_examen_modulo_2017.SETITEM(ll_row_resul_total, "clv_per", gi_periodo)
	ids_resultado_examen_modulo_2017.SETITEM(ll_row_resul_total, "anio", gi_anio)
	ids_resultado_examen_modulo_2017.SETITEM(ll_row_resul_total, "calificacion_global_examen", ld_calificacion_global_examen)
	ids_resultado_examen_modulo_2017.SETITEM(ll_row_resul_total, "calificacion_global_porc", ld_calificacion_global_porc)


	// Se asigna el puntaje total del aspirante 
	ls_busca_resultado = "folio = " + STRING(folio)  
	ll_row_aspiran = ids_update_aspiran_2017.FIND(ls_busca_resultado, 0, ids_update_aspiran_2017.ROWCOUNT() + 1) 
	IF ll_row_aspiran > 0 THEN 
		ld_promedio_aspiran = ids_update_aspiran_2017.GETITEMDECIMAL(ll_row_aspiran, "promedio")  
		IF ISNULL(ld_promedio_aspiran) THEN ld_promedio_aspiran = 0 
			ld_puntaje_total = (ld_promedio_aspiran * (ld_prcn_promedio/100.00)) + (ld_calificacion_global_examen * (ld_prcn_examen/100.00))  
			ld_puntaje_total = ROUND(ld_puntaje_total, 2) * 100
			ids_update_aspiran_2017.SETITEM(ll_row_aspiran, "puntaje", ld_puntaje_total)
	END IF

	ld_total_aciertos = 0
	le_total_reactivos = 0
	ld_calificacion_global_examen = 0 
	ld_calificacion_global_porc = 0
	ld_puntaje_total = 0
	
	

	
NEXT 

st_progreso.TEXT = "Actualizando resultados... "

/**************************************/
// Se pasan los datos a los DS de actualización de SQLSERVER 
INTEGER le_pos 

//le_ttl_delete = ids_resultado_examen_modsql_2017.ROWCOUNT() 
//FOR le_pos = 1 TO le_ttl_delete
//	ids_resultado_examen_modsql_2017.DELETEROW(1) 
//NEXT 	
//le_ttl_delete = ids_resultado_examen_modsql_2017.UPDATE() 

//le_ttl_delete = ids_resultado_exa_mod_areasql_2017.ROWCOUNT() 
//FOR le_pos = 1 TO le_ttl_delete  
//	ids_resultado_exa_mod_areasql_2017.DELETEROW(1) 
//NEXT 	
//le_ttl_delete = ids_resultado_exa_mod_areasql_2017.UPDATE()

ids_resultado_exa_mod_areasql_2017.RESET()
ids_resultado_examen_modsql_2017.RESET() 

le_pos = ids_resultado_examen_modulo_2017.ROWSCOPY(1, ids_resultado_examen_modulo_2017.ROWCOUNT(), PRIMARY!, ids_resultado_examen_modsql_2017, 1, PRIMARY!)
le_pos = ids_resultado_examen_mod_area_2017.ROWSCOPY(1, ids_resultado_examen_mod_area_2017.ROWCOUNT(), PRIMARY!, ids_resultado_exa_mod_areasql_2017, 1, PRIMARY!) 
le_pos = ids_update_aspiran_2017.ROWSCOPY(1, ids_update_aspiran_2017.ROWCOUNT(), PRIMARY!, lds_update_aspiran_2017, 1, PRIMARY!)
/**************************************/

IF ids_resultado_examen_modulo_2017.UPDATE() < 0 THEN 
	ROLLBACK USING gtr_sadm; 
	MessageBox("Error de actualización", "Error de actualización de resultado del módulo",StopSign!)
	RETURN -1
END IF 

IF ids_resultado_examen_mod_area_2017.UPDATE() < 0 THEN 
	ROLLBACK USING gtr_sadm; 
	MessageBox("Error de actualización", "Error de actualización de resultado del módulo por área",StopSign!)
	RETURN -1
END IF 

IF ids_update_aspiran_2017.UPDATE() < 0 THEN 
	ROLLBACK USING gtr_sadm; 
	MessageBox("Error de actualización", "Error de actualización de resultado del aspirante",StopSign!) 
	RETURN -1
END IF 

// Se actualiza el promedio de bachillerato y el puntaje obtenido 
FOR le_pos = 1 TO ids_update_aspiran_2017.ROWCOUNT()  

	ll_folio = ids_update_aspiran_2017.GETITEMNUMBER(le_pos, "folio")
	le_clv_ver = ids_update_aspiran_2017.GETITEMNUMBER(le_pos, "clv_ver")
	le_clv_per = ids_update_aspiran_2017.GETITEMNUMBER(le_pos, "clv_per")
	le_anio = ids_update_aspiran_2017.GETITEMNUMBER(le_pos, "anio")
	ld_promedio = ids_update_aspiran_2017.GETITEMNUMBER(le_pos, "promedio")
	ld_puntaje = ids_update_aspiran_2017.GETITEMNUMBER(le_pos, "puntaje")

	UPDATE aspiran
		SET puntaje = :ld_puntaje, 
			promedio = :ld_promedio
		WHERE folio =:ll_folio
		AND clv_ver = :le_clv_ver 
		AND clv_per = :le_clv_per 
		AND anio = :le_anio 
	USING itr_admision_web; 	
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		ROLLBACK USING gtr_sadm; 
		ROLLBACK USING itr_admision_web;
		MessageBox("Error de actualización", "Error de actualización de puntaje y promedio en WEB: " + ls_error,StopSign!)
		RETURN -1			
	END IF 
	
	// Se eliminan los detalles previos de calificación 
	DELETE FROM resultado_examen_modulo_2017 
	WHERE folio = :ll_folio 
	AND clv_ver = :le_clv_ver 	
	AND clv_per = :le_clv_per 	
	AND anio = :le_anio
	USING itr_admision_web; 		
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		ROLLBACK USING gtr_sadm; 
		ROLLBACK USING itr_admision_web;
		MessageBox("Error de actualización", "Error de actualización de puntaje y promedio en WEB: " + ls_error,StopSign!)
		RETURN -1			
	END IF 	
	
	DELETE FROM resultado_examen_mod_area_2017 
	WHERE folio = :ll_folio 
	USING itr_admision_web; 		
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		ROLLBACK USING gtr_sadm; 
		ROLLBACK USING itr_admision_web;
		MessageBox("Error de actualización", "Error de actualización de puntaje y promedio en WEB: " + ls_error,StopSign!)
		RETURN -1			
	END IF 	
	
NEXT 	

/*SE AGREGA BLOQUE PARA ACTUALIZAR LAS CALIFICACIONES EN SQL SERVER*/ 
//ids_resultado_examen_modsql_2017.SETTRANSOBJECT(itr_admision_web)
FOR le_pos = 1 TO ids_resultado_examen_modsql_2017.ROWCOUNT() 
	
	ll_folio = ids_resultado_examen_modsql_2017.GETITEMNUMBER(le_pos, "folio")
	le_clv_ver = ids_resultado_examen_modsql_2017.GETITEMNUMBER(le_pos, "clv_ver")
	le_clv_per = ids_resultado_examen_modsql_2017.GETITEMNUMBER(le_pos, "clv_per")
	le_anio = ids_resultado_examen_modsql_2017.GETITEMNUMBER(le_pos, "anio")	
	ld_calificacion_global_examenU = ids_resultado_examen_modsql_2017.GETITEMNUMBER(le_pos, "calificacion_global_examen")	
	ld_calificacion_global_porcU = ids_resultado_examen_modsql_2017.GETITEMNUMBER(le_pos, "calificacion_global_porc")		
	
	INSERT INTO resultado_examen_modulo_2017(folio, clv_ver, clv_per,anio, calificacion_global_examen, calificacion_global_porc)
     VALUES (:ll_folio, 	:le_clv_ver, 	:le_clv_per, 	:le_anio, 	:ld_calificacion_global_examenU, 	:ld_calificacion_global_porcU) 
	 USING itr_admision_web; 
	 IF itr_admision_web.SQLCODE < 0 THEN 
		ROLLBACK USING gtr_sadm; 
		ROLLBACK USING itr_admision_web;
		MessageBox("Error de actualización", "Error de actualización de resultado del módulo en WEB",StopSign!)
		RETURN -1	
	END IF 	
	
NEXT 

//ids_resultado_exa_mod_areasql_2017.SETTRANSOBJECT(itr_admision_web)
FOR le_pos = 1 TO ids_resultado_exa_mod_areasql_2017.ROWCOUNT() 
	
	ll_folio =  ids_resultado_exa_mod_areasql_2017.GETITEMNUMBER(le_pos, "folio")
	le_cve_area_examenU =  ids_resultado_exa_mod_areasql_2017.GETITEMNUMBER(le_pos, "cve_area_examen") 
	ld_resultado_excobaU =  ids_resultado_exa_mod_areasql_2017.GETITEMDECIMAL(le_pos, "resultado_excoba")  
	ld_resultado_ponderadoU =  ids_resultado_exa_mod_areasql_2017.GETITEMDECIMAL(le_pos, "resultado_ponderado")	 
	
	INSERT INTO resultado_examen_mod_area_2017(folio, cve_area_examen, resultado_excoba, resultado_ponderado) 
	VALUES(:ll_folio, :le_cve_area_examenU, :ld_resultado_excobaU, :ld_resultado_ponderadoU) 
	 USING itr_admision_web; 	
	
	IF itr_admision_web.SQLCODE < 0 THEN  
		ROLLBACK USING gtr_sadm; 
		ROLLBACK USING itr_admision_web;
		MessageBox("Error de actualización", "Error de actualización de resultado del módulo por área en WEB",StopSign!)
		RETURN -1	
	END IF 	

NEXT


/**************************************************************/



COMMIT USING gtr_sadm; 
COMMIT USING itr_admision_web; 

LONG ll_folio_inicial, ll_folio_final 

ll_folio_inicial = long(em_min.text)
ll_folio_final   = long(em_max.text)

st_progreso.TEXT = "Proceso Terminado."
dw_reporte.SETTRANSOBJECT(gtr_sadm)
dw_reporte.RETRIEVE(gi_version,gi_periodo, gi_anio, ll_id_fecha, ll_folio_inicial, ll_folio_final) 

RETURN 0 

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

////Modificado el 21 de Enero de 2014
////Por la nueva ponderación del CENEVAL 2014 
////Desaparece la sección 5 de Tecnologías de información y Comunicación
//
//
//long foli,fol,ll_folio_inicial, ll_folio_final, ll_rows, ll_row, ll_folio, ll_row_resultado, ll_insertrow
//int carr,area, li_cve_tipo_examen = 1, li_cve_modulo_examen = 1, li_update
//real valor, acumula
//dec ld_area_ceneval_1, ld_area_ceneval_2, ld_area_ceneval_3, ld_area_ceneval_4, ld_area_ceneval_5
//dec ld_area_1, ld_area_2, ld_area_3, ld_area_4, ld_area_5, ld_calificacion_global, ld_numerador
//dec ld_peso_area_1, ld_peso_area_2, ld_peso_area_3, ld_peso_area_4, ld_peso_area_5, ld_peso_total
//integer li_cve_area_examen_1, li_cve_area_examen_2, li_cve_area_examen_3, li_cve_area_examen_4, li_cve_area_examen_5
//integer li_obten_parametros_area_examen, li_confirma_periodo
//
//SetPointer(HourGlass!)
//
//li_confirma_periodo = f_confirma_periodo()
//if li_confirma_periodo= -1 or isnull(li_confirma_periodo) then
//	MessageBox("Error al elegir el periodo", "No es una versión de examen válida", StopSign!)
//	return
//elseif li_confirma_periodo<> 1 then
//	MessageBox("Cancelación del proceso", "No se ejecutará el proceso cálculo de calificaciones", StopSign!)
//	return
//END IF
//
//SetPointer(HourGlass!)
//
//ll_folio_inicial = long(em_min.text)
//ll_folio_final   = long(em_max.text)
//
//ll_rows = dw_aspiran_pago_examen.Retrieve(gi_version,gi_periodo, gi_anio,ll_folio_inicial, ll_folio_final)
//	
////Solo examen de seleccion (sin diagnóstico)
//li_cve_tipo_examen = 1
//li_cve_modulo_examen = 1
//
//li_obten_parametros_area_examen = f_obten_parametros_area_examen(li_cve_tipo_examen, li_cve_modulo_examen,& 
//ld_peso_area_1, ld_peso_area_2, ld_peso_area_3, ld_peso_area_4, ld_peso_area_5,&
//li_cve_area_examen_1, li_cve_area_examen_2, li_cve_area_examen_3, li_cve_area_examen_4, li_cve_area_examen_5)
//
// 	
//IF li_obten_parametros_area_examen = -1 THEN
//	MessageBox("Error al consultar parametros_area_examen", "No es posible determinar la ponderación del examen", StopSign!)
//	return
//END IF
//
//for ll_row=1 to ll_rows
//	dw_aspiran_pago_examen.ScrollToRow(ll_row)
//	ll_folio = dw_aspiran_pago_examen.GetItemNumber(ll_row,"folio")
//	st_1.text = "Folio ["+string(ll_folio)+"] "+string(ll_row)+" de "+string(ll_rows)
//	
//	dw_resultado_examen_modulo.Reset()
//	ll_row_resultado = dw_resultado_examen_modulo.Retrieve(ll_folio,gi_version,gi_periodo, gi_anio, li_cve_tipo_examen, li_cve_modulo_examen)
//	
//   //Si no existe el renglón es porque es nuevo y hay que insertarlo
//	if ll_row_resultado = 0 then
//		ll_insertrow = dw_resultado_examen_modulo.InsertRow(0)
//		if ll_insertrow = -1 or isnull(ll_insertrow) then
//			MessageBox("Error de inserción", "Error de inserción de resultado del módulo",StopSign!)
//			return
//		else
//			ll_row_resultado = ll_insertrow
//			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "folio", ll_folio)
//			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "clv_ver", gi_version)
//			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "clv_per", gi_periodo)
//			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "anio", gi_anio)
//			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "cve_tipo_examen", li_cve_tipo_examen)
//			dw_resultado_examen_modulo.SetItem(ll_row_resultado, "cve_modulo_examen", li_cve_modulo_examen)			
//		end if		
//	end if
//	//Obtiene el puntaje obtenido
//	ld_area_ceneval_1 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_1")
//	ld_area_ceneval_2 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_2")
//	ld_area_ceneval_3 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_3")
//	ld_area_ceneval_4 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_4")
////Modificado	 21-Enero-2014
////	ld_area_ceneval_5 = dw_aspiran_pago_examen.GetItemNumber(ll_row,"area_5")
//	//Convierte el puntaje a la escala 0-100
//	ld_area_1 = f_convierte_puntaje_ceneval(ld_area_ceneval_1)
//	ld_area_2 = f_convierte_puntaje_ceneval(ld_area_ceneval_2)
//	ld_area_3 = f_convierte_puntaje_ceneval(ld_area_ceneval_3)
//	ld_area_4 = f_convierte_puntaje_ceneval(ld_area_ceneval_4)
////Modificado	 21-Enero-2014
////	ld_area_5 = f_convierte_puntaje_ceneval(ld_area_ceneval_5)
//	ld_numerador = (ld_area_1*ld_peso_area_1 + ld_area_2*ld_peso_area_2 + &
//	  ld_area_3*ld_peso_area_3 + ld_area_4*ld_peso_area_4 )
//	  
//	if ld_numerador >0.01 then
//		ld_calificacion_global = ld_numerador /100
//	elseif  isnull(ld_numerador) then 
//		ld_calificacion_global = 0
//	else
//		ld_calificacion_global = 0
//	end if
//	//Asigna el puntaje obtenido
//	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_1", ld_area_1)			
//	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_2", ld_area_2)			
//	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_3", ld_area_3)			
//	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_4", ld_area_4)			
////Modificado	 21-Enero-2014
////	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "area_5", ld_area_5)			
//	dw_resultado_examen_modulo.SetItem(ll_row_resultado, "calificacion_global_examen", ld_calificacion_global)			
//	li_update = dw_resultado_examen_modulo.Update()
//	if li_update = 1 then
//		commit using gtr_sadm;
//	else 
//		rollback using gtr_sadm;
//		MessageBox("Error de actualización", "Error de actualización de resultado del módulo",StopSign!)
//		return		
//	end if
//	f_asigna_puntaje_aspiran(ll_folio,gi_version,gi_periodo, gi_anio)
//
//next
//dw_resultado_examen_modulo.Reset()
//
//dw_resultado_examen_modulo_cons.Retrieve(gi_version,gi_periodo, gi_anio, ll_folio_inicial, ll_folio_final,li_cve_tipo_examen, li_cve_modulo_examen)
//
//






 
end event

type uo_1 from uo_ver_per_ani within w_califica_aspirantes_2017
integer x = 27
integer y = 48
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;
f_recupera_fechas()

RETURN 



end event

