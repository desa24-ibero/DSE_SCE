$PBExportHeader$uo_grupos_multiplantel.sru
forward
global type uo_grupos_multiplantel from nonvisualobject
end type
end forward

global type uo_grupos_multiplantel from nonvisualobject
end type
global uo_grupos_multiplantel uo_grupos_multiplantel

type variables
INTEGER ie_periodo 
INTEGER ie_anio 

transaction itr_sumuia
STRING is_ocupado 



DATASTORE ids_ocupados

end variables

forward prototypes
public function integer of_inserta_valida_aula (long al_materia, string as_grupo, datawindow adw_horario)
public function integer of_valida_nuevo_grupo (long al_cve_materia, string as_gpo)
public function integer of_cancela_apartado (long al_cve_materia, string as_gpo)
public function integer of_inserta_apartado (long al_cve_materia, string as_gpo, long al_cve_profesor)
public function integer of_inserta_valida_aula_bloque (long al_materia, string as_grupo, datastore ads_horario, transaction atr_sce)
end prototypes

public function integer of_inserta_valida_aula (long al_materia, string as_grupo, datawindow adw_horario);STRING ls_error

LONG ll_cve_mat
STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio
INTEGER le_cve_dia
STRING ls_cve_salon
INTEGER le_hora_inicio
INTEGER le_hora_final
INTEGER le_clase_aula 
INTEGER le_pos


// Se elimina el horario del grupo para evaluación 
DELETE FROM horario_multiplantel 
WHERE 	cve_mat = :al_materia
AND gpo = :as_grupo 
AND periodo = :ie_periodo 
AND anio = :ie_anio
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	ls_error = "Se produjo un error al eliminar el horario para validación del grupo: " + gtr_sce.SQLERRTEXT 
	ROLLBACK USING gtr_sce; 
	MESSAGEBOX("Error", ls_error)
	RETURN -1 	
END IF

ll_cve_mat = al_materia
ls_gpo = as_grupo
le_periodo = ie_periodo
le_anio = ie_anio

FOR le_pos = 1 TO adw_horario.ROWCOUNT() 
	
	le_cve_dia = adw_horario.GETITEMNUMBER(le_pos, "cve_dia") 
	IF ISNULL(le_cve_dia) THEN CONTINUE 
	ls_cve_salon = adw_horario.GETITEMSTRING(le_pos, "cve_salon") 
//	IF ISNULL(ls_cve_salon) THEN CONTINUE 
	le_hora_inicio = adw_horario.GETITEMNUMBER(le_pos, "hora_inicio") 
	IF ISNULL(le_hora_inicio) THEN CONTINUE 
	le_hora_final = adw_horario.GETITEMNUMBER(le_pos, "hora_final") 
	IF ISNULL(le_hora_final) THEN CONTINUE 
	le_clase_aula = adw_horario.GETITEMNUMBER(le_pos, "clase_aula") 
	IF ISNULL(le_clase_aula) THEN CONTINUE 
	
	INSERT INTO horario_multiplantel(cve_mat, gpo, periodo, anio, cve_dia, cve_salon, hora_inicio, hora_final, clase_aula) 
	VALUES(:ll_cve_mat, :ls_gpo, :le_periodo, :le_anio, :le_cve_dia, :ls_cve_salon, :le_hora_inicio, :le_hora_final, :le_clase_aula) 
	USING gtr_sce; 	
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = "Se produjo un error al insertar el horario para validación del grupo: " + gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", ls_error)
		RETURN -1 	
	END IF	
	
NEXT

COMMIT USING gtr_sce; 

RETURN 0





//
//
//CREATE TABLE horario_multiplantel 
//	(
//	cve_mat     INT NOT NULL,
//	gpo         VARCHAR (2) NOT NULL,
//	periodo     tipo_periodo NOT NULL,
//	anio        tipo_anio NOT NULL,
//	cve_dia     tipo_dia NOT NULL,
//	cve_salon   VARCHAR (16) NULL,
//	hora_inicio tipo_hora NOT NULL,
//	hora_final  tipo_hora NOT NULL,
//	clase_aula  int1 NULL
//	)
//
//GO
//










 
 




//n_tr gtr_sce
end function

public function integer of_valida_nuevo_grupo (long al_cve_materia, string as_gpo);//RETORNA 0 = No disponible, 1 = Disponible 
INTEGER le_resultado
LONG ll_folio
STRING ls_nombre_evento
STRING ls_nombre_responsable
STRING ls_correo_responsable
STRING ls_telefono_responsable
DATETIME ldt_fecha_inicio
DATETIME ldt_fecha_fin 

STRING ls_query
LONG ll_rows


DECLARE valida_aula procedure for sp_valida_materia
	@materia = :al_cve_materia, 
	@gpo = :as_gpo, 
	@resultado = :le_resultado out 
USING itr_sumuia;

EXECUTE valida_aula; 
IF itr_sumuia.sqlcode <> 0 Then
	RETURN -1
End if
FETCH valida_aula INTO :le_resultado; 
IF itr_sumuia.sqlcode < 0 Then
	CLOSE valida_aula;
	RETURN -1
End if	
CLOSE valida_aula;

IF le_resultado = 0 THEN 

//	ls_query = " SELECT folio,nombre_evento,nombre_responsable,correo_responsable,telefono_responsable,fecha_inicio,fecha_fin " + & 
//					" FROM sarrt_solicitud WHERE folio IN (SELECT folio FROM sarrt_hist_solicitud WHERE cve_materia = " + STRING(al_cve_materia) + "  AND gpo = '" + as_gpo + "' ) AND estatus = 1  "	
//	
	ids_ocupados.DATAOBJECT = "dw_multiplantel_sala_ocupada" 
//	ids_ocupados.MODIFY("Datawindow.Table.Select = '" + ls_query + "'")
	ids_ocupados.SETTRANSOBJECT(itr_sumuia) 
	ll_rows = ids_ocupados.RETRIEVE(al_cve_materia, as_gpo) 
	//ll_rows = ids_ocupados.RETRIEVE(1001, 'A') 
	
	OPENWITHPARM(w_aula_audiovisual_ocupada, ids_ocupados)
	

//	SELECT folio,nombre_evento,nombre_responsable,correo_responsable,telefono_responsable,fecha_inicio,fecha_fin 
//	INTO :ll_folio, :ls_nombre_evento, :ls_nombre_responsable, :ls_correo_responsable, :ls_telefono_responsable, :ldt_fecha_inicio, :ldt_fecha_fin 
//	FROM sarrt_solicitud WHERE folio IN (SELECT folio FROM sarrt_hist_solicitud WHERE cve_materia = :al_cve_materia  AND gpo = :as_gpo) AND estatus = 1  
//	USING itr_sumuia; 
//	IF itr_sumuia.SQLCODE < 0 THEN 
//		MESSAGEBOX("Error", "Se produjo un error al recuperar la información del apartado de aula audiovisual: " + itr_sumuia.SQLERRTEXT)  
//		RETURN -1 	
//	END IF

//	is_ocupado = " El aula audiovisual se encuentra ocupada por: " + STRING(ls_nombre_responsable) + "    para: " + ls_nombre_evento + "    Contacto: " + & 
//					"   mail: " + ls_correo_responsable + "    tel. "  + ls_telefono_responsable + "   de " + STRING(ldt_fecha_inicio, "dd/mm/yyyy") + " hasta: " + STRING(ldt_fecha_fin, "dd/mm/yyyy") 
//					
					
END IF

RETURN le_resultado 





end function

public function integer of_cancela_apartado (long al_cve_materia, string as_gpo);//RETORNA 0 = No disponible, 1 = Disponible 
INTEGER le_resultado

DECLARE cancela_aula procedure for sp_cancela_materia 
	@materia = :al_cve_materia, 
	@gpo = :as_gpo 
USING itr_sumuia;

EXECUTE cancela_aula ;
IF itr_sumuia.sqlcode < 0 Then
	RETURN -1
End if
//FETCH cancela_aula INTO :le_resultado; 
//IF itr_sumuia.sqlcode <> 0 Then
//	CLOSE cancela_aula;
//	RETURN -1
//End if	
CLOSE cancela_aula;

RETURN le_resultado 



end function

public function integer of_inserta_apartado (long al_cve_materia, string as_gpo, long al_cve_profesor);//RETORNA 0 = No disponible, 1 = Disponible 
INTEGER le_resultado


DECLARE aparta_aula procedure for sp_valida_inserta 
	@materia = :al_cve_materia, 
	@gpo = :as_gpo, 
	@cve_profesor = :al_cve_profesor 
USING itr_sumuia;

EXECUTE aparta_aula ;
IF itr_sumuia.sqlcode < 0 Then
	RETURN -1
End if
//FETCH aparta_aula INTO :le_resultado; 
//IF itr_sumuia.sqlcode <> 0 Then
//	CLOSE aparta_aula;
//	RETURN -1
//End if	
CLOSE aparta_aula;

RETURN 0 



end function

public function integer of_inserta_valida_aula_bloque (long al_materia, string as_grupo, datastore ads_horario, transaction atr_sce);STRING ls_error

LONG ll_cve_mat
STRING ls_gpo
INTEGER le_periodo
INTEGER le_anio
INTEGER le_cve_dia
STRING ls_cve_salon
INTEGER le_hora_inicio
INTEGER le_hora_final
INTEGER le_clase_aula 
INTEGER le_pos


// Se elimina el horario del grupo para evaluación 
DELETE FROM horario_multiplantel 
WHERE 	cve_mat = :al_materia
AND gpo = :as_grupo 
AND periodo = :ie_periodo 
AND anio = :ie_anio
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	ls_error = "Se produjo un error al eliminar el horario para validación del grupo: " + gtr_sce.SQLERRTEXT 
	ROLLBACK USING gtr_sce; 
	MESSAGEBOX("Error", ls_error)
	RETURN -1 	
END IF

ll_cve_mat = al_materia
ls_gpo = as_grupo
le_periodo = ie_periodo
le_anio = ie_anio

FOR le_pos = 1 TO ads_horario.ROWCOUNT() 
	
	le_cve_dia = ads_horario.GETITEMNUMBER(le_pos, "cve_dia") 
	IF ISNULL(le_cve_dia) THEN CONTINUE 
	ls_cve_salon = ads_horario.GETITEMSTRING(le_pos, "cve_salon") 
//	IF ISNULL(ls_cve_salon) THEN CONTINUE 
	le_hora_inicio = ads_horario.GETITEMNUMBER(le_pos, "hora_inicio") 
	IF ISNULL(le_hora_inicio) THEN CONTINUE 
	le_hora_final = ads_horario.GETITEMNUMBER(le_pos, "hora_final") 
	IF ISNULL(le_hora_final) THEN CONTINUE 
	le_clase_aula = ads_horario.GETITEMNUMBER(le_pos, "clase_aula") 
	IF ISNULL(le_clase_aula) THEN CONTINUE 
	
	INSERT INTO horario_multiplantel(cve_mat, gpo, periodo, anio, cve_dia, cve_salon, hora_inicio, hora_final, clase_aula) 
	VALUES(:ll_cve_mat, :ls_gpo, :le_periodo, :le_anio, :le_cve_dia, :ls_cve_salon, :le_hora_inicio, :le_hora_final, :le_clase_aula) 
	USING gtr_sce; 	
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = "Se produjo un error al insertar el horario para validación del grupo: " + gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", ls_error)
		RETURN -1 	
	END IF	
	
NEXT

COMMIT USING gtr_sce; 

RETURN 0



//	le_row_ins = iuo_grupo_servicios.ids_horario.INSERTROW(0)
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_mat", iuo_grupo_servicios.il_cve_mat)	
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "gpo", iuo_grupo_servicios.is_gpo)	
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "periodo", iuo_grupo_servicios.ie_periodo)	 
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "anio", iuo_grupo_servicios.ie_anio)	
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_dia", le_cve_dia)	
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "cve_salon", ls_cve_salon)	
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "hora_inicio", le_hora_inicio)	
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "hora_final", le_hora_final)	
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "clase_aula", le_clase_aula) 
//	iuo_grupo_servicios.ids_horario.SETITEM(le_row_ins, "comentario", ls_comentario) 
//
//
//
//CREATE TABLE horario_multiplantel 
//	(
//	cve_mat     INT NOT NULL,
//	gpo         VARCHAR (2) NOT NULL,
//	periodo     tipo_periodo NOT NULL,
//	anio        tipo_anio NOT NULL,
//	cve_dia     tipo_dia NOT NULL,
//	cve_salon   VARCHAR (16) NULL,
//	hora_inicio tipo_hora NOT NULL,
//	hora_final  tipo_hora NOT NULL,
//	clase_aula  int1 NULL
//	)
//
//GO
//










 
 




//n_tr gtr_sce
end function

on uo_grupos_multiplantel.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_grupos_multiplantel.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;STRING ls_mensaje

// Se hace la conexión a sumuia_bd 
if f_conecta_pas_parametros_bd(gtr_sce, itr_sumuia, 26, gs_usuario, gs_password)=0 then  
	ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
	MessageBox("Error", ls_mensaje, StopSign!)
	return -1
end if
itr_sumuia.AUTOCOMMIT = TRUE

ids_ocupados = CREATE DATASTORE 
end event

event destructor;IF ISVALID(itr_sumuia) THEN 
	DISCONNECT USING itr_sumuia; 
END IF



end event

