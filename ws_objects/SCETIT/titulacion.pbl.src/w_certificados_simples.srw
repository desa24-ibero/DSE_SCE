$PBExportHeader$w_certificados_simples.srw
forward
global type w_certificados_simples from Window
end type
type st_1 from statictext within w_certificados_simples
end type
type vsb_dw_certificado from vscrollbar within w_certificados_simples
end type
type dw_1 from datawindow within w_certificados_simples
end type
type uo_nombre from uo_nombre_carrera_simple within w_certificados_simples
end type
end forward

global type w_certificados_simples from Window
int X=4
int Y=3
int Width=3584
int Height=1523
boolean TitleBar=true
string Title="Certificados Simples"
string MenuName="m_menu_certificado"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
vsb_dw_certificado vsb_dw_certificado
dw_1 dw_1
uo_nombre uo_nombre
end type
global w_certificados_simples w_certificados_simples

on w_certificados_simples.create
if this.MenuName = "m_menu_certificado" then this.MenuID = create m_menu_certificado
this.st_1=create st_1
this.vsb_dw_certificado=create vsb_dw_certificado
this.dw_1=create dw_1
this.uo_nombre=create uo_nombre
this.Control[]={this.st_1,&
this.vsb_dw_certificado,&
this.dw_1,&
this.uo_nombre}
end on

on w_certificados_simples.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.vsb_dw_certificado)
destroy(this.dw_1)
destroy(this.uo_nombre)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
dw_1.settransobject(gtr_sce)

/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1

/*Cambia el título de la barra de herramientas*/
//control_escolar.toolbarsheettitle="Control de Certificados"

/*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_menu_certificado.m_registro.m_nuevo.disable( )
m_menu_certificado.m_registro.m_actualiza.disable( )
m_menu_certificado.m_registro.m_borraregistro.disable( )
m_menu_certificado.m_registro.m_primero.disable ( )
m_menu_certificado.m_registro.m_ultimo.disable ( )
m_menu_certificado.m_registro.m_siguiente.disable ( )
m_menu_certificado.m_registro.m_anterior.disable ( )
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

event close;/*Cuando se cierre la ventana w_certificados...*/

/*Verifica si se deben actualizar datos en el DataWindow dw_1*/
w_certificados_simples.dw_1.event actualiza ( )

end event

type st_1 from statictext within w_certificados_simples
int X=973
int Y=35
int Width=750
int Height=77
boolean Enabled=false
string Text="0 para ver Listado Completo"
boolean FocusRectangle=false
long BackColor=12632256
long BorderColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type vsb_dw_certificado from vscrollbar within w_certificados_simples
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
int X=3456
int Y=669
int Width=73
int Height=659
boolean Enabled=false
boolean BringToTop=true
int MinPosition=1
int Position=1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_1.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if


end event

event lineup;/* En cuanto el usuario oprima la flecha-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event moved;// En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... 

// Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos 

// Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar 

//Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
//                          Var_Carrera=Se almacena la Carrera
//									 Var_Plan=Se almacena el Plan 

if dw_1.rowcount() > 0 then
	
int VarX
int Var_Carrera
int Var_Plan

// Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos 
maxposition=dw_1.RowCount()

// Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar 



//Se asignan valores a Var_Carrera y a Var_Plan 
Var_Carrera=dw_1.object.cve_carrera[scrollpos]
Var_Plan=dw_1.object.cve_plan[scrollpos]

//Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP 
SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera 
	AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;

//	 Se verifica que no sea nulo el valor traido 
	if isnull(VarX) then
			messagebox("!!! Aviso !!!",&
		"La Tabla de Plan de Estudios NO esta actualizada,"+&
		"se tomara como estudio no incorporado a la SEP, "+&
		"Favor de consultar al Administrador de la Base de Datos",Exclamation!)

		dw_1.object.no_sep.visible=TRUE
else
		if VarX = 1 then
//			Esta carrera y plan SI estan validados por la SEP 
			dw_1.object.st_incorporado.visible=FALSE
   	else
//			Esta carrera y plan NO estan validados por la SEP 
			dw_1.object.st_incorporado.visible=TRUE
		end if	
	end if
	
	dw_1.ScrollToRow(scrollpos)
else
	visible =FALSE
end if


end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_1.RowCount() then
	/* Si no lo estoy mueve el scroll bar una posición más */
	position=position+1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event pageup;/* En cuanto el usuario oprima la página-arriba del ScrollBar... */

/* Verifica que no esté al inicio de los renglones del DataWindow */
if position>1 then
	/* Si no lo estoy mueve el scroll bar una posición menos */
	position=position -1
	/* Genera el evento moved con la nueva posición */
	EVENT moved(position)
end if
end event

event constructor;visible=FALSE
end event

type dw_1 from datawindow within w_certificados_simples
event type integer carga ( string cuenta,  string carrera,  string cve_plan )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
event anterior ( )
event siguiente ( )
event ultimo ( )
event primero ( )
int X=4
int Y=669
int Width=3441
int Height=659
int TabOrder=20
string DataObject="dw_certificados_simples"
end type

event carga;/*Cuando se activa el evento carga...*/

/*Ve si nos hay cambios que no se hayan guardado*/
event actualiza()

/*Haz un retrive con los parámetros que le pasaron, y ve si realmente se bajaron datos.*/
If retrieve(long(cuenta),long(carrera),long(cve_plan))=0 &
   then
		//enabled=false
		return 0
	else
		/*Si se bajaron datos, pon el foco dentro del DataWindow*/
		//enabled=true
		SetFocus()
		return 1
end if
end event

event borra_renglon;/*Cuando se activa el evonto borra_renglon...*/

/*Pregunta para verificar que realmente se desea borrar el renglón*/
int respuesta
respuesta = messagebox("Atención","Esta seguro de querer borrar el campo actual.",StopSign!,YesNo!,2)

if respuesta = 1 then
	/*Si realmente se desea borrar, borra el renglón actual y verifica que se haya logrado*/
	if deleterow(getrow())	= 1 then
		/*Si se borro, llama a actualiza*/
		event actualiza()
	else
		/*De lo contrario avisa que no se pudo borrar el renglón*/
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif respuesta = 2 then
	/*Si no se quiere borrar el renglón, desecha los cambios hechos.*/
	rollback using gtr_sce;
end if

end event

event actualiza;/*Cuando se dispara el evento actualiza...*/

/*Si es asi, acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if dw_1.ModifiedCount()+dw_1.DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	int respuesta
	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if respuesta = 1 &
		then
			
			/*Checa que los renglones cumplan con las reglas de validación*/
			if update(true) = 1 then		
				/*Si es asi, guardalo en la tabla y avisa.*/
				commit using gtr_sce;
				messagebox("Información","Se han guardado los cambios")			
			else
				/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using gtr_sce;
				messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if	
end if	
end event

event nuevo;//Cuando se activa el evento nuevo... 

//Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
//                            Var_Carrera=Se almacena la Carrera
//									 Var_Plan=Se almacena el Plan  

int VarX
int Var_Carrera
int Var_Plan




//enabled=true
visible=true
//Pon el foco dentro del DataWindow 
SetFocus()
//Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él 
scrolltorow(insertrow(0))

//Modifica la columna fecha_inicio del renglón nuevo para que tenga la fecha de hoy  
Object.fecha_inicio[RowCount()]=Today()
Object.legalizado[RowCount()]=0
Object.checado_sep[RowCount()]=0
Object.num_veces_sep[RowCount()]=0

//Object.fecha_entrada_sep[RowCount()]=1900-01-01
//Object.fecha_salida_tentat_sep[RowCount()]=1900-01-01
//Object.fecha_salida_sep[RowCount()]=1900-01-01
//Object.fecha_checado_sep[RowCount()]=1900-01-01
//Object.fecha_envio_plantel[RowCount()]=1900-01-01

//Modifica la columna cuenta para que tenga el texto del número de cuenta (que se encuentra 
//	        dentro del objeto uo_nombre en un EditMask llamado em_cuenta) 

Object.cuenta[RowCount()]=long(parent.uo_nombre.em_cuenta.Text)

//Verifica el estado del RadioButton rb_actual dentro del objeto uo_nombre 
if parent.uo_nombre.rb_actual.checked then
//Si esta checado, modifica la columna cve_carrera para que tenga el mismo valor que la
//		columna academicos_cve_carrera del DataWindow dw_nombre que esta en el objeto uo_nombre
//		(Puede ser de cualquier renglón ya que la carrera actual es la misma) 
	Object.cve_carrera[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_carrera[1]
	Object.cve_plan[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_plan[1]
// Se asignan valores a Var_Carrera y a Var_Plan  
	Var_Carrera=parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_carrera[1]
	Var_Plan=parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_plan[1]

// Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP  
	SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;
// Se verifica que no sea nulo el valor traido  
	if isnull(VarX) then
		messagebox("!!! Aviso !!!",&
		"La Tabla de Plan de Estudios NO esta actualizada,"+&
		"se tomara como estudio no incorporado a la SEP, "+&
		"Favor de consultar al Administrador de la Base de Datos",Exclamation!)
		dw_1.object.st_incorporado.visible=TRUE
	else  
		if VarX = 1 then      
			//Esta carrera y plan SI estan validados por la SEP  
			dw_1.object.st_incorporado.visible=FALSE
		else
			//Esta carrera y plan NO estan validados por la SEP  
			dw_1.object.st_incorporado.visible=TRUE
		end if	
	end if
else
//De lo contrario, modifica la columna cve_carrera para que tenga el mismo valor que la
//		columna hist_carreras_cve_carrera del DataWindow dw_nombre que esta en el objeto uo_nombre
//		(Debe ser del renglón actual ya que varía si se tiene un largo histrorial de carreras) 
	Object.cve_carrera[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_carrera_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
	Object.cve_plan[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_plan_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
	Var_Carrera=parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_carrera_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
	Var_Plan=parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_plan_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]

// Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP  
	SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;
// Se verifica que no sea nulo el valor traido  
	if isnull(VarX) then
		messagebox("!!! Aviso !!!",&
		"La Tabla de Plan de Estudios NO esta actualizada,"+&
		"se tomara como estudio no incorporado a la SEP, "+&
		"Favor de consultar al Administrador de la Base de Datos",Exclamation!)
		dw_1.object.st_incorporado.visible=TRUE
	else  
		if VarX = 1 then      
			//Esta carrera y plan SI estan validados por la SEP  
			dw_1.object.st_incorporado.visible=FALSE
		else
			//Esta carrera y plan NO estan validados por la SEP  
			dw_1.object.st_incorporado.visible=TRUE
		end if	
	end if
end if


end event

event botonazo;IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=13 then
			setcolumn(1)
			SetFocus()
			return -1
		end if
	END IF
END IF

IF keyflags  = 0 THEN
	IF key = KeyEnter! THEN
		if update(true) = 1 then
			setcolumn(1)
			SetFocus()
		else
			return -1
		end if
	END IF
END IF

IF keyflags  = 1 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=1 then
			setcolumn(13)
			SetFocus()
			return -1
		end if	
	END IF
END IF

end event

event anterior;/* Verificar si existen mas de un renglon */
if rowcount() > 0 then
   if getrow()=1 then
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()   	
   else
		 /*Restar uno a la posicion actual */
		 scrolltorow(getrow() - 1)
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()   
   end if	

end if
end event

event siguiente;/* Verificar si existen mas de un renglon */
if rowcount() > 0 then
   if getrow()=rowcount() then
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()   	
   else
		 /*Restar uno a la posicion actual */
		 scrolltorow(getrow() + 1)
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()   
   end if	

end if
end event

event ultimo;/* Verificar si existen mas de un renglon */
if rowcount() > 0 then
   	 /*Moverse al final  */
		 scrolltorow(rowcount())
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()   
   end if	
end event

event primero;/* Verificar si existen mas de un renglon */
if rowcount() > 0 then
   	 /*Moverse al final  */
		 scrolltorow(1)
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()   
   end if	

end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado.position=currentrow

	/*Si está en el modo "navega", actualiza el número de cuenta dentro del objeto*/
	if parent.uo_nombre.cbx_navega.checked then
		w_certificados.uo_nombre.em_cuenta. event busqueda_simple(string(Object.cuenta[currentrow]))
	end if

end if


end event

event dberror;return 0
end event

event retrieveend;if rowcount > 0 then
	visible=true
	//enabled=true
end if

//Cuando dw_1 termine de leer los datos de la tabla... 

//Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
//                          Var_Carrera=Se almacena la Carrera
//									 Var_Plan=Se almacena el Plan  

int VarX
int Var_Carrera
int Var_Plan

if rowcount=0 then
	vsb_dw_certificado.visible=FALSE	
else	
	//Se asignan valores a Var_Carrera y a Var_Plan  
	Var_Carrera=dw_1.object.cve_carrera[1]
	Var_Plan=dw_1.object.cve_plan[1]
	//Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP  
	SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;
	// Se verifica que no sea nulo el valor traido  
	if isnull(VarX) then
			messagebox("!!! Aviso !!!",&
			"La Tabla de Plan de Estudios NO esta actualizada,"+&
			"se tomara como estudio no incorporado a la SEP, "+&
			"Favor de consultar al Administrador de la Base de Datos",Exclamation!)   
		dw_1.object.st_incorporado.visible=TRUE
	else
		if VarX = 1 then
		//Esta carrera y plan SI estan validados por la SEP  
			dw_1.object.st_incorporado.visible=FALSE
   	else
		//Esta carrera y plan NO estan validados por la SEP  
			dw_1.object.st_incorporado.visible=TRUE
		end if	
	end if
		//Verifica si se bajo más de un dato 
		if rowcount>1 then
			//Si es así, haz visible el VerticalScrollBar 
			vsb_dw_certificado.visible=TRUE
		else
			vsb_dw_certificado.visible=FALSE
		end if
end if


end event

event constructor;/*En cuanto se construya el dw_1...*/
m_menu_certificado.dw = this

//enabled = false
visible = false
end event

event itemchanged;datetime ldt_fecha
date ld_fecha
int	li_anio,li_mes, li_dia
if dwo.name = "fecha_entrada_sep" then
	li_anio = integer(mid(data,1,4))
	li_mes = integer(mid(data,6,2))
	li_dia = integer(mid(data,9,2))
	if li_mes <= 10 then
		li_mes += 2
	else
		li_anio++
		li_mes -= 10
	end if
	ld_fecha = date(li_anio, li_mes, li_dia)
	ldt_fecha = datetime(ld_fecha)
	setitem(getrow(),"fecha_salida_tentat_sep",ld_fecha)
end if
end event

type uo_nombre from uo_nombre_carrera_simple within w_certificados_simples
event destroy ( )
int X=0
int Y=3
int TabOrder=10
boolean Enabled=true
end type

on uo_nombre.destroy
call uo_nombre_carrera_simple::destroy
end on

