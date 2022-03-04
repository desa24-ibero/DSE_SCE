$PBExportHeader$w_parametros_evaluacion.srw
$PBExportComments$Ventana para cambiar fechas
forward
global type w_parametros_evaluacion from w_main
end type
type cb_3 from u_cb within w_parametros_evaluacion
end type
type cb_2 from u_cb within w_parametros_evaluacion
end type
type cb_1 from u_cb within w_parametros_evaluacion
end type
type dw_1 from u_dw_captura within w_parametros_evaluacion
end type
end forward

global type w_parametros_evaluacion from w_main
integer x = 832
integer y = 360
integer width = 4192
integer height = 2368
string title = "Parámetros de Evaluación"
string menuname = "m_menu"
long backcolor = 67108864
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_parametros_evaluacion w_parametros_evaluacion

type variables
int ord
end variables

on w_parametros_evaluacion.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_parametros_evaluacion.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;x=1
y=1

dw_1.settransobject(gtr_sadm)

this.of_SetResize(TRUE)

this.inv_resize.of_Register &
 (dw_1, this.inv_resize.SCALERIGHTBOTTOM)
 
 dw_1.Retrieve()

end event

type cb_3 from u_cb within w_parametros_evaluacion
integer x = 3461
integer y = 1040
integer width = 238
integer taborder = 40
string text = "Buscar..."
end type

event clicked;call super::clicked;// integer li_rtn
// 
// 
//li_rtn = GetFileOpenName("Seleccione la ruta de los Archivos", &
//   docpath, docname[], "DBF", &
//   + "Archivos de Bases de Datos(*.DBF),*.DBF," &
//   + "Todos los Archivos (*.*), *.*", &
//   "C:\")
	
	
string ls_path = "C:\Archivos de programa\Aplicaciones UIA\ServiciosEscolares10\Admision\CENEVAL"

integer li_result
long ll_row
boolean lb_DirectoryExists

lb_DirectoryExists = DirectoryExists ( ls_path )
if not lb_DirectoryExists then
	ls_path = "C:\Archivos de programa\Aplicaciones UIA\ServiciosEscolares10\Admision"
	lb_DirectoryExists = DirectoryExists ( ls_path )
	if not lb_DirectoryExists then
		ls_path = ""
	end if
	
end if

li_result = GetFolder( "Elegir Carpeta", ls_path )


ll_row = dw_1.GetRow()
if ll_row > 0 then
	dw_1.SetItem(ll_row,"ruta_archivo_dsn",ls_path)
end if


// puts the user-selected path in a SingleLineEdit box.
end event

type cb_2 from u_cb within w_parametros_evaluacion
integer x = 3461
integer y = 940
integer width = 238
integer taborder = 40
string text = "Buscar..."
end type

event clicked;call super::clicked;// integer li_rtn
// 
// 
//li_rtn = GetFileOpenName("Seleccione la ruta de los Archivos", &
//   docpath, docname[], "DBF", &
//   + "Archivos de Bases de Datos(*.DBF),*.DBF," &
//   + "Todos los Archivos (*.*), *.*", &
//   "C:\")
	
	
string ls_path = "C:\Archivos de programa\Aplicaciones UIA\ServiciosEscolares10\Admision\CENEVAL"

integer li_result
long ll_row
boolean lb_DirectoryExists

lb_DirectoryExists = DirectoryExists ( ls_path )
if not lb_DirectoryExists then
	ls_path = "C:\Archivos de programa\Aplicaciones UIA\ServiciosEscolares10\Admision"
	lb_DirectoryExists = DirectoryExists ( ls_path )
	if not lb_DirectoryExists then
		ls_path = ""
	end if
	
end if

li_result = GetFolder( "Elegir Carpeta", ls_path )


ll_row = dw_1.GetRow()
if ll_row > 0 then
	dw_1.SetItem(ll_row,"archivo_no_presentaron",ls_path)
end if


// puts the user-selected path in a SingleLineEdit box.
end event

type cb_1 from u_cb within w_parametros_evaluacion
integer x = 3461
integer y = 840
integer width = 238
integer taborder = 30
string text = "Buscar..."
end type

event clicked;call super::clicked;// integer li_rtn
// 
// 
//li_rtn = GetFileOpenName("Seleccione la ruta de los Archivos", &
//   docpath, docname[], "DBF", &
//   + "Archivos de Bases de Datos(*.DBF),*.DBF," &
//   + "Todos los Archivos (*.*), *.*", &
//   "C:\")
	
	
string ls_path = "C:\Archivos de programa\Aplicaciones UIA\ServiciosEscolares10\Admision\CENEVAL"

integer li_result
long ll_row
boolean lb_DirectoryExists

lb_DirectoryExists = DirectoryExists ( ls_path )
if not lb_DirectoryExists then
	ls_path = "C:\Archivos de programa\Aplicaciones UIA\ServiciosEscolares10\Admision"
	lb_DirectoryExists = DirectoryExists ( ls_path )
	if not lb_DirectoryExists then
		ls_path = ""
	end if
	
end if

li_result = GetFolder( "Elegir Carpeta", ls_path )



ll_row = dw_1.GetRow()
if ll_row > 0 then
	dw_1.SetItem(ll_row,"archivo_presentaron",ls_path)
end if


// puts the user-selected path in a SingleLineEdit box.
end event

type dw_1 from u_dw_captura within w_parametros_evaluacion
integer x = 41
integer y = 32
integer width = 3794
integer height = 2096
integer taborder = 20
string dataobject = "d_parametros_evaluacion"
borderstyle borderstyle = styleraised!
end type

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event carga;if event actualiza()=1 then
	event primero()
	return retrieve()
end if
end event

event nuevo;call super::nuevo;long ll_renglon

ll_renglon=rowcount()

end event

event constructor;call super::constructor;this.of_SetDropDownCalendar(TRUE)
this.iuo_calendar.of_Register("fecha_ultima_aplicacion", &
  this.iuo_calendar.DDLB)

end event

