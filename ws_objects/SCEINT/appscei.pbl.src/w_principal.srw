$PBExportHeader$w_principal.srw
$PBExportComments$Ventana principal de la aplicación
forward
global type w_principal from window
end type
type mdi_1 from mdiclient within w_principal
end type
end forward

global type w_principal from window
integer x = 101
integer y = 364
integer width = 3479
integer height = 1664
boolean titlebar = true
string menuname = "m_principal"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
event ue_inicializa_ventana ( )
mdi_1 mdi_1
end type
global w_principal w_principal

event ue_inicializa_ventana();/*
DESCRIPCIÓN: Si el password es el correcto, habilita la seguridad en la aplicación y
				pon el nombre del usuario en la ventana.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:

string ls_nombre
ls_nombre=gs_usuario

//Comentado para migrar sin padlock
//SELECT first_name+' '+last_name
//INTO :ls_nombre
//FROM pc_user_def
//WHERE pc_user_def.user_id = :ls_nombre
//USING gtr_sce;

SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :ls_nombre
USING gtr_sce;

title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")+' '+gs_usuario+' '+ls_nombre

//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window(this)


//Seguridad via PFC
gnv_app.of_SetSecurity(TRUE)
//Comentado para aprovechar el uso de una transaccion
//gnv_app.itr_security = CREATE n_tr
gnv_app.itr_security = gtr_sce
gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
//gnv_app.itr_security.of_Connect()

Integer li_return

li_return = gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, &
gs_usuario, "Default")

gnv_app.inv_security.of_SetSecurity(this)
*/


string ls_nombre,ls_plantel, ls_tipo_periodo
//SELECT description
//INTO :ls_nombre
//FROM security_users
//WHERE security_users.name = :ls_nombre
//USING gtr_sce;
//SELECT plantel INTO:ls_plantel FROM planteles WHERE actual = 1 USING gtr_sce;


SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :gs_usuario
USING gtr_sce;
SELECT plantel INTO:ls_plantel FROM planteles WHERE actual = 1 USING gtr_sce;


// Se recupera el tipo de periodo
SELECT descripcion
INTO :ls_tipo_periodo
FROM periodo_tipo 
WHERE id_tipo = :gs_tipo_periodo 
 USING gtr_sce;
IF ISNULL(ls_tipo_periodo)  THEN ls_tipo_periodo = "" 

gs_descripcion_tipo_periodo = ls_tipo_periodo

title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")+' '+gs_usuario+' '+ls_nombre +"  Plantel: "+ls_plantel + "  Tipo Periodo Operacion: " + ls_tipo_periodo 
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

event open;uo_periodo_tipo_servicios luo_periodo_tipo_servicios
luo_periodo_tipo_servicios = CREATE uo_periodo_tipo_servicios

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
// Si el plantel activo soporta múltiples periodos y el periodo es cualquiera
IF gs_periodo_default =  "C" THEN 
	
	SELECT multiple_periodo INTO :gs_multiples_periodos 
	FROM planteles WHERE actual = 1 USING gtr_sce;
	
	// Se verifica si el plantel soporta múltiples periodos.
	IF gs_multiples_periodos ="S" THEN 
		//Se habilita opción de menú para cambiar el periodo.
		m_principal.m_especial.m_cambiodetipodeperiodo.visible = TRUE
		//gs_tipo_periodo = "S" 
		// Se abre ventana de selección de periodo.
		//OPEN(w_cambio_tipo_periodo) 
	// Si no se permiten múltiples periodos se asigna "Semestral" por omisión al tipo de periodo y a la bandera indicadora.
	ELSE
		//Se habilita opción de menú para cambiar el periodo.
		m_principal.m_especial.m_cambiodetipodeperiodo.visible = FALSE 
		gs_multiples_periodos = "N" 
		//gs_tipo_periodo = "S" 
		gs_tipo_periodo = luo_periodo_tipo_servicios.f_obten_tipo_periodo(gtr_sce, 1)
		
		IF luo_periodo_tipo_servicios.i_error = -1 THEN
			MessageBox(luo_periodo_tipo_servicios.s_title, luo_periodo_tipo_servicios.s_message, StopSign!)
			RETURN luo_periodo_tipo_servicios.i_error
		END IF
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
periodo_actual(gi_periodo,gi_anio,gtr_sce)



TRIGGEREVENT("ue_inicializa_ventana") 





///*
//DESCRIPCIÓN: Si el password es el correcto, habilita la seguridad en la aplicación y
//				pon el nombre del usuario en la ventana.
//PARÁMETROS: Ninguno
//REGRESA: Nada
//AUTOR: Víctor Manuel Iniestra Álvarez
//FECHA: 15 Junio 1998
//MODIFICACIÓN:
//
//string ls_nombre
//ls_nombre=gs_usuario
//
////Comentado para migrar sin padlock
////SELECT first_name+' '+last_name
////INTO :ls_nombre
////FROM pc_user_def
////WHERE pc_user_def.user_id = :ls_nombre
////USING gtr_sce;
//
//SELECT description
//INTO :ls_nombre
//FROM security_users
//WHERE security_users.name = :ls_nombre
//USING gtr_sce;
//
//title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")+' '+gs_usuario+' '+ls_nombre
//
////Comentado para migrar sin padlock
////g_nv_security.fnv_secure_window(this)
//
//
////Seguridad via PFC
//gnv_app.of_SetSecurity(TRUE)
////Comentado para aprovechar el uso de una transaccion
////gnv_app.itr_security = CREATE n_tr
//gnv_app.itr_security = gtr_sce
//gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
////gnv_app.itr_security.of_Connect()
//
//Integer li_return
//
//li_return = gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, &
//gs_usuario, "Default")
//
//gnv_app.inv_security.of_SetSecurity(this)
//*/
//
//
//string ls_nombre,ls_plantel, ls_tipo_periodo
////SELECT description
////INTO :ls_nombre
////FROM security_users
////WHERE security_users.name = :ls_nombre
////USING gtr_sce;
////SELECT plantel INTO:ls_plantel FROM planteles WHERE actual = 1 USING gtr_sce;
//
//
//SELECT description
//INTO :ls_nombre
//FROM security_users
//WHERE security_users.name = :gs_usuario
//USING gtr_sce;
//SELECT plantel INTO:ls_plantel FROM planteles WHERE actual = 1 USING gtr_sce;
//
//
//// Se recupera el tipo de periodo
//SELECT descripcion
//INTO :ls_tipo_periodo
//FROM periodo_tipo 
//WHERE id_tipo = :gs_tipo_periodo 
// USING gtr_sce;
//IF ISNULL(ls_tipo_periodo)  THEN ls_tipo_periodo = "" 
//
//gs_descripcion_tipo_periodo = ls_tipo_periodo
//
//title=ProfileString (gs_startupfile, gs_datos, "APLICACION","")+' '+gs_usuario+' '+ls_nombre +"  Plantel: "+ls_plantel + "  Tipo Periodo Operacion: " + ls_tipo_periodo 
//g_w_frame = this
//periodo_actual_mat_insc(gi_periodo,gi_anio,gtr_sce)
//gs_password = gtr_sce.LogPass
//
//
//gnv_app.of_SetSecurity(TRUE)
//gnv_app.itr_security = gtr_sce
//gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
//gnv_app.itr_security.of_Connect()
//if (gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, gs_usuario,"Default") <> 1) then
//		MessageBox("Atención","No se pudo inicializar correctamente la seguridad")
//		Close(this)
//end if
//gnv_app.inv_security.of_SetSecurity(this)
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
//
end event

event close;/*
DESCRIPCIÓN: Al salir de la aplicación, cierra la seguridad.
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Víctor Manuel Iniestra Álvarez
FECHA: 15 Junio 1998
MODIFICACIÓN:
*/
//Comentado para migrar sin padlock
//g_nv_security.fnv_close_security()
end event

type mdi_1 from mdiclient within w_principal
long BackColor=276856960
end type

