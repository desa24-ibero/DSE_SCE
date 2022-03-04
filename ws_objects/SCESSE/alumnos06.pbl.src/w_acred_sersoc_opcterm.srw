$PBExportHeader$w_acred_sersoc_opcterm.srw
$PBExportComments$Se realizan los procesos de acreditación:  servicio social y opción terminal.  Juan Campos .  Marzo-1997.
forward
global type w_acred_sersoc_opcterm from window
end type
type sle_califaux from singlelineedit within w_acred_sersoc_opcterm
end type
type sle_usuario from singlelineedit within w_acred_sersoc_opcterm
end type
type dw_carrera_plan_nivel from datawindow within w_acred_sersoc_opcterm
end type
type dw_acred_sersoc_opcterm from datawindow within w_acred_sersoc_opcterm
end type
type uo_nombre from uo_nombre_alumno within w_acred_sersoc_opcterm
end type
type rr_1 from roundrectangle within w_acred_sersoc_opcterm
end type
end forward

shared variables
boolean juan 
end variables

global type w_acred_sersoc_opcterm from window
integer x = 5
integer y = 4
integer width = 3406
integer height = 1708
boolean titlebar = true
string title = "ACREDITACIÓN"
string menuname = "m_acreditacion_altasbajascambios"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 27291696
sle_califaux sle_califaux
sle_usuario sle_usuario
dw_carrera_plan_nivel dw_carrera_plan_nivel
dw_acred_sersoc_opcterm dw_acred_sersoc_opcterm
uo_nombre uo_nombre
rr_1 rr_1
end type
global w_acred_sersoc_opcterm w_acred_sersoc_opcterm

type variables
boolean cap_grupo = false
boolean cap_anio = False
boolean cap_modifica_periodo = false
boolean elige_menu_opcterm = false
Integer   Renglon
end variables

on w_acred_sersoc_opcterm.create
if this.MenuName = "m_acreditacion_altasbajascambios" then this.MenuID = create m_acreditacion_altasbajascambios
this.sle_califaux=create sle_califaux
this.sle_usuario=create sle_usuario
this.dw_carrera_plan_nivel=create dw_carrera_plan_nivel
this.dw_acred_sersoc_opcterm=create dw_acred_sersoc_opcterm
this.uo_nombre=create uo_nombre
this.rr_1=create rr_1
this.Control[]={this.sle_califaux,&
this.sle_usuario,&
this.dw_carrera_plan_nivel,&
this.dw_acred_sersoc_opcterm,&
this.uo_nombre,&
this.rr_1}
end on

on w_acred_sersoc_opcterm.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.sle_califaux)
destroy(this.sle_usuario)
destroy(this.dw_carrera_plan_nivel)
destroy(this.dw_acred_sersoc_opcterm)
destroy(this.uo_nombre)
destroy(this.rr_1)
end on

event open;// Se determina que menu fue el que llamo a esta ventana, para determinar que 
// objetos quedan visibles y que proceso se ejecuta.
// Juan Campos. Febrero-1997.

String  	NombreUsuario, Parametro 
Boolean EstaRegistrado

//g_nv_security.fnv_secure_window (this)

Parametro = Message.StringParm 

this.x = 1
this.y = 1

dw_acred_sersoc_opcterm.SetTransObject(gtr_sce)
dw_carrera_plan_nivel.SetTransObject(gtr_sce)

NombreUsuario = gtr_sce.logid
IF NombreUsuario = "" THEN
	MessageBox("Error","No hay un nombre de usuario registrado")	
	Close(w_acred_sersoc_opcterm)
Else
 	w_acred_sersoc_opcterm.uo_nombre.em_cuenta.Setfocus()
  	sle_usuario.text = NombreUsuario
  	w_acred_sersoc_opcterm.sle_usuario.enabled = false
  	w_acred_sersoc_opcterm.sle_usuario.visible = false
  	w_acred_sersoc_opcterm.sle_califaux.enabled = false
  	w_acred_sersoc_opcterm.sle_califaux.visible = false
  	dw_acred_sersoc_opcterm.enabled = False
  	dw_acred_sersoc_opcterm.visible = False
  	m_acreditacion_altasbajascambios.m_altas.enabled = False
  	m_acreditacion_altasbajascambios.m_bajas.enabled = False
  	m_acreditacion_altasbajascambios.m_cambios.enabled = False
End if
  
If Parametro = "AC_SERVICIO_SOCIAL" Then
 	w_acred_sersoc_opcterm.title = "ACREDITACIÓN SERVICIO SOCIAL"	 
  
End If     

If Parametro = "AC_OPCION_TERMINAL" Then
 	w_acred_sersoc_opcterm.title = "ACREDITACIÓN OPCIÓN TERMINAL"	 
End If     

If Parametro = "AC_PRERREQ_INGLES" Then
 	w_acred_sersoc_opcterm.title = "ACREDITACIÓN PRERREQUISITO DE INGLÉS"	 
End If     




end event

event doubleclicked;// Es importante que el nombre del titulo de la  ventana se llame siempre igual.
// Si se requiere cambiar por otro nombre, revise siempre los scripts de los objetos 
// relacionados ya que dependiendo de este nombre se ejecutan diferentes procesos.
// Juan Campos. Febrero-1997. 

String  	Cuenta, Nivel
Long 	Plan, Materia, Carrera,Modifica_Periodo
Long 	CveOpcterm = 0,CveSemTit = 0,CveProyOpcTerm = 0
Boolean TieneCarreaPlan

Cuenta = w_acred_sersoc_opcterm.uo_nombre.em_cuenta.text

if long(cuenta) > 0 Then  
	If w_acred_sersoc_opcterm.dw_carrera_plan_nivel.Retrieve(Long(Cuenta))  = 0 Then
  		MessageBox("Aviso","El alumno no tiene un catalogo de académicos") 
  		TieneCarreaPlan  = False
	Else
  		Plan		= w_acred_sersoc_opcterm.dw_carrera_plan_nivel.GetitemNumber(1,"academicos_cve_plan") 
  		Carrera	= w_acred_sersoc_opcterm.dw_carrera_plan_nivel.GetitemNumber(1,"academicos_cve_carrera") 
  		Nivel		= w_acred_sersoc_opcterm.dw_carrera_plan_nivel.GetitemString(1,"academicos_nivel")	  
  		TieneCarreaPlan  = True
	End if
 
	If w_acred_sersoc_opcterm.title = "ACREDITACIÓN SERVICIO SOCIAL" Then // Inicio Acreditación Servicio Social
  		If TieneCarreaPlan Then  // tienecarreraplan	 
    			If Nivel = "L" Then // Nivel
      			If Plan = 1 or Plan = 2 Then
        				Materia = 3748   
      			ElseIF Plan = 3 Or Plan = 4 Or Plan = 6 Then
		      		Materia = 8763 
	       		Else
            			MessageBox("Aviso","Revise el plan de estudios de este alumno")							 
			   		Return
     				End if
	   			if w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.Retrieve(Long(Cuenta),Materia) = 0 Then
		  			Messagebox("Aviso","El alumno no tiene la materia de servicio social")
		  			dw_acred_sersoc_opcterm.enabled = False
        				dw_acred_sersoc_opcterm.visible = False
		  			Return
	   			Else
		  			dw_acred_sersoc_opcterm.enabled = True
        			dw_acred_sersoc_opcterm.visible = True
		  			dw_acred_sersoc_opcterm.setfocus()
		  			Modifica_Periodo = MessageBox("Aviso","Desea Modificar el periodo",Question!,YesNo!,2)
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cuenta",Long(Cuenta))
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_mat",Materia) 
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_plan",Plan) 
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_carrera",Carrera)      
		  			sle_califaux.text = w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.GetitemString(1,8)
		  			dw_acred_sersoc_opcterm.SetTabOrder(1,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(2,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(3,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(6,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(7,0)
	     			dw_acred_sersoc_opcterm.SetTabOrder(9,0)					
					IF  ModIFica_Periodo = 1 Then 
						cap_modIFica_periodo = True
						dw_acred_sersoc_opcterm.SetTabOrder(4,1)
						dw_acred_sersoc_opcterm.SetTabOrder(5,2)
						dw_acred_sersoc_opcterm.SetTabOrder(8,3)   
//						SetColumn(4) 	  
					Else
						cap_modIFica_periodo = False
						dw_acred_sersoc_opcterm.SetTabOrder(4,0)
						dw_acred_sersoc_opcterm.SetTabOrder(5,0)
						dw_acred_sersoc_opcterm.SetTabOrder(8,1)
//						SetColumn(8) 
					End IF 							  
      		End If // tiene materia servicio social
			Else
	  			Messagebox("Error","Solo alumnos de licenciatura")
	  			dw_acred_sersoc_opcterm.Retrieve(0,0)
	  			Return
			End If // Nivel
  		Else
	 		Return
  		End If // tieneCarreraplan
	End If // acreditación servicio social

	If w_acred_sersoc_opcterm.title = "ACREDITACIÓN OPCIÓN TERMINAL" Then // Inicio Acreditación Opción terminal
  		If TieneCarreaPlan Then  // TieneCarreraPlan	 
    		If obten_cve_opcion_terminal(Carrera,Plan,CveOpcterm,CveSemTit,CveProyOpcTerm) Then
				If prerrequisito_opcterm(Long(Cuenta),CveSemTit,CveProyOpcTerm) Then					
		  			dw_acred_sersoc_opcterm.enabled = true
        				dw_acred_sersoc_opcterm.visible = true
		  			If w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.Retrieve(Long(Cuenta),CveOpcterm) = 0 Then		 
			 			elige_menu_opcterm = True // m_altas visible = true
		    				m_acreditacion_altasbajascambios.m_bajas.enabled = False
		    				m_acreditacion_altasbajascambios.m_cambios.enabled = False
		    				m_acreditacion_altasbajascambios.m_altas.enabled = True
          				dw_acred_sersoc_opcterm.InsertRow(0)
	     			Else	
    		 				elige_menu_opcterm = false // m_bajas,m_cambios visible = true
		    				m_acreditacion_altasbajascambios.m_altas.enabled = False
		  	 			m_acreditacion_altasbajascambios.m_bajas.enabled = True
		    				m_acreditacion_altasbajascambios.m_cambios.enabled = True
        				End IF // retrieve data window 
		  			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cuenta",Long(Cuenta))
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_mat",CveOpcterm) 
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_plan",Plan) 
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_carrera",Carrera)      
		  			dw_acred_sersoc_opcterm.SetTabOrder(1,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(2,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(3,1)
		  			dw_acred_sersoc_opcterm.SetTabOrder(4,2)
		  			dw_acred_sersoc_opcterm.SetTabOrder(5,3)
	     			dw_acred_sersoc_opcterm.SetTabOrder(6,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(7,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(8,4)
		  			dw_acred_sersoc_opcterm.setfocus()
		  			dw_acred_sersoc_opcterm.SetColumn(3) 
	   		Else	
		  			MessageBox("Error","El alumno no cumple con los prerrequisitos de: "+String(CveSemTit)+" "+String(CveProyOpcTerm)+" "+ "para acreditar La opción Terminal")
				End IF // prerrequisito_opcterm
	 		Else
				Messagebox("Error","Revisé que el plan de estudios de esté alumno tenga cargada la:  cve_area_opción terminal, ")
				MessageBox("Importante","El catalógo Aux_Opcion_terminal , contiene las materias que son prerrequsito para acreditar la materia de opción_terminal, verifique que se encuentren cargadas")	
		 	End If // Obten cve_opc_terminal
  		End if // tienecarreraplan	 
	End If // Fin Acreditación Opción terminal


	If w_acred_sersoc_opcterm.title = "ACREDITACIÓN PRERREQUISITO DE INGLÉS" Then // Inicio Acreditación del Prerrequisito de Inglés
  		If TieneCarreaPlan Then  // tienecarreraplan	 
    			If Nivel = "L" Then // Nivel
      			Materia = 4078         			
	   			if w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.Retrieve(Long(Cuenta),Materia) = 0 Then
		  				Messagebox("Aviso","El alumno no tiene la materia del Prerrequisito de Inglés")
	        			dw_acred_sersoc_opcterm.InsertRow(0)						
					End if

	  	 			m_acreditacion_altasbajascambios.m_bajas.enabled = True
	    			m_acreditacion_altasbajascambios.m_cambios.enabled = True	   			
		  			dw_acred_sersoc_opcterm.enabled = true
     				dw_acred_sersoc_opcterm.visible = true
		  			dw_acred_sersoc_opcterm.enabled = True
        			dw_acred_sersoc_opcterm.visible = True
		  			dw_acred_sersoc_opcterm.setfocus()
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cuenta",Long(Cuenta))
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_mat",Materia) 
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_plan",Plan) 
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"cve_carrera",Carrera)      
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"gpo","Z")      
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"calificacion","AC")      
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"periodo",gi_periodo)      
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"anio",gi_anio)      
	     			w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.SetItem(1,"observacion",3) //Ordinario     
		  			Modifica_Periodo = MessageBox("Aviso","Desea Modificar el periodo",Question!,YesNo!,2)
		  			sle_califaux.text = w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.GetitemString(1,8)
		  			dw_acred_sersoc_opcterm.SetTabOrder(1,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(2,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(3,1)
		  			dw_acred_sersoc_opcterm.SetTabOrder(4,2)
		  			dw_acred_sersoc_opcterm.SetTabOrder(5,3)
	     			dw_acred_sersoc_opcterm.SetTabOrder(6,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(7,0)
		  			dw_acred_sersoc_opcterm.SetTabOrder(8,4)
					IF  ModIFica_Periodo = 1 Then 
						cap_modIFica_periodo = True
						dw_acred_sersoc_opcterm.SetTabOrder(4,1)
						dw_acred_sersoc_opcterm.SetTabOrder(5,2)
						dw_acred_sersoc_opcterm.SetTabOrder(8,3)   
//						SetColumn(4) 	  
					Else
						cap_modIFica_periodo = False
						dw_acred_sersoc_opcterm.SetTabOrder(4,0)
						dw_acred_sersoc_opcterm.SetTabOrder(5,0)
						dw_acred_sersoc_opcterm.SetTabOrder(8,1)
//						SetColumn(8) 
					End IF 							  
      		// tiene materia servicio social
 				Else
	  				Messagebox("Error","Solo alumnos de licenciatura")
	  				dw_acred_sersoc_opcterm.Retrieve(0,0)
	  				Return
				End If // Nivel
  		Else
	 		Return
  		End If // tieneCarreraplan
	End If // acreditación servicio social


end if

end event

event close;//close(this)
end event

type sle_califaux from singlelineedit within w_acred_sersoc_opcterm
integer x = 1202
integer y = 1708
integer width = 635
integer height = 112
integer taborder = 40
integer textsize = -11
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean autohscroll = false
end type

type sle_usuario from singlelineedit within w_acred_sersoc_opcterm
integer x = 343
integer y = 1680
integer width = 635
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean autohscroll = false
end type

type dw_carrera_plan_nivel from datawindow within w_acred_sersoc_opcterm
integer x = 224
integer y = 496
integer width = 2866
integer height = 116
integer taborder = 10
string dataobject = "dw_carrera_plan_nivel"
boolean border = false
boolean livescroll = true
end type

type dw_acred_sersoc_opcterm from datawindow within w_acred_sersoc_opcterm
event keyboard pbm_dwnkey
integer x = 315
integer y = 636
integer width = 2683
integer height = 764
integer taborder = 50
string dataobject = "dw_acred_sersoc_opcterm"
boolean vscrollbar = true
boolean resizable = true
boolean livescroll = true
end type

event keyboard;// Juan Campos.  Marzo-1997.

IF keydown(keytab!) then
	triggerevent(itemchanged!)
end if



end event

event itemchanged;// Valida los datos capturados.
// Juan Campos.  Marzo-1997.

Integer Año
String  Calificacion,grupo,columna

Columna = dw_acred_sersoc_opcterm.GetColumnname( )

if Columna = "gpo" Then
	if dw_acred_sersoc_opcterm.AcceptText( ) = 1 Then
		Grupo = w_acred_sersoc_opcterm.dw_acred_sersoc_opcterm.GetitemString(GetRow(),"gpo")	
		if grupo_valido(Grupo) Then
			cap_grupo = true
//			IF keydown(keytab!) then
//			   SetColumn("gpo")	
//			end if
//			IF keydown(keyenter!) then
//			  	SetColumn("periodo")
//			end if
			Return 0 // acepta el valor 
		Else
			cap_grupo = False
		  	Messagebox("Grupos Validos"," A a la Z,  AN a la ZN,  Donde N = 1 al 9")
//			setitem(GetRow(),"gpo","")
			Return 1 // rechaza el valor y no deja cambiar de focus
		end if
	Else
		Cap_grupo = False
//		setitem(GetRow(),"gpo","")
	  	Return 1 // rechaza el valor y no deja cambiar de focus
	end if	
end if

//if Columna = "periodo" then
//   	IF keydown(keytab!) then
//	   	SetColumn("periodo")	
//   	end if
//   	IF keydown(keyenter!) then
//	  	SetColumn("anio")
//   	end if
//end if
//
if Columna = "anio" Then  // año 
 	if dw_acred_sersoc_opcterm.AcceptText( ) = 1 Then
		if GetitemNumber(GetRow(),"anio") < 100 Then
			SetItem(GetRow(),"anio", GetitemNumber(GetRow(),"anio")+1900)
			AcceptText( )
		End if	
		if GetitemNumber(GetRow(),"anio") < 1950 Then 
         Return 1  //rechaza el valor y no deja cambiar de focus
		Else
 			Return 0 
		end if		
	else
		cap_anio = false
	   Return 1 // rechaza el valor y no deja cambiar de focus
   end if
End if


//if Columna = "calificacion" then
//	IF keydown(keytab!) then
//	 	SetColumn("calificacion")	
//   	end if
//   	IF keydown(keyenter!) then
//	  	SetColumn("observacion")
//   	end if
//end if
// 
//if Columna = "observacion" then
//	IF keydown(keytab!) then
//		SetColumn("observacion")	
//  	end if
//   	IF keydown(keyenter!) then
//	 	SetColumn("gpo")
//   	end if
//end if

If w_acred_sersoc_opcterm.title = "ACREDITACIÓN SERVICIO SOCIAL" Then
	m_acreditacion_altasbajascambios.m_bajas.enabled = False
	m_acreditacion_altasbajascambios.m_cambios.enabled = True
	m_acreditacion_altasbajascambios.m_altas.enabled = False
//
//	if not cap_grupo Then
//      	if cap_modifica_periodo then
//	      	m_acreditacion_altasbajascambios.m_cambios.enabled = true
//       	else
//	      	m_acreditacion_altasbajascambios.m_cambios.enabled = False
//      	End if
//   	else
//	   	m_acreditacion_altasbajascambios.m_cambios.enabled = False
//   	end if
end if

If w_acred_sersoc_opcterm.title = "ACREDITACIÓN OPCIÓN TERMINAL" Then
 	if cap_grupo and cap_anio then
		if elige_menu_opcterm  Then  // m_altas visible = true
	   		m_acreditacion_altasbajascambios.m_bajas.enabled = False
	   		m_acreditacion_altasbajascambios.m_cambios.enabled = False
	   		m_acreditacion_altasbajascambios.m_altas.enabled = True
   		Else	// m_bajas,m_cambios visible = true
	   		m_acreditacion_altasbajascambios.m_altas.enabled = False
	   		m_acreditacion_altasbajascambios.m_bajas.enabled = True
	   		m_acreditacion_altasbajascambios.m_cambios.enabled = True
		end if
	else
//		m_acreditacion_altasbajascambios.m_altas.enabled = False
//	   	m_acreditacion_altasbajascambios.m_bajas.enabled = False
//	   	m_acreditacion_altasbajascambios.m_cambios.enabled = False
   	end if
end if

end event

event rowfocuschanged;
IF keydown(keyenter!) then
	SetRow(GetRow()-1)
	SetRowFocusIndicator(Hand!)  
	ScrollToRow(GetRow()-1)  	
Else
	SetRow(GetRow())
	SetRowFocusIndicator(Hand!)  
	ScrollToRow(GetRow())  	
end if
 

end event

event getfocus;IF rowcount() > 0 Then
	SetRow(1)
	SetRowFocusIndicator(Hand!)  
	ScrollToRow(1)  
End IF
end event

type uo_nombre from uo_nombre_alumno within w_acred_sersoc_opcterm
integer x = 32
integer y = 36
integer width = 3241
integer height = 424
integer taborder = 20
boolean enabled = true
end type

on uo_nombre.destroy
call uo_nombre_alumno::destroy
end on

type rr_1 from roundrectangle within w_acred_sersoc_opcterm
long linecolor = 1086374080
integer linethickness = 4
long fillcolor = 10789024
integer x = 37
integer y = 468
integer width = 3250
integer height = 956
integer cornerheight = 44
integer cornerwidth = 41
end type

