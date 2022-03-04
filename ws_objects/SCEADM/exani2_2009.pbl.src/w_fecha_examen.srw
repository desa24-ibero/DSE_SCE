$PBExportHeader$w_fecha_examen.srw
forward
global type w_fecha_examen from window
end type
type dw_copia_sybase from datawindow within w_fecha_examen
end type
type cb_2 from commandbutton within w_fecha_examen
end type
type cb_1 from commandbutton within w_fecha_examen
end type
type pb_delete from picturebutton within w_fecha_examen
end type
type pb_insert from picturebutton within w_fecha_examen
end type
type cb_carga from commandbutton within w_fecha_examen
end type
type uo_per_ani from uo_per_ani_admision within w_fecha_examen
end type
type dw_turno from datawindow within w_fecha_examen
end type
type dw_examen_fecha from datawindow within w_fecha_examen
end type
end forward

global type w_fecha_examen from window
integer width = 4919
integer height = 2300
boolean titlebar = true
string title = "Fechas de Aplicación de Examen de Admisión"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
dw_copia_sybase dw_copia_sybase
cb_2 cb_2
cb_1 cb_1
pb_delete pb_delete
pb_insert pb_insert
cb_carga cb_carga
uo_per_ani uo_per_ani
dw_turno dw_turno
dw_examen_fecha dw_examen_fecha
end type
global w_fecha_examen w_fecha_examen

type variables

INTEGER ie_periodo, ie_anio 

transaction itr_admision_web



end variables

forward prototypes
public function integer wf_valida_fecha (integer al_row)
end prototypes

public function integer wf_valida_fecha (integer al_row);
DATETIME ldt_fecha_examen
INTEGER li_id_turno
INTEGER li_estatus
INTEGER li_cupo
INTEGER li_ocupado
DATETIME ldt_fecha_limite_registro
DATETIME ldt_fecha_inicio_despliegue
DATETIME ldt_comp
INTEGER li_periodo_ingreso
INTEGER li_anio_ingreso


ldt_fecha_examen = dw_examen_fecha.GETITEMDATETIME(al_row, "fecha_examen")
IF ISNULL(ldt_fecha_examen) OR ldt_fecha_examen = ldt_comp THEN 
	MESSAGEBOX("ERROR", "No se ha especificado Fecha de Éxamen.") 
	RETURN -1
END IF

li_id_turno = dw_examen_fecha.GETITEMNUMBER(al_row, "id_turno")
IF ISNULL(li_id_turno) THEN 
	MESSAGEBOX("ERROR", "No se ha especificado Turno.") 
	RETURN -1	
END IF

li_estatus = dw_examen_fecha.GETITEMNUMBER(al_row, "estatus")
IF ISNULL(li_estatus) THEN 
	MESSAGEBOX("ERROR", "No se ha especificado Estatus de Fecha de Éxamen.") 
	RETURN -1	
END IF

li_cupo = dw_examen_fecha.GETITEMNUMBER(al_row, "cupo")
IF ISNULL(li_cupo) THEN 
	MESSAGEBOX("ERROR", "No se ha especificado Cupo.") 
	RETURN -1	
END IF

li_ocupado = dw_examen_fecha.GETITEMNUMBER(al_row, "ocupado")
IF ISNULL(li_ocupado) THEN li_ocupado = 0

ldt_fecha_limite_registro = dw_examen_fecha.GETITEMDATETIME(al_row, "fecha_limite_registro")
IF ISNULL(ldt_fecha_limite_registro) OR ldt_fecha_limite_registro = ldt_comp THEN 
	MESSAGEBOX("ERROR", "No se ha especificado Fecha Límite de Registro.") 
	RETURN -1	
END IF 

ldt_fecha_inicio_despliegue = dw_examen_fecha.GETITEMDATETIME(al_row, "fecha_inicio_despliegue")
IF ISNULL(ldt_fecha_inicio_despliegue) OR ldt_fecha_inicio_despliegue = ldt_comp THEN 
	MESSAGEBOX("ERROR", "No se ha especificado Fecha de Inicio de Despliegue.") 
	RETURN -1		
END IF

// Ciclo para verificar que no se haya repetido una misma fecha y turno.
INTEGER li_pos, ll_ttl_reg
INTEGER le_turno_pos
DATETIME ldt_fecha_pos

ll_ttl_reg = dw_examen_fecha.ROWCOUNT()

FOR li_pos = 1 TO ll_ttl_reg 
	
	// Si se trata del registro que se edita continua con el ciclo 
	IF li_pos = al_row THEN CONTINUE

	le_turno_pos = dw_examen_fecha.GETITEMNUMBER(li_pos, "id_turno")
	ldt_fecha_pos = dw_examen_fecha.GETITEMDATETIME(li_pos, "fecha_examen")

	IF le_turno_pos = li_id_turno AND DATE(ldt_fecha_pos) = DATE(ldt_fecha_examen) THEN 
		MESSAGEBOX("Aviso", "Ya existe registrada una Fecha de Exámen con el mismo Turno.") 
		RETURN -1
	END IF
	
NEXT

RETURN 0 
  
  
  
end function

on w_fecha_examen.create
this.dw_copia_sybase=create dw_copia_sybase
this.cb_2=create cb_2
this.cb_1=create cb_1
this.pb_delete=create pb_delete
this.pb_insert=create pb_insert
this.cb_carga=create cb_carga
this.uo_per_ani=create uo_per_ani
this.dw_turno=create dw_turno
this.dw_examen_fecha=create dw_examen_fecha
this.Control[]={this.dw_copia_sybase,&
this.cb_2,&
this.cb_1,&
this.pb_delete,&
this.pb_insert,&
this.cb_carga,&
this.uo_per_ani,&
this.dw_turno,&
this.dw_examen_fecha}
end on

on w_fecha_examen.destroy
destroy(this.dw_copia_sybase)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.pb_delete)
destroy(this.pb_insert)
destroy(this.cb_carga)
destroy(this.uo_per_ani)
destroy(this.dw_turno)
destroy(this.dw_examen_fecha)
end on

event open;//abre una transacción a MSSQLSERVER
INTEGER li_conexion 

li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)




cb_carga.TRIGGEREVENT(CLICKED!)

dw_turno.SETTRANSOBJECT(itr_admision_web)
dw_turno.RETRIEVE()



end event

event close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type dw_copia_sybase from datawindow within w_fecha_examen
boolean visible = false
integer x = 1920
integer y = 1740
integer width = 686
integer height = 400
integer taborder = 80
string title = "none"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type cb_2 from commandbutton within w_fecha_examen
integer x = 4379
integer y = 1724
integer width = 402
integer height = 112
integer taborder = 70
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;CLOSE(PARENT)
end event

type cb_1 from commandbutton within w_fecha_examen
integer x = 3945
integer y = 1724
integer width = 402
integer height = 112
integer taborder = 60
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;LONG ll_id_examen, llpos, ll_id_examen_act

dw_examen_fecha.ACCEPTTEXT() 

SELECT MAX(id_examen) 
INTO :ll_id_examen
FROM examen_fecha
USING itr_admision_web;
IF itr_admision_web.SQLCODE < 0 THEN 
	MESSAGEBOX("ERROR", "Se produjo un error al recuperar el id del exámen: " + itr_admision_web.SQLERRTEXT)  
END IF
IF ISNULL(ll_id_examen) THEN ll_id_examen = 0 

INTEGER le_num_examenes

le_num_examenes = dw_examen_fecha.ROWCOUNT() 

FOR llpos = 1 TO le_num_examenes 
	ll_id_examen_act = dw_examen_fecha.getitemnumber(llpos, "id_examen") 
	IF isnull(ll_id_examen_act) THEN 
		IF wf_valida_fecha(llpos) < 0 THEN RETURN 0
		ll_id_examen = ll_id_examen + 1 		
		dw_examen_fecha.SETITEM(llpos, "id_examen", ll_id_examen)  
	END IF
NEXT 

// Se asigna el nuevo orden de aplicación de exámenes 
dw_examen_fecha.SETSORT("fecha_examen asc, id_turno asc") 
dw_examen_fecha.SORT()
FOR llpos = 1 TO le_num_examenes 
	dw_examen_fecha.SETITEM(llpos, "orden_periodo_ing", llpos)  
NEXT 


IF dw_examen_fecha.UPDATE() = 1 THEN 
	
	COMMIT USING itr_admision_web;
	
	// Se hace la transferencia a Sybase
	INTEGER le_pos, ll_ttl_rows

	dw_copia_sybase.DATAOBJECT = "dw_examen_fecha_sql_syb" 
	dw_copia_sybase.SETTRANSOBJECT(gtr_sadm) 
	ll_ttl_rows = dw_copia_sybase.RETRIEVE(ie_periodo, ie_anio)
	FOR le_pos = 1 TO ll_ttl_rows 
		dw_copia_sybase.DELETEROW(1)
	NEXT
	dw_examen_fecha.ROWSCOPY(1, dw_examen_fecha.ROWCOUNT(), PRIMARY!, dw_copia_sybase, dw_copia_sybase.ROWCOUNT() + 1, PRIMARY!)
	IF dw_copia_sybase.UPDATE() < 0 THEN 
		MESSAGEBOX("ERROR", "Se produjo un error al actualizar las fechas en SYBASE: " + gtr_sadm.SQLERRTEXT)  
		ROLLBACK USING gtr_sadm;		
	ELSE
		COMMIT USING gtr_sadm;
	END IF
	
	MESSAGEBOX("Aviso", "Las fechas han sido actualizadas con éxito ")  
	
ELSE
	MESSAGEBOX("ERROR", "Se produjo un error al actualizar las fechas: " + itr_admision_web.SQLERRTEXT)  
	ROLLBACK USING itr_admision_web;
END IF




end event

type pb_delete from picturebutton within w_fecha_examen
integer x = 4663
integer y = 140
integer width = 110
integer height = 96
integer taborder = 40
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;LONG ll_id_examen_act 
LONG ll_num_reg

ll_id_examen_act = dw_examen_fecha.getitemnumber(dw_examen_fecha.GETROW(), "id_examen") 

// Se verifica si la fecha de exámen ya tiene asiciados salones o aspirantes.
SELECT COUNT(*) 
INTO :ll_num_reg 
FROM carr_sal 
WHERE id_examen = :ll_id_examen_act 
USING itr_admision_web; 
IF itr_admision_web.SQLCODE < 0 THEN 
	MESSAGEBOX("Aviso", "Se produjo un error al verificar existencia de salones: " + itr_admision_web.SQLERRTEXT)
	RETURN -1
END IF
IF ll_num_reg > 0 THEN 
	MESSAGEBOX("Aviso", "La fecha de exámen no puede ser eliminada porque ya tiene salones asociados. Si la fecha ya no es válida solo debe deshabilitarla asignándole el estatus 'CERRADO' ") 
	RETURN -1
END IF


SELECT COUNT(*) 
INTO :ll_num_reg 
FROM aspiran  
WHERE id_examen = :ll_id_examen_act 
USING itr_admision_web; 
IF itr_admision_web.SQLCODE < 0 THEN 
	MESSAGEBOX("Aviso", "Se produjo un error al verificar existencia de aspirantes: " + itr_admision_web.SQLERRTEXT)
	RETURN -1
END IF
IF ll_num_reg > 0 THEN 
	MESSAGEBOX("Aviso", "La fecha de exámen no puede ser eliminada porque ya tiene aspirantes asociados. Si la fecha ya no es válida solo debe deshabilitarla asignándole el estatus 'CERRADO' ") 
	RETURN -1
END IF



IF NOT ISNULL(ll_id_examen_act) THEN 
	IF MESSAGEBOX("CONFIRMACIÓN", "La fecha de Aplicación de Exámen No." + STRING(ll_id_examen_act) + " será ELIMINADA ¿Desea Continuar? ", Question!, YesNoCancel!) > 1 THEN RETURN 0 
END IF

dw_examen_fecha.DELETEROW(dw_examen_fecha.GETROW())

IF dw_examen_fecha.UPDATE() < 0 THEN 
	COMMIT USING itr_admision_web;
END IF

cb_carga.TRIGGEREVENT(CLICKED!)





end event

type pb_insert from picturebutton within w_fecha_examen
integer x = 4530
integer y = 140
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;
INTEGER le_row
le_row = dw_examen_fecha.INSERTROW(0)

dw_examen_fecha.SETITEM(le_row, "periodo_ingreso", ie_periodo)
dw_examen_fecha.SETITEM(le_row, "anio_ingreso", ie_anio)

dw_examen_fecha.SCROLLTOROW(le_row)
dw_examen_fecha.SETROW(le_row) 






end event

type cb_carga from commandbutton within w_fecha_examen
integer x = 1454
integer y = 64
integer width = 402
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cargar"
end type

event clicked;INTEGER le_periodo, le_anio 
INTEGER llpos 

le_periodo = parent.uo_per_ani.ie_periodo
le_anio = parent.uo_per_ani.ie_anio

dw_examen_fecha.SETTRANSOBJECT(itr_admision_web)
dw_examen_fecha.RETRIEVE(le_periodo,le_anio)

ie_periodo = le_periodo
ie_anio = le_anio


// Se asigna el nuevo orden de aplicación de exámenes 
dw_examen_fecha.SETSORT("fecha_examen asc, id_turno asc") 
dw_examen_fecha.SORT()
FOR llpos = 1 TO dw_examen_fecha.ROWCOUNT()  
	dw_examen_fecha.SETITEM(llpos, "orden_periodo_ing", llpos)  
NEXT 

end event

type uo_per_ani from uo_per_ani_admision within w_fecha_examen
integer x = 69
integer y = 32
integer taborder = 10
boolean enabled = true
long backcolor = 67108864
end type

on uo_per_ani.destroy
call uo_per_ani_admision::destroy
end on

event ue_modifica;call super::ue_modifica;
PARENT.ie_periodo = THIS.ie_periodo
PARENT.ie_anio = THIS.ie_anio
end event

type dw_turno from datawindow within w_fecha_examen
integer x = 64
integer y = 1720
integer width = 1472
integer height = 424
string title = "none"
string dataobject = "dw_examen_turno_lista"
boolean border = false
boolean livescroll = true
end type

type dw_examen_fecha from datawindow within w_fecha_examen
integer x = 64
integer y = 268
integer width = 4718
integer height = 1396
integer taborder = 50
string title = "none"
string dataobject = "dw_examen_fecha"
boolean hscrollbar = true
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;

IF dwo.name = "id_turno" THEN 

	INTEGER le_cupo 
	INTEGER le_turno
	
	le_turno = INTEGER(data)
	
	SELECT cupo_default 
	INTO :le_cupo
	FROM examen_turno 
	WHERE id_turno = :le_turno  
	USING itr_admision_web;
	IF itr_admision_web.SQLCODE < 0 THEN 
		MESSAGEBOX("ERROR", "Se produjo un error al recuperar el cupo por default: " + itr_admision_web.SQLERRTEXT) 
	END IF
	
	IF ISNULL(le_cupo) THEN le_cupo = 0 
		
	THIS.SETITEM(row, "cupo", le_cupo) 
	THIS.SETITEM(row, "ocupado", 0) 
	
ELSEIF dwo.name = "fecha_examen" THEN 	
	
	DATETIME ldt_fecha_examen
	ldt_fecha_examen = DATETIME(DATE(data))
	
	INTEGER le_cve_version
	
	SELECT clv_ver 
	INTO :le_cve_version 
	FROM fecha 
	WHERE clv_actividad = 13 
	AND :ldt_fecha_examen >= fecha_ini
	AND :ldt_fecha_examen<= fecha_fin
	USING  gtr_sadm;
	IF gtr_sadm.SQLCODE < 0 THEN 
		MESSAGEBOX("Error", "Se produjo un error al recuperar la versión de la fecha de exámen ingresada: " + gtr_sadm.SQLERRTEXT) 
		RETURN 2	
	END IF 

	IF ISNULL(le_cve_version) OR gtr_sadm.SQLCODE = 100 THEN 
		MESSAGEBOX("Error", "No existe una versión de examen definida para la fecha de éxamen ingresada") 
		RETURN 2			
	END IF
	
	THIS.SETITEM(row, "cve_ver", le_cve_version) 
	
END IF 






 
end event

event constructor;SetRowFocusIndicator(Hand!) 
end event

