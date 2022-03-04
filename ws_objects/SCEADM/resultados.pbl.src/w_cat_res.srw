$PBExportHeader$w_cat_res.srw
$PBExportComments$Catálogo de Resultados, con calificaciones
forward
global type w_cat_res from Window
end type
type dw_1 from datawindow within w_cat_res
end type
type uo_nombre from uo_nombre_aspirante within w_cat_res
end type
end forward

global type w_cat_res from Window
int X=4
int Y=6
int Width=3621
int Height=1949
boolean TitleBar=true
string Title="Catálogo de Resultados"
string MenuName="m_menu"
long BackColor=10789024
dw_1 dw_1
uo_nombre uo_nombre
end type
global w_cat_res w_cat_res

type variables
string salones[]
int num_salones
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_cat_res.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_1=create dw_1
this.uo_nombre=create uo_nombre
this.Control[]={this.dw_1,&
this.uo_nombre}
end on

on w_cat_res.destroy
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

type dw_1 from datawindow within w_cat_res
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
int Y=429
int Width=3580
int Height=1357
string DataObject="dw_cat_res"
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

type uo_nombre from uo_nombre_aspirante within w_cat_res
int X=0
int Y=0
int TabOrder=11
boolean Enabled=true
long BackColor=1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante::destroy
end on

