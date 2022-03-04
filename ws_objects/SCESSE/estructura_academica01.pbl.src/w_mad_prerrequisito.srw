$PBExportHeader$w_mad_prerrequisito.srw
$PBExportComments$Ventana de Prerrequisitos de cada materia
forward
global type w_mad_prerrequisito from window
end type
type em_3x from editmask within w_mad_prerrequisito
end type
type em_2x from editmask within w_mad_prerrequisito
end type
type dw_5 from datawindow within w_mad_prerrequisito
end type
type st_7 from statictext within w_mad_prerrequisito
end type
type st_6 from statictext within w_mad_prerrequisito
end type
type sle_1 from editmask within w_mad_prerrequisito
end type
type st_5 from statictext within w_mad_prerrequisito
end type
type st_4 from statictext within w_mad_prerrequisito
end type
type st_3 from statictext within w_mad_prerrequisito
end type
type dw_2x from datawindow within w_mad_prerrequisito
end type
type dw_1x from datawindow within w_mad_prerrequisito
end type
type st_1 from statictext within w_mad_prerrequisito
end type
type st_2 from statictext within w_mad_prerrequisito
end type
type vsb_dw_certificado2 from vscrollbar within w_mad_prerrequisito
end type
type cb_1 from commandbutton within w_mad_prerrequisito
end type
type vsb_dw_certificado from vscrollbar within w_mad_prerrequisito
end type
type vsb_dw_certificado3 from vscrollbar within w_mad_prerrequisito
end type
type dw_1 from datawindow within w_mad_prerrequisito
end type
type dw_2 from datawindow within w_mad_prerrequisito
end type
type gb_5 from groupbox within w_mad_prerrequisito
end type
type gb_4 from groupbox within w_mad_prerrequisito
end type
type gb_3 from groupbox within w_mad_prerrequisito
end type
type gb_2 from groupbox within w_mad_prerrequisito
end type
type dw_3 from datawindow within w_mad_prerrequisito
end type
type dw_4 from datawindow within w_mad_prerrequisito
end type
type gb_1 from groupbox within w_mad_prerrequisito
end type
end forward

global type w_mad_prerrequisito from window
boolean visible = false
integer x = 5
integer y = 4
integer width = 3511
integer height = 1868
boolean titlebar = true
string title = "Materia-Plan (Prerrequisitos)"
string menuname = "m_prerrequisitos"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 12632256
em_3x em_3x
em_2x em_2x
dw_5 dw_5
st_7 st_7
st_6 st_6
sle_1 sle_1
st_5 st_5
st_4 st_4
st_3 st_3
dw_2x dw_2x
dw_1x dw_1x
st_1 st_1
st_2 st_2
vsb_dw_certificado2 vsb_dw_certificado2
cb_1 cb_1
vsb_dw_certificado vsb_dw_certificado
vsb_dw_certificado3 vsb_dw_certificado3
dw_1 dw_1
dw_2 dw_2
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
gb_2 gb_2
dw_3 dw_3
dw_4 dw_4
gb_1 gb_1
end type
global w_mad_prerrequisito w_mad_prerrequisito

type variables
int carrera_x
int plan_x
int bandera1=0,bandera5=0
string materia_x
end variables

on w_mad_prerrequisito.create
if this.MenuName = "m_prerrequisitos" then this.MenuID = create m_prerrequisitos
this.em_3x=create em_3x
this.em_2x=create em_2x
this.dw_5=create dw_5
this.st_7=create st_7
this.st_6=create st_6
this.sle_1=create sle_1
this.st_5=create st_5
this.st_4=create st_4
this.st_3=create st_3
this.dw_2x=create dw_2x
this.dw_1x=create dw_1x
this.st_1=create st_1
this.st_2=create st_2
this.vsb_dw_certificado2=create vsb_dw_certificado2
this.cb_1=create cb_1
this.vsb_dw_certificado=create vsb_dw_certificado
this.vsb_dw_certificado3=create vsb_dw_certificado3
this.dw_1=create dw_1
this.dw_2=create dw_2
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.gb_2=create gb_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_1=create gb_1
this.Control[]={this.em_3x,&
this.em_2x,&
this.dw_5,&
this.st_7,&
this.st_6,&
this.sle_1,&
this.st_5,&
this.st_4,&
this.st_3,&
this.dw_2x,&
this.dw_1x,&
this.st_1,&
this.st_2,&
this.vsb_dw_certificado2,&
this.cb_1,&
this.vsb_dw_certificado,&
this.vsb_dw_certificado3,&
this.dw_1,&
this.dw_2,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.gb_2,&
this.dw_3,&
this.dw_4,&
this.gb_1}
end on

on w_mad_prerrequisito.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.em_3x)
destroy(this.em_2x)
destroy(this.dw_5)
destroy(this.st_7)
destroy(this.st_6)
destroy(this.sle_1)
destroy(this.st_5)
destroy(this.st_4)
destroy(this.st_3)
destroy(this.dw_2x)
destroy(this.dw_1x)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.vsb_dw_certificado2)
destroy(this.cb_1)
destroy(this.vsb_dw_certificado)
destroy(this.vsb_dw_certificado3)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_1)
end on

event open;dw_1.settransobject(gtr_sce)
dw_2.settransobject(gtr_sce)
dw_3.settransobject(gtr_sce)
dw_4.settransobject(gtr_sce)
dw_5.settransobject(gtr_sce)
dw_1x.settransobject(gtr_sce)
dw_2x.settransobject(gtr_sce)

gb_2.visible=FALSE
gb_5.visible=false

/*Acomoda la ventana en el margen superior izquierdo*/
this.x=1
this.y=1


/*Desabilita las opciones nuevo, actualiza y borra del menú*/
m_prerrequisitos.m_registro.m_nuevo.disable( )
m_prerrequisitos.m_registro.m_actualizar.disable( )
m_prerrequisitos.m_registro.m_borraregistro.disable( )
m_prerrequisitos.m_registro.m_nuevoprerrequisito.disable ( )
m_prerrequisitos.m_registro.m_borrarprerrequisito.disable ( )
m_prerrequisitos.m_registro.m_agregarprerrequisito.disable ( )
/**/gnv_app.inv_security.of_SetSecurity(this)


//g_nv_security.fnv_secure_window (this)


end event

event close;		dw_5. Event actualiza()
end event

type em_3x from editmask within w_mad_prerrequisito
event modified pbm_enmodified
event constructor pbm_constructor
integer x = 1106
integer y = 252
integer width = 206
integer height = 84
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###xxxxxx"
string displaydata = ""
end type

event modified;string Carrera

/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_10x*/
if keydown(keyenter!) then	
	Carrera=this.text
	if (Carrera <> '') then
        vsb_dw_certificado3.triggerevent("verifica")
	end if	
end if

end event

type em_2x from editmask within w_mad_prerrequisito
event constructor pbm_constructor
event modified pbm_enmodified
integer x = 1102
integer y = 92
integer width = 206
integer height = 84
integer taborder = 20
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "###xxxxxx"
string displaydata = ""
end type

event modified;string Carrera

/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_10x*/
if keydown(keyenter!) then	
	Carrera=this.text
	if (Carrera <> '') then
        vsb_dw_certificado2.triggerevent("verifica")
	end if	
end if

end event

type dw_5 from datawindow within w_mad_prerrequisito
event constructor pbm_constructor
event dberror pbm_dwndberror
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
event type integer carga ( string cuenta,  string carrera )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
event primero ( )
event ultimo ( )
event siguiente ( )
event anterior ( )
event nuevox ( )
event borra_renglonx ( )
event borra_renglon_cursativa ( )
integer x = 133
integer y = 736
integer width = 1733
integer height = 356
integer taborder = 50
string dataobject = "dw_mad_prerrequisito_b"
boolean border = false
end type

event constructor;/*En cuanto se construya el dw_1...*/
m_prerrequisitos.dw = this
//
//enabled = false
visible = false

this.SetRowFocusIndicator(Hand!)
end event

event dberror;return -1
end event

event retrieveend;///*Cuando dw_1 termine de leer los datos de la tabla...*/
//

enabled = true
visible = true

m_prerrequisitos.m_registro.m_actualizar.enable( )
if rowcount=0 then
	visible=FALSE
	st_6.visible=FALSE
	st_7.visible=TRUE
	gb_5.visible=false
	m_prerrequisitos.m_registro.m_nuevo.enable( )
   m_prerrequisitos.m_registro.m_borraregistro.enable( )
	
else
	gb_5.visible=TRUE
	visible=TRUE
	st_7.visible=FALSE
	st_6.visible=TRUE
	m_prerrequisitos.m_registro.m_nuevo.disable( )
   m_prerrequisitos.m_registro.m_borraregistro.enable( )
end if

this.SetRowFocusIndicator(Hand!)
end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */
if rowcount() > 0 then
if currentrow>0 then
	accepttext()
end if
end if

end event

event carga;///*Cuando se activa el evento carga...*/
//
///*Ve si nos hay cambios que no se hayan guardado*/
//event actualiza()
//
///*Haz un retrive con los parámetros que le pasaron, y ve si realmente se bajaron datos.*/
//If retrieve(long(cuenta),long(carrera))=0 &
//   then
//		/*Si no se bajaron datos, inserta un renglón nuevo en el DataWindow*/
//		
//		visible=false
//		enabled=false
//		return 0
//	else
//		/*Si se bajaron datos, pon el foco dentro del DataWindow*/
//		enabled=true
//		visible=true
//		SetFocus()
//		
		return 1
//end if
end event

event borra_renglon;/*Cuando se activa el evento borra_renglon...*/
int Temporal
if rowcount() > 0 then
/*Pregunta para verificar que realmente se desea borrar el renglón*/
int respuesta
respuesta = messagebox("Atención","Esta seguro de querer ELIMINAR la Materia Actual "+&
                       "con todos sus prerrequisitos",StopSign!,YesNo!,2)

if respuesta = 1 then
	/*Si realmente se desea borrar, borra el renglón actual y verifica que se haya logrado*/
	if deleterow(rowcount())= 1 then	
   /*Si se borro, llama a actualiza*/
		// event actualiza()
		
		if dw_1.rowcount() > 0 then
			Temporal=dw_1.rowcount()
			DO WHILE (Temporal<>0)
				dw_1.deleterow(Temporal)
				Temporal=dw_1.rowcount()
			LOOP

		end if	  
		
		/* Desaparece el Datawindow */
				enabled = false
				visible = false
				gb_5.visible=false
				
   else
		/*De lo contrario avisa que no se pudo borrar el renglón*/
		messagebox("Error","Por Alguna razon NO SE HAN GUARDADO LOS CAMBIOS ",StopSign!)	
	end if

elseif respuesta = 2 then
	/*Si no se quiere borrar el la materia, desecha los cambios hechos.*/
	rollback using gtr_sce;
end if
end if
end event

event actualiza;/*Cuando se dispara el evento actualiza...*/

/*Si es asi, acepta el texto de la última columna editada*/
AcceptText()
/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ( ( dw_5.ModifiedCount()+dw_5.DeletedCount() > 0) or bandera5		=	1 ) Then

	/*Pregunta si se desean guardar los cambios hechos*/
	int respuesta
	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
	if respuesta = 1 &
		then
			/*Checa que los renglones cumplan con las reglas de validación*/
			if update(true) = 1 then
					if ( (dw_1.ModifiedCount()+dw_1.DeletedCount() > 0) or bandera1	=	1 ) Then
								if dw_1.update(true) = 1 then		
									/*Si es asi, guardalo en la tabla y avisa.*/
								   commit using gtr_sce;
									messagebox("Información","Se han guardado los cambios")			
								else
									/*De lo contrario, desecha los cambios (todos) y avisa*/
								   rollback using gtr_sce;
										messagebox("Información",&
							   	   "     Algunos datos están incorrectos, Favor de Corregirlos. "+&
										"~r~O bien trata de dar de Alta a una Materia con el mismo Registro")	
								end if
					else
						commit using gtr_sce;
						messagebox("Información","Se han guardado los cambios")	
					end if
		    else		
					/*De lo contrario, desecha los cambios (todos) y avisa*/
				rollback using gtr_sce;
				messagebox("Información",&
			      "     Algunos datos están incorrectos, Favor de Corregirlos. "+&
				"~r~O bien trata de dar de Alta a una Materia con el mismo Registro")	
	       end if			
	else	
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")	
	end if
else
		
		if ( (dw_1.ModifiedCount()+dw_1.DeletedCount() > 0 ) or bandera1	=	1 ) Then
	         /*Pregunta si se desean guardar los cambios hechos*/
      	int respuesta2
      	respuesta2 = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
      	if respuesta2 = 1 &
					then
					/*Checa que los renglones cumplan con las reglas de validación*/
					if dw_1.update(true) = 1 then		
							/*Si es asi, guardalo en la tabla y avisa.*/
						commit using gtr_sce;
						messagebox("Información","Se han guardado los cambios")			
					else
						/*De lo contrario, desecha los cambios (todos) y avisa*/
						rollback using gtr_sce;
						messagebox("Información",&
								      "     Algunos datos están incorrectos, Favor de Corregirlos. "+&
										"~r~O bien trata de dar de Alta a una Materia con el mismo Registro")	
					end if
			else
					/*De lo contrario, solo avisa que no se guardó nada.*/
					messagebox("Información","No se han guardado los cambios")
			end if		
		end if					
end if


end event

event nuevo();/*Cuando se activa el evento nuevo...*/
gb_5.visible=true
enabled=true
visible=true

SetFocus()
/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))

this.SetColumn(4)
Object.cve_mat[RowCount()]=long(materia_x)
Object.cve_carrera[RowCount()]=carrera_x
Object.cve_plan[RowCount()]=plan_x
m_prerrequisitos.m_registro.m_nuevoprerrequisito.enable ( )
m_prerrequisitos.m_registro.m_borrarprerrequisito.enable ( )	
m_prerrequisitos.m_registro.m_agregarprerrequisito.enable ( )
end event

event botonazo;//IF keyflags  = 0 THEN
//	IF key = KeyTab! THEN
//		IF getcolumn()=8 then
//			setcolumn(1)
//			SetFocus()
//			return -1
//		end if
//	END IF
//END IF
//
//IF keyflags  = 0 THEN
//	IF key = KeyEnter! THEN
//		if update(true) = 1 then
//			setcolumn(1)
//			SetFocus()
//		else
//			return -1
//		end if
//	END IF
//END IF
//
//IF keyflags  = 1 THEN
//	IF key = KeyTab! THEN
//		IF getcolumn()=1 then
//			setcolumn(8)
//			SetFocus()
//			return -1
//		end if	
//	END IF
//END IF
//
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

event nuevox;dw_1. EVENT nuevo(m_prerrequisitos.band)
end event

event borra_renglonx;dw_1. EVENT borra_renglon()
end event

event borra_renglon_cursativa();int Temporal
long ll_row_actual

if rowcount() > 0 then
	//*Pregunta para verificar que realmente se desea borrar el renglón*/
	int respuesta
	respuesta = messagebox("Atención","¿Esta seguro de querer ELIMINAR la cursativa/subsistema actual?",StopSign!,YesNo!,2)

	if respuesta = 1 then
		ll_row_actual= GetRow()
	//*Si realmente se desea borrar, borra el renglón actual y verifica que se haya logrado*/
		if deleterow(ll_row_actual)= 1 then	
   	//*Si se borro, llama a actualiza*/
				
	   else
		//*De lo contrario avisa que no se pudo borrar el renglón*/
			messagebox("Error","Por Alguna razon NO SE HAN GUARDADO LOS CAMBIOS ",StopSign!)	
		end if

	elseif respuesta = 2 then
		//*Si no se quiere borrar el la materia, desecha los cambios hechos.*/
	end if
end if
end event

event itemchanged;bandera5	=	1
end event

type st_7 from statictext within w_mad_prerrequisito
event constructor pbm_constructor
integer x = 521
integer y = 1200
integer width = 1047
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Materia SIN REGISTRO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type st_6 from statictext within w_mad_prerrequisito
event constructor pbm_constructor
integer x = 521
integer y = 1200
integer width = 1047
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Materia CON REGISTRO"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type sle_1 from editmask within w_mad_prerrequisito
integer x = 192
integer y = 208
integer width = 311
integer height = 84
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
string mask = "#####"
string displaydata = ""
end type

event modified;string Materia

/* Si se detecta un ENTER se verifica que haya escrito algo y se verifica el numero de cuenta 
en el evento clicked de cd_1x*/
if keydown(keyenter!) then
	dw_5. Event actualiza()
	Materia=this.text
	if (Materia <> '') then
   	 cb_1.triggerevent("clicked")
	end if	
end if

end event

type st_5 from statictext within w_mad_prerrequisito
event constructor pbm_constructor
integer x = 521
integer y = 1344
integer width = 1047
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Materia CON PRERREQUISITOS"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type st_4 from statictext within w_mad_prerrequisito
event constructor pbm_constructor
integer x = 521
integer y = 1344
integer width = 1047
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Materia SIN PRERREQUISITOS"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type st_3 from statictext within w_mad_prerrequisito
integer x = 105
integer y = 124
integer width = 507
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 10789024
boolean enabled = false
string text = "Clave de Materia :"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type dw_2x from datawindow within w_mad_prerrequisito
integer x = 3698
integer y = 652
integer width = 1367
integer height = 364
string dataobject = "dw_mad_verifica_mat2"
boolean livescroll = true
end type

type dw_1x from datawindow within w_mad_prerrequisito
integer x = 3648
integer y = 220
integer width = 1083
integer height = 220
string dataobject = "dw_mad_verifica_mat1"
boolean livescroll = true
end type

type st_1 from statictext within w_mad_prerrequisito
event constructor pbm_constructor
integer x = 521
integer y = 1488
integer width = 1047
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Procesando ....... Por favor Espere !!"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type st_2 from statictext within w_mad_prerrequisito
event constructor pbm_constructor
integer x = 731
integer y = 1488
integer width = 667
integer height = 76
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 65535
long backcolor = 255
boolean enabled = false
string text = "Proceso Terminado !"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = stylelowered!
boolean focusrectangle = false
end type

event constructor;visible=false
end event

type vsb_dw_certificado2 from vscrollbar within w_mad_prerrequisito
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
event constructor pbm_constructor
event verifica ( )
integer x = 3131
integer y = 68
integer width = 219
integer height = 124
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_3.RowCount() then
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
maxposition=dw_3.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */

dw_3.ScrollToRow(scrollpos)

carrera_x=dw_3.object.cve_carrera[dw_3.getrow()]
em_2x.text= string(dw_3.object.cve_carrera[dw_3.getrow()])
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_3.RowCount() then
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

event verifica;int Total,Cont,Bandera
int Carrera_P
Total = dw_3.rowcount()

Bandera = 0
Carrera_P=integer(em_2x.text)

FOR Cont=1 TO Total
	if dw_3.object.cve_carrera[Cont]=Carrera_P then
		Bandera=1
		EVENT moved(Cont)
	end if
NEXT

If Bandera = 0 then
	messagebox("Aviso","La Carrera : "+em_2x.text+"  , NO EXISTE.  Por Favor Verifique !",Exclamation!)
	em_2x.SelectText(1, Len(em_2x.Text))
	em_2x.setfocus()
end if

end event

type cb_1 from commandbutton within w_mad_prerrequisito
event type integer verifica ( )
integer x = 3077
integer y = 240
integer width = 325
integer height = 124
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event verifica;long Cont,Size
long Clave
int areas_1[],areas_2[]
int Bandera
long Clave_2

Clave_2=long(materia_x)

dw_1x.retrieve(carrera_x,plan_x)
dw_2x.retrieve(carrera_x,plan_x)


if dw_1x.rowcount() > 0 then
     FOR Cont=1 TO dw_1x.rowcount()
      areas_2[Cont]=dw_1x.object.cve_area[Cont]
	  NEXT
end if
if dw_2x.rowcount() > 0 then
areas_1[1]=dw_2x.object.cve_area_basica[1]
areas_1[2]=dw_2x.object.cve_area_mayor_oblig[1]
areas_1[3]=dw_2x.object.cve_area_mayor_opt[1]
areas_1[4]=dw_2x.object.cve_area_opcion_terminal[1]
areas_1[5]=dw_2x.object.cve_area_servicio_social[1]
areas_1[6]=dw_2x.object.cve_area_integ_fundamental[1]
areas_1[7]=dw_2x.object.cve_area_integ_tema1[1]
areas_1[8]=dw_2x.object.cve_area_integ_tema2[1]
areas_1[9]=dw_2x.object.cve_area_integ_tema3[1]
areas_1[10]=dw_2x.object.cve_area_integ_tema4[1]

else
areas_1[1]=0
areas_1[2]=0
areas_1[3]=0
areas_1[4]=0
areas_1[5]=0
areas_1[6]=0
areas_1[7]=0
areas_1[8]=0
areas_1[9]=0
areas_1[10]=0

end if
	
SELECT aux.cve_proyecto_opc_term,aux.cve_seminario_tit
INTO :areas_1[11], :areas_1[12]
FROM aux_opcion_terminal aux
WHERE aux.cve_area = :areas_1[4]  using gtr_sce;




FOR Cont=1 TO 12
	if isnull(areas_1[Cont]) then 
		areas_1[Cont] =0
	end if
NEXT


Size = upperbound(areas_2[])

FOR Cont=1 TO Size
	if isnull(areas_2[Cont]) then 
		areas_2[Cont] =0
	end if
NEXT




Size = upperbound(areas_1[])


FOR Cont=1 TO Size
	
 	 SELECT area_mat.cve_mat
	 into :Clave
    FROM area_mat 
    WHERE ( area_mat.cve_area = :areas_1[Cont] ) AND  
          ( area_mat.cve_mat = :Clave_2 )    using gtr_sce;

	if gtr_sce.SQLCode = 100 then
		/* Not found*/
		Bandera=0
	else
		Bandera=1
		exit
	end if

NEXT


if (Clave_2=areas_1[11] or Clave_2=areas_1[12]) then
   Bandera=1
end if

if Bandera=1 then
	 return 1
else
Size = upperbound(areas_2[])	
FOR Cont=1 TO Size
	
 	 SELECT area_mat.cve_mat
	 into :Clave
    FROM area_mat 
    WHERE ( area_mat.cve_area = :areas_2[Cont] ) AND  
         ( area_mat.cve_mat = :Clave_2 )  using gtr_sce;

	if gtr_sce.SQLCode = 100 then
		/* Not found*/
		Bandera=0
	else
		Bandera=1
		exit
	end if

NEXT

end if



if Bandera=1 then
	return 1
else
	return 0
end if

end event

event clicked;//dw_5. Event actualiza()
//materia_x=sle_1.text
//if (this. EVENT verifica()=1 ) then
//	// Si Encontro la MATERIA en el PLAN
//	gb_5.visible=true
//	gb_2.visible=TRUE
//	st_2.visible=FALSE
//   st_1.visible=TRUE
//	dw_1.visible=TRUE
//	dw_2.visible=TRUE
//	dw_5.visible=TRUE
//	dw_5.retrieve(integer(materia_x),carrera_x,plan_x)
//	dw_1.retrieve(integer(materia_x),carrera_x,plan_x)
//	dw_2.retrieve(integer(materia_x))
//	st_1.visible=FALSE
//	st_2.visible=TRUE
//	
//else
//	gb_5.visible=false
//	st_2.visible=FALSE
//	st_1.visible=FALSE
//	dw_1.visible=FALSE
//	dw_2.visible=FALSE
//	dw_5.visible=FALSE
//	st_5.visible=FALSE
//	st_4.visible=FALSE
//	gb_2.visible=FALSE
//	st_6.visible=FALSE
//	st_7.visible=FALSE
//   messagebox("Información",    "       La MATERIA NO PERTENECE A LA CARRERA-PLAN. "+&
//	                          "~r~ Es necesario que se encuentre en algun AREA de la CARRERA "+&
//									  "~r~para poder accesar a esta pantalla.Si desea más Información"+&
//									  "~r~       Consulte al Administrador de la Base de Datos")
//	sle_1.SelectText(1, Len(sle_1.Text))
//	sle_1.setfocus()
//	m_prerrequisitos.m_registro.m_nuevo.disable( )
//	m_prerrequisitos.m_registro.m_actualizar.disable( )
//	m_prerrequisitos.m_registro.m_borraregistro.disable( )
//	m_prerrequisitos.m_registro.m_nuevoprerrequisito.disable ( )
//	m_prerrequisitos.m_registro.m_borrarprerrequisito.disable ( )
//	
//end if
//
//
//
//
//
//
DataWindowChild dw_child
int	iRtn

dw_5. Event actualiza()
materia_x=sle_1.text


	gb_5.visible=true
	gb_2.visible=TRUE
	st_2.visible=FALSE
   	st_1.visible=TRUE
	dw_1.visible=TRUE
	dw_2.visible=TRUE
	dw_5.visible=TRUE
	dw_2.retrieve(long(materia_x))
	if (dw_2.RowCount() > 0) then
		//if (dw_2.GetItemString(1,"nivel") = "L") then
		// Se cambia condición para considerar "L" y "T"  al mismo tiempo 
		if (dw_2.GetItemString(1,"nivel") <> "P") then 
			dw_5.dataobject = "dw_mad_prerrequisito_b"
			dw_5.settransobject(gtr_sce)
			
			//Obtiene el child datawindow
			iRtn = dw_5.GetChild("cve_subsistema",dw_child)
			// Revisar errores
			If iRtn =-1 then
				MessageBox("Error","No es posible obtener el datawindowchild de cve_subsistema",StopSign!)
			Else
				//Establece el transaction object
				//Recupera la información en base a la carrera y el plan
				dw_child.SetTransObject(gtr_sce)
				dw_child.Retrieve(carrera_x,plan_x)		
			End If			
		else
			dw_5.dataobject = "dw_mad_prerrequisito_pos_b"
			dw_5.settransobject(gtr_sce)
		end if
	end if

	dw_5.retrieve(long(materia_x),carrera_x,plan_x)
	dw_1.retrieve(long(materia_x),carrera_x,plan_x)
	st_1.visible=FALSE
	st_2.visible=TRUE
	




end event

type vsb_dw_certificado from vscrollbar within w_mad_prerrequisito
event constructor pbm_constructor
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
integer x = 3653
integer y = 52
integer width = 73
integer height = 144
boolean bringtotop = true
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event constructor;visible=FALSE
end event

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

int VarX
int Var_Carrera
int Var_Plan

/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
maxposition=dw_1.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */

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
		"La Tabla de Plan de Estudios NO esta actualizada,favor de consultar al administrador de la Base de Datos",Exclamation!)		
	else
		if VarX = 1 then
      	/*Esta carrera y plan SI estan validados por la SEP */
   	else
			/*Esta carrera y plan NO estan validados por la SEP */
	 	messagebox("Aviso", "La carrera actual junto con el plan NO estan reconocidos ante la SEP. Es posible que la tabla haya sido manipulada de alguna manera, ya que esta carrera SI estaba registrada ante la SEP, favor de consultar al administrador de la Base de Datos",Exclamation!)
		end if	
	end if
	
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

type vsb_dw_certificado3 from vscrollbar within w_mad_prerrequisito
event constructor pbm_constructor
event linedown pbm_sbnlinedown
event lineup pbm_sbnlineup
event moved pbm_sbnthumbtrack
event pagedown pbm_sbnpagedown
event pageup pbm_sbnpageup
event verifica ( )
integer x = 2784
integer y = 236
integer width = 178
integer height = 124
boolean stdwidth = false
integer minposition = 1
integer position = 1
end type

event linedown;/* En cuanto el usuario oprima la flecha-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_4.RowCount() then
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
maxposition=dw_4.RowCount()

/* Haz que el la ventana del DataWindow se mueva al cambiar la posición del ScrollBar */

dw_4.ScrollToRow(scrollpos)

plan_x=dw_4.object.cve_plan[dw_4.getrow()]
em_3x.text= string(dw_4.object.cve_plan[dw_4.getrow()])
end event

event pagedown;/* En cuanto el usuario oprima la página-abajo del ScrollBar... */

/* Verifica que no esté al final de los renglones del DataWindow */
if position<dw_4.RowCount() then
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

event verifica;int Total,Cont,Bandera
int Plan_P
Total = dw_4.rowcount()

Bandera = 0
Plan_P=integer(em_3x.text)

FOR Cont=1 TO Total
	if dw_4.object.cve_plan[Cont]=Plan_P then
		Bandera=1
		EVENT moved(Cont)
	end if
NEXT

If Bandera = 0 then
	messagebox("Aviso","El Plan : "+em_3x.text+"   , NO EXISTE.  Por Favor Verifique !",Exclamation!)
	em_3x.SelectText(1, Len(em_3x.Text))
	em_3x.setfocus()
end if

end event

type dw_1 from datawindow within w_mad_prerrequisito
event constructor pbm_constructor
event dberror pbm_dwndberror
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
event type integer carga ( string cuenta,  string carrera )
event borra_renglon ( )
event actualiza ( )
event nuevo ( integer band )
event botonazo pbm_dwnkey
event primero ( )
event ultimo ( )
event siguiente ( )
event anterior ( )
event type integer verifica ( )
event type integer verifica_2 ( )
event type integer verifica_3 ( )
integer x = 2021
integer y = 512
integer width = 1417
integer height = 1068
integer taborder = 60
string dataobject = "dw_mad_prerrequisito"
boolean vscrollbar = true
boolean border = false
end type

event constructor;/*En cuanto se construya el dw_1...*/

//
//enabled = false
visible = false
end event

event dberror;messagebox("",string(sqldbcode)+sqlerrtext+sqlsyntax)
return -1
end event

event retrieveend;///*Cuando dw_1 termine de leer los datos de la tabla...*/
//
integer cont

enabled = true
visible = true

if rowcount=0 then
	visible=FALSE
	st_5.visible=FALSE
	st_4.visible=TRUE
else
	
	visible=TRUE
	st_4.visible=FALSE
	st_5.visible=TRUE
	dw_1.SetRowFocusIndicator(Hand!) 
end if

	if dw_5.rowcount() > 0 then
		m_prerrequisitos.m_registro.m_nuevoprerrequisito.enable ( )
		m_prerrequisitos.m_registro.m_borrarprerrequisito.enable ( )
		m_prerrequisitos.m_registro.m_agregarprerrequisito.enable ( )
		
	else	
		m_prerrequisitos.m_registro.m_nuevoprerrequisito.disable ( )
		m_prerrequisitos.m_registro.m_borrarprerrequisito.disable ( )		
		m_prerrequisitos.m_registro.m_agregarprerrequisito.disable ( )
		

	end if 

end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */
if rowcount() > 0 then
if currentrow>0 then
	accepttext()
end if
end if

end event

event carga;///*Cuando se activa el evento carga...*/
//
///*Ve si nos hay cambios que no se hayan guardado*/
//event actualiza()
//
///*Haz un retrive con los parámetros que le pasaron, y ve si realmente se bajaron datos.*/
//If retrieve(long(cuenta),long(carrera))=0 &
//   then
//		/*Si no se bajaron datos, inserta un renglón nuevo en el DataWindow*/
//		
//		visible=false
//		enabled=false
//		return 0
//	else
//		/*Si se bajaron datos, pon el foco dentro del DataWindow*/
//		enabled=true
//		visible=true
//		SetFocus()
//		
		return 1
//end if
end event

event borra_renglon;integer cont
/*Cuando se activa el evento borra_renglon...*/

if rowcount() > 0 then
/*Pregunta para verificar que realmente se desea borrar el renglón*/
int respuesta
respuesta = messagebox("Atención","Esta seguro de querer Borrar EL PRERREQUISITO SELECCIONADO de la Materia Actual "+&
                       "",StopSign!,YesNo!,2)

if respuesta = 1 then
	/*Si realmente se desea borrar, borra el renglón actual y verifica que se haya logrado*/
	if deleterow(this.getrow())	= 1 then	
   /*Si se borro, llama a actualiza*/
//		dw_5. Event actualiza()
		
		/* Desaparece el Datawindow */
		if rowcount() =0 then
				enabled = false
				visible = false
		else
			for cont = 1 to rowcount() /*Se actualiza el campo de orden en base al renglon borrado*/
				Object.prerrequisitos_orden[cont]	=	cont
			next				
		end if
   else
		/*De lo contrario avisa que no se pudo borrar el renglón*/
		messagebox("Error","Por Alguna razon NO SE HAN GUARDADO LOS CAMBIOS ",StopSign!)	
	end if

elseif respuesta = 2 then
	/*Si no se quiere borrar el la materia, desecha los cambios hechos.*/
	rollback using gtr_sce;
end if
end if
end event

event actualiza;//
///*Si es asi, acepta el texto de la última columna editada*/
//AcceptText()
///*Ve si existen cambios en el DataWindow que no se hayan guardado*/
//if dw_1.ModifiedCount()+dw_1.DeletedCount() > 0 Then
//
//	/*Pregunta si se desean guardar los cambios hechos*/
//	int respuesta
//	respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
//
//	if respuesta = 1 &
//		then
//			/*Checa que los renglones cumplan con las reglas de validación*/
//			if update(true) = 1 then		
//				/*Si es asi, guardalo en la tabla y avisa.*/
//				commit using gtr_sce;
//				messagebox("Información","Se han guardado los cambios")			
//			else
//				/*De lo contrario, desecha los cambios (todos) y avisa*/
//				rollback using gtr_sce;
//				messagebox("Información",&
//			   "Algunos datos están incorrectos, favor de corregirlos. O bien trata de dar de Alta a una persona ya actualizada")	
//			end if
//	else
//		/*De lo contrario, solo avisa que no se guardó nada.*/
//		messagebox("Información","No se han guardado los cambios")
//	end if	
//end if	
end event

event nuevo(integer band);integer cont
long ll_cve_mat, ll_row_insercion, ll_num_rows

enabled=true
visible=true

SetFocus()
/*Inserta un nuevo renglón antes del renglon actual del DataWindow y haz un Scroll hacia él*/
if band = 1 then	
	scrolltorow(insertrow(getrow()))
	ll_row_insercion=getrow()
elseif band = 0 then
		scrolltorow(insertrow(0))
		ll_row_insercion=getrow()
end if

ll_cve_mat= long(materia_x)
ll_num_rows= RowCount()

Object.prerrequisitos_cve_mat[ll_row_insercion]=ll_cve_mat
Object.prerrequisitos_cve_carrera[ll_row_insercion]=carrera_x
Object.prerrequisitos_cve_plan[ll_row_insercion]=plan_x

for cont = 1 to rowcount()/*Se actualiza el campo de orden en base al nuevo renglon*/
	Object.prerrequisitos_orden[cont]	=	cont
next


end event

event botonazo;IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=8 then
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
			setcolumn(8)
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

event verifica;return 1
end event

event verifica_2;
return 1

end event

event verifica_3;return 1
end event

event itemchanged;bandera1	=	1
end event

type dw_2 from datawindow within w_mad_prerrequisito
integer y = 404
integer width = 2002
integer height = 248
string dataobject = "dw_mad_prerrequisito_c"
boolean border = false
boolean livescroll = true
end type

event constructor;visible=FALSE
end event

type gb_5 from groupbox within w_mad_prerrequisito
integer x = 114
integer y = 668
integer width = 1765
integer height = 440
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Registro :"
end type

type gb_4 from groupbox within w_mad_prerrequisito
integer x = 2007
integer y = 448
integer width = 1458
integer height = 1164
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Prerrequisitos :"
end type

type gb_3 from groupbox within w_mad_prerrequisito
integer x = 78
integer y = 64
integer width = 567
integer height = 252
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_mad_prerrequisito
integer x = 347
integer y = 1124
integer width = 1394
integer height = 480
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
string text = "Status"
end type

type dw_3 from datawindow within w_mad_prerrequisito
event constructor pbm_constructor
event dberror pbm_dwndberror
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
event type integer carga ( string cuenta,  string carrera )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
integer x = 699
integer y = 48
integer width = 2697
integer height = 160
string dataobject = "dw_titulacion_carrera"
boolean border = false
end type

event constructor;/*En cuanto se construya el dw_1...*/
settransobject(gtr_sce)

retrieve()



end event

event dberror;return -1
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

//int Cont

/*Verifica si se bajo más de un dato*/
if rowcount>1 then
	/*Si es así, haz visible el VerticalScrollBar*/
	vsb_dw_certificado2.visible=TRUE
	carrera_x=dw_3.object.cve_carrera[dw_3.getrow()]
	em_2x.text = string(dw_3.object.cve_carrera[dw_3.getrow()])
	em_2x.SelectText(1, Len(em_2x.Text))
	em_2x.setfocus()
	sle_1.setfocus()
else
	vsb_dw_certificado2.visible=FALSE
end if

//for Cont=1 to Rowcount() 
//	setitem(Cont,"digito",obten_digito(long(getitemnumber(Cont,"titulacion_cuenta"))))
//next


	

end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado2.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado2.position=currentrow

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
if dw_2.ModifiedCount()+dw_2.DeletedCount() > 0 Then

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
long VarX

enabled=true
visible=true
/*Pon el foco dentro del DataWindow*/
SetFocus()


/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))




end event

event botonazo;/* Evento que controla el TAB */
IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=10 then
			setcolumn(1)
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
		IF getcolumn()=1 then
			setcolumn(10)
			SetFocus()
			return -1
		end if	
	END IF
END IF

end event

type dw_4 from datawindow within w_mad_prerrequisito
event constructor pbm_constructor
event dberror pbm_dwndberror
event retrieveend pbm_dwnretrieveend
event rowfocuschanged pbm_dwnrowchange
event type integer carga ( string cuenta,  string carrera )
event borra_renglon ( )
event actualiza ( )
event nuevo ( )
event botonazo pbm_dwnkey
integer x = 709
integer y = 212
integer width = 2322
integer height = 160
string dataobject = "dw_plan_materia_plan"
boolean border = false
end type

event constructor;/*En cuanto se construya el dw_1...*/
settransobject(gtr_sce)

retrieve()



end event

event dberror;return -1
end event

event retrieveend;/*Cuando dw_1 termine de leer los datos de la tabla...*/

//int Cont

/*Verifica si se bajo más de un dato*/
if rowcount>1 then
	/*Si es así, haz visible el VerticalScrollBar*/
	vsb_dw_certificado3.visible=TRUE
	plan_x=dw_4.object.cve_plan[dw_4.getrow()]
	em_3x.text = string(dw_4.object.cve_plan[dw_4.getrow()])
	em_3x.SelectText(1, Len(em_3x.Text))
	em_3x.setfocus()
	sle_1.setfocus()
else
	vsb_dw_certificado3.visible=FALSE
end if

//for Cont=1 to Rowcount() 
//	setitem(Cont,"digito",obten_digito(long(getitemnumber(Cont,"titulacion_cuenta"))))
//next


	

end event

event rowfocuschanged;/* En cuanto el usuario cambie "manualmente" el focus del DataWindow... */

if currentrow>0 then
	accepttext()

	/* Ajusta el tamaño máximo del VerticalScroolBar al número de renglones obtenidos */
	vsb_dw_certificado3.maxposition=RowCount()

	/* Obtén en que renglón está y mueve el ScrollBar en consecuencia */
	vsb_dw_certificado3.position=currentrow

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
if dw_2.ModifiedCount()+dw_2.DeletedCount() > 0 Then

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
long VarX

enabled=true
visible=true
/*Pon el foco dentro del DataWindow*/
SetFocus()


/*Inserta un nuevo renglón al final del DataWindow y haz un Scroll hacia él*/
scrolltorow(insertrow(0))




end event

event botonazo;/* Evento que controla el TAB */
IF keyflags  = 0 THEN
	IF key = KeyTab! THEN
		IF getcolumn()=10 then
			setcolumn(1)
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
		IF getcolumn()=1 then
			setcolumn(10)
			SetFocus()
			return -1
		end if	
	END IF
END IF

end event

type gb_1 from groupbox within w_mad_prerrequisito
integer x = 18
integer width = 3438
integer height = 388
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
borderstyle borderstyle = styleraised!
end type

