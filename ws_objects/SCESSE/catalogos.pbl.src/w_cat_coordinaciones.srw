$PBExportHeader$w_cat_coordinaciones.srw
forward
global type w_cat_coordinaciones from w_catalogo
end type
end forward

global type w_cat_coordinaciones from w_catalogo
integer x = 4
integer y = 6
integer width = 3686
integer height = 2221
end type
global w_cat_coordinaciones w_cat_coordinaciones

on w_cat_coordinaciones.create
call super::create
end on

on w_cat_coordinaciones.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Departamentos"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
end event

event close;call super::close;//close(this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_coordinaciones
integer x = 106
integer y = 93
integer width = 3434
integer height = 1619
string dataobject = "dw_coordinaciones"
end type

event dw_catalogo::rbuttondown;call super::rbuttondown;long ll_row, ll_cve_profesor, ll_cve_profesor_elegido

if row > 0 then
	ll_cve_profesor = this.GetItemNumber(row,"cve_coordinador")
	OpenWithParm(w_response_elige_profesor, ll_cve_profesor)
	ll_cve_profesor_elegido = Message.DoubleParm
	if not(ll_cve_profesor = ll_cve_profesor_elegido or ll_cve_profesor_elegido = 0) then
		this.SetItem(row,"cve_coordinador",ll_cve_profesor_elegido)
	end if
end if
end event

