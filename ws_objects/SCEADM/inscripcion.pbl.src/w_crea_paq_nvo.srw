$PBExportHeader$w_crea_paq_nvo.srw
forward
global type w_crea_paq_nvo from window
end type
type uo_1 from uo_per_ani within w_crea_paq_nvo
end type
type dw_3 from datawindow within w_crea_paq_nvo
end type
type dw_2 from datawindow within w_crea_paq_nvo
end type
type dw_1 from datawindow within w_crea_paq_nvo
end type
type dw_4 from datawindow within w_crea_paq_nvo
end type
type gb_1 from groupbox within w_crea_paq_nvo
end type
type gb_2 from groupbox within w_crea_paq_nvo
end type
type gb_3 from groupbox within w_crea_paq_nvo
end type
end forward

global type w_crea_paq_nvo from window
integer x = 5
integer y = 12
integer width = 3986
integer height = 2536
boolean titlebar = true
string title = "Creación de Paquetes"
string menuname = "m_menu"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
long backcolor = 67108864
uo_1 uo_1
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
dw_4 dw_4
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
end type
global w_crea_paq_nvo w_crea_paq_nvo

type variables
string salones[]
int num_salones
integer ii_insertando

transaction itr_web	/* OSS 24-Ago-2011*/
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_crea_paq_nvo.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_1=create uo_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.dw_4=create dw_4
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.Control[]={this.uo_1,&
this.dw_3,&
this.dw_2,&
this.dw_1,&
this.dw_4,&
this.gb_1,&
this.gb_2,&
this.gb_3}
end on

on w_crea_paq_nvo.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.dw_4)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
end on

event open;x = 1
y = 1
String		ls_sintaxis_sql	/* OSS 24-Ago-2011 */
String		ls_mensaje		/* OSS 14-Dic-2011 */


// Establecer la conexión a la base de datos web de SQLServer ...
IF f_conecta_pas_parametros_bd ( gtr_sce , itr_web , 11 , gs_usuario , gs_password ) = 0 THEN
	ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
	MessageBox("Error", ls_mensaje, StopSign!)
	return -1
END IF
//if isvalid(itr_web) = false  then
//	itr_web = CREATE transaction//Creación de la transacción
//end if
//
///* Populate sqlca from current PB.INI settings */
//itr_web.DBMS       = ProfileString (gs_startupfile, "WEB_PARAM", "dbms",       "")
//itr_web.database   = ProfileString (gs_startupfile, "WEB_PARAM", "database",   "")
//itr_web.userid     = ProfileString (gs_startupfile, "WEB_PARAM", "userid",     "")
//itr_web.dbpass     = ProfileString (gs_startupfile, "WEB_PARAM", "dbpass",     "")
//
//
//itr_web.servername = ProfileString (gs_startupfile, "WEB_PARAM", "servername", "")
//itr_web.dbparm     = ProfileString (gs_startupfile, "WEB_PARAM", "dbparm",     "OJSyntax='PB'")
//
//itr_web.logid      = gs_usuario
//itr_web.logpass    = gs_password
//
////Conexión a la base de datos
//connect using itr_web;
//
//if itr_web.sqlcode <> 0 then
//	MessageBox ("No hay conexión con la Base de Datos "+"WEB_PARAM"+".", itr_web.sqlerrtext, None!)
//	Close ( This )
//ELSE
//	if itr_web.DBMS = 'OLE DB' then
//		ls_sintaxis_sql = 'SET IMPLICIT_TRANSACTIONS OFF'
//		EXECUTE IMMEDIATE :ls_sintaxis_sql USING itr_web;
//	end if
//end if


/*
IF conecta_bd(itr_web,"WEB_PARAM", gs_usuario, gs_password)<>1 THEN
	
	MessageBox("Acceso Negado", "El usuario no se encuentra autorizado para la base de WEB", StopSign!)
	
	Close ( This )
END IF
*/

/* OSS 24-Ago-2011 */
end event

type uo_1 from uo_per_ani within w_crea_paq_nvo
integer x = 1381
integer y = 44
integer taborder = 10
boolean enabled = true
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

type dw_3 from datawindow within w_crea_paq_nvo
event carga ( integer carr,  integer plan )
integer x = 2409
integer y = 1288
integer width = 1417
integer height = 1020
string dataobject = "dw_mat_1_sem_nvo"
boolean vscrollbar = true
boolean livescroll = true
end type

event carga;retrieve(carr,plan)

end event

event doubleclicked;long ll_renglon_paq, ll_renglon_actual, ll_registros_paq_mat
integer li_paquete,  li_inserta_paq_mat
long ll_cve_mat

ll_renglon_paq = dw_1.GetRow()
li_paquete = dw_1.object.num_paq[ll_renglon_paq]

ll_renglon_actual =this.GetRow()
ll_cve_mat = this.object.area_mat_cve_mat[ll_renglon_actual]

if ll_renglon_actual>0 then
	ll_registros_paq_mat = dw_2.event carga(ll_cve_mat, li_paquete)
	if ll_registros_paq_mat = 0 then
		ii_insertando = 1
		dw_2.event inserta_registro(li_paquete, ll_cve_mat)
		if li_inserta_paq_mat =-1 then
			MessageBox ("Error", "Error al insertar registro en datawindow de paquetes_materias")
			return
		else
			dw_2.event actualiza()
			ii_insertando = 0
			dw_2.SetFocus()
		end if
	else
		MessageBox ("Error", "La materia seleccionada ya existe para ese numero de paquete")
	end if	
	ll_registros_paq_mat = dw_2.event carga(9999, li_paquete)		
	dw_2.event sel_registro(li_paquete, ll_cve_mat)
end if

return


end event

event constructor;dw_3.settransobject(gtr_sce)
end event

event rowfocuschanged;SelectRow ( 0 , False )
SelectRow ( CurrentRow , True )
end event

type dw_2 from datawindow within w_crea_paq_nvo
event actualiza ( )
event type long carga ( long clv_mat,  integer a_num_paq )
event inserta_registro ( integer a_num_paq,  long a_clv_mat )
event sel_registro ( integer a_num_paq,  long a_clv_mat )
integer x = 123
integer y = 1288
integer width = 2162
integer height = 860
string dataobject = "dw_paquetes_materias_nvo"
boolean vscrollbar = true
boolean livescroll = true
end type

event actualiza(); //dw_1.event actualiza()
boolean lb_exito_actual
long ll_numrows, ll_indice
integer li_num_paq, li_codigo_sql, li_periodo, li_anio, li_primer_sem
long ll_cve_mat
string ls_mensaje_sql, ls_grupo

ll_numrows = this.RowCount()

li_periodo = gi_periodo
li_anio = gi_anio

AcceptText()
if update(true) = 1 then		
	commit using gtr_sadm;
	lb_exito_actual = true
else
	rollback using gtr_sadm;
	messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	lb_exito_actual = false
end if

if lb_exito_actual = false then
	return	
end if

if ii_insertando = 1 then
	return
end if

li_primer_sem= 1

for ll_indice = 1 to ll_numrows 
	li_num_paq = this.object.num_paq[ll_indice]
	ls_grupo = this.object.grupo[ll_indice]
	ll_cve_mat = this.object.clv_mat[ll_indice]

	UPDATE grupos
	SET primer_sem = :li_num_paq
	FROM grupos
	WHERE (grupos.periodo = :li_periodo ) AND
			(grupos.anio = :li_anio ) AND
			(grupos.gpo = :ls_grupo) AND
			(grupos.cve_mat = :ll_cve_mat) AND
			(grupos.cond_gpo = 1)    
	USING gtr_sce;
	
	li_codigo_sql = gtr_sce.SqlCode
	ls_mensaje_sql = gtr_sce.SqlErrText
	
	if li_codigo_sql <> -1 then
		commit using gtr_sce;
	else
		rollback using gtr_sce;
		messagebox("Error al actualizar grupos",ls_mensaje_sql)	
	end if	
	
	// OSS. 29-Ago-2011, replicar el update en SQLServer ...
	UPDATE grupos
	SET primer_sem = :li_num_paq
	FROM grupos
	WHERE (grupos.periodo = :li_periodo ) AND
			(grupos.anio = :li_anio ) AND
			(grupos.gpo = :ls_grupo) AND
			(grupos.cve_mat = :ll_cve_mat) AND
			(grupos.cond_gpo = 1)    
	USING itr_web;
	
	li_codigo_sql = itr_web.SqlCode
	ls_mensaje_sql = itr_web.SqlErrText
	
	if li_codigo_sql <> -1 then
		commit using itr_web;
	else
		rollback using itr_web;
		messagebox("Error al actualizar grupos, en SQLServer ",ls_mensaje_sql)	
	end if	
	// OSS. 29-Ago-2011, replicar el update en SQLServer ...
next


//dw_1.event actualiza()
//AcceptText()
////if ModifiedCount()+DeletedCount() > 0 Then
//	if update(true) = 1 then		
//		commit using gtr_sce;
//	else
//		rollback using gtr_sce;
//		messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
//	end if
////end if

end event

event carga;long ll_num_rows
integer li_periodo, li_anio

li_periodo = gi_periodo
li_anio = gi_anio


//dw_2.event actualiza()
//retrieve(clv_mat,gi_periodo,gi_anio)
ll_num_rows = retrieve(clv_mat, a_num_paq, li_periodo, li_anio)

return ll_num_rows



end event

event inserta_registro;long ll_newrow
integer li_anio, li_periodo

li_anio = gi_anio
li_periodo = gi_periodo

ll_newrow = this.InsertRow(0)
this.ScrollToRow(ll_newrow)
this.SetItem(ll_newrow, "anio", li_anio)
this.SetItem(ll_newrow, "clv_per", li_periodo)
this.SetItem(ll_newrow, "num_paq", a_num_paq)
this.SetItem(ll_newrow, "clv_mat", a_clv_mat)







end event

event sel_registro;long ll_reg_actual, ll_num_registros, ll_registro_sel

ll_num_registros= this.RowCount()
ll_registro_sel= ll_num_registros

for ll_reg_actual= 1 to ll_num_registros
	if this.object.num_paq[ll_reg_actual]= a_num_paq and &
		this.object.clv_mat[ll_reg_actual]= a_clv_mat then
			ll_registro_sel= ll_reg_actual
			Exit
	end if
next

this.SetFocus()
this.ScrollToRow(ll_registro_sel)
this.SetColumn(3)


end event

event constructor;dw_2.settransobject(gtr_sadm)
end event

event doubleclicked;long li_num_paq, li_renglon_paquetes, li_renglon_actual, li_codigo_sql, li_delete
integer li_borrar
string ls_mensaje_sql
/*Borra el renglón actual*/

li_renglon_actual= this.GetRow()

this.SelectRow(li_renglon_actual, TRUE)

li_borrar = MessageBox("Eliminación", "Desea borrar el registro actual?",Question!,YesNo!)

if li_borrar <>1 then 
	this.SelectRow(li_renglon_actual, FALSE)
	return
end if


setfocus()
li_delete = this.DeleteRow(li_renglon_actual)
if li_delete <> -1 then
	event actualiza()
else
	MessageBox("Error", "Error al actualizar el datawindow de paquetes_materias")
end if


end event

event itemfocuschanged;DataWindowChild grupo, cve_subsistema
string ls_filtro, ls_filtro_1, ls_filtro_2, ls_carrera, ls_columna, ls_plan
string ls_num_paq, ls_clv_mat, ls_anio, ls_periodo
integer rtncode, li_num_paq, li_anio, li_periodo
long ll_carrera, ll_grupo, ll_row
long ll_clv_mat

if ii_insertando = 1 then 
	return
end if

ll_row = this.GetRow()


//ls_columna =dwo.name

ls_columna =this.GetColumnName()


li_num_paq = this.object.num_paq[ll_row]
ll_clv_mat = this.object.clv_mat[ll_row]
li_anio = gi_anio
li_periodo = gi_periodo

ls_num_paq = string(li_num_paq)
ls_clv_mat = string(ll_clv_mat)
ls_anio = string(li_anio)
ls_periodo = string(li_periodo)


ls_filtro_1 = "cve_mat = "+ ls_clv_mat + " and periodo = "+ls_periodo+" and anio = "+ls_anio

rtncode = this.GetChild('grupo', grupo)

IF rtncode = -1 THEN MessageBox("Error", "No es un DataWindowChild")

	// Set the transaction object for the child
	
	grupo.SetTransObject(gtr_sadm)
	
	// Populate the child with all the posible values for grupo
	if isnull(ls_carrera) then
		ls_carrera = "0"
	end if
	
	grupo.SetFilter(ls_filtro_1)
	grupo.Filter()
	grupo.Retrieve()








end event

event rowfocuschanged;SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

event sqlpreview;// OSS. 29-Ago-2011.

// Sincronizar la inserción a SQLServer ...
IF SQLType = PreviewInsert! OR SQLType = PreviewDelete! OR SQLType = PreviewUpdate! THEN
	
	EXECUTE IMMEDIATE :SQLSyntax USING itr_web;
	
	IF itr_web.SQLCode = -1 THEN
		MessageBox ( "Error:" , "De base de datos al insertar en paquetes_materias en SQLServer.~n~r~n~r" +  itr_web.SQLErrText )
		RollBack Using itr_web;
	END IF
	
END IF


end event

type dw_1 from datawindow within w_crea_paq_nvo
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event carga ( )
integer x = 123
integer y = 332
integer width = 3598
integer height = 780
string dataobject = "dw_paquetes_nvo"
boolean vscrollbar = true
boolean livescroll = true
end type

event primero;/*Ve al primer renglón*/
setcolumn(1)
setfocus()
scrolltorow(1)
end event

event anterior;/*Ve al renglón anterior*/
setcolumn(1)
setfocus()
if getrow()>1 then
	scrolltorow(getrow()-1)
end if

end event

event siguiente;/*Ve al siguiente renglón*/
setcolumn(1)
setfocus()
if getrow()<rowcount() then
	scrolltorow(getrow()+1)
end if
end event

event ultimo;/*Ve al último renglón*/
setcolumn(1)
setfocus()
scrolltorow(rowcount())
end event

event actualiza;AcceptText()
//if ModifiedCount()+DeletedCount() > 0 Then
	dw_2.event actualiza()
	if update(true) = 1 then		
		commit using gtr_sadm;
	else
		rollback using gtr_sadm;
		messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
	end if
//end if
end event

event nuevo;insertrow(0)
scrolltorow(rowcount())
setfocus()
object.cupo[getrow()]=0
object.inscritos[getrow()]=0
end event

event borra();long cont, l_num_paq, li_codigo_sql, ll_renglon_paquetes, ll_rows_paq_mat, ll_row, ll_clv_mat
string ls_mensaje_sql, ls_grupo
integer li_respuesta, li_num_paq_max, li_num_paq
/*Borra el renglón actual*/

li_respuesta = MessageBox("Confirmacion","¿Esta seguro de querer borrar el paquete actual?", Question!, YesNO! )
if li_respuesta <> 1 then
	return	
end if

//Obtiene los renglones de paquetes_materias
ll_rows_paq_mat = dw_2.RowCount()
ll_row =1

//Obtiene el renglon actual del paquetes
cont=object.num_paq[getrow()]

li_num_paq=object.num_paq[getrow()]
ll_renglon_paquetes = dw_1.GetRow()


for ll_row=dw_2.rowcount() to 1 step -1
	
	ll_clv_mat =dw_2.object.clv_mat[ll_row]
	ls_grupo = dw_2.object.grupo[ll_row]

	SELECT max(dbo.paquetes_materias.num_paq)
	INTO :li_num_paq_max
	FROM dbo.paquetes_materias
	WHERE dbo.paquetes_materias.clv_mat = :ll_clv_mat
	AND	dbo.paquetes_materias.grupo = :ls_grupo
	AND	dbo.paquetes_materias.num_paq <> :li_num_paq
	AND	dbo.paquetes_materias.clv_per = :gi_periodo
	AND	dbo.paquetes_materias.anio = :gi_anio
	USING gtr_sadm;

	li_codigo_sql = gtr_sadm.SQLCode
	ls_mensaje_sql = gtr_sadm.SQLErrText
	
	if li_codigo_sql = 100 or isnull(li_num_paq_max) then
		
		UPDATE dbo.grupos
		SET dbo.grupos.primer_sem = 0
		WHERE ( dbo.grupos.periodo = :gi_periodo ) 
		AND	( dbo.grupos.anio = :gi_anio ) 
		AND	( dbo.grupos.cve_mat = :ll_clv_mat )
		AND	( dbo.grupos.gpo = :ls_grupo )
		AND	( dbo.grupos.primer_sem = :li_num_paq )
		USING gtr_sce;

		li_codigo_sql= gtr_sce.SqlCode
		ls_mensaje_sql= gtr_sce.SqlErrText

		if li_codigo_sql <> -1 then
//OSS			commit using gtr_sce;
		else
	 		MessageBox("Error al actualizar primer_sem de grupos", ls_mensaje_sql)
			rollback using gtr_sce;
			return
		end if

	end if

	// OSS. 29-Ago-2011, replicar la transacción en SLQServer ...
	SELECT max(dbo.paquetes_materias.num_paq)
	INTO :li_num_paq_max
	FROM dbo.paquetes_materias
	WHERE dbo.paquetes_materias.clv_mat = :ll_clv_mat
	AND	dbo.paquetes_materias.grupo = :ls_grupo
	AND	dbo.paquetes_materias.num_paq <> :li_num_paq
	AND	dbo.paquetes_materias.clv_per = :gi_periodo
	AND	dbo.paquetes_materias.anio = :gi_anio
	USING itr_web;

	li_codigo_sql = itr_web.SQLCode
	ls_mensaje_sql = itr_web.SQLErrText
	
	if li_codigo_sql = 100 or isnull(li_num_paq_max) then
		
		UPDATE dbo.grupos
		SET dbo.grupos.primer_sem = 0
		WHERE ( dbo.grupos.periodo = :gi_periodo ) 
		AND	( dbo.grupos.anio = :gi_anio ) 
		AND	( dbo.grupos.cve_mat = :ll_clv_mat )
		AND	( dbo.grupos.gpo = :ls_grupo )
		AND	( dbo.grupos.primer_sem = :li_num_paq )
		USING itr_web;

		li_codigo_sql= itr_web.SqlCode
		ls_mensaje_sql= itr_web.SqlErrText

		if li_codigo_sql <> -1 then
			commit using gtr_sce;
			commit using itr_web;
		else
	 		MessageBox("Error al actualizar primer_sem de grupos", ls_mensaje_sql)
			rollback using gtr_sce;
			rollback using itr_web;
			return
		end if

	end if
	// OSS. 29-Ago-2011, replicar la transacción en SLQServer ( FIN )...
	
	dw_2.deleterow(ll_row)
//	ll_row= ll_row +1
next

for cont=dw_3.rowcount() to 1 step -1
	dw_3.deleterow(cont)
next
setfocus()
deleterow(getrow())
event actualiza()



end event

event carga;retrieve()

end event

event constructor;dw_1.settransobject(gtr_sadm)
dw_4.settransobject(gtr_sce)

DataWindowChild carr,plan

getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

getchild("clv_plan",plan)
plan.settransobject(gtr_sce)
plan.retrieve()

dw_1.event carga()

m_menu.dw = this
end event

event itemchanged;int cont,columna
int li_clv_carr, li_clv_plan

columna = getcolumn()
if (columna=2) then
	li_clv_carr = integer(Data)
	li_clv_plan=object.clv_plan[row]
end if

if (columna=3)  then
	li_clv_plan = integer(Data)
	li_clv_carr=object.clv_carr[row]
end if

if (columna=2 or columna=3) then
	if not isnull(li_clv_carr) and not isnull(li_clv_plan)then
		dw_3.event carga(li_clv_carr,li_clv_plan)
		dw_4.event carga(li_clv_carr,li_clv_plan)
	end if
end if

//		dw_3.event carga(object.clv_carr[row],object.clv_plan[row])
//		dw_4.event carga(object.clv_carr[row],object.clv_plan[row])

end event

event rowfocuschanged;if (currentrow>0 and rowcount()>0) then
	dw_3.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow])
	dw_4.event carga(object.clv_carr[currentrow],object.clv_plan[currentrow])
	dw_2.event carga(9999,object.num_paq[currentrow])
end if

SelectRow ( 0 , False )

SelectRow ( CurrentRow , True )
end event

event getfocus;setcolumn(1)
end event

event sqlpreview;// OSS. 29-Ago-2011.

// Sincronizar la inserción a SQLServer ...
IF SQLType = PreviewInsert! OR SQLType = PreviewDelete! OR SQLType = PreviewUpdate! THEN
	
	EXECUTE IMMEDIATE :SQLSyntax USING itr_web;
	
	IF itr_web.SQLCode = -1 THEN
		MessageBox ( "Error:" , "De base de datos al insertar en paquetes_materias en SQLServer.~n~r~n~r" +  itr_web.SQLErrText )
		RollBack Using itr_web;
	END IF
	
END IF


end event

type dw_4 from datawindow within w_crea_paq_nvo
event carga ( integer carr,  integer plan )
boolean visible = false
integer x = 2021
integer y = 1960
integer width = 1509
integer height = 540
boolean bringtotop = true
string dataobject = "dw_prerreq"
boolean vscrollbar = true
boolean livescroll = true
end type

event carga;retrieve(carr,plan)

end event

event retrieveend;long cont1,cont2

FOR cont1=1 TO rowcount
	FOR cont2=1 TO dw_3.rowcount()
		IF dw_3.object.area_mat_cve_mat[cont2] = object.cve_mat[cont1] THEN
			dw_3.deleterow(cont2)
			cont2=dw_3.rowcount()+1
		END IF
	NEXT
NEXT

end event

event constructor;dw_4.settransobject(gtr_sce)
end event

type gb_1 from groupbox within w_crea_paq_nvo
integer x = 41
integer y = 216
integer width = 3858
integer height = 948
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Paquetes"
borderstyle borderstyle = stylebox!
end type

type gb_2 from groupbox within w_crea_paq_nvo
integer x = 41
integer y = 1188
integer width = 2295
integer height = 1164
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materias por paquete"
borderstyle borderstyle = stylebox!
end type

type gb_3 from groupbox within w_crea_paq_nvo
integer x = 2341
integer y = 1188
integer width = 1559
integer height = 1164
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
string text = "Materias por Plan de Estudios"
borderstyle borderstyle = stylebox!
end type

