$PBExportHeader$uo_servicios_titulo_e.sru
forward
global type uo_servicios_titulo_e from nonvisualobject
end type
end forward

global type uo_servicios_titulo_e from nonvisualobject
end type
global uo_servicios_titulo_e uo_servicios_titulo_e

type variables

INTEGER ie_error 
STRING is_error 

// Datastores con la estructura de los documentos. 
DATASTORE ids_est_documento 
DATASTORE ids_est_detalle 
DATASTORE ids_est_cierre 

// Datastore con la información del archivo.
DATASTORE ids_documento 
DATASTORE ids_detalle
DATASTORE ids_cierre

// Datastore con la lista de alumnos de los que se genera documento 
DATASTORE ids_alumnos 

// Datastore con la lista de documentos que pueden generar.
DATASTORE ids_lista_docs

// Datastore con la estructura del archivo 
DATASTORE ids_e_titulo_archivo

// Datastore con el tipo de asignatura
DATASTORE ids_lista_tipo_asignatura  

STRING is_sintaxis_maestro, is_sintaxis_detalle, is_sintaxis_cierre  
STRING is_tipo_doc 

INTEGER ie_tipo_documento, ii_indice, ie_legalizado

INTEGER ie_tipo_certificacion

LONG il_relacion[]  
LONG il_num_relacion   

DATETIME idt_fecha_inicio
DATETIME idt_fecha_fin

STRING is_nivel 
STRING is_archivo_cierre 

STRING is_ruta_variable


end variables

forward prototypes
public function integer of_carga_estructuras (string as_id_doc)
public function integer f_genera_archivos (string as_id_doc)
public function integer f_genera_informacion_titulo ()
public function integer f_genera_archivos2 (string as_id_doc)
public function integer f_valida_informacion_titulo (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_mensaje_salida)
public function integer f_inserta_documento_generado (long a_cuenta, long a_cve_carrera, long a_cve_plan, integer a_tipo_documento, integer a_estatus_generado, string as_mensaje_validacion)
public function integer f_genera_grupo_zip (ref string as_nombre_zip, ref integer ai_num_generacion)
public function integer f_crea_carpeta (ref string as_ruta, integer ai_consecutivo)
public function integer f_actualiza_grupo_zip (integer ai_consecutivo)
public function integer f_valida_informacion_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_mensaje_salida)
public function integer f_valida_inf_titulo_etapas (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_mensaje_salida)
public function integer f_calcula_promedio_cer (long al_cuenta, long al_cve_carrera, integer le_plan, ref decimal ad_promedio, ref integer ai_creditos)
public function integer f_sustituye_parametros (ref string as_cadena, long al_cuenta, long al_carrera, long al_plan, long al_certificacion, decimal ad_promedio, integer ai_creditos, integer ai_legalizado)
end prototypes

public function integer of_carga_estructuras (string as_id_doc);INTEGER le_ttl_rows, le_pos 
STRING ls_cadena 

is_sintaxis_maestro = "" 
is_sintaxis_detalle = ""  
is_sintaxis_cierre = ""

ids_e_titulo_archivo = CREATE DATASTORE 
ids_e_titulo_archivo.DATAOBJECT = "dw_e_titulo_archivo_e"  
ids_e_titulo_archivo.SETTRANSOBJECT(gtr_sce) 
le_ttl_rows = ids_e_titulo_archivo.RETRIEVE(as_id_doc)

ids_lista_docs = CREATE DATASTORE 
ids_lista_docs.DATAOBJECT = "dw_lista_documentos_e"  
ids_lista_docs.SETTRANSOBJECT(gtr_sce) 
le_ttl_rows = ids_lista_docs.RETRIEVE(as_id_doc)

ids_est_documento = CREATE DATASTORE 
ids_est_documento.DATAOBJECT = "dw_e_titulo_sintaxis_e" 
ids_est_documento.SETTRANSOBJECT(gtr_sce)
le_ttl_rows = ids_est_documento.RETRIEVE(as_id_doc, 'M')

FOR le_pos = 1 TO le_ttl_rows 

	ls_cadena = ids_est_documento.GETITEMSTRING(le_pos, "sintaxis")  
	IF ISNULL(ls_cadena) THEN ls_cadena = "" 
	is_sintaxis_maestro = is_sintaxis_maestro + " "  + ls_cadena 

NEXT 


ids_est_detalle = CREATE DATASTORE 
ids_est_detalle.DATAOBJECT = "dw_e_titulo_sintaxis_e"  
ids_est_detalle.SETTRANSOBJECT(gtr_sce) 
le_ttl_rows = ids_est_detalle.RETRIEVE(as_id_doc, 'D')

FOR le_pos = 1 TO le_ttl_rows 

	ls_cadena = ids_est_detalle.GETITEMSTRING(le_pos, "sintaxis")  
	IF ISNULL(ls_cadena) THEN ls_cadena = "" 
	is_sintaxis_detalle = is_sintaxis_detalle + " "  + ls_cadena 

NEXT 


ids_est_cierre = CREATE DATASTORE 
ids_est_cierre.DATAOBJECT = "dw_e_titulo_sintaxis_e"  
ids_est_cierre.SETTRANSOBJECT(gtr_sce) 
le_ttl_rows = ids_est_cierre.RETRIEVE(as_id_doc, 'C')

FOR le_pos = 1 TO le_ttl_rows 

	ls_cadena = ids_est_cierre.GETITEMSTRING(le_pos, "sintaxis")  
	IF ISNULL(ls_cadena) THEN ls_cadena = "" 
	is_sintaxis_cierre = is_sintaxis_cierre + " "  + ls_cadena 

NEXT 

ids_lista_tipo_asignatura = CREATE DATASTORE 
ids_lista_tipo_asignatura.DATAOBJECT = "dw_lista_tipo_asignatura" 
ids_lista_tipo_asignatura.SETTRANSOBJECT(gtr_sce) 
le_ttl_rows = ids_lista_tipo_asignatura.RETRIEVE() 
ids_lista_tipo_asignatura.SETSORT("id_tipo_materia asc") 
ids_lista_tipo_asignatura.SORT() 


RETURN 0 


 
end function

public function integer f_genera_archivos (string as_id_doc);// Se llama función que genera los querys del documento 
STRING ls_sintaxis_maestro, ls_sintaxis_detalle 
STRING ls_sintaxis_maestro_paso, ls_sintaxis_detalle_paso  
STRING ls_error

// SE GENERA LA INFORMACIÓN DEL "MAESTRO" DEL DOCUMENTO 
LONG ll_archivo 
STRING ls_count 
STRING ls_dato, ls_campo 
STRING ls_inserta 
STRING ls_cuenta 
LONG ll_cuenta
LONG ll_carrera
LONG ll_plan


INTEGER le_pos_m, le_pos_d 
INTEGER le_ttl_m, le_ttl_d
INTEGER le_col, le_ttl_col 

STRING ls_ruta 
STRING ls_archivo

INTEGER le_pos_alumno, le_ttl_alumno 

of_carga_estructuras(as_id_doc) 

// Se recupera las cadenas base para la generación de los archivos.
IF ids_lista_docs.ROWCOUNT() > 0 THEN 
	ls_ruta = ids_lista_docs.GETITEMSTRING(1, "ruta")
	ls_archivo = ids_lista_docs.GETITEMSTRING(1, "nombre_archivo") 
ELSE
	MESSAGEBOX("Error", "No existen definiciones de documentos para generar. ")
	RETURN -1 
END IF 
				
// Se llama función previa a la generación de los documentos.
IF as_id_doc = "tit"  THEN 
	IF f_genera_informacion_titulo( ) < 0 THEN RETURN -1 
END IF 
				
// Se hace ciclo para generar cada uno de los documentos requeridos: 							
le_ttl_alumno = ids_alumnos.ROWCOUNT() 
FOR le_pos_alumno = 1 TO le_ttl_alumno 	
	
		ll_cuenta = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cuenta") 
		ls_cuenta = STRING(ll_cuenta)  
		ll_carrera = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cve_carrera") 
		IF ISNULL(ll_carrera) THEN ll_carrera = 0 
		ll_plan = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cve_plan") 
		IF ISNULL(ll_plan) THEN ll_plan = 0
	
		IF ISVALID(ids_documento)  THEN DESTROY ids_documento 
		ids_documento = CREATE DATASTORE 
		
		ls_sintaxis_maestro_paso = is_sintaxis_maestro 
		// Se llama función de sustitución de parámetros 
		f_sustituye_parametros(ls_sintaxis_maestro_paso, ll_cuenta, ll_carrera, ll_plan, ie_tipo_certificacion,0,0,ie_legalizado) 
		ls_sintaxis_maestro = gtr_sce.SyntaxFromSQL(ls_sintaxis_maestro_paso, "style(type=grid)", ref ls_error) 
		ids_documento.create(ls_sintaxis_maestro , ref ls_error) 
		
		IF Len(ls_error) > 0 THEN 
			ie_error = -1 
			is_error = ls_error 
			RETURN -1 
		END IF
		
		ids_documento.SETTRANSOBJECT(gtr_sce) 
		le_ttl_m = ids_documento.RETRIEVE() 
		
		// Si existe el detalle lo recupera.
		IF LEN(is_sintaxis_detalle) > 0 THEN 
			
			IF ISVALID(ids_detalle) THEN DESTROY ids_detalle 
			ids_detalle = CREATE DATASTORE 
			
			ls_sintaxis_detalle_paso = is_sintaxis_detalle
			// Se llama función de sustitución de parámetros 
			f_sustituye_parametros(ls_sintaxis_detalle_paso, ll_cuenta, ll_carrera, ll_plan, ie_tipo_certificacion,0,0,ie_legalizado) 
	
			ls_sintaxis_detalle = gtr_sce.SyntaxFromSQL(ls_sintaxis_detalle_paso, "style(type=grid)", ref ls_error)  
			ids_detalle.create(ls_sintaxis_detalle , ref ls_error) 
			
			IF Len(ls_error) > 0 THEN 
				ie_error = -1 
				is_error = ls_error 
				RETURN -1 
			END IF
		
			ids_detalle.SETTRANSOBJECT(gtr_sce) 
			le_ttl_d = ids_detalle.RETRIEVE() 
			
		END IF 
		

		// Se abre archivo
		//ll_archivo = FileOpen("C:\Apoyos\EJEMPLOS_CERTIFICADOS\" + "prueba_cer" + "_" + ".txt", LineMode!, Write! , LockWrite! , Replace!, EncodingUTF8!) 
		ll_archivo = FileOpen(ls_ruta + ls_archivo + "_" + ls_cuenta + ".txt", LineMode!, Write! , LockWrite! , Replace!, EncodingUTF8!) 
		
		// Se genera el archivo de texto del MAESTRO 
		FOR le_pos_m = 1 TO le_ttl_m  
			
			ls_count = ids_documento.Object.DataWindow.Column.Count
			le_ttl_col = INTEGER(ls_count) 
			
			FOR le_col = 1 TO le_ttl_col 
				
				ls_campo = ids_documento.Describe("#" + STRING(le_col) + ".Name")
				ls_dato = ids_documento.GETITEMSTRING(le_pos_m, le_col) 
				ls_inserta = ls_campo + " | " + ls_dato 
				FILEWRITE(ll_archivo, ls_inserta) 
			
			NEXT 
			
		NEXT 
		
		// Se genera el archivo de texto del DETALLE  
		FOR le_pos_d  = 1 TO le_ttl_d 
		
			ls_count = ids_detalle.Object.DataWindow.Column.Count
			le_ttl_col = INTEGER(ls_count) 
			
			FOR le_col = 1 TO le_ttl_col 
				
				ls_campo = ids_detalle.Describe("#" + STRING(le_col) + ".Name")
				ls_dato = ids_detalle.GETITEMSTRING(le_pos_m, le_col) 
				ls_inserta = ls_campo + " | " + ls_dato 
				FILEWRITE(ll_archivo, ls_inserta) 
			
			NEXT 
		
		NEXT 
		
		
		FILECLOSE(ll_archivo)
						
	NEXT



RETURN 0 





 
end function

public function integer f_genera_informacion_titulo ();LONG ll_cuenta
LONG ll_cve_carrera
LONG ll_cve_plan 
LONG ll_error 

INTEGER le_pos, le_ttl_reg, resultado

le_ttl_reg = ids_alumnos.ROWCOUNT()


// Antes de generar los archivos , se ejecuta SP para cada uno de las CUENTA-CARRERA-PLAN, para generar la información necesaria. 
FOR le_pos = 1 TO le_ttl_reg 

	ll_cuenta = ids_alumnos.GETITEMNUMBER(le_pos, "cuenta") 
	ll_cve_carrera = ids_alumnos.GETITEMNUMBER(le_pos, "cve_carrera") 
	ll_cve_plan = ids_alumnos.GETITEMNUMBER(le_pos, "cve_plan") 

	DECLARE calcula_titulo procedure for sp_calcula_titulo   
				@a_cuenta = :ll_cuenta,  
				@a_cve_carrera = :ll_cve_carrera,  
				@a_cve_plan = :ll_cve_plan 
	USING gtr_sce;			

	EXECUTE calcula_titulo ;
	IF gtr_sce.sqlcode < 0 Then
		MESSAGEBOX("Error", "Se produjo un error al EJECUTAR SP para generar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT) 
		RETURN -1 
   	End if	

//	FETCH  calcula_titulo INTO :ll_error; 
//	IF gtr_sce.sqlcode < 0 Then
//		MESSAGEBOX("Error", "Se produjo un error al RECUPERAR VALOR DE SP generar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
//		RETURN -1 
//	End if	

//	CLOSE calcula_titulo;
//	IF gtr_sce.sqlcode < 0 Then
//		MESSAGEBOX("Error", "Se produjo un error al CERRAR SP para generar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
//		RETURN -1 
//	End if	

	GARBAGECOLLECT() 
 
 	COMMIT USING gtr_sce; 
 
NEXT 
  
  
RETURN 0 




end function

public function integer f_genera_archivos2 (string as_id_doc);
// Se llama función que genera los querys del documento 
STRING ls_sintaxis_maestro, ls_sintaxis_detalle,  ls_sintaxis_cierre 
STRING ls_sintaxis_maestro_paso, ls_sintaxis_detalle_paso, ls_sintaxis_cierre_paso  
STRING ls_error

// SE GENERA LA INFORMACIÓN DEL "MAESTRO" DEL DOCUMENTO 
LONG ll_archivo 
STRING ls_count 
STRING ls_dato, ls_campo 
STRING ls_inserta 
STRING ls_cuenta 
LONG ll_cuenta
LONG ll_carrera
LONG ll_plan

INTEGER le_pos_m, le_pos_d, le_pos_c, le_estatal  
INTEGER le_ttl_m, le_ttl_d, le_ttl_c
INTEGER le_col, le_ttl_col, le_tipo_area, le_row_mat, le_tipo_asig
STRING ls_tipo_asig

STRING ls_ruta 
STRING ls_archivo
STRING ls_separador 

INTEGER le_pos_alumno, le_ttl_alumno 
INTEGER le_estatus , le_orden_dato

STRING ls_dato_archivo 
STRING ls_dato_vista 
STRING ls_valor_vista, ls_mensaje_validacion, ls_mensaje_validacion2 
STRING ls_bandera_zip = "N"

LONG ll_relacion[]  
DECIMAL ld_promedio 
INTEGER le_creditos


is_archivo_cierre = "" 
il_relacion  = ll_relacion
is_tipo_doc = as_id_doc
of_carga_estructuras(as_id_doc) 

// Se recupera las cadenas base para la generación de los archivos.
IF ids_lista_docs.ROWCOUNT() > 0 THEN 
	ls_ruta = ids_lista_docs.GETITEMSTRING(1, "ruta")
	
	// Si la ruta es variable, se toma la ruta temporal seleccionada. 
	IF ls_ruta = "VARIABLE" THEN 
		ls_ruta = is_ruta_variable
	END IF 	
	
	ls_archivo = ids_lista_docs.GETITEMSTRING(1, "nombre_archivo") 
	ls_separador = ids_lista_docs.GETITEMSTRING(1, "separador")  
	
//	// Se crea el directorio si no existe
//	f_crea_carpeta(ls_ruta)
	
ELSE
	MESSAGEBOX("Error", "No existen definiciones de documentos para generar. ")
	RETURN -1 
END IF 
				
// Se llama función previa a la generación de los documentos.
IF as_id_doc = "tit"  THEN 
	IF f_genera_informacion_titulo( ) < 0 THEN RETURN -1 
	ie_tipo_documento = 4 
	ie_tipo_certificacion = 0
ELSE
	ie_tipo_documento = 1 
END IF 
				
				
OPEN(w_avance, w_titulos_relacion)	
w_avance.hpb_docs.minposition = 0
				
// Se hace ciclo para generar cada uno de los documentos requeridos: 							
le_ttl_alumno = ids_alumnos.ROWCOUNT() 
FOR le_pos_alumno = 1 TO le_ttl_alumno 	
	
		ll_cuenta = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cuenta") 
		ls_cuenta = STRING(ll_cuenta)  
		ll_carrera = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cve_carrera") 
		IF ISNULL(ll_carrera) THEN ll_carrera = 0 
		ll_plan = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cve_plan") 
		IF ISNULL(ll_plan) THEN ll_plan = 0
		
		// Si se trata de certificados, se verifica si es estatal 
		IF as_id_doc <> "tit" THEN 
			
			//  Se verifica si el certificado es estatal o federal 
			SELECT plan_estatal 
			INTO :le_estatal 
			FROM plan_estudios 
			WHERE cve_carrera = :ll_carrera 
			AND cve_plan = :ll_plan 
			USING gtr_sce;  
			IF gtr_sce.sqlcode < 0 THEN 
				MESSAGEBOX("Error", "Se produjo un error al validar si es Plan Estatal: " + gtr_sce.SQLERRTEXT) 
				RETURN -1  
			END IF 	
			IF ISNULL(le_estatal) THEN le_estatal = 0 
			IF le_estatal = 1 THEN 
				as_id_doc = "ceres" 
			ELSE
				as_id_doc = "cer" 
			END IF 
			
		END IF 
	
		IF as_id_doc = "tit"  THEN  
 			IF f_valida_informacion_titulo(ll_cuenta, ll_carrera, ll_plan, ls_mensaje_validacion) <> 0 THEN 
				le_estatus = 4  
				f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, ls_mensaje_validacion)  				
				CONTINUE
			END IF 
		ELSE 
			
			/*Se carga de nueva cuenta la estructura para que corresponda al tipo de certificado.*/
			of_carga_estructuras(as_id_doc) 
			
			
 			IF f_valida_informacion_certificado(ll_cuenta, ll_carrera, ll_plan, ls_mensaje_validacion) <> 0 THEN 
				le_estatus = 4  
				f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, ls_mensaje_validacion)  				
				CONTINUE
			END IF 			
			// Si se trata de certificados se calcula el promedio. 
			IF f_calcula_promedio_cer(ll_cuenta, ll_carrera, ll_plan,ld_promedio, le_creditos)  < 0 THEN 
				MESSAGEBOX("Error", "Se produjo un error al calcular el promedio del alumno: " + STRING(ll_cuenta))  
				RETURN -1 
			END IF 	
			
		END IF
	
	
		IF ISVALID(ids_documento)  THEN DESTROY ids_documento 
		ids_documento = CREATE DATASTORE 
		
		ls_sintaxis_maestro_paso = is_sintaxis_maestro 
		// Se llama función de sustitución de parámetros 
		f_sustituye_parametros(ls_sintaxis_maestro_paso, ll_cuenta, ll_carrera, ll_plan, ie_tipo_certificacion,ld_promedio, le_creditos,ie_legalizado) 
		ls_sintaxis_maestro = gtr_sce.SyntaxFromSQL(ls_sintaxis_maestro_paso, "style(type=grid)", ref ls_error) 
		ids_documento.create(ls_sintaxis_maestro , ref ls_error) 
		
		IF Len(ls_error) > 0 THEN 
			ie_error = -1 
			is_error = ls_error 
			RETURN -1 
		END IF
		
		ids_documento.SETTRANSOBJECT(gtr_sce) 
		le_ttl_m = ids_documento.RETRIEVE() 
		IF le_ttl_m <= 0 THEN 
			
			// Si se trata de Titulos
			IF ie_tipo_documento = 4 THEN 
				le_estatus = 1  
				ls_mensaje_validacion2 = ""
				f_valida_inf_titulo_etapas(ll_cuenta, ll_carrera, ll_plan, ls_mensaje_validacion2)
			// Si se trata de Certificados	
			ELSE
				le_estatus = 2
 			END IF
			// f_inserta_documento_generado( /*long a_cuenta*/, /*long a_cve_carrera*/, /*long a_cve_plan*/, /*integer a_tipo_documento*/, /*string a_estatus_generado */)
			f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, ls_mensaje_validacion2)  
			CONTINUE 
		ELSE
// DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR 			
			IF ls_bandera_zip = "N" AND as_id_doc = "tit" THEN 
				// Recupera e inserta el nombre de zip
				STRING ls_nombre_zip
				INTEGER le_num_generacion
				IF f_genera_grupo_zip(ls_nombre_zip, le_num_generacion) < 0 THEN 
					RETURN -1
				END IF 	
				ls_count = ids_documento.Object.DataWindow.Column.Count 
				le_ttl_col = INTEGER(ls_count) 
				ls_campo = ids_documento.Describe("#" + STRING(le_ttl_col - 1) + ".Name") 			
				ids_documento.SETITEM(le_ttl_m, ls_campo, "1")  
				ls_campo = ids_documento.Describe("#" + STRING(le_ttl_col) + ".Name") 			
				ids_documento.SETITEM(le_ttl_m, ls_campo, ls_nombre_zip)   
				ls_bandera_zip = "S"
				
				// Se crea el directorio si no existe
				f_crea_carpeta(ls_ruta, le_num_generacion)				
				
			ELSE	
				IF as_id_doc = "tit" THEN  
					ids_documento.SETITEM(le_ttl_m, ls_campo, ls_nombre_zip)
				END IF	
			END IF
// DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR DESCOMENTAR 
		END IF 	
		
		// Si existe el detalle lo recupera.
		IF LEN(is_sintaxis_detalle) > 0 THEN 
			
			IF ISVALID(ids_detalle) THEN DESTROY ids_detalle 
			ids_detalle = CREATE DATASTORE 
			
			ls_sintaxis_detalle_paso = is_sintaxis_detalle
			// Se llama función de sustitución de parámetros 
			f_sustituye_parametros(ls_sintaxis_detalle_paso, ll_cuenta, ll_carrera, ll_plan, ie_tipo_certificacion,ld_promedio, le_creditos,ie_legalizado) 
	
			ls_sintaxis_detalle = gtr_sce.SyntaxFromSQL(ls_sintaxis_detalle_paso, "style(type=grid)", ref ls_error)  
			ids_detalle.create(ls_sintaxis_detalle , ref ls_error) 
			
			IF Len(ls_error) > 0 THEN 
				ie_error = -1 
				is_error = ls_error 
				RETURN -1 
			END IF
		
			ids_detalle.SETTRANSOBJECT(gtr_sce) 
			le_ttl_d = ids_detalle.RETRIEVE()  
			IF le_ttl_d = 0 THEN 
				le_estatus = 5
				f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, "")  
				CONTINUE 			
			ELSEIF le_ttl_d < 0 THEN 
				le_estatus = 2
				f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, "")  
				CONTINUE 							
			END IF 	
			
			// Si se trata de certificados, se complementa el tipo de materia.
			IF as_id_doc = "cer"  THEN 
				
				ls_count = ids_detalle.Object.DataWindow.Column.Count
				le_ttl_col = INTEGER(ls_count) 
				ls_campo = ids_detalle.Describe("#" + STRING(le_ttl_col) + ".Name") 
				
				FOR le_pos_d  = 1 TO le_ttl_d 
					
					ls_dato = ids_detalle.GETITEMSTRING(le_pos_d, le_ttl_col) 
					le_tipo_area = tipoarea_nivel_suj(INTEGER(ls_dato), ll_plan, is_nivel )  
					
					le_row_mat = ids_lista_tipo_asignatura.FIND("id_tipo_materia = '" + STRING(le_tipo_area) + "'", 1, ids_lista_tipo_asignatura.ROWCOUNT()) 
					IF le_row_mat > 0 THEN 
						le_tipo_asig = ids_lista_tipo_asignatura.GETITEMNUMBER(le_row_mat, "id_tipo_asignatura")  
						ls_tipo_asig	= ids_lista_tipo_asignatura.GETITEMSTRING(le_row_mat, "descripcion")  
					ELSE
						le_tipo_asig = 1
						ls_tipo_asig	= 'OBLIGATORIA'									
					END IF 
				
					ids_detalle.SETITEM(le_pos_d, "idTipoAsignatura", STRING(le_tipo_asig))	
					ids_detalle.SETITEM(le_pos_d, "tipoAsignatura", ls_tipo_asig)
					
				NEXT 
			
			/*Si se trata de certificados estatales*/ 
			ELSEIF as_id_doc = "ceres"  THEN 
			
//				ls_count = ids_detalle.Object.DataWindow.Column.Count
//				le_ttl_col = INTEGER(ls_count) 
//				ls_campo = ids_detalle.Describe("#" + STRING(le_ttl_col) + ".Name") 
//				
//				FOR le_pos_d  = 1 TO le_ttl_d 
//					
//					ls_dato = ids_detalle.GETITEMSTRING(le_pos_d, le_ttl_col) 
//					le_tipo_area = tipoarea_nivel_suj(INTEGER(ls_dato), ll_plan, is_nivel )  
//					
//					le_row_mat = ids_lista_tipo_asignatura.FIND("id_tipo_materia = '" + STRING(le_tipo_area) + "'", 1, ids_lista_tipo_asignatura.ROWCOUNT()) 
//					IF le_row_mat > 0 THEN 
//						le_tipo_asig = ids_lista_tipo_asignatura.GETITEMNUMBER(le_row_mat, "id_tipo_asignatura")  
//						ls_tipo_asig	= ids_lista_tipo_asignatura.GETITEMSTRING(le_row_mat, "descripcion")  
//					ELSE
//						le_tipo_asig = 1
//						ls_tipo_asig	= 'OBLIGATORIA'									
//					END IF 
//				
//					ids_detalle.SETITEM(le_pos_d, "idTipoAsignatura", STRING(le_tipo_asig))	
//					ids_detalle.SETITEM(le_pos_d, "tipoAsignatura", ls_tipo_asig)
//					
//				NEXT 			
			
			
			END IF 
			
		END IF 


		// CIERRE 
		// Si existe cierre lo recupera.
		IF LEN(is_sintaxis_cierre) > 0 THEN 
			
			IF ISVALID(ids_cierre) THEN DESTROY ids_cierre 
			ids_cierre = CREATE DATASTORE 
			
			ls_sintaxis_cierre_paso = is_sintaxis_cierre
			// Se llama función de sustitución de parámetros 
			f_sustituye_parametros(ls_sintaxis_cierre_paso, ll_cuenta, ll_carrera, ll_plan, ie_tipo_certificacion,ld_promedio, le_creditos,ie_legalizado) 
	
			ls_sintaxis_cierre = gtr_sce.SyntaxFromSQL(ls_sintaxis_cierre_paso, "style(type=grid)", ref ls_error)  
			ids_cierre.create(ls_sintaxis_cierre , ref ls_error) 
			
			IF Len(ls_error) > 0 THEN 
				ie_error = -1 
				is_error = ls_error 
				RETURN -1 
			END IF
		
			ids_cierre.SETTRANSOBJECT(gtr_sce) 
			le_ttl_c = ids_cierre.RETRIEVE()  
			COMMIT USING gtr_sce;
			IF le_ttl_c <= 0 THEN 
				le_estatus = 2
				f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, "")  
				CONTINUE 			
			END IF 	
			
		END IF 
		// CIERRE 

		// Se abre archivo
		ll_archivo = FileOpen(ls_ruta + ls_archivo + "_" + ls_cuenta + "_" + STRING(ll_carrera) + "_" + STRING(ll_plan) + ".txt", LineMode!, Write! , LockWrite! , Replace!, EncodingUTF8!)  
		IF ll_archivo < 0 THEN 
			le_estatus = 6
			f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, "")  
			CONTINUE
		END IF 
		
		IF ls_bandera_zip = "S" AND as_id_doc = "tit" AND TRIM(is_archivo_cierre) <> "" THEN 
			is_archivo_cierre = ls_ruta + ls_archivo + "_" + ls_cuenta + "_" + STRING(ll_carrera) + "_" + STRING(ll_plan) + ".txt" 
		END IF 	
		
		// Se recupera el total de lineas del archivo de texto  
		ids_e_titulo_archivo.SETFILTER("nivel = 'M'") 
		ids_e_titulo_archivo.FILTER()
		ids_e_titulo_archivo.SETSORT("orden asc") 
		ids_e_titulo_archivo.SORT() 
		le_ttl_m = ids_e_titulo_archivo.ROWCOUNT() 
		
		// Se genera el archivo de texto del MAESTRO 
		FOR le_pos_m = 1 TO le_ttl_m  
		
			// Se recupera la los datos de archivo y vista correspondientes 
			ls_dato_archivo = ids_e_titulo_archivo.GETITEMSTRING(le_pos_m, "dato_archivo")  
			ls_dato_vista = TRIM(ids_e_titulo_archivo.GETITEMSTRING(le_pos_m, "dato_vista")) 
			IF ISNULL(ls_dato_vista) THEN ls_dato_vista = ""  
			
			IF LEN(ls_dato_vista) > 0 THEN 
				// Se recupera el valor del campo 
				ls_valor_vista = ids_documento.GETITEMSTRING(ids_documento.ROWCOUNT(), ls_dato_vista) 
			ELSE
				ls_valor_vista = "" 
			END IF
			
			IF TRIM(ls_valor_vista) = "" AND TRIM(ls_dato_archivo) = "" THEN 
				ls_inserta = "" 
			ELSEIF TRIM(ls_valor_vista) = "" AND POS(ls_dato_archivo, "*") > 0 THEN 
				ls_inserta = ls_dato_archivo  
			ELSE	
				ls_inserta = ls_dato_archivo + " " + ls_separador + " " + ls_valor_vista 
			END IF 
				
			FILEWRITE(ll_archivo, ls_inserta)  
		
		NEXT 		
		
		// SE INSERTA EL DETALLE DE MATERIAS
		
		// Se recupera el total de lineas del archivo de texto 
		ids_e_titulo_archivo.SETFILTER("nivel = 'D'") 
		ids_e_titulo_archivo.FILTER()
		ids_e_titulo_archivo.SETSORT("orden asc") 
		ids_e_titulo_archivo.SORT() 
		le_ttl_m = ids_e_titulo_archivo.ROWCOUNT() 
		
		
		FOR le_pos_d  = 1 TO le_ttl_d 
			// Se genera el archivo de texto del MAESTRO 
			FOR le_pos_m = 1 TO le_ttl_m  
			
				// Se recupera la los datos de archivo y vista correspondientes 
				ls_dato_archivo = ids_e_titulo_archivo.GETITEMSTRING(le_pos_m, "dato_archivo")  
				ls_dato_vista = TRIM(ids_e_titulo_archivo.GETITEMSTRING(le_pos_m, "dato_vista")) 
				IF ISNULL(ls_dato_vista) THEN ls_dato_vista = ""  
				le_orden_dato = ids_e_titulo_archivo.GETITEMNUMBER(le_pos_m, "orden")  
				
				IF LEN(ls_dato_vista) > 0 THEN 
					// Se recupera el valor del campo 
					//ls_dato_vista =  ids_detalle.Describe("#" + STRING(le_orden_dato) + ".Name") 
					ls_valor_vista = ids_detalle.GETITEMSTRING(le_pos_d, ls_dato_vista) 
				ELSE
					ls_valor_vista = "" 
				END IF
				
				IF TRIM(ls_valor_vista) = "" AND POS(ls_dato_archivo, "*") > 0 THEN 
					ls_inserta = ls_dato_archivo  
				ELSE	
					ls_inserta = ls_dato_archivo + " " + ls_separador + " " + ls_valor_vista 
				END IF 
					
				FILEWRITE(ll_archivo, ls_inserta)  
				
			NEXT		
		NEXT
		

	
		
		// CIERRE		
		// Se recupera el total de lineas del archivo de texto 
		ids_e_titulo_archivo.SETFILTER("nivel = 'C'") 
		ids_e_titulo_archivo.FILTER()
		ids_e_titulo_archivo.SETSORT("orden asc") 
		ids_e_titulo_archivo.SORT() 
		le_ttl_c = ids_e_titulo_archivo.ROWCOUNT() 
		
		// Se genera el archivo de texto del MAESTRO 
		FOR le_pos_c = 1 TO le_ttl_c  
		
			// Se recupera la los datos de archivo y vista correspondientes 
			ls_dato_archivo = ids_e_titulo_archivo.GETITEMSTRING(le_pos_c, "dato_archivo")  
			ls_dato_vista = TRIM(ids_e_titulo_archivo.GETITEMSTRING(le_pos_c, "dato_vista")) 
			IF ISNULL(ls_dato_vista) THEN ls_dato_vista = ""  
			
			IF LEN(ls_dato_vista) > 0 THEN 
				// Se recupera el valor del campo 
				ls_valor_vista = ids_cierre.GETITEMSTRING(1, ls_dato_vista) 
			ELSE
				ls_valor_vista = "" 
			END IF
			
			IF TRIM(ls_valor_vista) = "" AND TRIM(ls_dato_archivo) = "" THEN 
				ls_inserta = "" 
			ELSEIF TRIM(ls_valor_vista) = "" AND POS(ls_dato_archivo, "*") > 0 THEN 
				ls_inserta = ls_dato_archivo  
			ELSE	
				ls_inserta = ls_dato_archivo + " " + ls_separador + " " + ls_valor_vista 
			END IF 
				
			FILEWRITE(ll_archivo, ls_inserta)  
			
		NEXT
		// CIERRE 
		
		
		
		
		
		
		// Se genera el archivo de texto del CIERRE  
//		FOR le_pos_c = 1 TO le_ttl_c  
//			
//			ls_count = ids_cierre.Object.DataWindow.Column.Count
//			le_ttl_col = INTEGER(ls_count) 
//			
//			FOR le_col = 1 TO le_ttl_col 
//				
//				ls_campo = ids_cierre.Describe("#" + STRING(le_col) + ".Name")
//				ls_dato = ids_cierre.GETITEMSTRING(le_pos_c, le_col) 
//				ls_inserta = ls_campo + " | " + ls_dato 
//				FILEWRITE(ll_archivo, ls_inserta) 
//			
//			NEXT 
//			
//		NEXT 
		// CIERRE
		
		
		FILECLOSE(ll_archivo)
			
		w_avance.st_avance.TEXT = "Procesado: "	 + STRING(le_pos_alumno) + " de: " + STRING(le_ttl_alumno)
		w_avance.hpb_docs.maxposition = le_ttl_alumno 
		w_avance.hpb_docs.position = le_pos_alumno 
		
		le_estatus = 0
		f_inserta_documento_generado(ll_cuenta, ll_carrera, ll_plan, ie_tipo_documento, le_estatus, "") 
		
	NEXT

	CLOSE(w_avance)

	IF as_id_doc = "tit" AND le_num_generacion > 0 THEN 
		IF f_actualiza_grupo_zip(le_num_generacion) < 0 THEN 
			MESSAGEBOX("Error", "Se produjo un error al insertar el numero de archivo zip:" + gtr_sce.SQLERRTEXT) 
		END IF	
	END IF

COMMIT USING gtr_sce;


ll_archivo = FileOpen(is_archivo_cierre, LineMode!, Write! , LockWrite! , Append!, EncodingUTF8!)  
FILEWRITE(ll_archivo, "")
FILECLOSE(ll_archivo)



MESSAGEBOX("Aviso", "Los archivos fueron generados con éxito.")  

uo_parametros luo_parametros
luo_parametros = CREATE uo_parametros

luo_parametros.il_relacion = il_relacion 
OPENWITHPARM(w_reporte_documentos, luo_parametros) 


RETURN 0 





 
























//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//// Se llama función que genera los querys del documento 
//STRING ls_sintaxis_maestro, ls_sintaxis_detalle 
//STRING ls_sintaxis_maestro_paso, ls_sintaxis_detalle_paso  
//STRING ls_error
//
//// SE GENERA LA INFORMACIÓN DEL "MAESTRO" DEL DOCUMENTO 
//LONG ll_archivo 
//STRING ls_count 
//STRING ls_dato, ls_campo 
//STRING ls_inserta 
//STRING ls_cuenta 
//LONG ll_cuenta
//LONG ll_carrera
//LONG ll_plan
//
//
//INTEGER le_pos_m, le_pos_d 
//INTEGER le_ttl_m, le_ttl_d
//INTEGER le_col, le_ttl_col 
//
//STRING ls_ruta 
//STRING ls_archivo
//
//INTEGER le_pos_alumno, le_ttl_alumno 
//
//of_carga_estructuras(as_id_doc) 
//
//// Se recupera las cadenas base para la generación de los archivos.
//IF ids_lista_docs.ROWCOUNT() > 0 THEN 
//	ls_ruta = ids_lista_docs.GETITEMSTRING(1, "ruta")
//	ls_archivo = ids_lista_docs.GETITEMSTRING(1, "nombre_archivo") 
//ELSE
//	MESSAGEBOX("Error", "No existen definiciones de documentos para generar. ")
//	RETURN -1 
//END IF 
//				
//// Se llama función previa a la generación de los documentos.
//IF as_id_doc = "tit"  THEN 
//	IF f_genera_informacion_titulo( ) < 0 THEN RETURN -1 
//END IF 
//				
//// Se hace ciclo para generar cada uno de los documentos requeridos: 							
//le_ttl_alumno = ids_alumnos.ROWCOUNT() 
//FOR le_pos_alumno = 1 TO le_ttl_alumno 	
//	
//		ll_cuenta = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cuenta") 
//		ls_cuenta = STRING(ll_cuenta)  
//		ll_carrera = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cve_carrera") 
//		IF ISNULL(ll_carrera) THEN ll_carrera = 0 
//		ll_plan = ids_alumnos.GETITEMNUMBER(le_pos_alumno, "cve_plan") 
//		IF ISNULL(ll_plan) THEN ll_plan = 0
//	
//		IF ISVALID(ids_documento)  THEN DESTROY ids_documento 
//		ids_documento = CREATE DATASTORE 
//		
//		ls_sintaxis_maestro_paso = is_sintaxis_maestro 
//		// Se llama función de sustitución de parámetros 
//		f_sustituye_parametros(ls_sintaxis_maestro_paso, ll_cuenta, ll_carrera, ll_plan) 
//		ls_sintaxis_maestro = gtr_sce.SyntaxFromSQL(ls_sintaxis_maestro_paso, "style(type=grid)", ref ls_error) 
//		ids_documento.create(ls_sintaxis_maestro , ref ls_error) 
//		
//		IF Len(ls_error) > 0 THEN 
//			ie_error = -1 
//			is_error = ls_error 
//			RETURN -1 
//		END IF
//		
//		ids_documento.SETTRANSOBJECT(gtr_sce) 
//		le_ttl_m = ids_documento.RETRIEVE() 
//		
//		// Si existe el detalle lo recupera.
//		IF LEN(is_sintaxis_detalle) > 0 THEN 
//			
//			IF ISVALID(ids_detalle) THEN DESTROY ids_detalle 
//			ids_detalle = CREATE DATASTORE 
//			
//			ls_sintaxis_detalle_paso = is_sintaxis_detalle
//			// Se llama función de sustitución de parámetros 
//			f_sustituye_parametros(ls_sintaxis_detalle_paso, ll_cuenta, ll_carrera, ll_plan) 
//	
//			ls_sintaxis_detalle = gtr_sce.SyntaxFromSQL(ls_sintaxis_detalle_paso, "style(type=grid)", ref ls_error)  
//			ids_detalle.create(ls_sintaxis_detalle , ref ls_error) 
//			
//			IF Len(ls_error) > 0 THEN 
//				ie_error = -1 
//				is_error = ls_error 
//				RETURN -1 
//			END IF
//		
//			ids_detalle.SETTRANSOBJECT(gtr_sce) 
//			le_ttl_d = ids_detalle.RETRIEVE() 
//			
//		END IF 
//		
//
//		// Se abre archivo
//		//ll_archivo = FileOpen("C:\Apoyos\EJEMPLOS_CERTIFICADOS\" + "prueba_cer" + "_" + ".txt", LineMode!, Write! , LockWrite! , Replace!, EncodingUTF8!) 
//		ll_archivo = FileOpen(ls_ruta + ls_archivo + "_" + ls_cuenta + ".txt", LineMode!, Write! , LockWrite! , Replace!, EncodingUTF8!) 
//		
//		// Se genera el archivo de texto del MAESTRO 
//		FOR le_pos_m = 1 TO le_ttl_m  
//			
//			ls_count = ids_documento.Object.DataWindow.Column.Count
//			le_ttl_col = INTEGER(ls_count) 
//			
//			FOR le_col = 1 TO le_ttl_col 
//				
//				ls_campo = ids_documento.Describe("#" + STRING(le_col) + ".Name")
//				ls_dato = ids_documento.GETITEMSTRING(le_pos_m, le_col) 
//				ls_inserta = ls_campo + " | " + ls_dato 
//				FILEWRITE(ll_archivo, ls_inserta) 
//			
//			NEXT 
//			
//		NEXT 
//		
//		// Se genera el archivo de texto del DETALLE  
//		FOR le_pos_d  = 1 TO le_ttl_d 
//		
//			ls_count = ids_detalle.Object.DataWindow.Column.Count
//			le_ttl_col = INTEGER(ls_count) 
//			
//			FOR le_col = 1 TO le_ttl_col 
//				
//				ls_campo = ids_detalle.Describe("#" + STRING(le_col) + ".Name")
//				ls_dato = ids_detalle.GETITEMSTRING(le_pos_m, le_col) 
//				ls_inserta = ls_campo + " | " + ls_dato 
//				FILEWRITE(ll_archivo, ls_inserta) 
//			
//			NEXT 
//		
//		NEXT 
//		
//		
//		FILECLOSE(ll_archivo)
//						
//	NEXT
//
//
//
//RETURN 0 
//
//
//
//		// SE INSERTA EL DETALLE DE MATERIAS 
		
//		// Se genera el archivo de texto del DETALLE  
//		FOR le_pos_d  = 1 TO le_ttl_d 
//		
//			ls_count = ids_detalle.Object.DataWindow.Column.Count
//			le_ttl_col = INTEGER(ls_count) 
//			
//			FOR le_col = 1 TO le_ttl_col 
//				
//				ls_campo = ids_detalle.Describe("#" + STRING(le_col) + ".Name")
//				ls_dato = ids_detalle.GETITEMSTRING(le_pos_d, le_col) 
//				ls_inserta = ls_campo + " | " + ls_dato 
//				FILEWRITE(ll_archivo, ls_inserta) 
//			
//			NEXT 
//		
//		NEXT 
//
// 
end function

public function integer f_valida_informacion_titulo (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_mensaje_salida);//RETURN 0
LONG ll_error 
STRING ls_mensaje_salida

DECLARE valida_previo_titulo procedure for sp_valida_previo_titulo_xml    
			@an_cuenta = :al_cuenta,  
			@an_cve_carrera = :al_cve_carrera,  
			@an_cve_plan = :al_cve_plan
USING gtr_sce;			

//, 
//			@mensaje_salida = :ls_mensaje_salida  OUTPUT 

EXECUTE valida_previo_titulo ;
IF gtr_sce.sqlcode < 0 Then
	MESSAGEBOX("Error", "Se produjo un error al EJECUTAR SP para generar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT) 
	RETURN -1 
End if	

FETCH  valida_previo_titulo INTO :ll_error, :ls_mensaje_salida;  
IF gtr_sce.sqlcode < 0 Then
	CLOSE valida_previo_titulo;
	COMMIT USING gtr_sce; 	
	as_mensaje_salida = ls_mensaje_salida 
	MESSAGEBOX("Error", "Se produjo un error al RECUPERAR VALOR DE SP generar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
	RETURN -1 
End if	

IF ll_error <> 0 Then
	CLOSE valida_previo_titulo;
	COMMIT USING gtr_sce; 
	as_mensaje_salida = ls_mensaje_salida 
	RETURN -1 
End if	

CLOSE valida_previo_titulo;
IF gtr_sce.sqlcode < 0 Then
	CLOSE valida_previo_titulo;
	COMMIT USING gtr_sce; 	
	MESSAGEBOX("Error", "Se produjo un error al CERRAR SP para generar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
	RETURN -1 
End if	

GARBAGECOLLECT() 

COMMIT USING gtr_sce; 
 
RETURN ll_error 






end function

public function integer f_inserta_documento_generado (long a_cuenta, long a_cve_carrera, long a_cve_plan, integer a_tipo_documento, integer a_estatus_generado, string as_mensaje_validacion);LONG ll_registro
DATETIME ldt_fecha_registro
STRING ls_usuario_registro 
STRING ls_error

// Se recupera el consecutivo del registro de generación de archivo. 
SELECT MAX(registro)  
INTO :ll_registro
FROM e_documento_generado 
USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("ERROR", "Se produjo un  error al recuperar el consecutivo del número del registro de generación del archivo: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF 
COMMIT USING gtr_sce; 


IF ISNULL(ll_registro) THEN ll_registro = 0 
ll_registro = ll_registro + 1 

ls_usuario_registro = gs_usuario 

ldt_fecha_registro = fecha_servidor(gtr_sce)

// Se inserta el registro de la generación del archivo.
INSERT INTO e_documento_generado(registro, cuenta, cve_carrera, cve_plan, 
												tipo_documento, estatus_generado, fecha_registro, usuario_registro, relacion, comentario) 
VALUES(:ll_registro, :a_cuenta, :a_cve_carrera, :a_cve_plan, 
			:a_tipo_documento, :a_estatus_generado, :ldt_fecha_registro, :ls_usuario_registro, :il_num_relacion, :as_mensaje_validacion) 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	ls_error = gtr_sce.SQLERRTEXT
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("ERROR", "Se produjo un  error al insertar el registro de generación del archivo: " + ls_error)  
	RETURN -1 
END IF 

COMMIT USING gtr_sce; 

ii_indice = UPPERBOUND(il_relacion) + 1 
il_relacion[ii_indice] = ll_registro

RETURN 0 




end function

public function integer f_genera_grupo_zip (ref string as_nombre_zip, ref integer ai_num_generacion);DATE ldt_fecha_registro 
STRING ls_nombre_zip
INTEGER le_consecutivo 

ldt_fecha_registro = DATE(fecha_servidor(gtr_sce))  

ls_nombre_zip = RIGHT(STRING(DAY(ldt_fecha_registro) + 100), 2) + "_" + RIGHT(STRING(MONTH(ldt_fecha_registro) + 100), 2) + "_" + STRING(YEAR(ldt_fecha_registro))    

SELECT MAX(num_generacion)
INTO :le_consecutivo 
FROM e_titulo_control_gen
WHERE id_doc = :is_tipo_doc 
AND fecha_generacion = :ldt_fecha_registro 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el numero de archivo zip:" + gtr_sce.SQLERRTEXT) 
	RETURN -1
END IF 

IF ISNULL(le_consecutivo) THEN le_consecutivo = 0 
le_consecutivo++ 

as_nombre_zip = ls_nombre_zip + "_" + STRING(le_consecutivo) + ".zip"    
ai_num_generacion = le_consecutivo
RETURN 0 




end function

public function integer f_crea_carpeta (ref string as_ruta, integer ai_consecutivo);DATE ldt_fecha_registro 
STRING ls_nombre_carpeta 

ldt_fecha_registro = DATE(fecha_servidor(gtr_sce)) 

ls_nombre_carpeta = RIGHT(STRING(DAY(ldt_fecha_registro) + 100), 2) + "_" + RIGHT(STRING(MONTH(ldt_fecha_registro) + 100), 2) + "_" + STRING(YEAR(ldt_fecha_registro))  + "_" + STRING(ai_consecutivo)

IF NOT DirectoryExists ( as_ruta + ls_nombre_carpeta) THEN 
	CREATEDIRECTORY(as_ruta + ls_nombre_carpeta) 
END IF 	

// SE completa la ruta 
as_ruta = as_ruta + ls_nombre_carpeta + "\"

RETURN 0 



end function

public function integer f_actualiza_grupo_zip (integer ai_consecutivo);DATE ldt_fecha_registro 
STRING ls_nombre_zip
INTEGER le_consecutivo 

ldt_fecha_registro = DATE(fecha_servidor(gtr_sce))  

//ls_nombre_zip = RIGHT(STRING(DAY(ldt_fecha_registro) + 100), 2) + "_" + RIGHT(STRING(MONTH(ldt_fecha_registro) + 100), 2) + "_" + STRING(YEAR(ldt_fecha_registro))    


INSERT INTO e_titulo_control_gen(id_doc, num_generacion, fecha_generacion)  
VALUES (:is_tipo_doc, :ai_consecutivo, :ldt_fecha_registro )
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	//ROLLBACK USING gtr_sce; 
	//MESSAGEBOX("Error", "Se produjo un error al insertar el numero de archivo zip:" + gtr_sce.SQLERRTEXT) 
	RETURN -1
END IF  

//COMMIT USING gtr_sce; 


RETURN 0 


end function

public function integer f_valida_informacion_certificado (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_mensaje_salida);
LONG ll_error 
STRING ls_mensaje_salida

IF gs_plantel = "PLANTEL CIUDAD DE MÉXICO" THEN
		DECLARE valida_sol_certificado procedure for sp_valida_sol_certificado    
			@an_cuenta = :al_cuenta,  
			@an_cve_carrera = :al_cve_carrera,  
			@an_cve_plan = :al_cve_plan
		USING gtr_sce;			
		
		EXECUTE valida_sol_certificado ;
		IF gtr_sce.sqlcode < 0 Then
			MESSAGEBOX("Error", "Se produjo un error al EJECUTAR SP para validar la información necesaria para la creación del certificado electrónico" + gtr_sce.SQLERRTEXT) 
			RETURN -1 
		End if	
		
		FETCH  valida_sol_certificado INTO :ll_error, :ls_mensaje_salida;  
		IF gtr_sce.sqlcode < 0 Then
			CLOSE valida_sol_certificado;
			COMMIT USING gtr_sce; 	
			as_mensaje_salida = ls_mensaje_salida 
			MESSAGEBOX("Error", "Se produjo un error al RECUPERAR VALOR DE SP para validar necesaria para la creación del certificado electrónico" + gtr_sce.SQLERRTEXT)  
			RETURN -1 
		End if	
		
		IF ll_error <> 0 Then
			CLOSE valida_sol_certificado;
			COMMIT USING gtr_sce; 
			as_mensaje_salida = ls_mensaje_salida 
			RETURN -1 
		End if	
		
		CLOSE valida_sol_certificado;
		IF gtr_sce.sqlcode < 0 Then
			//CLOSE valida_sol_certificado;
			COMMIT USING gtr_sce; 	
			MESSAGEBOX("Error", "Se produjo un error al CERRAR SP paravalidar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
			RETURN -1 
		End if			
		
ELSEIF gs_plantel = "PLANTEL TIJUANA"  THEN 
		DECLARE valida_sol_certificado_tij procedure for sp_valida_sol_certificado_tij    
			@an_cuenta = :al_cuenta,  
			@an_cve_carrera = :al_cve_carrera,  
			@an_cve_plan = :al_cve_plan
		USING gtr_sce;		
		
		EXECUTE valida_sol_certificado_tij ;
		IF gtr_sce.sqlcode < 0 Then
			MESSAGEBOX("Error", "Se produjo un error al EJECUTAR SP para validar la información necesaria para la creación del certificado electrónico" + gtr_sce.SQLERRTEXT) 
			RETURN -1 
		End if	
		
		FETCH  valida_sol_certificado_tij INTO :ll_error, :ls_mensaje_salida;  
		IF gtr_sce.sqlcode < 0 Then
			CLOSE valida_sol_certificado_tij;
			COMMIT USING gtr_sce; 	
			as_mensaje_salida = ls_mensaje_salida 
			MESSAGEBOX("Error", "Se produjo un error al RECUPERAR VALOR DE SP para validar necesaria para la creación del certificado electrónico" + gtr_sce.SQLERRTEXT)  
			RETURN -1 
		End if	
		
		IF ll_error <> 0 Then
			CLOSE valida_sol_certificado_tij;
			COMMIT USING gtr_sce; 
			as_mensaje_salida = ls_mensaje_salida 
			RETURN -1 
		End if	
		
		CLOSE valida_sol_certificado_tij;
		IF gtr_sce.sqlcode < 0 Then
			//CLOSE valida_sol_certificado_tij;
			COMMIT USING gtr_sce; 	
			MESSAGEBOX("Error", "Se produjo un error al CERRAR SP paravalidar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
			RETURN -1 
		End if			
		COMMIT USING gtr_sce; 	
		
END IF 	




//, 
//			@mensaje_salida = :ls_mensaje_salida  OUTPUT 



GARBAGECOLLECT() 

COMMIT USING gtr_sce; 
 
RETURN ll_error 






end function

public function integer f_valida_inf_titulo_etapas (long al_cuenta, long al_cve_carrera, long al_cve_plan, ref string as_mensaje_salida);//RETURN 0
LONG ll_error 
STRING ls_mensaje_salida

DECLARE valida_previo_titulo procedure for sp_valida_datos_titulo_xml    
			@an_cuenta = :al_cuenta,  
			@an_cve_carrera = :al_cve_carrera,  
			@an_cve_plan = :al_cve_plan
USING gtr_sce;			



EXECUTE valida_previo_titulo ;
IF gtr_sce.sqlcode < 0 Then
	MESSAGEBOX("Error", "Se produjo un error al EJECUTAR SP para validar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT) 
	RETURN -1 
End if	

FETCH  valida_previo_titulo INTO :ll_error, :ls_mensaje_salida;  
IF gtr_sce.sqlcode < 0 Then
	CLOSE valida_previo_titulo;
	COMMIT USING gtr_sce; 	
	as_mensaje_salida = ls_mensaje_salida 
	MESSAGEBOX("Error", "Se produjo un error al RECUPERAR VALOR DE SP para valuidar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
	RETURN -1 
End if	

as_mensaje_salida = ls_mensaje_salida 

IF ll_error <> 0 Then
	CLOSE valida_previo_titulo;
	COMMIT USING gtr_sce; 
	as_mensaje_salida = ls_mensaje_salida 
	RETURN -1 
End if	

CLOSE valida_previo_titulo;
IF gtr_sce.sqlcode < 0 Then
	CLOSE valida_previo_titulo;
	COMMIT USING gtr_sce; 	
	MESSAGEBOX("Error", "Se produjo un error al CERRAR SP para validar la información necesaria para la creación del título electrónico" + gtr_sce.SQLERRTEXT)  
	RETURN -1 
End if	

GARBAGECOLLECT() 

COMMIT USING gtr_sce; 
 
RETURN ll_error 








RETURN 0




end function

public function integer f_calcula_promedio_cer (long al_cuenta, long al_cve_carrera, integer le_plan, ref decimal ad_promedio, ref integer ai_creditos);
//al_cuenta
//al_cve_carrera
//le_plan
//ad_promedio
//ai_creditos

INTEGER le_doc_inf 
INTEGER le_doc_sup 
STRING ls_query 

// Se especifica el rango de tipo de documento  
IF ie_legalizado = 1 THEN 
	le_doc_inf = 5
	le_doc_sup = 8
ELSE
	le_doc_inf = 1
	le_doc_sup = 4
END IF

LONG ll_opcion_terminal

SELECT am.cve_mat 
INTO :ll_opcion_terminal
	FROM area_mat am, plan_estudios pe, carreras c
	WHERE pe.cve_carrera = :al_cve_carrera AND pe.cve_plan = :le_plan
	AND c.cve_carrera = pe.cve_carrera
   AND c.nivel <> "P" 
	AND pe.cve_plan IN (3,4)
	AND pe.cve_area_opcion_terminal = am.cve_area 
	USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la opción terminal: " + gtr_sce.SQLERRTEXT)  
	RETURN -1 
END IF 		

IF ISNULL(ll_opcion_terminal) THEN ll_opcion_terminal = 0 

ls_query = " select distinct mc.cve_mat, h.cuenta, h.calificacion, h.observacion, h.cve_carrera, h.cve_plan, mc.creditos " + & 
				" from historico h, materias_certificado mc " + &  
				" where h.cuenta = " + STRING(al_cuenta)  + &  
				" AND h.cve_carrera = "+ STRING(al_cve_carrera) + " and cve_plan = " + STRING(le_plan) + &  
				" AND h.calificacion NOT IN (~~'BA~~',~~'BJ~~') " + &  
				" AND h.cuenta = mc.cuenta " + & 
				" AND h.cve_mat = mc.cve_mat " + &  
				" AND h.cve_carrera= mc.cve_carrera " + &  
				" AND h.observacion <> 5 " + &  
				" AND h.calificacion in (~~'6~~',~~'7~~',~~'8~~',~~'9~~',~~'10~~', ~~'AC~~') " + &  
				" AND mc.es_materia = 1 AND mc.cve_tipo_doc_rep BETWEEN "  + STRING( le_doc_inf) + " AND " + STRING(le_doc_sup)  

INTEGER le_ttl_mat, le_pos 
DATASTORE lds_materias 
lds_materias = CREATE DATASTORE 
lds_materias.DATAOBJECT = "dw_calculo_reporte_cert"  
lds_materias.MODIFY("Datawindow.Table.Select = '" + ls_query + "'")
lds_materias.SETTRANSOBJECT(gtr_sce) 
le_ttl_mat = lds_materias.RETRIEVE() 

IF le_ttl_mat <= 0 THEN 
	MESSAGEBOX("Aviso", "No se encontraron materias para generar el Certificado. ")  
	RETURN -1 
END IF 	

STRING ls_calificacion 
DECIMAL le_calificacion 
DECIMAL le_suma_calificacion
INTEGER le_ttl_materias
DECIMAL ld_promedio 
INTEGER le_creditos
INTEGER le_ttl_creditos

FOR le_pos = 1 TO le_ttl_mat
	 
	 ls_calificacion = lds_materias.GETITEMSTRING(le_pos, "calificacion")  + ".00"
	 IF ISNULL(ls_calificacion) THEN ls_calificacion = "" 
	 le_creditos = lds_materias.GETITEMNUMBER(le_pos, "materias_certificado_creditos")  
	 IF ISNULL(le_creditos) THEN le_creditos = 0 
	 
	 IF ISNUMBER(ls_calificacion)  THEN 
		 le_calificacion = DEC(ls_calificacion) 
	ELSE
		IF ls_calificacion = 'MB' THEN 
			le_calificacion = 10.00  
		ELSEIF ls_calificacion = 'B' THEN 
			le_calificacion = 8.00  
		ELSEIF ls_calificacion = 'S' THEN 
			le_calificacion = 6.00   
		ELSE
			CONTINUE 
		END IF 
	END IF 	
	 
	le_suma_calificacion = le_suma_calificacion + le_calificacion 
	le_ttl_materias ++ 
	
	le_ttl_creditos = le_ttl_creditos + le_creditos 

	 
NEXT 

IF le_ttl_materias > 0.00 THEN 
	ld_promedio = le_suma_calificacion / le_ttl_materias 
END IF 	

ad_promedio = TRUNCATE(ld_promedio, 2) 


select SUM(m.creditos) 
INTO :le_ttl_creditos
FROM materias m, historico h, materias_certificado mc  
WHERE m.cve_mat = h.cve_mat AND
	h.cuenta = :al_cuenta and h.cve_carrera = :al_cve_carrera and
	h.cve_plan = :le_plan AND
	h.calificacion IN ('6 ','7 ','8 ','9 ','10','AC','MB','B ','S ','RE','E ' )
	AND h.cve_mat <> :ll_opcion_terminal 
	AND h.cuenta = mc.cuenta
	AND h.cve_mat = mc.cve_mat 
	AND h.cve_carrera= mc.cve_carrera 
	AND mc.es_materia = 1 AND mc.cve_tipo_doc_rep BETWEEN :le_doc_inf AND :le_doc_sup 	
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la opción terminal: " + gtr_sce.SQLERRTEXT)  
	RETURN -1 
END IF 		

ai_creditos = le_ttl_creditos

//AND h.observacion <> 5 

RETURN 0 








////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////

//// Función de cálculo de promedio para certificados. 
//DECIMAL do_prom 
//INTEGER in_cred, le_legalizado   
//
//le_legalizado = ie_legalizado 
//
///*Procedimiento que calcula tanto el promedio como el número de créditos acumulados*/
//DECLARE cal_prom PROCEDURE FOR calcula_promedio_cer   
//		@cuenta = :al_cuenta,   
//		@cve_carr = :al_cve_carrera,   
//		@plan = :le_plan,   
//		@tipo_cer = :le_legalizado, 
//		@promedio = :do_prom OUTPUT,
//		@creditos =:in_cred OUTPUT 
//USING gtr_sce;
//
//execute cal_prom;
//IF gtr_sce.sqlcode < 0 Then
//	MESSAGEBOX("Error", "Se produjo un error al EJECUTAR SP para calcular promedio" + gtr_sce.SQLERRTEXT) 
//	close cal_prom; 
//	RETURN -1 
//End if	
//
//FETCH cal_prom INTO :do_prom, :in_cred;/*Calcula promedio y créditos cursados*/
//close cal_prom;
//
//COMMIT USING gtr_sce;
//
//ad_promedio = ROUND(do_prom, 2)  
//ai_creditos = in_cred 
//
//RETURN 0 
//
//
//
end function

public function integer f_sustituye_parametros (ref string as_cadena, long al_cuenta, long al_carrera, long al_plan, long al_certificacion, decimal ad_promedio, integer ai_creditos, integer ai_legalizado);LONG le_pos 

// Se sustituye la cuenta 
DO
	le_pos = POS(as_cadena, "<¿cuenta?>") 
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 10, STRING(al_cuenta)) 
	END IF
LOOP WHILE le_pos > 0 

DO
	le_pos = POS(as_cadena, "<¿carrera?>") 
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 11, STRING(al_carrera)) 	
	END IF
LOOP WHILE le_pos > 0 	

DO
	le_pos = POS(as_cadena, "<¿plan?>")  
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 8, STRING(al_plan)) 	
	END IF
LOOP WHILE le_pos > 0 	

DO
	le_pos = POS(as_cadena, "<¿certificacion?>")  
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 17, STRING(al_certificacion)) 	
	END IF
LOOP WHILE le_pos > 0 	


DO
	le_pos = POS(as_cadena, "<¿fechainicial?>")  
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 16, STRING(idt_fecha_inicio, "mmm dd yyyy")) 	
	END IF
LOOP WHILE le_pos > 0 	


 DO
	le_pos = POS(as_cadena, "<¿fechafinal?>")  
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 14, STRING(idt_fecha_fin, "mmm dd yyyy")) 	
	END IF
LOOP WHILE le_pos > 0 	


// Promedio para el caso de certificados
 DO
	le_pos = POS(as_cadena, "<¿promedio?>")  
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 12, STRING(ad_promedio)) 	
	END IF
LOOP WHILE le_pos > 0 	

// Créditos para el caso de certificados
 DO
	le_pos = POS(as_cadena, "<¿creditos?>")  
	IF le_pos > 0 THEN 
		as_cadena = REPLACE(as_cadena, le_pos, 12, STRING(ai_creditos)) 	
	END IF
LOOP WHILE le_pos > 0 	

// Créditos para el caso de certificados
 DO
	le_pos = POS(as_cadena, "<¿legalizado?>")  
	IF le_pos > 0 THEN 
		IF ai_legalizado = 1 THEN 
			as_cadena = REPLACE(as_cadena, le_pos, 14, "5,6,7,8") 	
		ELSE
			as_cadena = REPLACE(as_cadena, le_pos, 14, "1,2,3,4") 	
		END IF 	
	END IF
LOOP WHILE le_pos > 0 	

// Legalizado detalle ESTATAL
 DO
	le_pos = POS(as_cadena, "<¿legalizadoEstatal?>")  
	IF le_pos > 0 THEN 
		IF ai_legalizado = 1 THEN 
			// Legalizado
			as_cadena = REPLACE(as_cadena, le_pos, 21, "'L'") 	
		ELSE
			// Simple 
			as_cadena = REPLACE(as_cadena, le_pos, 21, "'S'") 	 
		END IF 	
	END IF
LOOP WHILE le_pos > 0 	

RETURN 0  



end function

on uo_servicios_titulo_e.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_servicios_titulo_e.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_alumnos = CREATE DATASTORE 
ids_alumnos.DATAOBJECT = "dw_lista_alumnos_e"  




end event

