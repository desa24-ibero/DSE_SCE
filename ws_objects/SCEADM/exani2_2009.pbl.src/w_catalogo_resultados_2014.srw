$PBExportHeader$w_catalogo_resultados_2014.srw
$PBExportComments$Catálogo de Resultados, con calificaciones
forward
global type w_catalogo_resultados_2014 from window
end type
type dw_1 from datawindow within w_catalogo_resultados_2014
end type
type uo_nombre from uo_nombre_aspirante within w_catalogo_resultados_2014
end type
end forward

global type w_catalogo_resultados_2014 from window
integer x = 5
integer y = 8
integer width = 3621
integer height = 1948
boolean titlebar = true
string title = "Catálogo de Resultados"
string menuname = "m_menu"
long backcolor = 16777215
dw_1 dw_1
uo_nombre uo_nombre
end type
global w_catalogo_resultados_2014 w_catalogo_resultados_2014

type variables
string salones[]
int num_salones
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_catalogo_resultados_2014.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.uo_nombre=create uo_nombre
this.Control[]={this.dw_1,&
this.uo_nombre}
end on

on w_catalogo_resultados_2014.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.uo_nombre)
end on

event open;x = 1
y = 1

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = false
uo_nombre.cbx_nuevo.enabled = false


end event

event doubleclicked;dw_1.event carga(long(uo_nombre.em_cuenta.text))
end event

type dw_1 from datawindow within w_catalogo_resultados_2014
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
integer y = 428
integer width = 3579
integer height = 1356
string dataobject = "dw_catalogo_resultados_2014"
end type

event primero;uo_nombre.event primero()
end event

event anterior;uo_nombre.event anterior()
end event

event siguiente;uo_nombre.event siguiente()
end event

event ultimo;uo_nombre.event ultimo()
end event

event carga;
return retrieve(gi_version,gi_periodo,gi_anio,folio)

end event

event constructor;m_menu.dw = this

DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

this.settransobject(gtr_sadm)
end event

type uo_nombre from uo_nombre_aspirante within w_catalogo_resultados_2014
integer width = 3241
integer height = 416
integer taborder = 11
boolean enabled = true
long backcolor = 1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante::destroy
end on

