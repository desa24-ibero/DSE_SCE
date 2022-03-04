$PBExportHeader$w_datosgenerales.srw
$PBExportComments$Despliegue, consulta y modificación de datos generales de un aspirante(Nombre,direccion,esc. proc., fec. nac., ......)
forward
global type w_datosgenerales from window
end type
type uo_nombre from uo_nombre_aspirante within w_datosgenerales
end type
type cb_2 from commandbutton within w_datosgenerales
end type
type cb_3 from commandbutton within w_datosgenerales
end type
type dw_1 from datawindow within w_datosgenerales
end type
type cb_1 from commandbutton within w_datosgenerales
end type
type em_bachillera from editmask within w_datosgenerales
end type
type dw_3 from datawindow within w_datosgenerales
end type
type dw_cp from datawindow within w_datosgenerales
end type
type dw_2 from datawindow within w_datosgenerales
end type
end forward

global type w_datosgenerales from window
boolean visible = false
integer x = 5
integer y = 4
integer width = 3730
integer height = 1700
boolean titlebar = true
string title = "Datos Generales de Aspirantes"
string menuname = "m_menu"
long backcolor = 10789024
uo_nombre uo_nombre
cb_2 cb_2
cb_3 cb_3
dw_1 dw_1
cb_1 cb_1
em_bachillera em_bachillera
dw_3 dw_3
dw_cp dw_cp
dw_2 dw_2
end type
global w_datosgenerales w_datosgenerales

type variables
string st_salones[]
int in_num_salones 


transaction itr_admision_web 






end variables

forward prototypes
public function integer wf_replica_sql ()
end prototypes

public function integer wf_replica_sql ();
LONG ll_folio
STRING ls_nombre
STRING ls_apaterno
STRING ls_amaterno
STRING ls_calle
STRING ls_codigo_pos
STRING ls_colonia
LONG ll_estado
STRING ls_telefono
DATETIME lf_fecha_nac
LONG ll_lugar_nac
LONG ll_nacional
STRING ls_sexo
LONG ll_edo_civil
LONG ll_religion
LONG ll_bachillera
LONG ll_trabajo
LONG ll_trab_hor
LONG ll_ya_inscri
LONG ll_cuenta
LONG ll_transporte
LONG ll_anio
LONG ll_clv_ver
LONG ll_clv_per
STRING ls_telefono_movil
STRING ls_e_mail

LONG ll_total 
STRING ls_error

ll_folio = dw_3.GETITEMNUMBER(1, "folio")
ls_nombre = dw_3.GETITEMSTRING(1, "nombre")	
ls_apaterno	= dw_3.GETITEMSTRING(1, "apaterno")	 
ls_amaterno = dw_3.GETITEMSTRING(1, "amaterno")	
ls_calle = dw_3.GETITEMSTRING(1, "calle")	
ls_codigo_pos = dw_3.GETITEMSTRING(1, "codigo_pos")	  
ls_colonia= dw_3.GETITEMSTRING(1, "colonia")	
ll_estado = dw_3.GETITEMNUMBER(1, "estado")	
ls_telefono= dw_3.GETITEMSTRING(1, "telefono")	 
lf_fecha_nac= dw_3.GETITEMDATETIME(1, "fecha_nac")	
ll_lugar_nac = dw_3.GETITEMNUMBER(1, "lugar_nac")	
ll_nacional = dw_3.GETITEMNUMBER(1, "nacional")	  
ls_sexo= dw_3.GETITEMSTRING(1, "sexo")	
ll_edo_civil = dw_3.GETITEMNUMBER(1, "edo_civil")	   
ll_religion = dw_3.GETITEMNUMBER(1, "religion")	
ll_bachillera = dw_3.GETITEMNUMBER(1, "bachillera")	
ll_trabajo = dw_3.GETITEMNUMBER(1, "trabajo")	
ll_trab_hor = dw_3.GETITEMNUMBER(1, "trab_hor")	  
ll_ya_inscri = dw_3.GETITEMNUMBER(1, "ya_inscri")	  
ll_cuenta = dw_3.GETITEMNUMBER(1, "cuenta")	
ll_transporte = dw_3.GETITEMNUMBER(1, "transporte")	
ll_anio = dw_3.GETITEMNUMBER(1, "anio")	
ll_clv_ver = dw_3.GETITEMNUMBER(1, "clv_ver")	
ll_clv_per = dw_3.GETITEMNUMBER(1, "clv_per")	
ls_telefono_movil= dw_3.GETITEMSTRING(1, "general_telefono_movil")	  
ls_e_mail= dw_3.GETITEMSTRING(1, "general_e_mail")

// Se verifica si existe un registro previo de general en SQL_SQERVER 
SELECT COUNT(*) 
INTO :ll_total 
FROM general 
WHERE folio = :ll_folio
AND clv_ver = :ll_clv_ver 
AND clv_per = :ll_clv_per 
AND anio = :ll_anio 
USING itr_admision_web; 

IF ll_total > 0 THEN 
	
	UPDATE general 
	SET general.nombre = :ls_nombre,   
         general.apaterno = :ls_apaterno,   
         general.amaterno = : ls_amaterno,   
         general.calle = :ls_calle,   
         general.codigo_pos = :ls_codigo_pos,   
         general.colonia = :ls_colonia,   
         general.estado = :ll_estado,   
         general.telefono = :ls_telefono,   
         general.fecha_nac = : lf_fecha_nac,   
         general.lugar_nac = :ll_lugar_nac,   
         general.nacional = :ll_nacional,   
         general.sexo = :ls_sexo,   
         general.edo_civil = :ll_edo_civil,   
         general.religion = :ll_religion,   
         general.bachillera = :ll_bachillera,   
         general.trabajo = :ll_trabajo,   
         general.trab_hor = :ll_trab_hor,   
         general.ya_inscri = :ll_ya_inscri,   
         general.cuenta = :ll_cuenta,   
         general.transporte = :ll_transporte,   
         general.telefono_movil = :ls_telefono_movil,   
         general.e_mail = :ls_e_mail   	
	WHERE general.folio = :ll_folio
	AND general.clv_ver = :ll_clv_ver 
	AND general.clv_per = :ll_clv_per 
	AND general.anio = :ll_anio 
	USING itr_admision_web; 
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		ROLLBACK USING itr_admision_web;
		MESSAGEBOX("Error", "Se produjo un error al actualizar la información de general WEB: " + ls_error) 
		RETURN -1 
	END IF
	
ELSE
	
	INSERT INTO general(general.folio, general.clv_ver, general.clv_per, general.anio, general.nombre, 
								general.apaterno, general.amaterno, general.calle, general.codigo_pos, general.colonia, 
								general.estado, general.telefono, general.fecha_nac, general.lugar_nac, general.nacional, 
								general.sexo, general.edo_civil, general.religion, general.bachillera, general.trabajo, 
								general.trab_hor, general.ya_inscri, general.cuenta, general.transporte, general.telefono_movil, 
								general.e_mail)
	VALUES(:ll_folio, :ll_clv_ver,  :ll_clv_per,  :ll_anio,  	:ls_nombre,   
				:ls_apaterno,   : ls_amaterno,   :ls_calle,   :ls_codigo_pos,   :ls_colonia,   
				:ll_estado,   :ls_telefono,   : lf_fecha_nac,   :ll_lugar_nac,   :ll_nacional,   
				:ls_sexo,   :ll_edo_civil,   :ll_religion,   :ll_bachillera,   :ll_trabajo,   
				:ll_trab_hor,   :ll_ya_inscri,   :ll_cuenta,   :ll_transporte,   :ls_telefono_movil,   
				:ls_e_mail)
	USING itr_admision_web; 
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_error = itr_admision_web.SQLERRTEXT 
		ROLLBACK USING itr_admision_web;
		MESSAGEBOX("Error", "Se produjo un error al insertar la información de general WEB: " + ls_error) 
		RETURN -1 
	END IF	
	
	
END IF

COMMIT USING itr_admision_web;

RETURN 0 




//folio	folio	
//nombre	nombre	
//apaterno	 apaterno	 
//amaterno	amaterno	
//calle	calle	
//codigo_pos	  codigo_pos	  
//colonia	colonia	
//estado	estado	
//telefono	 telefono	 
//fecha_nac	 fecha_nac	
//lugar_nac	lugar_nac	
//nacional	  nacional	  
//sexo	sexo	
//edo_civil	   edo_civil	   
//religion	religion	
//bachillera	bachillera	
//trabajo	trabajo	
//trab_hor	  trab_hor	  
//ya_inscri	  ya_inscri	  
//cuenta	cuenta	
//transporte	transporte	
//anio	anio	
//clv_ver	clv_ver	
//clv_per	clv_per	
//telefono_movil	  telefono_movil	  
//e_mail     e_mail     
//


//
//
//
//
//
//
//// Se verifica si ya existe el registro en SQL 
//SELECT COUNT(*) 
//FROM general 
//WHERE folio = 
//USING itr_admision_web; 
//
//
//
//
//
// SELECT general.folio,   
//         general.nombre,   
//         general.apaterno,   
//         general.amaterno,   
//         general.calle,   
//         general.codigo_pos,   
//         general.colonia,   
//         general.estado,   
//         general.telefono,   
//         general.fecha_nac,   
//         general.lugar_nac,   
//         general.nacional,   
//         general.sexo,   
//         general.edo_civil,   
//         general.religion,   
//         general.bachillera,   
//         general.trabajo,   
//         general.trab_hor,   
//         general.ya_inscri,   
//         general.cuenta,   
//         general.transporte,   
//         general.anio,   
//         general.clv_ver,   
//         general.clv_per,   
//         general.telefono_movil,   
//         general.e_mail  
//    FROM general,   
//
//
//
//
//
//
//
//
//folio	
//nombre	
//apaterno	
//amaterno	
//calle	
//codigo_pos	
//colonia	
//estado	
//telefono	
//fecha_nac	
//lugar_nac	
//nacional	
//sexo	
//edo_civil	
//religion	
//bachillera	
//trabajo	
//trab_hor	
//ya_inscri	
//cuenta	
//transporte	
//anio	
//clv_ver	
//clv_per	
//telefono_movil	
//e_mail




end function

on w_datosgenerales.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_nombre=create uo_nombre
this.cb_2=create cb_2
this.cb_3=create cb_3
this.dw_1=create dw_1
this.cb_1=create cb_1
this.em_bachillera=create em_bachillera
this.dw_3=create dw_3
this.dw_cp=create dw_cp
this.dw_2=create dw_2
this.Control[]={this.uo_nombre,&
this.cb_2,&
this.cb_3,&
this.dw_1,&
this.cb_1,&
this.em_bachillera,&
this.dw_3,&
this.dw_cp,&
this.dw_2}
end on

on w_datosgenerales.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_nombre)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.em_bachillera)
destroy(this.dw_3)
destroy(this.dw_cp)
destroy(this.dw_2)
end on

event open;boolean lb_seguridad

lb_seguridad= true
//g_nv_security.fnv_secure_window(this)

//Seguridad Via PFC
lb_seguridad= gnv_app.inv_security.of_SetSecurity(this)


IF NOT lb_seguridad THEN
//	   MessageBox("Security", "Unable to set security")
//	   Close(this)
END IF

this.x = 1
this.y = 1

uo_nombre.em_cuenta.text = " "
triggerevent(doubleclicked!)

uo_nombre.cbx_nuevo.visible = true
uo_nombre.cbx_nuevo.enabled = true

INTEGER li_conexion 
li_conexion = f_conecta_pas_parametros_bd(gtr_sce, itr_admision_web, 24, gs_usuario, gs_password)
if li_conexion <>1 then
	MessageBox("Error de conexion a la base del web","Favor de reintentar con un usuario que tenga permisos", StopSign!)
	close(this)
end if
end event

event doubleclicked;uo_nombre.cbx_nuevo.checked = false

int flag
flag = 0

if dw_2.event carga(long(uo_nombre.em_cuenta.text)) = 0 then
	flag = flag + 1
else
	dw_2.modify("lugar_nac.width=887")		
end if	

if flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if

//dw_3.setitem(1,"nombre",uo_nombre.dw_nombre_aspirante.getitemstring(1,"nombre"))
//dw_3.setitem(1,"apaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"apaterno"))
//dw_3.setitem(1,"amaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"amaterno"))



end event

event close;if isvalid(itr_admision_web) then
	DISCONNECT USING itr_admision_web;
end if
end event

type uo_nombre from uo_nombre_aspirante within w_datosgenerales
integer width = 3241
integer height = 416
integer taborder = 10
boolean enabled = true
long backcolor = 1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante::destroy
end on

type cb_2 from commandbutton within w_datosgenerales
event clicked pbm_bnclicked
integer x = 2949
integer y = 892
integer width = 329
integer height = 108
integer taborder = 40
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;parent.event doubleclicked(0,0,0)
end event

type cb_3 from commandbutton within w_datosgenerales
event clicked pbm_bnclicked
integer x = 2935
integer y = 700
integer width = 361
integer height = 108
integer taborder = 50
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;dw_2.event actualiza()
end event

type dw_1 from datawindow within w_datosgenerales
boolean visible = false
integer x = 3369
integer y = 60
integer width = 832
integer height = 940
string dataobject = "dw_salonxcarrera"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sce)
end event

event retrieverow;in_num_salones=in_num_salones+1
st_salones[in_num_salones]=object.salon[row]

end event

type cb_1 from commandbutton within w_datosgenerales
integer x = 2926
integer y = 508
integer width = 379
integer height = 108
integer taborder = 30
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Datos Padre"
end type

event clicked;if dw_2.RowCount()>0 then
	if w_datosgenerales.uo_nombre.cbx_nuevo.text = "Nuevo" then
		dw_2.event Actualiza()
	end if
	open(w_datos_padre)
end if
end event

type em_bachillera from editmask within w_datosgenerales
integer x = 443
integer y = 1004
integer width = 178
integer height = 84
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = "Ä"
end type

event modified;if dw_3.rowcount()>0 then
	dw_3.object.bachillera[1]=integer(text)
end if
end event

event losefocus;dw_3.setfocus()
end event

type dw_3 from datawindow within w_datosgenerales
integer y = 412
integer width = 3717
integer height = 1116
integer taborder = 20
string dataobject = "dw_general"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;DataWindowChild est
getchild("estado",est)
est.settransobject(gtr_sce)
est.retrieve()

DataWindowChild lug
getchild("lugar_nac",lug)
lug.settransobject(gtr_sce)
lug.retrieve()

DataWindowChild edo
getchild("edo_civil",edo)
edo.settransobject(gtr_sce)
edo.retrieve()

DataWindowChild rel
getchild("religion",rel)
rel.settransobject(gtr_sce)
rel.retrieve()

DataWindowChild tra
getchild("transporte",tra)
tra.settransobject(gtr_sce)
tra.retrieve()

DataWindowChild nac
getchild("nacional",nac)
nac.settransobject(gtr_sce)
nac.retrieve()

DataWindowChild trab
getchild("trabajo",trab)
trab.settransobject(gtr_sce)
trab.retrieve()

DataWindowChild bac
getchild("bachillera",bac)
bac.settransobject(gtr_sce)
bac.retrieve()

settransobject(gtr_sadm)
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

event doubleclicked;if getcolumn() = 16 then
	openwithparm(w_busqueda,"escuela")
	object.bachillera[row]=ok
end if
end event

type dw_cp from datawindow within w_datosgenerales
integer x = 361
integer y = 740
integer width = 2610
integer height = 492
integer taborder = 60
string dataobject = "dw_codigos_postales"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;hide()
settransobject(gtr_sce)
end event

event getfocus;show()
end event

event losefocus;hide()
end event

event doubleclicked;if row>0 then
	dw_3.object.colonia[1]=object.colonia[row]+", "+object.ciudad[row]
	dw_3.object.estado[1]=object.cve_estado[row]
	dw_3.setfocus()
end if

end event

type dw_2 from datawindow within w_datosgenerales
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
integer x = 9
integer y = 452
integer width = 2432
integer height = 384
string dataobject = "dw_aspiran"
end type

event primero;event actualiza()
uo_nombre.event primero()
end event

event anterior;event actualiza()
uo_nombre.event anterior()
end event

event siguiente;event actualiza()
uo_nombre.event siguiente()
end event

event ultimo;event actualiza()
uo_nombre.event ultimo()
end event

event actualiza();	w_datosgenerales.uo_nombre.dw_nombre_aspirante.AcceptText()
	AcceptText()	
	/*Acepta el texto de la última columna editada*/
	dw_3.AcceptText()
	/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
	if dw_3.ModifiedCount() > 0 Then
		/*Checa que los renglones cumplan con las reglas de validación*/
		if dw_3.update(true) = 1 then
		/*Si es asi, guardalo en la tabla y avisa.*/
			commit using gtr_sadm;
			//messagebox("Información","Se han guardado los cambios")			
			w_datosgenerales.uo_nombre.cbx_nuevo.text = "Modificar"
			MESSAGEBOX("Aviso", "Los datos generales fueron guardados con éxito")
			
			// 12/02/2018  Se actualiza la información en SQL SERVER
			IF wf_replica_sql() = 0 THEN 
				MESSAGEBOX("Aviso", "Los datos generales fueron guardados en WEB con éxito")
			END IF
			
		else
			/*De lo contrario, desecha los cambios (todos) y avisa*/
			rollback using gtr_sadm;
			messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
		end if
	end if /*ModifiedCount() > 0*/
end event

event carga;/*event actualiza()*/
dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)
return retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

event constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

settransobject(gtr_sadm)
m_menu.dw = this
end event

