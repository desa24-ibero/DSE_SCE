$PBExportHeader$w_complemento_al_titulo.srw
forward
global type w_complemento_al_titulo from window
end type
type dw_carrera from datawindow within w_complemento_al_titulo
end type
type st_2 from statictext within w_complemento_al_titulo
end type
type cb_imprime from commandbutton within w_complemento_al_titulo
end type
type st_1 from statictext within w_complemento_al_titulo
end type
type dw_idioma from datawindow within w_complemento_al_titulo
end type
type cb_consultar from commandbutton within w_complemento_al_titulo
end type
type dw_reporte from datawindow within w_complemento_al_titulo
end type
type uo_cuenta from uo_nombre_alumno_2013 within w_complemento_al_titulo
end type
type r_1 from rectangle within w_complemento_al_titulo
end type
type r_2 from rectangle within w_complemento_al_titulo
end type
end forward

global type w_complemento_al_titulo from window
integer width = 4338
integer height = 2500
boolean titlebar = true
string title = "Complemento al Título"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
event ue_inicia_proceso ( )
dw_carrera dw_carrera
st_2 st_2
cb_imprime cb_imprime
st_1 st_1
dw_idioma dw_idioma
cb_consultar cb_consultar
dw_reporte dw_reporte
uo_cuenta uo_cuenta
r_1 r_1
r_2 r_2
end type
global w_complemento_al_titulo w_complemento_al_titulo

type variables
DatawindowChild dwcIdioma 
end variables

forward prototypes
public function boolean wf_es_alumno_titulado (long al_cuenta)
end prototypes

event ue_inicia_proceso();Long		ll_cuenta
Int			li_CodigoRetorno
DataWindowChild dwc_cuenta

ll_cuenta = Message.Longparm

// Oscar Sánchez. 23-Julio-2018, Obtener las posibles carreras del alumno ...

li_CodigoRetorno = dw_carrera.GetChild ( 'cve_carrera' , dwc_cuenta )

IF li_CodigoRetorno = -1 THEN 
	MessageBox( "Error" , "Al obtener la DataWindowChild dwc_cuenta" )
END IF
		
dwc_cuenta.SetTransObject ( gtr_sce )

dwc_cuenta.Retrieve ( ll_cuenta )

dw_carrera.SetTransObject ( gtr_sce )
dw_carrera.InsertRow ( 0 )


end event

public function boolean wf_es_alumno_titulado (long al_cuenta);/*
	Fecha de creación:	13-Julio-2017
	Descripción:				Verifica si la cuenta corresponde a un alumno titulado.
	_______________________________________________________________________________________
	Control de cambios:
	Nombre				Fecha					Descripción
	Oscar Sánchez		13-Julio-2017		Versión Inicial
*/

Boolean	lb_retorno
Int			li_cantidad

SELECT	Count ( cuenta )
INTO		:li_cantidad
FROM		titulacion
where 	cuenta = :al_cuenta
USING	gtr_sce;

lb_retorno = True

IF gtr_sce.SQLCode = -1 THEN
	lb_retorno = False
	MessageBox ( "Error" , "De base de datos al consultar si el alumno ya está titulado.~n~r" + gtr_sce.SQLErrText )
END IF

IF gtr_sce.SQLCode = 100 THEN
	// El alumno no está titulado ...
	lb_retorno = False
END IF

Return lb_retorno
end function

on w_complemento_al_titulo.create
this.dw_carrera=create dw_carrera
this.st_2=create st_2
this.cb_imprime=create cb_imprime
this.st_1=create st_1
this.dw_idioma=create dw_idioma
this.cb_consultar=create cb_consultar
this.dw_reporte=create dw_reporte
this.uo_cuenta=create uo_cuenta
this.r_1=create r_1
this.r_2=create r_2
this.Control[]={this.dw_carrera,&
this.st_2,&
this.cb_imprime,&
this.st_1,&
this.dw_idioma,&
this.cb_consultar,&
this.dw_reporte,&
this.uo_cuenta,&
this.r_1,&
this.r_2}
end on

on w_complemento_al_titulo.destroy
destroy(this.dw_carrera)
destroy(this.st_2)
destroy(this.cb_imprime)
destroy(this.st_1)
destroy(this.dw_idioma)
destroy(this.cb_consultar)
destroy(this.dw_reporte)
destroy(this.uo_cuenta)
destroy(this.r_1)
destroy(this.r_2)
end on

event open;integer 	rtncode, li_cve_idioma

SetPointer(HourGlass!)

//Getchild Tipo
rtncode = dw_idioma.GetChild("cve_idioma", dwcidioma )

IF rtncode = -1 THEN 
	MessageBox("Error", "No se pudo recuperar el data window Idioma")
	return
End If 

dwcidioma.SetTransObject(gtr_sce)
dw_idioma.SetTransObject(gtr_sce)
dw_reporte.settransobject( gtr_sce)

if dwcidioma.Retrieve() <= 0 then 
	messagebox('Información', 'No existen idiomas')
	return
else
	dw_idioma.retrieve()
end if
end event

type dw_carrera from datawindow within w_complemento_al_titulo
integer x = 901
integer y = 524
integer width = 2345
integer height = 92
integer taborder = 40
string title = "none"
string dataobject = "dw_carrera_titulada_x_cuenta"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_2 from statictext within w_complemento_al_titulo
integer x = 901
integer y = 460
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Carrera:"
boolean focusrectangle = false
end type

type cb_imprime from commandbutton within w_complemento_al_titulo
integer x = 3337
integer y = 560
integer width = 338
integer height = 100
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;string ls_fecha_envio, ls_fecha
DataStore Ds_reporte_direct
long	ll_result

If dw_reporte.rowcount( ) > 0 Then
		PrintSetup();
		If 	dw_reporte.print() = -1 Then
			MessageBox('Error del Sistema', 'Error al imprimir el documento')
			return -1
		End If
Else
	MessageBox('Mensaje del Sistema', 'No existe información en el reporte para imprimir')
End If
end event

type st_1 from statictext within w_complemento_al_titulo
integer x = 137
integer y = 460
integer width = 247
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "Idioma:"
boolean focusrectangle = false
end type

type dw_idioma from datawindow within w_complemento_al_titulo
integer x = 133
integer y = 536
integer width = 635
integer height = 84
integer taborder = 20
string title = "none"
string dataobject = "dddw_comp_tit_idioma"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_consultar from commandbutton within w_complemento_al_titulo
integer x = 3337
integer y = 420
integer width = 338
integer height = 100
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consultar"
end type

event clicked;integer li_row, li_idioma, li_row2, li_rtncode
long ll_cuenta
datawindowchild ldwc_datos_alum
string ls_apaterno
Long		ll_cve_carrera

// Oscar Sánchez. 24-Julio-2018, obtener la carrera  ...
ll_cve_carrera = dw_carrera.Object.cve_carrera [1]

IF IsNull ( ll_cve_carrera ) THEN
	MessageBox ( "Aviso:" , "Por favor, selecciona la carrera ..." )
	dw_carrera.SetFocus ( )
	Return -1
END IF
// Oscar Sánchez. 24-Julio-2018, obtener la carrera  ...

//Getchild Tipo
li_rtncode = dw_reporte.GetChild("dw_4", ldwc_datos_alum )

IF li_rtncode = -1 THEN 
	MessageBox("Error", "No se pudo recuperar el data window dw_4")
	return
End If 
ldwc_datos_alum.SetTransObject(gtr_sce)

dwcidioma.accepttext( )
dw_idioma.accepttext( )

li_row = dwcidioma.getrow()
li_idioma = dwcidioma.getitemnumber(li_row, 'cve_idioma')

ll_cuenta = uo_cuenta.of_obten_cuenta( )
ls_apaterno = uo_cuenta.of_obten_apaterno( )

If ll_cuenta = 0 Or ls_apaterno = "" Or len(ls_apaterno) <= 1 Then
	MessageBox('Mensaje del Sistema', 'Es necesario proporcionar una cuenta valida', StopSign!)
	dw_reporte.reset( )
	return -1
End If

If li_idioma = 0 Then
	MessageBox('Mensaje del Sistema', 'Es necesario elegir un idioma', StopSign!)
	dw_reporte.reset( )
	return -1
End If

// Oscar Sánchez. 13-Julio-2018, Validar si la cuenta pertenece a un alumno de titulación ...
IF not wf_es_alumno_titulado ( ll_cuenta ) THEN
	MessageBox ( "Mensaje del Sistema" , "La cuenta no pertenece a un alumno titulado" )
	Return -1
END IF
// Oscar Sánchez. 13-Julio-2018, Validar si la cuenta pertenece a un alumno de titulación ...

If dw_reporte.Retrieve ( li_idioma , ll_cuenta , ll_cve_carrera ) <= 0  Then //Or ldwc_datos_alum.retrieve(li_idioma, ll_cuenta ) <= 0 Then 
	MessageBox('Mensaje del Sistema', 'No existe información para la consulta realizada...')
	dw_reporte.reset( )
	return -1
End If
end event

type dw_reporte from datawindow within w_complemento_al_titulo
integer x = 46
integer y = 716
integer width = 4027
integer height = 1592
integer taborder = 40
string title = "none"
string dataobject = "dw_complemento_al_titulo"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type uo_cuenta from uo_nombre_alumno_2013 within w_complemento_al_titulo
integer x = 82
integer y = 40
integer taborder = 10
end type

on uo_cuenta.destroy
call uo_nombre_alumno_2013::destroy
end on

type r_1 from rectangle within w_complemento_al_titulo
integer linethickness = 4
long fillcolor = 16777215
integer x = 82
integer y = 448
integer width = 745
integer height = 204
end type

type r_2 from rectangle within w_complemento_al_titulo
integer linethickness = 4
long fillcolor = 16777215
integer x = 859
integer y = 448
integer width = 2441
integer height = 204
end type

