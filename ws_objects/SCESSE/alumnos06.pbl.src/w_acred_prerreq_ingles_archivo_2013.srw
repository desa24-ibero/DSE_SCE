$PBExportHeader$w_acred_prerreq_ingles_archivo_2013.srw
forward
global type w_acred_prerreq_ingles_archivo_2013 from w_master_main
end type
type uo_1 from uo_per_ani within w_acred_prerreq_ingles_archivo_2013
end type
type st_texto_ruta from u_st within w_acred_prerreq_ingles_archivo_2013
end type
type sle_ruta_archivo from u_sle within w_acred_prerreq_ingles_archivo_2013
end type
type pb_archivo from picturebutton within w_acred_prerreq_ingles_archivo_2013
end type
type dw_cuentas_archivo_prerreq from uo_master_dw within w_acred_prerreq_ingles_archivo_2013
end type
type pb_cargar from picturebutton within w_acred_prerreq_ingles_archivo_2013
end type
type dw_prerrequisito_cuentas from uo_master_dw within w_acred_prerreq_ingles_archivo_2013
end type
type pb_materias from picturebutton within w_acred_prerreq_ingles_archivo_2013
end type
type gb_1 from groupbox within w_acred_prerreq_ingles_archivo_2013
end type
type gb_2 from groupbox within w_acred_prerreq_ingles_archivo_2013
end type
type gb_3 from groupbox within w_acred_prerreq_ingles_archivo_2013
end type
type gb_4 from groupbox within w_acred_prerreq_ingles_archivo_2013
end type
end forward

global type w_acred_prerreq_ingles_archivo_2013 from w_master_main
integer width = 3611
integer height = 2632
string title = "Acreditación de Prerrequisto de Inglés por Archivo"
uo_1 uo_1
st_texto_ruta st_texto_ruta
sle_ruta_archivo sle_ruta_archivo
pb_archivo pb_archivo
dw_cuentas_archivo_prerreq dw_cuentas_archivo_prerreq
pb_cargar pb_cargar
dw_prerrequisito_cuentas dw_prerrequisito_cuentas
pb_materias pb_materias
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_acred_prerreq_ingles_archivo_2013 w_acred_prerreq_ingles_archivo_2013

type variables
string is_nombre_archivo

end variables

forward prototypes
public function integer wf_carga_prerreq_alumnos ()
end prototypes

public function integer wf_carga_prerreq_alumnos ();//Carga los prerrequisitos de los alumnos
integer li_return_carga
string ls_mensaje 
long ll_cuentas[], ll_row, ll_rows, ll_cuenta, ll_row2, ll_rows2
long ll_found, ll_row_insert
String  	Nivel
Long 	Plan, Carrera, ll_cve_mat
Integer li_carrera_plan,  ll_cve_carrera, ll_cve_plan

dw_cuentas_archivo_prerreq.Reset()
li_return_carga = dw_cuentas_archivo_prerreq.ImportFile(is_nombre_archivo)

//Valida que no haya cuentas 0 o vacias
IF li_return_carga> 0 THEN
	ll_rows = dw_cuentas_archivo_prerreq.RowCount()
	FOR ll_row = 1 TO ll_rows
		ll_cuenta = dw_cuentas_archivo_prerreq.GetItemNumber(ll_row, "cuenta")
		IF ll_cuenta= 0 OR ISNULL(ll_cuenta) THEN
			li_return_carga= -4
		END IF
	NEXT
END IF

IF li_return_carga  < 0 THEN
	
	CHOOSE CASE li_return_carga
		CASE -1  
			ls_mensaje = "No hay registros"
		CASE -2  
			ls_mensaje = "Archivo Vacío"
		CASE -3  
			ls_mensaje = "Argumento Inválido"
		CASE -4  
			ls_mensaje = "Entrada Invalida"
		CASE -5  
			ls_mensaje = "No es posible abrir el archivo"
		CASE -6  
			ls_mensaje = "No es posible cerrar el archivo"
		CASE -7  
			ls_mensaje = "Error leyendo el archivo"
		CASE -8  
			ls_mensaje = "No es un archivo TXT"
		CASE -9  
			ls_mensaje = "El usuario canceló la importación"
		CASE -10
			ls_mensaje = "Formato de archivo dBase no soportado (not version 2 or 3)"
		CASE -11 
			ls_mensaje = "XML Parsing Error; XML parser libraries not found or XML not well formed"
		CASE -12
			ls_mensaje = "XML Template does not exist or does not match the DataWindow"
		CASE -13
			ls_mensaje = "Unsupported DataWindow style for import"
		CASE -14
			ls_mensaje = "Error resolving DataWindow nesting"
		CASE ELSE
			ls_mensaje = "Error desconocido"
	END CHOOSE
	MessageBox("Error en la carga del archivo", ls_mensaje, StopSign!)
	dw_cuentas_archivo_prerreq.Reset()
	RETURN -1	
END IF

// Se tma la clave de la materia inglés de la tabla de requisitos. 
SELECT TOP 1 cve_mat  
INTO :ll_cve_mat  
FROM materias_requisito 
WHERE id_prerrequisito = 'ING' 
USING gtr_sce;
//ll_cve_mat = 4078

ll_rows = dw_cuentas_archivo_prerreq.RowCount()
FOR ll_row = 1 TO ll_rows
	ll_cuenta = dw_cuentas_archivo_prerreq.GetItemNumber(ll_row, "cuenta")
	ll_cuentas[ll_row] = ll_cuenta
NEXT

ll_rows2 = dw_prerrequisito_cuentas.Retrieve(ll_cuentas)

FOR ll_row = 1 TO ll_rows
	ll_cuenta = dw_cuentas_archivo_prerreq.GetItemNumber(ll_row, "cuenta")
	ll_found  = dw_prerrequisito_cuentas.Find("cuenta ="+string(ll_cuenta), 1, ll_rows)
	li_carrera_plan = obten_carrera_plan(ll_cuenta, ll_cve_carrera , ll_cve_plan)
	
	IF li_carrera_plan = 1 THEN
		dw_prerrequisito_cuentas.Reset()
		RETURN -1
	END IF
	
	IF ll_found<=0 THEN
		ll_row_insert = dw_prerrequisito_cuentas.InsertRow(0)
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "cuenta", ll_cuenta)
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "cve_mat", ll_cve_mat) 
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "cve_plan", ll_cve_plan) 
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "cve_carrera", ll_cve_carrera)      
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "gpo", "Z")      
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "calificacion", "AC")      
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "periodo", gi_periodo)      
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "anio", gi_anio)      
		dw_prerrequisito_cuentas.SetItem(ll_row_insert, "observacion", 3) //Ordinario     
	ELSE
		dw_prerrequisito_cuentas.SelectRow (ll_found, true)
	END IF
	
NEXT


RETURN 0

end function

on w_acred_prerreq_ingles_archivo_2013.create
int iCurrent
call super::create
this.uo_1=create uo_1
this.st_texto_ruta=create st_texto_ruta
this.sle_ruta_archivo=create sle_ruta_archivo
this.pb_archivo=create pb_archivo
this.dw_cuentas_archivo_prerreq=create dw_cuentas_archivo_prerreq
this.pb_cargar=create pb_cargar
this.dw_prerrequisito_cuentas=create dw_prerrequisito_cuentas
this.pb_materias=create pb_materias
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.st_texto_ruta
this.Control[iCurrent+3]=this.sle_ruta_archivo
this.Control[iCurrent+4]=this.pb_archivo
this.Control[iCurrent+5]=this.dw_cuentas_archivo_prerreq
this.Control[iCurrent+6]=this.pb_cargar
this.Control[iCurrent+7]=this.dw_prerrequisito_cuentas
this.Control[iCurrent+8]=this.pb_materias
this.Control[iCurrent+9]=this.gb_1
this.Control[iCurrent+10]=this.gb_2
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.gb_4
end on

on w_acred_prerreq_ingles_archivo_2013.destroy
call super::destroy
destroy(this.uo_1)
destroy(this.st_texto_ruta)
destroy(this.sle_ruta_archivo)
destroy(this.pb_archivo)
destroy(this.dw_cuentas_archivo_prerreq)
destroy(this.pb_cargar)
destroy(this.dw_prerrequisito_cuentas)
destroy(this.pb_materias)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

event open;call super::open;dw_prerrequisito_cuentas.Settransobject(gtr_sce)


end event

event close;close(this)
end event

event closequery;//
end event

type st_sistema from w_master_main`st_sistema within w_acred_prerreq_ingles_archivo_2013
end type

type p_ibero from w_master_main`p_ibero within w_acred_prerreq_ingles_archivo_2013
end type

type uo_1 from uo_per_ani within w_acred_prerreq_ingles_archivo_2013
integer x = 73
integer y = 392
integer height = 168
integer taborder = 50
boolean bringtotop = true
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_texto_ruta from u_st within w_acred_prerreq_ingles_archivo_2013
integer x = 1568
integer y = 444
integer width = 146
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 16777215
string text = "Ruta:"
end type

type sle_ruta_archivo from u_sle within w_acred_prerreq_ingles_archivo_2013
integer x = 1714
integer y = 440
integer width = 1719
integer height = 76
integer taborder = 30
boolean bringtotop = true
fontcharset fontcharset = ansi!
string facename = "Tahoma"
long backcolor = 16777215
end type

type pb_archivo from picturebutton within w_acred_prerreq_ingles_archivo_2013
integer x = 1390
integer y = 416
integer width = 160
integer height = 124
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string picturename = "Custom039!"
alignment htextalign = left!
end type

event clicked;string pathname, filename
integer value

value = GetFileOpenName("Seleccione el Archivo", &
		+ pathname, filename, "TXT", &
		+ "Text Files (*.TXT),*.TXT")

IF value = 1 THEN 
	is_nombre_archivo = pathname
	sle_ruta_archivo.text = is_nombre_archivo
	pb_cargar.enabled = true
ELSE
	MessageBox("Sin Archivo","No se ha abierto ningún archivo",Information!)
end if
end event

type dw_cuentas_archivo_prerreq from uo_master_dw within w_acred_prerreq_ingles_archivo_2013
integer x = 261
integer y = 700
integer width = 549
integer height = 1732
integer taborder = 11
boolean bringtotop = true
string dataobject = "d_carga_archivo_prerreq_2013"
boolean hscrollbar = false
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type pb_cargar from picturebutton within w_acred_prerreq_ingles_archivo_2013
integer x = 73
integer y = 700
integer width = 160
integer height = 124
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string picturename = "DataManip!"
string disabledname = "Custom080!"
alignment htextalign = left!
end type

event clicked;integer li_return_carga
li_return_carga = wf_carga_prerreq_alumnos()
IF li_return_carga= -1 THEN
	MessageBox("Error de Carga", "Favor de revisar el archivo a cargar",StopSign!)
	RETURN
ELSE
	MessageBox("Carga Exitosa", "Se ha cargado el archivo exitosamente",Information!)
	pb_materias.enabled = true
	RETURN
END IF
end event

type dw_prerrequisito_cuentas from uo_master_dw within w_acred_prerreq_ingles_archivo_2013
integer x = 1097
integer y = 700
integer width = 2359
integer height = 1736
integer taborder = 21
boolean bringtotop = true
string dataobject = "d_carga_prerreq_ingles_2013"
boolean resizable = true
boolean border = true
borderstyle borderstyle = stylelowered!
end type

type pb_materias from picturebutton within w_acred_prerreq_ingles_archivo_2013
integer x = 910
integer y = 700
integer width = 160
integer height = 124
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
boolean enabled = false
string picturename = "DBAdmin!"
string disabledname = "Custom080!"
alignment htextalign = left!
end type

event clicked;integer li_res_update, li_confirmacion
long	ll_rowcount

ll_rowcount = dw_prerrequisito_cuentas.RowCount()
li_confirmacion = 	MessageBox("Confirmación", "¿Desea almacenar los ["+string(ll_rowcount)+"] prerrequisitos?",Question!, YesNo!)

IF li_confirmacion = 1 THEN
	li_res_update = dw_prerrequisito_cuentas.Update()
	IF li_res_update = 1 THEN
		COMMIT USING gtr_sce;
		MessageBox("Actualizacion exitosa", "Se han almacenado los ["+string(ll_rowcount)+"] prerrequisitos",Information!)
	ELSE
		ROLLBACK USING gtr_sce;
		MessageBox("Error de Actualizacion", "No es posible almacenar los prerrequisitos",StopSign!)
	END IF
ELSE
	MessageBox("Sin actualización", "No se ha actualizado",Information!)
END IF

pb_cargar.enabled = false
pb_materias.enabled = false
dw_cuentas_archivo_prerreq.Reset()
dw_prerrequisito_cuentas.Reset()
sle_ruta_archivo.text = ''
Setnull(is_nombre_archivo)


end event

type gb_1 from groupbox within w_acred_prerreq_ingles_archivo_2013
integer x = 1362
integer y = 304
integer width = 2103
integer height = 284
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Seleccionar archivo"
end type

type gb_2 from groupbox within w_acred_prerreq_ingles_archivo_2013
integer x = 37
integer y = 304
integer width = 1312
integer height = 284
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Periodo"
end type

type gb_3 from groupbox within w_acred_prerreq_ingles_archivo_2013
integer x = 37
integer y = 608
integer width = 800
integer height = 1844
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Cargar alumnos"
end type

type gb_4 from groupbox within w_acred_prerreq_ingles_archivo_2013
integer x = 855
integer y = 608
integer width = 2619
integer height = 1844
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 128
long backcolor = 16777215
string text = "Almacenar Materias"
end type

