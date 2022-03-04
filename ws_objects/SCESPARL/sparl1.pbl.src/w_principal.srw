$PBExportHeader$w_principal.srw
forward
global type w_principal from window
end type
type mdi_1 from mdiclient within w_principal
end type
end forward

global type w_principal from window
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
event ue_inicializa_ventana ( )
mdi_1 mdi_1
end type
global w_principal w_principal

event ue_inicializa_ventana();
string ls_plantel,ls_nombre
Integer li_return
boolean lb_this
ls_nombre=gs_usuario

setpointer(Hourglass!)

if Pos(usuario,"inscrip") > 0 then
	gi_nivel_usuario = 1
elseif Pos(usuario,"inscpos") > 0 then
	gi_nivel_usuario = 2
else
	gi_nivel_usuario = 13
end if

//SELECT first_name+' '+last_name
//INTO :ls_nombre
//FROM pc_user_def
//WHERE pc_user_def.user_id = :usuario USING gtr_sce;

SELECT description
INTO :ls_nombre
FROM security_users
WHERE security_users.name = :ls_nombre
USING gtr_sce;


SELECT plantel
INTO :ls_plantel
FROM planteles
WHERE actual = 1 USING gtr_sce;

//title=usuario+' '+ls_nombre+"  Plantel: "+ls_plantel
title= ' '+gs_usuario+' '+ls_nombre+' '+ '  Plantel: '+ls_plantel

//Seguridad via PFC


/**/gnv_app.of_SetSecurity(TRUE)
//Comentado para aprovechar el uso de una transaccion
//gnv_app.itr_security = CREATE n_tr
/**/gnv_app.itr_security = gtr_sce
/**/li_return = gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), gs_sce)
//gnv_app.itr_security.of_Connect()

li_return = gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, &
gs_usuario, "Default")

lb_this = gnv_app.inv_security.of_SetSecurity(this)


uo_periodo_servicios luo_periodo_servicios 
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 
luo_periodo_servicios.f_carga_periodos_tipo(gtr_sce) 
gs_descripcion_tipo_periodo = luo_periodo_servicios.f_recupera_descripcion_tipo( gs_tipo_periodo) 






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

event open;

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
// Si el plantel activo soporta múltiples periodos y el periodo es cualquiera
IF gs_periodo_default =  "C" THEN 
	
	SELECT multiple_periodo INTO :gs_multiples_periodos 
	FROM planteles WHERE actual = 1 USING gtr_sce;
	
	// Se verifica si el plantel soporta múltiples periodos.
	IF gs_multiples_periodos ="S" THEN 
		//Se habilita opción de menú para cambiar el periodo.
		m_principal.m_configuracion.m_cambiotipodeperiodo.visible = TRUE
		//gs_tipo_periodo = "S" 
		// Se abre ventana de selección de periodo.
		//OPEN(w_cambio_tipo_periodo) 
	// Si no se permiten múltiples periodos se asigna "Semestral" por omisión al tipo de periodo y a la bandera indicadora.
	ELSE
		//Se habilita opción de menú para cambiar el periodo.
		m_principal.m_configuracion.m_cambiotipodeperiodo.visible = FALSE 
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
	m_principal.m_configuracion.m_cambiotipodeperiodo.visible = FALSE	  
END IF	

//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**
//**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**--**	
periodo_actual(gi_periodo,gi_anio,gtr_sce)

// Se recupera el periodo siguiente.
uo_periodo_servicios luo_periodo_servicios
luo_periodo_servicios = CREATE uo_periodo_servicios 
luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 
luo_periodo_servicios.f_recupera_periodo_siguiente( gi_periodo, gi_anio, gtr_sce)
// **************************************************************


TRIGGEREVENT("ue_inicializa_ventana")

//
//string ls_plantel,ls_nombre
//Integer li_return
//boolean lb_this
//ls_nombre=gs_usuario
//
//setpointer(Hourglass!)
//
//if Pos(usuario,"inscrip") > 0 then
//	gi_nivel_usuario = 1
//elseif Pos(usuario,"inscpos") > 0 then
//	gi_nivel_usuario = 2
//else
//	gi_nivel_usuario = 13
//end if
//
////SELECT first_name+' '+last_name
////INTO :ls_nombre
////FROM pc_user_def
////WHERE pc_user_def.user_id = :usuario USING gtr_sce;
//
//SELECT description
//INTO :ls_nombre
//FROM security_users
//WHERE security_users.name = :ls_nombre
//USING gtr_sce;
//
//
//SELECT plantel
//INTO :ls_plantel
//FROM planteles
//WHERE actual = 1 USING gtr_sce;
//
////title=usuario+' '+ls_nombre+"  Plantel: "+ls_plantel
//title= ' '+gs_usuario+' '+ls_nombre+' '+ '  Plantel: '+ls_plantel
//
////Seguridad via PFC
//
//
///**/gnv_app.of_SetSecurity(TRUE)
////Comentado para aprovechar el uso de una transaccion
////gnv_app.itr_security = CREATE n_tr
///**/gnv_app.itr_security = gtr_sce
///**/li_return = gnv_app.itr_security.of_Init_Sce(gnv_app.of_GetAppINIFile(), "SCE")
////gnv_app.itr_security.of_Connect()
//
//li_return = gnv_app.inv_security.of_InitSecurity(gnv_app.itr_security, GetApplication().appname, &
//gs_usuario, "Default")
//
//lb_this = gnv_app.inv_security.of_SetSecurity(this)
//
//
//uo_periodo_servicios luo_periodo_servicios 
//luo_periodo_servicios = CREATE uo_periodo_servicios 
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce) 
//luo_periodo_servicios.f_carga_periodos_tipo(gtr_sce) 
//gs_descripcion_tipo_periodo = luo_periodo_servicios.f_recupera_descripcion_tipo( gs_tipo_periodo) 
//
//
//
//
//
//
end event

type mdi_1 from mdiclient within w_principal
long BackColor=276856960
end type

