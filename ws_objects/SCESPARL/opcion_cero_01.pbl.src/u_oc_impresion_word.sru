$PBExportHeader$u_oc_impresion_word.sru
forward
global type u_oc_impresion_word from u_oc
end type
end forward

global type u_oc_impresion_word from u_oc
end type
global u_oc_impresion_word u_oc_impresion_word

forward prototypes
public function long of_inserta_folio_documento_tit (long al_cuenta, integer ai_cve_documento)
public function integer of_obten_arreglo_de_string (string as_cadena, ref string as_arreglo_cadenas[])
public function integer of_imprime_documento (long al_valor, long al_cve_documento, string as_columnas_marcas[], string as_query_definicion, boolean ab_permite_edicion, boolean ab_en_sitio)
public function integer of_imprime_documento (long al_cve_documento, long al_valor, boolean ab_permite_edicion, boolean ab_en_sitio)
public function integer of_imprime_documento (long al_cve_documento, string as_valor_01[], boolean ab_permite_edicion, boolean ab_en_sitio)
end prototypes

public function long of_inserta_folio_documento_tit (long al_cuenta, integer ai_cve_documento);//Función que registra el documento generado
//
//of_inserta_folio_documento_tit
//
//Parámetros:		al_cuenta		
//						ai_cve_documento

int li_codigo_sql, li_cve_documento
long ll_cuenta, ll_max_folio, ll_folio_siguiente
string ls_carrera, ls_nivel, ls_mensaje_sql, ls_sexo, ls_mensaje_aux
boolean 	lb_nueva_insercion 


gtr_sce.AutoCommit = true
lb_nueva_insercion = false
	
ll_cuenta = al_cuenta
li_cve_documento = ai_cve_documento

SELECT max(dbo.folio_documento_tit.folio)
INTO	:ll_max_folio
FROM	dbo.folio_documento_tit
USING gtr_sce;

ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	rollback using gtr_sce;
	MessageBox("Error al recuperar el folio máximo en la constancia:"+string(ai_cve_documento),  ls_mensaje_sql)
	return -1
elseif li_codigo_sql=100 then
	ll_max_folio = 0
else
end if

if isnull(ll_max_folio) then
	lb_nueva_insercion = true
	ll_max_folio = 0
end if

ll_folio_siguiente= ll_max_folio +1

if lb_nueva_insercion then

	ls_mensaje_aux="Error al insertar en folio_documento_tit en la constancia: "

	INSERT INTO	dbo.folio_documento_tit
	(dbo.folio_documento_tit.folio, dbo.folio_documento_tit.cuenta, dbo.folio_documento_tit.cve_documento)
	VALUES
	(:ll_folio_siguiente, :ll_cuenta, :li_cve_documento)
	USING gtr_sce;
else

	ls_mensaje_aux="Error al actualizar en folio_documento_tit en la constancia: "

	UPDATE dbo.folio_documento_tit
	SET dbo.folio_documento_tit.folio = :ll_folio_siguiente,
	    dbo.folio_documento_tit.cuenta = :ll_cuenta,
		 dbo.folio_documento_tit.cve_documento = :li_cve_documento
	FROM dbo.folio_documento_tit
	USING gtr_sce;
end if


ls_mensaje_sql=gtr_sce.SqlErrText
li_codigo_sql=gtr_sce.SqlCode

if li_codigo_sql = -1 then
	rollback using gtr_sce;
	MessageBox(ls_mensaje_aux+string(ai_cve_documento),  ls_mensaje_sql)
	return -1
else
	commit using gtr_sce;
end if


return ll_folio_siguiente


end function

public function integer of_obten_arreglo_de_string (string as_cadena, ref string as_arreglo_cadenas[]);//of_obten_arreglo_de_string
//	Recibe	as_cadena	string
//				as_arreglo_cadenas[] string
// Propósito
// 	Convierte el argumento as_cadena, el cual debe ser una lista separada por comas,
//		en un arreglo de cadenas en el argumento as_arreglo_cadenas[]


long ll_posicion_coma, ll_indice_arreglo
string ls_subcadena, ls_cadena

ls_cadena= as_cadena
ll_posicion_coma= POS(ls_cadena,",",1)
ll_indice_arreglo=1

DO WHILE ll_posicion_coma<>0 

	ls_subcadena = TRIM(MID(ls_cadena,1,ll_posicion_coma - 1))
	
	as_arreglo_cadenas[ll_indice_arreglo] = ls_subcadena
	ll_indice_arreglo= ll_indice_arreglo + 1
	ls_cadena = MID(ls_cadena,ll_posicion_coma + 1)
	ll_posicion_coma= POS(ls_cadena,",",1)
	IF isnull(ll_posicion_coma) THEN
		ll_posicion_coma= 0
	END IF	
LOOP

IF len(ls_cadena)>0 THEN
	ls_subcadena= TRIM(ls_cadena)
	as_arreglo_cadenas[ll_indice_arreglo] = ls_subcadena	
END IF

RETURN 0


end function

public function integer of_imprime_documento (long al_valor, long al_cve_documento, string as_columnas_marcas[], string as_query_definicion, boolean ab_permite_edicion, boolean ab_en_sitio);//of_imprime_documento
//Recibe		al_valor	long
//				al_cve_documento long
//				as_columnas_marcas[]	string
//				as_query_definicion	string
//				ab_permite_edicion boolean
//				ab_en_sitio	boolean

return of_imprime_documento(al_cve_documento, al_valor, ab_permite_edicion, ab_en_sitio)

end function

public function integer of_imprime_documento (long al_cve_documento, long al_valor, boolean ab_permite_edicion, boolean ab_en_sitio);//of_imprime_documento
//Recibe		al_cve_documento long
//				al_valor	long
//				ab_permite_edicion boolean
//				ab_en_sitio	boolean


blob lblob_ole
long ll_campos, ll_rows, ll_tamanio_arreglo, ll_indice_arreglo
integer iDDEHandle, li_remote, li_ret_activate, li_cve_tipo_dato
string ls_filename, ls_valor, ls_condicion_cuenta, ls_condicion_datastore,ls_ret_activate
datastore lds_datastore
string ls_presentacion, ls_error, ls_resultado_syntax, ls_marca_actual, ls_columna_actual
string ls_columna_valor_unico, ls_query_definicion, ls_columnas_marcas[], ls_query_datos
string ls_marca_folio_documento = "folio_documento", ls_folio_insertado
long ll_folio_insertado
SetPointer(HourGlass!)
//expresión.PrintOut(Background, Append, Range, OutputFileName, From, To, Item, Copies, Pages, PageType, PrintToFile, Collate, FileName, ActivePrinterMacGX, ManualDuplexPrint, PrintZoomColumn, PrintZoomRow, PrintZoomPaperWidth, PrintZoomPaperHeight)
//Background   Variant opcional. True para que la macro continúe mientras Microsoft Word imprime el documento.
//Append   Variant opcional. True para adjuntar el documento seleccionado al nombre de archivo especificado por el argumento OutputFileName. False para sobrescribir el contenido de OutputFileName.
//Range   Variant opcional. Intervalo de páginas. Puede ser una de las siguientes constantes 
//		WdPrintOutRange: wdPrintAllDocument, wdPrintCurrentPage, wdPrintFromTo, wdPrintRangeOfPages o wdPrintSelection.
constant integer wdPrintAllDocument	=0
constant integer wdPrintCurrentPage	=2
constant integer wdPrintFromTo	=3
constant integer wdPrintRangeOfPages	=4
constant integer wdPrintSelection	=1

//OutputFileName   Variant opcional. Si PrintToFile es True, este argumento especifica la ruta de acceso y el nombre del archivo de salida.
//From   Variant opcional. Número de la primera página del intervalo cuando Range se establece como wdPrintFromTo.
//To   Variant opcional. Número de la última página del intervalo cuando Range se establece como wdPrintFromTo.
//Item   Variant opcional. Elemento que va a imprimirse. Puede ser una de las siguientes constantes 
//		WdPrintOutItem: wdPrintAutoTextEntries, wdPrintComments, wdPrintDocumentContent, wdPrintKeyAssignments, wdPrintProperties o wdPrintStyles. 

constant integer wdPrintAutoTextEntries	=4
constant integer wdPrintComments	=2
constant integer wdPrintDocumentContent	=0
constant integer wdPrintKeyAssignments	=5
constant integer wdPrintProperties	=1
constant integer wdPrintStyles	=3

//Copies   Variant opcional. Número de copias que va a imprimirse.
//Pages   Variant opcional. Números e intervalos de página que deben imprimirse, separados por comas. Por ejemplo, con "2, 6-10" se imprimiría la página 2 y de la página 6 a la 10.
//PageType   Variant opcional. Tipo de página que va a imprimirse. Puede ser una de las siguientes constantes 
//		WdPrintOutPages: wdPrintAllPages, wdPrintEvenPagesOnly o wdPrintOddPagesOnly.

constant integer wdPrintAllPages	=0
constant integer wdPrintEvenPagesOnly	=2
constant integer wdPrintOddPagesOnly	=1

//PrintToFile   Variant opcional. True para enviar instrucciones de impresora a un archivo. Compruebe que especifica un nombre de archivo con OutputFileName.
//Collate   Variant opcional. Cuando se imprimen varias copias de un documento, True imprime todas las páginas del documento antes de imprimir las copias.
//FileName   Variant opcional. Ruta de acceso y nombre de archivo del documento que va a imprimirse. Si se omite este argumento, Word imprime el documento activo. Sólo está disponible con el objeto Application.
//ActivePrinterMacGX   Variant opcional. Este argumento está disponible sólo en Microsoft Office 98, edición para Macintosh. Para obtener más información acerca de este argumento, consulte la Ayuda de referencia de idioma que se incluye en Microsoft Office 98, edición para Macintosh.
//ManualDuplexPrint   Variant opcional. True para imprimir un documento de dos caras mediante una impresora que no dispone de un kit de impresión a doble cara. Si este argumento es True, se pasan por alto las propiedades PrintBackground y PrintReverse. Las propiedades PrintOddPagesInAscendingOrder y PrintEvenPagesInAscendingOrder se utilizan para controlar la salida durante la impresión manual a doble cara. Este argumento puede no estar disponible, según la compatibilidad con idioma, por ejemplo, Inglés (EE.UU.), que se haya seleccionado o instalado.
//PrintZoomColumn   Variant opcional. Número de páginas que desea que Word ajuste horizontalmente en una página. Puede ser 1, 2, 3 ó 4. Se utiliza con el argumento PrintZoomRow para imprimir varias páginas en una sola hoja.
//PrintZoomRow   Variant opcional. Número de páginas que desea que Word ajuste verticalmente en una página. Puede ser 1, 2 ó 4. Se utiliza con el argumento PrintZoomColumn para imprimir varias páginas en una sola hoja.
//PrintZoomWidth   Variant opcional. Ancho, en twips, que desea que Word aplique para la escala de páginas impresas, (20 twips = 1 punto; 72 puntos = 2,54 cm).
//PrintZoomHeight   Variant opcional. Alto, en twips, que desea que Word aplique para la escala de páginas impresas, (20 twips = 1 punto; 72 puntos = 2,54 cm).


//Propiedad WindowState
//                
//Devuelve o establece el estado de la ventana del documento o la ventana de tareas especificadas.
//Puede ser una de las siguientes constantes 
//		WdWindowState: wdWindowStateMaximize, wdWindowStateMinimize o wdWindowStateNormal. Long de Lectura/Escritura.

constant integer wdWindowStateMaximize	=1
constant integer wdWindowStateMinimize	=2
constant integer wdWindowStateNormal	=0


SELECTBLOB archivo_documento_titulac
INTO :lblob_ole
FROM documento_titulacion
WHERE cve_documento = :al_cve_documento
USING gtr_sce;

SELECT columna_valor_unico,
		 cve_tipo_dato,
		 query_definicion,
		 query_datos
INTO  :ls_columna_valor_unico,
		:li_cve_tipo_dato,
		:ls_query_definicion,
		:ls_query_datos
FROM documento_titulacion
WHERE cve_documento = :al_cve_documento
USING gtr_sce;


ls_valor= string(al_valor)

IF POS(upper(ls_query_definicion),"WHERE") > 0 then
	ls_condicion_cuenta = " AND "+ls_columna_valor_unico+" = "+ls_valor
ELSE
	ls_condicion_cuenta = " WHERE "+ls_columna_valor_unico+" = "+ls_valor	
END IF

ls_condicion_datastore= ls_query_definicion + ls_condicion_cuenta

lds_datastore = CREATE datastore

ls_presentacion= "Grid"

ls_resultado_syntax= gtr_sce.SyntaxFromSQL(ls_condicion_datastore, ls_presentacion, ls_error)
if ls_resultado_syntax= "" or isnull(ls_resultado_syntax) then
	MessageBox("Error en datawindow", ls_error,Stopsign!)
	SetPointer(Arrow!)
	return -1
end if

lds_datastore.Create(ls_resultado_syntax)
lds_datastore.SetTransObject(gtr_sce)
ll_rows= lds_datastore.Retrieve()

if ll_rows= 0 then
	MessageBox("Error en consulta","No existe información con los datos introducidos",Stopsign!)
	SetPointer(Arrow!)
	return -1
elseif ll_rows = -1 then
	MessageBox("Error de datawindow", "No es posible generar el reporte",Stopsign!)
	SetPointer(Arrow!)
	return -1
end if
//*****

IF not isnull(lblob_ole) THEN

	this.ObjectData = lblob_ole
	IF ab_en_sitio THEN
		li_ret_activate= this.Activate(InPlace!)
	ELSE
		li_ret_activate= this.Activate(OffSite!)
	END IF
	CHOOSE CASE li_ret_activate
		CASE -1  
			ls_ret_activate= "Container is empty"
		CASE -2  
			ls_ret_activate= "Invalid verb for object"
		CASE -3  
			ls_ret_activate= "Verb not implemented by object"
		CASE -4  
			ls_ret_activate= "No verbs supported by object"
		CASE -5  
			ls_ret_activate= "Object can't execute verb now"
		CASE -9  
			ls_ret_activate= "Other error"
	END CHOOSE
	IF li_ret_activate<>0 THEN
		MessageBox("Error de Activación de Documento",ls_ret_activate,StopSign!)
		SetPointer(Arrow!)
		return -1
	ELSE
		IF ab_permite_edicion THEN
			this.object.application.WindowState = wdWindowStateMaximize			
		ELSE
			this.object.application.WindowState = wdWindowStateMinimize
		END IF
	END IF
	this.of_obten_arreglo_de_string(ls_query_datos, ls_columnas_marcas) 
//	MessageBox("Pausa","Documento ligado",Question!)
	ll_tamanio_arreglo= upperbound(ls_columnas_marcas)
	//Recorre toda la lista de las marcas
	FOR ll_indice_arreglo= 1 to ll_tamanio_arreglo
		ls_marca_actual= ls_columnas_marcas[ll_indice_arreglo]
		IF this.object.application.ActiveDocument.Bookmarks.Exists(ls_marca_actual) THEN
			//Si existe la marca, sustituirá la marca por el contenido encontrado en el query
			this.object.application.Selection.Goto(TRUE,0,0,ls_marca_actual)
			ls_columna_actual = lds_datastore.GetItemString(ll_rows,ll_indice_arreglo)
			this.object.application.Selection.TypeText(ls_columna_actual)
		END IF
	NEXT	
	
	IF ab_permite_edicion THEN
		IF this.object.application.PrintPreview = FALSE Then
			this.object.application.PrintPreview= true
		END IF		
	END IF	
	
//	this.object.application.PrintOut(FileName="", Range:=wdPrintAllDocument, Item:= &
//        wdPrintDocumentContent, Copies:=1, Pages:="", PageType:=wdPrintAllPages, &
//        Collate:=True, Background:=True, PrintToFile:=False, PrintZoomColumn:=0, &
//        PrintZoomRow:=0, PrintZoomPaperWidth:=0, PrintZoomPaperHeight:=0)
//	this.object.application.document.PrintOut(Background, Append, Range,    OutputFileName, From, To, Item, Copies, Pages, PageType       , PrintToFile, Collate, FileName, ActivePrinterMacGX, ManualDuplexPrint, PrintZoomColumn, PrintZoomRow, PrintZoomPaperWidth, PrintZoomPaperHeight)
	ll_folio_insertado= this.of_inserta_folio_documento_tit(al_valor, al_cve_documento)
	if	ll_folio_insertado <> -1 then
		ls_folio_insertado = string(ll_folio_insertado)
		IF this.object.application.ActiveDocument.Bookmarks.Exists(ls_marca_folio_documento) THEN
			//Si existe la marca, sustituirá la marca por el contenido encontrado en el query
			this.object.application.Selection.Goto(TRUE,0,0,ls_marca_folio_documento)
			this.object.application.Selection.TypeText(ls_folio_insertado)
		END IF	
		
		this.object.application.PrintOut(true,       false,  wdPrintAllDocument) //,               ,     ,   ,     ,       , Pages, PageType       , PrintToFile, Collate, FileName, ActivePrinterMacGX, ManualDuplexPrint, PrintZoomColumn, PrintZoomRow, PrintZoomPaperWidth, PrintZoomPaperHeight)
	end if
//	this.object.application.ActiveDocument.PrintOut() 
	IF NOT ab_permite_edicion THEN
		this.object.application.ActiveDocument.Close()
//		this.object.application.Quit()
	END IF
	SetPointer(Arrow!)
	return 0
ELSE
	MessageBox("Archivo sin Documento", "El tipo de archivo no tiene un documento relacionado",StopSign!)
	SetPointer(Arrow!)
	return -1
	
END IF


//*******
end function

public function integer of_imprime_documento (long al_cve_documento, string as_valor_01[], boolean ab_permite_edicion, boolean ab_en_sitio);//of_imprime_documento
//Recibe		al_cve_documento long
//				as_valor_01[]  string
//				ab_permite_edicion boolean
//				ab_en_sitio	boolean


blob lblob_ole
long ll_campos, ll_rows, ll_tamanio_arreglo, ll_indice_arreglo
integer iDDEHandle, li_remote, li_ret_activate, li_cve_tipo_dato
string ls_filename, ls_valor_01, ls_valor_02, ls_valor_03
string ls_condicion_cuenta, ls_condicion_datastore,ls_ret_activate
datastore lds_datastore
string ls_presentacion, ls_error, ls_resultado_syntax, ls_marca_actual, ls_columna_actual
string ls_columna_valor_unico, ls_query_definicion, ls_columnas_marcas[], ls_query_datos
string ls_columnas_valor_unico[], ls_tipo_dato_valor_unico,  ls_tipos_dato_valor_unico[]
string ls_condicion_where
integer li_num_cols_unico, li_num_tipo_dato_unico, li_num_valores, li_indice_where
string ls_marca_folio_documento = "folio_documento", ls_folio_insertado
long ll_folio_insertado
SetPointer(HourGlass!)
//expresión.PrintOut(Background, Append, Range, OutputFileName, From, To, Item, Copies, Pages, PageType, PrintToFile, Collate, FileName, ActivePrinterMacGX, ManualDuplexPrint, PrintZoomColumn, PrintZoomRow, PrintZoomPaperWidth, PrintZoomPaperHeight)
//Background   Variant opcional. True para que la macro continúe mientras Microsoft Word imprime el documento.
//Append   Variant opcional. True para adjuntar el documento seleccionado al nombre de archivo especificado por el argumento OutputFileName. False para sobrescribir el contenido de OutputFileName.
//Range   Variant opcional. Intervalo de páginas. Puede ser una de las siguientes constantes 
//		WdPrintOutRange: wdPrintAllDocument, wdPrintCurrentPage, wdPrintFromTo, wdPrintRangeOfPages o wdPrintSelection.
constant integer wdPrintAllDocument	=0
constant integer wdPrintCurrentPage	=2
constant integer wdPrintFromTo	=3
constant integer wdPrintRangeOfPages	=4
constant integer wdPrintSelection	=1

//OutputFileName   Variant opcional. Si PrintToFile es True, este argumento especifica la ruta de acceso y el nombre del archivo de salida.
//From   Variant opcional. Número de la primera página del intervalo cuando Range se establece como wdPrintFromTo.
//To   Variant opcional. Número de la última página del intervalo cuando Range se establece como wdPrintFromTo.
//Item   Variant opcional. Elemento que va a imprimirse. Puede ser una de las siguientes constantes 
//		WdPrintOutItem: wdPrintAutoTextEntries, wdPrintComments, wdPrintDocumentContent, wdPrintKeyAssignments, wdPrintProperties o wdPrintStyles. 

constant integer wdPrintAutoTextEntries	=4
constant integer wdPrintComments	=2
constant integer wdPrintDocumentContent	=0
constant integer wdPrintKeyAssignments	=5
constant integer wdPrintProperties	=1
constant integer wdPrintStyles	=3

//Copies   Variant opcional. Número de copias que va a imprimirse.
//Pages   Variant opcional. Números e intervalos de página que deben imprimirse, separados por comas. Por ejemplo, con "2, 6-10" se imprimiría la página 2 y de la página 6 a la 10.
//PageType   Variant opcional. Tipo de página que va a imprimirse. Puede ser una de las siguientes constantes 
//		WdPrintOutPages: wdPrintAllPages, wdPrintEvenPagesOnly o wdPrintOddPagesOnly.

constant integer wdPrintAllPages	=0
constant integer wdPrintEvenPagesOnly	=2
constant integer wdPrintOddPagesOnly	=1

//PrintToFile   Variant opcional. True para enviar instrucciones de impresora a un archivo. Compruebe que especifica un nombre de archivo con OutputFileName.
//Collate   Variant opcional. Cuando se imprimen varias copias de un documento, True imprime todas las páginas del documento antes de imprimir las copias.
//FileName   Variant opcional. Ruta de acceso y nombre de archivo del documento que va a imprimirse. Si se omite este argumento, Word imprime el documento activo. Sólo está disponible con el objeto Application.
//ActivePrinterMacGX   Variant opcional. Este argumento está disponible sólo en Microsoft Office 98, edición para Macintosh. Para obtener más información acerca de este argumento, consulte la Ayuda de referencia de idioma que se incluye en Microsoft Office 98, edición para Macintosh.
//ManualDuplexPrint   Variant opcional. True para imprimir un documento de dos caras mediante una impresora que no dispone de un kit de impresión a doble cara. Si este argumento es True, se pasan por alto las propiedades PrintBackground y PrintReverse. Las propiedades PrintOddPagesInAscendingOrder y PrintEvenPagesInAscendingOrder se utilizan para controlar la salida durante la impresión manual a doble cara. Este argumento puede no estar disponible, según la compatibilidad con idioma, por ejemplo, Inglés (EE.UU.), que se haya seleccionado o instalado.
//PrintZoomColumn   Variant opcional. Número de páginas que desea que Word ajuste horizontalmente en una página. Puede ser 1, 2, 3 ó 4. Se utiliza con el argumento PrintZoomRow para imprimir varias páginas en una sola hoja.
//PrintZoomRow   Variant opcional. Número de páginas que desea que Word ajuste verticalmente en una página. Puede ser 1, 2 ó 4. Se utiliza con el argumento PrintZoomColumn para imprimir varias páginas en una sola hoja.
//PrintZoomWidth   Variant opcional. Ancho, en twips, que desea que Word aplique para la escala de páginas impresas, (20 twips = 1 punto; 72 puntos = 2,54 cm).
//PrintZoomHeight   Variant opcional. Alto, en twips, que desea que Word aplique para la escala de páginas impresas, (20 twips = 1 punto; 72 puntos = 2,54 cm).


//Propiedad WindowState
//                
//Devuelve o establece el estado de la ventana del documento o la ventana de tareas especificadas.
//Puede ser una de las siguientes constantes 
//		WdWindowState: wdWindowStateMaximize, wdWindowStateMinimize o wdWindowStateNormal. Long de Lectura/Escritura.

constant integer wdWindowStateMaximize	=1
constant integer wdWindowStateMinimize	=2
constant integer wdWindowStateNormal	=0


SELECTBLOB archivo_documento_titulac
INTO :lblob_ole
FROM documento_titulacion
WHERE cve_documento = :al_cve_documento
USING gtr_sce;

SELECT columna_valor_unico,
		 cve_tipo_dato,
		 query_definicion,
		 query_datos,
		 tipo_dato_valor_unico
INTO  :ls_columna_valor_unico,
		:li_cve_tipo_dato,
		:ls_query_definicion,
		:ls_query_datos,
		:ls_tipo_dato_valor_unico
FROM documento_titulacion
WHERE cve_documento = :al_cve_documento
USING gtr_sce;


li_num_valores= upperbound(as_valor_01)

if li_num_valores <=0 then
	MessageBox("Error en valores","No existen elementos de información para la impresión",Stopsign!)
	SetPointer(Arrow!)
	return -1
end if


if not isnumber(as_valor_01[1]) then
	MessageBox("Error en columna","La primer columna siempre deberá ser numérica",Stopsign!)
	SetPointer(Arrow!)
	return -1
end if


this.of_obten_arreglo_de_string(ls_columna_valor_unico, ls_columnas_valor_unico) 
this.of_obten_arreglo_de_string(ls_tipo_dato_valor_unico, ls_tipos_dato_valor_unico) 

li_num_cols_unico = upperbound(ls_columnas_valor_unico)
li_num_tipo_dato_unico = upperbound(ls_tipos_dato_valor_unico)

if not(li_num_cols_unico=li_num_tipo_dato_unico AND li_num_tipo_dato_unico= li_num_valores) then
	MessageBox("Error en columnas y valores","No corresponde el número de columnas únicas con sus valores y tipos de datos",Stopsign!)
	SetPointer(Arrow!)
	return -1
end if

IF POS(upper(ls_query_definicion),"WHERE") > 0 then
	ls_condicion_cuenta = " AND "+ls_columna_valor_unico+" = "+ls_valor_01
ELSE
	ls_condicion_cuenta = " WHERE "+ls_columna_valor_unico+" = "+ls_valor_01	
END IF

ls_condicion_where=""
FOR li_indice_where= 1 TO li_num_valores 
	IF upper(ls_tipos_dato_valor_unico[li_indice_where])="INT" or &
		upper(ls_tipos_dato_valor_unico[li_indice_where])="INTEGER" or & 
		upper(ls_tipos_dato_valor_unico[li_indice_where])="LONG" THEN
		IF POS(upper(ls_query_definicion),"WHERE") > 0  THEN
			ls_condicion_where = ls_condicion_where +  " AND "+ls_columnas_valor_unico[li_indice_where]+&
										" = "+as_valor_01[li_indice_where]
		ELSE
			IF POS(upper(ls_condicion_where),"WHERE") > 0 THEN			
				ls_condicion_where = ls_condicion_where + " AND "+ls_columnas_valor_unico[li_indice_where]+&
											" = "+as_valor_01[li_indice_where]
			ELSE
				ls_condicion_where = ls_condicion_where + " WHERE "+ls_columnas_valor_unico[li_indice_where]+&
											" = "+as_valor_01[li_indice_where]
			END IF
			
		END IF	
	ELSEIF  upper(ls_tipos_dato_valor_unico[li_indice_where])="STRING" or &
			upper(ls_tipos_dato_valor_unico[li_indice_where])="STR" THEN
		IF POS(upper(ls_query_definicion),"WHERE") > 0  THEN
				ls_condicion_where = ls_condicion_where + " AND "+ls_columnas_valor_unico[li_indice_where]+&
											" = '"+as_valor_01[li_indice_where]+"'"
		ELSE
			IF POS(upper(ls_condicion_where),"WHERE") > 0 THEN			
				ls_condicion_where = ls_condicion_where + " AND "+ls_columnas_valor_unico[li_indice_where]+&
											" = '"+as_valor_01[li_indice_where]+"'"
			ELSE
				ls_condicion_where = ls_condicion_where + " WHERE "+ls_columnas_valor_unico[li_indice_where]+&
											" = '"+as_valor_01[li_indice_where]+"'"
			END IF			
		END IF	
	END IF

	
NEXT



ls_condicion_datastore= ls_query_definicion + ls_condicion_where

lds_datastore = CREATE datastore

ls_presentacion= "Grid"

ls_resultado_syntax= gtr_sce.SyntaxFromSQL(ls_condicion_datastore, ls_presentacion, ls_error)
if ls_resultado_syntax= "" or isnull(ls_resultado_syntax) then
	MessageBox("Error en datawindow", ls_error,Stopsign!)
	SetPointer(Arrow!)
	return -1
end if

lds_datastore.Create(ls_resultado_syntax)
lds_datastore.SetTransObject(gtr_sce)
ll_rows= lds_datastore.Retrieve()

if ll_rows= 0 then
	MessageBox("Error en consulta","No existe información con los datos introducidos",Stopsign!)
	SetPointer(Arrow!)
	return -1
elseif ll_rows = -1 then
	MessageBox("Error de datawindow", "No es posible generar el reporte",Stopsign!)
	SetPointer(Arrow!)
	return -1
end if
//*****

IF not isnull(lblob_ole) THEN

	this.ObjectData = lblob_ole
	IF ab_en_sitio THEN
		li_ret_activate= this.Activate(InPlace!)
	ELSE
		li_ret_activate= this.Activate(OffSite!)
	END IF
	CHOOSE CASE li_ret_activate
		CASE -1  
			ls_ret_activate= "Container is empty"
		CASE -2  
			ls_ret_activate= "Invalid verb for object"
		CASE -3  
			ls_ret_activate= "Verb not implemented by object"
		CASE -4  
			ls_ret_activate= "No verbs supported by object"
		CASE -5  
			ls_ret_activate= "Object can't execute verb now"
		CASE -9  
			ls_ret_activate= "Other error"
	END CHOOSE
	IF li_ret_activate<>0 THEN
		MessageBox("Error de Activación de Documento",ls_ret_activate,StopSign!)
		SetPointer(Arrow!)
		return -1
	ELSE
		IF ab_permite_edicion THEN
			this.object.application.WindowState = wdWindowStateMaximize			
		ELSE
			this.object.application.WindowState = wdWindowStateMinimize
		END IF
	END IF
	this.of_obten_arreglo_de_string(ls_query_datos, ls_columnas_marcas) 
//	MessageBox("Pausa","Documento ligado",Question!)
	ll_tamanio_arreglo= upperbound(ls_columnas_marcas)
	//Recorre toda la lista de las marcas
	FOR ll_indice_arreglo= 1 to ll_tamanio_arreglo
		ls_marca_actual= ls_columnas_marcas[ll_indice_arreglo]
		IF this.object.application.ActiveDocument.Bookmarks.Exists(ls_marca_actual) THEN
			//Si existe la marca, sustituirá la marca por el contenido encontrado en el query
			this.object.application.Selection.Goto(TRUE,0,0,ls_marca_actual)
			ls_columna_actual = lds_datastore.GetItemString(ll_rows,ll_indice_arreglo)
			this.object.application.Selection.TypeText(ls_columna_actual)
		END IF
	NEXT	
	
	IF ab_permite_edicion THEN
		IF this.object.application.PrintPreview = FALSE Then
			this.object.application.PrintPreview= true
		END IF		
	END IF	
	
//	this.object.application.PrintOut(FileName="", Range:=wdPrintAllDocument, Item:= &
//        wdPrintDocumentContent, Copies:=1, Pages:="", PageType:=wdPrintAllPages, &
//        Collate:=True, Background:=True, PrintToFile:=False, PrintZoomColumn:=0, &
//        PrintZoomRow:=0, PrintZoomPaperWidth:=0, PrintZoomPaperHeight:=0)
//	this.object.application.document.PrintOut(Background, Append, Range,    OutputFileName, From, To, Item, Copies, Pages, PageType       , PrintToFile, Collate, FileName, ActivePrinterMacGX, ManualDuplexPrint, PrintZoomColumn, PrintZoomRow, PrintZoomPaperWidth, PrintZoomPaperHeight)

	ll_folio_insertado= this.of_inserta_folio_documento_tit(long(as_valor_01[1]), al_cve_documento)
	if	ll_folio_insertado <> -1 then
		ls_folio_insertado = string(ll_folio_insertado)
		IF this.object.application.ActiveDocument.Bookmarks.Exists(ls_marca_folio_documento) THEN
			//Si existe la marca, sustituirá la marca por el contenido encontrado en el query
			this.object.application.Selection.Goto(TRUE,0,0,ls_marca_folio_documento)
			this.object.application.Selection.TypeText(ls_folio_insertado)
		END IF	
		this.object.application.PrintOut(true, false,  wdPrintAllDocument) //,               ,     ,   ,     ,       , Pages, PageType       , PrintToFile, Collate, FileName, ActivePrinterMacGX, ManualDuplexPrint, PrintZoomColumn, PrintZoomRow, PrintZoomPaperWidth, PrintZoomPaperHeight)
	end if
//	this.object.application.ActiveDocument.PrintOut() 
	IF NOT ab_permite_edicion THEN
		this.object.application.ActiveDocument.Close()
//		this.object.application.Quit()
	END IF
	SetPointer(Arrow!)
	return 0
ELSE
	MessageBox("Archivo sin Documento", "El tipo de archivo no tiene un documento relacionado",StopSign!)
	SetPointer(Arrow!)
	return -1
	
END IF


end function

on u_oc_impresion_word.create
end on

on u_oc_impresion_word.destroy
end on

