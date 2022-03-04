$PBExportHeader$uo_bloqueos_alumno.sru
forward
global type uo_bloqueos_alumno from nonvisualobject
end type
end forward

global type uo_bloqueos_alumno from nonvisualobject
end type
global uo_bloqueos_alumno uo_bloqueos_alumno

type variables
long     il_ar_cuenta[]
integer  il_ar_bloqueo_documentos[]
integer  il_ar_bloqueo_laboratorio[]
integer  il_ar_bloqueo_biblioteca[]
integer  il_ar_adeudos_vencidos[]
integer  il_ar_pago_inscripcion[]
datetime il_ar_fecha_creacion[]
datetime idttm_fecha_creacion
long il_segundos_actualizacion
boolean  ib_existe_con_cobranzas = false


end variables

forward prototypes
public function boolean f_revisa_pago_inscripcion ()
public function integer f_obten_bloqueos (long al_cuenta, ref integer ai_bloqueo_biblioteca, ref integer ai_bloqueo_documentos, ref integer ai_bloqueo_laboratorios, ref integer ai_adeudos_vencidos, ref integer ai_pago_inscripcion)
public function integer f_mensaje_bloqueos (long al_cuenta, ref string as_mensaje_bloqueos)
end prototypes

public function boolean f_revisa_pago_inscripcion ();//f_revisa_pago_inscripcion
//Devuelve si en el momento actual hay que revisar el pago
//de inscripcion

return false
end function

public function integer f_obten_bloqueos (long al_cuenta, ref integer ai_bloqueo_biblioteca, ref integer ai_bloqueo_documentos, ref integer ai_bloqueo_laboratorios, ref integer ai_adeudos_vencidos, ref integer ai_pago_inscripcion);//f_obten_bloqueos
//Recibe: al_cuenta						long
//			 ai_bloqueo_biblioteca		integer
//			 ai_bloqueo_documentos		integer
//			 ai_bloqueo_laboratorios	integer
//			 ai_adeudos_vencidos			integer
//			 ai_pago_inscripcion			integer


integer li_codigo_sql
string ls_error
integer li_bloqueo_biblioteca, li_bloqueo_documentos, li_bloqueo_laboratorios
integer li_tiene_adeudos, li_pago_inscripcion
integer li_periodo, li_anio

SELECT bloqueo_bibioteca = CASE cve_flag_biblioteca WHEN 3 THEN 1
                                                    ELSE 0
                           END,
       bloqueo_documentos = CASE baja_documentos WHEN 1 THEN 1
                                                    ELSE 0
                           END,
       bloqueo_laboratorios = CASE baja_laboratorio WHEN 1 THEN 1
                                                    ELSE 0
                           END
INTO :li_bloqueo_biblioteca, 
     :li_bloqueo_documentos, 
	  :li_bloqueo_laboratorios
FROM banderas
WHERE cuenta = :al_cuenta
USING gtr_sce;

li_codigo_sql = gtr_sce.SQLCode
ls_error      = gtr_sce.SQLErrText

IF li_codigo_sql = -1 THEN
	MessageBox("Error en bloqueos",&
	"No es posible consultar los bloqueos del alumno["+string(al_cuenta)+"]",StopSign!)
ELSEIF li_codigo_sql = 100 THEN
	MessageBox("Banderas inexistentes",&
	"No es posible consultar los bloqueos del alumno["+string(al_cuenta)+"]",StopSign!)
END IF

li_tiene_adeudos    = tiene_adeudos(al_cuenta,gtr_scob)

IF f_revisa_pago_inscripcion() THEN
	
	periodo_actual_mat_insc(li_periodo, li_anio, gtr_sce)

	IF NOT(isnull(li_anio) or isnull(li_periodo)) THEN
		li_pago_inscripcion = pago_inscripcion(al_cuenta, li_anio, li_periodo, gtr_scob)
	END IF
ELSE
	li_pago_inscripcion = 1
END IF

ai_bloqueo_biblioteca   = li_bloqueo_biblioteca 
ai_bloqueo_documentos   = li_bloqueo_documentos
ai_bloqueo_laboratorios = li_bloqueo_laboratorios
ai_adeudos_vencidos     = li_tiene_adeudos
ai_pago_inscripcion     = li_pago_inscripcion

IF li_tiene_adeudos= -1 OR li_codigo_sql= -1 THEN
	RETURN -1
ELSE
	RETURN 0
END IF



end function

public function integer f_mensaje_bloqueos (long al_cuenta, ref string as_mensaje_bloqueos);integer li_obten_bloqueos
integer li_bloqueo_biblioteca, li_bloqueo_documentos, li_bloqueo_laboratorios
integer li_adeudos_vencidos, li_pago_inscripcion
string ls_mensaje_bloqueos = ""

li_obten_bloqueos = f_obten_bloqueos(al_cuenta,li_bloqueo_biblioteca,li_bloqueo_documentos,&
			 li_bloqueo_laboratorios, li_adeudos_vencidos, li_pago_inscripcion)	

as_mensaje_bloqueos = ""			 
			 
IF li_obten_bloqueos<> -1 THEN
	IF li_bloqueo_biblioteca = 1 THEN
		ls_mensaje_bloqueos = ls_mensaje_bloqueos +"Bloqueo de Biblioteca~n"
	END IF		
	IF li_bloqueo_documentos = 1 THEN
		ls_mensaje_bloqueos = ls_mensaje_bloqueos +"Bloqueo de Documentos~n"
	END IF		
	IF li_bloqueo_laboratorios = 1 THEN
		ls_mensaje_bloqueos = ls_mensaje_bloqueos +"Bloqueo de Laboratorio~n"
	END IF		
	IF li_adeudos_vencidos = 1 THEN
		ls_mensaje_bloqueos = ls_mensaje_bloqueos +"Adeudos Vencidos~n"
	END IF		
	IF li_pago_inscripcion = 0 THEN
		ls_mensaje_bloqueos = ls_mensaje_bloqueos +"Sin Pago de Inscripción~n"
	END IF		
	as_mensaje_bloqueos = ls_mensaje_bloqueos
	RETURN 0
END IF

RETURN -1

end function

on uo_bloqueos_alumno.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_bloqueos_alumno.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;if not isvalid(gtr_scob) then
	ib_existe_con_cobranzas= false
	if conecta_bd(gtr_scob, "SCOB",gs_usuario,gs_password)=0 then
	MessageBox("Error","No es posible consultar los adeudos ni los pagos",StopSign!)
	end if
else 
	ib_existe_con_cobranzas= true
end if
end event

event destructor;if ib_existe_con_cobranzas = false then

	if isvalid(gtr_scob) then
		if desconecta_bd(gtr_scob)=0 then
			MessageBox("Error","No es posible consultar los adeudos ni los pagos")
//			close(this)
		end if
	end if
end if
end event

