$PBExportHeader$w_cat_materias.srw
forward
global type w_cat_materias from window
end type
type st_1 from statictext within w_cat_materias
end type
type p_1 from picture within w_cat_materias
end type
type cbx_capt_asist from checkbox within w_cat_materias
end type
type cbx_modificar from checkbox within w_cat_materias
end type
type dw_key from datawindow within w_cat_materias
end type
type dw_sigla from datawindow within w_cat_materias
end type
type dw_nombre from datawindow within w_cat_materias
end type
type dw_sigla_anterior from datawindow within w_cat_materias
end type
end forward

shared variables
integer counter=0

end variables

global type w_cat_materias from window
integer x = 5
integer y = 4
integer width = 3657
integer height = 3364
boolean titlebar = true
string title = "Materias"
string menuname = "m_menu_cat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 78682240
st_1 st_1
p_1 p_1
cbx_capt_asist cbx_capt_asist
cbx_modificar cbx_modificar
dw_key dw_key
dw_sigla dw_sigla
dw_nombre dw_nombre
dw_sigla_anterior dw_sigla_anterior
end type
global w_cat_materias w_cat_materias

type variables
Boolean EnUltimaColumna
Boolean modificar=FALSE
KeyCode lastkey
int lastcolumn
end variables

on w_cat_materias.create
if this.MenuName = "m_menu_cat" then this.MenuID = create m_menu_cat
this.st_1=create st_1
this.p_1=create p_1
this.cbx_capt_asist=create cbx_capt_asist
this.cbx_modificar=create cbx_modificar
this.dw_key=create dw_key
this.dw_sigla=create dw_sigla
this.dw_nombre=create dw_nombre
this.dw_sigla_anterior=create dw_sigla_anterior
this.Control[]={this.st_1,&
this.p_1,&
this.cbx_capt_asist,&
this.cbx_modificar,&
this.dw_key,&
this.dw_sigla,&
this.dw_nombre,&
this.dw_sigla_anterior}
end on

on w_cat_materias.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.cbx_capt_asist)
destroy(this.cbx_modificar)
destroy(this.dw_key)
destroy(this.dw_sigla)
destroy(this.dw_nombre)
destroy(this.dw_sigla_anterior)
end on

event open;dw_key.SetTransObject (gtr_sce)
dw_nombre.SetTransObject (gtr_sce)
dw_sigla.SetTransObject (gtr_sce)
dw_sigla_anterior.SetTransObject (gtr_sce)
dw_key.Insertrow(0)
dw_nombre.Visible=FALSE
dw_sigla.Visible=FALSE
dw_sigla_anterior.Visible=FALSE
/**/gnv_app.inv_security.of_SetSecurity(this)


//g_nv_security.fnv_secure_window (this)
end event

type st_1 from statictext within w_cat_materias
integer x = 713
integer y = 112
integer width = 192
integer height = 88
boolean bringtotop = true
integer textsize = -14
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 255
long backcolor = 16777215
string text = "DSE"
boolean focusrectangle = false
end type

type p_1 from picture within w_cat_materias
integer x = 14
integer y = 32
integer width = 681
integer height = 264
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type cbx_capt_asist from checkbox within w_cat_materias
integer x = 489
integer y = 364
integer width = 645
integer height = 76
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "Ca&ptura asistida"
boolean lefttext = true
end type

event clicked;int column
column=dw_key.GetColumn()
dw_key.SetFocus()
dw_key.SetColumn(column)
end event

type cbx_modificar from checkbox within w_cat_materias
integer x = 2267
integer y = 364
integer width = 709
integer height = 76
boolean bringtotop = true
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 16777215
long backcolor = 8421376
string text = "Nuevo Registro"
boolean automatic = false
boolean lefttext = true
end type

event clicked;string mod_protected=	"materias_cve_depto.Protect=1"&
							+"materias_nivel.Protect=1"&
							+"materias_evaluacion.Protect=1"&
							+"materias_supervision.Protect=1"&
							+"materias_creditos.Protect=1"&
							+"materias_carga_academica.Protect=1"&
							+"materias_cobro_especial.Protect=1"&
							+"materias_horas_practica.Protect=1"&
							+"materias_horas_teoria.Protect=1"&
							+"materias_horas_total.Protect=1"
							
string mod_unprotected= "materias_cve_depto.Protect=0"&
							+"materias_nivel.Protect=0"&
							+"materias_evaluacion.Protect=0"&
							+"materias_supervision.Protect=0"&
							+"materias_creditos.Protect=0"&
							+"materias_carga_academica.Protect=0"&
							+"materias_cobro_especial.Protect=0"&
							+"materias_horas_practica.Protect=0"&
							+"materias_horas_teoria.Protect=0"&
							+"materias_horas_total.Protect=0"
							
/*********************************************************************************/
//IF  This.Checked=TRUE THEN
//	dw_key.modify(mod_unprotected)
//ELSE
//	dw_key.modify(mod_protected)
//END IF
//dw_key.SetFocus()
		
end event

type dw_key from datawindow within w_cat_materias
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event checkey pbm_dwnkey
event dw_del ( )
event db_update ( )
event dw_new ( )
integer x = 5
integer y = 320
integer width = 3547
integer height = 2800
integer taborder = 10
string dataobject = "w_materias2"
end type

event primero;SetPointer(HourGlass!)
dw_key.Retrieve(1)
end event

event anterior;Long	corriente,anterior
SetPointer(HourGlass!)
corriente = dw_key.GetItemNumber(dw_key.GetRow(),"materias_cve_mat")
IF corriente<>0 THEN
	SELECT materias.cve_mat  
	INTO :anterior  
	FROM materias  
	WHERE ( materias.cve_mat < :corriente )   
	ORDER BY materias.cve_mat DESC  using gtr_sce;
	IF gtr_sce.SQLCode=100 THEN
		dw_key.Retrieve(1)
	ELSE
		dw_key.Retrieve(anterior)
	END IF
ELSE
	dw_key.Retrieve(1)
END IF
	
end event

event siguiente;Long	corriente,siguiente
SetPointer(HourGlass!)
corriente = This.GetItemNumber(This.GetRow(),"materias_cve_mat")
IF corriente<>0 THEN
	SELECT materias.cve_mat  
	INTO :siguiente  
	FROM materias  
	WHERE ( materias.cve_mat > :corriente )   
	ORDER BY materias.cve_mat ASC  using gtr_sce;
	CHOOSE CASE gtr_sce.SQLCode
	CASE 100
		dw_key.Retrieve(corriente)
	CASE 0
		dw_key.Retrieve(siguiente)
	CASE -1	
		IF gtr_sce.SQLdbCode=0 THEN
			This.Retrieve(siguiente)
		ELSE
		MessageBox("Error en la Base de Datos",string(gtr_sce.SQLDBCode)+":"+gtr_sce.SQLErrText)
		END IF
	END CHOOSE		
ELSE
	This.TriggerEvent("ultimo")
END IF	
end event

event ultimo;Long	ultimo
SetPointer(HourGlass!)
SELECT materias.cve_mat  
INTO :ultimo  
FROM materias  
ORDER BY materias.cve_mat DESC  using gtr_sce;
dw_key.Retrieve(ultimo)

end event

event checkey;lastkey = key
lastcolumn = This.GetColumn()
//IF  Key=KeyTab! THEN
//	CHOOSE CASE This.GetColumnName()
//	CASE "materias_cobro_especial"
//		This.SetColumn("materias_cve_mat")
//		Return 1
//	CASE	"materias_materia"
//		IF dw_nombre.Visible=TRUE THEN
//			dw_nombre.SetFocus()
////		ELSEIF cbx_modificar.Checked=FALSE THEN
////			This.SetColumn("materias_cve_mat")	
////			Return 1 	
//		END IF
//	CASE	"materias_sigla"
//		IF dw_sigla.Visible=TRUE THEN
//			dw_sigla.SetFocus()
//		END IF
//	END CHOOSE
//END IF	
IF key=KeyEnter! THEN
	IF This.GetColumn()=12 THEN
		This.SetColumn(1)
	ELSE
		This.SetColumn(This.GetColumn()+1)
	END IF		
	Return 1
END IF
end event

event dw_del;IF MessageBox("Confirimar","¿Desea BORRAR este registro de la Base de Datos?",	&
					Question!, yesNo!, 2 ) = 1 THEN
	deleterow(GetRow())
	Update()
	InsertRow(0)
END IF
/* ya que el Data Window Solo Trea un renglon el argumento '0' tambien funcionaria*/	

end event

event db_update;//IF NOT cbx_modificar.Checked THEN Return

IF Update()=1 THEN
	IF MessageBox("Confirimar","La Actualizacion es valida. ¿Desea Concretarla?",Question!,YesNo!,2 ) = 1 THEN
		COMMIT USING gtr_sce;
	ELSE
		ROLLBACK USING gtr_sce;
	END IF
ELSE
	ROLLBACK USING gtr_sce;
	MessageBox("Error","El registro no ha podido ser actualizado~ndB Admin messge:~n"+gtr_sce.SQLErrText,StopSign!)
END IF
Reset()
InsertRow(0)
SetColumn(1)

end event

event dw_new;cbx_modificar.Checked=TRUE
Reset()
InsertRow(0)
SetColumn(1)


end event

event itemchanged;IF This.GetColumnName()="materias_cve_mat" THEN
	IF This.Retrieve(long(data))=0 THEN
		long clave_mat,buf
		SELECT materias.cve_mat  
		INTO :buf  
		FROM materias  
		WHERE ( materias.cve_mat >= :clave_mat )  
		ORDER BY materias.cve_mat ASC   using gtr_sce;
		CHOOSE CASE gtr_sce.SQLCode
		CASE 100
//			MessageBox("","...not found")
		CASE 0
//			MessageBox("","...succes")
		CASE -1	
//			MessageBox("Error en la Base de Datos",string(gtr_sce.SQLDBCode)+":"+gtr_sce.SQLErrText)
		END CHOOSE
		This.InsertRow(0)	
		This.SetItem(1,1,long(data))
		This.SetText(data)
		cbx_modificar.Checked=TRUE
	END  IF	
END IF	

	CHOOSE CASE This.GetColumnName()
	CASE "materias_cobro_especial"
//		This.SetColumn("materias_cve_mat")
//		Return 1
	CASE	"materias_materia"
		IF dw_nombre.Visible=TRUE THEN
			dw_nombre.SetFocus()
//		ELSEIF cbx_modificar.Checked=FALSE THEN
//			This.SetColumn("materias_cve_mat")	
//			Return 1 	
		END IF
	CASE	"materias_sigla"
		IF dw_sigla.Visible=TRUE THEN
			dw_sigla.SetFocus()
		END IF
	CASE	"sigla_anterior"
		IF dw_sigla_anterior.Visible=TRUE THEN
			dw_sigla_anterior.SetFocus()
		END IF

	CASE "materias_cve_coordinacion"
		
		STRING ls_tipo_periodo 
		LONG ll_cve_coordinacion
		
		ll_cve_coordinacion = LONG (data) 
		
		SELECT tipo_periodo
		INTO :ls_tipo_periodo
		FROM coordinaciones 
		WHERE cve_coordinacion = :ll_cve_coordinacion 
		USING gtr_sce; 
		
		IF ISNULL(ls_tipo_periodo) THEN ls_tipo_periodo = "" 
		
		IF TRIM(ls_tipo_periodo) = "" THEN 
			MESSAGEBOX("Error", "La coordinación no tiene definido un tipo de periodo.") 
			THIS.SETTEXT("")
			RETURN 2 
		END IF
			
		THIS.SETITEM(row, "tipo_periodo", ls_tipo_periodo)


END CHOOSE
end event

event editchanged;IF cbx_capt_asist.Checked=TRUE THEN
	IF dw_key.GetColumnName()="materias_materia" THEN
		dw_nombre.retrieve(data+"%")
		dw_nombre.Visible=TRUE
	END IF
	IF dw_key.GetColumnName()="materias_sigla" THEN
		dw_sigla.retrieve(data+"%")
		dw_sigla.Visible=TRUE
	END IF
	IF dw_key.GetColumnName()="sigla_anterior" THEN
		dw_sigla_anterior.retrieve(data+"%")
		dw_sigla_anterior.Visible=TRUE
	END IF
END IF
end event

event constructor;m_menu_cat.dw = This

end event

event getfocus;/*materias_*/
dw_key.SetColumn("materias_cve_mat")
end event

event dberror;MessageBox("dB Error# "+string(sqldbcode),"Descripcion:"+sqlerrtext)
end event

event retrieveend;IF	rowcount<1 THEN cbx_modificar.Checked=TRUE ELSE cbx_modificar.Checked=FALSE

end event

event sqlpreview;//if request=PreviewFunctionUpdate! then MessageBox("SQL Preview","SQL Sentence:~n"+sqlsyntax)
end event

type dw_sigla from datawindow within w_cat_materias
event checkey pbm_dwnkey
integer x = 320
integer y = 612
integer width = 2665
integer height = 644
boolean bringtotop = true
string dataobject = "dw_op_sigla"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event checkey;IF key=KeyEnter! THEN
	dw_key.Retrieve(This.GetItemNumber(This.GetRow(),"cve_mat") )
	dw_key.SetFocus()
END IF
IF key=Keyc! or Key=KeyC! THEN
	dw_key.Object.Data[1,2]=This.GetItemString(This.GetRow(),"sigla")
	dw_key.SetFocus()
	dw_key.SetColumn(3)
END IF
IF key=KeyEscape! THEN
	dw_key.SetFocus()
	dw_key.SetColumn(4)
END IF

end event

event losefocus;dw_key.SetColumn("materias_cve_coordinacion")
This.Visible=FALSE


end event

type dw_nombre from datawindow within w_cat_materias
event checkey pbm_dwnkey
integer x = 489
integer y = 924
integer width = 2665
integer height = 644
boolean bringtotop = true
string dataobject = "w_op_nombre"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event checkey;IF key=KeyEnter! THEN
	dw_key.retrieve(This.GetItemNumber(This.GetRow(),"cve_mat") )
	dw_key.SetFocus()
END IF
IF key=Keyc! or Key=KeyC! THEN
	dw_key.Object.Data[1,3] = This.GetItemString(This.GetRow(),"materia")
	dw_key.SetFocus()
	dw_key.SetColumn(4)
END IF
IF key=KeyEscape! THEN
	dw_key.SetFocus()
	dw_key.SetColumn(4)
END IF

end event

event losefocus;dw_key.SetColumn("materias_cve_coordinacion")
This.Visible=FALSE


end event

type dw_sigla_anterior from datawindow within w_cat_materias
event checkey pbm_dwnkey
integer x = 480
integer y = 604
integer width = 2665
integer height = 644
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_op_sigla_anterior"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event checkey;IF key=KeyEnter! THEN
	dw_key.Retrieve(This.GetItemNumber(This.GetRow(),"cve_mat") )
	dw_key.SetFocus()
END IF
IF key=Keyc! or Key=KeyC! THEN
	dw_key.Object.Data[1,2]=This.GetItemString(This.GetRow(),"sigla")
	dw_key.SetFocus()
	dw_key.SetColumn(3)
END IF
IF key=KeyEscape! THEN
	dw_key.SetFocus()
	dw_key.SetColumn(4)
END IF

end event

event losefocus;dw_key.SetColumn("materias_cve_coordinacion")
This.Visible=FALSE


end event

