$PBExportHeader$u_dw.sru
$PBExportComments$Extension DataWindow class
forward
global type u_dw from pfc_u_dw
end type
end forward

global type u_dw from pfc_u_dw
event type integer ue_actualiza ( )
event ue_borrarenglon ( )
event ue_guarda_archivo ( )
end type
global u_dw u_dw

event type integer ue_actualiza();// Personalizado para los catálogos del SIT
// Juan Campos Sánchez.
// Regresa: 1 si hace los cambios en la base de datos
// Cambios al objeto de transaccion para que permita modificar en
//	Control Escolar
// Julio-2001.
 
if this.ModifiedCount() + this.DeletedCount() > 0 then 
	if this.Event pfc_Update(true,true) >= 1 then 
		commit using gtr_sce;
		Messagebox("Aviso","Los cambios fueron guardados")
		return 1
	else
		rollback using gtr_sce;
		Messagebox("Antención","~nAlgunos datos no son validos~n~nLos cambios NO se guardaron")	
		return 0
	end if
else
	return FAILURE 
end if

end event

event ue_borrarenglon;// Borra el renglon selecionado y guarda los cambios en la base de datos 
// Se personalizo para usu de los Catálogos de Tesorería
// Juan Campos Sánchez
// 4-Julio-2001.

if messagebox("Atención","Esta seguro que desea borrar el renglon actual",Question!,YesNo!,1) = 1 then

	if this. event pfc_deleterow() = 1 then
	
		if this.DeletedCount() > 0 then 		
			
			if this. event ue_actualiza() = 0 then this. event pfc_retrieve()
			
		end if
		
	end if
	
end if

end event

event ue_guarda_archivo;// Guarda los datos del dw en archivo externo
// Juan Campos Julio-2001.

if this.rowcount() > 0 then
	if this.SaveAs() <> 1 then		 
		messagebox("Anteción","No se pudo guardar el archivo externo")	
	end if
else
	Messagebox("Atención","No hay datos para guardar")
end if

end event

on u_dw.create
end on

on u_dw.destroy
end on

