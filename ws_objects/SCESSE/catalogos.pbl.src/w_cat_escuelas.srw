$PBExportHeader$w_cat_escuelas.srw
forward
global type w_cat_escuelas from w_catalogo
end type
end forward

global type w_cat_escuelas from w_catalogo
integer x = 5
integer y = 4
integer width = 4891
integer height = 2384
end type
global w_cat_escuelas w_cat_escuelas

on w_cat_escuelas.create
call super::create
end on

on w_cat_escuelas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;control_escolar.toolbarsheettitle="Escuelas"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
//gnv_app.inv_security.of_SetSecurity(this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_escuelas
event copia_municipio ( )
event limpia_municipio ( )
event edita_copia_municipio ( )
integer x = 96
integer y = 76
integer width = 4690
string dataobject = "dw_escuelas_2"
boolean hscrollbar = true
end type

event dw_catalogo::copia_municipio();THIS.SETITEM(GETROW(), "cve_mun_loc", THIS.GETITEMNUMBER(GETROW(), "edita_mun_loc")) 




end event

event dw_catalogo::limpia_municipio();
INTEGER le_null
SETNULL(le_null)

THIS.SETITEM(THIS.GETROW(), "cve_mun_loc", le_null) 



end event

event dw_catalogo::edita_copia_municipio();THIS.SETITEM(GETROW(), "edita_mun_loc", THIS.GETITEMNUMBER(GETROW(), "cve_mun_loc")) 






end event

event dw_catalogo::itemchanged;call super::itemchanged;DATAWINDOWCHILD ldw_municipios

IF dwo.name = "cve_sep" AND LOWER(gs_servidor) <> LOWER("Mexico") THEN 
	THIS.GETCHILD("edita_mun_loc", ldw_municipios) 
	ldw_municipios.SETFILTER("cve_estado = " + data)  
	ldw_municipios.FILTER() 

	THIS.POSTEVENT("limpia_municipio")

ELSEIF dwo.name = "mun_loc" OR dwo.name  = "edita_mun_loc"  THEN 
	THIS.SETROW(row)
	THIS.POSTEVENT("copia_municipio")

ELSEIF dwo.name  = "cve_mun_loc"THEN 
	THIS.SETROW(row)
	THIS.POSTEVENT("edita_copia_municipio")
END IF 




end event

event dw_catalogo::rowfocuschanged;call super::rowfocuschanged;LONG ll_cve_estado
DATAWINDOWCHILD ldw_municipios

IF LOWER(gs_servidor) <> LOWER("Mexico") THEN 
	ll_cve_estado = THIS.GETITEMNUMBER(currentrow, "cve_sep") 
	IF ISNULL(ll_cve_estado) THEN RETURN 0
	
	THIS.GETCHILD("edita_mun_loc", ldw_municipios) 
	
	ldw_municipios.SETFILTER("cve_estado = " + STRING(ll_cve_estado))   
	ldw_municipios.FILTER() 
END IF 

end event

event dw_catalogo::itemfocuschanged;call super::itemfocuschanged;
IF dwo.name = "edita_mun_loc" THEN 
	THIS.MODIFY("edita_mun_loc.width = 919")
	THIS.MODIFY("edita_mun_loc.x = 2798")
ELSE
	THIS.MODIFY("edita_mun_loc.width = 78")
	THIS.MODIFY("edita_mun_loc.x = 3639")
END IF



end event

event dw_catalogo::itemerror;call super::itemerror;RETURN 1
end event

event dw_catalogo::clicked;call super::clicked;LONG ll_cve_mun_loc, ll_cve_estado

IF dwo.name = "b_buscar" THEN 
	ll_cve_estado = THIS.GETITEMNUMBER(row, "cve_sep") 
	IF ISNULL(ll_cve_estado) THEN RETURN 0

	OPENWITHPARM(w_busca_municipios, ll_cve_estado) 
	ll_cve_mun_loc = MESSAGE.doubleparm 
	
	IF ll_cve_mun_loc > 0 THEN 
		THIS.SETITEM(row, "cve_mun_loc", ll_cve_mun_loc)
		THIS.SETROW(row)
		THIS.POSTEVENT("edita_copia_municipio")
	END IF		
END IF 



end event

