$PBExportHeader$w_area_materia.srw
forward
global type w_area_materia from window
end type
type dw_areas from datawindow within w_area_materia
end type
type cb_borrar from commandbutton within w_area_materia
end type
type dw_cve_area from datawindow within w_area_materia
end type
type em_nom_area from editmask within w_area_materia
end type
type st_nom_area from statictext within w_area_materia
end type
type st_1 from statictext within w_area_materia
end type
type em_clave_area from editmask within w_area_materia
end type
type rr_clave_area from roundrectangle within w_area_materia
end type
type st_cb_group from statictext within w_area_materia
end type
type cb_insertar from commandbutton within w_area_materia
end type
type dw_verifica_nombre from datawindow within w_area_materia
end type
type dw_area_mat from datawindow within w_area_materia
end type
end forward

shared variables
//string dato
boolean modificar=FALSE
end variables

global type w_area_materia from window
integer x = 5
integer y = 4
integer width = 3648
integer height = 2400
boolean titlebar = true
string title = "Area-Materia"
string menuname = "m_menu_cat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
dw_areas dw_areas
cb_borrar cb_borrar
dw_cve_area dw_cve_area
em_nom_area em_nom_area
st_nom_area st_nom_area
st_1 st_1
em_clave_area em_clave_area
rr_clave_area rr_clave_area
st_cb_group st_cb_group
cb_insertar cb_insertar
dw_verifica_nombre dw_verifica_nombre
dw_area_mat dw_area_mat
end type
global w_area_materia w_area_materia

type variables
public boolean nuevaclave=FALSE,no_itemerror=FALSE
keycode lastkey
public string dato
end variables

on w_area_materia.create
if this.MenuName = "m_menu_cat" then this.MenuID = create m_menu_cat
this.dw_areas=create dw_areas
this.cb_borrar=create cb_borrar
this.dw_cve_area=create dw_cve_area
this.em_nom_area=create em_nom_area
this.st_nom_area=create st_nom_area
this.st_1=create st_1
this.em_clave_area=create em_clave_area
this.rr_clave_area=create rr_clave_area
this.st_cb_group=create st_cb_group
this.cb_insertar=create cb_insertar
this.dw_verifica_nombre=create dw_verifica_nombre
this.dw_area_mat=create dw_area_mat
this.Control[]={this.dw_areas,&
this.cb_borrar,&
this.dw_cve_area,&
this.em_nom_area,&
this.st_nom_area,&
this.st_1,&
this.em_clave_area,&
this.rr_clave_area,&
this.st_cb_group,&
this.cb_insertar,&
this.dw_verifica_nombre,&
this.dw_area_mat}
end on

on w_area_materia.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_areas)
destroy(this.cb_borrar)
destroy(this.dw_cve_area)
destroy(this.em_nom_area)
destroy(this.st_nom_area)
destroy(this.st_1)
destroy(this.em_clave_area)
destroy(this.rr_clave_area)
destroy(this.st_cb_group)
destroy(this.cb_insertar)
destroy(this.dw_verifica_nombre)
destroy(this.dw_area_mat)
end on

event open;//g_nv_security.fnv_secure_window (this)

dw_area_mat.SetTrans (gtr_sce)
//dw_area_mat.Insertrow(0)
dw_verifica_nombre.Visible=FALSE
dw_cve_area.SetTrans (gtr_sce)
dw_areas.SetTrans (gtr_sce)
/**/gnv_app.inv_security.of_SetSecurity(this)


end event

type dw_areas from datawindow within w_area_materia
integer x = 155
integer y = 1468
integer width = 1842
integer height = 204
integer taborder = 60
string dataobject = "dw_areas_modify"
boolean border = false
boolean livescroll = true
end type

event retrieveend;IF rowcount=0 THEN
	InsertRow(0)
	Object.cve_area[1]=dw_area_mat.Object.area_mat_cve_area[1]
	Object.total_mat[1]=dw_area_mat.Object.materias_tot[1]
ELSEIF rowcount=1 THEN
	IF Object.total_mat[1]<>dw_area_mat.Object.materias_tot[1] THEN
		IF MessageBox("Discrepancia","Los datos ~"Total de materias~" real  y almacenado ~nson distintos."+ "~nDesea actualizar el dato almacenado."+ &
		"~nreal  "+string(dw_area_mat.Object.materias_tot[1])+",~nalmacenado  "+string(Object.total_mat[1]),information!,YesNo!,2)=1 THEN 
			Object.total_mat[1]=dw_area_mat.Object.materias_tot[1]
			Update()
			Commit using gtr_sce;
			Retrieve(dw_area_mat.Object.area_mat_cve_area[1])
		END IF
	END IF	
END IF

end event

event sqlpreview;if sqltype=PreviewUpdate!  then MessageBox("Preview UpDate()",sqlsyntax)
end event

type cb_borrar from commandbutton within w_area_materia
event dwnkey pbm_dwnkey
integer x = 2821
integer y = 1040
integer width = 311
integer height = 112
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "E&liminar"
end type

event dwnkey;if keydown (KeyEnter!) then 
	This.triggerevent (clicked!)
end if
end event

event clicked;dw_area_mat.triggerevent ("row_delete")
dw_area_mat.SetFocus()
end event

type dw_cve_area from datawindow within w_area_materia
event checkey pbm_dwnkey
integer x = 379
integer y = 52
integer width = 2592
integer height = 204
integer taborder = 10
string dataobject = "dw_ext_cve_area"
boolean border = false
boolean livescroll = true
end type

event checkey;lastkey=key
//IF (key=KeyEnter! OR  key=KeyTab!) AND this.AcceptText()=-1 THEN
//	Return 1
//END IF


//IF This.Object.clavedearea.current = This.Object.clavedearea.original  THEN
//	This.SetFocus()
//ELSE
//	dw_cve_area.border=FALSE
//	dw_cve_area.Object.DataWindow.Color =10789024
//	dw_cve_area.Object.DataWindow.Zoom =100
//	dw_cve_area.Object.clavedearea.y = 12
//	dw_cve_area.Object.mensaje.Visible = 0
//	dw_cve_area.Object.clavedearea_t.Visible = 1
//END IF
//ELSE
//	<action2>
//END IF
//
end event

event losefocus;this.AcceptText()
IF This.Object.clavedearea.current = This.Object.clavedearea.original  THEN
	This.SetFocus()
ELSE
	nuevaclave=FALSE
	dw_cve_area.border=FALSE
	dw_cve_area.Object.DataWindow.Color =10789024
	dw_cve_area.Object.DataWindow.Zoom =100
	dw_cve_area.Object.clavedearea.y = 12
	dw_cve_area.Object.mensaje.Visible = 0
	dw_cve_area.Object.clavedearea_t.Visible = 1
END IF
end event

event itemerror;//Messagebox("ItemError Event","")
Return 1
end event

event error;Messagebox("Error Event","")
end event

event itemchanged;int RowTotal
RowTotal = dw_area_mat.Retrieve(long(data))
IF not nuevaclave THEN
	IF RowTotal < 1  THEN
		MessageBox("Verificar","Aun NO EXISTE un Area-Materia con la clave : " + data +" en la Base de Datos")
		dwo.primary[row]=0
		return 1					
	END IF
ELSE
	IF RowTotal > 0 THEN
		MessageBox("Verificar","YA EXISTE un  Area-Materia con la clave : " + data +" en la Base de Datos")
		dw_area_mat.Reset()
		dwo.primary[row]=0
		return 1					
	ELSE
		cb_borrar.Enabled=TRUE
		cb_insertar.Enabled=TRUE
	END IF
	IF  lastkey=KeyEnter! THEN
		This.TriggerEvent(LoseFocus!)
	END IF
END IF	
end event

type em_nom_area from editmask within w_area_materia
integer x = 1559
integer y = 164
integer width = 855
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
alignment alignment = center!
textcase textcase = upper!
boolean displayonly = true
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string displaydata = "Ä"
end type

type st_nom_area from statictext within w_area_materia
integer x = 754
integer y = 156
integer width = 695
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Nombre del Area"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type st_1 from statictext within w_area_materia
integer x = 754
integer y = 60
integer width = 695
integer height = 92
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 12632256
boolean enabled = false
string text = "Clave del Area"
alignment alignment = center!
boolean border = true
boolean focusrectangle = false
end type

type em_clave_area from editmask within w_area_materia
integer x = 1559
integer y = 60
integer width = 247
integer height = 80
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 15793151
boolean enabled = false
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = "("
end type

event modified;
IF dw_area_mat.Retrieve(Integer(This.Text)) < 1 AND KeyDown(KeyEnter!) THEN
	
	MessageBox("Verificar","Aun NO EXISTE el area clave : " + this.Text +	&
					" en la Base de Datos")
//ELSE
//	dw_area_mat.InsertRow(0)
END IF

end event

type rr_clave_area from roundrectangle within w_area_materia
long linecolor = 15793151
integer linethickness = 3
long fillcolor = 10789024
integer x = 32
integer y = 28
integer width = 3278
integer height = 252
integer cornerheight = 45
integer cornerwidth = 40
end type

type st_cb_group from statictext within w_area_materia
integer x = 2811
integer y = 748
integer width = 338
integer height = 116
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "MS Sans Serif"
long backcolor = 10789024
boolean enabled = false
string text = "Operaciones de Renglon:"
boolean focusrectangle = false
end type

type cb_insertar from commandbutton within w_area_materia
event clicked pbm_bnclicked
event getfocus pbm_bnsetfocus
integer x = 2821
integer y = 896
integer width = 306
integer height = 112
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Agr&egar"
end type

event clicked;dw_area_mat.triggerevent ("row_insert")
dw_area_mat.SetFocus()
end event

event getfocus;//IF keydown (KeyEnter!) THEN
//	This.TriggerEvent(Clicked!)
//END IF
//if keydown (KeyEnter!) then 
//	This.triggerevent (clicked!)
//end if
end event

type dw_verifica_nombre from datawindow within w_area_materia
event key pbm_dwnkey
integer x = 635
integer y = 620
integer width = 2277
integer height = 588
integer taborder = 30
string dataobject = "w_op_nombre"
boolean vscrollbar = true
boolean livescroll = true
end type

event key;IF Key=KeyEnter! THEN	
	dw_area_mat.SetRow(1)
	dato=string(This.GetItemNumber(This.GetRow(),"cve_mat"))
	dw_area_mat.TriggerEvent("row_modify")
	dw_area_mat.SetFocus()
END IF



end event

event losefocus;dw_area_mat.SetColumn("area_mat_cve_mat")
dw_verifica_nombre.Visible=FALSE


end event

type dw_area_mat from datawindow within w_area_materia
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event checkey pbm_dwnkey
event row_modify ( )
event row_insert ( )
event row_delete ( )
event dw_new ( )
event dw_del ( )
event db_update ( )
integer x = 41
integer y = 320
integer width = 3200
integer height = 1372
integer taborder = 20
string dataobject = "dw_area_materia"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event primero;SetPointer(HourGlass!)
dw_area_mat.Retrieve(1)
//em_clave_area.Text="1"
dw_cve_area.SetItem(1,1,1)

end event

event anterior;Integer	corriente,rango,anterior=0
SetPointer(HourGlass!)
corriente = dw_cve_area.GetItemNumber(1,1)
IF IsNull(corriente) = TRUE OR corriente<3	THEN
	dw_area_mat.Retrieve(1)
	dw_cve_area.SetItem(1,1,1)
ELSE
	DO 
		anterior=0	
		rango = corriente -100	
		SELECT area_mat.cve_area 
		INTO :anterior  
		FROM area_mat  
		WHERE ( area_mat.cve_area < :corriente ) AND (area_mat.cve_area > :rango )  
		ORDER BY area_mat.cve_area DESC using gtr_sce;	
		IF 0<>anterior THEN
			dw_area_mat.Retrieve(anterior)
			dw_cve_area.SetItem(1,1,anterior)
			return
		END IF
		corriente	= corriente -100
	LOOP WHILE  corriente<>anterior
END IF

end event

event siguiente;Integer	corriente,siguiente=0,cont,max,rango
SetPointer(HourGlass!)
corriente = Object.area_mat_cve_area[1]
IF IsNull(corriente)=FALSE OR corriente>0 THEN
	int res=1
	string letras
	SELECT max(area_mat.cve_area )
	INTO :max 
	FROM area_mat  
	WHERE ( area_mat.cve_area >= :corriente ) using gtr_sce;
	if corriente>=max then Return
	DO 
		siguiente = 0	
		rango = corriente + 100
		SELECT min(area_mat.cve_area )
		INTO :siguiente  
		FROM area_mat  
		WHERE ( area_mat.cve_area > :corriente ) AND (area_mat.cve_area < :rango )  using gtr_sce;
		IF siguiente>0 THEN
			dw_area_mat.Retrieve(siguiente)
			dw_cve_area.SetItem(1,1,siguiente)
			return
		END IF
		corriente	= corriente +100
	LOOP WHILE  corriente<>siguiente	
ELSE
	dw_area_mat.TriggerEvent("ultimo")
END IF
end event

event ultimo;Integer	ultimo

SetPointer(HourGlass!)
SELECT max(area_mat.cve_area )
INTO :ultimo
FROM area_mat   using gtr_sce; 
//ORDER BY area_mat.cve_area DESC 
dw_area_mat.Retrieve(ultimo)
//em_clave_area.Text=string(ultimo)
dw_cve_area.SetItem(1,1,ultimo)

end event

event checkey;IF Key=KeyEnter! AND This.GetColumnName()="materias_materia" THEN
//	This.SetRow(1)
	This.TriggerEvent("row_insert")
	Return 1
ELSE
	IF (Key=KeyTab! OR Key=KeyDownArrow!) AND This.GetColumnName()="materias_materia" &
		AND dw_verifica_nombre.Visible=TRUE THEN
		dw_verifica_nombre.SetFocus()
	END IF
END IF

end event

event row_modify();long	clave,area
decimal creditos
string		materia
clave=long(dato)
   SELECT materias.materia,   
          materias.creditos  
   INTO :materia,   
        :creditos  
   FROM materias  
   WHERE materias.cve_mat = :clave  using gtr_sce;	
	IF gtr_sce.SQLCode=100 THEN
		MessageBox("Error: Clave Inexistente","La clave " + Dato + &
					" no esta registrada en la Base de Datos. Verifique y reintente.",	&
					StopSign!)
	dw_area_mat.DeleteRow(dw_area_mat.GetRow())
	dw_area_mat.InsertRow(1)
	ELSE
//		area=Integer(em_clave_area.Text)
		area=dw_cve_area.Object.Data[1,1]
		this.SetItem(this.GetRow(),"materias_materia",materia)
		this.SetItem(this.GetRow(),"materias_creditos",creditos)	
		this.SetItem(this.GetRow(),"area_mat_cve_mat",clave)
//		this.SetItem(this.GetRow(),"area_mat_cve_area",area)
	END IF
	This.SetRow(1)
end event

event row_insert;IF MessageBox("Confirmar","Se agregara un nuevo renglon",Information!,OKCancel!,2)=1 THEN	
		This.InsertRow(1)
//		This.SetItem(1,"area_mat_cve_area",dw_cve_area.Object.Data[1,1])//integer(em_clave_area.Text))
		Object.area_mat_cve_area[1]=dw_cve_area.Object.Data[1,1]
		This.ScrollToRow(1)
		This.TriggerEvent(RowFocusChanged!)
END IF
end event

event row_delete;IF MessageBox("Confirmar","Se eliminara el renglón seleccionado",Information!,OKCancel!,2)=1 THEN	
		DeleteRow(GetRow())//(This.GetRow())
END IF

end event

event dw_new;nuevaclave = TRUE
dw_cve_area.border=TRUE
dw_cve_area.borderStyle=StyleRaised!
dw_cve_area.Object.DataWindow.Color =0
dw_cve_area.Object.DataWindow.Zoom =120
dw_cve_area.Object.clavedearea.y = 40
dw_cve_area.Object.mensaje.Visible = 1
dw_cve_area.Object.clavedearea.primary[1]=0
dw_cve_area.Object.clavedearea_t.Visible = 0
dw_cve_area.Object.nombredearea.Visible = 0
dw_cve_area.Object.nombredearea_t.Visible = 0
dw_cve_area.SetFocus()

end event

event dw_del;int cuenta,TotalRenglones
TotalRenglones=This.RowCount()
MessageBox("Total de Renglones",string(TotalRenglones))
FOR cuenta=1 TO TotalRenglones
	This.DeleteRow(1)	
NEXT
dw_areas.DeleteRow(0)
IF MessageBox("Confirimar","¿Desea BORRAR los registros de Area-Materia con clave ~""+ &
					/*em_clave_area.Text*/string(dw_cve_area.Object.data[1,1])+"~" de la Base de Datos?" &
					,Question!,yesNo!,2 ) = 1 THEN
	Update()				
	This.triggerevent ("db_update")
END IF

end event

event db_update;//IF THEN
	dw_areas.object.data[1,1] = dw_cve_area.object.data[1,1]
	IF /*dw_cve_area.Update() = 1 AND*/ dw_areas.Update()=1 AND Update()=1  THEN
		if MessageBox("Confirimar","¿Desea actualizar la Base de Datos con las modificaciones efectuadas?",	&
		Question!,YesNo!,2 ) = 1 then
			COMMIT USING gtr_sce;
		end if	
//		messagebox("Resultado","...La base de datos ha sido actualizada")
	ELSE
		ROLLBACK USING gtr_sce;
		messagebox("Error","La actualización no fue realizada",STOPSIGN!)	
	END IF
	Reset()
	dw_areas.Reset()
	dw_cve_area.object.data[1,1] = 0  //sobre el "primary buffer"
	dw_cve_area.SetColumn(1)	
	dw_cve_area.SetText("0")			//sobre el "edit control"
//END IF
end event

event constructor;Object.area_mat_cve_area.visible=0
m_menu_cat.dw = This
dw_verifica_nombre.SetTrans(gtr_sce)
this.Modify("cred_min.Alignment='2'")/* esta linea se agrego debido 
													a la imposibilidad de asignar 
													tal valor en el painter del DW*/
end event

event editchanged;string columna
IF dw_area_mat.GetColumnName()="materias_materia" THEN
	SetPointer(HourGlass!)
	dw_verifica_nombre.retrieve(data+"%")	
	dw_verifica_nombre.Visible=TRUE
END IF
end event

event itemchanged;integer	clave,renglon
string	materia
IF GetColumnName()="area_mat_cve_mat"	THEN
	dato=data	// data es una variable global
	FOR renglon=1 TO RowCount()
		if object.area_mat_cve_mat[renglon]=long(data) Then 
			MessageBox("Aviso","La Clave de materia"+data+", ya existe en esta Area-Materia",Exclamation!)
			no_itemerror=TRUE
			SetText("")
			Return 1
		else
			no_itemerror=FALSE
		end if	
	NEXT

	this.TriggerEvent("row_modify")
//	dw_cve_area.SetItem(1,1,integer(data))
END IF
end event

event rowfocuschanged;IF This.GetRow()=0 THEN	 //Las tres siguientes lineas evitan el desbordamiento del programa.	
	Return						//En el evento de usuario "dw_del" provoca un cambio de renglon  cuando el buffer primario
END IF							//se vacia  y el codigo restante de este script trata de accesar a un row/colunm invalido
IF /*This.GetRow()=1 	AND*/ IsNull(This.GetItemNumber(This.GetRow(),"area_mat_cve_mat")) THEN
	This.Modify("materias_materia.Edit.DisplayOnly=NO")
	This.SetTabOrder("area_mat_cve_mat",5)
	This.SetColumn("area_mat_cve_mat")
ELSE
	This.Modify("materias_materia.Edit.DisplayOnly=YES")
	This.SetTabOrder("area_mat_cve_mat",0)
END IF	
end event

event retrieveend;int cve_area,cred_min
string buffer

IF rowcount>0 THEN	
	if dw_areas.Retrieve(Object.area_mat_cve_area[1])<>1 then dw_areas.InsertRow(0)
	cb_insertar.Enabled=True
	cb_borrar.Enabled=True
	cve_area=This.GetItemnumber(1,"area_mat_cve_area")//integer(em_clave_area.text)
	IF rowcount>0 THEN
   	SELECT areas.creditos_min  
   	INTO :cred_min  
   	FROM areas  
   	WHERE areas.cve_area = :cve_area   using gtr_sce;
		IF gtr_sce.SQLCode=100 THEN
//				seleccionar colorbackground="medium_gray"
			This.Object.Cred_min_t.BackGround.color=RGB(127,127,127)
			This.Object.Cred_min_t.Text=" null en area_mat "
		ELSE
		This.Object.Cred_min_t.BackGround.color=RGB(255,255,255)
		if IsNull(cred_min) then cred_min = 0
		This.Object.Cred_min_t.Text=" "+string(cred_min)+" "
		END IF
	END IF
ELSE
	cb_insertar.Enabled=FALSE
	cb_borrar.Enabled=FALSE
END IF
end event

event sqlpreview;if request=PreviewFunctionUpdate! then MessageBox("Preview UpDate()",sqlsyntax)
end event

event itemerror;IF GetColumnName()="area_mat_cve_mat"	AND no_itemerror THEN Return 1
end event

