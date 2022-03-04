$PBExportHeader$uo_dw_reporte_general.sru
forward
global type uo_dw_reporte_general from datawindow
end type
end forward

global type uo_dw_reporte_general from datawindow
int Width=3483
int Height=1576
int TabOrder=10
string DataObject="d_reporte_general"
BorderStyle BorderStyle=StyleLowered!
boolean LiveScroll=true
event ue_asigna_contenido ( string as_contenido,  transaction atr_transaccion )
end type
global uo_dw_reporte_general uo_dw_reporte_general

type variables
DataWindowChild idwc_contenido

end variables

event ue_asigna_contenido;datawindow ldw_reporte
integer rtncode
ldw_reporte = create datawindow
ldw_reporte.dataobject = this.dataobject

rtncode = ldw_reporte.GetChild('contenido', idwc_contenido)

IF rtncode = -1 THEN MessageBox( "Error", "Not a DataWindowChild "+string(rtncode))


idwc_contenido.Modify( "DataWindow.dataobject='+as_contenido+'" )
//idwc_contenido.dataobject = as_contenido
idwc_contenido.settransobject(atr_transaccion)
idwc_contenido.retrieve()
end event

