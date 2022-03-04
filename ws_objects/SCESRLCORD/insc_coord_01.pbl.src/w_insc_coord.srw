$PBExportHeader$w_insc_coord.srw
forward
global type w_insc_coord from window
end type
type mdi_1 from mdiclient within w_insc_coord
end type
end forward

global type w_insc_coord from window
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
long backcolor = 16777215
event ue_inicializa ( )
mdi_1 mdi_1
end type
global w_insc_coord w_insc_coord

event ue_inicializa();

//g_nv_security.fnv_secure_window(this)
setpointer(Hourglass!)

int preinsc
preinsc = 0

/*
//	Oscar Sánchez, 14 Dic 2019.	La variable gi_nivel usuario no tiene un uso practico para coordinadores, se quitan las referencias a la variable//	Oscar Sánchez, 14 Dic 2019.	Los coordinadores tienen permitido exceder cupo ...
if Pos(usuario,"inscrip") > 0  then
	gi_nivel_usuario = 1
elseif Pos(usuario,"inscpos") > 0  or gs_nivel_coordinacion = "P" then
	gi_nivel_usuario = 2
else
	gi_nivel_usuario = 13
end if
*/

/*
//	Oscar Sánchez, 14 Dic 2019.	A solicitud de Fantine, se eliminan todas las referencias a la tabla activacion_su y se reemplazan por referencias a la tabla activacion
//	Oscar Sánchez, 14 Dic 2019.	La variable gi_nivel usuario no tiene un uso practico para coordinadores, se quitan las referencias a la variable//	Oscar Sánchez, 14 Dic 2019.	Los coordinadores tienen permitido exceder cupo ...
if gi_nivel_usuario < 10 then
	SELECT activacion.preinsc  
    INTO :preinsc  
    FROM activacion 
	 WHERE tipo_periodo = :gs_tipo_periodo ;
else
	/*
	Oscar Sánchez, 12-Oct-2018. Se modifica el nivel de usuario para que tome posteriormente los objetos correspondientes a un superusuario
	MessageBox("Error Fatal", "El usuario escrito provocó una falla no reparable",StopSign!)
	Halt
	*/
	SELECT activacion_su.preinsc  
    INTO :preinsc  
    FROM activacion_su WHERE tipo_periodo = :gs_tipo_periodo;
end if
*/

SELECT activacion.preinsc  
    INTO :preinsc  
    FROM activacion 
	 WHERE tipo_periodo = :gs_tipo_periodo ;

string ls_nombre, ls_plantel
SELECT first_name+' '+last_name
INTO :ls_nombre
FROM pc_user_def
WHERE pc_user_def.user_id = :usuario;

SELECT plantel
INTO :ls_plantel
FROM planteles
WHERE actual = 1;
title=usuario+' '+ls_nombre+"  Plantel: "+ls_plantel

SELECT descripcion
INTO :gs_descripcion_periodo 
FROM periodo_tipo
WHERE id_tipo = :gs_tipo_periodo;

//	Oscar Sánchez, 10 Dic 2019.	La unica ventana a usar es w_reinscripcion_2014, no usar w_preinscripción_2014 para Coordinadores.
/*if preinsc = 0 then	*/
	opensheet(w_reinscripcion_2014,w_insc_coord,6,Original!)
/*else	
    opensheet(w_preinscripción_2014,w_insc_coord,6,Original!)
end if*/
end event

on w_insc_coord.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_insc_coord.destroy
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


end event

event close;//IF IsValid (g_nv_security) then
//	g_nv_security.fnv_close_security()
//END IF

end event

type mdi_1 from mdiclient within w_insc_coord
long BackColor=276856960
end type

