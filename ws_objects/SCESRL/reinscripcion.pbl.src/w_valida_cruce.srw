$PBExportHeader$w_valida_cruce.srw
forward
global type w_valida_cruce from window
end type
type cb_2 from commandbutton within w_valida_cruce
end type
type st_1 from statictext within w_valida_cruce
end type
type dw_1 from datawindow within w_valida_cruce
end type
type cb_1 from commandbutton within w_valida_cruce
end type
end forward

global type w_valida_cruce from window
integer width = 4754
integer height = 1980
boolean titlebar = true
string title = "Untitled"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_2 cb_2
st_1 st_1
dw_1 dw_1
cb_1 cb_1
end type
global w_valida_cruce w_valida_cruce

on w_valida_cruce.create
this.cb_2=create cb_2
this.st_1=create st_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.st_1,&
this.dw_1,&
this.cb_1}
end on

on w_valida_cruce.destroy
destroy(this.cb_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.cb_1)
end on

type cb_2 from commandbutton within w_valida_cruce
integer x = 4091
integer y = 260
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;dw_1.print( ) 

end event

type st_1 from statictext within w_valida_cruce
integer x = 178
integer y = 1612
integer width = 402
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type dw_1 from datawindow within w_valida_cruce
integer x = 187
integer y = 100
integer width = 3794
integer height = 1364
integer taborder = 20
string title = "none"
string dataobject = "dw_cuentas_revisa"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_1 from commandbutton within w_valida_cruce
integer x = 4064
integer y = 72
integer width = 402
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "none"
end type

event clicked;LONG cta
LONG mat
STRING gpo


//  Carlos Armando Melgoza Piña  									Marzo 1997
//  Función que revisa si no existe ninguna materia inscrita en ese horario 
//  Regresa 0 si no se enciman materias y 1 en caso contrario

Integer	li_resultado			// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
String		ls_mensaje			// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
Integer	li_materia_cruce	// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
String		ls_grupo_cruce		// Oscar Sánchez, 13-Septiembre-2018. La validación de horario debe ser por medio del llamado a un SP
String		ls_sesionado
int d,h, cont,c,verif
//long año
//int per
//periodo_actual_insc(per,año)

LONG ll_materias
LONG ll_pos 
LONG ll_row

LONG ll_asimilante 
STRING ls_asimilante
INTEGER le_tipo

DATASTORE lds_cuentas  
lds_cuentas = CREATE DATASTORE 
lds_cuentas.DATAOBJECT = "dw_cuentas_revisa" 
lds_cuentas.SETTRANSOBJECT(SQLCA) 
ll_materias = lds_cuentas.RETRIEVE() 

FOR ll_pos = 1 TO ll_materias 

	cta = lds_cuentas.GETITEMNUMBER(ll_pos, "cuenta")
	mat = lds_cuentas.GETITEMNUMBER(ll_pos, "cve_mat")
	gpo = lds_cuentas.GETITEMSTRING(ll_pos, "gpo")
	
	SELECT cve_asimilada, gpo_asimilado, tipo 
	INTO :ll_asimilante, :ls_asimilante, :le_tipo 
	FROM grupos 
	WHERE cve_mat = :mat
	AND gpo = :gpo; 
	
	IF le_tipo = 1 OR le_tipo = 2 OR le_tipo = 4  THEN CONTINUE 
	
	IF ISNULL(ll_asimilante) THEN ll_asimilante = 0 
	IF ll_asimilante <> 0 THEN 
		mat = ll_asimilante 
		gpo = ls_asimilante
	END IF		


	DECLARE  sp_validacion_materias_encimadas PROCEDURE FOR sp_srl_validacion_mat_enc_temp
	@CUENTA				= :cta,
	@MATERIA				= :mat,
	@GRUPO					= :gpo,
	@RESULTADO			= :li_resultado OUTPUT,
	@MENSAJE				= :ls_mensaje OUTPUT,
	@MATERIA_CRUCE	= :li_materia_cruce OUTPUT,
	@GRUPO_CRUCE		= :ls_grupo_cruce OUTPUT;
	
	EXECUTE sp_validacion_materias_encimadas;
	
	FETCH sp_validacion_materias_encimadas INTO :li_resultado, :ls_mensaje, :li_materia_cruce, :ls_grupo_cruce, :ls_sesionado;
	
	CLOSE sp_validacion_materias_encimadas;
		
	IF	li_resultado <> 0 THEN
		
		ll_row = dw_1.INSERTROW(0)
		dw_1.SETITEM(ll_row, "cuenta", cta)
		dw_1.SETITEM(ll_row, "cve_mat", mat)
		dw_1.SETITEM(ll_row, "gpo", gpo)
		
	END IF
	Commit;
	
	st_1.TEXT = STRING(ll_pos) + " de " + STRING(ll_materias) 
	
NEXT 	

Return 0




end event

