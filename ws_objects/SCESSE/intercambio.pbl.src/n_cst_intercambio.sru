$PBExportHeader$n_cst_intercambio.sru
$PBExportComments$Manejador principal de la aplicación.
forward
global type n_cst_intercambio from n_cst_appmanager
end type
end forward

global type n_cst_intercambio from n_cst_appmanager
end type
global n_cst_intercambio n_cst_intercambio

forward prototypes
public function integer of_refreshprojects ()
end prototypes

public function integer of_refreshprojects ();// This function will find the active sheet and refresh the projects listed there.
// This function is called whenever a change has been made to the current project,
// a new project added, or the current project deleted.

//w_s_projectlist	w_active
//
//w_active = this.of_getframe().GetActiveSheet()
//IF IsValid(w_active) THEN
//	Return w_s_projectlist.of_refresh()
//END IF
//
Return 0
end function

on n_cst_intercambio.create
call super::create
end on

on n_cst_intercambio.destroy
call super::destroy
end on

event pfc_open;call super::pfc_open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	pfc_open
//
//	Arguments:
//	as_commandline		Cualquier parámetro de Línea de mando ya fue
//							suministrado cuando la aplicación fue lanzada. 
//
//	Returns:
//	None
//
//	Description:
//	Crea una ventana de bienvenida e inicializa algunos servicios
//	de la aplicación. Realiza la conexión a la base de datos y abre
//	la ventana principal de la aplicación.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
integer	li_return
string	ls_inifile

// Display the Splash window
this.of_Splash(1)

// Initialize the various functionality of this service
this.of_SetTrRegistration(TRUE)
this.of_SetError(TRUE)
inv_error.of_SetPredefinedSource(gtr_sce)

// Connect to database
ls_inifile = gnv_app.of_GetAppIniFile()
IF gtr_sce.of_Init(ls_inifile, "Database") = -1 THEN
	this.inv_error.of_message(gnv_app.iapp_object.DisplayName, + &
			"Error initializing connection information, .INI file not found.")
ELSE
	IF gtr_sce.of_Connect() = -1 THEN
		this.inv_error.of_message(gnv_app.iapp_object.DisplayName, + &
				"Error connecting to Database.", StopSign!, OK!)
	ELSE
		Open(w_frame_intercambio)
	END IF 
END IF
end event

event constructor;call super::constructor;//////////////////////////////////////////////////////////////////////////////
//
//	Object Name:  n_cst_intercambio
//
//	Description:
//	Objeto de usuario para administrar la aplicación.
//
//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	constructor
//
//	Arguments:
//	None
//
//	Returns:
//	Long
//
//	Description:
//	Pone la información por defecto necesaria para esta aplicación y 
//	crea el objeto de transacción apropiado para la misma.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
/*-------------------------------------------------------*/
/* Información por defecto de la aplicación.					*/
/*-------------------------------------------------------*/
iapp_object.DisplayName = "SCE - Sistema de Control Escolar"
this.of_SetCopyright("Copyright © 2004 Universidad Iberoamericana-Santa Fe.  All rights reserved.")
this.of_SetLogo("uia.bmp")
this.of_SetVersion("Version 1.0.00")
this.of_SetAppIniFile("intercambio.ini")

/*-------------------------------------------------------*/
/* Transacción principal de la aplicación.					*/
/*-------------------------------------------------------*/
gtr_sce = create n_tr




end event

