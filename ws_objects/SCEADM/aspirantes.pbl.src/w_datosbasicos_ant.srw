$PBExportHeader$w_datosbasicos_ant.srw
forward
global type w_datosbasicos_ant from Window
end type
type uo_nombre from uo_nombre_aspirante2 within w_datosbasicos_ant
end type
type cb_3 from commandbutton within w_datosbasicos_ant
end type
type cb_1 from commandbutton within w_datosbasicos_ant
end type
type dw_solicitud from datawindow within w_datosbasicos_ant
end type
type cb_2 from commandbutton within w_datosbasicos_ant
end type
type dw_1 from datawindow within w_datosbasicos_ant
end type
type em_carrera from editmask within w_datosbasicos_ant
end type
type dw_3 from datawindow within w_datosbasicos_ant
end type
type dw_2 from datawindow within w_datosbasicos_ant
end type
end forward

global type w_datosbasicos_ant from Window
int X=5
int Y=4
int Width=3282
int Height=1364
boolean TitleBar=true
string Title="Solicitud de Examen de Admisión"
string MenuName="m_menu"
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
global w_datosbasicos_ant w_datosbasicos_ant

type variables
string st_salones[]
int in_num_salones
end variables

forward prototypes
public function long obten_foto (long cuenta, ref string foto)
end prototypes

on w_datosbasicos_ant.create
if this.MenuName = "m_menu" then this.MenuID = create m_menu
this.uo_nombre=create uo_nombre
this.cb_3=create cb_3
this.cb_1=create cb_1
this.dw_solicitud=create dw_solicitud
this.cb_2=create cb_2
this.dw_1=create dw_1
this.em_carrera=create em_carrera
this.dw_3=create dw_3
this.dw_2=create dw_2
this.Control[]={this.uo_nombre,&
this.cb_3,&
this.cb_1,&
this.dw_solicitud,&
this.cb_2,&
this.dw_1,&
this.em_carrera,&
this.dw_3,&
this.dw_2}
end on

on w_datosbasicos_ant.destroy
if IsValid(MenuID) then destroy(MenuID)
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
end event

type uo_nombre from uo_nombre_aspirante2 within w_datosbasicos_ant
int X=0
int Y=0
int TabOrder=10
boolean Enabled=true
long BackColor=1090519039
end type

on uo_nombre.destroy
call uo_nombre_aspirante2::destroy
end on

type cb_3 from commandbutton within w_datosbasicos_ant
event clicked pbm_bnclicked
int X=2542
int Y=556
int Width=361
int Height=108
string Text="Actualizar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;dw_2.event actualiza()
uo_nombre.cbx_nuevo.Checked = FALSE
end event

type cb_1 from commandbutton within w_datosbasicos_ant
event clicked pbm_bnclicked
int X=2926
int Y=556
int Width=329
int Height=108
string Text="Cancelar"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;parent.event doubleclicked(0,0,0)
end event

type dw_solicitud from datawindow within w_datosbasicos_ant
event constructor pbm_constructor
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
int X=3369
int Y=1008
int Width=3401
int Height=1648
string DataObject="dw_solicitud"
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

type cb_2 from commandbutton within w_datosbasicos_ant
event clicked pbm_bnclicked
int X=3383
int Y=452
int Width=827
int Height=384
string Text="Imprime Solicitud"
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;if dw_2.rowcount()>0 then
	dw_solicitud.event carga(dw_2.object.folio[1])
	openwithparm(conf_impr,dw_solicitud)
end if
end event

type dw_1 from datawindow within w_datosbasicos_ant
int X=3369
int Y=60
int Width=832
int Height=940
string DataObject="dw_salonxcarrera"
boolean LiveScroll=true
end type

event constructor;settransobject(gtr_sadm)
end event

event retrieverow;in_num_salones=in_num_salones+1
st_salones[in_num_salones]=object.salon[row]

end event

type em_carrera from editmask within w_datosbasicos_ant
int X=663
int Y=452
int Width=210
int Height=80
int TabOrder=20
boolean BringToTop=true
Alignment Alignment=Center!
BorderStyle BorderStyle=StyleLowered!
string Mask="####"
string DisplayData=""
string Text=" "
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event modified;long fol
int carr_act,carr_ant,cupo,cont,usados
string salon_ant
real porc_uso_salon

if dw_2.rowcount()>0 then
	if dw_2.object.clv_carr[1]<>integer(text) then
		
		uo_nombre.cbx_nuevo.checked = true
		
		carr_act=integer(text)
		carr_ant=dw_2.object.clv_carr[1]
		salon_ant=dw_2.object.salon[1]
	
		in_num_salones=0
		dw_1.retrieve(carr_act,gi_version,gi_periodo,gi_anio)
				
		if salon_ant<>"INVA" then
			//Se debe dar de baja el salon/carrera
			
			UPDATE carr_sal
			SET folios = folios -1
			WHERE (clv_ver= :gi_version) AND
					(clv_per= :gi_periodo) AND
					(anio= :gi_anio) AND
					(salon= :salon_ant) AND
					(clv_carr= :carr_ant)
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
						(carr_sal.salon= :st_salones[cont])
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
							(clv_carr= :carr_act)
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
end event

event rbuttondown;openwithparm(w_busqueda,"carrera")
if ok<>0 then
	text=string(ok)
	event modified()
end if
end event

event losefocus;if text="" then getfocus()
end event

type dw_3 from datawindow within w_datosbasicos_ant
int Y=908
int Width=3269
int Height=300
int TabOrder=40
string DataObject="dw_basicos"
boolean VScrollBar=true
boolean LiveScroll=true
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

type dw_2 from datawindow within w_datosbasicos_ant
event primero ( )
event anterior ( )
event siguiente ( )
event ultimo ( )
event actualiza ( )
event nuevo ( )
event borra ( )
event type integer carga ( long folio )
int Y=416
int Width=2432
int Height=492
int TabOrder=30
string DataObject="dw_aspiran"
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

event actualiza;long fol
int respuesta

/*Cuando se dispara el evento actualiza...*/
	/*Acepta el texto de la última columna editada*/
	w_datosbasicos.uo_nombre.dw_nombre_aspirante.AcceptText()
	AcceptText()
	dw_3.AcceptText()
	/*Ve si existen cambios en el DataWindow que no se hayan guardado*/
	if (ModifiedCount()+dw_3.ModifiedCount()) > 0 Then
		/*Pregunta si se desean guardar los cambios hechos*/
		//respuesta = messagebox("Atención","Desea actualizar los cambios:",StopSign!,YesNo!,2)
		respuesta=1
		if respuesta = 1 then
			if object.salon[1]="INVA" then
				rollback using gtr_sadm;
				messagebox("Carrera Inválida","Deberás cambiarla ya que no tiene salones asignados")
			else
				if w_datosbasicos.uo_nombre.cbx_nuevo.text = "Nuevo" then
				
					tit1=""
					DO UNTIL tit1<>""
						open(w_folio_ceneval)
						fol=long(tit1)
					LOOP
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
					dw_3.object.folio[1]=fol
					dw_3.object.clv_ver[1]=gi_version
					dw_3.object.clv_per[1]=gi_periodo
					dw_3.object.anio[1]=gi_anio
				
				end if /*w_datosbasicos.uo_nombre.cbx_nuevo.text = "Nuevo"*/
			
				/*Checa que los renglones cumplan con las reglas de validación*/
				if update(true) = 1 then
					dw_3.update(true)
					/*Si es asi, guardalo en la tabla y avisa.*/
					commit using gtr_sadm;
					//messagebox("Información","Se han guardado los cambios")			
					w_datosbasicos.uo_nombre.cbx_nuevo.text = "Modificar"
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
	uo_nombre.dw_nombre_aspirante.setfocus()
end if
end event

event borra;long fol
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

event carga;/*event actualiza()*/
integer li_version

li_version = gi_sol_version

if gi_version = 99 then
	dw_3.retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)
end if

//dw_3.retrieve(folio,gi_version,gi_periodo,gi_anio)


if gi_version = 99 then
   return retrieve(folio,gi_sol_version,gi_periodo,gi_anio)
else
	return retrieve(folio,gi_version,gi_periodo,gi_anio)
end if

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

	hoy=datetime(today(),now())
	fol=object.folio[1]
	prom_ant=object.promedio[1]
	prom_nue=real(data)
	
	INSERT INTO bita_bachi  
		( folio, clv_ver, clv_per, anio, fecha, nuevo, anterior, usuario )  
	VALUES ( :fol,:gi_version,:gi_periodo,:gi_anio,:hoy,:prom_nue,:prom_ant,:gs_usuario)
	using gtr_SADM;
	commit using gtr_sadm;

	event actualiza()
	
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

