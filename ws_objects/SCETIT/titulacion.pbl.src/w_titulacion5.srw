$PBExportHeader$w_titulacion5.srw
$PBExportComments$Ventana de la entrega de Titulos
forward
global type w_titulacion5 from window
end type
type dw_1 from datawindow within w_titulacion5
end type
type st_1 from statictext within w_titulacion5
end type
type uo_nombre from uo_nombre_carr_tit5 within w_titulacion5
end type
type vsb_dw_certificado from vscrollbar within w_titulacion5
end type
end forward

global type w_titulacion5 from window
string tag = "Con esta ventana se muestra la fecha de entrega de documentos"
integer x = 4
integer y = 3
integer width = 3588
integer height = 1290
boolean titlebar = true
string title = "Entrega de Titulo o Diploma"
string menuname = "m_titulacion"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
dw_1 dw_1
st_1 st_1
uo_nombre uo_nombre
vsb_dw_certificado vsb_dw_certificado
end type
global w_titulacion5 w_titulacion5

on w_titulacion5.create
if this.MenuName = "m_titulacion" then this.MenuID = create m_titulacion
this.dw_1=create dw_1
this.st_1=create st_1
this.uo_nombre=create uo_nombre
this.vsb_dw_certificado=create vsb_dw_certificado
this.Control[]={this.dw_1,&
this.st_1,&
this.uo_nombre,&
this.vsb_dw_certificado}
end on

on w_titulacion5.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.uo_nombre)
destroy(this.vsb_dw_certificado)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
dw_1.settransobject(gtr_sce)

/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1

/*Cambia el título de la barra de herramientas*/
titulacion.toolbarsheettitle="Entrega de Documentos"

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
w_titulacion5.dw_1.event actualiza ( )

end event

type dw_1 from datawindow within w_titulacion5
event constructor pbm_constructor
event dberror pbm_dwndberror
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
event type integer carga ( string cuenta,  string carrera,  string plan )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
event anterior ( )
event primero ( )
event siguiente ( )
event ultimo ( )
event type integer verifica_2 ( )
event type integer verifica_3 ( )
event type integer verifica_4 ( )
integer x = 15
integer y = 643
integer width = 3416
integer height = 432
integer taborder = 11
string dataobject = "dw_entrega"
end type

event constructor;/*En cuanto se construya el dw_1...*/
m_titulacion.dw = this

enabled = false
visible = false
end event

event dberror;return 0
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/


/*Verifica si se bajo más de un dato*/
if rowcount>1 then
	/*Si es así, haz visible el VerticalScrollBar*/
	vsb_dw_certificado.visible=TRUE
else
	vsb_dw_certificado.visible=FALSE
end if

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
		w_titulacion5.uo_nombre.em_cuenta. event busqueda_simple(string(Object.cuenta[currentrow]))

	end if

end if

end if
end event

event carga;/*Cuando se activa el evento carga...*/

/*Ve si nos hay cambios que no se hayan guardado*/
event actualiza()

/*Haz un retrive con los parámetros que le pasaron, y ve si realmente se bajaron datos.*/
If retrieve(long(cuenta),long(carrera), long(plan))=0 &
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
		event actualiza()
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
				messagebox("Información",&
				"Algunos datos están incorrectos, favor de corregirlos. O bien trata de dar de Alta a una persona ya actualizada")
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
	end if	
end if	
end event

event nuevo;/*Cuando se activa el evento nuevo...*/




enabled=true
visible=true
/*Pon el foco dentro del DataWindow*/
SetFocus()
/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))



/*Modifica la columna cuenta para que tenga el texto del número de cuenta (que se encuentra 
	dentro del objeto uo_nombre en un EditMask llamado em_cuenta)*/
Object.cuenta[RowCount()]=long(w_titulacion5.uo_nombre.em_cuenta.Text)

/*Verifica el estado del RadioButton rb_actual dentro del objeto uo_nombre*/
if parent.uo_nombre.rb_actual.checked then
	/*Si esta checado, modifica la columna cve_carrera para que tenga el mismo valor que la
		columna academicos_cve_carrera del DataWindow dw_nombre que esta en el objeto uo_nombre
		(Puede ser de cualquier renglón ya que la carrera actual es la misma)*/
	
	
	Object.cve_carrera[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_carrera[1]
	Object.cve_plan[RowCount()]=&
		parent.uo_nombre.dw_nombre_alumno.Object.academicos_cve_plan[1]

	if this. EVENT verifica_3() = 1 then 
		// Como si esta registrado ante SEP hay que buscar en todos los procesos anteriores
	    if this. EVENT verifica_2() = 0 then
		   	 enabled = false
	          visible = false
	          /* Se borra el renglon insertado para no alterar la tabla */
	          deleterow(getrow())
		 end if	
	else
		 if this. EVENT verifica_4() = 0 then
		   	 enabled = false
	          visible = false
	          /* Se borra el renglon insertado para no alterar la tabla */
	          deleterow(getrow())
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

   if this. EVENT verifica_3() = 1 then 
		// Como si esta registrado ante SEP hay que buscar en todos los procesos anteriores
	    if this. EVENT verifica_2() = 0 then
		   	 enabled = false
	          visible = false
	          /* Se borra el renglon insertado para no alterar la tabla */
	          deleterow(getrow())
		 end if	
	else
		 if this. EVENT verifica_4() = 0 then
		   	 enabled = false
	          visible = false
	          /* Se borra el renglon insertado para no alterar la tabla */
	          deleterow(getrow())
		 end if	
	end if
	
		
end if
end event

event botonazo;IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=6 then
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
			setcolumn(6)
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

event primero;/* Verificar si existen mas de un renglon */
if rowcount() > 0 then
   	 /*Moverse al final  */
		 scrolltorow(1)
       /* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
       vsb_dw_certificado.position=getrow()   
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

event verifica_2;date VarX
long Var_Cuenta
int Var_Carrera
int Var_Plan, li_sin_tramite

Var_Cuenta=object.cuenta[rowcount()]
Var_Carrera=object.cve_carrera[rowcount()]
Var_Plan=object.cve_plan[rowcount()]

	
	SELECT profesiones.fecha_regreso_prof, 
	       profesiones.sin_tramite
	INTO :VarX, 
	     :li_sin_tramite
	FROM profesiones
	WHERE profesiones.cuenta=:Var_Cuenta and 
	      profesiones.cve_carrera = :Var_Carrera and 
			profesiones.cve_plan = : Var_Plan using gtr_sce;

	
	if gtr_sce.SQLCode = 100 then
		/* Not found*/
	         messagebox("!!! Aviso !!!",&
				"   El Alumno NO TIENE REGISTRO en Profesiones,   ~r~ "+&
				"   Por lo que no podra accesar a esta ventana ~r~ "+&
				"hasta que se haya acompletado el paso anterior",Exclamation!)

		return 0
	else
		if gtr_sce.SQLCode = 0 then
			  /* Found */
			  if isnull(li_sin_tramite) then
	         	li_sin_tramite= 0		
			  end if
   		  if isnull(VarX) and li_sin_tramite<>1 then
			   messagebox("!!! Aviso !!!",&
				"   El Alumno si tiene registro en Profesiones,  ~r~ "+&
				"        pero NO TIENE FECHA DE REGRESO.          ~r~ "+&
				"    Por lo que no podra accesar a esta ventana     ~r~ "+&
				"  hasta que se haya acompletado el paso anterior      ",Exclamation!)

				  return 0 /* Found but is null */

			  else
				  return 1 /* Todo esta bien */
			  end if
		else
			 /* Error */
			 return 0
		end if	 
   end if
	
end event

event verifica_3;
/*Declaración de Varibles : VarX =Se almacena si esta incorporado a SEP 1=SI,0=NO
                            Var_Carrera=Se almacena la Carrera
									 Var_Plan=Se almacena el Plan */
int VarX
int Var_Carrera
int Var_Plan

/*Se asignan valores a Var_Carrera y a Var_Plan */
Var_Carrera=object.cve_carrera[rowcount()]
Var_Plan=object.cve_plan[rowcount()]
	
	
/*Se hace un SQL para saber si la carrera y el plan estan registrados ante la SEP */

	SELECT plan_estudios.incorporado_sep
	INTO :VarX
   FROM plan_estudios   
	WHERE plan_estudios.cve_carrera=:Var_Carrera AND plan_estudios.cve_plan=:Var_Plan using gtr_sce;
	/* Se verifica que no sea nulo el valor traido */
	if isnull(VarX) then
	    /*Esta carrera y plan SE TOMARA COMO QUE NO esta validado por la SEP */
	    return 0
   else
	   if VarX = 1 then      
	    /*Esta carrera y plan SI estan validados por la SEP */
		 return 1	 
      else	
	    /*Esta carrera y plan NO estan validados por la SEP */
	      return 0
	   end if	
   end if
	
end event

event verifica_4;date VarX
long Var_Cuenta
int Var_Carrera
int Var_Plan

Var_Cuenta=object.cuenta[rowcount()]
Var_Carrera=object.cve_carrera[rowcount()]
Var_Plan=object.cve_plan[rowcount()]
	
	SELECT diseño_titulacion.fecha_regreso
	INTO :VarX
	FROM diseño_titulacion
	WHERE diseño_titulacion.cuenta=:Var_Cuenta  and 
	      diseño_titulacion.cve_carrera = :Var_Carrera and 
			diseño_titulacion.cve_plan = : Var_Plan using gtr_sce;
			

	
	if gtr_sce.SQLCode = 100 then
		/* Not found*/
	         messagebox("!!! Aviso !!!",&
				" El Alumno NO TIENE REGISTRO en Diseño de Titulo, ~r~ "+&
				"   Por lo que no podra accesar a esta ventana ~r~ "+&
				"hasta que se haya acompletado el paso anterior",Exclamation!)

		return 0
	else
		if gtr_sce.SQLCode = 0 then
			  /* Found */
   		  if isnull(VarX) then
			   messagebox("!!! Aviso !!!",&
				" El Alumno si tiene registro en Diseño de Titulo,  ~r~ "+&
				"          pero NO TIENE FECHA DE REGRESO.          ~r~ "+&
				"    Por lo que no podra accesar a esta ventana     ~r~ "+&
				"  hasta que se haya acompletado el paso anterior      ",Exclamation!)

				  return 0 /* Found but is null */

			  else
				  return 1 /* Todo esta bien */
			  end if
		else
			 /* Error */
			 return 0
		end if	 
   end if
end event

type st_1 from statictext within w_titulacion5
integer x = 955
integer y = 26
integer width = 750
integer height = 77
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "0 para ver Listado Completo"
boolean focusrectangle = false
end type

type uo_nombre from uo_nombre_carr_tit5 within w_titulacion5
integer y = 3
integer taborder = 10
boolean enabled = true
boolean border = true
end type

on uo_nombre.destroy
call uo_nombre_carr_tit5::destroy
end on

type vsb_dw_certificado from vscrollbar within w_titulacion5
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 3430
integer y = 643
integer width = 73
integer height = 432
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

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_1.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */
dw_1.ScrollToRow(scrollpos)

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

