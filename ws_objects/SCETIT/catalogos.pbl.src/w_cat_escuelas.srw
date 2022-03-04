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
string title = "Escuelas"
long backcolor = 16777215
end type
global w_cat_escuelas w_cat_escuelas

on w_cat_escuelas.create
call super::create
end on

on w_cat_escuelas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event activate;call super::activate;//control_escolar.toolbarsheettitle="Escuelas"
end event

event open;call super::open;//g_nv_security.fnv_secure_window (this)
//gnv_app.inv_security.of_SetSecurity(this)
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_escuelas
event copia_municipio ( )
event limpia_municipio ( )
integer x = 96
integer y = 76
integer width = 4690
string dataobject = "dw_escuelas_2"
end type

event dw_catalogo::copia_municipio();
THIS.SETITEM(GETROW(), "cve_mun_loc", THIS.GETITEMNUMBER(GETROW(), "edita_mun_loc")) 
THIS.SETCOLUMN("cene_1") 







end event

event dw_catalogo::limpia_municipio();
INTEGER le_null
SETNULL(le_null)

THIS.SETITEM(THIS.GETROW(), "cve_mun_loc", le_null) 



end event

event dw_catalogo::itemchanged;call super::itemchanged;
integer rtncode, li_setfilter, li_filter
string ls_data
long ll_rowcount, ll_retrieve

IF dwo.name = "cve_sep" THEN 

	LONG ll_cve_estado
	DATAWINDOWCHILD ldw_municipios
	
	
//	ll_cve_estado = THIS.GETITEMNUMBER(currentrow, "cve_sep") 
//	IF ISNULL(ll_cve_estado) THEN RETURN 0
	
	
	rtncode =THIS.GETCHILD("edita_mun_loc", ldw_municipios) 
	ls_data = data
	ll_rowcount = ldw_municipios.RowCount()
	if ll_rowcount = 0 then
//		ldw_municipios.dataobject = 'dddw_municipio_localidad_2'
		ldw_municipios.SetTransObject(gtr_sce)
		ll_retrieve =ldw_municipios.Retrieve()
	end if
	li_setfilter = ldw_municipios.SETFILTER("cve_estado = " + ls_data)  
	li_filter = ldw_municipios.FILTER() 
	ll_rowcount =ldw_municipios.RowCount()
	THIS.POSTEVENT("limpia_municipio")

ELSEIF dwo.name = "edita_mun_loc" THEN 
	
	THIS.SETROW(row)
	THIS.POSTEVENT("copia_municipio")
	

END IF 




end event

event dw_catalogo::rowfocuschanged;call super::rowfocuschanged;

//IF dwo.name = "cve_sep" THEN 


integer rtncode, li_setfilter, li_filter
string ls_data
long ll_rowcount, ll_retrieve



	LONG ll_cve_estado
	DATAWINDOWCHILD ldw_municipios
	
	
	ll_cve_estado = THIS.GETITEMNUMBER(currentrow, "cve_sep") 
	IF ISNULL(ll_cve_estado) THEN RETURN 0
	
	
	rtncode =THIS.GETCHILD("edita_mun_loc", ldw_municipios) 
	ll_rowcount = ldw_municipios.RowCount()	
	if ll_rowcount = 0 then
		ldw_municipios.SetTransObject(gtr_sce)
		ll_retrieve =ldw_municipios.Retrieve()
	end if		
	li_setfilter = ldw_municipios.SETFILTER("cve_estado = " + STRING(ll_cve_estado))   
	li_filter = ldw_municipios.FILTER() 
	ll_rowcount =ldw_municipios.RowCount()
//ELSEIF dwo.name = "edita_mun_loc" THEN 
//	
//	THIS.SETROW(row)
//	THIS.POSTEVENT("copia_municipio")
//	
//
//END IF 
//
end event

event dw_catalogo::itemfocuschanged;call super::itemfocuschanged;
IF dwo.name = "edita_mun_loc" THEN 
	THIS.MODIFY("edita_mun_loc.width = 930")
	THIS.MODIFY("edita_mun_loc.x = 2797")
ELSE
	THIS.MODIFY("edita_mun_loc.width = 78")
	THIS.MODIFY("edita_mun_loc.x = 3653")
END IF



end event

