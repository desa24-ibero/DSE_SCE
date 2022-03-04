$PBExportHeader$w_datosbasicos.srw
$PBExportComments$Altas, bajas, despliegue, consulta y modificación de datos básicos de un aspirante.
forward
global type w_datosbasicos from window
end type
type dw_fecha_examen from datawindow within w_datosbasicos
end type
type st_3 from statictext within w_datosbasicos
end type
type uo_nombre from uo_nombre_aspirante2 within w_datosbasicos
end type
type cb_3 from commandbutton within w_datosbasicos
end type
type cb_1 from commandbutton within w_datosbasicos
end type
type dw_solicitud from datawindow within w_datosbasicos
end type
type cb_2 from commandbutton within w_datosbasicos
end type
type dw_1 from datawindow within w_datosbasicos
end type
type em_carrera from editmask within w_datosbasicos
end type
type dw_3 from datawindow within w_datosbasicos
end type
type dw_2 from datawindow within w_datosbasicos
end type
end forward

global type w_datosbasicos from window
integer x = 5
integer y = 4
integer width = 3799
integer height = 1800
boolean titlebar = true
string title = "Solicitud de Examen de Admisión"
string menuname = "m_menu"
dw_fecha_examen dw_fecha_examen
st_3 st_3
uo_nombre uo_nombre
cb_3 cb_3
cb_1 cb_1
dw_solicitud dw_solicitud
cb_2 cb_2
dw_1 dw_1
em_carrera em_carrera
dw_3 dw_3
dw_2 dw_2
end type
global w_datosbasicos w_datosbasicos

type variables
string st_salones[]
int in_num_salones 

transaction itr_admision_web 

STRING is_cambio_fecha
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
public function integer f_recupera_fechas ()
public function integer f_transfiere_sql ()
end prototypes

public function long obten_foto (long cuenta, ref string foto);return 0
end function

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

public function integer f_transfiere_sql ();
LONG ll_folio	
LONG ll_clv_carr	
DECIMAL ld_promedio	
INTEGER le_anio	
STRING ls_salon	
INTEGER le_clv_ver	
INTEGER le_clv_per	
INTEGER le_num_paq	
INTEGER le_status	
INTEGER le_pago_exam	
INTEGER le_pago_insc	
INTEGER le_ing_per	
INTEGER le_ing_anio	
INTEGER le_sol_per	
INTEGER le_sol_anio	
INTEGER le_tiporegistro	
LONG ll_folio_original	
LONG ll_id_examen
STRING ls_CURP 

INTEGER le_anio_g, le_clv_ver_g, le_clv_per_g, le_religion_g 
STRING ls_apaterno_g, ls_amaterno_g, ls_nombre_g
INTEGER le_ya_inscri_g,	le_lugar_nac_g, le_nacional_g, le_edo_civil_g, le_trabajo_g, le_transporte_g	
LONG ll_cuenta_g, le_folio_g	
DATETIME ldt_fecha_nac_g	
STRING ls_sexo_g, ls_telefono_g, ls_e_mail_g, ls_telefono_movil_g 

STRING ls_mensaje
INTEGER le_tl_reg, le_pos
le_tl_reg = dw_2.ROWCOUNT() 

FOR le_pos = 1 TO le_tl_reg 

	ll_folio = dw_2.GETITEMNUMBER(le_pos, "folio")	
	IF ISNULL(ll_folio) THEN RETURN -1 
	ll_clv_carr = dw_2.GETITEMNUMBER(le_pos, "clv_carr")	
	ld_promedio = dw_2.GETITEMDECIMAL(le_pos, "promedio")	
	le_anio = dw_2.GETITEMNUMBER(le_pos, "anio")	
	IF ISNULL(le_anio) THEN RETURN -1 
	ls_salon = dw_2.GETITEMSTRING(le_pos, "salon")	
	le_clv_ver = dw_2.GETITEMNUMBER(le_pos, "clv_ver")	
	IF ISNULL(le_clv_ver) THEN RETURN -1 
	le_clv_per = dw_2.GETITEMNUMBER(le_pos, "clv_per")	
	IF ISNULL(le_clv_per) THEN RETURN -1 
	le_num_paq = dw_2.GETITEMNUMBER(le_pos, "num_paq")	
	le_status = dw_2.GETITEMNUMBER(le_pos, "status")	
	le_pago_exam = dw_2.GETITEMNUMBER(le_pos, "pago_exam")	
	le_pago_insc = dw_2.GETITEMNUMBER(le_pos, "pago_insc")	
	le_ing_per = dw_2.GETITEMNUMBER(le_pos, "ing_per")	
	le_ing_anio = dw_2.GETITEMNUMBER(le_pos, "ing_anio")	
	le_sol_per = dw_2.GETITEMNUMBER(le_pos, "sol_per")	
	le_sol_anio = dw_2.GETITEMNUMBER(le_pos, "sol_anio")	
	le_tiporegistro = dw_2.GETITEMNUMBER(le_pos, "tiporegistro")	
	ll_folio_original = dw_2.GETITEMNUMBER(le_pos, "folio_original")	
	ll_id_examen = dw_2.GETITEMNUMBER(le_pos, "id_examen") 
	
	if w_datosbasicos.uo_nombre.cbx_nuevo.text = "Nuevo" then
		INSERT INTO aspiran (folio, clv_carr , promedio, anio , salon ,
									clv_ver, clv_per, num_paq, status, pago_exam,
									pago_insc, ing_per, ing_anio, sol_per, sol_anio,
									tiporegistro, folio_original, id_examen)
		VALUES (:ll_folio, :ll_clv_carr, :ld_promedio, :le_anio, :ls_salon, 
					:le_clv_ver, :le_clv_per, :le_num_paq, :le_status, :le_pago_exam, 
					:le_pago_insc, :le_ing_per, :le_ing_anio, :le_sol_per, :le_sol_anio, 
					:le_tiporegistro, :ll_folio_original, :ll_id_examen)
		USING itr_admision_web;
	ELSE

		UPDATE aspiran 
		SET clv_carr = :ll_clv_carr, 
			promedio = :ld_promedio, 
			salon = :ls_salon, 
			num_paq = :le_num_paq, 
			status = :le_status, 
			pago_exam = :le_pago_exam, 
			pago_insc = :le_pago_insc,  
			ing_per = :le_ing_per,  
			ing_anio = :le_ing_anio,
			sol_per =  :le_sol_per, 
			sol_anio = :le_sol_anio,  
			tiporegistro = :le_tiporegistro, 
			folio_original = :ll_folio_original, 
			id_examen = :ll_id_examen
		WHERE folio = :ll_folio 
		AND anio = :le_anio
		AND clv_ver = :le_clv_ver  
		AND clv_per = :le_clv_per  
		USING itr_admision_web;				
		
	END IF
		
		IF itr_admision_web.SQLCODE < 0 THEN 
			ls_mensaje = itr_admision_web.SQLERRTEXT
			ROLLBACK USING itr_admision_web; 
			MESSAGEBOX("Error", "Se produjo un error al insertar el aspirante en SQLSERVER: " + ls_mensaje )
			RETURN -1 
		END IF

NEXT 

le_tl_reg = dw_3.ROWCOUNT() 

FOR le_pos = 1 TO le_tl_reg 

	le_folio_g = dw_3.GETITEMNUMBER(le_pos, "folio") 
	ls_nombre_g = dw_3.GETITEMSTRING(le_pos, "nombre")	
	ls_apaterno_g = dw_3.GETITEMSTRING(le_pos, "apaterno")		
	ls_amaterno_g = dw_3.GETITEMSTRING(le_pos, "amaterno")	
	le_ya_inscri_g = dw_3.GETITEMNUMBER(le_pos, "ya_inscri")	
	ll_cuenta_g = dw_3.GETITEMNUMBER(le_pos, "cuenta")	
	le_anio_g = dw_3.GETITEMNUMBER(le_pos, "anio")	
	le_clv_ver_g = dw_3.GETITEMNUMBER(le_pos, "clv_ver")	
	le_clv_per_g = dw_3.GETITEMNUMBER(le_pos, "clv_per")	
	ldt_fecha_nac_g = dw_3.GETITEMDATETIME(le_pos, "fecha_nac")		
	ls_sexo_g = dw_3.GETITEMSTRING(le_pos, "sexo")		
	le_religion_g = dw_3.GETITEMNUMBER(le_pos, "religion")	
	ls_telefono_g = dw_3.GETITEMSTRING(le_pos, "telefono")		
	le_lugar_nac_g = dw_3.GETITEMNUMBER(le_pos, "lugar_nac")	
	le_nacional_g = dw_3.GETITEMNUMBER(le_pos, "nacional")	
	le_edo_civil_g = dw_3.GETITEMNUMBER(le_pos, "edo_civil")
	le_trabajo_g = dw_3.GETITEMNUMBER(le_pos, "trabajo")	
	le_transporte_g = dw_3.GETITEMNUMBER(le_pos, "transporte")	
	ls_e_mail_g = dw_3.GETITEMSTRING(le_pos, "e_mail")			
	ls_telefono_movil_g = dw_3.GETITEMSTRING(le_pos, "telefono_movil")	 
	ls_CURP = dw_3.GETITEMSTRING(le_pos, "curp")	 
	
	if w_datosbasicos.uo_nombre.cbx_nuevo.text = "Nuevo" then
		INSERT INTO general(folio , nombre , apaterno , amaterno , ya_inscri,
									cuenta, anio, clv_ver, clv_per, fecha_nac,
									sexo, religion, telefono, lugar_nac, nacional,
									edo_civil, trabajo, transporte,  e_mail, telefono_movil, curp ) 
		VALUES(:le_folio_g, :ls_nombre_g, :ls_apaterno_g, :ls_amaterno_g, :le_ya_inscri_g, 
					:ll_cuenta_g, :le_anio_g, :le_clv_ver_g, :le_clv_per_g, :ldt_fecha_nac_g, 
					:ls_sexo_g, :le_religion_g, :ls_telefono_g, :le_lugar_nac_g, :le_nacional_g, 
					:le_edo_civil_g, :le_trabajo_g, :le_transporte_g, :ls_e_mail_g, :ls_telefono_movil_g, :ls_CURP )
		USING itr_admision_web;
		
	ELSE
		
		UPDATE general
		SET nombre = :ls_nombre_g,  
			apaterno = :ls_apaterno_g,  
			amaterno = :ls_amaterno_g,  
			ya_inscri = :le_ya_inscri_g, 
			cuenta = :ll_cuenta_g,  
			fecha_nac = :ldt_fecha_nac_g, 
			sexo = :ls_sexo_g,  
			religion = :le_religion_g,  
			telefono = :ls_telefono_g,  
			lugar_nac = :le_lugar_nac_g,  
			nacional = :le_nacional_g, 
			edo_civil = :le_edo_civil_g,  
			trabajo = :le_trabajo_g,  
			transporte = :le_transporte_g,  
			e_mail = :ls_e_mail_g,  
			telefono_movil = :ls_telefono_movil_g, 
			curp = :ls_CURP
		WHERE folio = :le_folio_g  
		AND anio = :le_anio_g   
		AND clv_ver = :le_clv_ver_g   
		AND clv_per = :le_clv_per_g   					
		USING itr_admision_web;		
		
	END IF
		
	IF itr_admision_web.SQLCODE < 0 THEN 
		ls_mensaje = itr_admision_web.SQLERRTEXT
		ROLLBACK USING itr_admision_web; 
		MESSAGEBOX("Error", "Se produjo un error al insertar información de generales en SQLSERVER: " + ls_mensaje )
		RETURN -1 
	END IF
	

NEXT 

COMMIT USING itr_admision_web;

RETURN 0

























//folio	
//clv_carr	
//promedio	
//anio	
//salon	
//clv_ver	
//clv_per	
//num_paq	
//status	
//pago_exam	
//pago_insc	
//ing_per	
//ing_anio	
//sol_per	
//sol_anio	
//tiporegistro	
//folio_original	
//id_examen
//

end function

on w_datosbasicos.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.dw_fecha_examen=create dw_fecha_examen
this.st_3=create st_3
this.uo_nombre=create uo_nombre
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_solicitud=create dw_solicitud
this.cb_2=create cb_2
this.dw_1=create dw_1
this.em_carrera=create em_carrera
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.dw_fecha_examen,&
this.st_3,&
this.uo_nombre,&
this.cb_3,&
this.cb_1,&
this.dw_solicitud,&
this.cb_2,&
this.dw_1,&
this.em_carrera,&
this.dw_3,&
this.dw_2}
end on

on w_datosbasicos.destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_fecha_examen)
destroy(this.st_3)
destroy(this.uo_nombre)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.dw_solicitud)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.em_carrera)
destroy(this.dw_3)
destroy(this.dw_2)
end on

event open;boolean lb_seguridad
//g_nv_security.fnv_secure_window(this)

lb_seguridad= true
//Seguridad via PFC
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

f_recupera_fechas()




end event

event doubleclicked;uo_nombre.cbx_nuevo.checked = false

int in_flag
in_flag = 0

if dw_2.event carga(long(uo_nombre.em_cuenta.text)) = 0 then
	in_flag = in_flag + 1
else
	dw_2.modify("lugar_nac.width=887")		
end if	

if in_flag < 3  then
	uo_nombre.cbx_nuevo.text = "Modificar"	
end if

//dw_3.setitem(1,"nombre",uo_nombre.dw_nombre_aspirante.getitemstring(1,"nombre"))
//dw_3.setitem(1,"apaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"apaterno"))
//dw_3.setitem(1,"amaterno",uo_nombre.dw_nombre_aspirante.getitemstring(1,"amaterno"))


is_cambio_fecha = 'N'
end event

type dw_fecha_examen from datawindow within w_datosbasicos
integer x = 640
integer y = 436
integer width = 1202
integer height = 104
integer taborder = 20
string title = "none"
string dataobject = "dw_fecha_examen_cambio_ver"
boolean livescroll = true
borderstyle borderstyle = stylelowered!
end type

event itemchanged;
is_cambio_fecha = 'S'


end event

type st_3 from statictext within w_datosbasicos
integer x = 41
integer y = 452
integer width = 571
integer height = 64
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long backcolor = 67108864
string text = "Fecha Aplicación:"
alignment alignment = right!
boolean focusrectangle = false
end type

type uo_nombre from uo_nombre_aspirante2 within w_datosbasicos
integer taborder = 10
boolean enabled = true
long backcolor = 1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante2::destroy
end on

event cambia_seleccion;call super::cambia_seleccion;f_recupera_fechas()
end event

type cb_3 from commandbutton within w_datosbasicos
event clicked pbm_bnclicked
integer x = 2542
integer y = 940
integer width = 361
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Actualizar"
end type

event clicked;dw_2.ACCEPTTEXT()
dw_3.ACCEPTTEXT()


dw_2.event actualiza()
uo_nombre.cbx_nuevo.Checked = FALSE
end event

type cb_1 from commandbutton within w_datosbasicos
event clicked pbm_bnclicked
integer x = 2926
integer y = 940
integer width = 329
integer height = 108
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar"
end type

event clicked;parent.event doubleclicked(0,0,0)
end event

type dw_solicitud from datawindow within w_datosbasicos
event constructor pbm_constructor
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
boolean visible = false
integer x = 3369
integer y = 1008
integer width = 3401
integer height = 1648
string dataobject = "dw_solicitud"
end type

event constructor;DataWindowChild carr
getchild("aspiran_clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

DataWindowChild carr1
getchild("x",carr1)
carr1.settransobject(gtr_sce)
carr1.retrieve()

settransobject(gtr_sadm)
end event

event primero;uo_nombre.event primero()
end event

event anterior;uo_nombre.event anterior()
end event

event siguiente;uo_nombre.event siguiente()
end event

event ultimo;uo_nombre.event ultimo()
end event

event carga;return retrieve(folio,gi_version,gi_periodo,gi_anio)
end event

type cb_2 from commandbutton within w_datosbasicos
event clicked pbm_bnclicked
boolean visible = false
integer x = 3383
integer y = 452
integer width = 827
integer height = 384
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Imprime Solicitud"
end type

event clicked;if dw_2.rowcount()>0 then
	dw_solicitud.event carga(dw_2.object.folio[1])
	openwithparm(conf_impr,dw_solicitud)
end if
end event

type dw_1 from datawindow within w_datosbasicos
boolean visible = false
integer x = 3369
integer y = 60
integer width = 832
integer height = 940
string dataobject = "dw_salonxcarrera"
boolean livescroll = true
end type

event constructor;settransobject(gtr_sadm)
end event

event retrieverow;in_num_salones=in_num_salones+1
st_salones[in_num_salones]=object.salon[row]

end event

type em_carrera from editmask within w_datosbasicos
integer x = 663
integer y = 584
integer width = 210
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
string text = " "
alignment alignment = center!
borderstyle borderstyle = stylelowered!
string mask = "####"
string displaydata = "~b"
end type

event modified;long fol, ll_id_examen
int carr_act,carr_ant,cupo,cont,usados
string salon_ant
real porc_uso_salon


ll_id_examen = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
IF ISNULL(ll_id_examen) THEN 
	messagebox("Fecha de Exámen Inválida","No se ha seleccionado una fecha de Aplicación de Exámen.")
	text = ""
	RETURN 0
// Si la fecha de exámen es 0, indica que es un registro anterior a  examen-fecha y no se valida el salón.	
ELSEIF ll_id_examen = 0 THEN 
	dw_2.object.clv_carr[1]=integer(text)
	dw_2.event actualiza()
	RETURN 0
ELSE

	// CODIGO ORIGINAL 
	if dw_2.rowcount()>0 then
		if dw_2.object.clv_carr[1]<>integer(text) then
			
			uo_nombre.cbx_nuevo.checked = true
			
			carr_act=integer(text)
			carr_ant=dw_2.object.clv_carr[1]
			salon_ant=dw_2.object.salon[1]
		
			in_num_salones=0
			dw_1.retrieve(carr_act,gi_version,gi_periodo,gi_anio, ll_id_examen)
					
			if salon_ant<>"INVA" then
				//Se debe dar de baja el salon/carrera
				
				UPDATE carr_sal
				SET folios = folios -1
				WHERE (clv_ver= :gi_version) AND
						(clv_per= :gi_periodo) AND
						(anio= :gi_anio) AND
						(salon= :salon_ant) AND
						(clv_carr= :carr_ant) AND 
						(id_examen = :ll_id_examen)
				USING gtr_sadm;
				
				IF gtr_sadm.SQLNRows > 0 THEN
					/*COMMIT USING sadm ; */
					dw_2.object.salon[1]="INVA"
				ELSE
					messagebox("Error en la tabla 'carr_sal'","Borrando")
				END IF
			
			end if
		
			if in_num_salones=0 then
				messagebox('No hay salones asignados a esta carrera',&
					'Dalos de alta en "Salones para Examen"')
			else
				cont=1
				DO WHILE (dw_2.object.salon[1]="INVA")AND(cont<=in_num_salones)
							
					SELECT salon.cupo
					INTO :cupo
					FROM salon
					WHERE salon.cve_salon=:st_salones[cont]
					USING gtr_SCE;
			
					SELECT sum(carr_sal.folios)
					INTO :usados
					FROM carr_sal
					WHERE (carr_sal.clv_ver= :gi_version) AND
							(carr_sal.clv_per= :gi_periodo) AND
							(carr_sal.anio= :gi_anio) AND
							(carr_sal.salon= :st_salones[cont]) AND 
							(id_examen = :ll_id_examen)
					USING gtr_sadm;
			
					//messagebox(salones[cont],string(cupo)+" "+string(usados))
					
					select valor/100.0
					into :porc_uso_salon
					from varios
					where indice=1
					using gtr_sadm;
	
					if (usados<int(porc_uso_salon*cupo) or gi_version=0) then
				
						UPDATE carr_sal
						SET folios = folios +1
						WHERE (clv_ver= :gi_version) AND
								(clv_per= :gi_periodo) AND
								(anio= :gi_anio) AND
								(salon= :st_salones[cont]) AND
								(clv_carr= :carr_act) AND 
								(id_examen = :ll_id_examen)
						USING gtr_sadm;
				
						IF gtr_sadm.SQLNRows > 0 THEN
							/*COMMIT USING sadm ;*/
							dw_2.object.salon[1]=st_salones[cont]
						ELSE
							messagebox("Error en la tabla 'carr_sal'","")
						END IF
					end if
					cont=cont+1
				LOOP
				if dw_2.object.salon[1]="INVA" then
					messagebox("Ya no hay salones disponibles",&
						'Dalos de alta en "Salones para Examen"')
				end if
			end if
		
			if dw_2.object.salon[1]<>"INVA" then
				dw_2.object.clv_carr[1]=integer(text)
				COMMIT USING gtr_sadm ;
				dw_2.event actualiza()
			end if
		end if
	end if
	// CODIGO ORIGINAL 
	
END IF		
end event

event rbuttondown;openwithparm(w_busqueda,"carrera")
if ok<>0 then
	text=string(ok)
	event modified()
end if
end event

event losefocus;if text="" then getfocus()
end event

type dw_3 from datawindow within w_datosbasicos
integer x = 5
integer y = 1156
integer width = 3333
integer height = 420
integer taborder = 50
string dataobject = "dw_basicos"
boolean vscrollbar = true
boolean livescroll = true
end type

event constructor;settransobject(gtr_sadm)
end event

event itemchanged;long cuenta
string nombre

if row>0 and getcolumnname() = "cuenta" then
	cuenta=long(data)
	if cuenta<>0 then
		SELECT apaterno+' '+amaterno+' '+nombre
		INTO :nombre
		FROM alumnos
		WHERE alumnos.cuenta = :cuenta
		USING gtr_SCE;
		commit using gtr_SCE;
		
		if nombre="" then
			object.ya_inscri[row]=0
		else
			object.ya_inscri[row]=1
		end if
		messagebox(string(cuenta)+'-'+string(obten_digito(cuenta)),nombre)
	else
		object.ya_inscri[row]=0		
	end if
end if
end event

type dw_2 from datawindow within w_datosbasicos
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
integer y = 568
integer width = 2459
integer height = 576
integer taborder = 40
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

event actualiza();datetime ldFechaNace
int respuesta, liAnio, liPeriodo, liVersion
long fol, ll_id_examen
string lsApaterno, lsAmaterno, lsNombre




/*Cuando se dispara el evento actualiza...*/
	/*Acepta el texto de la última columna editada*/
	w_datosbasicos.uo_nombre.dw_nombre_aspirante.AcceptText()
	AcceptText()
	dw_3.AcceptText()
	/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
	if (ModifiedCount()+dw_3.ModifiedCount()) > 0  OR (is_cambio_fecha = 'S' AND w_datosbasicos.uo_nombre.cbx_nuevo.text <> "Nuevo") Then 
		
		ll_id_examen = dw_fecha_examen.GETITEMNUMBER(1, "id_examen")  
		IF ISNULL(ll_id_examen) THEN 
			messagebox("Fecha de Exámen Inválida","No se ha seleccionado una fecha de Aplicación de Exámen.")
			RETURN 
		END IF		
		
		/*Pregunta si se desean guardar los cambios hechos*/
		//respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
		respuesta=1
		if respuesta = 1 then
			if object.salon[1]="INVA" AND ll_id_examen > 0 AND NOT ISNULL(ll_id_examen) then 
				rollback using gtr_sadm;
				messagebox("Carrera Inválida","Deberás cambiarla ya que no tiene salones asignados")
			else
				if w_datosbasicos.uo_nombre.cbx_nuevo.text = "Nuevo" then
				
					tit1=""
					//DO UNTIL tit1<>""
						//open(w_folio_ceneval)
						//fol=long(tit1)
					//LOOP
					
					fol = f_recupera_folio_aspiran(itr_admision_web)
					IF fol < 0 THEN RETURN 
					
					tit1=uo_nombre.uo_1.dw_ver.object.version[uo_nombre.uo_1.dw_ver.getrow()]+' '+&
						uo_nombre.uo_1.dw_per.object.periodo[uo_nombre.uo_1.dw_per.getrow()]+' '+&
						uo_nombre.uo_1.em_ani.text
					
					w_datosbasicos.uo_nombre.em_cuenta.text = string(fol)
					w_datosbasicos.uo_nombre.em_digito.text = obten_digito(fol)
					object.folio[1]=fol
					object.clv_ver[1]=gi_version
					object.clv_per[1]=gi_periodo
					object.anio[1]=gi_anio
					object.ing_per[1]=gi_periodo
					object.ing_anio[1]=gi_anio
					object.sol_per[1]=gi_periodo
					object.sol_anio[1]=gi_anio
					object.id_examen[1] = ll_id_examen
					dw_3.object.folio[1]=fol
					dw_3.object.clv_ver[1]=gi_version
					dw_3.object.clv_per[1]=gi_periodo
					dw_3.object.anio[1]=gi_anio
				
				end if /*w_datosbasicos.uo_nombre.cbx_nuevo.text = "Nuevo"*/
			
				IF is_cambio_fecha = 'S' THEN 
					object.id_examen[1] = ll_id_examen
				END IF
			
				/*Checa que los renglones cumplan con las reglas de validación*/
				if update(true) = 1 then
					dw_3.update(true)
					/*Si es asi, guardalo en la tabla y avisa.*/
					commit using gtr_sadm;
//					liAnio
//					liPeriodo
//					liVersion
//					lsApaterno
//					lsAmaterno
//					lsNombre

					/*Se llama la función de replica en SQLSERVER*/ 
					IF f_transfiere_sql() <> 0 THEN 
						
					END IF
					/*Se llama la función de replica en SQLSERVER*/ 					


					//messagebox("Información","Se han guardado los cambios")			
					w_datosbasicos.uo_nombre.cbx_nuevo.text = "Modificar"
					
					is_cambio_fecha = 'N'
					
				else
					/*De lo contrario, desecha los cambios (todos) y avisa*/
					rollback using gtr_sadm;
					messagebox("Información","Algunos datos están incorrectos, favor de corregirlos")	
				end if
			

			
			end if /*object.salon[1]="INVA"*/
		else
			/*De lo contrario, solo avisa que no se guardó nada.*/
			messagebox("Información","No se han guardado los cambios")
		end if /*respuesta = 1*/
	end if /*(ModifiedCount()+dw_3.ModifiedCount()) > 0*/
	
//MESSAGEBOX("Aviso", "Se han actualizado los datos")	 
	
	
	
end event

event nuevo;event actualiza()

if gi_version<>99 then
	uo_nombre.cbx_nuevo.text = "Nuevo"

	uo_nombre.cbx_nuevo.checked = true

	uo_nombre.em_cuenta.text = ""
	uo_nombre.em_digito.text = ""

	event carga(1)
	insertrow(getrow())
	dw_3.insertrow(dw_3.getrow())

	uo_nombre.dw_nombre_aspirante.event carga(1)
	uo_nombre.dw_nombre_aspirante.insertrow(uo_nombre.dw_nombre_aspirante.getrow())

	object.salon[1]="INVA"
	object.num_paq[1]=0
	object.status[1]=0
	object.pago_exam[1]=0
	object.pago_insc[1]=0
	object.clv_carr[1]=0
	dw_3.object.ya_inscri[1]=0
	dw_3.object.cuenta[1]=0
	dw_3.object.sexo[1]='M'
	dw_3.object.religion[1]=2

	dw_3.object.lugar_nac[1]=1
	dw_3.object.nacional[1]=1
	dw_3.object.edo_civil[1]=0
	dw_3.object.trabajo[1]=0
	dw_3.object.transporte[1]=2
	uo_nombre.dw_nombre_aspirante.setfocus()
end if
end event

event borra();long fol
int carr,num_paq, li_num_error
string salon_ant, ls_error

if rowcount()>0 then
	if w_datosbasicos.uo_nombre.cbx_nuevo.checked then
		if RowCount()>0 then
			if object.pago_exam[1]=0 then
				if object.pago_insc[1]=0 then
					carr=object.clv_carr[1]
					fol=object.folio[1]
					salon_ant=object.salon[1]
					num_paq=object.num_paq[1]
		
					if num_paq>0 then
						UPDATE paquetes
						SET inscritos = inscritos-1
						WHERE paquetes.num_paq = :num_paq
						USING gtr_SADM;
						li_num_error = gtr_SADM.SQLCode
						ls_error= gtr_SADM.SQLErrtext
						if li_num_error = 0 then
							COMMIT USING gtr_SADM;
						else 
							ROLLBACK USING gtr_SADM;
							MessageBox("Error en el update de paquetes",ls_error)
						end if
					end if
					
					/*
						OSS. Jun 18, 2012, Esta bitácora se debe llenar por medio de un trigger
					*/
					/*
					DELETE FROM bita_bachi
					WHERE (bita_bachi.folio=:fol) AND
						(bita_bachi.clv_ver=:gi_version) AND
						(bita_bachi.clv_per=:gi_periodo) AND
						(bita_bachi.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_bachi",ls_error)
					end if
					*/
					
					DELETE FROM bita_res
					WHERE (bita_res.folio=:fol) AND
						(bita_res.clv_ver=:gi_version) AND
						(bita_res.clv_per=:gi_periodo) AND
						(bita_res.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_res",ls_error)
					end if

					
					DELETE FROM bita_carr
					WHERE (bita_carr.folio=:fol) AND
						(bita_carr.clv_ver=:gi_version) AND
						(bita_carr.clv_per=:gi_periodo) AND
						(bita_carr.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de bita_carr",ls_error)
					end if
					
					DELETE FROM padres
					WHERE (padres.folio=:fol) AND
						(padres.clv_ver=:gi_version) AND
						(padres.clv_per=:gi_periodo) AND
						(padres.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de padres",ls_error)
					end if
			
			
					// Si fue un apartado de lugar no hay que hacer la disminución
	            if gi_version <> 0 then		
 						UPDATE carr_sal
						SET folios = folios -1
						WHERE (clv_ver= :gi_version) AND
								(clv_per= :gi_periodo) AND
								(anio= :gi_anio) AND
								(salon= :salon_ant) AND
								(clv_carr= :carr)
						USING gtr_SADM;
						li_num_error = gtr_SADM.SQLCode
						ls_error= gtr_SADM.SQLErrtext
						if li_num_error = 0 then
							COMMIT USING gtr_SADM;
						else 
							ROLLBACK USING gtr_SADM;
							MessageBox("Error en el update de carr_sal",ls_error)
						end if
					end if
			
			
					DELETE FROM cali_sec
					WHERE (cali_sec.folio=:fol) AND
						(cali_sec.clv_ver=:gi_version) AND
						(cali_sec.clv_per=:gi_periodo) AND
						(cali_sec.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de cali_sec",ls_error)
					end if
					
					
					DELETE FROM cali_are
					WHERE (cali_are.folio=:fol) AND
						(cali_are.clv_ver=:gi_version) AND
						(cali_are.clv_per=:gi_periodo) AND
						(cali_are.anio=:gi_anio)
					USING gtr_SADM;
					li_num_error = gtr_SADM.SQLCode
					ls_error= gtr_SADM.SQLErrtext
					if li_num_error = 0 then
						COMMIT USING gtr_SADM;
					else 
						ROLLBACK USING gtr_SADM;
						MessageBox("Error en el delete de cali_are",ls_error)
					end if

					
					dw_3.deleterow(1)		
					if dw_3.update(true) = 1 then
						deleterow(1)		
						if update(true) = 1 then
							commit using gtr_SADM;
						end if
					end if
				else
					messagebox("No se puede borrar","Cajas no le ha hecho el rembolso de su Inscripción")
				end if
			else
				messagebox("No se puede borrar","Cajas no le ha hecho el rembolso de su Examen")
			end if
		end if
	end if
end if
end event

event type integer carga(long folio);/*event actualiza()*/
integer li_version

li_version = gi_sol_version

if gi_version = 99 then
	dw_3.retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)
end if

//dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)


if gi_version = 99 then
    retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	retrieve(folio,gi_version,gi_periodo,gi_anio)
end if


LONG ll_id_examen 

IF THIS.ROWCOUNT() > 0 THEN  
	ll_id_examen = THIS.GETITEMNUMBER(1, "id_examen") 
	dw_fecha_examen.SETITEM(1, "id_examen", ll_id_examen)
END IF
is_cambio_fecha = 'N'

return THIS. ROWCOUNT()


//return retrieve(folio,gi_version,gi_periodo,gi_anio)

end event

event itemchanged;long columna,fol
int carr_act,carr_ant,cupo,cont,usados
string salon_ant
datetime hoy
real prom_ant,prom_nue,porc_uso_salon

columna = getcolumn()

if columna=2 then
	em_carrera.event modified()
end if

if columna=3 then

	uo_nombre.cbx_nuevo.checked = true
/*
	OSS. Jun 18, 2012, Esta bitácora se debe llenar por medio de un trigger
*/
/*
	hoy=datetime(today(),now())
	fol=object.folio[1]
	prom_ant=object.promedio[1]
	prom_nue=real(data)
	
	INSERT INTO bita_bachi  
		( folio, clv_ver, clv_per, anio, fecha, nuevo, anterior, usuario )  
	VALUES ( :fol,:gi_version,:gi_periodo,:gi_anio,:hoy,:prom_nue,:prom_ant,:gs_usuario)
	using gtr_SADM;
	commit using gtr_sadm;
*/
//	event actualiza()	Se comenta por que esta haciendo dos veces el actualizado en la bitacora al presionar el boton actualizar
	
end if
end event

event constructor;DataWindowChild carr
getchild("clv_carr",carr)
carr.settransobject(gtr_sce)
carr.retrieve()

settransobject(gtr_sadm)
m_menu.dw = this
end event

event retrieveend;if rowcount>0 then
	em_carrera.text=string(object.clv_carr[1])
else
	em_carrera.text=""
end if
end event

