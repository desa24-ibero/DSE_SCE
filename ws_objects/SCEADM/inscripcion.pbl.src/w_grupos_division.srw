$PBExportHeader$w_grupos_division.srw
forward
global type w_grupos_division from window
end type
type cb_5 from commandbutton within w_grupos_division
end type
type em_min from editmask within w_grupos_division
end type
type em_max from editmask within w_grupos_division
end type
type cb_4 from commandbutton within w_grupos_division
end type
type st_2 from statictext within w_grupos_division
end type
type pb_insert from picturebutton within w_grupos_division
end type
type pb_delete from picturebutton within w_grupos_division
end type
type st_1 from statictext within w_grupos_division
end type
type uo_per_ani from uo_per_ani_admision within w_grupos_division
end type
type dw_aspiran_inscribe from datawindow within w_grupos_division
end type
type cb_3 from commandbutton within w_grupos_division
end type
type dw_division_porcentaje from datawindow within w_grupos_division
end type
type cb_2 from commandbutton within w_grupos_division
end type
type cb_1 from commandbutton within w_grupos_division
end type
type dw_materia_genera from datawindow within w_grupos_division
end type
type dw_grupos_distribucion from datawindow within w_grupos_division
end type
type gb_1 from groupbox within w_grupos_division
end type
type gb_2 from groupbox within w_grupos_division
end type
type gb_3 from groupbox within w_grupos_division
end type
end forward

global type w_grupos_division from window
integer width = 4663
integer height = 2436
boolean titlebar = true
string title = "Inscripción de TIU"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_5 cb_5
em_min em_min
em_max em_max
cb_4 cb_4
st_2 st_2
pb_insert pb_insert
pb_delete pb_delete
st_1 st_1
uo_per_ani uo_per_ani
dw_aspiran_inscribe dw_aspiran_inscribe
cb_3 cb_3
dw_division_porcentaje dw_division_porcentaje
cb_2 cb_2
cb_1 cb_1
dw_materia_genera dw_materia_genera
dw_grupos_distribucion dw_grupos_distribucion
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_grupos_division w_grupos_division

type variables
INTEGER ie_periodo
INTEGER ie_anio 


LONG il_folio_ini 
LONG il_folio_fin 


uo_gpo_division_servicios iuo_gpo_division_servicios
end variables

on w_grupos_division.create
this.cb_5=create cb_5
this.em_min=create em_min
this.em_max=create em_max
this.cb_4=create cb_4
this.st_2=create st_2
this.pb_insert=create pb_insert
this.pb_delete=create pb_delete
this.st_1=create st_1
this.uo_per_ani=create uo_per_ani
this.dw_aspiran_inscribe=create dw_aspiran_inscribe
this.cb_3=create cb_3
this.dw_division_porcentaje=create dw_division_porcentaje
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_materia_genera=create dw_materia_genera
this.dw_grupos_distribucion=create dw_grupos_distribucion
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.cb_5,&
this.em_min,&
this.em_max,&
this.cb_4,&
this.st_2,&
this.pb_insert,&
this.pb_delete,&
this.st_1,&
this.uo_per_ani,&
this.dw_aspiran_inscribe,&
this.cb_3,&
this.dw_division_porcentaje,&
this.cb_2,&
this.cb_1,&
this.dw_materia_genera,&
this.dw_grupos_distribucion,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_grupos_division.destroy
destroy(this.cb_5)
destroy(this.em_min)
destroy(this.em_max)
destroy(this.cb_4)
destroy(this.st_2)
destroy(this.pb_insert)
destroy(this.pb_delete)
destroy(this.st_1)
destroy(this.uo_per_ani)
destroy(this.dw_aspiran_inscribe)
destroy(this.cb_3)
destroy(this.dw_division_porcentaje)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_materia_genera)
destroy(this.dw_grupos_distribucion)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;dw_materia_genera.INSERTROW(0) 

dw_division_porcentaje.SETTRANSOBJECT(gtr_sadm) 
dw_division_porcentaje.RETRIEVE() 


dw_grupos_distribucion.SETTRANSOBJECT(gtr_sadm) 
dw_grupos_distribucion.RETRIEVE(9999, ie_periodo, ie_anio ) 
end event

type cb_5 from commandbutton within w_grupos_division
integer x = 2263
integer y = 52
integer width = 512
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Carga Grupos"
end type

event clicked;ie_anio = parent.uo_per_ani.ie_anio
ie_periodo = parent.uo_per_ani.ie_periodo

dw_grupos_distribucion.SETTRANSOBJECT(gtr_sadm) 
dw_grupos_distribucion.RETRIEVE(9999, ie_periodo, ie_anio ) 
end event

type em_min from editmask within w_grupos_division
integer x = 2880
integer y = 212
integer width = 338
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;//text=string(event num_folios(0))
end event

event getfocus;//text=string(event num_folios(0))
end event

type em_max from editmask within w_grupos_division
integer x = 3237
integer y = 212
integer width = 338
integer height = 100
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
alignment alignment = center!
string mask = "######"
boolean spin = true
string displaydata = ""
double increment = 1
string minmax = "2~~999999"
end type

event constructor;//text=string(event num_folios(1))
end event

event getfocus;//text=string(event num_folios(1))
end event

type cb_4 from commandbutton within w_grupos_division
boolean visible = false
integer x = 4128
integer y = 1896
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Buscar"
end type

event clicked;//str_aspirante	lstr_aspirante
//Int					li_renglon_encontrado
//
//lstr_aspirante.folio		= 0
//lstr_aspirante.clv_ver	= gi_version
//lstr_aspirante.clv_per	= gi_periodo
//lstr_aspirante.anio		= gi_anio
//
//OpenWithParm ( w_busqueda_aspirante , lstr_aspirante )
//
//lstr_aspirante = Message.powerObjectparm
//
//IF lstr_aspirante.folio > 0 THEN
//	// Presentar el folio del aspirante ...
//	em_min.Text = String ( lstr_aspirante.folio )
//	em_max.Text = String ( lstr_aspirante.folio )
//
//	// Obtener la versión y asignarla a la variable global ...
//	gi_version = lstr_aspirante.clv_ver	
//	li_renglon_encontrado = uo_1.dw_ver.Find ( 'clv_ver=' + String ( gi_version ) , 1 , uo_1.dw_ver.RowCount ( ) )
//	uo_1.dw_ver.SelectRow ( li_renglon_encontrado , True )
//	uo_1.dw_ver.SCrollToRow ( li_renglon_encontrado )
//
//	dw_1.Event Carga ( )
//END IF
end event

type st_2 from statictext within w_grupos_division
integer x = 110
integer y = 228
integer width = 279
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materia: "
boolean focusrectangle = false
end type

type pb_insert from picturebutton within w_grupos_division
boolean visible = false
integer x = 2057
integer y = 1964
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

event clicked;//
//INTEGER le_row
//le_row = dw_examen_fecha.INSERTROW(0)
//
//dw_examen_fecha.SETITEM(le_row, "periodo_ingreso", ie_periodo)
//dw_examen_fecha.SETITEM(le_row, "anio_ingreso", ie_anio)
//
//dw_examen_fecha.SCROLLTOROW(le_row)
//dw_examen_fecha.SETROW(le_row) 
//





end event

type pb_delete from picturebutton within w_grupos_division
boolean visible = false
integer x = 2190
integer y = 1964
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;//LONG ll_id_examen_act 
//LONG ll_num_reg
//
//ll_id_examen_act = dw_examen_fecha.getitemnumber(dw_examen_fecha.GETROW(), "id_examen") 
//
//// Se verifica si la fecha de exámen ya tiene asiciados salones o aspirantes.
//SELECT COUNT(*) 
//INTO :ll_num_reg 
//FROM carr_sal 
//WHERE id_examen = :ll_id_examen_act 
//USING itr_admision_web; 
//IF itr_admision_web.SQLCODE < 0 THEN 
//	MESSAGEBOX("Aviso", "Se produjo un error al verificar existencia de salones: " + itr_admision_web.SQLERRTEXT)
//	RETURN -1
//END IF
//IF ll_num_reg > 0 THEN 
//	MESSAGEBOX("Aviso", "La fecha de exámen no puede ser eliminada porque ya tiene salones asociados. Si la fecha ya no es válida solo debe deshabilitarla asignándole el estatus 'CERRADO' ") 
//	RETURN -1
//END IF
//
//
//SELECT COUNT(*) 
//INTO :ll_num_reg 
//FROM aspiran  
//WHERE id_examen = :ll_id_examen_act 
//USING itr_admision_web; 
//IF itr_admision_web.SQLCODE < 0 THEN 
//	MESSAGEBOX("Aviso", "Se produjo un error al verificar existencia de aspirantes: " + itr_admision_web.SQLERRTEXT)
//	RETURN -1
//END IF
//IF ll_num_reg > 0 THEN 
//	MESSAGEBOX("Aviso", "La fecha de exámen no puede ser eliminada porque ya tiene aspirantes asociados. Si la fecha ya no es válida solo debe deshabilitarla asignándole el estatus 'CERRADO' ") 
//	RETURN -1
//END IF
//
//
//
//IF NOT ISNULL(ll_id_examen_act) THEN 
//	IF MESSAGEBOX("CONFIRMACIÓN", "La fecha de Aplicación de Exámen No." + STRING(ll_id_examen_act) + " será ELIMINADA ¿Desea Continuar? ", Question!, YesNoCancel!) > 1 THEN RETURN 0 
//END IF
//
//dw_examen_fecha.DELETEROW(dw_examen_fecha.GETROW())
//
//IF dw_examen_fecha.UPDATE() < 0 THEN 
//	COMMIT USING itr_admision_web;
//END IF
//
//cb_carga.TRIGGEREVENT(CLICKED!)
//
//
//
//
//
end event

type st_1 from statictext within w_grupos_division
integer x = 110
integer y = 72
integer width = 279
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo:"
boolean focusrectangle = false
end type

type uo_per_ani from uo_per_ani_admision within w_grupos_division
event destroy ( )
integer x = 475
integer y = 28
integer taborder = 40
boolean enabled = true
long backcolor = 67108864
end type

on uo_per_ani.destroy
call uo_per_ani_admision::destroy
end on

event ue_modifica;call super::ue_modifica;
PARENT.ie_periodo = THIS.ie_periodo
PARENT.ie_anio = THIS.ie_anio
end event

type dw_aspiran_inscribe from datawindow within w_grupos_division
boolean visible = false
integer x = 3246
integer y = 1812
integer width = 686
integer height = 400
integer taborder = 20
string title = "none"
string dataobject = "dw_asp_alum_ing_paq_div"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_3 from commandbutton within w_grupos_division
integer x = 3840
integer y = 188
integer width = 590
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Inscribe Alumnos"
end type

event clicked;String ls_min, ls_max

ls_min = em_min.text
ls_max = em_max.text
il_folio_ini = Long(ls_min)
il_folio_fin = Long(ls_max)

IF ISNULL(il_folio_ini) OR il_folio_ini = 0 OR ISNULL(il_folio_fin) OR il_folio_fin  = 0 THEN 
	MESSAGEBOX("Error", "No se han especificado los folios a procesar. ")
	RETURN -1 
END IF 

IF MESSAGEBOX("Confirmación", "Se realizará la inscripción de el TIU. ¿Desea Continuar?", question!, YesNo!) = 2 THEN RETURN 0 


//iuo_gpo_division_servicios.ie_periodo 
//iuo_gpo_division_servicios.ie_anio 

IF NOT ISVALID(iuo_gpo_division_servicios) THEN iuo_gpo_division_servicios = CREATE uo_gpo_division_servicios 
iuo_gpo_division_servicios.ie_anio = parent.uo_per_ani.ie_anio
iuo_gpo_division_servicios.ie_periodo = parent.uo_per_ani.ie_periodo
iuo_gpo_division_servicios.itr_sce = gtr_sce 
iuo_gpo_division_servicios.itr_sce_adm = gtr_sadm 

iuo_gpo_division_servicios.il_version = 99 
iuo_gpo_division_servicios.il_folio_inc = il_folio_ini 
iuo_gpo_division_servicios.il_folio_fin = il_folio_fin 

iuo_gpo_division_servicios.of_incribe_mat_division() 

//dw_aspiran_inscribe.SETTRANSOBJECT(gtr_sadm) 
//dw_aspiran_inscribe.RETRIEVE(99, ie_periodo, ie_anio, il_folio_ini, il_folio_fin) 








// Se hace ciclo para inscribir a cada uno de los aspirantes 
//iuo_gpo_division_servicios
end event

type dw_division_porcentaje from datawindow within w_grupos_division
integer x = 155
integer y = 1852
integer width = 1673
integer height = 388
integer taborder = 10
string title = "none"
string dataobject = "dw_grupos_div_porcentaje"
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_grupos_division
boolean visible = false
integer x = 1970
integer y = 1792
integer width = 576
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Porcentaje  Division"
end type

type cb_1 from commandbutton within w_grupos_division
integer x = 2263
integer y = 200
integer width = 512
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Genera Grupos"
end type

event clicked;
LONG ll_cve_materia

ll_cve_materia = dw_materia_genera.GETITEMNUMBER(1, "cve_mat")

ie_anio = parent.uo_per_ani.ie_anio
ie_periodo = parent.uo_per_ani.ie_periodo

iuo_gpo_division_servicios = CREATE uo_gpo_division_servicios 
iuo_gpo_division_servicios.ie_anio = parent.uo_per_ani.ie_anio
iuo_gpo_division_servicios.ie_periodo = parent.uo_per_ani.ie_periodo
iuo_gpo_division_servicios.itr_sce = gtr_sce 
iuo_gpo_division_servicios.itr_sce_adm = gtr_sadm 
iuo_gpo_division_servicios.il_cve_mat = ll_cve_materia
IF iuo_gpo_division_servicios.of_genera_grupos_division( ) = 0 THEN 
	MESSAGEBOX("Aviso", "Se han generado los grupos por división.") 
END IF 

dw_grupos_distribucion.SETTRANSOBJECT(gtr_sadm) 
dw_grupos_distribucion.RETRIEVE(ll_cve_materia, ie_periodo, ie_anio )   





//SELECT cve_mat, gpo, char_length(gpo) 
//FROM grupos 
//WHERE cve_mat = 24077 
//AND periodo = 0 
//AND anio = 2022
//AND char_length(gpo) > 1 
//AND cupo > 0 
end event

type dw_materia_genera from datawindow within w_grupos_division
integer x = 475
integer y = 212
integer width = 1723
integer height = 136
integer taborder = 10
string title = "none"
string dataobject = "dw_grupos_div_materia"
boolean border = false
boolean livescroll = true
end type

event itemchanged;
LONG ll_materia 
STRING ls_materia_nombre

IF dwo.name = "cve_mat"  THEN 
	
	ll_materia  = LONG(data)  
	
	SELECT materia 
	INTO :ls_materia_nombre  
	FROM materias 
	WHERE cve_mat = :ll_materia 
	USING gtr_sce; 
	
	THIS.SETITEM(1, "materia", ls_materia_nombre)  
	
	
END IF 	





end event

type dw_grupos_distribucion from datawindow within w_grupos_division
integer x = 105
integer y = 400
integer width = 4375
integer height = 1316
integer taborder = 10
string title = "Generación y Asignación de Grupos por Diivisión"
string dataobject = "dw_grupos_div_cupo"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type gb_1 from groupbox within w_grupos_division
integer x = 101
integer y = 1760
integer width = 1783
integer height = 556
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Proporciones por division: "
end type

type gb_2 from groupbox within w_grupos_division
integer x = 2816
integer y = 132
integer width = 818
integer height = 212
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Rango de Folios"
borderstyle borderstyle = stylebox!
end type

type gb_3 from groupbox within w_grupos_division
boolean visible = false
integer x = 4018
integer y = 1824
integer width = 626
integer height = 212
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Buscar por Aspirante"
borderstyle borderstyle = stylebox!
end type

