$PBExportHeader$intercambio.sra
$PBExportComments$Generated PFC-Based Application
forward
global type intercambio from application
end type
global n_tr sqlca
global dynamicdescriptionarea sqlda
global dynamicstagingarea sqlsa
global error error
global n_msg message
end forward

global variables
/*  Application Manager  */
n_cst_intercambio gnv_app 

n_tr gtr_sce

Constant long VK_NUMLOCK						=  144
Constant long VK_SCROLL							=  145
Constant long VK_CAPITAL						= 20
Constant long KEYEVENTF_EXTENDEDKEY			= 1
Constant long KEYEVENTF_KEYUP					= 2
Constant long VER_PLATFORM_WIN32_NT			= 2
Constant long VER_PLATFORM_WIN32_WINDOWS	= 1


end variables

global type intercambio from application
string appname = "intercambio"
end type
global intercambio intercambio

type prototypes
FUNCTION uLong GetVersionExA(Ref str_osversioninfo lpVersionInfo) LIBRARY "KERNEL32.DLL" alias for "GetVersionExA;Ansi"
SUBROUTINE keybd_event(int bVk, int bScan, int dwFlags, int dwExtraInfo) LIBRARY "USER32.DLL" 
FUNCTION boolean GetKeyboardState(ref integer kbarray[256])  LIBRARY "USER32.DLL"
FUNCTION boolean SetKeyboardState(ref integer kbarray[256]) LIBRARY "USER32.DLL"
FUNCTION ulong FindWindowA(ulong Winhandle, string Wintitle) LIBRARY "USER32.DLL" alias for "FindWindowA;Ansi"
FUNCTION ulong FindWindowA(ref string lpClassName, ref string lpWindowName) LIBRARY "USER32.DLL" alias for "FindWindowA;Ansi"
Function long GetClassNameA(ulong hwnd, ref string cname, int buf) LIBRARY "User32.dll" alias for "GetClassNameA;Ansi"

end prototypes

on intercambio.create
appname="intercambio"
message=create n_msg
sqlca=create n_tr
sqlda=create dynamicdescriptionarea
sqlsa=create dynamicstagingarea
error=create error
end on

on intercambio.destroy
destroy(sqlca)
destroy(sqlda)
destroy(sqlsa)
destroy(error)
destroy(message)
end on

event open;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	open
//
//	Arguments:
//	string	commandline		Argumentos adicionales incluidos sobre la línea de
//									comando después del nombre del programa ejecutable.
//
//	Returns:
//	None
//
//	Description:	
//	Crea el manejador de la aplicación, n_cst_intercambio, como gnv_app, 
//	entonces dispara el evento pfc_open.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
gnv_app = create n_cst_intercambio

gnv_app.Event pfc_open ( commandline )
end event

event close;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	close
//
//	Arguments:
//	None
//
//	Returns:
//	None
//
//	Description:	
//	Dispara el evento pfc_close sobre gnv_app, luego destruye el manejador
//	de la aplicación
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
gnv_app.Event pfc_close ( )

Destroy gnv_app
end event

event systemerror;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	systemerror
//
//	Arguments:
//	None
//
//	Returns:
//	None
//
//	Description:	
//	Dispara el evento pfc_systemerror sobre el manejador de la aplicación
//	gnv_app.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
gnv_app.Event pfc_systemerror ( )
end event

event connectionbegin;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	connectionbegin
//
//	Arguments:
//	userid				El usuario.
//	password				La contraseña.
//	connectstring		La cadena de conexión.
//
//	Returns:
//	connectprivilege
//
//	Description:	
//	Dispara el evento pfc_connectionbegin sobre el manejador de la aplicación
//	gnv_app.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
Return gnv_app.Event pfc_connectionbegin ( userid, password, connectstring )
end event

event connectionend;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	connectionend
//
//	Arguments:
//	userid				El usuario.
//	password				La contraseña.
//	connectstring		La cadena de conexión.
//
//	Returns:
//	connectprivilege
//
//	Description:	
//	Dispara el evento pfc_connectionend sobre el manejador de la aplicación
//	gnv_app.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
gnv_app.Event pfc_connectionend (  )
end event

event idle;//////////////////////////////////////////////////////////////////////////////
//
//	Event:
//	idle
//
//	Arguments:
//	None
//
//	Returns:
//	None
//
//	Description:	
//	Dispara el evento pfc_idle sobre gnv_app.
//
//////////////////////////////////////////////////////////////////////////////
//	
//	Revision History
//
//	Version
//	1.0   Initial version
//
//////////////////////////////////////////////////////////////////////////////
gnv_app.Event pfc_idle (  )
end event

