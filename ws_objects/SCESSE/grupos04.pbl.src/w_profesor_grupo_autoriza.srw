$PBExportHeader$w_profesor_grupo_autoriza.srw
forward
global type w_profesor_grupo_autoriza from window
end type
type uoi_coordinaciones from uo_coordinaciones_divisional within w_profesor_grupo_autoriza
end type
type st_3 from statictext within w_profesor_grupo_autoriza
end type
type cbx_inc_titulares from checkbox within w_profesor_grupo_autoriza
end type
type st_2 from statictext within w_profesor_grupo_autoriza
end type
type cb_salir from commandbutton within w_profesor_grupo_autoriza
end type
type cb_guardar from commandbutton within w_profesor_grupo_autoriza
end type
type cb_1 from commandbutton within w_profesor_grupo_autoriza
end type
type dw_estatus from datawindow within w_profesor_grupo_autoriza
end type
type uo_periodo from uo_per_ani within w_profesor_grupo_autoriza
end type
type st_1 from statictext within w_profesor_grupo_autoriza
end type
type dw_autorizacion from datawindow within w_profesor_grupo_autoriza
end type
end forward

global type w_profesor_grupo_autoriza from window
integer width = 5202
integer height = 2896
boolean titlebar = true
string title = "Autorización de Profesores Grupos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
uoi_coordinaciones uoi_coordinaciones
st_3 st_3
cbx_inc_titulares cbx_inc_titulares
st_2 st_2
cb_salir cb_salir
cb_guardar cb_guardar
cb_1 cb_1
dw_estatus dw_estatus
uo_periodo uo_periodo
st_1 st_1
dw_autorizacion dw_autorizacion
end type
global w_profesor_grupo_autoriza w_profesor_grupo_autoriza

type variables
INTEGER ii_periodo, ii_anio
INTEGER ie_cve_division 
end variables

forward prototypes
public function integer wf_obten_division ()
end prototypes

public function integer wf_obten_division ();integer li_cve_division, li_codigo_sql
string ls_mensaje_sql
STRING ls_usuario

ls_usuario = gs_usuario 


SELECT divisiones.cve_division 
INTO :li_cve_division
FROM  divisiones 
WHERE divisiones.id_usuario = :ls_usuario
USING gtr_sce;


li_codigo_sql = gtr_sce.SqlCode
ls_mensaje_sql = gtr_sce.SqlErrText

if li_codigo_sql = 100 or isnull(li_cve_division) then 
	return 9999
elseif li_codigo_sql = -1 then
	MessageBox("Error al consultar coordinaciones", ls_mensaje_sql)
	return -1
end if

return li_cve_division
end function

on w_profesor_grupo_autoriza.create
this.uoi_coordinaciones=create uoi_coordinaciones
this.st_3=create st_3
this.cbx_inc_titulares=create cbx_inc_titulares
this.st_2=create st_2
this.cb_salir=create cb_salir
this.cb_guardar=create cb_guardar
this.cb_1=create cb_1
this.dw_estatus=create dw_estatus
this.uo_periodo=create uo_periodo
this.st_1=create st_1
this.dw_autorizacion=create dw_autorizacion
this.Control[]={this.uoi_coordinaciones,&
this.st_3,&
this.cbx_inc_titulares,&
this.st_2,&
this.cb_salir,&
this.cb_guardar,&
this.cb_1,&
this.dw_estatus,&
this.uo_periodo,&
this.st_1,&
this.dw_autorizacion}
end on

on w_profesor_grupo_autoriza.destroy
destroy(this.uoi_coordinaciones)
destroy(this.st_3)
destroy(this.cbx_inc_titulares)
destroy(this.st_2)
destroy(this.cb_salir)
destroy(this.cb_guardar)
destroy(this.cb_1)
destroy(this.dw_estatus)
destroy(this.uo_periodo)
destroy(this.st_1)
destroy(this.dw_autorizacion)
end on

event open;// Se recupera el periodo de alta de grupos
 f_obten_periodo(ii_periodo, ii_anio, 4) 

ie_cve_division = wf_obten_division() 
 
uoi_coordinaciones.il_division = ie_cve_division 
uoi_coordinaciones.TRIGGEREVENT("carga") 
 
 
THIS.uo_periodo.em_ani.text = string(ii_anio)
THIS.uo_periodo.em_per.text = string(ii_periodo)

THIS.uo_periodo.ie_anio = ii_anio 
THIS.uo_periodo.ie_periodo = ii_periodo   
THIS.uo_periodo.TRIGGEREVENT("ue_modifica") 

DATAWINDOWCHILD ldwc_estatus_prof 
dw_estatus.INSERTROW(0) 
dw_estatus.GETCHILD("id_estatus", ldwc_estatus_prof)
ldwc_estatus_prof.SETTRANSOBJECT(gtr_sce) 
ldwc_estatus_prof.RETRIEVE() 
INTEGER le_row
le_row = ldwc_estatus_prof.INSERTROW(0)
ldwc_estatus_prof.SETITEM(le_row, 1, 9999)
ldwc_estatus_prof.SETITEM(le_row, 2, 'TODOS')


end event

type uoi_coordinaciones from uo_coordinaciones_divisional within w_profesor_grupo_autoriza
integer x = 2062
integer y = 48
integer taborder = 60
end type

on uoi_coordinaciones.destroy
call uo_coordinaciones_divisional::destroy
end on

type st_3 from statictext within w_profesor_grupo_autoriza
integer x = 1627
integer y = 76
integer width = 393
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Coordinación: "
boolean focusrectangle = false
end type

type cbx_inc_titulares from checkbox within w_profesor_grupo_autoriza
integer x = 1298
integer y = 268
integer width = 485
integer height = 80
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Inc. Titulares"
end type

type st_2 from statictext within w_profesor_grupo_autoriza
integer x = 59
integer y = 272
integer width = 251
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Estatus: "
boolean focusrectangle = false
end type

type cb_salir from commandbutton within w_profesor_grupo_autoriza
integer x = 4229
integer y = 264
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT) 
end event

type cb_guardar from commandbutton within w_profesor_grupo_autoriza
integer x = 3813
integer y = 264
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;IF dw_autorizacion.UPDATE() < 0 THEN 
	ROLLBACK USING gtr_sce; 
	MESSAGEBOX("Error", "Se produjo un error al guardar la información de grupos") 
	RETURN -1
END IF 	
	
COMMIT USING gtr_sce;
MESSAGEBOX("Aviso", "El estaus de los profesores fue actualizado con éxito.")  



end event

type cb_1 from commandbutton within w_profesor_grupo_autoriza
integer x = 3397
integer y = 264
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;INTEGER le_estatus
LONG ll_cve_coordinacion 

le_estatus = dw_estatus.GETITEMNUMBER(1, "id_estatus")  
IF ISNULL(le_estatus) THEN le_estatus = 0 

ll_cve_coordinacion = uoi_coordinaciones.of_obten_cve_coordinacion()


// Se verifica si se ha seleccionado una coordinación
IF ISNULL(ll_cve_coordinacion) OR ll_cve_coordinacion = 0 THEN 
	MESSAGEBOX("Aviso", "No se ha selecionado una coordinación válida.")
	RETURN -1 
END IF 


STRING ls_sql 

ls_sql = "  SELECT profesor_cotitular.cve_mat,   " + & 
"         profesor_cotitular.gpo,   " + &  
"         profesor_cotitular.periodo,    " + & 
"         profesor_cotitular.anio,   " + &  
"         profesor_cotitular.cve_profesor,   " + &  
"         profesor_cotitular.titularidad,   " + &  
"         profesor_cotitular.fecha_inicio,   " + &  
"         profesor_cotitular.fecha_fin,   " + &  
"         profesor_cotitular.horas_totales_grupo,   " + &  
"         profesor_cotitular.tipo_profesor,   " + &  
"         profesor_cotitular.autorizado,   " + &  
"         materias.materia,   " + &  
"         profesor.nombre,   " + &  
"         profesor.apaterno,   " + &  
"         profesor.amaterno,   " + &  
"         grupos.forma_imparte,   " + &  
"         grupos.sesionado,   " + &  
"         grupos.fecha_inicio,   " + &  
"         grupos.fecha_fin  " + &  
"    FROM profesor_cotitular,   " + &  
"         materias,   " + &  
"         profesor,   " + &  
"         grupos, coordinaciones, departamentos, divisiones   " + &  
"   WHERE ( profesor_cotitular.cve_mat = materias.cve_mat ) and   " + & 
"         ( profesor_cotitular.cve_profesor = profesor.cve_profesor ) and   " + & 
"		( profesor_cotitular.cve_mat = grupos.cve_mat ) and  " + & 
"		( profesor_cotitular.gpo = grupos.gpo ) and  " + & 
"		( profesor_cotitular.periodo = grupos.periodo ) and  " + & 
"		( profesor_cotitular.anio = grupos.anio ) AND  " + & 
"		( profesor_cotitular.periodo = " + STRING(ii_periodo) + " OR " + STRING(ii_periodo) + " = 9999 ) AND  " + & 
"		( profesor_cotitular.anio = " + STRING(ii_anio) + " OR " + STRING(ii_anio) + " =  9999) AND  " + & 
"		( profesor_cotitular.autorizado = " + STRING(le_estatus) + " OR " + STRING(le_estatus) +  "  = 9999) "  + & 
"	   	AND materias.cve_coordinacion = coordinaciones.cve_coordinacion  " + & 
"	   	AND coordinaciones.cve_depto = departamentos.cve_depto  " + & 
"	    AND departamentos.cve_division = divisiones.cve_division  " + & 
"		AND (divisiones.cve_division = " + STRING(ie_cve_division) +  " OR " + STRING(ie_cve_division) + " = 9999 ) " + & 
"		AND (coordinaciones.cve_coordinacion = " + STRING(ll_cve_coordinacion) + " OR " +  STRING(ll_cve_coordinacion) + " = 9999 ) " + &
" ORDER BY 1,2,3,4 " 



/*( profesor.cve_profesor = grupos.cve_profesor ) and */
dw_autorizacion.DATAOBJECT = "dw_profesor_autoriza_est"
dw_autorizacion.MODIFY("Datawindow.Table.Select = '" + ls_sql + "'" )
dw_autorizacion.SETTRANSOBJECT(gtr_sce) 
dw_autorizacion.RETRIEVE(ii_periodo, ii_anio, le_estatus, ie_cve_division) 

IF NOT cbx_inc_titulares.CHECKED THEN  
	dw_autorizacion.SETFILTER("profesor_cotitular_titularidad = 0") 
	dw_autorizacion.FILTER() 
END IF 	

dw_autorizacion.GROUPCALC() 





end event

type dw_estatus from datawindow within w_profesor_grupo_autoriza
integer x = 462
integer y = 256
integer width = 768
integer height = 100
integer taborder = 30
string title = "none"
string dataobject = "dw_profesor_estatus_aut"
boolean border = false
boolean livescroll = true
end type

type uo_periodo from uo_per_ani within w_profesor_grupo_autoriza
integer x = 343
integer y = 28
integer width = 1253
integer height = 168
integer taborder = 20
boolean enabled = true
boolean border = true
long backcolor = 1090519039
end type

event ue_modifica;call super::ue_modifica;
PARENT.ii_periodo = THIS.ie_periodo
PARENT.ii_anio = THIS.ie_anio 

end event

on uo_periodo.destroy
call uo_per_ani::destroy
end on

type st_1 from statictext within w_profesor_grupo_autoriza
integer x = 78
integer y = 52
integer width = 265
integer height = 64
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Periodo: "
boolean focusrectangle = false
end type

type dw_autorizacion from datawindow within w_profesor_grupo_autoriza
integer x = 78
integer y = 412
integer width = 4585
integer height = 2036
integer taborder = 10
string title = "none"
string dataobject = "dw_profesor_autoriza_est"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

