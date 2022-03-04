$PBExportHeader$w_datos_padre.srw
$PBExportComments$Datos del Padre (llamada desde w_datos_generales)
forward
global type w_datos_padre from window
end type
type cb_3 from commandbutton within w_datos_padre
end type
type cb_2 from commandbutton within w_datos_padre
end type
type cb_1 from commandbutton within w_datos_padre
end type
type dw_datos from datawindow within w_datos_padre
end type
type dw_cp from datawindow within w_datos_padre
end type
end forward

global type w_datos_padre from window
integer x = 146
integer y = 680
integer width = 3392
integer height = 1052
boolean titlebar = true
string title = "Datos del Padre o Tutor"
boolean controlmenu = true
windowtype windowtype = response!
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_datos dw_datos
dw_cp dw_cp
end type
global w_datos_padre w_datos_padre

type variables

transaction itr_admision_web 


end variables

forward prototypes
public function integer wf_replica_sql ()
end prototypes

public function integer wf_replica_sql ();LONG ll_folio
STRING ls_nombre
STRING ls_apaterno
STRING ls_amaterno
STRING ls_calle
STRING ls_codigo_pos
STRING ls_colonia
LONG ll_estado
STRING ls_telefono
LONG ll_clv_ver
LONG ll_clv_per
LONG ll_anio
STRING ls_sexo

INTEGER le_num_registros
STRING ls_error 

ll_folio = dw_datos.GETITEMNUMBER(1, "folio")	
ls_nombre = dw_datos.GETITEMSTRING(1, "nombre")	
ls_apaterno = dw_datos.GETITEMSTRING(1, "apaterno")	
ls_amaterno= dw_datos.GETITEMSTRING(1, "amaterno")	
ls_calle = dw_datos.GETITEMSTRING(1, "calle")	
ls_codigo_pos = dw_datos.GETITEMSTRING(1, "codigo_pos	")
ls_colonia = dw_datos.GETITEMSTRING(1, "colonia")	
ll_estado= dw_datos.GETITEMNUMBER(1, "estado")	
ls_telefono= dw_datos.GETITEMSTRING(1, "telefono")	
ll_clv_ver = dw_datos.GETITEMNUMBER(1, "clv_ver")	
ll_clv_per = dw_datos.GETITEMNUMBER(1, "clv_per")	
ll_anio= dw_datos.GETITEMNUMBER(1, "anio")	
ls_sexo= dw_datos.GETITEMSTRING(1, "sexo")


SELECT COUNT(*) 
INTO :le_num_registros 
FROM padres 
WHERE padres.folio = :ll_folio   
AND padres.clv_ver = :ll_clv_ver    
AND padres.clv_per = :ll_clv_per   
AND padres.anio = :ll_anio   
USING itr_admision_web;

IF le_num_registros > 0 THEN 
	
	UPDATE padres 
	SET 
         padres.nombre = :ls_nombre,    
         padres.apaterno = :ls_apaterno,   
         padres.amaterno = :ls_amaterno,   
         padres.calle = :ls_calle,   
         padres.codigo_pos = :ls_codigo_pos,   
         padres.colonia = :ls_colonia,   
         padres.estado = :ll_estado,   
         padres.telefono = :ls_telefono,   
         padres.sexo = :ls_sexo 
	WHERE padres.folio = :ll_folio 
    AND padres.clv_ver = :ll_clv_ver 
    AND padres.clv_per = :ll_clv_per    
    AND padres.anio = :ll_anio 
	USING  itr_admision_web; 
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		ROLLBACK USING itr_admision_web;
		MESSAGEBOX("Error", "Se produjo un error al actualizar la información de padres WEB: " + ls_error) 
		RETURN -1 
	END IF
	
ELSE
	
	INSERT INTO padres(padres.folio,   padres.nombre,   padres.apaterno,   padres.amaterno,   padres.calle,   
								padres.codigo_pos,   padres.colonia,   padres.estado,   padres.telefono,   padres.clv_ver,   
								padres.clv_per,   padres.anio,   padres.sexo)
	VALUES(:ll_folio, :ls_nombre, :ls_apaterno, :ls_amaterno, :ls_calle, 
				:ls_codigo_pos, :ls_colonia, :ll_estado, :ls_telefono, :ll_clv_ver, 
				:ll_clv_per, :ll_anio, :ls_sexo)
	USING itr_admision_web; 
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		ROLLBACK USING itr_admision_web;
		MESSAGEBOX("Error", "Se produjo un error al insertar la información de padres WEB: " + ls_error) 
		RETURN -1 
	END IF					
	
END IF 
	
COMMIT USING itr_admision_web; 


RETURN 0 



//  SELECT padres.folio,   
//         padres.nombre,   
//         padres.apaterno,   
//         padres.amaterno,   
//         padres.calle,   
//         padres.codigo_pos,   
//         padres.colonia,   
//         padres.estado,   
//         padres.telefono,   
//         padres.clv_ver,   
//         padres.clv_per,   
//         padres.anio,   
//         padres.sexo  
//    FROM padres 
//
//
//
//
//
//
//
//folio	folio	
//nombre	nombre	
//apaterno	apaterno	
//amaterno	amaterno	
//calle	calle	
//codigo_pos	codigo_pos	
//colonia	colonia	
//estado	estado	
//telefono	telefono	
//clv_ver	clv_ver	
//clv_per	clv_per	
//anio	anio	
//sexo   sexo
//
//
//
//
end function

event open;long fol

fol=long(w_datosgenerales.uo_nombre.em_cuenta.text)

dw_datos.settransobject(gtr_sadm)

if fol>1 then
	if dw_datos.retrieve(fol,gi_version,gi_periodo,gi_anio) = 0 then
		dw_datos.insertrow(0)
		dw_datos.object.folio[1]=fol
		dw_datos.object.clv_ver[1]=gi_version
		dw_datos.object.clv_per[1]=gi_periodo
		dw_datos.object.anio[1]=gi_anio
	end if
else
	close(this)
end if


INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if
end event

on w_datos_padre.create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_datos=create dw_datos
this.dw_cp=create dw_cp
this.Control[]={this.cb_3,&
this.cb_2,&
this.cb_1,&
this.dw_datos,&
this.dw_cp}
end on

on w_datos_padre.destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_datos)
destroy(this.dw_cp)
end on

event close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type cb_3 from commandbutton within w_datos_padre
integer x = 1728
integer y = 792
integer width = 850
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Copiar Domicilio del Aspirante"
end type

event clicked;int li_confirmacion

li_confirmacion = MessageBox("Confirmación","¿Desea copiar el domicilio del aspirante?",Question!,YesNo!)

if li_confirmacion= 1 then
		w_datos_padre.dw_datos.object.calle[1]=w_datosgenerales.dw_3.object.calle[1]
		w_datos_padre.dw_datos.object.codigo_pos[1]=w_datosgenerales.dw_3.object.codigo_pos[1]
		w_datos_padre.dw_datos.object.colonia[1]=w_datosgenerales.dw_3.object.colonia[1]
		w_datos_padre.dw_datos.object.estado[1]=w_datosgenerales.dw_3.object.estado[1]
		w_datos_padre.dw_datos.object.telefono[1]=w_datosgenerales.dw_3.object.telefono[1]
else
		MessageBox("Copia Cancelada","No se ha copiado el domicilio",Information!)
end if

end event

type cb_2 from commandbutton within w_datos_padre
integer x = 2601
integer y = 792
integer width = 361
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Actualizar"
end type

event clicked;if w_datos_padre.dw_datos.update() > 0 then
	commit using gtr_sadm;
	MESSAGEBOX("Aviso", "Los datos del padre fueron guardados con éxito")
	// 12/02/2018  Se actualiza la información en SQL SERVER
	IF wf_replica_sql() = 0 THEN 
		MESSAGEBOX("Aviso", "Los datos del padre fueron guardados en WEB con éxito")
	END IF
	close(w_datos_padre)
else
	rollback using gtr_sadm;
end if
end event

type cb_1 from commandbutton within w_datos_padre
integer x = 2985
integer y = 792
integer width = 329
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Cancelar"
end type

event clicked;close(parent)
end event

type dw_datos from datawindow within w_datos_padre
integer x = 73
integer y = 76
integer width = 3246
integer height = 700
integer taborder = 10
string dataobject = "dw_padre_alumnos"
boolean border = false
end type

event constructor;DataWindowChild est
getchild("estado",est)
est.settransobject(gtr_sce)
est.retrieve()

end event

event doubleclicked;//int columna
//
//columna = getcolumn()
//
//CHOOSE CASE COLUMNA
//	CASE 5
//		w_datos_padre.dw_datos.object.calle[1]=w_datosgenerales.dw_3.object.calle[1]
//	CASE 6
//		w_datos_padre.dw_datos.object.codigo_pos[1]=w_datosgenerales.dw_3.object.codigo_pos[1]
//	CASE 7
//		w_datos_padre.dw_datos.object.colonia[1]=w_datosgenerales.dw_3.object.colonia[1]
//	CASE 8
//		w_datos_padre.dw_datos.object.estado[1]=w_datosgenerales.dw_3.object.estado[1]
//	CASE 9
//		w_datos_padre.dw_datos.object.telefono[1]=w_datosgenerales.dw_3.object.telefono[1]
//END CHOOSE

end event

event rbuttondown;w_datos_padre.dw_datos.object.calle[1]=w_datosgenerales.dw_3.object.calle[1]
w_datos_padre.dw_datos.object.codigo_pos[1]=w_datosgenerales.dw_3.object.codigo_pos[1]
w_datos_padre.dw_datos.object.colonia[1]=w_datosgenerales.dw_3.object.colonia[1]
w_datos_padre.dw_datos.object.estado[1]=w_datosgenerales.dw_3.object.estado[1]
w_datos_padre.dw_datos.object.telefono[1]=w_datosgenerales.dw_3.object.telefono[1]

end event

event itemchanged;long columna

columna = getcolumn()

if columna=6 then

	dw_cp.retrieve(data)
	if dw_cp.rowcount()>0 then
		if dw_cp.rowcount()=1 then
			object.colonia[1]=dw_cp.object.colonia[1]+", "+dw_cp.object.ciudad[1]
			object.estado[1]=dw_cp.object.cve_estado[1]
		else
			dw_cp.setfocus()
		end if
	end if	
end if
end event

type dw_cp from datawindow within w_datos_padre
event constructor pbm_constructor
event doubleclicked pbm_dwnlbuttondblclk
event getfocus pbm_dwnsetfocus
event losefocus pbm_dwnkillfocus
integer x = 393
integer y = 180
integer width = 2606
integer height = 488
integer taborder = 20
string dataobject = "dw_codigos_postales"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;hide()
settransobject(gtr_sce)
end event

event doubleclicked;if row>0 then
	dw_datos.object.colonia[1]=object.colonia[row]+", "+object.ciudad[row]
	dw_datos.object.estado[1]=object.cve_estado[row]
	dw_datos.setfocus()
end if

end event

event getfocus;show()
end event

event losefocus;hide()
end event

