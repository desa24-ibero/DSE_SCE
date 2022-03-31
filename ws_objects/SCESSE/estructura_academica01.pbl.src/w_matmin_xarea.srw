$PBExportHeader$w_matmin_xarea.srw
forward
global type w_matmin_xarea from window
end type
type cb_1 from commandbutton within w_matmin_xarea
end type
type dw_matmin from datawindow within w_matmin_xarea
end type
end forward

global type w_matmin_xarea from window
integer width = 2254
integer height = 2004
boolean titlebar = true
string title = "Materias Minimas por Area"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
dw_matmin dw_matmin
end type
global w_matmin_xarea w_matmin_xarea

type variables
uo_parametros_corr_titulacion iuo_parametros_corr_titulacion 

end variables

on w_matmin_xarea.create
this.cb_1=create cb_1
this.dw_matmin=create dw_matmin
this.Control[]={this.cb_1,&
this.dw_matmin}
end on

on w_matmin_xarea.destroy
destroy(this.cb_1)
destroy(this.dw_matmin)
end on

event open;Long ll_cve , ll_plan
Integer li_opt , li_obl
dw_matmin.SetTransObject (gtr_sce)
iuo_parametros_corr_titulacion = CREATE uo_parametros_corr_titulacion  

iuo_parametros_corr_titulacion = MESSAGE.POWEROBJECTPARM 

 ll_cve = iuo_parametros_corr_titulacion.ids_paso.object.cve_carrera[1]
 ll_plan = iuo_parametros_corr_titulacion.ids_paso.object.cve_plan[1]
 
 dw_matmin.retrieve(ll_cve , ll_plan )
 
 If dw_matmin.rowcount() < 1 then
iuo_parametros_corr_titulacion.ids_paso.ROWSCOPY(1, iuo_parametros_corr_titulacion.ids_paso.ROWCOUNT(), PRIMARY!, dw_matmin, 1, PRIMARY!) 
End if



select COUNT(*) 
into :li_opt
from subsistema 
where  cve_carrera = :ll_cve and cve_plan = :ll_plan and
clase_area = 'OPT' USING gtr_sce;  

select COUNT(*) 
into :li_obl
from subsistema 
where  cve_carrera = :ll_cve and cve_plan = :ll_plan and
clase_area = 'OBL'  USING gtr_sce;

If li_opt > 0 then
	dw_matmin.object.cve_area_menor_opt_mat.protect = false
else
	dw_matmin.object.cve_area_menor_opt_mat.protect = true
End if 

If li_obl > 0 then
	dw_matmin.object.cve_area_menor_oblig_mat.protect = false
else
	dw_matmin.object.cve_area_menor_oblig_mat.protect = true
End if 
end event

type cb_1 from commandbutton within w_matmin_xarea
integer x = 1710
integer y = 1668
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;If dw_matmin.update() = -1 then 
MessageBox( 'Aviso', 'Error al guardar La cantidad minima , Verifique.', StopSign! ) 
Return 
else 
commit; 
MessageBox( 'Aviso', 'Se Guardo Correctamente , Verifique.') 
End if
end event

type dw_matmin from datawindow within w_matmin_xarea
integer x = 101
integer y = 60
integer width = 1897
integer height = 1720
integer taborder = 10
string title = "Materias Minimas por Area"
string dataobject = "dw_mat_min_xarea"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

