$PBExportHeader$w_borra_historia_2013.srw
$PBExportComments$Esta ventana es de consulta se despliega todas las materias anteriores incritas,calificacion,periodo,anio etc. de la tabla de historico. Juan Campos Nov-1996
forward
global type w_borra_historia_2013 from w_master_main
end type
type uo_nombre from uo_carreras_alumno_lista within w_borra_historia_2013
end type
type dw_borra_historia from uo_master_dw within w_borra_historia_2013
end type
end forward

global type w_borra_historia_2013 from w_master_main
integer width = 3758
integer height = 2668
string title = "Borra Historia Académica"
string menuname = "m_menu_general_2013"
boolean maxbox = false
uo_nombre uo_nombre
dw_borra_historia dw_borra_historia
end type
global w_borra_historia_2013 w_borra_historia_2013

type variables
long il_carrera,il_cuenta,il_plan
Datawindowchild dwc_periodo
end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();If MessageBox("Aviso","¿Está seguro que desea BORRAR LA HISTORIA académica de esté alumno?",Question!,YesNo!,2) = 1 Then
	Return 1
else 
	Return -1
end if
end function

on w_borra_historia_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.uo_nombre=create uo_nombre
this.dw_borra_historia=create dw_borra_historia
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_borra_historia
end on

on w_borra_historia_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_borra_historia)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_plan = uo_nombre.istr_carrera.str_cve_plan

if il_carrera = 0 then return

dw_borra_historia.Reset()

If dw_borra_historia.Retrieve(il_cuenta,il_carrera, il_plan) = 0 Then
	Messagebox("Aviso","El alumno no tiene registradas materias en el historico")	
end if
end event

event open;call super::open;m_menu_general_2013.m_registro.m_nuevo.enabled = False
dw_borra_historia.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_borra_historia, dwc_periodo, "historico_periodo")

end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Borra Historia Académica"
end event

event ue_actualiza;call super::ue_actualiza;integer li_corte_3r_4i,  li_baja_3_reprob, li_baja_4_insc
long ll_cuenta,  ll_cve_plan, ll_cve_flag_promedio_original, Contador, ContMat
decimal ld_promedio
int li_res 
BOOLEAN DeleteOK = True

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	triggerevent(doubleclicked!)
	return
end if

Setpointer(Hourglass!)

ContMat = dw_borra_historia.RowCount()

If ContMat > 0 Then
	
	For Contador = 1 To ContMat
		If dw_borra_historia.DeleteRow(1) <> 1 Then
			DeleteOK = False
			Messagebox("Ocurrio un error al borrar la historia","Intente de nuevo")
			EXIT 
		End If
	Next
	If DeleteOk  Then 
		dw_borra_historia.Update()
		Commit Using gtr_sce; 
		MessageBox("Aviso","La historia académica fue borrada")
	END IF
	IF gtr_sce.sqlcode = 0 Then
		messagebox("Información","Se han guardado los cambios")		
		If Not act_banderas_borrahistoria(il_cuenta) then // Actualiza creditos,promedio y banderas
			rollback using gtr_sce;
				Messagebox("ATENCIÓN","Los catálogos, Académicos, Banderas de bloqueos de servicios escolares, NO se actualizaron")
				MessageBox("IMPORTANTE","Revisar promedio, créditos y Banderas bloqueos de servicios escolares del alumno, en sus respectivos catálogos")		  	  
		else	
			dw_borra_historia.Reset()
			Commit using gtr_sce;
			End if
	Else
		Rollback using gtr_sce;
		Messagebox("Aviso","Error al borrar Historia ~rLos cambios No fueron guardados "+gtr_sce.sqlerrtext)		
	End if		
	
ELSE
	
	Rollback Using gtr_sce;
	Messagebox("No hay datos para borrar","")	
	
END IF





//integer li_corte_3r_4i,  li_baja_3_reprob, li_baja_4_insc
//long ll_cuenta,  ll_cve_plan, ll_cve_flag_promedio_original
//decimal ld_promedio
//int li_res
//
//li_res = wf_validar ()
//if li_res = -1 then
//	rollback using gtr_sce;
//	messagebox("Información","No se han guardado los cambios")	
//	triggerevent(doubleclicked!)
//	return
//end if
//
//Setpointer(Hourglass!)
//Delete from historico
//   WHERE (historico.cuenta  = :il_cuenta) And
//         (historico.cve_carrera = :il_carrera)  And
//         (historico.cve_plan = :il_plan) using gtr_sce;
//
//IF gtr_sce.sqlcode = 0 Then
//	messagebox("Información","Se han guardado los cambios")		
//	If Not act_banderas_borrahistoria(il_cuenta) then // Actualiza creditos,promedio y banderas
//		rollback using gtr_sce;
//   		Messagebox("ATENCIÓN","Los catálogos, Académicos, Banderas de bloqueos de servicios escolares, NO se actualizaron")
//    		MessageBox("IMPORTANTE","Revisar promedio, créditos y Banderas bloqueos de servicios escolares del alumno, en sus respectivos catálogos")		  	  
//	else	
//		dw_borra_historia.Reset()
//		Commit using gtr_sce;
//    	End if
//Else
//	Rollback using gtr_sce;
//	Messagebox("Aviso","Error al borrar Historia ~rLos cambios No fueron guardados "+gtr_sce.sqlerrtext)		
//End if		
//
end event

event ue_borra;call super::ue_borra;Triggerevent('ue_actualiza')
end event

type st_sistema from w_master_main`st_sistema within w_borra_historia_2013
end type

type p_ibero from w_master_main`p_ibero within w_borra_historia_2013
end type

type uo_nombre from uo_carreras_alumno_lista within w_borra_historia_2013
integer x = 37
integer y = 304
integer width = 3241
integer height = 516
integer taborder = 40
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

type dw_borra_historia from uo_master_dw within w_borra_historia_2013
integer x = 41
integer y = 832
integer width = 3621
integer height = 1604
integer taborder = 0
string dataobject = "dw_bajasborrahistoria_materias_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this
end event

