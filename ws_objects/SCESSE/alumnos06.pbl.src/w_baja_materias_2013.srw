$PBExportHeader$w_baja_materias_2013.srw
forward
global type w_baja_materias_2013 from w_master_main
end type
type uo_nombre from uo_carreras_alumno_lista within w_baja_materias_2013
end type
type dw_baja_materias from uo_master_dw within w_baja_materias_2013
end type
end forward

global type w_baja_materias_2013 from w_master_main
integer width = 3758
integer height = 2668
string title = "Baja de Materias"
string menuname = "m_menu_general_2013"
boolean maxbox = false
uo_nombre uo_nombre
dw_baja_materias dw_baja_materias
end type
global w_baja_materias_2013 w_baja_materias_2013

type variables
long il_carrera,il_cuenta,il_cve_plan,il_materia
datawindowchild idwc_calif
Datawindowchild dwc_periodo
end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();Return 1
end function

on w_baja_materias_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.uo_nombre=create uo_nombre
this.dw_baja_materias=create dw_baja_materias
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_nombre
this.Control[iCurrent+2]=this.dw_baja_materias
end on

on w_baja_materias_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.dw_baja_materias)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_cve_plan = uo_nombre.istr_carrera.str_cve_plan

if il_carrera = 0 then return

dw_baja_materias.Reset()

triggerevent('ue_nuevo')

end event

event open;call super::open;dw_baja_materias.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

dw_baja_materias.Getchild('historico_calificacion',idwc_calif)
idwc_calif.settransobject(gtr_sce)

//triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

//Modif. Roberto Novoa May/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_baja_materias, dwc_periodo, "historico_periodo")

end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Baja de materias"
end event

event ue_actualiza;call super::ue_actualiza;int li_res
INTEGER le_existe

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if

If dw_baja_materias.Update(True,True) = 1 Then
     Commit Using gtr_sce; 
	messagebox("Información","Se han guardado los cambios")
	
	// Se verifica si la materia es inglés 
	SELECT COUNT(*) 
	INTO :le_existe 
	FROM materias_requisito 
	WHERE id_prerrequisito = 'ING'	 
	AND cve_mat = :il_materia 
	USING gtr_sce; 
	IF ISNULL(le_existe) THEN le_existe = 0
	
	//If il_materia = 4078 Then    // actualiza bandera prerreq. ingles
	If le_existe > 0 Then    // actualiza bandera prerreq. ingles 
		If Not Act_Bandera_Prerreq_Ingles(il_cuenta,'NA') then
	 		Messagebox("Atención","La bandera de Prerrequisito de ingles NO se actualizo") 	
		End If
	end if
	
	
     If Not actualiza_bandera(il_Cuenta,0) then
     	Messagebox("Aviso","Los catálogos Bloqueos, NO SE ACTUALIZARON ~rRevisar  Banderas de bloqueos del alumno")
     End if		  
	triggerevent(doubleclicked!)
Else
	Rollback Using gtr_sce;
	Messagebox("Algunos datos son incorrectos","Los cambios no fueron guardados")
End IF

end event

event ue_borra;call super::ue_borra;if dw_baja_materias.Getrow() = 0 then return
If Messagebox("Aviso","¿Desea borrar la materia seleccionada?",Question!,YesNo!,1) = 1 Then
	il_materia = dw_baja_materias.Getitemnumber(dw_baja_materias.Getrow(),'historico_cve_mat')
	dw_baja_materias.deleterow(dw_baja_materias.Getrow())
	triggerevent('ue_actualiza')
end if
end event

event ue_nuevo;call super::ue_nuevo;dw_baja_materias.Insertrow(0)
end event

type st_sistema from w_master_main`st_sistema within w_baja_materias_2013
end type

type p_ibero from w_master_main`p_ibero within w_baja_materias_2013
end type

type uo_nombre from uo_carreras_alumno_lista within w_baja_materias_2013
integer x = 37
integer y = 308
integer width = 3241
integer height = 516
integer taborder = 40
end type

on uo_nombre.destroy
call uo_carreras_alumno_lista::destroy
end on

event constructor;call super::constructor;m_menu_general_2013.objeto = this
end event

type dw_baja_materias from uo_master_dw within w_baja_materias_2013
integer x = 37
integer y = 840
integer width = 3621
integer height = 1592
integer taborder = 0
string dataobject = "dw_baja_materias_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this
end event

event itemchanged;// Juan Campos Sánchez. 		Enero-1998.

Long	ll_materia
string ls_materia
AcceptText()

IF dwo.name = "historico_cve_mat" Then
	ll_materia = long(data)
	if retrieve(il_cuenta,il_carrera,il_cve_plan,ll_materia) = 0 then
		MessageBox("Aviso","Está materia no está acreditada")
		parent.postevent('ue_nuevo')
	else
		idwc_calif.Retrieve(ll_materia)
		Selectrow(row,FALSE)
		Selectrow(row,true)
	end if
end if

end event

