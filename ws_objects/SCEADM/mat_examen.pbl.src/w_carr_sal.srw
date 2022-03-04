$PBExportHeader$w_carr_sal.srw
$PBExportComments$Ventana para dar de alta salones para las carreras. dw_version, dw_carr_sal
forward
global type w_carr_sal from window
end type
type dw_fecha_examen from datawindow within w_carr_sal
end type
type st_3 from statictext within w_carr_sal
end type
type st_2 from statictext within w_carr_sal
end type
type st_1 from statictext within w_carr_sal
end type
type uoi_carreras_seleccion from uo_carreras_seleccion within w_carr_sal
end type
type uo_2 from uo_carrera within w_carr_sal
end type
type uo_1 from uo_ver_per_ani within w_carr_sal
end type
type ddlb_1 from dropdownlistbox within w_carr_sal
end type
type dw_1 from uo_dw_captura within w_carr_sal
end type
end forward

global type w_carr_sal from window
integer x = 832
integer y = 360
integer width = 3694
integer height = 2936
boolean titlebar = true
string title = "Salones para Exámen"
string menuname = "m_menu_mat_examen"
boolean resizable = true
long backcolor = 16777215
dw_fecha_examen dw_fecha_examen
st_3 st_3
st_2 st_2
st_1 st_1
uoi_carreras_seleccion uoi_carreras_seleccion
uo_2 uo_2
uo_1 uo_1
ddlb_1 ddlb_1
dw_1 dw_1
end type
global w_carr_sal w_carr_sal

type variables
int ord

uo_administrador_liberacion iuo_administrador_liberacion

transaction itr_admision_web

n_transfiere_sybase_sql in_transfiere_sybase_sql

end variables

forward prototypes
public function integer f_recupera_fechas ()
end prototypes

public function integer f_recupera_fechas ();// Se recuperan las fechas de examen de la versión solicitada
INTEGER li_clv_ver_nueva 

dw_fecha_examen.RESET()
dw_fecha_examen.INSERTROW(0)

li_clv_ver_nueva = gi_version

DATAWINDOWCHILD ldwc_fechas
dw_fecha_examen.GETCHILD("id_examen", ldwc_fechas) 
ldwc_fechas.SETTRANSOBJECT(itr_admision_web) 
ldwc_fechas.RETRIEVE(li_clv_ver_nueva,gi_periodo, gi_anio) 

RETURN 0 



end function

on w_carr_sal.create
if this.MenuName = "m_menu_mat_examen" then this.MenuID = create m_menu_mat_examen
this.dw_fecha_examen=create dw_fecha_examen
this.st_3=create st_3
this.st_2=create st_2
this.st_1=create st_1
this.uoi_carreras_seleccion=create uoi_carreras_seleccion
this.uo_2=create uo_2
this.uo_1=create uo_1
this.ddlb_1=create ddlb_1
this.dw_1=create dw_1
this.Control[]={this.dw_fecha_examen,&
this.st_3,&
this.st_2,&
this.st_1,&
this.uoi_carreras_seleccion,&
this.uo_2,&
this.uo_1,&
this.ddlb_1,&
this.dw_1}
end on

on w_carr_sal.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fecha_examen)
destroy(this.st_3)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.uoi_carreras_seleccion)
destroy(this.uo_2)
destroy(this.uo_1)
destroy(this.ddlb_1)
destroy(this.dw_1)
end on

event open;integer li_conexion

x=1
y=1

dw_1.settransobject(gtr_sadm)

//abre una transacción a MSSQLSERVER

li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)

//transaction		atr_transaccion_parametros
//transaction		atr_transaccion_nueva_bd
//integer 			ai_cve_conexion
//string				as_usuario
//string				as_password

if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if

//dw_aspiran_web.SetTransObject(itr_admision_web )


//Redirigido 2013-04-08 
//dw_1.settransobject(gtr_sadm)
//dw_1.settransobject(itr_admision_web)

f_obten_titulo(w_principal)

if not isvalid(iuo_administrador_liberacion) then
	iuo_administrador_liberacion = CREATE uo_administrador_liberacion	
end if

f_recupera_fechas()
end event

event close;
if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if

if isvalid(iuo_administrador_liberacion) then
	DESTROY iuo_administrador_liberacion 
end if

f_obten_titulo(w_principal)

end event

type dw_fecha_examen from datawindow within w_carr_sal
integer x = 622
integer y = 348
integer width = 1202
integer height = 104
integer taborder = 30
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

type st_3 from statictext within w_carr_sal
integer x = 55
integer y = 372
integer width = 539
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Fecha Aplicación:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_carr_sal
integer x = 2363
integer y = 56
integer width = 430
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Ordenamiento"
boolean focusrectangle = false
end type

type st_1 from statictext within w_carr_sal
integer x = 55
integer y = 236
integer width = 270
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 16777215
string text = "Carrera"
boolean focusrectangle = false
end type

type uoi_carreras_seleccion from uo_carreras_seleccion within w_carr_sal
integer x = 389
integer y = 192
integer taborder = 20
boolean border = false
end type

on uoi_carreras_seleccion.destroy
call uo_carreras_seleccion::destroy
end on

type uo_2 from uo_carrera within w_carr_sal
boolean visible = false
integer x = 2267
integer y = 20
integer width = 1344
integer height = 204
boolean enabled = true
end type

on uo_2.destroy
call uo_carrera::destroy
end on

type uo_1 from uo_ver_per_ani within w_carr_sal
integer y = 16
boolean enabled = true
end type

on uo_1.destroy
call uo_ver_per_ani::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()

RETURN 

end event

type ddlb_1 from dropdownlistbox within w_carr_sal
integer x = 2834
integer y = 56
integer width = 443
integer height = 228
integer taborder = 10
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Por Carrera"
boolean vscrollbar = true
string item[] = {"Por Carrera","Por Salón"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;if index=1 then
	ord=1
else
	ord=2
end if
end event

event constructor;ord=1
end event

type dw_1 from uo_dw_captura within w_carr_sal
integer x = 23
integer y = 492
integer width = 3451
integer height = 2180
integer taborder = 20
string dataobject = "dw_carr_sal_2014"
boolean resizable = true
borderstyle borderstyle = styleraised!
end type

event carga;/*Antes de cargar algo, ve si hay modificaciones no guardadas*/
long ll_cve_carrera, ll_id_fecha
string ls_carrera
event actualiza()
event primero()

//2014-02-14
ll_cve_carrera = uoi_carreras_seleccion.of_obten_cve_carrera()
ls_carrera = uoi_carreras_seleccion.of_obten_carrera()

ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
	RETURN -1
END IF


//object.st_1.text=uo_2.dw_carrera.object.carrera[uo_2.dw_carrera.getrow()]+' '+tit1
//return retrieve(gi_version,ord,gi_periodo,gi_anio,uo_2.dw_carrera.object.cve_carrera[uo_2.dw_carrera.getrow()])

object.st_1.text= ls_carrera+' '+tit1
return retrieve(gi_version,ord,gi_periodo,gi_anio,ll_cve_carrera,ll_id_fecha )
end event

event constructor;call super::constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild sal
getchild("salon",sal)
sal.settransobject(gtr_sce)
sal.retrieve()
end event

event nuevo;long ll_rows, ll_new_row, ll_rows_despues_insert, ll_row_elegido, ll_cve_carrera, ll_id_fecha

ll_cve_carrera = uoi_carreras_seleccion.of_obten_cve_carrera()

ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
	RETURN 
END IF



this.SetRowFocusIndicator(Hand!) 
this.setfocus()

ll_rows = this.rowcount()
ll_new_row = this.scrolltorow(insertrow(0))


//setcolumn(1)




if gi_version<99 then
	
//	object.folios[ll_row]=0
//	object.clv_ver[ll_row]=gi_version
//	object.clv_per[ll_row]=gi_periodo
//	object.anio[ll_row]=gi_anio
	ll_rows_despues_insert = rowcount()
	ll_row_elegido= scrolltorow(ll_rows_despues_insert)
	this.SetItem(ll_rows_despues_insert, "clv_carr",ll_cve_carrera)
	this.SetItem(ll_rows_despues_insert, "folios",0)
	this.SetItem(ll_rows_despues_insert, "clv_ver",gi_version)
	this.SetItem(ll_rows_despues_insert, "clv_per",gi_periodo)
	this.SetItem(ll_rows_despues_insert, "anio",gi_anio)	
	this.SetItem(ll_rows_despues_insert, "id_examen",ll_id_fecha)	
	ll_row_elegido= scrolltorow(ll_rows_despues_insert)
end if





end event

event inicia_transaction_object;call super::inicia_transaction_object;tr_dw_propio = gtr_sadm
end event

event actualiza;/*
DESCRIPCIÓN: Evento en el cual se actualizan los cambios efectuados.
				
PARÁMETROS: Ninguno
REGRESA: Nada
AUTOR: Antonio Pica Ruiz
FECHA: 14 Febrero 2014
MODIFICACIÓN:
*/
int li_respuesta

u_datastore lds_origen, lds_destino, lds_origen2, lds_destino2,  lds_origen3, lds_destino3
string  ls_dataobject_carr_sal, ls_dataobject_general, ls_dataobject_padres
long ll_actualiza_datastore, ll_actualiza_datastore2, ll_actualiza_datastore3,ll_rows1, ll_rows2, ll_rows3,  ll_rows4, ll_rows5, ll_rows6, ll_id_fecha
integer li_inserta_aspiran, li_inserta_general, li_inserta_padres
n_transfiere_sybase_sql ln_transfiere_sybase_sql
integer li_cambio_version_examen_sit_2013
LONG ll_pos_null, llpos
LONG ll_pos_mod

/*Acepta el texto de la última columna editada*/
AcceptText()

ll_id_fecha = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(ll_id_fecha) OR ll_id_fecha = 0 THEN 
	MESSAGEBOX("Error", "Debe seleccionar una fecha de aplicación de exámen. " ) 
	RETURN -1
END IF

/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
if ModifiedCount()+DeletedCount() > 0 Then

	/*Se verifica si ya se asignó fecha de exámen a todos los registros.*/ 
//	ll_pos_null = THIS.FIND("ISNULL(id_examen) OR id_examen <= 0", 0, THIS.ROWCOUNT() + 1)
//	IF ll_pos_null > 0 THEN 
		IF MESSAGEBOX("Confirmación", "Los salones serán guardados asociados a la FECHA DE EXAMEN, PERIODO Y VERSION SELECCIONADOS. ¿Desea continuar?", Question!,YesNo!,2) = 2 THEN RETURN -1	
		// Se hace ciclo para asignar la fecha de examen.
		FOR llpos = 1 TO THIS.ROWCOUNT()
			THIS.SETITEM(llpos, "id_examen", ll_id_fecha)
			this.SetItem(llpos, "clv_ver",gi_version)
			this.SetItem(llpos, "clv_per",gi_periodo)
			this.SetItem(llpos, "anio",gi_anio)				
		NEXT
//	END IF
	
	/*Si no se ha asignado se solicita confirmación de la fecha de exámen*/
	
	
	/*Se verifica si ya se asignó fecha de exámen a todos los registros.*/ 
	/*Pregunta si se desean guardar los cambios hechos*/
	li_respuesta = messagebox("Atención","Los salones serán actualizados ¿Desea Continuar?",Question!,YesNo!,2) 


	if li_respuesta = 1 then
		
			// Se elimina la captura previa de salones
			DELETE FROM carr_sal      
			  WHERE carr_sal.clv_per =  :gi_periodo 
			  and  carr_sal.anio = :gi_anio
			  AND carr_sal.clv_ver = :gi_version 
			  AND carr_sal.id_examen = :ll_id_fecha
			  USING gtr_sadm;
			  IF itr_admision_web.SQLCODE < 0 THEN
				MessageBox("Error de Actualización","No es posible realizar la inserción en SQLWEBPRO.admision_bd.carr_sal",StopSign!)
				return -1 
			END IF
		
			// Se modifican todos los renglones para que sean insertados.
			FOR ll_pos_mod = 1 TO dw_1.ROWCOUNT() 
				dw_1.SetItemStatus(ll_pos_mod, 0, Primary!, NewModified!) 
			NEXT
		
			/*Checa que los renglones cumplan con las reglas de validación*/
			if event actualiza_np() = 1 then//Manda llamar la función que realiza el update
					//ls_dataobject_carr_sal = 'd_carr_sal_sql_sybase'
					ls_dataobject_carr_sal = 'd_carr_sal_sybase_sql'

					lds_origen = create u_datastore
					lds_destino = create u_datastore

					lds_origen.dataobject    = ls_dataobject_carr_sal
					lds_destino.dataobject   = ls_dataobject_carr_sal
		
					lds_origen.SetTransObject(tr_dw_propio)		
					lds_destino.SetTransObject(itr_admision_web)
				
					//Inserta en la tabla de carr_sal
					ll_rows1 = lds_origen.Retrieve(gi_version, gi_periodo, gi_anio,ll_id_fecha)
					ln_transfiere_sybase_sql =  create n_transfiere_sybase_sql

					//Inserta en la tabla de carr_sal
					if ll_rows1<> -1 then
						
						///////////////////////////////////////
						// Se eilimina la versión y el periodo en el destino 
						DELETE FROM carr_sal      
				        WHERE carr_sal.clv_per =  :gi_periodo 
						  and  carr_sal.anio = :gi_anio
						  AND carr_sal.clv_ver = :gi_version 
						  AND carr_sal.id_examen = :ll_id_fecha
						  USING itr_admision_web;
						  IF itr_admision_web.SQLCODE < 0 THEN
							MessageBox("Error de Actualización","No es posible realizar la inserción en SQLWEBPRO.admision_bd.carr_sal",StopSign!)
							return -1 
						END IF
						  
						
						///////////////////////////////////////
						
						ll_actualiza_datastore = ln_transfiere_sybase_sql.of_delete_insert_datastore(lds_origen, lds_destino, tr_dw_propio, itr_admision_web)
		
						if ll_actualiza_datastore= -1 then
							MessageBox("Error de Actualización","No es posible realizar la inserción en SQLWEBPRO.admision_bd.carr_sal",StopSign!)
							return -1 
						ELSE
							messagebox("Información","Se ha actualizado SQLWEBPRO.admision_bd.carr_sal") 
						end if
					else
						MessageBox("Error de Actualización","No es posible realizar la consulta en SYBCESPRO.admision_bd.carr_sal",StopSign!)
						return -1
					end if			
				return 1
			else 
				return -1
			end if
	else
		/*De lo contrario, solo avisa que no se guardó nada.*/
		messagebox("Información","No se han guardado los cambios")
		return -1
	end if
else
	return 1
end if


end event

event rowfocuschanged;SetRowFocusIndicator(Hand!) 
end event

