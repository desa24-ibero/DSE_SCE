$PBExportHeader$w_prerrequisitos_especiales.srw
forward
global type w_prerrequisitos_especiales from window
end type
type cb_1 from commandbutton within w_prerrequisitos_especiales
end type
type cb_imprimir from commandbutton within w_prerrequisitos_especiales
end type
type cb_salir from commandbutton within w_prerrequisitos_especiales
end type
type cb_guardar from commandbutton within w_prerrequisitos_especiales
end type
type pb_delete from picturebutton within w_prerrequisitos_especiales
end type
type pb_insert from picturebutton within w_prerrequisitos_especiales
end type
type dw_carreras from datawindow within w_prerrequisitos_especiales
end type
type dw_prerrequisitos_esp from datawindow within w_prerrequisitos_especiales
end type
end forward

global type w_prerrequisitos_especiales from window
integer width = 4635
integer height = 2436
boolean titlebar = true
string title = "PROPEDÉUTICOS POR CARRERA"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_imprimir cb_imprimir
cb_salir cb_salir
cb_guardar cb_guardar
pb_delete pb_delete
pb_insert pb_insert
dw_carreras dw_carreras
dw_prerrequisitos_esp dw_prerrequisitos_esp
end type
global w_prerrequisitos_especiales w_prerrequisitos_especiales

forward prototypes
public function integer wf_filtra_carreras ()
end prototypes

public function integer wf_filtra_carreras ();
LONG ll_cve_carrera 

ll_cve_carrera = dw_carreras.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) THEN 
	//MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
	RETURN 0
END IF

dw_prerrequisitos_esp.modify("Datawindow.print.preview = No")

dw_prerrequisitos_esp.RETRIEVE()

IF ll_cve_carrera <> 9999 THEN 
	dw_prerrequisitos_esp.SETFILTER("cve_carrera = " + STRING(ll_cve_carrera))
ELSE 
	dw_prerrequisitos_esp.SETFILTER("")
END IF

dw_prerrequisitos_esp.FILTER() 

dw_prerrequisitos_esp.SORT() 
dw_prerrequisitos_esp.GROUPCALC() 


return 0
end function

on w_prerrequisitos_especiales.create
this.cb_1=create cb_1
this.cb_imprimir=create cb_imprimir
this.cb_salir=create cb_salir
this.cb_guardar=create cb_guardar
this.pb_delete=create pb_delete
this.pb_insert=create pb_insert
this.dw_carreras=create dw_carreras
this.dw_prerrequisitos_esp=create dw_prerrequisitos_esp
this.Control[]={this.cb_1,&
this.cb_imprimir,&
this.cb_salir,&
this.cb_guardar,&
this.pb_delete,&
this.pb_insert,&
this.dw_carreras,&
this.dw_prerrequisitos_esp}
end on

on w_prerrequisitos_especiales.destroy
destroy(this.cb_1)
destroy(this.cb_imprimir)
destroy(this.cb_salir)
destroy(this.cb_guardar)
destroy(this.pb_delete)
destroy(this.pb_insert)
destroy(this.dw_carreras)
destroy(this.dw_prerrequisitos_esp)
end on

event open;dw_carreras.SETTRANSOBJECT(gtr_sce) 
dw_carreras.INSERTROW(0)

dw_prerrequisitos_esp.SETROWFOCUSINDICATOR(Hand!)
dw_prerrequisitos_esp.SETTRANSOBJECT(gtr_sce)  


wf_filtra_carreras() 




end event

type cb_1 from commandbutton within w_prerrequisitos_especiales
integer x = 4151
integer y = 800
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salvar"
end type

event clicked;if dw_prerrequisitos_esp.SaveAs("",Excel!, TRUE)<>1 then
	dw_prerrequisitos_esp.SaveAs("",Clipboard!, TRUE)
	messagebox("No se pudo guardar el archivo","La información se encuentra en el Clipboard")	
end if

end event

type cb_imprimir from commandbutton within w_prerrequisitos_especiales
integer x = 4151
integer y = 668
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprimir"
end type

event clicked;dw_prerrequisitos_esp.modify("Datawindow.print.preview = Yes")
dw_prerrequisitos_esp.modify("Datawindow.print.Orientation = 1")
SetPointer(HourGlass!)
openwithparm(conf_impr,dw_prerrequisitos_esp)
end event

type cb_salir from commandbutton within w_prerrequisitos_especiales
integer x = 4151
integer y = 404
integer width = 402
integer height = 112
integer taborder = 30
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

type cb_guardar from commandbutton within w_prerrequisitos_especiales
integer x = 4151
integer y = 264
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;
STRING ls_error 

dw_prerrequisitos_esp.ACCEPTTEXT() 
IF dw_prerrequisitos_esp.UPDATE() < 0  THEN 
	ls_error = gtr_sadm.SQLERRTEXT
	ROLLBACK USING gtr_sce;
	MESSAGEBOX("Error", "Se produjo un error al actualizar la información: " + ls_error) 
	wf_filtra_carreras() 
	RETURN -1 	
END IF

COMMIT USING gtr_sce;

wf_filtra_carreras() 

MESSAGEBOX("Aviso", "La información ha sido actualizada con éxito")


//LONG ll_currentrow 
//STRING ls_error , ls_desc_prop
//
//dw_propedeutico_lista.ACCEPTTEXT() 
//dw_prop_carrera_peso.ACCEPTTEXT()
//
//ll_currentrow = dw_propedeutico_lista.GETROW() 
//IF ib_modifica_prop OR ib_modifica_peso THEN 
//	wf_actualiza_prop(ll_currentrow)
//	ib_modifica_prop = FALSE
//	ib_modifica_peso = FALSE
//END IF
//
////STRING ls_desc_prop
////SELECT descripcion 
////INTO :ls_desc_prop 
////FROM propedeuticos 
////WHERE id_prop = :ls_id_prop
////USING gtr_sadm;
//IF gtr_sadm.SQLCODE < 0 THEN 
//	ls_error = gtr_sadm.SQLERRTEXT
//	ROLLBACK USING gtr_sadm;
//	MESSAGEBOX("Error", "Se produjo un error al recuperar la descripción del Propedéutico: " + ls_error)
//	RETURN -1 
//END IF
//
//MESSAGEBOX("Aviso", "El Propedéutico " + ls_desc_prop + " ha sido guardado con éxito")
//
//
end event

type pb_delete from picturebutton within w_prerrequisitos_especiales
integer x = 3982
integer y = 124
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;LONG ll_cve_carrera
STRING ls_prop, ls_error


ll_cve_carrera = dw_carreras.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) OR ll_cve_carrera = 9999 THEN 
	MESSAGEBOX("Aviso", "Debe seleccionar una carrera para realizar el borrado.") 
	RETURN 1
END IF

LONG ll_currentrow 

ll_currentrow = dw_prerrequisitos_esp.GETROW() 

IF MESSAGEBOX("Confirmación", "Se borrará el Propedéutico y la Materia Asociada. ¿Desea Continuar?", Question!, YesNo!, 2) = 2 THEN RETURN 0 

dw_prerrequisitos_esp.DELETEROW(ll_currentrow) 

cb_guardar.TRIGGEREVENT(CLICKED!) 

wf_filtra_carreras() 


//DELETE FROM prop_carrera_minimos 
//WHERE cve_carrera = :ll_cve_carrera 
//AND id_prop = :ls_prop 
//USING gtr_sadm; 
//IF gtr_sadm.SQLCODE < 0 THEN 
//	ls_error = gtr_sadm.SQLERRTEXT
//	ROLLBACK USING gtr_sadm; 
//	MESSAGEBOX("Error", "Se produjo un error al borrar el Propedéutico asociado a la Carrera:" + ls_error )
//	RETURN -1
//END IF
//
//DELETE FROM prop_carrera_peso 
//WHERE cve_carrera = :ll_cve_carrera 
//AND id_prop = :ls_prop 
//USING gtr_sadm; 
//IF gtr_sadm.SQLCODE < 0 THEN 
//	ls_error = gtr_sadm.SQLERRTEXT
//	ROLLBACK USING gtr_sadm; 
//	MESSAGEBOX("Error", "Se produjo un error al borrar el peso por área del Propedéutico:" + ls_error )
//	RETURN -1
//END IF
//
//COMMIT USING gtr_sadm; 
//
//dw_carrera.TRIGGEREVENT("carga") 
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

type pb_insert from picturebutton within w_prerrequisitos_especiales
integer x = 3849
integer y = 124
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;LONG ll_cve_carrera 


ll_cve_carrera = dw_carreras.GETITEMNUMBER(1, "cve_carrera") 
IF ISNULL(ll_cve_carrera) THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado ninguna carrera.")
	RETURN 0
ELSEIF ll_cve_carrera = 9999 THEN 
	MESSAGEBOX("Aviso", "Debe seleccionar una carrera para insertar curso propedéutico.") 
	RETURN 0	
END IF


INTEGER le_row
le_row = dw_prerrequisitos_esp.INSERTROW(0)
dw_prerrequisitos_esp.SETITEM(le_row, "cve_carrera", ll_cve_carrera) 
dw_prerrequisitos_esp.SETITEM(le_row, "enlace", 'Y') 
dw_prerrequisitos_esp.SETITEM(le_row, "orden", 1) 
dw_prerrequisitos_esp.SETSORT("cve_carrera asc, cve_prerreq asc")
dw_prerrequisitos_esp.SORT() 
dw_prerrequisitos_esp.GROUPCALC() 







end event

type dw_carreras from datawindow within w_prerrequisitos_especiales
integer x = 46
integer y = 100
integer width = 2281
integer height = 104
integer taborder = 10
string title = "none"
string dataobject = "dw_prop_selecciona_carrera"
boolean border = false
boolean livescroll = true
end type

event itemchanged;IF dwo.name = "cve_carrera" THEN 
	POST wf_filtra_carreras()
END IF 






end event

type dw_prerrequisitos_esp from datawindow within w_prerrequisitos_especiales
integer x = 46
integer y = 244
integer width = 4055
integer height = 2004
integer taborder = 10
string dataobject = "dw_prerrequisitos_esp"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

