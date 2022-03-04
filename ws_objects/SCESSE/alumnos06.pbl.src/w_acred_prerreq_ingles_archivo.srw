$PBExportHeader$w_acred_prerreq_ingles_archivo.srw
forward
global type w_acred_prerreq_ingles_archivo from w_main
end type
type cb_2 from u_cb within w_acred_prerreq_ingles_archivo
end type
type dw_prerrequisito_cuentas from u_dw within w_acred_prerreq_ingles_archivo
end type
type uo_1 from uo_per_ani within w_acred_prerreq_ingles_archivo
end type
type cb_1 from u_cb within w_acred_prerreq_ingles_archivo
end type
type st_texto_ruta from u_st within w_acred_prerreq_ingles_archivo
end type
type sle_ruta_archivo from u_sle within w_acred_prerreq_ingles_archivo
end type
type cb_buscar_archivo from u_cb within w_acred_prerreq_ingles_archivo
end type
type dw_cuentas_archivo_prerreq from u_dw within w_acred_prerreq_ingles_archivo
end type
end forward

global type w_acred_prerreq_ingles_archivo from w_main
integer width = 3707
integer height = 1612
string title = "Acreditación de Prerrequisto de Inglés por Archivo"
cb_2 cb_2
dw_prerrequisito_cuentas dw_prerrequisito_cuentas
uo_1 uo_1
cb_1 cb_1
st_texto_ruta st_texto_ruta
sle_ruta_archivo sle_ruta_archivo
cb_buscar_archivo cb_buscar_archivo
dw_cuentas_archivo_prerreq dw_cuentas_archivo_prerreq
end type
global w_acred_prerreq_ingles_archivo w_acred_prerreq_ingles_archivo

type variables
string is_nombre_archivo= ""

end variables

forward prototypes
public function integer wf_carga_prerreq_alumnos ()
end prototypes

public function integer wf_carga_prerreq_alumnos ();// wf_carga_prerreq_alumnos
//Carga los prerrequisitos de los alumnos
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

ll_cve_mat = 4078

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

on w_acred_prerreq_ingles_archivo.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.dw_prerrequisito_cuentas=create dw_prerrequisito_cuentas
this.uo_1=create uo_1
this.cb_1=create cb_1
this.st_texto_ruta=create st_texto_ruta
this.sle_ruta_archivo=create sle_ruta_archivo
this.cb_buscar_archivo=create cb_buscar_archivo
this.dw_cuentas_archivo_prerreq=create dw_cuentas_archivo_prerreq
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.dw_prerrequisito_cuentas
this.Control[iCurrent+3]=this.uo_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.st_texto_ruta
this.Control[iCurrent+6]=this.sle_ruta_archivo
this.Control[iCurrent+7]=this.cb_buscar_archivo
this.Control[iCurrent+8]=this.dw_cuentas_archivo_prerreq
end on

on w_acred_prerreq_ingles_archivo.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.dw_prerrequisito_cuentas)
destroy(this.uo_1)
destroy(this.cb_1)
destroy(this.st_texto_ruta)
destroy(this.sle_ruta_archivo)
destroy(this.cb_buscar_archivo)
destroy(this.dw_cuentas_archivo_prerreq)
end on

event open;call super::open;x=1
y=1
dw_cuentas_archivo_prerreq.SetTransObject(gtr_sce)
dw_prerrequisito_cuentas.SetTransObject(gtr_sce)
end event

type cb_2 from u_cb within w_acred_prerreq_ingles_archivo
integer x = 1883
integer y = 572
integer width = 471
integer taborder = 40
string text = "Almacenar Materias"
end type

event clicked;call super::clicked;integer li_res_update, li_confirmacion
long	ll_rowcount

ll_rowcount = dw_prerrequisito_cuentas.RowCount()
li_confirmacion = 	MessageBox("Confirmación", "¿Desea almacenar los ["+string(ll_rowcount)+"] prerrequisitos?",Question!, YesNo!)

IF li_confirmacion = 1 THEN
	li_res_update = dw_prerrequisito_cuentas.event pfc_update(true, true)
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
end event

type dw_prerrequisito_cuentas from u_dw within w_acred_prerreq_ingles_archivo
integer x = 667
integer y = 700
integer width = 2898
integer height = 680
integer taborder = 20
string dataobject = "d_carga_prerreq_ingles"
end type

type uo_1 from uo_per_ani within w_acred_prerreq_ingles_archivo
integer x = 55
integer y = 48
integer width = 1248
integer height = 164
integer taborder = 40
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type cb_1 from u_cb within w_acred_prerreq_ingles_archivo
integer x = 55
integer y = 572
integer width = 416
integer taborder = 30
string text = "Cargar Alumnos"
end type

event clicked;call super::clicked;integer li_return_carga
li_return_carga = wf_carga_prerreq_alumnos()
IF li_return_carga= -1 THEN
	MessageBox("Error de Carga", "Favor de revisar el archivo a cargar",StopSign!)
	RETURN
ELSE
	MessageBox("Carga Exitosa", "Se ha cargado el archivo exitosamente",Information!)
	RETURN
END IF
end event

type st_texto_ruta from u_st within w_acred_prerreq_ingles_archivo
integer x = 55
integer y = 440
integer width = 146
string text = "Ruta:"
end type

type sle_ruta_archivo from u_sle within w_acred_prerreq_ingles_archivo
integer x = 238
integer y = 436
integer width = 1719
integer height = 76
integer taborder = 20
long backcolor = 80269524
end type

type cb_buscar_archivo from u_cb within w_acred_prerreq_ingles_archivo
integer x = 55
integer y = 284
integer width = 416
integer taborder = 10
string text = "Buscar Archivo..."
end type

event clicked;call super::clicked;

string pathname, filename

integer value

value = GetFileOpenName("Seleccione el Archivo", &
		+ pathname, filename, "TXT", &
		+ "Text Files (*.TXT),*.TXT")

IF value = 1 THEN 
	is_nombre_archivo = pathname
	sle_ruta_archivo.text = is_nombre_archivo
ELSE
	MessageBox("Sin Archivo","No se ha abierto ningún archivo",Information!)
END IF


end event

type dw_cuentas_archivo_prerreq from u_dw within w_acred_prerreq_ingles_archivo
integer x = 41
integer y = 700
integer width = 535
integer height = 680
integer taborder = 10
string dataobject = "d_carga_archivo_prerreq"
end type

