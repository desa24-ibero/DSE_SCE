$PBExportHeader$w_principal.srw
$PBExportComments$Ventana Principal
forward
global type w_principal from window
end type
type mdi_1 from mdiclient within w_principal
end type
end forward

global type w_principal from window
integer x = 5
integer y = 4
integer width = 3707
integer height = 2412
boolean titlebar = true
string title = "Sistema de Control Escolar"
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
long backcolor = 276856960
event ue_inicializa_ventana ( )
mdi_1 mdi_1
end type
global w_principal w_principal

event ue_inicializa_ventana();string ls_nombre,ls_plantel, ls_desc_periodo

uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :gs_usuario
USING gtr_sce;

SELECT plantel INTO:ls_plantel FROM planteles WHERE actual = 1 USING gtr_sce;

ls_desc_periodo = luo_periodo_tipo_servicios.f_obten_desc_periodo(gtr_sce, gs_tipo_periodo)

IF luo_periodo_tipo_servicios.i_error = -1 THEN 
	MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
	RETURN
END IF	

title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")+' '+gs_usuario+' '+ls_nombre +"  Plantel: "+ls_plantel + "  Tipo Periodo Operacion: " + ls_desc_periodo 
g_w_frame = this
periodo_actual_mat_insc(gi_periodo,gi_anio,gtr_sce)
gs_password = gtr_sce.LogPass

gnv_app.of_SetSecurity(TRUE)
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
gnv_app.itr_security.of_Connect()
if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
		Close(this)
end if
gnv_app.inv_security.of_SetSecurity(this)



Int		li_cve_plantel

setpointer(Hourglass!)

// Obtener el plantel actual ...
SELECT	cve_plantel
INTO		:li_cve_plantel
FROM		planteles
WHERE	actual = 1
USING	gtr_sce;

IF li_cve_plantel = 20 THEN
	// Plantel Tijuana ...
	m_principal.m_alumnos.m_reportes1.m_documentos1.m_recepcióndedocumentos.Visible = True
ELSE
	m_principal.m_alumnos.m_reportes1.m_documentos1.m_recepcióndedocumentos.Visible = False
END IF








end event

on w_principal.create
if this.MenuName = "m_principal" then this.MenuID = create m_principal
this.mdi_1=create mdi_1
this.Control[]={this.mdi_1}
end on

on w_principal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event close;/*
DESCRIPCIÓN: Al salir de la aplicación, cierra la seguridad.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 24 Junio 1998
MODIFICACIÓN:
*/

//IF IsValid (g_nv_security) THEN
//	g_nv_security.fnv_close_security ()
//END IF
//

end event

event open;//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
// Si el plantel activo soporta múltiples periodos y el periodo es cualquiera
IF gs_periodo_default =  "C" THEN 
	
	SELECT multiple_periodo INTO :gs_multiples_periodos 
	FROM planteles WHERE actual = 1 USING gtr_sce;
	
	// Se verifica si el plantel soporta múltiples periodos.
	IF gs_multiples_periodos ="S" THEN 
		//Se habilita opción de menú para cambiar el periodo.
		m_principal.m_especial.m_cambiodetipodeperiodo.visible = TRUE

	// Si no se permiten múltiples periodos se asigna "Semestral" por omisión al tipo de periodo y a la bandera indicadora.
	ELSE
		//Se habilita opción de menú para cambiar el periodo.
		m_principal.m_especial.m_cambiodetipodeperiodo.visible = FALSE 
		gs_multiples_periodos = "N" 
		gs_tipo_periodo = "S" 
	END IF
ELSEIF TRIM(gs_periodo_default) = "" THEN 
	MessageBox("Usuario sin periodo definido", "El usuario no tiene asignado un tipo de periodo por omisión",Exclamation!)
	CLOSE(THIS)
	HALT CLOSE		
ELSE
	// Se asigna por omisión el periodo que tenga asignado el usuario 
	gs_tipo_periodo = gs_periodo_default
	//Se habilita opción de menú para cambiar el periodo.
	m_principal.m_especial.m_cambiodetipodeperiodo.visible = FALSE	 
END IF	

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
periodo_actual(g_per,g_year,gtr_sce)

TRIGGEREVENT("ue_inicializa_ventana") 

end event

type mdi_1 from mdiclient within w_principal
long BackColor=276856960
end type

