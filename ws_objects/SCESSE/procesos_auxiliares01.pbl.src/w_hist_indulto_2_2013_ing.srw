$PBExportHeader$w_hist_indulto_2_2013_ing.srw
forward
global type w_hist_indulto_2_2013_ing from w_master_main
end type
type uo_1 from uo_per_ani within w_hist_indulto_2_2013_ing
end type
type uo_nombre from uo_nombre_alumno_2013 within w_hist_indulto_2_2013_ing
end type
type r_1 from rectangle within w_hist_indulto_2_2013_ing
end type
type dw_hist_indulto from uo_master_dw within w_hist_indulto_2_2013_ing
end type
type pb_elimina_indulto from picturebutton within w_hist_indulto_2_2013_ing
end type
type pb_insert from picturebutton within w_hist_indulto_2_2013_ing
end type
type dw_historico from datawindow within w_hist_indulto_2_2013_ing
end type
type gb_1 from groupbox within w_hist_indulto_2_2013_ing
end type
end forward

global type w_hist_indulto_2_2013_ing from w_master_main
integer width = 3534
integer height = 2756
string title = "Extensión de créditos Prerrequisito Inglés"
string menuname = "m_indultos_2013_ing"
boolean maxbox = false
event ue_filtrar ( )
uo_1 uo_1
uo_nombre uo_nombre
r_1 r_1
dw_hist_indulto dw_hist_indulto
pb_elimina_indulto pb_elimina_indulto
pb_insert pb_insert
dw_historico dw_historico
gb_1 gb_1
end type
global w_hist_indulto_2_2013_ing w_hist_indulto_2_2013_ing

type variables
long     il_Cuenta
boolean ib_modificando, ib_borrado
int ii_periodo,ii_anio
Datawindowchild dwc_periodo
uo_periodo_servicios iuo_periodo_servicios 
STRING is_periodo_desc 

TRANSACTION itr_sql 

DECIMAL il_cred_default, il_cred_minimos
end variables

forward prototypes
public function integer wf_validar ()
public function integer wf_cambia_periodo ()
end prototypes

event ue_filtrar();//long ll_ren
//
///*
//uo_1.em_per.triggerevent(Modified!)
//uo_1.em_ani.triggerevent(Modified!)
//
//ii_periodo = gi_periodo
//ii_anio = gi_anio
//*/
//
//
//ii_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L")
//il_cuenta = long(uo_nombre.of_obten_cuenta())
//
//
//ll_ren = dw_hist_indulto.Retrieve(il_cuenta,ii_periodo,ii_anio)
//
//if ll_ren = 0 then
//	dw_hist_indulto.Reset()
//	messagebox('AVISO','No existe información con esa cuenta')
//	return
//end if
end event

public function integer wf_validar ();//Revisa que los registros sean lógicos y no estén repetidos
long ll_rows, ll_row_actual, ll_row_buscado, ll_cuenta
string ls_cve_indulto
string ls_busqueda_duplicado
integer li_periodo, li_anio
INTEGER le_num_registros

IF idw_trabajo.ROWCOUNT() = 0 THEN RETURN 1

li_periodo = idw_trabajo.GetItemNumber(1, "periodo")
li_anio= idw_trabajo.GetItemNumber(1, "anio")
ls_cve_indulto= idw_trabajo.GetItemString(1, "cve_indulto")
ll_cuenta = dw_hist_indulto.GetItemNumber(1,'cuenta')
IF ISNULL(ll_cuenta) THEN ll_cuenta = 0 
IF ll_cuenta <= 0 THEN 
	MESSAGEBOX("Aviso", "No se ha seleccionado un alumno para Extensión de Créditos de Idioma.")
	RETURN -1
END IF	

SELECT COUNT(*) 
INTO :le_num_registros 
FROM hist_indulto 
WHERE cuenta = :ll_cuenta
and cve_indulto = :ls_cve_indulto
and periodo = :li_periodo
and anio = :li_anio 
USING gtr_sce; 
IF le_num_registros > 0 then 
	MESSAGEBOX("Aviso", "Ya existe una Extensión de Créditos de Requisito de Inglés para esta cuenta y periodo.")
	RETURN -1
END IF

return 1





//ll_rows = idw_trabajo.RowCount()
//for ll_row_actual=1  to ll_rows
//	ls_cve_indulto= idw_trabajo.GetItemString(ll_row_actual, "cve_indulto")
//	li_periodo = idw_trabajo.GetItemNumber(ll_row_actual, "periodo")
//	li_anio= idw_trabajo.GetItemNumber(ll_row_actual, "anio")
//	ls_busqueda_duplicado = 'cve_indulto = "'+ls_cve_indulto+'" and periodo = '+string(li_periodo)+' and anio = '+string(li_anio) 
//	ll_row_buscado = idw_trabajo.find(ls_busqueda_duplicado,1, ll_rows)
//	if ll_row_buscado <> 0 and ll_row_buscado <> ll_row_actual then
//		idw_trabajo.ScrollToRow(ll_row_actual)	
//		MessageBox("Indulto Duplicado", "Favor de escribir un Indulto distinto", StopSign!)
//		return -1	
//	end if
//next
end function

public function integer wf_cambia_periodo ();INTEGER li_anio, li_periodo 
STRING ls_periodo 

IF dw_hist_indulto.ROWCOUNT() > 0 THEN RETURN 0

li_anio=integer(uo_1.em_ani.text)
ls_periodo=uo_1.em_per.text
li_periodo=uo_1.iuo_periodo_servicios.f_recupera_id(ls_periodo, "L")

//if dw_hist_indulto.Retrieve(il_cuenta,li_periodo,li_anio) = 0  then dw_hist_indulto.INSERTROW(0)
	//IF dw_hist_indulto.ROWCOUNT() <= 0 THEN dw_hist_indulto.INSERTROW(0)
	dw_hist_indulto.RESET() 
	dw_hist_indulto.INSERTROW(0)
	dw_hist_indulto.SETITEM(1, "cve_indulto", "I")
	dw_hist_indulto.Setitem(1,'cuenta',il_cuenta)
	dw_hist_indulto.Setitem(1,'periodo',li_periodo)
	dw_hist_indulto.Setitem(1,'periodo_descripcion',ls_periodo)	
	dw_hist_indulto.Setitem(1,'anio',li_anio)	
	ib_modificando = true	
	ib_borrado = FALSE
//end if

//dw_hist_indulto.Setitem(1,'periodo',li_periodo)
//dw_hist_indulto.Setitem(1,'anio',li_anio)	
//dw_hist_indulto.Setitem(1,'periodo_descripcion',ls_periodo)	
//ib_modificando = true

RETURN 0

end function

event activate;call super::activate;control_escolar.toolbarsheettitle="Indultos"
end event

on w_hist_indulto_2_2013_ing.create
int iCurrent
call super::create
if this.MenuName = "m_indultos_2013_ing" then this.MenuID = create m_indultos_2013_ing
this.uo_1=create uo_1
this.uo_nombre=create uo_nombre
this.r_1=create r_1
this.dw_hist_indulto=create dw_hist_indulto
this.pb_elimina_indulto=create pb_elimina_indulto
this.pb_insert=create pb_insert
this.dw_historico=create dw_historico
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
this.Control[iCurrent+2]=this.uo_nombre
this.Control[iCurrent+3]=this.r_1
this.Control[iCurrent+4]=this.dw_hist_indulto
this.Control[iCurrent+5]=this.pb_elimina_indulto
this.Control[iCurrent+6]=this.pb_insert
this.Control[iCurrent+7]=this.dw_historico
this.Control[iCurrent+8]=this.gb_1
end on

on w_hist_indulto_2_2013_ing.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
destroy(this.uo_nombre)
destroy(this.r_1)
destroy(this.dw_hist_indulto)
destroy(this.pb_elimina_indulto)
destroy(this.pb_insert)
destroy(this.dw_historico)
destroy(this.gb_1)
end on

event doubleclicked;call super::doubleclicked;il_cuenta = long(uo_nombre.of_obten_cuenta()) 

IF il_cuenta > 0 THEN 
	// Se verifica el nivel del alumno. 
	STRING ls_nivel
	SELECT nivel 
	INTO :ls_nivel 
	FROM academicos 
	WHERE cuenta = :il_cuenta 
	USING gtr_sce;  
	IF gtr_sce.SQLCODE < 0 THEN 
		MESSAGEBOX("Aviso", "Se produjo un error al verificar el nivel del alumno." +  gtr_sce.SQLERRTEXT)  
		RETURN -1 
	END IF
	IF ls_nivel <> 'L' THEN 	
		MESSAGEBOX("Aviso", "No es posible dar Extensión de Créditos a alumnos que no sean de Licenciatura." ) 
		uo_nombre.em_cuenta.text = " "
		uo_nombre.em_digito.text = " "
		//uo_nombre.TRIGGEREVENT(constructor!)
		dw_hist_indulto.RESET() 
		dw_historico.RESET()
		IF uo_nombre.dw_nombre_alumno.ROWCOUNT() > 0 THEN uo_nombre.dw_nombre_alumno.DELETEROW(1)
		uo_nombre.dw_nombre_alumno.INSERTROW(0)
		RETURN -1 
	END IF 
END IF


//ii_periodo = integer(uo_1.em_per.text)
ii_anio = integer(uo_1.em_ani.text)
ii_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L")

dw_hist_indulto.Getchild('periodo',dwc_periodo)
dwc_periodo.settransobject(gtr_sce)
dwc_periodo.retrieve(gs_tipo_periodo)


SELECT valor_default, valor_minimo
INTO :il_cred_default, :il_cred_minimos
FROM parametros_banderas 
WHERE bandera = 'exten_cred_ing' 
AND periodo = :ii_periodo  
USING gtr_sce;
IF gtr_sce.SQLCODE < 0 THEN 
	MESSAGEBOX("Error", "Se produjo un error al recuperar la Extensión de Créditos por Prerrequisito de Inglés para el periodo seleccionado: " + gtr_sce.SQLERRTEXT)
	MESSAGEBOX("Error", "FAVOR DE VERIFICAR ANTES DE REALIZAR LA EXTENSIÓN DE CRÉDITOS")  
	CLOSE(THIS) 
END IF


if il_cuenta = 0 then 
	uo_nombre.em_cuenta.text = " "
	uo_nombre.em_digito.text = " "
	IF uo_nombre.dw_nombre_alumno.ROWCOUNT() > 0 THEN uo_nombre.dw_nombre_alumno.DELETEROW(1)
	uo_nombre.dw_nombre_alumno.INSERTROW(0)	
	dw_hist_indulto.RESET() 
	dw_historico.RESET()	
	return
END IF

//wf_cambia_periodo()


dw_hist_indulto.SETTRANSOBJECT(gtr_sce) 
dw_hist_indulto.RETRIEVE(il_cuenta, ii_periodo, ii_anio) 

dw_historico.SETTRANSOBJECT(gtr_sce) 
dw_historico.RETRIEVE(il_cuenta) 



//*****************************








//INTEGER li_anio, li_periodo 
//STRING ls_periodo 
//
//li_anio=integer(uo_1.em_ani.text)
//ls_periodo=uo_1.em_per.text
//li_periodo=uo_1.iuo_periodo_servicios.f_recupera_id(ls_periodo, "L")
//
//if il_cuenta = 0 then return
//
//if dw_hist_indulto.Retrieve(il_cuenta,ii_periodo,ii_anio) = 0  then 
//	dw_hist_indulto.INSERTROW(0)
//	dw_hist_indulto.SETITEM(1, "cve_indulto", "I")
//	dw_hist_indulto.Setitem(1,'cuenta',il_cuenta)
//	dw_hist_indulto.Setitem(1,'periodo',li_periodo)
//	dw_hist_indulto.Setitem(1,'anio',li_anio)	
//	dw_hist_indulto.Setitem(1,'periodo_descripcion',ls_periodo)	
//	ib_modificando = true
//end if

end event

event open;call super::open;//////////////////////////////////////////////////////

INTEGER le_periodo, le_anio 
STRING ls_error


// Se recupera el periodo y año de indulto de Inglés.
SELECT periodos_por_procesos.periodo, periodos_por_procesos.anio, periodo.descripcion
INTO :le_periodo, :le_anio, :is_periodo_desc
FROM periodos_por_procesos, periodo  
WHERE periodos_por_procesos.cve_proceso = 16 
AND periodos_por_procesos.periodo = periodo.periodo 
USING gtr_sce;
IF gtr_sce.sqlcode < 0 THEN 
	ls_error = gtr_sce.SQLERRTEXT 
	MESSAGEBOX("Error", "Se produjo un error al recuperar el periodo de Extensión de Créditos de Inglés: " + ls_error) 
	RETURN 0
END IF

uo_1.em_ani.text = string(le_anio) 
uo_1.em_per.text = string(le_periodo)  

//this.em_ani.text = string(gi_anio) 
//this.em_per.text = string(gi_periodo)  

uo_1.em_per.TRIGGEREVENT(MODIFIED!) 


////////////////////////////////////////////////////////////////////////////////


ib_borrado = FALSE 

dw_hist_indulto.Settransobject(gtr_sce)
uo_nombre.em_cuenta.text = " "

	//Modif. Roberto Novoa R.  Jun/2016 - Funcionalidad de periodos múltiples
	iuo_periodo_servicios = CREATE uo_periodo_servicios
	iuo_periodo_servicios.f_carga_periodos( gs_tipo_periodo, gtr_sce)

triggerevent(doubleclicked!) 


STRING ls_mensaje 
if f_conecta_con_parametros_bd(gtr_sce, itr_sql, 23 )=0 then
	ls_mensaje = "Atención: "+ "Problemas al conectarse a la base de datos de WEB.controlescolar_bd"
	MessageBox("Error", ls_mensaje, StopSign!) 
	CLOSE(THIS) 
	return -1 
end if 


//16	Periodo Indulto Prerrequisito Inglés	2	2018
end event

event ue_actualiza;call super::ue_actualiza;int li_res, ie_bandera
STRING ls_error 
LONG ll_creditos 


if ib_modificando then	
	li_res = wf_validar ()
	if li_res = -1 then
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		triggerevent(doubleclicked!)
		return
	end if
	
			
	
	if dw_hist_indulto.update(true) = 1 then
		commit using gtr_sce;	
		
		//**--**
		//il_cuenta = long(uo_nombre.of_obten_cuenta())		
		
		IF ib_borrado THEN 
//			IF MESSAGEBOX("Confirmación", "El indulto del prerrequisto de inglés será eliminado. ¿Desea Restiruir los Créditos Permitidos del Alumno?", Question!, YesNo!) = 1 THEN 
			
			INTEGER le_semestres, le_acreditacion

			// Se verifica cuantos semestres ha cursado:
			SELECT  sem_cursados     
			INTO :le_semestres
			FROM academicos  
			WHERE cuenta = :il_cuenta 
			USING gtr_sce; 
			IF gtr_sce.SQLCODE < 0 THEN 
				ls_error = gtr_sce.SQLERRTEXT 
				rollback using gtr_sce;
				messagebox("Información","Se produjo un error al recuperar los semestres cursados del alumno: " + ls_error)			 
				RETURN 
			END IF

			// Se verifica si el alumno ya acredito la materia.
			SELECT  COUNT(*) 
			INTO :le_acreditacion 
			FROM historico,
					academicos 
			WHERE historico.cuenta = academicos.cuenta 
				AND historico.cve_mat IN( SELECT cve_mat FROM materias_requisito WHERE id_prerrequisito = 'ING')  
				AND historico.calificacion = 'AC'   
				AND historico.cve_carrera = academicos.cve_carrera 
				AND historico.cve_plan = academicos.cve_plan 
				AND academicos.cuenta = :il_cuenta
				USING gtr_sce; 
			IF gtr_sce.SQLCODE < 0 THEN 
				ls_error = gtr_sce.SQLERRTEXT 
				rollback using gtr_sce;
				messagebox("Información","Se produjo un error al recuperar la acreditación del Idioma: " + ls_error)			 
				RETURN 
			END IF
			
			// Si el alumno es de tercer semestre o posterior y no ha acréditado el inglés, se restringen sus créditos
			IF le_semestres >= 3 AND le_acreditacion = 0 THEN 
				ll_creditos = il_cred_minimos
				ie_bandera = 1 
			ELSE
				ll_creditos = il_cred_default 
				ie_bandera = 0
			END IF
		ELSE				
			ll_creditos = il_cred_default 
			ie_bandera = 0
		END IF 		
		
		
		// Se actualizan las banderas correspondientes.
		UPDATE banderas 
		SET exten_cred = :ll_creditos
		WHERE cuenta = :il_cuenta
		USING gtr_sce; 
		IF gtr_sce.SQLCODE < 0 THEN 
			ls_error = gtr_sce.SQLERRTEXT 
			rollback using gtr_sce;
			messagebox("Información","Se produjo un error al actualizar banderas: " + ls_error)			 
		ELSE
			commit using gtr_sce;	
		END IF
		//, cve_flag_prerreq_ingles = :ie_bandera 
		
		// Se hace la actualización en SQL SERVER 
		UPDATE banderas 
		SET exten_cred = :ll_creditos
		WHERE cuenta = :il_cuenta
		USING itr_sql; 	
		IF itr_sql.SQLCODE < 0 THEN 
			ls_error = itr_sql.SQLERRTEXT 
			rollback using itr_sql;
			messagebox("Información","Se produjo un error al actualizar banderas en WEB: " + ls_error)			 		
		ELSE
			COMMIT USING itr_sql; 
		END IF
		
		//, cve_flag_prerreq_ingles = :ie_bandera
		//**--**
		
		messagebox("Información","Se han guardado los cambios")				
		triggerevent(doubleclicked!)
		ib_modificando = FALSE 
	else
		rollback using gtr_sce;
		messagebox("Información","No se han guardado los cambios")	
		return
	end if
Else
	Rollback  using gtr_sce;
	triggerevent(doubleclicked!)
end if




end event

event closequery;//

DISCONNECT USING itr_sql;
end event

event ue_nuevo;call super::ue_nuevo;uo_nombre.em_cuenta.text = " "
uo_nombre.em_digito.text = " "
IF uo_nombre.dw_nombre_alumno.ROWCOUNT() > 0 THEN uo_nombre.dw_nombre_alumno.DELETEROW(1)
uo_nombre.dw_nombre_alumno.INSERTROW(0)
dw_hist_indulto.RESET() 
dw_historico.RESET()	
return



//long ll_row
//String ls_periodo
//
////ii_periodo = integer(uo_1.em_per.text)
//ii_anio = integer(uo_1.em_ani.text)
//
//ls_periodo=uo_1.em_per.text
//ii_periodo=uo_1.iuo_periodo_servicios.f_recupera_id( uo_1.em_per.text, "L")
//il_cuenta = long(uo_nombre.of_obten_cuenta())
//
//
//dw_hist_indulto.scrolltorow(dw_hist_indulto.insertrow(0))
//dw_hist_indulto.setcolumn(1)
//ll_row= dw_hist_indulto.GetRow()
//dw_hist_indulto.SetItem(ll_row, "cuenta", il_cuenta)
//dw_hist_indulto.SetItem(ll_row, 'periodo', ii_periodo)
//dw_hist_indulto.SetItem(ll_row, 'anio', ii_anio)
//dw_hist_indulto.SetItem(ll_row, 'texper', ls_periodo)
//
end event

event close;//if ib_modificando then
//	if messagebox('Aviso','¿Desea guardar los cambios?',Question!,Yesno!) = 1 then
//		if wf_validar () <> 1 then 	
//			rollback using gtr_sce;
//			messagebox("Información","No se han guardado los cambios")	
//			return 
//		else
//			 triggerevent("ue_actualiza")
//		end if
//	end if
//end if
end event

type st_sistema from w_master_main`st_sistema within w_hist_indulto_2_2013_ing
integer textsize = -16
end type

type p_ibero from w_master_main`p_ibero within w_hist_indulto_2_2013_ing
end type

type uo_1 from uo_per_ani within w_hist_indulto_2_2013_ing
integer x = 1015
integer y = 740
integer width = 1253
integer height = 168
integer taborder = 10
end type

on uo_1.destroy
call uo_per_ani::destroy
end on

event constructor;call super::constructor;//INTEGER le_periodo, le_anio 
//STRING ls_error
//
//
//// Se recupera el periodo y año de indulto de Inglés.
//SELECT periodos_por_procesos.periodo, periodos_por_procesos.anio, periodo.descripcion
//INTO :le_periodo, :le_anio, :is_periodo_desc
//FROM periodos_por_procesos, periodo  
//WHERE periodos_por_procesos.cve_proceso = 16 
//AND periodos_por_procesos.periodo = periodo.periodo 
//USING gtr_sce;
//IF gtr_sce.sqlcode < 0 THEN 
//	ls_error = gtr_sce.SQLERRTEXT 
//	MESSAGEBOX("Error", "Se produjo un error al recuperar el periodo de Indultos de Inglés: " + ls_error) 
//	RETURN 0
//END IF
//
//this.em_ani.text = string(le_anio) 
//this.em_per.text = string(le_periodo)  
//
////this.em_ani.text = string(gi_anio) 
////this.em_per.text = string(gi_periodo)  
//
//em_per.TRIGGEREVENT(MODIFIED!) 
//
//
//
end event

event ue_modifica;call super::ue_modifica;wf_cambia_periodo()
end event

type uo_nombre from uo_nombre_alumno_2013 within w_hist_indulto_2_2013_ing
integer x = 105
integer y = 368
integer taborder = 20
end type

on uo_nombre.destroy
call uo_nombre_alumno_2013::destroy
end on

event constructor;call super::constructor;iw_ventana = parent
m_indultos_2013_ing.objeto = this

end event

type r_1 from rectangle within w_hist_indulto_2_2013_ing
long linecolor = 128
integer linethickness = 5
long fillcolor = 16777215
integer x = 677
integer y = 960
integer width = 2025
integer height = 268
end type

type dw_hist_indulto from uo_master_dw within w_hist_indulto_2_2013_ing
integer x = 699
integer y = 996
integer width = 1691
integer height = 200
integer taborder = 30
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_hist_indulto_2013_ing"
boolean hscrollbar = false
boolean vscrollbar = false
end type

event constructor;call super::constructor;m_indultos_2013_ing.dw = this
idw_trabajo = this
end event

event itemchanged;call super::itemchanged;ib_modificando = true
end event

type pb_elimina_indulto from picturebutton within w_hist_indulto_2_2013_ing
integer x = 2551
integer y = 1000
integer width = 110
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
string powertiptext = "Elimina Extensión de créditos Prerrequisito Inglés"
end type

event clicked;IF dw_hist_indulto.ROWCOUNT() > 0 THEN dw_hist_indulto.DELETEROW(1)
ib_modificando = true
ib_borrado = TRUE 
end event

type pb_insert from picturebutton within w_hist_indulto_2_2013_ing
integer x = 2423
integer y = 1000
integer width = 110
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
string powertiptext = "Inserta Extensión de créditos Prerrequisito Inglés"
end type

event clicked;wf_cambia_periodo()
end event

type dw_historico from datawindow within w_hist_indulto_2_2013_ing
integer x = 754
integer y = 1392
integer width = 1879
integer height = 816
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_hist_indulto_2013_ing_hist"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_hist_indulto_2_2013_ing
integer x = 677
integer y = 1296
integer width = 2025
integer height = 984
integer taborder = 50
integer textsize = -11
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
string text = "Histórico de Extensión de créditos: "
end type

