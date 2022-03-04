$PBExportHeader$w_alta_materias.srw
forward
global type w_alta_materias from window
end type
type st_nombre_materia from statictext within w_alta_materias
end type
type dw_carrera_plan from datawindow within w_alta_materias
end type
type uo_nombre from uo_nombre_alumno within w_alta_materias
end type
type cb_alta_materia from commandbutton within w_alta_materias
end type
type dw_alta_materias from datawindow within w_alta_materias
end type
end forward

global type w_alta_materias from window
integer x = 22
integer y = 29
integer width = 3379
integer height = 1584
boolean titlebar = true
string title = "ALTA DE MATERIAS"
string menuname = "m_movimientos_historico"
boolean controlmenu = true
long backcolor = 27291696
boolean righttoleft = true
event reset ( )
st_nombre_materia st_nombre_materia
dw_carrera_plan dw_carrera_plan
uo_nombre uo_nombre
cb_alta_materia cb_alta_materia
dw_alta_materias dw_alta_materias
end type
global w_alta_materias w_alta_materias

type variables
Window EstaVentana
end variables

event reset;// Juan Campos Sánchez. Enero-1998

EstaVentana.SetRedraw(False)
dw_alta_materias.Reset()		
st_nombre_materia.text = ""
dw_alta_materias.InsertRow(0)
cb_alta_materia.Enabled = False
EstaVentana.SetRedraw(True)


end event

on w_alta_materias.create
if this.MenuName = "m_movimientos_historico" then this.MenuID = create m_movimientos_historico
this.st_nombre_materia=create st_nombre_materia
this.dw_carrera_plan=create dw_carrera_plan
this.uo_nombre=create uo_nombre
this.cb_alta_materia=create cb_alta_materia
this.dw_alta_materias=create dw_alta_materias
this.Control[]={this.st_nombre_materia,&
this.dw_carrera_plan,&
this.uo_nombre,&
this.cb_alta_materia,&
this.dw_alta_materias}
end on

on w_alta_materias.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_nombre_materia)
destroy(this.dw_carrera_plan)
destroy(this.uo_nombre)
destroy(this.cb_alta_materia)
destroy(this.dw_alta_materias)
end on

event open;// Alta de materias
// Versión 2.0 Mejorada
// Juan Campos Sánchez.    Enero-1997.

This.x=1
This.y=1

EstaVentana = This
dw_alta_materias.InsertRow(0)
dw_alta_materias.Enabled=False
cb_alta_materia.Enabled = False
uo_nombre.em_cuenta.SetFocus()
end event

event doubleclicked;// Juan Campos Sánchez.	Enero-1998.

Long  Cuenta

dw_carrera_plan.Reset()
This.TriggerEvent("Reset")
Cuenta = long(uo_nombre.em_cuenta.text)
IF cuenta = 0 Or dw_carrera_plan.Retrieve(Cuenta) = 0 Then
	MessageBox("Aviso","Este alumno no tiene un catálogo de datos académicos")
	cb_alta_materia.Enabled = False
	This.TriggerEvent("Reset")
Else
	dw_alta_materias.Enabled = True
	dw_alta_materias.Setfocus()
End If

 
end event

type st_nombre_materia from statictext within w_alta_materias
integer x = 1020
integer y = 704
integer width = 1858
integer height = 96
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
boolean border = true
borderstyle borderstyle = styleshadowbox!
boolean focusrectangle = false
end type

type dw_carrera_plan from datawindow within w_alta_materias
integer x = 40
integer y = 477
integer width = 2853
integer height = 163
string dataobject = "dw_carrera_plan"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_carrera_plan.settransobject(gtr_sce)
end event

type uo_nombre from uo_nombre_alumno within w_alta_materias
integer x = 40
integer y = 32
integer width = 3240
integer height = 426
integer taborder = 10
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type cb_alta_materia from commandbutton within w_alta_materias
event key pbm_keydown
integer x = 2944
integer y = 829
integer width = 377
integer height = 109
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Alta Materia"
end type

event key;if keydown(keyenter!) Then This.EVENT Clicked()
end event

event clicked;//	Se actualiza la tabla de histórico,academicos,Banderas.
//	Se calcula los Nuevos créditos y promedio.  
//	Juan Campos Sánchez.		Febrero-1997. 
//	Modificado					Enero-1998.

SetPointer(Hourglass!) 
long cuenta
long materia, carrera, plan
string calificacion

If MessageBox("Verifique que los datos sean correctos","Desea continuar",Question!,YesNo!,1) = 1 Then  
	Cuenta 	= Long(uo_nombre.em_cuenta.text)
	Materia	= dw_alta_materias.GetItemNumber(dw_alta_materias.GetRow(),"cve_mat")
	Calificacion= dw_alta_materias.GetItemString(dw_alta_materias.GetRow(),"calificacion")	
	Carrera =dw_carrera_plan.GetItemNumber(dw_carrera_plan.GetRow(),"academicos_cve_carrera")
	Plan = dw_carrera_plan.GetItemNumber(dw_carrera_plan.GetRow(),"academicos_cve_plan")
IF	Not IsNull(Materia) And Not IsNull(Calificacion) then
		If Not Existe_Mat_Acreditada(Cuenta,Materia,Carrera,Plan) Then 		
			if f_valida_sem_tit_opc_term(Cuenta,Materia,Carrera,Plan) Then 		
				dw_alta_materias.SetItem(dw_alta_materias.GetRow(),"cuenta",cuenta)
				dw_alta_materias.SetItem(dw_alta_materias.GetRow(),"cve_carrera",dw_carrera_plan.GetItemNumber(1,"academicos_cve_carrera"))
				dw_alta_materias.SetItem(dw_alta_materias.GetRow(),"cve_plan",dw_carrera_plan.GetItemNumber(1,"academicos_cve_plan"))
   	      If dw_alta_materias.Update(True,True) = 1 Then
						If Materia = 4078 Then 
							If Not act_bandera_prerreq_ingles(Cuenta,Calificacion) Then
								Rollback Using gtr_sce;
	        					Messagebox("La bandera de prerrequisito de ingles NO se actualizo","Los cambios No se guardaron", StopSign!)		  
							End if
						End If
   	            Commit Using gtr_sce; 
						Messagebox("Aviso","La materia fue dada de alta")					
		 		      If Not actualiza_bandera(Cuenta,0) then
	         	     	Messagebox("ATENCIÓN","Los catálogos Bloqueos, NO SE ACTUALIZARON")
	            	  	MessageBox("IMPORTANTE","Revisar  Banderas de bloqueos del alumno")
		            End if		    		  	
				Else
					Rollback Using gtr_sce;
					Messagebox("Ocurrio un error al insertar en histórico",gtr_sce.sqlerrtext+"~nLos cambios no se guardaron", StopSign!)	
				End IF
			Else
				Rollback Using gtr_sce;
				Messagebox("Falta cursar el seminario de titulación","Es necesario insertar el seminario de ~ntitulación antes de la opcion terminal", StopSign!)					
			End if
 		Else
			Rollback Using gtr_sce;
			Messagebox("Está materia ya existe en el histórico del alumno","Los cambios no se guardaron", StopSign!)	
		End IF
	Else
		Rollback Using gtr_sce;
		Messagebox("Algunos datos son incorrectos","Los cambios no se guardaron", StopSign!)
	End IF		
End IF  
cb_alta_materia.Enabled = False
w_alta_materias.TriggerEvent("Reset")
uo_nombre.em_cuenta.Setfocus()
 

end event

type dw_alta_materias from datawindow within w_alta_materias
integer x = 40
integer y = 666
integer width = 2853
integer height = 685
integer taborder = 20
string dataobject = "dw_alta_materias"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event constructor;dw_alta_materias.settransobject(gtr_sce)

end event

event itemchanged;// Juan Campos Sánchez. 		Enero-1998.

Long	Materia,Carrera,Plan
String nulo
long	Cuenta
Boolean Continua
AcceptText()
Materia = GetItemNumber(GetRow(),"cve_mat")
SetNull(nulo)
IF dwo.name = "cve_mat" Then
	cb_alta_materia.Enabled = False
	IF Not sersoc_opcterm(String(Materia)) Then 
    	Select materia Into :st_nombre_materia.text
      From  materias Where cve_mat = :Materia Using gtr_sce;
		IF gtr_sce.sqlcode = 0 Then
			Carrera =dw_carrera_plan.GetItemNumber(dw_carrera_plan.GetRow(),"academicos_cve_carrera")
			Plan = dw_carrera_plan.GetItemNumber(dw_carrera_plan.GetRow(),"academicos_cve_plan")
       	IF Pertenece_Plan_estudios(Materia,Carrera,Plan) or Materia = 4078 Then
				Continua = True
			Else
      		If MessageBox("Está materia no pertenece al plan de estudios","Aun desea continuar",Question!,YesNo!,2) = 1 Then 
					Continua = True
				Else	
					Continua = False
					w_alta_materias.TriggerEvent("Reset")	  
					setColumn("cve_mat")
       		End IF
			End IF
			 
			If Continua Then 
				Cuenta = long(uo_nombre.em_cuenta.text) 
				IF Not Existe_Mat_Acreditada(Cuenta,Materia,Carrera,Plan) Then 	
					cb_alta_materia.Enabled = True
					//Return 0
 				Else
 					MessageBox("Error","Está materia ya está acreditada")
					w_alta_materias.TriggerEvent("Reset")	  
					setColumn("cve_mat")
					return 1
				End IF
			End IF
		Else
			Messagebox("Error al leer la tabla de materias",gtr_sce.SQLErrText)			                                                			
			w_alta_materias.TriggerEvent("Reset")	  
			setColumn("cve_mat")
			return 1
		End IF
	Else
		w_alta_materias.TriggerEvent("Reset")	  
		setColumn("cve_mat")
		return 1
	End IF
	SetColumn("gpo")
	return 0
ElseIF dwo.name = "gpo" Then
	If Grupo_Valido(GetItemString(GetRow(),"gpo")) Then
		cb_alta_materia.Enabled = True
		//Return 0
	Else
		cb_alta_materia.Enabled = False
		Setitem(getrow(),"gpo",nulo)
		Return 1
	End If
	SetColumn("periodo")
	return 0
ElseIF dwo.name = "periodo" Then	
	SetColumn("anio")
	return 0
ElseIF dwo.name = "anio" Then
	If GetItemNumber(GetRow(),"anio") < 100 Then
		SetItem(GetRow(),"anio",1900+GetItemNumber(GetRow(),"anio"))
		This.Filter( ) 
		cb_alta_materia.Enabled = True
 	End If
	SetColumn("calificacion")
	return 0
ElseIF dwo.name = "calificacion" Then
	If tipo_evaluacion(Materia,GetItemString(GetRow(),"calificacion")) Then 	
		cb_alta_materia.Enabled = True
		//Return 0
   Else	
		cb_alta_materia.Enabled = False
		Setitem(getrow(),"calificacion",nulo)
		Return 1
  	End If
	SetColumn("observacion")
	return 0
ElseIF dwo.name = "observacion" Then
	if parent.cb_alta_materia.enabled = true then parent.cb_alta_materia.event clicked()
End IF

Accepttext()



	
	
	
	

end event

