$PBExportHeader$w_corte_documentos.srw
forward
global type w_corte_documentos from window
end type
type st_tipo_periodo from statictext within w_corte_documentos
end type
type cb_2 from commandbutton within w_corte_documentos
end type
type st_estatus from statictext within w_corte_documentos
end type
type cb_1 from commandbutton within w_corte_documentos
end type
type st_1 from statictext within w_corte_documentos
end type
type st_2 from statictext within w_corte_documentos
end type
end forward

global type w_corte_documentos from window
integer x = 832
integer y = 364
integer width = 2779
integer height = 1876
boolean titlebar = true
string title = "Corte de Documentos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
st_tipo_periodo st_tipo_periodo
cb_2 cb_2
st_estatus st_estatus
cb_1 cb_1
st_1 st_1
st_2 st_2
end type
global w_corte_documentos w_corte_documentos

forward prototypes
public function integer wf_valida_transaccion (string as_proceso_realizado)
end prototypes

public function integer wf_valida_transaccion (string as_proceso_realizado);string ls_mensaje_sql
integer li_codigo_sql

ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	rollback using gtr_sce;
	MessageBox("Error en "+as_proceso_realizado,  ls_mensaje_sql)
end if

return li_codigo_sql
end function

event open; 

st_2.text = &
"Este proceso ejecuta el corte de documentos en once partes~n"	+ &
"[1] Bloquea a todos los alumnos.~n"+ &
"[2] Desbloquea a los alumnos de licenciatura que tienen sus~n"+&
"    documentos (1,2,3,33) en orden.~n"+ &
"[3] Desbloquea a los alumnos de licenciatura que tienen sus~n"+&
"    documentos (1,4,5,33) en orden.~n"+ &
"[4] Desbloquea a los alumnos de posgrado NO incorporado a sep~n"+&
"    que tienen sus documentos en orden.~n"+&
"[5] Desbloquea a los alumnos de posgrado incorporado a sep que~n"+&
"    tienen sus documentos en orden.~n"+&
"[6] Desbloquea a los alumnos de posgrado incorporado a sep que~n"+&
"    ingresaron con opción de titulación por creditos de posgrado.~n"+&
"[7] Desbloquea a los alumnos de posgrado incorporado a sep que~n"+&
"    ingresaron con opción de titulación por creditos de posgrado~n"+&
"    y que no cuentan con materias en su histórico.~n"+&
"[8] Desbloquea a los alumnos de doctorado que han entregado su título~n"+&
"    y cédula de maestría.~n"+&
"[9]  Bloqueos de alumnos extranjeros que no tengan la forma migratoria.~n"+&
"[10] Bloqueos de alumnos extranjeros que no tengan la traduccion de acta de nacimiento.~n"+&
"[11] Bloqueos de alumnos que tengan anomalía en cualquiera de sus documentos.~n"


st_tipo_periodo.TEXT = "Tipo Periodo para Corte: " + gs_descripcion_tipo_periodo



end event

on w_corte_documentos.create
this.st_tipo_periodo=create st_tipo_periodo
this.cb_2=create cb_2
this.st_estatus=create st_estatus
this.cb_1=create cb_1
this.st_1=create st_1
this.st_2=create st_2
this.Control[]={this.st_tipo_periodo,&
this.cb_2,&
this.st_estatus,&
this.cb_1,&
this.st_1,&
this.st_2}
end on

on w_corte_documentos.destroy
destroy(this.st_tipo_periodo)
destroy(this.cb_2)
destroy(this.st_estatus)
destroy(this.cb_1)
destroy(this.st_1)
destroy(this.st_2)
end on

type st_tipo_periodo from statictext within w_corte_documentos
integer x = 1289
integer y = 1480
integer width = 1198
integer height = 108
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 10789024
string text = "Tipo Periodo para Corte:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_corte_documentos
boolean visible = false
integer x = 1522
integer y = 1480
integer width = 1138
integer height = 108
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Anterior Corte de Documentos"
end type

event clicked;//	Antonio Pica Ruiz.							Junio-2001.
// 	Antonio Pica Ruiz.							Modificado 22 de Octubre de 2012.

IF Messagebox("Corte de Documentos","Desea Continuar",Question!,YesNo!,2) = 1 THEN
	
	Setpointer(hourglass!)
	st_estatus.Text = "PASO [1]"
	UPDATE banderas SET baja_documentos = 1 WHERE baja_documentos = 0 using gtr_sce;
	if wf_valida_transaccion("documentos [1]") = -1 then return

//UPDATE banderas SET baja_documentos = 1 WHERE baja_documentos = 0 AND cuenta IN
//(SELECT a.cuenta FROM academicos a, plan_estudios pe
// WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
// AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1) using gtr_sce;

	st_estatus.Text = "PASO [2]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT cuenta FROM academicos WHERE nivel NOT LIKE "P") and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 2 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 3 AND cve_flag_documento IN (1,2,6,10)) and cuenta NOT IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 33 AND cve_flag_documento IN (0,5,2)) using gtr_sce;
	if wf_valida_transaccion("documentos [2]") = -1 then return
	/*Linea sustituida: (SELECT cuenta FROM academicos WHERE nivel LIKE "L") and cuenta IN */

	st_estatus.Text = "PASO [3]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT cuenta FROM academicos WHERE nivel NOT LIKE "P") and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 4 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 5 AND cve_flag_documento IN (1,2,6,10)) and cuenta NOT IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 33 AND cve_flag_documento IN (0,5,2)) using gtr_sce;
	if wf_valida_transaccion("documentos [3]") = -1 then return
	/*(SELECT cuenta FROM academicos WHERE nivel LIKE "L") and cuenta IN*/

	st_estatus.Text = "PASO [4]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 0) AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento IN (4,7,10,12,13,21,25,30,35,36,42,43,44,47,39,46)
	 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento IN (5,8,13,30,35,36,37,40,43,45,47)
	 AND cve_flag_documento IN (1,2,6,10)) using gtr_sce;
	if wf_valida_transaccion("documentos [4]") = -1 then return


	st_estatus.Text = "PASO [5]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1) AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento IN  (4,7,13,25,36,43,44)
	 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento IN (5,8,13,25,36,43,45)
	 AND cve_flag_documento IN (1,2,6,10)) using gtr_sce;
	if wf_valida_transaccion("documentos [5]") = -1 then return


	st_estatus.Text = "PASO [6]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1) AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 38 AND cve_flag_documento IN (1,2,6,10)) and cuenta NOT IN
	(SELECT h.cuenta FROM historico h, academicos a, plan_estudios pe, materias m
	WHERE a.cve_carrera = h.cve_carrera AND a.cve_plan = h.cve_plan AND a.cuenta = h.cuenta AND 
	a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan AND h.cve_mat = m.cve_mat AND a.nivel LIKE "P" AND
	pe.incorporado_sep = 1 AND h.calificacion IN ("5","6","7","NA","S") AND m.creditos > 0) AND cuenta IN
	(SELECT h.cuenta FROM historico h, academicos a, plan_estudios pe, materias m
	WHERE a.cve_carrera = h.cve_carrera AND a.cve_plan = h.cve_plan AND  a.cuenta = h.cuenta AND 
	a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan AND h.cve_mat = m.cve_mat AND a.nivel LIKE "P" AND
	pe.incorporado_sep = 1 
	GROUP BY h.cuenta HAVING SUM(m.creditos)<=50) using gtr_sce;
	if wf_valida_transaccion("documentos [6]") = -1 then return

	st_estatus.Text = "PASO [7]"	
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1) 
	AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) 
	AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 38 AND cve_flag_documento IN (1,2,6,10)) 
	AND cuenta NOT IN
	(SELECT h.cuenta FROM historico h, academicos a, plan_estudios pe, materias m
	WHERE a.cve_carrera = h.cve_carrera AND a.cve_plan = h.cve_plan AND a.cuenta = h.cuenta AND 
	a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan AND h.cve_mat = m.cve_mat AND a.nivel LIKE "P" AND
	pe.incorporado_sep = 1 AND h.calificacion IN ("5","6","7","NA","S") AND m.creditos > 0) 
	AND cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	WHERE a.cve_carrera = pe.cve_carrera 
	AND a.cve_plan = pe.cve_plan 
	AND a.nivel LIKE "P" 
	AND pe.incorporado_sep = 1 
	AND a.cuenta  NOT in (select h.cuenta from historico h where
	h.cuenta = a.cuenta and h.cve_carrera = a.cve_carrera and h.cve_plan = a.cve_plan)) using gtr_sce;
	if wf_valida_transaccion("documentos [7]") = -1 then return

	st_estatus.Text = "PASO [8]"
	UPDATE banderas
	SET baja_documentos=0
	FROM academicos a, carreras c, banderas_inscrito bi, banderas ba
	WHERE a.cve_carrera = c.cve_carrera 
	AND a.cve_carrera = c.cve_carrera
	AND a.nivel LIKE  "P" AND c.carrera like "%DOCTORADO%" 
	AND a.cuenta = ba.cuenta 
	AND a.cuenta = bi.cuenta AND a.cuenta IN
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and a.cuenta IN
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (12,30,60,62,63) AND cve_flag_documento IN (1,2,6,10)) 
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (37,40,61,63) AND cve_flag_documento IN (1,2,6,10)) 
	using gtr_sce;
	if wf_valida_transaccion("documentos [8]") = -1 then
		return
	else
		st_estatus.Text = "ACTUALIZANDO"

		commit using gtr_sce;
	end if	       
  	Messagebox("Proceso Terminado","Se ha terminado el corte de documentos exitosamente", Information!)
	st_estatus.Text = "CORTE EXITOSO"

END IF

end event

type st_estatus from statictext within w_corte_documentos
integer x = 256
integer y = 1608
integer width = 2235
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 10789024
boolean enabled = false
string text = "ESTATUS PROCESO"
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_corte_documentos
integer x = 251
integer y = 1480
integer width = 987
integer height = 108
integer taborder = 1
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Corte de Documentos"
end type

event clicked;//	Antonio Pica Ruiz.							Junio-2001.
// 	Antonio Pica Ruiz.							Modificado 22 de Octubre de 2012.
// 	Antonio Pica Ruiz.							Modificado 3 de Octubre de 2014.
// 	Antonio Pica Ruiz.							Modificado 20 de Marzo de 2015.
//  "PASO [5]"
//	"PASO [8]"
// 	Antonio Pica Ruiz.							Modificado 24 de Junio de 2015.
//  "PASO [5]"

IF Messagebox("Corte de Documentos","Desea Continuar",Question!,YesNo!,2) = 1 THEN
	
	Setpointer(hourglass!)
//"[1] Bloquea a todos los alumnos.~n"+ &	
	st_estatus.Text = "PASO [1]"	
	UPDATE banderas SET baja_documentos = 1 WHERE baja_documentos = 0 
	AND cuenta in (SELECT cuenta FROM academicos 
				WHERE EXISTS(SELECT * FROM plan_estudios 
								WHERE academicos.cve_carrera = plan_estudios.cve_carrera
								AND academicos.cve_plan = plan_estudios.cve_plan
								AND plan_estudios.tipo_periodo = :gs_tipo_periodo )) 	
	using gtr_sce;
	if wf_valida_transaccion("documentos [1]") = -1 then return

//UPDATE banderas SET baja_documentos = 1 WHERE baja_documentos = 0 AND cuenta IN
//(SELECT a.cuenta FROM academicos a, plan_estudios pe
// WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
// AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1) using gtr_sce;

//2014-10-03: Se añadieron los documentos 14,17,28 como obligatorios

//"[2] Desbloquea a los alumnos de licenciatura que tienen sus~n"+&
//"    documentos (1,2,3,33) en orden.~n"+ &

	st_estatus.Text = "PASO [2]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT cuenta FROM academicos WHERE nivel NOT IN ( "P" )
	AND EXISTS(SELECT * FROM plan_estudios 
				WHERE academicos.cve_carrera = plan_estudios.cve_carrera
				AND academicos.cve_plan = plan_estudios.cve_plan
				AND plan_estudios.tipo_periodo = :gs_tipo_periodo )) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 2 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 3 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	
	(SELECT cuenta FROM documentos WHERE cve_documento IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and cuenta NOT IN
	
	(SELECT cuenta FROM documentos WHERE cve_documento = 33 AND cve_flag_documento IN (0,5,2)) using gtr_sce;
	if wf_valida_transaccion("documentos [2]") = -1 then return


//2014-10-03: Se añadieron los documentos 14,17,28 como obligatorios
//"[3] Desbloquea a los alumnos de licenciatura que tienen sus~n"+&
//"    documentos (1,4,5,33) en orden.~n"+ &
	
	st_estatus.Text = "PASO [3]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT cuenta FROM academicos WHERE nivel NOT IN ( "P" )
	AND EXISTS(SELECT * FROM plan_estudios 
				WHERE academicos.cve_carrera = plan_estudios.cve_carrera
				AND academicos.cve_plan = plan_estudios.cve_plan
				AND plan_estudios.tipo_periodo = :gs_tipo_periodo )) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 4 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN

	(SELECT cuenta FROM documentos WHERE cve_documento  IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and cuenta IN

	(SELECT cuenta FROM documentos WHERE cve_documento = 5 AND cve_flag_documento IN (1,2,6,10)) and cuenta NOT IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 33 AND cve_flag_documento IN (0,5,2)) using gtr_sce;
	if wf_valida_transaccion("documentos [3]") = -1 then return

//2014-10-03: Se añadieron los documentos 14,17,28 como obligatorios
//	(SELECT cuenta FROM documentos WHERE cve_documento IN (4,7,10,12,13,21,25,30,35,36,42,43,44,47,39,46)
//	 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
//	(SELECT cuenta FROM documentos WHERE cve_documento IN (5,8,13,30,35,36,37,40,43,45,47)
//	 AND cve_flag_documento IN (1,2,6,10)) using gtr_sce;
//"[4] Desbloquea a los alumnos de posgrado NO incorporado a sep~n"+&
//"    que tienen sus documentos en orden.~n"+&

	st_estatus.Text = "PASO [4]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 0 AND pe.tipo_periodo = :gs_tipo_periodo) AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento IN (4,47)
	 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN

	(SELECT cuenta FROM documentos WHERE cve_documento  IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	
	(SELECT cuenta FROM documentos WHERE cve_documento IN (5,47)
	 AND cve_flag_documento IN (1,2,6,10)) using gtr_sce;
	if wf_valida_transaccion("documentos [4]") = -1 then return

//2014-10-03: Se añadieron los documentos 14,17,28 como obligatorios
//	(SELECT cuenta FROM documentos WHERE cve_documento IN  (4,7,13,25,36,43,44)
//	 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
//	(SELECT cuenta FROM documentos WHERE cve_documento IN (5,8,13,25,36,43,45)
//	 AND cve_flag_documento IN (1,2,6,10)) using gtr_sce;
//"[5] Desbloquea a los alumnos de posgrado incorporado a sep que~n"+&
//"    tienen sus documentos en orden.~n"+&

	st_estatus.Text = "PASO [5]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1 AND pe.tipo_periodo = :gs_tipo_periodo) AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento IN  (4,13)
	 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN

	(SELECT cuenta FROM documentos WHERE cve_documento  IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and cuenta IN

	(SELECT cuenta FROM documentos WHERE cve_documento IN (5,13)
	 AND cve_flag_documento IN (1,2,6,10)) using gtr_sce;
	if wf_valida_transaccion("documentos [5]") = -1 then return

//2014-10-03: Se añadieron los documentos 14,17,28 como obligatorios
//"[6] Desbloquea a los alumnos de posgrado incorporado a sep que~n"+&
//"    ingresaron con opción de titulación por creditos de posgrado.~n"+&

	st_estatus.Text = "PASO [6]"
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1 AND pe.tipo_periodo = :gs_tipo_periodo) AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and cuenta IN

	(SELECT cuenta FROM documentos WHERE cve_documento  IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	
	(SELECT cuenta FROM documentos WHERE cve_documento = 38 AND cve_flag_documento IN (1,2,6,10)) and cuenta NOT IN
	(SELECT h.cuenta FROM historico h, academicos a, plan_estudios pe, materias m
	WHERE a.cve_carrera = h.cve_carrera AND a.cve_plan = h.cve_plan AND a.cuenta = h.cuenta AND 
	a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan AND h.cve_mat = m.cve_mat AND a.nivel LIKE "P" AND
	pe.incorporado_sep = 1 AND h.calificacion IN ("5","6","7","NA","S") AND m.creditos > 0) AND cuenta IN
	(SELECT h.cuenta FROM historico h, academicos a, plan_estudios pe, materias m
	WHERE a.cve_carrera = h.cve_carrera AND a.cve_plan = h.cve_plan AND  a.cuenta = h.cuenta AND 
	a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan AND h.cve_mat = m.cve_mat AND a.nivel LIKE "P" AND
	pe.incorporado_sep = 1 
	GROUP BY h.cuenta HAVING SUM(m.creditos)<=50) using gtr_sce;
	if wf_valida_transaccion("documentos [6]") = -1 then return

//2014-10-03: Se añadieron los documentos 14,17,28 como obligatorios
//"[7] Desbloquea a los alumnos de posgrado incorporado a sep que~n"+&
//"    ingresaron con opción de titulación por creditos de posgrado~n"+&
//"    y que no cuentan con materias en su histórico.~n"+&

	st_estatus.Text = "PASO [7]"	
	UPDATE banderas SET baja_documentos = 0 WHERE cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	 WHERE a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan
	 AND a.nivel LIKE  "P" AND pe.incorporado_sep = 1 AND pe.tipo_periodo = :gs_tipo_periodo) 
	AND cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) 
	AND cuenta IN

	(SELECT cuenta FROM documentos WHERE cve_documento  IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and cuenta IN
	
	(SELECT cuenta FROM documentos WHERE cve_documento = 38 AND cve_flag_documento IN (1,2,6,10)) 
	AND cuenta NOT IN
	(SELECT h.cuenta FROM historico h, academicos a, plan_estudios pe, materias m
	WHERE a.cve_carrera = h.cve_carrera AND a.cve_plan = h.cve_plan AND a.cuenta = h.cuenta AND 
	a.cve_carrera = pe.cve_carrera AND a.cve_plan = pe.cve_plan AND h.cve_mat = m.cve_mat AND a.nivel LIKE "P" AND
	pe.incorporado_sep = 1 AND h.calificacion IN ("5","6","7","NA","S") AND m.creditos > 0) 
	AND cuenta IN
	(SELECT a.cuenta FROM academicos a, plan_estudios pe
	WHERE a.cve_carrera = pe.cve_carrera 
	AND a.cve_plan = pe.cve_plan 
	AND a.nivel LIKE "P" 
	AND pe.incorporado_sep = 1 
	AND a.cuenta  NOT in (select h.cuenta from historico h where
	h.cuenta = a.cuenta and h.cve_carrera = a.cve_carrera and h.cve_plan = a.cve_plan)) using gtr_sce;
	if wf_valida_transaccion("documentos [7]") = -1 then return

//2014-10-03: Se añadieron los documentos 14,17,28 como obligatorios
//	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (12,30,60,62,63) AND cve_flag_documento IN (1,2,6,10))  and a.cuenta IN 
//	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (37,40,61,63) AND cve_flag_documento IN (1,2,6,10)) 
//"[8] Desbloquea a los alumnos de doctorado que han entregado su título~n"+&
//"    y cédula de maestría."

	st_estatus.Text = "PASO [8]"
	
	/*UPDATE banderas
	SET baja_documentos=0
	FROM academicos a, carreras c, banderas_inscrito bi, banderas ba
	WHERE a.cve_carrera = c.cve_carrera 
	AND a.cve_carrera = c.cve_carrera
	AND a.nivel LIKE  "P" AND c.carrera like "%DOCTORADO%" 
	AND a.cuenta = ba.cuenta 
	AND a.cuenta = bi.cuenta AND a.cuenta IN
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and a.cuenta IN
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (30, 60, 63) AND cve_flag_documento IN (1,2,6,10))  and a.cuenta IN 

	(SELECT cuenta FROM documentos WHERE cve_documento  IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and a.cuenta IN
	
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (37,61, 63) AND cve_flag_documento IN (1,2,6,10)) 
	AND EXISTS(SELECT * FROM plan_estudios 
				WHERE a.cve_carrera = plan_estudios.cve_carrera
				AND a.cve_plan = plan_estudios.cve_plan
				AND plan_estudios.tipo_periodo = :gs_tipo_periodo )
	using gtr_sce;*/
	
	UPDATE banderas
	SET baja_documentos=0
	FROM academicos a, carreras c, banderas_inscrito bi, banderas ba
	WHERE a.cve_carrera = c.cve_carrera 
	AND a.cve_carrera = c.cve_carrera
	AND a.nivel LIKE  "P" AND c.carrera like "%DOCTORADO%" 
	AND a.cuenta = ba.cuenta 
	AND a.cuenta = bi.cuenta AND a.cuenta IN
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento = 1 AND cve_flag_documento IN (1,2,6,10)) and a.cuenta IN
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (61, 60, 63) AND cve_flag_documento IN (1,2,6,10))  and a.cuenta IN 

	(SELECT cuenta FROM documentos WHERE cve_documento  IN (14, 17, 28) AND cve_flag_documento IN (1,2,6,10)) and a.cuenta IN
	
	(SELECT documentos.cuenta FROM documentos WHERE cve_documento in (30, 37, 63) AND cve_flag_documento IN (1,2,6,10)) 
	AND EXISTS(SELECT * FROM plan_estudios 
				WHERE a.cve_carrera = plan_estudios.cve_carrera
				AND a.cve_plan = plan_estudios.cve_plan
				AND plan_estudios.tipo_periodo = :gs_tipo_periodo )
	using gtr_sce;	
	
	
	
	if wf_valida_transaccion("documentos [8]") = -1 then return
	
//2014-10-03: Bloqueos de alumnos extranjeros que no tengan la forma migratoria
	
	st_estatus.Text = "PASO [9]"
	UPDATE banderas
	SET baja_documentos=1
	WHERE  cuenta IN
	(SELECT cuenta FROM alumnos WHERE cve_nacion <>1) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento in (52) AND cve_flag_documento NOT IN (1,2,6,10) )
	AND cuenta in (SELECT cuenta FROM academicos 
						WHERE EXISTS(SELECT * FROM plan_estudios 
										WHERE academicos.cve_carrera = plan_estudios.cve_carrera
										AND academicos.cve_plan = plan_estudios.cve_plan
										AND plan_estudios.tipo_periodo = :gs_tipo_periodo ))
	using gtr_sce;

	if wf_valida_transaccion("documentos [9]") = -1 then return
	
//2014-10-03: Bloqueos de alumnos extranjeros que no tengan la traduccion de acta de nacimiento

	st_estatus.Text = "PASO [10]"
	UPDATE banderas
	SET baja_documentos=1
	WHERE  cuenta IN
	(SELECT cuenta FROM alumnos WHERE cve_nacion <>1) and cuenta IN
	(SELECT cuenta FROM documentos WHERE cve_documento in (20) AND cve_flag_documento NOT IN (1,2,6,10) )
	AND cuenta in (SELECT cuenta FROM academicos 
					WHERE EXISTS(SELECT * FROM plan_estudios 
									WHERE academicos.cve_carrera = plan_estudios.cve_carrera
									AND academicos.cve_plan = plan_estudios.cve_plan
									AND plan_estudios.tipo_periodo = :gs_tipo_periodo ))
	using gtr_sce;

	if wf_valida_transaccion("documentos [10]") = -1 then return
	
//2014-10-03: Bloqueos de alumnos que tengan anomalía en cualquiera de sus documentos

	st_estatus.Text = "PASO [11]"
	UPDATE banderas
	SET baja_documentos=1
	WHERE  cuenta IN
	(SELECT cuenta FROM documentos WHERE  cve_flag_documento IN (3 ) )
	AND cuenta in (SELECT cuenta FROM academicos 
					WHERE EXISTS(SELECT * FROM plan_estudios 
									WHERE academicos.cve_carrera = plan_estudios.cve_carrera
									AND academicos.cve_plan = plan_estudios.cve_plan
									AND plan_estudios.tipo_periodo = :gs_tipo_periodo )) 	
	using gtr_sce;
	
	if wf_valida_transaccion("documentos [11]") = -1 then
		return
	else
		st_estatus.Text = "ACTUALIZANDO"

		commit using gtr_sce;
	end if	       
  	Messagebox("Proceso Terminado","Se ha terminado el corte de documentos exitosamente", Information!)
	st_estatus.Text = "CORTE EXITOSO"

END IF

end event

type st_1 from statictext within w_corte_documentos
integer x = 256
integer y = 12
integer width = 2235
integer height = 96
integer textsize = -14
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 10789024
boolean enabled = false
string text = "CORTE DE DOCUMENTOS.   TOME PRECAUCIONES."
alignment alignment = center!
boolean border = true
long bordercolor = 16777215
boolean focusrectangle = false
end type

type st_2 from statictext within w_corte_documentos
integer x = 256
integer y = 124
integer width = 2235
integer height = 1304
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = roman!
string facename = "Times New Roman"
long backcolor = 10789024
boolean enabled = false
boolean border = true
long bordercolor = 16777215
end type

