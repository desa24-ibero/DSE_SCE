$PBExportHeader$w_actualiza_cambios_nota.srw
forward
global type w_actualiza_cambios_nota from window
end type
type cb_1 from commandbutton within w_actualiza_cambios_nota
end type
type cb_salir from commandbutton within w_actualiza_cambios_nota
end type
type cb_imprimir from commandbutton within w_actualiza_cambios_nota
end type
type cb_ransferir from commandbutton within w_actualiza_cambios_nota
end type
type uo_periodo from uo_per_ani within w_actualiza_cambios_nota
end type
type dw_transferidas from datawindow within w_actualiza_cambios_nota
end type
type gb_1 from groupbox within w_actualiza_cambios_nota
end type
end forward

global type w_actualiza_cambios_nota from window
integer width = 4754
integer height = 2280
boolean titlebar = true
string title = "Actualiza Cambios de Nota"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_salir cb_salir
cb_imprimir cb_imprimir
cb_ransferir cb_ransferir
uo_periodo uo_periodo
dw_transferidas dw_transferidas
gb_1 gb_1
end type
global w_actualiza_cambios_nota w_actualiza_cambios_nota

type variables
n_tr itr_web

INTEGER ii_periodo 
INTEGER ii_anio 
end variables

forward prototypes
public function integer wf_transfiere ()
end prototypes

public function integer wf_transfiere ();
IF conecta_bd(itr_web,gs_web_param, gs_usuario,gs_password)<>1 THEN 
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de Control Escolar WEB", StopSign!)
	RETURN -1
END IF 

STRING ls_sql 
LONG ll_ttl_rgs

ls_sql = "  SELECT ui_bicamnot_linea.cuenta, " + &    
					" ui_bicamnot_linea.cve_movimiento, " + &      
					" ui_bicamnot_linea.cve_mat, " + &      
					" ui_bicamnot_linea.gpo, " + &      
					" ui_bicamnot_linea.periodo, " + &      
					" ui_bicamnot_linea.anio, " + &      
					" ui_bicamnot_linea.calificacion, " + &      
					" ui_bicamnot_linea.calificacion_ant, " + &      
					" ui_bicamnot_linea.fecha_hora, " + &      
					" ui_bicamnot_linea.usuario, " + &      
					" ui_bicamnot_linea.cve_tipo_examen, " + &      
					" ui_bicamnot_linea.actualizado, " + &      
					" ui_bicamnot_linea.fecha_actualizado " + &     
			 " FROM ui_bicamnot_linea " + &      
		" WHERE ui_bicamnot_linea.actualizado = 0 "  + & 
		" AND ui_bicamnot_linea.periodo =  " + STRING(ii_periodo) + &      
		" AND ui_bicamnot_linea.anio = " + STRING(ii_anio)   + & 
		" ORDER BY ui_bicamnot_linea.fecha_hora asc " 

dw_transferidas.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'") 
dw_transferidas.SETTRANSOBJECT(itr_web) 
ll_ttl_rgs = dw_transferidas.RETRIEVE()  
IF ll_ttl_rgs < 0 THEN 
	// Se produjo un error al transferir la información de
	DISCONNECT USING itr_web;
	MESSAGEBOX("Error", "Se produjo un error al recuperar la información de Cambio de Nota del WEB") 
	RETURN -1 	
END IF
IF ll_ttl_rgs = 0 THEN 
	DISCONNECT USING itr_web;
	MESSAGEBOX("Aviso", "No hay registros nuevos de Cambio de Nota en WEB del periodo seleccionado") 
	RETURN -1 	
END IF 	

DATASTORE lds_inserta
lds_inserta = CREATE DATASTORE 
lds_inserta.DATAOBJECT = dw_transferidas.DATAOBJECT 
lds_inserta.SETTRANSOBJECT(gtr_sce) 
dw_transferidas.ROWSCOPY(1, dw_transferidas.ROWCOUNT(), PRIMARY!, lds_inserta, 1, PRIMARY!)

IF lds_inserta.UPDATE() < 0 THEN 
	DISCONNECT USING itr_web;	
	// Se produjo un error al transferir la información de
	MESSAGEBOX("Error", "Se produjo un error al copiar la información de Cambio de Nota") 
	RETURN -1 
ELSE 
	COMMIT USING gtr_sce; 
	// Se produjo un error al transferir la información de
//	MESSAGEBOX("Aviso", "Información transferida con éxito.")  
//	RETURN -1 	
END IF 	

LONG ll_pos 

FOR ll_pos = 1 TO dw_transferidas.ROWCOUNT() 
	dw_transferidas.SETITEM(ll_pos, "actualizado", 1)
NEXT 

IF dw_transferidas.UPDATE() < 0 THEN 
	ROLLBACK USING itr_web;
	DISCONNECT USING itr_web;
	MESSAGEBOX("Error", "Se produjo un error al actualizar el estatus de los registros en WEB")
	RETURN -1 
END IF 

gtr_sce.AUTOCOMMIT = TRUE  

DECLARE  lsp_ui_bicamnot_linea PROCEDURE FOR sp_ui_bicamnot_linea 
using gtr_sce ; 
	
EXECUTE lsp_ui_bicamnot_linea;
if len(gtr_sce.sqlerrtext) > 0 then 
	ROLLBACK USING itr_web;
	DISCONNECT USING itr_web;
	messagebox('Error',gtr_sce.sqlerrtext)
	return -1 
end if
CLOSE lsp_ui_bicamnot_linea;

gtr_sce.AUTOCOMMIT = FALSE 
COMMIT USING itr_web;
DISCONNECT USING itr_web;
//COMMIT USING gtr_sce;

MESSAGEBOX("Aviso", "Información transferida con éxito.")  

RETURN 0 









end function

on w_actualiza_cambios_nota.create
this.cb_1=create cb_1
this.cb_salir=create cb_salir
this.cb_imprimir=create cb_imprimir
this.cb_ransferir=create cb_ransferir
this.uo_periodo=create uo_periodo
this.dw_transferidas=create dw_transferidas
this.gb_1=create gb_1
this.Control[]={this.cb_1,&
this.cb_salir,&
this.cb_imprimir,&
this.cb_ransferir,&
this.uo_periodo,&
this.dw_transferidas,&
this.gb_1}
end on

on w_actualiza_cambios_nota.destroy
destroy(this.cb_1)
destroy(this.cb_salir)
destroy(this.cb_imprimir)
destroy(this.cb_ransferir)
destroy(this.uo_periodo)
destroy(this.dw_transferidas)
destroy(this.gb_1)
end on

event open;THIS.uo_periodo.ie_anio = gi_anio 
THIS.uo_periodo.ie_periodo = gi_periodo   
THIS.uo_periodo.TRIGGEREVENT("ue_modifica") 




end event

type cb_1 from commandbutton within w_actualiza_cambios_nota
integer x = 2587
integer y = 88
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Exportar"
end type

event clicked;INTEGER li_rows 
INTEGER li_result1 

li_rows = dw_transferidas.ROWCOUNT() 

If li_rows > 0 Then
	li_result1 = dw_transferidas.saveas( "", Excel!, True)
	If li_result1 = 1 Then MessageBox("Mensaje del Sistema", "Archivo generado de manera satisfactoria")
Else
	MessageBox('Mensaje del Sistema', 'No existe información para generar el archivo solicitado')	
End If
end event

type cb_salir from commandbutton within w_actualiza_cambios_nota
integer x = 3918
integer y = 88
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT)  

end event

type cb_imprimir from commandbutton within w_actualiza_cambios_nota
integer x = 2112
integer y = 88
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;
If dw_transferidas.rowcount( ) > 0 Then
		PrintSetup();
		If 	dw_transferidas.print() = -1 Then
			MessageBox('Error del Sistema', 'Error al imprimir el documento')
			return -1
		End If
Else
	MessageBox('Mensaje del Sistema', 'No existe información en el reporte para imprimir')
End If
end event

type cb_ransferir from commandbutton within w_actualiza_cambios_nota
integer x = 1637
integer y = 88
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Transferir"
end type

event clicked;
wf_transfiere() 


end event

type uo_periodo from uo_per_ani within w_actualiza_cambios_nota
integer x = 247
integer y = 64
integer taborder = 10
boolean enabled = true
end type

on uo_periodo.destroy
call uo_per_ani::destroy
end on

event ue_modifica;call super::ue_modifica;PARENT.ii_periodo = THIS.ie_periodo
PARENT.ii_anio = THIS.ie_anio 
end event

type dw_transferidas from datawindow within w_actualiza_cambios_nota
integer x = 146
integer y = 388
integer width = 4151
integer height = 1640
string title = "none"
string dataobject = "dw_ui_bicamnot_linea"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_actualiza_cambios_nota
integer x = 101
integer y = 296
integer width = 4270
integer height = 1776
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cambios de Nota Transferidos: "
end type

