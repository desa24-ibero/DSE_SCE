$PBExportHeader$uo_genera_xml.sru
forward
global type uo_genera_xml from nonvisualobject
end type
end forward

global type uo_genera_xml from nonvisualobject
end type
global uo_genera_xml uo_genera_xml

type variables

DATASTORE ids_archivo 
DATASTORE ids_archivo_dato 
DATASTORE ids_archivo_query 
//DATASTORE ids_archivo_query_sumuia
DATASTORE ids_archivo_seccion 
DATASTORE ids_archivo_xml 
DATASTORE ids_archivo_xml_seccion 
DATASTORE ids_archivo_xml_seccion2
DATASTORE ids_archivo_datos

STRING is_error
INTEGER ie_error
end variables

forward prototypes
public function integer conecta_bd ()
public function integer desconectabd ()
public function integer carga_estructuras ()
public subroutine genera_xml ()
public function integer carga_informacion_archivo (string as_id_archivo)
public function integer reemplaza_dato (ref string as_segmento_xml, long al_pos_datos)
public function integer dato_rompimiento (integer ae_id_seccion)
public function integer genera_sub_detalle (long al_seccion_xml, ref long al_pos_datos, string as_archivo, integer ai_rompimiento_padre, string as_rompimiento_padre, ref string as_retorno[])
public function integer inserta_bitacora (string as_mensaje, string as_status)
public function string recupera_fecha ()
public function integer caracteres_especiales (ref string as_cadena)
end prototypes

public function integer conecta_bd ();//
//
////SQLCA.database = "controlescolar_bd"
////SQLCA.dbms = "SYC Sybase System 10" 
////SQLCA.dbparm = "OJSyntax='PB'"
////SQLCA.logid = "sie"
////SQLCA.logpass = "desarrollo" 
////SQLCA.servername = "SYBCESdes" 
//
//
//SQLCA.database = "controlescolar_bd"
//SQLCA.dbms = "ODBC" 
//SQLCA.dbparm = "ConnectString='DSN=SQLEXTDES;UID=sa;PWD=desarrollo'"
//SQLCA.logid = "sa"
//SQLCA.logpass = "desarrollo" 
//SQLCA.servername = "uiaw12dbdes02v\SQLEXTDES"
//
//
//CONNECT USING(SQLCA);
//
//
RETURN 0 
//
//
//
//
//
//////PBDOM_ELEMENT pbdom_elem_1
//////PBDOM_ELEMENT pbdom_elem_2
//////PBDOM_ELEMENT pbdom_elem_3
//////PBDOM_ELEMENT pbdom_elem_root
////PBDOM_DOCUMENT pbdom_doc1
////
//////pbdom_elem_1 = Create PBDOM_ELEMENT
//////pbdom_elem_2 = Create PBDOM_ELEMENT
//////pbdom_elem_3 = Create PBDOM_ELEMENT
//////
//////pbdom_elem_1.SetName("pbdom_elem_1")
//////pbdom_elem_2.SetName("pbdom_elem_2")
//////pbdom_elem_3.SetName("pbdom_elem_3")
//////
//////
//////pbdom_elem_1.AddContent(pbdom_elem_2)
//////pbdom_elem_2.AddContent(pbdom_elem_3)
//////
////pbdom_doc1 = CREATE PBDOM_DOCUMENT 
//////pbdom_doc1.NewDocument("Root_Element_From_Doc_1")
//////pbdom_elem_root = pbdom_doc1.GetRootElement()
//////
//////pbdom_elem_root.AddContent(pbdom_elem_1)
//////
//////pbdom_doc1.savedocument("C:\XML\D2L\Ejemplos\ejemplo1.xml")
////
////pbdom_builder pbdom_builder_new
////
////string Xml_str
////Xml_str = "<Root_Element_From_Doc_1>"
////Xml_str += "   <pbdom_elem_1>"
////Xml_str += "	   <pbdom_elem_2>"
////Xml_str += "		   <pbdom_elem_3/>"
////Xml_str += "		</pbdom_elem_2>"
////Xml_str += "	</pbdom_elem_1>"
////Xml_str += "</Root_Element_From_Doc_1>"
////
////pbdom_builder_new= Create PBDOM_BUILDER
////pbdom_doc1 = pbdom_builder_new.BuildFromString(Xml_str)
////pbdom_doc1.savedocument("C:\XML\D2L\Ejemplos\ejemplo1.xml")
////
////RETURN 0 
////
////
////
////
////
//////pbdom_builder          builder       
//////pbdom_document     document  
//////pbdom_element      root  
//////pbdom_element      ldom_childelements[]  
//////pbdom_attribute     ldom_effdate  
//////pbdom_attribute     ldom_expdate  
//////pbdom_attribute     ldom_aftertax  
//////pbdom_attribute     ldom_currency  
//////pbdom_element          base  
//////integer                    li_count, li_index  
//////string                         ls_message  
//////builder = CREATE PBDOM_BUILDER  
//////try  
//////    
//////     //Create a DOM document from the XML file  
//////     document = builder.BuildFromFile ( "document.xml" )   
//////       
//////     //Get a handle to the root element  
//////     root = document.GetRootElement()  
//////      document.GetElementsByTagName ( "Rate", ldom_childelements[] )  
//////       
//////     li_count = UpperBound ( ldom_childelements[] )  
//////     FOR li_index = 1 TO li_count  
//////          ldom_effdate = ldom_childelements[li_index].getattribute( "EffectiveDate" )  
//////          ldom_expdate = ldom_childelements[li_index].getattribute( "ExpireDate" )  
//////          base = ldom_childelements[li_index].getchildelement( "Base" )  
//////          ldom_aftertax = base.getattribute( "AmountAfterTax" )  
//////          ldom_currency = base.getattribute( "CurrencyCode" )  
//////          ls_message += "From " + ldom_effdate.gettext( ) + " to " + ldom_expdate.gettext() + " the rate is " + ldom_aftertax.gettext() + " " + ldom_currency.gettext() + "~r~n"  
//////     NEXT  
//////       
//////     MessageBox ( "Rates", ls_message )  
//////       
//////catch ( PBDOM_Exception except )  
//////     MessageBox ("Exception Occurred", except.Text )  
//////finally  
//////     Destroy builder  
//////end try  
//////
//////RETURN 0
//////
////////
////////PBDOM_ELEMENT pbdom_elem_1
////////PBDOM_ELEMENT pbdom_elem_2
////////PBDOM_ELEMENT pbdom_elem_3
////////PBDOM_ELEMENT pbdom_elem_root
////////PBDOM_DOCUMENT pbdom_doc1
////////
////////
////////pbdom_elem_1 = Create PBDOM_ELEMENT
////////pbdom_elem_2 = Create PBDOM_ELEMENT
////////pbdom_elem_3 = Create PBDOM_ELEMENT
////////
////////pbdom_elem_1.SetName("pbdom_elem_1")
////////pbdom_elem_2.SetName("pbdom_elem_2")
////////pbdom_elem_3.SetName("pbdom_elem_3")
////////
////////pbdom_elem_1.AddContent(pbdom_elem_2)
////////pbdom_elem_2.AddContent(pbdom_elem_3)
////////
////////pbdom_doc1.NewDocument("Root_Element_From_Doc_1")
////////pbdom_elem_root = pbdom_doc1.GetRootElement()
////////
////////
////////
////////pbdom_elem_root.AddContent(pbdom_elem_1)
////////
////////
////////
////////
////////
////////
////////RETURN 0
////////
////////
////////
////////
////////
////////
////////
end function

public function integer desconectabd ();
DISCONNECT USING SQLCA; 

RETURN 0 

end function

public function integer carga_estructuras ();// Función de llenado de estructuras de 

ids_archivo = CREATE DATASTORE  
ids_archivo.DATAOBJECT = "dw_archivo"
ids_archivo.SETTRANSOBJECT(SQLCA)
ie_error = ids_archivo .RETRIEVE()
IF ie_error < 0 THEN 
	is_error = "Se produjo un error al cargar archivos." + SQLCA.SQLERRTEXT
	RETURN -1
END IF

ids_archivo_dato = CREATE DATASTORE  
ids_archivo_dato.DATAOBJECT = "dw_archivo_dato"
ids_archivo_dato.SETTRANSOBJECT(SQLCA)
ie_error = ids_archivo_dato.RETRIEVE()
IF ie_error < 0 THEN 
	is_error = "Se produjo un error al cargar archivos." + SQLCA.SQLERRTEXT
	RETURN -1	
END IF

ids_archivo_query = CREATE DATASTORE  
ids_archivo_query.DATAOBJECT = "dw_archivo_query"
ids_archivo_query.SETTRANSOBJECT(SQLCA)
ie_error = ids_archivo_query.RETRIEVE()
IF ie_error < 0 THEN 
	is_error = "Se produjo un error al cargar archivos." + SQLCA.SQLERRTEXT
	RETURN -1	
END IF

//ids_archivo_query_sumuia = CREATE DATASTORE  
//ids_archivo_query_sumuia.DATAOBJECT = "dw_archivo_query"
//ids_archivo_query_sumuia.SETTRANSOBJECT(SQLCA)
//ie_error = ids_archivo_query_sumuia.RETRIEVE()
//IF ie_error < 0 THEN 
//	is_error = "Se produjo un error al cargar archivos." + SQLCA.SQLERRTEXT
//	RETURN -1	
//END IF


ids_archivo_seccion = CREATE DATASTORE  
ids_archivo_seccion.DATAOBJECT = "dw_archivo_seccion"
ids_archivo_seccion.SETTRANSOBJECT(SQLCA)
ie_error = ids_archivo_seccion.RETRIEVE() 
IF ie_error < 0 THEN 
	is_error = "Se produjo un error al cargar archivos." + SQLCA.SQLERRTEXT
	RETURN -1	
END IF

ids_archivo_xml = CREATE DATASTORE  
ids_archivo_xml.DATAOBJECT = "dw_archivo_xml"
ids_archivo_xml.SETTRANSOBJECT(SQLCA)
ie_error = ids_archivo_xml.RETRIEVE()
IF ie_error < 0 THEN 
	is_error = "Se produjo un error al cargar archivos." + SQLCA.SQLERRTEXT
	RETURN -1	
END IF

ids_archivo_xml_seccion = CREATE DATASTORE  
ids_archivo_xml_seccion.DATAOBJECT = "dw_archivo_xml"
ids_archivo_xml_seccion.SETTRANSOBJECT(SQLCA)
ie_error = ids_archivo_xml_seccion.RETRIEVE()
IF ie_error < 0 THEN 
	is_error = "Se produjo un error al cargar archivos." + SQLCA.SQLERRTEXT
	RETURN -1	
END IF

ids_archivo_xml_seccion2 = CREATE DATASTORE 
ids_archivo_xml_seccion2.DATAOBJECT = "dw_archivo_xml"
ids_archivo_xml_seccion.ROWSCOPY(1, ids_archivo_xml_seccion.ROWCOUNT(), PRIMARY!, ids_archivo_xml_seccion2, 1, PRIMARY!) 


RETURN 0




end function

public subroutine genera_xml ();INTEGER le_pos_archivo
STRING ls_archivo
LONG  ll_archivo, ll_archivo_alldone

STRING ls_ruta
STRING ls_nombre_archivo 

LONG ll_pos_xml_ciclo
LONG ll_pos_xml, ll_ttl_xml
LONG ll_pos_datos, ll_ttl_datos
STRING ls_segmento_xml
LONG ll_seccion, ll_seccion_ant
//STRING ls_dato_rompimiento 
INTEGER le_dato_rompimiento 
STRING ls_valor_romp, ls_valor_romp_ant   
STRING ls_valor_romp_det, ls_valor_romp_ant_det 
LONG ll_seccion_det, ll_seccion_ant_det 
STRING ls_subdetalle[], ls_fragmentoxml
LONG ll_pos_fragmento
STRING ls_fecha_ejec


// Se llenan los Datastores con las estructuras de los XML
carga_estructuras() 

// Se hace ciclo sobre cada uno de los archivos.
FOR le_pos_archivo = 1 TO ids_archivo.ROWCOUNT() 

	// Se toma la información del archivo que se genera 
	ls_archivo = ids_archivo.GETITEMSTRING(le_pos_archivo, "id_doc") 
	ls_ruta = ids_archivo.GETITEMSTRING(le_pos_archivo, "ruta")  
	ls_nombre_archivo = ids_archivo.GETITEMSTRING(le_pos_archivo, "nombre_archivo")  

	// *******ELIMINAR ESTE IF
//	IF ls_archivo = "template" THEN 
	// *******ELIMINAR ESTE IF

	
	// Se carga la información del archivo y se filtran los demás DS de estructuras.
	carga_informacion_archivo(ls_archivo)  
	
	// 16/02/2018  Se agrega para que no genere archivos vacios.
	IF ids_archivo_datos.ROWCOUNT() <= 0 THEN 
		CONTINUE
	END IF
	// 16/02/2018  Se agrega para que no genere archivos vacios.
	
	// Recupera fecha de ejecución		
	ls_fecha_ejec = recupera_fecha() 
	IF ISNULL(ls_fecha_ejec ) THEN ls_fecha_ejec  = ""  
		
	// Se abre archivo
	ll_archivo = FileOpen(ls_ruta + ls_nombre_archivo + "_" + ls_fecha_ejec + ".xml", LineMode!, Write! , LockWrite! , Replace!, EncodingUTF8!) 
	
	// Ciclo sobre cada registro de datos 
	ll_ttl_datos = ids_archivo_datos.ROWCOUNT() 
	ll_ttl_xml = ids_archivo_xml.ROWCOUNT() 
	
	// Se apunta al primer registro de los datos del archivo 
	ll_pos_datos = 1
	
	/*REGISTRO*/
	DO WHILE ll_pos_datos <= ll_ttl_datos 
	
		ll_pos_xml = 1 
			
		/* XML */
		DO WHILE ll_pos_xml <= ll_ttl_xml  
			
			// Se verifica si se termina el ciclo del XML y aún hay datos disponibles
			IF ll_pos_xml = ll_ttl_xml AND ll_pos_datos <= ll_ttl_datos THEN 
				ll_pos_xml = 1 
			ELSEIF ll_pos_datos > ll_ttl_datos THEN 
				EXIT 
			END IF
			
			
			// Se recupera la sección 
			ll_seccion = ids_archivo_xml.GETITEMNUMBER(ll_pos_xml, "seccion") 
			IF ll_seccion <> ll_seccion_ant THEN 
				ll_seccion_ant = ll_seccion 
			END IF
			
			// Si se trata de la raíz se inserta el inicio del archivo o el cierre 
			IF (ll_seccion = 0 AND ll_pos_datos = 1 ) OR (ll_seccion = 100 AND ll_pos_datos = ll_ttl_datos) THEN   
				
				ls_segmento_xml = ids_archivo_xml.GETITEMSTRING(ll_pos_xml, "sintaxis")   
				FILEWRITE(ll_archivo, ls_segmento_xml) 
				ll_pos_xml ++ 
				// NOTA: Esta sección no incrementa el contador de dato, no implica el procesamiento de un nuevo registro
				CONTINUE 
			// Si es sección 0 en cualquier otra iteración no se toma en cuenta	
			ELSEIF ll_seccion = 0 THEN 
					ll_pos_xml ++
					CONTINUE
			ELSE
				
				//  Se filtra el datastore para la sección actual. 
				ids_archivo_xml_seccion.SETFILTER("seccion >= " + STRING(ll_seccion) + " AND seccion <> 100 AND id_doc = '" + ls_archivo + "'")  
				ids_archivo_xml_seccion.FILTER() 
				ids_archivo_xml_seccion.SETSORT("orden asc")
				ids_archivo_xml_seccion.SORT() 
			
				// Toma el dato de rompimiento de la sección actual 
				le_dato_rompimiento = dato_rompimiento(ll_seccion) 
		
				//ls_valor_romp = ids_archivo_datos.GETITEMSTRING(ll_pos_datos, ls_dato_rompimiento)  
				ls_valor_romp = ids_archivo_datos.GETITEMSTRING(ll_pos_datos, le_dato_rompimiento)  
				ls_valor_romp_ant = ls_valor_romp 					
				
				if ls_valor_romp = "90318" then  
					ls_valor_romp = ls_valor_romp
				end if
				
				
				//// Toma el segmento de archivo XML 
				//ls_segmento_xml = ids_archivo_xml.GETITEMSTRING(ll_pos_xml, "sintaxis")  
			
				ll_pos_xml_ciclo = 1 
				
				// Se hace ciclo sobre la estructura filtrada de XML 
				DO 
					
					// Se insertan los registros en el archivo 
					FOR ll_pos_xml_ciclo = 1 TO ids_archivo_xml_seccion.ROWCOUNT() 
					
						ls_segmento_xml = ids_archivo_xml_seccion.GETITEMSTRING(ll_pos_xml_ciclo, "sintaxis")  
						ll_seccion_det = ids_archivo_xml_seccion.GETITEMNUMBER(ll_pos_xml_ciclo, "seccion")

						// Si hay un cambio de sección 
						IF ll_seccion_det <> ll_seccion THEN 
							
							// Se llama la función que inserta el detalle de esta sección.
							genera_sub_detalle( ll_seccion_det, ll_pos_datos, ls_archivo, le_dato_rompimiento, ls_valor_romp, ls_subdetalle[])
							// Se inserta el detalle generado						 
							FOR ll_pos_fragmento = 1 TO UPPERBOUND(ls_subdetalle) 
								ls_fragmentoxml = ls_subdetalle[ll_pos_fragmento] 
								FILEWRITE(ll_archivo, ls_fragmentoxml)								
							NEXT
							
							// Se incrementa el apuntador de posición hasta el siguiente cambio de sección 
							DO 
								 
								IF ll_pos_xml_ciclo < ids_archivo_xml_seccion.ROWCOUNT() THEN 
									// Se toma la siguiente posición para determinar si hay un cambio de sección 
									ll_seccion_det = ids_archivo_xml_seccion.GETITEMNUMBER((ll_pos_xml_ciclo + 1), "seccion")									
									IF ll_seccion_det <> ll_seccion THEN 
										ll_pos_xml_ciclo ++
									ELSE
										ll_seccion_det = ll_seccion
									END IF
								END IF 
								
							LOOP WHILE ll_seccion_det <> ll_seccion 	
							
							//*********************************
							
						ELSE
					
							// Se revisa si la línea del archivo llea algpún dato 
							reemplaza_dato(ls_segmento_xml, ll_pos_datos) 
							FILEWRITE(ll_archivo, ls_segmento_xml) 					
							
							IF POS(ls_segmento_xml, "90318") > 0 THEN 
								ls_segmento_xml = ls_segmento_xml
							END IF
							
						END IF
						
					NEXT
					
					// Se incrementa el apuntador de la posición del contador de datos 
					ll_pos_datos ++ 					
			
					ls_valor_romp = ids_archivo_datos.GETITEMSTRING(ll_pos_datos, le_dato_rompimiento) 
			
				// Se verifica el dato de rompimiento 
				LOOP WHILE ls_valor_romp = ls_valor_romp_ant 
				
				// Se incrementa el apuntador de posición hasta el siguiente cambio de sección 
				DO 
					ll_pos_xml ++ 
					IF ll_pos_xml <= ll_ttl_xml THEN 
						ll_seccion = ids_archivo_xml.GETITEMNUMBER(ll_pos_xml, "seccion") 
						IF ll_seccion = 100 AND  ll_pos_datos > ll_ttl_datos THEN 
							ls_segmento_xml = ids_archivo_xml.GETITEMSTRING(ll_pos_xml, "sintaxis")  
							FILEWRITE(ll_archivo, ls_segmento_xml) 												
							// Se termina el ciclo
							ll_seccion_ant = 0											
						END IF
					ELSE 
						// Se termina el ciclo
						ll_seccion_ant = 0				
					END IF 
				LOOP WHILE (ll_seccion = ll_seccion_ant	) OR (ll_seccion = (ll_seccion_ant + 1))
				
				
			END IF
			
		/* XML */	
		LOOP 
	
	/* REGISTRO */
	LOOP	

	//****** ELIMINAR ESTE END IF 
//	END IF
	//****** ELIMINAR ESTE END IF 

	
	FILECLOSE(ll_archivo)
	ll_archivo_alldone = FileOpen(ls_ruta + ls_nombre_archivo +  "_" + ls_fecha_ejec + ".alldone", LineMode!, Write! , LockWrite! , Replace!, EncodingUTF8!) 
	FILECLOSE(ll_archivo_alldone)

NEXT 

// Se inserta registro en bitacora.
inserta_bitacora("Archivos generados correctamente", "E") 




















//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


//INTEGER le_pos_archivo
//STRING ls_archivo
//LONG  ll_archivo
//
//STRING ls_ruta
//STRING ls_nombre_archivo 
//
//LONG ll_pos_xml_ciclo
//LONG ll_pos_xml, ll_ttl_xml
//LONG ll_pos_datos, ll_ttl_datos
//STRING ls_segmento_xml
//LONG ll_seccion, ll_seccion_ant
////STRING ls_dato_rompimiento 
//INTEGER le_dato_rompimiento 
//STRING ls_valor_romp  
//STRING ls_valor_romp_ant 
//
//
//// Se llenan los Datastores con las estructuras de los XML
//carga_estructuras() 
//
//// Se hace ciclo sobre cada uno de los archivos.
//FOR le_pos_archivo = 1 TO ids_archivo.ROWCOUNT() 
//
//	// Se toma la información del archivo que se genera 
//	ls_archivo = ids_archivo.GETITEMSTRING(le_pos_archivo, "id_doc") 
//	ls_ruta = ids_archivo.GETITEMSTRING(le_pos_archivo, "ruta")  
//	ls_nombre_archivo = ids_archivo.GETITEMSTRING(le_pos_archivo, "nombre_archivo")  
//
//	// *******ELIMINAR ESTE IF
//	IF ls_archivo = "memberships" THEN 
//	// *******ELIMINAR ESTE IF
//
//	
//	// Se carga la información del archivo y se filtran los demás DS de estructuras.
//	carga_informacion_archivo(ls_archivo)  
//		
//	// Se abre archivo
//	ll_archivo = FileOpen(ls_ruta + ls_nombre_archivo + ".xml", LineMode!, Write! , LockWrite! , Replace!) 
//	
//	// Ciclo sobre cada registro de datos 
//	ll_ttl_datos = ids_archivo_datos.ROWCOUNT() 
//	ll_ttl_xml = ids_archivo_xml.ROWCOUNT() 
//	
//	// Se apunta al primer registro de los datos del archivo 
//	ll_pos_datos = 1
//	
//	/*REGISTRO*/
//	DO WHILE ll_pos_datos <= ll_ttl_datos 
//	
//		ll_pos_xml = 1 
//			
//		/* XML */
//		DO WHILE ll_pos_xml <= ll_ttl_xml  
//			
//			// Se verifica si se termina el ciclo del XML y aún hay datos disponibles
//			IF ll_pos_xml = ll_ttl_xml AND ll_pos_datos <= ll_ttl_datos THEN 
//				ll_pos_xml = 1 
//			ELSEIF ll_pos_datos > ll_ttl_datos THEN 
//				EXIT 
//			END IF
//			
//			
//			// Se recupera la sección 
//			ll_seccion = ids_archivo_xml.GETITEMNUMBER(ll_pos_xml, "seccion") 
//			IF ll_seccion <> ll_seccion_ant THEN 
//				ll_seccion_ant = ll_seccion 
//			END IF
//			
//			// Si se trata de la raíz se inserta el inicio del archivo o el cierre 
//			IF (ll_seccion = 0 AND ll_pos_datos = 1 ) OR (ll_seccion = 100 AND ll_pos_datos = ll_ttl_datos) THEN   
//				
//				ls_segmento_xml = ids_archivo_xml.GETITEMSTRING(ll_pos_xml, "sintaxis")   
//				FILEWRITE(ll_archivo, ls_segmento_xml) 
//				ll_pos_xml ++ 
//				// NOTA: Esta sección no incrementa el contador de dato, no implica el procesamiento de un nuevo registro
//				CONTINUE 
//			// Si es sección 0 en cualquier otra iteración no se toma en cuenta	
//			ELSEIF ll_seccion = 0 THEN 
//					ll_pos_xml ++
//					CONTINUE
//			ELSE
//				
//				//  Se filtra el datastore para la sección actual. 
//				ids_archivo_xml_seccion.SETFILTER("seccion = " + STRING(ll_seccion) + " AND id_doc = '" + ls_archivo + "'")  
//				ids_archivo_xml_seccion.FILTER() 
//				ids_archivo_xml_seccion.SETSORT("orden asc")
//				ids_archivo_xml_seccion.SORT() 
//			
//				// Toma el dato de rompimiento de la sección actual 
//				le_dato_rompimiento = dato_rompimiento(ll_seccion) 
//		
//				//ls_valor_romp = ids_archivo_datos.GETITEMSTRING(ll_pos_datos, ls_dato_rompimiento)  
//				ls_valor_romp = ids_archivo_datos.GETITEMSTRING(ll_pos_datos, 1)  
//				ls_valor_romp_ant = ls_valor_romp 					
//				
//				//// Toma el segmento de archivo XML 
//				//ls_segmento_xml = ids_archivo_xml.GETITEMSTRING(ll_pos_xml, "sintaxis")  
//			
//				ll_pos_xml_ciclo = 1 
//				// Se hace ciclo sobre la estructura filtrada de XML 
//				DO 
//					
//					// Se insertan los registros en el archivo 
//					FOR ll_pos_xml_ciclo = 1 TO ids_archivo_xml_seccion.ROWCOUNT() 
//					
//						ls_segmento_xml = ids_archivo_xml_seccion.GETITEMSTRING(ll_pos_xml_ciclo, "sintaxis")  
//					
//						// Se revisa si la línea del archivo llea algpún dato 
//						reemplaza_dato(ls_segmento_xml, ll_pos_datos) 
//						
//						FILEWRITE(ll_archivo, ls_segmento_xml) 					
//						
//					NEXT
//					
//					// Se incrementa el apuntador de la posición del contador de datos 
//					ll_pos_datos ++ 					
//			
//					ls_valor_romp = ids_archivo_datos.GETITEMSTRING(ll_pos_datos, le_dato_rompimiento) 
//			
//				// Se verifica el dato de rompimiento 
//				LOOP WHILE ls_valor_romp = ls_valor_romp_ant 
//				
//				// Se incrementa el apuntador de posición hasta el siguiente cambio de sección 
//				DO 
//					ll_pos_xml ++ 
//					IF ll_pos_xml <= ll_ttl_xml THEN 
//						ll_seccion = ids_archivo_xml.GETITEMNUMBER(ll_pos_xml, "seccion") 
//						IF ll_seccion = 100 AND  ll_pos_datos > ll_ttl_datos THEN 
//							ls_segmento_xml = ids_archivo_xml.GETITEMSTRING(ll_pos_xml, "sintaxis")  
//							FILEWRITE(ll_archivo, ls_segmento_xml) 												
//							// Se termina el ciclo
//							ll_seccion_ant = 0											
//						END IF
//					ELSE 
//						// Se termina el ciclo
//						ll_seccion_ant = 0				
//					END IF 
//				LOOP WHILE ll_seccion = ll_seccion_ant	
//				
//				
//			END IF
//			
//		/* XML */	
//		LOOP 
//	
//	/* REGISTRO */
//	LOOP	
//
//	//****** ELIMINAR ESTE END IF 
//	END IF
//	//****** ELIMINAR ESTE END IF 
//
//	
//	FILECLOSE(ll_archivo)
//
//NEXT 
//
//
//
//
//
//
//
//
//
//
//
end subroutine

public function integer carga_informacion_archivo (string as_id_archivo);STRING ls_query
STRING ls_segmento
INTEGER le_pos
INTEGER le_error
STRING ls_error, ls_sintaxis 


// Función que carga la información con la que se genera el archivo.
ids_archivo_query.SETFILTER("id_doc = '" + as_id_archivo + "'") 
ids_archivo_query.FILTER() 
ids_archivo_query.SETSORT("orden asc") 
ids_archivo_query.SORT() 

// Se extrae el query.
FOR le_pos = 1 TO ids_archivo_query.ROWCOUNT() 
	
	ls_segmento = ids_archivo_query.GETITEMSTRING(le_pos, "sintaxis") 
	IF ISNULL(ls_segmento) THEN ls_segmento = "" 
	
	ls_query = 	ls_query + " " + ls_segmento 

NEXT 

// Se crea el datatstore con la información del archivo. 
ids_archivo_datos = CREATE DATASTORE 

ls_sintaxis = SQLCA.SyntaxFromSQL(ls_query, "style(type=grid)", ref ls_error)
ids_archivo_datos.Create(ls_sintaxis, ref ls_error) 

IF Len(ls_error) > 0 THEN 
	ie_error = -1 
	is_error = ls_error 
	RETURN -1 
END IF

ids_archivo_datos.SETTRANSOBJECT(SQLCA) 
le_error = ids_archivo_datos.RETRIEVE() 
IF le_error < 0 THEN 
	
	
END IF

//**--** 
//// Se verifica si existe información complementaria del archivo de SUMUIA 
//ids_archivo_query_sumuia.SETFILTER("id_doc = '" + as_id_archivo + "A'") 
//ids_archivo_query_sumuia.FILTER() 
//ids_archivo_query_sumuia.SETSORT("orden asc") 
//ids_archivo_query_sumuia.SORT() 
//
//DATAWINDOW lds_archivo_datos_comp
//lds_archivo_datos_comp = CREATE DATAWINDOW 
//lds_archivo_datos_comp.Create(ls_sintaxis, ref ls_error) 
//
//// Se limpia la cadena del query anterior
//ls_query = ""
//
//// Se extrae el query de datos complementarios.
//FOR le_pos = 1 TO ids_archivo_query_sumuia.ROWCOUNT() 
//	ls_segmento = ids_archivo_query_sumuia.GETITEMSTRING(le_pos, "sintaxis") 
//	IF ISNULL(ls_segmento) THEN ls_segmento = "" 
//	ls_query = 	ls_query + " " + ls_segmento 
//NEXT 
//
//lds_archivo_datos_comp.MODIFY("Datawindow.Table.Select = '" + ls_query + "'")
//lds_archivo_datos_comp.SETTRANSOBJECT(SQLCA)
//le_error = lds_archivo_datos_comp.RETRIEVE() 
//IF le_error < 0 THEN 
//	
//	
//END IF 

//**--**

// Se aplican filtros a los demás DS
ids_archivo_dato.SETFILTER("id_doc = '" + as_id_archivo + "'")  
ids_archivo_dato.FILTER()  
ids_archivo_dato.SETSORT("orden asc")  
ids_archivo_dato.SORT()  

ids_archivo_seccion.SETFILTER("id_doc = '" + as_id_archivo + "'")  
ids_archivo_seccion.FILTER()  
ids_archivo_seccion.SETSORT("orden asc")  
ids_archivo_seccion.SORT()  

ids_archivo_xml.SETFILTER("id_doc = '" + as_id_archivo + "'")  
ids_archivo_xml.FILTER()  
ids_archivo_xml.SETSORT("orden asc")  
ids_archivo_xml.SORT()   


RETURN 0




end function

public function integer reemplaza_dato (ref string as_segmento_xml, long al_pos_datos);
INTEGER le_pos, le_pos_dato 
INTEGER le_pos_fin
STRING ls_dato  
STRING ls_valor_dato
INTEGER le_num_columna

DO 

	le_pos = POS(as_segmento_xml, "<¿@?>") 
	IF le_pos = 0 THEN RETURN 0 
	
	le_pos_fin = POS(as_segmento_xml, "<¿@?>", le_pos + 1) 
	IF 	le_pos_fin = 0 THEN RETURN 0 
	
	// Se toma el segmento de cadena entre las dos marcas 
	ls_dato = MID(as_segmento_xml, (le_pos + 5), (le_pos_fin - (le_pos + 5))) 
	
	// Se busca el número de columna del dato
	le_pos_dato = ids_archivo_dato.FIND("dato = '" + ls_dato + "'", 0, ids_archivo_dato.ROWCOUNT() + 1)  
	IF le_pos_dato > 0 THEN 
		le_num_columna = ids_archivo_dato.GETITEMNUMBER(le_pos_dato, "orden") 
		IF ISNULL(le_num_columna) THEN le_num_columna = 0 
	END IF
	IF le_num_columna = 0 THEN 
		ie_error = -1
		is_error = "Error al realizar el reemplazo de datos." 
	END IF

	// Se recupera el dato que se sustituye 
	ls_valor_dato = ids_archivo_datos.GETITEMSTRING(al_pos_datos, le_num_columna)  
	IF ISNULL(ls_valor_dato ) THEN ls_valor_dato  = "" 
	
	// Se llama función de reemplazo de caracteres especiales.
	caracteres_especiales(ls_valor_dato) 
	
	// Se reemplaza el dato
	as_segmento_xml = REPLACE(as_segmento_xml, le_pos, (le_pos_fin - (le_pos - 5)), ls_valor_dato) 


	le_pos = 0
	le_pos_fin = 0
	
	le_pos = POS(as_segmento_xml, "<¿@?>")  
	IF le_pos = 0 THEN RETURN 0 
	

LOOP WHILE le_pos > 0  

RETURN 0








//
//INTEGER le_pos, le_pos_dato 
//INTEGER le_pos_fin
//STRING ls_dato  
//STRING ls_valor_dato
//INTEGER le_num_columna
//
//DO 
//
//	le_pos = POS(as_segmento_xml, "@@") 
//	IF le_pos = 0 THEN RETURN 0 
//	
//	le_pos_fin = POS(as_segmento_xml, "@@", le_pos + 1) 
//	IF 	le_pos_fin = 0 THEN RETURN 0 
//	
//	// Se toma el segmento de cadena entre las dos marcas 
//	ls_dato = MID(as_segmento_xml, (le_pos + 2), (le_pos_fin - (le_pos + 2))) 
//	
//	// Se busca el número de columna del dato
//	le_pos_dato = ids_archivo_dato.FIND("dato = '" + ls_dato + "'", 0, ids_archivo_dato.ROWCOUNT() + 1)  
//	IF le_pos_dato > 0 THEN 
//		le_num_columna = ids_archivo_dato.GETITEMNUMBER(le_pos_dato, "orden") 
//		IF ISNULL(le_num_columna) THEN le_num_columna = 0 
//	END IF
//	IF le_num_columna = 0 THEN 
//		ie_error = -1
//		is_error = "Error al realizar el reemplazo de datos." 
//	END IF
//
//	// Se recupera el dato que se sustituye 
//	ls_valor_dato = ids_archivo_datos.GETITEMSTRING(al_pos_datos, le_num_columna)  
//	IF ISNULL(ls_valor_dato ) THEN ls_valor_dato  = "" 
//	
//	// Se reemplaza el dato
//	as_segmento_xml = REPLACE(as_segmento_xml, le_pos, (le_pos_fin - (le_pos - 2)), ls_valor_dato) 
//
//
//	le_pos = 0
//	le_pos_fin = 0
//	
//	le_pos = POS(as_segmento_xml, "@@")  
//	IF le_pos = 0 THEN RETURN 0 
//	
//
//LOOP WHILE le_pos > 0  
//
//RETURN 0
//

end function

public function integer dato_rompimiento (integer ae_id_seccion);

STRING ls_cadena_busqueda 
INTEGER le_posicion 
STRING ls_dato
INTEGER le_orden_dato


ls_dato = "" 
ls_cadena_busqueda = "seccion = " + STRING(ae_id_seccion)  
le_posicion = ids_archivo_seccion.FIND(ls_cadena_busqueda, 0, ids_archivo_seccion.ROWCOUNT() + 1)  

IF le_posicion > 0 THEN 
	ls_dato = ids_archivo_seccion.GETITEMSTRING(le_posicion, "dato_base")  
	le_orden_dato = ids_archivo_seccion.GETITEMNUMBER(le_posicion, "orden_dato")  
	IF ISNULL(ls_dato) THEN ls_dato = "" 
	IF ISNULL(le_orden_dato) THEN le_orden_dato = 0 
END IF 

RETURN le_orden_dato 


end function

public function integer genera_sub_detalle (long al_seccion_xml, ref long al_pos_datos, string as_archivo, integer ai_rompimiento_padre, string as_rompimiento_padre, ref string as_retorno[]);
STRING ls_rompimiento_padre 
STRING ls_segmento_xml 
LONG ll_pos, ll_ttl_xml 
LONG ll_pos_xml
STRING ls_lmp[]

as_retorno = ls_lmp

// Función que genera el detalle de una sección de archivo en particular. 
ids_archivo_xml_seccion2.SETFILTER("seccion = " + STRING(al_seccion_xml) + " AND id_doc = '" + as_archivo + "'")   
ids_archivo_xml_seccion2.FILTER()
ids_archivo_xml_seccion2.SETSORT("orden asc") 
ids_archivo_xml_seccion2.SORT() 

ll_ttl_xml = ids_archivo_xml_seccion2.ROWCOUNT() 

// Se toma el dato de rempimiento actual
ls_rompimiento_padre = as_rompimiento_padre 

DO
	
	// Se hace ciclo para insertar todo este nivel.  
	FOR ll_pos = 1 TO ll_ttl_xml 
		ls_segmento_xml = ids_archivo_xml_seccion2.GETITEMSTRING(ll_pos, "sintaxis")   
		reemplaza_dato(ls_segmento_xml, al_pos_datos)  
		ll_pos_xml++
		as_retorno[ll_pos_xml] = ls_segmento_xml
	NEXT
	
	al_pos_datos++
	ls_rompimiento_padre = ids_archivo_datos.GETITEMSTRING(al_pos_datos, ai_rompimiento_padre)   

LOOP WHILE as_rompimiento_padre = ls_rompimiento_padre 

al_pos_datos --

RETURN 0




end function

public function integer inserta_bitacora (string as_mensaje, string as_status);
STRING ls_hora_ejecucion 
DATETIME l_dt_fecha_ejecucion
LONG ll_id

// Recupera la fecha del servidor.
SELECT getdate() 
INTO :l_dt_fecha_ejecucion 
FROM activacion
WHERE tipo_periodo = :gs_tipo_periodo
USING SQLCA; 

ls_hora_ejecucion = STRING(TIME(DATE(l_dt_fecha_ejecucion)), "hh:mm")  

// recupera el id consecutivo.
SELECT MAX(id) 
INTO :ll_id 
FROM archivo_bitacora
USING SQLCA; 
IF ISNULL(ll_id) THEN ll_id = 0
// Se genera el siguiente folio. 
ll_id++ 

COMMIT USING SQLCA;

// Se inserta la bitácora. 
INSERT INTO archivo_bitacora(id, fecha_ejecucion, hora_ejecucion, estatus, mensaje)
VALUES (:ll_id, :l_dt_fecha_ejecucion, :ls_hora_ejecucion, :as_status, :as_mensaje) 
USING SQLCA; 
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al insrtar la bitácora de ejecuión. " + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA; 
ELSE
	COMMIT USING SQLCA;
END IF 


RETURN 0 







end function

public function string recupera_fecha (); 
 DATETIME ldt_fecha_server 
 STRING ls_fecha_ret
 
SELECT getdate() 
INTO :ldt_fecha_server 
FROM archivo_hora 
USING SQLCA;
IF SQLCA.SQLCODE < 0 OR SQLCA.SQLCODE = 100 THEN 
	ls_fecha_ret = "1900-01-01"
ELSE
	ls_fecha_ret = STRING(DATE(ldt_fecha_server), "yyyy-mm-dd")	
END IF



RETURN ls_fecha_ret  





 
end function

public function integer caracteres_especiales (ref string as_cadena);INTEGER lepos
INTEGER lelen

STRING ls_salida
STRING ls_char


lelen = LEN(as_cadena) 

FOR lepos = 1 TO lelen 

	// Ser toma el primer caracter de la cadena 
	ls_char = LEFT(as_cadena, 1) 

	// Se agrega el caracter a la cadena de salida 
	CHOOSE CASE ls_char 
		CASE "<" 
			ls_char = "&lt;"
		CASE "&"
			ls_char = "&amp;"
		CASE ">"
			ls_char = "&gt;"
		CASE '"'
			ls_char = "&quot;"
		CASE "'"
			ls_char = "&apos;"
	END CHOOSE
	
	ls_salida = ls_salida + ls_char 
	
	// Se recorta la cadena
	as_cadena = RIGHT(as_cadena, LEN(as_cadena) - 1)
	
NEXT 

// Se pasa la cadena modificada a la cadena de salida. 
as_cadena = ls_salida

RETURN 0 




end function

on uo_genera_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_genera_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;conecta_bd( )
end event

event destructor;
//desconectabd( )
end event

