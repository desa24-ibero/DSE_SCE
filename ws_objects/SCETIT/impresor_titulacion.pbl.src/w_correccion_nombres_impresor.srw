$PBExportHeader$w_correccion_nombres_impresor.srw
forward
global type w_correccion_nombres_impresor from window
end type
type cb_2 from commandbutton within w_correccion_nombres_impresor
end type
type cb_1 from commandbutton within w_correccion_nombres_impresor
end type
type dw_nombres from datawindow within w_correccion_nombres_impresor
end type
end forward

global type w_correccion_nombres_impresor from window
integer width = 4549
integer height = 2568
boolean titlebar = true
string title = "Edición de Nombres en Tittulos"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
cb_1 cb_1
dw_nombres dw_nombres
end type
global w_correccion_nombres_impresor w_correccion_nombres_impresor

type variables
uo_parametros_corr_titulacion iuo_parametros_corr_titulacion 


end variables

forward prototypes
public function integer wf_despliega_nombres ()
end prototypes

public function integer wf_despliega_nombres ();
iuo_parametros_corr_titulacion.ids_paso.ROWSCOPY(1, iuo_parametros_corr_titulacion.ids_paso.ROWCOUNT(), PRIMARY!, dw_nombres, 1, PRIMARY!)     



RETURN 0 






end function

on w_correccion_nombres_impresor.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_nombres=create dw_nombres
this.Control[]={this.cb_2,&
this.cb_1,&
this.dw_nombres}
end on

on w_correccion_nombres_impresor.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_nombres)
end on

event open;
iuo_parametros_corr_titulacion = CREATE uo_parametros_corr_titulacion  

iuo_parametros_corr_titulacion = MESSAGE.POWEROBJECTPARM 


iuo_parametros_corr_titulacion.ids_paso.ROWSCOPY(1, iuo_parametros_corr_titulacion.ids_paso.ROWCOUNT(), PRIMARY!, dw_nombres, 1, PRIMARY!) 
dw_nombres.SETROWFOCUSINDICATOR(HAND!)





end event

type cb_2 from commandbutton within w_correccion_nombres_impresor
integer x = 4050
integer y = 2296
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked; CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_correccion_nombres_impresor
integer x = 3621
integer y = 2296
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;
dw_nombres.SETFILTER("bandera_diferente = 1") 
dw_nombres.FILTER() 

IF dw_nombres.ROWCOUNT() > 0 THEN  
	IF MESSAGEBOX("Confirmación", "Los nombres listados presentan diferencias con los nombres almacenados en Control Escolar. ¿Desea continuar? ", Question!, YesNoCancel!) > 1 THEN RETURN 
END IF 	

// Se regresa la información a la ventana de reporte. 

iuo_parametros_corr_titulacion.ids_paso.RESET() 
dw_nombres.SETFILTER("")
dw_nombres.FILTER()  

// Se actualizan los nombres en la tabla titulacion. 

LONG ll_pos
LONG ll_ttl_rgs 
LONG ll_cuenta 
LONG ll_cve_carrera 
LONG ll_cve_plan
STRING ls_nombre, ls_a_paterno, ls_a_materno, ls_error, ls_cuenta 

ll_ttl_rgs = dw_nombres.ROWCOUNT()  


FOR ll_pos = 1 TO ll_ttl_rgs 

	ls_cuenta = dw_nombres.GETITEMSTRING(ll_pos, "cuenta") 
	ll_cuenta = LONG( LONG( LEFT(ls_cuenta, LEN(ls_cuenta) -  (LEN(ls_cuenta) - (POS(ls_cuenta, "-") - 1))))) 
	ll_cve_carrera = dw_nombres.GETITEMNUMBER(ll_pos, "cve_carrera")  
	ll_cve_plan = dw_nombres.GETITEMNUMBER(ll_pos, "cve_plan")
	ls_nombre = dw_nombres.GETITEMSTRING(ll_pos, "nombre") 
	ls_a_paterno = dw_nombres.GETITEMSTRING(ll_pos, "a_paterno")  
	ls_a_materno = dw_nombres.GETITEMSTRING(ll_pos, "a_materno") 

	UPDATE titulacion 
	SET nombre_t = :ls_nombre, 
		apaterno_t = :ls_a_paterno,  
		amaterno_t = :ls_a_materno 
	WHERE cuenta = :ll_cuenta 
	AND cve_plan = :ll_cve_plan 
	AND cve_carrera = :ll_cve_carrera 
	USING gtr_sce;
	IF gtr_sce.SQLCODE < 0 THEN 
		ls_error = gtr_sce.SQLERRTEXT 
		ROLLBACK USING gtr_sce; 
		MESSAGEBOX("Error", "Se produjo un error al actualizar el Nombre para impresión del Título: " + ls_error) 
		RETURN -1 
	END IF 

NEXT 

COMMIT USING gtr_sce; 

MESSAGEBOX("Aviso", "Los nombres fueron actualizados con éxito.")

dw_nombres.ROWSCOPY(1, dw_nombres.ROWCOUNT(), PRIMARY!, iuo_parametros_corr_titulacion.ids_paso, 1, PRIMARY!)



end event

type dw_nombres from datawindow within w_correccion_nombres_impresor
integer x = 69
integer y = 56
integer width = 4379
integer height = 2208
integer taborder = 20
string title = "Confirmación de Nombres Impresos en Títulos"
string dataobject = "dw_correccion_nombres_titulo_imp"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

