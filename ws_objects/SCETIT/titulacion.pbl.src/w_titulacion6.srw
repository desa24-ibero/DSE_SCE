$PBExportHeader$w_titulacion6.srw
$PBExportComments$Ventana de Parámetros de Titulación
forward
global type w_titulacion6 from Window
end type
type st_1 from statictext within w_titulacion6
end type
type vsb_dw_certificado from vscrollbar within w_titulacion6
end type
type dw_1 from datawindow within w_titulacion6
end type
end forward

global type w_titulacion6 from Window
int X=4
int Y=6
int Width=1697
int Height=541
boolean TitleBar=true
string Title="Parámetros de Titulación"
string Tag="Menú en donde se despliegan los parámetros de Titulación"
string MenuName="m_titulacion"
long BackColor=12632256
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
st_1 st_1
vsb_dw_certificado vsb_dw_certificado
dw_1 dw_1
end type
global w_titulacion6 w_titulacion6

on w_titulacion6.create
if this.MenuName = "m_titulacion" then this.MenuID = create m_titulacion
this.st_1=create st_1
this.vsb_dw_certificado=create vsb_dw_certificado
this.dw_1=create dw_1
this.Control[]={this.st_1,&
this.vsb_dw_certificado,&
this.dw_1}
end on

on w_titulacion6.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.vsb_dw_certificado)
destroy(this.dw_1)
end on

event open;/*Cuando se abra la ventana w_certificados...*/

/*Haz que la fuente de datos de el DataWindow sea el gtr_sce*/
dw_1.settransobject(gtr_sce)

/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1

/*Cambia el título de la barra de herramientas*/
titulacion.toolbarsheettitle="Parámetros de Titulación"

//Comentado para migrar sin padlock
//g_nv_security.fnv_secure_window (this)

end event

event close;/*Cuando se cierre la ventana w_certificados...*/

/*Verifica si se deben actualizar datos en el DataWindow dw_1*/
w_titulacion6.dw_1.event actualiza ( )

end event

type st_1 from statictext within w_titulacion6
int X=369
int Y=13
int Width=801
int Height=77
boolean Enabled=false
boolean Border=true
BorderStyle BorderStyle=StyleShadowBox!
string Text=" Parámetros de Titulación"
Alignment Alignment=Center!
boolean FocusRectangle=false
long BackColor=12632256
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type vsb_dw_certificado from vscrollbar within w_titulacion6
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
int X=1448
int Y=118
int Width=124
int Height=208
boolean Enabled=false
boolean BringToTop=true
boolean StdWidth=false
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

type dw_1 from datawindow within w_titulacion6
event type integer carga ( string cuenta,  string carrera )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
event primero ( )
event ultimo ( )
event siguiente ( )
event anterior ( )
int Y=118
int Width=1448
int Height=208
int TabOrder=20
string DataObject="dw_parametros"
end type

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
				dw_1.setsort("cve_tramite A")
         	dw_1.sort()
				///*Se actualiza el scroll bar a la posicion UNO */
				vsb_dw_certificado. event moved(1)
				vsb_dw_certificado.position=1
				
				
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
long VarX
long Contador

enabled=true
visible=true
/*Pon el foco dentro del DataWindow*/
SetFocus()

VarX=RowCount()

FOR Contador=1 TO VarX
     if Contador <> this.object.cve_tramite[Contador] then
		EXIT
     end if
NEXT

/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))

/*Se coloca la clave del tramite con el ultimo valor mas uno */
Object.cve_tramite[RowCount()]=Contador

end event

event botonazo;/* Evento que controla el TAB */
IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=3 then
			setcolumn(2)
			SetFocus()
			return -1
		end if
	END IF
END IF

IF keyflags  = 0 THEN
	IF key = KeyEnter! THEN
		if update(true) = 1 then
			setcolumn(2)
			SetFocus()
		else
			return -1
		end if
	END IF
END IF

IF keyflags  = 1 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=2 then
			setcolumn(3)
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

event constructor;/*En cuanto se construya el dw_1...*/
settransobject(gtr_sce)
retrieve()
m_titulacion.dw = this

end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado.position=currentrow

end if


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

event dberror;return -1
end event

