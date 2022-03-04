$PBExportHeader$w_reporte_cambio_nota.srw
forward
global type w_reporte_cambio_nota from window
end type
type dw_calificacion from datawindow within w_reporte_cambio_nota
end type
type cb_generar from commandbutton within w_reporte_cambio_nota
end type
type uo_nombre from uo_nombre_alumno_2013 within w_reporte_cambio_nota
end type
type cb_2 from commandbutton within w_reporte_cambio_nota
end type
type cb_imprimir from commandbutton within w_reporte_cambio_nota
end type
type dw_materia from datawindow within w_reporte_cambio_nota
end type
type uo_1 from uo_per_ani within w_reporte_cambio_nota
end type
type st_4 from statictext within w_reporte_cambio_nota
end type
type uoi_coordinaciones from uo_coordinaciones within w_reporte_cambio_nota
end type
type dw_reporte from datawindow within w_reporte_cambio_nota
end type
type r_1 from rectangle within w_reporte_cambio_nota
end type
end forward

global type w_reporte_cambio_nota from window
integer width = 4859
integer height = 2288
boolean titlebar = true
string title = "Impresión para Cambio de Nota"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
string icon = "AppIcon!"
boolean center = true
dw_calificacion dw_calificacion
cb_generar cb_generar
uo_nombre uo_nombre
cb_2 cb_2
cb_imprimir cb_imprimir
dw_materia dw_materia
uo_1 uo_1
st_4 st_4
uoi_coordinaciones uoi_coordinaciones
dw_reporte dw_reporte
r_1 r_1
end type
global w_reporte_cambio_nota w_reporte_cambio_nota

type variables
LONG ii_cve_coordinacion
uo_materias_servicios iuo_materias_servicios 
end variables

forward prototypes
public subroutine wf_limpia_calificacion ()
end prototypes

public subroutine wf_limpia_calificacion ();dw_calificacion.RESET() 
dw_calificacion.INSERTROW(0)

dw_reporte.RESET() 
//dw_reporte.INSERTROW(0) 

RETURN  




end subroutine

on w_reporte_cambio_nota.create
this.dw_calificacion=create dw_calificacion
this.cb_generar=create cb_generar
this.uo_nombre=create uo_nombre
this.cb_2=create cb_2
this.cb_imprimir=create cb_imprimir
this.dw_materia=create dw_materia
this.uo_1=create uo_1
this.st_4=create st_4
this.uoi_coordinaciones=create uoi_coordinaciones
this.dw_reporte=create dw_reporte
this.r_1=create r_1
this.Control[]={this.dw_calificacion,&
this.cb_generar,&
this.uo_nombre,&
this.cb_2,&
this.cb_imprimir,&
this.dw_materia,&
this.uo_1,&
this.st_4,&
this.uoi_coordinaciones,&
this.dw_reporte,&
this.r_1}
end on

on w_reporte_cambio_nota.destroy
destroy(this.dw_calificacion)
destroy(this.cb_generar)
destroy(this.uo_nombre)
destroy(this.cb_2)
destroy(this.cb_imprimir)
destroy(this.dw_materia)
destroy(this.uo_1)
destroy(this.st_4)
destroy(this.uoi_coordinaciones)
destroy(this.dw_reporte)
destroy(this.r_1)
end on

event open;
uoi_coordinaciones.backcolor = this.backcolor
uoi_coordinaciones.enabled = true

//uo_grupo.rb_editar.visible = false
//uo_grupo.rb_insertar.visible = false

ii_cve_coordinacion = f_obten_coord_de_usuario(gs_usuario)

if ii_cve_coordinacion = 9999 then
//Ve todo
elseif ii_cve_coordinacion = -1 then
	MessageBox("Error en lectura de coordinacion", "No es posible determinar la coordinacion del usuario",StopSign!)
	close(this)
else	
	//Solo su coordinacion 
	uoi_coordinaciones.ENABLED = FALSE
end if

dw_materia.INSERTROW(0)

iuo_materias_servicios = CREATE uo_materias_servicios
iuo_materias_servicios.itr_sce = gtr_sce 

wf_limpia_calificacion() 
end event

event resize;

dw_reporte.height = 1320 + (THIS.HEIGHT - 2184) - 100



end event

event doubleclicked;
wf_limpia_calificacion() 
dw_materia.RESET()
dw_materia.INSERTROW(0) 




end event

type dw_calificacion from datawindow within w_reporte_cambio_nota
integer x = 3374
integer y = 352
integer width = 1326
integer height = 96
integer taborder = 40
string title = "none"
string dataobject = "dw_lista_calificacion_cam_nota"
boolean border = false
boolean livescroll = true
end type

type cb_generar from commandbutton within w_reporte_cambio_nota
integer x = 3456
integer y = 624
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Generar"
end type

event clicked;LONG ll_cuenta 
LONG ll_materia 
STRING ls_calificacion 

ls_calificacion = dw_calificacion.GETITEMSTRING(1, "calificacion")  
IF ISNULL(ls_calificacion) THEN ls_calificacion = "" 
IF TRIM(ls_calificacion) = "" THEN 
	MESSAGEBOX("Error", "No se ha capturado la Nueva Calificación.")  
	RETURN 
END IF 

ll_cuenta = LONG(uo_nombre.em_cuenta.text) 
IF ISNULL(ll_cuenta) or ll_cuenta<= 0 THEN 
	MESSAGEBOX("Error", "La cuenta no es válida.") 
	RETURN  
END IF 	

ll_materia = dw_materia.GETITEMNUMBER(1, "cve_mat") 
IF ISNULL(ll_materia) or ll_materia <= 0 THEN 
	MESSAGEBOX("Error", "La materia no es válida.")  
	RETURN  
END IF 	

dw_reporte.SETTRANSOBJECT(gtr_sce)  
dw_reporte.RETRIEVE(ll_cuenta, ll_materia, ls_calificacion, ii_cve_coordinacion)
dw_reporte.SETROW(1) 
IF dw_reporte.ROWCOUNT() <= 0 THEN 
	MESSAGEBOX("Error", "No se encontró información de esta Cuenta - Materia.")  
	RETURN  
END IF 		
	
	
	
	
dw_reporte.SETITEM(1, "calificacion_nueva	",  ls_calificacion)
dw_reporte.SETFOCUS()  
//dw_reporte.SCROLLTOROW(1)



end event

type uo_nombre from uo_nombre_alumno_2013 within w_reporte_cambio_nota
integer x = 73
integer y = 260
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

type cb_2 from commandbutton within w_reporte_cambio_nota
integer x = 4352
integer y = 624
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 

end event

type cb_imprimir from commandbutton within w_reporte_cambio_nota
integer x = 3877
integer y = 624
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;IF dw_reporte.ROWCOUNT() <= 0 THEN 
	MESSAGEBOX("Aviso", "No hay información para imprimir.") 
	RETURN 
END IF 	

SetPointer(HourGlass!)
openwithparm(conf_impr,dw_reporte)
end event

type dw_materia from datawindow within w_reporte_cambio_nota
integer x = 32
integer y = 608
integer width = 3378
integer height = 148
integer taborder = 30
string title = "none"
string dataobject = "d_materia_rep_cambionota"
boolean border = false
boolean livescroll = true
end type

event clicked;LONG ll_cve_materia
STRING ls_materia 
STRING ls_null
IF dwo.name = "b_buscar" THEN 
	
	OPENWITHPARM(w_busca_materia, ii_cve_coordinacion) 
	ll_cve_materia = MESSAGE.doubleparm 
	
	THIS.SETITEM(1, "cve_mat", ll_cve_materia)   
	iuo_materias_servicios.of_recupera_materia( ll_cve_materia, ls_materia) 
	THIS.SETITEM(1, "materias_materia", ls_materia)     
	
	wf_limpia_calificacion() 
	
//	THIS.MODIFY("cve_mat.PROTECT = 1")
//	THIS.Modify("cve_mat.Background.Color = '67108864'")		
//	THIS.Modify("b_buscar.Visible = 0")	
END IF 	
end event

event itemchanged;INTEGER le_resultado
STRING ls_descripcion

IF dwo.name =  "cve_mat" THEN 

	// Se valida que la materia pertenezca a la coordinación. 
	IF NOT(f_materia_valida(LONG(data), ii_cve_coordinacion)) then
		MessageBox("Materia Inexistente", "La materia "+string(data)+ " no existe registrada, o no pertenece a su coordinacion.",StopSign!)
		RETURN 2 
	END IF
	

	// Si se modifica la materia, se limpia el grupo 
	le_resultado = iuo_materias_servicios.of_recupera_materia(LONG(data), ls_descripcion)  
	IF le_resultado < 0 THEN RETURN 2  
	THIS.SETITEM(1, "materias_materia", ls_descripcion) 
	
	wf_limpia_calificacion() 
	
END IF 



end event

type uo_1 from uo_per_ani within w_reporte_cambio_nota
integer x = 1888
integer y = 36
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type st_4 from statictext within w_reporte_cambio_nota
integer x = 101
integer y = 76
integer width = 421
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Coordinación:"
boolean focusrectangle = false
end type

type uoi_coordinaciones from uo_coordinaciones within w_reporte_cambio_nota
integer x = 530
integer y = 52
integer taborder = 10
boolean border = false
end type

event carga;call super::carga;uoi_coordinaciones.dw_coordinaciones.SetItem(1,"cve_coordinacion", PARENT.ii_cve_coordinacion)



end event

on uoi_coordinaciones.destroy
call uo_coordinaciones::destroy
end on

type dw_reporte from datawindow within w_reporte_cambio_nota
integer x = 73
integer y = 816
integer width = 4690
integer height = 1320
integer taborder = 80
string title = "none"
string dataobject = "d_cambio_nota"
boolean hscrollbar = true
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type r_1 from rectangle within w_reporte_cambio_nota
long linecolor = 128
integer linethickness = 4
long fillcolor = 16777215
integer x = 3328
integer y = 292
integer width = 1394
integer height = 220
end type

