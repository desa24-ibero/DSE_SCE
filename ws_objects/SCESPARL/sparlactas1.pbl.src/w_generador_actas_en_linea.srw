$PBExportHeader$w_generador_actas_en_linea.srw
forward
global type w_generador_actas_en_linea from w_main
end type
type uo_nivel from uo_nivel_2013 within w_generador_actas_en_linea
end type
type rb_ets_lp from radiobutton within w_generador_actas_en_linea
end type
type cb_guardar_como from commandbutton within w_generador_actas_en_linea
end type
type cb_imprimir from commandbutton within w_generador_actas_en_linea
end type
type dw_asignatura_movtos from datawindow within w_generador_actas_en_linea
end type
type dw_acta_per_nivel_profesor from datawindow within w_generador_actas_en_linea
end type
type rb_titulo_de_suf from radiobutton within w_generador_actas_en_linea
end type
type rb_extraordinaria from radiobutton within w_generador_actas_en_linea
end type
type rb_ordinaria from radiobutton within w_generador_actas_en_linea
end type
type rb_posgrado from radiobutton within w_generador_actas_en_linea
end type
type rb_licenciatura from radiobutton within w_generador_actas_en_linea
end type
type uo_1 from uo_per_ani within w_generador_actas_en_linea
end type
type st_txt from statictext within w_generador_actas_en_linea
end type
type dw_act_eval from datawindow within w_generador_actas_en_linea
end type
type gb_2 from groupbox within w_generador_actas_en_linea
end type
type tab_1 from tab within w_generador_actas_en_linea
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_1 from userobject within tab_1
end type
type tabpage_3 from userobject within tab_1
end type
type cb_1 from commandbutton within tabpage_3
end type
type tabpage_3 from userobject within tab_1
cb_1 cb_1
end type
type tab_1 from tab within w_generador_actas_en_linea
tabpage_1 tabpage_1
tabpage_3 tabpage_3
end type
type gb_1 from groupbox within w_generador_actas_en_linea
end type
type bolas from structure within w_generador_actas_en_linea
end type
end forward

type bolas from structure
	integer		bola[13, 14]
end type

global type w_generador_actas_en_linea from w_main
integer x = 18
integer y = 20
integer width = 4238
integer height = 2828
string title = "Generador de Actas de Evaluación"
string menuname = "m_gen_actas_en_linea"
long backcolor = 134217739
event genera_acta ( )
uo_nivel uo_nivel
rb_ets_lp rb_ets_lp
cb_guardar_como cb_guardar_como
cb_imprimir cb_imprimir
dw_asignatura_movtos dw_asignatura_movtos
dw_acta_per_nivel_profesor dw_acta_per_nivel_profesor
rb_titulo_de_suf rb_titulo_de_suf
rb_extraordinaria rb_extraordinaria
rb_ordinaria rb_ordinaria
rb_posgrado rb_posgrado
rb_licenciatura rb_licenciatura
uo_1 uo_1
st_txt st_txt
dw_act_eval dw_act_eval
gb_2 gb_2
tab_1 tab_1
gb_1 gb_1
end type
global w_generador_actas_en_linea w_generador_actas_en_linea

type variables
long il_inicia_acceso
end variables

forward prototypes
public function integer no_insc_hoja (integer inscritos, integer hoja)
public subroutine llena_linea_alumno (ref string linea, ref integer band, string cuenta, string alumno, ref long cont)
public subroutine imprime_encabezado (ref string linea, string evaluacion, string plantel)
public function bolas llenadebolitas (long cvemat, string gpo, integer numacta, integer hoja, integer inscritos, long year, integer periodo)
public subroutine per_cve_gpo (long year, string periodo, long cvemat, string gpo, ref string linea)
public subroutine llena_string_f_struct (ref string matrix_print[14], ref bolas matrix)
public subroutine acta_hoja_insc (long acta, integer hoja, integer inscritos, ref string linea)
public subroutine obten_fecha_agrega_linea (ref string linea, string matrix_print)
public function integer wf_genera_actas_en_linea ()
public function integer wf_asigna_profesores_por_designar ()
protected function integer wf_genera_actas_ets ()
end prototypes

event genera_acta();//Evento en el cual se genera el archivo de texto que imprime las actas de evaluación
//CAMP Abril 1998
bolas matrix
string matrix_print[14]
string linea,depto[2],nivel,mat[3],profesor[2],alumno,path,file_name,gpo[2],cuenta,tipo_eval
long year,cont,cont1,cve_mat[2],row=1,acta=1
long hoja,inscritos,localiza//,i,j
int band=0,hojaT=1,archivo,per
char periodo
string ls_profesor_nombre_completo[2],ls_coordinaciones_coordinacion[2], ls_materias_nivel[2], ls_materias_materia[2]
int li_inscritos[2]
int li_confirma
string evaluacion, pla
int li_periodo, li_anio
int gen
long ll_rows
string ls_nivel
integer li_cve_tipo_examen
string ls_cve_tipo_calificacion
integer li_cve_estatus_acta
integer li_no_acta
integer li_inscritos_acta
long 	ll_cve_profesor
integer li_proceso_generadas, li_set_estatus_proceso_actas
string ls_tipo_examen,ls_desc_nivel

STRING ls_nivel2
string ls_array_nivel[] 
integer li_result

li_periodo = gi_periodo
li_anio = gi_anio

if rb_ordinaria.checked = true then
	li_cve_tipo_examen = 3
	ls_tipo_examen	=	"ORDINARIO "
elseif rb_extraordinaria.checked = true then
	li_cve_tipo_examen = 2
	ls_tipo_examen =    "EXTRAORDINARIO "
elseif rb_titulo_de_suf.checked = true then
	li_cve_tipo_examen = 6
	ls_tipo_examen =    "A TITULO DE SUFICIENCIA "
end if

li_result = uo_nivel.of_carga_arreglo_nivel( )
uo_nivel.of_obtiene_array( ls_array_nivel[] )

If li_result = - 1 Then
	MessageBox("Mensaje del Sistema", "Error al ejecutar uo_nivel.of_carga_arreglo_nivel", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox("Mensaje del Sistema", "Debe seleccionar un nivel", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) > 1 Then
	MessageBox("Mensaje del Sistema", "Solo puede seleccionar un nivel", StopSign!)
	return
End If

ls_nivel = ls_array_nivel[1]
ls_desc_nivel = f_decodifica_nivel(ls_nivel)

//if rb_licenciatura.checked = true then
//	ls_desc_nivel = "LICENCIATURA"
//else
//	ls_desc_nivel = "POSGRADO"
//end if

//choose case ls_nivel
//	case "L"
//		ls_desc_nivel = "LICENCIATURA"
//	case "P"
//		ls_desc_nivel =	 "POSGRADO"
//	case "T"
//		ls_desc_nivel =	 "TSU"
//end choose

IF rb_ordinaria.Checked = TRUE THEN
	li_confirma = MessageBox("Confirmacion Ordinaria", "¿Desea generar actas ORDINARIAS", Question!, YesNo!)
	
	if li_confirma= 1 then
		if wf_genera_actas_en_linea()<> -1 then
			MessageBox("Generación exitosa", "Se han generado las actas en Línea", Information!)
			if wf_asigna_profesores_por_designar()<> -1 then
				MessageBox("Asignación por designar exitosa", "Se han asignado las actas por designar", Information!)
				//Actualiza el esatus general del proceso de actas para el periodo vigente
				li_proceso_generadas=1
				li_set_estatus_proceso_actas =f_set_estatus_proceso_actas(li_proceso_generadas,li_periodo, li_anio,1,gtr_sce)
				if li_set_estatus_proceso_actas = -1 then
					MessageBox("Error en la actualizacion del proceso de actas ["+string(li_proceso_generadas)+"]",&
							"Si la Generacion fue exitosa actualice el registro ["+string(li_proceso_generadas)+"] de la tabla proceso_actas",StopSign!)
				end if
			else
				MessageBox("Asignación por designar  fallida", "No se han asignado las actas por designar", StopSign!)
			end if
		else
			MessageBox("Generación fallida", "No se han generado las actas en Línea", StopSign!)
		end if
	end if
	return
ELSEIF rb_extraordinaria.Checked = TRUE or rb_titulo_de_suf.Checked = TRUE THEN
	li_confirma = MessageBox("Confirmacion Extraordinario y a Título de Suficiencia", &
		"¿Desea generar actas ["+ls_tipo_examen+"] de nivel ["+ls_desc_nivel+"]", Question!, YesNo!)
	if li_confirma= 1 then
		if wf_genera_actas_ets()<> -1 then
			MessageBox("Generación exitosa", "Se han generado las actas en Línea", Information!)
//			if wf_asigna_profesores_por_designar()<> -1 then
				MessageBox("Asignación por designar exitosa", "Se han asignado las actas por designar", Information!)
				//Actualiza el esatus general del proceso de actas para el periodo vigente
				li_proceso_generadas=1
				li_set_estatus_proceso_actas =f_set_estatus_proceso_actas(li_proceso_generadas,li_periodo, li_anio,1,gtr_sce)
				if li_set_estatus_proceso_actas = -1 then
					MessageBox("Error en la actualizacion del proceso de actas ["+string(li_proceso_generadas)+"]",&
							"Si la Generacion fue exitosa actualice el registro ["+string(li_proceso_generadas)+"] de la tabla proceso_actas",StopSign!)
				end if
//			else
//				MessageBox("Asignación por designar  fallida", "No se han asignado las actas por designar", StopSign!)
//			end if
		else
			MessageBox("Generación fallida", "No se han generado las actas en Línea", StopSign!)
		end if		
	end if
	return
ELSE
	MessageBox("Selección Inválida", "Favor de seleccionar el tipo de evaluación", StopSign!)
	return
END IF


IF isnull(li_confirma) THEN
	MessageBox("Selección Inválida", "Favor de seleccionar el tipo de evaluación", StopSign!)
	return
ELSEIF li_confirma<> 1 THEN
	MessageBox("Generación Cancelada", "No se generarán las actas", Information!)
	return
END IF

return

//if rb_licenciatura.checked = true then
//	SELECT COUNT(*) INTO :gen 
//	FROM actas_evaluacion a, materias m
//	WHERE a.cve_mat = m.cve_mat AND
//	m.nivel = "L" USING gtr_sce;
//else
//	SELECT COUNT(*) INTO :gen 
//	FROM actas_evaluacion a, materias m
//	WHERE a.cve_mat = m.cve_mat AND
//	m.nivel = "P" USING gtr_sce;
//end if

	SELECT COUNT(*) INTO :gen 
	FROM actas_evaluacion a, materias m
	WHERE a.cve_mat = m.cve_mat 
	AND m.nivel = :ls_nivel USING gtr_sce;

//if rb_licenciatura.checked = true then
//	ls_nivel = 'L'
	SELECT COUNT(*) INTO :gen 
	FROM acta_evaluacion_preeliminar a, materias m
	WHERE a.cve_mat = m.cve_mat 
//	AND m.nivel = "L" 
	AND m.nivel = :ls_nivel
	AND a.periodo = :li_periodo 
	AND a.anio = :li_anio
	USING gtr_sce;
//else
//	ls_nivel = 'P'
//	SELECT COUNT(*) INTO :gen 
//	FROM acta_evaluacion_preeliminar a, materias m
//	WHERE a.cve_mat = m.cve_mat 
//	AND m.nivel = "P" 
//	AND a.periodo = :li_periodo 
//	AND a.anio = :li_anio
//	USING gtr_sce;
//end if

if gen > 0 and rb_ordinaria.checked = true then
	messagebox("Aviso", "Las actas ya se generaron")
	return
end if
path	=	"c:\actas_evaluacion.txt"
if GetFileSaveName ( "Elija nombre para guardar las actas de evaluación", path, file_name) = 0 then
	return
end if
archivo	=	FileOpen ( path,LineMode!,Write!,Shared! ,Replace!)

ll_rows= dw_act_eval.retrieve(gi_periodo, gi_anio, ls_nivel)

//if rb_licenciatura.checked = true then
//	ll_rows= dw_act_eval.retrieve(gi_periodo,gi_anio,"L")
//else
//	ll_rows =dw_act_eval.retrieve(gi_periodo,gi_anio,"P")
//end if

SELECT plantel INTO :pla FROM planteles WHERE actual = 1 USING gtr_sce;
do while (len(pla)< 12)
	pla += " "
loop


//Generación de paginas de configuración(2)

string ls_primera_linea
ls_primera_linea = "%!"+char(10)+"(iberoarro.jdt) STARTLM"
linea = ls_primera_linea
//filewrite(archivo,ls_primera_linea)




//for cont = 1 to 20
//	if mod(cont,10)	= 0 then
//		linea = linea + char(13)+char(10)
//	else
//		for cont1	= 1 to 9
//			linea = linea + "@@@@@@@@@ "
//		next	
//		linea	=	linea + char(13)+char(10)
//	end if
//	if cont = 50 then
//		linea	=	linea+char(12)
//	end if
//next
//linea = linea + char(12)
//if filewrite(archivo,linea) < 0 then
//	return
//end if
//Final Generación de paginas de configuración(2)
if rb_ordinaria.checked = true then
	li_cve_tipo_examen = 3
	tipo_eval	=	"ORDINARIA    "
elseif rb_extraordinaria.checked = true then
	li_cve_tipo_examen = 2
	tipo_eval =    "EXTRAOR      "
elseif rb_titulo_de_suf.checked = true then
	li_cve_tipo_examen = 6
	tipo_eval =    "TITULO       "
end if
do while (len(tipo_eval)< 10)
	tipo_eval	=	tipo_eval+" "
loop

//linea = ""
//linea += "****Actas****"+char(12)
if	dw_act_eval.rowcount()	>	0 then
	//dw_act_eval.InsertRow(0)
	cont	=	1
	cve_mat[1]	=	dw_act_eval.getitemnumber(cont,"mat_inscritas_cve_mat")	
	gpo[1]	=	dw_act_eval.getitemstring(cont,"mat_inscritas_gpo")
	
	ls_profesor_nombre_completo[1] = dw_act_eval.getitemstring(cont,"profesor_nombre_completo")
	ls_coordinaciones_coordinacion[1] = dw_act_eval.getitemstring(cont,"coordinaciones_coordinacion")
	ls_materias_nivel[1] = dw_act_eval.getitemstring(cont,"materias_nivel")
	ls_materias_materia[1] = dw_act_eval.getitemstring(cont,"materias_materia")
	li_inscritos[1] = dw_act_eval.getitemnumber(cont,"inscritos")
	
	per	=	dw_act_eval.getitemnumber(cont,"mat_inscritas_periodo")
	year	=	dw_act_eval.getitemnumber(cont,"mat_inscritas_anio")
	mat[3]	=	dw_act_eval.getitemstring(cont,"materias_materia")
	depto[2]	=	dw_act_eval.getitemstring(cont,"coordinaciones_coordinacion")
	profesor[2]	=	dw_act_eval.getitemstring(cont,"profesor_nombre_completo")
	evaluacion = dw_act_eval.getitemstring(cont,"materias_evaluacion")
	ll_cve_profesor =	dw_act_eval.getitemNumber(cont,"cve_profesor")
	
	li_cve_estatus_acta = 1
	ls_cve_tipo_calificacion = evaluacion
	li_no_acta = acta

	evaluacion = trim(evaluacion)
	int insc
	insc = dw_act_eval.getitemnumber(cont,"inscritos")	
	li_inscritos_acta = insc
	if rb_ordinaria.checked = true then
		INSERT INTO actas_evaluacion VALUES(:cve_mat[1],:gpo[1],:acta,:insc,0) USING gtr_sce;
		COMMIT using gtr_sce;
		
		INSERT INTO acta_evaluacion_preeliminar (
			cve_mat,
			gpo,
			periodo,
			anio,
			no_acta,
			cve_tipo_examen,
			nivel,
			cve_profesor,
			inscritos,
			status,
			cve_tipo_calificacion,
			cve_estatus_acta)       		
		VALUES (
		:cve_mat[1],
		:gpo[1],
		:li_periodo,
		:li_anio,
		:li_no_acta,
		:li_cve_tipo_examen,
		:ls_nivel,
		:ll_cve_profesor,
		:li_inscritos_acta,
		0,			
		:ls_cve_tipo_calificacion,	
		:li_cve_estatus_acta		
		) USING gtr_sce;
		
	end if
	
	//acta =	long(dw_act_eval.getitemstring(cont,"actas_evaluacion_no_acta"))
	
//	if dw_act_eval.getitemstring(cont,"materias_nivel")	=	'L'	then
//		nivel	=	"Licenciatura"
//	elseif dw_act_eval.getitemstring(cont,"materias_nivel")	=	'P'	then
//		nivel	=	"Posgrado"
//	end if	

	ls_nivel2 = dw_act_eval.getitemstring(cont,"materias_nivel")
	nivel = f_decodifica_nivel(ls_nivel2) 
//	choose case dw_act_eval.getitemstring(cont,"materias_nivel")
//	case "L"
//		nivel	=	"Licenciatura"
//	case "P"
//		nivel	=	"Posgrado"
//	case "T"
//		nivel	=	"TSU"
//	end choose

//Agrega encabezado
imprime_encabezado(linea, evaluacion,pla)
linea	= linea + char(13)+char(10)
for row	=	1	to 44
	dw_act_eval.scrolltorow(cont)
//	if cont=32768 or cont = 32766 then
//		//messagebox("",string(dw_act_eval.object.alumnos_cuenta[cont]))
//	end if

	//cuenta	=	string(dw_act_eval.object.alumnos_cuenta[cont])+"-"+obten_digito(dw_act_eval.object.alumnos_cuenta[cont])
	//messagebox("",string(cont))
	cuenta = string(dw_act_eval.getitemnumber(cont,"alumnos_cuenta"))+"-"+obten_digito(dw_act_eval.getitemnumber(cont,"alumnos_cuenta"))
	do while (len(cuenta)< 8)
		cuenta	=	" "	+	cuenta
	loop
	cuenta =	cuenta +" "
	alumno	=	dw_act_eval.getitemstring(cont,"alumnos_nombre_completo")
	if len(alumno) > 40 then
		alumno = mid(alumno,1,40)
	end if
	cve_mat[2]	=	dw_act_eval.getitemnumber(cont,"mat_inscritas_cve_mat")
	gpo[2]	=	dw_act_eval.getitemstring(cont,"mat_inscritas_gpo")
	
	ls_profesor_nombre_completo[2] = dw_act_eval.getitemstring(cont,"profesor_nombre_completo")
	ls_coordinaciones_coordinacion[2] = dw_act_eval.getitemstring(cont,"coordinaciones_coordinacion")
	ls_materias_nivel[2] = dw_act_eval.getitemstring(cont,"materias_nivel")
	ls_materias_materia[2] = dw_act_eval.getitemstring(cont,"materias_materia")
	li_inscritos[2] = dw_act_eval.getitemnumber(cont,"inscritos")
	
	
	do while (len(nivel)< 12)
		nivel	=	nivel	+	" "
	loop

	if cve_mat[1]	<>	cve_mat[2]	then
		band	=	1
	elseif gpo[1] <> gpo[2] then
		band	=	1
	else
		
	end if
	if cont = 1 then
			matrix	=	llenadebolitas(cve_mat[1],gpo[1],acta,hojaT,no_insc_hoja(dw_act_eval.getitemnumber(cont,"inscritos"),hojaT),year,per)
			llena_string_f_struct(matrix_print,matrix)
	end if
	choose case row
		case	11 			
							//INICIALIZACION DE ARREGLOS
							for cont1	=	1 to 3
								mat[cont1]=""
								if cont1	<>	3	then
									depto[cont1]	=	""
									profesor[cont1]	=	""
								end if
							next
							profesor[2]	=	ls_profesor_nombre_completo[1]//dw_act_eval.getitemstring(cont - 1,"profesor_nombre_completo")
							//OBTENCIÓN DEL NOMBRE DEL PROFESOR
							do while (len(profesor[2])	>	25)
								if profesor[1]	=	"" then
									profesor[1]	=	mid(profesor[2],1,pos(profesor[2],' '))
								else
									profesor[1]	=	profesor[1]	+	" "	+	mid(profesor[2],1,pos(profesor[2],' '))
								end if
								profesor[2]	=	mid(profesor[2],pos(profesor[2],' ')+1)
							loop
							do while (len(profesor[1]) < 28)
								profesor[1]	=	profesor[1]+" "
							loop
							do while (len(profesor[2]) < 28)
								profesor[2]	=	profesor[2]+" "
							loop
							linea	=	linea	+	profesor[1]
							llena_linea_alumno(linea,band,cuenta,alumno,cont)			
		case	12	
							linea	=	linea	+	profesor[2]
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
 		case	16	
							depto[2]	=	ls_coordinaciones_coordinacion[1]//dw_act_eval.getitemstring(cont - 1,"coordinaciones_coordinacion")
							do while (len(depto[2])	>	25)
								if depto[1]	=	"" then
									depto[1]	=	mid(depto[2],1,pos(depto[2],' '))
								else
									depto[1]	=	depto[1]	+	" "	+	mid(depto[2],1,pos(depto[2],' '))
								end if
								depto[2]	=	mid(depto[2],pos(depto[2],' ')+1)
							loop
							do while (len(depto[1]) < 28)
								depto[1]	=	depto[1]+" "
							loop
							do while (len(depto[2]) < 28)
								depto[2]	=	depto[2]+" "
							loop
							linea	=	linea	+	depto[1]
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	17
							linea	=	linea	+	depto[2]
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	19			
							mat[3]	=	ls_materias_materia[1]//dw_act_eval.getitemstring(cont - 1,"materias_materia")
							if (len(mat[3])	>	25) then
								localiza	=	pos(mat[3],' ',10)
								if localiza	=	0 or localiza > 25 then localiza	= 25
								mat[2]	=	mid(mat[3],1,localiza)
								mat[3]	=	mid(mat[3],localiza+1)
								if (len(mat[3]) > 25)	then
//ERROR DE INDICE									mat[2] = mid(mat[2],1,25)
									mat[3] = mid(mat[3],1,25)
								end if
							end if
//							do while (len(mat[1]) < 28)
//								mat[1]	=	mat[1]+" "
//							loop
							do while (len(mat[2]) < 28)
								mat[2]	=	mat[2]+" "
							loop
							do while (len(mat[3]) < 28)
								mat[3]	=	mat[3]+" "
							loop

							linea	=	linea	+	mat[2]
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	20			
							linea	=	linea	+	mat[3]
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
//		case	21			
//							linea	=	linea	+	mat[3]
//							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	22			
//							if /*dw_act_eval.getitemstring(cont - 1,"materias_nivel")*/ls_materias_nivel[1]	=	'L'	then
//								nivel	=	"LICENCIATURA"
//							elseif /*dw_act_eval.getitemstring(cont - 1,"materias_nivel")*/ls_materias_nivel[1]	=	'P'	then
//								nivel	=	"POSGRADO    "
//							end if

							choose case ls_materias_nivel[1]
							case "L"
								nivel	=	"LICENCIATURA"
							case "P"
								nivel	=	"POSGRADO    "
							case "T"
								nivel	=	"TSU         "
							end choose
							
							linea	=	linea	+	tipo_eval	+	nivel	+	"   "
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	26			
							if per	=	0 then
								periodo	=	'P'
							elseif per		=	1	then
								periodo	=	'V'								
							elseif	per	=	2	then
								periodo	=	'O'								
							end if
							per_cve_gpo(year,periodo,cve_mat[1],gpo[1],linea)
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	27			
//							linea	=	linea +matrix_print[1]+"    "	
							linea	=	linea +matrix_print[1]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	28			
//							linea	=	linea +matrix_print[2]+"    "	
							linea	=	linea +matrix_print[2]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	29			
//							linea	=	linea +matrix_print[3]+"    "	
							linea	=	linea +matrix_print[3]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	30			
//							linea	=	linea +matrix_print[4]+"    "	
							linea	=	linea +matrix_print[4]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	31			
//							linea	=	linea +matrix_print[5]+"    "	
							linea	=	linea +matrix_print[5]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	32			
//							linea	=	linea +matrix_print[6]+"    "	
							linea	=	linea +matrix_print[6]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	33			
							obten_fecha_agrega_linea(linea,matrix_print[7])
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	36			
							inscritos	=	li_inscritos[1]//dw_act_eval.getitemnumber(cont - 1,"inscritos")
							acta_hoja_insc(acta,hojaT,inscritos,linea)
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	39			
//							linea	=	linea +matrix_print[11]+"    "	
							linea	=	linea +matrix_print[11]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	40			
//							linea	=	linea +matrix_print[12]+"    "	
							linea	=	linea +matrix_print[12]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case	41			
//							linea	=	linea +matrix_print[13]+"    "	
							linea	=	linea +matrix_print[13]+"  "	
							llena_linea_alumno(linea,band,cuenta,alumno,cont)
		case 42
//							linea	=	linea +matrix_print[14]+"    "
							linea	=	linea +matrix_print[14]+"  "
							llena_linea_alumno(linea,band,cuenta,alumno,cont)		
		case 44
			if band	=	0 then
				hojaT++
				row	=	0
				linea	=	linea	+	char(12)
				evaluacion = dw_act_eval.getitemstring(cont,"materias_evaluacion")
				evaluacion = trim(evaluacion)
				imprime_encabezado(linea, evaluacion,pla)
			elseif band 	=	1	then
				band	= 0
				linea	=	linea + char(12)
				cve_mat[1]	= cve_mat[2]
				gpo[1] =	gpo[2]
				
				ls_profesor_nombre_completo[1] = ls_profesor_nombre_completo[2]
				ls_coordinaciones_coordinacion[1] = ls_coordinaciones_coordinacion[2]
				ls_materias_nivel[1] = ls_materias_nivel[2]
				ls_materias_materia[1] = ls_materias_materia[2]
				li_inscritos[1] = li_inscritos[2] 
				
				
				row	=	0
				HojaT	=	1
				/*comentario*/acta++
				
//				int insc
				insc = dw_act_eval.getitemnumber(cont,"inscritos")
				if rb_ordinaria.checked = true then
					INSERT INTO actas_evaluacion VALUES(:cve_mat[1],:gpo[1],:acta,:insc,0) USING gtr_sce;
					COMMIT USING gtr_sce;
				end if
				evaluacion = dw_act_eval.getitemstring(cont,"materias_evaluacion")
				evaluacion = trim(evaluacion)
				imprime_encabezado(linea,evaluacion,pla)	
			elseif band	=	3	then
				linea	=	linea +char(12)
				filewrite(archivo,linea)
				exit
			end if			
			matrix	=	llenadebolitas(cve_mat[1],gpo[1],acta,hojaT,no_insc_hoja(dw_act_eval.getitemnumber(cont,"inscritos"),hojaT),year,per)
			llena_string_f_struct(matrix_print,matrix)
		case	else
			linea	=	linea +"                            "
			llena_linea_alumno(linea,band,cuenta,alumno,cont)
	end choose
//	if cont = dw_act_eval.rowcount() then
//		band = 3
//		if row = 46 then
//			exit		
//		end if
//	end if 
if isnull(linea) then linea = char(13)+char(10)
	filewrite(archivo,linea)
	st_txt.text = string(cont)+ " de "+string(dw_act_eval.rowcount())
	linea	=	""
next
end if
fileclose(archivo)
dw_act_eval.saveas(mid(path,1,len(path) - 3)+"act",Text! ,TRUE)

end event

public function integer no_insc_hoja (integer inscritos, integer hoja);if inscritos	>  43 then
	if hoja = 1 then		
		return 43
	else
		inscritos	=	inscritos	-	43
		return no_insc_hoja(inscritos,hoja - 1)
	end if
else
	return inscritos
end if
end function

public subroutine llena_linea_alumno (ref string linea, ref integer band, string cuenta, string alumno, ref long cont);//Función que decide si agregar el nombre del alumno y su cuenta o no
//Dependiendo del valor de Bandera
//Abril 1998	DkWf

if band = 0 then
	linea =	linea	+cuenta+alumno	//+char(10)+char(13)
	if cont = dw_act_eval.rowcount() then
		band = 3
	else
		cont ++		
	end if
/*elseif band	=	1 then
	linea	=	linea//	+	char(13)+char(10)
elseif band	=	3 then
	cont = dw_act_eval.rowcount()*/
end if


end subroutine

public subroutine imprime_encabezado (ref string linea, string evaluacion, string plantel);//Funcion que imprime el encabezado de las actas de evaluación
//Abril 1998 DkWf
//Plantel: "nombre del plantel"
string nomb_plant,encab
nomb_plant	= " Plantel: "+plantel+" Esta acta permite calificaciones de: "
choose case evaluacion
	case "ALFA"
	  nomb_plant +=   "***NA o AC***"
	case "ALIN"
		nomb_plant +=  "***NA o AC o IN***"
	case "NUIN"
		nomb_plant +=  "***5 o 6 o 7 o 8 o 9 o 10 o IN***"
	case "NUM"
		nomb_plant +=  "***5 o 6 o 7 o 8 o 9 o 10***"
end choose

linea = linea + nomb_plant+char(13)+char(10)

Do while (len(encab) < 80)
		encab = encab	+	" "	
Loop

//encab = encab + "CALIFICACION"
choose case evaluacion
	case "ALFA"
	  encab +=   "            * *"
	case "ALIN"
		encab +=  "            * * *"
	case "NUIN"
		encab +=  "* * * * * *     *"
	case "NUM"
		encab +=  "* * * * * *"
end choose

linea = linea + encab

end subroutine

public function bolas llenadebolitas (long cvemat, string gpo, integer numacta, integer hoja, integer inscritos, long year, integer periodo);Bolas Bolitas
int valor[7], limite[7], BolaX[7], BolaY[7],size[7]
int digito
int i, j, di, cve
for i =	1 to 7//INICIALIZACIÓN DEL CAMPO MAX DE TAMA&O
	if i	=	5 or i	=	6 then
		size[i]	=	6
	else
		size[i]	=	3		
	end if
next
if periodo	=	0 then//LLENADO DEL CAMPO DE PERIODO
	Bolitas.Bola[5,1]	=	1
elseif periodo	=	1	then
	Bolitas.Bola[5,2]	=	1	
elseif periodo =	2	then
	Bolitas.Bola[5,3]	=	1	
end if

valor[1]	=	cvemat
valor[2]	=	numacta
valor[3]	=	inscritos
valor[4]	=	hoja
valor[5]	=	asc(mid(gpo,1,1))
valor[6]	=	asc(mid(gpo,2,1))
valor[7] =  year
//valor[7]	=	integer(mid(string(year),3,2))

//limite[1] = 3; limite[2] = 4; limite[3] = 1
//***Correccion para materias de 5 digitos
limite[1] = 4; limite[2] = 4; limite[3] = 1
BolaX[1] = 7; BolaX[2] = 1; BolaX[3] = 9
BolaY[1] = 1; BolaY[2] = 11; BolaY[3] = 11

limite[4] = 0; limite[5] = 0; limite[6] = 0;limite[7] = 3
//BolaX[4] = 7; BolaX[5] = 11; BolaX[6] = 12;BolaX[7] =	1
//BolaY[4] = 11; BolaY[5] = 1; BolaY[6] = 1;BolaY[7] = 1
//***Correccion para materias de 5 digitos
BolaX[4] = 7; BolaX[5] = 12; BolaX[6] = 13;BolaX[7] =	1
BolaY[4] = 11; BolaY[5] = 1; BolaY[6] = 1;BolaY[7] = 1

for cve = 1 to 7
	for i = 0 to limite[cve]
		digito = truncate(valor[cve]/(10^(limite[cve] - i)), 0)
		if digito > 0 then
			for di = 0 to size[cve]
				if digito >= (2^(size[cve] - di)) then
					Bolitas.Bola[BolaX[cve]+i,BolaY[cve]+di] = 1
					digito -= (2^(size[cve] - di))
				end if
			next
			valor[cve] -= truncate(valor[cve]/(10^(limite[cve] - i)), 0)*(10^(limite[cve] - i))
		end if
	next
next
return Bolitas
end function

public subroutine per_cve_gpo (long year, string periodo, long cvemat, string gpo, ref string linea);string period_clave_gpo,cve
cve	=	string(cvemat)
do while(len(cve)<5)
	cve	=	"0"+cve
loop
period_clave_gpo	=	mid(string(year,"0000"),1,1)+" "+mid(string(year,"0000"),2,1)+" "+&
							mid(string(year,"0000"),3,1)+" "+mid(string(year,"0000"),4,1)+" "
//period_clave_gpo	=	mid(string(year),3,1)+" "+mid(string(year),4,1)+" "
period_clave_gpo	=	period_clave_gpo	+	periodo+	"   "
//***Correccion por 5 digitos
//period_clave_gpo	=	period_clave_gpo	+	mid(cve,1,1)+" "+mid(cve,2,1)+" "+mid(cve,3,1)+" "+mid(cve,4,1)+" "+mid(cve,5,1)+" "
period_clave_gpo	=	period_clave_gpo	+	mid(cve,1,1)+" "+mid(cve,2,1)+" "+mid(cve,3,1)+" "+mid(cve,4,1)+" "+mid(cve,5,1)+" "
period_clave_gpo	=	period_clave_gpo	+	mid(gpo,1,1)+" "+mid(gpo,2,1)

do while(len(period_clave_gpo)<23)
	period_clave_gpo	=	period_clave_gpo	+	" "
loop
//linea	=	linea	+	period_clave_gpo+"     "   
//***Correccion por 5 digitos
linea	=	linea	+	period_clave_gpo+"    "   
end subroutine

public subroutine llena_string_f_struct (ref string matrix_print[14], ref bolas matrix);//Función que llena un string a partir de la estructura
//Abril 1998	DkWf

int i,j
for i = 1 to 14
	matrix_print[i]	=	""
	for j=1 to 13
		if matrix.bola[j,i]	=	1 then
			matrix_print[i]	=	matrix_print[i]+"@ "
		else
			matrix_print[i]	=	matrix_print[i]+"  "
		end if
	next
next

//for i=1 to 14	
//	do while(len(matrix_print[i])<23)
//		matrix_print[i]	=	matrix_print[i]+" "
//	loop
//	matrix_print[i]	= matrix_print[i] + char(13)
//	for j = 1 to 23
//		if mid(matrix_print[i],j,1) = "@" then
//			matrix_print[i]	=	matrix_print[i]+ "#"
//		else
//			matrix_print[i]	=	matrix_print[i]+ " "
//		end if
//	next
//next

//matrix_print[7]	=	""
//if matrix.bola[9,7]	=	1 then
//	matrix_print[7]	=	"@ "
//elseif	matrix.bola[9,7]	=	0 then
//	matrix_print[7]	=	"  "	
//end if
//if matrix.bola[10,7]	=	1 then
//	matrix_print[7]	=	matrix_print[7]	+	"@ "
//elseif	matrix.bola[10,7]	=	0 then
//	matrix_print[7]	=	matrix_print[7]	+	"  "	
//end if
//do while(len(matrix_print[7])<8)
//	matrix_print[7]	=	matrix_print[7]+" "
//loop

end subroutine

public subroutine acta_hoja_insc (long acta, integer hoja, integer inscritos, ref string linea);string act_h_ins,act,ins
//int inscrit
act	=	string(acta)
do while (len(act)<5)
	act	=	'0'+act
loop
act_h_ins	=	mid(act,1,1)+" "+mid(act,2,1)+" "+mid(act,3,1)+" "+mid(act,4,1)+" "+mid(act,5,1)+"   "
act_h_ins	=	act_h_ins	+	string(hoja)+"   "


//inscrit	=	no_insc_hoja(inscritos,hoja)

ins	=	string(inscritos)
do while(len(ins)<2)
	ins	=	'0'+ins
loop
act_h_ins	=	act_h_ins	+	mid(ins,1,1)+" "+mid(ins,2,1)
do while(len(act_h_ins)<23)
	act_h_ins	=	act_h_ins	+	" "
loop

linea	=	linea	+	act_h_ins +"     "

end subroutine

public subroutine obten_fecha_agrega_linea (ref string linea, string matrix_print);string fecha
int j

fecha	=	string(today(),"dd mm yyyy ")


fecha	= fecha+mid(matrix_print,12)


//linea	=	linea	+ fecha+"    "
//*** Correccion por 5 digitos
linea	=	linea	+ fecha+"  "
end subroutine

public function integer wf_genera_actas_en_linea ();//wf_genera_actas_en_linea
//Descripción: Genera las tablas base para las actas en línea

long ll_cuenta
long ll_cve_mat, ll_cve_mat_anterior
string ls_gpo, ls_gpo_anterior
integer li_periodo
integer li_anio
long ll_cve_coordinacion
string ls_evaluacion
long ll_row_actual, ll_num_rows
long ll_orden_alumno =1
long ll_no_acta =0
string ls_nivel
string ls_cve_tipo_calificacion
integer li_cve_tipo_examen
integer li_cve_estatus_acta
integer li_status
integer li_inscritos_acta
long ll_cve_profesor
string ls_mensaje_sql, ls_mensaje_sql_2
integer li_codigo_sql, li_codigo_sql_2
integer li_inserta_acta_en_linea, li_inserta_alumno_acta_en_linea
integer li_es_fecha_baja_total, li_code_es_fecha_baja_total
long ll_num_actas_nivel
string ls_desc_nivel
integer li_cve_tipo_examen_ordinario = 3

string ls_array_nivel[]


li_periodo = gi_periodo
li_anio = gi_anio

ll_cve_mat_anterior = 0
ls_gpo_anterior = ""
li_cve_estatus_acta = 1
li_status = 0

li_code_es_fecha_baja_total = f_es_fecha_baja_total(li_periodo, li_anio, li_es_fecha_baja_total) 
if li_code_es_fecha_baja_total <> 0 then
	Messagebox("Error en validación de baja total","No es posible generar el archivo de actas",StopSign!)
	return -1
end if

if li_es_fecha_baja_total = 1 then
	Messagebox("Todavía son bajas totales","No es posible generar las actas en esta fecha,~n"+&
				" Sino hasta que concluyan las bajas totales",StopSign!)
	return -1
end if

//if rb_licenciatura.checked = true then
//	ls_nivel = 'L'
//	ls_desc_nivel = 'Licenciatura'
//else
//	ls_nivel = 'P'
//	ls_desc_nivel = 'Posgrado'
//end if

uo_nivel.of_obtiene_array( ls_array_nivel[] )

If UpperBound(ls_array_nivel[]) <> 1 Then
	MessageBox("Mensaje del Sistema", "No se puede leer el nivel: wf_genera_actas_en_linea", StopSign!)
	return -1
End If

ls_nivel = ls_array_nivel[1]
ls_desc_nivel = f_decodifica_nivel(ls_nivel) 
//choose case ls_nivel
//	case "L"
//		ls_desc_nivel = 'Licenciatura'
//	case "P"
//		ls_desc_nivel = 'Posgrado'
//	case "T"
//		ls_desc_nivel = 'TSU'
//end choose


ll_num_actas_nivel = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, ls_nivel, li_cve_tipo_examen_ordinario, gtr_sce)

if ll_num_actas_nivel= -1 then
	Messagebox("Error de Consulta","No es posible consultar las actas, probablemente por permisos",StopSign!)
	return -1	
end if

if ll_num_actas_nivel >0 then
	Messagebox("Actas ya generadas","Se encontraron["+string(ll_num_actas_nivel)+"] actas Ordinarias de ["+ls_desc_nivel+"] ya existentes.",StopSign!)
	return -1	
end if

ll_num_rows =dw_act_eval.retrieve(li_periodo, li_anio, ls_nivel)

if rb_ordinaria.checked = true then
//3	ORDINARIO
	li_cve_tipo_examen = 3
elseif rb_extraordinaria.checked = true then
//2	EXTRAORDINARIO
	li_cve_tipo_examen = 2
elseif rb_titulo_de_suf.checked = true then
//6	TIT. SUFICIENCIA
	li_cve_tipo_examen = 6
end if

for ll_row_actual=1 to ll_num_rows
	ll_cuenta           = dw_act_eval.GetItemNumber(ll_row_actual,"alumnos_cuenta")
	ll_cve_mat          = dw_act_eval.GetItemNumber(ll_row_actual,"mat_inscritas_cve_mat")
	ls_gpo              = dw_act_eval.GetItemString(ll_row_actual,"mat_inscritas_gpo")
	li_periodo          = dw_act_eval.GetItemNumber(ll_row_actual,"mat_inscritas_periodo")
	li_anio             = dw_act_eval.GetItemNumber(ll_row_actual,"mat_inscritas_anio")
	ll_cve_coordinacion = dw_act_eval.GetItemNumber(ll_row_actual,"coordinaciones_cve_coordinacion")
	ls_evaluacion       = dw_act_eval.GetItemString(ll_row_actual,"materias_evaluacion")
	ll_cve_profesor 	  = dw_act_eval.GetItemNumber(ll_row_actual,"cve_profesor")
	li_inscritos_acta   = dw_act_eval.GetItemNumber(ll_row_actual,"inscritos")
	ls_nivel 			  = dw_act_eval.GetItemString(ll_row_actual,"materias_nivel")
	
	ls_cve_tipo_calificacion = ls_evaluacion
	
	if mod(ll_row_actual,100)= 0 then
		st_txt.text = string(ll_row_actual)+"/"+string(ll_num_rows)
	end if
	//Si cambió el grupo
 	if (ll_cve_mat <> ll_cve_mat_anterior or ls_gpo<>ls_gpo_anterior) then
//Incrementa el folio del acta
		ll_no_acta = ll_no_acta +1		
//	Inserta una nueva acta
		li_inserta_acta_en_linea = f_inserta_acta_en_linea(ll_cve_mat, ls_gpo, li_periodo, li_anio,&
			ll_no_acta, li_cve_tipo_examen, ls_nivel, ll_cve_profesor, li_inscritos_acta, li_status,&			
			ls_cve_tipo_calificacion, li_cve_estatus_acta) 

		IF li_inserta_acta_en_linea <> 0 THEN
			RETURN li_inserta_acta_en_linea		
		END IF

		ll_orden_alumno = 1
	end if
//Inserta a un alumno en el acta	
	li_inserta_alumno_acta_en_linea = f_inserta_alumno_acta_en_linea(ll_cve_mat, ls_gpo, li_periodo, li_anio,&
		ll_no_acta, li_cve_tipo_examen, ls_nivel, ll_cuenta, ll_orden_alumno)

	IF li_inserta_alumno_acta_en_linea <> 0 THEN
		RETURN li_inserta_alumno_acta_en_linea		
	END IF	
	
	//Asigna las variables de matera y grupo anterior
	ll_cve_mat_anterior = ll_cve_mat
	ls_gpo_anterior = ls_gpo
	ll_orden_alumno = ll_orden_alumno +1
next
st_txt.text = string(ll_row_actual)+"/"+string(ll_num_rows)
return 0
end function

public function integer wf_asigna_profesores_por_designar ();//wf_asigna_profesores_por_designar
long ll_rows_por_designar, ll_row_actual_por_designar, ll_cve_mat
integer li_code_es_fecha_baja_total, li_periodo, li_anio, li_es_fecha_baja_total
string ls_nivel,	ls_desc_nivel, ls_gpo
integer ll_cve_profesor_por_designar = 1
long ll_rows_asignatura_movtos, ll_row_actual_asignatura, ll_cve_profesor_movtos, ll_cve_coordinador
long ll_cve_profesor_sustituto
integer li_acta_per_nivel_profesor, li_es_coordinador
integer li_saveas
string ls_array_nivel[]

li_periodo = gi_periodo
li_anio = gi_anio


li_code_es_fecha_baja_total = f_es_fecha_baja_total(li_periodo, li_anio, li_es_fecha_baja_total) 
if li_code_es_fecha_baja_total <> 0 then
	Messagebox("Error en validación de baja total","No es posible generar el archivo de actas",StopSign!)
	return -1
end if

if li_es_fecha_baja_total = 1 then
	Messagebox("Todavía son bajas totales","No es posible generar las actas en esta fecha,~n"+&
				" Sino hasta que concluyan las bajas totales",StopSign!)
	return -1
end if

//if rb_licenciatura.checked = true then
//	ls_nivel = 'L'
//	ls_desc_nivel = 'Licenciatura'
//else
//	ls_nivel = 'P'
//	ls_desc_nivel = 'Posgrado'
//end if

uo_nivel.of_obtiene_array( ls_array_nivel[] )

If UpperBound(ls_array_nivel[]) <> 1 Then
	MessageBox("Error", "No se puede leer el nivel: wf_asigna_profesores_por_designar", StopSign!)
	return -1
End If

ls_nivel = ls_array_nivel[1]
ls_desc_nivel = f_decodifica_nivel(ls_nivel) 
//choose case ls_nivel
//	case "L"
//		ls_desc_nivel = 'Licenciatura'
//	case "P"
//		ls_desc_nivel = 'Posgrado'
//	case "T"
//		ls_desc_nivel = 'TSU'
//end choose


ll_rows_por_designar = dw_acta_per_nivel_profesor.Retrieve(li_periodo, li_anio, ls_nivel,ll_cve_profesor_por_designar )

for ll_row_actual_por_designar=1 to ll_rows_por_designar
	ll_cve_mat = dw_acta_per_nivel_profesor.GetItemNumber(ll_row_actual_por_designar,"cve_mat")
	ls_gpo= dw_acta_per_nivel_profesor.GetItemString(ll_row_actual_por_designar,"gpo")
	li_es_coordinador = 0
	ll_rows_asignatura_movtos =dw_asignatura_movtos.Retrieve(ll_cve_mat, ls_gpo, li_periodo, li_anio)
	if ll_rows_asignatura_movtos= -1 then
		MessageBox("Error al consultar movimientos de asignatura","No es posible consultar["+string(ll_cve_mat)+"-"+ls_gpo+"]",Stopsign!)
		return -1
	elseif ll_rows_asignatura_movtos> 0 then
		ll_row_actual_asignatura = 1
		ll_cve_profesor_movtos = dw_asignatura_movtos.GetItemNumber(ll_row_actual_asignatura,"profesor")
		ll_cve_profesor_sustituto = ll_cve_profesor_movtos
	elseif ll_rows_asignatura_movtos= 0 then
		ll_cve_coordinador = f_obten_coord_de_materia(ll_cve_mat)
		if ll_cve_coordinador= -1 then
			MessageBox("Error al consultar coordinador de materia","No es posible consultar ["+string(ll_cve_mat)+"-"+ls_gpo+"]",Stopsign!)
			return -1			
		end if
		ll_cve_profesor_sustituto = ll_cve_coordinador
		li_es_coordinador = 1
	else
		MessageBox("Error al consultar movimientos de asignatura","+No es posible consultar ["+string(ll_cve_mat)+"-"+ls_gpo+"]",Stopsign!)
		return -1
	end if
	dw_acta_per_nivel_profesor.SetItem(ll_row_actual_por_designar,"cve_profesor",ll_cve_profesor_sustituto )
	dw_acta_per_nivel_profesor.SetItem(ll_row_actual_por_designar,"cve_profesor_rh",ll_cve_profesor_por_designar )
	dw_acta_per_nivel_profesor.SetItem(ll_row_actual_por_designar,"es_coordinador",li_es_coordinador )
next

li_acta_per_nivel_profesor = dw_acta_per_nivel_profesor.Update()
if li_acta_per_nivel_profesor = 1 then
	commit using gtr_sce;
	MessageBox("Actualización de Profesores por designar exitosa","Se actualizaron ["+string(ll_rows_por_designar)+"] de ["+ls_desc_nivel+"]",Information!)
	li_saveas = dw_acta_per_nivel_profesor.SaveAs("", Excel8!, TRUE	)
	if li_saveas = 1 then
		MessageBox("Archivo Almacenado Exitosamente", "Se ha generado el archivo con la reasignación de profesores", Information!)
	end if
else
	rollback using gtr_sce;
	MessageBox("Error al Actualizar Profesores por designar","+No es posible actualizar.",Stopsign!)
	return -1
end if




return 0

end function

protected function integer wf_genera_actas_ets ();//wf_genera_actas_ets
//Descripción: Genera las tablas base para las actas en línea

long ll_cuenta
long ll_cve_mat, ll_cve_mat_anterior
string ls_gpo, ls_gpo_anterior
integer li_periodo
integer li_anio
long ll_cve_coordinacion
string ls_evaluacion
long ll_row_actual, ll_num_rows
long ll_orden_alumno =1
long ll_no_acta =0
string ls_nivel, ls_nivel_todos = 'T'
string ls_cve_tipo_calificacion
integer li_cve_tipo_examen
integer li_cve_estatus_acta
integer li_status
integer li_inscritos_acta
long ll_cve_profesor
string ls_mensaje_sql, ls_mensaje_sql_2
integer li_codigo_sql, li_codigo_sql_2
integer li_inserta_acta_en_linea, li_inserta_alumno_acta_en_linea
integer li_es_fecha_menor_ets, li_code_es_fecha_baja_total
long ll_num_actas_nivel, ll_num_actas_extra, ll_num_actas_tit
string ls_desc_nivel
integer li_cve_tipo_examen_extra = 2
integer li_cve_tipo_examen_tit = 6
string ls_array_nivel[]

li_periodo = gi_periodo
li_anio = gi_anio

ll_cve_mat_anterior = 0
ls_gpo_anterior = ""
li_cve_estatus_acta = 1
li_status = 0

li_code_es_fecha_baja_total = f_es_fecha_menor_aplicacion_ets(li_periodo, li_anio, li_es_fecha_menor_ets) 
if li_code_es_fecha_baja_total <> 0 then
	Messagebox("Error en validación de Aplicación Extraordinario y a Título de Suf.","No es posible generar el proceso de actas",StopSign!)
	return -1
end if

if li_es_fecha_menor_ets = 0 then
	Messagebox("Ya son fechas de Aplicación Extraordinario y a Título de Suf.","No es posible generar las actas en esta fecha,~n"+&
				"Solo se permite antes de aplicar los exámenes",StopSign!)
	return -1
end if

//if rb_licenciatura.checked = true then
//	ls_nivel = 'L'
//	ls_desc_nivel = 'Licenciatura'
//else
//	ls_nivel = 'P'
//	ls_desc_nivel = 'Posgrado'
//end if

uo_nivel.of_obtiene_array( ls_array_nivel[] )

If UpperBound(ls_array_nivel[]) <> 1 Then
	MessageBox("Mensaje del Sistema", "No se puede leer el nivel: wf_genera_actas_ets", StopSign!)
	return -1
End If

ls_nivel = ls_array_nivel[1]
ls_desc_nivel = f_decodifica_nivel(ls_nivel) 
//choose case ls_nivel
//	case "L"
//		ls_desc_nivel = 'Licenciatura'
//	case "P"
//		ls_desc_nivel = 'Posgrado'
//	case "T"
//		ls_desc_nivel = 'TSU'
//end choose

if rb_ordinaria.checked = true then
//3	ORDINARIO
	li_cve_tipo_examen = 3
elseif rb_extraordinaria.checked = true then
//2	EXTRAORDINARIO
	li_cve_tipo_examen = 2
elseif rb_titulo_de_suf.checked = true then
//6	TIT. SUFICIENCIA
	li_cve_tipo_examen = 6
end if

ll_num_actas_extra = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, ls_nivel, li_cve_tipo_examen_extra, gtr_sce)

ll_num_actas_tit = f_num_actas_nivel_tipo_examen(li_periodo, li_anio, ls_nivel, li_cve_tipo_examen_tit, gtr_sce)


if ll_num_actas_extra= -1 then
	Messagebox("Error de Consulta","No es posible consultar las actas a Extraordinario, probablemente por permisos",StopSign!)
	return -1	
end if

if ll_num_actas_tit= -1 then
	Messagebox("Error de Consulta","No es posible consultar las actas a Título, probablemente por permisos",StopSign!)
	return -1	
end if

if li_cve_tipo_examen = 2 then
	if ll_num_actas_extra >0 then
		Messagebox("Actas ya generadas","Se encontraron["+string(ll_num_actas_extra)+"] actas de Extraordinario de ["+ ls_desc_nivel +"] ya existentes.",StopSign!)
		return -1	
	end if
end if 

if li_cve_tipo_examen = 6 then
	if ll_num_actas_tit >0 then
		Messagebox("Actas ya generadas","Se encontraron["+string(ll_num_actas_tit)+"] actas A Título de Suficiencia de ["+ ls_desc_nivel +"] ya existentes.",StopSign!)
		return -1	
	end if
end if

//Obtiene las actas ya existentes
ll_num_rows =dw_act_eval.retrieve(li_periodo, li_anio, ls_nivel, li_cve_tipo_examen)


for ll_row_actual=1 to ll_num_rows
	ll_cuenta           = dw_act_eval.GetItemNumber(ll_row_actual,"alumnos_cuenta")
	ll_cve_mat          = dw_act_eval.GetItemNumber(ll_row_actual,"mat_inscritas_cve_mat")
	ls_gpo              = dw_act_eval.GetItemString(ll_row_actual,"mat_inscritas_gpo")
	li_periodo          = dw_act_eval.GetItemNumber(ll_row_actual,"mat_inscritas_periodo")
	li_anio             = dw_act_eval.GetItemNumber(ll_row_actual,"mat_inscritas_anio")
	ll_cve_coordinacion = dw_act_eval.GetItemNumber(ll_row_actual,"coordinaciones_cve_coordinacion")
	ls_evaluacion       = dw_act_eval.GetItemString(ll_row_actual,"materias_evaluacion")
	ll_cve_profesor 	  = dw_act_eval.GetItemNumber(ll_row_actual,"profesor_cve_profesor")
	li_inscritos_acta   = dw_act_eval.GetItemNumber(ll_row_actual,"inscritos")
	li_cve_tipo_examen  = dw_act_eval.GetItemNumber(ll_row_actual,"grupo_sinodal_ets_tipo_examen")
	ls_cve_tipo_calificacion = ls_evaluacion
	
	if mod(ll_row_actual,100)= 0 then
		st_txt.text = string(ll_row_actual)+"/"+string(ll_num_rows)
	end if
	//Si cambió el grupo
 	if (ll_cve_mat <> ll_cve_mat_anterior or ls_gpo<>ls_gpo_anterior) then
//Incrementa el folio del acta
		ll_no_acta = ll_no_acta +1		
//	Inserta una nueva acta
		li_inserta_acta_en_linea = f_inserta_acta_en_linea(ll_cve_mat, ls_gpo, li_periodo, li_anio,&
			ll_no_acta, li_cve_tipo_examen, ls_nivel, ll_cve_profesor, li_inscritos_acta, li_status,&			
			ls_cve_tipo_calificacion, li_cve_estatus_acta) 

		IF li_inserta_acta_en_linea <> 0 THEN
			RETURN li_inserta_acta_en_linea		
		END IF

		ll_orden_alumno = 1
	end if
//Inserta a un alumno en el acta	
	li_inserta_alumno_acta_en_linea = f_inserta_alumno_acta_en_linea(ll_cve_mat, ls_gpo, li_periodo, li_anio,&
		ll_no_acta, li_cve_tipo_examen, ls_nivel, ll_cuenta, ll_orden_alumno)

	IF li_inserta_alumno_acta_en_linea <> 0 THEN
		RETURN li_inserta_alumno_acta_en_linea		
	END IF	
	
	//Asigna las variables de matera y grupo anterior
	ll_cve_mat_anterior = ll_cve_mat
	ls_gpo_anterior = ls_gpo
	ll_orden_alumno = ll_orden_alumno +1
next
st_txt.text = string(ll_row_actual)+"/"+string(ll_num_rows)
return 0
end function

on w_generador_actas_en_linea.create
int iCurrent
call super::create
if this.MenuName = "m_gen_actas_en_linea" then this.MenuID = create m_gen_actas_en_linea
this.uo_nivel=create uo_nivel
this.rb_ets_lp=create rb_ets_lp
this.cb_guardar_como=create cb_guardar_como
this.cb_imprimir=create cb_imprimir
this.dw_asignatura_movtos=create dw_asignatura_movtos
this.dw_acta_per_nivel_profesor=create dw_acta_per_nivel_profesor
this.rb_titulo_de_suf=create rb_titulo_de_suf
this.rb_extraordinaria=create rb_extraordinaria
this.rb_ordinaria=create rb_ordinaria
this.rb_posgrado=create rb_posgrado
this.rb_licenciatura=create rb_licenciatura
this.uo_1=create uo_1
this.st_txt=create st_txt
this.dw_act_eval=create dw_act_eval
this.gb_2=create gb_2
this.tab_1=create tab_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nivel
this.Control[iCurrent+2]=this.rb_ets_lp
this.Control[iCurrent+3]=this.cb_guardar_como
this.Control[iCurrent+4]=this.cb_imprimir
this.Control[iCurrent+5]=this.dw_asignatura_movtos
this.Control[iCurrent+6]=this.dw_acta_per_nivel_profesor
this.Control[iCurrent+7]=this.rb_titulo_de_suf
this.Control[iCurrent+8]=this.rb_extraordinaria
this.Control[iCurrent+9]=this.rb_ordinaria
this.Control[iCurrent+10]=this.rb_posgrado
this.Control[iCurrent+11]=this.rb_licenciatura
this.Control[iCurrent+12]=this.uo_1
this.Control[iCurrent+13]=this.st_txt
this.Control[iCurrent+14]=this.dw_act_eval
this.Control[iCurrent+15]=this.gb_2
this.Control[iCurrent+16]=this.tab_1
this.Control[iCurrent+17]=this.gb_1
end on

on w_generador_actas_en_linea.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nivel)
destroy(this.rb_ets_lp)
destroy(this.cb_guardar_como)
destroy(this.cb_imprimir)
destroy(this.dw_asignatura_movtos)
destroy(this.dw_acta_per_nivel_profesor)
destroy(this.rb_titulo_de_suf)
destroy(this.rb_extraordinaria)
destroy(this.rb_ordinaria)
destroy(this.rb_posgrado)
destroy(this.rb_licenciatura)
destroy(this.uo_1)
destroy(this.st_txt)
destroy(this.dw_act_eval)
destroy(this.gb_2)
destroy(this.tab_1)
destroy(this.gb_1)
end on

event open;x=1
y=1

dw_acta_per_nivel_profesor.SetTransObject(gtr_sce)
dw_asignatura_movtos.SetTransObject(gtr_sce)

uo_nivel.of_carga_control(gtr_sce)

il_inicia_acceso = 1
end event

type uo_nivel from uo_nivel_2013 within w_generador_actas_en_linea
integer x = 1134
integer y = 276
integer taborder = 30
end type

on uo_nivel.destroy
call uo_nivel_2013::destroy
end on

type rb_ets_lp from radiobutton within w_generador_actas_en_linea
boolean visible = false
integer x = 128
integer y = 528
integer width = 759
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Extraordinario y a Título"
end type

event clicked;dw_act_eval.DataObject = "dw_datos_gpo_alumno_mat_ets"
dw_act_eval.SetTransObject(gtr_sce)

rb_ordinaria.Checked = FALSE
rb_extraordinaria.Checked = FALSE

This.Checked = TRUE

end event

type cb_guardar_como from commandbutton within w_generador_actas_en_linea
integer x = 3675
integer y = 1892
integer width = 430
integer height = 100
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar Como..."
end type

event clicked;integer li_saveas

li_saveas = dw_acta_per_nivel_profesor.SaveAs("", Excel8!, TRUE	)

if li_saveas = 1 then
	MessageBox("Archivo Almacenado Exitosamente", "Se ha generado el archivo con la reasignación de profesores", Information!)
end if
end event

type cb_imprimir from commandbutton within w_generador_actas_en_linea
integer x = 3712
integer y = 1624
integer width = 357
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;integer li_confirmacion, li_print

li_confirmacion = MessageBox("Confirmación", "¿Desea imprimir los Profesores por designar?", Question!, YesNo!)

IF li_confirmacion <> 1 THEN	
	return
END IF


li_print = dw_acta_per_nivel_profesor.Print()

if li_print = 1 then
	MessageBox("Impresión Exitosa", "Favor de recoger la impresion", Information!)
end if
end event

type dw_asignatura_movtos from datawindow within w_generador_actas_en_linea
integer x = 64
integer y = 2188
integer width = 3570
integer height = 400
integer taborder = 70
string title = "none"
string dataobject = "d_asignatura_movtos_grupo_periodo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type dw_acta_per_nivel_profesor from datawindow within w_generador_actas_en_linea
integer x = 64
integer y = 1780
integer width = 3570
integer height = 368
integer taborder = 60
string title = "none"
string dataobject = "d_acta_per_nivel_profesor"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type rb_titulo_de_suf from radiobutton within w_generador_actas_en_linea
integer x = 123
integer y = 512
integer width = 613
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Titulo de Suficiencia"
end type

event clicked;dw_act_eval.DataObject = "dw_datos_gpo_alumno_mat_ets"
dw_act_eval.SetTransObject(gtr_sce)

rb_ordinaria.Checked = FALSE
rb_extraordinaria.Checked = FALSE

This.Checked = TRUE

end event

type rb_extraordinaria from radiobutton within w_generador_actas_en_linea
integer x = 123
integer y = 436
integer width = 613
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Extraordinaria"
end type

event clicked;dw_act_eval.DataObject = "dw_datos_gpo_alumno_mat_ets"
dw_act_eval.SetTransObject(gtr_sce)

rb_ordinaria.Checked = FALSE
rb_titulo_de_suf.Checked = FALSE

This.Checked = TRUE

end event

type rb_ordinaria from radiobutton within w_generador_actas_en_linea
integer x = 123
integer y = 360
integer width = 613
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12639424
string text = "Ordinaria"
boolean checked = true
end type

event clicked;//dw_act_eval.DataObject = "dw_datos_gpo_alumno_mat"
dw_act_eval.DataObject = "dw_datos_gpo_alumno_mat_en_linea"
dw_act_eval.SetTransObject(gtr_sce)

rb_extraordinaria.Checked = FALSE
rb_titulo_de_suf.Checked = FALSE

This.Checked = TRUE


end event

type rb_posgrado from radiobutton within w_generador_actas_en_linea
boolean visible = false
integer x = 3163
integer y = 400
integer width = 334
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217739
string text = "Posgrado"
end type

type rb_licenciatura from radiobutton within w_generador_actas_en_linea
boolean visible = false
integer x = 3163
integer y = 328
integer width = 402
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 134217739
string text = "Licenciatura"
boolean checked = true
end type

type uo_1 from uo_per_ani within w_generador_actas_en_linea
integer x = 73
integer y = 636
integer width = 1253
integer height = 168
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_txt from statictext within w_generador_actas_en_linea
integer x = 2025
integer y = 712
integer width = 1362
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 16777215
boolean enabled = false
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

type dw_act_eval from datawindow within w_generador_actas_en_linea
event genera_reporte ( )
integer x = 64
integer y = 848
integer width = 3570
integer height = 884
integer taborder = 50
string dataobject = "dw_datos_gpo_alumno_mat_en_linea"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event retrieveend;//long cont,val
//if dataobject = "dw_datos_gpo_alumno_mat_reporte" then
//	val	=	1
//	setitem(1,"acta",val)
//	val++
//	for cont = 2 to rowcount()
//		if getitemstring(cont,"grupos_cve_mat_gpo")=getitemstring(cont - 1,"grupos_cve_mat_gpo")	then
//			setitem(cont,"acta",val)		
//		else		
//			setitem(cont,"acta",val)
//			val++
//		end if
//		scrolltorow(cont)
//	next
//end if
end event

event constructor;m_gen_actas_en_linea.dw	=	this
end event

type gb_2 from groupbox within w_generador_actas_en_linea
boolean visible = false
integer x = 3141
integer y = 248
integer width = 553
integer height = 236
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 134217739
string text = "Nivel"
end type

type tab_1 from tab within w_generador_actas_en_linea
integer x = 105
integer y = 16
integer width = 2254
integer height = 240
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_3)
end on

event selectionchanged;string ls_array_nivel[], ls_nivel
integer li_result

If newindex	=	2 Then
	li_result = uo_nivel.of_carga_arreglo_nivel( )
	uo_nivel.of_obtiene_array( ls_array_nivel[] )

	If li_result = - 1 Then
		MessageBox("Mensaje del Sistema", "Error al ejecutar uo_nivel.of_carga_arreglo_nivel en tab_1.selectionchanged", StopSign!)
		return
	End If
	
	If UpperBound(ls_array_nivel[]) <= 0 Then
		MessageBox("Mensaje del Sistema", "Debe seleccionar un nivel", StopSign!)
		return
	End If
	
	If UpperBound(ls_array_nivel[]) > 1 Then
		MessageBox("Mensaje del Sistema", "Solo puede seleccionar un nivel", StopSign!)
		return
	End If
	
	ls_nivel = ls_array_nivel[1]
End If

if newindex	=	1 then
	dw_act_eval.dataobject="dw_datos_gpo_alumno_mat_en_linea"
	dw_act_eval.settransobject(gtr_sce)
elseif newindex	=	2 then	
	dw_act_eval.dataobject="dw_datos_gpo_alumno_mat_reporte"	
	dw_act_eval.settransobject(gtr_sce)
//	if rb_licenciatura.checked = true then
//		dw_act_eval.retrieve(gi_periodo,gi_anio,"L")
//	else
//		dw_act_eval.retrieve(gi_periodo,gi_anio,"P")
//	end if
	dw_act_eval.retrieve(gi_periodo, gi_anio, ls_nivel)
end if

//dw_act_eval.retrieve(gi_periodo,gi_anio,"L")
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2217
integer height = 112
long backcolor = 134217728
string text = "Genera Todas las Actas"
long tabbackcolor = 26964016
string picturename = "Custom024!"
long picturemaskcolor = 553648127
end type

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 112
integer width = 2217
integer height = 112
long backcolor = 134217728
string text = "Genera reportes"
long picturemaskcolor = 536870912
cb_1 cb_1
end type

on tabpage_3.create
this.cb_1=create cb_1
this.Control[]={this.cb_1}
end on

on tabpage_3.destroy
destroy(this.cb_1)
end on

type cb_1 from commandbutton within tabpage_3
integer x = 1815
integer y = 12
integer width = 325
integer height = 108
integer taborder = 12
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga"
end type

event clicked;integer li_cve_tipo_examen, li_result
string ls_array_nivel[], ls_nivel

li_result = uo_nivel.of_carga_arreglo_nivel( )
uo_nivel.of_obtiene_array( ls_array_nivel[] )

If li_result = - 1 Then
	MessageBox("Mensaje del Sistema", "Error al ejecutar uo_nivel.of_carga_arreglo_nivel en cb_1.clicked", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) <= 0 Then
	MessageBox("Mensaje del Sistema", "Debe seleccionar un nivel", StopSign!)
	return
End If

If UpperBound(ls_array_nivel[]) > 1 Then
	MessageBox("Mensaje del Sistema", "Solo puede seleccionar un nivel", StopSign!)
	return
End If

ls_nivel = ls_array_nivel[1]

if rb_extraordinaria.checked or  rb_titulo_de_suf.checked then
	if rb_extraordinaria.checked then
		dw_act_eval.dataobject = 'd_reportesactas_ets'
		li_cve_tipo_examen = 2
		dw_act_eval.SetTransObject(gtr_sce)
	elseif rb_titulo_de_suf.checked then
		dw_act_eval.dataobject = 'd_reportesactas_ets'
		li_cve_tipo_examen = 6
		dw_act_eval.SetTransObject(gtr_sce)
	end if
//	if rb_licenciatura.checked = true then
//			dw_act_eval.retrieve(gi_anio, gi_periodo, "L", li_cve_tipo_examen)
//	else
//			dw_act_eval.retrieve(gi_anio, gi_periodo, "P", li_cve_tipo_examen)
//	end if	
	dw_act_eval.retrieve(gi_anio, gi_periodo, ls_nivel, li_cve_tipo_examen)
else
//	if rb_licenciatura.checked = true then
//			dw_act_eval.retrieve(gi_periodo,gi_anio,"L")
//	else
//			dw_act_eval.retrieve(gi_periodo,gi_anio,"P")
//	end if
	dw_act_eval.retrieve(gi_periodo ,gi_anio, ls_nivel)
end if
end event

type gb_1 from groupbox within w_generador_actas_en_linea
integer x = 96
integer y = 284
integer width = 832
integer height = 352
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 16777215
string text = "Tipo de evaluación"
end type

