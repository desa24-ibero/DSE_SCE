$PBExportHeader$w_titulacion.srw
$PBExportComments$Ventana para los examenes profesionales
forward
global type w_titulacion from window
end type
type st_1 from statictext within w_titulacion
end type
type vsb_dw_certificado from vscrollbar within w_titulacion
end type
type uo_nombre from uo_nombre_carr_tit within w_titulacion
end type
type dw_1 from datawindow within w_titulacion
end type
end forward

global type w_titulacion from window
integer x = 5
integer y = 4
integer width = 3589
integer height = 2148
boolean titlebar = true
string title = "Examen Profesional"
string menuname = "m_titulacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
st_1 st_1
vsb_dw_certificado vsb_dw_certificado
uo_nombre uo_nombre
dw_1 dw_1
end type
global w_titulacion w_titulacion

on w_titulacion.create
if this.MenuName = "m_titulacion" then this.MenuID = create m_titulacion
this.st_1=create st_1
this.vsb_dw_certificado=create vsb_dw_certificado
this.uo_nombre=create uo_nombre
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.vsb_dw_certificado,&
this.uo_nombre,&
this.dw_1}
end on

on w_titulacion.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.vsb_dw_certificado)
destroy(this.uo_nombre)
destroy(this.dw_1)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
dw_1.settransobject(gtr_sce)

/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1

/*Cambia el título de la barra de herramientas*/
titulacion.toolbarsheettitle="Control de Titulación"

/*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_titulacion.m_registro.m_nuevo.disable( )
m_titulacion.m_registro.m_actualiza.disable( )
m_titulacion.m_registro.m_borraregistro.disable( )
m_titulacion.m_registro.m_primero.disable ( )
m_titulacion.m_registro.m_ultimo.disable ( )
m_titulacion.m_registro.m_siguiente.disable ( )
m_titulacion.m_registro.m_anterior.disable ( )

//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)

end event

event close;/*Cuando se cierre la ventana w_certificados...*/

/*Verifica si se deben actualizar datos en el DataWindow dw_1*/
w_titulacion.dw_1.event actualiza ( )

end event

type st_1 from statictext within w_titulacion
integer x = 969
integer y = 20
integer width = 750
integer height = 76
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "0 para ver Listado Completo"
long bordercolor = 12632256
boolean focusrectangle = false
end type

type vsb_dw_certificado from vscrollbar within w_titulacion
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 3447
integer y = 644
integer width = 73
integer height = 1092
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
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

event moved;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/*Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
                            Var_Carrera=Se almacena la Carrera
									 Var_Plan=Se almacena el Plan */
if dw_1.rowcount() > 0 then
	
int VarX
int Var_Carrera
int Var_Plan

IF scrollpos = 0 THEN RETURN

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_1.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */

dw_1.object.titulacion_fecha_envio.visible=TRUE
dw_1.object.titulacion_fecha_regreso.visible=TRUE
dw_1.object.titulacion_num_pago.visible=TRUE

/*Se asignan valores a Var_Carrera y a Var_Plan */	
Var_Carrera=dw_1.object.cve_carrera[scrollpos]
Var_Plan=dw_1.object.cve_plan[scrollpos]

/*Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP */
SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;

	/* Se verifica que no sea nulo el valor traido */
	if isnull(VarX) then
			messagebox("!!! Aviso !!!",&
		"La Tabla de Plan de Estudios NO esta actualizada,"+&
		"se tomara como estudio no incorporado a la SEP, "+&
		"Favor de consultar al Administrador de la Base de Datos",Exclamation!)

	   dw_1.object.titulacion_fecha_envio.visible=FALSE
		dw_1.object.titulacion_fecha_regreso.visible=FALSE
		dw_1.object.titulacion_num_pago.visible=FALSE
		dw_1.object.no_sep.visible=TRUE
else
		if VarX = 1 then
			/*Esta carrera y plan SI estan validados por la SEP */
			dw_1.object.no_sep.visible=FALSE
   	else
			/*Esta carrera y plan NO estan validados por la SEP */
      	dw_1.object.titulacion_fecha_envio.visible=FALSE
			dw_1.object.titulacion_fecha_regreso.visible=FALSE
			dw_1.object.titulacion_num_pago.visible=FALSE
			dw_1.object.no_sep.visible=TRUE
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

type uo_nombre from uo_nombre_carr_tit within w_titulacion
event destroy ( )
integer x = 23
integer y = 4
integer taborder = 20
boolean enabled = true
boolean border = true
end type

on uo_nombre.destroy
call uo_nombre_carr_tit::destroy
end on

type dw_1 from datawindow within w_titulacion
event type integer carga ( string cuenta,  string carrera,  string plan )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
event primero ( )
event siguiente ( )
event anterior ( )
event ultimo ( )
event actualiza_borra ( )
event type integer verifica ( )
event type integer verifica_2 ( )
event verifica_3 ( )
event type integer verifica_4 ( )
event type integer verifica_5 ( )
event calcula_fechas_estudio ( )
integer x = 50
integer y = 644
integer width = 3397
integer height = 1280
integer taborder = 30
string dataobject = "dw_titulacion"
end type

event type integer carga(string cuenta, string carrera, string plan);/*Cuando se activa el evento carga...*/

/*Ve si nos hay cambios que no se hayan guardado*/
event actualiza()

/*Haz un retrive con los parámetros que le pasaron, y ve si realmente se bajaron datos.*/
If retrieve(long(cuenta), long(carrera), long(plan))=0 &
   then
		/*Si no se bajaron datos, inserta un renglón nuevo en el DataWindow*/

		visible=false
		enabled=false
		return 0
	else
		/*Si se bajaron datos, pon el foco dentro del DataWindow*/
		enabled=true
		visible=true
		SetFocus()
		
		return 1
end if
end event

event borra_renglon;/*Cuando se activa el evonto borra_renglon...*/

/*Pregunta para verificar que realmente se desea borrar el renglón*/
if rowcount() > 0 then
	
int respuesta
respuesta = messagebox("Atención","Esta seguro de querer borrar el campo actual.",StopSign!,YesNo!,2)

if respuesta = 1 then
	/*Si realmente se desea borrar, borra el renglón actual y verifica que se haya logrado*/
	if deleterow(getrow())	= 1 then
		/*Si se borro, llama a actualiza*/
		event actualiza_borra()
		/* Desaparece el Datawindow */
		if rowcount()=0 then
		enabled = false
		visible = false
		vsb_dw_certificado.visible=FALSE
		
	
	   end if
			/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado.position=getrow()

		
		
	else
		/*De lo contrario avisa que no se pudo borrar el renglón*/
		messagebox("Información","No se han guardado los cambios")	
	end if
elseif respuesta = 2 then
	/*Si no se quiere borrar el renglón, desecha los cambios hechos.*/
	rollback using gtr_sce;
end if
end if
end event

event actualiza();/*Cuando se dispara el evento actualiza...*/

/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
/*Si es asi, acepta el texto de la última columna editada*/
THIS.AcceptText() 
	
if dw_1.ModifiedCount()+dw_1.DeletedCount() > 0 Then

	/*Pregunta si se desean guardar los cambios hechos*/
	int respuesta
	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)

	if respuesta = 1 then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if this. EVENT verifica_2() = 1 then
			    if (this. EVENT verifica() = 1 and this. EVENT verifica_4() = 1) then
	              if update(true) = 1 then
			            commit using gtr_sce;
					      messagebox("Información","Se han guardado los cambios")
   	   		      w_titulacion.uo_nombre.em_cuenta.setfocus ( )
			        else
				         /*De lo contrario, desecha los cambios (todos) y avisa*/
				         rollback using gtr_sce;
							messagebox("Información",&
				         " Ha ocurrido un error al momento de guardar los cambios."+&				
							"~r~ Las posibles causas son:"+&
							"~r~ - Algunos Datos están incorrectos,"+&
							"~r~ - Falta el Tipo de Titulacion,"+&
							"~r~ - Trata de dar de Alta a una persona con registro." +&	
				         "~r~ !!!! No se han guardado los cambios !!!!")
  			        end if

			    else
					 /* Error en datos */
				 end if
		   else
				/* Error en fechas*/
				messagebox("Información",&
	         " Ha ocurrido un error al momento de guardar los cambios."+&
				"~r~ Las fechas poseen un formato invalido "+&
				"~r~ O Bien falta la fecha de envio"+&
	         "~r~ !!!! No se han guardado los cambios !!!!")
		   end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if	
end if	

end event

event nuevo;/*Cuando se activa el evento nuevo...*/

/*Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
                            Var_Carrera=Se almacena la Carrera
									 Var_Plan=Se almacena el Plan */
int VarX
int Var_Carrera
int Var_Plan

enabled=true
visible=true
/*Pon el foco dentro del DataWindow*/
SetFocus()
/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))



/*Modifica la columna cuenta para que tenga el texto del número de cuenta (que se encuentra 
	dentro del objeto uo_nombre en un EditMask llamado em_cuenta)*/
Object.cuenta[RowCount()]=long(w_titulacion.uo_nombre.em_cuenta.Text)

/*Verifica el estado del RadioButton rb_actual dentro del objeto uo_nombre*/
if parent.uo_nombre.rb_actual.checked then
	/*Si esta checado, modifica la columna cve_carrera para que tenga el mismo valor que la
		columna academicos_cve_carrera del DataWindow dw_nombre que esta en el objeto uo_nombre
		(Puede ser de cualquier renglón ya que la carrera actual es la misma)*/
	Object.cve_carrera[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_carrera[1]
	Object.cve_plan[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_plan[1]

	/*Se asignan valores a Var_Carrera y a Var_Plan */
	Var_Carrera=parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_carrera[1]
	Var_Plan=parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_plan[1]

//Revisa si tiene dado de alta un certificado
	 if this. EVENT verifica_5() = 0 then
		 enabled = false
	    visible = false
	    /* Se borra el renglon insertado para no alterar la tabla */
	    deleterow(getrow())
	 end if	  
	
	/*Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP */
	SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;
/* Se verifica que no sea nulo el valor traido */
if isnull(VarX) then
	messagebox("!!! Aviso !!!",&
	"La Tabla de Plan de Estudios NO esta actualizada,"+&
	"se tomara como estudio no incorporado a la SEP, "+&
	"Favor de consultar al Administrador de la Base de Datos",Exclamation!)
   
	dw_1.object.titulacion_fecha_envio.visible=FALSE
	dw_1.object.titulacion_fecha_regreso.visible=FALSE
	dw_1.object.titulacion_num_pago.visible=FALSE
	dw_1.object.no_sep.visible=TRUE
else  
	if VarX = 1 then      
		/*Esta carrera y plan SI estan validados por la SEP */
		dw_1.object.no_sep.visible=FALSE
	else
		/*Esta carrera y plan NO estan validados por la SEP */
      dw_1.object.titulacion_fecha_envio.visible=FALSE
		dw_1.object.titulacion_fecha_regreso.visible=FALSE
		dw_1.object.titulacion_num_pago.visible=FALSE
		dw_1.object.no_sep.visible=TRUE
	end if	


end if
	
else
	/*De lo contrario, modifica la columna cve_carrera para que tenga el mismo valor que la
		columna hist_carreras_cve_carrera del DataWindow dw_nombre que esta en el objeto uo_nombre
		(Debe ser del renglón actual ya que varía si se tiene un largo histrorial de carreras)*/
	Object.cve_carrera[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_carrera_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
   Object.cve_plan[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_plan_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
	/*Se asignan valores a Var_Carrera y a Var_Plan */
	Var_Carrera=parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_carrera_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]
	Var_Plan=parent.uo_nombre.dw_nombre_alumno.Object.hist_carreras_cve_plan_ant[parent.uo_nombre.dw_nombre_alumno.GetRow()]

//Revisa si tiene dado de alta un certificado
	 if this. EVENT verifica_5() = 0 then
		 enabled = false
	    visible = false
	    /* Se borra el renglon insertado para no alterar la tabla */
	    deleterow(getrow())
	 end if	  

	/*Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP */
	SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;

/* Se verifica que no sea nulo el valor traido */
if isnull(VarX) then
		messagebox("!!! Aviso !!!",&
	"La Tabla de Plan de Estudios NO esta actualizada,"+&
	"se tomara como estudio no incorporado a la SEP, "+&
	"Favor de consultar al Administrador de la Base de Datos",Exclamation!)

   dw_1.object.titulacion_fecha_envio.visible=FALSE
	dw_1.object.titulacion_fecha_regreso.visible=FALSE
	dw_1.object.titulacion_num_pago.visible=FALSE
	dw_1.object.no_sep.visible=TRUE
else
	if VarX = 1 then
		/*Esta carrera y plan SI estan validados por la SEP */
		dw_1.object.no_sep.visible=FALSE
   else
		/*Esta carrera y plan NO estan validados por la SEP */
		dw_1.object.titulacion_fecha_envio.visible=FALSE
		dw_1.object.titulacion_fecha_regreso.visible=FALSE
		dw_1.object.titulacion_num_pago.visible=FALSE
		dw_1.object.no_sep.visible=TRUE
	end if	
end if
	
end if
end event

event botonazo;/* Este evento controla los TABS y el Enter, con el fin de hacer ciclico el TAB y deshabilitar
el ENTER */
IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=16 then
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
			setcolumn(16)
			SetFocus()
			return -1
		end if	
	END IF
END IF

end event

event primero;/* Verificar si existen mas de un renglon */
if rowcount() > 0 then
   	 /*Moverse al final  */
		 scrolltorow(1)
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()  
		 this. EVENT verifica_3()
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
this. EVENT verifica_3()
end if

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
   this. EVENT verifica_3()
end if
end event

event ultimo;/* Verificar si existen mas de un renglon */
if rowcount() > 0 then
   	 /*Moverse al final  */
		 scrolltorow(rowcount())
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()  
		 this. EVENT verifica_3()
   end if	


end event

event actualiza_borra;/*Cuando se dispara el evento actualiza...*/

/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
/*Si es asi, acepta el texto de la última columna editada*/
AcceptText()
	
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
				w_titulacion.uo_nombre.em_cuenta.setfocus ( )
			else
				/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using gtr_sce;
				messagebox("Información",&
			   "Algunos datos están incorrectos, favor de corregirlos. O bien trata de dar de Alta a una persona ya actualizada")	
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if	
end if	
end event

event verifica;
/*Se verifica si la fecha de regreso es nula */
if isnull(Object.titulacion_fecha_regreso[getrow()]) then
		/* Se verifica si la opcion de titulacion es mayor a 4 para obligar a llenar el campo del nombre de tesis*/
		if object.opcion_titulacion[getrow()] <= 4 then
			   if isnull(Object.titulacion_nombre_tesis[getrow()]) or Object.titulacion_nombre_tesis[getrow()]='' then
					/*Se verifica si es nulo o sin espacios */
					messagebox("Información","Falta el campo de Nombre de Tesis."+&
					"~r~ No se han guardado los cambios")
					return 0
				else
				   return 1
				end if 
		else
			  /*Si es asi, guardalo en la tabla y avisa.*/
			  return 1
		end if
else	
	   /* Como no fue nula, se verifica que la fecha de envio sea menor o igual*/
	   if date(Object.titulacion_fecha_regreso[getrow()]) >= &
	      date(Object.titulacion_fecha_envio[getrow()]) then
		   /* Se verifica si la opcion de titulacion es mayor a 4 para obligar a llenar el campo del nombre de tesis*/	
            if object.opcion_titulacion[getrow()] <= 4 then
				    /*Se verifica si es nulo o sin espacios */
					 if isnull(Object.titulacion_nombre_tesis[getrow()]) or Object.titulacion_nombre_tesis[getrow()]='' then
						  messagebox("Información","Falta el campo de Nombre de Tesis."+&
						  "~r~ No se han guardado los cambios")
						  return 0
					 else									     							
						 /* Todo esta en orden, se puede actualizar*/
						  return 1
					 end if
				else	
				   /* La opcion de titulacion es >4 entonces se puede actualizar*/
				   return 1
				end if
		else
			   messagebox("Información","La Fecha de Envio es menor a la fecha de Regreso."+&
				"~r~ No se han guardado los cambios.")
				return 0
	   end if
end if


end event

event verifica_2;string fecha1
string fecha2

fecha1=string(Object.titulacion_fecha_envio[getrow()],"dd/mm/yyyy")
fecha2=string(Object.titulacion_fecha_regreso[getrow()],"dd/mm/yyyy")

if isnull(Object.titulacion_fecha_regreso[getrow()]) AND isnull(Object.titulacion_fecha_envio[getrow()]) then
	return 1 /* Los dos son nulos */
else
   if isnull(Object.titulacion_fecha_regreso[getrow()]) then
		  if isdate(fecha1) then
			  return 1 /*Es nulo el de regreso y es valido el de envio */
	     else
			  return 0 /*Es nulo el de regreso pero no es valido el de envio*/
        end if
	else
		if (isdate(fecha1) and isdate(fecha2)) then
		   return 1 /* Las dos fechas son validas */
	   else
			return 0 /* Alguna de las fechas no es valida */
	   end if	
    end if		
end if		


end event

event verifica_3;/* En cuanto se de el evento Moved (usuario moviendo la barra o llamado desde aca adentro)... */

/*Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
                            Var_Carrera=Se almacena la Carrera
									 Var_Plan=Se almacena el Plan */
if dw_1.rowcount() > 0 then
	
int VarX
int Var_Carrera
int Var_Plan

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */

dw_1.object.titulacion_fecha_envio.visible=TRUE
dw_1.object.titulacion_fecha_regreso.visible=TRUE
dw_1.object.titulacion_num_pago.visible=TRUE

/*Se asignan valores a Var_Carrera y a Var_Plan */	
Var_Carrera=dw_1.object.cve_carrera[this.getrow()]
Var_Plan=dw_1.object.cve_plan[this.getrow()]

/*Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP */
SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;

	/* Se verifica que no sea nulo el valor traido */
	if isnull(VarX) then
			messagebox("!!! Aviso !!!",&
		"La Tabla de Plan de Estudios NO esta actualizada,"+&
		"se tomara como estudio no incorporado a la SEP, "+&
		"Favor de consultar al Administrador de la Base de Datos",Exclamation!)

	   dw_1.object.titulacion_fecha_envio.visible=FALSE
		dw_1.object.titulacion_fecha_regreso.visible=FALSE
		dw_1.object.titulacion_num_pago.visible=FALSE
		dw_1.object.no_sep.visible=TRUE
else
		if VarX = 1 then
			/*Esta carrera y plan SI estan validados por la SEP */
			dw_1.object.no_sep.visible=FALSE
   	else
			/*Esta carrera y plan NO estan validados por la SEP */
      	dw_1.object.titulacion_fecha_envio.visible=FALSE
			dw_1.object.titulacion_fecha_regreso.visible=FALSE
			dw_1.object.titulacion_num_pago.visible=FALSE
			dw_1.object.no_sep.visible=TRUE
		end if	
	end if
end if
end event

event verifica_4;int Aprobado,Mencion,Reconocimiento

Aprobado = This.Object.titulacion_aprobado[getrow()]
Mencion = This.Object.titulacion_mencion[getrow()]
Reconocimiento = This.Object.titulacion_reconocimiento[getrow()]


if Aprobado = 1 then
    if (Mencion = 1 and Reconocimiento = 1 )then
		 messagebox("Información"," NO ES POSIBLE OTORGAR un Reconocimiento y una Mención."+&
									  "~r~ Favor de Verificar las dos opciones antes mencionadas."+&
 									  "~r~             No se han guardado los cambios.")	
		return 0 // Existe la Mencion y el Reconocimiento
	else
		return 1 // Solo existe Mencion o Reconocimiento
	end if
else
    if (Mencion = 1 or Reconocimiento =1) then
		 messagebox("Información"," NO ES POSIBLE OTORGAR un Reconocimiento o una Mención,"+&
									  "~r~          a un Alumno SUSPENDIDO o NO APROBADO. "+&
									  "~r~    Favor de Verificar las opciones antes mencionadas."+&
 									  "~r~           No se han guardado los cambios.")	
		return 0 // NO APROBADO y existe la Mencion o el Reconocimiento
	else
		return 1 // NO APROBADO y NO existe Mencion o Reconocimiento
	end if
    	
end if 

end event

event verifica_5;
date VarX
long Var_Cuenta, ll_num_certs
int Var_Carrera
int Var_Plan

Var_Cuenta=object.cuenta[rowcount()]
Var_Carrera=object.cve_carrera[rowcount()]
Var_Plan=object.cve_plan[rowcount()]
	
	SELECT count(dbo.certificado.fecha_inicio)
	INTO :ll_num_certs
	FROM dbo.certificado
	WHERE dbo.certificado.cuenta=:Var_Cuenta  and 
	      dbo.certificado.cve_carrera = :Var_Carrera and 
			dbo.certificado.cve_plan = : Var_Plan using gtr_sce;
			

	
	if gtr_sce.SQLCode = 100 then
		/* Not found*/
	         messagebox("!!! Aviso !!!",&
				" El Alumno NO TIENE REGISTRO en Certificado, ~r~ "+&
				"   Por lo que no podra accesar a esta ventana ~r~ "+&
				"hasta que se haya completado el paso anterior",Exclamation!)

		return 0
	else
		if gtr_sce.SQLCode = 0 then
			  /* Found */
   		  if isnull(ll_num_certs) then
			   messagebox("!!! Aviso !!!",&
				" El Alumno si tiene registro en Certificado,  ~r~ "+&
				"          pero NO TIENE FECHA DE INICIO.          ~r~ "+&
				"    Por lo que no podra accesar a esta ventana     ~r~ "+&
				"  hasta que se haya completado el paso anterior      ",Exclamation!)

				  return 0 /* Found but is null */

			  else
				  return 1 /* Todo esta bien */
			  end if
		else
			 /* Error */
			 MessageBox("Error en la cuenta de Certificados","No se puede leer los certificados existentes",StopSign!)
			 return 0
		end if	 
   end if
	
	
end event

event calcula_fechas_estudio();INTEGER le_per_inic 
INTEGER le_anio_inc 

INTEGER le_per_fin 
INTEGER le_anio_fin 

DATETIME ldt_fecha_inicio 
DATETIME ldt_fecha_fin 
DATETIME ldt_lmp 


le_per_inic = THIS.GETITEMNUMBER(1, "periodo_inicio") 
IF ISNULL(le_per_inic) THEN le_per_inic = 0 
le_anio_inc = THIS.GETITEMNUMBER(1, "anio_inicio") 
IF ISNULL(le_anio_inc) THEN le_anio_inc = 0 

le_per_fin = THIS.GETITEMNUMBER(1, "periodo_fin") 
IF ISNULL(le_per_fin) THEN le_per_fin = 0 
le_anio_fin = THIS.GETITEMNUMBER(1, "anio_fin") 
IF ISNULL(le_anio_fin) THEN le_anio_fin = 0 


SELECT fecha 
INTO :ldt_fecha_inicio 
FROM v_calendario 
WHERE periodo = :le_per_inic
AND anio = :le_anio_inc
AND cve_evento = 1
USING gtr_sce; 
IF ldt_fecha_inicio =  ldt_lmp THEN SETNULL(ldt_fecha_inicio) 

SELECT fecha 
INTO :ldt_fecha_fin 
FROM v_calendario 
WHERE periodo = :le_per_fin
AND anio = :le_anio_fin
AND cve_evento = 2
USING gtr_sce; 	
IF ldt_fecha_fin = ldt_lmp THEN SETNULL(ldt_fecha_fin)  

THIS.SETITEM(1, "fecha_inicio", ldt_fecha_inicio) 
THIS.SETITEM(1, "fecha_fin", ldt_fecha_fin) 	

RETURN 
end event

event constructor;/*En cuanto se construya el dw_1...*/
/* Se asigna el Menu */
m_titulacion.dw = this



/*Se deshabilita el dw_1*/
enabled = false
visible = false
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if rowcount()>0 then
	
if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado.position=currentrow

	/*Si está en el modo "navega", actualiza el número de cuenta dentro del objeto*/
	if parent.uo_nombre.cbx_navega.checked then
		w_titulacion.uo_nombre.em_cuenta. event busqueda_simple(string(Object.cuenta[currentrow]))

	end if

end if

end if
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

/*Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
                            Var_Carrera=Se almacena la Carrera
									 Var_Plan=Se almacena el Plan */
int VarX
int Var_Carrera
int Var_Plan

dw_1.object.titulacion_fecha_envio.visible=TRUE
dw_1.object.titulacion_fecha_regreso.visible=TRUE
dw_1.object.titulacion_num_pago.visible=TRUE

if rowcount=0 then
	vsb_dw_certificado.visible=FALSE

  
	
else
	
	/*Se asignan valores a Var_Carrera y a Var_Plan */
	Var_Carrera=dw_1.object.cve_carrera[1]
	Var_Plan=dw_1.object.cve_plan[1]
	/*Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP */
	SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;
	/* Se verifica que no sea nulo el valor traido */
	if isnull(VarX) then
			messagebox("!!! Aviso !!!",&
			"La Tabla de Plan de Estudios NO esta actualizada,"+&
			"se tomara como estudio no incorporado a la SEP, "+&
			"Favor de consultar al Administrador de la Base de Datos",Exclamation!)
	
	   dw_1.object.titulacion_fecha_envio.visible=FALSE
		dw_1.object.titulacion_fecha_regreso.visible=FALSE
		dw_1.object.titulacion_num_pago.visible=FALSE
		dw_1.object.no_sep.visible=TRUE
else
		if VarX = 1 then
		/*Esta carrera y plan SI estan validados por la SEP */
			dw_1.object.no_sep.visible=FALSE
   	else
		/*Esta carrera y plan NO estan validados por la SEP */
      	dw_1.object.titulacion_fecha_envio.visible=FALSE
			dw_1.object.titulacion_fecha_regreso.visible=FALSE
			dw_1.object.titulacion_num_pago.visible=FALSE
			dw_1.object.no_sep.visible=TRUE
		end if	
	end if
	
		/*Verifica si se bajo más de un dato*/
		if rowcount>1 then
			/*Si es así, haz visible el VerticalScrollBar*/
			vsb_dw_certificado.visible=TRUE
			
		else
			vsb_dw_certificado.visible=FALSE
		  

		end if
end if


end event

event dberror;return 0
end event

event itemchanged;
IF dwo.name = "periodo_inicio" OR dwo.name = "anio_inicio" OR dwo.name = "periodo_fin" OR dwo.name = "anio_fin" THEN  
	
	POSTEVENT("calcula_fechas_estudio")
	
END IF 






end event

