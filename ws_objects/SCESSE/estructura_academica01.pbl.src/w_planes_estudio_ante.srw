$PBExportHeader$w_planes_estudio_ante.srw
forward
global type w_planes_estudio_ante from window
end type
type cbx_nuevo from checkbox within w_planes_estudio_ante
end type
type dw_tab from datawindow within w_planes_estudio_ante
end type
type dw_key from datawindow within w_planes_estudio_ante
end type
end forward

shared variables
string carreraplan
keycode lastkey
boolean modificar=FALSE 
end variables

global type w_planes_estudio_ante from window
integer x = 832
integer y = 364
integer width = 5431
integer height = 2400
boolean titlebar = true
string title = "Planes de Estudio"
string menuname = "m_menu_cat"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
long backcolor = 10789024
cbx_nuevo cbx_nuevo
dw_tab dw_tab
dw_key dw_key
end type
global w_planes_estudio_ante w_planes_estudio_ante

on w_planes_estudio_ante.create
if this.MenuName = "m_menu_cat" then this.MenuID = create m_menu_cat
this.cbx_nuevo=create cbx_nuevo
this.dw_tab=create dw_tab
this.dw_key=create dw_key
this.Control[]={this.cbx_nuevo,&
this.dw_tab,&
this.dw_key}
end on

on w_planes_estudio_ante.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cbx_nuevo)
destroy(this.dw_tab)
destroy(this.dw_key)
end on

event open;
dw_key.SetTransObject (gtr_sce)
dw_tab.SetTransObject (gtr_sce)
//dw_key.Insertrow(0)

//g_nv_security.fnv_secure_window (this)
/**/gnv_app.inv_security.of_SetSecurity(this)
end event

type cbx_nuevo from checkbox within w_planes_estudio_ante
integer x = 2679
integer y = 20
integer width = 626
integer height = 76
integer textsize = -11
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 10789024
string text = "Nuevo Registro"
boolean automatic = false
end type

type dw_tab from datawindow within w_planes_estudio_ante
integer x = 1339
integer y = 1324
integer width = 1211
integer height = 452
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_tab_total_cred"
boolean border = false
boolean livescroll = true
end type

type dw_key from datawindow within w_planes_estudio_ante
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
integer y = 104
integer width = 5362
integer height = 2084
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
data=this.GetText()

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

event db_update;integer carrera
string mensaje,dato
icon icono
dato = string( GetItemNumber(GetRow(),"plan_estudios_cve_carrera") )
carrera = integer(Left(dato,len(dato)-1))
SetItem(GetRow(),"plan_estudios_cve_carrera",carrera) 
IF  Update()=1 THEN//AND gtr_sce.SQLNRows > 0 THEN
	COMMIT USING gtr_sce;
	mensaje="Autorizada."
	icono=Information!
ELSE
	ROLLBACK USING gtr_sce;
	mensaje="No autorizada.~n DBMS Err: #"+string(gtr_sce.SQLDBCode)+" , "+gtr_sce.SQLErrText
	icono=StopSign!
END IF
Messagebox("Actulizacion de Registros",mensaje,icono)
Reset()
dw_tab.Reset()
SetItem(GetRow(),"plan_estudios_cve_carrera",integer(dato))
SetColumn("plan_estudios_cve_carrera")
end event

event dw_del;MessageBox("",integer(dw_key.GetRow()))
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
dw_key.Insertrow(0)
dw_tab.Reset()
Messagebox("Eliminacion de registro...",mensaje,icono)


end event

event dw_new;int row
//row=dw_key.GetRow()
//dw_key.DeleteRow(row)
Reset()
InsertRow(0)
dw_tab.Reset()
cbx_nuevo.Checked=TRUE
end event

event primero; long res_carrera,res_plan,row
 
 row = This.GetRow()
 SELECT Distinct min(plan_estudios.cve_carrera),   
         plan_estudios.cve_plan
 INTO		:res_carrera,:res_plan
 FROM plan_estudios 
 WHERE plan_estudios.cve_plan>0
 HAVING plan_estudios.cve_plan>0 using gtr_sce;
// ORDER BY plan_estudios.cve_carrera ASC,
//				plan_estudios.cve_plan ASC 
//MessageBox("QUERY primero",string(res_carrera)+"--carrera     plan--"+string(res_plan))
string clave
clave = string(res_carrera)+string(res_plan)
This.Retrieve(res_carrera,res_plan)
This.SetItem(row,"plan_estudios_cve_carrera",integer(clave))

//MessageBox("","     Hola!!!!")

end event

event ultimo; integer res_carrera,res_plan
 SELECT max(plan_estudios.cve_carrera),   
         plan_estudios.cve_plan
 INTO		:res_carrera,:res_plan
 FROM plan_estudios  
 ORDER BY plan_estudios.cve_carrera DESC,
				plan_estudios.cve_plan DESC using gtr_sce;
//MessageBox("QUERY",string(res_carrera)+"--carrera     plan--"+string(res_plan))
string clave
clave = string(res_carrera)+string(res_plan)
This.Retrieve(res_carrera,res_plan)
This.SetItem(This.GetRow(),"plan_estudios_cve_carrera",integer(clave))

end event

event siguiente;  int carrera,arg1,arg2,plan,row ,max_carrera=100
  string buf
 row = GetRow()
 plan = Object.plan_estudios_cve_plan[row]
// carrera = (Object.plan_estudios_cve_carrera[row] - plan)/10
carrera =integer( left(string(Object.plan_estudios_cve_carrera[row]),len(string(Object.plan_estudios_cve_carrera[row]))-1)  )
SELECT max(plan_estudios.cve_carrera) 
INTO		:max_carrera
FROM plan_estudios   using gtr_sce;
IF IsNull(carrera) THEN 
	TriggerEvent("Ultimo")
	Return
ELSEIF plan=4 and carrera=max_carrera THEN	
	Return
END IF
DO
	arg1=0
	arg2=0
	plan++
	IF plan=5 THEN 
		plan=1
		carrera++
	END IF
	SELECT plan_estudios.cve_carrera,plan_estudios.cve_plan  
 	INTO		:arg1,:arg2
	FROM plan_estudios  
	WHERE (plan_estudios.cve_carrera =:carrera AND plan_estudios.cve_plan = :plan) using gtr_sce; 
	if arg2<>0 then 
		Retrieve(arg1,arg2)
		Object.plan_estudios_cve_carrera[row]=integer(string(arg1)+string(arg2))
	end if	
LOOP WHILE arg1=0
end event

event anterior; int carrera,arg1,arg2,plan,row 
 row = GetRow()
 plan = Object.plan_estudios_cve_plan[row]
 carrera = (Object.plan_estudios_cve_carrera[row] - plan)/10
 IF IsNull(carrera) THEN 
	TriggerEvent("Primero")
	Return
ELSEIF plan=1 and carrera=10 THEN	
	Return
END IF
DO
	arg1=0
	arg2=0
	plan --
	IF plan=0 THEN 
		plan=4
		carrera --
	END IF
	SELECT plan_estudios.cve_carrera,plan_estudios.cve_plan  
 	INTO		:arg1,:arg2
	FROM plan_estudios  
	WHERE (plan_estudios.cve_carrera =:carrera AND plan_estudios.cve_plan = :plan) using gtr_sce; 
	if arg2<>0 then 
		Retrieve(arg1,arg2)
		Object.plan_estudios_cve_carrera[row]=integer(string(arg1)+string(arg2))
	end if	
LOOP WHILE arg1=0
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

event itemchanged;IF GetColumnName()="plan_estudios_cve_carrera" AND lastkey=KeyEnter! THEN
	carreraplan=data
	long carrera,plan
	carrera = long(Left(data,len(data)-1))
	plan = long(Right(data,1))
	IF Retrieve(long(carrera),long(plan))<1 THEN
		InsertRow(0)
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

event retrieveend;IF rowcount>0 THEN
	cbx_nuevo.Checked=FALSE
	int	row 
	row = Getrow()
	SetItem(row,"plan_estudios_cve_carrera",long(carreraplan))
	dw_tab.Retrieve ( GetItemNumber(row,"plan_estudios_cve_area_basica"), &
							GetItemNumber(row,"plan_estudios_cve_area_mayor_oblig"), &
							GetItemNumber(row,"plan_estudios_cve_area_mayor_opt"), &
							GetItemNumber(row,"plan_estudios_cve_area_servicio_social"), &
							GetItemNumber(row,"plan_estudios_cve_area_opcion_terminal"))	
ELSE		
	cbx_nuevo.Checked=TRUE		
END IF

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

