$PBExportHeader$w_alta_materias_2013.srw
forward
global type w_alta_materias_2013 from w_master_main
end type
type dw_alta_materias from uo_master_dw within w_alta_materias_2013
end type
type uo_nombre from uo_carreras_alumno_lista within w_alta_materias_2013
end type
end forward

global type w_alta_materias_2013 from w_master_main
integer width = 3776
integer height = 2684
string title = "Alta de Materias"
string menuname = "m_menu_general_2013"
boolean maxbox = false
boolean clientedge = true
dw_alta_materias dw_alta_materias
uo_nombre uo_nombre
end type
global w_alta_materias_2013 w_alta_materias_2013

type variables
long il_carrera,il_cuenta,il_cve_plan,il_periodo,il_anio
datawindowchild idwc_calif
Datawindowchild dwc_periodo
end variables

forward prototypes
public function integer wf_validar ()
end prototypes

public function integer wf_validar ();dwItemStatus l_status
int li_i,li_periodo,li_anio
string ls_gpo, ls_calificacion,ls_periodo
long ll_materia,ll_cuenta
INTEGER le_existe 

idw_trabajo.Accepttext()
l_status = idw_trabajo.GetItemStatus(1, 0, Primary!)

//historico_calificacion
for li_i = 1 to idw_trabajo.Rowcount()
	l_status = idw_trabajo.GetItemStatus(li_i, 'historico_calificacion', Primary!)
	if l_status <> NotModified!	then
		ls_gpo = idw_trabajo.GetItemString(li_i,"historico_gpo")
		ll_materia = idw_trabajo.GetItemNumber(li_i,"historico_cve_mat")
		ls_calificacion = idw_trabajo.GetItemString(li_i,"historico_calificacion")
		if isnull(ll_materia) and isnull(ls_calificacion) then
			messagebox('Aviso','Falta capturar la Materia y/o Calificación')
			return -1
		end if
		li_anio = idw_trabajo.GetItemNumber(li_i,"anio")
		if li_anio < il_anio then
			messagebox('Aviso','El año capturado no puede ser menor a: ' + string(il_anio))
			return -1
		end if
		li_periodo = idw_trabajo.GetItemNumber(li_i,"historico_periodo")
		if li_periodo < il_periodo and  li_anio <= il_anio then
//			choose case il_periodo
//			case 0
//				ls_periodo = 'PRIMAVERA'
//			case 1
//				ls_periodo = 'VERANO'
//			case 2
//				ls_periodo = 'OTOÑO'
//			end choose
			
			SELECT descripcion
			INTO :ls_periodo
			FROM periodo
			WHERE periodo = :il_periodo
			USING gtr_sce; 
			IF ISNULL(ls_periodo)	 THEN ls_periodo = "" 


			messagebox('Aviso','El periodo capturado no puede ser menor a: ' + ls_periodo)
			return -1
		end if
		
		If  Existe_Mat_Acreditada(il_cuenta,ll_materia,il_carrera,il_cve_plan) Then 	
			Messagebox("Aviso","Está materia ya existe en el histórico del alumno")
			return -1
		end if 
		
		// SE ELIMINA ESTA VALIDACIÓN, este cambio solo aplica para TIJUANA, en CDMX NO SE INSERTA SS POR ESTA VENTANA 
//		if Not f_valida_sem_tit_opc_term(il_cuenta,ll_materia,il_carrera,il_cve_plan) Then 		
//			Messagebox("Aviso","Falta cursar el seminario de titulación~rEs necesario insertar el seminario de ~ntitulación antes de la opcion terminal")					
//			return -1
//		end if
		
		le_existe = 0
		SELECT COUNT(*)
		INTO :le_existe 
		FROM materias_requisito 
		WHERE id_prerrequisito = 'ING'
		AND cve_mat = :ll_materia 
		USING gtr_sce;
		
		//If ll_materia = 4078 Then    // actualiza bandera prerreq. ingles
		IF le_existe > 0 THEN 
			If Not Act_Bandera_Prerreq_Ingles(ll_cuenta,ls_calificacion) then
		 		Messagebox("Atención","La bandera de Prerrequisito de ingles NO se actualizo") 	
				 Return -1
			End If
		End IF
	else
		messagebox('Aviso','Favor de capturar datos de la materia')
		return -1
	end if
end for
end function

on w_alta_materias_2013.create
int iCurrent
call super::create
if this.MenuName = "m_menu_general_2013" then this.MenuID = create m_menu_general_2013
this.dw_alta_materias=create dw_alta_materias
this.uo_nombre=create uo_nombre
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_alta_materias
this.Control[iCurrent+2]=this.uo_nombre
end on

on w_alta_materias_2013.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_alta_materias)
destroy(this.uo_nombre)
end on

event closequery;//
end event

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta())
il_carrera = uo_nombre.istr_carrera.str_cve_carrera
il_cve_plan = uo_nombre.istr_carrera.str_cve_plan
il_periodo = uo_nombre.istr_carrera.str_periodo_ing
il_anio = uo_nombre.istr_carrera.str_anio_ing

if il_carrera = 0 then return

dw_alta_materias.Reset()

triggerevent('ue_nuevo')

end event

event open;call super::open;dw_alta_materias.settransobject(gtr_sce)

uo_nombre.em_cuenta.text = " "

dw_alta_materias.Getchild('historico_calificacion',idwc_calif)
idwc_calif.settransobject(gtr_sce)

//triggerevent(doubleclicked!)
/**/gnv_app.inv_security.of_SetSecurity(this)

//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
f_dddw_converter(dw_alta_materias, dwc_periodo, "historico_periodo")

//**--**--****--**--****--**--****--**--****--**--****--**--****--**--****--**--**
//**--**--****--**--****--**--****--**--****--**--****--**--****--**--****--**--**
//uo_periodo_servicios luo_periodo_servicios
//luo_periodo_servicios = CREATE uo_periodo_servicios 
//luo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)
//luo_periodo_servicios.f_modifica_lista_columna( dw_alta_materias, "historico_periodo", "L")
//**--**--****--**--****--**--****--**--****--**--****--**--****--**--****--**--**
//**--**--****--**--****--**--****--**--****--**--****--**--****--**--****--**--**
end event

event activate;call super::activate;control_escolar.toolbarsheettitle="Alta de materias"
end event

event ue_actualiza;call super::ue_actualiza;int li_res

li_res = wf_validar ()
if li_res = -1 then
	rollback using gtr_sce;
	messagebox("Información","No se han guardado los cambios")	
	return
end if

If dw_alta_materias.Update(True,True) = 1 Then
     Commit Using gtr_sce; 
	messagebox("Información","Se han guardado los cambios")					
     If Not actualiza_bandera(il_Cuenta,0) then
     	Messagebox("Aviso","Los catálogos Bloqueos, NO SE ACTUALIZARON ~rRevisar  Banderas de bloqueos del alumno")
     End if		  
	triggerevent(doubleclicked!)
Else
	Rollback Using gtr_sce;
	Messagebox("Algunos datos son incorrectos","Los cambios no fueron guardados")
End IF

end event

event ue_nuevo;call super::ue_nuevo;long ll_ren

ll_ren = dw_alta_materias.Insertrow(0)
dw_alta_materias.Setitem(ll_ren,'cuenta',il_cuenta)
dw_alta_materias.Setitem(ll_ren,'cve_carrera',il_carrera)
dw_alta_materias.Setitem(ll_ren,'cve_plan',il_cve_plan)
end event

event ue_borra;call super::ue_borra;dw_alta_materias.deleterow(dw_alta_materias.Getrow())
end event

type st_sistema from w_master_main`st_sistema within w_alta_materias_2013
end type

type p_ibero from w_master_main`p_ibero within w_alta_materias_2013
end type

type dw_alta_materias from uo_master_dw within w_alta_materias_2013
integer x = 37
integer y = 840
integer width = 3621
integer height = 1592
integer taborder = 0
string dataobject = "dw_alta_materias_2013"
boolean hscrollbar = false
boolean resizable = true
end type

event constructor;call super::constructor;idw_trabajo = this
m_menu_general_2013.dw = this
end event

event itemchanged;// Juan Campos Sánchez. 		Enero-1998.

Long	ll_materia,ll_anio
string ls_materia,ls_periodo

IF dwo.name = "historico_cve_mat" Then
	ll_materia = long(data)

	IF NOT sersoc_opcterm(data) THEN
	    	SELECT materia 
		INTO :ls_materia
   	 	FROM materias 
		WHERE cve_mat = :ll_materia 
		USING gtr_sce;
		
		IF gtr_sce.sqlcode = -1 THEN
			Messagebox("Aviso","Error al leer la tabla de materias ~r" +gtr_sce.SQLErrText)			                                                			
			Setitem(row,"materias_materia",'')
		ELSE
			IF gtr_sce.sqlcode = 0 THEN
				Setitem(row,"materias_materia",ls_materia)
				idwc_calif.Retrieve(ll_materia)
				
				IF Pertenece_Plan_estudios(ll_materia,il_carrera,il_cve_plan) or ll_materia = 4078 THEN
					IF Existe_Mat_Acreditada(il_cuenta,ll_materia,il_carrera,il_cve_plan) THEN 
						MessageBox("Aviso","Está materia ya está acreditada")
						Setitem(row,"materias_materia",'')
					END IF
				ELSE
					//MessageBox("Aviso","Está materia no pertenece al plan de estudios") 
					If MessageBox("Está materia no pertenece al plan de estudios","Aun desea continuar",Question!,YesNo!,2) = 2 Then 
						Setitem(row,"materias_materia",'')
					END IF
				END IF
			ELSE
				MessageBox("Aviso","La materia que se desea consultar no existe") 
				Setitem(row,"materias_materia",'')
			END IF
		END IF
	END IF
	
	DATAWINDOWCHILD ldwc_calif
	THIS.GETCHILD("historico_calificacion", ldwc_calif) 
	ldwc_calif.SETTRANSOBJECT(gtr_sce) 
	ldwc_calif.RETRIEVE(LONG(data))
	
	
END IF

IF dwo.name = "historico_gpo" Then
	If not Grupo_Valido(data) Then
		MessageBox("Aviso","Grupo Invalido, ~rGrupos validos, [A a la Z] , [AN a la ZN], Donde N = 1 al 9")	
		//Return 1
	End If
end if
//IF dwo.name = "historico_periodo" Then	
//	ll_anio = Getitemnumber(row,'anio')
//	if ll_anio > 0 then
//		if long(data) < il_periodo and Getitemnumber(row,'anio') < il_anio then
//			choose case  il_periodo
//			case 0
//				ls_periodo = 'PRIMAVERA'
//			case 1
//				ls_periodo = 'VERANO'
//			case 2
//				ls_periodo = 'OTOÑO'
//			end choose
//		
//			messagebox('Aviso','El periodo no puede ser menor al periodo de ingreso: ' + ls_periodo)
//			return 1
//		end if
//	else
//		if long(data) < il_periodo  then
//			choose case  il_periodo
//			case 0
//				ls_periodo = 'PRIMAVERA'
//			case 1
//				ls_periodo = 'VERANO'
//			case 2
//				ls_periodo = 'OTOÑO'
//			end choose
//		
//			messagebox('Aviso','El periodo no puede ser menor al periodo de ingreso: ' + ls_periodo)
//			return 1
//		end if
//	end if
//end if
//IF dwo.name = "anio" Then
//	if long(data) < il_anio then
//		MEssagebox('Aviso','El año no debe ser menor al año de ingreso: ' + data)
//      	Return 1  //rechaza el valor y no deja cambiar de focus
//	end if		
//end if
IF dwo.name = "historico_calificacion" Then
	ll_materia = Getitemnumber(row,"historico_cve_mat")
	If not tipo_evaluacion_2013(ll_materia,data) Then 	
		Return 1
	End If
//	SetColumn("historico_observacion")
end if
end event

event itemfocuschanged;//
end event

event itemerror;//
end event

type uo_nombre from uo_carreras_alumno_lista within w_alta_materias_2013
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

