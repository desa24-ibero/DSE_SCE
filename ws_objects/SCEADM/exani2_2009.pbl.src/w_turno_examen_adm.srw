$PBExportHeader$w_turno_examen_adm.srw
forward
global type w_turno_examen_adm from window
end type
type pb_borrar from picturebutton within w_turno_examen_adm
end type
type pb_agregar from picturebutton within w_turno_examen_adm
end type
type cb_2 from commandbutton within w_turno_examen_adm
end type
type cb_1 from commandbutton within w_turno_examen_adm
end type
type dw_turno from datawindow within w_turno_examen_adm
end type
end forward

global type w_turno_examen_adm from window
integer width = 1632
integer height = 932
boolean titlebar = true
string title = "Turnos de Aplicación de Examen"
boolean controlmenu = true
boolean minbox = true
boolean maxbox = true
boolean resizable = true
windowstate windowstate = maximized!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
pb_borrar pb_borrar
pb_agregar pb_agregar
cb_2 cb_2
cb_1 cb_1
dw_turno dw_turno
end type
global w_turno_examen_adm w_turno_examen_adm

type variables
transaction itr_admision_web
end variables

on w_turno_examen_adm.create
this.pb_borrar=create pb_borrar
this.pb_agregar=create pb_agregar
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_turno=create dw_turno
this.Control[]={this.pb_borrar,&
this.pb_agregar,&
this.cb_2,&
this.cb_1,&
this.dw_turno}
end on

on w_turno_examen_adm.destroy
destroy(this.pb_borrar)
destroy(this.pb_agregar)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_turno)
end on

event open;INTEGER li_conexion

li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)

dw_turno.SETTRANSOBJECT(gtr_sadm) 
dw_turno.RETRIEVE() 



end event

type pb_borrar from picturebutton within w_turno_examen_adm
integer x = 219
integer y = 652
integer width = 110
integer height = 96
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "DeleteRow!"
alignment htextalign = left!
end type

event clicked;LONG ll_id_turno_act 
LONG ll_ttl_examenes

ll_id_turno_act = dw_turno.getitemnumber(dw_turno.GETROW(), "id_turno") 
IF NOT ISNULL(ll_id_turno_act) THEN 
	IF MESSAGEBOX("CONFIRMACIÓN", "El Turno de Aplicación de Exámen No." + STRING(ll_id_turno_act) + " será ELIMINADO ¿Desea Continuar? ", Question!, YesNoCancel!) > 1 THEN RETURN 0 
END IF

SELECT COUNT(*) 
INTO :ll_ttl_examenes
FROM examen_fecha 
WHERE id_turno = :ll_id_turno_act 
USING gtr_sadm; 
IF gtr_sadm.SQLCODE < 0 THEN  
	MESSAGEBOX("ERROR", "Se produjo un error al verificar Fechas de Exámen con éste Turno: " + gtr_sadm.SQLERRTEXT)
	RETURN 0
END IF 
IF ll_ttl_examenes > 0 THEN 
	MESSAGEBOX("Aviso", "Existen fechas de Aplicación de Éxamen en éste Turno, por lo que no puede ser eliminado.") 
	RETURN 0
END IF


dw_turno.DELETEROW(dw_turno.GETROW())

IF dw_turno.UPDATE() < 0 THEN 
	COMMIT USING gtr_sadm;
END IF



end event

type pb_agregar from picturebutton within w_turno_examen_adm
integer x = 82
integer y = 652
integer width = 110
integer height = 96
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "Insert5!"
alignment htextalign = left!
end type

event clicked;dw_turno.INSERTROW(0)
end event

type cb_2 from commandbutton within w_turno_examen_adm
integer x = 1120
integer y = 644
integer width = 402
integer height = 112
integer taborder = 50
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Salir"
end type

event clicked;
CLOSE(PARENT) 


end event

type cb_1 from commandbutton within w_turno_examen_adm
integer x = 677
integer y = 644
integer width = 402
integer height = 112
integer taborder = 40
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Guardar"
end type

event clicked;
LONG ll_id_turno, llpos, ll_id_turno_act, ll_rows1, ll_actualiza_datastore
n_transfiere_sybase_sql ln_transfiere_sybase_sql

SELECT MAX(id_turno) 
INTO :ll_id_turno
FROM examen_turno
USING gtr_sadm;
IF gtr_sadm.SQLCODE < 0 THEN 
	MESSAGEBOX("ERROR", "Se produjo un error al recuperar el id del Turno: " + gtr_sadm.SQLERRTEXT)  
END IF
IF ISNULL(ll_id_turno) THEN ll_id_turno = 0 

INTEGER le_num_turnos

le_num_turnos = dw_turno.ROWCOUNT() 

FOR llpos = 1 TO le_num_turnos 
	ll_id_turno_act = dw_turno.getitemnumber(llpos, "id_turno") 
	IF isnull(ll_id_turno_act) THEN 
		ll_id_turno = ll_id_turno + 1 		
		dw_turno.SETITEM(llpos, "id_turno", ll_id_turno)  
	END IF
NEXT 

IF dw_turno.UPDATE() = 1 THEN 
	COMMIT USING gtr_sadm;
//	MESSAGEBOX("Aviso", "Los turnos han sido actualizadas con éxito ")  
ELSE
	MESSAGEBOX("ERROR", "Se produjo un error al actualizar los turnos: " + gtr_sadm.SQLERRTEXT)  
	ROLLBACK USING gtr_sadm;
END IF

// Se hace la transferencia a SQL SERVER
ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql

u_datastore lds_origen, lds_destino

lds_origen = create u_datastore
lds_destino = create u_datastore

lds_origen.dataobject    = dw_turno.DATAOBJECT
lds_destino.dataobject   = dw_turno.DATAOBJECT

lds_origen.SetTransObject(gtr_sadm)	 
lds_destino.SetTransObject(itr_admision_web) 

ll_rows1 = lds_origen.Retrieve()

//Inserta en la tabla de carr_sal
if ll_rows1<> -1 then
	
	///////////////////////////////////////
	// Se eiliminan los turnos
	DELETE FROM examen_turno      
	  USING itr_admision_web;
	  IF itr_admision_web.SQLCODE < 0 THEN
		MessageBox("Error de Actualización","No es posible realizar la inserción en SQLWEBPRO.admision_bd.examen_turno",StopSign!)
		return -1 
	END IF
	///////////////////////////////////////
	
	ll_actualiza_datastore = ln_transfiere_sybase_sql.of_delete_insert_datastore(lds_origen, lds_destino, gtr_sadm, itr_admision_web)

	if ll_actualiza_datastore= -1 then
		ROLLBACK USING itr_admision_web;
		MessageBox("Error de Actualización","No es posible realizar la inserción en SQLWEBPRO.admision_bd.examen_turno",StopSign!)
		return -1 
	ELSE
		COMMIT USING itr_admision_web; 
		//messagebox("Información","Se ha replicado la información en WEB ") 
	end if
else
	MessageBox("Error de Actualización","No es posible realizar la consulta en SYBCESPRO.admision_bd.examen_turno",StopSign!)
	return -1
end if			

MESSAGEBOX("Aviso", "Los turnos han sido actualizadas con éxito ")  









end event

type dw_turno from datawindow within w_turno_examen_adm
integer x = 64
integer y = 56
integer width = 1458
integer height = 556
integer taborder = 10
string title = "none"
string dataobject = "dw_examen_turno"
boolean vscrollbar = true
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

