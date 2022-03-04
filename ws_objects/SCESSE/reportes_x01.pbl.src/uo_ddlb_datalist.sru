$PBExportHeader$uo_ddlb_datalist.sru
forward
global type uo_ddlb_datalist from dropdownlistbox
end type
end forward

global type uo_ddlb_datalist from dropdownlistbox
integer width = 443
integer height = 104
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = "none"
boolean sorted = false
string item[] = {"hola"}
borderstyle borderstyle = stylelowered!
end type
global uo_ddlb_datalist uo_ddlb_datalist

type variables
private datastore ids_datos
private int ii_claves[], ii_total
private string is_descripciones[]


end variables

forward prototypes
public function integer inicializa (string as_nombre_datawindow, n_tr atr_tran)
public function integer obtenclave (string as_descripcion)
end prototypes

public function integer inicializa (string as_nombre_datawindow, n_tr atr_tran);
int li_total, li_i
ids_datos.DataObject = as_nombre_datawindow
ids_datos.SetTransObject(atr_tran)
li_total = ids_datos.retrieve()
if li_total > 0 then
	ii_total = li_total
	for li_i = 1 to li_total
		ii_claves[li_i] = ids_datos.GetItemNumber(li_i, 1)
		is_descripciones[li_i] = ids_datos.GetItemString(li_i,2)
		AddItem(is_descripciones[li_i])
	next 
	end if
return li_total

end function

public function integer obtenclave (string as_descripcion);int li_i = 0
boolean lb_encontrado = false
do while (li_i < ii_total and not(lb_encontrado))
	li_i++
	if is_descripciones[li_i] = as_descripcion then
		lb_encontrado = true
	end if	
loop
if lb_encontrado = true then
	return ii_claves[li_i]
else
	return 0
end if
end function

on uo_ddlb_datalist.create
end on

on uo_ddlb_datalist.destroy
end on

event constructor;ids_datos = Create DataStore
ii_total = 0
end event

event destructor;Destroy ids_datos
end event

