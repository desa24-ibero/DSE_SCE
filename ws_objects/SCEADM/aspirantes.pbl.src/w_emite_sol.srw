$PBExportHeader$w_emite_sol.srw
$PBExportComments$Imprime la solicitud de ingreso con el formato establecido
forward
global type w_emite_sol from w_ancestral
end type
type dw_nacimiento from uo_dw_reporte within w_emite_sol
end type
type uo_nombre from uo_nombre_aspirante within w_emite_sol
end type
end forward

global type w_emite_sol from w_ancestral
integer width = 3666
integer height = 2256
string title = "Emisión de Solicitudes"
string menuname = "m_menu"
dw_nacimiento dw_nacimiento
uo_nombre uo_nombre
end type
global w_emite_sol w_emite_sol

type variables
long il_folio
end variables

event open;call super::open;uo_nombre.em_cuenta.text = " "

dw_nacimiento.settransobject(gtr_sadm)
end event

event doubleclicked;call super::doubleclicked;int flag
flag = 0

il_folio=long(uo_nombre.em_cuenta.text)
if dw_nacimiento.event carga() = 0 then
	flag = flag + 1
else
	dw_nacimiento.modify("lugar_nac.width=887")		
end if	

if flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if

dw_nacimiento.setitem(dw_nacimiento.getrow(),"general_nombre",uo_nombre.dw_nombre_aspirante.getitemstring(uo_nombre.dw_nombre_aspirante.getrow(),"nombre"))

dw_nacimiento.setitem(dw_nacimiento.getrow(),"general_apaterno",uo_nombre.dw_nombre_aspirante.getitemstring(uo_nombre.dw_nombre_aspirante.getrow(),"apaterno"))

dw_nacimiento.setitem(dw_nacimiento.getrow(),"general_amaterno",uo_nombre.dw_nombre_aspirante.getitemstring(uo_nombre.dw_nombre_aspirante.getrow(),"amaterno"))
end event

on w_emite_sol.create
int iCurrent
call super::create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_nacimiento=create dw_nacimiento
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_nacimiento
this.Control[iCurrent+2]=this.uo_nombre
end on

on w_emite_sol.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_nacimiento)
destroy(this.uo_nombre)
end on

type p_uia from w_ancestral`p_uia within w_emite_sol
end type

type dw_nacimiento from uo_dw_reporte within w_emite_sol
integer x = 0
integer y = 416
integer width = 3621
integer height = 1652
integer taborder = 20
string dataobject = "dw_solicitud"
end type

event carga;return retrieve(il_folio,gi_version,gi_periodo,gi_anio)
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild carr1
getchild("x",carr1)
carr1.settransobject(gtr_sce)
carr1.retrieve()
end event

event anterior;uo_nombre.event anterior()
end event

event primero;uo_nombre.event primero()
end event

event siguiente;call super::siguiente;uo_nombre.event siguiente()
end event

event ultimo;uo_nombre.event ultimo()
end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

type uo_nombre from uo_nombre_aspirante within w_emite_sol
integer x = 375
integer width = 3241
integer height = 416
integer taborder = 10
boolean enabled = true
long backcolor = 1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante::destroy
end on

