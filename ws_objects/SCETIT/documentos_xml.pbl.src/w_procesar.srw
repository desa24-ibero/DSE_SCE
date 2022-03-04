$PBExportHeader$w_procesar.srw
forward
global type w_procesar from window
end type
type cb_cuentas from commandbutton within w_procesar
end type
type cb_limpiar from commandbutton within w_procesar
end type
type cb_inc from commandbutton within w_procesar
end type
type cb_salir from commandbutton within w_procesar
end type
type cb_iniciar from commandbutton within w_procesar
end type
type st_estado from statictext within w_procesar
end type
type cb_configurar from commandbutton within w_procesar
end type
type cb_ejecutar from commandbutton within w_procesar
end type
type cb_terminar from commandbutton within w_procesar
end type
end forward

global type w_procesar from window
integer width = 3410
integer height = 584
boolean titlebar = true
string title = "Generación de XML para D2L"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 15780518
string icon = "AppIcon!"
boolean center = true
event settimer ( )
cb_cuentas cb_cuentas
cb_limpiar cb_limpiar
cb_inc cb_inc
cb_salir cb_salir
cb_iniciar cb_iniciar
st_estado st_estado
cb_configurar cb_configurar
cb_ejecutar cb_ejecutar
cb_terminar cb_terminar
end type
global w_procesar w_procesar

type variables

STRING is_hora  
end variables

forward prototypes
public subroutine wf_genera_archivos ()
public function integer wf_genera_archivos_inc ()
public subroutine wf_genera_archivos_cuenta ()
end prototypes

event settimer();
//timer(0)
//timer(10)

RETURN 
end event

public subroutine wf_genera_archivos ();STRING ls_error

IF multiples_periodos = "S" THEN 	
	
	// Se recupera el periodo activo para el tipo.
	SELECT periodo, anio  
	INTO :ge_periodo, :ge_anio  
	FROM periodos_por_procesos
	WHERE cve_proceso = 0 
	AND tipo_periodo = :gs_tipo_periodo 
	USING SQLCA;
	
ELSE
	
	// Se recupera el periodo activo para el tipo.
	SELECT periodo, anio  
	INTO :ge_periodo, :ge_anio  
	FROM periodos_por_procesos
	WHERE cve_proceso = 0 
	USING SQLCA;		
	
END IF


DELETE FROM movmat_inscritas_xml
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	ls_error = "No se generaron archivos. Se produjo un error al borrar los movimientos de materias para XML: " + SQLCA.SQLERRTEXT 
	ROLLBACK USING SQLCA;
	MESSAGEBOX("Error", ls_error)
	RETURN 
END IF


INSERT INTO movmat_inscritas_xml (cuenta, cve_mat, gpo, periodo, anio, calificacion, cve_condicion, acreditacion, inscripcion, movimiento, usuario, fecha)
SELECT cuenta, cve_mat, gpo, periodo, anio, calificacion, cve_condicion, acreditacion, inscripcion, movimiento, usuario, fecha
FROM movmat_inscritas
WHERE periodo = :ge_periodo
AND  anio = :ge_anio 
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	ls_error = "No se generaron archivos. Se produjo un error al insertar los movimientos de materias para XML: " + SQLCA.SQLERRTEXT 
	ROLLBACK USING SQLCA;
	MESSAGEBOX("Error", ls_error)
	RETURN 
END IF

COMMIT USING SQLCA;


// Se crea el objeto de generación de XML 
uo_genera_xml luo_genera_xml
luo_genera_xml = CREATE uo_genera_xml 

st_estado.TEXT = "Procesando..."

// Se generan los archivos. 
luo_genera_xml.genera_xml()

st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )" 


end subroutine

public function integer wf_genera_archivos_inc ();
// Se crea el objeto de generación de XML 
uo_genera_xml_incremental luo_genera_xml
luo_genera_xml = CREATE uo_genera_xml_incremental 

st_estado.TEXT = "Procesando..."

// Se generan los archivos. 

st_estado.TEXT = "Procesando cambios Memberships... "
luo_genera_xml.f_inserta_mat_inscritas_modificadas() 

st_estado.TEXT = "Procesando cambios Offerings... "
luo_genera_xml.f_inserta_grupos_modificados()  

st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )" 





RETURN 0 
end function

public subroutine wf_genera_archivos_cuenta ();//wf_genera_archivos_cuenta

STRING ls_error

IF multiples_periodos = "S" THEN 	
	
	// Se recupera el periodo activo para el tipo.
	SELECT periodo, anio  
	INTO :ge_periodo, :ge_anio  
	FROM periodos_por_procesos
	WHERE cve_proceso = 0 
	AND tipo_periodo = :gs_tipo_periodo 
	USING SQLCA;
	
ELSE
	
	// Se recupera el periodo activo para el tipo.
	SELECT periodo, anio  
	INTO :ge_periodo, :ge_anio  
	FROM periodos_por_procesos
	WHERE cve_proceso = 0 
	USING SQLCA;		
	
END IF




// Se crea el objeto de generación de XML 
uo_genera_xml_cuenta luo_genera_xml
luo_genera_xml = CREATE uo_genera_xml_cuenta 

st_estado.TEXT = "Procesando..."   

STRING ls_cuenta 
INTEGER llpos 



FOR llpos = 1 TO 4 

	IF llpos = 1 THEN ls_cuenta = "156972"
	IF llpos = 2 THEN ls_cuenta = "138999"
	IF llpos = 3 THEN ls_cuenta = "117710"
	IF llpos = 4 THEN ls_cuenta = "184300"

	// Se generan los archivos. 
	luo_genera_xml.genera_xml(ls_cuenta)  

NEXT 



st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )" 


end subroutine

on w_procesar.create
this.cb_cuentas=create cb_cuentas
this.cb_limpiar=create cb_limpiar
this.cb_inc=create cb_inc
this.cb_salir=create cb_salir
this.cb_iniciar=create cb_iniciar
this.st_estado=create st_estado
this.cb_configurar=create cb_configurar
this.cb_ejecutar=create cb_ejecutar
this.cb_terminar=create cb_terminar
this.Control[]={this.cb_cuentas,&
this.cb_limpiar,&
this.cb_inc,&
this.cb_salir,&
this.cb_iniciar,&
this.st_estado,&
this.cb_configurar,&
this.cb_ejecutar,&
this.cb_terminar}
end on

on w_procesar.destroy
destroy(this.cb_cuentas)
destroy(this.cb_limpiar)
destroy(this.cb_inc)
destroy(this.cb_salir)
destroy(this.cb_iniciar)
destroy(this.st_estado)
destroy(this.cb_configurar)
destroy(this.cb_ejecutar)
destroy(this.cb_terminar)
end on

event open;
guo_conexion.conecta_bd( )

SELECT hora
INTO :is_hora
FROM archivo_hora 
USING SQLCA;

st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )"

guo_conexion.desconecta_bd( )



TITLE = "Generación de XML para D2L " + gs_plantel 

// Se inicializa el tipo de periodo por default a Semestral. 
gs_tipo_periodo = 'S'




end event

event timer;// Se recupera la hora del servidor.

DATETIME ldt_fecha_server 
DATETIME ldt_fecha_ejecucion
STRING ls_hora 
TIME lt_hora
TIME lt_hora_serv

IF guo_conexion.conecta_bd() < 0 THEN RETURN -1 

SELECT TOP 1 getdate()
INTO :ldt_fecha_server  
FROM activacion  
USING SQLCA;
//WHERE tipo_periodo = :gs_tipo_periodo
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la hora del sistema: " + SQLCA.SQLERRTEXT)
	RETURN 
END IF

//ldt_fecha_server =   DATETIME('14/08/2017 10:00:00') 
//MESSAGEBOX("", STRING(ldt_fecha_server))


SELECT hora
INTO :ls_hora 
FROM archivo_hora 
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la hora del sistema: " + SQLCA.SQLERRTEXT)
	RETURN 
END IF

is_hora = ls_hora  

st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )" 
lt_hora = TIME(ls_hora)  
lt_hora_serv = TIME(ldt_fecha_server)  

// Se recupera la fecha de la última ejecución.
SELECT fecha_ejecucion 
INTO :ldt_fecha_ejecucion 
FROM archivo_bitacora 
WHERE id = (SELECT MAX(id) FROM archivo_bitacora)
USING SQLCA; 
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la última fecha de generación de archivos: " + SQLCA.SQLERRTEXT) 
	RETURN 
END IF

IF ISNULL(ldt_fecha_ejecucion) THEN ldt_fecha_ejecucion = DATETIME(DATE("1900/01/01") )


IF lt_hora_serv <= lt_hora THEN 
	guo_conexion.desconecta_bd()  
	RETURN  
END IF

IF DATE(ldt_fecha_ejecucion) = DATE(ldt_fecha_server) THEN 
	guo_conexion.desconecta_bd()  
	RETURN  
END IF

//// Se genera la información de los archivos de la fecha anterior
//gf_fecha_ejecucion = RELATIVEDATE(DATE(ldt_fecha_server) , -1) 
//wf_genera_archivos_inc() 
//
//// Se genera la información de los archivos complementarios.
//gf_fecha_ejecucion = DATE(ldt_fecha_server)  
//wf_genera_archivos_inc() 
//
//wf_genera_archivos() 


////////////////////////////////////////////////////////////////
DATASTORE lds_periodo_tipo
lds_periodo_tipo = CREATE DATASTORE 
lds_periodo_tipo.DATAOBJECT = 'dw_periodo_tipo' 
INTEGER le_periodos_tipo
INTEGER le_pos 

//guo_conexion.conecta_bd( )

IF multiples_periodos = "S" THEN 
	lds_periodo_tipo.SETTRANSOBJECT(SQLCA) 
	le_periodos_tipo = lds_periodo_tipo.RETRIEVE()
ELSE
	le_periodos_tipo = 1 
END IF

// Se ejecuta el proceso para cada tipo de periodo 
FOR le_pos = 1 TO le_periodos_tipo 
	
	
	IF multiples_periodos = "S" THEN 	
		
		// Se recupera el tipo de Periodo 
		gs_tipo_periodo = lds_periodo_tipo.GETITEMSTRING(le_pos, "id_tipo") 
	
		// Se recupera el periodo activo para el tipo.
		SELECT periodo, anio  
		INTO :ge_periodo, :ge_anio  
		FROM periodos_por_procesos
		WHERE cve_proceso = 0 
		AND tipo_periodo = :gs_tipo_periodo 
		USING SQLCA;
		
	ELSE
		
		gs_tipo_periodo = gs_periodo_default 
		
		// Se recupera el periodo activo para el tipo.
		SELECT periodo, anio  
		INTO :ge_periodo, :ge_anio  
		FROM periodos_por_procesos
		WHERE cve_proceso = 0 
		USING SQLCA;		
		
	END IF
	
	IF SQLCA.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar el periodo activo: " + SQLCA.SQLERRTEXT) 
		RETURN 0 
	END IF	
	
	// Se genera la información de los archivos de la fecha anterior
	gf_fecha_ejecucion = RELATIVEDATE(DATE(ldt_fecha_server) , -1) 
	wf_genera_archivos_inc() 
	
	// Se genera la información de los archivos complementarios.
	gf_fecha_ejecucion = DATE(ldt_fecha_server)  
	wf_genera_archivos_inc() 
	
	wf_genera_archivos() 	

// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 
//	wf_genera_archivos_inc() 
//	wf_genera_archivos() 
// CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL CODIGO ORIGINAL 

NEXT 



////////////////////////////////////////////////////////////////

SELECT fecha_ejecucion 
INTO :ldt_fecha_ejecucion 
FROM archivo_bitacora 
WHERE id = (SELECT MAX(id) FROM archivo_bitacora)
USING SQLCA; 
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la última fecha de generación de archivos: " + SQLCA.SQLERRTEXT) 
	RETURN 
END IF

st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )"  + "(Ultima Ejecución:" + STRING(DATE(ldt_fecha_ejecucion)) + ")" 

guo_conexion.desconecta_bd() 

GARBAGECOLLECT() 

POSTEVENT("settimer") 





end event

event close;

DISCONNECT USING SQLCA; 



end event

type cb_cuentas from commandbutton within w_procesar
integer x = 1463
integer y = 296
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "E Cuentas"
end type

event clicked;
cb_configurar.ENABLED = FALSE
cb_ejecutar.ENABLED = FALSE
cb_iniciar.ENABLED = FALSE

IF MESSAGEBOX("Confirmación", "Los archivos serán generados en este momento. ¿Desea Continuar?", Question!, YesNo!) = 2 THEN 
	cb_configurar.ENABLED = TRUE
	cb_ejecutar.ENABLED = TRUE
	cb_iniciar.ENABLED = TRUE 	
	RETURN 
END IF 

guo_conexion.conecta_bd( )




wf_genera_archivos_cuenta() 

guo_conexion.desconecta_bd( )

cb_configurar.ENABLED = TRUE
cb_ejecutar.ENABLED = TRUE
cb_iniciar.ENABLED = TRUE 
st_estado.TEXT = "En espera... "


end event

type cb_limpiar from commandbutton within w_procesar
boolean visible = false
integer x = 2784
integer y = 76
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
string text = "Limpiar"
end type

event clicked;guo_conexion.conecta_bd( )

DELETE FROM archivo_grupos_bit_fecha 
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Error al limpiar archivo_mat_insc_bit_fec : " + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA;	
	RETURN 0
END IF



DELETE FROM archivo_mat_insc_bit_fec
USING SQLCA;
IF SQLCA.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Error al limpiar archivo_mat_insc_bit_fec : " + SQLCA.SQLERRTEXT)
	ROLLBACK USING SQLCA;
	RETURN 0	
END IF

COMMIT USING SQLCA;

guo_conexion.desconecta_bd( )


MESSAGEBOX("Aviso", "Las tablas han sido limpiadas con éxito" )
RETURN 0
end event

type cb_inc from commandbutton within w_procesar
integer x = 2395
integer y = 296
integer width = 457
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ejecutar Inc."
end type

event clicked;
cb_configurar.ENABLED = FALSE
cb_ejecutar.ENABLED = FALSE
cb_iniciar.ENABLED = FALSE

OPEN(w_confirma_fecha)

IF MESSAGEBOX("Confirmación", "Los archivos INCREMENTALES serán generados en este momento. ¿Desea Continuar?", Question!, YesNo!) = 2 THEN 
	cb_configurar.ENABLED = TRUE
	cb_ejecutar.ENABLED = TRUE
	cb_iniciar.ENABLED = TRUE 	
	RETURN 
END IF 

DATASTORE lds_periodo_tipo
lds_periodo_tipo = CREATE DATASTORE 
lds_periodo_tipo.DATAOBJECT = 'dw_periodo_tipo' 
INTEGER le_periodos_tipo
INTEGER le_pos 

guo_conexion.conecta_bd( )

IF multiples_periodos = "S" THEN 
	lds_periodo_tipo.SETTRANSOBJECT(SQLCA) 
	le_periodos_tipo = lds_periodo_tipo.RETRIEVE()
ELSE
	le_periodos_tipo = 1 
END IF

// Se ejecuta el proceso para cada tipo de periodo 
FOR le_pos = 1 TO le_periodos_tipo 
	
	IF multiples_periodos = 'S' THEN 
		gs_tipo_periodo = lds_periodo_tipo.GETITEMSTRING(le_pos, "id_tipo") 
		
		// Se recupera el periodo activo para el tipo.
		SELECT periodo, anio  
		INTO :ge_periodo, :ge_anio  
		FROM periodos_por_procesos
		WHERE cve_proceso = 0 
		AND tipo_periodo = :gs_tipo_periodo 
		USING SQLCA;		
		
	ELSE
		gs_tipo_periodo = 'S' 
		
		// Se recupera el periodo activo para el tipo.
		SELECT periodo, anio  
		INTO :ge_periodo, :ge_anio  
		FROM periodos_por_procesos
		WHERE cve_proceso = 0 
		USING SQLCA;		
		
	END IF
	

	
	IF SQLCA.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar el periodo activo: " + SQLCA.SQLERRTEXT) 
		RETURN 0 
	END IF		
	

	wf_genera_archivos_inc() 
	
	wf_genera_archivos() 

NEXT 

guo_conexion.desconecta_bd( )

cb_configurar.ENABLED = TRUE
cb_ejecutar.ENABLED = TRUE
cb_iniciar.ENABLED = TRUE 
st_estado.TEXT = "En espera... "


end event

type cb_salir from commandbutton within w_procesar
integer x = 2917
integer y = 296
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salir"
end type

event clicked;
IF MESSAGEBOX("Confirmación", "Al cerrar la aplicación no se generarán los archivos de D2L. ¿Desea Continuar?", Question!, YesNo!) = 2 THEN RETURN 

TIMER(0)
CLOSE(PARENT)
end event

type cb_iniciar from commandbutton within w_procesar
integer x = 59
integer y = 296
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Iniciar"
end type

event clicked;

st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )"
//timer(3600)
timer(900)

cb_configurar.ENABLED = FALSE
cb_ejecutar.ENABLED = FALSE
cb_iniciar.ENABLED = FALSE
cb_salir.ENABLED = FALSE
cb_inc.ENABLED = FALSE
end event

type st_estado from statictext within w_procesar
integer x = 105
integer y = 64
integer width = 2569
integer height = 192
integer textsize = -12
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 15780518
string text = "Estado:"
boolean focusrectangle = false
end type

type cb_configurar from commandbutton within w_procesar
integer x = 1019
integer y = 296
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Configurar"
end type

event clicked;

open(w_edita_archivo, PARENT) 

is_hora = MESSAGE.STRINGPARM

st_estado.TEXT = "En espera ( Hora de Ejecución:" + is_hora + " )"


end event

type cb_ejecutar from commandbutton within w_procesar
integer x = 1934
integer y = 296
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ejecutar"
end type

event clicked;
cb_configurar.ENABLED = FALSE
cb_ejecutar.ENABLED = FALSE
cb_iniciar.ENABLED = FALSE

IF MESSAGEBOX("Confirmación", "Los archivos serán generados en este momento. ¿Desea Continuar?", Question!, YesNo!) = 2 THEN 
	cb_configurar.ENABLED = TRUE
	cb_ejecutar.ENABLED = TRUE
	cb_iniciar.ENABLED = TRUE 	
	RETURN 
END IF 

guo_conexion.conecta_bd( )

wf_genera_archivos() 

guo_conexion.desconecta_bd( )

cb_configurar.ENABLED = TRUE
cb_ejecutar.ENABLED = TRUE
cb_iniciar.ENABLED = TRUE 
st_estado.TEXT = "En espera... "


end event

type cb_terminar from commandbutton within w_procesar
integer x = 539
integer y = 296
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Detener"
end type

event clicked;
st_estado.TEXT = "En espera... "

timer(0) 

cb_configurar.ENABLED = TRUE
cb_ejecutar.ENABLED = TRUE
cb_iniciar.ENABLED = TRUE
cb_salir.ENABLED = TRUE 
cb_inc.ENABLED = TRUE 




end event

