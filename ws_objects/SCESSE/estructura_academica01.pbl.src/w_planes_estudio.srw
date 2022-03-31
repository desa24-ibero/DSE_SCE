$PBExportHeader$w_planes_estudio.srw
forward
global type w_planes_estudio from window
end type
type dw_autorizacion from datawindow within w_planes_estudio
end type
type st_1 from statictext within w_planes_estudio
end type
type p_1 from picture within w_planes_estudio
end type
type em_clave from editmask within w_planes_estudio
end type
type cbx_nuevo from checkbox within w_planes_estudio
end type
type dw_tab from datawindow within w_planes_estudio
end type
type dw_key from datawindow within w_planes_estudio
end type
type dw_tab2 from datawindow within w_planes_estudio
end type
type cb_matmin from commandbutton within w_planes_estudio
end type
end forward

shared variables
string carreraplan
keycode lastkey
boolean modificar=FALSE 
end variables

global type w_planes_estudio from window
integer x = 832
integer y = 364
integer width = 5307
integer height = 3148
boolean titlebar = true
string title = "Planes de Estudio"
string menuname = "m_menu_cat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 16777215
dw_autorizacion dw_autorizacion
st_1 st_1
p_1 p_1
em_clave em_clave
cbx_nuevo cbx_nuevo
dw_tab dw_tab
dw_key dw_key
dw_tab2 dw_tab2
cb_matmin cb_matmin
end type
global w_planes_estudio w_planes_estudio

type variables
long il_cve_carrera, il_cve_plan
Datawindowchild dwc_periodo 

uo_periodo_servicios iuo_periodo_servicios

long il_cve_carrera_p, il_cve_planp
long il_cve_carrera_f, il_cve_planf

long il_cve_carrera_act, il_cve_plan_act_max, il_cve_plan_act_min 
end variables

forward prototypes
public function integer wf_primer_carrera ()
public function integer wf_ultima_carrera ()
end prototypes

public function integer wf_primer_carrera ();
 // Se recupera la menor carrera 
SELECT min(plan_estudios.cve_carrera)  
INTO		:il_cve_carrera_p 
FROM plan_estudios 
WHERE plan_estudios.cve_carrera > 0
USING gtr_sce; 
 
 // Se recupera el primer plan 
SELECT MIN(plan_estudios.cve_plan)  
INTO	:il_cve_planp 
FROM plan_estudios 
WHERE plan_estudios.cve_carrera = :il_cve_carrera_p 
USING gtr_sce;  

RETURN 0  
end function

public function integer wf_ultima_carrera ();
 // Se recupera la menor carrera 
SELECT MAX(plan_estudios.cve_carrera)  
INTO		:il_cve_carrera_f 
FROM plan_estudios 
USING gtr_sce; 
 
 // Se recupera el primer plan 
SELECT MAX(plan_estudios.cve_plan)  
INTO	:il_cve_planf 
FROM plan_estudios 
WHERE plan_estudios.cve_carrera = :il_cve_carrera_f  
USING gtr_sce;  

RETURN 0  


end function

on w_planes_estudio.create
if this.MenuName = "m_menu_cat" then this.MenuID = create m_menu_cat
this.dw_autorizacion=create dw_autorizacion
this.st_1=create st_1
this.p_1=create p_1
this.em_clave=create em_clave
this.cbx_nuevo=create cbx_nuevo
this.dw_tab=create dw_tab
this.dw_key=create dw_key
this.dw_tab2=create dw_tab2
this.cb_matmin=create cb_matmin
this.Control[]={this.dw_autorizacion,&
this.st_1,&
this.p_1,&
this.em_clave,&
this.cbx_nuevo,&
this.dw_tab,&
this.dw_key,&
this.dw_tab2,&
this.cb_matmin}
end on

on w_planes_estudio.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_autorizacion)
destroy(this.st_1)
destroy(this.p_1)
destroy(this.em_clave)
destroy(this.cbx_nuevo)
destroy(this.dw_tab)
destroy(this.dw_key)
destroy(this.dw_tab2)
destroy(this.cb_matmin)
end on

event open;
dw_key.SetTransObject (gtr_sce)
dw_tab.SetTransObject (gtr_sce)
//dw_key.Insertrow(0)

//g_nv_security.fnv_secure_window (this)
/**/gnv_app.inv_security.of_SetSecurity(this)

//Modif. Roberto Novoa Jun/2016 .- Funcionalidad periodos multiples
//f_dddw_converter(dw_key, dwc_periodo, "plan_estudios_periodo_ini")
//f_dddw_converter(dw_key, dwc_periodo, "plan_estudios_periodo_vigencia")


iuo_periodo_servicios = CREATE uo_periodo_servicios 
iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, 'L', gtr_sce)  
iuo_periodo_servicios.f_modifica_lista_columna( dw_key, "plan_estudios_periodo_vigencia", 'L') 

wf_primer_carrera() 
wf_ultima_carrera() 


//dw_autorizacion.SETTRANSOBJECT(gtr_sce) 
//dw_autorizacion.INSERTROW(0) 





end event

type dw_autorizacion from datawindow within w_planes_estudio
integer x = 338
integer y = 2504
integer width = 2418
integer height = 108
integer taborder = 30
string title = "none"
string dataobject = "dw_seleccion_autorizacion_recon"
boolean border = false
boolean livescroll = true
end type

type st_1 from statictext within w_planes_estudio
integer x = 699
integer y = 104
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

type p_1 from picture within w_planes_estudio
integer x = 23
integer y = 24
integer width = 635
integer height = 196
boolean bringtotop = true
string picturename = "logoibero-web.png"
boolean focusrectangle = false
end type

type em_clave from editmask within w_planes_estudio
integer x = 562
integer y = 268
integer width = 325
integer height = 88
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 16777215
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = stringmask!
string mask = "!!!!!!!!"
end type

event modified;string ls_separador, ls_nombre_separador, ls_carreraplan, ls_carrera, ls_plan
integer li_pos
long carrera,plan

ls_separador = "-"
ls_nombre_separador= "guion"
ls_carreraplan=text

li_pos = Pos(ls_carreraplan, ls_separador)
dw_tab2.reset() 


if isnull(li_pos) or li_pos = 0 then
	MessageBox("Plan Invalido", "Favor de separar la carrera y el plan con un "+&
	            ls_nombre_separador+" ["+ls_separador+"]", StopSign!)
	return
end if

ls_carrera = mid(text, 1, li_pos -1 )
ls_plan = mid(text, li_pos + 1)

carrera = long(ls_carrera)
plan = long(ls_plan)

if not isnumber(ls_carrera) or carrera= 0 then
	MessageBox("Carrera Invalida", "La carrera ["+ls_carrera+"] no es valida.", StopSign!)
	return
end if

if not isnumber(ls_plan) or plan=0 then
	MessageBox("Plan Invalido", "El plan ["+ls_plan+"] no es valido.", StopSign!)
	return
end if

if not f_existe_carrera(carrera) then
	MessageBox("Carrera Inexistente", "La carrera ["+ls_carrera+"] no esta dado de alta.", StopSign!)
	return
end if

if not f_existe_plan(plan)  then
	MessageBox("Plan Inexistente", "El plan ["+ls_plan+"] no esta dado de alta.", StopSign!)
	return
end if

// Se verifica si existe la Carrera-Plan 
//LONG ll_existe 
//SELECT COUNT(*) 
//INTO :ll_existe 
//FROM plan_estudios 
//WHERE cve_carrera = :carrera  
//AND cve_plan = :plan 
//USING gtr_sce; 
//IF gtr_sce.SQLCODE < 0 THEN 
//	MESSAGEBOX("Error", "Se produjo un error al verificar la existencia de la Carrera-Plan: " + gtr_sce.SQLERRTEXT) 
//	RETURN 
//END IF 
// Si existe se pasa la clave a las variables de instancia y se despliega el nuevo registro
//IF ll_existe > 0 THEN 
//	MESSAGEBOX("Error", "Se produjo un error al verificar la existencia de la Carrera-Plan: " + gtr_sce.SQLERRTEXT) 
	il_cve_carrera= carrera
	il_cve_plan= plan
//END IF 	

dw_key.TriggerEvent("ue_movi_clave")


MessageBox("Carrera :"+String(carrera), "Plan :"+string(plan))

end event

type cbx_nuevo from checkbox within w_planes_estudio
integer x = 2789
integer y = 136
integer width = 626
integer height = 76
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 12639424
string text = "Nuevo Registro"
boolean automatic = false
end type

type dw_tab from datawindow within w_planes_estudio
boolean visible = false
integer x = 1358
integer y = 1472
integer width = 1239
integer height = 700
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_tab_total_cred"
boolean border = false
boolean livescroll = true
end type

type dw_key from datawindow within w_planes_estudio
event trigg_retrieve ( dwobject dwo,  integer row )
event dwnkey pbm_dwnkey
event db_update ( )
event dw_del ( )
event dw_new ( )
event primero ( )
event ultimo ( )
event siguiente ( )
event anterior ( )
event post_keydown ( )
event tab pbm_dwntabout
event ue_movi_clave ( )
event cambia_lista_periodo ( )
integer y = 240
integer width = 5198
integer height = 2268
integer taborder = 10
string dataobject = "dw_planes_estudio_bis"
boolean border = false
end type

event trigg_retrieve;string data="0000",columna,renglon
columna=this.Getcolumnname()
renglon=string(this.GetRow())
data=columna+","+renglon
messagebox("col,row",renglon+","+columna)
this.SetColumn("plan_estudios_cve_carrera")
em_clave.SetFocus()
//data=this.GetText()
data=string(il_cve_carrera)+string(il_cve_plan)

messagebox("GetText",data)
this.SetColumn("plan_estudios_cred_total")

////this.AcceptText()
//
//data = columna+">"+ &
//		string(This.GetItemNumber(this.GetRow(),"plan_estudios_cve_carrera"))+ &
//		"<"+renglon
//messagebox("GetItemNumber",data)
//data=this.GetText()
//data="["+columna+","+renglon+"]"
//messagebox("GetText",data)
end event

event dwnkey;IF This.GetColumnName()="plan_estudios_cve_carrera" THEN
	lastkey=key
END IF
IF key=KeyEnter! THEN
	int next_col
	next_col =  This.GetColumn()+1
	IF next_col=20 THEN
		This.SetColumn(1)
	ELSE
		This.SetColumn(next_col)
	END IF		
	This.AcceptText()
	Return 1
END IF

end event

event db_update();integer carrera
string mensaje,dato
icon icono
//dato = string( GetItemNumber(GetRow(),"plan_estudios_cve_carrera") )
//carrera = integer(Left(dato,len(dato)-1))
//SetItem(GetRow(),"plan_estudios_cve_carrera",carrera) 

IF THIS.ROWCOUNT() > 0 THEN 
	IF ISNULL(THIS.GETITEMNUMBER(1, "plan_estudios_activo")) THEN 
		THIS.SETITEM(1, "plan_estudios_activo",1)
	END IF 
END IF 

SetItem(GetRow(),"plan_estudios_cve_carrera",il_cve_carrera) 
IF  Update()=1 THEN//AND gtr_sce.SQLNRows > 0 THEN
	COMMIT USING gtr_sce;
	mensaje="Autorizada."
	icono=Information!
	
	/**/
	INTEGER le_autorizacion 
	STRING ls_error
	le_autorizacion = dw_autorizacion.GETITEMNUMBER(1,1) 
	IF ISNULL(le_autorizacion) THEN le_autorizacion = 0 
	
	IF le_autorizacion > 0 THEN 
		// Se hace actualización de la autorización. 
		UPDATE carreras 
		SET idAutorizacionReconocimiento = :le_autorizacion
		WHERE cve_carrera = :il_cve_carrera 
		USING gtr_sce; 
		IF gtr_sce.SQLCODE < 0 THEN
			ls_error = gtr_sce.SQLERRTEXT 
			ROLLBACK USING gtr_sce; 
			MESSAGEBOX("Error", "Se produjo un error al actualizar la Autorización Reconocimiento en carreras: " + ls_error )
		END IF
		COMMIT USING gtr_sce; 

		UPDATE CarrerasDGP 
		SET idAutorizacionReconocimiento = :le_autorizacion  
		WHERE cve_carrera = :il_cve_carrera 
		USING gtr_sce; 		
		IF gtr_sce.SQLCODE < 0 THEN
			ROLLBACK USING gtr_sce;  
			ls_error = gtr_sce.SQLERRTEXT 
			MESSAGEBOX("Error", "Se produjo un error al actualizar la Autorización Reconocimiento en CarrerasDGP : " + ls_error )
		END IF
		COMMIT USING gtr_sce; 
	END IF 	
	/**/
	
ELSE
	ROLLBACK USING gtr_sce;
	mensaje="No autorizada.~n DBMS Err: #"+string(gtr_sce.SQLDBCode)+" , "+gtr_sce.SQLErrText
	icono=StopSign!
END IF
Messagebox("Actualizacion de Registros",mensaje,icono)
Reset()
dw_tab.Reset()
//SetItem(GetRow(),"plan_estudios_cve_carrera",integer(dato))
//SetColumn("plan_estudios_cve_carrera")
dw_key.TriggerEvent("ue_movi_clave")
em_clave.SetFocus()


end event

event dw_del();MessageBox("",integer(dw_key.GetRow()))
dw_key.DeleteRow(dw_key.GetRow())
//dw_key.Update()
string mensaje
icon icono
IF  dw_key.Update()=1 THEN//AND gtr_sce.SQLNRows > 0 THEN
	COMMIT USING gtr_sce;
	mensaje="...Exitosa!  "
	icono=Information!
ELSE
	ROLLBACK USING gtr_sce;
	mensaje="...Fracasada  "
	icono=StopSign!
END IF

INTEGER le_row

le_row = dw_key.Insertrow(0)
//dw_key.SETITEM(le_row, "plan_estudios_tipo_periodo", gs_tipo_periodo) 
dw_tab.Reset()
Messagebox("Eliminacion de registro...",mensaje,icono)


end event

event dw_new();int row
INTEGER le_row
//row=dw_key.GetRow()
//dw_key.DeleteRow(row)
Reset()
le_row = InsertRow(0)
//dw_key.SETITEM(le_row, "plan_estudios_tipo_periodo", gs_tipo_periodo) 
dw_tab.Reset()
cbx_nuevo.Checked=TRUE
end event

event primero();
long res_carrera,res_plan,row
string clave
 
 row = This.GetRow()

wf_primer_carrera() 
 
clave = string(il_cve_carrera_p)+"-"+string(il_cve_planp)
This.Retrieve(il_cve_carrera_p,il_cve_planp)

il_cve_carrera = il_cve_carrera_p
il_cve_plan = il_cve_planp

em_clave.Text= clave
em_clave.SetFocus()

dw_key.SETFOCUS() 





// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 
// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 

//long res_carrera,res_plan,row
//string clave
// 
// row = This.GetRow()
// SELECT Distinct min(plan_estudios.cve_carrera),   
//         plan_estudios.cve_plan
// INTO		:res_carrera,:res_plan
// FROM plan_estudios 
// WHERE plan_estudios.cve_plan>0
// HAVING plan_estudios.cve_plan>0 using gtr_sce;
//// ORDER BY plan_estudios.cve_carrera ASC,
////				plan_estudios.cve_plan ASC 
////MessageBox("QUERY primero",string(res_carrera)+"--carrera     plan--"+string(res_plan))
////clave = string(res_carrera)+string(res_plan)
//clave = string(res_carrera)+"-"+string(res_plan)
//This.Retrieve(res_carrera,res_plan)
////This.SetItem(row,"plan_estudios_cve_carrera",integer(clave))
//em_clave.Text= clave
//em_clave.SetFocus()
//
//dw_key.SETFOCUS() 
////MessageBox("","     Hola!!!!")
//
//
//
//


end event

event ultimo();long res_carrera,res_plan,row
string clave
 
 row = This.GetRow()

wf_ultima_carrera() 
 
clave = string(il_cve_carrera_f)+"-"+string(il_cve_planf)
This.Retrieve(il_cve_carrera_f,il_cve_planf)

il_cve_carrera = il_cve_carrera_p
il_cve_plan = il_cve_planp

em_clave.Text= clave
em_clave.SetFocus()

dw_key.SETFOCUS() 




//integer res_carrera,res_plan
//string clave
// SELECT max(plan_estudios.cve_carrera),   
//         plan_estudios.cve_plan
// INTO		:res_carrera,:res_plan
// FROM plan_estudios  
// ORDER BY plan_estudios.cve_carrera DESC,
//				plan_estudios.cve_plan DESC using gtr_sce;
////MessageBox("QUERY",string(res_carrera)+"--carrera     plan--"+string(res_plan))
////clave = string(res_carrera)+string(res_plan)
//clave = string(res_carrera)+"-"+string(res_plan)
//This.Retrieve(res_carrera,res_plan)
////This.SetItem(This.GetRow(),"plan_estudios_cve_carrera",integer(clave))
//em_clave.Text = clave
//em_clave.SetFocus()

end event

event siguiente();LONG res_carrera,res_plan,row, plan, carrera 
STRING clave
LONG ll_carrera_sig, ll_plan_sig 
 
row = This.GetRow()  
 
wf_primer_carrera()  
 
row = GetRow()
plan = il_cve_plan
carrera = il_cve_carrera

// Se verifica si existe la carrera o si se trata de la primera 
IF IsNull(carrera) THEN 
	TriggerEvent("Ultimo")
	Return
ELSEIF plan = il_cve_planf and carrera = il_cve_carrera_f THEN	 
	Return
END IF

// Se recupera el plan siguiente 
SELECT MIN(plan_estudios.cve_plan)  
INTO :ll_plan_sig 
FROM plan_estudios 
WHERE plan_estudios.cve_carrera = :carrera 
AND plan_estudios.cve_plan > :plan 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el plan de la carrera " + gtr_sce.SQLERRTEXT)
END IF 		

// Se verifica si ya no existe ningún plan anterior. 
IF ISNULL(ll_plan_sig) THEN 
	
	// Se recupera la carrera anterior 
	SELECT MIN(plan_estudios.cve_carrera)
	INTO :ll_carrera_sig
	FROM plan_estudios 
	WHERE plan_estudios.cve_carrera > :carrera 
	USING gtr_sce;  
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar la carrera anterior " + gtr_sce.SQLERRTEXT)
	END IF 	
	
	// Se recupera el plan más grande para esta carrera 
	SELECT MIN(plan_estudios.cve_plan)  
	INTO :ll_plan_sig 
	FROM plan_estudios 
	WHERE plan_estudios.cve_carrera = :ll_carrera_sig 
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar el plan de la carrera anterior " + gtr_sce.SQLERRTEXT)
	END IF 		
ELSE 
	ll_carrera_sig = carrera 
	
END IF  

il_cve_carrera= ll_carrera_sig
il_cve_plan= ll_plan_sig
Retrieve(ll_carrera_sig,ll_plan_sig)
Object.plan_estudios_cve_carrera[row]=integer(string(ll_carrera_sig)+string(ll_plan_sig))
em_clave.text= string(ll_carrera_sig)+"-"+string(ll_plan_sig)









// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 
// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 
// CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL  CODIGO ORIGINAL 


//  int carrera,arg1,arg2,plan,row ,max_carrera=100
//  string buf
// row = GetRow()
// plan = Object.plan_estudios_cve_plan[row]
//// carrera = (Object.plan_estudios_cve_carrera[row] - plan)/10
////carrera =integer( left(string(Object.plan_estudios_cve_carrera[row]),len(string(Object.plan_estudios_cve_carrera[row]))-1)  )
//carrera=il_cve_carrera
//SELECT max(plan_estudios.cve_carrera) 
//INTO		:max_carrera
//FROM plan_estudios   using gtr_sce;
//IF IsNull(carrera) THEN 
//	TriggerEvent("Ultimo")
//	Return
//ELSEIF plan=4 and carrera=max_carrera THEN	
//	Return
//END IF
//DO
//	arg1=0
//	arg2=0
//	plan++
//	IF plan=5 THEN 
//		plan=1
//		carrera++
//	END IF
//	SELECT plan_estudios.cve_carrera,plan_estudios.cve_plan  
// 	INTO		:arg1,:arg2
//	FROM plan_estudios  
//	WHERE (plan_estudios.cve_carrera =:carrera AND plan_estudios.cve_plan = :plan) using gtr_sce; 
//	if arg2<>0 then 
//		Retrieve(arg1,arg2)
//		Object.plan_estudios_cve_carrera[row]=integer(string(arg1)+string(arg2))
//		il_cve_carrera= arg1
//		il_cve_plan= arg2
//		em_clave.text= string(arg1)+"-"+string(arg2)
//	end if	
//LOOP WHILE arg1=0
//
end event

event anterior();LONG res_carrera,res_plan,row, plan, carrera 
STRING clave
LONG ll_carrera_ant, ll_plan_ant 
 
row = This.GetRow()  
 
wf_primer_carrera()  
 
row = GetRow()
plan = il_cve_plan
carrera = il_cve_carrera

// Se verifica si existe la carrera o si se trata de la primera 
IF IsNull(carrera) THEN 
	TriggerEvent("Primero")
	Return
ELSEIF plan = il_cve_planp and carrera = il_cve_carrera_p THEN	 
	Return
END IF

// Se recupera el plan anterior 
SELECT MAX(plan_estudios.cve_plan)  
INTO :ll_plan_ant 
FROM plan_estudios 
WHERE plan_estudios.cve_carrera = :carrera 
AND plan_estudios.cve_plan < :plan 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el plan de la carrera " + gtr_sce.SQLERRTEXT)
END IF 		

// Se verifica si ya no existe ningún plan anterior. 
IF ISNULL(ll_plan_ant) THEN 
	
	// Se recupera la carrera anterior 
	SELECT MAX(plan_estudios.cve_carrera)
	INTO :ll_carrera_ant
	FROM plan_estudios 
	WHERE plan_estudios.cve_carrera < :carrera 
	USING gtr_sce;  
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar la carrera anterior " + gtr_sce.SQLERRTEXT)
	END IF 	
	
	// Se recupera el plan más grande para esta carrera 
	SELECT MAX(plan_estudios.cve_plan)  
	INTO :ll_plan_ant 
	FROM plan_estudios 
	WHERE plan_estudios.cve_carrera = :ll_carrera_ant 
	USING gtr_sce; 
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar el plan de la carrera anterior " + gtr_sce.SQLERRTEXT)
	END IF 		
ELSE 
	ll_carrera_ant = carrera 	
END IF  

il_cve_carrera= ll_carrera_ant
il_cve_plan= ll_plan_ant
Retrieve(ll_carrera_ant,ll_plan_ant)
Object.plan_estudios_cve_carrera[row]=integer(string(ll_carrera_ant)+string(ll_plan_ant))
em_clave.text= string(ll_carrera_ant)+"-"+string(ll_plan_ant)








// Código Original  Código Original  Código Original  Código Original  Código Original  Código Original  Código Original  Código Original  Código Original 
// Código Original  Código Original  Código Original  Código Original  Código Original  Código Original  Código Original  Código Original  Código Original 

// int carrera,arg1,arg2,plan,row 
// row = GetRow()
//// plan = Object.plan_estudios_cve_plan[row]
//// carrera = (Object.plan_estudios_cve_carrera[row] - plan)/10
// plan = il_cve_plan
// carrera = il_cve_carrera
// IF IsNull(carrera) THEN 
//	TriggerEvent("Primero")
//	Return
//ELSEIF plan=1 and carrera=10 THEN	
//	Return
//END IF
//DO
//	arg1=0
//	arg2=0
//	plan --
//	IF plan=0 THEN 
//		plan=4
//		carrera --
//	END IF
//	SELECT plan_estudios.cve_carrera,plan_estudios.cve_plan  
// 	INTO		:arg1,:arg2
//	FROM plan_estudios  
//	WHERE (plan_estudios.cve_carrera =:carrera AND plan_estudios.cve_plan = :plan) using gtr_sce; 
//	if arg2<>0 then 
//		Retrieve(arg1,arg2)
//		Object.plan_estudios_cve_carrera[row]=integer(string(arg1)+string(arg2))
//		il_cve_carrera= arg1
//		il_cve_plan= arg2
//		em_clave.text= string(arg1)+"-"+string(arg2)
//	end if	
//LOOP WHILE arg1=0
//
end event

event post_keydown;string setting,col_tab_seq
	int new_col_tab_seq
	col_tab_seq = This.GetColumnName() + ".TabSequence"
	setting = This.Describe(col_tab_seq)
	new_col_tab_seq = integer(setting) + 10
	col_tab_seq += "=" + string(new_col_tab_seq)
	This.Modify(col_tab_seq)
	MessageBox("","")
end event

event ue_movi_clave();long carrera,plan
long carrera_int,plan_int
string carrera_txt,plan_txt
char nivel_txt
INTEGER le_row 

	carrera = il_cve_carrera
	plan = il_cve_plan
	carreraplan= string(carrera)+string(plan)
	
	IF dw_key.Retrieve(carrera,plan)<1 THEN
		le_row = InsertRow(0)
//		dw_key.SETITEM(le_row, "plan_estudios_tipo_periodo", gs_tipo_periodo) 
		dw_tab.InsertRow(0)
		IF messagebox ("Clave Inexistente","¿Desea crear un nuevo plan de estudios" &
			+" con clave: "+carreraplan+" ?",Question!,YesNo!,2)=1 THEN
			This.SetItem(dw_key.Getrow(),"plan_estudios_cve_carrera",long(carreraplan))
			 SELECT carreras.carrera,   
         			carreras.nivel,   
        				 nombre_plan.nombre_plan  
			 INTO	:carrera_txt,:nivel_txt,:plan_txt	
   			 FROM carreras,   
       			  nombre_plan  
  			 WHERE ( carreras.cve_carrera = :carrera ) AND  
       			  ( nombre_plan.cve_plan = :plan )   using gtr_sce;
			IF gtr_sce.SQLCode=100 THEN
				Messagebox("Verifique informacion","No existe carrera alguna con clave: "+string(carrera))
//				dwo.primary[row]=0  
			ELSE 
				dw_key.SetItem(dw_key.Getrow(),"plan_estudios_cve_plan",plan)
				dw_key.SetItem(dw_key.Getrow(),"carreras_carrera",carrera_txt)
				dw_key.SetItem(dw_key.Getrow(),"carreras_nivel",nivel_txt)
				dw_key.SetItem(dw_key.Getrow(),"nombre_plan_nombre_plan",plan_txt)
				dw_key.SetColumn("plan_estudios_cred_total")
			END IF
		END IF
	END IF		
	
//ELSEIF	GetColumnName()="llave"/*"plan_estudios_cve_carrera"*/ AND lastkey=KeyTab! THEN
//	MessageBox("Advertencia","Se requieren privilegios para alterar los subsecuentes campos."+ &
//					"~r Sin los privilegios adecuados sera imposible continuar")
//END IF
//
end event

event cambia_lista_periodo();
STRING ls_tipo_periodo
ls_tipo_periodo = dw_key.GETITEMSTRING(1, "plan_estudios_tipo_periodo") 
IF ISNULL(ls_tipo_periodo) THEN ls_tipo_periodo = "" 
IF TRIM(ls_tipo_periodo) = "" THEN RETURN 
iuo_periodo_servicios.f_carga_periodos( ls_tipo_periodo, 'L', gtr_sce)  
iuo_periodo_servicios.f_modifica_lista_columna( dw_key, "plan_estudios_periodo_ini", 'L')  
iuo_periodo_servicios.f_modifica_lista_columna( dw_key, "plan_estudios_periodo_vigencia", 'L')  
INTEGER le_null
SETNULL(le_null)





end event

event itemchanged;
INTEGER le_row , le_null
SETNULL(le_null) 

// Se filtra el tipo de periodo seleccionado 
IF dwo.name = "plan_estudios_tipo_periodo" THEN 
	dw_key.SETITEM(1, "plan_estudios_periodo_ini", le_null)
	dw_key.SETITEM(1, "plan_estudios_periodo_vigencia", le_null) 	
	PostEvent("cambia_lista_periodo") 
END IF

IF GetColumnName()="plan_estudios_cve_carrera" AND lastkey=KeyEnter! THEN
	carreraplan=data
	long carrera,plan
	carrera = long(Left(data,len(data)-1))
	plan = long(Right(data,1))
	IF Retrieve(long(carrera),long(plan))<1 THEN
		le_row = InsertRow(0)
		//dw_key.SETITEM(le_row, "plan_estudios_tipo_periodo", gs_tipo_periodo) 
		dw_tab.InsertRow(0)
		IF messagebox ("Clave Inexistente","¿Desea crear un nuevo plan de estudios" &
			+" con clave: "+carreraplan+" ?",Question!,YesNo!,2)=1 THEN
			This.SetItem(row,"plan_estudios_cve_carrera",long(carreraplan))
			long carrera_int,plan_int
			string carrera_txt,plan_txt
			char nivel_txt
			 SELECT carreras.carrera,   
         			carreras.nivel,   
        				 nombre_plan.nombre_plan  
			 INTO	:carrera_txt,:nivel_txt,:plan_txt	
   			 FROM carreras,   
       			  nombre_plan  
  			 WHERE ( carreras.cve_carrera = :carrera ) AND  
       			  ( nombre_plan.cve_plan = :plan )   using gtr_sce;
			IF gtr_sce.SQLCode=100 THEN
				Messagebox("Verifique informacion","No existe carrera alguna con clave: "+string(carrera))
				dwo.primary[row]=0  
			ELSE 
				This.SetItem(row,"plan_estudios_cve_plan",plan)
				This.SetItem(row,"carreras_carrera",carrera_txt)
				This.SetItem(row,"carreras_nivel",nivel_txt)
				This.SetItem(row,"nombre_plan_nombre_plan",plan_txt)
				This.SetColumn("plan_estudios_cred_total")
			END IF
		END IF
	END IF		
ELSEIF	GetColumnName()="llave"/*"plan_estudios_cve_carrera"*/ AND lastkey=KeyTab! THEN
	MessageBox("Advertencia","Se requieren privilegios para alterar los subsecuentes campos."+ &
					"~r Sin los privilegios adecuados sera imposible continuar")
END IF

end event

event retrieveend;Integer li_i , li_new, ll_cvearea , ll_find , ll_cve

IF rowcount>0 THEN
	cbx_nuevo.Checked=FALSE
	int	row 
	row = Getrow()
//	SetItem(row,"plan_estudios_cve_carrera",long(carreraplan))
	SetItem(row,"plan_estudios_cve_carrera",long(string(il_cve_carrera)+string(il_cve_plan)))
	dw_tab.Retrieve ( GetItemNumber(row,"plan_estudios_cve_area_basica"), &
							GetItemNumber(row,"plan_estudios_cve_area_mayor_oblig"), &
							GetItemNumber(row,"plan_estudios_cve_area_mayor_opt"), &
							GetItemNumber(row,"plan_estudios_cve_area_servicio_social"), &
							GetItemNumber(row,"plan_estudios_cve_area_opcion_terminal"), &
							GetItemNumber(row,"plan_estudios_cve_area_sintesis_eval_oblig"), &
							GetItemNumber(row,"plan_estudios_cve_area_sintesis_eval_opt"))	  
	
If dw_tab.rowcount() > 0 then
	for li_i = 1 to 7
		CHOOSE CASE li_i 
			case 1
			    	ll_cve = this.object.plan_estudios_cve_area_basica[row]
				
				ll_find = dw_tab.Find( "areas_cve_area = " + String( ll_cve ) +" ", 1, dw_tab.Rowcount())
				
				 if ll_find > 0 then
							li_new = dw_tab2.insertrow(0)
							dw_tab2.object.creditos[li_new] = dw_tab.object.materias_creditos[ll_find]
							dw_tab2.object.areas_totales[li_new] = 	dw_tab.object.areas_total_materias[ll_find]
							dw_tab2.object.creditos_min[li_new] = 	dw_tab.object.areas_creditos_min[ll_find]
						else
								li_new = dw_tab2.insertrow(0)
				end if

	
		case 2
			    	ll_cve = this.object.plan_estudios_cve_area_mayor_oblig[row]
				
				ll_find = dw_tab.Find( "areas_cve_area = " + String( ll_cve ) +" ", 1, dw_tab.Rowcount())
				
				 if ll_find > 0 then
							li_new = dw_tab2.insertrow(0)
							dw_tab2.object.creditos[li_new] = dw_tab.object.materias_creditos[ll_find]
							dw_tab2.object.areas_totales[li_new] = 	dw_tab.object.areas_total_materias[ll_find]
							dw_tab2.object.creditos_min[li_new] = 	dw_tab.object.areas_creditos_min[ll_find]
						else
								li_new = dw_tab2.insertrow(0)
				end if
				
				case 3
			    	ll_cve = this.object.plan_estudios_cve_area_mayor_opt[row]
				
				ll_find = dw_tab.Find( "areas_cve_area = " + String( ll_cve ) +" ", 1, dw_tab.Rowcount())
				
				 if ll_find > 0 then
							li_new = dw_tab2.insertrow(0)
							dw_tab2.object.creditos[li_new] = dw_tab.object.materias_creditos[ll_find]
							dw_tab2.object.areas_totales[li_new] = 	dw_tab.object.areas_total_materias[ll_find]
							dw_tab2.object.creditos_min[li_new] = 	dw_tab.object.areas_creditos_min[ll_find]
						else
								li_new = dw_tab2.insertrow(0)
				end if
				
				case 4
			    	ll_cve = this.object.plan_estudios_cve_area_servicio_social[row]
				
				ll_find = dw_tab.Find( "areas_cve_area = " + String( ll_cve ) +" ", 1, dw_tab.Rowcount())
				
				 if ll_find > 0 then
							li_new = dw_tab2.insertrow(0)
							dw_tab2.object.creditos[li_new] = dw_tab.object.materias_creditos[ll_find]
							dw_tab2.object.areas_totales[li_new] = 	dw_tab.object.areas_total_materias[ll_find]
							dw_tab2.object.creditos_min[li_new] = 	dw_tab.object.areas_creditos_min[ll_find]
						else
								li_new = dw_tab2.insertrow(0)
				end if
				
				case 5
			    	ll_cve = this.object.plan_estudios_cve_area_opcion_terminal[row]
				
				ll_find = dw_tab.Find( "areas_cve_area = " + String( ll_cve ) +" ", 1, dw_tab.Rowcount())
				
				 if ll_find > 0 then
							li_new = dw_tab2.insertrow(0)
							dw_tab2.object.creditos[li_new] = dw_tab.object.materias_creditos[ll_find]
							dw_tab2.object.areas_totales[li_new] = 	dw_tab.object.areas_total_materias[ll_find]
							dw_tab2.object.creditos_min[li_new] = 	dw_tab.object.areas_creditos_min[ll_find]
						else
								li_new = dw_tab2.insertrow(0)
				end if
				
				case 6
			    	ll_cve = this.object.plan_estudios_cve_area_sintesis_eval_oblig[row]
				
				ll_find = dw_tab.Find( "areas_cve_area = " + String( ll_cve ) +" ", 1, dw_tab.Rowcount())
				
				 if ll_find > 0 then
							li_new = dw_tab2.insertrow(0)
							dw_tab2.object.creditos[li_new] = dw_tab.object.materias_creditos[ll_find]
							dw_tab2.object.areas_totales[li_new] = 	dw_tab.object.areas_total_materias[ll_find]
							dw_tab2.object.creditos_min[li_new] = 	dw_tab.object.areas_creditos_min[ll_find]
						else
								li_new = dw_tab2.insertrow(0)
				end if
				
				case 7
			    	ll_cve = this.object.plan_estudios_cve_area_sintesis_eval_opt[row]
				
				ll_find = dw_tab.Find( "areas_cve_area = " + String( ll_cve ) +" ", 1, dw_tab.Rowcount())
				
				 if ll_find > 0 then
							li_new = dw_tab2.insertrow(0)
							dw_tab2.object.creditos[li_new] = dw_tab.object.materias_creditos[ll_find]
							dw_tab2.object.areas_totales[li_new] = 	dw_tab.object.areas_total_materias[ll_find]
							dw_tab2.object.creditos_min[li_new] = 	dw_tab.object.areas_creditos_min[ll_find]
						else
								li_new = dw_tab2.insertrow(0)
				end if
	end choose

	next
	
End if 
							
ELSE		
	cbx_nuevo.Checked=TRUE		
END IF


THIS.EVENT cambia_lista_periodo() 

INTEGER le_autorizacion 
SELECT idAutorizacionReconocimiento 
INTO :le_autorizacion 
FROM carreras
WHERE cve_carrera = :il_cve_carrera 
USING gtr_sce; 
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la Autorizacion Reconicimiento: " + gtr_sce.SQLERRTEXT) 
	RETURN -1 
END IF  

IF ISNULL(le_autorizacion) THEN le_autorizacion = 0 
			
IF le_autorizacion > 0 THEN 		
	
	dw_autorizacion.SETTRANSOBJECT(gtr_sce) 
	IF dw_autorizacion.ROWCOUNT() = 0 THEN dw_autorizacion.INSERTROW(0) 
	dw_autorizacion.SETITEM(1, "idautorizacionreconocimiento", le_autorizacion) 
ELSE 	

	SETNULL(le_autorizacion) 
	dw_autorizacion.SETTRANSOBJECT(gtr_sce) 
	IF dw_autorizacion.ROWCOUNT() = 0 THEN dw_autorizacion.INSERTROW(0) 
	dw_autorizacion.SETITEM(1, "idautorizacionreconocimiento", le_autorizacion) 

END IF

SETFOCUS(THIS) 



end event

event itemfocuschanged;//IF	NOT(This.GetColumnName()="plan_estudios_cve_carrera") /*and modificar=FALSE*/ THEN
//	MessageBox("Advertencia","Se requieren privilegios para alterar los subsecuentes"&
//					+" campos .~rSin los privilegios adecuados sera imposible continuar"&
//					)
//	This.SetColumn("plan_estudios_cve_carrera")
//END IF
//
end event

event constructor;m_menu_cat.dw = This
Post event primero()
end event

event sqlpreview;
//IF request=PreviewFunctionUpdate! THEN
//	Messagebox("Codigo SQL para UpDate() ",sqlsyntax)
//	ROLLBACK USING gtr_sce;
//END IF
//

end event

type dw_tab2 from datawindow within w_planes_estudio
integer x = 1358
integer y = 1472
integer width = 1239
integer height = 752
integer taborder = 30
boolean bringtotop = true
string dataobject = "d_ext_creditosmin"
boolean border = false
boolean livescroll = true
end type

type cb_matmin from commandbutton within w_planes_estudio
integer x = 1888
integer y = 2136
integer width = 635
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Materias Min x Area"
end type

event clicked;DATASTORE lds_paso 
Long ll_new
uo_parametros_corr_titulacion luo_parametros_corr_titulacion 
luo_parametros_corr_titulacion = CREATE uo_parametros_corr_titulacion 
luo_parametros_corr_titulacion.ids_paso = CREATE DATASTORE 
luo_parametros_corr_titulacion.ids_paso.DATAOBJECT = "dw_mat_min_xarea"  

lds_paso = CREATE DATASTORE 
lds_paso.DATAOBJECT = "dw_mat_min_xarea"  

if dw_key.rowcount() > 0 then
		ll_new = lds_paso.insertrow(0)
		
		lds_paso.object.cve_carrera[ll_new] = il_cve_carrera
		lds_paso.object.cve_plan[ll_new] = il_cve_plan
		
//		lds_paso.object.cve_carrera[ll_new] = dw_key.object.plan_estudios_cve_carrera[dw_key.getrow()]
//		lds_paso.object.cve_plan[ll_new] = dw_key.object.plan_estudios_cve_plan[dw_key.getrow()]
		
lds_paso.object.cve_area_basica[ll_new] = dw_key.object.plan_estudios_cve_area_basica[dw_key.getrow()]
lds_paso.object.cve_area_mayor_oblig [ll_new] = dw_key.object.plan_estudios_cve_area_mayor_oblig[dw_key.getrow()]
lds_paso.object.cve_area_mayor_opt[ll_new] = dw_key.object.plan_estudios_cve_area_mayor_opt[dw_key.getrow()]
lds_paso.object.cve_area_opcion_terminal[ll_new] = dw_key.object.plan_estudios_cve_area_opcion_terminal[dw_key.getrow()]
lds_paso.object.cve_area_servicio_social[ll_new] = dw_key.object.plan_estudios_cve_area_servicio_social[dw_key.getrow()]
//lds_paso.object.cve_area_integ_fundamental[ll_new] = dw_key.object.plan_estudios_cve_area_integ_fundamental[dw_key.getrow()]
//lds_paso.object.cve_area_integ_tema1[ll_new] = dw_key.object.plan_estudios_cve_area_integ_tema1[dw_key.getrow()]
//lds_paso.object.cve_area_integ_tema2[ll_new] = dw_key.object.plan_estudios_cve_area_integ_tema2[dw_key.getrow()]
//lds_paso.object.cve_area_integ_tema3[ll_new] = dw_key.object.plan_estudios_cve_area_integ_tema3[dw_key.getrow()]
//lds_paso.object.cve_area_integ_tema4[ll_new] = dw_key.object.plan_estudios_cve_area_integ_tema4[dw_key.getrow()]
lds_paso.object.cve_area_sintesis_eval_oblig[ll_new] = dw_key.object.plan_estudios_cve_area_sintesis_eval_oblig[dw_key.getrow()]
lds_paso.object.cve_area_sintesis_eval_opt [ll_new] = dw_key.object.plan_estudios_cve_area_sintesis_eval_opt[dw_key.getrow()]
//
		
		
		lds_paso.ROWSCOPY(1, lds_paso.ROWCOUNT(), PRIMARY!, luo_parametros_corr_titulacion.ids_paso, 1, PRIMARY!)   
		
		OPENWITHPARM(w_matmin_xarea, luo_parametros_corr_titulacion)   

end if
end event

