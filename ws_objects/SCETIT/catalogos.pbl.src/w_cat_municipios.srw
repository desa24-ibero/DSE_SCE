$PBExportHeader$w_cat_municipios.srw
$PBExportComments$Mantenimiento a Municipios / Localidades
forward
global type w_cat_municipios from w_catalogo
end type
end forward

global type w_cat_municipios from w_catalogo
integer width = 4407
integer height = 1872
string menuname = "m_catalogo_2"
long backcolor = 1073741824
end type
global w_cat_municipios w_cat_municipios

type variables
STRING is_sort
STRING is_columna
end variables

forward prototypes
public function integer wf_valida_registros ()
end prototypes

public function integer wf_valida_registros ();

LONG ll_total
LONG ll_pos


LONG ll_cve_estado
STRING ls_municipio
STRING ls_localidad
LONG ll_id


dw_catalogo.SETFILTER("tipo_registro = 1")
dw_catalogo.FILTER()



ll_total = dw_catalogo.ROWCOUNT() 

FOR ll_pos = 1 TO ll_total 

	ll_id = dw_catalogo.GETITEMNUMBER(ll_pos, "cve_mun_loc") 

	ll_cve_estado = dw_catalogo.GETITEMNUMBER(ll_pos, "cve_estado") 
	IF ISNULL(ll_cve_estado) THEN ll_cve_estado = 0
	
	ls_municipio = dw_catalogo.GETITEMSTRING(ll_pos, "municipio") 
	IF ISNULL(ls_municipio) THEN ls_municipio = "" 
	
	ls_localidad	 = dw_catalogo.GETITEMSTRING(ll_pos, "localidad") 
	IF ISNULL(ls_localidad) THEN ls_localidad = "" 

	IF ll_cve_estado = 0 OR ls_municipio = "" OR ls_localidad = "" THEN 
		MESSAGEBOX("Aviso", "No se actualizaron los registros. Existe información incompleta.") 
		dw_catalogo.SETFILTER("")
		dw_catalogo.FILTER()				
		dw_catalogo.SETSORT("cve_mun_loc ASC")
		dw_catalogo.SORT() 
		dw_catalogo.SCROLLTOROW(dw_catalogo.FIND("cve_mun_loc = " + STRING(ll_id), 0,  dw_catalogo.ROWCOUNT())  )
		RETURN -1
	END IF  
	
NEXT 

RETURN 0


end function

on w_cat_municipios.create
call super::create
if IsValid(this.MenuID) then destroy(this.MenuID)
if this.MenuName = "m_catalogo_2" then this.MenuID = create m_catalogo_2
end on

on w_cat_municipios.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;
is_sort = 'ASC'
end event

type dw_catalogo from w_catalogo`dw_catalogo within w_cat_municipios
integer x = 82
integer y = 72
integer width = 4151
integer height = 1500
string dataobject = "dw_municipio_localidad_captura"
end type

event dw_catalogo::rowfocuschanged;call super::rowfocuschanged;

//MESSAGEBOX("ENTRA", STRING(GETITEMSTATUS(getrow(), 0, Primary! ) ) ) 


// Se verifica si ya tiene asignado ID
LONG ll_id 
LONG ll_cve_municipio 
LONG ll_pos 

IF currentrow <= 0 THEN RETURN 0

ll_id = THIS.GETITEMNUMBER(currentrow, "cve_mun_loc") 

IF ll_id > 0 AND NOT ISNULL(ll_id ) THEN RETURN 0
	

SELECT MAX(cve_mun_loc) 
INTO :ll_cve_municipio
FROM municipio_localidad 
USING gtr_sce;
IF ISNULL(ll_cve_municipio) THEN ll_cve_municipio = 0


// Se incrementa la llave
ll_cve_municipio ++ 

DO 
	ll_pos = THIS.FIND("cve_mun_loc = " + STRING(ll_cve_municipio), 0, ROWCOUNT() + 1)  
	IF ll_pos > 0 THEN ll_cve_municipio ++ 
LOOP WHILE ll_pos <> 0 

THIS.SETITEM(currentrow, "cve_mun_loc", ll_cve_municipio)  
THIS.SETITEM(currentrow, "tipo_registro", 1)  



















end event

event dw_catalogo::constructor;m_catalogo_2.dw = this
end event

event dw_catalogo::doubleclicked;call super::doubleclicked;
STRING ls_objeto

ls_objeto = dwo.name 

IF dwo.type = "text" THEN 
	ls_objeto = LEFT(ls_objeto, LEN(ls_objeto) - 2)  
ELSE
	RETURN 0
END IF

// Si se trata de la misma columna 
IF ls_objeto = is_columna THEN 
	IF is_sort = "ASC" THEN 
		is_sort = "DESC" 
	ELSE
		is_sort = "ASC"
	END IF
ELSE
	is_sort = "ASC"
END IF

THIS.SETSORT(ls_objeto + " " + is_sort) 
THIS.SORT()

is_columna = ls_objeto





end event

event dw_catalogo::updatestart;call super::updatestart;
// Se verifica la información.
IF wf_valida_registros() = 0 THEN RETURN 0 
// No se hace el update
RETURN 1 
end event

event dw_catalogo::itemchanged;call super::itemchanged;
THIS.SETITEM(row, "tipo_registro", 1)  



end event

event dw_catalogo::updateend;call super::updateend;THIS.SETFILTER("")
THIS.FILTER() 
THIS.RETRIEVE()
end event

