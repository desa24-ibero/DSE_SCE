$PBExportHeader$w_grupos_paquete.srw
forward
global type w_grupos_paquete from window
end type
type cb_guardar from commandbutton within w_grupos_paquete
end type
type cb_salir from commandbutton within w_grupos_paquete
end type
type dw_selecciona_paquete from datawindow within w_grupos_paquete
end type
type pb_borra_horario from picturebutton within w_grupos_paquete
end type
type pb_inserta_horario from picturebutton within w_grupos_paquete
end type
type uo_periodo from uo_per_ani within w_grupos_paquete
end type
type st_1 from statictext within w_grupos_paquete
end type
type dw_grupos_paquetes from datawindow within w_grupos_paquete
end type
end forward

global type w_grupos_paquete from window
integer width = 3721
integer height = 2264
boolean titlebar = true
string title = "Grupos Paquetes"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_guardar cb_guardar
cb_salir cb_salir
dw_selecciona_paquete dw_selecciona_paquete
pb_borra_horario pb_borra_horario
pb_inserta_horario pb_inserta_horario
uo_periodo uo_periodo
st_1 st_1
dw_grupos_paquetes dw_grupos_paquetes
end type
global w_grupos_paquete w_grupos_paquete

type variables
INTEGER ii_periodo 
INTEGER ii_anio 

n_tr itr_sce 

uo_grupo_servicios iuo_grupo_servicios
uo_materias_servicios iuo_materias_servicios 
uo_profesor_servicios iuo_profesor_servicios  

LONG il_coordinacion

INTEGER ie_periodo 
INTEGER ie_anio 


end variables

forward prototypes
public function integer wf_carga ()
public function integer wf_carga_lista_paquetes ()
public function integer wf_inicializa_servicio ()
end prototypes

public function integer wf_carga ();
iuo_grupo_servicios.il_id_paquete = dw_selecciona_paquete.GETITEMNUMBER(1, "id_paquete") 
iuo_grupo_servicios.of_carga_grupo_paquete()

dw_selecciona_paquete.SETITEM(1, "descripcion", iuo_grupo_servicios.is_descripcion_paq) 

//
//iuo_grupo_servicios.il_cve_coordinacion_paq
//iuo_grupo_servicios.ie_periodo_paq
//iuo_grupo_servicios.ie_anio_paq
//


iuo_grupo_servicios.ids_paquete_horario.ROWSCOPY(1, iuo_grupo_servicios.ids_paquete_horario.ROWCOUNT(), PRIMARY!, dw_grupos_paquetes, dw_grupos_paquetes.ROWCOUNT() + 1, PRIMARY!) 



RETURN 0 


end function

public function integer wf_carga_lista_paquetes ();
dw_selecciona_paquete.INSERTROW(0) 

DATAWINDOWCHILD dw_child

dw_selecciona_paquete.GETCHILD("id_paquete", dw_child)  

dw_child.SETTRANSOBJECT(itr_sce)  
dw_child.RETRIEVE(il_coordinacion) 

INTEGER le_row
le_row = dw_child.INSERTROW(0)

dw_child.SETITEM(le_row, "id_paquete", 0)  
dw_child.SETITEM(le_row, "descripcion", "NUEVO")  
dw_child.SETSORT("id_paquete asc") 
dw_child.SORT() 


RETURN 0 





end function

public function integer wf_inicializa_servicio ();
//iuo_grupo_servicios

// Se hacen algunas validaciones básicas propias de la ventana.
STRING ls_descripcion

ls_descripcion = dw_selecciona_paquete.GETITEMSTRING(1, "descripcion") 
IF TRIM(ls_descripcion) = "NUEVO" THEN 
	MESSAGEBOX("Aviso", "Es necesario que especifique una descripción del paquete de crupos.") 
	RETURN -1 
END IF






// grupos_paquetes 
iuo_grupo_servicios.il_id_paquete = dw_selecciona_paquete.GETITEMNUMBER(1, "id_paquete")    
iuo_grupo_servicios.is_descripcion_paq = dw_selecciona_paquete.GETITEMSTRING(1, "descripcion")   
iuo_grupo_servicios.il_cve_coordinacion_paq = il_coordinacion  
iuo_grupo_servicios.ie_periodo_paq = ie_periodo 
iuo_grupo_servicios.ie_anio_paq = ie_anio 

//DATASTORE ids_paquete_horario
LONG ll_pos
LONG ll_ttl_mat

LONG ll_cve_materia 
INTEGER le_cve_dia 
INTEGER le_hora_inicio 
INTEGER le_hora_fin 
INTEGER le_row

iuo_grupo_servicios.ids_paquete_horario.RESET() 

ll_ttl_mat = dw_grupos_paquetes.ROWCOUNT() 

FOR ll_pos = 1 TO ll_ttl_mat 
	
	ll_cve_materia = dw_grupos_paquetes.GETITEMNUMBER(ll_pos, "cve_materia") 
	le_cve_dia = dw_grupos_paquetes.GETITEMNUMBER(ll_pos, "cve_dia") 
	le_hora_inicio = dw_grupos_paquetes.GETITEMNUMBER(ll_pos, "hora_inicio") 
	le_hora_fin = dw_grupos_paquetes.GETITEMNUMBER(ll_pos, "hora_fin") 	

	le_row = iuo_grupo_servicios.ids_paquete_horario.INSERTROW(0)
	iuo_grupo_servicios.ids_paquete_horario.SETITEM(le_row, "cve_materia", ll_cve_materia)
	iuo_grupo_servicios.ids_paquete_horario.SETITEM(le_row, "hora_inicio", le_hora_inicio) 
	iuo_grupo_servicios.ids_paquete_horario.SETITEM(le_row, "hora_fin", le_hora_fin)  
	iuo_grupo_servicios.ids_paquete_horario.SETITEM(le_row, "cve_dia", le_cve_dia) 
	
	
NEXT 	


RETURN 0 






end function

on w_grupos_paquete.create
this.cb_guardar=create cb_guardar
this.cb_salir=create cb_salir
this.dw_selecciona_paquete=create dw_selecciona_paquete
this.pb_borra_horario=create pb_borra_horario
this.pb_inserta_horario=create pb_inserta_horario
this.uo_periodo=create uo_periodo
this.st_1=create st_1
this.dw_grupos_paquetes=create dw_grupos_paquetes
this.Control[]={this.cb_guardar,&
this.cb_salir,&
this.dw_selecciona_paquete,&
this.pb_borra_horario,&
this.pb_inserta_horario,&
this.uo_periodo,&
this.st_1,&
this.dw_grupos_paquetes}
end on

on w_grupos_paquete.destroy
destroy(this.cb_guardar)
destroy(this.cb_salir)
destroy(this.dw_selecciona_paquete)
destroy(this.pb_borra_horario)
destroy(this.pb_inserta_horario)
destroy(this.uo_periodo)
destroy(this.st_1)
destroy(this.dw_grupos_paquetes)
end on

event open;	il_coordinacion = 4300


itr_sce = gtr_sce

iuo_grupo_servicios = CREATE uo_grupo_servicios  
iuo_materias_servicios = CREATE uo_materias_servicios 
iuo_profesor_servicios = CREATE uo_profesor_servicios 

iuo_grupo_servicios.itr_sce = itr_sce 
iuo_grupo_servicios.of_inicializa_parametros() 

iuo_materias_servicios.itr_sce = itr_sce 
iuo_profesor_servicios.itr_sce = itr_sce 


wf_carga_lista_paquetes() 

DATAWINDOWCHILD ldwc_dia
dw_grupos_paquetes.GETCHILD("cve_dia",  ldwc_dia)  
ldwc_dia.SETTRANSOBJECT(itr_sce) 
ldwc_dia.RETRIEVE() 


DATAWINDOWCHILD ldwc_materia
dw_grupos_paquetes.GETCHILD("materias_materia",  ldwc_materia)  
ldwc_materia.SETTRANSOBJECT(itr_sce) 
ldwc_materia.RETRIEVE() 







end event

type cb_guardar from commandbutton within w_grupos_paquete
integer x = 2711
integer y = 1944
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;
IF wf_inicializa_servicio() < 0 THEN RETURN  -1 

IF iuo_grupo_servicios.of_inserta_grupo_paquete() < 0 THEN
	MESSAGEBOX("Aviso", iuo_grupo_servicios.is_error) 
	RETURN -1 
END IF  

MESSAGEBOX("Aviso", "El paquete fue guardado con éxito.")  


dw_selecciona_paquete.RESET() 
dw_selecciona_paquete.INSERTROW(0) 
dw_grupos_paquetes.RESET() 
wf_carga_lista_paquetes() 


RETURN 



end event

type cb_salir from commandbutton within w_grupos_paquete
integer x = 3163
integer y = 1944
integer width = 402
integer height = 112
integer taborder = 20
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

type dw_selecciona_paquete from datawindow within w_grupos_paquete
event ue_carga ( )
integer x = 82
integer y = 236
integer width = 2560
integer height = 212
integer taborder = 40
string title = "none"
string dataobject = "dw_selecciona_grupo_paq"
boolean border = false
boolean livescroll = true
end type

event ue_carga();INTEGER id_paquete 

id_paquete = dw_selecciona_paquete.GETITEMNUMBER(1, "id_paquete")  
IF ISNULL(id_paquete) THEN RETURN 

iuo_grupo_servicios.il_id_paquete  = id_paquete
iuo_grupo_servicios.of_carga_grupo_paquete( )

dw_selecciona_paquete.SETITEM(1, "descripcion", iuo_grupo_servicios.is_descripcion_paq) 


dw_grupos_paquetes.SETTRANSOBJECT(itr_sce) 
dw_grupos_paquetes.RETRIEVE(id_paquete) 



RETURN 


















end event

event itemchanged;
IF dwo.name = "id_paquete" THEN  
	
	IF data = '0' THEN 
		THIS.SETITEM(1, "descripcion", "NUEVO")	
		dw_grupos_paquetes.RESET() 
	ELSE 
		POSTEVENT("ue_carga")		
	END IF 
	
END IF 



end event

type pb_borra_horario from picturebutton within w_grupos_paquete
integer x = 3278
integer y = 344
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

event clicked;INTEGER le_row 

le_row = dw_grupos_paquetes.GETROW()

IF le_row > 0 THEN dw_grupos_paquetes.DELETEROW(le_row) 



end event

type pb_inserta_horario from picturebutton within w_grupos_paquete
integer x = 3159
integer y = 344
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;dw_grupos_paquetes.INSERTROW(0)
end event

type uo_periodo from uo_per_ani within w_grupos_paquete
event destroy ( )
integer x = 507
integer y = 28
integer width = 1253
integer height = 168
integer taborder = 20
boolean border = true
long backcolor = 1090519039
end type

on uo_periodo.destroy
call uo_per_ani::destroy
end on

event ue_modifica;call super::ue_modifica;PARENT.ii_periodo = THIS.ie_periodo
PARENT.ii_anio = THIS.ie_anio 

PARENT.iuo_grupo_servicios.ie_periodo = ii_periodo 
PARENT.iuo_grupo_servicios.ie_anio = ii_anio  



end event

type st_1 from statictext within w_grupos_paquete
integer x = 114
integer y = 52
integer width = 315
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo: "
boolean focusrectangle = false
end type

type dw_grupos_paquetes from datawindow within w_grupos_paquete
integer x = 91
integer y = 480
integer width = 3470
integer height = 1408
integer taborder = 10
string dataobject = "dw_grupos_paquetes"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
STRING ls_materia 


IF dwo.name = "cve_materia" THEN 
	
	iuo_materias_servicios.of_recupera_materia( LONG(data), ls_materia)
	
	THIS.SETITEM(row, "materias_materia", ls_materia)   
	
END IF 






end event

event clicked;
IF dwo.name = "b_buscar" THEN 
	
	LONG ll_cve_materia
	STRING ls_materia 

	OPENWITHPARM(w_busca_materia, il_coordinacion) 
	ll_cve_materia = MESSAGE.doubleparm 
	
	THIS.SETITEM(row, "cve_materia", ll_cve_materia)   
	iuo_materias_servicios.of_recupera_materia( ll_cve_materia, ls_materia) 
	THIS.SETITEM(row, "materias_materia", ls_materia)     

	
END IF 


 




end event

