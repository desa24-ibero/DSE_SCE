$PBExportHeader$w_srl.srw
forward
global type w_srl from window
end type
type mdi_1 from mdiclient within w_srl
end type
end forward

global type w_srl from window
integer x = 5
integer y = 4
integer width = 3657
integer height = 2400
boolean titlebar = true
string title = "Sistema de Reinscripción en Linea"
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 26964016
event ue_inicializa ( )
mdi_1 mdi_1
end type
global w_srl w_srl

event ue_inicializa();//g_nv_security.fnv_secure_window(this)
setpointer(Hourglass!)

int preinsc
preinsc = 0
if Pos(usuario,"inscrip") > 0 then
	gi_nivel_usuario = 1
elseif Pos(usuario,"inscpos") > 0 then
	gi_nivel_usuario = 2
else
	gi_nivel_usuario = 13
end if
if gi_nivel_usuario < 10 then
	SELECT activacion.preinsc  
    INTO :preinsc  
    FROM activacion WHERE tipo_periodo = :gs_tipo_periodo;
else
	SELECT activacion_su.preinsc  
    INTO :preinsc  
    FROM activacion_su WHERE tipo_periodo = :gs_tipo_periodo;
end if

string ls_plantel,ls_nombre
SELECT first_name+' '+last_name
INTO :ls_nombre
FROM pc_user_def
WHERE pc_user_def.user_id = :usuario;


SELECT descripcion
INTO :gs_descripcion_periodo 
FROM periodo_tipo
WHERE id_tipo = :gs_tipo_periodo;

f_obten_titulo(w_srl)


if preinsc = 0 then	
	opensheet(w_reinscripcion_2014,w_srl,6,Original!)
else	
	opensheet(w_preinscripción_2014,w_srl,6,Original!)
end if
end event

on w_srl.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_srl.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;STRING ls_plantel 
Long ll_indice = 1

SELECT plantel, multiple_periodo
INTO :ls_plantel, :gs_multiples_periodos
FROM planteles
WHERE actual = 1;
//title=usuario+' '+ls_nombre+"  Plantel: "+ls_plantel


//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
// Si el plantel activo soporta múltiples periodos y el periodo es cualquiera
IF gs_periodo_default =  "C" THEN 
	// Se verifica si el plantel soporta múltiples periodos.
	IF gs_multiples_periodos ="S" THEN 
		//Se habilita opción de menú para cambiar el periodo.
		m_principal.m_reinscripcion.m_cambiarperiodo.visible = TRUE
		gs_tipo_periodo = "S" 
		// Se abre ventana de selección de periodo.
		OPEN(w_cambio_tipo_periodo) 
	// Si no se permiten múltiples periodos se asigna "Semestral" por omisión al tipo de periodo y a la bandera indicadora.
	ELSE
		gs_multiples_periodos = "N" 
		
		SELECT ISNULL(a1.id_tipo, "")
		INTO :gs_tipo_periodo
		FROM periodo_tipo a1, periodo_tipo a2
		WHERE a1.id_tipo >= a2.id_tipo
		GROUP BY a1.id_tipo
		HAVING COUNT(1) = :ll_indice
		ORDER BY a1.id_tipo
		USING SQLCA;
		
		IF SQLCA.sqlcode <> 0  THEN
			MessageBox("Error", "Error en la consulta de la función open(). " + SQLCA.sqlErrText, StopSign!)
			RETURN -1
		ELSE
			IF gs_tipo_periodo = "" THEN
				MessageBox("Error", "El tipo periodo obtenido en la función open(), no es válido: vacío", StopSign!)
				RETURN -1
			END IF		
		END IF
	END IF
ELSEIF TRIM(gs_periodo_default) = "" THEN 
	MessageBox("Usuario sin periodo definido", "El usuario no tiene asignado un tipo de periodo por omisión",Exclamation!)
	CLOSE(THIS)
	HALT CLOSE		
ELSE
	// Se asigna por omisión Semestral
	gs_tipo_periodo = gs_periodo_default
END IF	

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	

POSTEVENT("ue_inicializa") 


//////////////////////////////////////////////////////////////////////////////////////////////////
// Código Original
//////////////////////////////////////////////////////////////////////////////////////////////////

////g_nv_security.fnv_secure_window(this)
//setpointer(Hourglass!)
//
//int preinsc
//preinsc = 0
//if Pos(usuario,"inscrip") > 0 then
//	gi_nivel_usuario = 1
//elseif Pos(usuario,"inscpos") > 0 then
//	gi_nivel_usuario = 2
//else
//	gi_nivel_usuario = 13
//end if
//if gi_nivel_usuario < 10 then
//	SELECT activacion.preinsc  
//    INTO :preinsc  
//    FROM activacion ;
//else
//	SELECT activacion_su.preinsc  
//    INTO :preinsc  
//    FROM activacion_su ;
//end if
//
//string ls_plantel,ls_nombre
//SELECT first_name+' '+last_name
//INTO :ls_nombre
//FROM pc_user_def
//WHERE pc_user_def.user_id = :usuario;
//
//SELECT plantel, multiple_periodo
//INTO :ls_plantel, :gs_multiples_periodos
//FROM planteles
//WHERE actual = 1;
//title=usuario+' '+ls_nombre+"  Plantel: "+ls_plantel
//
//
//
////**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
////**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//// Si el plantel activo soporta múltiples periodos y el periodo es cualquiera
//IF gs_periodo_default =  "C" THEN 
//	// Se verifica si el plantel soporta múltiples periodos.
//	IF gs_multiples_periodos ="S" THEN 
//		//Se habilita opción de menú para cambiar el periodo.
//		m_principal.m_reinscripcion.m_cambiarperiodo.visible = TRUE
//		gs_tipo_periodo = "S" 
//		// Se abre ventana de selección de periodo.
//		OPEN(w_cambio_tipo_periodo) 
//	// Si no se permiten múltiples periodos se asigna "Semestral" por omisión al tipo de periodo y a la bandera indicadora.
//	ELSE
//		gs_multiples_periodos = "S" 
//		gs_tipo_periodo = "S" 
//	END IF
//ELSEIF TRIM(gs_periodo_default) = "" THEN 
//	MessageBox("Usuario sin periodo definido", "El usuario no tiene asignado un tipo de periodo por omisión",Exclamation!)
//	CLOSE(THIS)
//	HALT CLOSE		
//ELSE
//	// Se asigna por omisión Semestral
//	gs_tipo_periodo = gs_periodo_default
//END IF	
//
////title=usuario+' '+ls_nombre+"  Plantel: "+ls_plantel 
//f_obten_titulo(w_srl)
//
//
////**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
////**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
//
//
//if preinsc = 0 then	
//	opensheet(w_reinscripcion_2014,w_srl,6,Original!)
//else	
//	opensheet(w_preinscripción_2014,w_srl,6,Original!)
//end if
end event

event close;//IF IsValid (g_nv_security) then
//	g_nv_security.fnv_close_security()
//END IF

end event

type mdi_1 from mdiclient within w_srl
long BackColor=276856960
end type

