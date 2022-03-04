$PBExportHeader$u_datastore.sru
forward
global type u_datastore from datastore
end type
end forward

global type u_datastore from datastore
end type
global u_datastore u_datastore

forward prototypes
public function integer of_borra_todo ()
end prototypes

public function integer of_borra_todo ();//DESCRIPCIÓN: Borra todos los registros del datastore

integer li_res_del
long ll_row, ll_num_rows
integer li_cve_dia_orig, li_hora_inicio_orig, li_hora_final_orig, li_cupo

	
ll_num_rows = RowCount()

for ll_row=1 to ll_num_rows
	li_res_del= DeleteRow(0)
	if li_res_del= -1 then
		return -1
	end if
next

return 1

end function

on u_datastore.create
call super::create
TriggerEvent( this, "constructor" )
end on

on u_datastore.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event dberror;MessageBox(String(sqldbcode),sqlerrtext+"~n"+sqlsyntax,StopSign!)
return 1
end event

